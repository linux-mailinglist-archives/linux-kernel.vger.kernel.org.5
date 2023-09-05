Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7337930F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244146AbjIEVg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjIEVgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:36:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891BF133;
        Tue,  5 Sep 2023 14:36:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBD4C433C9;
        Tue,  5 Sep 2023 21:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693949778;
        bh=OmESOkO4hxqmbt0xXSaMT+WIW0FV6ajHn0D67qa11GU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tNaYeS+o6mV+UJWyI/cZfyNVjSzTHlKuqdz4fLpvurNISSA0dUXSWDeqEhQp0fTPs
         NcyCcYDKTyiSP406in295FovCbqmiE+xhTRznEM+U2fE/99YG8bGtFyy6rQy/jhyfF
         6GkD6Ai+2ZqY2SZN2s+poFZ0NAoy6jCDQWd4I4nBFkg6ZiI5GH/Xq/aJHHkOKb1gPw
         keJYkvsz1fMRuNniBrcxfOequ3RMgZkFD2hzdv+fiUbkpb+oMzmXapOcY/73nYAI8Q
         J6yTPLo4cNVUKaILxpYSaP4xSjRRF/6xNXA9HYcvcMnQqje+OTipSqNz2K24pqtNOF
         pfJ7vEQqFL06Q==
Message-ID: <27ae3297ad161fd67706db70b402db04.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230901091823.30242-5-quic_luoj@quicinc.com>
References: <20230901091823.30242-1-quic_luoj@quicinc.com> <20230901091823.30242-5-quic_luoj@quicinc.com>
Subject: Re: [PATCH v6 4/4] clk: qcom: add clock controller driver for qca8386/qca8084
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
To:     Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, catalin.marinas@arm.com, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, will@kernel.org
Date:   Tue, 05 Sep 2023 14:36:15 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Luo Jie (2023-09-01 02:18:23)
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 263e55d75e3f..785cb6eb514f 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -195,6 +195,14 @@ config IPQ_GCC_9574
>           i2c, USB, SD/eMMC, etc. Select this for the root clock
>           of ipq9574.
> =20
> +config IPQ_NSSCC_QCA8K
> +       tristate "QCA8K(QCA8386 or QCA8084) NSS Clock Controller"

This needs to be limited by a depends.

	depends on MDIO_BUS || COMPILE_TEST

perhaps?

> +       help
> +         Support for NSS(Network SubSystem) clock controller on
> +         qca8386/qca8084 chip.
> +         Say Y or M if you want to use network features of switch or
> +         PHY device. Select this for the root clock of qca8k.
> +
>  config MSM_GCC_8660
>         tristate "MSM8660 Global Clock Controller"
>         depends on ARM || COMPILE_TEST
> diff --git a/drivers/clk/qcom/nsscc-qca8k.c b/drivers/clk/qcom/nsscc-qca8=
k.c
> new file mode 100644
> index 000000000000..f9312735daf3
> --- /dev/null
> +++ b/drivers/clk/qcom/nsscc-qca8k.c
> @@ -0,0 +1,2179 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reser=
ved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>

Is platform_device include used?

> +#include <linux/regmap.h>
> +#include <linux/phy.h>

Is the phy include used? Where is the mdio.h include?

