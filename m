Return-Path: <linux-kernel+bounces-167750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448508BAE9D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDA7281964
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3A8153584;
	Fri,  3 May 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mj4URREh"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B1757C84
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745550; cv=none; b=FJzx6OIZGhlDhDff2aKj9L0EPzT7XWm99ucz0pcCmZRahSQkiCJN0Ii/wZI3D0qQlzRLOHbyB3JM97Dv1rd3Sz+SxAnlkFpCUjRMxloxk9FfA5wNAUmBJj50glz1B6qrqGwgSRRC1/gQCj47UeJav2IlHsLHdCgHQtLCDG3dGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745550; c=relaxed/simple;
	bh=fmAQOwuqbH92WRnANOz6hbMBCYY9pMsvnv+HZhOCGpU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=YZXYr93h6SrEK3hBcMdcW0+E8ilpGxR+S6PzuMgkgZVOwDvlchlkNi5wwV5nnNrUhdoICWijwwR/d0amTaPN0vaDr6/2RbOhv2Yq15AMPCBk29ohl0yD6e2bYFMHIjA2M4cqGw53tbgGi1e1X2xAJ3+G4A6L0vr1OjGEE9eaBGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mj4URREh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so3074759f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714745547; x=1715350347; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=hhRxRK/HSEN/52/No7JIaI4S23/1GIMBtFW/KjaPFSA=;
        b=mj4URREhiH6Z2+lNSdCdxPvzEzFG0TXf0Pgq2JZon4j/4yhRM+DZWIa/p/B+H+kmm6
         w+jHOzPjdMHqro5G4dAV/RqG64q/Uu8DlZWUcpZkQbTP4xS+f13OnTRkHhrt9T0Iv8CJ
         05ZxTzePMD7CBe2V8sVuaVv2UqPc5VWtITkK2bs6q0c1IKn1Z6neNgZZsO64ac4GUlaZ
         2d3adV2nPRXPKPJNJGRG596sNsO5vsbWkPCz9Yvfj5uLxfcS4U/vzmASR/1CTCFvWcU5
         63wF5IPCmw4XiWWzV+m192UGFxx8+2oY7V4M13tAcJ83pNbyML14GbAtnYqQAhudY6bO
         3xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714745547; x=1715350347;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhRxRK/HSEN/52/No7JIaI4S23/1GIMBtFW/KjaPFSA=;
        b=NG+0S1zvTAdUBvfMcAS17H1u7Y56BmjTtPQ6iiOxsbnAF2vk+Yy/d7Jellmah17aWh
         BzJjUJLFBvdC3pKPGHvm3ITBM/SYGHyxMoaaMSX26Db9dY5N1USo/vg3Zu7cqt7kLB4d
         +nM39LkZhJmu1l8Ny2oFpc4FZ2pd+ehL2Kd7GRTJtmpIXCmh/sTeNv2vIiwii24syrPd
         tlkp6hEfYQi3pWxuUIBy/mfw49yEONvU4NnYaRM1HLNwPNJDHOgWdq/o946OA9ZtPr/m
         Ej9P22Cc5ENWeD4inYRgVm9dCf0NK/mULxL301O55yI+gwT6vU1oiJpJpftCKelnozK0
         lVgw==
X-Forwarded-Encrypted: i=1; AJvYcCXGLXNLp6GY+VIprMPrz9Cjzflha1tZ4luD9CqqshXDTtclppiyF1Lla68ncNGORXUjifxIWZPbnGiQcTM+Owhwe1uzNaNdl8ShKabC
X-Gm-Message-State: AOJu0YxPD7IwDY7Ff/yE2DNUwcT21iHd6qFwbq5rxqvg/R0k3yZg3fA+
	hiLYbLXlX2dHu67PsIN4+IP5V3FYktAEce1hXG2l7qxHsNljL0277SF9a2PC58M=
