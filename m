Return-Path: <linux-kernel+bounces-78516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E29861462
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B62DEB2250C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55778548E3;
	Fri, 23 Feb 2024 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJPJf7Ly"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD06FBD;
	Fri, 23 Feb 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699409; cv=none; b=akyLwywmAZNelv9kaYytZTTm4BClgIkDF1EE79HMedYBeo7HdR9zavCnlHszOGVyvzTBdzDREpXOw6ZQi3oBmdivEewUrtDHFnhrJWTXuQeEtYqqrwrrKo4XjCSg5CWg5C05C0MSTqhKKrNEVd+MBnraOZsQ4ZeSu1OE4mjbSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699409; c=relaxed/simple;
	bh=DEMIQOvydhZ/VpnCranobldgWGcw+Pq5Nukc/1RDlVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2C9tZwVy7f/yIGSMW4jYErnTacdmdsMlt93jhK29d8pNZQD9E8Eyz7K0l6ZP/cb1deQvXZAHM5upDzutRo6vaWH5MOmE9K4IunT5E6Xf6MuTGy/ESQPZ6j22xy9DyHNNrp3FvHmblRp9Dfe0Eh2qxEMsXP0rZ+qwS0LYW1uEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJPJf7Ly; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5643eccad0bso1373194a12.1;
        Fri, 23 Feb 2024 06:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708699406; x=1709304206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRQuvAZAPsUv3dwxMyD+E+7cfGvNoyt2/LH5pgsTUnE=;
        b=cJPJf7LyBc8vjzfhUn8A/vr1Gv6jGe9Wct57Z5HhdTzzsODeAJOXCBPQsLFUMurlrB
         OJnuNDaYJCI9yXc7J/g+bCw2WGtZp9jk6BQy9drQsAXo8hgAtLVotjbez2J3+nkAxBmo
         rs8gfQWOe8ynrspIMA/P2KZQ7BAvFO35C4oBE78LtLbOxmt3kbuFK03Kq7cWpDcQLUIf
         mldC5E4hG0oIkobAoL/7iHHpHM94yUMCEQGpRNvdAOX2EXN2A3MD3x4r3urPAqVCo/sf
         w5ArcWzU8oKFaIUZRwu5Fuf8WzNi3ifATTmgYHaLmvagmWMtKCof0LezCniTVo3jZAiJ
         6O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699406; x=1709304206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRQuvAZAPsUv3dwxMyD+E+7cfGvNoyt2/LH5pgsTUnE=;
        b=bqBgl16jc1bMjyWpGONnVSlZ0HUNIRXQdjKSqB+g8ruCeuXmpHytq/Y9nopRctJkvV
         xKsqT4G3OOfH8ikb4FgOKskLfzUhUjawh3ywnd45TDv49fxVWdJH1+0MRQp/jLEFSsvn
         LpsjD34dU6kInoBKHhz2ELireInWOFrfxpJAeUANvw5K4KiAjrr0Lq3KxNqN8Vid2qMt
         VTtaNrCXjmhc41OS9hrpxr2pBO4qwC5SYLwgjK1joJiYkifei9Y8baqnnM5+iHoBERRT
         K6NXjoGHqyI/1Uwk23lPzSdGvtu1YkJSQjPym9z8DU0gH/OdJyfSiZMYxvMTIkXMKgQE
         JF3w==
X-Forwarded-Encrypted: i=1; AJvYcCWe0UFflyxrGNqc3t5XUVCNhCEH50VUEoTZ77GdGkz9xFb8x1zr9qvoVJYtN19f5MZRqHyvfz75xxwk/kLIArwsAOErpdoNneU6H/Hvu4/rkGaPNrN/RAEY84CgxOuk8NtnVZdPHM/MnROWtla7C0SUSBOXmYmaeeSM4XF4z4FPm31T2swKLDgUmrIseArPGm5hqpzrLS4yRIbJdrXnFq0=
X-Gm-Message-State: AOJu0YyCXw48KKsv9bAi0qEVhdMrUCU4HlNKPTCSHUP/ChWD7wX3Gxpk
	Qjig6X3o7b5mKO/Ae5+fy5LZS4rWUD7tZ9wAUylTIoalOCEAw1yLbnF2KSnINwmNpGxJsj01kcM
	cfF4fgXnT/jMqi7eldklHYpXCi0w=
X-Google-Smtp-Source: AGHT+IGiHiAkfrKtroFs848fr9GZTa3NoU86QtnnJ6tiFG1Z8p16HIHWpUfwHXBT5/jFD1kjrOBJqL8PGK2y1xsRPQM=
X-Received: by 2002:a17:906:1310:b0:a3d:a63f:2db0 with SMTP id
 w16-20020a170906131000b00a3da63f2db0mr19511ejb.28.1708699405892; Fri, 23 Feb
 2024 06:43:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223133758.9787-1-mitrutzceclan@gmail.com> <20240223133758.9787-2-mitrutzceclan@gmail.com>
In-Reply-To: <20240223133758.9787-2-mitrutzceclan@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2024 16:42:50 +0200
Message-ID: <CAHp75VekP4fJPxcZeQVXypDDrQT1i9CtesN2R4TtiYxxpQr44A@mail.gmail.com>
Subject: Re: [PATCH v15 2/3] iio: adc: ad_sigma_delta: Add optional irq selection
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org, 
	linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Walle <michael@walle.cc>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
	Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, David Lechner <dlechner@baylibre.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:38=E2=80=AFPM Dumitru Ceclan <mitrutzceclan@gmail=
com> wrote:
>
> Add optional irq_num attribute to ad_sigma_delta_info structure for
> selecting the used interrupt line for ADC's conversion completion.

..

>   * @data_reg: Address of the data register, if 0 the default address of =
0x3 will
>   *   be used.
>   * @irq_flags: flags for the interrupt used by the triggered buffer
> + * @irq_line: IRQ for reading conversions. If 0, spi->irq will be used
>   * @num_slots: Number of sequencer slots

Now kernel doc order is unaligned with the real member order.
Moreover, have you checked with `pahole`?

>  struct ad_sigma_delta_info {
> @@ -60,6 +61,7 @@ struct ad_sigma_delta_info {
>         unsigned int data_reg;
>         unsigned long irq_flags;
>         unsigned int num_slots;
> +       int irq_line;
>  };

But no need to resend, it's minor and Jonathan can probably amend this
whilst applying.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko

