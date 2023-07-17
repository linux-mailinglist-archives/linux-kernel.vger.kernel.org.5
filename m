Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354F67565C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjGQOGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjGQOGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:06:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F9DE1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDDFA61085
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF446C433C8;
        Mon, 17 Jul 2023 14:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689602771;
        bh=jFlcqvBEGeYJTLoZhszcbHb+juzBNAgFWmAJZkofD4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKer11Xy797yEfQCiPdQQ3paWtUcjMnwpPlljyc6QTNn/fc1ArwKWa8U+B0m5VPFE
         OOee7qfJJQbjUkLgMQLR5cwZP410Q8z/tUpqNPTHVTA5eJszbXmv7eKOu28sd4Uuma
         TNkznZaY59aQSYg9JTwoF6W1NJ9/ueEq5GIxt3vA=
Date:   Mon, 17 Jul 2023 16:06:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc:     Luca Boccassi <bluca@debian.org>, Borislav Petkov <bp@alien8.de>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <2023071723-paging-despite-7094@gregkh>
References: <2023071226-crafty-deviator-12e2@gregkh>
 <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
 <2023071233-empirical-overturn-744c@gregkh>
 <CAMw=ZnRRviBNi_LK9VOSUV9PNHe3jurUcLfgLpbTOsp_eE4WyA@mail.gmail.com>
 <2023071350-specked-botanist-6ba8@gregkh>
 <CAMw=ZnQZ9ds3xsa2AZv_F13dB6rR4XzGPrBjJHSga1oU5xRezQ@mail.gmail.com>
 <2023071552-quilt-tranquil-b7bf@gregkh>
 <CAMw=ZnROWgDOiAr1iikTWa7Qm81HoE17NuEdLt8hwGnkKSnoCg@mail.gmail.com>
 <2023071643-broiler-level-afbf@gregkh>
 <ZLUIViihakhyPV1N@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLUIViihakhyPV1N@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:22:51AM +0100, Daniel P. Berrangé wrote:
> On Sun, Jul 16, 2023 at 08:28:10PM +0200, Greg KH wrote:
> > On Sun, Jul 16, 2023 at 06:41:04PM +0100, Luca Boccassi wrote:
> > > On Sat, 15 Jul 2023 at 07:52, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > If you are not willing to take the time to determine how this proposed
> > > > change will affect the kernel developers and infrastructure by doing
> > > > some modeling based on our past history, then we have no reason to even
> > > > consider accepting this change as you are stating that you have no idea
> > > > how it will affect us.
> > > 
> > > There's no need for that to tell you how this will affect you: it will
> > > not. Every now and then you'll receive a one-liner patch to apply.
> > > What's so terrible about that?
> 
> I think that's not entirely accurate, as this *will* have an impact on
> anyone involved in backporting fixes for the kernel stable trees, when
> they need to resolve conflicts on the SBAT file. It shouldn't have a
> big impact, but we should be honest that it will be a non-zero impact.
> 
> Lets say mainline branch has had 2 security vulnerabilities A and B,
> each of which was associated with an increment of the SBAT version
> number. The first flaw A changed SBAT from 7 to 8,and then the second
> flaw B changed SBAT from 8 to 9.
> 
> If someone wants to backport the fix for bug "B" they will get a
> conflict on the SBAT file when cherry-picking the patch. When that
> happens they must decide:
> 
>   * It is acceptable to ignore issue A, because it didn't affect
>     that branch. The conflict is resolved by having the backported
>     patch increase SBAT version from 7 to 9 directly.
> 
>   * It is required to first backport issue A, because that also
>     affects that branch. The conflict is resolved by first backporting
>     the code fix & SBAT change for A, and then backporting the code
>     fix and SBAT change for B. SBAT changes from 7 to 8 to 9 just
>     like on master.
> 
> IOW whomever is doing backport patches for stable needs to understand
> the semantics of SBAT and how to resolve conflicts on it. If they get
> this wrong, then it breaks the protection offered by SBAT, which would
> then require a 3rd SBAT change to fix the mistake.
> 
> This likely means that stable tree maintainers themselves need to
> understand the SBAT change rules, so they can review conflict resolution
> for any proposed changes, to sanity check what is being proposed.

