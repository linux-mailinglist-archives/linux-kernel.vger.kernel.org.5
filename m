Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB1A7511A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjGLUHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjGLUHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:07:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C9B1991
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE3DD618EC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39E6C433C7;
        Wed, 12 Jul 2023 20:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689192433;
        bh=hUPBZyfdDAkTTSlt7IS3kW6lPbc9VL+NI9CFtUdqhGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UhW3InwCkTfx0l1RMkrBJMprWBSO24DWKpjtvTeGiEhpNJnZD7zUZVtfd6DwYxoS5
         oZTFtpGCGLRunpdaSWHBO1e5v7RsQ3cNpneZuMT7kADmiPpYsgqTsipssUiFwPeQEd
         8pZ+4vTkUJeevdJ+EeXBAFhpe/nrBKqGH+JFe+so=
Date:   Wed, 12 Jul 2023 22:07:10 +0200
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
Message-ID: <2023071226-crafty-deviator-12e2@gregkh>
References: <20230712120002.GIZK6Vwga6DlJqdjEh@fat_crate.local>
 <ZK6hLZcuAH9jXKuL@redhat.com>
 <20230712132840.GKZK6qiK70m1O90jFL@fat_crate.local>
 <ZK6zdsIbnQFUmK69@redhat.com>
 <2023071200-unopposed-unbuckled-cde8@gregkh>
 <CAMw=ZnTVRaqRmtz+sDj7AeAS7xivSu+56UgKbzmuW9+K6TTx1A@mail.gmail.com>
 <2023071239-progress-molasses-3b3d@gregkh>
 <CAMw=ZnRheXk7W_r-32bGymbHKdXc7aKUpwGAOX+k7DJkN+DiCQ@mail.gmail.com>
 <2023071229-dusk-repacking-da3a@gregkh>
 <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:35:14PM +0100, Luca Boccassi wrote:
> On Wed, 12 Jul 2023 at 20:05, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 12, 2023 at 07:59:12PM +0100, Luca Boccassi wrote:
> > > On Wed, 12 Jul 2023 at 17:57, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Jul 12, 2023 at 05:23:18PM +0100, Luca Boccassi wrote:
> > > > > On Wed, 12 Jul 2023 at 16:43, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Wed, Jul 12, 2023 at 03:06:46PM +0100, Daniel P. Berrangé wrote:
> > > > > > > On Wed, Jul 12, 2023 at 03:28:40PM +0200, Borislav Petkov wrote:
> > > > > > > > On Wed, Jul 12, 2023 at 01:48:45PM +0100, Daniel P. Berrangé wrote:
> > > > > > > > > That doesn't make it useless, as the 3rd/4th/5th fields in the SBAT
> > > > > > > > > file are just human targetted metadata. The validation process just
> > > > > > > > > works off the 1st/2nd field.
> > > > > > > >
> > > > > > > > It's a good thing I asked - feels like I'm just scratching the surface
> > > > > > > > on what this thing actually is and the commit message is not explaining
> > > > > > > > any of that.
> > > > > > > >
> > > > > > > > First, second field, that's what, "linux,1"?
> > > > > > >
> > > > > > > Each sbat CSV file line has following fields:
> > > > > > >
> > > > > > >   component_name: the name we're comparing
> > > > > > >   component_generation: the generation number for the comparison
> > > > > > >   vendor_name: human readable vendor name
> > > > > > >   vendor_package_name: human readable package name
> > > > > > >   vendor_version: human readable package version (maybe machine parseable too, not specified here)
> > > > > > >   vendor_url: url to look stuff up, contact, whatever.
> > > > > > >
> > > > > > > So 'linux' is 'component_name' and '1' is component_generation
> > > > > > >
> > > > > > > > > From a functional POV, it doesn't have to be unique identified,
> > > > > > > > > as it is just a human targetted metadata field. A friendly git
> > > > > > > > > version as from 'git describe' is more appropriate than a build
> > > > > > > > > ID sha.
> > > > > > > >
> > > > > > > > So can you explain what exactly that version is supposed to describe?
> > > > > > > > Exact kernel sources the kernel was built from? Or a random, increasing
> > > > > > > > number which tools can use to mark as bad?
> > > > > > >
> > > > > > > AFAICT beyond being "human readable package version", it is a fairly
> > > > > > > arbitrary decision. A release version number for formal releases, or
> > > > > > > a 'git describe' version string for git snapshots both satisfy the
> > > > > > > versioning requirement IMHO.
> > > > > > >
> > > > > > > > How do you prevent people from binary-editing that section? Secure boot
> > > > > > > > does that because that changes the signed kernel image?
> > > > > > >
> > > > > > > The PE files are signed by the vendor who builds them, using their
> > > > > > > SecureBoot signing key. The data covered by the signature includes
> > > > > > > the '.sbat' section.
> > > > > > >
> > > > > > > IOW, if you binary edit the section, the SecureBoot signature
> > > > > > > verification fails and the kernel won't be booted.
> > > > > > >
> > > > > > > > > > And then why does it have to be a separate section? All those
> > > > > > > > > > requirements need to be written down.
> > > > > > > >
> > > > > > > > You missed this question.
> > > > > > >
> > > > > > > That's simply what the spec defines as the approach.
> > > > > > >
> > > > > > > The PE file format used by EFI applications has multiple
> > > > > > > sections and the spec has declare that the '.sbat' section
> > > > > > > is where this data shall live.
> > > > > > >
> > > > > > > > > The first line just identifies the file format and should
> > > > > > > > > never change:
> > > > > > > > >
> > > > > > > > >   sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
> > > > > > > >
> > > > > > > > Why do you even need it then?
> > > > > > >
> > > > > > > First it identifies the data format, and second if a
> > > > > > > problem is ever discovered with the  SBAT concept,
> > > > > > > a fixed approach can be indicated by changing to
> > > > > > > 'sbat,2,.....' and thus have the effect of revoking
> > > > > > > use of any binaries which declare the 'sbat,1,....'
> > > > > > > version. Pretty unlikely this will happen, but a useful
> > > > > > > backup plan/safety net.
> > > > > > >
> > > > > > > > > The second line identifies the kernel generation
> > > > > > > > >
> > > > > > > > >   linux,1,The Linux Developers,linux,6.5.0-rc1,https://linux.org
> > > > > > > > >
> > > > > > > > > The first field 'linux' should never change once decided upon, as it is
> > > > > > > > > the name of the upstream project's EFI component - in this case the
> > > > > > > > > linux kernel.
> > > > > > > > >
> > > > > > > > > The second field '1' is the most important one, as it is the mechanism
> > > > > > > > > through which revokation takes places, and the only one a human upstream
> > > > > > > > > maintainer should manually change.
> > > > > > > >
> > > > > > > > Hold on, how often are those things going to change? And who's going to
> > > > > > > > change them? I sure hope we won't start getting patches constantly
> > > > > > > > updating those numbers?
> > > > > > >
> > > > > > > It is hard to predict the future, but my gut feeling is very infrequently.
> > > > > >
> > > > > > Have you looked at the past as proof of this?
> > > > >
> > > > > I can't quite think of relevant bugs, in the recent past. Are you
> > > > > aware of past instances of kernel module signature verification being
> > > > > broken? Or userspace being allowed to do arbitrary kernel memory
> > > > > manipulation before ExitBootServices?
> > > >
> > > > Yes.
> > >
> > > Then you already know the answer w.r.t. frequency
> >
> > I have a clue, yes.  But given that others do not that are proposing
> > this, that's quite worrying.
> 
> Not really, as that's not the purpose. As the documentation clearly
> states, the purpose is to have a revocation mechanism that won't
> exhaust nvram space.

