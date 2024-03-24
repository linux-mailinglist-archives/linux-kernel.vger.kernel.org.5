Return-Path: <linux-kernel+bounces-112833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B50B5887ECE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4030DB20D9D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0EC10798;
	Sun, 24 Mar 2024 20:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6o2WGmj"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AFDD2FA;
	Sun, 24 Mar 2024 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711310890; cv=none; b=j9nS+kiD8oGCrEK5acPYfKetegRTa8YOmwF9df6kUNrOXY7QvdhkSYIyAoNWxOOU3xVdjUwVp/+xvyhFCdlYRW/h/MfPFRXlWHRAifBwba2L8LwAMX5mSLFNEnjC4+TKk8pmOgYMMsoaQN8YnjHI8dVAukob2QyX/e1TJKF9dR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711310890; c=relaxed/simple;
	bh=96pBEhq+UMIcGdJgoSW6NpmKLHH1fy9LSh6o40sLCNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiqAwsiNw5Q2HBODWHsMbRduX7zAjSZjGEcuy+demXFi+4p2AT2qc1PPUZQIg2t0kUc6otxHl9nxgarv/vMO/uWEztk1tYz7W3VSfoaN8PXa/hik4oSbQyMMyFj+009qac0quEmdyEfbk8+VprxhByZkJEuqOgN1UJfePDtltCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6o2WGmj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a47385a4379so326453266b.0;
        Sun, 24 Mar 2024 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711310887; x=1711915687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmJuo1f1enZJCrEBjhO66Mb9UFer5++BcZ4gFBXYotU=;
        b=D6o2WGmj4O7IqhZzdyMvwp50iAvaq0Ml9c3qigWddT9AqewskPJlbDRLFFuxwOdOYX
         Oa8A4Z3kPhDhBztSNuPmq7LZcCYjHj4Ms7N4jEMiKcu5GW3CDTrjVGeMTJ9AhB7eEDI6
         oB+3tkAItCYdL9wlQErEkBFUMdqd5/8yZcq+2p0kBZbtwd+acdoZNvzLEYHsnWNm/xvi
         oHXSVVFPCRbJb0BEh13PkqgIO8vcX2j/sSdcboPqAs+KojsBXHeVEGZlSQh1QowaOpUq
         NlwoqaytmC2XZqn5XRl+pFiO2pJDANGXczOU3ehJUJJpmTzcXwXPPccUwrbvS96SeLW6
         OqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711310887; x=1711915687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmJuo1f1enZJCrEBjhO66Mb9UFer5++BcZ4gFBXYotU=;
        b=RLbN3cCZmylTzc1LmFGYvv6/XnDalSsvFywSoU5nAnloBRVhYyttahRNdSb1Xp7Yup
         zoohaerbZwcPRPzTIjcIuJQ7X8eklMIPuJ/NUNPKe/KKXJgbNOWh20bax1ap9KxoOTc4
         1GsQd9+8lBJDJhn2ks6ALpcvbr+z3yfaY7XdlLRp+5fXiSmgXa1cso/2uFiqndC2Zzwi
         /G8v69ZegDdIdwDetzIeQkGrZgR/AO6XZANTOQY9FcOc4h4/YxI1KA3m4JpjOY8/YNTR
         qaUjz4SWz6fDWGzJyKICHmCi71gRk2PPBcHdriNPWeO4QYHiCNx0Kma/RSELv5rB5tYH
         CfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPQbnc83ikRzz04/qGpyn3dajISsN25kIPllLZWABM6pcMEKAl2hSYTJEGzwUNQ5230CiIQFzEGJrLaFT8R/x3c3YxtNTeAO/8J6SaTbB+n2NEBNCFUxSfOqqqvlgknOrklUfDpkAZ+s7eLmrm20WP1xRMKwJRPL3IMbalON8U8fy6QWMAaF8BewX3BoPdQepKx5/NFRrHtJixj+zVqYtEBecGT4ctQg==
X-Gm-Message-State: AOJu0YxhQFXo9/7sdO4zLv3o7qlh8jYkODSxVTPAUlacFbsnNjkOzr0G
	DlNh8T8v+zx2F+3tCTp3TpK3lFf1tf3PnEl0q1gy9S1moc893pCw1swd1U4s8cor1FIigtU/I2p
	0X4+NnjFQXvC2ScjkLadhuiIlbk4=
X-Google-Smtp-Source: AGHT+IGnHV9dklcqVjCC1K2N4WzMD7czh4HdYnDtDZE91j3Ir4r4I4Of+bw2uITII3fwJ5TLUOHvwIlNRDLusYb9N2M=
X-Received: by 2002:a17:907:bb92:b0:a4a:378a:a8db with SMTP id
 xo18-20020a170907bb9200b00a4a378aa8dbmr315442ejc.15.1711310886695; Sun, 24
 Mar 2024 13:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324150107.976025-1-hpa@redhat.com> <20240324150107.976025-4-hpa@redhat.com>
In-Reply-To: <20240324150107.976025-4-hpa@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 24 Mar 2024 22:07:30 +0200
Message-ID: <CAHp75Vcu69i4zk=Feewz89BCGvHKn295m1nwm94-eJ3+BSSdAw@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND 3/6] leds: core: Add led_mc_set_brightness() function
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 5:02=E2=80=AFPM Kate Hsuan <hpa@redhat.com> wrote:
>
> From: Hans de Goede <hdegoede@redhat.com>
>
> Add a new led_mc_set_brightness() function for in kernel color/brightness
> changing of multi-color LEDs.
>
> led-class-multicolor can be build as a module and led_mc_set_brightness()
> will have builtin callers, so put led_mc_set_brightness() inside led-core

the builtin

> instead, just like how led_set_brightness() is part of the core and not
> of the led-class object.
>
> This also adds a new LED_MULTI_COLOR led_classdev flag to allow
> led_mc_set_brightness() to verify that it is operating on a multi-color
> LED classdev, avoiding casting the passed in LED classdev to a multi-colo=
r
> LED classdev, when it actually is not a multi-color LED.

..

> +/*
> + * This is a led-core function because just like led_set_brightness()
> + * it is used in kernel by e.g. triggers.

in the kernel

> + */

..

> +       if (!(led_cdev->flags & LED_MULTI_COLOR)) {
> +               dev_err_once(led_cdev->dev, "%s: error not a multi-color =
LED\n",  __func__);

Not sure how __func__ helps here.

> +               return;
> +       }
> +
> +       mcled_cdev =3D lcdev_to_mccdev(led_cdev);
> +       if (num_colors !=3D mcled_cdev->num_colors) {
> +               dev_err_once(led_cdev->dev, "%s: error num_colors mismatc=
h %d !=3D %d\n",

Should be '...%u !=3D %u...'.

> +                            __func__, num_colors, mcled_cdev->num_colors=
);

Ditto about __func__.

> +               return;
> +       }

--=20
With Best Regards,
Andy Shevchenko

