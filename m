Return-Path: <linux-kernel+bounces-163758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84D48B6F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FCA1C22687
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9B5129E8A;
	Tue, 30 Apr 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nv2Toj7r"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673A6129E66
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472344; cv=none; b=OlCNKNtYtiJXUY81Nlh/VN5eQcim2tQLatyVrkd8M+OtBYsfK6MwzbG7hu1skvQCe51FwvCWdBk9NUY8D0pJwcKe4cG0RTxgColWL2z3yn3MN1FwWNIUruY82ZXt4/xxZPYVUglMePIA+n9SVyYKu0ubQDwb4BdKjL21J9UvhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472344; c=relaxed/simple;
	bh=Ls/3l42xKNszQ9b1EXEGWgnCybj8QLYmQMdzk1SNDAc=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CW8OUvWsN5K42uz0mwf5KSaC8Pu4ZwTKjRVn3uXgJpKDhXLJUbSOvS0AFe6gpuZyytkuB3m+Gp7XzWjx6q6arpSfn2wYF+wG9o+oO8H6isNqcd3BZT0+Yk+XRrEQ0a+AE5iSbS+fh/Zj5+TLqFUz1VeUwydf/HdD0lewY4mzzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nv2Toj7r; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4D4DD3F129
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714472333;
	bh=rMvXDrs+VuBthhlIIsViBJ5vFM54y5Hbkyxx9H9AQH4=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=nv2Toj7rYsAS5rvITe5w1RTEY+Md0HGv6A1Eb4X1Wxz1HmeeK4qua22IDh3F3TvHM
	 f+OFVmc4YkGkv1/U3kAUVp+fon+HpMQfac/ksdg/Q3UpoQX4ewYq8hVmA8w5MRyYkx
	 E17YHIe/CEx/c3SBgzupm+S0pEbivEC+fgPvjmpCGEbetE2orof3KYcYndaf4NBigj
	 mpIb8OFcE2nGxVPh78ENYbXM+IrEev9bbFYFX0qOszypdhvqo45ov75XYvGu3WNsvo
	 /bP2kYFqVCj/ugouU2yUsUosdQjSJ7FvicmzY37+4YMMMPWPQz9F/WP6IFKfDbcXlT
	 VXkSMWn+PL4Yg==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-61be75e21fdso17163827b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714472332; x=1715077132;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rMvXDrs+VuBthhlIIsViBJ5vFM54y5Hbkyxx9H9AQH4=;
        b=mIlmJACTQE2FOE1EEXVDt4Geoq8pDh//8f86inRn11bw7bmPqXmBX6MRdOj2ObBj+0
         DeC5GGPKYcuFL5f5qw4dT1HjERVnvkTNuyX0EKZVrxOdLxfyBRrl/1Rm7DpsTCJZIFJr
         pIrGOml0c4WcF1hDHAFsx2co6/8OiA0cvI0YbuxXQhyt5T06oqEFPNSXtAWdeOM28Jt5
         lqOzGZLOWGGnLeypi9O+lB04InvLgOm9gEiGG4cJd/ONnl5xjtWcdzmrbKO1N+TMp0Hx
         9D1brPCdkZfbk3yYECtiL3o60Y1Aftmnd2h2fqil8PB41Pie/xxTnc/DNwdoi1JVwwld
         CU0w==
X-Forwarded-Encrypted: i=1; AJvYcCVciKNwlC/M+YI50HSnmwE6malqxXrBNqwWcF5870ehWCVzNGz145AO4mJnUyGQmP5d8HjPUg+O4hrN1koKQAQ59dept6ZpEQqRWx8p
X-Gm-Message-State: AOJu0YxvQLw51u3Glkdk1h8QzOgePobI0RvkkpTBCPLFv32xP5kEoLVO
	J/DsaGPbpl6s0Miq/CIGjyIBoRk9dlSjYI29VkeZida9Zv7tdNMgNaE/Zu57B+AG9XPlGe4vSWu
	Z0Mw9ovhRksBWEbd7uuIYMF8jpNr/zqiikd3yo2XVHOFeWTyGFFdnt2+6JB3AoUIPPvrD/a6dKF
	BU9QoJao2cE1/C8bNr0pr2Vk83ifwwoBTHQL36Z9lCq+zh1wKEY1QA
