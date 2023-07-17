Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4970F756CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGQTO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjGQTOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:14:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30131B5;
        Mon, 17 Jul 2023 12:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F60A6121D;
        Mon, 17 Jul 2023 19:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4496C433C7;
        Mon, 17 Jul 2023 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689621288;
        bh=OsEawghtwBT7iv0WttprK9jGHSbrsVJ0XtLmVa+47/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ujy8hekg6gGk+ORsAunzZjMH1evFq4VFlhQ1JqC+2nc/JTFmOfQnH8NnX2ri1e40c
         XCem618cdbTu7xyYob4gbLyo1Cf5tZ4PCm2KOU3ZWhS0RgDGw8syDe4HggMFUzIl7p
         AuKDXGshC/7qciwLpXQuBC7z+bLjbg3TvTufZSbpqOg1+p7eaxE4+EUJObPXZSsL77
         ofL3CNNWRuQvcBEXNQYUAMd6bM2mXZkNeAf2xXcU23gJgl+19yel0MoTd71siVWRd9
         YwSV7YwYKok/FnO7FkUFpsyaoSXQOLgfrhYXZgbZZJs0I/VInIEFdSolplXCkS/7gy
         u2POxeRliOLDw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1b049163c93so2795368fac.3;
        Mon, 17 Jul 2023 12:14:48 -0700 (PDT)
X-Gm-Message-State: ABy/qLa7wvD5gCCBNtaLsqcoX/M7IaT5IMEpcI/KKc9LxqanPb1bpb4D
        rGdZWskD6XxXTx6kny//VAlTj+UKr8HSk2Bdy1g=
X-Google-Smtp-Source: APBJJlH6NZCJ9oRuhP0V6/+A3u2H7rn26xv1pJBweo7s2CHk2YNizjdiUUZafW1Zk2zUiQljdqsO4vmxxwdsl8iKg4k=
X-Received: by 2002:a05:6870:2197:b0:195:f0bb:959e with SMTP id
 l23-20020a056870219700b00195f0bb959emr13676591oae.50.1689621288074; Mon, 17
 Jul 2023 12:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230714143002.GL9196@kitsune.suse.cz> <ZLFhuf95srX2wvJc@fjasle.eu>
 <20230714151042.GN9196@kitsune.suse.cz>
In-Reply-To: <20230714151042.GN9196@kitsune.suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 18 Jul 2023 04:14:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT6mQ0EpwmKUCBhv9Acaf_qyGq4hu=XvSWRuZ-pNAFWVw@mail.gmail.com>
Message-ID: <CAK7LNAT6mQ0EpwmKUCBhv9Acaf_qyGq4hu=XvSWRuZ-pNAFWVw@mail.gmail.com>
Subject: Re: [PATCH v3] depmod: Handle installing modules under a prefix
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Nicolas Schier <nicolas@fjasle.eu>, linux-modules@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
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

On Sat, Jul 15, 2023 at 12:10=E2=80=AFAM Michal Such=C3=A1nek <msuchanek@su=
se.de> wrote:
>
> On Fri, Jul 14, 2023 at 04:54:49PM +0200, Nicolas Schier wrote:
> > On Fri, Jul 14, 2023 at 04:30:02PM +0200, Michal Such=EF=BF=BDnek wrote=
:
> > > Hello,
> > >
> > > On Fri, Jul 14, 2023 at 04:05:10PM +0200, Nicolas Schier wrote:
> > > > On Fri, Jul 14, 2023 at 02:21:08PM +0200 Michal Suchanek wrote:
> > > > > Some distributions aim at not shipping any files in / outside of =
usr.
> > > >
> > > > For me, preventing negation often makes things easier, e.g.: "... a=
im at
> > > > shipping files only below /usr".
> > > >
> > > > >
> > > > > The path under which kernel modules are installed is hardcoded to=
 /lib
> > > > > which conflicts with this goal.
> > > > >
> > > > > When kmod provides the config command, use it to determine the co=
rrect
> > > > > module installation prefix.
> > > > >
> > > > > This is a prefix under which the modules are searched by kmod on =
the
> > > > > system, and is separate from the temporary staging location alrea=
dy
> > > > > supported by INSTALL_MOD_PATH.
> > > > >
> > > > > With kmod that does not provide the config command empty prefix i=
s used
> > > > > as before.
> > > > >
> > > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > > ---
> > > > > v2: Avoid error on systems with kmod that does not support config
> > > > > command
> > > > > v3: More verbose commit message
> > > > > ---
> > > > >  Makefile          | 4 +++-
> > > > >  scripts/depmod.sh | 8 ++++----
> > > > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/Makefile b/Makefile
> > > > > index 47690c28456a..b1fea135bdec 100644
> > > > > --- a/Makefile
> > > > > +++ b/Makefile
> > > > > @@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?=3D $(INSTALL_PAT=
H)/dtbs/$(KERNELRELEASE)
> > > > >  # makefile but the argument can be passed to make if needed.
> > > > >  #
> > > > >
> > > > > -MODLIB =3D $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> > > > > +export KERNEL_MODULE_PREFIX :=3D $(shell kmod config &> /dev/nul=
l && kmod config | jq -r .module_prefix)
> > > >
> > > > All other calls of `jq` that I could find are located at tools/; as=
 this here
