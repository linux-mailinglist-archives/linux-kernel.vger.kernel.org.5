Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92B88064DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376573AbjLFBoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376574AbjLFBoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:44:20 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E6FD72;
        Tue,  5 Dec 2023 17:44:24 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1rAgxP-0002fY-0B;
        Wed, 06 Dec 2023 01:44:12 +0000
Date:   Wed, 6 Dec 2023 01:44:08 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Couzens <lynxis@fe80.eu>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: [RFC PATCH v2 2/8] phy: add driver for MediaTek pextp 10GE SerDes PHY
Message-ID: <63636378a52dd1ea7370dbf0ca3037a7d24004b9.1701826319.git.daniel@makrotopia.org>
References: <cover.1701826319.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701826319.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for MediaTek's pextp 10 Gigabit/s Ethernet SerDes PHY which
can be found in the MT7988 SoC.

The PHY can operates only in PHY_MODE_ETHERNET, the submode is one of
PHY_INTERFACE_MODE_* corresponding to the supported modes:

 * USXGMII
 * 10GBase-R
 * 5GBase-R
 * 2500Base-X
 * 1000Base-X
 * Cisco SGMII (MAC side)

In order to work-around a performance issue present on the first of
two PEXTP present in MT7988 special tuning is applied which can be
selected by adding the mediatek,usxgmii-performance-errata property to
the device tree node.

There is no documentation what-so-ever for the pextp registers and
this driver is based on a GPL licensed implementation found in
MediaTek's SDK.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 MAINTAINERS                          |   1 +
 drivers/phy/mediatek/Kconfig         |  11 +
 drivers/phy/mediatek/Makefile        |   1 +
 drivers/phy/mediatek/phy-mtk-pextp.c | 365 +++++++++++++++++++++++++++
 4 files changed, 378 insertions(+)
 create mode 100644 drivers/phy/mediatek/phy-mtk-pextp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ef2a16370619..1ea4555013a4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13497,6 +13497,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/phy/mediatek-ge-soc.c
 F:	drivers/net/phy/mediatek-ge.c
+F:	drivers/phy/mediatek/phy-mtk-pextp.c
 
 MEDIATEK I2C CONTROLLER DRIVER
 M:	Qii Wang <qii.wang@mediatek.com>
diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 3125ecb5d119f..a7749a6d96541 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -13,6 +13,17 @@ config PHY_MTK_PCIE
 	  callback for PCIe GEN3 port, it supports software efuse
 	  initialization.
 
+config PHY_MTK_PEXTP
+	tristate "MediaTek PEXTP Driver"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on OF && OF_ADDRESS
+	depends on HAS_IOMEM
+	select GENERIC_PHY
+	help
+	  Say 'Y' here to add support for MediaTek pextp PHY driver.
+	  The driver provides access to the Ethernet SerDes PHY supporting
+	  various 1GE, 2.5GE, 5GE and 10GE modes.
+
 config PHY_MTK_TPHY
 	tristate "MediaTek T-PHY Driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
index c9a50395533eb..ca60c7b9b02ac 100644
--- a/drivers/phy/mediatek/Makefile
+++ b/drivers/phy/mediatek/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PHY_MTK_PCIE)		+= phy-mtk-pcie.o
 obj-$(CONFIG_PHY_MTK_TPHY)		+= phy-mtk-tphy.o
 obj-$(CONFIG_PHY_MTK_UFS)		+= phy-mtk-ufs.o
 obj-$(CONFIG_PHY_MTK_XSPHY)		+= phy-mtk-xsphy.o
+obj-$(CONFIG_PHY_MTK_PEXTP)		+= phy-mtk-pextp.o
 
 phy-mtk-hdmi-drv-y			:= phy-mtk-hdmi.o
 phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-mt2701.o
