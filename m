Return-Path: <linux-kernel+bounces-52737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EE0849C13
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688761C20E6C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040C420DC9;
	Mon,  5 Feb 2024 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="m0x5ueIm"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9335249F7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140394; cv=none; b=NLKI3MTM8Mzk/6XNY8x6yKVCR8vhGYCL0KbrSwGPLEgwu/r4/xMl8d7PYCebQl+VvZUemiAPEq5sg4m2T+hsNy4Kof4YVlhxTGabzSmL8rmAMXu0uxhPW86CC0BiY/+tPgmqkOmivf3WX6cvHMhWMs2agPmjTpZUwxtTlHC3nvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140394; c=relaxed/simple;
	bh=E1fJfdB8CjB0DIy+QKlUXOl+wySLvvDWfrhX8O7oy/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kN9ycxWtvxa9ajYaDoH34BELom4I5OIHIUE6klcGNhgZjs+OkxOUBBfyuEKJk5iuIkrRJvAT/YsOfziv31qdOcTxB47Vnhb8GzmDLLQnGsESPm08nZb4wO6h0kdo6oFhDYdklLT6NN2gugVTP2iKb1byxe3OzaopvewojfTflzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=m0x5ueIm; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d5c7443956so2036128241.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 05:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707140391; x=1707745191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9s94OzYLKOZpekLAFb3zLDMjbd7XdgLc/vdftPx6uo=;
        b=m0x5ueImDmLeipQilrBLAh6tr17/3EOCTlPJ5UfP87E22eFc0Z8Lr2/+YSwPY0tbP0
         8aPKLMx0nzyiHO4pCmTLB0T8Q8LjIPFeu2zzmEKyCFYSKg5A5/YLvd/QXcamiwAqR1DL
         oYDtchVrAHSJzAfW5yTHLS+czyrluPXmOkBfNFuYWudsT3djskwCJrMAdJjO6oyz0h7Y
         c8ZNyI7Q2nao1ZbzyYhcQ2g2u8Wu3v9ihCi/FPB2UdYKEtJhLmzS5wUYw9cGI12zxGz8
         qIt2knjMypYzwvUY/LMlL01ku8Z2SJU4dOd6RqLPOyksxeELOGYgUexN9LpaoC1U9Oi4
         JnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707140391; x=1707745191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9s94OzYLKOZpekLAFb3zLDMjbd7XdgLc/vdftPx6uo=;
        b=QQBE0rwYBiY/8UUe1bAzwnIkdo7BD+WxkN98A9QQ4aIZZuF3BzBCPaB6ScX6jNzf//
         00Wv74nl/qsnLr7VLcHfu5usaMfsMqogFkOtEUna0RYJL8rEriZzYaRxZgEqnFu/FP+X
         rt456/vyJPpw9lK5/G2zCV25QRcywnM6U9riMNz7GuECygl+OQlqsqEGsnm1ox3Ok1Ex
         AQrq9tshMB12mTJuRtEmZOlLmpeCaou9y4C6XvoYHxZ3GERaUq887QHbehJOugn11vh1
         fMQ1wd6rrLTihg8JDlrbNtWWtzuag7mGa81gNm00hMPGP3/0owTTUWZhvy3SN+Y/dm1D
         B0fA==
X-Gm-Message-State: AOJu0YzOHfTXCo+LRsDIvs4Rads0qCaLxZDbn1lK+LfIGo8FTLMgtHZi
	+hs0oqLobV9LRS43PXiHzAZOY4pJNQC6ie5unG5HDO8piC49PJ36/XYnNJ4JeBtMdMcEACQ3jc6
	F0zGhcjwP5+vqUxbUl4ZlcJPvU0zEj7o7HxjGIb0VYM06jDUM
X-Google-Smtp-Source: AGHT+IGgnn7xYNjdQ7tyPTGkeNKsQo94aRc1DIhIuoMa59byy25qCsHF9VeDV1ZtGjCVy5BtAZ76w5NyhoFqIc7HreM=
X-Received: by 2002:a67:b345:0:b0:46d:fb6:648e with SMTP id
 b5-20020a67b345000000b0046d0fb6648emr6048400vsm.8.1707140391612; Mon, 05 Feb
 2024 05:39:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205093418.39755-1-brgl@bgdev.pl> <20240205093418.39755-9-brgl@bgdev.pl>
 <ZcDSKYqFHSUZb2Qx@smile.fi.intel.com> <CAMRc=Mfh5CcftXUStGOXvUF-s3aNxnaNM0sDt72LKrBfttqitQ@mail.gmail.com>
 <ZcDkvOrlSRkmYIk_@smile.fi.intel.com>
In-Reply-To: <ZcDkvOrlSRkmYIk_@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 5 Feb 2024 14:39:40 +0100
Message-ID: <CAMRc=MeiXLZ4q8MH5h_wX1rBz9-YVK6UKUdCu2nTb6+uNHGXPQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/23] gpio: sysfs: use gpio_device_find() to iterate
 over existing devices
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 2:38=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 05, 2024 at 02:19:10PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Feb 5, 2024 at 1:36=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Feb 05, 2024 at 10:34:03AM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > With the list of GPIO devices now protected with SRCU we can use
> > > > gpio_device_find() to traverse it from sysfs.
>
> ...
>
> > > > +static int gpiofind_sysfs_register(struct gpio_chip *gc, void *dat=
a)
> > > > +{
> > > > +     struct gpio_device *gdev =3D gc->gpiodev;
> > > > +     int ret;
> > > > +
> > > > +     if (gdev->mockdev)
> > > > +             return 0;
> > > > +
> > > > +     ret =3D gpiochip_sysfs_register(gdev);
> > > > +     if (ret)
> > > > +             chip_err(gc, "failed to register the sysfs entry: %d\=
n", ret);
> > >
> > > > +     return 0;
> > >
> > > ???
>
> What the point of function to be int if you effectively ignore this by al=
ways
> returning 0?
>

Because the signature of the callback expects an int to be returned?

Bart

> > Not sure what the ... and ??? mean? The commit message should have
> > read "... traverse it from gpiofind_sysfs_register()" I agree but the
> > latter?
>
> I didn't realize this may not be obvious :-(.
>
> > > > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

