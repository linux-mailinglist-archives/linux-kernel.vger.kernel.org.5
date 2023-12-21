Return-Path: <linux-kernel+bounces-8788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F7681BC53
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F201C2464A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E487C5821E;
	Thu, 21 Dec 2023 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9EEYiHS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031F55E73;
	Thu, 21 Dec 2023 16:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E10C433C8;
	Thu, 21 Dec 2023 16:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703177321;
	bh=d/T6q9/kFW/Zn0KLleq7EELcD5Z018KWIn/1kpDdNys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9EEYiHS1e0Po1qyuQDBWwJLptb0u8epeeg1L0P4+3vrx/JW3VeWDhtK1AWLlSiea
	 mGuxYgfhbOp2LJ0nIjLDYSzS7itcqfo6FRURNnHsRmMVY2NtXlk2AXaBnFiv+C+96E
	 dHe9sHyUoyvpa1qthuXkGfh6MEEm2vQL4cIO/ikptWPtasJqfxn17Jfx5iA2OHbRan
	 nMFgymCgjemSPpf/1hNn1rD7ubG4BwOM1PShsYaKqthb0m5yPWLFHnOvSVyUHaFx/Y
	 /328Vjfwfox1+s3D8OV66w2h1Zicuz6Gh6DlEGU8YwoNaQT4HrvKtp/9ZOKUA22nEo
	 s4dZ0Uo/cQ1OQ==
Date: Thu, 21 Dec 2023 22:18:37 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH net-next v3 2/8] phy: add driver for MediaTek pextp
 10GE SerDes PHY
Message-ID: <ZYRsZWY0w2_uFOpn@matsya>
References: <cover.1702352117.git.daniel@makrotopia.org>
 <a58dae1cce1b49093b0ae05159c784a9ec02f058.1702352117.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a58dae1cce1b49093b0ae05159c784a9ec02f058.1702352117.git.daniel@makrotopia.org>

On 12-12-23, 03:46, Daniel Golle wrote:
> Add driver for MediaTek's pextp 10 Gigabit/s Ethernet SerDes PHY which
> can be found in the MT7988 SoC.
> 
> The PHY can operates only in PHY_MODE_ETHERNET, the submode is one of
> PHY_INTERFACE_MODE_* corresponding to the supported modes:
> 
>  * USXGMII
>  * 10GBase-R
>  * 5GBase-R
>  * 2500Base-X
>  * 1000Base-X
>  * Cisco SGMII (MAC side)
> 
> In order to work-around a performance issue present on the first of
> two PEXTP present in MT7988 special tuning is applied which can be
> selected by adding the mediatek,usxgmii-performance-errata property to
> the device tree node.
> 
> There is no documentation what-so-ever for the pextp registers and
> this driver is based on a GPL licensed implementation found in
> MediaTek's SDK.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  MAINTAINERS                          |   1 +
>  drivers/phy/mediatek/Kconfig         |  11 +
>  drivers/phy/mediatek/Makefile        |   1 +
>  drivers/phy/mediatek/phy-mtk-pextp.c | 361 +++++++++++++++++++++++++++
>  4 files changed, 374 insertions(+)
>  create mode 100644 drivers/phy/mediatek/phy-mtk-pextp.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 98f7dd0499f17..b2772cfe2a704 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13510,6 +13510,7 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/phy/mediatek-ge-soc.c
>  F:	drivers/net/phy/mediatek-ge.c
> +F:	drivers/phy/mediatek/phy-mtk-pextp.c
>  
>  MEDIATEK I2C CONTROLLER DRIVER
>  M:	Qii Wang <qii.wang@mediatek.com>
> diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
> index 3125ecb5d119f..a7749a6d96541 100644
> --- a/drivers/phy/mediatek/Kconfig
> +++ b/drivers/phy/mediatek/Kconfig
> @@ -13,6 +13,17 @@ config PHY_MTK_PCIE
>  	  callback for PCIe GEN3 port, it supports software efuse
>  	  initialization.
>  
> +config PHY_MTK_PEXTP
> +	tristate "MediaTek PEXTP Driver"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on OF && OF_ADDRESS
> +	depends on HAS_IOMEM
> +	select GENERIC_PHY
> +	help
> +	  Say 'Y' here to add support for MediaTek pextp PHY driver.
> +	  The driver provides access to the Ethernet SerDes PHY supporting
> +	  various 1GE, 2.5GE, 5GE and 10GE modes.
> +
>  config PHY_MTK_TPHY
>  	tristate "MediaTek T-PHY Driver"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
> index c9a50395533eb..ca60c7b9b02ac 100644
> --- a/drivers/phy/mediatek/Makefile
> +++ b/drivers/phy/mediatek/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PHY_MTK_PCIE)		+= phy-mtk-pcie.o
>  obj-$(CONFIG_PHY_MTK_TPHY)		+= phy-mtk-tphy.o
>  obj-$(CONFIG_PHY_MTK_UFS)		+= phy-mtk-ufs.o
>  obj-$(CONFIG_PHY_MTK_XSPHY)		+= phy-mtk-xsphy.o
> +obj-$(CONFIG_PHY_MTK_PEXTP)		+= phy-mtk-pextp.o