> +
> +#include <dt-bindings/clock/qcom,qca8k-nsscc.h>
> +#include <dt-bindings/reset/qcom,qca8k-nsscc.h>
> +
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
[...]
> +
> +static const struct freq_tbl ftbl_nss_cc_mac5_rx_clk_src[] =3D {
> +       F(50000000, P_XO, 1, 0, 0),
> +       F(125000000, P_UNIPHY0_RX, 1, 0, 0),
> +       F(125000000, P_UNIPHY0_TX, 1, 0, 0),
> +       F(312500000, P_UNIPHY0_RX, 1, 0, 0),
> +       F(312500000, P_UNIPHY0_TX, 1, 0, 0),

This frequency table looks like the parent should change rate...

> +       { }
> +};
> +
> +static struct clk_rcg2 nss_cc_mac5_rx_clk_src =3D {
> +       .cmd_rcgr =3D 0x154,
> +       .freq_tbl =3D ftbl_nss_cc_mac5_rx_clk_src,
> +       .hid_width =3D 5,
> +       .parent_map =3D nss_cc_uniphy0_rx_tx_map,
> +       .clkr.hw.init =3D &(const struct clk_init_data) {
> +               .name =3D "nss_cc_mac5_rx_clk_src",
> +               .parent_data =3D nss_cc_uniphy0_rx_tx_data,
> +               .num_parents =3D ARRAY_SIZE(nss_cc_uniphy0_rx_tx_data),
> +               .ops =3D &clk_rcg2_ops,

... but this doesn't have any CLK_SET_RATE_PARENT flag set. How does it
work?

> +       },
> +};
> +
> +static struct clk_regmap_div nss_cc_mac5_rx_div_clk_src =3D {
> +       .reg =3D 0x15c,
> +       .shift =3D 0,
> +       .width =3D 4,
> +       .clkr =3D {
> +               .hw.init =3D &(const struct clk_init_data) {
> +                       .name =3D "nss_cc_mac5_rx_div_clk_src",
[...]
> +
> +static struct clk_branch nss_cc_mdio_master_ahb_clk =3D {
> +       .halt_reg =3D 0x19c,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x19c,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(const struct clk_init_data) {
> +                       .name =3D "nss_cc_mdio_master_ahb_clk",
> +                       .parent_hws =3D (const struct clk_hw *[]) {
> +                               &nss_cc_ahb_clk_src.clkr.hw,
> +                       },
> +                       .num_parents =3D 1,
> +                       .flags =3D CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,

Why can't we simply enable clks in probe that are critical? The regmap
operations are complicated?

> +                       .ops =3D &clk_branch2_prepare_ops,
> +               },
> +       },
> +};
> +
> +static const struct clk_parent_data nss_cc_xo_data[] =3D {
> +       { .index =3D DT_XO },
> +};
> +
> +static const struct parent_map nss_cc_xo_map[] =3D {
> +       { P_XO, 0 },
> +};
> +
> +static const struct freq_tbl ftbl_nss_cc_sys_clk_src[] =3D {
> +       F(25000000, P_XO, 2, 0, 0),
> +       { }
> +};
[...]
> +
> +static const struct qcom_reset_map nss_cc_qca8k_resets[] =3D {
[...]
> +       [NSS_CC_GEPHY1_ARES] =3D { 0x304, 1 },
> +       [NSS_CC_GEPHY2_ARES] =3D { 0x304, 2 },
> +       [NSS_CC_GEPHY3_ARES] =3D { 0x304, 3 },
> +       [NSS_CC_DSP_ARES] =3D { 0x304, 4 },
> +       [NSS_CC_GLOBAL_ARES] =3D { 0x308, 0 },
> +       [NSS_CC_XPCS_ARES] =3D { 0x30C, 0 },

Lowercase hex please.

> +};
> +
> +/* For each read/write operation of clock register, there are three MDIO=
 frames
> + * sent to the device.
> + *
> + * 1. The high address part[31:8] of register is packaged into the first=
 MDIO frame.
> + * 2. The low address part[7:0] of register is packaged into the second =
MDIO frame
> + *    with the low 16bit data to read/write.
> + * 3. The low address part[7:0] of register is packaged into the last MD=
IO frame
> + *    with the high 16bit data to read/write.
> + *
> + * The clause22 MDIO frame format used by device is as below.
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + * | ST| OP|   ADDR  |   REG   | TA|             DATA              |
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + */
> +static inline void split_addr(u32 regaddr, u16 *r1, u16 *r2, u16 *page)

split_addr() is too generic of a name. Please namespace this function to
something else.

> +{
> +       *r1 =3D regaddr & 0x1c;
> +
> +       regaddr >>=3D 5;
> +       *r2 =3D regaddr & 0x7;
> +
> +       regaddr >>=3D 3;
> +       *page =3D regaddr & 0xffff;

Instead of this can you use FIELD_GET and have some macros for the part
of the address? Something like

#define QCA8K_CLK_REG_MASK		GENMASK(4, 2)
#define QCA8K_CLK_PHY_ADDR_MASK		GENMASK(7, 5)
#define QCA8K_CLK_PAGE_MASK		GENMASK(24, 8)

and then rename 'r1' and 'r2' to something else?

	*reg =3D FIELD_GET(QCA8K_CLK_REG_MASK, regaddr);
	*phy_addr =3D FIELD_GET(QCA8K_CLK_PHY_ADDR_MASK, regaddr) | QCA8K_LOW_ADDR=
_PREFIX;
	*page =3D FIELD_GET(QCA8K_CLK_PAGE_MASK);

> +}
> +
> +int qca8k_mii_read(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u32 =
*val)
> +{
> +       int ret;
> +
> +       ret =3D bus->read(bus, switch_phy_id, reg);

Why can't we use __mdiobus_read()?

> +       if (ret >=3D 0) {
> +               *val =3D ret;
> +               ret =3D bus->read(bus, switch_phy_id, (reg | BIT(1)));

What is BIT(1)? Can it have a #define? What if ret is negative? We
shouldn't treat that as data, right?

> +               *val |=3D ret << 16;
> +       }
> +
> +       if (ret < 0)
> +               dev_err_ratelimited(&bus->dev, "fail to read qca8k mii re=
gister\n");
> +
> +       return ret < 0 ? ret : 0;
> +}
> +
> +void qca8k_mii_write(struct mii_bus *bus, u16 switch_phy_id, u32 reg, u3=
2 val)
> +{
> +       int ret;
> +
> +       ret =3D bus->write(bus, switch_phy_id, reg, lower_16_bits(val));
> +       if (ret >=3D 0)
> +               ret =3D bus->write(bus, switch_phy_id, (reg | BIT(1)), up=
per_16_bits(val));
> +
> +       if (ret < 0)
> +               dev_err_ratelimited(&bus->dev, "fail to write qca8k mii r=
egister\n");
> +}
> +
> +int qca8k_mii_page_set(struct mii_bus *bus, u16 switch_phy_id, u32 reg, =
u16 page)

Regmap core has support for picking pages. Can that be used here?

> +{
> +       int ret;
> +
> +       ret =3D bus->write(bus, switch_phy_id, reg, page);
> +       if (ret < 0)
> +               dev_err_ratelimited(&bus->dev, "fail to set page\n");
> +
> +       return ret;
> +}
> +
> +int qca8k_regmap_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +       struct mii_bus *bus =3D context;
> +       u16 r1, r2, page;
> +       int ret;
> +
> +       reg +=3D QCA8K_CLK_REG_BASE;
> +       split_addr(reg, &r1, &r2, &page);
> +
> +       mutex_lock(&bus->mdio_lock);
> +       ret =3D qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG=
_PAGE_REG, page);
> +       if (ret < 0)
> +               goto qca8k_read_exit;
> +
> +       ret =3D qca8k_mii_read(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
> +
> +qca8k_read_exit:
> +       mutex_unlock(&bus->mdio_lock);
> +       return ret;
> +};
> +
> +int qca8k_regmap_write(void *context, unsigned int reg, unsigned int val)

These wrappers should be static. Please run sparse.

> +{
> +       struct mii_bus *bus =3D context;
> +       u16 r1, r2, page;
> +       int ret;
> +
> +       reg +=3D QCA8K_CLK_REG_BASE;
> +       split_addr(reg, &r1, &r2, &page);
> +
> +       mutex_lock(&bus->mdio_lock);
> +       ret =3D qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG=
_PAGE_REG, page);
> +       if (ret < 0)
> +               goto qca8k_write_exit;
> +
> +       qca8k_mii_write(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
> +
> +qca8k_write_exit:
> +       mutex_unlock(&bus->mdio_lock);
> +       return ret;
> +};
> +
> +int qca8k_regmap_update_bits(void *context, unsigned int reg, unsigned i=
nt mask, unsigned int value)
> +{
> +       struct mii_bus *bus =3D context;
> +       u16 r1, r2, page;
> +       int ret;
> +       u32 val;
> +
> +       reg +=3D QCA8K_CLK_REG_BASE;
> +       split_addr(reg, &r1, &r2, &page);
> +
> +       mutex_lock(&bus->mdio_lock);
> +       ret =3D qca8k_mii_page_set(bus, QCA8K_HIGH_ADDR_PREFIX, QCA8K_CFG=
_PAGE_REG, page);
> +       if (ret < 0)
> +               goto qca8k_update_exit;
> +
> +       ret =3D qca8k_mii_read(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, &val);
> +       if (ret < 0)
> +               goto qca8k_update_exit;
> +
> +       val &=3D ~mask;
> +       val |=3D value;
> +       qca8k_mii_write(bus, QCA8K_LOW_ADDR_PREFIX | r2, r1, val);
> +
> +qca8k_update_exit:
> +       mutex_unlock(&bus->mdio_lock);
> +       return ret;
> +}
> +
> +static const struct regmap_config nss_cc_qca8k_regmap_config =3D {
> +       .reg_bits =3D 12,
> +       .reg_stride =3D 4,
> +       .val_bits =3D 32,
> +       .max_register =3D 0x30C,

Lowercase hex please.

> +       .reg_read =3D qca8k_regmap_read,
> +       .reg_write =3D qca8k_regmap_write,
> +       .reg_update_bits =3D qca8k_regmap_update_bits,
> +       .disable_locking =3D true,
> +       .cache_type =3D REGCACHE_NONE,

Isn't this the default?

> +};
> +
> +static const struct qcom_cc_desc nss_cc_qca8k_desc =3D {
> +       .config =3D &nss_cc_qca8k_regmap_config,
> +       .clks =3D nss_cc_qca8k_clocks,
> +       .num_clks =3D ARRAY_SIZE(nss_cc_qca8k_clocks),
> +       .resets =3D nss_cc_qca8k_resets,
> +       .num_resets =3D ARRAY_SIZE(nss_cc_qca8k_resets),
> +};
> +
> +static int nss_cc_qca8k_probe(struct mdio_device *mdiodev)
> +{
> +       struct regmap *regmap;
> +
> +       regmap =3D devm_regmap_init(&mdiodev->dev, NULL, mdiodev->bus, ns=
s_cc_qca8k_desc.config);

Why can't we use devm_regmap_init_mdio() here? Is it because the device
needs special data marshaling per split_addr()?

> +       if (IS_ERR(regmap))
> +               return dev_err_probe(&mdiodev->dev, PTR_ERR(regmap), "Fai=
led to init regmap\n");
> +
> +       return qcom_cc_really_probe(&mdiodev->dev, &nss_cc_qca8k_desc, re=
gmap);
> +}
> +
