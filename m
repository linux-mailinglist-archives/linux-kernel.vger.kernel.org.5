Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3BE7788F4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjHKIaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHKIaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:30:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E74272D;
        Fri, 11 Aug 2023 01:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BF4D66B8D;
        Fri, 11 Aug 2023 08:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E58C433C7;
        Fri, 11 Aug 2023 08:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691742607;
        bh=QG1JzZuJTECYwp7R4BRf0CRHWs01VbWDHrTcKyBM/v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cOHf8vY+pmZaHtzr+QdDFrchih2d4CS/UR1EzOJ2aBsdj0ru5n1YsyuqX8m1JvWhx
         28HcHMhRBgL39RfsGIR9GnfwMIbZUsmdDixJ2SfMGIlBM7ca8y01f9NonzL3TdehWV
         5kDT+DFAqoY6DRwGwHibrdEWij5UYemXp79ori9qTiFLoZci75HU6cuVEZRjE1u+fi
         VTljokMRKwjHAplfR3A3C6LQ8wCJFXU1rQVe135Yi3l1R65mElUGbv/51/f7v6Slpn
         xKCbVhZaH21G+QfOxuZebKFu17YFe6zqZK1xDhFRUOuwvGl9WaDDITAObT+DRgOovE
         yKr9+YQSJWcJQ==
Date:   Fri, 11 Aug 2023 09:30:05 +0100
From:   Vinod Koul <vkoul@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        arnd@arndb.de, geert+renesas@glider.be, nfraprado@collabora.com,
        rafal@milecki.pl, peng.fan@nxp.com, quic_srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/5] phy: qcom-m31: Introduce qcom,m31 USB phy driver
Message-ID: <ZNXxja5HvVOtgliL@matsya>
References: <cover.1691660905.git.quic_varada@quicinc.com>
 <b17b55b2ff2277bb9bfa99acdb2f98ed420dfb6e.1691660905.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b17b55b2ff2277bb9bfa99acdb2f98ed420dfb6e.1691660905.git.quic_varada@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-08-23, 15:26, Varadarajan Narayanan wrote:
> Add the M31 USB2 phy driver.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v6:
> 	Kconfig:Add COMPILE_TEST and remove USB_GADGET from 'depends'
> 		Change 'selects' USB_PHY -> GENERIC_PHY
> 	Driver:	Use correct headers
> 		const int -> unsigned int for 'nregs' in private data
> 		Use generic names for clk, phy in m31 phy structure
> 		Init register details directly instead of using macro
> 		Use dev_err_probe in the error paths of driver probe
> v5:
> 	Kconfig and Makefile:- place snippet according to sorted order
> 	Use generic phy instead of usb-phy
> 	Use ARRAY_SIZE for reg init instead of blank last entry
> 	Fix copyright year
> 
> v4:
> 	Remove unused enum
> 	Error handling for devm_clk_get
> v1:
> 	Combine driver, makefile and kconfig into 1 patch
> 	Remove 'qscratch' region and its usage. The controller driver takes care
> 	of those settings
> 	Use compatible/data to handle ipq5332 init
> 	Drop the default case
> 	Get resources by index instead of name as there is only one resource
> 	Add clock
> 	Fix review comments in the driver
> ---
>  drivers/phy/qualcomm/Kconfig        |  11 ++
>  drivers/phy/qualcomm/Makefile       |   1 +
>  drivers/phy/qualcomm/phy-qcom-m31.c | 248 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 260 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-m31.c
> 
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index ced6038..d891058 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -143,6 +143,17 @@ config PHY_QCOM_EUSB2_REPEATER
>  	  PMICs. The repeater is paired with a Synopsys eUSB2 Phy
>  	  on Qualcomm SOCs.
>  
> +config PHY_QCOM_M31_USB
> +	tristate "Qualcomm M31 HS PHY driver support"
> +	depends on USB && (ARCH_QCOM || COMPILE_TEST)
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support M31 HS PHY transceivers on Qualcomm chips
> +	  with DWC3 USB core. It handles PHY initialization, clock
> +	  management required after resetting the hardware and power
> +	  management. This driver is required even for peripheral only or
> +	  host only mode configurations.
> +
>  config PHY_QCOM_USB_HS
>  	tristate "Qualcomm USB HS PHY module"
>  	depends on USB_ULPI_BUS
> diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
> index df94581..ffd609a 100644
> --- a/drivers/phy/qualcomm/Makefile
> +++ b/drivers/phy/qualcomm/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
>  obj-$(CONFIG_PHY_QCOM_EDP)		+= phy-qcom-edp.o
>  obj-$(CONFIG_PHY_QCOM_IPQ4019_USB)	+= phy-qcom-ipq4019-usb.o
>  obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
> +obj-$(CONFIG_PHY_QCOM_M31_USB)		+= phy-qcom-m31.o
>  obj-$(CONFIG_PHY_QCOM_PCIE2)		+= phy-qcom-pcie2.o
>  
>  obj-$(CONFIG_PHY_QCOM_QMP_COMBO)	+= phy-qcom-qmp-combo.o
> diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
> new file mode 100644
> index 0000000..d6a8d06
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-m31.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2014-2023, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of.h>

