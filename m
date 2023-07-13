Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A0A752BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjGMUuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjGMUuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:50:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131A730C3;
        Thu, 13 Jul 2023 13:50:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51dec0b6fecso1528539a12.1;
        Thu, 13 Jul 2023 13:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689281420; x=1691873420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SboTTTCH8PwJ1k7g+TtwxjrJ+lEO716FlHbTBOahELk=;
        b=SKbVRNckqBlwzRAuMF9yH+PurYvVsa8fqvtw+zDL/az2bGnW9qsiq2mVvgsSwr+FdN
         CBy1I39CdxXEslgDuDmanPf5qL4HvmE4lRmorJzmRezxl1sshoopUN6mmNVIMcRoCkOI
         V2SJYzsAxDTT69wUQ7FPgkAyyhW/fnXTskNoJ3mYDQ0tZZt8L4B24cdHey3tu9kvcQhW
         TUz8IrU4W+T04jRsvUa90+zjKcCWCk6Xx9CuKqa29Pa/Bj/GhtIDPkNRwn+SLAc/j4Eg
         kiFGW971JsIhaOrYYGDrlOctZxrcom4e1WzSmldUqvkAOQ/1gUuG3ltCyYnBqTJ+KuIq
         nJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689281420; x=1691873420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SboTTTCH8PwJ1k7g+TtwxjrJ+lEO716FlHbTBOahELk=;
        b=J05ZH4JdS97pwtMKNzSQj2IwDolmRZp2fTcl8OATrtYXRHslaoueHP0oAVK2P98xlH
         7uCz4lq+wXQg44oRiVG2czRc7G3io7+Uc6hC4Qqp5hv5s509HHgHrxU5tVflsm/e2UZ7
         DiB1dPCDUeCraWQRQ8f0aH7BIPk2dE9BqB+vTMEpr4R/8lGzPSqbGlOlx5sw86aeDIj/
         /0gkG+J5VY8B8mh7+EHvzhJeogaU6WLebAmo1nPtMRs295ddEYXaVhw1LjzdLD49ltvF
         sXiIuy01ttlfIRlnp8agN/rCwHTlJMY4sqsT+opWK2xXO68Jg7xTjAAVID/PR+VhLexy
         1zug==
X-Gm-Message-State: ABy/qLajmbgs/cxtQ4uYb4LveOP8D/GxQB0DvTeSJIuUq1dxQBYSwb4v
        wani98Kt6OUeBX2o2g1aTgo4Zko6irSPWgWf4PquJmzykPw=
X-Google-Smtp-Source: APBJJlEHIwaUXh5iJIfpYySS3oyu5o/08cYcubgi4ocgWz3y+lL51x7rZplcJHL9asds4CQnnhRrjTnMUOsKutZS4oo=
X-Received: by 2002:aa7:da4b:0:b0:51e:1692:1111 with SMTP id
 w11-20020aa7da4b000000b0051e16921111mr3271001eds.3.1689281419941; Thu, 13 Jul
 2023 13:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230713202046.150986-1-afd@ti.com>
In-Reply-To: <20230713202046.150986-1-afd@ti.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 13 Jul 2023 23:49:43 +0300
Message-ID: <CAHp75Vchw81jMbCK2KbVLxqh3YScjwQJW--B3p9fYYGVKjWLjg@mail.gmail.com>
Subject: Re: [PATCH v4] gpio: pisosr: Use devm_gpiochip_add_data() to simplify
 remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 11:20=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> Use devm version of gpiochip add function to handle removal for us.
>
> While here update copyright and module author.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>
> Changes from v3:
>  - Do not cast void * lock explicitly
>  - Rebase on v6.5-rc1
>
> Changes from v2:
>  - Rebase on v6.4-rc2
>
> Changes from v1:
>  - Use devm to cleanup mutex
>
>  drivers/gpio/gpio-pisosr.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
> index 67071bea08c26..e3013e778e151 100644
> --- a/drivers/gpio/gpio-pisosr.c
> +++ b/drivers/gpio/gpio-pisosr.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com=
/
> - *     Andrew F. Davis <afd@ti.com>
> + * Copyright (C) 2015-2023 Texas Instruments Incorporated - https://www.=
ti.com/
> + *     Andrew Davis <afd@ti.com>
>   */
>
>  #include <linux/bitmap.h>
> @@ -116,6 +116,11 @@ static const struct gpio_chip template_chip =3D {
>         .can_sleep              =3D true,
>  };
>
> +static void pisosr_mutex_destroy(void *lock)
> +{
> +       mutex_destroy(lock);
> +}
> +
>  static int pisosr_gpio_probe(struct spi_device *spi)
>  {
>         struct device *dev =3D &spi->dev;
> @@ -126,8 +131,6 @@ static int pisosr_gpio_probe(struct spi_device *spi)
>         if (!gpio)
>                 return -ENOMEM;
>
> -       spi_set_drvdata(spi, gpio);
> -
>         gpio->chip =3D template_chip;
>         gpio->chip.parent =3D dev;
>         of_property_read_u16(dev->of_node, "ngpios", &gpio->chip.ngpio);
> @@ -145,8 +148,11 @@ static int pisosr_gpio_probe(struct spi_device *spi)
>                                      "Unable to allocate load GPIO\n");
>
>         mutex_init(&gpio->lock);
> +       ret =3D devm_add_action_or_reset(dev, pisosr_mutex_destroy, &gpio=
->lock);
> +       if (ret)
> +               return ret;
>
> -       ret =3D gpiochip_add_data(&gpio->chip, gpio);
> +       ret =3D devm_gpiochip_add_data(dev, &gpio->chip, gpio);
>         if (ret < 0) {
>                 dev_err(dev, "Unable to register gpiochip\n");
>                 return ret;
> @@ -155,15 +161,6 @@ static int pisosr_gpio_probe(struct spi_device *spi)
>         return 0;
>  }
>
> -static void pisosr_gpio_remove(struct spi_device *spi)
> -{
> -       struct pisosr_gpio *gpio =3D spi_get_drvdata(spi);
> -
> -       gpiochip_remove(&gpio->chip);
> -
> -       mutex_destroy(&gpio->lock);
> -}
> -
>  static const struct spi_device_id pisosr_gpio_id_table[] =3D {
>         { "pisosr-gpio", },
>         { /* sentinel */ }
> @@ -182,11 +179,10 @@ static struct spi_driver pisosr_gpio_driver =3D {
>                 .of_match_table =3D pisosr_gpio_of_match_table,
>         },
>         .probe =3D pisosr_gpio_probe,
> -       .remove =3D pisosr_gpio_remove,
>         .id_table =3D pisosr_gpio_id_table,
>  };
>  module_spi_driver(pisosr_gpio_driver);
>
> -MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
> +MODULE_AUTHOR("Andrew Davis <afd@ti.com>");
>  MODULE_DESCRIPTION("SPI Compatible PISO Shift Register GPIO Driver");
>  MODULE_LICENSE("GPL v2");
> --
> 2.39.2
>


--=20
With Best Regards,
Andy Shevchenko
