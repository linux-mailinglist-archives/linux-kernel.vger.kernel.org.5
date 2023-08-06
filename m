Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D57771689
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 21:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjHFTcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 15:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFTct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 15:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F1F1719
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 12:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 970E56124E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8D6C433CD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691350367;
        bh=tL8iT6yeYppDtj3cEPICVF2UPLS5piCRnt0rmZLqSsk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g1V+aTwh1U+cynygIW1yPoFwy+NovY0OS1id8gIILY4RGzNVyI+apveAhEsBDtBQZ
         ok2yEQMNneDNLfloX5bx3uO0PDMVwGuNJfQpb1VsP7Q3jkVUb4jKKPDswheQCIOmbm
         JlC+ZMyK4Ist50rGKaDFz9kwUtc+WcXt8y0U+WXYBVhSvvtq5S7wV+8/gdEpsqbvuF
         FYJGXc2dawlqMzTso/4O6eYUBMwiEsM6fDbqu6g0HXpTd3M5Hw6z6gYqRAqb0EChKq
         n9p16WnOiu3sb65OOgTJzi6RN5fw2ogXxLQBJC7lePXRw+/EFw2bgcJNhPpmAcr1Ig
         UPJXvKpazDT2Q==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-56cb1e602e7so2307801eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 12:32:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YzIGOQVnBE3ne8FqIqzEeiQHcEYVQEi+4JDaYQ/LaxhoQJwCpGW
        nKvQXhcrv+8Qa7HpK+K0bRYducO1vcsrjCRrXWA=
X-Google-Smtp-Source: AGHT+IHH+OemTD5DsV/J8N+9wh/Cmrq+yT3qX4nZhGT4pKLNXaJJqDAl7Jku2IE3pEIGPIweYRxC54w4ADgjOFBq8Kg=
X-Received: by 2002:a4a:3018:0:b0:56c:7428:4a35 with SMTP id
 q24-20020a4a3018000000b0056c74284a35mr5760880oof.7.1691350366127; Sun, 06 Aug
 2023 12:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230623145358.568971-1-yesshedi@gmail.com> <20230623145358.568971-9-yesshedi@gmail.com>
In-Reply-To: <20230623145358.568971-9-yesshedi@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 7 Aug 2023 04:32:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNARnuaOi-GwW0qnFgH5styuUTtmjSNWV92PEO6VgpqNvQg@mail.gmail.com>
Message-ID: <CAK7LNARnuaOi-GwW0qnFgH5styuUTtmjSNWV92PEO6VgpqNvQg@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] kbuild: modinst: do modules_install step by step
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:54=E2=80=AFPM Shreenidhi Shedi <yesshedi@gmail.c=
om> wrote:
>
> Currently Makefile.modinst does three tasks on each module built:
> - Install modules
> - Sign modules
> - Compress modules
>
> All the above tasks happen from a single place.
>
> This patch divides this task further and uses a different makefile for
> each task.
> Signing module logic is completely refactored and everything happens
> from a shell script now.
>
> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>


This patch is bad in multiple ways.

1. Break "make modules_sign"
2.   Serialize the installation steps, that is, works less efficiently
3.   Increase code without adding any benefits.


There is no good reason to do these changes.

NACK.





