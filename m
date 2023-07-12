Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B91751297
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjGLVXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGLVXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:23:11 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 379531BF3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:23:09 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36CLCxga009006;
        Wed, 12 Jul 2023 23:12:59 +0200
Date:   Wed, 12 Jul 2023 23:12:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20230712211259.GA8942@1wt.eu>
References: <20230712132840.GKZK6qiK70m1O90jFL@fat_crate.local>
 <ZK6zdsIbnQFUmK69@redhat.com>
 <2023071200-unopposed-unbuckled-cde8@gregkh>
 <CAMw=ZnTVRaqRmtz+sDj7AeAS7xivSu+56UgKbzmuW9+K6TTx1A@mail.gmail.com>
 <2023071239-progress-molasses-3b3d@gregkh>
 <CAMw=ZnRheXk7W_r-32bGymbHKdXc7aKUpwGAOX+k7DJkN+DiCQ@mail.gmail.com>
 <2023071229-dusk-repacking-da3a@gregkh>
 <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
 <2023071226-crafty-deviator-12e2@gregkh>
 <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jul 12, 2023 at 09:41:23PM +0100, Luca Boccassi wrote:
> > Also note that "single identifiers for individual issues" do NOT work
> > for kernel fixes (and arguably do not work for any other software
> > project either) as they fail to properly describe things.
> >
> > Think about Meltdown, one "identifier" of a CVE, and hundreds of
> > patches.  What if you happened to not backport one of them?
> >
> > Same goes for the issue reported last week or so, tens of fixes, over
> > multiple stable kernel releases, for one "identifier", how would you
> > have classified that?
> >
> > Anyway, I've been over this loads before, giving whole talks about this,
> > there's a reason the kernel developers don't mess with CVEs (i.e.
> > individual identifiers), they fail to work.
> 
> There is no 'single identifier for individual issues' nor CVE involved
> here. The purpose of the generation id (which is per EFI component,
> not per bug) is to let the boot process know whether an EFI component
> should be accepted or rejected, in a way that doesn't exhaust nvram.
> Issues are not individually singled out, and there is no direct
> correlation with CVEs. It doesn't matter how many fixes there are, or
> how many bugs, if a generation of a component is vulnerable in any way
> that matters, then it gets denied.

I refrained from chiming in but I'm really reading shocking stuff here,
so please let me make a few comments based on some old experience.

Several times in this thread you seemed to imply that there is "someone" or
"something" that knows whether or not a kernel is absolutely vulnerable
or absolutely trustable regarding a certain bug, when developers
themselves only have an estimate about it, whose probability quickly
fades away with the depth of backports.

When I was in charge of extended 2.6.32 many years ago, the Debian kernel
team helped me by occasionally sending me series of backports of fixes
for issues I had missed, and fixes for backports I had failed. That's the
principle of maintenance: adding incremental fixes that make the whole
code better.

With your process (OK you said it's not yours, but then why adopt it when
it doesn't match the workflow of the software it tries to adapt to), how
would we proceed ? "Let's bump this ID now that the new 2.6.32.233 has
everything fixed". Or rather "let's *not* bump it because nobody knows
how to backport this other stuff that's blocking the ID increment". Then
once finally bumped, one month later we figure that the fixes were still
incorrect due to important differences in the older branches, and have
to be fixed again, so according to what I understand, we must then
immediately revoke the current ID, that is also shared by upstream and
all correctly fixed maintenance branches, and have to emit a new one
for all branches at once even if the code didn't change, just because
myself incompetent stable maintainer of the week-end failed to fix
something non-obvious at once ? If so, I'm sorry but this is non-sense.
There must be another approach to this or it was designed by someone
having never met a bug in person!

What I'm also wondering is, if in the end it turns out that only the
distro has the skills to decide which kernel version is fixed and which
one isn't (after all, it's the distro who chooses the config and the
compiler, both are as much involved in bugs as the code itself), then
why not make sort of a wrapper or an envelope around an existing kernel
image, which provides this ID that the distro can freely choose, then
transfer the control to the embedded kernel image ? This might give
the distro the freedom to proceed as it wants with no cross-dependency
on kernel branches.

> > Pointing to an external document that is thousands of lines long,
> > talking about bootloaders, is NOT a good way to get people to want to
> > accept a kernel patch :)
> 
> Then how about just asking for that? "Hello submitter, please send a
> v2 with a detailed summary of the problem being solved for those of us
> who are not familiar with it, thank you"

Probably that there was a problem with process in the first place by
which someone asks some maintainers to accept to merge, maintain and
become responsible for breaking changes they disagree with, without
having even being presented to them before being developed ?

Regards,
Willy
