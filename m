Return-Path: <linux-kernel+bounces-7485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087DE81A8BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5CE1C22504
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2412E495FF;
	Wed, 20 Dec 2023 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLJVvOeD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86648780;
	Wed, 20 Dec 2023 22:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1891C433C7;
	Wed, 20 Dec 2023 22:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703110147;
	bh=n2WN7a6kmK1PS3VBEljLxjvOz4cQI76lQvzhbY9GqhU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kLJVvOeDR8TZdNN6LNpze1EukidKPmDsBghMNgHOdCJhXUqicf+9jpSuaybGsNBfX
	 bWZwBFsG+Oo6kOuhYElKlgqfTvX5dZ4oyg1zEfXFx6HZB1p3tvj1StOUijuA5Oth/Y
	 JPOAXWo0FMv/JKIp41i0fmK2ZdoiB7AMxpD+F0cVuTvRVpJ1s4j9ESjxuXm8DATuEw
	 EfunZX8JK2vdIf0hDhLMbRtNBo0517uHCgU+AtOxs1IQ1JHdNsw1VpTuL8r5S821Bd
	 0++gz4HaJBoL/SabYzNyJq5kDdDX5KJyXjguTTUMu568HQrcFHDQcAgWRcIjovt34x
	 +hFi+Eb6AcxGg==
Message-ID: <7c322ab2ab59b434429ce471c148c026.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231218170404.910153-1-tmaimon77@gmail.com>
References: <20231218170404.910153-1-tmaimon77@gmail.com>
Subject: Re: [PATCH RESEND v21] clk: npcm8xx: add clock controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
To: Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com, benjaminfair@google.com, joel@jms.id.au, mturquette@baylibre.com, tali.perry1@gmail.com, venture@google.com, yuenn@google.com
Date: Wed, 20 Dec 2023 14:09:05 -0800
User-Agent: alot/0.10

