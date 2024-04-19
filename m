Return-Path: <linux-kernel+bounces-151450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED82D8AAF1B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9ED9282138
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399AE86640;
	Fri, 19 Apr 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WgaDV7KP"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C285C62
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713532298; cv=none; b=G071gKNWyzqoXleMG0wu/8GGLWTvFKHAIzRmvhtqyaBIw/hroDdadr3hqpQBDGql61NT0niZ6h/p0U7ojdsaohMLj8kXHsyL4aVCdokc+i/HRBZzmCOIhoCt6SSv57tgtbiL8LzrwdioLxWYPuMy4UNi2/5Gev5Kx8hf1FYV+N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713532298; c=relaxed/simple;
	bh=GOKCVMSTNaA6lXAE7yggz6r1QECEGrAck2tn/InTWJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pz592XwWpQE55FhNN5+wKjCvVIm6Chvbuor5TPEbjg95yEUcElOVUjzXJnH27S0T8qxaMeN4wTc+bEG1dH3dF2CLqS8BEX6L7RsUtTskToJy+TMsYjPRR1IRjLyd4dc/FzY6k6x0KrHUSSHQERSeYEp8M6HkhLJWgRwYVjOlQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WgaDV7KP; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dde0b30ebe2so2047272276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713532294; x=1714137094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXgtDkC8EaDAy1lPCRjBn5ZbvljYuzgvsv6Zpn67Xbo=;
        b=WgaDV7KPI/DqlpC3lj32LxOEKl0ZvaeDtVhsouVSXj28E4tFlzLXnvY03uU/77B6A4
         qMoFFw2csNEVAFKlrglHZ+pa97WJcuVX3TRhRvkEaWwofzstI2BSfnCLIQEKWIC7+Nfd
         VKGmzgk9aR5/XWdktkRvpaHuy+cg5/gpYri16DDZ4aWi6NSX08c8FG2xdutTuH4UpcSN
         ZkiRQjoe4seS04JGUEhXnLC9smU7XwbGngkAkB0/81X2WrJm85FIoSdRgMDy/Rfz/WpK
         gqWweO6UcUX6wC0C2b/6CSF9FIgTiiKjx2F4Pwvvu0HbQAlzNtyUDpbk9T7rb8wzz2zf
         0XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713532294; x=1714137094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXgtDkC8EaDAy1lPCRjBn5ZbvljYuzgvsv6Zpn67Xbo=;
        b=MZxIbng3XTsMrB8MWma11jl3cp+3AKw0ehAT9Q4+WMGXL7ypKCmlQo6jDuSpVQSkOF
         H/K+D2TdWC+UQRl+EV6fBb5/ubAeEZ/071M6Ipqw9ZYqmnV93ABN0m3JMBYnDipUjpke
         uuLC/8u37D4zxR6zn7gvXfIihryUbUW5nQkb3ttvMQFsavyOwA8nsmB2Ss8X5WOPNG4k
         vbTkfL+lF7zCidgSF1NGKn1s/y3jMHd+gM4ddZyjWi9EIXe+Qk1sTBxLK7zxNtHUG8Vs
         nuXdhn8Ntv/9SS5ZbSLeO3Rw9WKqmG3hC8ExAzx89LnCELMSOw9W5wUGlx2juyKzeNqq
         8s3g==
X-Forwarded-Encrypted: i=1; AJvYcCUlaBJkzIsTD7YTsLg5WjgD+AUcAD6QHzB5X/++tA8Ylwj5/kUGu1kDfI5ssYnYPKlI8SX2O7nuy4doGNjVVxMeGaEItJAFFOCWTkDO
X-Gm-Message-State: AOJu0YxhEXvadEVvZOmDTn0d0F7dL+xxjOYLUMivxG5KvMLaTKDnpAWi
	rytzFbR7kzdSt4dDixWtRn3GwGav1v2FhFLfvtI2e9wTkeeDFESustVb2Sv3XKG3rH74l4h6pwd
	M3g48kD/p6iOOgyu1xOX3wxA+mgEnw8T4k2NtKg==
X-Google-Smtp-Source: AGHT+IF7fJMloHUkqS9dzr6pPah2k0itIUV5Ij6WynNDjU3f/phN7+DsgIDQHGZsEmuabnVTyJSGAFDGXXkr6242mOE=
X-Received: by 2002:a25:8548:0:b0:dc6:c32f:6126 with SMTP id
 f8-20020a258548000000b00dc6c32f6126mr1857295ybn.22.1713532294482; Fri, 19 Apr
 2024 06:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419080555.97343-1-aapo.vienamo@linux.intel.com>
In-Reply-To: <20240419080555.97343-1-aapo.vienamo@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 19 Apr 2024 15:11:23 +0200
Message-ID: <CACRpkdbSB+JTdhGXViWs-SmR3nUnm6dVXt3WzK-d4zFSz63XxQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: Add Intel Granite Rapids-D vGPIO driver
To: Aapo Vienamo <aapo.vienamo@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aapo,

thanks for your patch!

The code is impeccable, not much to say about that.
From that PoV the driver is finished.

I have some technical review comments:

On Fri, Apr 19, 2024 at 10:07=E2=80=AFAM Aapo Vienamo
<aapo.vienamo@linux.intel.com> wrote:

> This driver provides a basic GPIO driver for the Intel Granite Rapids-D
> virtual GPIOs. On SoCs with limited physical pins on the package, the
> physical pins controlled by this driver would be exposed on an external
> device such as a BMC or CPLD.
>
> Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

OK I get how it works, but not all the way right? We write these registers,
and somehow that results on pins on a completely different piece of
silicon in a different package driving some lines low/high?

So ... can we write something about how the signal gets over there
from where the driver is running? It needs to happen somehow, right?

> +config GPIO_GRANITERAPIDS
> +       tristate "Intel Granite Rapids-D vGPIO support"
> +       depends on X86 || COMPILE_TEST
> +       select GPIOLIB_IRQCHIP
> +       help
> +         Select this to enable GPIO support on platforms with the follow=
ing
> +         SoCs:
> +
> +         - Intel Granite Rapids-D
> +
> +         The driver enables basic GPIO functionality and implements inte=
rrupt
> +         support.
> +
> +         To compile this driver as a module, choose M here: the module w=
ill
> +         be called gpio-graniterapids.

This help text is not as informative as the commit log. Write something
about how the GPIO works here, too.

> +static int gnr_gpio_configure_pad(struct gpio_chip *gc, unsigned int gpi=
o,
> +                                 u32 clear_mask, u32 set_mask)
> +{
> +       struct gnr_gpio *priv =3D gpiochip_get_data(gc);
> +       void __iomem *addr =3D gnr_gpio_get_padcfg_addr(priv, gpio);
> +       u32 dw;
> +
> +       if (test_bit(gpio, priv->ro_bitmap))
> +               return -EACCES;
> +
> +       guard(raw_spinlock_irqsave)(&priv->lock);
> +
> +       dw =3D readl(addr);
> +       dw &=3D ~clear_mask;
> +       dw |=3D set_mask;
> +       writel(dw, addr);
> +
> +       return 0;
> +}

Configure pad sounds like pin control so it's a bit of icky name.
What it really does is configure the direction (in or out) for this
GPIO pad. And it's not really the *pad* that is configured, right?
It is the hardware *driver* for the pad, i.e. what is reflected in
the GPIO line control register.

Can you rename this:
gnr_gpio_configure_direction()?

With the above stuff addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

