Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C817B80C074
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjLKE3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjLKE3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:29:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20898EB
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:29:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD1FC433CC;
        Mon, 11 Dec 2023 04:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702268992;
        bh=CBIN7qE+dliGQVl5j5og6YUs6cyR0Ka0T/R9rGOhhVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YJv6n4JYKDZbZnL1IZinNVmq91C5KWjElFWNCAMnFteZnZR+1IGy8rrTFCmWF48g8
         0YdpQloW7HStuQfhuaeHBUdVtwQQEyo9bY36scNvK1S2GQzn3c9QFHZGMSHJYyiVjC
         aUKwIreqnm3T+MySdXu76jR3gS77mEkhhcXtlM5icazEt0XmshYBi0dF3esHVS+iFe
         +5CdMIrz18pZhkaJBUgQEqYMH0SccaVdJKcYaKD0ybYdn++f7aqWWVsZuR3NuXRIs7
         aDay/IHReIFpMd085N7jEafs3LNPioUp1iBS+IU5IQ/SZkhpddzhqAR/tG3JVnQGmL
         xx00cVIEiHM2A==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3ba0d0a72dfso171163b6e.1;
        Sun, 10 Dec 2023 20:29:52 -0800 (PST)
X-Gm-Message-State: AOJu0Yx8nDfcbv7S6eKKuBT0TDkwr1EWsTLP5h+gneDc3QaJHLt8ADNH
        JPCdZkbizvEjXxp+aGJiT3XmNsAin6oIAh3HehQ=
X-Google-Smtp-Source: AGHT+IEOX0jnWks1g0k+Zt/cEjYn+4cUPwnz76bRXZqIopiPcD+b8yFe56H204dHreTXrcJSkvmn2T/ICtNqhrWJKLw=
X-Received: by 2002:a05:6808:190a:b0:3b9:e87b:a72f with SMTP id
 bf10-20020a056808190a00b003b9e87ba72fmr2676335oib.25.1702268991724; Sun, 10
 Dec 2023 20:29:51 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAT3N82cJD3GsF+yUBEfPNOBkhzYPk37q3k0HdU7ukz9vQ@mail.gmail.com>
 <32b332af189bfca8acdb231cee294355aa4af290.1701892062.git.msuchanek@suse.de>
 <CAK7LNATPF7baHLXZVgzz=6zOhLx8maX0r0EU3DBFwAEZ6kCeww@mail.gmail.com> <20231210210748.GM9696@kitsune.suse.cz>
In-Reply-To: <20231210210748.GM9696@kitsune.suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 11 Dec 2023 13:29:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQQe-fdeKe2RHd5TyYpXa95WJO_-f38o12oewGC3rFTHA@mail.gmail.com>
Message-ID: <CAK7LNAQQe-fdeKe2RHd5TyYpXa95WJO_-f38o12oewGC3rFTHA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] depmod: Handle installing modules under a
 different directory
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 6:07=E2=80=AFAM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:
>
> Hello!
>
> On Mon, Dec 11, 2023 at 03:43:44AM +0900, Masahiro Yamada wrote:
> > On Thu, Dec 7, 2023 at 4:48=E2=80=AFAM Michal Suchanek <msuchanek@suse.=
de> wrote:
> > >
> > > Some distributions aim at shipping all files in /usr.
> > >
> > > The path under which kernel modules are installed is hardcoded to /li=
b
> > > which conflicts with this goal.
> > >
> > > When kmod provides kmod.pc, use it to determine the correct module
> > > installation path.
> > >
> > > With kmod that does not provide the config /lib/modules is used as
> > > before.
> > >
> > > While pkg-config does not return an error when a variable does not ex=
ist
> > > the kmod configure script puts some effort into ensuring that
> > > module_directory is non-empty. With that empty module_directory from
> > > pkg-config can be used to detect absence of the variable.
> > >
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > > v6:
> > >  - use ?=3D instead of :=3D to make it easier to override the value
> >
> >
> > "KERNEL_MODULE_DIRECTORY=3D/local/usr/lib/modules make modules_install"
> > will override the install destination, but
> > depmod will not be not aware of it.
>
> At the same time if you know what you are doing you can build a src rpm
> for another system that uses a different location.
>
> > How to avoid the depmod error?
>
> Not override the variable?




You are not answering my question.


You intentionally changed :=3D to ?=3D.

This implies that KERNEL_MODULE_DIRECTORY is an interface to users,
and should be documented in Documentation/kbuild/kbuild.rst


However, it never works if it is overridden from the env variable
or make command line because there is no way to let depmod know
the fact that KERNEL_MODULE_DIRECTORY has been overridden.



In my understanding, depmod does not provide an option to
specify the module directory from a command line option, does it?
If not, is it reasonable to add a new option to depmod?


depmod provides the "-b basedir" option, but it only allows
adding a prefix to the default "/lib/modules/<version>".

(My original idea to provide the prefix_part, it would have worked
like  -b "${INSTALL_MOD_PATH}${MOD_PREFIX}", which you refused)




















> Thanks
>
> Michal
>
> > >  - use shorter expression for determining the module directory assumi=
ng
> > >    it's non-empty
> > > ---
> > >  Makefile | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 511b5616aa41..84f32bd563d4 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1081,7 +1081,9 @@ export INSTALL_DTBS_PATH ?=3D $(INSTALL_PATH)/d=
tbs/$(KERNELRELEASE)
> > >  # makefile but the argument can be passed to make if needed.
> > >  #
> > >
> > > -MODLIB =3D $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> > > +export KERNEL_MODULE_DIRECTORY ?=3D $(or $(shell pkg-config --variab=
le=3Dmodule_directory kmod 2>/dev/null),/lib/modules)
> > > +
> > > +MODLIB =3D $(INSTALL_MOD_PATH)$(KERNEL_MODULE_DIRECTORY)/$(KERNELREL=
EASE)
> > >  export MODLIB
> > >
> > >  PHONY +=3D prepare0
> > > --
> > > 2.42.0
> > >
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>


--=20
Best Regards
Masahiro Yamada
