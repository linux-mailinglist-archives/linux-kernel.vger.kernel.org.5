Return-Path: <linux-kernel+bounces-70849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D44859D34
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF61328158A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8E220DD8;
	Mon, 19 Feb 2024 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="G+pEhP16"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E321370
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328658; cv=none; b=tYFjZxErN53dUm7ou1YMjjpcAqGR4Pzu6PCyPac2K+uKP1z9uBfm24Z4FytElhJpOgqtdh+zS6y9ZLNTPbgoRttmLvPskPKVQeuWyD01L8JbC6zyZmKQpJl9a+ncgliFkVDoptkeyI6WQaQY9C4QGPU8x1Bc68ivstBE3nXSJ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328658; c=relaxed/simple;
	bh=7/qPoQrZcFSiHts/pkXzTwa8vDdpEHbTGYy9TW/YEl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLoqqBPXLK3/pqZMD3O7mrBnYpcRZMMgSpyu+v2aEAEcNu1O6mxzwKFLQKATJ/1dCXB+YGmEOonA9l7Gg8fv95CVhOGC+jA1MYXVVTLhIRZ2+r0YkaxAYD1NPo9A6NH+5fanM3KUq8MqEavMGFm0ZxLt2GuByEUOXSCd4a2PZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=G+pEhP16; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d6a772e08dso1273212241.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708328655; x=1708933455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tg3MFuW2EZ67A7xGiTJNMKIfel/eoLDMzTrRgCoVUVI=;
        b=G+pEhP16ey8jfIZnnBOLZmLesMGhN2WpWjS4KCYxhCiqOcJVGhJxdNrmyUydzQw/GB
         Sq9v+pkBEdZ0lKCbUWxvAGihT1Dn0euNrfVvxGicp9ZkGnnWJr+VpawSAHJzncojsyg+
         DJgVU8UrY1IDuCTYvpKSeBi+j4ckqYqO8N3gQdCl1qdMZPCMwlULGXHE2v5yxfiJAD6C
         1jHmOQfjhdfcsB+Wzk85CdzDLegrHIFgIq50YCMKLZQrVvx4+B8SI6Z8xsthmQIGjW+8
         BvBdF2W3AqBp347S6NiHcM/0PDruJZMbEzLQ5F1fyXHB0d+Cn2kR5ZyyauEcKWn10A6i
         m3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708328655; x=1708933455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tg3MFuW2EZ67A7xGiTJNMKIfel/eoLDMzTrRgCoVUVI=;
        b=c7z09fvzGMvj0QUZmnNUBWs512l/Jbk1maI2ot18ZFFCU2fgia83CA6t8T5d6XuCaZ
         ggFcCSO2sdew9w1WgjGWM7GUAxUwryueRIrsCRQfWeoh3+dvICSBoX5JjzO0WDWnDy2/
         +5p56jwXCh99YN1OAwV4zSGoc+F7OVdpcu0RRAGQtXAavt8tU/sUndwA8dvusAtHyEZS
         kaaZwZLvnU3tfeSPJ6Oklzd2gVo5Ro/s0mc73uaGcqqxJdRYmBM6T8bF13M2p8djtpn7
         ihblaR+JAw7kbI6F6TY+KFNvwsGuyGInqAewQFhVrH3OhJt1GbGbKUx9L/4pHTqgSODl
         pEcg==
X-Forwarded-Encrypted: i=1; AJvYcCXT+Pfx4NyJY84hatjGhRPfmLPCPXoIOrS7OPVvmc0JDXg2MazU1DiKiFWrhNrJ6KzadbyHwYniFPZs/yujfhFCucSURjsHgAN/lZ6j
X-Gm-Message-State: AOJu0Yw8eSGOXsEEbyr4c7BVyupkDMuKlbHNbiH6ov3HHBjbbrSHR1Zz
	aag1FBit0M10sTmSp1Dx8nottWxAZWvXM4scCTfhnmTC9sXjUa/qhJmClu2ONZEHZofj9homylX
	1y/kdFgfJ7SVMZOmofDW4b/yLKJDE37gDpiEgqw==
X-Google-Smtp-Source: AGHT+IGunJEBsTI0SmSoWKg+aPSEXOJMsTGF+Un8NyhjOhAtwMpa/tUFgrHw8ZsoB0/YwQv+yUpJYgxlkXCOcm1vhQ0=
X-Received: by 2002:a67:b607:0:b0:46e:e861:fb09 with SMTP id
 d7-20020a67b607000000b0046ee861fb09mr2778487vsm.2.1708328655070; Sun, 18 Feb
 2024 23:44:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218174853.6492-1-brgl@bgdev.pl>
In-Reply-To: <20240218174853.6492-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 08:44:04 +0100
Message-ID: <CAMRc=MffACd5XyGVv4DQO9AhbeYiVhougS8_SJ23xHd-jpfF2g@mail.gmail.com>
Subject: Re: [PATCH] gpio: fix memory leak in gpiod_request_commit()
To: Xiaolei Wang <xiaolei.wang@windriver.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 6:49=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We now copy the label string directly in desc_set_label() so it must not
> be done a second time in gpiod_request_commit().
>
> Fixes: 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
> Reported-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Closes: https://lore.kernel.org/all/20240217135255.1128716-1-xiaolei.wang=
@windriver.com/T/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index e4dd13d81b4d..3c22920bd201 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2250,12 +2250,6 @@ static int gpiod_request_commit(struct gpio_desc *=
desc, const char *label)
>         if (test_and_set_bit(FLAG_REQUESTED, &desc->flags))
>                 return -EBUSY;
>
> -       if (label) {
> -               label =3D kstrdup_const(label, GFP_KERNEL);
> -               if (!label)
> -                       return -ENOMEM;
> -       }
> -
>         /* NOTE:  gpio_request() can be called in early boot,
>          * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
>          */
> --
> 2.40.1
>

I should probably stop coding while sleep-deprived and in the evening,
I realized now I sent the exact same fix as you. I thought this was
removing the allocation from desc_set_label() and not
gpiod_request_commit().

I'll go ahead and apply your patch and you can disregard this thread.

Thanks!
Bartosz

