Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D6A7F2A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjKUKbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjKUKbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:31:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8239A191
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:21:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B75AC433CD;
        Tue, 21 Nov 2023 10:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700562110;
        bh=nqEMNBsAq/aTxYyPQlr2WLtFqb7Pl5m3A4FfNF84E8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HEqYYQMBl03x5OuP94qI3xfFCQr5Oa5dmhEyrfHTXy+17YLKFqhNNj+IrZAqEcW1G
         HNS/gbo06qEIM23PbXQV55+3j/OZw71FooAo30OXXOojU6lABzjVRunpQjGNKjcLJA
         X5lRH2ppBoFuxdkPfSBq9YXDyciTGNuFHFxgwdCxsmCENDlC077yIvTIDpMYdBzoSJ
         MsHUZRhPUbs1fmRXS/MdQcvLIs2mhAogSJTV2X+tnWPRfL9Z+JtIyxmhf414jrVvvQ
         5k0FO/W58+NOzLYUWlHBI0o5OtOIBKFM37cD5iupgQ8ntb3ZiZLAKOnZS/uwly5zcB
         xLkF6UCpyP+0w==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ce322b62aeso2881086a34.3;
        Tue, 21 Nov 2023 02:21:50 -0800 (PST)
X-Gm-Message-State: AOJu0Yxf6WBjXCEu3L03LD9hCWID4cyc3J1yGSDHQK8dryuWA7ZN/4Fp
        YJ2hPHHzVdRvnHhL5MB2Hz0hkbubd0rH+Jl3Cns=
X-Google-Smtp-Source: AGHT+IE0VzmuYiYA+diTPNkp5V/jzc7Rz44WQqSAJOeWjWPJG72xt/yM1+V68Kh1Hop+Qb5PpmHga87IbgrZSU5E6T8=
X-Received: by 2002:a05:6871:b415:b0:1e9:68b5:d418 with SMTP id
 br21-20020a056871b41500b001e968b5d418mr8549006oac.34.1700562109483; Tue, 21
 Nov 2023 02:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20231120222832.4063882-1-masahiroy@kernel.org> <20231120222832.4063882-2-masahiroy@kernel.org>
In-Reply-To: <20231120222832.4063882-2-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 21 Nov 2023 19:21:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNATK3BVDZ88v7MWjzOk3Kv8CR4Tz_k77yi1OO=zc+71j=g@mail.gmail.com>
Message-ID: <CAK7LNATK3BVDZ88v7MWjzOk3Kv8CR4Tz_k77yi1OO=zc+71j=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: pinconf-generic: resize the pin config array directly
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 7:28=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> pinconf_generic_parse_dt_config() allocates memory that is large enough
> to contain all the config parameters. Then, kmemdup() copies the found
> configs to the memory with the exact size.
>
> There is no need to allocate memory twice; you can directly resize the
> initial memory using krealloc_array().
>
> I also changed kcalloc() to kmalloc_array() to keep the consistency with
> krealloc_array(). This change has no impact because you do not need to
> zero out the 'cfg' array.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>



Sorry, I retract this patch set.

krealloc() does not save any memory
when the new_size is smaller than the current size.













> ---
>
>  drivers/pinctrl/pinconf-generic.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-=
generic.c
> index 8313cb5f3b3c..ba4fe2466e78 100644
> --- a/drivers/pinctrl/pinconf-generic.c
> +++ b/drivers/pinctrl/pinconf-generic.c
> @@ -247,7 +247,6 @@ int pinconf_generic_parse_dt_config(struct device_nod=
e *np,
>  {
>         unsigned long *cfg;
>         unsigned int max_cfg, ncfg =3D 0;
> -       int ret;
>
>         if (!np)
>                 return -EINVAL;
> @@ -256,7 +255,7 @@ int pinconf_generic_parse_dt_config(struct device_nod=
e *np,
>         max_cfg =3D ARRAY_SIZE(dt_params);
>         if (pctldev)
>                 max_cfg +=3D pctldev->desc->num_custom_params;
> -       cfg =3D kcalloc(max_cfg, sizeof(*cfg), GFP_KERNEL);
> +       cfg =3D kmalloc_array(max_cfg, sizeof(*cfg), GFP_KERNEL);
>         if (!cfg)
>                 return -ENOMEM;
>
> @@ -266,30 +265,22 @@ int pinconf_generic_parse_dt_config(struct device_n=
ode *np,
>                 parse_dt_cfg(np, pctldev->desc->custom_params,
>                              pctldev->desc->num_custom_params, cfg, &ncfg=
);
>
> -       ret =3D 0;
> -
>         /* no configs found at all */
>         if (ncfg =3D=3D 0) {
> +               kfree(cfg);
>                 *configs =3D NULL;
>                 *nconfigs =3D 0;
> -               goto out;
> +               return 0;
>         }
>
> -       /*
> -        * Now limit the number of configs to the real number of
> -        * found properties.
> -        */
> -       *configs =3D kmemdup(cfg, ncfg * sizeof(unsigned long), GFP_KERNE=
L);
> -       if (!*configs) {
> -               ret =3D -ENOMEM;
> -               goto out;
> -       }
> +       /* Now resize the array to store the real number of found propert=
ies. */
> +       *configs =3D krealloc_array(cfg, ncfg, sizeof(unsigned long), GFP=
_KERNEL);
> +       if (!*configs)
> +               return -ENOMEM;
>
>         *nconfigs =3D ncfg;
>
> -out:
> -       kfree(cfg);
> -       return ret;
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(pinconf_generic_parse_dt_config);
>
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada
