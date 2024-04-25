Return-Path: <linux-kernel+bounces-158570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E08B2239
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537121F26363
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7F0149C41;
	Thu, 25 Apr 2024 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jUhexmaV"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29921149C4F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050420; cv=none; b=kX/9RBMlgS3lbdFUYt1sQigIinD881Ndk27A61Lj5f5s6XoKPx1PpcCMZcrtX/jPpkj7R04QRX9kFJ7vIC+rcrIn9E25rOM6S/7QfFN9qLMuAcupcNGNSRanAOkJP8QxISzhnsCEYwzRzMZdB9YmxGqUNUkRjl4OdV7S+C7pR7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050420; c=relaxed/simple;
	bh=iCLpk1XYOML5rjW/DzWQBTxUzuHTUhaSKVXX0JoQ3Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S25XEhU65i5s5N6gRtK+p/Xu/pg1kexLj+UnX/1cA8+3P0+a6mPBw9jhlFl/aiE1Lc75XEq0QtRTsdrlhGYL4P0ou6HNqPeaaHfOHjL6yAMrw6LwI7CoglSzA7O5eNIGKIx6oFPa7dVhhyjlYjMt7S8WTZ2U4WbG9dt5TdT+kwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jUhexmaV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d872102372so15742991fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1714050416; x=1714655216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXjxjK1s1trKrgIcuofImk0hlW/Fp+pJsvVfi+fABag=;
        b=jUhexmaVg3+VvIhtKVjrGJT/suS68SwbTxEHzojrrWp0Q55MrZoXxZyCbKkVrQ/6bx
         ju8IHHDJ5c/jMOr4UPeLE8+vJNyWBNEO7suLpacoeiDSHT9gIK7FpMFA0TrXiew1G7KO
         6lsNAlXIDfze8Ak2cecflHIHN/IHNF0/d1Y/wuD1w8LO3Kxsn2Ep5A0NYaQkvzEqapRp
         9EEsj6nrs8q2L6hMY8fbdrKg4mhWYIud31Z6gd+5fxlJp5ApmKL/W2nmqID5+74MScRb
         WIKNHmWi7NbNXKDdOJDdigtBTCZVOL2PRUeNwsTNAE/SkfdbxMeI3E97Y5alJTH7BoqX
         3jNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714050416; x=1714655216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXjxjK1s1trKrgIcuofImk0hlW/Fp+pJsvVfi+fABag=;
        b=WPEqjRvIsa8p6HN++oS8vqymaDOQz5uPwU+K6b9k7RbXyLhedGKb5XT27aaoLPYGFv
         /Q2YKU1INEDC/LYDAmhW5hSzaDFPGwnUu8tNyrZfKZFPkDMX/0WaEI+3zKwN5RkRu72J
         BrA1fUu/dDrVZz2tqJmTykK5S90HjZk+MiDnKCt4tRk6dpoe4BVUXlIQMWEb99CMy2ox
         p3hC3Dj+RKx131wBVdlq/YL9FlEM72kQ9R/nYxBWffecHbDfVYBKUHlqwA5ltSgoTajj
         /RyYuFNzMjNVpCMClwi7vR6hEigvEahRA66/qFn4O+bpLwXfXOUOV6+XYd/LrSTYkgt3
         20Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWgIRLBQeYMizO1tEL5sA/9cODS8xu6j2QxODHGpM5/ZZoKbyl1iWaG/vX9imQOU+3nYMFHbN9PZdJo1KVWyjyUNxFdjryzCIzPWrBN
X-Gm-Message-State: AOJu0YzyDh3dYHRUmP5z3wolH8iFKA5DtKak407na9crYIfm/bjsqfjq
	dfiD9RFpu9WYv11ryS8BgYATVR1z+nntbi7rZLUdWGeNU3yLg1vEt+oj64EbAsvvv9nSWQkqz7L
	bzFDmFICRHndAN6J3bSFJfeudYrjPhWkH/bhz2w==
X-Google-Smtp-Source: AGHT+IEOISNStsO/9+WhdVo2RtgV8uceX8S2G+eTOusKA26PiwFvCdNPq3Iw+sCaXY1CsixaLmp+nRqIEwhJ7bS+kyg=
X-Received: by 2002:a2e:90d4:0:b0:2dd:c2eb:66db with SMTP id
 o20-20020a2e90d4000000b002ddc2eb66dbmr913164ljg.14.1714050416212; Thu, 25 Apr
 2024 06:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423022814.3951048-1-haibo.chen@nxp.com> <CACRpkdaRxoEZT1_KyJ3QMDgBcciw1XUXKr=cEiPxbcwSnpmyiA@mail.gmail.com>
 <AS1PR04MB9502BE89834E7F9DA3E8D70B90112@AS1PR04MB9502.eurprd04.prod.outlook.com>
 <DU0PR04MB949691D7F68E2F32371B604F90102@DU0PR04MB9496.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB949691D7F68E2F32371B604F90102@DU0PR04MB9496.eurprd04.prod.outlook.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 25 Apr 2024 15:06:45 +0200
