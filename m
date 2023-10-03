Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1850D7B74F4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjJCXa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjJCXay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:30:54 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFEE90;
        Tue,  3 Oct 2023 16:30:48 -0700 (PDT)
Received: from [192.168.68.112] (ppp118-210-175-196.adl-adc-lon-bras34.tpg.internode.on.net [118.210.175.196])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 799B620059;
        Wed,  4 Oct 2023 07:30:39 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1696375842;
        bh=0DwoPwHtvsNHshbiX0L5U/GGpl/naUYap0pFgc5OoPg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=fup1rsQjI6vuo9F7ghDudR0GDrJtiWkokCJjW2gEiNomV9EFA+PifQ1z6X65JDVkd
         eu3Qv/lLuC/Xq/QAnP32VuWQAfPKFpJzXS1H3PihTjA39WDeswTe+PKzcqmiz2KxQZ
         dVzI57qBkV+WXOLxQrBqfh2lCBko/TlO9vs3XiGBTOHyVN+JSmU7EGD4s//VaOyqxM
         TZAkCouYeQyfBDttjPDWLxV/mAlDk6DJTwDKfVpd1jW7I8HzH+qC6odtOmBLtUwjkR
         Sk68RYBMauvX7fA7NrjYc0l1MWfywAoOQYP1prkTO/rCRRoGP2GBox5XhfvIaCqSen
         26vRJ1Qd4NMKQ==
Message-ID: <6608b6ea673454672fb5930b57e9e7a5570d96d5.camel@codeconstruct.com.au>
Subject: Re: [PATCH 08/36] gpio: aspeed: use new pinctrl GPIO helpers
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Date:   Wed, 04 Oct 2023 10:00:38 +1030
In-Reply-To: <20231003145114.21637-9-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
         <20231003145114.21637-9-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-03 at 16:50 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Replace the pinctrl helpers taking the global GPIO number as argument
> with the improved variants that instead take a pointer to the GPIO chip
> and the controller-relative offset.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-aspeed.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index da33bbbdacb9..d3aa1cfd4ace 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -750,12 +750,12 @@ static int aspeed_gpio_request(struct gpio_chip *ch=
ip, unsigned int offset)
>  	if (!have_gpio(gpiochip_get_data(chip), offset))
>  		return -ENODEV;
> =20
> -	return pinctrl_gpio_request(chip->base + offset);
> +	return pinctrl_gpio_request_new(chip, offset);
>  }
> =20
>  static void aspeed_gpio_free(struct gpio_chip *chip, unsigned int offset=
)
>  {
> -	pinctrl_gpio_free(chip->base + offset);
> +	pinctrl_gpio_free_new(chip, offset);
>  }
> =20
>  static int usecs_to_cycles(struct aspeed_gpio *gpio, unsigned long usecs=
,
> @@ -973,7 +973,7 @@ static int aspeed_gpio_set_config(struct gpio_chip *c=
hip, unsigned int offset,
>  	else if (param =3D=3D PIN_CONFIG_BIAS_DISABLE ||
>  			param =3D=3D PIN_CONFIG_BIAS_PULL_DOWN ||
>  			param =3D=3D PIN_CONFIG_DRIVE_STRENGTH)
> -		return pinctrl_gpio_set_config(offset, config);
> +		return pinctrl_gpio_set_config_new(chip, offset, config);

Ah, this looks like it removes a bug too. Nice.

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

>  	else if (param =3D=3D PIN_CONFIG_DRIVE_OPEN_DRAIN ||
>  			param =3D=3D PIN_CONFIG_DRIVE_OPEN_SOURCE)
>  		/* Return -ENOTSUPP to trigger emulation, as per datasheet */

