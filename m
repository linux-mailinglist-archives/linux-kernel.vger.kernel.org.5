Return-Path: <linux-kernel+bounces-37212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B0083ACCE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B973EB290DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E260577622;
	Wed, 24 Jan 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="H23NMAEF"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B0D539E;
	Wed, 24 Jan 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108374; cv=none; b=RQ3W9ROypyAMT+4XkOs+KjGh+/3fN83nESpom2ggUalz7fJpCvpFSCjQs9FlfG875jAbfTTUxYsViUf2LtuNSgBSEbSmgCaZDILc42+pptNi51bEe26tX5OyH0vFER+UHakDgV2Or2BCMIS3pOXUST8mlekEHewQi7nMiHLMi0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108374; c=relaxed/simple;
	bh=XTMZ3TgD6xSb7BLokfcv4fi2h3Rrq3qnBQ7vkdE20qg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AUe87YoGdocBCQNFidQwqYozBEsbFEtJlqPfuggBhtGwDvAIWa0lDRcdsXuJIWAvVHj26b5kCmlK5vzsQYp/4mDvvm2Milf2sINJHnvSNqhGHyqFQbOwngmqhEUiyxgh6VwQv/TWzvr2f405e1x81Lf5Fy1kaoF168upP7qQCFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=H23NMAEF; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1706108364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fu/VqkBcTBzDnUp3yweiwVzJaj64g+dNk/wv5JeixR0=;
	b=H23NMAEFsMHlHzf35gHOgrZZF/vPkt8xJg1w4u1ATdzGLZtOsqdjKLCh4S9hPmlpR1YUQr
	584AwSGPeCGehxQyKyI58AYgFz/tjk8wwY2Qb4xyP27X8hipzHpYt4hg19hOfktP64EC8T
	wce+d2MhXNYnWtgYqQuZoETck7io5aM=
Message-ID: <83ad61e2f9d62621f42d8738f6028103fe8bfb94.camel@crapouillou.net>
Subject: Re: [PATCH 19/21] gpio: swnode: replace gpiochip_find() with
 gpio_device_find_by_label()
From: Paul Cercueil <paul@crapouillou.net>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Aaro Koskinen
 <aaro.koskinen@iki.fi>,  Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony
 Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Mika
 Westerberg <mika.westerberg@linux.intel.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Linus Walleij
 <linus.walleij@linaro.org>, Dipen Patel <dipenp@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Hans de
 Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, timestamp@lists.linux.dev, 
	linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org, Bartosz
	Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Jan 2024 15:59:22 +0100
In-Reply-To: <20230905185309.131295-20-brgl@bgdev.pl>
References: <20230905185309.131295-1-brgl@bgdev.pl>
	 <20230905185309.131295-20-brgl@bgdev.pl>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZMLQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5UzFZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtNz8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe+rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIPdlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7Urf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KFlBwgAhlGy6nqP7O3u7q23hRW5AQ0EXQqFwQEIAMo+MgvYHsyjX3Ja4Oolg1Txzm8woj30ch2nACFCqaO0R/1kLj2VVeLrDyQUOlXx9PD6IQI4M8wy8m0sR4wV2p/g/paw7k65cjzYYLh+FdLNyO7IW
	YXndJO+wDPi3aK/YKUYepqlP+QsmaHNYNdXEQDRKqNfJg8t0f5rfzp9ryxd1tCnbV+tG8VHQWiZXNqN7062DygSNXFUfQ0vZ3J2D4oAcIAEXTymRQ2+hr3Hf7I61KMHWeSkCvCG2decTYsHlw5Erix/jYWqVOtX0roOOLqWkqpQQJWtU+biWrAksmFmCp5fXIg1Nlg39v21xCXBGxJkxyTYuhdWyu1yDQ+LSIUAEQEAAYkBNgQYAQoAIBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsMAAoJEHPua9InSr1B4wsH/Az767YCT0FSsMNt1jkkdLCBi7nY0GTW+PLP1a4zvVqFMo/vD6uz1ZflVTUAEvcTi3VHYZrlgjcxmcGu239oruqUS8Qy/xgZBp9KF0NTWQSl1iBfVbIU5VV1vHS6r77W5x0qXgfvAUWOH4gmN3MnF01SH2zMcLiaUGF+mcwl15rHbjnT3Nu2399aSE6cep86igfCAyFUOXjYEGlJy+c6UyT+DUylpjQg0nl8MlZ/7Whg2fAU9+FALIbQYQzGlT4c71SibR9T741jnegHhlmV4WXXUD6roFt54t0MSAFSVxzG8mLcSjR2cLUJ3NIPXixYUSEn3tQhfZj07xIIjWxAYZo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Bartosz,