alphabetically sorted please

>  
>  phy-mtk-hdmi-drv-y			:= phy-mtk-hdmi.o
>  phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-mt2701.o
> diff --git a/drivers/phy/mediatek/phy-mtk-pextp.c b/drivers/phy/mediatek/phy-mtk-pextp.c
> new file mode 100644
> index 0000000000000..3ec48cf129105
> --- /dev/null
> +++ b/drivers/phy/mediatek/phy-mtk-pextp.c
> @@ -0,0 +1,361 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* MediaTek 10GE SerDes PHY driver
> + *
> + * Copyright (c) 2023 Daniel Golle <daniel@makrotopia.org>
> + * based on mtk_usxgmii.c found in MediaTek's SDK released under GPL-2.0
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Henry Yen <henry.yen@mediatek.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/netdevice.h>

why do you need this header?

> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +#include <linux/phy.h>
> +#include <linux/phy/phy.h>
> +
> +#define MTK_PEXTP_NUM_CLOCKS	2
> +
> +struct mtk_pextp_phy {
> +	void __iomem		*base;
> +	struct device		*dev;
> +	struct reset_control	*reset;
> +	struct clk_bulk_data	clocks[MTK_PEXTP_NUM_CLOCKS];
> +	bool			da_war;
> +};
> +
> +static bool mtk_interface_mode_is_xgmii(phy_interface_t interface)
> +{
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_INTERNAL:
> +	case PHY_INTERFACE_MODE_USXGMII:
> +	case PHY_INTERFACE_MODE_10GBASER:
> +	case PHY_INTERFACE_MODE_5GBASER:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static void mtk_pextp_setup(struct mtk_pextp_phy *pextp, phy_interface_t interface)
> +{
> +	bool is_10g = (interface == PHY_INTERFACE_MODE_10GBASER ||
> +		       interface == PHY_INTERFACE_MODE_USXGMII);
> +	bool is_2p5g = (interface == PHY_INTERFACE_MODE_2500BASEX);
> +	bool is_5g = (interface == PHY_INTERFACE_MODE_5GBASER);
> +
> +	dev_dbg(pextp->dev, "setting up for mode %s\n", phy_modes(interface));
> +
> +	/* Setup operation mode */
> +	if (is_10g)
> +		iowrite32(0x00c9071c, pextp->base + 0x9024);
> +	else
> +		iowrite32(0x00d9071c, pextp->base + 0x9024);
> +
> +	if (is_5g)
> +		iowrite32(0xaaa5a5aa, pextp->base + 0x2020);
> +	else
> +		iowrite32(0xaa8585aa, pextp->base + 0x2020);
> +
> +	if (is_2p5g || is_5g || is_10g) {
> +		iowrite32(0x0c020707, pextp->base + 0x2030);
> +		iowrite32(0x0e050f0f, pextp->base + 0x2034);
> +		iowrite32(0x00140032, pextp->base + 0x2040);
> +	} else {
> +		iowrite32(0x0c020207, pextp->base + 0x2030);
> +		iowrite32(0x0e05050f, pextp->base + 0x2034);
> +		iowrite32(0x00200032, pextp->base + 0x2040);
> +	}
> +
> +	if (is_2p5g || is_10g)
> +		iowrite32(0x00c014aa, pextp->base + 0x50f0);
> +	else if (is_5g)
> +		iowrite32(0x00c018aa, pextp->base + 0x50f0);
> +	else
> +		iowrite32(0x00c014ba, pextp->base + 0x50f0);
> +
> +	if (is_5g) {
> +		iowrite32(0x3777812b, pextp->base + 0x50e0);
> +		iowrite32(0x005c9cff, pextp->base + 0x506c);
> +		iowrite32(0x9dfafafa, pextp->base + 0x5070);
> +		iowrite32(0x273f3f3f, pextp->base + 0x5074);
> +		iowrite32(0xa8883868, pextp->base + 0x5078);
> +		iowrite32(0x14661466, pextp->base + 0x507c);
> +	} else {
> +		iowrite32(0x3777c12b, pextp->base + 0x50e0);
> +		iowrite32(0x005f9cff, pextp->base + 0x506c);
> +		iowrite32(0x9d9dfafa, pextp->base + 0x5070);
> +		iowrite32(0x27273f3f, pextp->base + 0x5074);
> +		iowrite32(0xa7883c68, pextp->base + 0x5078);
> +		iowrite32(0x11661166, pextp->base + 0x507c);
> +	}
> +
> +	if (is_2p5g || is_10g) {
> +		iowrite32(0x0e000aaf, pextp->base + 0x5080);
> +		iowrite32(0x08080d0d, pextp->base + 0x5084);
> +		iowrite32(0x02030909, pextp->base + 0x5088);
> +	} else if (is_5g) {
> +		iowrite32(0x0e001abf, pextp->base + 0x5080);
> +		iowrite32(0x080b0d0d, pextp->base + 0x5084);
> +		iowrite32(0x02050909, pextp->base + 0x5088);
> +	} else {
> +		iowrite32(0x0e000eaf, pextp->base + 0x5080);
> +		iowrite32(0x08080e0d, pextp->base + 0x5084);
> +		iowrite32(0x02030b09, pextp->base + 0x5088);
> +	}
> +
> +	if (is_5g) {
> +		iowrite32(0x0c000000, pextp->base + 0x50e4);
> +		iowrite32(0x04000000, pextp->base + 0x50e8);
> +	} else {
> +		iowrite32(0x0c0c0000, pextp->base + 0x50e4);
> +		iowrite32(0x04040000, pextp->base + 0x50e8);
> +	}
> +
> +	if (is_2p5g || mtk_interface_mode_is_xgmii(interface))
> +		iowrite32(0x0f0f0c06, pextp->base + 0x50eC);

ouch, why mixed case, make it small everwhere please

> +	else
> +		iowrite32(0x0f0f0606, pextp->base + 0x50eC);
> +
> +	if (is_5g) {
> +		iowrite32(0x50808c8c, pextp->base + 0x50a8);
> +		iowrite32(0x18000000, pextp->base + 0x6004);
> +	} else {
> +		iowrite32(0x506e8c8c, pextp->base + 0x50a8);
> +		iowrite32(0x18190000, pextp->base + 0x6004);
> +	}
> +
> +	if (is_10g)
> +		iowrite32(0x01423342, pextp->base + 0x00f8);
> +	else if (is_5g)
> +		iowrite32(0x00a132a1, pextp->base + 0x00f8);
> +	else if (is_2p5g)
> +		iowrite32(0x009c329c, pextp->base + 0x00f8);
> +	else
> +		iowrite32(0x00fa32fa, pextp->base + 0x00f8);
> +
> +	/* Force SGDT_OUT off and select PCS */
> +	if (mtk_interface_mode_is_xgmii(interface))
> +		iowrite32(0x80201f20, pextp->base + 0x00f4);
> +	else
> +		iowrite32(0x80201f21, pextp->base + 0x00f4);
> +
> +	/* Force GLB_CKDET_OUT */
> +	iowrite32(0x00050c00, pextp->base + 0x0030);
> +
> +	/* Force AEQ on */
> +	iowrite32(0x02002800, pextp->base + 0x0070);
> +	ndelay(1020);
> +
> +	/* Setup DA default value */
> +	iowrite32(0x00000020, pextp->base + 0x30b0);
> +	iowrite32(0x00008a01, pextp->base + 0x3028);
> +	iowrite32(0x0000a884, pextp->base + 0x302c);
> +	iowrite32(0x00083002, pextp->base + 0x3024);
> +	if (mtk_interface_mode_is_xgmii(interface)) {
> +		iowrite32(0x00022220, pextp->base + 0x3010);
> +		iowrite32(0x0f020a01, pextp->base + 0x5064);
> +		iowrite32(0x06100600, pextp->base + 0x50b4);
> +		if (interface == PHY_INTERFACE_MODE_USXGMII)
> +			iowrite32(0x40704000, pextp->base + 0x3048);
> +		else
> +			iowrite32(0x47684100, pextp->base + 0x3048);
> +	} else {
> +		iowrite32(0x00011110, pextp->base + 0x3010);
> +		iowrite32(0x40704000, pextp->base + 0x3048);
> +	}
> +
> +	if (!mtk_interface_mode_is_xgmii(interface) && !is_2p5g)
> +		iowrite32(0x0000c000, pextp->base + 0x3064);
> +
> +	if (interface != PHY_INTERFACE_MODE_10GBASER) {
> +		iowrite32(0xa8000000, pextp->base + 0x3050);
> +		iowrite32(0x000000aa, pextp->base + 0x3054);
> +	} else {
> +		iowrite32(0x00000000, pextp->base + 0x3050);
> +		iowrite32(0x00000000, pextp->base + 0x3054);
> +	}
> +
> +	if (mtk_interface_mode_is_xgmii(interface))
> +		iowrite32(0x00000f00, pextp->base + 0x306c);
> +	else if (is_2p5g)
> +		iowrite32(0x22000f00, pextp->base + 0x306c);
> +	else
> +		iowrite32(0x20200f00, pextp->base + 0x306c);
> +
> +	if (interface == PHY_INTERFACE_MODE_10GBASER && pextp->da_war)
> +		iowrite32(0x0007b400, pextp->base + 0xa008);
> +
> +	if (mtk_interface_mode_is_xgmii(interface))
> +		iowrite32(0x00040000, pextp->base + 0xa060);
> +	else
> +		iowrite32(0x00050000, pextp->base + 0xa060);
> +
> +	if (is_10g)
> +		iowrite32(0x00000001, pextp->base + 0x90d0);
> +	else if (is_5g)
> +		iowrite32(0x00000003, pextp->base + 0x90d0);
> +	else if (is_2p5g)
> +		iowrite32(0x00000005, pextp->base + 0x90d0);
> +	else
> +		iowrite32(0x00000007, pextp->base + 0x90d0);
> +
> +	/* Release reset */
> +	iowrite32(0x0200e800, pextp->base + 0x0070);
> +	usleep_range(150, 500);
> +
> +	/* Switch to P0 */
> +	iowrite32(0x0200c111, pextp->base + 0x0070);
> +	ndelay(1020);
> +	iowrite32(0x0200c101, pextp->base + 0x0070);
> +	usleep_range(15, 50);
> +
> +	if (mtk_interface_mode_is_xgmii(interface)) {
> +		/* Switch to Gen3 */
> +		iowrite32(0x0202c111, pextp->base + 0x0070);
> +	} else {
> +		/* Switch to Gen2 */
> +		iowrite32(0x0201c111, pextp->base + 0x0070);
> +	}
> +	ndelay(1020);
> +	if (mtk_interface_mode_is_xgmii(interface))
> +		iowrite32(0x0202c101, pextp->base + 0x0070);
> +	else
> +		iowrite32(0x0201c101, pextp->base + 0x0070);
> +	usleep_range(100, 500);
> +	iowrite32(0x00000030, pextp->base + 0x30b0);
> +	if (mtk_interface_mode_is_xgmii(interface))
> +		iowrite32(0x80201f00, pextp->base + 0x00f4);
> +	else
> +		iowrite32(0x80201f01, pextp->base + 0x00f4);
> +
> +	iowrite32(0x30000000, pextp->base + 0x3040);
> +	usleep_range(400, 1000);
> +}
> +
> +static int mtk_pextp_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> +{
> +	struct mtk_pextp_phy *pextp = phy_get_drvdata(phy);
> +
> +	if (mode != PHY_MODE_ETHERNET)
> +		return -EINVAL;
> +
> +	switch (submode) {
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_5GBASER:
> +	case PHY_INTERFACE_MODE_10GBASER:
> +	case PHY_INTERFACE_MODE_USXGMII:
> +		mtk_pextp_setup(pextp, submode);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mtk_pextp_reset(struct phy *phy)
> +{
> +	struct mtk_pextp_phy *pextp = phy_get_drvdata(phy);
> +
> +	reset_control_assert(pextp->reset);
> +	usleep_range(100, 500);
> +	reset_control_deassert(pextp->reset);
> +	usleep_range(1, 10);
> +
> +	return 0;
> +}
> +
> +static int mtk_pextp_power_on(struct phy *phy)
> +{
> +	struct mtk_pextp_phy *pextp = phy_get_drvdata(phy);
> +
> +	return clk_bulk_prepare_enable(MTK_PEXTP_NUM_CLOCKS, pextp->clocks);
> +}
> +
> +static int mtk_pextp_power_off(struct phy *phy)
> +{
> +	struct mtk_pextp_phy *pextp = phy_get_drvdata(phy);
> +
> +	clk_bulk_disable_unprepare(MTK_PEXTP_NUM_CLOCKS, pextp->clocks);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops mtk_pextp_ops = {
> +	.power_on	= mtk_pextp_power_on,
> +	.power_off	= mtk_pextp_power_off,
> +	.set_mode	= mtk_pextp_set_mode,
> +	.reset		= mtk_pextp_reset,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int mtk_pextp_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct phy_provider *phy_provider;
> +	struct mtk_pextp_phy *pextp;
> +	struct phy *phy;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	pextp = devm_kzalloc(&pdev->dev, sizeof(*pextp), GFP_KERNEL);
> +	if (!pextp)
> +		return -ENOMEM;
> +
> +	pextp->base = devm_of_iomap(&pdev->dev, np, 0, NULL);
> +	if (!pextp->base)
> +		return -EIO;
> +
> +	pextp->dev = &pdev->dev;
> +
> +	pextp->clocks[0].id = "topxtal";
> +	pextp->clocks[0].clk = devm_clk_get(&pdev->dev, pextp->clocks[0].id);
> +	if (IS_ERR(pextp->clocks[0].clk))
> +		return PTR_ERR(pextp->clocks[0].clk);
> +
> +	pextp->clocks[1].id = "xfipll";
> +	pextp->clocks[1].clk = devm_clk_get(&pdev->dev, pextp->clocks[1].id);
> +	if (IS_ERR(pextp->clocks[1].clk))
> +		return PTR_ERR(pextp->clocks[1].clk);
> +
> +	pextp->reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(pextp->reset))
> +		return PTR_ERR(pextp->reset);
> +
> +	pextp->da_war = of_property_read_bool(np, "mediatek,usxgmii-performance-errata");
> +
> +	phy = devm_phy_create(&pdev->dev, NULL, &mtk_pextp_ops);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
> +
> +	phy_set_drvdata(phy, pextp);
> +
> +	phy_provider = devm_of_phy_provider_register(&pdev->dev, of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct of_device_id mtk_pextp_match[] = {
> +	{ .compatible = "mediatek,mt7988-xfi-pextp", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mtk_pextp_match);
> +
> +static struct platform_driver mtk_pextp_driver = {
> +	.probe = mtk_pextp_probe,
> +	.driver = {
> +		.name = "mtk-pextp",
> +		.of_match_table = mtk_pextp_match,
> +	},
> +};
> +module_platform_driver(mtk_pextp_driver);

why is this driver in netdev series, it should not be dependent on rest
and can be send separately to phy ss

> +
> +MODULE_DESCRIPTION("MediaTek pextp SerDes PHY driver");
> +MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.43.0

-- 
~Vinod