How do you know that the list of issues will not exhaust it, if you
don't know how many issues are found?

Take the time and look over the past 10 years and get an idea of what
you are dealing with here please.

Also note that "single identifiers for individual issues" do NOT work
for kernel fixes (and arguably do not work for any other software
project either) as they fail to properly describe things.

Think about Meltdown, one "identifier" of a CVE, and hundreds of
patches.  What if you happened to not backport one of them?

Same goes for the issue reported last week or so, tens of fixes, over
multiple stable kernel releases, for one "identifier", how would you
have classified that?

Anyway, I've been over this loads before, giving whole talks about this,
there's a reason the kernel developers don't mess with CVEs (i.e.
individual identifiers), they fail to work.

> > > > And no, I will not provide examples for obvious reasons.
> > >
> > > Security-through-obscurity? Nice!
> >
> > That's not what this is, please see the many places this is explained
> > in detail.  If you wish to discuss how the kernel security team handles
> > known security fixes, we can do so on a relevant thread (i.e. not this
> > one.)
> >
> > > > > > > I can't say I recall any specific Linux bugs that would warrant it, but
> > > > > > > those involved in Linux/Bootloade/SecureBoot world can probably answer
> > > > > > > this better than me. IIUC, the scope of bugs relevent to this is quite
> > > > > > > narrow.
> > > > > >
> > > > > > Really?  I know a lot of people who would disagree...
> > > > >
> > > > > They'd better have some convincing reasons
> > > > >
> > > > > > > > > If there is discovered a flaw in Linux that allows the Secure Boot chain
> > > > > > > > > to be broken (eg some flaw allowed linux to be exploited as a mechanism
> > > > > > > > > to load an unsigned binary), then this 'generation' number would need
> > > > > > > > > to be incremented when a fix is provided in upstream Linux trees.
> > > > > > > >
> > > > > > > > Oh boy, there it is. And then when those fixes need to be backported to
> > > > > > > > stable, then those patches updating that number would need to be
> > > > > > > > backported too. I can already see the mess on the horizon.
> > > > > > >
> > > > > > > If applicable, yes.
> > > > > >
> > > > > > And how are you going to determine this?
> > > > >
> > > > > Same as it's done for the bootloaders - does it enable a secure boot
> > > > > bypass -> yes/no
> > > >
> > > > And how are you going to determine this?  Seriously, please explain the
> > > > auditing you are going to do here and who is going to maintain it and
> > > > fund the effort?
> > >
> > > Same way it is determined for Shim, Grub, sd-boot, Windows BootMngr,
> > > etc - maintainers doing their jobs, researchers poking at them, or if
> > > we are particularly unlucky by live exploits in the wild. I'm not
> > > exactly sure where the confusion comes from, none of this is novel.
> >
> > But why does any of this matter at all?  Just use the kernel version
> > (which is already in the image), and be done with it.  We always
> > increment it so all should be fine.
> 
> No, all will not be fine, because stable branches exist, so it would
> not be _one_ kernel version but N, with monotonically increasing
> values of N. That doesn't work, and the reason for that are explained
> in the protocol documentation that was linked in the initial mail.

Pointing to an external document that is thousands of lines long,
talking about bootloaders, is NOT a good way to get people to want to
accept a kernel patch :)

good luck!

greg k-h