X-Received: by 2002:a05:690c:6912:b0:61b:1f0e:10 with SMTP id if18-20020a05690c691200b0061b1f0e0010mr12844572ywb.4.1714472332144;
        Tue, 30 Apr 2024 03:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaBVJ/3WeS4exbR9xNI2Qqc6qz4UWMr6GNN7koPcmrPmFgcAsmkzNaDoorrn+/mlcLYv209H78q2LBQY4YFsI=
X-Received: by 2002:a05:690c:6912:b0:61b:1f0e:10 with SMTP id
 if18-20020a05690c691200b0061b1f0e0010mr12844546ywb.4.1714472331799; Tue, 30
 Apr 2024 03:18:51 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Apr 2024 05:18:51 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <NTZPR01MB09860632D4BDB31B98E1BD18E11AA@NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn>
References: <20240412084543.7243-1-ziv.xu@starfivetech.com>
 <20240412084543.7243-3-ziv.xu@starfivetech.com> <NTZPR01MB09860632D4BDB31B98E1BD18E11AA@NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 30 Apr 2024 05:18:51 -0500
Message-ID: <CAJM55Z8U5ddBg_T34rHYUXQcTLdzhMhbhv3mZxehQL8VLBFtUA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYxMCAyLzNdIGNsb2Nrc291cmNlOiBBZGQgSkg3MTEwIA==?=
	=?UTF-8?B?dGltZXIgZHJpdmVy?=
To: Ziv Xu <ziv.xu@starfivetech.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Walker Chen <walker.chen@starfivetech.com>, Xingyu Wu <xingyu.wu@starfivetech.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ziv Xu wrote:
>
>
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Ziv Xu
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B44=E6=9C=8812=E6=97=
=A5 16:46
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Daniel Lezcano <daniel.lezcano@linaro.org>=
; Thomas Gleixner
> > <tglx@linutronix.de>; Emil Renner Berthing
> > <emil.renner.berthing@canonical.com>; Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr>
> > =E6=8A=84=E9=80=81: linux-riscv@lists.infradead.org; devicetree@vger.ke=
rnel.org; Rob Herring
> > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Paul Walmsley
> > <paul.walmsley@sifive.com>; Palmer Dabbelt <palmer@dabbelt.com>; Albert
> > Ou <aou@eecs.berkeley.edu>; Philipp Zabel <p.zabel@pengutronix.de>; Wal=
ker
> > Chen <walker.chen@starfivetech.com>; Xingyu Wu
> > <xingyu.wu@starfivetech.com>; linux-kernel@vger.kernel.org; Conor Doole=
y
> > <conor@kernel.org>
> > =E4=B8=BB=E9=A2=98: [PATCH v10 2/3] clocksource: Add JH7110 timer drive=
r
> >
> > From: Xingyu Wu <xingyu.wu@starfivetech.com>
> >
> > Add timer driver for the StarFive JH7110 SoC.
> >
> > This timer has four free-running and independent 32-bit counters.
> > Each channel(counter) can trigger an interrupt when timeout even CPU is
> > sleeping. So this timer is used as global timer and register clockevent=
 for each
