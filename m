Return-Path: <linux-kernel+bounces-101240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C14C87A47E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600C41C21BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999281B7EF;
	Wed, 13 Mar 2024 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MycfQvPN"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160031AAD4;
	Wed, 13 Mar 2024 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320558; cv=none; b=QSUgsGzoy+bxRH0K0JjpTFyCOOEU6YDISJstXcgURoy/WuXtL1yJ9OQPto9XbAB2iZj4GOVM+ReSWkR7We6Odl8Wo/TCi0HaiNt0UZXHrnlsxVR2heLQDHV8VrUyANE6URa+y008jwwkzYl84bbtvsTCuGblLGGzR2mxrZhGFlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320558; c=relaxed/simple;
	bh=W3MX+DIfQCMEinvY+Opj0jrGMavyNe+dauQPU3864bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A96YDPwLw10+1tCW7yxIw5ksIyYHGu9t/t0a1GQS2WBJ1u6KEAA8xq2h0JXskMmaKWuFjB6zdnQtGy3EcxvpWaDCq/dJbC6ApgzyFWDjE2c7gHGhGDqGQ3CxZei16A53QPKZRJt2/hO0yPs1HwgOcUJNS2orpVp17Na555MQ5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MycfQvPN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a465ddc2c09so33116366b.2;
        Wed, 13 Mar 2024 02:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710320555; x=1710925355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJ4UuBVuPwsgjmRRNq5Hw3TTHQUgO9YD/ZhBcEygeF4=;
        b=MycfQvPNlTtztGBYtxaqVsAeBZcylDt4GUTtO2WsaBNGxINQly8V183GnYRzHIAW3J
         1fxezVdxFYbe3JGX+rhCZVNzbgA/+LtMKvAGzny4dx6eiOqDtitiUp3nVScbqXqD3ZoJ
         Re+uJYo4OVfr3QkvJhH8e4zkMGhPsLKcxV017vvfL964MRb7DopnG83FwQzxJib14INX
         OKr6+zYZBPfeHBOR41oyUrwbdwTOUGBR38qDqefRoETTVaW2i3FS5ORcfx0aE7MQtjkV
         4s5p45bFrpx7Ruohn5MBXNw+L5cF7/NrfVWSlnHmOevMYLxypUMLgzAfcW3E44C/I/xs
         9x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710320555; x=1710925355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJ4UuBVuPwsgjmRRNq5Hw3TTHQUgO9YD/ZhBcEygeF4=;
        b=rT2T1WdoKFTw36BWZZfMy/X2u0J71w+AZszMtvXyfskhg07zFjJbuNaoijER45sXeP
         VfmldoupapXTtTeJ5kg/rnzWo7M5DrAJD5pC2TzRhSL7FSg5z1LqZaW+cmUb2MJxrYcr
         z8UTSpM2HqqCV4fqykBFjngNCTKpJwY6GUFjlZyiaC7JrEEHnhpjHUp3Wsay3NHJiHSV
         rKjumApEqDo35gxXp+gi9wql4ImmGL3+hUgXpLrwGSC11nKyaEfjKNbOISBaf2RriPpc
         bF8IzXwD/p3jFzQrC57OeBzEV+4lV188/WUnQc5VYTas0Ft4ptedveZxj0ONBaW83Xot
         7mQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnZGn5wkKj6q125VYTFq0m1A753cSsP7yaxHmi8m8lrVY4eMz75x004PqAi4k4h+hciK136ak2Sm/ED8J4FOC6x2zhDt2qC/dzBfT3+9GvYc2XjJcxkbIHEvJ6XjEgcKZBJiU5Uvhs4A==
X-Gm-Message-State: AOJu0YwdO+4c1Q2ZhwuUqBmeN46yGs7fgOdx+IER0cBHlMFcc2+bbvFV
	QFZHhEGRBeYaBddfxD1naotnmY4pxulxwgxH83VVRFekKK0O8uYJTtET9lnFTtrqEv0nW+BMVc8
	iug3oSYo75kKtE0SW4cKZgYhLw3g=
X-Google-Smtp-Source: AGHT+IFXvMw4RamLq0PUCkT8uQyv+/driiRPj3QMgTtbNWQM+mzkMj3dQIEkEGmdmXFljDauf/6ZGQqw6/F+aWrlNLg=
X-Received: by 2002:a17:906:6d4d:b0:a46:54c8:96f1 with SMTP id
 a13-20020a1709066d4d00b00a4654c896f1mr807025ejt.55.1710320555277; Wed, 13 Mar
 2024 02:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313081425.2634-1-xingtong_wu@163.com> <20240313081425.2634-2-xingtong_wu@163.com>
In-Reply-To: <20240313081425.2634-2-xingtong_wu@163.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Mar 2024 11:01:59 +0200
Message-ID: <CAHp75Vc_JEcVJA9GbsL5oespp6RHBRstTy8Jr9_pQvEkNh6owA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] leds: simatic-ipc-leds-gpio: add support for
 module BX-59A
To: Xing Tong Wu <xingtong_wu@163.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	Xing Tong Wu <xingtong.wu@siemens.com>, Gerd Haeussler <gerd.haeussler.ext@siemens.com>, 
	Tobias Schaffner <tobias.schaffner@siemens.com>, Henning Schild <henning@hennsch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 10:15=E2=80=AFAM Xing Tong Wu <xingtong_wu@163.com>=
 wrote:
>
> From: Xing Tong Wu <xingtong.wu@siemens.com>
>
> This is used for the Siemens Simatic IPC BX-59A, which has its LEDs
> connected to GPIOs provided by the Nuvoton NCT6126D.

FWIW, LGTM
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Although a couple of minor remarks below.

> Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
> ---
>  .../leds/simple/simatic-ipc-leds-gpio-core.c  |  1 +
>  .../simple/simatic-ipc-leds-gpio-f7188x.c     | 53 ++++++++++++++++---
>  2 files changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c b/drivers/l=
eds/simple/simatic-ipc-leds-gpio-core.c
> index 667ba1bc3a30..85003fd7f1aa 100644
> --- a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
> +++ b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
> @@ -56,6 +56,7 @@ int simatic_ipc_leds_gpio_probe(struct platform_device =
*pdev,
>         case SIMATIC_IPC_DEVICE_127E:
>         case SIMATIC_IPC_DEVICE_227G:
>         case SIMATIC_IPC_DEVICE_BX_21A:
> +       case SIMATIC_IPC_DEVICE_BX_59A:
>                 break;
>         default:
>                 return -ENODEV;
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c b/drivers=
/leds/simple/simatic-ipc-leds-gpio-f7188x.c
> index c7c3a1f986e6..08d8e580b4f1 100644
> --- a/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
> +++ b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
> @@ -17,7 +17,12 @@
>
>  #include "simatic-ipc-leds-gpio.h"
>
> -static struct gpiod_lookup_table simatic_ipc_led_gpio_table =3D {
> +struct simatic_ipc_led_tables {
> +       struct gpiod_lookup_table *led_lookup_table;
> +       struct gpiod_lookup_table *led_lookup_table_extra;
> +};
> +
> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g =3D {
>         .dev_id =3D "leds-gpio",
>         .table =3D {
>                 GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_=
LOW),
> @@ -30,7 +35,7 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_t=
able =3D {
>         },
>  };
>
> -static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra =3D {
> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra_227g =
=3D {
>         .dev_id =3D NULL, /* Filled during initialization */
>         .table =3D {
>                 GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_=
HIGH),
> @@ -39,16 +44,52 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio=
_table_extra =3D {
>         },
>  };
>
> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_bx_59a =3D {
> +       .dev_id =3D "leds-gpio",
> +       .table =3D {
> +               GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_=
LOW),
> +               GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 1, GPIO_ACTIVE_=
LOW),
> +               GPIO_LOOKUP_IDX("gpio-f7188x-5", 3, NULL, 2, GPIO_ACTIVE_=
LOW),
> +               GPIO_LOOKUP_IDX("gpio-f7188x-5", 2, NULL, 3, GPIO_ACTIVE_=
LOW),
> +               GPIO_LOOKUP_IDX("gpio-f7188x-7", 7, NULL, 4, GPIO_ACTIVE_=
LOW),
> +               GPIO_LOOKUP_IDX("gpio-f7188x-7", 4, NULL, 5, GPIO_ACTIVE_=
LOW),
> +               {} /* Terminating entry */
> +       }
> +};
> +
>  static int simatic_ipc_leds_gpio_f7188x_probe(struct platform_device *pd=
ev)
>  {
> -       return simatic_ipc_leds_gpio_probe(pdev, &simatic_ipc_led_gpio_ta=
ble,
> -                                          &simatic_ipc_led_gpio_table_ex=
tra);
> +       const struct simatic_ipc_platform *plat =3D dev_get_platdata(&pde=
v->dev);
> +       struct simatic_ipc_led_tables *led_tables;
> +
> +       led_tables =3D devm_kzalloc(&pdev->dev, sizeof(*led_tables), GFP_=
KERNEL);
> +       if (!led_tables)
> +               return -ENOMEM;

You can make this smarter, i.e. only allocate memory after the switch
case. But it might require additional code and variables which will be
more churn. So, I'm fine with this approach.

> +       switch (plat->devmode) {
> +       case SIMATIC_IPC_DEVICE_227G:
> +               led_tables->led_lookup_table =3D &simatic_ipc_led_gpio_ta=
ble_227g;
> +               led_tables->led_lookup_table_extra =3D &simatic_ipc_led_g=
pio_table_extra_227g;
> +               break;
> +       case SIMATIC_IPC_DEVICE_BX_59A:
> +               led_tables->led_lookup_table =3D &simatic_ipc_led_gpio_ta=
ble_bx_59a;
> +               break;
> +       default:
> +               return -ENODEV;
> +       }
> +
> +       platform_set_drvdata(pdev, led_tables);
> +       return simatic_ipc_leds_gpio_probe(pdev, led_tables->led_lookup_t=
able,
> +                                          led_tables->led_lookup_table_e=
xtra);
>  }
>
>  static void simatic_ipc_leds_gpio_f7188x_remove(struct platform_device *=
pdev)
>  {
> -       simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
> -                                    &simatic_ipc_led_gpio_table_extra);

> +       struct simatic_ipc_led_tables *led_tables;
> +       led_tables =3D platform_get_drvdata(pdev);

This can be done on a single line.

> +       simatic_ipc_leds_gpio_remove(pdev, led_tables->led_lookup_table,
> +                                    led_tables->led_lookup_table_extra);
>  }
>
>  static struct platform_driver simatic_ipc_led_gpio_driver =3D {


--=20
With Best Regards,
Andy Shevchenko

