Return-Path: <linux-kernel+bounces-143266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF908A366F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9331C233F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D8B150986;
	Fri, 12 Apr 2024 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="T4KNrlAX"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D923778
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712950684; cv=none; b=dhG5KsTCwuuVCDxGzvJVNvQiUxt2uUAd+6YItqYMAvj+H9Yj1SsRfdrbpgNmveKXwC6TIPOblF3J1ykMsNx5YQaU6Gnt7ZLAArMaZDktkIlvfZsj95TFrCIurrhPI5Lh24BLvkHbqLCQXXU9cgEUCJ0fbIwobuebfnfAqbPnER0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712950684; c=relaxed/simple;
	bh=gsfELytgY5x4hQcFZxJ/77pYZa6JSOFnKqDvqYK9T2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGDLl9Koh2Idq1AhLe694CUmRjZHuHoASxVN+qcLbAcKMobxcEKswmgpFjHcYMfsDFaUQcX5WLL7jVVar5SS/RVdmlDBFqEIQYyUjnNO8P1Oulx84jA/MA7t3SYxxYwoYNzWfi4fiYozTIVg/108i/ao4GU6j91nsfdc+XXBnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=T4KNrlAX; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d8129797fcso13125981fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712950680; x=1713555480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2cNkGqcGx7IBGriRb2f5XVGGwlgEQtCfumu0ixlvO0=;
        b=T4KNrlAXLK2P4KRlSbaVQ2WLTqvo3eV0de0UdCHDOEMwOPGBom3T0voRkvmDkrI9j6
         HOy4SySsDlyxi6Yqj8KG5DDbFVPwOx3/Bup2wZoy06bTE/QZJo1LApSuM6vHkagWUmxZ
         tnu46ZxWihyTALrj1MX+Y12BXu8bRhBXAJJZjYAV5g977EkujYAuNAVNEWC6ALfvLW+H
         15YkIJbKkhKRJznzeg25gua/oB4xB0X0QJVjkYkaE9azhuXsoCvNygYlc3srocna4B9L
         aSUk5ECd7MniZiC/io27+V1J6CmQE7gxkicse/3gbYRTivU47Gm4kp6pwrE8rdUc63ON
         2G5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712950680; x=1713555480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2cNkGqcGx7IBGriRb2f5XVGGwlgEQtCfumu0ixlvO0=;
        b=diNp8/G2tB6zAlTWsEqPU8GQEkCNnNk0B8WlwIIXYUFNjisdoaYNUmLUpyFJ5oBglH
         QaofdB8KUKTdojliK+YCHK8QZh4e5cxp6LXB/FBvvkfy5UV+tJEMjzh8DhanTDPSHxdp
         ofApTHTEc9AaJBiwRvGRmyg3Ag+YALJGh4v4xcgLqq8ocyv1gI5QpEfpKABscXvn4Op0
         tZvafEjTqDtpibSxGrmkIW1qG2XXEqrO7XoHJLMMIvk2bh2IYcAwI2kC3oUen/WOd0ay
         d4fHO7ROp/goHP+0GDRiHVQYGy8IzhlHiBR3KJBShNDoj1qeP60pntm1wF4BuPA5dL2n
         R03w==
X-Forwarded-Encrypted: i=1; AJvYcCXLEam9/rllmp9SF7FiOGnE7X92DxSM8ExsIsUOaX9dv6Z4ODmRuexGCUGEnQGePl1s3+fL7RlcxdGHJTn2nGDtTEFOdDou0qnYMPDO
X-Gm-Message-State: AOJu0YyTTTS2UGn0f7PW/rEqiijCSINyD7ee5ToIaw4HCCY39BjXdruh
	/cTNIFptv7g8G6IfRrCQJEe2NxDwhBUJK30Pghnl+tZzXsYDF/+HwNbMI98w51m1XrMQtSTi4jJ
	a13Ns3em5PMVzCHrKQ2s1GO6nExfrFdsXVBJYTQ==
X-Google-Smtp-Source: AGHT+IH+jEq8r7U4FkjCa87gOw/vXf0vhISfuOxofd2v8isSrRxKMHv7GbZRCJF16KXpRHCaofniXvLINhCq+pVuZp4=
X-Received: by 2002:a2e:9984:0:b0:2d7:17e0:ff56 with SMTP id
 w4-20020a2e9984000000b002d717e0ff56mr2760451lji.18.1712950680140; Fri, 12 Apr
 2024 12:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410063930.1199355-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240410063930.1199355-1-andy.shevchenko@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 12 Apr 2024 21:37:49 +0200
Message-ID: <CAMRc=McnSbPOTAUMSx6iH_0VAsX0yteofgAyvxQB5sUcV5ni8w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: regmap: Use -ENOTSUPP consistently
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Walle <mwalle@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 8:39=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> The GPIO library expects the drivers to return -ENOTSUPP in some cases
> and not using analogue POSIX code. Make the driver to follow this.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/gpio/gpio-regmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index c08c8e528867e..71684dee2ca5d 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -129,7 +129,7 @@ static int gpio_regmap_get_direction(struct gpio_chip=
 *chip,
>                 base =3D gpio_regmap_addr(gpio->reg_dir_in_base);
>                 invert =3D 1;
>         } else {
> -               return -EOPNOTSUPP;
> +               return -ENOTSUPP;
>         }
>
>         ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> @@ -160,7 +160,7 @@ static int gpio_regmap_set_direction(struct gpio_chip=
 *chip,
>                 base =3D gpio_regmap_addr(gpio->reg_dir_in_base);
>                 invert =3D 1;
>         } else {
> -               return -EOPNOTSUPP;
> +               return -ENOTSUPP;
>         }
>
>         ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> --
> 2.44.0
>

Applied, thanks!

Bart