X-Google-Smtp-Source: AGHT+IG7I+uOPEVi7yt2/IEUl4ceEwG2AhZeV5XXRfYV9348623gNtreh4a6C9PXtYfg2IF5WehKUA==
X-Received: by 2002:a5d:608f:0:b0:346:bc1b:4e7c with SMTP id w15-20020a5d608f000000b00346bc1b4e7cmr2682453wrt.35.1714745546806;
        Fri, 03 May 2024 07:12:26 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:1b85:e590:355b:9957])
        by smtp.gmail.com with ESMTPSA id s14-20020adfe00e000000b0034e553f6174sm2345294wrh.98.2024.05.03.07.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 07:12:26 -0700 (PDT)
References: <20240430064438.2094701-1-xianwei.zhao@amlogic.com>
 <20240430064438.2094701-5-xianwei.zhao@amlogic.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Neil Armstrong
 <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen  Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Chuan Liu <chuan.liu@amlogic.com>
Subject: Re: [PATCH v8 4/5] clk: meson: c3: add support for the C3 SoC PLL
 clock
Date: Fri, 03 May 2024 16:11:08 +0200
In-reply-to: <20240430064438.2094701-5-xianwei.zhao@amlogic.com>
Message-ID: <1jzft72ddi.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 30 Apr 2024 at 14:44, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:

> Add the C3 PLL clock controller driver for the Amlogic C3 SoC family.
>
> Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig  |  14 +
>  drivers/clk/meson/Makefile |   1 +
>  drivers/clk/meson/c3-pll.c | 746 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 761 insertions(+)
>  create mode 100644 drivers/clk/meson/c3-pll.c
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 29ffd14d267b..9f975a980581 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -128,6 +128,20 @@ config COMMON_CLK_A1_PERIPHERALS
>  	  device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>  	  controller to work.
>  
> +config COMMON_CLK_C3_PLL
> +	tristate "Amlogic C3 PLL clock controller"
> +	depends on ARM64
> +	depends on ARM_SCMI_PROTOCOL

There was a comment from Rob on v7 that was not addressed.
Please make sure you address all comments before reposting.

> +	depends on COMMON_CLK_SCMI

imply, not depend.

