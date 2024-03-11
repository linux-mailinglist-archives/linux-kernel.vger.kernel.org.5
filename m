Return-Path: <linux-kernel+bounces-98491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E89877ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B391F222B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C29C2E6;
	Mon, 11 Mar 2024 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ae0RyZBu"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8903AD55
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710136729; cv=none; b=nVQZE6cPG85Qs7+ETiQvpev76ZgZcKn1YQ4VpH8hVmtKFYKnZYNdx27Z2wE/i70zjg/eL4+nPDebbz5HHJXUcHbS4m9IHhV+9kXOYs/vbyvWVVViFWdZKjtwWwtN4o3qKOeYyDLSnqWIcuD5zXKiQUrPrcSoxJtKZZ4XOvf/1AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710136729; c=relaxed/simple;
	bh=SNlJeHoSGuiC4YTmt7+n+q13/150/TRv48G3IjiVdqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ach2zQ7B7dpJIwclIk/lLqRgMZizC4xK6SIQ2W/tEZCUU7pkbCEPIIvnbzwrxdmreyWr6zMqgplMjW1trQdizZOLzUYQRDoFHvLGbClFFN8IwXvU39Vnf0EOsMTiC/U6E1yDhThKRXsvu2ks1LJHswA6KAtHFMFDfspjPChs+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ae0RyZBu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4132a436086so2971035e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 22:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1710136726; x=1710741526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+/SGeTJ2In+PBSViijiZt2zPtoByX/MEX5Z46fSm+M=;
        b=Ae0RyZBuchrgUwx52QKJfZJul5TiBj85ctPe/r7azQNqB26eCeUA+/BZIRfRe1d+Mn
         rSdrWCZvZU47cWqrxw/nlFgBpKSHJSHrSa+qR6N2uUJpYh+YfKGFJZaGTBnik2rY9FD0
         wL+mrYuFNGhjWhB/KMpQ6ylPIF+KWVQbBYezo1a/icpgt35ChY4fqSrbpcHdb7xpucrr
         YGOgFSoWZF+/wMik884zuKUqD4G8Aeyja1PfRLyWFPDODtmf3kQ4BNFArLxKqxa0OeYv
         PAHTG94g4ShUNzPEPoCh3bTgK8tlFodTvlW0ztwS9p5Q0Smkd9xXrbf5sb/gAs8z7bOg
         CrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710136726; x=1710741526;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+/SGeTJ2In+PBSViijiZt2zPtoByX/MEX5Z46fSm+M=;
        b=C9BsDzv5gf++Ti3HbNtnhC+N6JQTQVcXYDaUsi3abbqJ/NsEdQxct2tANBvNXGJfoZ
         Ug+OCYkkj6mo6QYoQI3dTFs6KPlGh4XgItIJASAPIFd93nvEhH2/Xj0vnmZ1vwvDIBX3
         U8aytwkxp9cxnw0m5AARpGB/tGPHuRrwPnt2nSEosR1oaU63nfCPLIpL2bL6BWNbmbkK
         3nOkoKXYyj0n2U5zHBp18PhQ6lolnXr08vOhCK63IyDh/SS4RuyXdKxOTdk94p406wkE
         nBbTkp2sb0f4TNkU/kvb64ub3rlKh3/Pg8WnxYdu8QtQFN6XJpUizwJlGcTmzQ6XsfFV
         gCEg==
X-Forwarded-Encrypted: i=1; AJvYcCUEf0atKwcw6dSwyC30z2GYpBXOPN3MJ3lrlJwwJluvTOeAS6IUZKiWZvFB+FwYMk8Hry4dCSXLuh4o2wlNHXaKNFkepKGeOoFkThnW
X-Gm-Message-State: AOJu0YzVTc7+F37bpFWvHAq5mZz0RjdsED+EccuD++TQHF4TZXDfP8C2
	YZUn+quA/MwYq290YXgobhRpP8Ld56BRzGDLWM5sKengtQBIHLSFqOGl0QEj6DA=
X-Google-Smtp-Source: AGHT+IGAA4xdFAU+7CwwGo6hGmuRT2qEqlJxSkz/J/OB3B3wRCxURUF7dIhuGE4MoPPkxUsohLZtLw==
X-Received: by 2002:a05:600c:4ecf:b0:413:1713:864 with SMTP id g15-20020a05600c4ecf00b0041317130864mr4585552wmq.33.1710136726197;
        Sun, 10 Mar 2024 22:58:46 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c310d00b004131bb71c07sm7820750wmo.11.2024.03.10.22.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 22:58:45 -0700 (PDT)