> ---
>  scripts/Makefile.compress |  53 ++++++++++++++++++
>  scripts/Makefile.install  |  66 +++++++++++++++++++++++
>  scripts/Makefile.modinst  | 111 +++-----------------------------------
>  scripts/Makefile.sign     |  37 +++++++++++++
>  scripts/signfile.sh       |  24 +++++++++
>  5 files changed, 186 insertions(+), 105 deletions(-)
>  create mode 100644 scripts/Makefile.compress
>  create mode 100644 scripts/Makefile.install
>  create mode 100644 scripts/Makefile.sign
>  create mode 100755 scripts/signfile.sh
>
> diff --git a/scripts/Makefile.compress b/scripts/Makefile.compress
> new file mode 100644
> index 000000000000..35d337ac9b6c
> --- /dev/null
> +++ b/scripts/Makefile.compress
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +# Compressing modules
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +PHONY :=3D __modcompress
> +__modcompress:
> +
> +include include/config/auto.conf
> +include $(srctree)/scripts/Kbuild.include
> +
> +modules :=3D $(call read-file, $(MODORDER))
> +
> +ifeq ($(KBUILD_EXTMOD),)
> +dst :=3D $(MODLIB)/kernel
> +else
> +INSTALL_MOD_DIR ?=3D updates
> +dst :=3D $(MODLIB)/$(INSTALL_MOD_DIR)
> +endif
> +
> +suffix-y                               :=3D
> +suffix-$(CONFIG_MODULE_COMPRESS_GZIP)  :=3D .gz
> +suffix-$(CONFIG_MODULE_COMPRESS_XZ)    :=3D .xz
> +suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)  :=3D .zst
> +
> +modules :=3D $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(m=
odules))
> +
> +__modcompress: $(modules)
> +       @:
> +
> +#
> +# Compression
> +#
> +quiet_cmd_gzip =3D GZIP    $@
> +      cmd_gzip =3D $(KGZIP) -n -f $<
> +quiet_cmd_xz =3D XZ      $@
> +      cmd_xz =3D $(XZ) --lzma2=3Ddict=3D2MiB -f $<
> +quiet_cmd_zstd =3D ZSTD    $@
> +      cmd_zstd =3D $(ZSTD) -T0 --rm -f -q $<
> +
> +$(dst)/%.ko.gz: $(dst)/%.ko FORCE
> +       $(call cmd,gzip)
> +
> +$(dst)/%.ko.xz: $(dst)/%.ko FORCE
> +       $(call cmd,xz)
> +
> +$(dst)/%.ko.zst: $(dst)/%.ko FORCE
> +       $(call cmd,zstd)
> +
> +PHONY +=3D FORCE
> +FORCE:
> +
> +.PHONY: $(PHONY)
> diff --git a/scripts/Makefile.install b/scripts/Makefile.install
> new file mode 100644
> index 000000000000..40c496cb99dc
> --- /dev/null
> +++ b/scripts/Makefile.install
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +# Installing modules
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +PHONY :=3D __modinstall
> +__modinstall:
> +
> +include include/config/auto.conf
> +include $(srctree)/scripts/Kbuild.include
> +
> +modules :=3D $(call read-file, $(MODORDER))
> +
> +ifeq ($(KBUILD_EXTMOD),)
> +dst :=3D $(MODLIB)/kernel
> +else
> +INSTALL_MOD_DIR ?=3D updates
> +dst :=3D $(MODLIB)/$(INSTALL_MOD_DIR)
> +endif
> +
> +$(foreach x, % :, $(if $(findstring $x, $(dst)), \
> +       $(error module installation path cannot contain '$x')))
> +
> +modules :=3D $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(m=
odules))
> +
> +__modinstall: $(modules)
> +       @:
> +
> +#
> +# Installation
> +#
> +quiet_cmd_install =3D INSTALL $@
> +      cmd_install =3D mkdir -p $(dir $@); cp $< $@
> +
> +# Strip
> +#
> +# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after=
 they
> +# are installed. If INSTALL_MOD_STRIP is '1', then the default option
> +# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be=
 used
> +# as the options to the strip command.
> +ifdef INSTALL_MOD_STRIP
> +
> +ifeq ($(INSTALL_MOD_STRIP),1)
> +strip-option :=3D --strip-debug
> +else
> +strip-option :=3D $(INSTALL_MOD_STRIP)
> +endif
> +
> +quiet_cmd_strip =3D STRIP   $@
> +      cmd_strip =3D $(STRIP) $(strip-option) $@
> +
> +else
> +
> +quiet_cmd_strip =3D
> +      cmd_strip =3D :
> +
> +endif
> +
> +$(dst)/%.ko: $(extmod_prefix)%.ko FORCE
> +       $(call cmd,install)
> +       $(call cmd,strip)
> +
> +PHONY +=3D FORCE
> +FORCE:
> +
> +.PHONY: $(PHONY)
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index ab0c5bd1a60f..d87e09e57963 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -1,116 +1,17 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> -# Installing modules
> +# Install, Sign & Compress modules
>  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> -PHONY :=3D __modinst
> -__modinst:
> -
>  include include/config/auto.conf
>  include $(srctree)/scripts/Kbuild.include
>
> -modules :=3D $(call read-file, $(MODORDER))
> -
> -ifeq ($(KBUILD_EXTMOD),)
> -dst :=3D $(MODLIB)/kernel
> -else
> -INSTALL_MOD_DIR ?=3D updates
> -dst :=3D $(MODLIB)/$(INSTALL_MOD_DIR)
> -endif
> -
> -$(foreach x, % :, $(if $(findstring $x, $(dst)), \
> -       $(error module installation path cannot contain '$x')))
> -
> -suffix-y                               :=3D
> -suffix-$(CONFIG_MODULE_COMPRESS_GZIP)  :=3D .gz
> -suffix-$(CONFIG_MODULE_COMPRESS_XZ)    :=3D .xz
> -suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)  :=3D .zst
> -
> -modules :=3D $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(m=
odules))
> -
> -__modinst: $(modules)
> -       @:
> -
> -#
> -# Installation
> -#
> -quiet_cmd_install =3D INSTALL $@
> -      cmd_install =3D mkdir -p $(dir $@); cp $< $@
> -
> -# Strip
> -#
> -# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after=
 they
> -# are installed. If INSTALL_MOD_STRIP is '1', then the default option
> -# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be=
 used
