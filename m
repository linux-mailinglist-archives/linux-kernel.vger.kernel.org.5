Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A607FA061
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjK0NK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjK0Mzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:55:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225D09B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:55:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDE2C433C7;
        Mon, 27 Nov 2023 12:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701089753;
        bh=OkaVj0kQZoxNvjFiy/iUPvm6ml8q1+fcKNVZApGhjcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQ85pDXhBPl1hmX7p0hYZDPsizOxHpZiabGHKL0JlfHoNW26pP7vKVvp7+8DMpX+3
         Qo6IkbllSDAJ4wUv46ysjngZ7ANNwe3pbGR2TpDEF0kXiBKiZ0xaOVjg8RiGuAvyl6
         11ZRlWjATOxoxvVOcvCQAgiqo5bcADjIfHMRRyuf7fPui1KRJGYyhmkUKD7EILilIC
         wIvYisMgRZyEX9TeMOJbmd5/KIl9IOmsYw0xK8VqdJk6558knv5RGX2cEkv1FvwnU2
         UAOU1/Syv719i0iCEolxZQplcQaO6NewUtiQ4c38MPRu7UVvcPj7/eY1JglM9xKVQY
         wJ9iBVMZmGZfw==
Date:   Mon, 27 Nov 2023 18:25:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shengyang Chen <shengyang.chen@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, minda.chen@starfivetech.com,
        changhuang.liang@starfivetech.com, rogerq@kernel.org,
        geert+renesas@glider.be, keith.zhao@starfivetech.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] phy: starfive: Add mipi dphy tx support
Message-ID: <ZWSR1DSfGPCquWXT@matsya>
References: <20231117130421.79261-1-shengyang.chen@starfivetech.com>
 <20231117130421.79261-3-shengyang.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117130421.79261-3-shengyang.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-11-23, 21:04, Shengyang Chen wrote:
> Add mipi dphy tx support for the StarFive JH7110 SoC.
> It is used to transfer DSI data.

How different is this from RX driver? Cant the support be added in the
TX driver with a new compatible?