Quoting Tomer Maimon (2023-12-18 09:04:04)
> diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> new file mode 100644
> index 000000000000..e6c5111cc255
> --- /dev/null
> +++ b/drivers/clk/clk-npcm8xx.c
> @@ -0,0 +1,552 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Nuvoton NPCM8xx Clock Generator
> + * All the clocks are initialized by the bootloader, so this driver allo=
ws only
> + * reading of current settings directly from the hardware.
> + *
> + * Copyright (C) 2020 Nuvoton Technologies
> + * Author: Tomer Maimon <tomer.maimon@nuvoton.com>
> + */
> +
> +#define pr_fmt(fmt) "npcm8xx_clk: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
[...]
> +#define NPCM8XX_CLK_S_CLKOUT      "clkout"
> +#define NPCM8XX_CLK_S_PRE_ADC     "pre adc"
> +#define NPCM8XX_CLK_S_UART        "uart"
> +#define NPCM8XX_CLK_S_UART2       "uart2"
> +#define NPCM8XX_CLK_S_TIMER       "timer"
> +#define NPCM8XX_CLK_S_MMC         "mmc"
> +#define NPCM8XX_CLK_S_SDHC        "sdhc"
> +#define NPCM8XX_CLK_S_ADC         "adc"
> +#define NPCM8XX_CLK_S_GFX         "gfx0_gfx1_mem"
> +#define NPCM8XX_CLK_S_USBIF       "serial_usbif"
> +#define NPCM8XX_CLK_S_USB_HOST    "usb_host"
> +#define NPCM8XX_CLK_S_USB_BRIDGE  "usb_bridge"
> +#define NPCM8XX_CLK_S_PCI         "pci"
> +#define NPCM8XX_CLK_S_TH          "th"
> +#define NPCM8XX_CLK_S_ATB         "atb"
> +#define NPCM8XX_CLK_S_PRE_CLK     "pre_clk"
> +#define NPCM8XX_CLK_S_RG         "rg"
> +#define NPCM8XX_CLK_S_RCP        "rcp"
> +
> +static struct clk_hw hw_pll1_div2, hw_pll2_div2, hw_gfx_div2, hw_pre_clk;
> +static struct npcm8xx_clk_pll_data npcm8xx_pll_clks[] =3D {
> +       { NPCM8XX_CLK_S_PLL0, { .name =3D NPCM8XX_CLK_S_REFCLK }, NPCM8XX=
_PLLCON0, 0 },

This is a new driver, so please stop using .name in clk_parent_data
structures.

> +       { NPCM8XX_CLK_S_PLL1, { .name =3D NPCM8XX_CLK_S_REFCLK }, NPCM8XX=
_PLLCON1, 0 },
> +       { NPCM8XX_CLK_S_PLL2, { .name =3D NPCM8XX_CLK_S_REFCLK }, NPCM8XX=
_PLLCON2, 0 },
> +       { NPCM8XX_CLK_S_PLL_GFX, { .name =3D NPCM8XX_CLK_S_REFCLK }, NPCM=
8XX_PLLCONG, 0 },
> +};
> +
> +static const u32 cpuck_mux_table[] =3D { 0, 1, 2, 7 };
> +static const struct clk_parent_data cpuck_mux_parents[] =3D {
> +       { .hw =3D &npcm8xx_pll_clks[0].hw },
> +       { .hw =3D &npcm8xx_pll_clks[1].hw },
> +       { .index =3D 0 },

This requires a binding update. As of today, there isn't a 'clocks'
property for the nuvoton,npcm845-clk binding.

> +       { .hw =3D &npcm8xx_pll_clks[2].hw }
> +};
> +
> +static const u32 pixcksel_mux_table[] =3D { 0, 2 };
> +static const struct clk_parent_data pixcksel_mux_parents[] =3D {
> +       { .hw =3D &npcm8xx_pll_clks[3].hw },
> +       { .index =3D 0 }
> +};
> +
[...]
> +
> +/* configurable dividers: */
> +static struct npcm8xx_clk_div_data npcm8xx_divs[] =3D {
> +       { NPCM8XX_CLKDIV1, 28, 3, NPCM8XX_CLK_S_ADC, &npcm8xx_pre_divs[0]=
.hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_ADC },
> +       { NPCM8XX_CLKDIV1, 16, 5, NPCM8XX_CLK_S_UART, &npcm8xx_muxes[3].h=
w, 0, 0, NPCM8XX_CLK_UART },
> +       { NPCM8XX_CLKDIV1, 11, 5, NPCM8XX_CLK_S_MMC, &npcm8xx_muxes[2].hw=
, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_MMC },
> +       { NPCM8XX_CLKDIV1, 6, 5, NPCM8XX_CLK_S_SPI3, &npcm8xx_pre_divs[1]=
.hw, 0, 0, NPCM8XX_CLK_SPI3 },
> +       { NPCM8XX_CLKDIV1, 2, 4, NPCM8XX_CLK_S_PCI, &npcm8xx_muxes[7].hw,=
 CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_PCI },
> +
> +       { NPCM8XX_CLKDIV2, 30, 2, NPCM8XX_CLK_S_APB4, &npcm8xx_pre_divs[1=
].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB4=
 },
> +       { NPCM8XX_CLKDIV2, 28, 2, NPCM8XX_CLK_S_APB3, &npcm8xx_pre_divs[1=
].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB3=
 },
> +       { NPCM8XX_CLKDIV2, 26, 2, NPCM8XX_CLK_S_APB2, &npcm8xx_pre_divs[1=
].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB2=
 },
> +       { NPCM8XX_CLKDIV2, 24, 2, NPCM8XX_CLK_S_APB1, &npcm8xx_pre_divs[1=
].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB1=
 },
> +       { NPCM8XX_CLKDIV2, 22, 2, NPCM8XX_CLK_S_APB5, &npcm8xx_pre_divs[1=
].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB5=
 },
> +       { NPCM8XX_CLKDIV2, 16, 5, NPCM8XX_CLK_S_CLKOUT, &npcm8xx_muxes[8]=
.hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_CLKOUT },
> +       { NPCM8XX_CLKDIV2, 13, 3, NPCM8XX_CLK_S_GFX, &npcm8xx_muxes[7].hw=
, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_GFX },
> +       { NPCM8XX_CLKDIV2, 8, 5, NPCM8XX_CLK_S_USB_BRIDGE, &npcm8xx_muxes=
[4].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU },

Just put the string where there are any macros that are used once
please.

> +       { NPCM8XX_CLKDIV2, 4, 4, NPCM8XX_CLK_S_USB_HOST, &npcm8xx_muxes[4=
].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU48 },
> +       { NPCM8XX_CLKDIV2, 0, 4, NPCM8XX_CLK_S_SDHC, &npcm8xx_muxes[2].hw=
, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SDHC },
> +
> +       { NPCM8XX_CLKDIV3, 16, 8, NPCM8XX_CLK_S_SPI1, &npcm8xx_pre_divs[1=
].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI1 },
> +       { NPCM8XX_CLKDIV3, 11, 5, NPCM8XX_CLK_S_UART2, &npcm8xx_muxes[3].=
hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_UART2 },
> +       { NPCM8XX_CLKDIV3, 6, 5, NPCM8XX_CLK_S_SPI0, &npcm8xx_pre_divs[1]=
.hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI0 },
> +       { NPCM8XX_CLKDIV3, 1, 5, NPCM8XX_CLK_S_SPIX, &npcm8xx_pre_divs[1]=
.hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPIX },
> +
> +       { NPCM8XX_CLKDIV4, 28, 4, NPCM8XX_CLK_S_RG, &npcm8xx_muxes[11].hw=
, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RG },
> +       { NPCM8XX_CLKDIV4, 12, 4, NPCM8XX_CLK_S_RCP, &npcm8xx_muxes[12].h=
w, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RCP },
> +
> +       { NPCM8XX_THRTL_CNT, 0, 2, NPCM8XX_CLK_S_TH, &npcm8xx_muxes[0].hw=
, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_TH },
> +};
> +
[...]
> +
> +static int npcm8xx_clk_probe(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *npcm8xx_clk_data;
> +       struct device_node *np =3D pdev->dev.of_node;
> +       struct device *dev =3D &pdev->dev;
> +       struct regmap *clk_regmap;
> +       struct clk_hw *hw;
> +       unsigned int i;
> +
> +       npcm8xx_clk_data =3D devm_kzalloc(dev, struct_size(npcm8xx_clk_da=
ta, hws,
> +                                                        NPCM8XX_NUM_CLOC=
KS),
> +                                       GFP_KERNEL);
> +       if (!npcm8xx_clk_data)
> +               return -ENOMEM;
> +
> +       clk_regmap =3D syscon_regmap_lookup_by_phandle(np, "nuvoton,syscl=
k");

I don't see this as part of the binding either. Please update the
binding.

> +       if (IS_ERR(clk_regmap)) {
> +               dev_err(&pdev->dev, "Failed to find nuvoton,sysclk\n");
> +               return PTR_ERR(clk_regmap);
> +       }
> +
> +       npcm8xx_clk_data->num =3D NPCM8XX_NUM_CLOCKS;
> +
> +       for (i =3D 0; i < NPCM8XX_NUM_CLOCKS; i++)
> +               npcm8xx_clk_data->hws[i] =3D ERR_PTR(-EPROBE_DEFER);
> +
> +       /* Register plls */

