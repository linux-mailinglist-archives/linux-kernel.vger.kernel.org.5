Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D78B756CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGQTOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjGQTOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:14:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0E1197;
        Mon, 17 Jul 2023 12:14:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E255061214;
        Mon, 17 Jul 2023 19:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DC6C433C9;
        Mon, 17 Jul 2023 19:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689621275;
        bh=Nvlf8KPWX09HX4QhaMf3lS/xufvdWYYCeaHJJ535AB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R6QF7096V1fLqpcSLGWX4f5cWKpOKetDz4bGI37ahqzUPY0lXXbjr8QYgBMrpxjH/
         7ZsGpzQylnDWV7tyKzS1CZO03keOD0Puyn+5vdBDIADzii2xk8QIx6t2/oEyVXygIg
         gRfM9+99BuN7+Ox08+DIqVP/PHq1pxUJWyEOe7UwrKS8JP2aIbQ3fmaUWUcUljgCSR
         V1Qfrum+LK88I4b75FUPzvuCr1Ne5DYvXEzL3+QcBXjtNZBtBA5DxXM/5RcjkIUQy7
         h4PKy++Ld9CiM47fLBm3sUv7JzgQLbmyIjLxBSjvMmOveKsGTdEPkFMijTyToOUn9j
         NCUpbOzO8o8EA==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6b9b835d302so2058177a34.1;
        Mon, 17 Jul 2023 12:14:35 -0700 (PDT)
X-Gm-Message-State: ABy/qLadgHP0Dolco0qjs5bonuhjSuJamt6tVZUgdo65gDCrwHyWZ8eh
        52MivOJLu7TiAP7jYzsJhhpTr5lwrdYkhbKZuHY=
X-Google-Smtp-Source: APBJJlGl4Y/4hnWobKnAC8fm03tvVl16enrfTelg1VaubIudF38fTQZ9F6V3aDi1IoaOJtepJqg1kU+Y2XsqHPWogb0=
X-Received: by 2002:aca:bb87:0:b0:3a4:5063:dd94 with SMTP id
 l129-20020acabb87000000b003a45063dd94mr4133939oif.42.1689621274550; Mon, 17
 Jul 2023 12:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230714143002.GL9196@kitsune.suse.cz> <ZLFhuf95srX2wvJc@fjasle.eu>
In-Reply-To: <ZLFhuf95srX2wvJc@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 18 Jul 2023 04:13:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQMs3QBYfWcLkmOQdbbq7cj=7wWbK=AWhdTC2rAsKHXzQ@mail.gmail.com>
Message-ID: <CAK7LNAQMs3QBYfWcLkmOQdbbq7cj=7wWbK=AWhdTC2rAsKHXzQ@mail.gmail.com>
Subject: Re: [PATCH v3] depmod: Handle installing modules under a prefix
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     =?UTF-8?Q?Michal_Such=EF=BF=BDnek?= <msuchanek@suse.de>,
        linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?B?TWljaGFsIEtvdXRu77+9?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 11:55=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu>=
 wrote:
>
> On Fri, Jul 14, 2023 at 04:30:02PM +0200, Michal Such=EF=BF=BDnek wrote:
> > Hello,
> >
> > On Fri, Jul 14, 2023 at 04:05:10PM +0200, Nicolas Schier wrote:
> > > On Fri, Jul 14, 2023 at 02:21:08PM +0200 Michal Suchanek wrote:
> > > > Some distributions aim at not shipping any files in / outside of us=
r.
> > >
> > > For me, preventing negation often makes things easier, e.g.: "... aim=
 at