> 
> Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>
> ---
>  MAINTAINERS                               |   7 +
>  drivers/phy/starfive/Kconfig              |  10 +
>  drivers/phy/starfive/Makefile             |   1 +
>  drivers/phy/starfive/phy-jh7110-dphy-tx.c | 542 ++++++++++++++++++++++
>  4 files changed, 560 insertions(+)
>  create mode 100644 drivers/phy/starfive/phy-jh7110-dphy-tx.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cfb533ec89e8..255c577afa49 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20677,6 +20677,13 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
>  F:	drivers/phy/starfive/phy-jh7110-dphy-rx.c
>  
> +STARFIVE JH7110 DPHY TX DRIVER
> +M:	Keith Zhao <keith.zhao@starfivetech.com>
> +M:	Shengyang Chen <shengyang.chen@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-tx.yaml
> +F:	drivers/phy/starfive/phy-jh7110-dphy-tx.c
> +
>  STARFIVE JH7110 MMC/SD/SDIO DRIVER
>  M:	William Qiu <william.qiu@starfivetech.com>
>  S:	Supported
> diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
> index 9508e2143011..d0cdd7cb4a13 100644
> --- a/drivers/phy/starfive/Kconfig
> +++ b/drivers/phy/starfive/Kconfig
> @@ -15,6 +15,16 @@ config PHY_STARFIVE_JH7110_DPHY_RX
>  	  system. If M is selected, the module will be called
>  	  phy-jh7110-dphy-rx.ko.
>  
> +config PHY_STARFIVE_JH7110_DPHY_TX
> +	tristate "StarFive JH7110 D-PHY TX Support"
> +	depends on HAS_IOMEM
> +	select GENERIC_PHY
> +	select GENERIC_PHY_MIPI_DPHY
> +	help
> +	  Choose this option if you have a StarFive D-PHY TX in your
> +	  system. If M is selected, the module will be called
> +	  phy-jh7110-dphy-tx.ko.
> +
>  config PHY_STARFIVE_JH7110_PCIE
>  	tristate "Starfive JH7110 PCIE 2.0/USB 3.0 PHY support"
>  	depends on HAS_IOMEM
> diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
> index b391018b7c47..eedc4a6fec15 100644
> --- a/drivers/phy/starfive/Makefile
> +++ b/drivers/phy/starfive/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PHY_STARFIVE_JH7110_DPHY_RX)	+= phy-jh7110-dphy-rx.o
> +obj-$(CONFIG_PHY_STARFIVE_JH7110_DPHY_TX)	+= phy-jh7110-dphy-tx.o
>  obj-$(CONFIG_PHY_STARFIVE_JH7110_PCIE)		+= phy-jh7110-pcie.o
>  obj-$(CONFIG_PHY_STARFIVE_JH7110_USB)		+= phy-jh7110-usb.o
> diff --git a/drivers/phy/starfive/phy-jh7110-dphy-tx.c b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
> new file mode 100644
> index 000000000000..69aa172563e4
> --- /dev/null
> +++ b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
> @@ -0,0 +1,542 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * DPHY TX driver for the StarFive JH7110 SoC
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + * Author: Keith Zhao <keith.zhao@starfivetech.com>
> + * Author: Shengyang Chen <shengyang.chen@starfivetech.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/phy/phy-mipi-dphy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +
> +#define STF_DPHY_APBIFSAIF_SYSCFG(x)			(x)
> +
> +#define  STF_DPHY_AON_POWER_READY_N_SHIFT		0x0U
> +#define  STF_DPHY_AON_POWER_READY_N_MASK		BIT(0)
> +#define  STF_DPHY_CFG_L0_SWAP_SEL_SHIFT			0xCU
> +#define  STF_DPHY_CFG_L0_SWAP_SEL_MASK			GENMASK(14, 12)
> +#define  STF_DPHY_CFG_L1_SWAP_SEL_SHIFT			0xFU
> +#define  STF_DPHY_CFG_L1_SWAP_SEL_MASK			GENMASK(17, 15)
> +#define  STF_DPHY_CFG_L2_SWAP_SEL_SHIFT			0x12U
> +#define  STF_DPHY_CFG_L2_SWAP_SEL_MASK			GENMASK(20, 18)
> +#define  STF_DPHY_CFG_L3_SWAP_SEL_SHIFT			0x15U
> +#define  STF_DPHY_CFG_L3_SWAP_SEL_MASK			GENMASK(23, 21)
> +#define  STF_DPHY_CFG_L4_SWAP_SEL_SHIFT			0x18U
> +#define  STF_DPHY_CFG_L4_SWAP_SEL_MASK			GENMASK(26, 24)
> +#define  STF_DPHY_RGS_CDTX_PLL_UNLOCK_SHIFT		0x12U
> +#define  STF_DPHY_RGS_CDTX_PLL_UNLOCK_MASK		BIT(18)
> +#define  STF_DPHY_RG_CDTX_L0N_HSTX_RES_SHIFT		0x13U
> +#define  STF_DPHY_RG_CDTX_L0N_HSTX_RES_MASK		GENMASK(23, 19)
> +#define  STF_DPHY_RG_CDTX_L0P_HSTX_RES_SHIFT		0x18U
> +#define  STF_DPHY_RG_CDTX_L0P_HSTX_RES_MASK		GENMASK(28, 24)
> +
> +#define  STF_DPHY_RG_CDTX_L1P_HSTX_RES_SHIFT		0x5U
> +#define  STF_DPHY_RG_CDTX_L1P_HSTX_RES_MASK		GENMASK(9, 5)
> +#define  STF_DPHY_RG_CDTX_L2N_HSTX_RES_SHIFT		0xAU
> +#define  STF_DPHY_RG_CDTX_L2N_HSTX_RES_MASK		GENMASK(14, 10)
> +#define  STF_DPHY_RG_CDTX_L2P_HSTX_RES_SHIFT		0xFU
> +#define  STF_DPHY_RG_CDTX_L2P_HSTX_RES_MASK		GENMASK(19, 15)
> +#define  STF_DPHY_RG_CDTX_L3N_HSTX_RES_SHIFT		0x14U
> +#define  STF_DPHY_RG_CDTX_L3N_HSTX_RES_MASK		GENMASK(24, 20)
> +#define  STF_DPHY_RG_CDTX_L3P_HSTX_RES_SHIFT		0x19U
> +#define  STF_DPHY_RG_CDTX_L3P_HSTX_RES_MASK		GENMASK(29, 25)
> +
> +#define  STF_DPHY_RG_CDTX_L4N_HSTX_RES_SHIFT		0x0U
> +#define  STF_DPHY_RG_CDTX_L4N_HSTX_RES_MASK		GENMASK(4, 0)
> +#define  STF_DPHY_RG_CDTX_L4P_HSTX_RES_SHIFT		0x5U
> +#define  STF_DPHY_RG_CDTX_L4P_HSTX_RES_MASK		GENMASK(9, 5)
> +#define  STF_DPHY_RG_CDTX_PLL_FBK_FRA_SHIFT		0x0U
> +#define  STF_DPHY_RG_CDTX_PLL_FBK_FRA_MASK		GENMASK(23, 0)
> +
> +#define  STF_DPHY_RG_CDTX_PLL_FBK_INT_SHIFT		0x0U
> +#define  STF_DPHY_RG_CDTX_PLL_FBK_INT_MASK		GENMASK(8, 0)
> +#define  STF_DPHY_RG_CDTX_PLL_FM_EN_SHIFT		0x9U
> +#define  STF_DPHY_RG_CDTX_PLL_FM_EN_MASK		BIT(9)
> +#define  STF_DPHY_RG_CDTX_PLL_LDO_STB_X2_EN_SHIFT	0xAU
> +#define  STF_DPHY_RG_CDTX_PLL_LDO_STB_X2_EN_MASK	BIT(10)
> +#define  STF_DPHY_RG_CDTX_PLL_PRE_DIV_SHIFT		0xBU
> +#define  STF_DPHY_RG_CDTX_PLL_PRE_DIV_MASK		GENMASK(12, 11)
> +
> +#define  STF_DPHY_RG_CDTX_PLL_SSC_EN_SHIFT		0x12U
> +#define  STF_DPHY_RG_CDTX_PLL_SSC_EN_MASK		0x40000U
> +
> +#define  STF_DPHY_RG_CLANE_HS_CLK_POST_TIME_SHIFT	0x0U
> +#define  STF_DPHY_RG_CLANE_HS_CLK_POST_TIME_MASK	GENMASK(7, 0)
> +#define  STF_DPHY_RG_CLANE_HS_CLK_PRE_TIME_SHIFT	0x8U
> +#define  STF_DPHY_RG_CLANE_HS_CLK_PRE_TIME_MASK		GENMASK(15, 8)
> +#define  STF_DPHY_RG_CLANE_HS_PRE_TIME_SHIFT		0x10U
> +#define  STF_DPHY_RG_CLANE_HS_PRE_TIME_MASK		GENMASK(23, 16)
> +#define  STF_DPHY_RG_CLANE_HS_TRAIL_TIME_SHIFT		0x18U
> +#define  STF_DPHY_RG_CLANE_HS_TRAIL_TIME_MASK		GENMASK(31, 24)
> +
> +#define  STF_DPHY_RG_CLANE_HS_ZERO_TIME_SHIFT		0x0U
> +#define  STF_DPHY_RG_CLANE_HS_ZERO_TIME_MASK		GENMASK(7, 0)
> +#define  STF_DPHY_RG_DLANE_HS_PRE_TIME_SHIFT		0x8U
> +#define  STF_DPHY_RG_DLANE_HS_PRE_TIME_MASK		GENMASK(15, 8)
> +#define  STF_DPHY_RG_DLANE_HS_TRAIL_TIME_SHIFT		0x10U
> +#define  STF_DPHY_RG_DLANE_HS_TRAIL_TIME_MASK		GENMASK(23, 16)
> +#define  STF_DPHY_RG_DLANE_HS_ZERO_TIME_SHIFT		0x18U
> +#define  STF_DPHY_RG_DLANE_HS_ZERO_TIME_MASK		GENMASK(31, 24)
> +
> +#define  STF_DPHY_RG_EXTD_CYCLE_SEL_SHIFT		0x0U
> +#define  STF_DPHY_RG_EXTD_CYCLE_SEL_MASK		GENMASK(2, 0)
> +#define  STF_DPHY_SCFG_C_HS_PRE_ZERO_TIME_SHIFT		0x0U
> +#define  STF_DPHY_SCFG_C_HS_PRE_ZERO_TIME_MASK		GENMASK(31, 0)
> +
> +#define  STF_DPHY_SCFG_DSI_TXREADY_ESC_SEL_SHIFT	0x1U
> +#define  STF_DPHY_SCFG_DSI_TXREADY_ESC_SEL_MASK		GENMASK(2, 1)
> +#define  STF_DPHY_SCFG_PPI_C_READY_SEL_SHIFT		0x3U
> +#define  STF_DPHY_SCFG_PPI_C_READY_SEL_MASK		GENMASK(4, 3)
> +
> +#define  STF_DPHY_REFCLK_IN_SEL_SHIFT			0x1AU
> +#define  STF_DPHY_REFCLK_IN_SEL_MASK			GENMASK(28, 26)
> +#define  STF_DPHY_RESETB_SHIFT				0x1DU
> +#define  STF_DPHY_RESETB_MASK				BIT(29)
> +
> +#define STF_DPHY_REFCLK_12M				1
> +#define STF_DPHY_BITRATE_ALIGN				10000000
> +
> +#define STF_MAP_LANES_NUM				5
> +
> +struct m31_dphy_config {
> +	int ref_clk;
> +	unsigned long bitrate;
> +	u32 pll_prev_div;
> +	u32 pll_fbk_int;
> +	u32 pll_fbk_fra;
> +	u32 extd_cycle_sel;
> +	u32 dlane_hs_pre_time;
> +	u32 dlane_hs_zero_time;
> +	u32 dlane_hs_trail_time;
> +	u32 clane_hs_pre_time;
> +	u32 clane_hs_zero_time;
> +	u32 clane_hs_trail_time;
> +	u32 clane_hs_clk_pre_time;
> +	u32 clane_hs_clk_post_time;
> +};
> +
> +static const struct m31_dphy_config m31_dphy_configs[] = {
> +	{12000000, 490000000, 0x0, 0xa3, 0x55 << 16 | 0x55 << 8 | 0x55,
> +	 0x2, 0xc, 0x1d, 0x14, 0x8, 0x42, 0x12, 0x3, 0x28},
> +	{12000000, 680000000, 0x0, 0x71, 0x55 << 16 | 0x55 << 8 | 0x55,
> +	 0x1, 0x8, 0x13, 0xe, 0x5, 0x2e, 0xd, 0x1, 0x16},
> +	{12000000, 750000000, 0x0, 0x7d, 0x0 << 16 | 0x0 << 8 | 0x0,
> +	 0x1, 0x8, 0x16, 0xf, 0x6, 0x32, 0xe, 0x1, 0x17},
> +	{12000000, 900000000, 0x0, 0x96, 0x0 << 16 | 0x0 << 8 | 0x0,
> +	 0x1, 0xa, 0x19, 0x12, 0x8, 0x3c, 0x10, 0x1, 0x19},
> +};
> +
> +struct stf_dphy_info {
> +	/**
> +	 * @maps:
> +	 *
> +	 * Physical lanes and logic lanes mapping table.
> +	 *
> +	 * The default order is:
> +	 * [data lane 0, data lane 1, data lane 2, date lane 3, clk lane]
> +	 */
> +	u8 maps[STF_MAP_LANES_NUM];
> +};
> +
> +struct stf_dphy {
> +	struct device *dev;
> +	void __iomem *topsys;
> +	struct clk *txesc_clk;
> +	struct reset_control *sys_rst;
> +	struct reset_control *txbytehs_rst;
> +
> +	struct phy_configure_opts_mipi_dphy config;
> +
> +	struct regulator *mipitx_1p8;
> +	struct regulator *mipitx_0p9;
> +
> +	struct phy *phy;
> +	const struct stf_dphy_info *info;
> +};
> +
> +static inline u32 stf_dphy_get_reg(void *io_addr, u32 addr, u32 shift, u32 mask)
> +{
> +	u32 tmp;
> +
> +	tmp = readl(io_addr);
> +	tmp = (tmp & mask) >> shift;
> +	return tmp;
> +}
> +
> +static inline void stf_dphy_set_reg(void *io_addr, u32 addr, u32 data, u32 shift, u32 mask)
> +{
> +	u32 tmp;
> +
> +	tmp = readl(io_addr + addr);
> +	tmp &= ~mask;
> +	tmp |= (data << shift) & mask;
> +	writel(tmp, (io_addr + addr));
> +}
> +
> +static int is_pll_locked(struct stf_dphy *dphy)
> +{
> +	int tmp = stf_dphy_get_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(8),
> +				  STF_DPHY_RGS_CDTX_PLL_UNLOCK_SHIFT,
> +				  STF_DPHY_RGS_CDTX_PLL_UNLOCK_MASK);
> +	return !tmp;
> +}
> +
> +static void stf_dphy_hw_reset(struct stf_dphy *dphy, int assert)
> +{
> +	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(100),
> +			 !assert, STF_DPHY_RESETB_SHIFT, STF_DPHY_RESETB_MASK);
> +
> +	if (!assert) {
> +		/*the lock-in time of pll of M31 is 20us-50ms*/
> +		while ((!is_pll_locked(dphy)) && msecs_to_jiffies(50))
> +			;
> +		dev_err(dphy->dev, "MIPI dphy-tx # PLL Locked\n");
> +	}
> +}
> +
> +static int stf_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> +{
> +	struct stf_dphy *dphy;
> +	u32 bitrate;
> +	unsigned long alignment;
> +	int i;
> +	const struct m31_dphy_config *p;
> +	const u32 STF_DPHY_AON_POWER_READY_N_active = 0;
> +	const struct stf_dphy_info *info;
> +
> +	dphy = phy_get_drvdata(phy);
> +	info = dphy->info;
> +	bitrate = opts->mipi_dphy.hs_clk_rate;
> +
> +	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(8), 0x10,
> +			 STF_DPHY_RG_CDTX_L0N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L0N_HSTX_RES_MASK);
> +	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
> +			 STF_DPHY_RG_CDTX_L0N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L0N_HSTX_RES_MASK);
> +	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
> +			 STF_DPHY_RG_CDTX_L2N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L2N_HSTX_RES_MASK);
> +	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
> +			 STF_DPHY_RG_CDTX_L3N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L3N_HSTX_RES_MASK);
> +	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(16), 0x10,
> +			 STF_DPHY_RG_CDTX_L4N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L4N_HSTX_RES_MASK);
> +	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(8), 0x10,
> +			 STF_DPHY_RG_CDTX_L0P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L0P_HSTX_RES_MASK);
> +	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
> +			 STF_DPHY_RG_CDTX_L1P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L1P_HSTX_RES_MASK);
> +	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
> +			 STF_DPHY_RG_CDTX_L2P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L2P_HSTX_RES_MASK);
> +	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
> +			 STF_DPHY_RG_CDTX_L3P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L3P_HSTX_RES_MASK);
> +	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(16), 0x10,
> +			 STF_DPHY_RG_CDTX_L4P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L4P_HSTX_RES_MASK);
> +
> +	alignment = STF_DPHY_BITRATE_ALIGN;
> +	if (bitrate % alignment)
> +		bitrate += alignment - (bitrate % alignment);
> +
> +	p = m31_dphy_configs;
> +	for (i = 0; i < ARRAY_SIZE(m31_dphy_configs); i++, p++) {
> +		if (p->bitrate == bitrate) {
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(100),
> +					 STF_DPHY_REFCLK_12M, STF_DPHY_REFCLK_IN_SEL_SHIFT,
> +					 STF_DPHY_REFCLK_IN_SEL_MASK);
> +
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0),
> +					 STF_DPHY_AON_POWER_READY_N_active,
> +					 STF_DPHY_AON_POWER_READY_N_SHIFT,
> +					 STF_DPHY_AON_POWER_READY_N_MASK);
> +
> +			/*Lane setting*/
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[0],
> +					 STF_DPHY_CFG_L0_SWAP_SEL_SHIFT,
> +					 STF_DPHY_CFG_L0_SWAP_SEL_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[1],
> +					 STF_DPHY_CFG_L1_SWAP_SEL_SHIFT,
> +					 STF_DPHY_CFG_L1_SWAP_SEL_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[2],
> +					 STF_DPHY_CFG_L2_SWAP_SEL_SHIFT,
> +					 STF_DPHY_CFG_L2_SWAP_SEL_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[3],
> +					 STF_DPHY_CFG_L3_SWAP_SEL_SHIFT,
> +					 STF_DPHY_CFG_L3_SWAP_SEL_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[4],
> +					 STF_DPHY_CFG_L4_SWAP_SEL_SHIFT,
> +					 STF_DPHY_CFG_L4_SWAP_SEL_MASK);
> +			/*PLL setting*/
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(28), 0x0,
> +					 STF_DPHY_RG_CDTX_PLL_SSC_EN_SHIFT,
> +					 STF_DPHY_RG_CDTX_PLL_SSC_EN_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(24), 0x1,
> +					 STF_DPHY_RG_CDTX_PLL_LDO_STB_X2_EN_SHIFT,
> +					 STF_DPHY_RG_CDTX_PLL_LDO_STB_X2_EN_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(24), 0x1,
> +					 STF_DPHY_RG_CDTX_PLL_FM_EN_SHIFT,
> +					 STF_DPHY_RG_CDTX_PLL_FM_EN_MASK);
> +
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(24),
> +					 p->pll_prev_div, STF_DPHY_RG_CDTX_PLL_PRE_DIV_SHIFT,
> +					 STF_DPHY_RG_CDTX_PLL_PRE_DIV_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(24),
> +					 p->pll_fbk_int, STF_DPHY_RG_CDTX_PLL_FBK_INT_SHIFT,
> +					 STF_DPHY_RG_CDTX_PLL_FBK_INT_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(20),
> +					 p->pll_fbk_fra, STF_DPHY_RG_CDTX_PLL_FBK_FRA_SHIFT,
> +					 STF_DPHY_RG_CDTX_PLL_FBK_FRA_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(40),
> +					 p->extd_cycle_sel, STF_DPHY_RG_EXTD_CYCLE_SEL_SHIFT,
> +					 STF_DPHY_RG_EXTD_CYCLE_SEL_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
> +					 p->dlane_hs_pre_time,
> +					 STF_DPHY_RG_DLANE_HS_PRE_TIME_SHIFT,
> +					 STF_DPHY_RG_DLANE_HS_PRE_TIME_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
> +					 p->dlane_hs_pre_time,
> +					 STF_DPHY_RG_DLANE_HS_PRE_TIME_SHIFT,
> +					 STF_DPHY_RG_DLANE_HS_PRE_TIME_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
> +					 p->dlane_hs_zero_time,
> +					 STF_DPHY_RG_DLANE_HS_ZERO_TIME_SHIFT,
> +					 STF_DPHY_RG_DLANE_HS_ZERO_TIME_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
> +					 p->dlane_hs_trail_time,
> +					 STF_DPHY_RG_DLANE_HS_TRAIL_TIME_SHIFT,
> +					 STF_DPHY_RG_DLANE_HS_TRAIL_TIME_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(32),
> +					 p->clane_hs_pre_time,
> +					 STF_DPHY_RG_CLANE_HS_PRE_TIME_SHIFT,
> +					 STF_DPHY_RG_CLANE_HS_PRE_TIME_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
> +					 p->clane_hs_zero_time,
> +					 STF_DPHY_RG_CLANE_HS_ZERO_TIME_SHIFT,
> +					 STF_DPHY_RG_CLANE_HS_ZERO_TIME_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(32),
> +					 p->clane_hs_trail_time,
> +					 STF_DPHY_RG_CLANE_HS_TRAIL_TIME_SHIFT,
> +					 STF_DPHY_RG_CLANE_HS_TRAIL_TIME_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(32),
> +					 p->clane_hs_clk_pre_time,
> +					 STF_DPHY_RG_CLANE_HS_CLK_PRE_TIME_SHIFT,
> +					 STF_DPHY_RG_CLANE_HS_CLK_PRE_TIME_MASK);
> +			stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(32),
> +					 p->clane_hs_clk_post_time,
> +					 STF_DPHY_RG_CLANE_HS_CLK_POST_TIME_SHIFT,
> +					 STF_DPHY_RG_CLANE_HS_CLK_POST_TIME_MASK);
> +
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int stf_dphy_init(struct phy *phy)
> +{
> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
> +	int ret;
> +
> +	stf_dphy_hw_reset(dphy, 0);
> +	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(48), 0,
> +			 STF_DPHY_SCFG_PPI_C_READY_SEL_SHIFT, STF_DPHY_SCFG_PPI_C_READY_SEL_MASK);
> +	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(48), 0,
> +			 STF_DPHY_SCFG_DSI_TXREADY_ESC_SEL_SHIFT,
> +			 STF_DPHY_SCFG_DSI_TXREADY_ESC_SEL_MASK);
> +	stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(44), 0x30,
> +			 STF_DPHY_SCFG_C_HS_PRE_ZERO_TIME_SHIFT,
> +			 STF_DPHY_SCFG_C_HS_PRE_ZERO_TIME_MASK);
> +
> +	ret = clk_prepare_enable(dphy->txesc_clk);
> +	if (ret) {
> +		dev_err(dphy->dev, "Failed to prepare/enable txesc_clk\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_deassert(dphy->sys_rst);
> +	if (ret) {
> +		dev_err(dphy->dev, "Failed to deassert sys_rst\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_deassert(dphy->txbytehs_rst);
> +	if (ret < 0) {
> +		dev_err(dphy->dev, "Failed to deassert txbytehs_rst\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int stf_dphy_exit(struct phy *phy)
> +{
> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = reset_control_assert(dphy->txbytehs_rst);
> +	if (ret < 0) {
> +		dev_err(dphy->dev, "Failed to assert txbytehs_rst\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_assert(dphy->sys_rst);
> +	if (ret) {
> +		dev_err(dphy->dev, "Failed to assert sys_rst\n");
> +		return ret;
> +	}
> +
> +	clk_disable_unprepare(dphy->txesc_clk);
> +
> +	stf_dphy_hw_reset(dphy, 1);
> +
> +	return 0;
> +}
> +
> +static int stf_dphy_power_on(struct phy *phy)
> +{
> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(dphy->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regulator_enable(dphy->mipitx_0p9);
> +	if (ret) {
> +		dev_err(dphy->dev, "Cannot enable mipitx_0p9 regulator\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int stf_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
> +			     union phy_configure_opts *opts)
> +{
> +	if (mode != PHY_MODE_MIPI_DPHY)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int stf_dphy_power_off(struct phy *phy)
> +{
> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
> +
> +	regulator_disable(dphy->mipitx_0p9);
> +
> +	pm_runtime_put_sync(dphy->dev);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops stf_dphy_ops = {
> +	.power_on	= stf_dphy_power_on,
> +	.power_off	= stf_dphy_power_off,
> +	.init		= stf_dphy_init,
> +	.exit		= stf_dphy_exit,
> +	.configure	= stf_dphy_configure,
> +	.validate	= stf_dphy_validate,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int stf_dphy_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy_provider;
> +	struct stf_dphy *dphy;
> +	int ret;
> +
> +	dphy = devm_kzalloc(&pdev->dev, sizeof(*dphy), GFP_KERNEL);
> +	if (!dphy)
> +		return -ENOMEM;
> +
> +	dphy->info = of_device_get_match_data(&pdev->dev);
> +
> +	dphy->dev = &pdev->dev;
> +	dev_set_drvdata(&pdev->dev, dphy);
> +
> +	dphy->topsys = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dphy->topsys)) {
> +		ret = PTR_ERR(dphy->topsys);
> +		return ret;
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
> +
> +	dphy->mipitx_0p9 = devm_regulator_get(&pdev->dev, "mipi_0p9");
> +	if (IS_ERR(dphy->mipitx_0p9)) {
> +		ret = PTR_ERR(dphy->mipitx_0p9);
> +		return ret;
> +	}
> +
> +	dphy->txesc_clk = devm_clk_get(&pdev->dev, "dphy_txesc");
> +	if (IS_ERR(dphy->txesc_clk)) {
> +		ret = PTR_ERR(dphy->txesc_clk);
> +		dev_err(&pdev->dev, "txesc_clk get error\n");
> +		return ret;
> +	}
> +
> +	dphy->sys_rst = reset_control_get_exclusive(&pdev->dev, "dphy_sys");
> +	if (IS_ERR(dphy->sys_rst)) {
> +		ret = PTR_ERR(dphy->sys_rst);
> +		dev_err(&pdev->dev, "sys_rst get error\n");
> +		return ret;
> +	}
> +
> +	dphy->txbytehs_rst = reset_control_get_exclusive(&pdev->dev, "dsi_txbytehs");
> +	if (IS_ERR(dphy->txbytehs_rst)) {
> +		dev_err(&pdev->dev, "Failed to get txbytehs_rst\n");
> +		return PTR_ERR(dphy->txbytehs_rst);
> +	}
> +
> +	dphy->phy = devm_phy_create(&pdev->dev, NULL, &stf_dphy_ops);
> +	if (IS_ERR(dphy->phy)) {
> +		ret = PTR_ERR(dphy->phy);
> +		dev_err(&pdev->dev, "Failed to create phy\n");
> +		return ret;
> +	}
> +	phy_set_drvdata(dphy->phy, dphy);
> +
> +	phy_provider = devm_of_phy_provider_register(&pdev->dev, of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider)) {
> +		ret = PTR_ERR(phy_provider);
> +		dev_err(&pdev->dev, "Failed to create phy\n");
> +		return ret;
> +	}
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct stf_dphy_info starfive_dphy_info = {
> +	.maps = {0, 1, 2, 3, 4},
> +};
> +
> +static const struct of_device_id stf_dphy_dt_ids[] = {
> +	{
> +		.compatible = "starfive,jh7110-dphy-tx",
> +		.data = &starfive_dphy_info,
> +	},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, stf_dphy_dt_ids);
> +
> +static struct platform_driver stf_dphy_driver = {
> +	.driver = {
> +		.name	= "starfive-dphy-tx",
> +		.of_match_table = stf_dphy_dt_ids,
> +	},
> +	.probe = stf_dphy_probe,
> +};
> +module_platform_driver(stf_dphy_driver);
> +
> +MODULE_AUTHOR("Keith Zhao <keith.zhao@starfivetech.com>");
> +MODULE_AUTHOR("Shengyang Chen <shengyang.chen@starfivetech.com>");
> +MODULE_DESCRIPTION("StarFive JH7110 DPHY TX driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.17.1

-- 
~Vinod
