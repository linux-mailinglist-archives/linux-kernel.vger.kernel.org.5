Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440B07B9978
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244263AbjJEBMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241050AbjJEBMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:12:33 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7F8E4;
        Wed,  4 Oct 2023 18:12:23 -0700 (PDT)
Received: from [192.168.68.112] (ppp118-210-84-62.adl-adc-lon-bras32.tpg.internode.on.net [118.210.84.62])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 22EBF200DB;
        Thu,  5 Oct 2023 09:12:13 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1696468337;
        bh=xAxBkEJVdrWYBdGjmgEXDdPp5zXscmuH8qacPOd7/ek=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=eoIzp3TLvlOLS2As2yWm6Y+lulUfPoFLMN47c8hyhA4en1MViwWxFtCxFb5CLJz+e
         ufeii4Unrj8ebwvcJ2VWtid0g87OtRmQTf4H26qSsbsd3QnDCSj0zWHiRJyCe6fOZr
         6sSsZtCjxR2ZctKxXpzuhGMdD2uL5x7Zr3Pr2Y/rmU7w0cllCW7X+JaQyspLJ15L2+
         diC9oBgd1ko/KUlqQIFpkDoYOxR4KmxscrR1sN82SL6TJua+G7QAl6w5d9wE8Ja294
         O6LfaLRSBm/8j/N4fx894/+5i2/yNSqL1W1EpbkdP50GL8nOFRme+uiW5lg3BIMQNk
         yYUeJkyzZgt1A==
Message-ID: <b5b813d156c31d73baf1e153f495e69d3367718b.camel@codeconstruct.com.au>
Subject: Re: [PATCH] gpio: aspeed: fix the GPIO number passed to
 pinctrl_gpio_set_config()
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Thu, 05 Oct 2023 11:42:12 +1030
In-Reply-To: <20231003073926.10771-1-brgl@bgdev.pl>
References: <20231003073926.10771-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-03 at 09:39 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> pinctrl_gpio_set_config() expects the GPIO number from the global GPIO
> numberspace, not the controller-relative offset, which needs to be added
> to the chip base.
>=20
> Fixes: 5ae4cb94b313 ("gpio: aspeed: Add debounce support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks!

> ---
>  drivers/gpio/gpio-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index da33bbbdacb9..58f107194fda 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -973,7 +973,7 @@ static int aspeed_gpio_set_config(struct gpio_chip *c=
hip, unsigned int offset,
>  	else if (param =3D=3D PIN_CONFIG_BIAS_DISABLE ||
>  			param =3D=3D PIN_CONFIG_BIAS_PULL_DOWN ||
>  			param =3D=3D PIN_CONFIG_DRIVE_STRENGTH)
> -		return pinctrl_gpio_set_config(offset, config);
> +		return pinctrl_gpio_set_config(chip->base + offset, config);
>  	else if (param =3D=3D PIN_CONFIG_DRIVE_OPEN_DRAIN ||
>  			param =3D=3D PIN_CONFIG_DRIVE_OPEN_SOURCE)
>  		/* Return -ENOTSUPP to trigger emulation, as per datasheet */

