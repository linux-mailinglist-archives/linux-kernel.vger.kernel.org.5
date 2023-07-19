Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E7175961D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjGSNDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGSNDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:03:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCC91A6;
        Wed, 19 Jul 2023 06:03:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-521662a6c9cso7805804a12.1;
        Wed, 19 Jul 2023 06:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689771795; x=1690376595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnKUHW8UFLtid4Ubf/TR5gF1kp2rPVVoMYNXfQXzKCk=;
        b=Xy7fKCLGjdSSrYUOgLbHGmPetNUKLH5h+yunY01PoIB/Z1Q2MxTicKPkJuatmdQ6hP
         Ici+v3yEWEAYev2zwap9ml1RxWgv+kvta7/YtdX4A+4mPfGodNqV6xelQAAkjGnL1E4U
         MzHFbwfVuk+GJ2PNCrAJZOLtsBCAlNvnXdpbNfnswp7YlRWkg6IbxKK+MVD6rOEBMey2
         /i/ESbJsrtIZ7BcTlXe2pHo/q1qNtyj+4xeUloChiKWRjT44o9nHiU/0UDC5BYPHKz09
         F4o0zkjQbbDiV5R8trgkmfOQDD4Gs5fWFCTMzXTwct9YkmUDYYbPuvF+4QL0fKJRkYeI
         usCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689771795; x=1690376595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnKUHW8UFLtid4Ubf/TR5gF1kp2rPVVoMYNXfQXzKCk=;
        b=Fv50FWB8ZlXnD8exkJIauU/x9Tyi9GVe0zxrrJpQVOzyMFfR4zrYioqLQsuJlUHfKE
         bAScMk3fjzYXUbbtUo7rc0VSZnUZkx99ORruJydWzcuntyqFkJVRZ38Z5tSgRuN35L/O
         FwrUv5GcpdJ46QzqXG81k+RcmD1NICvnV/mLt8ChI2O4ENOUPbC1Zi6C53087McHIPMK
         YV1YCNIZhil9uxVTFIzCNuPFjBZdBsZnOtyqf/znc4R2gB1lSV84ib5ZgvFlSaIG4dMI
         cPitLpJiYaxLKM0M96Nm0Q3jNrLUW5OzfN0XGf7+gaeeW98WpDM2zPuFtGAXW/UNJ6xx
         Xx2A==
X-Gm-Message-State: ABy/qLZITzCfmT6y9IybOILhVw+WahkL2uquMjtB/13B+O9XdYttfy69
        h7PMduZXXfXgWZvXlOls9DQhest73+5SX8d0NfU=
X-Google-Smtp-Source: APBJJlFRsfDdGqFuK/ZoIgov59gBy5DI7HxYHRoXMgRkvk6FyscDNknzkBWElrT0oN3uZDrgoJ+qjYA1aEOSsQtSNLQ=
X-Received: by 2002:a17:906:3e50:b0:97e:aace:b6bc with SMTP id
 t16-20020a1709063e5000b0097eaaceb6bcmr2404806eji.53.1689771795377; Wed, 19
 Jul 2023 06:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230719114101.55051-1-brgl@bgdev.pl>
In-Reply-To: <20230719114101.55051-1-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Jul 2023 16:02:39 +0300
Message-ID: <CAHp75VfdCsAE8dGfTe2PsT5kxvoT84nChNptwgaA4Q5jf5oJvQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: fix irq domain leak
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Wed, Jul 19, 2023 at 2:41=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Uwe Kleine-K=C3=B6nig pointed out we still have one resource leak in the =
mvebu
> driver triggered on driver detach. Let's address it with a custom devm
> action.

One nit-pick below, in either case
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 812d47889a8e ("gpio/mvebu: Use irq_domain_add_linear")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-mvebu.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index a35958e7adf6..67497116ce27 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -1112,6 +1112,13 @@ static int mvebu_gpio_probe_syscon(struct platform=
_device *pdev,
>         return 0;
>  }
>
> +static void mvebu_gpio_remove_irq_domain(void *data)
> +{
> +       struct irq_domain *domain =3D data;
> +
> +       irq_domain_remove(domain);

The from/to void * doesn't need an explicit casting in C. This can be
a one liner

static void mvebu_gpio_remove_irq_domain(void *domain)
{
      irq_domain_remove(domain);
}

> +}
> +
>  static int mvebu_gpio_probe(struct platform_device *pdev)
>  {
>         struct mvebu_gpio_chip *mvchip;
> @@ -1246,13 +1253,18 @@ static int mvebu_gpio_probe(struct platform_devic=
e *pdev)
>                 return -ENODEV;
>         }
>
> +       err =3D devm_add_action_or_reset(&pdev->dev, mvebu_gpio_remove_ir=
q_domain,
> +                                      mvchip->domain);
> +       if (err)
> +               return err;
> +
>         err =3D irq_alloc_domain_generic_chips(
>             mvchip->domain, ngpios, 2, np->name, handle_level_irq,
>             IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_LEVEL, 0, 0);
>         if (err) {
>                 dev_err(&pdev->dev, "couldn't allocate irq chips %s (DT).=
\n",
>                         mvchip->chip.label);
> -               goto err_domain;
> +               return err;
>         }
>
>         /*
> @@ -1292,10 +1304,6 @@ static int mvebu_gpio_probe(struct platform_device=
 *pdev)
>         }
>
>         return 0;
> -
> -err_domain:
> -       irq_domain_remove(mvchip->domain);
> -       return err;
>  }


--=20
With Best Regards,
Andy Shevchenko
