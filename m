Return-Path: <linux-kernel+bounces-2873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80765816384
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3574228221A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ED04B12A;
	Sun, 17 Dec 2023 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lcjc/JkG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ED44B124;
	Sun, 17 Dec 2023 23:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3E9C433C8;
	Sun, 17 Dec 2023 23:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702857140;
	bh=6ao4QwwxsmhGEWfg70Ew5Z3bfAgkkiWmUHeBKXMWP5A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Lcjc/JkGziIa2RuVNBajY3AdoGjPMQzGHrloj/z82rGm5VgIW2UQ26gGUe7/6l8zP
	 hx/rGKwEQ08lUDQNm1ogKrdw5xNJkdsp0MnsqSSfGMH7X/eHqCt0rlpGP7M2jPInIe
	 sa4WwNTbybCwMo+98RfVWEeSYoo5FKXqncxHVP+VNcd4kMykiLgpI9YKWsspjGb05b
	 RHBNIhwV1umhWMt8BYvgbKr017ldpwB5jYtwWq8u4951MYML8J0TXJWWXkKVdyg4XY
	 Z/Pkkoc7slZiPaI8DfvaHReY0ryORFLPPQQ2MktBKxh5xjX0MuqvE3Rv+4L7E0343I
	 CaYdFKJ2OKoeQ==
Message-ID: <e8124f2cad7afbb4e9fbd777dda992f4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231208143700.354785-5-gabriel.fernandez@foss.st.com>
References: <20231208143700.354785-1-gabriel.fernandez@foss.st.com> <20231208143700.354785-5-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v6 4/5] clk: stm32: introduce clocks for STM32MP257 platform
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Sun, 17 Dec 2023 15:52:17 -0800
User-Agent: alot/0.10

Quoting gabriel.fernandez@foss.st.com (2023-12-08 06:36:59)
> diff --git a/drivers/clk/stm32/clk-stm32mp25.c b/drivers/clk/stm32/clk-st=
m32mp25.c
> new file mode 100644
> index 000000000000..36321fd6142e
> --- /dev/null
> +++ b/drivers/clk/stm32/clk-stm32mp25.c
> @@ -0,0 +1,1125 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
> + * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicro=
electronics.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>

Is this include used?

> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>

Is this include used?