> > > > is evaluated on each invocation, this should probably be documented=
 in
> > > > Documentation/process/changes.rst?
> > > >
> > > > (Absence of `jq` will cause error messages, even with CONFIG_MODULE=
S=3Dn.)
> > >
> > > That's a good point.
> > >
> > > >
> > > > > +
> > > > > +MODLIB =3D $(INSTALL_MOD_PATH)$(KERNEL_MODULE_PREFIX)/lib/module=
s/$(KERNELRELEASE)
> > > > >  export MODLIB
> > > > >
> > > > >  PHONY +=3D prepare0
> > > > > diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> > > > > index 3643b4f896ed..88ac79056153 100755
> > > > > --- a/scripts/depmod.sh
> > > > > +++ b/scripts/depmod.sh
> > > > > @@ -27,16 +27,16 @@ fi
> > > > >  # numbers, so we cheat with a symlink here
> > > > >  depmod_hack_needed=3Dtrue
> > > > >  tmp_dir=3D$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
> > > > > -mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
> > > > > +mkdir -p "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEA=
SE"
> > > > >  if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
> > > > > -       if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.d=
ep" -o \
> > > > > -               -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.d=
ep.bin"; then
> > > > > +       if test -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KE=
RNELRELEASE/modules.dep" -o \
> > > > > +               -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KE=
RNELRELEASE/modules.dep.bin"; then
> > > > >                 depmod_hack_needed=3Dfalse
> > > > >         fi
> > > > >  fi
> > > >
> > > > I'd like to come back to the statement from Masahiro: Is the check =
above,
> > > > against some very old versions of depmod [1], the only reason for t=
his patch?
> > > >
> > > > If we could remove that, would
> > > >
> > > >     make INSTALL_MOD_PATH=3D"$(kmod config | jq -r .module_prefix)"=
 modules_install
> > > >
> > > > be sufficient?
> > >
> > > No, the INSTALL_MOD_PATH is passed as the -b argument to depmod while
> > > the newly added part is not because it's integral part of where the
> > > modules are installed on the system, and not the staging area path.
> >
> > Ah, thanks.  So just for my understanding, could this be a (non-gentle)
> > alternative version of your patch, w/o modifying top-level Makefile?
> >
> > diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> > index 3643b4f896ed..72c819de0669 100755
> > --- a/scripts/depmod.sh
> > +++ b/scripts/depmod.sh
> > @@ -1,4 +1,4 @@
> > -#!/bin/sh
> > +#!/bin/bash
> >  # SPDX-License-Identifier: GPL-2.0
> >  #
> >  # A depmod wrapper used by the toplevel Makefile
> > @@ -23,6 +23,8 @@ if [ -z $(command -v $DEPMOD) ]; then
> >         exit 0
> >  fi
> >
> > +kmod_version=3D$(( $(kmod --version | sed -rne 's/^kmod version ([0-9]=
+).*$/\1/p') ))
> > +
> >  # older versions of depmod require the version string to start with th=
ree
> >  # numbers, so we cheat with a symlink here
> >  depmod_hack_needed=3Dtrue
> > @@ -35,6 +37,13 @@ if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/nul=
l; then
> >         fi
> >  fi
> >  rm -rf "$tmp_dir"
> > +
> > +if [ "${kmod_version}" -gt 32 ]; then
> > +       kmod_prefix=3D"$(kmod config | jq -r .module_prefix)"
> > +       INSTALL_MOD_PATH=3D"${INSTALL_MOD_PATH#${kmod_prefix}"
> > +       depmod_hack_needed=3Dfalse
> > +fi
> > +
> >  if $depmod_hack_needed; then
> >         symlink=3D"$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
> >         ln -s "$KERNELRELEASE" "$symlink"
> >
> > (untested, and assuming that kmod module prefix is in kmod >=3D 32)
>
> It can be detected by running the 'kmod config' command first and
> ignoring the output when it fails which the above patch already did.
> The version check does not sound very reliable.
>
> > Or are I am still missing something?
>
> MODLIB still needs to include the extra prefix so that files are
> installed in the correct location. And that's defined in the toplevel
> Makefile.
>
> Thanks
>
> Michal



As Documentation/kbuild/kbuild.rst mentions,
you can override MODLIB.

Kbuild already provides the maximum flexibility.


$ make modules_install \
  INSTALL_MOD_PATH=3D/path/to/whatever/staging/dir \
  MODLIB=3D/path/to/whatever/real/install/destination



--=20
Best Regards
Masahiro Yamada
