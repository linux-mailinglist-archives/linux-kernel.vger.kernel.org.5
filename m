Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96E178C4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbjH2NOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjH2NOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DD3BE;
        Tue, 29 Aug 2023 06:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91EBB63682;
        Tue, 29 Aug 2023 13:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAD2C433C7;
        Tue, 29 Aug 2023 13:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693314860;
        bh=8JuxMsJ3U5i7GuhCyC/QrZ1hPppSeHOK4ObwLj5mz6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lentXxNxN5mmx8xZXG4cqwYpiTX3+qDYYnae4LjeLx+BBa8wA5N76Luk9yp6kd9rP
         ruI6+iJ/vi0HLejPHe2OYGjJHVBhCFhXU0cfiOTG9wfHeDdL6qN4iARQZ+JNyeHNEr
         kY4LrDw5nNWBInCX0FXCqXabAJ3oAola09T2p1xBNiX4JHBpj5ZlT63hgCA0ux+uwB
         pGy8Y+8ID8SUfvWliIrGsSWTx8MB+Y4nznK5pRhZf4ISMTCtmzza/hpOe+s5N9ZE2X
         3JFGBdUCYmoQek/Mjz192YwJ8av5909vhOpma6HVPzkGy/ZbILlC1NsHKExg91RYly
         +JmBLQ6vcWWJA==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3a8506f5b73so3090116b6e.0;
        Tue, 29 Aug 2023 06:14:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YwpL1uavq0/LmYl+v9ab18B6dOp4weTyxLa9MMqP4t9puQd991t
        +ijg+FMhu2CaOEESF0xyIR8IdCzBfbtea+O7qho=
X-Google-Smtp-Source: AGHT+IEHY+TUkRwN9caizuIvWFd/8ucahftpstde9afS5W4HOCHDxNhbIuQHyoQfTwnRvwdAmcDwVo72D/R/sV73t+Y=
X-Received: by 2002:a05:6808:218c:b0:3a1:d656:21c with SMTP id
 be12-20020a056808218c00b003a1d656021cmr17611136oib.21.1693314859223; Tue, 29
 Aug 2023 06:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230826071359.2060501-1-senozhatsky@chromium.org>
In-Reply-To: <20230826071359.2060501-1-senozhatsky@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 29 Aug 2023 22:13:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAROnZpZiOC4eS5kTcv4Q2YDrE9KYBD-dVcfXwBPQWvbmg@mail.gmail.com>
Message-ID: <CAK7LNAROnZpZiOC4eS5kTcv4Q2YDrE9KYBD-dVcfXwBPQWvbmg@mail.gmail.com>
Subject: Re: [PATCH] kconfig: add warn-unknown-symbols sanity check
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, Aug 27, 2023 at 6:00=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Introduce KCONFIG_WARN_UNKNOWN_SYMBOLS environment variable,
> which makes Kconfig warn about unknown .config symbols.
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
> ---
>  Documentation/kbuild/kconfig.rst | 11 +++++++++++
>  scripts/kconfig/confdata.c       | 23 +++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/Documentation/kbuild/kconfig.rst b/Documentation/kbuild/kcon=
fig.rst
> index 6530ecd99da3..4de1f5435b7b 100644
> --- a/Documentation/kbuild/kconfig.rst
> +++ b/Documentation/kbuild/kconfig.rst
> @@ -56,6 +56,17 @@ KCONFIG_OVERWRITECONFIG
>  If you set KCONFIG_OVERWRITECONFIG in the environment, Kconfig will not
>  break symlinks when .config is a symlink to somewhere else.
>
> +KCONFIG_WARN_UNKNOWN_SYMBOLS
> +----------------------------
> +This environment variable makes Kconfig warn about all unrecognized
> +symbols in the .config file.


This warns not only for the .config but also defconfig files.

Could you reword it?

For example,

 "symbols in the config input".


> +
> +KCONFIG_WERROR
> +--------------
> +If set, Kconfig will treat `KCONFIG_WARN_UNKNOWN_SYMBOLS` warnings as
> +errors.

My hope is to turn other warnings in the config file into errors.

See below.


> +
> +
>  `CONFIG_`
>  ---------
>  If you set `CONFIG_` in the environment, Kconfig will prefix all symbols
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 992575f1e976..c24f637827fe 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -349,7 +349,12 @@ int conf_read_simple(const char *name, int def)
>         char *p, *p2;
>         struct symbol *sym;
>         int i, def_flags;
> +       bool found_unknown =3D false;
> +       const char *warn_unknown;
> +       const char *werror;
>
> +       warn_unknown =3D getenv("KCONFIG_WARN_UNKNOWN_SYMBOLS");
> +       werror =3D getenv("KCONFIG_WERROR");
>         if (name) {
>                 in =3D zconf_fopen(name);
>         } else {
> @@ -437,6 +442,13 @@ int conf_read_simple(const char *name, int def)
>                         if (def =3D=3D S_DEF_USER) {
>                                 sym =3D sym_find(line + 2 + strlen(CONFIG=
_));
>                                 if (!sym) {
> +                                       if (warn_unknown) {
> +                                               conf_warning("unknown sym=
bol: %s",
> +                                                            line + 2 + s=
trlen(CONFIG_));
> +                                               found_unknown =3D true;
> +                                               continue;

Please drop this 'continue' because it would skip
conf_set_changed(true).

warn_unknown should keep the same code flow
except showing the warning message.




> +                                       }
> +
>                                         conf_set_changed(true);
>                                         continue;
>                                 }
> @@ -471,6 +483,13 @@ int conf_read_simple(const char *name, int def)
>
>                         sym =3D sym_find(line + strlen(CONFIG_));
>                         if (!sym) {
> +                               if (warn_unknown && def !=3D S_DEF_AUTO) =
{
> +                                       conf_warning("unknown symbol: %s"=
,
> +                                                    line + strlen(CONFIG=
_));
> +                                       found_unknown =3D true;
> +                                       continue;

Same here.
When KCONFIG_WARN_UNKNOWN_SYMBOLS is set,
conf_set_changed(true) will be skipped.



You can do like this:


@@ -471,7 +483,7 @@ int conf_read_simple(const char *name, int def)

                        sym =3D sym_find(line + strlen(CONFIG_));
                        if (!sym) {
-                               if (def =3D=3D S_DEF_AUTO)
+                               if (def =3D=3D S_DEF_AUTO) {
                                        /*
                                         * Reading from include/config/auto=
.conf
                                         * If CONFIG_FOO previously existed=
 in
@@ -479,8 +491,13 @@ int conf_read_simple(const char *name, int def)
                                         * include/config/FOO must be touch=
ed.
                                         */
                                        conf_touch_dep(line + strlen(CONFIG=
_));
-                               else
+                               } else {
+                                       if (warn_unknown && def !=3D S_DEF_=
AUTO)
+                                               conf_warning("unknown
symbol: %s",
+                                                            line +
strlen(CONFIG_));
+
                                        conf_set_changed(true);
+                               }
                                continue;
                        }





> +                               }
> +
>                                 if (def =3D=3D S_DEF_AUTO)
>                                         /*
>                                          * Reading from include/config/au=
to.conf
> @@ -519,6 +538,10 @@ int conf_read_simple(const char *name, int def)
>         }
>         free(line);
>         fclose(in);
> +
> +       if (found_unknown && werror)
> +               exit(1);


I like to reuse 'conf_warnings' as you did in the previous version.

      if (conf_warnings && werror)
                exit(1)



Then, you do not need to add 'found_unknown'.






--=20
Best Regards
Masahiro Yamada