Exactly, and this also shows how a single "number" means nothing when it
comes to stable trees, as it can never properly convey what got fixed,
and what did not get fixed.

> > And who will be sending that to me?  For what releases?  For how long
> > will they be agreeing to do this work for?  How will it be tracked?
> > What will they be using to determine when the number will be changed?
> > How will they know it should be changed?
> 
> Before we consider SBAT, there is the code bug & its patch.
> 
> Someone finds bug in the early boot process on EFI systems and cooks up
> a patch for it. This is work that is already done today, whether entirely
> upstream in the normal context of day-to-day kernel development, or
> downstream with a vendor receiving a bug report and triaging a response
> to it which eventually turns into an upstream submission.
> 
> Today there is the question of whether to assign a CVE to such fixes.

No there is not any such question.  The kernel security team explicitly
does NOT deal with CVEs, and MITRE refuses to give me any new ones even
when I ask.

So we just aren't even going to play that game of security theatre,
sorry.

We fix hundreds, if not thousands, of bugs a month that could be
considered "CVE worthy" if we wanted to play that game, so we don't.

> If upstream doesn't have an associated CVE identified when merging the
> code patch, the downstream vendors act as a backstop and can decide to
> assign a CVE after the fact. This is relatively easy as assigning a
> CVE doesn't result in any code patches, it is just paperwork and does
> not really impact upstream at that point.

Again, upstream does not do anything with CVEs except recommend staying
away from them entirely as they do nothing except grease the wheels of
companies that have broken engineering processes (i.e. RH.)

> In terms of triage, deciding to increment SBAT is little different
> from deciding to assign a CVE. The analysis & decision can be done
> upstream, but if not, downstream vendors can act as a backstop to
> do the analysis after a code patch is already in upstream. I would
> probably assume that any flaw serious enough to break SecureBoot
> is likely going to arrive via an embargoed security report involving
> downstream vendors, so SBT changes would be co-ordinated via the
> vendor triage & response.

I can think of at least a dozen fixes we have done in the past year that
could have been considered "seriously enough to break secure boot" that
never got a CVE as we just did our job and fixed the issue and moved on
to the next problem.

So this is where your whole idea of "tracking breakages" breaks down.
You all don't know how to track this because no one is doing it.  And
when we have had people try to audit all fixes we backport for something
potentially like this, they gave up after a few months as they could not
keep up with the huge flow.

In short, we fix so many things, and any kernel change could possibly be
a security issue, that trying to enumerate them all and classify them is
almost impossible, even when someone is paying a team of people to do
that.  And now, no one is paying anyone, so again, who is going to
realistically do this work?

And even better yet, if you were to attempt to increment this number as
part of a patch that was submitted, that throws up a HUGE red flag to
the world that "hey, this was a serious fix, let's go attack
everything!" before it gets a chance to be rolled out to everywhere.

So by design, your "increment the number" process would HAVE TO lag the
acceptance of any potential patch that fixes a security issue, otherwise
you are making systems LESS secure, instead of more secure by the very
nature of the information being given to the world at large.

> The key difference with SBAT is that if a downstream vendor identifies
> needs for an SBAT version change, after a  patch is already merged in
> upstream, this would typically trigger a 2nd followup patch to be sent
> upstream from the vendor.

So you will always lag.  So how will you "match" the SBAT version change
with the actual patch?

Why not just increment the SBAT version at every kernel version change
to be sure you got it right that the fixes in this version actually
resolve real issues?

> In terms of what branches would be impacted. The minimum bar would be
> to only make SBAT changes in master. If that is all that is ever done
> upstream, the mechanism would work as intended.