> > > shipping files only below /usr".
> > >
> > > >
> > > > The path under which kernel modules are installed is hardcoded to /=
lib
> > > > which conflicts with this goal.
> > > >
> > > > When kmod provides the config command, use it to determine the corr=
ect
> > > > module installation prefix.
> > > >
> > > > This is a prefix under which the modules are searched by kmod on th=
e
> > > > system, and is separate from the temporary staging location already
> > > > supported by INSTALL_MOD_PATH.
> > > >
> > > > With kmod that does not provide the config command empty prefix is =
used
> > > > as before.
> > > >
> > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > ---
> > > > v2: Avoid error on systems with kmod that does not support config
> > > > command
> > > > v3: More verbose commit message
> > > > ---
> > > >  Makefile          | 4 +++-
> > > >  scripts/depmod.sh | 8 ++++----
> > > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/Makefile b/Makefile
> > > > index 47690c28456a..b1fea135bdec 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?=3D $(INSTALL_PATH)=
/dtbs/$(KERNELRELEASE)
> > > >  # makefile but the argument can be passed to make if needed.
> > > >  #
> > > >
> > > > -MODLIB   =3D $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> > > > +export KERNEL_MODULE_PREFIX :=3D $(shell kmod config &> /dev/null =
&& kmod config | jq -r .module_prefix)
> > >
> > > All other calls of `jq` that I could find are located at tools/; as t=
his here
> > > is evaluated on each invocation, this should probably be documented i=
n
> > > Documentation/process/changes.rst?
> > >
> > > (Absence of `jq` will cause error messages, even with CONFIG_MODULES=
=3Dn.)
> >
> > That's a good point.
> >
> > >
> > > > +
> > > > +MODLIB   =3D $(INSTALL_MOD_PATH)$(KERNEL_MODULE_PREFIX)/lib/module=
s/$(KERNELRELEASE)
> > > >  export MODLIB
> > > >
> > > >  PHONY +=3D prepare0
> > > > diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> > > > index 3643b4f896ed..88ac79056153 100755
> > > > --- a/scripts/depmod.sh
> > > > +++ b/scripts/depmod.sh
> > > > @@ -27,16 +27,16 @@ fi
> > > >  # numbers, so we cheat with a symlink here
> > > >  depmod_hack_needed=3Dtrue
> > > >  tmp_dir=3D$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
> > > > -mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
> > > > +mkdir -p "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE=
"
> > > >  if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
> > > > - if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
> > > > -         -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin";=
 then
> > > > + if test -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELE=
ASE/modules.dep" -o \
> > > > +         -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELE=
ASE/modules.dep.bin"; then
> > > >           depmod_hack_needed=3Dfalse
> > > >   fi
> > > >  fi
> > >
> > > I'd like to come back to the statement from Masahiro: Is the check ab=
ove,
> > > against some very old versions of depmod [1], the only reason for thi=
s patch?
> > >
> > > If we could remove that, would
> > >
> > >     make INSTALL_MOD_PATH=3D"$(kmod config | jq -r .module_prefix)" m=
odules_install
> > >
> > > be sufficient?
> >
> > No, the INSTALL_MOD_PATH is passed as the -b argument to depmod while
> > the newly added part is not because it's integral part of where the
> > modules are installed on the system, and not the staging area path.
>
> Ah, thanks.  So just for my understanding, could this be a (non-gentle)
> alternative version of your patch, w/o modifying top-level Makefile?
>
> diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> index 3643b4f896ed..72c819de0669 100755
> --- a/scripts/depmod.sh
> +++ b/scripts/depmod.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # A depmod wrapper used by the toplevel Makefile
> @@ -23,6 +23,8 @@ if [ -z $(command -v $DEPMOD) ]; then
>         exit 0
>  fi
>
> +kmod_version=3D$(( $(kmod --version | sed -rne 's/^kmod version ([0-9]+)=
.*$/\1/p') ))
> +
>  # older versions of depmod require the version string to start with thre=
e
>  # numbers, so we cheat with a symlink here
>  depmod_hack_needed=3Dtrue
> @@ -35,6 +37,13 @@ if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null;=
 then
>         fi
>  fi
>  rm -rf "$tmp_dir"
> +
> +if [ "${kmod_version}" -gt 32 ]; then
> +       kmod_prefix=3D"$(kmod config | jq -r .module_prefix)"
> +       INSTALL_MOD_PATH=3D"${INSTALL_MOD_PATH#${kmod_prefix}"
> +       depmod_hack_needed=3Dfalse
> +fi
> +
>  if $depmod_hack_needed; then
>         symlink=3D"$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
>         ln -s "$KERNELRELEASE" "$symlink"
>
> (untested, and assuming that kmod module prefix is in kmod >=3D 32)
>
> Or are I am still missing something?
>
> > Was busybox ever fixed to not require the hack?
>
> I haven't checked that, yet.



I believe we can revert

8fc62e59425389a6d48429b9d146223122743435
bfe5424a8b31624e7a476f959d552999f931e7c7

There is no good reason to keep such old hacky code.


The old module-init-tools project was replaced by kmod.
I do not know whether busybox fixed the issue or not.
Anyway, Linux 3.0 was released 12 years ago.
There was plenty of time to fix the issue if we wanted.
If busybox is still not able to handle the X.Y version form,
it is just that nobody is caring about the busybox's depmod.




--
Best Regards
Masahiro Yamada
