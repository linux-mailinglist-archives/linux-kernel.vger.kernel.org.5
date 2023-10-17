Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B8F7CC32A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbjJQM1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjJQM1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:27:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61E3FD;
        Tue, 17 Oct 2023 05:27:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5A4A321C3D;
        Tue, 17 Oct 2023 12:27:50 +0000 (UTC)
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2108E2C5EF;
        Tue, 17 Oct 2023 12:27:49 +0000 (UTC)
Date:   Tue, 17 Oct 2023 14:27:47 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH rebased] kbuild: rpm-pkg: Fix build with non-default
 MODLIB
Message-ID: <20231017122747.GH6241@kitsune.suse.cz>
References: <20231005150728.3429-1-msuchanek@suse.de>
 <CAK7LNAQh7vCQ859RPkL3SDr2d4ptt5OVCr66fkPKGcvxDUHtkw@mail.gmail.com>
 <20231009085208.GT6241@kitsune.suse.cz>
 <CAK7LNASeMEKVi5c0PEow5KSdN7rsm7UYEf2smWOSkYOhr_5fVQ@mail.gmail.com>
 <20231009140733.GV6241@kitsune.suse.cz>
 <CAK7LNAQQMFUt4R1m_U8kBY5=BvxD_dMuE4MD4kpd48WK1E+AGA@mail.gmail.com>
 <20231010101552.GW6241@kitsune.suse.cz>
 <CAK7LNASX2_-xt3Qvxie_G=Q4fuVYR6eE47QjQ5NZf7QxY-4_tQ@mail.gmail.com>
 <20231017104453.GG6241@kitsune.suse.cz>
 <CAK7LNASKPg0JK0QsLGb1Rfx2ysvHJTm3NFOvtwOpZRz4-20T8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNASKPg0JK0QsLGb1Rfx2ysvHJTm3NFOvtwOpZRz4-20T8w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         TAGGED_RCPT(0.00)[];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 5A4A321C3D
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:05:29PM +0900, Masahiro Yamada wrote:
> On Tue, Oct 17, 2023 at 7:44 PM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > On Tue, Oct 17, 2023 at 07:15:50PM +0900, Masahiro Yamada wrote:
> > > > >
> > > > > Let me add more context to my question.
> > > > >
> > > > >
> > > > > I am interested in the timing when
> > > > > 'pkg-config --print-variables kmod | grep module_directory'
> > > > > is executed.
> > > > >
> > > > >
> > > > >
> > > > > 1.  Build a SRPM on machine A
> > > > >
> > > > > 2.  Copy the SRPM from machine A to machine B
> > > > >
> > > > > 3.  Run rpmbuild on machine B to build the SRPM into a RPM
> > > > >
> > > > > 4.  Copy the RPM from machine B to machine C
> > > > >
> > > > > 5.  Install the RPM to machine C
> > > >
> > > > As far as I am aware the typical use case is two step:
> > > >
> > > > 1. run make rpm-pkg on machine A
> > > > 2. install the binary rpm on machine C that might not have build tools
> > > >    or powerful enough CPU
> > > >
> > > > While it's theoretically possible to use the srpm to rebuild the binary
> > > > rpm independently of the kernel git tree I am not aware of people
> > > > commonly doing this.
> > >
> > >
> > >
> > > If I correctly understand commit
> > > 8818039f959b2efc0d6f2cb101f8061332f0c77e,
> > > those Redhat guys pack a SRPM on a local machine,
> > > then send it to their build server called 'koji'.
> > >
> > > Otherwise, there is no reason
> > > to have 'make srcrpm-pkg'.
> > >
> > >
> > >
> > > I believe "A == B" is not always true,
> > > but we can assume "distro(A) == distro(B)" is always met
> > > for simplicity.
> > >
> > > So, I am OK with configuration at the SRPM time.
> >
> > Even if the distro does not match it will likely work to configure SRPM
> > for non-matching distro and then build it on the target distro but I have
> > not tested it.
> 
> 
> 
> Your approach specifies %{MODLIB} as a fixed string
> when generating kernel.spec, i.e. at the SRPM time.
> 
> 
>  %files
>  %defattr (-, root, root)
> -/lib/modules/%{KERNELRELEASE}
> -%exclude /lib/modules/%{KERNELRELEASE}/build
> +%{MODLIB}
> +%exclude %{MODLIB}/build
>  /boot/*
> 
> 
> Then, how to change the path later?

Why would you need to change the path later?

The SRPM has sources, it does not need to build on the system on which
it is authored if it is intended for another distribution.

Of course, you would need to know for what distribution and where it
wants its modules so that you can specify the location when creating the
SRPM.

> > > > If rebuilding the source rpm on a different machine from where the git
> > > > tree is located, and possibly on a different distribution is desirable
> > > > then the detection of the KERNEL_MODULE_DIRECTORY should be added in the
> > > > rpm spec file as well.
> > > >
> > > > > Of course, we are most interested in the module path
> > > > > of machine C, but it is difficult/impossible to
> > > > > guess it at the time of building.
> > > > >
> > > > > We can assume machine B == machine C.
> > > > >
> > > > > We are the second most interested in the module
> > > > > path on machine B.
> > > > >
> > > > > The module path of machine A is not important.
> > > > >
> > > > > So, I am asking where you would inject
> > > > > 'pkg-config --print-variables kmod | grep module_directory'.
> > > >
> > > > I don't. I don't think there will be a separate machine B.
> > > >
> > > > And I can't really either - so far any attempt at adding support for
> > > > this has been rejected.
> > > >
> > > > Technically the KERNEL_MODULE_DIRECTORY could be set in two steps - one
> > > > giving the script to run, and one running it, and then it could be run
> > > > independently in the SRPM as well.
> > >
> > >
> > > At first, I thought your patch [1] was very ugly,
> > > but I do not think it is so ugly if cleanly implemented.
> > >
> > > It won't hurt to allow users to specify the middle part of MODLIB.
> > >
> > >
> > > There are two options.
> > >
> > >
> > > [A]  Add 'MOD_PREFIX' to specify the middle part of MODLIB
> > >
> > >
> > > The top Makefile will look as follows:
> > >
> > >
> > > MODLIB = $(INSTALL_MOD_PATH)$(MOD_PREFIX)/lib/modules/$(KERNELRELEASE)
> > > export MODLIB
> > >
> > >
> > > It is easier than specifying the entire MODLIB, but you still need
> > > to manually pass "MOD_PREFIX=/usr" from an env variable or
> > > the command line.
> > >
> > > If MOD_PREFIX is not given, MODLIB is the same as the current one.
> > >
> > > [B] Support a dynamic configuration as well
> > >
> > >
> > > MOD_PREFIX ?= $(shell pkg-config --variable=module_prefix libkmod 2>/dev/null)
> > > export MOD_PREFIX
> > >
> > > MODLIB = $(INSTALL_MOD_PATH)$(MOD_PREFIX)/lib/modules/$(KERNELRELEASE)
> > > export MODLIB
> >
> > That's basically the same thing as the patch that has been rejected.
> >
> > I used := to prevent calling pkg-config every time MODLIB is used but it
> > might not be the most flexible wrt overrides.
> 
> That's good you care about the cost of $(shell ) invocations.
> 
> := is evaluated one time at maximum, but one time at minimum.
> 
> $(shell ) is always invoked for non-build targets as
> "make clean", "make help", etc.
> That is what I care about.
> 
> 
> ?= is a recursive variable.
> 
> The workaround for one-time evaluation is here,
> https://savannah.gnu.org/bugs/index.php?64746#comment2
> 
> However, that is not a problem because I can do it properly somehow,
> for example, with "private export".

That's good to know.

> > > If MOD_PREFIX is given from an env variable or from the command line,
> > > it is respected.
> > >
> > > If "pkg-config --variable=module_prefix libkmod" works,
> > > that configuration is applied.
> > >
> > > Otherwise, MOD_PREFIX is empty, i.e. fall back to the current behavior.
> > >
> > >
> > > I prefer 'MOD_PREFIX' to 'KERNEL_MODULE_DIRECTORY' in your patch [1]
> > > because "|| echo /lib/modules" can be omitted.
> > >
> > > I do not think we will have such a crazy distro that
> > > installs modules under /opt/ directory.
> >
> > However, I can easily imagine a distribution that would want to put
> > modules in /usr/lib-amd64-linux/modules.
> 
> 
> Sorry, it is not easy for me.
> 
> What is the background of your thought?

That's where every other library and module would go on distributions
that care about ability to install packages for multiple architectures
at the same time. AFAIK the workaround is to inclclude the CPU
architecture in extraversion for the kernel to fit.

> >
> > > I could not understand why you inserted
> > > "--print-variables kmod 2>/dev/null | grep '^module_directory$$' >/dev/null"
> > > but I guess the reason is the same.
> > > "pkg-config --variable=module_directory kmod" always succeeds,
> > > so "|| echo /lib/modules" is never processed.
> >
> > Yes, that's the semantics of the tool. The jq version was slightly less
> > convoluted but required additional tool for building the kernel.
> 
> 
> It IS convoluted.

That's unfortunate result of how the pkgconfig tool works. By now it is
even too late to complain to the tool author because it's been like that
forever, best bet is to to use it as is or pick a different tool for
configuration.

> > > I do not know why you parsed kmod.pc instead of libkmod.pc [2]
> >
> > Because it's kmod property, not libkmod property.
> >
> > Distributions would install libkmod.pc only with development files
> > whereas the kmod.pc should be installed with the binaries.
> 
> 
> This is up to the kmod maintainer.
> 
> If they agree, I do not mind where the configuration comes from.

So far it has not been commented on. Maybe it's time for a ping.

Thanks

Michal

> > > [1] https://lore.kernel.org/linux-kbuild/20230718120348.383-1-msuchanek@suse.de/
> > > [2] https://github.com/kmod-project/kmod/blob/v31/configure.ac#L295