Ah, but kernels are NOT used in devices from Linus's tree (i.e. master),
but rather, the world runs off of the stable kernel releases.

> There will inevitably
> be backports to stable trees though, and people involved in this will
> need to understand the rules for resolving conflicts when backporting
> fixes that change SBAT as mentioned earlier.

And as the person running the stable releases, you BETTER be working
with me to try to figure this all out.  Which goes back to my original
point, to ignore the fact that this whole thing really is a process
issue, and NOT a technical issue, is naive and shortsighted by everyone
involved.

So work on the process issues first please, and then come back and talk
to us and we will be glad to discuss if your proposed changes are
actually doable or not.

> > None of this has been answered, and that's the real issue here.  This
> > "magic number" is saying it is going to reflect some specific "security
> > issue" yet no one is saying how those issues are going to be determined,
> > or anything else about it.
> 
> Luca gave a (non-exhaustive) list of examples of areas of the code
> which are most relevant earlier in the thread
> 
> [quote]
> Kernel module signature enforcement, Lockdown LSM, ensuring
> ExitBootServices is called at the right time, etc.
> [/quote]

I can say for certain that this is NOT a correct summary of what you
need to be auditing.  Heck, you forgot "kernel configuration
dependencies" which I know in the past have been real issues and caused
systems that previously were thought to be "secure" to be able to be
trivially bypassed.  Would you all even have listed that as a potential
thing to audit if I hadn't mentioned it?

Which goes back to my original statement above, who is going to be doing
this auditing and who is going to fund and support it and how exactly
are you going to do it?  Have you learned nothing from prior efforts
here?  If so, what are you going to do differently than those who
attempted this before?

> IIUC, your request here could potentially be satisfied if there was
> first a patch that added a file 'Documentation/security/sbat.rst'
> explaining in much more detail which set of kernel features are
> relevant when considering SBAT, and how to evaluate bugs to decide
> whether a SBAT change is justified or not.

That would be a good start, but really, I could sum that up with "any
kernel bug" as remember, a bug is a bug is a bug at this layer in the
stack.

> That docs file also needs to explain the implications and criteria
> for backporting patches to stable branches, and how to deal with SBAT
> if upstream didn't make a change to it and it needs changing after
> the fact.

Good luck with the documentation!  We can't get people to read our
simple "add a cc: stable@vger.kernel.org to your bugfix to have it
automatically backported" document, I can't wait to see just how the
process for sbat is going to look like and who is going to audit the
kernel submissions to determine if people are properly doing this or
not.

> The SBAT concept was introduced after discussions with Microsoft
> after the Grub BootHole[1] vulnerability was identified in 2021.

Great, so it is for grub, why does anyone think it can work with a
kernel that moves at the speed of Linux?

> I'm not aware of any kernel CVEs since that point in time that
> would have implied SBAT changes, but admittedly I've not paid
> close enough attention to be entirely confident. Is going back
> through 2 years of kernel CVEs (to the point where SBAT was
> invented) a long enough timeframe to satisfy this request for
> info on the frequency of changes ?

CVEs mean nothing, and in fact, many of them recently mean worse than
nothing, they are actually wrong!  So no, don't look at CVEs, instead,
look at all fixes that are going into the stable kernel trees.  That
should give you a better idea.

Oh, and you all forgot, how are you going to deal with fixes for issues
that cross multiple kernel patches, and even multiple kernel releases,
in order to properly resolve the issue?  And multiple implementations?
Think about Spectre/Meltdown, how would you all have classified that as
the fixes flowed into the releases over a 6 month period?  Would you
have just bumped the number each patch?  Or waited until "yes, we
finally got it right this time, we swear!" and then bumped the value?

Anyway, you all have a ton of real work to do, before any of us can
actually consider this as anything we should even consider doing.  Best
of luck, the 2 line kernel patch will be the most simple part of this
whole thing, that's not the real issue here at all.

thanks,

greg k-h