> -# as the options to the strip command.
> -ifdef INSTALL_MOD_STRIP
> -
> -ifeq ($(INSTALL_MOD_STRIP),1)
> -strip-option :=3D --strip-debug
> -else
> -strip-option :=3D $(INSTALL_MOD_STRIP)
> -endif
> -
> -quiet_cmd_strip =3D STRIP   $@
> -      cmd_strip =3D $(STRIP) $(strip-option) $@
> -
> -else
> -
> -quiet_cmd_strip =3D
> -      cmd_strip =3D :
> -
> -endif
> -
> -#
> -# Signing
> -# Don't stop modules_install even if we can't sign external modules.
> -#
> -ifeq ($(CONFIG_MODULE_SIG_ALL),y)
> -ifeq ($(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
> -sig-key :=3D $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CO=
NFIG_MODULE_SIG_KEY)
> -else
> -sig-key :=3D $(CONFIG_MODULE_SIG_KEY)
> -endif
> -quiet_cmd_sign =3D SIGN    $@
> -      cmd_sign =3D scripts/sign-file $(CONFIG_MODULE_SIG_HASH) "$(sig-ke=
y)" certs/signing_key.x509 $@ \
> -                 $(if $(KBUILD_EXTMOD),|| true)
> -else
> -quiet_cmd_sign :=3D
> -      cmd_sign :=3D :
> -endif
> -
> -ifeq ($(modules_sign_only),)
> -
> -$(dst)/%.ko: $(extmod_prefix)%.ko FORCE
> -       $(call cmd,install)
> -       $(call cmd,strip)
> -       $(call cmd,sign)
> -
> -else
> -
> -$(dst)/%.ko: FORCE
> -       $(call cmd,sign)
> -
> -endif
> -
> -#
> -# Compression
> -#
> -quiet_cmd_gzip =3D GZIP    $@
> -      cmd_gzip =3D $(KGZIP) -n -f $<
> -quiet_cmd_xz =3D XZ      $@
> -      cmd_xz =3D $(XZ) --lzma2=3Ddict=3D2MiB -f $<
> -quiet_cmd_zstd =3D ZSTD    $@
> -      cmd_zstd =3D $(ZSTD) -T0 --rm -f -q $<
> -
> -$(dst)/%.ko.gz: $(dst)/%.ko FORCE
> -       $(call cmd,gzip)
> -
> -$(dst)/%.ko.xz: $(dst)/%.ko FORCE
> -       $(call cmd,xz)
> +PHONY :=3D __modinst
>
> -$(dst)/%.ko.zst: $(dst)/%.ko FORCE
> -       $(call cmd,zstd)
> +__modinst: FORCE
> +       $(MAKE) -f scripts/Makefile.install
> +       $(MAKE) -f scripts/Makefile.sign
> +       $(MAKE) -f scripts/Makefile.compress
>
>  PHONY +=3D FORCE
>  FORCE:
> diff --git a/scripts/Makefile.sign b/scripts/Makefile.sign
> new file mode 100644
> index 000000000000..d6b242b16657
> --- /dev/null
> +++ b/scripts/Makefile.sign
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +# Signing modules
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +PHONY :=3D __modsign
> +__modsign:
> +
> +include include/config/auto.conf
> +include $(srctree)/scripts/Kbuild.include
> +
> +#
> +# Signing
> +# Don't stop modules_install even if we can't sign external modules.
> +#
> +ifeq ($(CONFIG_MODULE_SIG_ALL),y)
> +ifeq ($(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
> +sig-key :=3D $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CO=
NFIG_MODULE_SIG_KEY)
> +else
> +sig-key :=3D $(CONFIG_MODULE_SIG_KEY)
> +endif
> +quiet_cmd_sign =3D SIGNING ALL MODULES ...
> +      cmd_sign =3D $(CONFIG_SHELL) $(srctree)/scripts/signfile.sh \
> +                                        "$(CONFIG_MODULE_SIG_HASH)" \
> +                                        "$(sig-key)"
> +else
> +quiet_cmd_sign :=3D
> +      cmd_sign :=3D :
> +endif
> +
> +__modsign: FORCE
> +       $(call cmd,sign)
> +
> +PHONY +=3D FORCE
> +FORCE:
> +
> +.PHONY: $(PHONY)
> diff --git a/scripts/signfile.sh b/scripts/signfile.sh
> new file mode 100755
> index 000000000000..b2b58bfbd5ba
> --- /dev/null
> +++ b/scripts/signfile.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# A sign-file wrapper used by scripts/Makefile.sign
> +
> +#set -x
> +
> +if test $# -ne 2; then
> +       echo "Usage: $0 <hash-algo> <sign-key>" >&2
> +       exit 1
> +fi
> +
> +SIG_HASH=3D"$1"
> +SIG_KEY=3D"$2"
> +
> +MODULES_PATH=3D"${INSTALL_MOD_PATH}/lib/modules/${KERNELRELEASE}"
> +
> +find "${MODULES_PATH}" -name *.ko -type f -print0 | \
> +       xargs -r -0 -P$(nproc) -x -n32 sh -c "\
> +${srctree}/scripts/sign-file \
> +-a \"${SIG_HASH}\" \
> +-i \"${SIG_KEY}\" \
> +-x ${srctree}/certs/signing_key.x509 \
> +-b \$@ \$0"
> --
> 2.41.0
>


--=20
Best Regards
Masahiro Yamada
