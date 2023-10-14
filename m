Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1407C9518
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 17:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjJNPIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 11:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJNPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 11:08:13 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F707C9;
        Sat, 14 Oct 2023 08:08:09 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 39EF7hFh021799;
        Sat, 14 Oct 2023 17:07:43 +0200
Date:   Sat, 14 Oct 2023 17:07:43 +0200
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
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH v2] docs: add backporting and conflict resolution document
Message-ID: <20231014150743.GC21506@1wt.eu>
References: <20230824092325.1464227-1-vegard.nossum@oracle.com>
 <87bkdfg2ds.fsf@meer.lwn.net>
 <877cnu5jy0.fsf@meer.lwn.net>
 <83fd1a05-974e-4d91-82b0-c09cc2f8da1e@oracle.com>
 <20231014094320.GC20662@1wt.eu>
 <12b082c8-908f-4de2-b0b5-4b638e10c402@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12b082c8-908f-4de2-b0b5-4b638e10c402@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 01:48:54PM +0200, Vegard Nossum wrote:
> Did you see this meme? https://i.imgur.com/yk5rf13.png

No I didn't know it.

> I think conflicts have a bit of a bad reputation exactly because you're
> presented with something that's hard to make sense of at first sight.
> I'd like to dispel this myth that you need to be an expert to make sense
> of conflict markers. I think with the right attitude, the right tools,
> and the right approach you can go a LONG way. Also, nobody is born an
> expert and we should encourage people to gain experience in this area IMHO.

That's interesting that you mention this because I worked for a company
years ago where there was a person in charge of merges, who was not at
all part of the development team. I thought it made absolutely no sense
to request that someone who doesn't know the project would resolve
conflicts! When I expressed my surprise there, I was told "you know,
merging requires skills developers don't have"! So it's very possible
that there's this myth floating around, indeed.

> With that said, how about if we add a short section near the end about
> submitting stable backports where we encourage submitters to 1) approach
> the backporting process in a humble way, 2) describe the reason for the
> conflict in the changelog and their resolution, 3) be honest about their
> confidence in their resolution, 4) ask relevant maintainers for an
> explicit ack?

Maybe, by the way you remind me something that I've been used to doing
for many years: whenever I adapt a patch to resolve a conflict, I shortly
summarize my changes just before my signed-of-by line in brackets. It
helps me figure which patches needed adaptations, and others figure if
my reasoning is flawed. I seem to remember that Ben did the same. That's
something really convenient we should encourage I think.

> I'm open to other ideas, I just want to make sure we strike the right
> balance of encouragement vs. discouragement.

Sure. Another point which I didn't mention and which has to be considered
when backporting the same patch across multiple versions is that you often
face the choice of starting from the original patch and trying to stuff it
into an old version, or starting from the closest version and trying to
adapt it. I tend to prefer restarting from the closest (but more recent)
version, for multiple reasons:
  - less differences, some renames might already have been handled and
    in general any of the previously mentioned adaptations.

  - it limits the risk of leaving a failed backport in the middle of
    the chain. Indeed, let's that than when I was doing 3.10 I would
    have picked the original patch from 4.19 and adapted it myself.
    Maybe the 4.4 version was broken, and the user later upgrading
    from 3.10 to 4.4 could face a regression. Instead, by adapting
    the 4.4 one to 3.10, if 4.4 was wrong, 3.10 would also likely be
    and if detected there, the broken chain would be detected. This is
    particularly true for rarely used parts (e.g. uncommon drivers)
    where a bug can remain exposed for a long time without anyone
    noticing.

