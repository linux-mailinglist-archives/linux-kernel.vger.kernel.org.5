Return-Path: <linux-kernel+bounces-131096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FF0898310
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A9D1C25BEC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E93960ED0;
	Thu,  4 Apr 2024 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nlb9scJe"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37D6774E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218845; cv=none; b=djQAJqoNDC0f8BK6/A7VN8bJnk4+hPYJ2eTb7TU9evpczu/WYYO8cJPCESDbY46Mn7cJCTFJFZUhTHDcALL3x5fcJNobiAvFJfGdyWg+/9mMGCU6GNkfXodhX02rTplApW7kpfYxcGlLVVu5INWMB8Dr/RoM3oPxdfxI2DdNgTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218845; c=relaxed/simple;
	bh=DEtDOgJjtwKHKgzbnFh+oYPDkv4+cFLZBBuu6/r7Tl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dg2T0uMLjhUf5PmroDkpJFHMS2uYzWl9kzh3qALusJoF9gtAdmKw9mARMXXyFM2d4De4dIoL3aXqnfPCUbKbW1BS/Rd5WX+Zu5wIPB0fgsEF3YKiXmeixmPDuI3JEbxDuafZXq4BmI7/2hDsHU562qFM/eFwPqZ/4Xj/iRg0nio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nlb9scJe; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516c1bbe314so1069109e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712218841; x=1712823641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA1F4ecNFaqy2INS6J/CJxJtqMknUSKBTL4J/GsVmSk=;
        b=nlb9scJeU/urPmrMrLDA0q2D5EsO4K3OsvIw/tE2jt1ryGv7LhnOnG7Xw6viXkXWy8
         um/+EtNsCGYppQWT73cq5I3jmdLJe8cA2P456b5F9M2St/wKNhI9THg9R+og4HozGsCq
         JdxoS3F8079o9IgkfmLGsoYEddsXZHP0XDlrLso2w1l7v7BW7MU7KGR7GTsER2tQfT6r
         whx0QarqmEv5xPpV41ZfH0wzf1zidzSnxYK2y/TEOEor2BI+KanLJ0ysKVUVWpfUFwTV
         pRGWMP36gkvxbl9rBeQTp5Xk6jFpAhTRDdyVGv76UCfsWQMfuyVrk9DiONbwdSjaELQP
         3A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712218841; x=1712823641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA1F4ecNFaqy2INS6J/CJxJtqMknUSKBTL4J/GsVmSk=;
        b=d/YM3ij0U5QpMbzQxlAtiUUizOUH9KxIYQWxs/JocUfo/K6OMLxxwnVFIbBmPrjGjl
         pxjjMRmk8KMxhSSNfEYu4Q7CF3taoKdFMJglFRUdQ5fgD+byvZNrxYYvor0hSR8vCSEt
         zyoFfEhePXVQ9YNtO0RQ7BI7a5yH27dgtAsdayv9NNma0hGkrwN5pzhchrRrF+NmOAL1
         iYwqnTl6nAG/BcoAB5FkKVdtofWFFURCtC19crJRC5xoWZ0x76sDRqetETWC/34yeFsp
         pI9T+kNz3tgiz/tLzI93aZli22AgYD/sErtQB0x9OZQckxww4AnLp99llVy4xi2eO1rZ
         xRIg==
X-Gm-Message-State: AOJu0YxySLkWWlHt0UwapNSb5RZOlyLvrTxEaQKcxf1aIf873xsoCPAt
	vQm9FqffYY1fWA2EYCB6SSuBdHXzxxXM+PS5CZILKfHxSKgnOCsziA5ndVlWyhaZNRCyOh4n95E
	eivUGMs9M/qIY6teWoYXOBkgO0Z4AvIwpvvfbqW4cJpn8s3m9
X-Google-Smtp-Source: AGHT+IFyqOnNuajgEhPN2lGMEjaFHW2VF+WxCqdJBjBZlhWSuMK+lQfoZZNQECArc2FTcemx21az6fM07HImxUt/XlA=
X-Received: by 2002:a05:6512:6c4:b0:516:c763:b4f9 with SMTP id
 u4-20020a05651206c400b00516c763b4f9mr1773698lff.14.1712218840661; Thu, 04 Apr
 2024 01:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403131518.61392-1-warthog618@gmail.com> <20240403131518.61392-2-warthog618@gmail.com>
In-Reply-To: <20240403131518.61392-2-warthog618@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 4 Apr 2024 10:20:29 +0200
Message-ID: <CAMRc=Mf0DPN1-npNPQA=3ivQd-PMhf_ZAa6eSFjmQ26Y8_Gv=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: cdev: fix missed label sanitizing in debounce_setup()
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 3:15=E2=80=AFPM Kent Gibson <warthog618@gmail.com> w=
rote:
>
> When adding sanitization of the label, the path through
> edge_detector_setup() that leads to debounce_setup() was overlooked.
> A request taking this path does not allocate a new label and the
> request label is freed twice when the request is released, resulting
> in memory corruption.
>
> Add label sanitization to debounce_setup().
>
> Cc: stable@vger.kernel.org
> Fixes: b34490879baa ("gpio: cdev: sanitize the label before requesting th=
e interrupt")
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index fa9635610251..f4c2da2041e5 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -728,6 +728,16 @@ static u32 line_event_id(int level)
>                        GPIO_V2_LINE_EVENT_FALLING_EDGE;
>  }
>
> +static inline char *make_irq_label(const char *orig)
> +{
> +       return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
> +}
> +
> +static inline void free_irq_label(const char *label)
> +{
> +       kfree(label);
> +}
> +
>  #ifdef CONFIG_HTE
>
>  static enum hte_return process_hw_ts_thread(void *p)
> @@ -1015,6 +1025,7 @@ static int debounce_setup(struct line *line, unsign=
ed int debounce_period_us)
>  {
>         unsigned long irqflags;
>         int ret, level, irq;
> +       char *label;
>
>         /* try hardware */
>         ret =3D gpiod_set_debounce(line->desc, debounce_period_us);
> @@ -1037,11 +1048,17 @@ static int debounce_setup(struct line *line, unsi=
gned int debounce_period_us)
>                         if (irq < 0)
>                                 return -ENXIO;
>
> +                       label =3D make_irq_label(line->req->label);

Now that I look at the actual patch, I don't really like it. We
introduce a bug just to fix it a commit later. Such things have been
frowned upon in the past.

Let me shuffle the code a bit, I'll try to make it a bit more correct.

Bart

> +                       if (!label)
> +                               return -ENOMEM;
> +
>                         irqflags =3D IRQF_TRIGGER_FALLING | IRQF_TRIGGER_=
RISING;
>                         ret =3D request_irq(irq, debounce_irq_handler, ir=
qflags,
> -                                         line->req->label, line);
> -                       if (ret)
> +                                         label, line);
> +                       if (ret) {
> +                               free_irq_label(label);
>                                 return ret;
> +                       }
>                         line->irq =3D irq;
>                 } else {
>                         ret =3D hte_edge_setup(line, GPIO_V2_LINE_FLAG_ED=
GE_BOTH);
> @@ -1083,16 +1100,6 @@ static u32 gpio_v2_line_config_debounce_period(str=
uct gpio_v2_line_config *lc,
>         return 0;
>  }
>
> -static inline char *make_irq_label(const char *orig)
> -{
> -       return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
> -}
> -
> -static inline void free_irq_label(const char *label)
> -{
> -       kfree(label);
> -}
> -
>  static void edge_detector_stop(struct line *line)
>  {
>         if (line->irq) {
> --
> 2.39.2
>

