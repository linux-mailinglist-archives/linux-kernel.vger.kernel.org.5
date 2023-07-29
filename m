Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21BA767FB1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjG2NtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjG2NtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:49:08 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221CB3C05
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 06:48:34 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-4475df91bb1so1158620137.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690638512; x=1691243312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9K8MfQ/2KYhz06j+Ti9C7ni8VHpjYsaGehJNg80lJI=;
        b=naIQ08e9IBfOBzXIQ+DBbyHF77bOcJQNh533DgoExpps7JzVZoEv1fxQ3inQztlBHm
         mvKYyc0vz0Bbi8iKgmhAG6TBwUwkznd1U23XJpCnXdx6CayBCxZOyv3cUkDAHaX4u8ei
         COapMeQMEOppzxngooX247ziuuQBLjEWaKiqrHsTP78Zwfvi/mK6l9E34p0gWB7lxL5L
         HGAAvZlH7J/slyJ7/4CQFtlTfy1nFY17XHQYEPD6Y3i9UsmlMC15ANaAlgLcVYliJzO7
         1UF70PEiYbhQjdxhD7JzhFumvZkL7YhPtYRUmUqr4nl65OO6Kutq0DACWraQwUQc/Yau
         DHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638512; x=1691243312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9K8MfQ/2KYhz06j+Ti9C7ni8VHpjYsaGehJNg80lJI=;
        b=GvjlSf4MFh7ce8v7aAC+Vhvm1SiBrg/bEvVD5lzCgfo0fEOVHK0kRy+rUcO2PaWO5H
         02AzdOyseGAr4GFV6OghCYePyifE9akBOwKgu1kQ0croXDzj25xJPqcGSqItJ7LoU7qk
         A3gpaOb8vprEOFJaGwVJegoJBJ3bEN6qETRDf6Q05CYI/d7bsgaT6HYNcj+j0V5hL2vw
         UdCBIwrGkmgmQyqwLEBlTvQcES5+zPotlDOP6ygoCW+glnRM2bbvrARENqhCk+XcQOAc
         S512ubnFWI9I3p+bIg3dnqV0Vl9LhHwXgerwmYx0/NH4W1chKvPDuot9oTg1pZjTavf/
         9y9A==
X-Gm-Message-State: ABy/qLYGjtSZe34QP1Cq0MUx1sPxRSVUGLhX81Nj9Lige7cz+JCc2s//
        YiOjq12PhAYR2gY64nneLxnfotppXdp2yNBBaxEdaQ==
X-Google-Smtp-Source: APBJJlEGxuzP14KFNTnaZg4SyM3xkhc7QIoXLz/6CmWWZKRzZ8SxNn9y5I7BtzIVblotIewqVro2HnrOCA4pAxkY964=
X-Received: by 2002:a67:eb44:0:b0:447:6a0a:4c5f with SMTP id
 x4-20020a67eb44000000b004476a0a4c5fmr3432044vso.18.1690638512311; Sat, 29 Jul
 2023 06:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230711092328.26598-1-zhuyinbo@loongson.cn>
In-Reply-To: <20230711092328.26598-1-zhuyinbo@loongson.cn>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 29 Jul 2023 15:48:21 +0200
Message-ID: <CAMRc=MeJfWO+munPQGLtODEXyiS0g=MTm2E71etCLng1HXOq-A@mail.gmail.com>
Subject: Re: [PATCH] gpio: loongson: add firmware offset parse support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:23=E2=80=AFAM Yinbo Zhu <zhuyinbo@loongson.cn> w=
rote:
>
> Some platforms contain multiple GPIO chips that with different offset
> addresses, if using acpi_device_id or of_device_id's data domain to
> initialize GPIO chip and different compatibles need to be added, but
> this addition is unnecessary because these GPIO chips are compatible
> with each other. Therefore, this driver adds support for parsing the
> necessary offset elements of GPIO chips from firmware to fix such
> issue.
>

The commit message is hard to parse, it took me a long while trying to
figure out what it's saying. Why not: "Loongson GPIO controllers come
in multiple variants that are compatible except for certain register
offset values. Add support for device properties allowing to specify
them in ACPI or DT."

> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  drivers/gpio/gpio-loongson-64bit.c | 71 +++++++++++++++++++++++++++---
>  1 file changed, 64 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpio/gpio-loongson-64bit.c b/drivers/gpio/gpio-loong=
son-64bit.c
> index 06213bbfabdd..7f92cb6205b2 100644
> --- a/drivers/gpio/gpio-loongson-64bit.c
> +++ b/drivers/gpio/gpio-loongson-64bit.c
> @@ -26,6 +26,7 @@ struct loongson_gpio_chip_data {
>         unsigned int            conf_offset;
>         unsigned int            out_offset;
>         unsigned int            in_offset;
> +       unsigned int            inten_offset;
>  };
>
>  struct loongson_gpio_chip {
> @@ -117,7 +118,17 @@ static void loongson_gpio_set(struct gpio_chip *chip=
, unsigned int pin, int valu
>
>  static int loongson_gpio_to_irq(struct gpio_chip *chip, unsigned int off=
set)
>  {
> +       unsigned int u;
>         struct platform_device *pdev =3D to_platform_device(chip->parent)=
;
> +       struct loongson_gpio_chip *lgpio =3D to_loongson_gpio_chip(chip);
> +
> +       if (lgpio->chip_data->mode =3D=3D BIT_CTRL_MODE) {
> +               u =3D readl(lgpio->reg_base + lgpio->chip_data->inten_off=
set + offset / 32 * 4);
> +               u |=3D BIT(offset % 32);
> +               writel(u, lgpio->reg_base + lgpio->chip_data->inten_offse=
t + offset / 32 * 4);
> +       } else {
> +               writeb(1, lgpio->reg_base + lgpio->chip_data->inten_offse=
t + offset);
> +       }
>
>         return platform_get_irq(pdev, offset);
>  }
> @@ -127,11 +138,30 @@ static int loongson_gpio_init(struct device *dev, s=
truct loongson_gpio_chip *lgp
>  {
>         int ret;
>         u32 ngpios;
> +       unsigned int io_width;
>
>         lgpio->reg_base =3D reg_base;
> +       if (device_property_read_u32(dev, "ngpios", &ngpios) || !ngpios)
> +               return -EINVAL;
> +
> +       ret =3D DIV_ROUND_UP(ngpios, 8);
> +       switch (ret) {
> +       case 1 ... 2:
> +               io_width =3D ret;
> +               break;
> +       case 3 ... 4:
> +               io_width =3D 0x4;
> +               break;
> +       case 5 ... 8:
> +               io_width =3D 0x8;
> +               break;
> +       default:
> +               dev_err(dev, "unsupported io width\n");
> +               return -EINVAL;
> +       }
>
>         if (lgpio->chip_data->mode =3D=3D BIT_CTRL_MODE) {
> -               ret =3D bgpio_init(&lgpio->chip, dev, 8,
> +               ret =3D bgpio_init(&lgpio->chip, dev, io_width,
>                                 lgpio->reg_base + lgpio->chip_data->in_of=
fset,
>                                 lgpio->reg_base + lgpio->chip_data->out_o=
ffset,
>                                 NULL, NULL,
> @@ -151,16 +181,35 @@ static int loongson_gpio_init(struct device *dev, s=
truct loongson_gpio_chip *lgp
>                 spin_lock_init(&lgpio->lock);
>         }
>
> -       device_property_read_u32(dev, "ngpios", &ngpios);
> -
> -       lgpio->chip.can_sleep =3D 0;
>         lgpio->chip.ngpio =3D ngpios;
> -       lgpio->chip.label =3D lgpio->chip_data->label;
> -       lgpio->chip.to_irq =3D loongson_gpio_to_irq;
> +       lgpio->chip.can_sleep =3D 0;
> +       if (lgpio->chip_data->label)
> +               lgpio->chip.label =3D lgpio->chip_data->label;
> +       else
> +               lgpio->chip.label =3D kstrdup(to_platform_device(dev)->na=
me, GFP_KERNEL);
> +
> +       if (lgpio->chip_data->inten_offset)
> +               lgpio->chip.to_irq =3D loongson_gpio_to_irq;
>
>         return devm_gpiochip_add_data(dev, &lgpio->chip, lgpio);
>  }
>
> +static int loongson_gpio_get_props(struct device *dev,
> +                                   struct loongson_gpio_chip *lgpio)
> +{
> +       const struct loongson_gpio_chip_data *d =3D lgpio->chip_data;
> +
> +       if (device_property_read_u32(dev, "loongson,gpio-conf-offset", (u=
32 *)&d->conf_offset)
> +           || device_property_read_u32(dev, "loongson,gpio-in-offset", (=
u32 *)&d->in_offset)
> +           || device_property_read_u32(dev, "loongson,gpio-out-offset", =
(u32 *)&d->out_offset)
> +           || device_property_read_u32(dev, "loongson,gpio-ctrl-mode", (=
u32 *)&d->mode))

These need to be first specified in DT bindings. Please do it in a
separate patch.

Bart

> +               return -EINVAL;
> +
> +       device_property_read_u32(dev, "loongson,gpio-inten-offset", (u32 =
*)&d->inten_offset);
> +
> +       return 0;
> +}
> +
>  static int loongson_gpio_probe(struct platform_device *pdev)
>  {
>         void __iomem *reg_base;
> @@ -172,7 +221,12 @@ static int loongson_gpio_probe(struct platform_devic=
e *pdev)
>         if (!lgpio)
>                 return -ENOMEM;
>
> -       lgpio->chip_data =3D device_get_match_data(dev);
> +       lgpio->chip_data =3D devm_kzalloc(dev, sizeof(*lgpio->chip_data),=
 GFP_KERNEL);
> +       if (!lgpio->chip_data)
> +               return -ENOMEM;
> +
> +       if (loongson_gpio_get_props(dev, lgpio))
> +               lgpio->chip_data =3D device_get_match_data(dev);
>
>         reg_base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(reg_base))
> @@ -215,6 +269,9 @@ static const struct acpi_device_id loongson_gpio_acpi=
_match[] =3D {
>                 .id =3D "LOON0002",
>                 .driver_data =3D (kernel_ulong_t)&loongson_gpio_ls7a_data=
,
>         },
> +       {
> +               .id =3D "LOON0007",
> +       },
>         {}
>  };
>  MODULE_DEVICE_TABLE(acpi, loongson_gpio_acpi_match);
> --
> 2.31.1
>