> > CPU core after riscv-timer registration on the StarFive JH7110 SoC.
> >
> > Signed-off-by: Ziv Xu <ziv.xu@starfivetech.com>
> > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > ---
> >  MAINTAINERS                        |   7 +
> >  drivers/clocksource/Kconfig        |  11 +
> >  drivers/clocksource/Makefile       |   1 +
> >  drivers/clocksource/timer-jh7110.c | 345 +++++++++++++++++++++++++++++
> >  include/linux/cpuhotplug.h         |   1 +
> >  5 files changed, 365 insertions(+)
> >  create mode 100644 drivers/clocksource/timer-jh7110.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7c121493f43d..ef9b5f5bad9e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -21043,6 +21043,13 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
> >  F:	sound/soc/starfive/jh7110_tdm.c
> >
> > +STARFIVE JH7110 TIMER DRIVER
> > +M:	Samin Guo <samin.guo@starfivetech.com>
> > +M:	Xingyu Wu <xingyu.wu@starfivetech.com>
> > +S:	Supported
> > +F:	Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
> > +F:	drivers/clocksource/timer-jh7110.c
> > +
> >  STARFIVE JH71X0 CLOCK DRIVERS
> >  M:	Emil Renner Berthing <kernel@esmil.dk>
> >  M:	Hal Feng <hal.feng@starfivetech.com>
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig =
index
> > 34faa0320ece..2dc97201dee1 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -641,6 +641,17 @@ config RISCV_TIMER
> >  	  is accessed via both the SBI and the rdcycle instruction.  This is
> >  	  required for all RISC-V systems.
> >
> > +config STARFIVE_JH7110_TIMER
> > +	bool "Timer for the STARFIVE JH7110 SoC"
> > +	depends on ARCH_STARFIVE || COMPILE_TEST
> > +	select TIMER_OF
> > +	select CLKSRC_MMIO
> > +	default ARCH_STARFIVE
> > +	help
> > +	  This enables the timer for StarFive JH7110 SoC. On RISC-V platform,
> > +	  the system has started RISCV_TIMER, but you can also use this timer
> > +	  which can provide four channels to do a lot more things on JH7110 S=
oC.
> > +
> >  config CLINT_TIMER
> >  	bool "CLINT Timer for the RISC-V platform" if COMPILE_TEST
> >  	depends on GENERIC_SCHED_CLOCK && RISCV diff --git
> > a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile index
> > 4bb856e4df55..8dc2f0ea2d0f 100644
> > --- a/drivers/clocksource/Makefile
> > +++ b/drivers/clocksource/Makefile
> > @@ -80,6 +80,7 @@ obj-$(CONFIG_INGENIC_TIMER)		+=3D ingenic-timer.o
> >  obj-$(CONFIG_CLKSRC_ST_LPC)		+=3D clksrc_st_lpc.o
> >  obj-$(CONFIG_X86_NUMACHIP)		+=3D numachip.o
> >  obj-$(CONFIG_RISCV_TIMER)		+=3D timer-riscv.o
> > +obj-$(CONFIG_STARFIVE_JH7110_TIMER)	+=3D timer-jh7110.o
> >  obj-$(CONFIG_CLINT_TIMER)		+=3D timer-clint.o
> >  obj-$(CONFIG_CSKY_MP_TIMER)		+=3D timer-mp-csky.o
> >  obj-$(CONFIG_GX6605S_TIMER)		+=3D timer-gx6605s.o
> > diff --git a/drivers/clocksource/timer-jh7110.c
> > b/drivers/clocksource/timer-jh7110.c
> > new file mode 100644
> > index 000000000000..dc770507f209
> > --- /dev/null
> > +++ b/drivers/clocksource/timer-jh7110.c
> > @@ -0,0 +1,345 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Starfive JH7110 Timer driver
> > + *
> > + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> > + *
> > + * This timer has four free-running and independent 32-bit counters an=
d
> > +runs in 24MHz
> > + * clock on the StarFive JH7110 SoC. Each channel(counter) can trigger
> > +an interrupt
> > + * when timeout even CPU is sleeping. They support one-shot mode and
> > continuous-run mode.
> > + *
> > + * Each channel is used as a global timer that serves each cpu core:
> > + * JH7110 Timer Channel 0 -- CPU 0
> > + * JH7110 Timer Channel 1 -- CPU 1
> > + * JH7110 Timer Channel 2 -- CPU 2
> > + * JH7110 Timer Channel 3 -- CPU 3
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/cpu.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/irq.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reset.h>
> > +
> > +/* Bias: Ch0-0x0, Ch1-0x40, Ch2-0x80, and so on. */
> > +#define JH7110_TIMER_CH_LEN		0x40
> > +#define JH7110_TIMER_CH_BASE(x)		((x) * JH7110_TIMER_CH_LEN)
> > +#define JH7110_TIMER_CH_MAX		4
> > +
> > +#define JH7110_DELAY_US			0
> > +#define JH7110_TIMEOUT_US		10000
> > +#define JH7110_CLOCKEVENT_RATING	300
> > +#define JH7110_TIMER_MAX_TICKS		0xffffffff
> > +#define JH7110_TIMER_MIN_TICKS		0xf
> > +
> > +#define JH7110_TIMER_INT_STATUS		0x00 /* RO[0:4]: Interrupt Status
> > for channel0~4 */
> > +#define JH7110_TIMER_CTL		0x04 /* RW[0]: 0-continuous run, 1-single ru=
n
> > */
> > +#define JH7110_TIMER_LOAD		0x08 /* RW: load value to counter */
> > +#define JH7110_TIMER_ENABLE		0x10 /* RW[0]: timer enable register */
> > +#define JH7110_TIMER_RELOAD		0x14 /* RW: write 1 or 0 both reload
> > counter */
> > +#define JH7110_TIMER_VALUE		0x18 /* RO: timer value register */
> > +#define JH7110_TIMER_INT_CLR		0x20 /* RW: timer interrupt clear
> > register */
> > +#define JH7110_TIMER_INT_MASK		0x24 /* RW[0]: timer interrupt
> > mask register */
> > +
> > +#define JH7110_TIMER_INT_CLR_ENA	BIT(0)
> > +#define JH7110_TIMER_INT_CLR_AVA_MASK	BIT(1)
> > +
> > +#define JH7110_PERCPU_GET_CLKEVT
> > 	(&jh7110_timer_info.clkevt[smp_processor_id()])
> > +
> > +/**
> > + * struct jh7110_clkevt - Description of each timer channel
> > + * @clk:		Clock of each timer channel
> > + * @rst:		Reset of each timer channel
> > + * @base:		Virtual address of each timer channel
> > + * @irq:                Interrupt number of each timer channel
> > + * @timer_enabled:      Enabled flag for each timer channel
> > + * @name:		Name of each timer channel
> > + */
> > +struct jh7110_clkevt {
> > +	struct clk		*clk;
> > +	struct reset_control	*rst;
> > +	void __iomem		*base;
> > +	int			irq;
> > +	bool			timer_enabled;
> > +	char			name[sizeof("jh7110-timer.chX")];
> > +};
> > +
> > +struct jh7110_timer_priv {
> > +	struct clk		*pclk;
> > +	struct reset_control	*prst;
> > +	struct device		*dev;
> > +	struct jh7110_clkevt	clkevt[JH7110_TIMER_CH_MAX];
> > +};
> > +
> > +static struct jh7110_timer_priv jh7110_timer_info;
> > +
> > +/* 0:continuous-run mode, 1:single-run mode */ enum jh7110_timer_mode =
{
> > +	JH7110_TIMER_MODE_CONTIN,
> > +	JH7110_TIMER_MODE_SINGLE,
> > +};
> > +
> > +/* Interrupt Mask, 0:Unmask, 1:Mask */
> > +enum jh7110_timer_int_mask {
> > +	JH7110_TIMER_INT_ENA,
> > +	JH7110_TIMER_INT_DIS,
> > +};
> > +
> > +enum jh7110_timer_enable {
> > +	JH7110_TIMER_DIS,
> > +	JH7110_TIMER_ENA,
> > +};
> > +
> > +/*
> > + * BIT(0): Read value represent channel int status.
> > + * Write 1 to this bit to clear interrupt. Write 0 has no effects.
> > + * BIT(1): "1" means that it is clearing interrupt. BIT(0) can not be =
written.
> > + */
> > +static inline int jh7110_timer_int_clear(struct jh7110_clkevt *clkevt)
> > +{
> > +	u32 value;
> > +	int ret;
> > +
> > +	/* Waiting interrupt can be cleared */
> > +	ret =3D readl_poll_timeout_atomic(clkevt->base + JH7110_TIMER_INT_CLR=
,
> > value,
> > +					!(value & JH7110_TIMER_INT_CLR_AVA_MASK),
> > +					JH7110_DELAY_US, JH7110_TIMEOUT_US);
> > +	if (!ret)
> > +		writel(JH7110_TIMER_INT_CLR_ENA, clkevt->base +
> > +JH7110_TIMER_INT_CLR);
> > +
> > +	return ret;
> > +}
> > +
> > +static int jh7110_timer_start(struct jh7110_clkevt *clkevt) {
> > +	int ret;
> > +
> > +	/* Disable and clear interrupt first */
> > +	writel(JH7110_TIMER_INT_DIS, clkevt->base +
> > JH7110_TIMER_INT_MASK);
> > +	ret =3D jh7110_timer_int_clear(clkevt);
> > +
> > +	writel(JH7110_TIMER_INT_ENA, clkevt->base +
> > JH7110_TIMER_INT_MASK);
> > +	writel(JH7110_TIMER_ENA, clkevt->base + JH7110_TIMER_ENABLE);
> > +
> > +	return ret;
> > +}
> > +
> > +static int jh7110_timer_shutdown(struct clock_event_device *evt) {
> > +	struct jh7110_clkevt *clkevt =3D JH7110_PERCPU_GET_CLKEVT;
> > +
> > +	writel(JH7110_TIMER_DIS, clkevt->base + JH7110_TIMER_ENABLE);
> > +	return jh7110_timer_int_clear(clkevt); }
> > +
> > +/* IRQ handler for the timer */
> > +static irqreturn_t jh7110_timer_interrupt(int irq, void *data) {
> > +	struct clock_event_device *evt =3D (struct clock_event_device *)data;
> > +	struct jh7110_clkevt *clkevt =3D &jh7110_timer_info.clkevt[0];
> > +	u32 reg =3D readl(clkevt->base + JH7110_TIMER_INT_STATUS);
> > +	u8 cpu_id =3D smp_processor_id();
> > +
> > +	/* Check interrupt status and channel(cpu) ID */
> > +	if (!(reg & BIT(cpu_id)))
> > +		return IRQ_NONE;
> > +
> > +	clkevt =3D &jh7110_timer_info.clkevt[cpu_id];
> > +	writel(JH7110_TIMER_INT_CLR_ENA, (clkevt->base +
> > +JH7110_TIMER_INT_CLR));
> > +
> > +	if (evt->event_handler)
> > +		evt->event_handler(evt);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int jh7110_timer_set_periodic(struct clock_event_device *evt) {
> > +	struct jh7110_clkevt *clkevt =3D JH7110_PERCPU_GET_CLKEVT;
> > +
> > +	writel(JH7110_TIMER_MODE_CONTIN, clkevt->base +
> > JH7110_TIMER_CTL);
> > +	return 0;
> > +}
> > +
> > +static int jh7110_timer_set_oneshot(struct clock_event_device *evt) {
> > +	struct jh7110_clkevt *clkevt =3D JH7110_PERCPU_GET_CLKEVT;
> > +
> > +	writel(JH7110_TIMER_MODE_SINGLE, clkevt->base +
> > JH7110_TIMER_CTL);
> > +	return 0;
> > +}
> > +
> > +static int jh7110_timer_set_next_event(unsigned long next,
> > +				       struct clock_event_device *evt) {
> > +	struct jh7110_clkevt *clkevt =3D JH7110_PERCPU_GET_CLKEVT;
> > +
> > +	writel(JH7110_TIMER_MODE_SINGLE, clkevt->base +
> > JH7110_TIMER_CTL);
> > +	writel(next, clkevt->base + JH7110_TIMER_LOAD);
> > +
> > +	return jh7110_timer_start(clkevt);
> > +}
> > +
> > +static DEFINE_PER_CPU(struct clock_event_device, jh7110_clock_event) =
=3D {
> > +	.features			=3D CLOCK_EVT_FEAT_PERIODIC |
> > +					  CLOCK_EVT_FEAT_ONESHOT,
> > +	.rating				=3D JH7110_CLOCKEVENT_RATING,
> > +	.set_state_shutdown		=3D jh7110_timer_shutdown,
> > +	.set_state_periodic		=3D jh7110_timer_set_periodic,
> > +	.set_state_oneshot		=3D jh7110_timer_set_oneshot,
> > +	.set_state_oneshot_stopped	=3D jh7110_timer_shutdown,
> > +	.set_next_event			=3D jh7110_timer_set_next_event,
> > +};
> > +
> > +static int jh7110_timer_dying_cpu(unsigned int cpu) {
> > +	struct jh7110_timer_priv *priv =3D &jh7110_timer_info;
> > +
> > +	if (!priv->clkevt[cpu].timer_enabled)
> > +		return 0;
> > +
> > +	writel(JH7110_TIMER_DIS, priv->clkevt[cpu].base +
> > JH7110_TIMER_ENABLE);
> > +	jh7110_timer_int_clear(&priv->clkevt[cpu]);
> > +	reset_control_assert(priv->clkevt[cpu].rst);
> > +	clk_disable_unprepare(priv->clkevt[cpu].clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int jh7110_timer_starting_cpu(unsigned int cpu) {
> > +	struct clock_event_device *evt =3D per_cpu_ptr(&jh7110_clock_event, c=
pu);
> > +	struct jh7110_timer_priv *priv =3D &jh7110_timer_info;
> > +	int err;
> > +	u32 rate;
> > +
> > +	if (cpu >=3D JH7110_TIMER_CH_MAX)
> > +		return -ENOMEM;
> > +
> > +	err =3D clk_prepare_enable(priv->clkevt[cpu].clk);
> > +	if (err)
> > +		goto err_starting_cpu;
> > +
> > +	err =3D reset_control_deassert(priv->clkevt[cpu].rst);
> > +	if (err)
> > +		goto err_soft_reset;
> > +
> > +	rate =3D clk_get_rate(priv->clkevt[cpu].clk);
> > +	evt->cpumask =3D cpumask_of(cpu);
> > +	evt->irq =3D priv->clkevt[cpu].irq;
> > +
> > +	err =3D irq_force_affinity(evt->irq, cpumask_of(cpu));
> > +	if (err)
> > +		goto err_affinity;
> > +
> > +	clockevents_config_and_register(evt, rate, JH7110_TIMER_MIN_TICKS,
> > +					JH7110_TIMER_MAX_TICKS);
> > +
> > +	/* Use one-shot mode */
> > +	writel(JH7110_TIMER_MODE_SINGLE, (priv->clkevt[cpu].base +
> > +JH7110_TIMER_CTL));
> > +
> > +	priv->clkevt[cpu].timer_enabled =3D true;
> > +
> > +	err =3D jh7110_timer_start(&priv->clkevt[cpu]);
> > +	if (err)
> > +		goto err_affinity;
> > +	return 0;
> > +
> > +err_affinity:
> > +	reset_control_assert(priv->clkevt[cpu].rst);
> > +err_soft_reset:
> > +	clk_disable_unprepare(priv->clkevt[cpu].clk);
> > +err_starting_cpu:
> > +	free_irq(evt->irq, evt);
> > +	return err;
> > +}
> > +
> > +static int jh7110_timer_probe(struct platform_device *pdev) {
> > +	struct jh7110_timer_priv *priv =3D &jh7110_timer_info;
> > +	struct clock_event_device *evt;
> > +	struct jh7110_clkevt *clkevt;
> > +	char name[sizeof("chX")];
> > +	int ch;
> > +	int ret;
> > +	void __iomem *base;
> > +
> > +	base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(base))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
> > +				     "failed to map registers\n");
> > +
> > +	priv->prst =3D devm_reset_control_get_exclusive(&pdev->dev, "apb");
> > +	if (IS_ERR(priv->prst))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->prst),
> > +				     "failed to get apb reset\n");
> > +
> > +	priv->pclk =3D devm_clk_get_enabled(&pdev->dev, "apb");
> > +	if (IS_ERR(priv->pclk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->pclk),
> > +				     "failed to get & enable apb clock\n");
> > +
> > +	ret =3D reset_control_deassert(priv->prst);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret, "failed to deassert apb
> > +reset\n");
> > +
> > +	for (ch =3D 0; ch < JH7110_TIMER_CH_MAX; ch++) {
> > +		evt =3D per_cpu_ptr(&jh7110_clock_event, ch);
> > +		clkevt =3D &priv->clkevt[ch];
> > +		snprintf(name, sizeof(name), "ch%d", ch);
> > +
> > +		clkevt->base =3D base + JH7110_TIMER_CH_BASE(ch);
> > +		/* Ensure timer is disabled */
> > +		writel(JH7110_TIMER_DIS, clkevt->base + JH7110_TIMER_ENABLE);
> > +		ret =3D jh7110_timer_int_clear(clkevt);
> > +		if (ret)
> > +			return ret;
> > +
> > +		clkevt->rst =3D devm_reset_control_get_exclusive(&pdev->dev, name);
> > +		if (IS_ERR(clkevt->rst))
> > +			return PTR_ERR(clkevt->rst);
> > +
> > +		clkevt->clk =3D devm_clk_get(&pdev->dev, name);
> > +		if (IS_ERR(clkevt->clk))
> > +			return PTR_ERR(clkevt->clk);
> > +
> > +		clkevt->irq =3D platform_get_irq(pdev, ch);
> > +		if (clkevt->irq < 0)
> > +			return clkevt->irq;
> > +
> > +		snprintf(clkevt->name, sizeof(clkevt->name), "jh7110-timer.ch%d",
> > ch);
> > +		ret =3D devm_request_irq(&pdev->dev, clkevt->irq,
> > jh7110_timer_interrupt,
> > +				       IRQF_TIMER | IRQF_IRQPOLL,
> > +				       clkevt->name, evt);
> > +
> > +		if (ret)
> > +			return ret;
> > +
> > +		clkevt->timer_enabled =3D false;
> > +	}
> > +
> > +	return cpuhp_setup_state(CPUHP_AP_JH7110_TIMER_STARTING,
> > +				"clockevents/jh7110/timer:starting",
> > +				jh7110_timer_starting_cpu, jh7110_timer_dying_cpu); }
> > +
> > +static const struct of_device_id jh7110_timer_match[] =3D {
> > +	{ .compatible =3D "starfive,jh7110-timer", },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, jh7110_timer_match);
> > +
> > +static struct platform_driver jh7110_timer_driver =3D {
> > +	.probe =3D jh7110_timer_probe,
> > +	.driver =3D {
> > +		.name =3D "jh7110-timer",
> > +		.of_match_table =3D jh7110_timer_match,
> > +	},
> > +};
> > +module_platform_driver(jh7110_timer_driver);
> > +
> > +MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
> > +MODULE_DESCRIPTION("StarFive JH7110 timer driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h in=
dex
> > 35e78ddb2b37..4a8b487c327e 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -175,6 +175,7 @@ enum cpuhp_state {
> >  	CPUHP_AP_CSKY_TIMER_STARTING,
> >  	CPUHP_AP_TI_GP_TIMER_STARTING,
> >  	CPUHP_AP_HYPERV_TIMER_STARTING,
> > +	CPUHP_AP_JH7110_TIMER_STARTING,
> >  	/* Must be the last timer callback */
> >  	CPUHP_AP_DUMMY_TIMER_STARTING,
> >  	CPUHP_AP_ARM_XEN_STARTING,
> > --
> > 2.17.1
>
> Hi Daniel / Thomas
>
> I have submitted new version of patch for jh7110 timer driver. Could you =
please help to review and give your comments?
> Thanks a lot!

Hi Ziv

I tried this on 6.9-rc6 on my VF2. It boots, but very slowly and "choppy". =
That
is it repeatedly runs for <1s and then hangs for about 4s.

Does this patch work for you?

/Emil

