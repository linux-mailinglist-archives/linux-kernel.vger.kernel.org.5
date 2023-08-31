Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E464378EFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbjHaO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346472AbjHaO45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:56:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C3BCD7;
        Thu, 31 Aug 2023 07:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E277A606A0;
        Thu, 31 Aug 2023 14:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5699AC433C7;
        Thu, 31 Aug 2023 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693493813;
        bh=kOFh/fp/f3g52y+ZSaSQZzBLFCGMa0o3VZUWZA3MBck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mh7JEklUISW5EwyLhRw06gHT1TlgevM8+9OS9z+/IJ3zBgVGMCeVkbEgO6qUOi1n8
         xZ0tvEWHhq0BsSgY6FJFOPSESq2TYu3h5PaCX2S03nPYWiHv58vFG+WgQ70UY+/Ha5
         elGDtcQLLz/YjQEPFNVnToDM/traJ+rfHzWCfhB/SXz5oFCJf9tGxvHFHvvIRX5qAp
         nB3A9V9s+0lVPYvKFx9Sg/tc6jqyfOT4MFJY6FSUPm1B83a9ONLTlXTx3rzyFCZgOY
         7a5yPx9dPU5baKI/6/yH5wkYKuNNDS98BxqkWQ+xPZMTXv7AbnWip0D9AMv1UOKNdn
         NqQmNKo7frugw==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3a76d882080so545155b6e.2;
        Thu, 31 Aug 2023 07:56:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YxKiI8532zWi3ri7FJeQfbTQ132GYTx7cFWhN/WAiOjSJqm42I5
        l0aUQBp049LJ28V+qfxcHeEmwNJcma9hEbjSh4s=
X-Google-Smtp-Source: AGHT+IGc4H1BLJQnbde1NNvAyGUWH7P48NHTtS8coaD4Oy43L+5yfOD5IuuBa4SN22A0E8nDEVyQjR/WxPf27UhUO1c=
X-Received: by 2002:a05:6808:bc2:b0:3a7:e6fb:c8a9 with SMTP id
 o2-20020a0568080bc200b003a7e6fbc8a9mr6973862oik.8.1693493812662; Thu, 31 Aug
 2023 07:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230830004937.2938195-1-senozhatsky@chromium.org>
In-Reply-To: <20230830004937.2938195-1-senozhatsky@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 31 Aug 2023 23:56:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQvFR0dQAFU2YiqxrXJTKcH0-=n0Fea1Q8pc7ZuHHf0zg@mail.gmail.com>
Message-ID: <CAK7LNAQvFR0dQAFU2YiqxrXJTKcH0-=n0Fea1Q8pc7ZuHHf0zg@mail.gmail.com>
Subject: Re: [PATCHv2] kconfig: add warn-unknown-symbols sanity check
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Tomasz Figa <tfiga@chromium.org>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Aug 31, 2023 at 11:15=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Introduce KCONFIG_WARN_UNKNOWN_SYMBOLS environment variable,
> which makes Kconfig warn about unknown config symbols.
>
> This is especially useful for continuous kernel uprevs when
> some symbols can be either removed or renamed between kernel
> releases (which can go unnoticed otherwise).
>
> By default KCONFIG_WARN_UNKNOWN_SYMBOLS generates warnings,
> which are non-terminal. There is an additional environment
> variable KCONFIG_WERROR that overrides this behaviour and
> turns warnings into errors.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>


Applied to linux-kbuild. Thanks.




> ---
>  Documentation/kbuild/kconfig.rst |  9 +++++++++
>  scripts/kconfig/confdata.c       | 21 +++++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/kbuild/kconfig.rst b/Documentation/kbuild/kcon=
fig.rst
> index 6530ecd99da3..c946eb44bd13 100644
> --- a/Documentation/kbuild/kconfig.rst
> +++ b/Documentation/kbuild/kconfig.rst
> @@ -56,6 +56,15 @@ KCONFIG_OVERWRITECONFIG
>  If you set KCONFIG_OVERWRITECONFIG in the environment, Kconfig will not
>  break symlinks when .config is a symlink to somewhere else.
>
> +KCONFIG_WARN_UNKNOWN_SYMBOLS
> +----------------------------
> +This environment variable makes Kconfig warn about all unrecognized
> +symbols in the config input.
> +
> +KCONFIG_WERROR
> +--------------
> +If set, Kconfig treats warnings as errors.
> +
>  `CONFIG_`
>  ---------
>  If you set `CONFIG_` in the environment, Kconfig will prefix all symbols
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 992575f1e976..4a6811d77d18 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -349,7 +349,11 @@ int conf_read_simple(const char *name, int def)
>         char *p, *p2;
>         struct symbol *sym;
>         int i, def_flags;
> +       const char *warn_unknown;
> +       const char *werror;
>
> +       warn_unknown =3D getenv("KCONFIG_WARN_UNKNOWN_SYMBOLS");
> +       werror =3D getenv("KCONFIG_WERROR");
>         if (name) {
>                 in =3D zconf_fopen(name);
>         } else {
> @@ -437,6 +441,10 @@ int conf_read_simple(const char *name, int def)
>                         if (def =3D=3D S_DEF_USER) {
>                                 sym =3D sym_find(line + 2 + strlen(CONFIG=
_));
>                                 if (!sym) {
> +                                       if (warn_unknown)
> +                                               conf_warning("unknown sym=
bol: %s",
> +                                                            line + 2 + s=
trlen(CONFIG_));
> +
>                                         conf_set_changed(true);
>                                         continue;
>                                 }
> @@ -471,7 +479,7 @@ int conf_read_simple(const char *name, int def)
>
>                         sym =3D sym_find(line + strlen(CONFIG_));
>                         if (!sym) {
> -                               if (def =3D=3D S_DEF_AUTO)
> +                               if (def =3D=3D S_DEF_AUTO) {
>                                         /*
>                                          * Reading from include/config/au=
to.conf
>                                          * If CONFIG_FOO previously exist=
ed in
> @@ -479,8 +487,13 @@ int conf_read_simple(const char *name, int def)
>                                          * include/config/FOO must be tou=
ched.
>                                          */
>                                         conf_touch_dep(line + strlen(CONF=
IG_));
> -                               else
> +                               } else {
> +                                       if (warn_unknown)
> +                                               conf_warning("unknown sym=
bol: %s",
> +                                                            line + strle=
n(CONFIG_));
> +
>                                         conf_set_changed(true);
> +                               }
>                                 continue;
>                         }
>
> @@ -519,6 +532,10 @@ int conf_read_simple(const char *name, int def)
>         }
>         free(line);
>         fclose(in);
> +
> +       if (conf_warnings && werror)
> +               exit(1);
> +
>         return 0;
>  }
>
> --
> 2.42.0.rc2.253.gd59a3bf2b4-goog
>


--=20
Best Regards
Masahiro Yamada