Message-ID: <CAMRc=McQtohbuUSrhH8LiF6EWUzRKyHSObBv4D6VeE87NmdZQQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: vf610: always set GPIO to input mode when used as
 interrupt source
To: Bough Chen <haibo.chen@nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 1:01=E2=80=AFPM Bough Chen <haibo.chen@nxp.com> wro=
te:
>
> > -----Original Message-----
> > From: Bough Chen
> > Sent: 2024=E5=B9=B44=E6=9C=8823=E6=97=A5 20:21
> > To: Linus Walleij <linus.walleij@linaro.org>
> > Cc: brgl@bgdev.pl; linux-gpio@vger.kernel.org; linux-kernel@vger.kernel=
org;
> > imx@lists.linux.dev
> > Subject: RE: [PATCH] gpio: vf610: always set GPIO to input mode when us=
ed as
> > interrupt source
> >
> > > -----Original Message-----
> > > From: Linus Walleij <linus.walleij@linaro.org>
> > > Sent: 2024=E5=B9=B44=E6=9C=8823=E6=97=A5 19:41
> > > To: Bough Chen <haibo.chen@nxp.com>
> > > Cc: brgl@bgdev.pl; linux-gpio@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; imx@lists.linux.dev
> > > Subject: Re: [PATCH] gpio: vf610: always set GPIO to input mode when
> > > used as interrupt source
> > >
> > > On Tue, Apr 23, 2024 at 4:28=E2=80=AFAM <haibo.chen@nxp.com> wrote:
> > >
> > > > From: Haibo Chen <haibo.chen@nxp.com>
> > > >
> > > > Though the default pin configuration is INPUT, but if the prior
> > > > stage does configure the pins as OUTPUT, then Linux will not
> > > > reconfigure the pin as INPUT.
> > > >
> > > > e.g. When use one pin as interrupt source, and set as low level
> > > > trigger, if prior stage already set this pin as OUTPUT low, then
> > > > will meet interrupt storm.
> > > >
> > > > So always set GPIO to input mode when used as interrupt source to
> > > > fix above case.
> > > >
> > > > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > > > ---
> > > >  drivers/gpio/gpio-vf610.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
> > > > index 07e5e6323e86..305b0bcdee6f 100644
> > > > --- a/drivers/gpio/gpio-vf610.c
> > > > +++ b/drivers/gpio/gpio-vf610.c
> > > > @@ -214,7 +214,7 @@ static int vf610_gpio_irq_set_type(struct
> > > > irq_data *d,
> > > u32 type)
> > > >         else
> > > >                 irq_set_handler_locked(d, handle_edge_irq);
> > > >
> > > > -       return 0;
> > > > +       return port->gc.direction_input(&port->gc, d->hwirq);
> > >
> > > Just call vf610_gpio_direction_input() instead of indirecting through
> > > gc->direction_input(), no need to jump through the vtable and as
> > > Bartosz says: it just makes that struct vulnerable.
> >
> > Thanks for your quick review, I will do that in V2.
> >
> > >
> > > Second:
> > >
> > > In this patch also implement gc->get_direction() which is currently
> > > unimplemented. If you are going to change the direction of a GPIO
> > > randomly at runtime then the framework really likes to have a chance
> > > to know the current direction for obvious reasons.
> >
> > Yes, will implement gc->get_direction(), if we did this before, then fo=
r this case
> > we meet, framework will print out error log, save much debug time.
>
> Hi Linus,
>
> I implement gc->get_direction() today, for the case to request one gpio a=
s irq, gpio architecture will first
> call gpiochip_reqres_irq(), if the ROM or Uboot already config this gpio =
pin as OUTPUT mode, will get
> the following log:
>
> [    2.714889] gpio gpiochip3: (43850000.gpio): gpiochip_lock_as_irq: tri=
ed to flag a GPIO set as output for IRQ
> [    2.724816] gpio gpiochip3: (43850000.gpio): unable to lock HW IRQ 11 =
for IRQ
> [    2.731972] genirq: Failed to request resources for 2-0050 (irq 211) o=
n irqchip gpio-vf610
>
> Any suggested method to avoid this case? My previous method works because=
 driver lack of gc->get_direction().
>

Can you make the driver default all lines to input when the device is
being registered? Possibly also revert to input when the line is being
freed?

Bartosz

