Return-Path: <linux-kernel+bounces-83276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B4286912F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DDE1C27D51
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7F513AA43;
	Tue, 27 Feb 2024 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmB6Myd9"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2C2F2D;
	Tue, 27 Feb 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038898; cv=none; b=EI8EV8h4L8Xh/nuOgyWq7El0sujSj2Vo3vf7dJuBx4xLOI1U0pI+2GJj/1Svj408BD5bwj+UwWZ/3WVLm16Fco6wCz8UCyGkeR9rjBSadmD6TedwDYiXIAQTYIwbwDZlHJjy/xQsck/pJ/8sdMUHAdn9ex8ZHkUXGPYySe2sOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038898; c=relaxed/simple;
	bh=hVPtSdJtYddAG+EIclbX7xD+HPT6FRQSRfWO26yzzGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eTeQU7zY0XQj2YkzFxUR0qOOq1cHSHTSg4ArrQFgVzFGXNDg8gxsQlxbi2WjEk4V1kX5ih+qNPIjk6oRfE31ev+18zaDTKYHqtxiftuSA4268WVK0Qpj6LE387mQFJa2ZmjfOAHum+DXEJ8L6d13JJJo1XTAdo1U7xJwhf9s9uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmB6Myd9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so603076166b.2;
        Tue, 27 Feb 2024 05:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709038895; x=1709643695; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UikzpkujjXwCtreWrXfmmEcvmx/a1ETRiTxhijrjC1Y=;
        b=WmB6Myd9gQ+wtlgDVse3Rtv19VyY9RF9oPksLHlmw44u9wke31zPi63wJYnwg2X6IM
         aPxac8Im3X7UnmZB71cqjvsH8g8JS6vPT1QPJ3LcZ4Cdk8ydxzL+/72QFY3fXKEqCBul
         IIj6n5jQLvXAn82+o69mCtW47QUMlKnxGVY+7PP4rkJlU9Ek6Rscxj0nIXkeXQ56bUzl
         I3crMTTKa5++qWuePOwEknlN2p+rk0Hk6C38L5Z6UjiPdCGsxUZ4Yd18a1KF+GRRpSkA
         MvHaLs43MvBpLnuxF0RnveJUwtmbdgOtfipsDRQXEOLyHtBiEfjzxeqsvXiHuyqna/AS
         ZaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038895; x=1709643695;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UikzpkujjXwCtreWrXfmmEcvmx/a1ETRiTxhijrjC1Y=;
        b=NKvzdGC+xHDxsxeVkz6bMP+ce1CskrPQOb8dDkZ3uBsFyJtK3AZd3r8vjFm+ivdQz0
         d49Uwfde+euqR9OlryejXaJjdZuoh8Hm5cz8J1f4JQUyoqMowxhBMRLVzObqpSawlfc7
         QRVK5iRzWgnB7xMXyNW/QRD/+zMPpGDmuEUUW/blEAh6pb83ArmPqn7Fdc7N0Vz8ZErL
         Kbx2cwcYhyuuMurPSHhm5b3OrcGX31BsQpMw8YWKXTrK9xeZnTkDUjyWsk6TjJZ5Kq81
         MdydKoiVVr/IQcWIfvI4pokEMkThn27A/GZZlyz0WEMo93WAtxDej6xFuvmu8hwHGpyg
         FskQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoRU9F1Le0Dq2n/6RIGQUQECCZociqVyJpzP2+HO2IVyLpZy4WcBAuQvT2pKGcBUadoh2RsDTgKHtdyz9YSeqMDycWKRAaErt59H+CUdnrTKBghR3eEIwFWwjbYRM1ToWfXoJ40vUD+sO58iDGEAZNejKqAFMZe2cAcpi754lSrxzcJ10=
X-Gm-Message-State: AOJu0YzJwMBEtajklC7qnwEN6gHQnnP7dV8e4lQb9GVXuFiOejyZPg/R
	sP8tZbvCSsaVMb0WbDHzISOFmAo6Db2Z3OSFuuvP27Qg5H0fMcSA37ryjl1QdqK83tfc3Fnu36G
	jIugmtzHKhOnSDo90d3Zq3CChpS0=