> >    - the tool that helped me the most in resolving rename conflicts is
> >      "patch". As you explained, "git am" is a bit stubborn. But patch is
> >      way more lenient (and will often do mistakes). In the very old 2.6.32
> >      I used to rely on "git show XX | patch -p1" way more often than
> >      "git am". For a rename, you do "git show XX -- file |patch otherfile".
> >      It works the same with file-based patches or mbox: "patch -p1 < mbox".
> >      Patch however will not place the conflict markers and will leave .rej
> >      files. I then opened them in an editor next to the file to edit, to
> >      locate the area and copy the relevant part to its location. Emacs'
> >      ediff is also extremely convenient to pick select parts of each file.
> > 
> >    - control the patches: after I'm pretty sure I have resolved a patch,
> >      I compare it side by side with the original one. Normally, backported
> >      patches should have the same structure as the original. Using whatever
> >      editor supporting a vertical split helps a lot. Otherwise I also use
> >      "diff -y --width 200" between them to focus on differences (typically
> >      line numbers). It's not rare that a part is missing, either because
> >      I messed up, or because I forgot to process a .rej that I mistakenly
> >      removed, or because a file was added, I reset the tree and it's left
> >      untracked. So any difference between the patches should have its own
> >      explanation (line numbers, function names, file names, occurrences).
> >      By the way, it can very easily happen that applying a patch will work
> >      fine but it will apply to the wrong function because some code patterns
> >      especially in error unrolling paths are often the same between several
> >      functions. It happened to me quite a few times in the past, and even
> >      a few of these persisted till the public patch review. That's really
> >      a risk that must not be minimized!
> 
> There is a section on this: "Verifying the result", and also describes
> doing a side-by-side diff of the old and new patches.

Ah yes, I didn't notice it the first time, I thought it meant comparing
the files, not the patches.

> The bit about applying the patch to the wrong function -- I doubt this
> happens that much when using cherry-pick, since it knows both sides of
> the history and can tell when code moves around. You're probably right
> that it can easily happen with plain git am/patch though. In my mind,
> this is an argument in favour of using cherry-pick whenever possible.

Yep I never had it with cherry-pick, only with git-am (rare) and patch
(more common). I totally agree with cherry-picking as much as possible,
and I also often preferred to git-am to the original base to later
cherry-pick, as you mentioned.

> >    - something quite common is that as code evolves, it gets refactored
> >      so that what used to appear at 3 locations in the past now moved to
> >      a single function. But when you're backporting, you're doing the
> >      reverse work, you're taking a patch for a single location that may
> >      apply to multiple ones. Often the hint is that the function name
> >      changed. But sometimes it's not even the case. If what you've found
> >      looks like a nasty bug pattern that looks like it could easily have
> >      been copy-pasted at other places, it's worth looking for it elsewhere
> >      using git grep. If you find the same pattern, then you search for it
> >      into the tree the patch comes from. If you don't find it, it's likely
> >      that you'll need to adjust it, and git log is your friend to figure
> >      what happened to these areas. Note that git blame doesn't work for
> >      removed code. If you find the same pattern elsewhere in mainline, it's
> >      worth asking the patch author if that one is also an occurrence of the
> >      same bug or just normal. It's not uncommon to find new bugs during a
> >      backport.
> 
> Very good point.
> 
> I think this fits very well alongside the sections on function
> arguments, error handling, etc. since it details a specific thing that
> can go easily wrong.
> 
> Can I take what you wrote above, or do you want to submit your own
> incremental patch? I think we could insert it almost verbatim.

Sure, feel free to take whatever I wrote and even rework it as suits you!

> >    - color diff: usually I just rely on:
> > 
> >       [color]
> >           ui = true
> > 
> >      But I also recently got used to using diff-highlight that will
> >      highlight different characters between lines. It's nice for complex
> >      "if" conditions where you don't see the difference, or for spaces
> >      vs tabs:
> > 
> >      [pager]
> >          log = /usr/doc/git-2.35.3/contrib/diff-highlight/diff-highlight | less
> >          show = /usr/doc/git-2.35.3/contrib/diff-highlight/diff-highlight | less
> >          diff = /usr/doc/git-2.35.3/contrib/diff-highlight/diff-highlight | less
> 
> Right, git log/show/diff --word-diff=color can also do this to some degree.

I didn't know word-diff. The format is unusual but can be convenient at
times. I think it's worth mentioning various options so that developers
try them, adopt or reject them based on habits and taste.

> There is also core.whitespace/color.diff.whitespace that will highlight
> some common whitespace errors.

yes.

> I haven't used diff-highlight myself -- I'll give it a try.

