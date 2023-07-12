Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5F375128A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjGLVUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjGLVUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:20:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB568CE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:20:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 517A76190E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E091C433C8;
        Wed, 12 Jul 2023 21:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689196803;
        bh=McegQsZaG52wjsJRozjE92HzDPs7W4G2Fmq5kJtYojc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+H3qx8pTxYQPZgF6PJbO9g9OHfq4sG8vm5e9hUcw9vgY+YetyExmafBZ/1lNga77
         V28E0dsMyKcVh+5cqfFhkxueDwRll8zmgopl/+ZwiqCSHkYI6WIDS8jz4PRpJYGBhA
         OnIit9Nv6QyOD8r0p5WT0NJYeowFQ2NVJH67seAo=
Date:   Wed, 12 Jul 2023 23:20:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
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
Message-ID: <2023071233-empirical-overturn-744c@gregkh>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:41:23PM +0100, Luca Boccassi wrote:
> On Wed, 12 Jul 2023 at 21:07, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 12, 2023 at 08:35:14PM +0100, Luca Boccassi wrote:
> > > On Wed, 12 Jul 2023 at 20:05, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Jul 12, 2023 at 07:59:12PM +0100, Luca Boccassi wrote:
> > > > > On Wed, 12 Jul 2023 at 17:57, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Wed, Jul 12, 2023 at 05:23:18PM +0100, Luca Boccassi wrote:
> > > > > > > On Wed, 12 Jul 2023 at 16:43, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jul 12, 2023 at 03:06:46PM +0100, Daniel P. Berrangé wrote:
> > > > > > > > > On Wed, Jul 12, 2023 at 03:28:40PM +0200, Borislav Petkov wrote:
> > > > > > > > > > On Wed, Jul 12, 2023 at 01:48:45PM +0100, Daniel P. Berrangé wrote:
> > > > > > > > > > > That doesn't make it useless, as the 3rd/4th/5th fields in the SBAT
> > > > > > > > > > > file are just human targetted metadata. The validation process just
> > > > > > > > > > > works off the 1st/2nd field.
> > > > > > > > > >
> > > > > > > > > > It's a good thing I asked - feels like I'm just scratching the surface
> > > > > > > > > > on what this thing actually is and the commit message is not explaining
> > > > > > > > > > any of that.
> > > > > > > > > >
> > > > > > > > > > First, second field, that's what, "linux,1"?
> > > > > > > > >
> > > > > > > > > Each sbat CSV file line has following fields:
> > > > > > > > >
> > > > > > > > >   component_name: the name we're comparing
> > > > > > > > >   component_generation: the generation number for the comparison
> > > > > > > > >   vendor_name: human readable vendor name
> > > > > > > > >   vendor_package_name: human readable package name
> > > > > > > > >   vendor_version: human readable package version (maybe machine parseable too, not specified here)
> > > > > > > > >   vendor_url: url to look stuff up, contact, whatever.
> > > > > > > > >
> > > > > > > > > So 'linux' is 'component_name' and '1' is component_generation
> > > > > > > > >
> > > > > > > > > > > From a functional POV, it doesn't have to be unique identified,
> > > > > > > > > > > as it is just a human targetted metadata field. A friendly git
> > > > > > > > > > > version as from 'git describe' is more appropriate than a build
> > > > > > > > > > > ID sha.
> > > > > > > > > >
> > > > > > > > > > So can you explain what exactly that version is supposed to describe?
> > > > > > > > > > Exact kernel sources the kernel was built from? Or a random, increasing
> > > > > > > > > > number which tools can use to mark as bad?
> > > > > > > > >
> > > > > > > > > AFAICT beyond being "human readable package version", it is a fairly
> > > > > > > > > arbitrary decision. A release version number for formal releases, or
> > > > > > > > > a 'git describe' version string for git snapshots both satisfy the
> > > > > > > > > versioning requirement IMHO.
> > > > > > > > >
> > > > > > > > > > How do you prevent people from binary-editing that section? Secure boot
> > > > > > > > > > does that because that changes the signed kernel image?
> > > > > > > > >
> > > > > > > > > The PE files are signed by the vendor who builds them, using their
> > > > > > > > > SecureBoot signing key. The data covered by the signature includes
> > > > > > > > > the '.sbat' section.
> > > > > > > > >
> > > > > > > > > IOW, if you binary edit the section, the SecureBoot signature
> > > > > > > > > verification fails and the kernel won't be booted.
> > > > > > > > >
> > > > > > > > > > > > And then why does it have to be a separate section? All those
> > > > > > > > > > > > requirements need to be written down.
> > > > > > > > > >
> > > > > > > > > > You missed this question.
> > > > > > > > >
> > > > > > > > > That's simply what the spec defines as the approach.
> > > > > > > > >
> > > > > > > > > The PE file format used by EFI applications has multiple
> > > > > > > > > sections and the spec has declare that the '.sbat' section
> > > > > > > > > is where this data shall live.
> > > > > > > > >
> > > > > > > > > > > The first line just identifies the file format and should
> > > > > > > > > > > never change:
> > > > > > > > > > >
> > > > > > > > > > >   sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
> > > > > > > > > >
> > > > > > > > > > Why do you even need it then?
> > > > > > > > >
> > > > > > > > > First it identifies the data format, and second if a
> > > > > > > > > problem is ever discovered with the  SBAT concept,
> > > > > > > > > a fixed approach can be indicated by changing to
> > > > > > > > > 'sbat,2,.....' and thus have the effect of revoking
> > > > > > > > > use of any binaries which declare the 'sbat,1,....'
> > > > > > > > > version. Pretty unlikely this will happen, but a useful
> > > > > > > > > backup plan/safety net.
> > > > > > > > >
> > > > > > > > > > > The second line identifies the kernel generation
> > > > > > > > > > >
> > > > > > > > > > >   linux,1,The Linux Developers,linux,6.5.0-rc1,https://linux.org
> > > > > > > > > > >
> > > > > > > > > > > The first field 'linux' should never change once decided upon, as it is
> > > > > > > > > > > the name of the upstream project's EFI component - in this case the
> > > > > > > > > > > linux kernel.
> > > > > > > > > > >
> > > > > > > > > > > The second field '1' is the most important one, as it is the mechanism
> > > > > > > > > > > through which revokation takes places, and the only one a human upstream
> > > > > > > > > > > maintainer should manually change.
> > > > > > > > > >
> > > > > > > > > > Hold on, how often are those things going to change? And who's going to
> > > > > > > > > > change them? I sure hope we won't start getting patches constantly
> > > > > > > > > > updating those numbers?
> > > > > > > > >
> > > > > > > > > It is hard to predict the future, but my gut feeling is very infrequently.
> > > > > > > >
> > > > > > > > Have you looked at the past as proof of this?
> > > > > > >
> > > > > > > I can't quite think of relevant bugs, in the recent past. Are you
> > > > > > > aware of past instances of kernel module signature verification being
> > > > > > > broken? Or userspace being allowed to do arbitrary kernel memory
> > > > > > > manipulation before ExitBootServices?
> > > > > >
> > > > > > Yes.
> > > > >
> > > > > Then you already know the answer w.r.t. frequency
> > > >
> > > > I have a clue, yes.  But given that others do not that are proposing
> > > > this, that's quite worrying.
> > >
> > > Not really, as that's not the purpose. As the documentation clearly
> > > states, the purpose is to have a revocation mechanism that won't
> > > exhaust nvram space.
> >
> > How do you know that the list of issues will not exhaust it, if you
> > don't know how many issues are found?
> >
> > Take the time and look over the past 10 years and get an idea of what
> > you are dealing with here please.
> >
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

What does "in any way that matters" mean exactly?

And are you treating the whole kernel as an "EFI component" here?

Who is going to be responsible for determining that this number needs to
be updated?

How are they going to determine this?

What is their response time?

Who will they be submitting the patch to this string in order to have it
change?

And how is any of this going to interact with stable kernel releases,
long term kernel releases and end-of-life kernel releases?

How long will this feature have to be maintained?

> The only thing that matters is, "if we had infinite space in DBX and
> sensible ways to service it and nvram didn't wear down, would we
> blocklist this component version" - if the answer is no, then nothing
> happens. If the answer is yes, then the counter goes up.

I suggest you all take a look at the past 10 years of kernel releases
and changes (to pick a simple number) and determine what the number
would be now if you were to start counting then.  Is it 10?  100?
10000?  What do you think it will be in the next 40 years?

We have a plethora of kernel changes in our history to learn from here,
please do so and show how this will affect us going forward based on our
past, otherwise we have no way of knowing how any of this is going to
work.

thanks,

greg k-h
