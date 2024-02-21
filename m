Return-Path: <linux-kernel+bounces-75612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DA685EBF4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7A7B254D0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1B12D758;
	Wed, 21 Feb 2024 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBIhantO"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634DB1292F2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555550; cv=none; b=rJ6wBA6Ubn/tsT6rRDEHCSiz0t0gpzjcJZ1FlDgZiGifU4jndiS4gNA/YjBMKpyJNBQzedSLysasKWMN6mTNMd01nVZij2UXR1irlIZa3yQ3PYmJIKVC9mV2FI8EZCLp+yfCFUOjDzPrE3QGghwJfgigoh6IGhQl6VNxT53SQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555550; c=relaxed/simple;
	bh=PzPmVzNR72x1DSNGKMlcRbhI9DT2jbL/sgZikt4MkkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itakz7MmnnGrIylgbZDwoHierPALKhPjM0vcnACNfjebuifVWeq9YVbZ8g9hpfTKB68PTGRe6HUabNtBsTteZhmwCl7QfKUKzZcHRydZTeQYJM9IgIMe5GjyY8LyFIMmBdx0Og8CvOMeHALOUInAcXxRWROg58q12yXKsyRtrxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CBIhantO; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6002317a427so60668927b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708555542; x=1709160342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLealWf5HBstatX5jbeT2siWwuvRI4tzv53uDOTCcKI=;
        b=CBIhantOZlZ+uRI0NZLRnfNfKOPmxZRiUNDr6ksmw3kpBlT8EpGW+GTnXRFEINAsl5
         0ezEqbqfa3GRY53cAlDGKtXhvL8g0cTalLgomkFWnzfqTeaY4Y2y/yDHCSS00tpHgt6E
         G0/Evap/sfAR2DZD36H+nMQdE6+ZCOq7hhSCSg3kdEmEfR0uPI7TfkgXspOBhx4OGCQD
         bE5GD9u3mwGKl7PkqLi7cp46DhwE1r6nmSNxoHhISdoITndrP/KY4BOYG1Z2HpLhgWdX
         X6LWmMhbEbDiEkJGQ/Rtmz/QkPPmAeNdJtjhy0nvap6c6nD9/ezFr1xbonNbQXz3dYwH
         +4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708555542; x=1709160342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLealWf5HBstatX5jbeT2siWwuvRI4tzv53uDOTCcKI=;
        b=U7egvAl9vbs+YtbPrnC5pon0F2wDKdCeYZp2/H0bRLwVbB/8sMCc0WQ/QIiq1YGAZs
         szSIJN2E7EVIReVF8/bbjO+IbcaSck0fTpW0A+emMpPl1/7Rf21E+XUlRV/MtNpyFkXu
         48p1KXc2cWBqW40U/FBoX2IoUSin7pQtvgqp81DsGFQ+JxAtuhrijs2YTPnoFZ2Ej2ki
         8I65U5hcF10u5QEXHJOM2VoiUP1zP5LnJxhmTL+EMNCeSj3sMwKzGbKrlbd7uejOt6IX
         MqKXlavSM081+js3mUrevDa54caljYHUXgNzGK822rKHhrrZPaAxr/iHtsrGxsmctyiI
         rvAw==
X-Forwarded-Encrypted: i=1; AJvYcCU0LV/zacKhF9wy9ymsIMN98GjcaakjpeqzLQetHm9MnbO5QGVBhLSPTZ9INmEDoHjjlneS9v2Vk3QY2UYYaCHYwUrRAvK2xA834HeU
X-Gm-Message-State: AOJu0Yx3AnWtZpyimIjZjRYxzz0hokqGe5jWZTeLpo/S8VOo0x1b5qMR
	PVdiCAC2H/z2fwju6eTtutvH8ARu1K464WJY0cODyNnAIYb9gAmgtko60wb9yDlXBb4QEOaSY/N
	KezebLLEYJ0XCan1jj39y6EsBGzLZny/06fzuPg==
X-Google-Smtp-Source: AGHT+IEAbOt0U475gEe5FkMJwU7SU74wskhh7ls1GEZkCyuz898a19Y3NlIdf1mAPQo4igt+D+F2bAX0hsvHDSXIFM0=
X-Received: by 2002:a0d:d60a:0:b0:604:b6b2:1fc9 with SMTP id
 y10-20020a0dd60a000000b00604b6b21fc9mr19084807ywd.49.1708555541895; Wed, 21
 Feb 2024 14:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220111111.133826-1-herve.codina@bootlin.com> <20240220111111.133826-3-herve.codina@bootlin.com>
In-Reply-To: <20240220111111.133826-3-herve.codina@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 23:45:31 +0100
Message-ID: <CACRpkdZA1a6xxPL7hP_B4e0b5PoCv8CNhnxvM+dR5TGYkYv7Nw@mail.gmail.com>
Subject: Re: [PATCH 2/2] leds: gpio: Add devlinks between the gpio consumed
 and the gpio leds device
To: Herve Codina <herve.codina@bootlin.com>, Saravana Kannan <saravanak@google.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Saravana needs to look at this patch too, so I am top-posting.

Yours,
Linus Walleij

On Tue, Feb 20, 2024 at 12:11=E2=80=AFPM Herve Codina <herve.codina@bootlin=
com> wrote:

> When a gpio is removed, the gpio leds consumer need to be removed first.
> This dependency consumer/supplier can be described by devlink links.
> In case of device-tree, even if some devlinks are created due to the
> presence of gpio phandles in the gpio leds children, these links do not
> help in removing the gpio leds device (i.e. the real consumer) before
> the consumed gpio.
> We can reach cases where the gpio are no more present and the gpio leds
> driver continue to have leds using these gpio.
> Further more, when the gpio come back, the gpio leds still use the old
> removed one.
>
> Indeed, the gpio are consumed by the parent of the consumer used in the
> devlink creation due to phandles. A link is missing between the gpio and
> the real gpio consumer, the gpio leds device itself.
>
> Use the newly introduced gpiod_device_add_link() to create this
> missing link between the gpio leds devices and the gpios.
> With that done, if a gpio is removed, the gpio leds is removed and the
> resources are correctly released.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/leds/leds-gpio.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index 83fcd7b6afff..b3ec8ecbe5da 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -150,6 +150,7 @@ static struct gpio_leds_priv *gpio_leds_create(struct=
 device *dev)
>  {
>         struct fwnode_handle *child;
>         struct gpio_leds_priv *priv;
> +       struct device_link *link;
>         int count, ret;
>
>         count =3D device_get_child_node_count(dev);
> @@ -197,6 +198,20 @@ static struct gpio_leds_priv *gpio_leds_create(struc=
t device *dev)
>                 /* Set gpiod label to match the corresponding LED name. *=
/
>                 gpiod_set_consumer_name(led_dat->gpiod,
>                                         led_dat->cdev.dev->kobj.name);
> +
> +               /*
> +                * Create a link between the GPIO and the gpio-leds devic=
e.
> +                * This allow to have a relationship between the gpio use=
d and
> +                * the gpio-leds device in order to automatically remove =
the
> +                * gpio-leds device (consumer) when a GPIO (supplier) is =
removed.
> +                */
> +               link =3D gpiod_device_add_link(dev, led_dat->gpiod,
> +                                            DL_FLAG_AUTOREMOVE_CONSUMER)=
;
> +               if (IS_ERR(link)) {
> +                       fwnode_handle_put(child);
> +                       return ERR_CAST(link);
> +               }
> +
>                 priv->num_leds++;
>         }
>
> --
> 2.43.0
>

