Return-Path: <linux-kernel+bounces-71588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5AF85A76F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C775028344C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB138F87;
	Mon, 19 Feb 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="m7vj9A4f"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816503A1B6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356856; cv=none; b=EQYl/PQzAdrZ5JxMtHF3n6X9bauhwA04oZ4wv3I3BMMTfENELqq5kYnLIbpnGyJ7AOKJCVTK8UiMBeOWWlcuxF8qM/l52PHgAFhjDxVVXCK01/iDTeQnPDe+T2E/rLbbDb6YmIj77hmZshVSSKiZGBiz+gZabeW1Hwi6/0NOiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356856; c=relaxed/simple;
	bh=OFg9oqTwcZyyxLA+PL9UVn1Rcz+N4HoQ9s8zDEcli2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVFm6XDQTfXuCsNXfjJpFhdTt0r3k/k3ojPkXwMd+5rsiSuyNKTWa+wNhePXdh7BIv3aNFb3X1uTxar5PeYv6+wQlbfnV0Ubjhg3gbi+hYSysWey8hNeY5d43kGgGoNNX3bF7SgEpMY0hGRRv/8BYQ3jSF3O7CECEm0v95ByLHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=m7vj9A4f; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-21a95258d42so2952741fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708356846; x=1708961646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvVPolj8oeG4AKFrK8d+pLPilaj1PpVh47xpBNRxg+w=;
        b=m7vj9A4f5LEzjmiSmDA/WYeQCusxwYIQiuPFw5YyE7Zsjs1qW5UoGBphfd/0GbHN7x
         beNs5yZ9h2EVHeAfxQLvUn7cqQvZuMWq9aEjZe4a0ojsXnvjxVzdn4XwPKUxatoR25bo
         CRqnlACzqTcmZANl0jr/CnK0S0gI7EflsuCP6LindZOlboJHu/cHTvMH6FlCHqT3qNTG
         2DEdDC7VY1mN7rXlrTIZgvdWUEnXTzx5Rj31bjNyiPSzpIh+9jxmumangJTvPwWAyBsY
         NZuiruElBb13g0vl4AM6T3nHDGhrTSxwWT+rSiQPImMOe44BUU+EIXhFPUg1k4R7D6vp
         spFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708356846; x=1708961646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvVPolj8oeG4AKFrK8d+pLPilaj1PpVh47xpBNRxg+w=;
        b=QpnEMenVhzMYQNlJCNRg27mBnBa1cweb0UNIL/lzVWxXBlzSxqII0wEtyXq1I56+e7
         0Dk+5VrxP/REYmmFitbBLe7GujbMiZa0ey0tRwbAjwb4WEIURGVAK3Xq6j0z1CZy3fSJ
         uRA8NsSwITPHvtnXfX3NKdfPhrQowHGarfteNz/6tYzMU4jkpf1tZBN6TjvQ1E4kUXY+
         zvIcjka6XVtKWSj7TWOKWfdu5dTwlkiWgOC3xtwz4YLNthDyry5XFPB+wYJOhVOZlTd9
         UeqvZwvaxoIvSMBxkBVG8wW/4S5AeR+kBZ5FgxhUfsspy3aMRJQbfUhCaX6H4KzfOSBJ
         qWzw==
X-Forwarded-Encrypted: i=1; AJvYcCXCi/FIib0j5nABrq/cnmgDfYxGXXMTE6Qsq5fq4aTNeRZFsnKyIn2sO8L91byKKT4W+FJ1fbQzG4wENcNKtSBGgxLxLQUcJhaZqTpt
X-Gm-Message-State: AOJu0YzjUQobgKnztC/O4+IEsUvwXMvIOAv73+rMoXdn4bw0exBmd9vM
	dqzzpnmwcu3Q7h2LfslyZDXcSPkXohWtkKHwPYQupUmXfNbB02whxHQqDjGsbJZMmro575n14Dc
	KNXrc8CwBmwpVYZBKC5VzocZWineuWfFAjQWkXQ==
X-Google-Smtp-Source: AGHT+IH6wgFWgrzdMctoV3icDI335MC/CdaUuFj+nGvrkX8vJ7pjFLlj1xEDLlkiBRM39lL8enM+OZmAUPyDNuGbujs=
X-Received: by 2002:a05:6870:d24b:b0:21f:a33:e48f with SMTP id
 h11-20020a056870d24b00b0021f0a33e48fmr444912oac.11.1708356846558; Mon, 19 Feb
 2024 07:34:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-5-f88c0ccf372b@bootlin.com> <e031566a85ae0da0ee71dffba5d87c6414ef83e1.camel@pengutronix.de>
In-Reply-To: <e031566a85ae0da0ee71dffba5d87c6414ef83e1.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 16:33:55 +0100
Message-ID: <CAMRc=Me-oEx9S0w=XhwC4MzV9uzV0o0HnWBfNSstcqg5jpXyZg@mail.gmail.com>
Subject: Re: [PATCH 05/23] gpio: nomadik: extract GPIO platform driver from drivers/pinctrl/nomadik/
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 11:03=E2=80=AFAM Philipp Zabel <p.zabel@pengutronix=
de> wrote:
>
> On Mi, 2024-02-14 at 17:23 +0100, Th=C3=A9o Lebrun wrote:
> [...]
> > diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
> > new file mode 100644
> > index 000000000000..e39477e1a58f
> > --- /dev/null
> > +++ b/drivers/gpio/gpio-nomadik.c
> > @@ -0,0 +1,660 @@
> [...]
> > +static int nmk_gpio_probe(struct platform_device *dev)
> > +{
> [...]
> > +     ret =3D gpiochip_add_data(chip, nmk_chip);
>
> Use devm_gpiochip_add_data() to cleanup on unbind, before nmk_chip goes
> away. Or make the driver un-unbindable via suppress_bind_attrs. In that
> case you could drop devm_ prefixes everywhere for consistency.
>

No! Why? What about error paths in probe() where you want to undo everythin=
g?

Bart

> regards
> Philipp

