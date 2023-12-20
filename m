Return-Path: <linux-kernel+bounces-7498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03C481A8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3494B21EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9AD4A98A;
	Wed, 20 Dec 2023 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/b1Ax84"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C389649F7F;
	Wed, 20 Dec 2023 22:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A132C433C8;
	Wed, 20 Dec 2023 22:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703110609;
	bh=EYuAHLFAu52JNqdpI9RE6CjobCj8plhFfDlK2x+vg4g=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=s/b1Ax841wkTMn/VP+5NRp8THggUZTYTKKns1K2yPYtcF8+nZ154CP8JzyCW0rbwE
	 qTiFBMa1gjuru+k4XPM/5Qb1Zwwx44HHWTpO2I+mG6lBY7uvx0U3nMVlhuaIIPJXSm
	 aF5Zyj5xgOpJUK+lEIl10FBFsA0N++OyUpakjkYltY2ih5wjPBpR4vHhuXN0HBc2gg
	 NMK/NFN5l+gy5zOSbJl4yb7bY3L/k5viKx4NToRSxuXk5wWJfCjlUbCOt0xJMDj5lI
	 uOf5Olc5gcU5pIE4PpmVoFDg7GelklhmU9diq/hp1CA5NSgOdjkuKW8s4xeUteAe/E
	 XQE9p9Fo/1XTw==
Message-ID: <c98539f99030f174583d7ee36802b4b9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231219130909.265091-2-gabriel.fernandez@foss.st.com>
References: <20231219130909.265091-1-gabriel.fernandez@foss.st.com> <20231219130909.265091-2-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v7 1/2] clk: stm32: introduce clocks for STM32MP257 platform
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Wed, 20 Dec 2023 14:16:46 -0800
User-Agent: alot/0.10

