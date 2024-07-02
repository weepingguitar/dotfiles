set nocompatible " not vi compatible

"
" Set Vundle to manage plugins 
"
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Keep Plugin commands between vundle#begin/end.
"
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



" enable fzf command in vim
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf

" adjust tab to 4 spaces, default is 8
set tabstop=4 

"
" Syntax and indent
"
" Turn on syntax highlighting.
syntax on
" show matching braces when text indicator is over them
set showmatch 

" highlight current line, but only in active window 
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline 
    autocmd WinLeave * setlocal nocursorline
augroup END

" vim can autodetect this based on $TERM (e.g. 'xterm-256color')
" but it can be set to force 256 colors
" set t_Co=256
if has('gui_running')
    colorscheme solarized
    let g:lightline = {'colorscheme': 'solarized'}
elseif &t_Co < 256
    colorscheme default
    set nocursorline " looks bad in this mode
else
    set background=dark
    let g:solarized_termcolors=256 " instead of 16 color with mapping in terminal
    colorscheme solarized
    " customized colors
    highlight SignColumn ctermbg=234
    highlight StatusLine cterm=bold ctermfg=245 ctermbg=235
    highlight StatusLineNC cterm=bold ctermfg=245 ctermbg=235
    let g:lightline = {'colorscheme': 'dark'}
    highlight SpellBad cterm=underline
    " patches
    highlight CursorLineNr cterm=NONE
endif

set autoindent " copy line indentation when starting a new line

"
" Basic editing config
"

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" Show relative line numbers
set relativenumber

" Incremental search, enable searching as you type, rather than waiting till you press enter.
set incsearch

" highlight search
set hls

" line break
set lbr

" set list to see tabs and non-breakable spaces
set list
set listchars=tab:»\ ,precedes:←,extends:→,nbsp:~,trail:·

" show lines above and below cursor (when possible)
set scrolloff=5

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" allow backspacing over everything
set backspace=indent,eol,start


" skip redrawing screen in some cases
set lazyredraw

" allow auto-hiding of edited buffers
set hidden

" more history
set history=8000

" smart case-sensitive search
set ignorecase
set smartcase

" tab completion for files/bufferss
set wildmode=longest,list,full
set wildmenu

" Enable mouse support
set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" disable folding by default
set nofoldenable 

"
"Misc configurations
"

"unbind keys
nmap Q <Nop> 

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" prevent bad habits
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" movement relative to display lines
nnoremap <silent> <Leader>d :call ToggleMovementByDisplayLines()<CR>
function SetMovementByDisplayLines()
    noremap <buffer> <silent> <expr> k v:count ? 'k' : 'gk'
    noremap <buffer> <silent> <expr> j v:count ? 'j' : 'gj'
    noremap <buffer> <silent> 0 g0
    noremap <buffer> <silent> $ g$
endfunction
function ToggleMovementByDisplayLines()
    if !exists('b:movement_by_display_lines')
        let b:movement_by_display_lines = 0
    endif
    if b:movement_by_display_lines
        let b:movement_by_display_lines = 0
        silent! nunmap <buffer> k
        silent! nunmap <buffer> j
        silent! nunmap <buffer> 0
        silent! nunmap <buffer> $
    else
        let b:movement_by_display_lines = 1
        call SetMovementByDisplayLines()
    endif
endfunction

" toggle relative numbering
nnoremap <C-n> :set rnu!<CR>

" set cursor to block in insert mode and block in normal mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set ttimeout
set ttimeoutlen=1
set ttyfast
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END
autocmd VimLeave * silent !echo -ne "\e[6 q"
