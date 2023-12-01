Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C98680091D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378436AbjLAKxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378373AbjLAKxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:53:00 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840591700;
        Fri,  1 Dec 2023 02:53:03 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B1AqGF11299714, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B1AqGF11299714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Dec 2023 18:52:16 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 1 Dec 2023 18:52:16 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Dec 2023 18:52:15 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Fri, 1 Dec 2023 18:52:15 +0800
From:   Tzuyi Chang <tychang@realtek.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stanley Chang <stanley_chang@realtek.com>,
        Tzuyi Chang <tychang@realtek.com>
Subject: [PATCH 2/2] phy: realtek: pcie: Add PCIe PHY support for Realtek DHC RTD SoCs
Date:   Fri, 1 Dec 2023 18:52:07 +0800
Message-ID: <20231201105207.11786-3-tychang@realtek.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201105207.11786-1-tychang@realtek.com>
References: <20231201105207.11786-1-tychang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the phy driver to support PCIe PHY for Realtek DHC (Digital Home
Center) RTD SoCs.

Signed-off-by: Tzuyi Chang <tychang@realtek.com>
---
 drivers/phy/realtek/Kconfig        |   8 +
 drivers/phy/realtek/Makefile       |   1 +
 drivers/phy/realtek/phy-rtk-pcie.c | 738 +++++++++++++++++++++++++++++
 3 files changed, 747 insertions(+)
 create mode 100644 drivers/phy/realtek/phy-rtk-pcie.c

diff --git a/drivers/phy/realtek/Kconfig b/drivers/phy/realtek/Kconfig
index 75ac7e7c31ae..11c51f3714f1 100644
--- a/drivers/phy/realtek/Kconfig
+++ b/drivers/phy/realtek/Kconfig
@@ -29,4 +29,12 @@ config PHY_RTK_RTD_USB3PHY
 	  DWC3 USB IP. This driver will do the PHY initialization
 	  of the parameters.
 
+config PHY_RTD_PCIE
+	tristate "Realtek RTD PCIe PHY driver"
+	depends on OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the PCIe PHY on Realtek DHC (digital home center)
+	  RTD series SoCs.
+
 endif # ARCH_REALTEK || COMPILE_TEST
diff --git a/drivers/phy/realtek/Makefile b/drivers/phy/realtek/Makefile
index ed7b47ff8a26..a1f0ad199476 100644
--- a/drivers/phy/realtek/Makefile
+++ b/drivers/phy/realtek/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PHY_RTK_RTD_USB2PHY)	+= phy-rtk-usb2.o
 obj-$(CONFIG_PHY_RTK_RTD_USB3PHY)	+= phy-rtk-usb3.o
+obj-$(CONFIG_PHY_RTD_PCIE)			+= phy-rtk-pcie.o
diff --git a/drivers/phy/realtek/phy-rtk-pcie.c b/drivers/phy/realtek/phy-rtk-pcie.c
new file mode 100644
index 000000000000..8ec845890271
--- /dev/null
+++ b/drivers/phy/realtek/phy-rtk-pcie.c
@@ -0,0 +1,738 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Realtek DHC PCIe PHY driver
+ *
+ * Copyright (c) 2023 Realtek Semiconductor Corp.
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define PCIE_MDIO_CTR 0xC1C
+#define LINK_CONTROL_LINK_STATUS_REG 0x80
+#define MDIO_BUSY BIT(7)
+#define MDIO_RDY BIT(4)
+#define MDIO_SRST BIT(1)
+#define MDIO_WRITE BIT(0)
+#define MDIO_REG_SHIFT 8
+#define MDIO_DATA_SHIFT 16
+#define MDIO_TIMEOUT 100
+#define MDIO_DELAY_INTERVAL 5
+
+enum pcie_phy_speed {
+	PCIE_GEN1 = 1,
+	PCIE_GEN2 = 2,
+};
+
+struct rtd_pcie_phy {
+	struct regmap *pcie_regmap;
+	struct device *dev;
+};
+
+static void mdio_reset(struct rtd_pcie_phy *rtd_phy)
+{
+	regmap_write(rtd_phy->pcie_regmap, PCIE_MDIO_CTR, MDIO_SRST | MDIO_WRITE);
+}
+
+static int mdio_wait_busy(struct rtd_pcie_phy *rtd_phy)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read_poll_timeout(rtd_phy->pcie_regmap, PCIE_MDIO_CTR, val,
+				      (val & MDIO_BUSY) == 0, MDIO_DELAY_INTERVAL, MDIO_TIMEOUT);
+	if (ret) {
+		dev_err(rtd_phy->dev, "mdio is busy");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int write_mdio_reg(struct rtd_pcie_phy *rtd_phy, u8 reg, u16 data)
+{
+	unsigned int val;
+
+	val = (reg << MDIO_REG_SHIFT) | (data << MDIO_DATA_SHIFT) | MDIO_WRITE;
+	regmap_write(rtd_phy->pcie_regmap, PCIE_MDIO_CTR, val);
+
+	mdio_wait_busy(rtd_phy);
+
+	return 0;
+}
+
+static int read_mdio_reg(struct rtd_pcie_phy *rtd_phy, u8 reg)
+{
+	unsigned int addr;
+	unsigned int val;
+
+	addr = reg << MDIO_REG_SHIFT;
+	regmap_write(rtd_phy->pcie_regmap, PCIE_MDIO_CTR, addr);
+
+	mdio_wait_busy(rtd_phy);
+
+	regmap_read(rtd_phy->pcie_regmap, PCIE_MDIO_CTR, &val);
+
+	return val >> MDIO_DATA_SHIFT;
+}
+
+static int rtd_phy_write(struct rtd_pcie_phy *rtd_phy, int speed, u8 reg, u16 data)
+{
+	if (speed == PCIE_GEN2)
+		reg |= BIT(6);
+
+	return write_mdio_reg(rtd_phy, reg, data);
+}
+
+static int rtd_phy_read(struct rtd_pcie_phy *rtd_phy, int speed, u8 reg)
+{
+	if (speed == PCIE_GEN2)
+		reg |= BIT(6);
+
+	return read_mdio_reg(rtd_phy, reg);
+}
+
+static int rtd_phy_wait_for_status(struct rtd_pcie_phy *rtd_phy, int speed, u8 reg,
+				   u16 mask, u16 status)
+{
+	unsigned int addr;
+	unsigned int val;
+
+	if (speed == PCIE_GEN2)
+		reg |= BIT(6);
+
+	addr = reg << MDIO_REG_SHIFT;
+	regmap_write(rtd_phy->pcie_regmap, PCIE_MDIO_CTR, addr);
+
+	mdio_wait_busy(rtd_phy);
+
+	return regmap_read_poll_timeout(rtd_phy->pcie_regmap, PCIE_MDIO_CTR, val,
+					((val >> MDIO_DATA_SHIFT) & mask) == status,
+					MDIO_DELAY_INTERVAL, MDIO_TIMEOUT);
+}
+
+static int rtd_get_tx_swing_from_efuse(struct rtd_pcie_phy *rtd_phy)
+{
+	struct device_node *np = rtd_phy->dev->of_node;
+	int ret;
+
+	if (of_find_property(np, "nvmem-cell-names", NULL)) {
+		struct nvmem_cell *cell;
+		unsigned char *buf;
+
+		cell = nvmem_cell_get(rtd_phy->dev, "tx_swing_trim");
+		if (IS_ERR(cell)) {
+			dev_err(rtd_phy->dev, "missing nvmem resource");
+			return PTR_ERR(cell);
+		}
+		buf = nvmem_cell_read(cell, NULL);
+		nvmem_cell_put(cell);
+		if (IS_ERR(buf))
+			return PTR_ERR(buf);
+
+		ret = *buf;
+		kfree(buf);
+	} else {
+		dev_dbg(rtd_phy->dev, "can't find nvmem cell node");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static void rtd_set_tx_swing(struct rtd_pcie_phy *rtd_phy, int speed, u8 swing_val)
+{
+	int val;
+
+	val = rtd_phy_read(rtd_phy, speed, 0x20);
+	val &= ~GENMASK(7, 0);
+	val |= (swing_val | (swing_val << 4));
+	rtd_phy_write(rtd_phy, speed, 0x20, val);
+}
+
+static int rtd1319_pcie_phy_init(struct phy *phy)
+{
+	struct rtd_pcie_phy *rtd_phy = phy_get_drvdata(phy);
+
+	mdio_reset(rtd_phy);
+	/*Gen1*/
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x06, 0x000C);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x04, 0x52F5);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x06, 0x000C);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0A, 0xC210);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x29, 0xFF00);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x01, 0xA852);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0B, 0xB905);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x09, 0x620C);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x24, 0x4F08);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0D, 0xF712);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x23, 0xCB66);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x20, 0xC466);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x21, 0x5577);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x22, 0x0033);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x2F, 0x61BD);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0E, 0x1000);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x2B, 0xB801);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x1B, 0x8EA1);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x09, 0x600C);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x09, 0x620C);
+	/*Gen2*/
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x06, 0x000C);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x04, 0x52F5);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x0A, 0xC210);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x29, 0xFF00);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x01, 0xA84A);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x0B, 0xB905);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x09, 0x620C);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x24, 0x4F0C);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x0D, 0xF712);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x23, 0xCB66);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x20, 0xC466);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x21, 0x8866);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x22, 0x0033);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x2F, 0x91BD);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x0E, 0x1000);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x2B, 0xB801);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x1B, 0x8EA1);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x1E, 0x2CEB);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x09, 0x600C);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x09, 0x620C);
+
+	return 0;
+}
+
+static int rtd1619b_pcie_phy_general_init(struct phy *phy)
+{
+	struct rtd_pcie_phy *rtd_phy = phy_get_drvdata(phy);
+
+	mdio_reset(rtd_phy);
+	/*Gen1*/
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x29, 0xFF13);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x2A, 0x3D60);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x05, 0xFAD3);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x06, 0x0013);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x01, 0xA852);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0A, 0xB650);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x28, 0xF802);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0A, 0xB670);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x24, 0x4F10);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x23, 0x0B66);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x20, 0xC4CC);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x22, 0x0013);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x21, 0x55AA);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x2B, 0xA801);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x2F, 0xA008);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0B, 0x9905);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x09, 0x720C);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x29, 0xFF13);
+	/*Gen2*/
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x29, 0xFF13);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x2A, 0x3D60);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x05, 0xFAD3);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x1E, 0x6EEB);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x06, 0x0013);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x01, 0x484A);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x0A, 0xB650);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x28, 0xF802);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x23, 0x0B66);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x20, 0xC4EE);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x22, 0x0013);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x21, 0x55AA);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x2B, 0xA801);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x2F, 0xA008);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x0B, 0x9905);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x09, 0x720C);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x29, 0xFF13);
+
+	return 0;
+
+}
+
+static int rtd1619b_pcie1_phy_init(struct phy *phy)
+{
+	struct rtd_pcie_phy *rtd_phy = phy_get_drvdata(phy);
+	int tx_swing_otp;
+	u8 tx_swing_val;
+
+	rtd1619b_pcie_phy_general_init(phy);
+
+	/*tx swing trim*/
+	tx_swing_otp = rtd_get_tx_swing_from_efuse(rtd_phy);
+	if (tx_swing_otp >= 0) {
+		tx_swing_val = (tx_swing_otp & GENMASK(3, 0)) ^ 0xb;
+		rtd_set_tx_swing(rtd_phy, PCIE_GEN1, tx_swing_val);
+
+		tx_swing_val = ((tx_swing_otp & GENMASK(7, 4)) >> 4) ^ 0xb;
+		rtd_set_tx_swing(rtd_phy, PCIE_GEN2, tx_swing_val);
+	}
+
+	return 0;
+
+}
+
+static int rtd1619b_pcie2_phy_init(struct phy *phy)
+{
+	struct rtd_pcie_phy *rtd_phy = phy_get_drvdata(phy);
+	int tx_swing_otp;
+	u8 tx_swing_val;
+
+	mdio_reset(rtd_phy);
+	rtd1619b_pcie_phy_general_init(phy);
+
+	/*tx swing trim*/
+	tx_swing_otp = rtd_get_tx_swing_from_efuse(rtd_phy);
+	if (tx_swing_otp >= 0) {
+		tx_swing_val = ((tx_swing_otp & GENMASK(11, 8)) >> 8) ^ 0xb;
+		rtd_set_tx_swing(rtd_phy, PCIE_GEN1, tx_swing_val);
+
+		tx_swing_val = ((tx_swing_otp & GENMASK(15, 12)) >> 12) ^ 0xb;
+		rtd_set_tx_swing(rtd_phy, PCIE_GEN2, tx_swing_val);
+	}
+
+	return 0;
+
+}
+
+static int rtd1319d_pcie_phy_init(struct phy *phy)
+{
+	struct rtd_pcie_phy *rtd_phy = phy_get_drvdata(phy);
+	int tx_swing_otp;
+	u8 tx_swing_val;
+
+	mdio_reset(rtd_phy);
+	/*Gen1*/
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x01, 0xA852);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x04, 0xD2F5);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x06, 0x0017);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x09, 0x420C);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0A, 0x9270);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0B, 0xA905);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0C, 0xE000);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0D, 0xF71E);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0E, 0x1000);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x21, 0x77AA);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x22, 0x3813);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x23, 0x0B62);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x24, 0x4724);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x28, 0xF802);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x29, 0xFF10);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x2A, 0x3D61);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x2B, 0xB001);
+
+	/*Gen2*/
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x01, 0x304A);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x04, 0xD2F5);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x06, 0x0017);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x09, 0x420C);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x0A, 0x9250);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x0B, 0xA905);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x0C, 0xE000);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x0D, 0xF71E);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x0E, 0x1000);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x1E, 0x6EEB);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x20, 0xC4CC);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x21, 0x66AA);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x22, 0x3813);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x23, 0x0B62);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x28, 0xF802);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x29, 0xFF10);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x2A, 0x3D61);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x2B, 0xB001);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x2F, 0x9008);
+
+	/*tx swing trim*/
+	tx_swing_otp = rtd_get_tx_swing_from_efuse(rtd_phy);
+	if (tx_swing_otp >= 0) {
+		tx_swing_val = (tx_swing_otp & GENMASK(3, 0)) ^ 0xc;
+		rtd_set_tx_swing(rtd_phy, PCIE_GEN1, tx_swing_val);
+		rtd_set_tx_swing(rtd_phy, PCIE_GEN2, tx_swing_val);
+	}
+
+	return 0;
+}
+
+static int rtd1315e_pcie_phy_init(struct phy *phy)
+{
+	struct rtd_pcie_phy *rtd_phy = phy_get_drvdata(phy);
+	u8 tx_swing_val;
+	int tx_swing_otp;
+
+	mdio_reset(rtd_phy);
+	/*Gen1*/
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x01, 0x4052);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x04, 0xD2F5);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x09, 0x520C);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0A, 0x9270);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0B, 0x9B05);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x0E, 0x1001);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x22, 0x7823);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x23, 0x0EA2);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x24, 0x4720);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x28, 0xF802);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x29, 0xFF10);
+	rtd_phy_write(rtd_phy, PCIE_GEN1, 0x2A, 0x3D62);
+
+	/*Gen2*/
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x01, 0x404A);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x04, 0xD2F5);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x09, 0x520C);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x0B, 0x9B05);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x0E, 0x1001);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x1E, 0x6EEB);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x20, 0xC4CC);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x21, 0x66AA);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x22, 0x7823);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x23, 0x0EA2);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x28, 0xF802);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x29, 0xFF10);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x2F, 0x9008);
+	rtd_phy_write(rtd_phy, PCIE_GEN2, 0x2A, 0x3D62);
+
+	/*tx swing trim*/
+	tx_swing_otp = rtd_get_tx_swing_from_efuse(rtd_phy);
+	if (tx_swing_otp >= 0) {
+		tx_swing_val = (tx_swing_otp & GENMASK(3, 0)) ^ 0xc;
+		rtd_set_tx_swing(rtd_phy, PCIE_GEN1, tx_swing_val);
+		rtd_set_tx_swing(rtd_phy, PCIE_GEN2, tx_swing_val);
+	}
+
+	return 0;
+}
+
+static u8 gray_to_binary(u8 gray)
+{
+	u8 binary;
+
+	binary = gray & BIT(4);
+	binary |= (gray ^ (binary >> 1)) & BIT(3);
+	binary |= (gray ^ (binary >> 1)) & BIT(2);
+	binary |= (gray ^ (binary >> 1)) & BIT(1);
+	binary |= (gray ^ (binary >> 1)) & BIT(0);
+
+	return binary;
+}
+
+static void pcie_LEQ_calibrate(struct rtd_pcie_phy *rtd_phy, int speed)
+{
+	u8 binary_code;
+	u8 gray_code;
+	int val;
+
+	val = rtd_phy_read(rtd_phy, speed, 0x1f);
+	gray_code = (val & GENMASK(15, 11)) >> 11;
+	binary_code = gray_to_binary(gray_code);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x24);
+	val = (val & ~GENMASK(6, 2)) | (binary_code << 2);
+	rtd_phy_write(rtd_phy, speed, 0x24, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x0a);
+	val = val | BIT(5);
+	rtd_phy_write(rtd_phy, speed, 0x0a, val);
+}
+
+static int pcie_front_end_offset_calibrate(struct rtd_pcie_phy *rtd_phy, int speed)
+{
+	int val;
+	int ret;
+
+	ret = rtd_phy_wait_for_status(rtd_phy, speed, 0x1f, BIT(15), BIT(15));
+	if (ret) {
+		dev_err(rtd_phy->dev, "%s: Gen%d: beginning: timeout for waiting 0x1f[15] = 1",
+			__func__, speed);
+		return -EBUSY;
+	}
+
+	val = rtd_phy_read(rtd_phy, speed, 0x0D);
+	val &= ~BIT(6);
+	rtd_phy_write(rtd_phy, speed, 0x0D, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x19);
+	val &= ~BIT(2);
+	rtd_phy_write(rtd_phy, speed, 0x19, val);
+
+	rtd_phy_write(rtd_phy, speed, 0x10, 0x000C);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x1f);
+	val = (val & GENMASK(4, 1)) >> 1;
+	if ((val != 0x0 && val != 0xf))
+		return 0;
+
+	val = rtd_phy_read(rtd_phy, speed, 0x0B);
+	val |= 0x3 << 2;
+	rtd_phy_write(rtd_phy, speed, 0x0B, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x09);
+	val |= BIT(9);
+	rtd_phy_write(rtd_phy, speed, 0x09, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x09);
+	val &= ~BIT(9);
+	rtd_phy_write(rtd_phy, speed, 0x09, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x09);
+	val |= BIT(9);
+	rtd_phy_write(rtd_phy, speed, 0x09, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x0D);
+	val |= BIT(6);
+	rtd_phy_write(rtd_phy, speed, 0x0D, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x19);
+	val |= BIT(2);
+	rtd_phy_write(rtd_phy, speed, 0x19, val);
+
+	rtd_phy_write(rtd_phy, speed, 0x10, 0x3C4);
+
+	ret = rtd_phy_wait_for_status(rtd_phy, speed, 0x1f, BIT(15), BIT(15));
+	if (ret) {
+		dev_err(rtd_phy->dev, "%s: Gen%d: end: timeout for waiting 0x1f[15] = 1",
+			__func__, speed);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int pcie_OOBS_calibrate(struct rtd_pcie_phy *rtd_phy, int speed)
+{
+	int val;
+	int tmp;
+	int ret;
+
+	val = rtd_phy_read(rtd_phy, speed, 0x09);
+	val &= ~BIT(4);
+	rtd_phy_write(rtd_phy, speed, 0x09, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x09);
+	val |= BIT(9);
+	rtd_phy_write(rtd_phy, speed, 0x09, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x09);
+	val &= ~BIT(9);
+	rtd_phy_write(rtd_phy, speed, 0x09, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x09);
+	val |= BIT(9);
+	rtd_phy_write(rtd_phy, speed, 0x09, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x0D);
+	val |= BIT(6);
+	rtd_phy_write(rtd_phy, speed, 0x0D, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x19);
+	val |= BIT(2);
+	rtd_phy_write(rtd_phy, speed, 0x19, val);
+
+	rtd_phy_write(rtd_phy, speed, 0x10, 0x03C4);
+
+	ret = rtd_phy_wait_for_status(rtd_phy, speed, 0x1f, BIT(6), 0);
+	if (ret) {
+		dev_err(rtd_phy->dev, "%s: Gen%d: timeout for waiting 0x1f[6] = 0",
+			__func__, speed);
+		return -EBUSY;
+	}
+
+	mdelay(1);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x19);
+	val |= BIT(2);
+	rtd_phy_write(rtd_phy, speed, 0x19, val);
+
+	rtd_phy_write(rtd_phy, speed, 0x10, 0x03C4);
+
+	tmp = rtd_phy_read(rtd_phy, speed, 0x1f);
+	tmp = (tmp & GENMASK(12, 8)) >> 8;
+	val = rtd_phy_read(rtd_phy, speed, 0x03);
+	val = (val & ~GENMASK(5, 1)) | (tmp << 1);
+	rtd_phy_write(rtd_phy, speed, 0x03, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x09);
+	val |= BIT(4);
+	rtd_phy_write(rtd_phy, speed, 0x09, val);
+
+	return 0;
+}
+
+static void rtd1319_pcie_front_end_offset_calibrate(struct rtd_pcie_phy *rtd_phy, int speed)
+{
+	int val;
+	int tmp;
+
+	val = rtd_phy_read(rtd_phy, speed, 0x1f);
+	val = (val & GENMASK(4, 1)) >> 1;
+
+	tmp = rtd_phy_read(rtd_phy, speed, 0x0b);
+	val = (tmp & ~GENMASK(8, 5)) | (val << 5);
+	rtd_phy_write(rtd_phy, speed, 0x0b, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x0d);
+	val &= ~BIT(13);
+	rtd_phy_write(rtd_phy, speed, 0x0d, val);
+}
+
+static void rtd1319_pcie_LEQ_calibrate(struct rtd_pcie_phy *rtd_phy, int speed)
+{
+	u8 binary_code;
+	u8 gray_code;
+	int val;
+
+	val = rtd_phy_read(rtd_phy, speed, 0x1f);
+	gray_code = (val & GENMASK(15, 11)) >> 11;
+	binary_code = gray_to_binary(gray_code);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x24);
+	val = (val & ~GENMASK(6, 2)) | (binary_code << 2);
+	rtd_phy_write(rtd_phy, speed, 0x24, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x0a);
+	val = val | BIT(5);
+	rtd_phy_write(rtd_phy, speed, 0x0a, val);
+
+	val = rtd_phy_read(rtd_phy, speed, 0x0a);
+	val = val | BIT(6);
+	rtd_phy_write(rtd_phy, speed, 0x0a, val);
+
+}
+
+static int rtd_pcie_phy_calibrate(struct phy *phy)
+{
+	struct rtd_pcie_phy *rtd_phy = phy_get_drvdata(phy);
+	unsigned int val;
+	int speed;
+
+	regmap_read(rtd_phy->pcie_regmap, LINK_CONTROL_LINK_STATUS_REG, &val);
+	speed = (val & GENMASK(19, 16)) >> 16;
+	pcie_OOBS_calibrate(rtd_phy, speed);
+	pcie_front_end_offset_calibrate(rtd_phy, speed);
+	if (speed == 2)
+		pcie_LEQ_calibrate(rtd_phy, speed);
+
+	return 0;
+}
+
+static int rtd1319_pcie_phy_calibrate(struct phy *phy)
+{
+	struct rtd_pcie_phy *rtd_phy = phy_get_drvdata(phy);
+	unsigned int val;
+	int speed;
+
+	regmap_read(rtd_phy->pcie_regmap, LINK_CONTROL_LINK_STATUS_REG, &val);
+	speed = (val & GENMASK(19, 16)) >> 16;
+	rtd1319_pcie_front_end_offset_calibrate(rtd_phy, speed);
+	rtd1319_pcie_LEQ_calibrate(rtd_phy, speed);
+
+	return 0;
+}
+
+static const struct phy_ops rtd1319_pcie_phy_ops = {
+	.init		= rtd1319_pcie_phy_init,
+	.calibrate	= rtd1319_pcie_phy_calibrate,
+	.owner		= THIS_MODULE,
+};
+
+static const struct phy_ops rtd1619b_pcie1_phy_ops = {
+	.init		= rtd1619b_pcie1_phy_init,
+	.calibrate	= rtd_pcie_phy_calibrate,
+	.owner		= THIS_MODULE,
+};
+
+static const struct phy_ops rtd1619b_pcie2_phy_ops = {
+	.init		= rtd1619b_pcie2_phy_init,
+	.calibrate	= rtd_pcie_phy_calibrate,
+	.owner		= THIS_MODULE,
+};
+
+static const struct phy_ops rtd1319d_pcie_phy_ops = {
+	.init		= rtd1319d_pcie_phy_init,
+	.calibrate	= rtd_pcie_phy_calibrate,
+	.owner		= THIS_MODULE,
+};
+
+static const struct phy_ops rtd1315e_pcie_phy_ops = {
+	.init		= rtd1315e_pcie_phy_init,
+	.calibrate	= rtd_pcie_phy_calibrate,
+	.owner		= THIS_MODULE,
+};
+
+static int rtd_pcie_phy_probe(struct platform_device *pdev)
+{
+	struct device_node *pcie_np;
+	struct rtd_pcie_phy *rtd_phy;
+	const struct phy_ops *ops;
+	struct phy_provider *phy_provider;
+	struct phy *phy;
+	int ret = 0;
+
+	rtd_phy = devm_kzalloc(&pdev->dev, sizeof(*rtd_phy), GFP_KERNEL);
+	if (!rtd_phy)
+		return -ENOMEM;
+
+	rtd_phy->dev = &pdev->dev;
+
+	ops = device_get_match_data(rtd_phy->dev);
+	if (!ops)
+		return -EINVAL;
+
+	pcie_np = of_parse_phandle(rtd_phy->dev->of_node, "realtek,pcie-syscon", 0);
+	if (!pcie_np) {
+		dev_err(rtd_phy->dev, "failed to get pcie-controller phandle");
+		return -ENODEV;
+	}
+
+	rtd_phy->pcie_regmap = device_node_to_regmap(pcie_np);
+	if (IS_ERR(rtd_phy->pcie_regmap)) {
+		of_node_put(pcie_np);
+		ret = PTR_ERR(rtd_phy->pcie_regmap);
+		goto err_node_put;
+	}
+
+	phy = devm_phy_create(rtd_phy->dev, rtd_phy->dev->of_node, ops);
+	if (IS_ERR(phy)) {
+		ret = PTR_ERR(rtd_phy->pcie_regmap);
+		goto err_node_put;
+	}
+
+	phy_set_drvdata(phy, rtd_phy);
+
+	of_node_put(pcie_np);
+
+	phy_provider = devm_of_phy_provider_register(rtd_phy->dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+
+err_node_put:
+	of_node_put(pcie_np);
+	return ret;
+}
+
+static const struct of_device_id rtd_pcie_phy_of_match[] = {
+	{ .compatible = "realtek,rtd1319-pcie0-phy", .data = &rtd1319_pcie_phy_ops},
+	{ .compatible = "realtek,rtd1319-pcie1-phy", .data = &rtd1319_pcie_phy_ops},
+	{ .compatible = "realtek,rtd1319-pcie2-phy", .data = &rtd1319_pcie_phy_ops},
+	{ .compatible = "realtek,rtd1619b-pcie1-phy", .data = &rtd1619b_pcie1_phy_ops},
+	{ .compatible = "realtek,rtd1619b-pcie2-phy", .data = &rtd1619b_pcie2_phy_ops},
+	{ .compatible = "realtek,rtd1319d-pcie1-phy", .data = &rtd1319d_pcie_phy_ops},
+	{ .compatible = "realtek,rtd1315e-pcie1-phy", .data = &rtd1315e_pcie_phy_ops},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rtd_pcie_phy_of_match);
+
+static struct platform_driver rtd_pcie_phy_driver = {
+	.probe	= rtd_pcie_phy_probe,
+	.driver	= {
+		.name = "rtd-pcie-phy",
+		.of_match_table	= rtd_pcie_phy_of_match,
+	},
+};
+
+module_platform_driver(rtd_pcie_phy_driver);
+
+MODULE_DESCRIPTION("Realtek PCIe PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.43.0

