Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79D47CC724
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbjJQPLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344221AbjJQPK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:10:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914B612A;
        Tue, 17 Oct 2023 08:10:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5CD661F889;
        Tue, 17 Oct 2023 15:10:53 +0000 (UTC)
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 376892D450;
        Tue, 17 Oct 2023 15:10:52 +0000 (UTC)
Date:   Tue, 17 Oct 2023 17:10:50 +0200
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
Message-ID: <20231017151050.GJ6241@kitsune.suse.cz>
References: <20231009085208.GT6241@kitsune.suse.cz>
 <CAK7LNASeMEKVi5c0PEow5KSdN7rsm7UYEf2smWOSkYOhr_5fVQ@mail.gmail.com>
 <20231009140733.GV6241@kitsune.suse.cz>
 <CAK7LNAQQMFUt4R1m_U8kBY5=BvxD_dMuE4MD4kpd48WK1E+AGA@mail.gmail.com>
 <20231010101552.GW6241@kitsune.suse.cz>
 <CAK7LNASX2_-xt3Qvxie_G=Q4fuVYR6eE47QjQ5NZf7QxY-4_tQ@mail.gmail.com>
 <20231017104453.GG6241@kitsune.suse.cz>
 <CAK7LNASKPg0JK0QsLGb1Rfx2ysvHJTm3NFOvtwOpZRz4-20T8w@mail.gmail.com>
 <20231017122747.GH6241@kitsune.suse.cz>
 <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         TAGGED_RCPT(0.00)[];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 5CD661F889
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 11:46:45PM +0900, Masahiro Yamada wrote:
> On Tue, Oct 17, 2023 at 9:27 PM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > On Tue, Oct 17, 2023 at 09:05:29PM +0900, Masahiro Yamada wrote:
> > > On Tue, Oct 17, 2023 at 7:44 PM Michal Suchánek <msuchanek@suse.de> wrote:
> > > >
> > > > On Tue, Oct 17, 2023 at 07:15:50PM +0900, Masahiro Yamada wrote:

> > > > > If MOD_PREFIX is given from an env variable or from the command line,
> > > > > it is respected.
> > > > >
> > > > > If "pkg-config --variable=module_prefix libkmod" works,
> > > > > that configuration is applied.
> > > > >
> > > > > Otherwise, MOD_PREFIX is empty, i.e. fall back to the current behavior.
> > > > >
> > > > >
> > > > > I prefer 'MOD_PREFIX' to 'KERNEL_MODULE_DIRECTORY' in your patch [1]
> > > > > because "|| echo /lib/modules" can be omitted.
> > > > >
> > > > > I do not think we will have such a crazy distro that
> > > > > installs modules under /opt/ directory.
> > > >
> > > > However, I can easily imagine a distribution that would want to put
> > > > modules in /usr/lib-amd64-linux/modules.
> > >
> > >
> > > Sorry, it is not easy for me.
> > >
> > > What is the background of your thought?
> >
> > That's where every other library and module would go on distributions
> > that care about ability to install packages for multiple architectures
> > at the same time. AFAIK the workaround is to inclclude the CPU
> > architecture in extraversion for the kernel to fit.
> 
> 
> In my system (Ubuntu), I see the directory paths
> 
> /usr/aarch64-linux-gnu/lib/
> /usr/i686-linux-gnu/lib/
> /usr/x86_64-linux-gnu/lib/
> 
> If there were such a crazy distro that supports multiple kernel arches
> within a single image, modules might be installed:
> /usr/x86_64-linux-gnu/lib/module/<version>/

For me it's /usr/lib/i386-linux-gnu/.

Did they change the scheme at some point?

> > > >
> > > > > I could not understand why you inserted
> > > > > "--print-variables kmod 2>/dev/null | grep '^module_directory$$' >/dev/null"
> > > > > but I guess the reason is the same.
> > > > > "pkg-config --variable=module_directory kmod" always succeeds,
> > > > > so "|| echo /lib/modules" is never processed.
> > > >
> > > > Yes, that's the semantics of the tool. The jq version was slightly less
> > > > convoluted but required additional tool for building the kernel.
> > >
> > >
> > > It IS convoluted.
> >
> > That's unfortunate result of how the pkgconfig tool works. By now it is
> > even too late to complain to the tool author because it's been like that
> > forever, best bet is to to use it as is or pick a different tool for
> > configuration.
> 
> "pkg-config --variable=<name>" returns its value.
> It is pretty simple, and I do not think it is a big problem.
> 
> Your code is long, but the reason is that you implemented
> it in that way.
> 
> 
> If you go with KERNEL_MODULE_DIRECTORY for max flexibility,
> 
>   KERNEL_MODULE_DIRECTORY := $(or $(shell pkg-config
> --variable=module_directory kmod 2>/dev/null),/lib/modules)
> 
> should work with less characters and less process forks.

And assumes that the module_directory cannot be empty.

Which may or may not be a reasonable assumption, the script as proposed
in the patch does not rely on it.

> But, now I started to prefer confining the long code
> into the shell script, "scripts/modinst-dir",
> and calling it where needed.

That's also an option.

Thanks

Michal

> > > > > [1] https://lore.kernel.org/linux-kbuild/20230718120348.383-1-msuchanek@suse.de/
> > > > > [2] https://github.com/kmod-project/kmod/blob/v31/configure.ac#L295