Le mardi 05 septembre 2023 =C3=A0 20:53 +0200, Bartosz Golaszewski a =C3=A9=
crit=C2=A0:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> We're porting all users of gpiochip_find() to using
> gpio_device_find().
> Update the swnode GPIO code.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> =C2=A0drivers/gpio/gpiolib-swnode.c | 29 ++++++++++++-----------------
> =C2=A01 file changed, 12 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-
> swnode.c
> index b5a6eaf3729b..56c8519be538 100644
> --- a/drivers/gpio/gpiolib-swnode.c
> +++ b/drivers/gpio/gpiolib-swnode.c
> @@ -31,31 +31,26 @@ static void swnode_format_propname(const char
> *con_id, char *propname,
> =C2=A0		strscpy(propname, "gpios", max_size);
> =C2=A0}
> =C2=A0
> -static int swnode_gpiochip_match_name(struct gpio_chip *chip, void
> *data)
> +static struct gpio_device *swnode_get_gpio_device(struct
> fwnode_handle *fwnode)
> =C2=A0{
> -	return !strcmp(chip->label, data);
> -}
> +	const struct software_node *gdev_node;
> +	struct gpio_device *gdev;
> =C2=A0
> -static struct gpio_chip *swnode_get_chip(struct fwnode_handle
> *fwnode)
> -{
> -	const struct software_node *chip_node;
> -	struct gpio_chip *chip;
> -
> -	chip_node =3D to_software_node(fwnode);
> -	if (!chip_node || !chip_node->name)
> +	gdev_node =3D to_software_node(fwnode);
> +	if (!gdev_node || !gdev_node->name)
> =C2=A0		return ERR_PTR(-EINVAL);
> =C2=A0
> -	chip =3D gpiochip_find((void *)chip_node->name,
> swnode_gpiochip_match_name);
> -	return chip ?: ERR_PTR(-EPROBE_DEFER);
> +	gdev =3D gpio_device_find_by_label((void *)gdev_node->name);
> +	return gdev ?: ERR_PTR(-EPROBE_DEFER);
> =C2=A0}
> =C2=A0
> =C2=A0struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
> =C2=A0				=C2=A0=C2=A0 const char *con_id, unsigned int
> idx,
> =C2=A0				=C2=A0=C2=A0 unsigned long *flags)
> =C2=A0{
> +	struct gpio_device *gdev __free(gpio_device_put) =3D NULL;
> =C2=A0	const struct software_node *swnode;
> =C2=A0	struct fwnode_reference_args args;
> -	struct gpio_chip *chip;
> =C2=A0	struct gpio_desc *desc;
> =C2=A0	char propname[32]; /* 32 is max size of property name */
> =C2=A0	int error;
> @@ -77,12 +72,12 @@ struct gpio_desc *swnode_find_gpio(struct
> fwnode_handle *fwnode,
> =C2=A0		return ERR_PTR(error);
> =C2=A0	}
> =C2=A0
> -	chip =3D swnode_get_chip(args.fwnode);
> +	gdev =3D swnode_get_gpio_device(args.fwnode);
> =C2=A0	fwnode_handle_put(args.fwnode);
> -	if (IS_ERR(chip))
> -		return ERR_CAST(chip);
> +	if (IS_ERR(gdev))
> +		return ERR_CAST(gdev);

I'm a bit late to the party, sorry.

I'm looking at how __free() should be used to use it in my own
patchset, and I was wondering if this code actually works.

What happens if swnode_get_gpio_device() returns an error pointer?
Won't that cause a call to gpio_device_put() with the invalid pointer?

Cheers,
-Paul

> =C2=A0
> -	desc =3D gpiochip_get_desc(chip, args.args[0]);
> +	desc =3D gpiochip_get_desc(gdev->chip, args.args[0]);
> =C2=A0	*flags =3D args.args[1]; /* We expect native GPIO flags */
> =C2=A0
> =C2=A0	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' -
> status (%d)\n",


