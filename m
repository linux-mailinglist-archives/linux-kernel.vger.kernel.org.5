Return-Path: <linux-kernel+bounces-77432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0FC86054F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91ACB287AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C304312D212;
	Thu, 22 Feb 2024 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIaUSC+Y"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BE612D1F8;
	Thu, 22 Feb 2024 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639215; cv=none; b=TYvUfwTEfXRXHLC5KCKGiY90sUVWmOJ+uzuoWIDAMznf9r9VFaa/X9aTklomwxbY8MnUPVgHiMBL6qJ9SuGK/XJFC5v9NmiRhUfnL69EeQuCBVpcimMb02LnsEcIv94IrzdShQrm7KOlOwR/ZpCwwIsyn0fUK79i8pg3j4P08tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639215; c=relaxed/simple;
	bh=pxdI0YOnWrToH/6X5U1/eKzH7bdwsSPGxAIQid8eQTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPYe2BJCxEOwXtif38svIoF51bVM/hlYidiZEZeHn0vfKuzfIF5Al7Xr++OIejsqfm0NKAOhd1um/fww0lkXUrZkio+HZzzeX7Wzr0ZlbYT+iD8OVcCyhyqLJWwVMHAvCiGwQO7WeZq/n8HxXw4nTao6kw0VMLwGeozp+r9md7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIaUSC+Y; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512cca90f38so317708e87.2;
        Thu, 22 Feb 2024 14:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708639211; x=1709244011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxdI0YOnWrToH/6X5U1/eKzH7bdwsSPGxAIQid8eQTw=;
        b=EIaUSC+Ykd6+JfoUxfmcy9/IlOZDm4iZWGqxgFykB552Mon+K/VwXxqPLq84MBDFfg
         XUBzUUIg+sSsoySoXLaNsaDDD4UPDk7t3VIM9mNxgfDcTsa2mJfnUSgNfRyyxmgOWANv
         NAgMa+NXAl+ENFqIBTNz+4IvRcG4PoGOpocR0lnHSGdGY9Dr63FkfeNmIttHXnWWMvS2
         M06dvDO0/jln8VB/Zv1BdFvdlihYtKgmCTXEDHYoDq7XeNmJIcTyWt9ayYf1X4kFqGrl
         F6QRz8xU9WUm/HQBc4pcOuzH2NqrJGM+73F8jjgMRqArg8oRQJMSalRkW0rvBo9Z5Zpi
         i0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708639211; x=1709244011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxdI0YOnWrToH/6X5U1/eKzH7bdwsSPGxAIQid8eQTw=;
        b=uH/hoboIFYiCbPIZJHblYUE/VFSQi1ZJpTuMg95yTIkhoLBC9jKJfqEnlOApjicSod
         4UTxpw6w8lAY9Z9LLHhaHRr50E96VoCtIrCpKbF3G5n+1ZbAyp+C2jyMQCMsNUcjHMol
         gqSS2GFoTsXS4ggkRrkCbeyOMz5M60iOHvNDoFl8mvj0xIeeavogIzXtWbJtAbXHWkSx
         GY0ksuiabM9x9hporXDb51T//cZyTWRvrKodGRq8BlTceOL6VV8P9dqiB+fWNH3UtPTs
         XreCi9gvBkkhu0IqXIH6gHEOQUTC1mdzUT5VqjzliNtn3rK5ePzO2Lhp6olh4Z1rHAaQ
         raNA==
X-Forwarded-Encrypted: i=1; AJvYcCUXyaC9TEN5V7IqCv1xrQF7T8rVdTVH4izU5KIojnVpC3WpjvN0VmcQjZB6VaXYsr8r/byeZXf4AncdDGt3cwvpUzf0goot3fXJV8LNrscosi+gvaNx9c0m3aeP8pcj18s4f4etDAI5Nw==
X-Gm-Message-State: AOJu0YxfTypeIxycONWsUGaBbRmP82by02nselWsQbwmw4Rktw8xcXIS
	Cv8JW5IGccDiSCZU10gMQj3Tp5+ci6XxJHhcbArHrY/xmN2O3C0iCDQgTcFaockj0O51XTrIqJo
	uvS/FO9FT9lhdE2hUIWu5ydG/xVQ=
X-Google-Smtp-Source: AGHT+IHDEfNZY6VfeL6BGoqTieLAb3vHjYt71QfMqckuTJ8bdGmvXJpn3vetoNVYLA+pqybI0CIWVGhFox5IFc51E10=
X-Received: by 2002:a05:6512:1308:b0:512:b915:606a with SMTP id
 x8-20020a056512130800b00512b915606amr312553lfu.12.1708639211180; Thu, 22 Feb
 2024 14:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
 <Zde966nsJ76QOuzm@surfacebook.localdomain> <f5e74774-226a-4678-a6f9-b4f17250ad91@alliedtelesis.co.nz>
In-Reply-To: <f5e74774-226a-4678-a6f9-b4f17250ad91@alliedtelesis.co.nz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Feb 2024 23:59:34 +0200
Message-ID: <CAHp75Vfq3Pc+Eo3Z5mhORZwwuKF+Y7_47dTO8qARcfba4nmj2w@mail.gmail.com>
Subject: Re: Linux support for a 7 segment LED display
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>, 
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:53=E2=80=AFPM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
> On 23/02/24 10:34, andy.shevchenko@gmail.com wrote:
> > Sun, Feb 11, 2024 at 08:46:12PM +0000, Chris Packham kirjoitti:
> >> Hi Blinkenlight enthusiasts,
> >>
> >> I'm looking for something that I figured must exists but maybe it's so
> >> niche that no-one has bothered to upstream a driver for it.
> >>
> >> I have a requirement to support a 7-segment LED display[1] (one that c=
an
> >> display a single digit from 0-9). Hardware wise it's just a bunch of
> >> individual GPIOs connected to each segment (plus an extra one for a
> >> dot). I can't see anything obvious in drivers/leds but maybe I'm looki=
ng
> >> in the wrong place. Or maybe it's the kind of thing on PC hardware tha=
t
> >> is just driven by the BIOS without the operating system knowing about =
it.
> >>
> >> Is there an existing in-kernel driver for such a thing?
> > No, and can't be. Here is just a mapping table and other drivers that u=
se
> > 7-segment LED displays to be connected to.
> >
> > What you need is something else, i.e. special case of leds-gpio (which =
should
> > be somewhere else) that does something like this. To me it sounds like =
a
> > mixture between line-display.h (from auxdisplay) and gpio-aggregator.
> >
> > How many digits do you want to connect? How are they going to be connec=
ted
> > (static display, or dynamic when you need to refresh in certain periods=
 of
> > time)? Depending on the answer it might take one or another approach.
>
> It sounds like a auxdisplay driver might be the way to go. My hardware
> happens to have a single 7seg block but there's no reason the driver
> needs to be restricted to that. At some point it obviously becomes
> better to fit something like the ht16k33 to offload the character
> display but for one or 2 digits a PCA953x plus the LED block would do
> just fine.

I have hc595 (SPI GPIO) connected to a single digit 7-segment LED.
Since it can be also serialized, line display APIs seem plausible to
fit. What we need is a proxy between the two. And I think
gpio-aggregator is the best for that. It needs an additional
compatible string and the registration for line display (overall
something like 50 LoCs). We can even call that hardware compatible as
line-display-gpio (or so).

Cc: Geert and Krzysztof (for the comments on the idea above).

> The information we want to display is mostly static (basically a numeric
> unit identifier) but there are cases where we may want to alternate
> between this and "F" to indicate some fault condition.


--=20
With Best Regards,
Andy Shevchenko

