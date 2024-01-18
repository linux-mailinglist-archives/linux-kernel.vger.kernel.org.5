Return-Path: <linux-kernel+bounces-30124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240948319D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A808028AFB2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E0250EF;
	Thu, 18 Jan 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RODEh9Vg"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01324B57
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582804; cv=none; b=fPmrL9GuZBQqHl7rUUXu0JOCmYDq2TbzYmkEorQKv/24ITIX7w9hE9ukY9hRXEcjGwT65teb/jocvb1N1JxZkZkMBgGQot1yjkpRnjAox+U693V2NI2NPONPPz9aWmSlw7s+eTy5fD1oCbqX5bAQMHKbwPWJgiTu+TkoL954DWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582804; c=relaxed/simple;
	bh=7M4VaIUyYm8pE44IOXTCPDugJRBLIqoanr86Xn4yKIs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=WhbncdvBGeX4dqYcuFkHqP9c6SpfR0gDiLWw49tEO7AI/nlT2aSS6SM3K9Vs8oBjhN1IGVxkPUh26UeG15+QYlU57l2lDUEGm32/S4dWC+Mk+9YQOLDUlYDm/o/M3ctXetjUk+JLC/fsw33bL6J9D5DCW3dfr3JXGBmltfJjiMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RODEh9Vg; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d2ce52d0c1so100292241.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 05:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705582802; x=1706187602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbPI80yNiYQVcWLbaA0E+htnDslr+gyomLLCxgqK/9A=;
        b=RODEh9VgKUbKarmhkWY8riLHD0mvfw761K6T1JqT6HOQbrDqNM0jB7qRzdiR1nIUyw
         w31vlGZ5TifUZmURBbnYblehCKePsqlnVhuCe9o9sbzZLJf32LppFGgf9Xp9ng5Yd0Xz
         OenY6DJtD/RpPkKWomwvP3HgQ6CD3qsv/CvX+EkPLCeeu3Npn4oskjIJJAuUzgrA4SzD
         wU1LVQ9/m3esU9Ex9qkf0Wa5KP0uxEdkNs7s4ppL8UfybKp3C1CoAU4MYQ1SdgWmVKYK
         7uTjrHwx+O+QuyJ6kBatAmJoms4gGFq55a/LSQ75ytTsIDrjBZ3lvzL2Wi2wNfb93nHn
         yjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705582802; x=1706187602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbPI80yNiYQVcWLbaA0E+htnDslr+gyomLLCxgqK/9A=;
        b=smRM7sTU2+s7UJuIaBx3itm7QM7WJdrrbX0TqAPq+iNeeesAF+BbCBxnZdm/qahfSp
         E+xlXy56yYVaqPf88z2Ev/OgJAu78FaN+P9f7JypZXsoXxKlJP0bQMd7FKYxKr6zdEFn
         KDTqu4QVAsJUbs3YgXzL6DMyldJVf5AfI9fejfAB73zbFuHG577sKH418XX1EZ4OLQ8+
         ZLuoLx1DzUHoRBHCUZ4iy0a7SekW+S0UxWatQ5BuGiSqcYIT4D/HpV1MwGTjzZnTUBw3
         nQzKXJk7uKBE3eTvff7le+ta+ohOF72CUqvLMQASncxsopDLr5zU1kTtV6PBZrG1wLZa
         Me0Q==
X-Gm-Message-State: AOJu0YzFHnrfTloqWXwvckBg74DR490axKNw5zBWTb93fqhNWXFRhrbw
	oDuasd7ww4eaMkL0zOzFQOnlFd5nJDnZTULb2DHtkw2OyLA3qxMx0pC0BfjUuVunuBikpNMuuAf
	hG17703V1yB/SzUQwYOE2+nsrYVsDcahear+WhA==
X-Google-Smtp-Source: AGHT+IFV799Pl75EVGiEihv8NguEM801LhNe7yQvY5xjGtMqBPcnTKWr82ZJvwoc7zCV0G5B1YL66F/miSdR/lsCxqk=
X-Received: by 2002:a67:f797:0:b0:469:877d:fc1a with SMTP id
 j23-20020a67f797000000b00469877dfc1amr681665vso.8.1705582801234; Thu, 18 Jan
 2024 05:00:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117083251.53868-1-hector.palacios@digi.com>
 <20240117083251.53868-2-hector.palacios@digi.com> <CAHp75Vci=1nAvxRcbkK2SxGWGbQVbzQMTycMt8tZ5snPRTYXOg@mail.gmail.com>
 <fd5550ad-76c0-419b-aa07-a0493a57286e@digi.com> <CAHp75Vf4wXLEjmfpz6KQSCB0Jd8LNv6+SU_ikbhR_8PsJHuq-g@mail.gmail.com>
 <CAMRc=MfAW5NDJHtZ1333-xrcCyQfft-pQF1-0Vv_ehY16agShw@mail.gmail.com> <9b370036-bf3a-49d3-99a0-5c11eaca4e6f@digi.com>
In-Reply-To: <9b370036-bf3a-49d3-99a0-5c11eaca4e6f@digi.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 18 Jan 2024 13:59:50 +0100
Message-ID: <CAMRc=MeJQihq3N1ZqGiKS_9JJ6c0BwXZfiY1XicBiW8mc18Oxw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] gpio: vf610: add support to DT 'ngpios' property
To: Hector Palacios <hector.palacios@digi.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linus.walleij@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, andy@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 1:45=E2=80=AFPM Hector Palacios
<hector.palacios@digi.com> wrote:
>
> On 1/18/24 13:03, Bartosz Golaszewski wrote:
> >
> > On Thu, Jan 18, 2024 at 10:04=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >>
> >> On Thu, Jan 18, 2024 at 10:25=E2=80=AFAM Hector Palacios
> >> <hector.palacios@digi.com> wrote:
> >>> On 1/17/24 21:51, Andy Shevchenko wrote:
> >>>>> Some SoCs, such as i.MX93, don't have all 32 pins available
> >>>>> per port. Allow optional generic 'ngpios' property to be
> >>>>> specified from the device tree and default to
> >>>>> VF610_GPIO_PER_PORT (32) if the property does not exist.
> >>
> >> ...
> >>
> >>>>> +       ret =3D device_property_read_u32(dev, "ngpios", &ngpios);
> >>>>> +       if (ret || ngpios > VF610_GPIO_PER_PORT)
> >>>>> +               gc->ngpio =3D VF610_GPIO_PER_PORT;
> >>>>> +       else
> >>>>> +               gc->ngpio =3D (u16)ngpios;
> >>>>
> >>>> This property is being read by the GPIOLIB core. Why do you need to =
repeat this?
> >>>
> >>> My apologies; I had not seen this.
> >>> I'll use gpiochip_get_ngpios() on the next iteration.
> >>
> >> But still why?
> >> https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#=
L867
> >>
> >> It's called for every driver.
> >>
> >> Maybe it's needed to be refactored to allow fallbacks? Then can the
> >> GPIO MMIO case also be updated?
> >>
> >
> > I guess it's because Hector wants to set an upper limit on the number o=
f GPIOs?
>
> I think Andy is suggesting to rework the gpio-vf610 driver to use
> bgpio_chip struct (it doesn't currently), and then I guess the 'ngpio'
> property gets read automatically if you call bgpio_init().

No, Andy said (and even provided a link to the code) that "ngpios" is
read ALWAYS when a new GPIO chip is registered with the GPIO core.
It's just that it doesn't impose any limits but that could be
addressed with imposing an upper limit in DT bindings maybe?

Bart

