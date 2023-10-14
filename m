Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6737C9412
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjJNKOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjJNKOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:14:30 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87EFBA2;
        Sat, 14 Oct 2023 03:14:23 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 39E9hKnS020954;
        Sat, 14 Oct 2023 11:43:20 +0200
Date:   Sat, 14 Oct 2023 11:43:20 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        backports@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] docs: add backporting and conflict resolution document
Message-ID: <20231014094320.GC20662@1wt.eu>
References: <20230824092325.1464227-1-vegard.nossum@oracle.com>
 <87bkdfg2ds.fsf@meer.lwn.net>
 <877cnu5jy0.fsf@meer.lwn.net>
 <83fd1a05-974e-4d91-82b0-c09cc2f8da1e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83fd1a05-974e-4d91-82b0-c09cc2f8da1e@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vegard,

On Fri, Oct 13, 2023 at 05:24:31PM +0200, Vegard Nossum wrote:
> I've now added Steven Rostedt and Willy Tarreau as well on the
> off-chance that they have something to say about it (Steven presented
> his conflict resolution method at Kernel Recipes and I think Willy is
> experienced with backporting), but this is in no way meant as pressure
> to review this patch. Here's a link to the top of the thread:
> 
> https://lore.kernel.org/all/20230824092325.1464227-1-vegard.nossum@oracle.com/

That's a very nice description, I'm sure it can help (and I learned a
few points there already). There are a few points I'm not seeing there,
though, base on my habits:
  - in my experience, there's a huge difference between backporting
    code you don't know and code you know. I'm dealing with haproxy
    backports several times a week and I tend to know this code, so I
    use my intuition a lot and have no problem adjusting stuff around
    the conflicting parts. However when I was dealing with extended
    kernels, that was not the case at all, because I didn't know that
    code, and worse, I wasn't skilled at all on many of the parts I had
    to deal with. While it's OK to take the blame for a failed backport,
    it's generally not OK to expose users to risks caused by your lack
    of knowledge. In this case it means you need to be extra cautious,
    and very often to actually *ask* authors or maintainers for help.
    If maintainers do not want to help backporting some patches to an
    older version of their code, usually it should be perceived as a
    hint that they'll find it complicated to do it right; then take that
    as a hint that there's little chances you'll get it right by yourself
    while ignoring that code. This may imply dropping the fix, documenting
    the area as broken, or asking for help on various lists until someone
    more knowledgeable can help.

  - the tool that helped me the most in resolving rename conflicts is
    "patch". As you explained, "git am" is a bit stubborn. But patch is
    way more lenient (and will often do mistakes). In the very old 2.6.32
    I used to rely on "git show XX | patch -p1" way more often than
    "git am". For a rename, you do "git show XX -- file |patch otherfile".
    It works the same with file-based patches or mbox: "patch -p1 < mbox".
    Patch however will not place the conflict markers and will leave .rej
    files. I then opened them in an editor next to the file to edit, to
    locate the area and copy the relevant part to its location. Emacs'
    ediff is also extremely convenient to pick select parts of each file.

  - control the patches: after I'm pretty sure I have resolved a patch,
    I compare it side by side with the original one. Normally, backported
    patches should have the same structure as the original. Using whatever
    editor supporting a vertical split helps a lot. Otherwise I also use
    "diff -y --width 200" between them to focus on differences (typically
    line numbers). It's not rare that a part is missing, either because
    I messed up, or because I forgot to process a .rej that I mistakenly
    removed, or because a file was added, I reset the tree and it's left
    untracked. So any difference between the patches should have its own
    explanation (line numbers, function names, file names, occurrences).
    By the way, it can very easily happen that applying a patch will work
    fine but it will apply to the wrong function because some code patterns
    especially in error unrolling paths are often the same between several
    functions. It happened to me quite a few times in the past, and even
    a few of these persisted till the public patch review. That's really
    a risk that must not be minimized!

  - something quite common is that as code evolves, it gets refactored
    so that what used to appear at 3 locations in the past now moved to
    a single function. But when you're backporting, you're doing the
    reverse work, you're taking a patch for a single location that may
    apply to multiple ones. Often the hint is that the function name
    changed. But sometimes it's not even the case. If what you've found
    looks like a nasty bug pattern that looks like it could easily have
    been copy-pasted at other places, it's worth looking for it elsewhere
    using git grep. If you find the same pattern, then you search for it
    into the tree the patch comes from. If you don't find it, it's likely
    that you'll need to adjust it, and git log is your friend to figure
    what happened to these areas. Note that git blame doesn't work for
    removed code. If you find the same pattern elsewhere in mainline, it's
    worth asking the patch author if that one is also an occurrence of the
    same bug or just normal. It's not uncommon to find new bugs during a
    backport.

  - color diff: usually I just rely on:

     [color]
         ui = true

    But I also recently got used to using diff-highlight that will
    highlight different characters between lines. It's nice for complex
    "if" conditions where you don't see the difference, or for spaces
    vs tabs:

    [pager]
        log = /usr/doc/git-2.35.3/contrib/diff-highlight/diff-highlight | less
        show = /usr/doc/git-2.35.3/contrib/diff-highlight/diff-highlight | less
        diff = /usr/doc/git-2.35.3/contrib/diff-highlight/diff-highlight | less

  - git add, git add and git add: when fixing patches by hand, it's very
    common to leave some parts not added (especially with | patch -p1).
    It's useful to work on a clean tree to more easily spot untracked
    files with "git status".

> I feel like in the worst case, somebody sees the document down the line
> and vehemently disagrees with something and we either fix it or take it
> out completely.

No I don't disagree and even find it useful. If at least it could help
people figure the pain it is to backport any single patch, and encourage
them to help stable maintainers, that would already be awesome!

> I'd like to add that my impression is that a LOT of people *fear*
> backporting and conflict resolution -- and it doesn't have to be that
> way. We should be talking about merge conflicts and what good workflows
> look like (one of the reasons why I was very happy to see Steven's
> presentation at KR), instead of leaving everybody to figure it out on
> their own. This document is my contribution towards that.

I'm not completely sold to this. Yes we should teach more people to
perform that task themselves. But there's a big difference between
backporting a few patches and feeling like you could maintain your own
kernel because now you know how to resolve conflicts. What I mentioned
above about dealing with patches you don't understand must not be
underestimated, that's the biggest challenge I faced when working on
stable kernels. There's probably a feeling of shame of not understanding
something, but I can say that many times I asked for help and was helped
even by top-ranked developers, and nobody ever laughed at me for not
understanding a certain area. But doing that in your garage for your
own kernel or for your company's products is a huge problem because it's
unlikely that you'll get help from the maintainers this time, so you're
left on your own with your own understanding of certain patches.

Thus, yes to backports, no to kernel forks being a collection of
backports.

> > > - Colordiff looks cool, but I'd at least drop in a mention of the Emacs
> > >    ediff mode, which offers (I believe) a lot of the same functionality.
> 
> I don't use emacs personally, but I would welcome this addition if
> somebody were to write it!

There's not much to write about it. You start "ediff-buffers" between two
files, or you can probably find "ediff" in one of the menus, or type "ediff"
then press tab to get the list of commands. It's not always completely
intuitive but easy to remember, and fully interactive and supports rolling
back operations.

Hoping this helps,
Willy
