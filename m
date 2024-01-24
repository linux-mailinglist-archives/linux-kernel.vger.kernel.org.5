Return-Path: <linux-kernel+bounces-37221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88DC83ACD8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572741F2743B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC6F747A;
	Wed, 24 Jan 2024 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="XHbfH8oS"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD218624;
	Wed, 24 Jan 2024 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109097; cv=none; b=Dy7wSot6/wAYy7iqGjgE9LkS+I/vYUpoYe+IuFTCq6aw8DNgN3JSHzdKzg2nzJ7SO4geiHXfUPLGUSknSM8jtOLREaVqeIj+O8gaSDys6Ck1uFbhL7Jeau9TcbVDKmvwUtkiDGfgUpv5S9UtbEdniJygByeyVwHpR2qIXSYrYG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109097; c=relaxed/simple;
	bh=/7zykiUMwKCT+cqhXM9vhXh0wXFxTsw+vjXT9OyNpRU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WSu40jAhrwBG3JGg1jePvWEJP77RWeLn9szKzb5oZht64dP/cJYQXVXWiBqzoOGjKUI/t8B9C9Egr/ADVnTRVBkR1PiRo+n/Wvv4YLOc1z98z4dEdPuCLH/l1Ec5NeUqNFccpsn0Y9iHrYBTlyMlGeizNYodtWy8OZFyVm4xkcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=XHbfH8oS; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1706109093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/7zykiUMwKCT+cqhXM9vhXh0wXFxTsw+vjXT9OyNpRU=;
	b=XHbfH8oSQ1eYQEjvSqRaFgu1O7+6DEE3Bqq+bpSxUvFfcodlayBJdfA9jegOqweYOSKK2r
	/KyalUhsiufhcd0d/5HoqFQ6Xtw5tnXGoUbZGeq6T/8wMMcvfAAjfcfaPjvjmWQQ0nxmTI
	Kc2103WusQg+C2WRzK7BrGMiLweZvBw=
Message-ID: <26455575da695f26570392a333e7466a01a338e5.camel@crapouillou.net>
Subject: Re: [PATCH 19/21] gpio: swnode: replace gpiochip_find() with
 gpio_device_find_by_label()
From: Paul Cercueil <paul@crapouillou.net>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik
 <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King
 <linux@armlinux.org.uk>, Mika Westerberg <mika.westerberg@linux.intel.com>,
  Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij
 <linus.walleij@linaro.org>, Dipen Patel <dipenp@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Hans de
 Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>,
 linux-arm-kernel@lists.infradead.org,  linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org,  timestamp@lists.linux.dev,
 linux-tegra@vger.kernel.org,  platform-driver-x86@vger.kernel.org, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Jan 2024 16:11:31 +0100
In-Reply-To: <CAMRc=MdwAaQ1Prtweu9znEL+mbyxSmmKhL65PG+=YKniCD1c9w@mail.gmail.com>
References: <20230905185309.131295-1-brgl@bgdev.pl>
	 <20230905185309.131295-20-brgl@bgdev.pl>
	 <83ad61e2f9d62621f42d8738f6028103fe8bfb94.camel@crapouillou.net>
	 <CAMRc=MdwAaQ1Prtweu9znEL+mbyxSmmKhL65PG+=YKniCD1c9w@mail.gmail.com>
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