do you need both headers..?

> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +#define USB2PHY_PORT_UTMI_CTRL1		0x40
> +
> +#define USB2PHY_PORT_UTMI_CTRL2		0x44
> + #define UTMI_ULPI_SEL			BIT(7)
> + #define UTMI_TEST_MUX_SEL		BIT(6)
> +
> +#define HS_PHY_CTRL_REG			0x10
> + #define UTMI_OTG_VBUS_VALID		BIT(20)
> + #define SW_SESSVLD_SEL			BIT(28)
> +
> +#define USB_PHY_UTMI_CTRL0		0x3c
> +
> +#define USB_PHY_UTMI_CTRL5		0x50
> + #define POR_EN				BIT(1)
> +
> +#define USB_PHY_HS_PHY_CTRL_COMMON0	0x54
> + #define COMMONONN			BIT(7)
> + #define FSEL				BIT(4)
> + #define RETENABLEN			BIT(3)
> + #define FREQ_24MHZ			(GENMASK(6, 6) | GENMASK(4, 4))

why not use bit :-)

> +
> +#define USB_PHY_HS_PHY_CTRL2		0x64
> + #define USB2_SUSPEND_N_SEL		BIT(3)
> + #define USB2_SUSPEND_N			BIT(2)
> + #define USB2_UTMI_CLK_EN		BIT(1)
> +
> +#define USB_PHY_CFG0			0x94
> + #define UTMI_PHY_OVERRIDE_EN		BIT(1)
> +
> +#define USB_PHY_REFCLK_CTRL		0xa0
> + #define CLKCORE			BIT(1)
> +
> +#define USB2PHY_PORT_POWERDOWN		0xa4
> + #define POWER_UP			BIT(0)
> + #define POWER_DOWN			0
> +
> +#define USB_PHY_FSEL_SEL		0xb8
> + #define FREQ_SEL			BIT(0)
> +
> +#define USB2PHY_USB_PHY_M31_XCFGI_1	0xbc
> + #define USB2_0_TX_ENABLE		BIT(2)
> +
> +#define USB2PHY_USB_PHY_M31_XCFGI_4	0xc8
> + #define HSTX_SLEW_RATE_565PS		GENMASK(1, 0)
> + #define PLL_CHARGING_PUMP_CURRENT_35UA	GENMASK(4, 3)
> + #define ODT_VALUE_38_02_OHM		GENMASK(7, 6)
> +
> +#define USB2PHY_USB_PHY_M31_XCFGI_5	0xcc
> + #define ODT_VALUE_45_02_OHM		BIT(2)
> + #define HSTX_PRE_EMPHASIS_LEVEL_0_55MA	BIT(0)
> +
> +#define USB2PHY_USB_PHY_M31_XCFGI_11	0xe4
> + #define XCFG_COARSE_TUNE_NUM		BIT(1)
> + #define XCFG_FINE_TUNE_NUM		BIT(3)
> +
> +struct m31_phy_regs {
> +	u32 off;
> +	u32 val;
> +	u32 delay;
> +};
> +
> +struct m31_priv_data {
> +	bool				ulpi_mode;
> +	const struct m31_phy_regs	*regs;
> +	unsigned int			nregs;
> +};
> +
> +struct m31_phy_regs m31_ipq5332_regs[] = {
> +	{ USB_PHY_CFG0, UTMI_PHY_OVERRIDE_EN, 0 },
> +	{ USB_PHY_UTMI_CTRL5, POR_EN, 15 },
> +	{ USB_PHY_FSEL_SEL, FREQ_SEL, 0 },
> +	{ USB_PHY_HS_PHY_CTRL_COMMON0, COMMONONN | FREQ_24MHZ | RETENABLEN, 0 },
> +	{ USB_PHY_UTMI_CTRL5, POR_EN, 0 },
> +	{ USB_PHY_HS_PHY_CTRL2, USB2_SUSPEND_N_SEL | USB2_SUSPEND_N | USB2_UTMI_CLK_EN, 0 },
> +	{ USB2PHY_USB_PHY_M31_XCFGI_11, XCFG_COARSE_TUNE_NUM  | XCFG_FINE_TUNE_NUM, 0 },
> +	{ USB2PHY_USB_PHY_M31_XCFGI_4, HSTX_SLEW_RATE_565PS | PLL_CHARGING_PUMP_CURRENT_35UA |
> +				       ODT_VALUE_38_02_OHM, 0 },
> +	{ USB2PHY_USB_PHY_M31_XCFGI_1, USB2_0_TX_ENABLE, 0 },
> +	{ USB2PHY_USB_PHY_M31_XCFGI_5, ODT_VALUE_45_02_OHM | HSTX_PRE_EMPHASIS_LEVEL_0_55MA, 4 },
> +	{ USB_PHY_UTMI_CTRL5, 0x0, 0 },
> +	{ USB_PHY_HS_PHY_CTRL2, USB2_SUSPEND_N | USB2_UTMI_CLK_EN, 0 },

More readable way to code
                USB_PHY_CFG0,
                UTMI_PHY_OVERRIDE_EN,
                0

and so on, makes a better read and check for errors, one line for off,
one for val and one for delay

-- 
`~Vinod
