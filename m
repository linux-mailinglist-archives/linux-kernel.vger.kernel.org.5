Return-Path: <linux-kernel+bounces-129650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776FD896DD8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D900C28D50D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789561411F7;
	Wed,  3 Apr 2024 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X56YSJfu"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE1141987
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142886; cv=none; b=Nsj+M2YLORmRDIX2iQvj7KoGqMI0R5BEmflojS7gawM0rh6tZUI0hPKqP7f5ROfylbQCb7QaRAoB6ToWc7msqBIvQC4yGLKDPW7LISfEhoMQjuFUxnilmSMxpCZgIeM+5ouCOfOQjnjbEhVZgwKERH9EfVPSr6BGgLYcZUslsL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142886; c=relaxed/simple;
	bh=4dHen/LG9VvUA4vaNwOXfwrjtdQI8Ef8IuzweWNrq8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eC9mVf0izZ9C0zTsm/jYHhQOyi4JHocMdSSISBBnwFah53Ahp1aToCoi5u1876cLAv5m6KLgaOK0FXfXy8dYILlRm2D01lzff2rTDEVNvzeFcXrm+i7jKlfjU9cNYghxhXbqnbOL61EV5plCRS1gkZf6VQVvtLFCk2DqXX/serA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X56YSJfu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516c1f534caso12266e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712142883; x=1712747683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0nFW594aT7o5X9JZAIpTWGMmhMtKBdSxH8O2b6eDQs=;
        b=X56YSJfuNQOKfWw3DIDCM7V0NtwzalBu++KLxpmSthF5Acf8qgZ1hYPKOvSi8wh1gX
         Yp6xLEE2sO5Cs4tNJmaJp8FMzSKmubUoP3KjSEgOjCwjED9LJpft2CdMcoblsJkrJ9dC
         +/SHvkuzFtkwyZx1QXUzKht0IWA6ZJrtQ8wwyZNd7fh1/9EHHW1SJ4NGgbxwhKr/ruC+
         1lIzUVKobSBcZLk+T5+Jz7U53ksYZXlOPrWJc3MpXYxucuXltmqjQM6+CBtJJ1yefQjD
         q9ISYQvmDyTZR5CMryjcKjlnwgnT4fJ7++VXvDvJc9brrlhdpruyO+iOeGYSi75UTNAx
         8q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712142883; x=1712747683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0nFW594aT7o5X9JZAIpTWGMmhMtKBdSxH8O2b6eDQs=;
        b=Jbq0iiMZm6HX8X3hPm2JbvD0DegsI3b0SPcs6EOS2W8momvItnIerey1fHmVmFku29
         MTfEm+CudFLAIEHg/ydGI+i4BqkMwwnT8xLBBjRpw1O6Zd2DpnYDuKPX//OlMmo4g6L5
         WVj/4QnBWwAboCnWYmRccwb1qtZlMfoGMwObzhEjNzt/yyktlxWKTu+98Cx+uCOJeIuB
         MoffYEbCTcYvf2HOvcR+8F2/j22Q8HYdPK7n8DR5Cb7dtIF8H86zQdRdCFzMjGwUUvM8
         W7xeFze446cgG+wopzVr4SvcL0NJkXR6tq1UhWQBxjtxfWip8HCkflISN6V3STwEwaLz
         aN0A==
X-Forwarded-Encrypted: i=1; AJvYcCUKiXQn+mBLTOpj5TYmroaKX84TN3ySPm90imtvx1Tl15YIHM0BGjs3cxIUjATNjKy1q3fo94RZE/egv5ZnTVplfDvxgo9WlYdIMv6w
X-Gm-Message-State: AOJu0Yxrmf7taubg512pFfYGo+r9zPVg7xxZSX0xXF4xgiGRhBsE2u4u
	OdJhLNG+saJ3uiRZadFCyMKPl4s6bF7kkiOGBqtmcHRo4RXYV9zp/y4LFa6Eu96XCF+x4dfqZOa
	uKhPxVOdqD0KyflY0KpCvGM6HrqVJ35/9VrD2KA==
X-Google-Smtp-Source: AGHT+IG4z+4Ndr++qcPD3IhaBePnk545Jp4QWd/wFfePEK48Nb2+1h6x3A0lxSuntNtHpaS9ouWx4IHGkN/0YtNh8WA=
X-Received: by 2002:a05:6512:1044:b0:515:c9cf:7245 with SMTP id
 c4-20020a056512104400b00515c9cf7245mr4927235lfb.38.1712142883469; Wed, 03 Apr
 2024 04:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326181247.1419138-1-andriy.shevchenko@linux.intel.com> <20240326181247.1419138-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240326181247.1419138-2-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Apr 2024 13:14:32 +0200
Message-ID: <CAMRc=Mea+avqmdRgUhAuZPuEh9F3ET_6gYOGGwb1LunkLv4uVw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpiolib: Do not mention legacy GPIOF_* in the code
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:12=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> We are going to remove legacy API from kernel, don't mention
> it in the code that does not use it already for a while.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 5589e085ba25..f749ece2d3cd 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -364,7 +364,10 @@ int gpiod_get_direction(struct gpio_desc *desc)
>         if (ret < 0)
>                 return ret;
>
> -       /* GPIOF_DIR_IN or other positive, otherwise GPIOF_DIR_OUT */
> +       /*
> +        * GPIO_LINE_DIRECTION_IN or other positive,
> +        * otherwise GPIO_LINE_DIRECTION_OUT.
> +        */
>         if (ret > 0)
>                 ret =3D 1;
>
> --
> 2.43.0.rc1.1.gbec44491f096
>

Applied, thanks!

Bart