It gets a little while to get used to it as it changes the background
color around some parts. I find patches less easy to read when only
a few chars change on the line, but you get the info about what changes
and that's the point.

> In this case, I was using colordiff specifically to do the side-by-side
> diff of the two patches since it handles the <() shell syntax _and_ does
> the highlighting of differences between the patches.

Ah, then I understand, I didn't catch that you were using it to compare
the two patches. That's what I'm seeing on your site with the screenshots
indeed. In this case editing tools are of limited use here (except to
compare) since you definitely don't want to pick parts of a patch for
the other one.

> >    - git add, git add and git add: when fixing patches by hand, it's very
> >      common to leave some parts not added (especially with | patch -p1).
> >      It's useful to work on a clean tree to more easily spot untracked
> >      files with "git status".
> 
> Yet another reason to use git cherry-pick instead of manual patch
> commands: it keeps track of unmerged files for you. ;-)

Definitely. I think everyone prefers cherry-pick, but you quickly
learn it's not always an option. For old LTS kernels, they were so
far away from original ones that cherry-pick would systematically
pull in hundreds of context lines that made it very difficult to
locate the useful part :-/

> So I'm a bit torn on this. I think in this particular document I'd like
> to encourage the use of git and doing things "the git way" as much as
> possible.

Well, you asked how people in charge of this used to do it, right ? :-)
Similarly you've seen Steven's approach using Quilt. I had not thought
about using it this way, but the approach here was to keep track of
touched files. I think that in general patch management is ugly from a
software developemnt perspective. It relies on modifications arbitrarily
grouped by line because historically the tools have always worked this
way, and developers adapted to this method. But it doesn't follow any
sane workflow related to the software development cycle. It just
happens to work well enough. Based on this, I see nothing wrong with
doing what works for you. What matters is how much you can trust the
operations (hence the need for post-checks).

When working on old kernels, I used to find those rough ratios:
  - cherry-pick applies 1/3 of the time
  - 3/4 of applied cherry-picks actually build without error
  - 90% of cherry-picks that apply well really fix the problem

As such, as painful as it is, 10% of the patches that apply and build
after a successful cherry-pick do not correctly fix a problem or have
a side effect. Those that require manual fixing impose some analysis
that more often allows to detect that something is going to be wrong.
Several times it happened to me that I thought "uh oh 20 patches applied
in a row without problem, that's getting nasty".

I'm seeing a successful series of cherry-picks like a 100-line C program
that you write at once and that first compiles and starts without error.
You know that something's probably wrong but you don't know where to look.

So in short, yes, I do by far prefer cherry-pick but I don't trust it
that much because less human intervention usually means less validation.

> > > I'd like to add that my impression is that a LOT of people *fear*
> > > backporting and conflict resolution -- and it doesn't have to be that
> > > way. We should be talking about merge conflicts and what good workflows
> > > look like (one of the reasons why I was very happy to see Steven's
> > > presentation at KR), instead of leaving everybody to figure it out on
> > > their own. This document is my contribution towards that.
> > 
> > I'm not completely sold to this. Yes we should teach more people to
> > perform that task themselves. But there's a big difference between
> > backporting a few patches and feeling like you could maintain your own
> > kernel because now you know how to resolve conflicts. What I mentioned
> > above about dealing with patches you don't understand must not be
> > underestimated, that's the biggest challenge I faced when working on
> > stable kernels. There's probably a feeling of shame of not understanding
> > something, but I can say that many times I asked for help and was helped
> > even by top-ranked developers, and nobody ever laughed at me for not
> > understanding a certain area. But doing that in your garage for your
> > own kernel or for your company's products is a huge problem because it's
> > unlikely that you'll get help from the maintainers this time, so you're
> > left on your own with your own understanding of certain patches.
> > 
> > Thus, yes to backports, no to kernel forks being a collection of
> > backports.
> 
> Right; almost every time I talk about backporting it's really in the
> context of contributing these backports to stable. I'm not in favour of
> forks either and I'm not trying to encourage it.
> 
> Let me try to come up with a specific addition related to the changes
> you requested above and see if you agree with the wording.

OK!

Willy