> +	default y
> +	select COMMON_CLK_MESON_REGMAP
> +	select COMMON_CLK_MESON_PLL
> +	select COMMON_CLK_MESON_CLKC_UTILS
> +	help
> +	  Support for the PLL clock controller on Amlogic C302X and C308L devices,
> +	  AKA C3. Say Y if you want the board to work, because PLLs are the parent
> +	  of most peripherals.
> +
>  config COMMON_CLK_G12A
>  	tristate "G12 and SM1 SoC clock controllers support"
>  	depends on ARM64
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 9ee4b954c896..4420af628b31 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>  obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
> +obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
> diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
> new file mode 100644
> index 000000000000..74e11add165c
> --- /dev/null
> +++ b/drivers/clk/meson/c3-pll.c
> @@ -0,0 +1,746 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Amlogic C3 PLL Controller Driver
> + *
> + * Copyright (c) 2023 Amlogic, inc.
> + * Author: Chuan Liu <chuan.liu@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +#include "clk-regmap.h"
> +#include "clk-pll.h"
> +#include "meson-clkc-utils.h"
> +#include <dt-bindings/clock/amlogic,c3-pll-clkc.h>
> +
> +#define ANACTRL_FIXPLL_CTRL4			0x50
> +#define ANACTRL_GP0PLL_CTRL0			0x80
> +#define ANACTRL_GP0PLL_CTRL1			0x84
> +#define ANACTRL_GP0PLL_CTRL2			0x88
> +#define ANACTRL_GP0PLL_CTRL3			0x8c
> +#define ANACTRL_GP0PLL_CTRL4			0x90
> +#define ANACTRL_GP0PLL_CTRL5			0x94
> +#define ANACTRL_GP0PLL_CTRL6			0x98
> +#define ANACTRL_HIFIPLL_CTRL0			0x100
> +#define ANACTRL_HIFIPLL_CTRL1			0x104
> +#define ANACTRL_HIFIPLL_CTRL2			0x108
> +#define ANACTRL_HIFIPLL_CTRL3			0x10c
> +#define ANACTRL_HIFIPLL_CTRL4			0x110
> +#define ANACTRL_HIFIPLL_CTRL5			0x114
> +#define ANACTRL_HIFIPLL_CTRL6			0x118
> +#define ANACTRL_MPLL_CTRL0			0x180
> +#define ANACTRL_MPLL_CTRL1			0x184
> +#define ANACTRL_MPLL_CTRL2			0x188
> +#define ANACTRL_MPLL_CTRL3			0x18c
> +#define ANACTRL_MPLL_CTRL4			0x190
> +
> +static struct clk_regmap fclk_50m_en = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 0,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_50m_en",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix"
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_50m = {
> +	.mult = 1,
> +	.div = 40,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_50m",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_50m_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div2_div = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div2_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix"
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div2 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div2",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div2_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div2p5_div = {
> +	.mult = 2,
> +	.div = 5,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div2p5_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix"
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div2p5 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 4,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div2p5",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div2p5_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div3_div = {
> +	.mult = 1,
> +	.div = 3,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div3_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix"
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div3 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 20,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div3",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div3_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div4_div = {
> +	.mult = 1,
> +	.div = 4,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div4_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix"
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div4 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 21,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div4",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div4_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div5_div = {
> +	.mult = 1,
> +	.div = 5,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div5_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix"
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div5 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 22,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div5",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div5_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div7_div = {
> +	.mult = 1,
> +	.div = 7,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div7_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix"
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div7 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 23,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div7",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div7_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct reg_sequence c3_gp0_init_regs[] = {
> +	{ .reg = ANACTRL_GP0PLL_CTRL2,	.def = 0x0 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL3,	.def = 0x48681c00 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL4,  .def = 0x88770290 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL5,  .def = 0x3927200a },
> +	{ .reg = ANACTRL_GP0PLL_CTRL6,	.def = 0x56540000 },
> +};
> +
> +static const struct pll_mult_range c3_gp0_pll_mult_range = {
> +	.min = 125,
> +	.max = 250,
> +};
> +
> +static struct clk_regmap gp0_pll_dco = {
> +	.data = &(struct meson_clk_pll_data) {
> +		.en = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 9,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 19,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &c3_gp0_pll_mult_range,
> +		.init_regs = c3_gp0_init_regs,
> +		.init_count = ARRAY_SIZE(c3_gp0_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gp0_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "top",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +/* The maximum frequency divider supports is 32, not 128(2^7) */
> +static const struct clk_div_table c3_gp0_pll_od_table[] = {
> +	{ 0,  1 },
> +	{ 1,  2 },
> +	{ 2,  4 },
> +	{ 3,  8 },
> +	{ 4, 16 },
> +	{ 5, 32 },
> +	{ /* sentinel */ }
> +};
> +
> +static struct clk_regmap gp0_pll = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_GP0PLL_CTRL0,
> +		.shift = 16,
> +		.width = 3,
> +		.table = c3_gp0_pll_od_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gp0_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gp0_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct reg_sequence c3_hifi_init_regs[] = {
> +	{ .reg = ANACTRL_HIFIPLL_CTRL2,	.def = 0x0 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL3,	.def = 0x6a285c00 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x3927200a },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL6,	.def = 0x56540000 },
> +};
> +
> +static struct clk_regmap hifi_pll_dco = {
> +	.data = &(struct meson_clk_pll_data) {
> +		.en = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 19,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &c3_gp0_pll_mult_range,
> +		.init_regs = c3_hifi_init_regs,
> +		.init_count = ARRAY_SIZE(c3_hifi_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hifi_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "top",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap hifi_pll = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_HIFIPLL_CTRL0,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hifi_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&hifi_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct reg_sequence c3_mclk_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL1,	.def = 0x1420500f },
> +	{ .reg = ANACTRL_MPLL_CTRL2,	.def = 0x00023041 },
> +	{ .reg = ANACTRL_MPLL_CTRL3,	.def = 0x18180000 },
> +	{ .reg = ANACTRL_MPLL_CTRL2,	.def = 0x00023001 }
> +};
> +
> +static const struct pll_mult_range c3_mclk_pll_mult_range = {
> +	.min = 67,
> +	.max = 133,
> +};
> +
> +static struct clk_regmap mclk_pll_dco = {
> +	.data = &(struct meson_clk_pll_data) {
> +		.en = {
> +			.reg_off = ANACTRL_MPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_MPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_MPLL_CTRL0,
> +			.shift   = 16,
> +			.width   = 5,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_MPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_MPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &c3_mclk_pll_mult_range,
> +		.init_regs = c3_mclk_init_regs,
> +		.init_count = ARRAY_SIZE(c3_mclk_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "mclk",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct clk_div_table c3_mpll_od_table[] = {
> +	{ 0,  1 },
> +	{ 1,  2 },
> +	{ 2,  4 },
> +	{ 3,  8 },
> +	{ 4, 16 },
> +	{ /* sentinel */ }
> +};
> +
> +static struct clk_regmap mclk_pll_od = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_MPLL_CTRL0,
> +		.shift = 12,
> +		.width = 3,
> +		.table = c3_mpll_od_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk_pll_od",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk_pll_dco.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/* both value 0 and 1 gives divide the input rate by one */
> +static struct clk_regmap mclk_pll = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.shift = 16,
> +		.width = 5,
> +		.flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk_pll_od.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data mclk_parent[] = {
> +	{ .hw = &mclk_pll.hw },
> +	{ .fw_name = "mclk" },
> +	{ .hw = &fclk_50m.hw }
> +};
> +
> +static struct clk_regmap mclk0_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.mask = 0x3,
> +		.shift = 4,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = mclk_parent,
> +		.num_parents = ARRAY_SIZE(mclk_parent),
> +	},
> +};
> +
> +static struct clk_regmap mclk0_div_en = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.bit_idx = 1,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk0_div_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk0_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap mclk0_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.shift = 2,
> +		.width = 1,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk0_div_en.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap mclk0 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.bit_idx = 0,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap mclk1_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.mask = 0x3,
> +		.shift = 12,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = mclk_parent,
> +		.num_parents = ARRAY_SIZE(mclk_parent),
> +	},
> +};
> +
> +static struct clk_regmap mclk1_div_en = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.bit_idx = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk1_div_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk1_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap mclk1_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.shift = 10,
> +		.width = 1,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk1_div_en.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap mclk1 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk1_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_hw *c3_pll_hw_clks[] = {
> +	[CLKID_FCLK_50M_EN]	= &fclk_50m_en.hw,
> +	[CLKID_FCLK_50M]	= &fclk_50m.hw,
> +	[CLKID_FCLK_DIV2_DIV]	= &fclk_div2_div.hw,
> +	[CLKID_FCLK_DIV2]	= &fclk_div2.hw,
> +	[CLKID_FCLK_DIV2P5_DIV]	= &fclk_div2p5_div.hw,
> +	[CLKID_FCLK_DIV2P5]	= &fclk_div2p5.hw,
> +	[CLKID_FCLK_DIV3_DIV]	= &fclk_div3_div.hw,
> +	[CLKID_FCLK_DIV3]	= &fclk_div3.hw,
> +	[CLKID_FCLK_DIV4_DIV]	= &fclk_div4_div.hw,
> +	[CLKID_FCLK_DIV4]	= &fclk_div4.hw,
> +	[CLKID_FCLK_DIV5_DIV]	= &fclk_div5_div.hw,
> +	[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
> +	[CLKID_FCLK_DIV7_DIV]	= &fclk_div7_div.hw,
> +	[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
> +	[CLKID_GP0_PLL_DCO]	= &gp0_pll_dco.hw,
> +	[CLKID_GP0_PLL]		= &gp0_pll.hw,
> +	[CLKID_HIFI_PLL_DCO]	= &hifi_pll_dco.hw,
> +	[CLKID_HIFI_PLL]	= &hifi_pll.hw,
> +	[CLKID_MCLK_PLL_DCO]	= &mclk_pll_dco.hw,
> +	[CLKID_MCLK_PLL_OD]	= &mclk_pll_od.hw,
> +	[CLKID_MCLK_PLL]	= &mclk_pll.hw,
> +	[CLKID_MCLK0_SEL]	= &mclk0_sel.hw,
> +	[CLKID_MCLK0_SEL_EN]	= &mclk0_div_en.hw,
> +	[CLKID_MCLK0_DIV]	= &mclk0_div.hw,
> +	[CLKID_MCLK0]		= &mclk0.hw,
> +	[CLKID_MCLK1_SEL]	= &mclk1_sel.hw,
> +	[CLKID_MCLK1_SEL_EN]	= &mclk1_div_en.hw,
> +	[CLKID_MCLK1_DIV]	= &mclk1_div.hw,
> +	[CLKID_MCLK1]		= &mclk1.hw
> +};
> +
> +/* Convenience table to populate regmap in .probe */
> +static struct clk_regmap *const c3_pll_clk_regmaps[] = {
> +	&fclk_50m_en,
> +	&fclk_div2,
> +	&fclk_div2p5,
> +	&fclk_div3,
> +	&fclk_div4,
> +	&fclk_div5,
> +	&fclk_div7,
> +	&gp0_pll_dco,
> +	&gp0_pll,
> +	&hifi_pll_dco,
> +	&hifi_pll,
> +	&mclk_pll_dco,
> +	&mclk_pll_od,
> +	&mclk_pll,
> +	&mclk0_sel,
> +	&mclk0_div_en,
> +	&mclk0_div,
> +	&mclk0,
> +	&mclk1_sel,
> +	&mclk1_div_en,
> +	&mclk1_div,
> +	&mclk1,
> +};
> +
> +static struct regmap_config clkc_regmap_config = {
> +	.reg_bits       = 32,
> +	.val_bits       = 32,
> +	.reg_stride     = 4,
> +	.max_register   = ANACTRL_MPLL_CTRL4,
> +};
> +
> +static struct meson_clk_hw_data c3_pll_clks = {
> +	.hws = c3_pll_hw_clks,
> +	.num = ARRAY_SIZE(c3_pll_hw_clks),
> +};
> +
> +static int aml_c3_pll_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	void __iomem *base;
> +	int clkid, ret, i;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	/* Populate regmap for the regmap backed clocks */
> +	for (i = 0; i < ARRAY_SIZE(c3_pll_clk_regmaps); i++)
> +		c3_pll_clk_regmaps[i]->map = regmap;
> +
> +	for (clkid = 0; clkid < c3_pll_clks.num; clkid++) {
> +		/* array might be sparse */
> +		if (!c3_pll_clks.hws[clkid])
> +			continue;
> +
> +		ret = devm_clk_hw_register(dev, c3_pll_clks.hws[clkid]);
> +		if (ret) {
> +			dev_err(dev, "Clock registration failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
> +					   &c3_pll_clks);
> +}
> +
> +static const struct of_device_id c3_pll_clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,c3-pll-clkc",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, c3_pll_clkc_match_table);
> +
> +static struct platform_driver c3_pll_driver = {
> +	.probe		= aml_c3_pll_probe,
> +	.driver		= {
> +		.name	= "c3-pll-clkc",
> +		.of_match_table = c3_pll_clkc_match_table,
> +	},
> +};
> +
> +module_platform_driver(c3_pll_driver);
> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
> +MODULE_LICENSE("GPL");


-- 
Jerome