> +
> +#include "clk-stm32-core.h"
> +#include "reset-stm32.h"
> +
> +#include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +#include <dt-bindings/reset/st,stm32mp25-rcc.h>
> +
> +#include "stm32mp25_rcc.h"
> +
> +static const char * const adc12_src[] =3D {
> +       "ck_flexgen_46", "ck_icn_ls_mcu"

Can we please migrate to struct clk_parent_data?

> +};
> +
> +static const char * const adc3_src[] =3D {
> +       "ck_flexgen_47", "ck_icn_ls_mcu", "ck_flexgen_46"
> +};
> +
> +static const char * const usb2phy1_src[] =3D {
> +       "ck_flexgen_57", "hse_div2_ck"
> +};
[...]
> +       GATE_TIM4,
> +       GATE_TIM5,
> +       GATE_TIM6,
> +       GATE_TIM7,
> +       GATE_TIM8,
> +       GATE_UART4,
> +       GATE_UART5,
> +       GATE_UART7,
> +       GATE_UART8,
> +       GATE_UART9,
> +       GATE_USART1,
> +       GATE_USART2,
> +       GATE_USART3,
> +       GATE_USART6,
> +       GATE_USB2,
> +       GATE_USB2PHY1,
> +       GATE_USB2PHY2,
> +       GATE_USB3DR,
> +       GATE_USB3PCIEPHY,
> +       GATE_USBTC,
> +       GATE_VDEC,
> +       GATE_VENC,
> +       GATE_VREF,
> +       GATE_WWDG1,
> +       GATE_WWDG2,
> +       GATE_NB
> +};
> +
> +#define GATE_CFG(id, _offset, _bit_idx, _offset_clr)\
> +       [id] =3D {\

Please move these slashes out and align them.

> +               .offset         =3D (_offset),\
> +               .bit_idx        =3D (_bit_idx),\
> +               .set_clr        =3D (_offset_clr),\
> +       }
> +
> +static const struct stm32_gate_cfg stm32mp25_gates[GATE_NB] =3D {
> +       GATE_CFG(GATE_ADC12,            RCC_ADC12CFGR,          1,      0=
),
> +       GATE_CFG(GATE_ADC3,             RCC_ADC3CFGR,           1,      0=
),
> +       GATE_CFG(GATE_ADF1,             RCC_ADF1CFGR,           1,      0=
),
> +       GATE_CFG(GATE_CCI,              RCC_CCICFGR,            1,      0=
),
> +       GATE_CFG(GATE_CRC,              RCC_CRCCFGR,            1,      0=
),
> +       GATE_CFG(GATE_CRYP1,            RCC_CRYP1CFGR,          1,      0=
),
[....]
> +
> +static struct clk_stm32_clock_data stm32mp25_clock_data =3D {
> +       .gate_cpt       =3D stm32mp25_cpt_gate,
> +       .gates          =3D stm32mp25_gates,
> +       .muxes          =3D stm32mp25_muxes,
> +};
> +
> +static struct clk_stm32_reset_data stm32mp25_reset_data =3D {
> +       .reset_lines    =3D stm32mp25_reset_cfg,
> +       .nr_lines       =3D ARRAY_SIZE(stm32mp25_reset_cfg),
> +};
> +
> +static struct stm32_rcc_match_data stm32mp25_data =3D {

const

> +       .tab_clocks     =3D stm32mp25_clock_cfg,
> +       .num_clocks     =3D ARRAY_SIZE(stm32mp25_clock_cfg),
> +       .maxbinding     =3D STM32MP25_LAST_CLK,
> +       .clock_data     =3D &stm32mp25_clock_data,
> +       .reset_data     =3D &stm32mp25_reset_data,
> +};
> +
> +static const struct of_device_id stm32mp25_match_data[] =3D {
> +       {
> +               .compatible =3D "st,stm32mp25-rcc",
> +               .data =3D &stm32mp25_data,
> +       },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, stm32mp25_match_data);
> +
> +static int stm32mp25_rcc_init(struct device *dev)

Please inline this function in the one call site.

> +{
> +       void __iomem *base;
> +       int ret;
> +
> +       base =3D of_iomap(dev_of_node(dev), 0);

Use platform device APIs instead of OF specific ones.

> +       if (!base) {
> +               dev_err(dev, "%pOFn: unable to map resource", dev_of_node=
(dev));

Missing newline.

> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       ret =3D stm32_rcc_init(dev, stm32mp25_match_data, base);
> +
> +out:
> +       if (ret) {
> +               if (base)
> +                       iounmap(base);
> +
> +               of_node_put(dev_of_node(dev));

When did we get the node?

> +       }
> +
> +       return ret;
> +}
> +
> +static int get_clock_deps(struct device *dev)
> +{
> +       static const char * const clock_deps_name[] =3D {
> +               "hsi", "hse", "msi", "lsi", "lse",
> +       };
> +       size_t deps_size =3D sizeof(struct clk *) * ARRAY_SIZE(clock_deps=
_name);
> +       struct clk **clk_deps;
> +       int i;
> +
> +       clk_deps =3D devm_kzalloc(dev, deps_size, GFP_KERNEL);
> +       if (!clk_deps)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(clock_deps_name); i++) {
> +               struct clk *clk;
> +
> +               clk =3D of_clk_get_by_name(dev_of_node(dev), clock_deps_n=
ame[i]);
> +
> +               if (IS_ERR(clk)) {
> +                       if (PTR_ERR(clk) !=3D -EINVAL && PTR_ERR(clk) !=
=3D -ENOENT)
> +                               return PTR_ERR(clk);
> +               } else {
> +                       /* Device gets a reference count on the clock */
> +                       clk_deps[i] =3D devm_clk_get(dev, __clk_get_name(=
clk));

Is something using this clk_deps array?

> +                       clk_put(clk);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int stm32mp25_rcc_clocks_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       int ret =3D get_clock_deps(dev);
> +
> +       if (!ret)
> +               ret =3D stm32mp25_rcc_init(dev);
> +
> +       return ret;
> +}
> +