Quoting gabriel.fernandez@foss.st.com (2023-12-19 05:09:08)
> diff --git a/drivers/clk/stm32/clk-stm32mp25.c b/drivers/clk/stm32/clk-st=
m32mp25.c
> new file mode 100644
> index 000000000000..313e022c6142
> --- /dev/null
> +++ b/drivers/clk/stm32/clk-stm32mp25.c
> @@ -0,0 +1,1826 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
> + * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicro=
electronics.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-stm32-core.h"
> +#include "reset-stm32.h"
> +#include "stm32mp25_rcc.h"
> +
> +#include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +#include <dt-bindings/reset/st,stm32mp25-rcc.h>
> +
> +static const struct clk_parent_data adc12_src[] =3D {
> +       { .name =3D "ck_flexgen_46" },

This is a new driver. Don't use .name here. Instead use .index or .hw
and if that can't work then use .fw_name.

> +       { .name =3D "ck_icn_ls_mcu" },
> +};
> +
> +static const struct clk_parent_data adc3_src[] =3D {
> +       { .name =3D "ck_flexgen_47" },
> +       { .name =3D "ck_icn_ls_mcu" },
> +       { .name =3D "ck_flexgen_46" },
> +};
[...]
> +static struct clk_stm32_composite ck_ker_usb3pciephy =3D {
> +       .gate_id =3D GATE_USB3PCIEPHY,
> +       .mux_id =3D MUX_USB3PCIEPHY,
> +       .div_id =3D NO_STM32_DIV,
> +       .hw.init =3D CLK_HW_INIT_PARENTS_DATA("ck_ker_usb3pciephy", usb3p=
ciphy_src,
> +                                           &clk_stm32_composite_ops, 0),
> +};
> +
> +/* USB3 DRD */
> +static struct clk_stm32_gate ck_icn_m_usb3dr =3D {
> +       .gate_id =3D GATE_USB3DR,
> +       .hw.init =3D CLK_HW_INIT("ck_icn_m_usb3dr", "ck_icn_hsl", &clk_st=
m32_gate_ops, 0),
> +};
> +
> +static struct clk_stm32_gate ck_ker_usb2phy2 =3D {
> +       .gate_id =3D GATE_USB3DR,
> +       .hw.init =3D CLK_HW_INIT("ck_ker_usb2phy2", "ck_flexgen_58", &clk=
_stm32_gate_ops, 0),
> +};
> +
> +/* USBTC */
> +static struct clk_stm32_gate ck_icn_p_usbtc =3D {
> +       .gate_id =3D GATE_USBTC,
> +       .hw.init =3D CLK_HW_INIT("ck_icn_p_usbtc", "ck_icn_apb4", &clk_st=
m32_gate_ops, 0),

Please stop using strings to match parents, i.e. don't use CLK_HW_INIT.

> +};
> +
> +static struct clk_stm32_gate ck_ker_usbtc =3D {
> +       .gate_id =3D GATE_USBTC,
> +       .hw.init =3D CLK_HW_INIT("ck_ker_usbtc", "ck_flexgen_35", &clk_st=
m32_gate_ops, 0),
> +};
> +
> +/* VDEC / VENC */
> +static struct clk_stm32_gate ck_icn_p_vdec =3D {
> +       .gate_id =3D GATE_VDEC,
> +       .hw.init =3D CLK_HW_INIT("ck_icn_p_vdec", "ck_icn_apb4", &clk_stm=
32_gate_ops, 0),
> +};
> +
> +static struct clk_stm32_gate ck_icn_p_venc =3D {
> +       .gate_id =3D GATE_VENC,
> +       .hw.init =3D CLK_HW_INIT("ck_icn_p_venc", "ck_icn_apb4", &clk_stm=
32_gate_ops, 0),
> +};
> +
> +/* VREF */
> +static struct clk_stm32_gate ck_icn_p_vref =3D {
> +       .gate_id =3D GATE_VREF,
> +       .hw.init =3D CLK_HW_INIT("ck_icn_p_vref", "ck_icn_apb3", &clk_stm=
32_gate_ops, 0),
> +};
> +
> +/* WWDG */
> +static struct clk_stm32_gate ck_icn_p_wwdg1 =3D {
> +       .gate_id =3D GATE_WWDG1,
> +       .hw.init =3D CLK_HW_INIT("ck_icn_p_wwdg1", "ck_icn_apb3", &clk_st=
m32_gate_ops, 0),
> +};
> +
> +static struct clk_stm32_gate ck_icn_p_wwdg2 =3D {
> +       .gate_id =3D GATE_WWDG2,
> +       .hw.init =3D CLK_HW_INIT("ck_icn_p_wwdg2", "ck_icn_ls_mcu", &clk_=
stm32_gate_ops, 0),
> +};
> +
> +enum security_clk {
> +       SECF_NONE,

What is the use of this single value enum?

> +};
> +
> +static const struct clock_config stm32mp25_clock_cfg[] =3D {
> +       STM32_GATE_CFG(CK_BUS_ETH1,             ck_icn_p_eth1,          S=
ECF_NONE),
> +       STM32_GATE_CFG(CK_BUS_ETH2,             ck_icn_p_eth2,          S=
ECF_NONE),
[....]
> +
> +static const struct of_device_id stm32mp25_match_data[] =3D {
> +       {
> +               .compatible =3D "st,stm32mp25-rcc",
> +               .data =3D &stm32mp25_data,
> +       },

One line please:

 	{ .compatible =3D "st,stm32mp25-rcc", .data =3D &stm32mp25_data, },

> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, stm32mp25_match_data);
> +
> +static int get_clock_deps(struct device *dev)

What is the explanation for this function?

> +{
> +       static const char * const clock_deps_name[] =3D {
> +               "hsi", "hse", "msi", "lsi", "lse",
> +       };
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(clock_deps_name); i++) {
> +               struct clk *clk;
> +
> +               clk =3D of_clk_get_by_name(dev_of_node(dev), clock_deps_n=
ame[i]);
> +               if (IS_ERR(clk))
> +                       return PTR_ERR(clk);
> +
> +               clk_put(clk);
> +       }
> +
> +       return 0;
> +}
> +
> +static int stm32mp25_rcc_clocks_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       void __iomem *base;
> +       int ret;
> +
> +       ret =3D get_clock_deps(dev);
> +       if (ret)
> +               return ret;
> +
> +       base =3D devm_of_iomap(dev, dev->of_node, 0, NULL);

Use platform device APIs.

> +       if (WARN_ON(IS_ERR(base)))
> +               return PTR_ERR(base);
> +
> +       return stm32_rcc_init(dev, stm32mp25_match_data, base);
> +}
> +
> +static int stm32mp25_rcc_clocks_remove(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *child, *np =3D dev_of_node(dev);
> +
> +       for_each_available_child_of_node(np, child)
> +               of_clk_del_provider(child);

Add the providers with devm?

> +
> +       return 0;
> +}
> +
> +static struct platform_driver stm32mp25_rcc_clocks_driver =3D {
> +       .driver =3D {
> +               .name =3D "stm32mp25_rcc",
> +               .of_match_table =3D stm32mp25_match_data,
> +       },
> +       .probe =3D stm32mp25_rcc_clocks_probe,
> +       .remove =3D stm32mp25_rcc_clocks_remove,
> +};
> +
> +static int __init stm32mp25_clocks_init(void)
> +{
> +       return platform_driver_register(&stm32mp25_rcc_clocks_driver);
> +}
> +
> +core_initcall(stm32mp25_clocks_init);