X-Google-Smtp-Source: AGHT+IHb++aO+WH0LPzz8cPRkyvMXG9JIS7JDxPe6iL2Dh7/MmMI+nRWcQtgev94gQgJ4/smhdGR0UO1XtOlfDYiQRk=
X-Received: by 2002:a17:906:1b43:b0:a3f:1c10:5a63 with SMTP id
 p3-20020a1709061b4300b00a3f1c105a63mr6925228ejg.38.1709038894414; Tue, 27 Feb
 2024 05:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
 <20240226-scabby-fiber-87d5d6e45028@thorsis.com> <fd1c8657-62e6-449c-b47f-a2c3223b405c@alliedtelesis.co.nz>
 <20240227-married-amulet-da532c0a70d3@thorsis.com>
In-Reply-To: <20240227-married-amulet-da532c0a70d3@thorsis.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2024 15:00:58 +0200
Message-ID: <CAHp75Vd3aza1192YpRHvi6y7oEsrAoYA3+Qcja7Fw22c9+xhRQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] auxdisplay: 7 segment LED display
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>, 
	"ojeda@kernel.org" <ojeda@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>, 
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>, 
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, 
	"pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:43=E2=80=AFAM Alexander Dahl <ada@thorsis.com> w=
rote:
> Am Mon, Feb 26, 2024 at 08:10:07PM +0000 schrieb Chris Packham:
> > On 27/02/24 05:04, Alexander Dahl wrote:
> > > Am Mon, Feb 26, 2024 at 10:34:20AM +1300 schrieb Chris Packham:
> > >> This series adds a driver for a 7 segment LED display.
> > >>
> > >> I'd like to get some feedback on how this could be extended to suppo=
rt >1
> > >> character. The driver as presented is sufficient for my hardware whi=
ch only has
> > >> a single character display but I can see that for this to be generic=
ally useful
> > >> supporting more characters would be desireable.
> > >>
> > >> Earlier I posted an idea that the characters could be represended by
> > >> sub-nodes[1] but there doesn't seem to be a way of having that and k=
eeping the
> > >> convenience of using devm_gpiod_get_array() (unless I've missed some=
thing).
> > >>
> > >> [1] - https://scanmail.trustwave.com/?c=3D20988&d=3Dtrbc5eARVo-5gepR=
nwbAKbQmiGk1bOSpqZDQx9bx7w&u=3Dhttps%3a%2f%2flore%2ekernel%2eorg%2flkml%2f2=
a8d19ee-b18b-4b7c-869f-7d601cea30b6%40alliedtelesis%2eco%2enz%2f
> > > Read that thread out of curiosity and I'm sorry if I'm late to the
> > > party, but I wondered why this is limited to LEDs connected to GPIOs?
> > >
> > > Would it be possible to somehow stack this on top of some existing
> > > LEDs?  I mean you could wire a 7 segment device to almost any LED
> > > driver IC with enough channels, couldn't you?
> >
> > Mainly because the GPIO version is the hardware I have. I do wonder how
> > this might work with something like the pca9551 which really is just a
> > fancy version of the pca9554 on my board. A naive implementation would
> > be to configure all the pca9551 pins as GPIOs and use what I have as-is=
.
>
> My idea was to do it on top of the LED abstraction, not on top of the
> GPIO abstraction.  Currently you are using the GPIO consumer interface
> and group 7 gpios which are supplied by that pca9554 in your case, but
> could also be coming from a SoC or a 74hc595 etc.
>
> Why not put it a level of abstraction higher, and let it consume LEDs
> instead of GPIOs?  Your usecase would still be possible then.
>
> As far as I could see the concept of a LED consumer can be done, the
> leds-group-multicolor driver in
> drivers/leds/rgb/leds-group-multicolor.c does that, introduced with
> kernel v6.6 not so long ago.  It sets the sysfs entries of the LEDs
> part of the group to readonly so they are not usable on their own
> anymore and one would not disturb the grouped multicolor LED.
>
> This would allow to use LEDs as a 7 segment group driven by any LED
> driver including leds-gpio.

7-segment LEDs are not just a bunch of leds, they have explicit
meaning and using LED infrastructure is an obscuration of what's going
on (too many unrelated details are exposed, too hard to achieve what
user needs). In the auxdisplay we have already the concept of "line
display" with a 7-segment, or 14 (that are two main standards) with
respective character mapping in case somebody wants to print more than
hexadecimal digits on them. If I am mistaken, I would like to see the
concept in the example here on how user space will take care of
displaying (an arbitrary) data. Can you provide a draft of (user-side)
documentation before we even start going this direction?

> > Making a line display out of LED triggers might be another way of doing
> > it but not something I really want to pursue.
>
> Fair enough.  I just wanted to share my idea.  Didn't want to pressure
> you in any direction. :-)


--=20
With Best Regards,
Andy Shevchenko

