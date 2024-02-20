Return-Path: <linux-kernel+bounces-73093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1161B85BD7D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C204A2863B5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC82E6A34F;
	Tue, 20 Feb 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wYTRKQXs"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B76A340
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436841; cv=none; b=D/7fAlO5uOkb/mk1HW8/tLgapo0EduefohXA1Jub3ACvJ7SHBxgtVlw5diw0sziCyITkXM5ZPmvID5Fn4h43DZ9gF0Qe9AQfZkPlJkLitIpHHS8SDVMTgnB7P6AeuOaghSylDLTk1mcQnfHriqQAu3LAYsxn2NJZ/Q+CTuqpwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436841; c=relaxed/simple;
	bh=mE0j+Qrke2cddcGFIvvUiBvzrErWLU7t4wERqe0Rprc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ci/rwpLwwXGSbaatMzgsGSmVAY3nqybfWKQ1xiuiGcQ2aTXMcnaxeXrxbWi4cYN7/B+1Ny0xI3tbIKdE6JA2ZvidynebNBkFnEeMBEYWdNQWWFy3GBK07Hf673o1ok8W8OP2tyyUpiNl0o+ox4oP9jMLEz2trsRjRuxXNcIM1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wYTRKQXs; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4706beefb70so540032137.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708436838; x=1709041638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOKKbkQWU7AKt3SSuiELRArPG+65DzkCYGNRa8cvu24=;
        b=wYTRKQXsnOUrQOG+3MeYA8V9dXihvdD66W7wPJLmR8WMvtvhFTVWMP0qTjLdeuFaE0
         3H/Lt+el78P3WtRC7JRmRq4cpiNNFiPU6x+25j3ule9lJa/nMNvEF6l9VGzl/28bSq4c
         dfMNRyeQS4vHZQDZJV9D+Kp2/r6U+XLj4QvaP1zHhi4Yz3tkN/hihiNI9Xhv5q3Jejvu
         L4ykgGQkZQb2lvAMoZGh0BJC+5/HAQcVcLr+WippT3R5Vl43YE0FynkCNvfwDek9sXM7
         X3M6M7lziiRZVwy7cJNPwHJ68JrfqgTxR+OvHgQcJwARjNLs20357sUX5pNRLhkKIczj
         /1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708436838; x=1709041638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOKKbkQWU7AKt3SSuiELRArPG+65DzkCYGNRa8cvu24=;
        b=mrK3WErFTjRkoOh/iqP0shgH31WoMDc34kCpcLkdGgp8GpfpqLcLJy79LFnGWPNIoa
         E5lQ8euBCUCmrrjWs/9AD0L0kyZNLZfTER05Kp4VjGmRCv9YH90chwwwOmi2TiurvRrY
         mDlA9Mnz+naqKugRViE4uF4XTbZTubhN0uBEQZN2Dzpi3zlKZqzAFok/H6eY/6arfT9B
         7PM4K077MBXo8LnL2shVCtUDttgDPttBlrT58rvniB7rLItVhOti31NlPZrU5xSTfsN5
         VtXjsc6EwCSIlIG8qWSMifw4AK3Jdmme0WC5Gqkoh36iaLiAWt0PgoyQrnvQc0uTy+Ql
         jxVg==
X-Forwarded-Encrypted: i=1; AJvYcCUZMQjKfhE6Wmtc7PjXNVl458WpmJG3znFI+3UNrlny/do0dhkf2cvqmtftyGWVhk/qW85TEbCgqqz0sqigxtm2MzPH59lczTM6F5s0
X-Gm-Message-State: AOJu0Yx+RJZk8WCRNM/DUTFzk8hHvahNfELAZcXBMrCzuGu24zB6swgQ
	wO9r37NALOA7XC7FhqdaAuD0R+NGX1kEzlvNQfMtSsxqyYO7HQ6I2sL5AnVSFFfz2M5mF2E9+pO
	xhUZ5srJhxQ2VAozID9B/3n13LmcuAbXurDd5vA==
X-Google-Smtp-Source: AGHT+IGLCernra2jUl0A5+U2XB+a/z0FjsKHUQpK3wonJZJuh3Ofef/exclTOHmsAoggIscjPYbwp2F278HDfRp749E=
X-Received: by 2002:a67:fa93:0:b0:470:5cbc:4f4c with SMTP id
 f19-20020a67fa93000000b004705cbc4f4cmr3232337vsq.16.1708436836995; Tue, 20
 Feb 2024 05:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220111019.133697-1-herve.codina@bootlin.com> <20240220111019.133697-2-herve.codina@bootlin.com>
In-Reply-To: <20240220111019.133697-2-herve.codina@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 Feb 2024 14:47:06 +0100
Message-ID: <CAMRc=MdFuJGm2AUq45SkR8SpNDg-4Qe58fc7+ow0Oy+==aACnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpiolib: call gcdev_unregister() sooner in the
 removal operations
To: Herve Codina <herve.codina@bootlin.com>
Cc: Kent Gibson <warthog618@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:10=E2=80=AFPM Herve Codina <herve.codina@bootlin=
com> wrote:
>
> When gpio chip device is removed while some related gpio are used by the
> user-space, the following warning can appear:
>   remove_proc_entry: removing non-empty directory 'irq/233', leaking at l=
east 'gpiomon'
>   WARNING: CPU: 2 PID: 72 at fs/proc/generic.c:717 remove_proc_entry+0x19=
0/0x19c
>   ...
>   Call trace:
>     remove_proc_entry+0x190/0x19c
>     unregister_irq_proc+0xd0/0x104
>     free_desc+0x4c/0xc4
>     irq_free_descs+0x6c/0x90
>     irq_dispose_mapping+0x104/0x14c
>     gpiochip_irqchip_remove+0xcc/0x1a4
>     gpiochip_remove+0x48/0x100
>   ...
>
> Indeed, the gpio cdev uses an IRQ but this IRQ is not released
> (irq_free() call) before the call to gpiochip_irqchip_remove().
>
> In order to give a chance to the gpio dev driver to release this
> irq before removing the IRQ mapping, notify the cdev driver about
> the gpio device removal before the gpiochip_irqchip_remove() call.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/gpio/gpiolib.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 8b3a0f45b574..079181b9daa8 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1051,6 +1051,13 @@ void gpiochip_remove(struct gpio_chip *gc)
>
>         /* FIXME: should the legacy sysfs handling be moved to gpio_devic=
e? */
>         gpiochip_sysfs_unregister(gdev);
> +
> +       /*
> +        * Tell gcdev that the device is removing. If any gpio resources =
are in
> +        * use (irqs for instance), it's time for gcdev to release them.
> +        */
> +       gcdev_unregister(gdev);
> +
>         gpiochip_free_hogs(gc);
>         /* Numb the device, cancelling all outstanding operations */
>         gdev->chip =3D NULL;
> @@ -1085,7 +1092,6 @@ void gpiochip_remove(struct gpio_chip *gc)
>          * be removed, else it will be dangling until the last user is
>          * gone.
>          */
> -       gcdev_unregister(gdev);
>         up_write(&gdev->sem);

Please rebase it on top of the for-next branch of the GPIO tree. We've
had some significant rework recently, we no longer even have this
semaphore.

Bart

>         gpio_device_put(gdev);
>  }
> --
> 2.43.0
>