Message-ID: <01e96d4b-3038-498b-a9b2-2acac51f1d80@tuxon.dev>
Date: Mon, 11 Mar 2024 07:58:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/39] clk: at91: sam9x7: add sam9x7 pmc driver
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 mturquette@baylibre.com, sboyd@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172831.672953-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240223172831.672953-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.02.2024 19:28, Varshini Rajendran wrote:
> Add a driver for the PMC clocks of sam9x7 Soc family.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v4:
> - Changed variable name alloc_mem to clk_mux_buffer to be more
>   suggestive
> - Changed description of @f structure member appropriately
> ---
>  drivers/clk/at91/Makefile |   1 +
>  drivers/clk/at91/sam9x7.c | 946 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 947 insertions(+)
>  create mode 100644 drivers/clk/at91/sam9x7.c
> 
> diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
> index 89061b85e7d2..8e3684ba2c74 100644
> --- a/drivers/clk/at91/Makefile
> +++ b/drivers/clk/at91/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_SOC_AT91SAM9) += at91sam9260.o at91sam9rl.o at91sam9x5.o dt-compat.
>  obj-$(CONFIG_SOC_AT91SAM9) += at91sam9g45.o dt-compat.o
>  obj-$(CONFIG_SOC_AT91SAM9) += at91sam9n12.o at91sam9x5.o dt-compat.o
>  obj-$(CONFIG_SOC_SAM9X60) += sam9x60.o
> +obj-$(CONFIG_SOC_SAM9X7) += sam9x7.o
>  obj-$(CONFIG_SOC_SAMA5D3) += sama5d3.o dt-compat.o
>  obj-$(CONFIG_SOC_SAMA5D4) += sama5d4.o dt-compat.o
>  obj-$(CONFIG_SOC_SAMA5D2) += sama5d2.o dt-compat.o
> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
> new file mode 100644
> index 000000000000..d03387d2e35a
> --- /dev/null
> +++ b/drivers/clk/at91/sam9x7.c
> @@ -0,0 +1,946 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SAM9X7 PMC code.
> + *
> + * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Varshini Rajendran <varshini.rajendran@microchip.com>
> + *
> + */
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/clock/at91.h>
> +
> +#include "pmc.h"
> +
> +static DEFINE_SPINLOCK(pmc_pll_lock);
> +static DEFINE_SPINLOCK(mck_lock);
> +
> +/**
> + * enum pll_ids - PLL clocks identifiers
> + * @PLL_ID_PLLA:	PLLA identifier
> + * @PLL_ID_UPLL:	UPLL identifier
> + * @PLL_ID_AUDIO:	Audio PLL identifier
> + * @PLL_ID_LVDS:	LVDS PLL identifier
> + * @PLL_ID_PLLA_DIV2:	PLLA DIV2 identifier
> + * @PLL_ID_MAX:		Max PLL Identifier
> + */
> +enum pll_ids {
> +	PLL_ID_PLLA,
> +	PLL_ID_UPLL,
> +	PLL_ID_AUDIO,
> +	PLL_ID_LVDS,
> +	PLL_ID_PLLA_DIV2,
> +	PLL_ID_MAX,
> +};
> +
> +/**
> + * enum pll_type - PLL type identifiers
> + * @PLL_TYPE_FRAC:	fractional PLL identifier
> + * @PLL_TYPE_DIV:	divider PLL identifier
> + */
> +enum pll_type {
> +	PLL_TYPE_FRAC,
> +	PLL_TYPE_DIV,
> +};
> +
> +static const struct clk_master_characteristics mck_characteristics = {
> +	.output = { .min = 32000000, .max = 266666667 },
> +	.divisors = { 1, 2, 4, 3, 5},
> +	.have_div3_pres = 1,
> +};
> +
> +static const struct clk_master_layout sam9x7_master_layout = {
> +	.mask = 0x373,
> +	.pres_shift = 4,
> +	.offset = 0x28,
> +};
> +
> +/* Fractional PLL core output range. */
> +static const struct clk_range plla_core_outputs[] = {
> +	{ .min = 375000000, .max = 1600000000 },
> +};
> +
> +static const struct clk_range upll_core_outputs[] = {
> +	{ .min = 600000000, .max = 1200000000 },
> +};
> +
> +static const struct clk_range lvdspll_core_outputs[] = {
> +	{ .min = 400000000, .max = 800000000 },
> +};
> +
> +static const struct clk_range audiopll_core_outputs[] = {
> +	{ .min = 400000000, .max = 800000000 },
> +};
> +
> +static const struct clk_range plladiv2_core_outputs[] = {
> +	{ .min = 375000000, .max = 1600000000 },
> +};
> +
> +/* Fractional PLL output range. */
> +static const struct clk_range plla_outputs[] = {
> +	{ .min = 732421, .max = 800000000 },
> +};
> +
> +static const struct clk_range upll_outputs[] = {
> +	{ .min = 300000000, .max = 600000000 },
> +};
> +
> +static const struct clk_range lvdspll_outputs[] = {
> +	{ .min = 10000000, .max = 800000000 },
> +};
> +
> +static const struct clk_range audiopll_outputs[] = {
> +	{ .min = 10000000, .max = 800000000 },
> +};
> +
> +static const struct clk_range plladiv2_outputs[] = {
> +	{ .min = 366210, .max = 400000000 },
> +};
> +
> +/* PLL characteristics. */
> +static const struct clk_pll_characteristics plla_characteristics = {
> +	.input = { .min = 20000000, .max = 50000000 },
> +	.num_output = ARRAY_SIZE(plla_outputs),
> +	.output = plla_outputs,
> +	.core_output = plla_core_outputs,
> +};
> +
> +static const struct clk_pll_characteristics upll_characteristics = {
> +	.input = { .min = 20000000, .max = 50000000 },
> +	.num_output = ARRAY_SIZE(upll_outputs),
> +	.output = upll_outputs,
> +	.core_output = upll_core_outputs,
> +	.upll = true,
> +};
> +
> +static const struct clk_pll_characteristics lvdspll_characteristics = {
> +	.input = { .min = 20000000, .max = 50000000 },
> +	.num_output = ARRAY_SIZE(lvdspll_outputs),
> +	.output = lvdspll_outputs,
> +	.core_output = lvdspll_core_outputs,
> +};
> +
> +static const struct clk_pll_characteristics audiopll_characteristics = {
> +	.input = { .min = 20000000, .max = 50000000 },
> +	.num_output = ARRAY_SIZE(audiopll_outputs),
> +	.output = audiopll_outputs,
> +	.core_output = audiopll_core_outputs,
> +};
> +
> +static const struct clk_pll_characteristics plladiv2_characteristics = {
> +	.input = { .min = 20000000, .max = 50000000 },
> +	.num_output = ARRAY_SIZE(plladiv2_outputs),
> +	.output = plladiv2_outputs,
> +	.core_output = plladiv2_core_outputs,
> +};
> +
> +/* Layout for fractional PLL ID PLLA. */
> +static const struct clk_pll_layout plla_frac_layout = {
> +	.mul_mask = GENMASK(31, 24),
> +	.frac_mask = GENMASK(21, 0),
> +	.mul_shift = 24,
> +	.frac_shift = 0,
> +	.div2 = 1,

It seems to me that this is not taken into account (see below).

> +};
> +
> +/* Layout for fractional PLLs. */
> +static const struct clk_pll_layout pll_frac_layout = {
> +	.mul_mask = GENMASK(31, 24),
> +	.frac_mask = GENMASK(21, 0),
> +	.mul_shift = 24,
> +	.frac_shift = 0,
> +};
> +
> +/* Layout for DIV PLLs. */
> +static const struct clk_pll_layout pll_divpmc_layout = {
> +	.div_mask = GENMASK(7, 0),
> +	.endiv_mask = BIT(29),
> +	.div_shift = 0,
> +	.endiv_shift = 29,
> +};
> +
> +/* Layout for DIV PLL ID PLLADIV2. */
> +static const struct clk_pll_layout plladiv2_divpmc_layout = {
> +	.div_mask = GENMASK(7, 0),
> +	.endiv_mask = BIT(29),
> +	.div_shift = 0,
> +	.endiv_shift = 29,
> +	.div2 = 1,
> +};
> +
> +/* Layout for DIVIO dividers. */
> +static const struct clk_pll_layout pll_divio_layout = {
> +	.div_mask	= GENMASK(19, 12),
> +	.endiv_mask	= BIT(30),
> +	.div_shift	= 12,
> +	.endiv_shift	= 30,
> +};
> +
> +/*
> + * PLL clocks description
> + * @n:		clock name
> + * @p:		clock parent
> + * @l:		clock layout
> + * @t:		clock type
> + * @c:		pll characteristics
> + * @f:		clock flags
> + * @eid:	export index in sam9x7->chws[] array
> + */
> +static const struct {
> +	const char *n;
> +	const char *p;
> +	const struct clk_pll_layout *l;
> +	u8 t;
> +	const struct clk_pll_characteristics *c;
> +	unsigned long f;
> +	u8 eid;
> +} sam9x7_plls[][PLL_ID_MAX] = {
> +	[PLL_ID_PLLA] = {
> +		{
> +			.n = "plla_fracck",
> +			.p = "mainck",
> +			.l = &plla_frac_layout,
> +			.t = PLL_TYPE_FRAC,
> +			/*
> +			 * This feeds plla_divpmcck which feeds CPU. It should
> +			 * not be disabled.
> +			 */
> +			.f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
> +			.c = &plla_characteristics,
> +		},
> +
> +		{
> +			.n = "plla_divpmcck",
> +			.p = "plla_fracck",
> +			.l = &pll_divpmc_layout,

You mentioned in "[PATCH v4 24/39] clk: at91: sam9x7: add support for HW
PLL freq dividers" that this has div2 but it is registered w/ a layout that
has .div2 = 0.