Le mercredi 24 janvier 2024 =C3=A0 16:04 +0100, Bartosz Golaszewski a
=C3=A9crit=C2=A0:
> On Wed, Jan 24, 2024 at 3:59=E2=80=AFPM Paul Cercueil <paul@crapouillou.n=
et>
> wrote:
> >=20
> > Hi Bartosz,
> >=20
> > Le mardi 05 septembre 2023 =C3=A0 20:53 +0200, Bartosz Golaszewski a
> > =C3=A9crit :
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >=20
> > > We're porting all users of gpiochip_find() to using
> > > gpio_device_find().
> > > Update the swnode GPIO code.
> > >=20
> > > Signed-off-by: Bartosz Golaszewski
> > > <bartosz.golaszewski@linaro.org>
> > > ---
> > > =C2=A0drivers/gpio/gpiolib-swnode.c | 29 ++++++++++++----------------=
-
> > > =C2=A01 file changed, 12 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/drivers/gpio/gpiolib-swnode.c
> > > b/drivers/gpio/gpiolib-
> > > swnode.c
> > > index b5a6eaf3729b..56c8519be538 100644
> > > --- a/drivers/gpio/gpiolib-swnode.c
> > > +++ b/drivers/gpio/gpiolib-swnode.c
> > > @@ -31,31 +31,26 @@ static void swnode_format_propname(const char
> > > *con_id, char *propname,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 strscpy(propname, "gpios", max_size);
> > > =C2=A0}
> > >=20
> > > -static int swnode_gpiochip_match_name(struct gpio_chip *chip,
> > > void
> > > *data)
> > > +static struct gpio_device *swnode_get_gpio_device(struct
> > > fwnode_handle *fwnode)
> > > =C2=A0{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 return !strcmp(chip->label, data);
> > > -}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct software_node *gdev_node;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_device *gdev;
> > >=20
> > > -static struct gpio_chip *swnode_get_chip(struct fwnode_handle
> > > *fwnode)
> > > -{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 const struct software_node *chip_node;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_chip *chip;
> > > -
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 chip_node =3D to_software_node(fwnode);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (!chip_node || !chip_node->name)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 gdev_node =3D to_software_node(fwnode);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!gdev_node || !gdev_node->name)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ERR_PTR(-EINVAL);
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 chip =3D gpiochip_find((void *)chip_node->n=
ame,
> > > swnode_gpiochip_match_name);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 return chip ?: ERR_PTR(-EPROBE_DEFER);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 gdev =3D gpio_device_find_by_label((void *)=
gdev_node->name);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return gdev ?: ERR_PTR(-EPROBE_DEFER);
> > > =C2=A0}
> > >=20
> > > =C2=A0struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode=
,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *con_id, unsign=
ed int
> > > idx,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long *flags)
> > > =C2=A0{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_device *gdev __free(gpio_device=
_put) =3D NULL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct software_node *swnode;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fwnode_reference_args args;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_chip *chip;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_desc *desc;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char propname[32]; /* 32 is max size o=
f property name */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int error;
> > > @@ -77,12 +72,12 @@ struct gpio_desc *swnode_find_gpio(struct
> > > fwnode_handle *fwnode,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ERR_PTR(error);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 chip =3D swnode_get_chip(args.fwnode);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 gdev =3D swnode_get_gpio_device(args.fwnode=
);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fwnode_handle_put(args.fwnode);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(chip))
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ERR_CAST(chip);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(gdev))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ERR_CAST(gdev);
> >=20
> > I'm a bit late to the party, sorry.
> >=20
> > I'm looking at how __free() should be used to use it in my own
> > patchset, and I was wondering if this code actually works.
> >=20
> > What happens if swnode_get_gpio_device() returns an error pointer?
> > Won't that cause a call to gpio_device_put() with the invalid
> > pointer?
> >=20
> > Cheers,
> > -Paul
> >=20
>=20
> No. because the __free() callback is defined as:
>=20
> DEFINE_FREE(gpio_device_put, struct gpio_device *,
> =C2=A0=C2=A0=C2=A0 if (!IS_ERR_OR_NULL(_T)) gpio_device_put(_T))

Ok. I missed this.

I would argue that it's still not right though - it should probably use
IS_ERR() instead. gpio_device_put() only happens to accept NULL
pointers because the "dev" field is at the very beginning of the
"gpio_device" struct. I'm not sure this works with e.g.
CONFIG_RANDSTRUCT_FULL.

> Bart

Cheers,
-Paul

> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 desc =3D gpiochip_get_desc(chip, args.args[=
0]);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 desc =3D gpiochip_get_desc(gdev->chip, args=
args[0]);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *flags =3D args.args[1]; /* We expect =
native GPIO flags */
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("%s: parsed '%s' property of =
node '%pfwP[%d]' -
> > > status (%d)\n",
> >=20


