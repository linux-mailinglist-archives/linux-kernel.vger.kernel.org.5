Return-Path: <linux-kernel+bounces-71641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2D685A83D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E59C6B24CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9301E3DBA8;
	Mon, 19 Feb 2024 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bngmCOTL"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5603B7A9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358905; cv=none; b=L9WLvQ1xYED/A1kJrgKV9H9MGaKij7FShsHEcHm56q9KrkTvBquN5oc3rqV2YqcTYpLmUbEb+OAlcPkuJwuMPdqzQgshasDluhIuImQ5mfieozInvK3/BloahIWxWjGVdzPV/UVYocSH0yiAp1ArpreR/6NZ2g0bhwuc9cAxfjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358905; c=relaxed/simple;
	bh=mE2ioWa+nK06Ul9JOnjlCpHmBnRauhS8/1ZZnLWrLTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJQ6D6XaGF+BZVA2j9g09HDPa+2CzTyYCiTXGKNF6O9zqng1e5k4nTyCyeAjPgpDfKmKd2Fr7GSOv7AkJCbsIgzteXZSgbGBamkRKq+QRB2dU+KwDZRa286fNFlcpkxWj6uC7GFO3w5Tevxb6qkUGwGZP0uRPP1gakn+arNEWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bngmCOTL; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e2d83d2568so3125957a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708358900; x=1708963700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvB5cYOAVbHLURj4talifcczwe7iLf5Sx0hMgEl451A=;
        b=bngmCOTL5mkEHmcP1OTXbCINKskuXixHp7LciMUPXMy52hlPrxdIzunuq1KDoykfa8
         FfmOJR7LMDaF6cWQOFXpsVOfuvikVaUtu1J00xB7rxHGcNb/fktZMZjim6e9nCLdifuE
         TsnDt/8xeYcSW/sj/ihnUXlGJs1NHppsz0LyaFzRSxB8Hwp72Of9nrgzimUDedLO91mw
         a2xvsktyx25HSJh83es4uESAmTRvGqMm5/A4nAXpxBhM/IoHqgrKg1IRzNVHFk9A6gu4
         RQrMmlHFOlCDSgpsioqJVUy0aJpTVzAUX/4cXaWgkdif8FGc1Jp+XjYJ3e2Bc+0nBT6U
         F6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708358900; x=1708963700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvB5cYOAVbHLURj4talifcczwe7iLf5Sx0hMgEl451A=;
        b=mZbmoSaInA5chlZyM2TuUMYpYtUXRRvVAKDS7L56BFUSNgyiozw+yMGIyrY6iVmNDK
         GmtAXxYOC3l1rgoQ2MntVnM6DMwT0H316pxIc1H/V4JyxQQpiixctc3OHtwTzH6gRhVB
         hZ94u0Vhb/3BOovJ59K8nQYFjB46tMF3JC3r5MdTk754y4BXub0MKJ+hEw9J3AESXCt4
         m5gg51rR56d5IeQzOdPd+EbirvvjbByoKs7qC6/cNqpg4cx8dvk/7l8E+fXPWe5jRPqO
         evBUJF+oZvEPXB543tEYntaON3UtgeG/2a0fNaLGIvFJTTJGuCAhLMNW1kMdsZAA+iYh
         bWvg==
X-Forwarded-Encrypted: i=1; AJvYcCXVpDGLVYamVVIn6ftLZySDVditpirsfML28IpnsFfstvT3NgBWZeComjr+BRetRXZxXHmlmtGTLZ3+KMEDtSUY8c9rt3MzTnX+AVne
X-Gm-Message-State: AOJu0Yw2x8qA2f1SSER/Mc3QneE+Qcqobn0AHJBFiKi3VGWsFkPxqDjb
	PrR+KYm5+O/y8oYYYIbI+cECMaNV4Sdeo0P6rwP+6ePhWRE6cdX9NpqJeZ+Tr2vq2WqiKinIKhq
	7EgQHDg8CuZwACUu43dQ54XrnGDtO/VYGt8rCQw==
X-Google-Smtp-Source: AGHT+IEnTLZ0w9sERa5hgq7lUEKHxx1Szg7iESp9YoprPbwAMRk0yudwtYF0dVdrDs3+wUfRk0uPQ2U9kBncZRpuHzY=
X-Received: by 2002:a05:6808:bd0:b0:3c1:4b18:eb34 with SMTP id
 o16-20020a0568080bd000b003c14b18eb34mr10078647oik.29.1708358899648; Mon, 19
 Feb 2024 08:08:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com> <20240214-mbly-gpio-v1-5-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-5-f88c0ccf372b@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 17:08:08 +0100
Message-ID: <CAMRc=MfXHbpq7vgw64pYGGAyQQnYyGa1ei5NAQ6swtH7o--R=w@mail.gmail.com>
Subject: Re: [PATCH 05/23] gpio: nomadik: extract GPIO platform driver from drivers/pinctrl/nomadik/
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:
>
> Previously, drivers/pinctrl/nomadik/pinctrl-nomadik.c registered two
> platform drivers: pinctrl & GPIO. Move the GPIO aspect to the
> drivers/gpio/ folder, as would be expected.
>
> Both drivers are intertwined for a reason; pinctrl requires access to
> GPIO registers for pinmuxing, pull-disable, disabling interrupts while
> setting the muxing and wakeup control. Information sharing is done
> through a shared array containing GPIO chips and a few helper
> functions. That shared array is not touched from gpio-nomadik when
> CONFIG_PINCTRL_NOMADIK is not defined.
>
> Make no change to the code that moved into gpio-nomadik; there should be
> no behavior change following. A few functions are shared and header
> comments are added. Checkpatch warnings are addressed. NUM_BANKS is
> renamed to NMK_MAX_BANKS.
>
> It is supported to compile gpio-nomadik without pinctrl-nomadik. The
> opposite is not true.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  MAINTAINERS                                        |   1 +
>  drivers/gpio/Kconfig                               |  12 +
>  drivers/gpio/Makefile                              |   1 +
>  drivers/gpio/gpio-nomadik.c                        | 660 +++++++++++++++=
++++
>  drivers/pinctrl/nomadik/Kconfig                    |   5 +-
>  drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c   |   3 +-
>  drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c  |   3 +-
>  drivers/pinctrl/nomadik/pinctrl-nomadik.c          | 722 +--------------=
------
>  .../linux/gpio/gpio-nomadik.h                      | 122 +++-
>  9 files changed, 804 insertions(+), 725 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0cb2c459d1cf..3f864e773267 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2474,6 +2474,7 @@ F:        drivers/clk/clk-nomadik.c
>  F:     drivers/clocksource/clksrc-dbx500-prcmu.c
>  F:     drivers/dma/ste_dma40*
>  F:     drivers/pmdomain/st/ste-ux500-pm-domain.c
> +F:     drivers/gpio/gpio-nomadik.c
>  F:     drivers/hwspinlock/u8500_hsem.c
>  F:     drivers/i2c/busses/i2c-nomadik.c
>  F:     drivers/iio/adc/ab8500-gpadc.c
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 1301cec94f12..ff83371251c1 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -478,6 +478,18 @@ config GPIO_MXS
>         select GPIO_GENERIC
>         select GENERIC_IRQ_CHIP
>
> +config GPIO_NOMADIK
> +       bool "Nomadik GPIO driver"
> +       depends on ARCH_U8500 || ARCH_NOMADIK || COMPILE_TEST
> +       select OF_GPIO
> +       select GPIOLIB_IRQCHIP
> +       help
> +         Say yes here to support the Nomadik SoC GPIO block.
> +
> +         It handles up to 32 GPIOs per bank, that can all be interrupt s=
ources.
> +         It is deeply interconnected with the associated pinctrl driver =
as GPIO
> +         registers handle muxing ("alternate functions") as well.
> +
>  config GPIO_NPCM_SGPIO
>         bool "Nuvoton SGPIO support"
>         depends on ARCH_NPCM || COMPILE_TEST
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 9e40af196aae..9fc2f5931b22 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -116,6 +116,7 @@ obj-$(CONFIG_GPIO_MT7621)           +=3D gpio-mt7621.=
o
>  obj-$(CONFIG_GPIO_MVEBU)               +=3D gpio-mvebu.o
>  obj-$(CONFIG_GPIO_MXC)                 +=3D gpio-mxc.o
>  obj-$(CONFIG_GPIO_MXS)                 +=3D gpio-mxs.o
> +obj-$(CONFIG_GPIO_NOMADIK)             +=3D gpio-nomadik.o
>  obj-$(CONFIG_GPIO_NPCM_SGPIO)          +=3D gpio-npcm-sgpio.o
>  obj-$(CONFIG_GPIO_OCTEON)              +=3D gpio-octeon.o
>  obj-$(CONFIG_GPIO_OMAP)                        +=3D gpio-omap.o
> diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
> new file mode 100644
> index 000000000000..e39477e1a58f
> --- /dev/null
> +++ b/drivers/gpio/gpio-nomadik.c
> @@ -0,0 +1,660 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * GPIO driver for the IP block found in the Nomadik SoC; it is an AMBA =
device,
> + * managing 32 pins with alternate functions. It can also handle the STA=
2X11
> + * block from ST.
> + *
> + * The GPIO chips are shared with pinctrl-nomadik if used; it needs acce=
ss for
> + * pinmuxing functionality and others.
> + *
> + * Copyright (C) 2008,2009 STMicroelectronics
> + * Copyright (C) 2009 Alessandro Rubini <rubini@unipv.it>
> + *   Rewritten based on work by Prafulla WADASKAR <prafulla.wadaskar@st.=
com>
> + * Copyright (C) 2011-2013 Linus Walleij <linus.walleij@linaro.org>
> + */

Add a newline here.

> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/seq_file.h>
> +#include <linux/types.h>

You need linux/slab.h for GFP flags.

> +
> +#include <linux/gpio/gpio-nomadik.h>
> +
> +#ifndef CONFIG_PINCTRL_NOMADIK
> +static DEFINE_SPINLOCK(nmk_gpio_slpm_lock);
> +#endif
> +
> +void __nmk_gpio_set_slpm(struct nmk_gpio_chip *nmk_chip, unsigned int of=
fset,
> +                        enum nmk_gpio_slpm mode)
> +{
> +       u32 slpm;
> +
> +       slpm =3D readl(nmk_chip->addr + NMK_GPIO_SLPC);
> +       if (mode =3D=3D NMK_GPIO_SLPM_NOCHANGE)
> +               slpm |=3D BIT(offset);
> +       else
> +               slpm &=3D ~BIT(offset);
> +       writel(slpm, nmk_chip->addr + NMK_GPIO_SLPC);
> +}
> +
> +static void __nmk_gpio_set_output(struct nmk_gpio_chip *nmk_chip,
> +                                 unsigned int offset, int val)
> +{
> +       if (val)
> +               writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DATS);
> +       else
> +               writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DATC);
> +}
> +
> +void __nmk_gpio_make_output(struct nmk_gpio_chip *nmk_chip,
> +                           unsigned int offset, int val)
> +{
> +       writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DIRS);
> +       __nmk_gpio_set_output(nmk_chip, offset, val);
> +}
> +
> +/* IRQ functions */
> +
> +static void nmk_gpio_irq_ack(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> +
> +       clk_enable(nmk_chip->clk);
> +       writel(BIT(d->hwirq), nmk_chip->addr + NMK_GPIO_IC);
> +       clk_disable(nmk_chip->clk);
> +}
> +
> +enum nmk_gpio_irq_type {
> +       NORMAL,
> +       WAKE,
> +};
> +
> +static void __nmk_gpio_irq_modify(struct nmk_gpio_chip *nmk_chip,
> +                                 int offset, enum nmk_gpio_irq_type whic=
h,
> +                                 bool enable)
> +{
> +       u32 *rimscval;
> +       u32 *fimscval;
> +       u32 rimscreg;
> +       u32 fimscreg;
> +
> +       if (which =3D=3D NORMAL) {
> +               rimscreg =3D NMK_GPIO_RIMSC;
> +               fimscreg =3D NMK_GPIO_FIMSC;
> +               rimscval =3D &nmk_chip->rimsc;
> +               fimscval =3D &nmk_chip->fimsc;
> +       } else  {
> +               rimscreg =3D NMK_GPIO_RWIMSC;
> +               fimscreg =3D NMK_GPIO_FWIMSC;
> +               rimscval =3D &nmk_chip->rwimsc;
> +               fimscval =3D &nmk_chip->fwimsc;
> +       }
> +
> +       /* we must individually set/clear the two edges */
> +       if (nmk_chip->edge_rising & BIT(offset)) {
> +               if (enable)
> +                       *rimscval |=3D BIT(offset);
> +               else
> +                       *rimscval &=3D ~BIT(offset);
> +               writel(*rimscval, nmk_chip->addr + rimscreg);
> +       }
> +       if (nmk_chip->edge_falling & BIT(offset)) {
> +               if (enable)
> +                       *fimscval |=3D BIT(offset);
> +               else
> +                       *fimscval &=3D ~BIT(offset);
> +               writel(*fimscval, nmk_chip->addr + fimscreg);
> +       }
> +}
> +
> +static void __nmk_gpio_set_wake(struct nmk_gpio_chip *nmk_chip,
> +                               int offset, bool on)
> +{
> +       /*
> +        * Ensure WAKEUP_ENABLE is on.  No need to disable it if wakeup i=
s
> +        * disabled, since setting SLPM to 1 increases power consumption,=
 and
> +        * wakeup is anyhow controlled by the RIMSC and FIMSC registers.
> +        */
> +       if (nmk_chip->sleepmode && on) {
> +               __nmk_gpio_set_slpm(nmk_chip, offset,
> +                                   NMK_GPIO_SLPM_WAKEUP_ENABLE);
> +       }
> +
> +       __nmk_gpio_irq_modify(nmk_chip, offset, WAKE, on);
> +}
> +
> +static void nmk_gpio_irq_maskunmask(struct nmk_gpio_chip *nmk_chip,
> +                                   struct irq_data *d, bool enable)
> +{
> +       unsigned long flags;
> +
> +       clk_enable(nmk_chip->clk);
> +       spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
> +       spin_lock(&nmk_chip->lock);
> +
> +       __nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, enable);
> +
> +       if (!(nmk_chip->real_wake & BIT(d->hwirq)))
> +               __nmk_gpio_set_wake(nmk_chip, d->hwirq, enable);
> +
> +       spin_unlock(&nmk_chip->lock);
> +       spin_unlock_irqrestore(&nmk_gpio_slpm_lock, flags);
> +       clk_disable(nmk_chip->clk);
> +}
> +
> +static void nmk_gpio_irq_mask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> +
> +       nmk_gpio_irq_maskunmask(nmk_chip, d, false);
> +       gpiochip_disable_irq(gc, irqd_to_hwirq(d));
> +}
> +
> +static void nmk_gpio_irq_unmask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> +
> +       gpiochip_enable_irq(gc, irqd_to_hwirq(d));
> +       nmk_gpio_irq_maskunmask(nmk_chip, d, true);
> +}
> +
> +static int nmk_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> +       unsigned long flags;
> +
> +       clk_enable(nmk_chip->clk);
> +       spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
> +       spin_lock(&nmk_chip->lock);
> +
> +       if (irqd_irq_disabled(d))
> +               __nmk_gpio_set_wake(nmk_chip, d->hwirq, on);
> +
> +       if (on)
> +               nmk_chip->real_wake |=3D BIT(d->hwirq);
> +       else
> +               nmk_chip->real_wake &=3D ~BIT(d->hwirq);
> +
> +       spin_unlock(&nmk_chip->lock);
> +       spin_unlock_irqrestore(&nmk_gpio_slpm_lock, flags);
> +       clk_disable(nmk_chip->clk);
> +
> +       return 0;
> +}
> +
> +static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> +       bool enabled =3D !irqd_irq_disabled(d);
> +       bool wake =3D irqd_is_wakeup_set(d);
> +       unsigned long flags;
> +
> +       if (type & IRQ_TYPE_LEVEL_HIGH)
> +               return -EINVAL;
> +       if (type & IRQ_TYPE_LEVEL_LOW)
> +               return -EINVAL;
> +
> +       clk_enable(nmk_chip->clk);
> +       spin_lock_irqsave(&nmk_chip->lock, flags);
> +
> +       if (enabled)
> +               __nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, false);
> +
> +       if (enabled || wake)
> +               __nmk_gpio_irq_modify(nmk_chip, d->hwirq, WAKE, false);
> +
> +       nmk_chip->edge_rising &=3D ~BIT(d->hwirq);
> +       if (type & IRQ_TYPE_EDGE_RISING)
> +               nmk_chip->edge_rising |=3D BIT(d->hwirq);
> +
> +       nmk_chip->edge_falling &=3D ~BIT(d->hwirq);
> +       if (type & IRQ_TYPE_EDGE_FALLING)
> +               nmk_chip->edge_falling |=3D BIT(d->hwirq);
> +
> +       if (enabled)
> +               __nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, true);
> +
> +       if (enabled || wake)
> +               __nmk_gpio_irq_modify(nmk_chip, d->hwirq, WAKE, true);
> +
> +       spin_unlock_irqrestore(&nmk_chip->lock, flags);
> +       clk_disable(nmk_chip->clk);
> +
> +       return 0;
> +}
> +
> +static unsigned int nmk_gpio_irq_startup(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> +
> +       clk_enable(nmk_chip->clk);
> +       nmk_gpio_irq_unmask(d);
> +       return 0;
> +}
> +
> +static void nmk_gpio_irq_shutdown(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> +
> +       nmk_gpio_irq_mask(d);
> +       clk_disable(nmk_chip->clk);
> +}
> +
> +static void nmk_gpio_irq_handler(struct irq_desc *desc)
> +{
> +       struct irq_chip *host_chip =3D irq_desc_get_chip(desc);
> +       struct gpio_chip *chip =3D irq_desc_get_handler_data(desc);
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(chip);
> +       u32 status;
> +
> +       chained_irq_enter(host_chip, desc);
> +
> +       clk_enable(nmk_chip->clk);
> +       status =3D readl(nmk_chip->addr + NMK_GPIO_IS);
> +       clk_disable(nmk_chip->clk);
> +
> +       while (status) {
> +               int bit =3D __ffs(status);
> +
> +               generic_handle_domain_irq(chip->irq.domain, bit);
> +               status &=3D ~BIT(bit);
> +       }
> +
> +       chained_irq_exit(host_chip, desc);
> +}
> +
> +/* I/O Functions */
> +
> +static int nmk_gpio_get_dir(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(chip);
> +       int dir;
> +
> +       clk_enable(nmk_chip->clk);
> +
> +       dir =3D readl(nmk_chip->addr + NMK_GPIO_DIR) & BIT(offset);
> +
> +       clk_disable(nmk_chip->clk);
> +
> +       if (dir)
> +               return GPIO_LINE_DIRECTION_OUT;
> +
> +       return GPIO_LINE_DIRECTION_IN;
> +}
> +
> +static int nmk_gpio_make_input(struct gpio_chip *chip, unsigned int offs=
et)
> +{
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(chip);
> +
> +       clk_enable(nmk_chip->clk);
> +
> +       writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DIRC);
> +
> +       clk_disable(nmk_chip->clk);
> +
> +       return 0;
> +}
> +
> +static int nmk_gpio_get_input(struct gpio_chip *chip, unsigned int offse=
t)
> +{
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(chip);
> +       int value;
> +
> +       clk_enable(nmk_chip->clk);
> +
> +       value =3D !!(readl(nmk_chip->addr + NMK_GPIO_DAT) & BIT(offset));
> +
> +       clk_disable(nmk_chip->clk);
> +
> +       return value;
> +}
> +
> +static void nmk_gpio_set_output(struct gpio_chip *chip, unsigned int off=
set,
> +                               int val)
> +{
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(chip);
> +
> +       clk_enable(nmk_chip->clk);
> +
> +       __nmk_gpio_set_output(nmk_chip, offset, val);
> +
> +       clk_disable(nmk_chip->clk);
> +}
> +
> +static int nmk_gpio_make_output(struct gpio_chip *chip, unsigned int off=
set,
> +                               int val)
> +{
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(chip);
> +
> +       clk_enable(nmk_chip->clk);
> +
> +       __nmk_gpio_make_output(nmk_chip, offset, val);
> +
> +       clk_disable(nmk_chip->clk);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +
> +static int nmk_gpio_get_mode(struct nmk_gpio_chip *nmk_chip, int offset)
> +{
> +       u32 afunc, bfunc;
> +
> +       clk_enable(nmk_chip->clk);
> +
> +       afunc =3D readl(nmk_chip->addr + NMK_GPIO_AFSLA) & BIT(offset);
> +       bfunc =3D readl(nmk_chip->addr + NMK_GPIO_AFSLB) & BIT(offset);
> +
> +       clk_disable(nmk_chip->clk);
> +
> +       return (afunc ? NMK_GPIO_ALT_A : 0) | (bfunc ? NMK_GPIO_ALT_B : 0=
);
> +}
> +
> +void nmk_gpio_dbg_show_one(struct seq_file *s, struct pinctrl_dev *pctld=
ev,
> +                          struct gpio_chip *chip, unsigned int offset,
> +                          unsigned int gpio)
> +{
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(chip);
> +       int mode;
> +       bool is_out;
> +       bool data_out;
> +       bool pull;
> +       static const char * const modes[] =3D {
> +               [NMK_GPIO_ALT_GPIO]     =3D "gpio",
> +               [NMK_GPIO_ALT_A]        =3D "altA",
> +               [NMK_GPIO_ALT_B]        =3D "altB",
> +               [NMK_GPIO_ALT_C]        =3D "altC",
> +               [NMK_GPIO_ALT_C + 1]    =3D "altC1",
> +               [NMK_GPIO_ALT_C + 2]    =3D "altC2",
> +               [NMK_GPIO_ALT_C + 3]    =3D "altC3",
> +               [NMK_GPIO_ALT_C + 4]    =3D "altC4",
> +       };
> +
> +       char *label =3D gpiochip_dup_line_label(chip, offset);
> +       if (IS_ERR(label))
> +               return;
> +
> +       clk_enable(nmk_chip->clk);
> +       is_out =3D !!(readl(nmk_chip->addr + NMK_GPIO_DIR) & BIT(offset))=
;
> +       pull =3D !(readl(nmk_chip->addr + NMK_GPIO_PDIS) & BIT(offset));
> +       data_out =3D !!(readl(nmk_chip->addr + NMK_GPIO_DAT) & BIT(offset=
));
> +       mode =3D nmk_gpio_get_mode(nmk_chip, offset);
> +#ifdef CONFIG_PINCTRL_NOMADIK
> +       if (mode =3D=3D NMK_GPIO_ALT_C && pctldev)
> +               mode =3D nmk_prcm_gpiocr_get_mode(pctldev, gpio);
> +#endif
> +
> +       if (is_out) {
> +               seq_printf(s, " gpio-%-3d (%-20.20s) out %s           %s"=
,
> +                          gpio,
> +                          label ?: "(none)",
> +                          data_out ? "hi" : "lo",
> +                          (mode < 0) ? "unknown" : modes[mode]);
> +       } else {
> +               int irq =3D chip->to_irq(chip, offset);
> +               const int pullidx =3D pull ? 1 : 0;
> +               int val;
> +               static const char * const pulls[] =3D {
> +                       "none        ",
> +                       "pull enabled",
> +               };
> +
> +               seq_printf(s, " gpio-%-3d (%-20.20s) in  %s %s",
> +                          gpio,
> +                          label ?: "(none)",
> +                          pulls[pullidx],
> +                          (mode < 0) ? "unknown" : modes[mode]);
> +
> +               val =3D nmk_gpio_get_input(chip, offset);
> +               seq_printf(s, " VAL %d", val);
> +
> +               /*
> +                * This races with request_irq(), set_irq_type(),
> +                * and set_irq_wake() ... but those are "rare".
> +                */
> +               if (irq > 0 && irq_has_action(irq)) {
> +                       char *trigger;
> +                       bool wake;
> +
> +                       if (nmk_chip->edge_rising & BIT(offset))
> +                               trigger =3D "edge-rising";
> +                       else if (nmk_chip->edge_falling & BIT(offset))
> +                               trigger =3D "edge-falling";
> +                       else
> +                               trigger =3D "edge-undefined";
> +
> +                       wake =3D !!(nmk_chip->real_wake & BIT(offset));
> +
> +                       seq_printf(s, " irq-%d %s%s",
> +                                  irq, trigger, wake ? " wakeup" : "");
> +               }
> +       }
> +       clk_disable(nmk_chip->clk);
> +}
> +
> +static void nmk_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip=
)
> +{
> +       unsigned int i, gpio =3D chip->base;
> +
> +       for (i =3D 0; i < chip->ngpio; i++, gpio++) {
> +               nmk_gpio_dbg_show_one(s, NULL, chip, i, gpio);
> +               seq_puts(s, "\n");
> +       }
> +}
> +
> +#else
> +
> +static inline void nmk_gpio_dbg_show_one(struct seq_file *s,
> +                                        struct pinctrl_dev *pctldev,
> +                                        struct gpio_chip *chip,
> +                                        unsigned int offset,
> +                                        unsigned int gpio)
> +{
> +}
> +
> +#define nmk_gpio_dbg_show      NULL
> +
> +#endif
> +
> +/*
> + * We will allocate memory for the state container using devm* allocator=
s
> + * binding to the first device reaching this point, it doesn't matter if
> + * it is the pin controller or GPIO driver. However we need to use the r=
ight
> + * platform device when looking up resources so pay attention to pdev.
> + */
> +struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
> +                                            struct platform_device *pdev=
)
> +{
> +       struct nmk_gpio_chip *nmk_chip;
> +       struct platform_device *gpio_pdev;
> +       struct gpio_chip *chip;
> +       struct resource *res;
> +       struct clk *clk;
> +       void __iomem *base;
> +       u32 id;
> +
> +       gpio_pdev =3D of_find_device_by_node(np);

Any way we can avoid using OF APIs here? How about bus_find_device_by_fwnod=
e()?

In general I'd like to avoid adding new calls to OF functions and use
generic device properties everywhere, so all of_property_* in the
series would ideally be replaced with device_property_* alternatives.

> +       if (!gpio_pdev) {
> +               pr_err("populate \"%pOFn\": device not found\n", np);
> +               return ERR_PTR(-ENODEV);
> +       }
> +       if (of_property_read_u32(np, "gpio-bank", &id)) {
> +               dev_err(&pdev->dev, "populate: gpio-bank property not fou=
nd\n");
> +               platform_device_put(gpio_pdev);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +#ifdef CONFIG_PINCTRL_NOMADIK
> +       /* Already populated? */
> +       nmk_chip =3D nmk_gpio_chips[id];
> +       if (nmk_chip) {
> +               platform_device_put(gpio_pdev);
> +               return nmk_chip;
> +       }
> +#endif
> +
> +       nmk_chip =3D devm_kzalloc(&pdev->dev, sizeof(*nmk_chip), GFP_KERN=
EL);
> +       if (!nmk_chip) {
> +               platform_device_put(gpio_pdev);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       nmk_chip->bank =3D id;
> +       chip =3D &nmk_chip->chip;
> +       chip->base =3D id * NMK_GPIO_PER_CHIP;
> +       chip->ngpio =3D NMK_GPIO_PER_CHIP;
> +       chip->label =3D dev_name(&gpio_pdev->dev);
> +       chip->parent =3D &gpio_pdev->dev;
> +
> +       res =3D platform_get_resource(gpio_pdev, IORESOURCE_MEM, 0);
> +       base =3D devm_ioremap_resource(&pdev->dev, res);

devm_platform_ioremap_resource()?

> +       if (IS_ERR(base)) {
> +               platform_device_put(gpio_pdev);
> +               return ERR_CAST(base);
> +       }
> +       nmk_chip->addr =3D base;
> +
> +       clk =3D clk_get(&gpio_pdev->dev, NULL);

devm_clk_get()?

> +       if (IS_ERR(clk)) {
> +               platform_device_put(gpio_pdev);
> +               return (void *)clk;
> +       }
> +       clk_prepare(clk);
> +       nmk_chip->clk =3D clk;
> +
> +#ifdef CONFIG_PINCTRL_NOMADIK
> +       BUG_ON(nmk_chip->bank >=3D ARRAY_SIZE(nmk_gpio_chips));
> +       nmk_gpio_chips[id] =3D nmk_chip;
> +#endif
> +       return nmk_chip;
> +}
> +
> +static void nmk_gpio_irq_print_chip(struct irq_data *d, struct seq_file =
*p)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> +
> +       seq_printf(p, "nmk%u-%u-%u", nmk_chip->bank,
> +                  gc->base, gc->base + gc->ngpio - 1);
> +}
> +
> +static const struct irq_chip nmk_irq_chip =3D {
> +       .irq_ack =3D nmk_gpio_irq_ack,
> +       .irq_mask =3D nmk_gpio_irq_mask,
> +       .irq_unmask =3D nmk_gpio_irq_unmask,
> +       .irq_set_type =3D nmk_gpio_irq_set_type,
> +       .irq_set_wake =3D nmk_gpio_irq_set_wake,
> +       .irq_startup =3D nmk_gpio_irq_startup,
> +       .irq_shutdown =3D nmk_gpio_irq_shutdown,
> +       .irq_print_chip =3D nmk_gpio_irq_print_chip,
> +       .flags =3D IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};
> +
> +static int nmk_gpio_probe(struct platform_device *dev)
> +{
> +       struct device_node *np =3D dev->dev.of_node;
> +       struct nmk_gpio_chip *nmk_chip;
> +       struct gpio_chip *chip;
> +       struct gpio_irq_chip *girq;
> +       bool supports_sleepmode;
> +       int irq;
> +       int ret;
> +
> +       nmk_chip =3D nmk_gpio_populate_chip(np, dev);
> +       if (IS_ERR(nmk_chip)) {
> +               dev_err(&dev->dev, "could not populate nmk chip struct\n"=
);
> +               return PTR_ERR(nmk_chip);
> +       }
> +
> +       supports_sleepmode =3D
> +               of_property_read_bool(np, "st,supports-sleepmode");
> +
> +       /* Correct platform device ID */
> +       dev->id =3D nmk_chip->bank;
> +
> +       irq =3D platform_get_irq(dev, 0);
> +       if (irq < 0)
> +               return irq;
> +
> +       /*
> +        * The virt address in nmk_chip->addr is in the nomadik register =
space,
> +        * so we can simply convert the resource address, without remappi=
ng
> +        */
> +       nmk_chip->sleepmode =3D supports_sleepmode;
> +       spin_lock_init(&nmk_chip->lock);
> +
> +       chip =3D &nmk_chip->chip;
> +       chip->parent =3D &dev->dev;
> +       chip->request =3D gpiochip_generic_request;
> +       chip->free =3D gpiochip_generic_free;
> +       chip->get_direction =3D nmk_gpio_get_dir;
> +       chip->direction_input =3D nmk_gpio_make_input;
> +       chip->get =3D nmk_gpio_get_input;
> +       chip->direction_output =3D nmk_gpio_make_output;
> +       chip->set =3D nmk_gpio_set_output;
> +       chip->dbg_show =3D nmk_gpio_dbg_show;
> +       chip->can_sleep =3D false;
> +       chip->owner =3D THIS_MODULE;
> +
> +       girq =3D &chip->irq;
> +       gpio_irq_chip_set_chip(girq, &nmk_irq_chip);
> +       girq->parent_handler =3D nmk_gpio_irq_handler;
> +       girq->num_parents =3D 1;
> +       girq->parents =3D devm_kcalloc(&dev->dev, 1,
> +                                    sizeof(*girq->parents),
> +                                    GFP_KERNEL);
> +       if (!girq->parents)
> +               return -ENOMEM;
> +       girq->parents[0] =3D irq;
> +       girq->default_type =3D IRQ_TYPE_NONE;
> +       girq->handler =3D handle_edge_irq;
> +
> +       clk_enable(nmk_chip->clk);
> +       nmk_chip->lowemi =3D readl_relaxed(nmk_chip->addr + NMK_GPIO_LOWE=
MI);
> +       clk_disable(nmk_chip->clk);
> +
> +       ret =3D gpiochip_add_data(chip, nmk_chip);
> +       if (ret)
> +               return ret;
> +
> +       platform_set_drvdata(dev, nmk_chip);
> +
> +       dev_info(&dev->dev, "chip registered\n");
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id nmk_gpio_match[] =3D {
> +       { .compatible =3D "st,nomadik-gpio", },
> +       {}
> +};
> +
> +static struct platform_driver nmk_gpio_driver =3D {
> +       .driver =3D {
> +               .name =3D "gpio",
> +               .of_match_table =3D nmk_gpio_match,
> +       },
> +       .probe =3D nmk_gpio_probe,
> +};
> +
> +static int __init nmk_gpio_init(void)
> +{
> +       return platform_driver_register(&nmk_gpio_driver);
> +}
> +subsys_initcall(nmk_gpio_init);
> diff --git a/drivers/pinctrl/nomadik/Kconfig b/drivers/pinctrl/nomadik/Kc=
onfig
> index 0fea167c283f..f47f0755a835 100644
> --- a/drivers/pinctrl/nomadik/Kconfig
> +++ b/drivers/pinctrl/nomadik/Kconfig
> @@ -22,11 +22,10 @@ if (ARCH_U8500 || ARCH_NOMADIK)
>
>  config PINCTRL_NOMADIK
>         bool "Nomadik pin controller driver"
> -       depends on OF && GPIOLIB
> +       depends on OF
>         select PINMUX
>         select PINCONF
> -       select OF_GPIO
> -       select GPIOLIB_IRQCHIP
> +       select GPIO_NOMADIK
>
>  config PINCTRL_STN8815
>         bool "STN8815 pin controller driver"
> diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c b/drivers/p=
inctrl/nomadik/pinctrl-nomadik-db8500.c
> index 490e0959e8be..0b4a3dd9d8c7 100644
> --- a/drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c
> +++ b/drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c
> @@ -3,8 +3,9 @@
>  #include <linux/types.h>
>
>  #include <linux/pinctrl/pinctrl.h>
> +#include <linux/gpio/driver.h>
>
> -#include "pinctrl-nomadik.h"
> +#include <linux/gpio/gpio-nomadik.h>
>
>  /* All the pins that can be used for GPIO and some other functions */
>  #define _GPIO(offset)          (offset)
> diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c b/drivers/=
pinctrl/nomadik/pinctrl-nomadik-stn8815.c
> index 1552222ac68e..c5a52fcaba30 100644
> --- a/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c
> +++ b/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c
> @@ -3,8 +3,9 @@
>  #include <linux/types.h>
>
>  #include <linux/pinctrl/pinctrl.h>
> +#include <linux/gpio/driver.h>
>
> -#include "pinctrl-nomadik.h"
> +#include <linux/gpio/gpio-nomadik.h>
>
>  /* All the pins that can be used for GPIO and some other functions */
>  #define _GPIO(offset)          (offset)
> diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/=
nomadik/pinctrl-nomadik.c
> index 7911353ac97d..f3897dbfa2c3 100644
> --- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
> +++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Generic GPIO driver for logic cells found in the Nomadik SoC
> + * Pinmux & pinconf driver for the IP block found in the Nomadik SoC. Th=
is
> + * depends on gpio-nomadik and some handling is intertwined; see nmk_gpi=
o_chips
> + * which is used by this driver to access the GPIO banks array.
>   *
>   * Copyright (C) 2008,2009 STMicroelectronics
>   * Copyright (C) 2009 Alessandro Rubini <rubini@unipv.it>
> @@ -25,6 +27,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/types.h>
>
>  /* Since we request GPIOs from ourself */
>  #include <linux/pinctrl/consumer.h>
> @@ -36,15 +39,7 @@
>  #include "../core.h"
>  #include "../pinctrl-utils.h"
>
> -#include "pinctrl-nomadik.h"
> -
> -/*
> - * The GPIO module in the Nomadik family of Systems-on-Chip is an
> - * AMBA device, managing 32 pins and alternate functions.  The logic blo=
ck
> - * is currently used in the Nomadik and ux500.
> - *
> - * Symbols in this file are called "nmk_gpio" for "nomadik gpio"
> - */
> +#include <linux/gpio/gpio-nomadik.h>
>
>  /*
>   * pin configurations are represented by 32-bit integers:
> @@ -200,75 +195,6 @@ typedef unsigned long pin_cfg_t;
>         (PIN_CFG_DEFAULT |\
>          (PIN_NUM(num) | PIN_##alt | PIN_OUTPUT_##val))
>
> -/*
> - * "nmk_gpio" and "NMK_GPIO" stand for "Nomadik GPIO", leaving
> - * the "gpio" namespace for generic and cross-machine functions
> - */
> -
> -#define GPIO_BLOCK_SHIFT 5
> -#define NMK_GPIO_PER_CHIP (1 << GPIO_BLOCK_SHIFT)
> -#define NMK_MAX_BANKS DIV_ROUND_UP(512, NMK_GPIO_PER_CHIP)
> -
> -/* Register in the logic block */
> -#define NMK_GPIO_DAT   0x00
> -#define NMK_GPIO_DATS  0x04
> -#define NMK_GPIO_DATC  0x08
> -#define NMK_GPIO_PDIS  0x0c
> -#define NMK_GPIO_DIR   0x10
> -#define NMK_GPIO_DIRS  0x14
> -#define NMK_GPIO_DIRC  0x18
> -#define NMK_GPIO_SLPC  0x1c
> -#define NMK_GPIO_AFSLA 0x20
> -#define NMK_GPIO_AFSLB 0x24
> -#define NMK_GPIO_LOWEMI        0x28
> -
> -#define NMK_GPIO_RIMSC 0x40
> -#define NMK_GPIO_FIMSC 0x44
> -#define NMK_GPIO_IS    0x48
> -#define NMK_GPIO_IC    0x4c
> -#define NMK_GPIO_RWIMSC        0x50
> -#define NMK_GPIO_FWIMSC        0x54
> -#define NMK_GPIO_WKS   0x58
> -/* These appear in DB8540 and later ASICs */
> -#define NMK_GPIO_EDGELEVEL 0x5C
> -#define NMK_GPIO_LEVEL 0x60
> -
> -
> -/* Pull up/down values */
> -enum nmk_gpio_pull {
> -       NMK_GPIO_PULL_NONE,
> -       NMK_GPIO_PULL_UP,
> -       NMK_GPIO_PULL_DOWN,
> -};
> -
> -/* Sleep mode */
> -enum nmk_gpio_slpm {
> -       NMK_GPIO_SLPM_INPUT,
> -       NMK_GPIO_SLPM_WAKEUP_ENABLE =3D NMK_GPIO_SLPM_INPUT,
> -       NMK_GPIO_SLPM_NOCHANGE,
> -       NMK_GPIO_SLPM_WAKEUP_DISABLE =3D NMK_GPIO_SLPM_NOCHANGE,
> -};
> -
> -struct nmk_gpio_chip {
> -       struct gpio_chip chip;
> -       void __iomem *addr;
> -       struct clk *clk;
> -       unsigned int bank;
> -       void (*set_ioforce)(bool enable);
> -       spinlock_t lock;
> -       bool sleepmode;
> -       /* Keep track of configured edges */
> -       u32 edge_rising;
> -       u32 edge_falling;
> -       u32 real_wake;
> -       u32 rwimsc;
> -       u32 fwimsc;
> -       u32 rimsc;
> -       u32 fimsc;
> -       u32 pull_up;
> -       u32 lowemi;
> -};
> -
>  /**
>   * struct nmk_pinctrl - state container for the Nomadik pin controller
>   * @dev: containing device pointer
> @@ -283,11 +209,10 @@ struct nmk_pinctrl {
>         void __iomem *prcm_base;
>  };
>
> -static struct nmk_gpio_chip *nmk_gpio_chips[NMK_MAX_BANKS];
> +/* See nmk_gpio_populate_chip() that fills this array. */
> +struct nmk_gpio_chip *nmk_gpio_chips[NMK_MAX_BANKS];
>
> -static DEFINE_SPINLOCK(nmk_gpio_slpm_lock);
> -
> -#define NUM_BANKS ARRAY_SIZE(nmk_gpio_chips)
> +DEFINE_SPINLOCK(nmk_gpio_slpm_lock);
>
>  static void __nmk_gpio_set_mode(struct nmk_gpio_chip *nmk_chip,
>                                 unsigned offset, int gpio_mode)
> @@ -304,19 +229,6 @@ static void __nmk_gpio_set_mode(struct nmk_gpio_chip=
 *nmk_chip,
>         writel(bfunc, nmk_chip->addr + NMK_GPIO_AFSLB);
>  }
>
> -static void __nmk_gpio_set_slpm(struct nmk_gpio_chip *nmk_chip,
> -                               unsigned offset, enum nmk_gpio_slpm mode)
> -{
> -       u32 slpm;
> -
> -       slpm =3D readl(nmk_chip->addr + NMK_GPIO_SLPC);
> -       if (mode =3D=3D NMK_GPIO_SLPM_NOCHANGE)
> -               slpm |=3D BIT(offset);
> -       else
> -               slpm &=3D ~BIT(offset);
> -       writel(slpm, nmk_chip->addr + NMK_GPIO_SLPC);
> -}
> -
>  static void __nmk_gpio_set_pull(struct nmk_gpio_chip *nmk_chip,
>                                 unsigned offset, enum nmk_gpio_pull pull)
>  {
> @@ -364,22 +276,6 @@ static void __nmk_gpio_make_input(struct nmk_gpio_ch=
ip *nmk_chip,
>         writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DIRC);
>  }
>
> -static void __nmk_gpio_set_output(struct nmk_gpio_chip *nmk_chip,
> -                                 unsigned offset, int val)
> -{
> -       if (val)
> -               writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DATS);
> -       else
> -               writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DATC);
> -}
> -
> -static void __nmk_gpio_make_output(struct nmk_gpio_chip *nmk_chip,
> -                                 unsigned offset, int val)
> -{
> -       writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DIRS);
> -       __nmk_gpio_set_output(nmk_chip, offset, val);
> -}
> -
>  static void __nmk_gpio_set_mode_safe(struct nmk_gpio_chip *nmk_chip,
>                                      unsigned offset, int gpio_mode,
>                                      bool glitch)
> @@ -548,7 +444,7 @@ static void nmk_gpio_glitch_slpm_init(unsigned int *s=
lpm)
>  {
>         int i;
>
> -       for (i =3D 0; i < NUM_BANKS; i++) {
> +       for (i =3D 0; i < NMK_MAX_BANKS; i++) {
>                 struct nmk_gpio_chip *chip =3D nmk_gpio_chips[i];
>                 unsigned int temp =3D slpm[i];
>
> @@ -566,7 +462,7 @@ static void nmk_gpio_glitch_slpm_restore(unsigned int=
 *slpm)
>  {
>         int i;
>
> -       for (i =3D 0; i < NUM_BANKS; i++) {
> +       for (i =3D 0; i < NMK_MAX_BANKS; i++) {
>                 struct nmk_gpio_chip *chip =3D nmk_gpio_chips[i];
>
>                 if (!chip)
> @@ -578,7 +474,8 @@ static void nmk_gpio_glitch_slpm_restore(unsigned int=
 *slpm)
>         }
>  }
>
> -static int __maybe_unused nmk_prcm_gpiocr_get_mode(struct pinctrl_dev *p=
ctldev, int gpio)
> +/* Only called by gpio-nomadik but requires knowledge of struct nmk_pinc=
trl. */
> +int __maybe_unused nmk_prcm_gpiocr_get_mode(struct pinctrl_dev *pctldev,=
 int gpio)
>  {
>         int i;
>         u16 reg;
> @@ -610,576 +507,6 @@ static int __maybe_unused nmk_prcm_gpiocr_get_mode(=
struct pinctrl_dev *pctldev,
>         return NMK_GPIO_ALT_C;
>  }
>
> -/* IRQ functions */
> -
> -static void nmk_gpio_irq_ack(struct irq_data *d)
> -{
> -       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> -
> -       clk_enable(nmk_chip->clk);
> -       writel(BIT(d->hwirq), nmk_chip->addr + NMK_GPIO_IC);
> -       clk_disable(nmk_chip->clk);
> -}
> -
> -enum nmk_gpio_irq_type {
> -       NORMAL,
> -       WAKE,
> -};
> -
> -static void __nmk_gpio_irq_modify(struct nmk_gpio_chip *nmk_chip,
> -                                 int offset, enum nmk_gpio_irq_type whic=
h,
> -                                 bool enable)
> -{
> -       u32 *rimscval;
> -       u32 *fimscval;
> -       u32 rimscreg;
> -       u32 fimscreg;
> -
> -       if (which =3D=3D NORMAL) {
> -               rimscreg =3D NMK_GPIO_RIMSC;
> -               fimscreg =3D NMK_GPIO_FIMSC;
> -               rimscval =3D &nmk_chip->rimsc;
> -               fimscval =3D &nmk_chip->fimsc;
> -       } else  {
> -               rimscreg =3D NMK_GPIO_RWIMSC;
> -               fimscreg =3D NMK_GPIO_FWIMSC;
> -               rimscval =3D &nmk_chip->rwimsc;
> -               fimscval =3D &nmk_chip->fwimsc;
> -       }
> -
> -       /* we must individually set/clear the two edges */
> -       if (nmk_chip->edge_rising & BIT(offset)) {
> -               if (enable)
> -                       *rimscval |=3D BIT(offset);
> -               else
> -                       *rimscval &=3D ~BIT(offset);
> -               writel(*rimscval, nmk_chip->addr + rimscreg);
> -       }
> -       if (nmk_chip->edge_falling & BIT(offset)) {
> -               if (enable)
> -                       *fimscval |=3D BIT(offset);
> -               else
> -                       *fimscval &=3D ~BIT(offset);
> -               writel(*fimscval, nmk_chip->addr + fimscreg);
> -       }
> -}
> -
> -static void __nmk_gpio_set_wake(struct nmk_gpio_chip *nmk_chip,
> -                               int offset, bool on)
> -{
> -       /*
> -        * Ensure WAKEUP_ENABLE is on.  No need to disable it if wakeup i=
s
> -        * disabled, since setting SLPM to 1 increases power consumption,=
 and
> -        * wakeup is anyhow controlled by the RIMSC and FIMSC registers.
> -        */
> -       if (nmk_chip->sleepmode && on) {
> -               __nmk_gpio_set_slpm(nmk_chip, offset,
> -                                   NMK_GPIO_SLPM_WAKEUP_ENABLE);
> -       }
> -
> -       __nmk_gpio_irq_modify(nmk_chip, offset, WAKE, on);
> -}
> -
> -static void nmk_gpio_irq_maskunmask(struct nmk_gpio_chip *nmk_chip,
> -                                   struct irq_data *d, bool enable)
> -{
> -       unsigned long flags;
> -
> -       clk_enable(nmk_chip->clk);
> -       spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
> -       spin_lock(&nmk_chip->lock);
> -
> -       __nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, enable);
> -
> -       if (!(nmk_chip->real_wake & BIT(d->hwirq)))
> -               __nmk_gpio_set_wake(nmk_chip, d->hwirq, enable);
> -
> -       spin_unlock(&nmk_chip->lock);
> -       spin_unlock_irqrestore(&nmk_gpio_slpm_lock, flags);
> -       clk_disable(nmk_chip->clk);
> -}
> -
> -static void nmk_gpio_irq_mask(struct irq_data *d)
> -{
> -       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> -
> -       nmk_gpio_irq_maskunmask(nmk_chip, d, false);
> -       gpiochip_disable_irq(gc, irqd_to_hwirq(d));
> -}
> -
> -static void nmk_gpio_irq_unmask(struct irq_data *d)
> -{
> -       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> -
> -       gpiochip_enable_irq(gc, irqd_to_hwirq(d));
> -       nmk_gpio_irq_maskunmask(nmk_chip, d, true);
> -}
> -
> -static int nmk_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
> -{
> -       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> -       unsigned long flags;
> -
> -       clk_enable(nmk_chip->clk);
> -       spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
> -       spin_lock(&nmk_chip->lock);
> -
> -       if (irqd_irq_disabled(d))
> -               __nmk_gpio_set_wake(nmk_chip, d->hwirq, on);
> -
> -       if (on)
> -               nmk_chip->real_wake |=3D BIT(d->hwirq);
> -       else
> -               nmk_chip->real_wake &=3D ~BIT(d->hwirq);
> -
> -       spin_unlock(&nmk_chip->lock);
> -       spin_unlock_irqrestore(&nmk_gpio_slpm_lock, flags);
> -       clk_disable(nmk_chip->clk);
> -
> -       return 0;
> -}
> -
> -static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> -{
> -       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> -       bool enabled =3D !irqd_irq_disabled(d);
> -       bool wake =3D irqd_is_wakeup_set(d);
> -       unsigned long flags;
> -
> -       if (type & IRQ_TYPE_LEVEL_HIGH)
> -               return -EINVAL;
> -       if (type & IRQ_TYPE_LEVEL_LOW)
> -               return -EINVAL;
> -
> -       clk_enable(nmk_chip->clk);
> -       spin_lock_irqsave(&nmk_chip->lock, flags);
> -
> -       if (enabled)
> -               __nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, false);
> -
> -       if (enabled || wake)
> -               __nmk_gpio_irq_modify(nmk_chip, d->hwirq, WAKE, false);
> -
> -       nmk_chip->edge_rising &=3D ~BIT(d->hwirq);
> -       if (type & IRQ_TYPE_EDGE_RISING)
> -               nmk_chip->edge_rising |=3D BIT(d->hwirq);
> -
> -       nmk_chip->edge_falling &=3D ~BIT(d->hwirq);
> -       if (type & IRQ_TYPE_EDGE_FALLING)
> -               nmk_chip->edge_falling |=3D BIT(d->hwirq);
> -
> -       if (enabled)
> -               __nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, true);
> -
> -       if (enabled || wake)
> -               __nmk_gpio_irq_modify(nmk_chip, d->hwirq, WAKE, true);
> -
> -       spin_unlock_irqrestore(&nmk_chip->lock, flags);
> -       clk_disable(nmk_chip->clk);
> -
> -       return 0;
> -}
> -
> -static unsigned int nmk_gpio_irq_startup(struct irq_data *d)
> -{
> -       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> -
> -       clk_enable(nmk_chip->clk);
> -       nmk_gpio_irq_unmask(d);
> -       return 0;
> -}
> -
> -static void nmk_gpio_irq_shutdown(struct irq_data *d)
> -{
> -       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> -
> -       nmk_gpio_irq_mask(d);
> -       clk_disable(nmk_chip->clk);
> -}
> -
> -static void nmk_gpio_irq_handler(struct irq_desc *desc)
> -{
> -       struct irq_chip *host_chip =3D irq_desc_get_chip(desc);
> -       struct gpio_chip *chip =3D irq_desc_get_handler_data(desc);
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(chip);
> -       u32 status;
> -
> -       chained_irq_enter(host_chip, desc);
> -
> -       clk_enable(nmk_chip->clk);
> -       status =3D readl(nmk_chip->addr + NMK_GPIO_IS);
> -       clk_disable(nmk_chip->clk);
> -
> -       while (status) {
> -               int bit =3D __ffs(status);
> -
> -               generic_handle_domain_irq(chip->irq.domain, bit);
> -               status &=3D ~BIT(bit);
> -       }
> -
> -       chained_irq_exit(host_chip, desc);
> -}
> -
> -/* I/O Functions */
> -
> -static int nmk_gpio_get_dir(struct gpio_chip *chip, unsigned offset)
> -{
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(chip);
> -       int dir;
> -
> -       clk_enable(nmk_chip->clk);
> -
> -       dir =3D readl(nmk_chip->addr + NMK_GPIO_DIR) & BIT(offset);
> -
> -       clk_disable(nmk_chip->clk);
> -
> -       if (dir)
> -               return GPIO_LINE_DIRECTION_OUT;
> -
> -       return GPIO_LINE_DIRECTION_IN;
> -}
> -
> -static int nmk_gpio_make_input(struct gpio_chip *chip, unsigned offset)
> -{
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(chip);
> -
> -       clk_enable(nmk_chip->clk);
> -
> -       writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DIRC);
> -
> -       clk_disable(nmk_chip->clk);
> -
> -       return 0;
> -}
> -
> -static int nmk_gpio_get_input(struct gpio_chip *chip, unsigned offset)
> -{
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(chip);
> -       int value;
> -
> -       clk_enable(nmk_chip->clk);
> -
> -       value =3D !!(readl(nmk_chip->addr + NMK_GPIO_DAT) & BIT(offset));
> -
> -       clk_disable(nmk_chip->clk);
> -
> -       return value;
> -}
> -
> -static void nmk_gpio_set_output(struct gpio_chip *chip, unsigned offset,
> -                               int val)
> -{
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(chip);
> -
> -       clk_enable(nmk_chip->clk);
> -
> -       __nmk_gpio_set_output(nmk_chip, offset, val);
> -
> -       clk_disable(nmk_chip->clk);
> -}
> -
> -static int nmk_gpio_make_output(struct gpio_chip *chip, unsigned offset,
> -                               int val)
> -{
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(chip);
> -
> -       clk_enable(nmk_chip->clk);
> -
> -       __nmk_gpio_make_output(nmk_chip, offset, val);
> -
> -       clk_disable(nmk_chip->clk);
> -
> -       return 0;
> -}
> -
> -#ifdef CONFIG_DEBUG_FS
> -static int nmk_gpio_get_mode(struct nmk_gpio_chip *nmk_chip, int offset)
> -{
> -       u32 afunc, bfunc;
> -
> -       clk_enable(nmk_chip->clk);
> -
> -       afunc =3D readl(nmk_chip->addr + NMK_GPIO_AFSLA) & BIT(offset);
> -       bfunc =3D readl(nmk_chip->addr + NMK_GPIO_AFSLB) & BIT(offset);
> -
> -       clk_disable(nmk_chip->clk);
> -
> -       return (afunc ? NMK_GPIO_ALT_A : 0) | (bfunc ? NMK_GPIO_ALT_B : 0=
);
> -}
> -
> -static void nmk_gpio_dbg_show_one(struct seq_file *s,
> -       struct pinctrl_dev *pctldev, struct gpio_chip *chip,
> -       unsigned offset, unsigned gpio)
> -{
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(chip);
> -       int mode;
> -       bool is_out;
> -       bool data_out;
> -       bool pull;
> -       const char *modes[] =3D {
> -               [NMK_GPIO_ALT_GPIO]     =3D "gpio",
> -               [NMK_GPIO_ALT_A]        =3D "altA",
> -               [NMK_GPIO_ALT_B]        =3D "altB",
> -               [NMK_GPIO_ALT_C]        =3D "altC",
> -               [NMK_GPIO_ALT_C+1]      =3D "altC1",
> -               [NMK_GPIO_ALT_C+2]      =3D "altC2",
> -               [NMK_GPIO_ALT_C+3]      =3D "altC3",
> -               [NMK_GPIO_ALT_C+4]      =3D "altC4",
> -       };
> -
> -       char *label =3D gpiochip_dup_line_label(chip, offset);
> -       if (IS_ERR(label))
> -               return;
> -
> -       clk_enable(nmk_chip->clk);
> -       is_out =3D !!(readl(nmk_chip->addr + NMK_GPIO_DIR) & BIT(offset))=
;
> -       pull =3D !(readl(nmk_chip->addr + NMK_GPIO_PDIS) & BIT(offset));
> -       data_out =3D !!(readl(nmk_chip->addr + NMK_GPIO_DAT) & BIT(offset=
));
> -       mode =3D nmk_gpio_get_mode(nmk_chip, offset);
> -       if ((mode =3D=3D NMK_GPIO_ALT_C) && pctldev)
> -               mode =3D nmk_prcm_gpiocr_get_mode(pctldev, gpio);
> -
> -       if (is_out) {
> -               seq_printf(s, " gpio-%-3d (%-20.20s) out %s           %s"=
,
> -                          gpio,
> -                          label ?: "(none)",
> -                          data_out ? "hi" : "lo",
> -                          (mode < 0) ? "unknown" : modes[mode]);
> -       } else {
> -               int irq =3D chip->to_irq(chip, offset);
> -               const int pullidx =3D pull ? 1 : 0;
> -               int val;
> -               static const char * const pulls[] =3D {
> -                       "none        ",
> -                       "pull enabled",
> -               };
> -
> -               seq_printf(s, " gpio-%-3d (%-20.20s) in  %s %s",
> -                          gpio,
> -                          label ?: "(none)",
> -                          pulls[pullidx],
> -                          (mode < 0) ? "unknown" : modes[mode]);
> -
> -               val =3D nmk_gpio_get_input(chip, offset);
> -               seq_printf(s, " VAL %d", val);
> -
> -               /*
> -                * This races with request_irq(), set_irq_type(),
> -                * and set_irq_wake() ... but those are "rare".
> -                */
> -               if (irq > 0 && irq_has_action(irq)) {
> -                       char *trigger;
> -                       bool wake;
> -
> -                       if (nmk_chip->edge_rising & BIT(offset))
> -                               trigger =3D "edge-rising";
> -                       else if (nmk_chip->edge_falling & BIT(offset))
> -                               trigger =3D "edge-falling";
> -                       else
> -                               trigger =3D "edge-undefined";
> -
> -                       wake =3D !!(nmk_chip->real_wake & BIT(offset));
> -
> -                       seq_printf(s, " irq-%d %s%s",
> -                                  irq, trigger, wake ? " wakeup" : "");
> -               }
> -       }
> -       clk_disable(nmk_chip->clk);
> -}
> -
> -static void nmk_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip=
)
> -{
> -       unsigned                i;
> -       unsigned                gpio =3D chip->base;
> -
> -       for (i =3D 0; i < chip->ngpio; i++, gpio++) {
> -               nmk_gpio_dbg_show_one(s, NULL, chip, i, gpio);
> -               seq_printf(s, "\n");
> -       }
> -}
> -
> -#else
> -static inline void nmk_gpio_dbg_show_one(struct seq_file *s,
> -                                        struct pinctrl_dev *pctldev,
> -                                        struct gpio_chip *chip,
> -                                        unsigned offset, unsigned gpio)
> -{
> -}
> -#define nmk_gpio_dbg_show      NULL
> -#endif
> -
> -/*
> - * We will allocate memory for the state container using devm* allocator=
s
> - * binding to the first device reaching this point, it doesn't matter if
> - * it is the pin controller or GPIO driver. However we need to use the r=
ight
> - * platform device when looking up resources so pay attention to pdev.
> - */
> -static struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *=
np,
> -                                               struct platform_device *p=
dev)
> -{
> -       struct nmk_gpio_chip *nmk_chip;
> -       struct platform_device *gpio_pdev;
> -       struct gpio_chip *chip;
> -       struct resource *res;
> -       struct clk *clk;
> -       void __iomem *base;
> -       u32 id;
> -
> -       gpio_pdev =3D of_find_device_by_node(np);
> -       if (!gpio_pdev) {
> -               pr_err("populate \"%pOFn\": device not found\n", np);
> -               return ERR_PTR(-ENODEV);
> -       }
> -       if (of_property_read_u32(np, "gpio-bank", &id)) {
> -               dev_err(&pdev->dev, "populate: gpio-bank property not fou=
nd\n");
> -               platform_device_put(gpio_pdev);
> -               return ERR_PTR(-EINVAL);
> -       }
> -
> -       /* Already populated? */
> -       nmk_chip =3D nmk_gpio_chips[id];
> -       if (nmk_chip) {
> -               platform_device_put(gpio_pdev);
> -               return nmk_chip;
> -       }
> -
> -       nmk_chip =3D devm_kzalloc(&pdev->dev, sizeof(*nmk_chip), GFP_KERN=
EL);
> -       if (!nmk_chip) {
> -               platform_device_put(gpio_pdev);
> -               return ERR_PTR(-ENOMEM);
> -       }
> -
> -       nmk_chip->bank =3D id;
> -       chip =3D &nmk_chip->chip;
> -       chip->base =3D id * NMK_GPIO_PER_CHIP;
> -       chip->ngpio =3D NMK_GPIO_PER_CHIP;
> -       chip->label =3D dev_name(&gpio_pdev->dev);
> -       chip->parent =3D &gpio_pdev->dev;
> -
> -       res =3D platform_get_resource(gpio_pdev, IORESOURCE_MEM, 0);
> -       base =3D devm_ioremap_resource(&pdev->dev, res);
> -       if (IS_ERR(base)) {
> -               platform_device_put(gpio_pdev);
> -               return ERR_CAST(base);
> -       }
> -       nmk_chip->addr =3D base;
> -
> -       clk =3D clk_get(&gpio_pdev->dev, NULL);
> -       if (IS_ERR(clk)) {
> -               platform_device_put(gpio_pdev);
> -               return (void *) clk;
> -       }
> -       clk_prepare(clk);
> -       nmk_chip->clk =3D clk;
> -
> -       BUG_ON(nmk_chip->bank >=3D ARRAY_SIZE(nmk_gpio_chips));
> -       nmk_gpio_chips[id] =3D nmk_chip;
> -       return nmk_chip;
> -}
> -
> -static void nmk_gpio_irq_print_chip(struct irq_data *d, struct seq_file =
*p)
> -{
> -       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> -       struct nmk_gpio_chip *nmk_chip =3D gpiochip_get_data(gc);
> -
> -       seq_printf(p, "nmk%u-%u-%u", nmk_chip->bank,
> -                  gc->base, gc->base + gc->ngpio - 1);
> -}
> -
> -static const struct irq_chip nmk_irq_chip =3D {
> -       .irq_ack =3D nmk_gpio_irq_ack,
> -       .irq_mask =3D nmk_gpio_irq_mask,
> -       .irq_unmask =3D nmk_gpio_irq_unmask,
> -       .irq_set_type =3D nmk_gpio_irq_set_type,
> -       .irq_set_wake =3D nmk_gpio_irq_set_wake,
> -       .irq_startup =3D nmk_gpio_irq_startup,
> -       .irq_shutdown =3D nmk_gpio_irq_shutdown,
> -       .irq_print_chip =3D nmk_gpio_irq_print_chip,
> -       .flags =3D IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
> -       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> -};
> -
> -static int nmk_gpio_probe(struct platform_device *dev)
> -{
> -       struct device_node *np =3D dev->dev.of_node;
> -       struct nmk_gpio_chip *nmk_chip;
> -       struct gpio_chip *chip;
> -       struct gpio_irq_chip *girq;
> -       bool supports_sleepmode;
> -       int irq;
> -       int ret;
> -
> -       nmk_chip =3D nmk_gpio_populate_chip(np, dev);
> -       if (IS_ERR(nmk_chip)) {
> -               dev_err(&dev->dev, "could not populate nmk chip struct\n"=
);
> -               return PTR_ERR(nmk_chip);
> -       }
> -
> -       supports_sleepmode =3D
> -               of_property_read_bool(np, "st,supports-sleepmode");
> -
> -       /* Correct platform device ID */
> -       dev->id =3D nmk_chip->bank;
> -
> -       irq =3D platform_get_irq(dev, 0);
> -       if (irq < 0)
> -               return irq;
> -
> -       /*
> -        * The virt address in nmk_chip->addr is in the nomadik register =
space,
> -        * so we can simply convert the resource address, without remappi=
ng
> -        */
> -       nmk_chip->sleepmode =3D supports_sleepmode;
> -       spin_lock_init(&nmk_chip->lock);
> -
> -       chip =3D &nmk_chip->chip;
> -       chip->parent =3D &dev->dev;
> -       chip->request =3D gpiochip_generic_request;
> -       chip->free =3D gpiochip_generic_free;
> -       chip->get_direction =3D nmk_gpio_get_dir;
> -       chip->direction_input =3D nmk_gpio_make_input;
> -       chip->get =3D nmk_gpio_get_input;
> -       chip->direction_output =3D nmk_gpio_make_output;
> -       chip->set =3D nmk_gpio_set_output;
> -       chip->dbg_show =3D nmk_gpio_dbg_show;
> -       chip->can_sleep =3D false;
> -       chip->owner =3D THIS_MODULE;
> -
> -       girq =3D &chip->irq;
> -       gpio_irq_chip_set_chip(girq, &nmk_irq_chip);
> -       girq->parent_handler =3D nmk_gpio_irq_handler;
> -       girq->num_parents =3D 1;
> -       girq->parents =3D devm_kcalloc(&dev->dev, 1,
> -                                    sizeof(*girq->parents),
> -                                    GFP_KERNEL);
> -       if (!girq->parents)
> -               return -ENOMEM;
> -       girq->parents[0] =3D irq;
> -       girq->default_type =3D IRQ_TYPE_NONE;
> -       girq->handler =3D handle_edge_irq;
> -
> -       clk_enable(nmk_chip->clk);
> -       nmk_chip->lowemi =3D readl_relaxed(nmk_chip->addr + NMK_GPIO_LOWE=
MI);
> -       clk_disable(nmk_chip->clk);
> -
> -       ret =3D gpiochip_add_data(chip, nmk_chip);
> -       if (ret)
> -               return ret;
> -
> -       platform_set_drvdata(dev, nmk_chip);
> -
> -       dev_info(&dev->dev, "chip registered\n");
> -
> -       return 0;
> -}
> -
>  static int nmk_get_groups_cnt(struct pinctrl_dev *pctldev)
>  {
>         struct nmk_pinctrl *npct =3D pinctrl_dev_get_drvdata(pctldev);
> @@ -1197,12 +524,12 @@ static const char *nmk_get_group_name(struct pinct=
rl_dev *pctldev,
>
>  static int nmk_get_group_pins(struct pinctrl_dev *pctldev, unsigned sele=
ctor,
>                               const unsigned **pins,
> -                             unsigned *npins)
> +                             unsigned int *num_pins)
>  {
>         struct nmk_pinctrl *npct =3D pinctrl_dev_get_drvdata(pctldev);
>
>         *pins =3D npct->soc->groups[selector].grp.pins;
> -       *npins =3D npct->soc->groups[selector].grp.npins;
> +       *num_pins =3D npct->soc->groups[selector].grp.npins;
>         return 0;
>  }
>
> @@ -1533,7 +860,7 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, =
unsigned function,
>  {
>         struct nmk_pinctrl *npct =3D pinctrl_dev_get_drvdata(pctldev);
>         const struct nmk_pingroup *g;
> -       static unsigned int slpm[NUM_BANKS];
> +       static unsigned int slpm[NMK_MAX_BANKS];
>         unsigned long flags =3D 0;
>         bool glitch;
>         int ret =3D -EINVAL;
> @@ -1919,19 +1246,6 @@ static int nmk_pinctrl_probe(struct platform_devic=
e *pdev)
>         return 0;
>  }
>
> -static const struct of_device_id nmk_gpio_match[] =3D {
> -       { .compatible =3D "st,nomadik-gpio", },
> -       {}
> -};
> -
> -static struct platform_driver nmk_gpio_driver =3D {
> -       .driver =3D {
> -               .name =3D "gpio",
> -               .of_match_table =3D nmk_gpio_match,
> -       },
> -       .probe =3D nmk_gpio_probe,
> -};
> -
>  static SIMPLE_DEV_PM_OPS(nmk_pinctrl_pm_ops,
>                         nmk_pinctrl_suspend,
>                         nmk_pinctrl_resume);
> @@ -1945,12 +1259,6 @@ static struct platform_driver nmk_pinctrl_driver =
=3D {
>         .probe =3D nmk_pinctrl_probe,
>  };
>
> -static int __init nmk_gpio_init(void)
> -{
> -       return platform_driver_register(&nmk_gpio_driver);
> -}
> -subsys_initcall(nmk_gpio_init);
> -
>  static int __init nmk_pinctrl_init(void)
>  {
>         return platform_driver_register(&nmk_pinctrl_driver);
> diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.h b/include/linux/gp=
io/gpio-nomadik.h
> similarity index 61%
> rename from drivers/pinctrl/nomadik/pinctrl-nomadik.h
> rename to include/linux/gpio/gpio-nomadik.h
> index 1ef2559bc571..0166ddb71f43 100644
> --- a/drivers/pinctrl/nomadik/pinctrl-nomadik.h
> +++ b/include/linux/gpio/gpio-nomadik.h
> @@ -1,16 +1,74 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef PINCTRL_PINCTRL_NOMADIK_H
> -#define PINCTRL_PINCTRL_NOMADIK_H
> -
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -
> -#include <linux/pinctrl/pinctrl.h>
> +#ifndef __LINUX_GPIO_NOMADIK_H
> +#define __LINUX_GPIO_NOMADIK_H
>
>  /* Package definitions */
>  #define PINCTRL_NMK_STN8815    0
>  #define PINCTRL_NMK_DB8500     1
>
> +#define GPIO_BLOCK_SHIFT 5
> +#define NMK_GPIO_PER_CHIP BIT(GPIO_BLOCK_SHIFT)
> +#define NMK_MAX_BANKS DIV_ROUND_UP(512, NMK_GPIO_PER_CHIP)
> +
> +/* Register in the logic block */
> +#define NMK_GPIO_DAT   0x00
> +#define NMK_GPIO_DATS  0x04
> +#define NMK_GPIO_DATC  0x08
> +#define NMK_GPIO_PDIS  0x0c
> +#define NMK_GPIO_DIR   0x10
> +#define NMK_GPIO_DIRS  0x14
> +#define NMK_GPIO_DIRC  0x18
> +#define NMK_GPIO_SLPC  0x1c
> +#define NMK_GPIO_AFSLA 0x20
> +#define NMK_GPIO_AFSLB 0x24
> +#define NMK_GPIO_LOWEMI        0x28
> +
> +#define NMK_GPIO_RIMSC 0x40
> +#define NMK_GPIO_FIMSC 0x44
> +#define NMK_GPIO_IS    0x48
> +#define NMK_GPIO_IC    0x4c
> +#define NMK_GPIO_RWIMSC        0x50
> +#define NMK_GPIO_FWIMSC        0x54
> +#define NMK_GPIO_WKS   0x58
> +/* These appear in DB8540 and later ASICs */
> +#define NMK_GPIO_EDGELEVEL 0x5C
> +#define NMK_GPIO_LEVEL 0x60
> +
> +/* Pull up/down values */
> +enum nmk_gpio_pull {
> +       NMK_GPIO_PULL_NONE,
> +       NMK_GPIO_PULL_UP,
> +       NMK_GPIO_PULL_DOWN,
> +};
> +
> +/* Sleep mode */
> +enum nmk_gpio_slpm {
> +       NMK_GPIO_SLPM_INPUT,
> +       NMK_GPIO_SLPM_WAKEUP_ENABLE =3D NMK_GPIO_SLPM_INPUT,
> +       NMK_GPIO_SLPM_NOCHANGE,
> +       NMK_GPIO_SLPM_WAKEUP_DISABLE =3D NMK_GPIO_SLPM_NOCHANGE,
> +};
> +
> +struct nmk_gpio_chip {
> +       struct gpio_chip chip;
> +       void __iomem *addr;
> +       struct clk *clk;
> +       unsigned int bank;
> +       void (*set_ioforce)(bool enable);
> +       spinlock_t lock;
> +       bool sleepmode;
> +       /* Keep track of configured edges */
> +       u32 edge_rising;
> +       u32 edge_falling;
> +       u32 real_wake;
> +       u32 rwimsc;
> +       u32 fwimsc;
> +       u32 rimsc;
> +       u32 fimsc;
> +       u32 pull_up;
> +       u32 lowemi;
> +};
> +
>  /* Alternate functions: function C is set in hw by setting both A and B =
*/
>  #define NMK_GPIO_ALT_GPIO      0
>  #define NMK_GPIO_ALT_A 1
> @@ -104,7 +162,7 @@ struct prcm_gpiocr_altcx_pin_desc {
>  struct nmk_function {
>         const char *name;
>         const char * const *groups;
> -       unsigned ngroups;
> +       unsigned int ngroups;
>  };
>
>  /**
> @@ -141,13 +199,13 @@ struct nmk_pingroup {
>   */
>  struct nmk_pinctrl_soc_data {
>         const struct pinctrl_pin_desc *pins;
> -       unsigned npins;
> +       unsigned int npins;
>         const struct nmk_function *functions;
> -       unsigned nfunctions;
> +       unsigned int nfunctions;
>         const struct nmk_pingroup *groups;
> -       unsigned ngroups;
> +       unsigned int ngroups;
>         const struct prcm_gpiocr_altcx_pin_desc *altcx_pins;
> -       unsigned npins_altcx;
> +       unsigned int npins_altcx;
>         const u16 *prcm_gpiocr_registers;
>  };
>
> @@ -177,4 +235,42 @@ nmk_pinctrl_db8500_init(const struct nmk_pinctrl_soc=
_data **soc)
>
>  #endif
>
> -#endif /* PINCTRL_PINCTRL_NOMADIK_H */
> +#ifdef CONFIG_PINCTRL_DB8540
> +
> +void nmk_pinctrl_db8540_init(const struct nmk_pinctrl_soc_data **soc);
> +
> +#else
> +
> +static inline void
> +nmk_pinctrl_db8540_init(const struct nmk_pinctrl_soc_data **soc)
> +{
> +}
> +
> +#endif
> +
> +struct platform_device;
> +
> +/*
> + * Symbols declared in gpio-nomadik used by pinctrl-nomadik. If pinctrl-=
nomadik
> + * is enabled, then gpio-nomadik is enabled as well; the reverse if not =
always
> + * true.
> + */
> +void nmk_gpio_dbg_show_one(struct seq_file *s, struct pinctrl_dev *pctld=
ev,
> +                          struct gpio_chip *chip, unsigned int offset,
> +                          unsigned int gpio);
> +void __nmk_gpio_make_output(struct nmk_gpio_chip *nmk_chip,
> +                           unsigned int offset, int val);
> +void __nmk_gpio_set_slpm(struct nmk_gpio_chip *nmk_chip, unsigned int of=
fset,
> +                        enum nmk_gpio_slpm mode);
> +struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
> +                                            struct platform_device *pdev=
);
> +
> +/* Symbols declared in pinctrl-nomadik used by gpio-nomadik. */
> +#ifdef CONFIG_PINCTRL_NOMADIK
> +extern struct nmk_gpio_chip *nmk_gpio_chips[NMK_MAX_BANKS];
> +extern spinlock_t nmk_gpio_slpm_lock;
> +int __maybe_unused nmk_prcm_gpiocr_get_mode(struct pinctrl_dev *pctldev,
> +                                           int gpio);
> +#endif
> +
> +#endif /* __LINUX_GPIO_NOMADIK_H */
>
> --
> 2.43.1
>

Bart

