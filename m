Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF37D757B97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjGRMPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjGRMPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:15:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448DBBD;
        Tue, 18 Jul 2023 05:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AACF961558;
        Tue, 18 Jul 2023 12:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DEAC433C9;
        Tue, 18 Jul 2023 12:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689682501;
        bh=TkVJlTH+bMv6rkUmEXbgkhA1PsYI6+yfqXQnIiTGTa8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AfVhSnnmeVSu3nkJvFzzbXx0+CG9bDoUELNgjGr0xxbyl/BKVRP0rWJsV0ZUQYcby
         4F/W/NwVXaNcKm67fZ1ET2InIVEkOGA6UBQ14g2a7oe5s0sXAB2mcjbK1AnP7lfQwz
         twH0w9y2JezNZUPIFWGZQcyx++XFgQThmSm1MTp9eEQAeImgY4y5f+TQXNgFd4gpSW
         v9lrG3vBaHOjdeuhBZWQIbKFmpg6lBPw6oQSNPENaqzyDofc9K/unz0k9p9AjA2PEk
         NazPRpfwFpYxFmx4wJUbAXuPDWKp2rGaL7H11XZdV67ZmVRKJQrb5va+wS07LUPSo0
         2oTroehkl2liA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5634d8d1db0so3464696eaf.0;
        Tue, 18 Jul 2023 05:15:01 -0700 (PDT)
X-Gm-Message-State: ABy/qLaoF3O9EMx97oXnb4c4ZjVFiYwlb0v7R4EsxWQLXsEUUjMgMk3e
        P5wl3bsaYbg88yRM4ihpSz35hRyXsItHkvpvGfM=
X-Google-Smtp-Source: APBJJlHimf49c7Ljskkf5L4vvtXhO+nP+wtEpYYtsp4H5GBpO3MawJwHZUR0wl409dtYN3n7KIuka9EwbX3vSNq/Q2o=
X-Received: by 2002:a05:6808:120c:b0:3a3:ed69:331 with SMTP id
 a12-20020a056808120c00b003a3ed690331mr17321286oil.6.1689682500378; Tue, 18
 Jul 2023 05:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689681454.git.msuchanek@suse.de> <20230718120348.383-1-msuchanek@suse.de>
In-Reply-To: <20230718120348.383-1-msuchanek@suse.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 18 Jul 2023 21:14:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQopEkzYH9_urDxU9i060GDgtXYWWxTsRikxfYxxLCOxQ@mail.gmail.com>
Message-ID: <CAK7LNAQopEkzYH9_urDxU9i060GDgtXYWWxTsRikxfYxxLCOxQ@mail.gmail.com>
Subject: Re: [PATCH v5] depmod: Handle installing modules under a prefix
To:     Michal Suchanek <msuchanek@suse.de>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 9:03=E2=80=AFPM Michal Suchanek <msuchanek@suse.de>=
 wrote:
>
> Some distributions aim at shipping all files in /usr.
>
> The path under which kernel modules are installed is hardcoded to /lib
> which conflicts with this goal.
>
> When kmod provides the config command, use it to determine the correct
> module installation path.
>
> With kmod that does not provide the config command /lib/modules is used
> as before.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v2: Avoid error on systems with kmod that does not support config
> command
> v3: More verbose commit message
> v4:
>   - Document jq requirement
>   - fix bashism
>   - Update to getting full module path, not just additional prefix
> v5: switch to pkgconfig
> ---
>  Makefile          | 4 +++-
>  scripts/depmod.sh | 8 ++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 47690c28456a..1620d224ad9c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?=3D $(INSTALL_PATH)/dtbs/=
$(KERNELRELEASE)
>  # makefile but the argument can be passed to make if needed.
>  #
>
> -MODLIB =3D $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> +export KERNEL_MODULE_DIRECTORY :=3D $(shell pkg-config --print-variables=
 kmod 2>/dev/null | grep '^module_directory$$' >/dev/null && pkg-config --v=
ariable=3Dmodule_directory kmod || echo /lib/modules)

As I replied in another thread, Kbuild already provides
the max flexibility.

Please do not send this any more. NACK.









> +
> +MODLIB =3D $(INSTALL_MOD_PATH)$(KERNEL_MODULE_DIRECTORY)/$(KERNELRELEASE=
)
>  export MODLIB
>
>  PHONY +=3D prepare0
> diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> index 3643b4f896ed..06961f990fcb 100755
> --- a/scripts/depmod.sh
> +++ b/scripts/depmod.sh
> @@ -27,16 +27,16 @@ fi
>  # numbers, so we cheat with a symlink here
>  depmod_hack_needed=3Dtrue
>  tmp_dir=3D$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
> -mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
> +mkdir -p "$tmp_dir$KERNEL_MODULE_DIRECTORY/$KERNELRELEASE"
>  if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
> -       if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
> -               -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin";=
 then
> +       if test -e "$tmp_dir$KERNEL_MODULE_DIRECTORY/$KERNELRELEASE/modul=
es.dep" -o \
> +               -e "$tmp_dir$KERNEL_MODULE_DIRECTORY/$KERNELRELEASE/modul=
es.dep.bin"; then
>                 depmod_hack_needed=3Dfalse
>         fi
>  fi
>  rm -rf "$tmp_dir"
>  if $depmod_hack_needed; then
> -       symlink=3D"$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
> +       symlink=3D"$INSTALL_MOD_PATH$KERNEL_MODULE_DIRECTORY/99.98.$KERNE=
LRELEASE"
>         ln -s "$KERNELRELEASE" "$symlink"
>         KERNELRELEASE=3D99.98.$KERNELRELEASE
>  fi
> --
> 2.41.0
>


--=20
Best Regards
Masahiro Yamada