diff --git a/drivers/phy/mediatek/phy-mtk-pextp.c b/drivers/phy/mediatek/phy-mtk-pextp.c
new file mode 100644
index 0000000000000..e5bfab86f95a5
--- /dev/null
+++ b/drivers/phy/mediatek/phy-mtk-pextp.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* MediaTek 10GE SerDes PHY driver
+ *
+ * Copyright (c) 2023 Daniel Golle <daniel@makrotopia.org>
+ * based on mtk_usxgmii.c found in MediaTek's SDK released under GPL-2.0
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Henry Yen <henry.yen@mediatek.com>
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <linux/phy.h>
+#include <linux/phy/phy.h>
+
+struct mtk_pextp_phy {
+	void __iomem		*base;
+	struct device		*dev;
+	struct reset_control	*reset;
+	struct clk		*clk[2];
+	bool			da_war;
+};
+
+static bool mtk_interface_mode_is_xgmii(phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_INTERNAL:
+	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_5GBASER:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void mtk_pextp_setup(struct mtk_pextp_phy *pextp, phy_interface_t interface)
+{
+	bool is_10g = (interface == PHY_INTERFACE_MODE_10GBASER ||
+		       interface == PHY_INTERFACE_MODE_USXGMII);
+	bool is_2p5g = (interface == PHY_INTERFACE_MODE_2500BASEX);
+	bool is_5g = (interface == PHY_INTERFACE_MODE_5GBASER);
+
+	dev_dbg(pextp->dev, "setting up for mode %s\n", phy_modes(interface));
+
+	/* Setup operation mode */
+	if (is_10g)
+		iowrite32(0x00C9071C, pextp->base + 0x9024);
+	else
+		iowrite32(0x00D9071C, pextp->base + 0x9024);
+
+	if (is_5g)
+		iowrite32(0xAAA5A5AA, pextp->base + 0x2020);
+	else
+		iowrite32(0xAA8585AA, pextp->base + 0x2020);
+
+	if (is_2p5g || is_5g || is_10g) {
+		iowrite32(0x0C020707, pextp->base + 0x2030);
+		iowrite32(0x0E050F0F, pextp->base + 0x2034);
+		iowrite32(0x00140032, pextp->base + 0x2040);
+	} else {
+		iowrite32(0x0C020207, pextp->base + 0x2030);
+		iowrite32(0x0E05050F, pextp->base + 0x2034);
+		iowrite32(0x00200032, pextp->base + 0x2040);
+	}
+
+	if (is_2p5g || is_10g)
+		iowrite32(0x00C014AA, pextp->base + 0x50F0);
+	else if (is_5g)
+		iowrite32(0x00C018AA, pextp->base + 0x50F0);
+	else
+		iowrite32(0x00C014BA, pextp->base + 0x50F0);
+
+	if (is_5g) {
+		iowrite32(0x3777812B, pextp->base + 0x50E0);
+		iowrite32(0x005C9CFF, pextp->base + 0x506C);
+		iowrite32(0x9DFAFAFA, pextp->base + 0x5070);
+		iowrite32(0x273F3F3F, pextp->base + 0x5074);
+		iowrite32(0xA8883868, pextp->base + 0x5078);
+		iowrite32(0x14661466, pextp->base + 0x507C);
+	} else {
+		iowrite32(0x3777C12B, pextp->base + 0x50E0);
+		iowrite32(0x005F9CFF, pextp->base + 0x506C);
+		iowrite32(0x9D9DFAFA, pextp->base + 0x5070);
+		iowrite32(0x27273F3F, pextp->base + 0x5074);
+		iowrite32(0xA7883C68, pextp->base + 0x5078);
+		iowrite32(0x11661166, pextp->base + 0x507C);
+	}
+
+	if (is_2p5g || is_10g) {
+		iowrite32(0x0E000AAF, pextp->base + 0x5080);
+		iowrite32(0x08080D0D, pextp->base + 0x5084);
+		iowrite32(0x02030909, pextp->base + 0x5088);
+	} else if (is_5g) {
+		iowrite32(0x0E001ABF, pextp->base + 0x5080);
+		iowrite32(0x080B0D0D, pextp->base + 0x5084);
+		iowrite32(0x02050909, pextp->base + 0x5088);
+	} else {
+		iowrite32(0x0E000EAF, pextp->base + 0x5080);
+		iowrite32(0x08080E0D, pextp->base + 0x5084);
+		iowrite32(0x02030B09, pextp->base + 0x5088);
+	}
+
+	if (is_5g) {
+		iowrite32(0x0C000000, pextp->base + 0x50E4);
+		iowrite32(0x04000000, pextp->base + 0x50E8);
+	} else {
+		iowrite32(0x0C0C0000, pextp->base + 0x50E4);
+		iowrite32(0x04040000, pextp->base + 0x50E8);
+	}
+
+	if (is_2p5g || mtk_interface_mode_is_xgmii(interface))
+		iowrite32(0x0F0F0C06, pextp->base + 0x50EC);
+	else
+		iowrite32(0x0F0F0606, pextp->base + 0x50EC);
+
+	if (is_5g) {
+		iowrite32(0x50808C8C, pextp->base + 0x50A8);
+		iowrite32(0x18000000, pextp->base + 0x6004);
+	} else {
+		iowrite32(0x506E8C8C, pextp->base + 0x50A8);
+		iowrite32(0x18190000, pextp->base + 0x6004);
+	}
+
+	if (is_10g)
+		iowrite32(0x01423342, pextp->base + 0x00F8);
+	else if (is_5g)
+		iowrite32(0x00A132A1, pextp->base + 0x00F8);
+	else if (is_2p5g)
+		iowrite32(0x009C329C, pextp->base + 0x00F8);
+	else
+		iowrite32(0x00FA32FA, pextp->base + 0x00F8);
+
+	/* Force SGDT_OUT off and select PCS */
+	if (mtk_interface_mode_is_xgmii(interface))
+		iowrite32(0x80201F20, pextp->base + 0x00F4);
+	else
+		iowrite32(0x80201F21, pextp->base + 0x00F4);
+
+	/* Force GLB_CKDET_OUT */
+	iowrite32(0x00050C00, pextp->base + 0x0030);
+
+	/* Force AEQ on */
+	iowrite32(0x02002800, pextp->base + 0x0070);
+	ndelay(1020);
+
+	/* Setup DA default value */
+	iowrite32(0x00000020, pextp->base + 0x30B0);
+	iowrite32(0x00008A01, pextp->base + 0x3028);
+	iowrite32(0x0000A884, pextp->base + 0x302C);
+	iowrite32(0x00083002, pextp->base + 0x3024);
+	if (mtk_interface_mode_is_xgmii(interface)) {
+		iowrite32(0x00022220, pextp->base + 0x3010);
+		iowrite32(0x0F020A01, pextp->base + 0x5064);
+		iowrite32(0x06100600, pextp->base + 0x50B4);
+		if (interface == PHY_INTERFACE_MODE_USXGMII)
+			iowrite32(0x40704000, pextp->base + 0x3048);
+		else
+			iowrite32(0x47684100, pextp->base + 0x3048);
+	} else {
+		iowrite32(0x00011110, pextp->base + 0x3010);
+		iowrite32(0x40704000, pextp->base + 0x3048);
+	}
+
+	if (!mtk_interface_mode_is_xgmii(interface) && !is_2p5g)
+		iowrite32(0x0000C000, pextp->base + 0x3064);
+
+	if (interface == PHY_INTERFACE_MODE_USXGMII) {
+		iowrite32(0xA8000000, pextp->base + 0x3050);
+		iowrite32(0x000000AA, pextp->base + 0x3054);
+	} else if (mtk_interface_mode_is_xgmii(interface)) {
+		iowrite32(0x00000000, pextp->base + 0x3050);
+		iowrite32(0x00000000, pextp->base + 0x3054);
+	} else {
+		iowrite32(0xA8000000, pextp->base + 0x3050);
+		iowrite32(0x000000AA, pextp->base + 0x3054);
+	}
+
+	if (mtk_interface_mode_is_xgmii(interface))
+		iowrite32(0x00000F00, pextp->base + 0x306C);
+	else if (is_2p5g)
+		iowrite32(0x22000F00, pextp->base + 0x306C);
+	else
+		iowrite32(0x20200F00, pextp->base + 0x306C);
+
+	if (interface == PHY_INTERFACE_MODE_10GBASER && pextp->da_war)
+		iowrite32(0x0007B400, pextp->base + 0xA008);
+
+	if (mtk_interface_mode_is_xgmii(interface))
+		iowrite32(0x00040000, pextp->base + 0xA060);
+	else
+		iowrite32(0x00050000, pextp->base + 0xA060);
+
+	if (is_10g)
+		iowrite32(0x00000001, pextp->base + 0x90D0);
+	else if (is_5g)
+		iowrite32(0x00000003, pextp->base + 0x90D0);
+	else if (is_2p5g)
+		iowrite32(0x00000005, pextp->base + 0x90D0);
+	else
+		iowrite32(0x00000007, pextp->base + 0x90D0);
+
+	/* Release reset */
+	iowrite32(0x0200E800, pextp->base + 0x0070);
+	usleep_range(150, 500);
+
+	/* Switch to P0 */
+	iowrite32(0x0200C111, pextp->base + 0x0070);
+	ndelay(1020);
+	iowrite32(0x0200C101, pextp->base + 0x0070);
+	usleep_range(15, 50);
+
+	if (mtk_interface_mode_is_xgmii(interface)) {
+		/* Switch to Gen3 */
+		iowrite32(0x0202C111, pextp->base + 0x0070);
+	} else {
+		/* Switch to Gen2 */
+		iowrite32(0x0201C111, pextp->base + 0x0070);
+	}
+	ndelay(1020);
+	if (mtk_interface_mode_is_xgmii(interface))
+		iowrite32(0x0202C101, pextp->base + 0x0070);
+	else
+		iowrite32(0x0201C101, pextp->base + 0x0070);
+	usleep_range(100, 500);
+	iowrite32(0x00000030, pextp->base + 0x30B0);
+	if (mtk_interface_mode_is_xgmii(interface))
+		iowrite32(0x80201F00, pextp->base + 0x00F4);
+	else
+		iowrite32(0x80201F01, pextp->base + 0x00F4);
+
+	iowrite32(0x30000000, pextp->base + 0x3040);
+	usleep_range(400, 1000);
+}
+
+static int mtk_pextp_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct mtk_pextp_phy *pextp = phy_get_drvdata(phy);
+
+	if (mode != PHY_MODE_ETHERNET)
+		return -EINVAL;
+
+	switch (submode) {
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_5GBASER:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_USXGMII:
+		mtk_pextp_setup(pextp, submode);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mtk_pextp_reset(struct phy *phy)
+{
+	struct mtk_pextp_phy *pextp = phy_get_drvdata(phy);
+
+	reset_control_assert(pextp->reset);
+	usleep_range(100, 500);
+	reset_control_deassert(pextp->reset);
+	usleep_range(1, 10);
+
+	return 0;
+}
+
+static int mtk_pextp_power_on(struct phy *phy)
+{
+	struct mtk_pextp_phy *pextp = phy_get_drvdata(phy);
+	int ret;
+
+	ret = clk_prepare_enable(pextp->clk[0]);
+	if (ret)
+		return ret;
+
+	return clk_prepare_enable(pextp->clk[1]);
+}
+
+static int mtk_pextp_power_off(struct phy *phy)
+{
+	struct mtk_pextp_phy *pextp = phy_get_drvdata(phy);
+
+	clk_disable_unprepare(pextp->clk[1]);
+	clk_disable_unprepare(pextp->clk[0]);
+
+	return 0;
+}
+
+static const struct phy_ops mtk_pextp_ops = {
+	.power_on	= mtk_pextp_power_on,
+	.power_off	= mtk_pextp_power_off,
+	.set_mode	= mtk_pextp_set_mode,
+	.reset		= mtk_pextp_reset,
+	.owner		= THIS_MODULE,
+};
+
+static int mtk_pextp_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct phy_provider *phy_provider;
+	struct mtk_pextp_phy *pextp;
+	struct phy *phy;
+
+	if (!np)
+		return -ENODEV;
+
+	pextp = devm_kzalloc(&pdev->dev, sizeof(*pextp), GFP_KERNEL);
+	if (!pextp)
+		return -ENOMEM;
+
+	pextp->base = devm_of_iomap(&pdev->dev, np, 0, NULL);
+	if (!pextp->base)
+		return -EIO;
+
+	pextp->dev = &pdev->dev;
+	pextp->clk[0] = devm_clk_get(&pdev->dev, "topxtal");
+	if (IS_ERR(pextp->clk[0]))
+		return PTR_ERR(pextp->clk[0]);
+
+	pextp->clk[1] = devm_clk_get(&pdev->dev, "xfipll");
+	if (IS_ERR(pextp->clk[1]))
+		return PTR_ERR(pextp->clk[1]);
+
+	pextp->reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(pextp->reset))
+		return PTR_ERR(pextp->reset);
+
+	pextp->da_war = of_property_read_bool(np, "mediatek,usxgmii-performance-errata");
+
+	phy = devm_phy_create(&pdev->dev, NULL, &mtk_pextp_ops);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	phy_set_drvdata(phy, pextp);
+
+	phy_provider = devm_of_phy_provider_register(&pdev->dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id mtk_pextp_match[] = {
+	{ .compatible = "mediatek,mt7988-xfi-pextp", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mtk_pextp_match);
+
+static struct platform_driver mtk_pextp_driver = {
+	.probe = mtk_pextp_probe,
+	.driver = {
+		.name = "mtk-pextp",
+		.of_match_table = mtk_pextp_match,
+	},
+};
+module_platform_driver(mtk_pextp_driver);
+
+MODULE_DESCRIPTION("MediaTek pextp SerDes PHY driver");
+MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
+MODULE_LICENSE("GPL");
-- 
2.43.0
