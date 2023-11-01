Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AFA7DDC6C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376763AbjKAFqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 01:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376753AbjKAFpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 01:45:55 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF10E4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 22:45:47 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3A15ijZJ023658;
        Wed, 1 Nov 2023 13:44:45 +0800 (+08)
        (envelope-from pu.li@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SKwnc6bYWz2LjbCt;
        Wed,  1 Nov 2023 13:40:04 +0800 (CST)
Received: from zebjkernups01.spreadtrum.com (10.0.93.153) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 1 Nov 2023 13:44:43 +0800
From:   Pu Li <pu.li@unisoc.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Pu Li <pu.li@unisoc.com>, Zhiyong Liu <zhiyong.liu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] phy: sprd: Add Spreadtrum usb20 hsphy driver
Date:   Wed, 1 Nov 2023 13:44:32 +0800
Message-ID: <20231101054432.27509-3-pu.li@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231101054432.27509-1-pu.li@unisoc.com>
References: <20231101054432.27509-1-pu.li@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.93.153]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 3A15ijZJ023658
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Spreadtrum platform USB20 HSPHY driver support. This driver
takes care of all the PHY functionality, normally paired with
DesignWare USB20 (DRD) Controller or Spreadtrum musb phy (DRD )controller.

Signed-off-by: Pu Li <pu.li@unisoc.com>
---
 drivers/phy/Kconfig                  |    1 +
 drivers/phy/Makefile                 |    1 +
 drivers/phy/sprd/Kconfig             |   14 +
 drivers/phy/sprd/Makefile            |    6 +
 drivers/phy/sprd/phy-sprd-usb20-hs.c | 1324 ++++++++++++++++++++++++++
 drivers/phy/sprd/phy-sprd-usb20-hs.h |  525 ++++++++++
 6 files changed, 1871 insertions(+)
 create mode 100644 drivers/phy/sprd/Kconfig
 create mode 100644 drivers/phy/sprd/Makefile
 create mode 100644 drivers/phy/sprd/phy-sprd-usb20-hs.c
 create mode 100644 drivers/phy/sprd/phy-sprd-usb20-hs.h

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index d1670bbe6d6b..309eb623f8b3 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -92,6 +92,7 @@ source "drivers/phy/renesas/Kconfig"
 source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/samsung/Kconfig"
 source "drivers/phy/socionext/Kconfig"
+source "drivers/phy/sprd/Kconfig"
 source "drivers/phy/st/Kconfig"
 source "drivers/phy/starfive/Kconfig"
 source "drivers/phy/sunplus/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 868a220ed0f6..d83cb5917d08 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -31,6 +31,7 @@ obj-y					+= allwinner/	\
 					   rockchip/	\
 					   samsung/	\
 					   socionext/	\
+					   sprd/	\
 					   st/		\
 					   starfive/	\
 					   sunplus/	\
diff --git a/drivers/phy/sprd/Kconfig b/drivers/phy/sprd/Kconfig
new file mode 100644
index 000000000000..c43884012ef8
--- /dev/null
+++ b/drivers/phy/sprd/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Phy drivers for Spreadtrum platforms
+#
+
+config SPRD_USB20_HSPHY
+	tristate "Spreadtrum USB20 HSPHY Driver"
+	select USB_PHY
+	depends on ARCH_SPRD || COMPILE_TEST
+	help
+	  Enable this to support the SPRD USB20 High Speed PHY that is part of SOC.
+	  This driver takes care of all the PHY functionality,
+	  normally paired with DesignWare USB20 (DRD) Controller or
+	  Spreadtrum musb phy (DRD )controller.
diff --git a/drivers/phy/sprd/Makefile b/drivers/phy/sprd/Makefile
new file mode 100644
index 000000000000..b102f3515d47
--- /dev/null
+++ b/drivers/phy/sprd/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for physical layer drivers
+#
+
+obj-$(CONFIG_SPRD_USB20_HSPHY)     	+= phy-sprd-usb20-hs.o
diff --git a/drivers/phy/sprd/phy-sprd-usb20-hs.c b/drivers/phy/sprd/phy-sprd-usb20-hs.c
new file mode 100644
index 000000000000..8262a745fc74
--- /dev/null
+++ b/drivers/phy/sprd/phy-sprd-usb20-hs.c
@@ -0,0 +1,1324 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2023 Unisoc Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/iio/consumer.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include <linux/usb/otg.h>
+#include <uapi/linux/usb/charger.h>
+
+#include "phy-sprd-usb20-hs.h"
+
+static const struct sprd_hsphy_cfg *phy_cfg;
+
+/* phy_v1 cfg ops */
+static void phy_v1_usb_enable_ctrl(struct sprd_hsphy *phy, int on) {}
+
+static void phy_v1_usb_phy_power_ctrl(struct sprd_hsphy *phy, int on)
+{
+	u32 reg, msk;
+
+	if (on == CTRL0) {
+		reg = msk = phy_cfg->masks[MASK_AON_APB_USB_PHY_PD_L] |
+			phy_cfg->masks[MASK_AON_APB_USB_PHY_PD_S];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_PWR_CTRL], msk, reg);
+
+		if (phy_cfg->owner == PIKE2) {
+			reg = readl_relaxed(phy->base + phy_cfg->regs[REG_AP_AHB_OTG_CTRL0]);
+			reg &= ~0x1;
+			writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_CTRL0]);
+		}
+	} else if (on == CTRL1) {
+		if (phy_cfg->owner == PIKE2) {
+			reg = readl_relaxed(phy->base + phy_cfg->regs[REG_AP_AHB_OTG_CTRL0]);
+			reg |= 0x1;
+			writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_CTRL0]);
+		}
+
+		msk = phy_cfg->masks[MASK_AON_APB_USB_PHY_PD_L] |
+			phy_cfg->masks[MASK_AON_APB_USB_PHY_PD_S];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_PWR_CTRL], msk, 0);
+	} else if (on == CTRL2) {
+		reg = msk = phy_cfg->masks[MASK_AON_APB_USB_PHY_PD_L] |
+			phy_cfg->masks[MASK_AON_APB_USB_PHY_PD_S];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_PWR_CTRL], msk, reg);
+	}
+}
+
+static void phy_v1_usb_vbus_ctrl(struct sprd_hsphy *phy, int on)
+{
+	u32 reg;
+
+	reg = readl_relaxed(phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_TEST]);
+	if (on) {
+		reg |= (phy_cfg->masks[MASK_AP_AHB_OTG_VBUS_VALID_EXT] |
+			phy_cfg->masks[MASK_AP_AHB_OTG_VBUS_VALID_PHYREG]);
+	} else {
+		reg &= ~(phy_cfg->masks[MASK_AP_AHB_OTG_VBUS_VALID_EXT] |
+			phy_cfg->masks[MASK_AP_AHB_OTG_VBUS_VALID_PHYREG]);
+	}
+	writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_TEST]);
+}
+
+static void phy_v1_utmi_width_sel(struct sprd_hsphy *phy)
+{
+	u32 reg;
+
+	reg = readl_relaxed(phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_CTRL]);
+	reg &= ~(phy_cfg->masks[MASK_AP_AHB_UTMI_WIDTH_SEL] |
+		phy_cfg->masks[MASK_AP_AHB_USB2_DATABUS16_8]);
+	writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_CTRL]);
+}
+
+static void phy_v1_reset_core(struct sprd_hsphy *phy)
+{
+	u32 reg;
+
+	reg = readl_relaxed(phy->base + phy_cfg->regs[REG_AP_AHB_AHB_RST]);
+	reg = phy_cfg->masks[MASK_AP_AHB_OTG_PHY_SOFT_RST] |
+		phy_cfg->masks[MASK_AP_AHB_OTG_UTMI_SOFT_RST] |
+		phy_cfg->masks[MASK_AP_AHB_OTG_SOFT_RST];
+	writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_AHB_RST] + 0x1000);
+
+	usleep_range(20000, 30000);
+	writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_AHB_RST] + 0x2000);
+}
+
+static int phy_v1_set_mode(struct sprd_hsphy *phy, int on)
+{
+	u32 reg;
+
+	if (on) {
+		reg = phy->host_otg_ctrl0;
+		writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_CTRL0]);
+		reg = phy->host_otg_ctrl1;
+		writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_CTRL1]);
+
+		reg = readl_relaxed(phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_CTRL]);
+		reg &= ~phy_cfg->masks[MASK_AP_AHB_USB2_PHY_IDDIG];
+		reg |= phy_cfg->masks[MASK_AP_AHB_OTG_DPPULLDOWN] |
+			phy_cfg->masks[MASK_AP_AHB_OTG_DMPULLDOWN];
+		writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_CTRL]);
+
+		reg = readl_relaxed(phy->base + phy_cfg->regs[REG_AP_AHB_OTG_CTRL0]);
+		reg |= 0x200;
+		writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_CTRL0]);
+		phy->is_host = true;
+	} else {
+		reg = phy->device_otg_ctrl0;
+		writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_CTRL0]);
+		reg = phy->device_otg_ctrl1;
+		writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_CTRL1]);
+
+		reg = readl_relaxed(phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_CTRL]);
+		reg |= phy_cfg->masks[MASK_AP_AHB_USB2_PHY_IDDIG];
+		reg &= ~(phy_cfg->masks[MASK_AP_AHB_OTG_DPPULLDOWN] |
+			phy_cfg->masks[MASK_AP_AHB_OTG_DMPULLDOWN]);
+		writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_CTRL]);
+
+		reg = readl_relaxed(phy->base + phy_cfg->regs[REG_AP_AHB_OTG_CTRL0]);
+		reg &= ~0x200;
+		writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_CTRL0]);
+		phy->is_host = false;
+	}
+	return 0;
+}
+
+static const struct sprd_hsphy_cfg_ops phy_v1_cfg_ops = {
+	.usb_enable_ctrl = phy_v1_usb_enable_ctrl,
+	.usb_phy_power_ctrl = phy_v1_usb_phy_power_ctrl,
+	.usb_vbus_ctrl = phy_v1_usb_vbus_ctrl,
+	.utmi_width_sel = phy_v1_utmi_width_sel,
+	.reset_core = phy_v1_reset_core,
+	.set_mode = phy_v1_set_mode,
+};
+
+/* phy_v2 cfg ops */
+static void phy_v2_usb_enable_ctrl(struct sprd_hsphy *phy, int on)
+{
+	u32 reg, msk;
+
+	if (on == CTRL0) {
+		msk = phy_cfg->masks[MASK_AON_APB_OTG_REF_EB];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_APB_EB2], msk, 0);
+	} else if (on == CTRL1) {
+		reg = msk = phy_cfg->masks[MASK_AON_APB_OTG_REF_EB];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_APB_EB2], msk, reg);
+	} else if (on == CTRL2) {
+		reg = msk = phy_cfg->masks[MASK_AP_AHB_OTG_EB];
+		regmap_update_bits(phy->ap_ahb, phy_cfg->regs[REG_AP_AHB_AHB_EB], msk, reg);
+		reg = msk = phy_cfg->masks[MASK_AON_APB_ANLG_APB_EB] |
+			phy_cfg->masks[MASK_AON_APB_ANLG_EB] |
+			phy_cfg->masks[MASK_AON_APB_OTG_REF_EB];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_APB_EB2], msk, reg);
+	}
+}
+
+static void phy_v2_usb_phy_power_ctrl(struct sprd_hsphy *phy, int on)
+{
+	u32 reg, msk;
+
+	if (on == CTRL0) {
+		reg = msk = phy_cfg->masks[MASK_AON_APB_USB_ISO_SW_EN];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_PWR_CTRL], msk, reg);
+		usleep_range(10000, 15000);
+		reg = msk = phy_cfg->masks[MASK_AON_APB_USB_PHY_PD_L] |
+			phy_cfg->masks[MASK_AON_APB_USB_PHY_PD_S];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_PWR_CTRL], msk, reg);
+	} else if (on == CTRL1) {
+		msk = phy_cfg->masks[MASK_AON_APB_USB_PHY_PD_L] |
+			phy_cfg->masks[MASK_AON_APB_USB_PHY_PD_S] |
+			phy_cfg->masks[MASK_AON_APB_USB_ISO_SW_EN];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_PWR_CTRL], msk, 0);
+	} else if (on == CTRL2) {
+		reg = msk = phy_cfg->masks[MASK_AON_APB_USB_PHY_PD_L] |
+			phy_cfg->masks[MASK_AON_APB_USB_PHY_PD_S];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_PWR_CTRL], msk, reg);
+	}
+}
+
+static void phy_v2_usb_vbus_ctrl(struct sprd_hsphy *phy, int on)
+{
+	u32 reg, msk;
+
+	if (on) {
+		reg = readl_relaxed(phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_TEST]);
+		reg |= phy_cfg->masks[MASK_AP_AHB_OTG_VBUS_VALID_PHYREG];
+		writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_TEST]);
+
+		reg = msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_VBUSVLDEXT];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL1], msk, reg);
+	} else {
+		reg = readl_relaxed(phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_TEST]);
+		reg &= ~phy_cfg->masks[MASK_AP_AHB_OTG_VBUS_VALID_PHYREG];
+		writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_TEST]);
+
+		msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_VBUSVLDEXT];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL1], msk, 0);
+	}
+}
+
+static void phy_v2_utmi_width_sel(struct sprd_hsphy *phy)
+{
+	u32 reg, msk;
+
+	reg = msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_DATABUS16_8];
+	regmap_update_bits(phy->analog,
+		phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL1], msk, reg);
+
+	reg = readl_relaxed(phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_CTRL]);
+	reg |= phy_cfg->masks[MASK_AP_AHB_UTMI_WIDTH_SEL];
+	writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_CTRL]);
+}
+
+static void phy_v2_reset_core(struct sprd_hsphy *phy)
+{
+	u32 msk1, msk2;
+
+	msk1 = phy_cfg->masks[MASK_AP_AHB_OTG_UTMI_SOFT_RST] |
+		phy_cfg->masks[MASK_AP_AHB_OTG_SOFT_RST];
+	regmap_update_bits(phy->ap_ahb, phy_cfg->regs[REG_AP_AHB_AHB_RST], msk1, msk1);
+	msk2 = phy_cfg->masks[MASK_AON_APB_OTG_PHY_SOFT_RST];
+	regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_APB_RST2], msk2, msk2);
+
+	usleep_range(20000, 30000);
+	regmap_update_bits(phy->ap_ahb, phy_cfg->regs[REG_AP_AHB_AHB_RST], msk1, 0);
+	regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_APB_RST2], msk2, 0);
+}
+
+static int phy_v2_set_mode(struct sprd_hsphy *phy, int on)
+{
+	u32 reg, msk;
+
+	if (on) {
+		reg = phy->host_eye_pattern;
+		regmap_write(phy->analog, phy_cfg->regs[REG_ANALOG_USB20_USB20_TRIMMING], reg);
+
+		msk = phy_cfg->masks[MASK_ANALOG_USB20_UTMIOTG_IDDG];
+		regmap_update_bits(phy->analog, phy_cfg->regs[REG_ANALOG_USB20_IDDG], msk, 0);
+
+		reg = msk = phy_cfg->masks[MASK_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN] |
+			phy_cfg->masks[MASK_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_REG_SEL_CFG_0], msk, reg);
+		reg = msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_DMPULLDOWN] |
+			phy_cfg->masks[MASK_ANALOG_USB20_USB20_DPPULLDOWN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL2], msk, reg);
+
+		msk = 0x200;
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL1], msk, msk);
+		phy->is_host = true;
+	} else {
+		reg = phy->device_eye_pattern;
+		regmap_write(phy->analog, phy_cfg->regs[REG_ANALOG_USB20_USB20_TRIMMING], reg);
+
+		reg = msk = phy_cfg->masks[MASK_ANALOG_USB20_UTMIOTG_IDDG];
+		regmap_update_bits(phy->analog, phy_cfg->regs[REG_ANALOG_USB20_IDDG], msk, reg);
+
+		reg = msk = phy_cfg->masks[MASK_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN] |
+			phy_cfg->masks[MASK_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_REG_SEL_CFG_0], msk, reg);
+		msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_DMPULLDOWN] |
+			phy_cfg->masks[MASK_ANALOG_USB20_USB20_DPPULLDOWN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL2], msk, 0);
+
+		msk = 0x200;
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL1], msk, 0);
+		phy->is_host = false;
+	}
+	return 0;
+}
+
+static const struct sprd_hsphy_cfg_ops phy_v2_cfg_ops = {
+	.usb_enable_ctrl = phy_v2_usb_enable_ctrl,
+	.usb_phy_power_ctrl = phy_v2_usb_phy_power_ctrl,
+	.usb_vbus_ctrl = phy_v2_usb_vbus_ctrl,
+	.utmi_width_sel = phy_v2_utmi_width_sel,
+	.reset_core = phy_v2_reset_core,
+	.set_mode = phy_v2_set_mode,
+};
+
+/* phy_v3 cfg ops */
+static void phy_v3_usb_enable_ctrl(struct sprd_hsphy *phy, int on)
+{
+	u32 reg, msk;
+
+	if (on == CTRL0) {
+		msk = phy_cfg->masks[MASK_AON_APB_CGM_OTG_REF_EN] |
+			phy_cfg->masks[MASK_AON_APB_CGM_DPHY_REF_EN];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_CGM_REG1], msk, 0);
+	} else if (on == CTRL1) {
+		reg = msk = phy_cfg->masks[MASK_AON_APB_OTG_UTMI_EB];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_APB_EB1], msk, reg);
+		reg = msk = phy_cfg->masks[MASK_AON_APB_CGM_OTG_REF_EN] |
+			phy_cfg->masks[MASK_AON_APB_CGM_DPHY_REF_EN];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_CGM_REG1], msk, reg);
+	} else if (on == CTRL2) {
+		reg = msk = phy_cfg->masks[MASK_AON_APB_OTG_UTMI_EB] |
+			phy_cfg->masks[MASK_AON_APB_ANA_EB];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_APB_EB1], msk, reg);
+		reg = msk = phy_cfg->masks[MASK_AON_APB_CGM_OTG_REF_EN] |
+			phy_cfg->masks[MASK_AON_APB_CGM_DPHY_REF_EN];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_CGM_REG1], msk, reg);
+	}
+}
+
+static void phy_v3_usb_phy_power_ctrl(struct sprd_hsphy *phy, int on)
+{
+	u32 reg, msk;
+
+	if (on == CTRL0) {
+		reg = msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_PS_PD_L] |
+			phy_cfg->masks[MASK_ANALOG_USB20_USB20_PS_PD_S];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_BATTER_PLL], msk, reg);
+		reg = msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_ISO_SW_EN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_ISO_SW], msk, reg);
+	} else if (on == CTRL1) {
+		msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_ISO_SW_EN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_ISO_SW], msk, 0);
+		msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_PS_PD_L] |
+			phy_cfg->masks[MASK_ANALOG_USB20_USB20_PS_PD_S];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_BATTER_PLL], msk, 0);
+	} else if (on == CTRL2) {
+		reg = msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_PS_PD_L] |
+			phy_cfg->masks[MASK_ANALOG_USB20_USB20_PS_PD_S];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_BATTER_PLL], msk, reg);
+	}
+}
+
+static void phy_v3_usb_vbus_ctrl(struct sprd_hsphy *phy, int on)
+{
+	u32 reg, msk;
+
+	msk = phy_cfg->masks[MASK_AON_APB_OTG_VBUS_VALID_PHYREG];
+	reg = on ? msk : 0;
+	regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_OTG_PHY_TEST], msk, reg);
+
+	msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_VBUSVLDEXT];
+	reg = on ? msk : 0;
+	regmap_update_bits(phy->analog,
+		phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL1], msk, reg);
+}
+
+static void phy_v3_utmi_width_sel(struct sprd_hsphy *phy)
+{
+	u32 reg, msk;
+
+	reg = msk = phy_cfg->masks[MASK_AON_APB_UTMI_WIDTH_SEL];
+	regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_OTG_PHY_CTRL], msk, reg);
+
+	reg = msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_DATABUS16_8];
+	regmap_update_bits(phy->analog,
+		phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL1], msk, reg);
+}
+
+static void phy_v3_reset_core(struct sprd_hsphy *phy)
+{
+	u32 reg, msk;
+
+	reg = msk = phy_cfg->masks[MASK_AON_APB_OTG_PHY_SOFT_RST] |
+		phy_cfg->masks[MASK_AON_APB_OTG_UTMI_SOFT_RST];
+	regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_APB_RST1], msk, reg);
+
+	usleep_range(20000, 30000);
+	regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_APB_RST1], msk, 0);
+}
+
+static int phy_v3_set_mode(struct sprd_hsphy *phy, int on)
+{
+	u32 reg, msk;
+
+	if (on) {
+		reg = phy->host_eye_pattern;
+		regmap_write(phy->analog, phy_cfg->regs[REG_ANALOG_USB20_USB20_TRIMMING], reg);
+
+		msk = phy_cfg->masks[MASK_AON_APB_USB2_PHY_IDDIG];
+		regmap_update_bits(phy->aon_apb,
+			phy_cfg->regs[REG_AON_APB_OTG_PHY_CTRL], msk, 0);
+
+		reg = msk = phy_cfg->masks[MASK_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN] |
+			phy_cfg->masks[MASK_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_REG_SEL_CFG_0], msk, reg);
+		reg = msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_DMPULLDOWN] |
+			phy_cfg->masks[MASK_ANALOG_USB20_USB20_DPPULLDOWN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL2], msk, reg);
+
+		reg = 0x200;
+		msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_RESERVED];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL1], msk, reg);
+		phy->is_host = true;
+	} else {
+		reg = phy->device_eye_pattern;
+		regmap_write(phy->analog, phy_cfg->regs[REG_ANALOG_USB20_USB20_TRIMMING], reg);
+
+		reg = msk = phy_cfg->masks[MASK_AON_APB_USB2_PHY_IDDIG];
+		regmap_update_bits(phy->aon_apb,
+			phy_cfg->regs[REG_AON_APB_OTG_PHY_CTRL], msk, reg);
+
+		reg = msk = phy_cfg->masks[MASK_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN] |
+			phy_cfg->masks[MASK_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_REG_SEL_CFG_0], msk, reg);
+		msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_DMPULLDOWN] |
+			phy_cfg->masks[MASK_ANALOG_USB20_USB20_DPPULLDOWN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL2], msk, 0);
+
+		msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_RESERVED];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL1], msk, 0);
+		phy->is_host = false;
+	}
+	return 0;
+}
+
+static const struct sprd_hsphy_cfg_ops phy_v3_cfg_ops = {
+	.usb_enable_ctrl = phy_v3_usb_enable_ctrl,
+	.usb_phy_power_ctrl = phy_v3_usb_phy_power_ctrl,
+	.usb_vbus_ctrl = phy_v3_usb_vbus_ctrl,
+	.utmi_width_sel = phy_v3_utmi_width_sel,
+	.reset_core = phy_v3_reset_core,
+	.set_mode = phy_v3_set_mode,
+};
+
+/* phy_v4 cfg ops */
+static void phy_v4_usb_enable_ctrl(struct sprd_hsphy *phy, int on)
+{
+	u32 reg, msk;
+
+	if (on == CTRL0) {
+		if (phy_cfg->owner == UIS8520)
+			msk = phy_cfg->masks[MASK_AON_APB_CGM_OTG_REF_EN];
+		else
+			msk = phy_cfg->masks[MASK_AON_APB_CGM_OTG_REF_EN] |
+				phy_cfg->masks[MASK_AON_APB_CGM_DPHY_REF_EN];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_CGM_REG1], msk, 0);
+		msk = phy_cfg->masks[MASK_AON_APB_AON_USB2_TOP_EB] |
+			phy_cfg->masks[MASK_AON_APB_OTG_PHY_EB];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_APB_EB1], msk, 0);
+	} else if (on == CTRL1) {
+		reg = msk = phy_cfg->masks[MASK_AON_APB_AON_USB2_TOP_EB] |
+			phy_cfg->masks[MASK_AON_APB_OTG_PHY_EB];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_APB_EB1], msk, reg);
+		if (phy_cfg->owner == UIS8520)
+			reg = msk = phy_cfg->masks[MASK_AON_APB_CGM_OTG_REF_EN];
+		else
+			reg = msk = phy_cfg->masks[MASK_AON_APB_CGM_OTG_REF_EN] |
+				phy_cfg->masks[MASK_AON_APB_CGM_DPHY_REF_EN];
+		regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_CGM_REG1], msk, reg);
+	}
+}
+
+static void phy_v4_usb_phy_power_ctrl(struct sprd_hsphy *phy, int on)
+{
+	u32 reg, msk;
+
+	if (on == CTRL0) {
+		reg = msk = phy_cfg->masks[MASK_AON_APB_USB20_ISO_SW_EN];
+		regmap_update_bits(phy->aon_apb,
+			phy_cfg->regs[REG_AON_APB_AON_SOC_USB_CTRL], msk, reg);
+		reg = msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_ISO_SW_EN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_PHY], msk, reg);
+
+		reg = msk = phy_cfg->masks[MASK_AON_APB_C2G_ANALOG_USB20_USB20_PS_PD_L] |
+			phy_cfg->masks[MASK_AON_APB_C2G_ANALOG_USB20_USB20_PS_PD_S];
+		regmap_update_bits(phy->aon_apb,
+			phy_cfg->regs[REG_AON_APB_MIPI_CSI_POWER_CTRL], msk, reg);
+	} else if (on == CTRL1) {
+		msk = phy_cfg->masks[MASK_AON_APB_C2G_ANALOG_USB20_USB20_PS_PD_L] |
+			phy_cfg->masks[MASK_AON_APB_C2G_ANALOG_USB20_USB20_PS_PD_S];
+		regmap_update_bits(phy->aon_apb,
+			phy_cfg->regs[REG_AON_APB_MIPI_CSI_POWER_CTRL], msk, 0);
+
+		msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_ISO_SW_EN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_PHY], msk, 0);
+		msk = phy_cfg->masks[MASK_AON_APB_USB20_ISO_SW_EN];
+		regmap_update_bits(phy->aon_apb,
+			phy_cfg->regs[REG_AON_APB_AON_SOC_USB_CTRL], msk, 0);
+	}
+}
+
+static void phy_v4_usb_vbus_ctrl(struct sprd_hsphy *phy, int on)
+{
+	u32 reg, msk;
+
+	msk = phy_cfg->masks[MASK_AON_APB_OTG_VBUS_VALID_PHYREG];
+	reg = on ? msk : 0;
+	regmap_update_bits(phy->aon_apb,
+		phy_cfg->regs[REG_AON_APB_OTG_PHY_TEST], msk, reg);
+
+	msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_VBUSVLDEXT];
+	reg = on ? msk : 0;
+	regmap_update_bits(phy->analog,
+		phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL1], msk, reg);
+}
+
+static void phy_v4_utmi_width_sel(struct sprd_hsphy *phy)
+{
+	u32 reg, msk;
+
+	if (phy_cfg->owner == UIS8520)
+		return;
+
+	reg = msk = phy_cfg->masks[MASK_AON_APB_UTMI_WIDTH_SEL];
+	regmap_update_bits(phy->aon_apb,
+		phy_cfg->regs[REG_AON_APB_OTG_PHY_CTRL], msk, reg);
+
+	reg = msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_DATABUS16_8];
+	regmap_update_bits(phy->analog,
+		phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL1], msk, reg);
+}
+
+static void phy_v4_reset_core(struct sprd_hsphy *phy)
+{
+	u32 reg, msk;
+
+	reg = msk = phy_cfg->masks[MASK_AON_APB_OTG_PHY_SOFT_RST] |
+		phy_cfg->masks[MASK_AON_APB_OTG_UTMI_SOFT_RST];
+
+	regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_APB_RST1], msk, reg);
+
+	usleep_range(20000, 30000);
+	regmap_update_bits(phy->aon_apb, phy_cfg->regs[REG_AON_APB_APB_RST1], msk, 0);
+}
+
+static int phy_v4_set_mode(struct sprd_hsphy *phy, int on)
+{
+	u32 reg, msk;
+
+	if (on) {
+		reg = phy->host_eye_pattern;
+		regmap_write(phy->analog, phy_cfg->regs[REG_ANALOG_USB20_USB20_TRIMMING], reg);
+
+		msk = phy_cfg->masks[MASK_AON_APB_USB2_PHY_IDDIG];
+		regmap_update_bits(phy->aon_apb,
+			phy_cfg->regs[REG_AON_APB_OTG_PHY_CTRL], msk, 0);
+
+		reg = msk = phy_cfg->masks[MASK_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN] |
+			phy_cfg->masks[MASK_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_REG_SEL_CFG_0], msk, reg);
+		reg = msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_DMPULLDOWN] |
+			phy_cfg->masks[MASK_ANALOG_USB20_USB20_DPPULLDOWN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL2], msk, reg);
+
+		reg = 0x200;
+		msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_RESERVED];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL1], msk, reg);
+		phy->is_host = true;
+	} else {
+		reg = phy->device_eye_pattern;
+		regmap_write(phy->analog, phy_cfg->regs[REG_ANALOG_USB20_USB20_TRIMMING], reg);
+
+		reg = msk = phy_cfg->masks[MASK_AON_APB_USB2_PHY_IDDIG];
+		regmap_update_bits(phy->aon_apb,
+			phy_cfg->regs[REG_AON_APB_OTG_PHY_CTRL], msk, reg);
+
+		reg = msk = phy_cfg->masks[MASK_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN] |
+			phy_cfg->masks[MASK_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_REG_SEL_CFG_0], msk, reg);
+		msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_DMPULLDOWN] |
+			phy_cfg->masks[MASK_ANALOG_USB20_USB20_DPPULLDOWN];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL2], msk, 0);
+
+		msk = phy_cfg->masks[MASK_ANALOG_USB20_USB20_RESERVED];
+		regmap_update_bits(phy->analog,
+			phy_cfg->regs[REG_ANALOG_USB20_USB20_UTMI_CTL1], msk, 0);
+		phy->is_host = false;
+	}
+	return 0;
+}
+
+static const struct sprd_hsphy_cfg_ops phy_v4_cfg_ops = {
+	.usb_enable_ctrl = phy_v4_usb_enable_ctrl,
+	.usb_phy_power_ctrl = phy_v4_usb_phy_power_ctrl,
+	.usb_vbus_ctrl = phy_v4_usb_vbus_ctrl,
+	.utmi_width_sel = phy_v4_utmi_width_sel,
+	.reset_core = phy_v4_reset_core,
+	.set_mode = phy_v4_set_mode,
+};
+
+static const struct sprd_hsphy_cfg pike2_phy_cfg = {
+	.regs				= pike2_regs_layout,
+	.masks				= pike2_masks_layout,
+	.cfg_ops			= &phy_v1_cfg_ops,
+	.parameters			= phy_pike2_parameters,
+	.phy_version			= VERSION1,
+	.owner				= PIKE2,
+};
+
+static const struct sprd_hsphy_cfg sharkle_phy_cfg = {
+	.regs				= sharkle_regs_layout,
+	.masks				= sharkle_masks_layout,
+	.cfg_ops			= &phy_v1_cfg_ops,
+	.parameters			= phy_sharkle_parameters,
+	.phy_version			= VERSION1,
+	.owner				= SHARKLE,
+};
+
+static const struct sprd_hsphy_cfg sharkl3_phy_cfg = {
+	.regs				= sharkl3_regs_layout,
+	.masks				= sharkl3_masks_layout,
+	.cfg_ops			= &phy_v2_cfg_ops,
+	.parameters			= phy_sharkl3_parameters,
+	.phy_version			= VERSION2,
+	.owner				= SHARKL3,
+};
+
+static const struct sprd_hsphy_cfg sharkl5_phy_cfg = {
+	.regs				= sharkl5_regs_layout,
+	.masks				= sharkl5_masks_layout,
+	.cfg_ops			= &phy_v3_cfg_ops,
+	.parameters			= phy_sharkl5_parameters,
+	.phy_version			= VERSION3,
+	.owner				= SHARKL5,
+};
+
+static const struct sprd_hsphy_cfg sharkl5pro_phy_cfg = {
+	.regs				= sharkl5pro_regs_layout,
+	.masks				= sharkl5pro_masks_layout,
+	.cfg_ops			= &phy_v3_cfg_ops,
+	.parameters			= phy_sharkl5pro_parameters,
+	.phy_version			= VERSION3,
+	.owner				= SHARKL5PRO,
+};
+
+static const struct sprd_hsphy_cfg qogirl6_phy_cfg = {
+	.regs				= qogirl6_regs_layout,
+	.masks				= qogirl6_masks_layout,
+	.cfg_ops			= &phy_v3_cfg_ops,
+	.parameters			= phy_qogirl6_parameters,
+	.phy_version			= VERSION3,
+	.owner				= QOGIRL6,
+};
+
+static const struct sprd_hsphy_cfg qogirn6lite_phy_cfg = {
+	.regs				= qogirn6lite_regs_layout,
+	.masks				= qogirn6lite_masks_layout,
+	.cfg_ops			= &phy_v4_cfg_ops,
+	.parameters			= phy_qogirn6lite_parameters,
+	.phy_version			= VERSION4,
+	.owner				= QOGIRN6LITE,
+};
+
+static const struct sprd_hsphy_cfg uis8520_phy_cfg = {
+	.regs				= uis8520_regs_layout,
+	.masks				= uis8520_masks_layout,
+	.cfg_ops			= &phy_v4_cfg_ops,
+	.parameters			= phy_uis8520_parameters,
+	.phy_version			= VERSION4,
+	.owner				= UIS8520,
+};
+
+static void sprd_hsphy_charger_detect_work(struct work_struct *work)
+{
+	struct sprd_hsphy *phy = container_of(work, struct sprd_hsphy, work);
+	struct usb_phy *usb_phy = &phy->phy;
+
+	__pm_stay_awake(phy->wake_lock);
+	if (phy->event)
+		usb_phy_set_charger_state(usb_phy, USB_CHARGER_PRESENT);
+	else
+		usb_phy_set_charger_state(usb_phy, USB_CHARGER_ABSENT);
+	__pm_relax(phy->wake_lock);
+}
+
+static int sprd_hsphy_vbus_notify(struct notifier_block *nb,
+				  unsigned long event, void *data)
+{
+	struct usb_phy *usb_phy = container_of(nb, struct usb_phy, vbus_nb);
+	struct sprd_hsphy *phy = container_of(usb_phy, struct sprd_hsphy, phy);
+	const struct sprd_hsphy_cfg_ops *cfg_ops = phy_cfg->cfg_ops;
+
+	if (phy->is_host || usb_phy->last_event == USB_EVENT_ID) {
+		dev_info(phy->dev, "USB PHY is host mode\n");
+		return 0;
+	}
+	dev_info(usb_phy->dev, "[%s] enters!\n", __func__);
+
+	pm_wakeup_event(phy->dev, 400);
+
+	if (event)
+		/* usb vbus valid */
+		cfg_ops->usb_vbus_ctrl(phy, CTRL1);
+	else
+		cfg_ops->usb_vbus_ctrl(phy, CTRL0);
+
+	phy->event = event;
+	queue_work(system_unbound_wq, &phy->work);
+
+	return 0;
+}
+
+static int sprd_hostphy_set(struct usb_phy *x, int on)
+{
+	struct sprd_hsphy *phy = container_of(x, struct sprd_hsphy, phy);
+	const struct sprd_hsphy_cfg_ops *cfg_ops = phy_cfg->cfg_ops;
+
+	dev_info(x->dev, "[%s] enters!\n", __func__);
+	return cfg_ops->set_mode(phy, on);
+}
+
+static int sprd_hsphy_init(struct usb_phy *x)
+{
+	struct sprd_hsphy *phy = container_of(x, struct sprd_hsphy, phy);
+	const struct sprd_hsphy_cfg_ops *cfg_ops = phy_cfg->cfg_ops;
+	u32 reg = 0;
+	int ret = 0;
+
+	if (atomic_read(&phy->inited)) {
+		dev_dbg(x->dev, "%s is already inited!\n", __func__);
+		return 0;
+	}
+	dev_info(x->dev, "[%s] enters!\n", __func__);
+
+	/* Turn On VDD */
+	regulator_set_voltage(phy->vdd, phy->vdd_vol, phy->vdd_vol);
+	ret = regulator_enable(phy->vdd);
+	if (ret)
+		return ret;
+
+	/* usb enable */
+	cfg_ops->usb_enable_ctrl(phy, CTRL1);
+
+	/* usb phy power on */
+	cfg_ops->usb_phy_power_ctrl(phy, CTRL1);
+
+	/* Restore PHY tunes */
+	if (phy_cfg->phy_version == VERSION1) {
+		writel_relaxed(phy->phy_tune, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_TUNE]);
+		/* USB PHY write register need to delay 2ms~3ms */
+		usleep_range(2000, 3000);
+	}
+
+	/* usb vbus valid */
+	cfg_ops->usb_vbus_ctrl(phy, CTRL1);
+
+	/* for SPRD phy utmi_width sel */
+	cfg_ops->utmi_width_sel(phy);
+
+	/* for SPRD phy sampler sel */
+	if (phy_cfg->phy_version == VERSION1) {
+		reg = readl_relaxed(phy->base + phy_cfg->regs[REG_AP_AHB_OTG_CTRL1]);
+		reg |= phy_cfg->masks[MASK_AP_AHB_USB20_SAMPLER_SEL];
+		writel_relaxed(reg, phy->base + phy_cfg->regs[REG_AP_AHB_OTG_CTRL1]);
+	}
+
+	if (!atomic_read(&phy->reset)) {
+		/* USB PHY write register need to delay 2ms~3ms */
+		if (phy_cfg->phy_version == VERSION1)
+			usleep_range(2000, 3000);
+
+		cfg_ops->reset_core(phy);
+		atomic_set(&phy->reset, 1);
+	}
+
+	atomic_set(&phy->inited, 1);
+	return 0;
+}
+
+static void sprd_hsphy_shutdown(struct usb_phy *x)
+{
+	struct sprd_hsphy *phy = container_of(x, struct sprd_hsphy, phy);
+	const struct sprd_hsphy_cfg_ops *cfg_ops = phy_cfg->cfg_ops;
+
+	if (!atomic_read(&phy->inited)) {
+		dev_info(x->dev, "%s is already shut down\n", __func__);
+		return;
+	}
+	dev_info(x->dev, "[%s] enters!\n", __func__);
+
+	/* usb vbus invalid*/
+	cfg_ops->usb_vbus_ctrl(phy, CTRL0);
+
+	/* usb power down */
+	cfg_ops->usb_phy_power_ctrl(phy, CTRL0);
+
+	/* Backup PHY Tune value */
+	if (phy_cfg->phy_version == VERSION1)
+		phy->phy_tune = readl(phy->base + phy_cfg->regs[REG_AP_AHB_OTG_PHY_TUNE]);
+
+	cfg_ops->usb_enable_ctrl(phy, CTRL0);
+
+	regulator_disable(phy->vdd);
+
+	atomic_set(&phy->inited, 0);
+	atomic_set(&phy->reset, 0);
+}
+
+static ssize_t phy_tune_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct sprd_hsphy *phy = dev_get_drvdata(dev);
+
+	if (!phy)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "0x%x\n", phy->phy_tune);
+}
+
+static ssize_t phy_tune_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t size)
+{
+	struct sprd_hsphy *phy = dev_get_drvdata(dev);
+
+	if (!phy)
+		return -EINVAL;
+
+	if (kstrtouint(buf, 16, &phy->phy_tune) < 0)
+		return -EINVAL;
+
+	return size;
+}
+static DEVICE_ATTR_RW(phy_tune);
+
+static ssize_t vdd_voltage_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct sprd_hsphy *phy = dev_get_drvdata(dev);
+
+	if (!phy)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", phy->vdd_vol);
+}
+
+static ssize_t vdd_voltage_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size)
+{
+	struct sprd_hsphy *phy = dev_get_drvdata(dev);
+	u32 vol;
+
+	if (!phy)
+		return -EINVAL;
+
+	if (kstrtouint(buf, 10, &vol) < 0)
+		return -EINVAL;
+
+	if (vol < 1200000 || vol > 3750000) {
+		dev_err(dev, "Invalid voltage value %d\n", vol);
+		return -EINVAL;
+	}
+	phy->vdd_vol = vol;
+
+	return size;
+}
+static DEVICE_ATTR_RW(vdd_voltage);
+
+static ssize_t hsphy_device_eye_pattern_show(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	struct sprd_hsphy *phy = dev_get_drvdata(dev);
+
+	if (!phy)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "0x%x\n", phy->device_eye_pattern);
+}
+
+static ssize_t hsphy_device_eye_pattern_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t size)
+{
+	struct sprd_hsphy *phy = dev_get_drvdata(dev);
+
+	if (!phy)
+		return -EINVAL;
+
+	if (kstrtouint(buf, 16, &phy->device_eye_pattern) < 0)
+		return -EINVAL;
+
+	return size;
+}
+static DEVICE_ATTR_RW(hsphy_device_eye_pattern);
+
+static ssize_t hsphy_host_eye_pattern_show(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	struct sprd_hsphy *phy = dev_get_drvdata(dev);
+
+	if (!phy)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "0x%x\n", phy->host_eye_pattern);
+}
+
+static ssize_t hsphy_host_eye_pattern_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t size)
+{
+	struct sprd_hsphy *phy = dev_get_drvdata(dev);
+
+	if (!phy)
+		return -EINVAL;
+
+	if (kstrtouint(buf, 16, &phy->host_eye_pattern) < 0)
+		return -EINVAL;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(hsphy_host_eye_pattern);
+
+static struct attribute *usb_hsphy_attrs[] = {
+	&dev_attr_phy_tune.attr,
+	&dev_attr_vdd_voltage.attr,
+	&dev_attr_hsphy_device_eye_pattern.attr,
+	&dev_attr_hsphy_host_eye_pattern.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(usb_hsphy);
+
+static int sprd_eyepatt_tunehsamp_set(struct sprd_hsphy *phy, struct device *dev)
+{
+	int ret = 0;
+	u8 val[2];
+
+	ret = of_property_read_u8_array(dev->of_node, "sprd,hsphy-tunehsamp", val, 2);
+
+	if (ret < 0) {
+		dev_err(dev, "unable to get hsphy-device-tunehsamp\n");
+		return ret;
+	}
+
+	if (phy_cfg->phy_version == VERSION1) {
+		/* device setting */
+		phy->device_otg_ctrl0 &= ~phy_cfg->masks[MASK_AP_AHB_USB20_TUNEHSAMP];
+		phy->device_otg_ctrl0 |= (u32)val[0] << phy_cfg->parameters[TUNEHSAMP_SHIFT];
+
+		/* host setting */
+		phy->host_otg_ctrl0 &= ~phy_cfg->masks[MASK_AP_AHB_USB20_TUNEHSAMP];
+		phy->host_otg_ctrl0 |= (u32)val[1] << phy_cfg->parameters[TUNEHSAMP_SHIFT];
+
+	} else if (phy_cfg->phy_version == VERSION2 ||
+		phy_cfg->phy_version == VERSION3 ||
+		phy_cfg->phy_version == VERSION4) {
+		/* device setting */
+		phy->device_eye_pattern &= ~phy_cfg->masks[MASK_ANALOG_USB20_USB20_TUNEHSAMP];
+		phy->device_eye_pattern |= (u32)val[0] << phy_cfg->parameters[TUNEHSAMP_SHIFT];
+
+		/* host setting */
+		phy->host_eye_pattern &= ~phy_cfg->masks[MASK_ANALOG_USB20_USB20_TUNEHSAMP];
+		phy->host_eye_pattern |= (u32)val[1] << phy_cfg->parameters[TUNEHSAMP_SHIFT];
+	}
+
+	return 0;
+}
+
+static int sprd_eyepatt_tuneeq_set(struct sprd_hsphy *phy, struct device *dev)
+{
+	int ret = 0;
+	u8 val[2];
+
+	ret = of_property_read_u8_array(dev->of_node, "sprd,hsphy-tuneeq", val, 2);
+
+	if (ret < 0) {
+		dev_err(dev, "unable to get hsphy-tuneeq\n");
+		return ret;
+	}
+
+	if (phy_cfg->phy_version == VERSION1) {
+		/* device setting */
+		phy->device_otg_ctrl1 &= ~phy_cfg->masks[MASK_AP_AHB_USB20_TUNEEQ];
+		phy->device_otg_ctrl1 |= (u32)val[0] << phy_cfg->parameters[TUNEEQ_SHIFT];
+
+		/* host setting */
+		phy->host_otg_ctrl1 &= ~phy_cfg->masks[MASK_AP_AHB_USB20_TUNEEQ];
+		phy->host_otg_ctrl1 |= (u32)val[1] << phy_cfg->parameters[TUNEEQ_SHIFT];
+
+	} else if (phy_cfg->phy_version == VERSION2 ||
+		phy_cfg->phy_version == VERSION3 ||
+		phy_cfg->phy_version == VERSION4) {
+		/* device setting */
+		phy->device_eye_pattern &= ~phy_cfg->masks[MASK_ANALOG_USB20_USB20_TUNEEQ];
+		phy->device_eye_pattern |= (u32)val[0] << phy_cfg->parameters[TUNEEQ_SHIFT];
+
+		/* host setting */
+		phy->host_eye_pattern &= ~phy_cfg->masks[MASK_ANALOG_USB20_USB20_TUNEEQ];
+		phy->host_eye_pattern |= (u32)val[1] << phy_cfg->parameters[TUNEEQ_SHIFT];
+	}
+
+	return 0;
+}
+
+static int sprd_eyepatt_tfregres_set(struct sprd_hsphy *phy, struct device *dev)
+{
+	int ret = 0;
+	u8 val[2];
+
+	ret = of_property_read_u8_array(dev->of_node, "sprd,hsphy-tfregres", val, 2);
+
+	if (ret < 0) {
+		dev_err(dev, "unable to get hsphy-tfregres\n");
+		return ret;
+	}
+
+	if (phy_cfg->phy_version == VERSION1) {
+		/* device setting */
+		phy->device_otg_ctrl1 &= ~phy_cfg->masks[MASK_AP_AHB_USB20_TFREGRES];
+		phy->device_otg_ctrl1 |= (u32)val[0] << phy_cfg->parameters[TFREGRES_SHIFT];
+
+		/* host setting */
+		phy->host_otg_ctrl1 &= ~phy_cfg->masks[MASK_AP_AHB_USB20_TFREGRES];
+		phy->host_otg_ctrl1 |= (u32)val[1] << phy_cfg->parameters[TFREGRES_SHIFT];
+	} else if (phy_cfg->phy_version == VERSION2 ||
+		phy_cfg->phy_version == VERSION3 ||
+		phy_cfg->phy_version == VERSION4) {
+		/* device setting */
+		phy->device_eye_pattern &= ~phy_cfg->masks[MASK_ANALOG_USB20_USB20_TFREGRES];
+		phy->device_eye_pattern |= (u32)val[0] << phy_cfg->parameters[TFREGRES_SHIFT];
+
+		/* host setting */
+		phy->host_eye_pattern &= ~phy_cfg->masks[MASK_ANALOG_USB20_USB20_TFREGRES];
+		phy->host_eye_pattern |= (u32)val[1] << phy_cfg->parameters[TFREGRES_SHIFT];
+	}
+
+	return 0;
+}
+
+static int sprd_eye_pattern_prepared(struct sprd_hsphy *phy, struct device *dev)
+{
+	int ret = 0;
+
+	if (phy_cfg->phy_version == VERSION1) {
+		/* set default OTG_CTRL */
+		phy->device_otg_ctrl0 = readl_relaxed(phy->base +
+				phy_cfg->regs[REG_AP_AHB_OTG_CTRL0]);
+		phy->device_otg_ctrl1 = readl_relaxed(phy->base +
+				phy_cfg->regs[REG_AP_AHB_OTG_CTRL1]);
+
+		phy->host_otg_ctrl0 = readl_relaxed(phy->base +
+				phy_cfg->regs[REG_AP_AHB_OTG_CTRL0]);
+		phy->host_otg_ctrl1 = readl_relaxed(phy->base +
+				phy_cfg->regs[REG_AP_AHB_OTG_CTRL1]);
+	} else if (phy_cfg->phy_version == VERSION2 ||
+		phy_cfg->phy_version == VERSION3 ||
+		phy_cfg->phy_version == VERSION4) {
+		/* set default eyepatt */
+		regmap_read(phy->analog, phy_cfg->regs[REG_ANALOG_USB20_USB20_TRIMMING],
+					&phy->device_eye_pattern);
+
+		regmap_read(phy->analog, phy_cfg->regs[REG_ANALOG_USB20_USB20_TRIMMING],
+					&phy->host_eye_pattern);
+	}
+
+	/* set eyepatt tunehsamp */
+	ret |= sprd_eyepatt_tunehsamp_set(phy, dev);
+
+	/* set eyepatt tuneeq */
+	ret |= sprd_eyepatt_tuneeq_set(phy, dev);
+
+	/* set eyepatt tfregres */
+	ret |= sprd_eyepatt_tfregres_set(phy, dev);
+
+	return ret;
+}
+
+static int sprd_hsphy_cali_mode(void)
+{
+	struct device_node *cmdline_node;
+	const char *cmdline, *mode;
+	int ret;
+
+	cmdline_node = of_find_node_by_path("/chosen");
+	ret = of_property_read_string(cmdline_node, "bootargs", &cmdline);
+
+	if (ret) {
+		pr_err("Can't not parse bootargs\n");
+		return 0;
+	}
+
+	mode = strstr(cmdline, "androidboot.mode=cali");
+	if (mode)
+		return 1;
+
+	mode = strstr(cmdline, "sprdboot.mode=cali");
+	if (mode)
+		return 1;
+
+	return 0;
+}
+
+static int sprd_hsphy_probe(struct platform_device *pdev)
+{
+	struct sprd_hsphy *phy;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	int ret = 0, calimode = 0;
+	struct usb_otg *otg;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	otg = devm_kzalloc(dev, sizeof(*otg), GFP_KERNEL);
+	if (!otg)
+		return -ENOMEM;
+
+	/* phy cfg data */
+	phy_cfg = of_device_get_match_data(dev);
+	if (!phy_cfg) {
+		dev_err(dev, "no matching driver data found\n");
+		return -EINVAL;
+	}
+
+	/* set vdd */
+	ret = of_property_read_u32(dev->of_node, "sprd,vdd-voltage",
+				   &phy->vdd_vol);
+	if (ret < 0) {
+		dev_err(dev, "unable to read hsphy vdd voltage\n");
+		return ret;
+	}
+
+	calimode = sprd_hsphy_cali_mode();
+	if (calimode) {
+		phy->vdd_vol = phy_cfg->parameters[FULLSPEED_USB33_TUNE];
+		dev_info(dev, "calimode vdd_vol:%d\n", phy->vdd_vol);
+	}
+
+	phy->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(phy->vdd)) {
+		dev_err(dev, "unable to get hsphy vdd supply\n");
+		return PTR_ERR(phy->vdd);
+	}
+
+	ret = regulator_set_voltage(phy->vdd, phy->vdd_vol, phy->vdd_vol);
+	if (ret < 0) {
+		dev_err(dev, "fail to set hsphy vdd voltage at %dmV\n",
+			phy->vdd_vol);
+		return ret;
+	}
+
+	/* phy tune */
+	if (phy_cfg->phy_version == VERSION1) {
+		ret = of_property_read_u32(dev->of_node, "sprd,tune-value",
+					&phy->phy_tune);
+		if (ret < 0) {
+			dev_err(dev, "unable to read hsphy usb phy tune\n");
+			return ret;
+		}
+	}
+
+	/* phy base */
+	if (phy_cfg->phy_version == VERSION1 ||
+		phy_cfg->phy_version == VERSION2) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy_glb_regs");
+		if (!res) {
+			dev_err(dev, "missing USB PHY registers resource\n");
+			return -ENODEV;
+		}
+
+		phy->base = devm_ioremap(dev, res->start, resource_size(res));
+		if (IS_ERR(phy->base)) {
+			dev_err(dev, "unable to get phy base!\n");
+			return PTR_ERR(phy->base);
+		}
+	}
+
+	/* analog & aoapb & apahb regmap */
+	phy->aon_apb = syscon_regmap_lookup_by_phandle(dev->of_node,
+				 "sprd,syscon-enable");
+	if (IS_ERR(phy->aon_apb)) {
+		dev_err(dev, "USB aon apb syscon failed!\n");
+		return PTR_ERR(phy->aon_apb);
+	}
+
+	if (phy_cfg->phy_version == VERSION2) {
+		phy->ap_ahb = syscon_regmap_lookup_by_phandle(dev->of_node,
+				 "sprd,syscon-apahb");
+		if (IS_ERR(phy->ap_ahb)) {
+			dev_err(dev, "USB apahb syscon failed!\n");
+			return PTR_ERR(phy->ap_ahb);
+		}
+	}
+
+	if (phy_cfg->phy_version != VERSION1) {
+		phy->analog = syscon_regmap_lookup_by_phandle(dev->of_node,
+				 "sprd,syscon-ana");
+		if (IS_ERR(phy->analog)) {
+			dev_err(dev, "USB analog syscon failed!\n");
+			return PTR_ERR(phy->analog);
+		}
+	}
+
+	/* prepare eye pattern */
+	ret = sprd_eye_pattern_prepared(phy, dev);
+	if (ret < 0)
+		dev_warn(dev, "sprd_eye_pattern_prepared failed, ret = %d\n", ret);
+
+	/* enable usb module */
+	if (phy_cfg->phy_version == VERSION2 ||
+		phy_cfg->phy_version == VERSION3) {
+		phy_cfg->cfg_ops->usb_enable_ctrl(phy, CTRL2);
+	}
+
+	/* usb phy power down */
+	if (phy_cfg->phy_version != VERSION4)
+		phy_cfg->cfg_ops->usb_phy_power_ctrl(phy, CTRL2);
+
+	phy->dev = dev;
+	phy->phy.dev = dev;
+	phy->phy.label = "sprd-hsphy";
+	phy->phy.otg = otg;
+	phy->phy.init = sprd_hsphy_init;
+	phy->phy.shutdown = sprd_hsphy_shutdown;
+	phy->phy.set_vbus = sprd_hostphy_set;
+	phy->phy.type = USB_PHY_TYPE_USB2;
+	phy->phy.vbus_nb.notifier_call = sprd_hsphy_vbus_notify;
+	otg->usb_phy = &phy->phy;
+
+	device_init_wakeup(phy->dev, true);
+	phy->wake_lock = wakeup_source_register(phy->dev, "sprd-hsphy");
+	if (!phy->wake_lock) {
+		dev_err(dev, "fail to register wakeup lock.\n");
+		return -ENOMEM;
+	}
+	INIT_WORK(&phy->work, sprd_hsphy_charger_detect_work);
+	platform_set_drvdata(pdev, phy);
+
+	ret = usb_add_phy_dev(&phy->phy);
+	if (ret) {
+		dev_err(dev, "fail to add phy\n");
+		return ret;
+	}
+
+	ret = sysfs_create_groups(&dev->kobj, usb_hsphy_groups);
+	if (ret)
+		dev_warn(dev, "failed to create usb hsphy attributes\n");
+
+	if (extcon_get_state(phy->phy.edev, EXTCON_USB) > 0)
+		usb_phy_set_charger_state(&phy->phy, USB_CHARGER_PRESENT);
+
+	dev_info(dev, "sprd usb phy probe ok !\n");
+
+	return ret;
+}
+
+static int sprd_hsphy_remove(struct platform_device *pdev)
+{
+	struct sprd_hsphy *phy = platform_get_drvdata(pdev);
+
+	sysfs_remove_groups(&pdev->dev.kobj, usb_hsphy_groups);
+	usb_remove_phy(&phy->phy);
+	if (regulator_is_enabled(phy->vdd))
+		regulator_disable(phy->vdd);
+
+	return 0;
+}
+
+static const struct of_device_id sprd_hsphy_match[] = {
+	{ .compatible = "sprd,pike2-phy", .data = &pike2_phy_cfg,},
+	{ .compatible = "sprd,sharkle-phy", .data = &sharkle_phy_cfg,},
+	{ .compatible = "sprd,sharkl3-phy", .data = &sharkl3_phy_cfg,},
+	{ .compatible = "sprd,sharkl5-phy", .data = &sharkl5_phy_cfg,},
+	{ .compatible = "sprd,sharkl5pro-phy", .data = &sharkl5pro_phy_cfg,},
+	{ .compatible = "sprd,qogirl6-phy", .data = &qogirl6_phy_cfg,},
+	{ .compatible = "sprd,qogirn6lite-phy", .data = &qogirn6lite_phy_cfg,},
+	{ .compatible = "sprd,uis8520-phy", .data = &uis8520_phy_cfg,},
+	{},
+};
+MODULE_DEVICE_TABLE(of, sprd_hsphy_match);
+
+static struct platform_driver sprd_hsphy_driver = {
+	.probe = sprd_hsphy_probe,
+	.remove = sprd_hsphy_remove,
+	.driver = {
+		.name = "sprd-hsphy",
+		.of_match_table = sprd_hsphy_match,
+	},
+};
+
+static int __init sprd_hsphy_driver_init(void)
+{
+	return platform_driver_register(&sprd_hsphy_driver);
+}
+
+static void __exit sprd_hsphy_driver_exit(void)
+{
+	platform_driver_unregister(&sprd_hsphy_driver);
+}
+
+late_initcall(sprd_hsphy_driver_init);
+module_exit(sprd_hsphy_driver_exit);
+
+MODULE_ALIAS("platform:spreadtrum-usb20-hsphy");
+MODULE_AUTHOR("Pu Li <lip308226@gmail.com>");
+MODULE_DESCRIPTION("Spreadtrum USB20 HSPHY driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/phy/sprd/phy-sprd-usb20-hs.h b/drivers/phy/sprd/phy-sprd-usb20-hs.h
new file mode 100644
index 000000000000..897ee5e64482
--- /dev/null
+++ b/drivers/phy/sprd/phy-sprd-usb20-hs.h
@@ -0,0 +1,525 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * phy-sprd-usb20-hs.h - Spreadtrum usb20 phy Glue layer h file
+ *
+ * Copyright 2020-2023 Unisoc Inc.
+ */
+
+#ifndef __SPRD_USB20_HS_H
+#define __SPRD_USB20_HS_H
+
+#include <linux/regmap.h>
+#include <linux/usb/phy.h>
+
+struct sprd_hsphy {
+	struct device		*dev;
+	struct usb_phy		phy;
+	void __iomem		*base;
+	struct regulator	*vdd;
+	struct regmap           *aon_apb;
+	struct regmap           *ap_ahb;
+	struct regmap           *analog;
+	struct wakeup_source	*wake_lock;
+	struct work_struct	work;
+	unsigned long event;
+	u32			vdd_vol;
+	u32			phy_tune;
+	u32			host_eye_pattern;
+	u32			device_eye_pattern;
+	u32			host_otg_ctrl0;
+	u32			device_otg_ctrl0;
+	u32			host_otg_ctrl1;
+	u32			device_otg_ctrl1;
+	atomic_t		reset;
+	atomic_t		inited;
+	bool			is_host;
+};
+
+enum hsphy_parameters {
+	TUNEHSAMP_SHIFT,
+	TUNEEQ_SHIFT,
+	TFREGRES_SHIFT,
+	FULLSPEED_USB33_TUNE,
+};
+
+enum sprd_hsphy_reg_layout {
+	REG_AON_APB_APB_RST1,
+	REG_AON_APB_APB_RST2,
+	REG_AON_APB_APB_EB1,
+	REG_AON_APB_APB_EB2,
+	REG_AON_APB_CGM_REG1,
+	REG_AON_APB_OTG_PHY_TEST,
+	REG_AON_APB_OTG_PHY_CTRL,
+	REG_AON_APB_PWR_CTRL,
+	REG_AON_APB_AON_SOC_USB_CTRL,
+	REG_AON_APB_MIPI_CSI_POWER_CTRL,
+	REG_AP_AHB_AHB_EB,
+	REG_AP_AHB_AHB_RST,
+	REG_AP_AHB_OTG_CTRL0,
+	REG_AP_AHB_OTG_CTRL1,
+	REG_AP_AHB_OTG_PHY_CTRL,
+	REG_AP_AHB_OTG_PHY_TUNE,
+	REG_AP_AHB_OTG_PHY_TEST,
+	REG_ANALOG_USB20_USB20_ISO_SW,
+	REG_ANALOG_USB20_USB20_BATTER_PLL,
+	REG_ANALOG_USB20_USB20_UTMI_CTL1,
+	REG_ANALOG_USB20_USB20_TRIMMING,
+	REG_ANALOG_USB20_USB20_UTMI_CTL2,
+	REG_ANALOG_USB20_REG_SEL_CFG_0,
+	REG_ANALOG_USB20_IDDG,
+	REG_ANALOG_USB20_USB20_PHY,
+};
+
+enum sprd_hsphy_mask_layout {
+	MASK_AON_APB_USB_PHY_PD_S,
+	MASK_AON_APB_USB_PHY_PD_L,
+	MASK_AON_APB_ANLG_APB_EB,
+	MASK_AON_APB_ANLG_EB,
+	MASK_AON_APB_OTG_REF_EB,
+	MASK_AON_APB_ANA_EB,
+	MASK_AON_APB_OTG_UTMI_EB,
+	MASK_AON_APB_AON_USB2_TOP_EB,
+	MASK_AON_APB_OTG_PHY_EB,
+	MASK_AON_APB_CGM_OTG_REF_EN,
+	MASK_AON_APB_CGM_DPHY_REF_EN,
+	MASK_AON_APB_USB_ISO_SW_EN,
+	MASK_AON_APB_OTG_PHY_SOFT_RST,
+	MASK_AON_APB_OTG_UTMI_SOFT_RST,
+	MASK_AON_APB_OTG_VBUS_VALID_PHYREG,
+	MASK_AON_APB_USB2_PHY_IDDIG,
+	MASK_AON_APB_UTMI_WIDTH_SEL,
+	MASK_AON_APB_USB20_CTRL_MUX_REG,
+	MASK_AON_APB_USB20_ISO_SW_EN,
+	MASK_AON_APB_C2G_ANALOG_USB20_USB20_PS_PD_S,
+	MASK_AON_APB_C2G_ANALOG_USB20_USB20_PS_PD_L,
+	MASK_AP_AHB_OTG_EB,
+	MASK_AP_AHB_OTG_PHY_SOFT_RST,
+	MASK_AP_AHB_OTG_UTMI_SOFT_RST,
+	MASK_AP_AHB_OTG_SOFT_RST,
+	MASK_AP_AHB_USB2_PHY_IDDIG,
+	MASK_AP_AHB_OTG_DPPULLDOWN,
+	MASK_AP_AHB_OTG_DMPULLDOWN,
+	MASK_AP_AHB_OTG_VBUS_VALID_EXT,
+	MASK_AP_AHB_OTG_VBUS_VALID_PHYREG,
+	MASK_AP_AHB_UTMI_WIDTH_SEL,
+	MASK_AP_AHB_USB2_DATABUS16_8,
+	MASK_AP_AHB_USB20_SAMPLER_SEL,
+	MASK_AP_AHB_USB20_TUNEHSAMP,
+	MASK_AP_AHB_USB20_TUNEEQ,
+	MASK_AP_AHB_USB20_TFREGRES,
+	MASK_ANALOG_USB20_USB20_VBUSVLDEXT,
+	MASK_ANALOG_USB20_USB20_DATABUS16_8,
+	MASK_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN,
+	MASK_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN,
+	MASK_ANALOG_USB20_USB20_DMPULLDOWN,
+	MASK_ANALOG_USB20_USB20_DPPULLDOWN,
+	MASK_ANALOG_USB20_UTMIOTG_IDDG,
+	MASK_ANALOG_USB20_USB20_PS_PD_S,
+	MASK_ANALOG_USB20_USB20_PS_PD_L,
+	MASK_ANALOG_USB20_USB20_RESERVED,
+	MASK_ANALOG_USB20_USB20_ISO_SW_EN,
+	MASK_ANALOG_USB20_USB20_TUNEHSAMP,
+	MASK_ANALOG_USB20_USB20_TUNEEQ,
+	MASK_ANALOG_USB20_USB20_TFREGRES,
+};
+
+enum {
+	CTRL0 = 0,
+	CTRL1,
+	CTRL2,
+};
+
+struct sprd_hsphy_cfg_ops {
+	void (*usb_enable_ctrl)(struct sprd_hsphy *phy, int on);
+	void (*usb_phy_power_ctrl)(struct sprd_hsphy *phy, int on);
+	void (*usb_vbus_ctrl)(struct sprd_hsphy *phy, int on);
+	void (*utmi_width_sel)(struct sprd_hsphy *phy);
+	void (*reset_core)(struct sprd_hsphy *phy);
+	int (*set_mode)(struct sprd_hsphy *phy, int on);
+};
+
+enum hsphy_ip_version {
+	VERSION1,
+	VERSION2,
+	VERSION3,
+	VERSION4,
+};
+
+enum hsphy_owner {
+	PIKE2,
+	SHARKLE,
+	SHARKL3,
+	SHARKL5,
+	SHARKL5PRO,
+	QOGIRL6,
+	QOGIRN6LITE,
+	UIS8520,
+};
+
+struct sprd_hsphy_cfg {
+	/* array of registers with different offsets */
+	const unsigned int *regs;
+
+	const unsigned int *masks;
+
+	/* private ops for each SOC */
+	const struct sprd_hsphy_cfg_ops *cfg_ops;
+
+	const unsigned int *parameters;
+
+	enum hsphy_ip_version phy_version;
+
+	enum hsphy_owner	owner;
+};
+
+static const unsigned int pike2_regs_layout[] = {
+	[REG_AON_APB_PWR_CTRL]				= 0x0024,
+	[REG_AP_AHB_AHB_RST]				= 0x0004,
+	[REG_AP_AHB_OTG_CTRL0]				= 0x302c,
+	[REG_AP_AHB_OTG_CTRL1]				= 0x3030,
+	[REG_AP_AHB_OTG_PHY_CTRL]			= 0x3028,
+	[REG_AP_AHB_OTG_PHY_TUNE]			= 0x3020,
+	[REG_AP_AHB_OTG_PHY_TEST]			= 0x3024,
+};
+
+static const unsigned int sharkle_regs_layout[] = {
+	[REG_AON_APB_PWR_CTRL]				= 0x0024,
+	[REG_AP_AHB_AHB_RST]				= 0x0004,
+	[REG_AP_AHB_OTG_CTRL0]				= 0x302c,
+	[REG_AP_AHB_OTG_CTRL1]				= 0x3030,
+	[REG_AP_AHB_OTG_PHY_CTRL]			= 0x3028,
+	[REG_AP_AHB_OTG_PHY_TUNE]			= 0x3020,
+	[REG_AP_AHB_OTG_PHY_TEST]			= 0x3024,
+};
+
+static const unsigned int sharkl3_regs_layout[] = {
+	[REG_AON_APB_APB_RST2]				= 0x0130,
+	[REG_AON_APB_APB_EB2]				= 0x00b0,
+	[REG_AON_APB_PWR_CTRL]				= 0x0024,
+	[REG_AP_AHB_AHB_EB]				= 0x0000,
+	[REG_AP_AHB_AHB_RST]				= 0x0004,
+	[REG_AP_AHB_OTG_PHY_CTRL]			= 0x3028,
+	[REG_AP_AHB_OTG_PHY_TEST]			= 0x3024,
+	[REG_ANALOG_USB20_USB20_UTMI_CTL1]		= 0x009c,
+	[REG_ANALOG_USB20_USB20_TRIMMING]		= 0x00a8,
+	[REG_ANALOG_USB20_USB20_UTMI_CTL2]		= 0x00a4,
+	[REG_ANALOG_USB20_REG_SEL_CFG_0]		= 0x00b0,
+	[REG_ANALOG_USB20_IDDG]				= 0x00bc,
+};
+
+static const unsigned int sharkl5_regs_layout[] = {
+	[REG_AON_APB_APB_RST1]				= 0x0010,
+	[REG_AON_APB_APB_EB1]				= 0x0004,
+	[REG_AON_APB_CGM_REG1]				= 0x0138,
+	[REG_AON_APB_OTG_PHY_TEST]			= 0x0204,
+	[REG_AON_APB_OTG_PHY_CTRL]			= 0x0208,
+	[REG_ANALOG_USB20_USB20_ISO_SW]			= 0x0070,
+	[REG_ANALOG_USB20_USB20_BATTER_PLL]		= 0x005c,
+	[REG_ANALOG_USB20_USB20_UTMI_CTL1]		= 0x0058,
+	[REG_ANALOG_USB20_USB20_TRIMMING]		= 0x0064,
+	[REG_ANALOG_USB20_USB20_UTMI_CTL2]		= 0x0060,
+	[REG_ANALOG_USB20_REG_SEL_CFG_0]		= 0x0074,
+};
+
+static const unsigned int sharkl5pro_regs_layout[] = {
+	[REG_AON_APB_APB_RST1]				= 0x0010,
+	[REG_AON_APB_APB_EB1]				= 0x0004,
+	[REG_AON_APB_CGM_REG1]				= 0x0138,
+	[REG_AON_APB_OTG_PHY_TEST]			= 0x0204,
+	[REG_AON_APB_OTG_PHY_CTRL]			= 0x0208,
+	[REG_ANALOG_USB20_USB20_ISO_SW]			= 0x0070,
+	[REG_ANALOG_USB20_USB20_BATTER_PLL]		= 0x005c,
+	[REG_ANALOG_USB20_USB20_UTMI_CTL1]		= 0x0058,
+	[REG_ANALOG_USB20_USB20_TRIMMING]		= 0x0064,
+	[REG_ANALOG_USB20_USB20_UTMI_CTL2]		= 0x0060,
+	[REG_ANALOG_USB20_REG_SEL_CFG_0]		= 0x0074,
+};
+
+static const unsigned int qogirl6_regs_layout[] = {
+	[REG_AON_APB_APB_RST1]				= 0x0010,
+	[REG_AON_APB_APB_EB1]				= 0x0004,
+	[REG_AON_APB_CGM_REG1]				= 0x0138,
+	[REG_AON_APB_OTG_PHY_TEST]			= 0x0204,
+	[REG_AON_APB_OTG_PHY_CTRL]			= 0x0208,
+	[REG_ANALOG_USB20_USB20_ISO_SW]			= 0x001c,
+	[REG_ANALOG_USB20_USB20_BATTER_PLL]		= 0x0008,
+	[REG_ANALOG_USB20_USB20_UTMI_CTL1]		= 0x0004,
+	[REG_ANALOG_USB20_USB20_TRIMMING]		= 0x0010,
+	[REG_ANALOG_USB20_USB20_UTMI_CTL2]		= 0x000c,
+	[REG_ANALOG_USB20_REG_SEL_CFG_0]		= 0x0020,
+};
+
+static const unsigned int qogirn6lite_regs_layout[] = {
+	[REG_AON_APB_APB_RST1]				= 0x0010,
+	[REG_AON_APB_APB_EB1]				= 0x0004,
+	[REG_AON_APB_CGM_REG1]				= 0x0138,
+	[REG_AON_APB_OTG_PHY_TEST]			= 0x0204,
+	[REG_AON_APB_OTG_PHY_CTRL]			= 0x0208,
+	[REG_AON_APB_AON_SOC_USB_CTRL]			= 0x0190,
+	[REG_AON_APB_MIPI_CSI_POWER_CTRL]		= 0x0350,
+	[REG_ANALOG_USB20_USB20_UTMI_CTL1]		= 0x0004,
+	[REG_ANALOG_USB20_USB20_TRIMMING]		= 0x0010,
+	[REG_ANALOG_USB20_USB20_UTMI_CTL2]		= 0x000c,
+	[REG_ANALOG_USB20_REG_SEL_CFG_0]		= 0x0020,
+	[REG_ANALOG_USB20_USB20_PHY]			= 0x001C,
+};
+
+static const unsigned int uis8520_regs_layout[] = {
+	[REG_AON_APB_APB_RST1]				= 0x0010,
+	[REG_AON_APB_APB_EB1]				= 0x0004,
+	[REG_AON_APB_CGM_REG1]				= 0x0138,
+	[REG_AON_APB_OTG_PHY_TEST]			= 0x0204,
+	[REG_AON_APB_OTG_PHY_CTRL]			= 0x0208,
+	[REG_AON_APB_AON_SOC_USB_CTRL]			= 0x0190,
+	[REG_AON_APB_MIPI_CSI_POWER_CTRL]		= 0x0350,
+	[REG_ANALOG_USB20_USB20_UTMI_CTL1]		= 0x0008,
+	[REG_ANALOG_USB20_USB20_TRIMMING]		= 0x0018,
+	[REG_ANALOG_USB20_USB20_UTMI_CTL2]		= 0x0010,
+	[REG_ANALOG_USB20_REG_SEL_CFG_0]		= 0x0028,
+	[REG_ANALOG_USB20_USB20_PHY]			= 0x0024,
+};
+
+static const unsigned int pike2_masks_layout[] = {
+	[MASK_AON_APB_USB_PHY_PD_S]			= 0x20000,
+	[MASK_AON_APB_USB_PHY_PD_L]			= 0x10000,
+	[MASK_AP_AHB_OTG_PHY_SOFT_RST]			= 0x40,
+	[MASK_AP_AHB_OTG_UTMI_SOFT_RST]			= 0x20,
+	[MASK_AP_AHB_OTG_SOFT_RST]			= 0x10,
+	[MASK_AP_AHB_USB2_PHY_IDDIG]			= 0x8,
+	[MASK_AP_AHB_OTG_DPPULLDOWN]			= 0x100000,
+	[MASK_AP_AHB_OTG_DMPULLDOWN]			= 0x200000,
+	[MASK_AP_AHB_OTG_VBUS_VALID_EXT]		= 0x400000,
+	[MASK_AP_AHB_OTG_VBUS_VALID_PHYREG]		= 0x1000000,
+	[MASK_AP_AHB_UTMI_WIDTH_SEL]			= 0x40000000,
+	[MASK_AP_AHB_USB2_DATABUS16_8]			= 0x20000000,
+	[MASK_AP_AHB_USB20_SAMPLER_SEL]			= 0x100000,
+	[MASK_AP_AHB_USB20_TUNEHSAMP]			= 0xc0000000,
+	[MASK_AP_AHB_USB20_TUNEEQ]			= 0x7,
+	[MASK_AP_AHB_USB20_TFREGRES]			= 0x3f00,
+};
+
+static const unsigned int sharkle_masks_layout[] = {
+	[MASK_AON_APB_USB_PHY_PD_S]			= 0x20000,
+	[MASK_AON_APB_USB_PHY_PD_L]			= 0x10000,
+	[MASK_AP_AHB_OTG_PHY_SOFT_RST]			= 0x40,
+	[MASK_AP_AHB_OTG_UTMI_SOFT_RST]			= 0x20,
+	[MASK_AP_AHB_OTG_SOFT_RST]			= 0x10,
+	[MASK_AP_AHB_USB2_PHY_IDDIG]			= 0x8,
+	[MASK_AP_AHB_OTG_DPPULLDOWN]			= 0x100000,
+	[MASK_AP_AHB_OTG_DMPULLDOWN]			= 0x200000,
+	[MASK_AP_AHB_OTG_VBUS_VALID_EXT]		= 0x400000,
+	[MASK_AP_AHB_OTG_VBUS_VALID_PHYREG]		= 0x1000000,
+	[MASK_AP_AHB_UTMI_WIDTH_SEL]			= 0x40000000,
+	[MASK_AP_AHB_USB2_DATABUS16_8]			= 0x20000000,
+	[MASK_AP_AHB_USB20_SAMPLER_SEL]			= 0x100000,
+	[MASK_AP_AHB_USB20_TUNEHSAMP]			= 0xc0000000,
+	[MASK_AP_AHB_USB20_TUNEEQ]			= 0x7,
+	[MASK_AP_AHB_USB20_TFREGRES]			= 0x3f00,
+};
+
+static const unsigned int sharkl3_masks_layout[] = {
+	[MASK_AON_APB_USB_PHY_PD_S]			= 0x20000,
+	[MASK_AON_APB_USB_PHY_PD_L]			= 0x10000,
+	[MASK_AON_APB_ANLG_APB_EB]			= 0x2000,
+	[MASK_AON_APB_ANLG_EB]				= 0x800,
+	[MASK_AON_APB_OTG_REF_EB]			= 0x4000000,
+	[MASK_AON_APB_OTG_PHY_SOFT_RST]			= 0x8000000,
+	[MASK_AON_APB_USB_ISO_SW_EN]			= 0x10000000,
+	[MASK_AP_AHB_OTG_EB]				= 0x10,
+	[MASK_AP_AHB_OTG_UTMI_SOFT_RST]			= 0x20,
+	[MASK_AP_AHB_OTG_SOFT_RST]			= 0x10,
+	[MASK_AP_AHB_OTG_VBUS_VALID_PHYREG]		= 0x10000000,
+	[MASK_AP_AHB_UTMI_WIDTH_SEL]			= 0x40000000,
+	[MASK_ANALOG_USB20_USB20_VBUSVLDEXT]		= 0x10000,
+	[MASK_ANALOG_USB20_USB20_DATABUS16_8]		= 0x10000000,
+	[MASK_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN]	= 0x1,
+	[MASK_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN]	= 0x2,
+	[MASK_ANALOG_USB20_USB20_DMPULLDOWN]		= 0x4,
+	[MASK_ANALOG_USB20_USB20_DPPULLDOWN]		= 0x8,
+	[MASK_ANALOG_USB20_UTMIOTG_IDDG]		= 0x1,
+	[MASK_ANALOG_USB20_USB20_TUNEHSAMP]		= 0x18000000,
+	[MASK_ANALOG_USB20_USB20_TUNEEQ]		= 0x1c,
+	[MASK_ANALOG_USB20_USB20_TFREGRES]		= 0x7e00000,
+};
+
+static const unsigned int sharkl5_masks_layout[] = {
+	[MASK_AON_APB_ANA_EB]				= 0x1000,
+	[MASK_AON_APB_OTG_UTMI_EB]			= 0x100,
+	[MASK_AON_APB_CGM_OTG_REF_EN]			= 0x1000,
+	[MASK_AON_APB_CGM_DPHY_REF_EN]			= 0x400,
+	[MASK_AON_APB_OTG_PHY_SOFT_RST]			= 0x200,
+	[MASK_AON_APB_OTG_UTMI_SOFT_RST]		= 0x100,
+	[MASK_AON_APB_OTG_VBUS_VALID_PHYREG]		= 0x1000000,
+	[MASK_AON_APB_UTMI_WIDTH_SEL]			= 0x40000000,
+	[MASK_AON_APB_USB2_PHY_IDDIG]			= 0x8,
+	[MASK_ANALOG_USB20_USB20_VBUSVLDEXT]		= 0x10000,
+	[MASK_ANALOG_USB20_USB20_DATABUS16_8]		= 0x10000000,
+	[MASK_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN]	= 0x2,
+	[MASK_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN]	= 0x4,
+	[MASK_ANALOG_USB20_USB20_DMPULLDOWN]		= 0x8,
+	[MASK_ANALOG_USB20_USB20_DPPULLDOWN]		= 0x10,
+	[MASK_ANALOG_USB20_USB20_PS_PD_S]		= 0x10,
+	[MASK_ANALOG_USB20_USB20_PS_PD_L]		= 0x8,
+	[MASK_ANALOG_USB20_USB20_RESERVED]		= 0xffff,
+	[MASK_ANALOG_USB20_USB20_ISO_SW_EN]		= 0x1,
+	[MASK_ANALOG_USB20_USB20_TUNEHSAMP]		= 0x06000000,
+	[MASK_ANALOG_USB20_USB20_TUNEEQ]		= 0x7,
+	[MASK_ANALOG_USB20_USB20_TFREGRES]		= 0x01f80000,
+};
+
+static const unsigned int sharkl5pro_masks_layout[] = {
+	[MASK_AON_APB_ANA_EB]				= 0x1000,
+	[MASK_AON_APB_OTG_UTMI_EB]			= 0x100,
+	[MASK_AON_APB_CGM_OTG_REF_EN]			= 0x1000,
+	[MASK_AON_APB_CGM_DPHY_REF_EN]			= 0x400,
+	[MASK_AON_APB_OTG_PHY_SOFT_RST]			= 0x200,
+	[MASK_AON_APB_OTG_UTMI_SOFT_RST]		= 0x100,
+	[MASK_AON_APB_OTG_VBUS_VALID_PHYREG]		= 0x1000000,
+	[MASK_AON_APB_UTMI_WIDTH_SEL]			= 0x40000000,
+	[MASK_AON_APB_USB2_PHY_IDDIG]			= 0x8,
+	[MASK_ANALOG_USB20_USB20_VBUSVLDEXT]		= 0x10000,
+	[MASK_ANALOG_USB20_USB20_DATABUS16_8]		= 0x10000000,
+	[MASK_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN]	= 0x2,
+	[MASK_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN]	= 0x4,
+	[MASK_ANALOG_USB20_USB20_DMPULLDOWN]		= 0x8,
+	[MASK_ANALOG_USB20_USB20_DPPULLDOWN]		= 0x10,
+	[MASK_ANALOG_USB20_USB20_PS_PD_S]		= 0x10,
+	[MASK_ANALOG_USB20_USB20_PS_PD_L]		= 0x8,
+	[MASK_ANALOG_USB20_USB20_RESERVED]		= 0xffff,
+	[MASK_ANALOG_USB20_USB20_ISO_SW_EN]		= 0x1,
+	[MASK_ANALOG_USB20_USB20_TUNEHSAMP]		= 0x06000000,
+	[MASK_ANALOG_USB20_USB20_TUNEEQ]		= 0x7,
+	[MASK_ANALOG_USB20_USB20_TFREGRES]		= 0x01f80000,
+};
+
+static const unsigned int qogirl6_masks_layout[] = {
+	[MASK_AON_APB_ANA_EB]				= 0x1000,
+	[MASK_AON_APB_OTG_UTMI_EB]			= 0x100,
+	[MASK_AON_APB_CGM_OTG_REF_EN]			= 0x1000,
+	[MASK_AON_APB_CGM_DPHY_REF_EN]			= 0x400,
+	[MASK_AON_APB_OTG_PHY_SOFT_RST]			= 0x200,
+	[MASK_AON_APB_OTG_UTMI_SOFT_RST]		= 0x100,
+	[MASK_AON_APB_OTG_VBUS_VALID_PHYREG]		= 0x1000000,
+	[MASK_AON_APB_UTMI_WIDTH_SEL]			= 0x40000000,
+	[MASK_AON_APB_USB2_PHY_IDDIG]			= 0x8,
+	[MASK_ANALOG_USB20_USB20_VBUSVLDEXT]		= 0x10000,
+	[MASK_ANALOG_USB20_USB20_DATABUS16_8]		= 0x10000000,
+	[MASK_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN]	= 0x2,
+	[MASK_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN]	= 0x4,
+	[MASK_ANALOG_USB20_USB20_DMPULLDOWN]		= 0x8,
+	[MASK_ANALOG_USB20_USB20_DPPULLDOWN]		= 0x10,
+	[MASK_ANALOG_USB20_USB20_PS_PD_S]		= 0x10,
+	[MASK_ANALOG_USB20_USB20_PS_PD_L]		= 0x8,
+	[MASK_ANALOG_USB20_USB20_RESERVED]		= 0xffff,
+	[MASK_ANALOG_USB20_USB20_ISO_SW_EN]		= 0x1,
+	[MASK_ANALOG_USB20_USB20_TUNEHSAMP]		= 0x06000000,
+	[MASK_ANALOG_USB20_USB20_TUNEEQ]		= 0x7,
+	[MASK_ANALOG_USB20_USB20_TFREGRES]		= 0x01f80000,
+};
+
+static const unsigned int qogirn6lite_masks_layout[] = {
+	[MASK_AON_APB_AON_USB2_TOP_EB]			= 0x0100,
+	[MASK_AON_APB_OTG_PHY_EB]			= 0x0200,
+	[MASK_AON_APB_CGM_OTG_REF_EN]			= 0x1000,
+	[MASK_AON_APB_CGM_DPHY_REF_EN]			= 0x400,
+	[MASK_AON_APB_OTG_PHY_SOFT_RST]			= 0x200,
+	[MASK_AON_APB_OTG_UTMI_SOFT_RST]		= 0x100,
+	[MASK_AON_APB_OTG_VBUS_VALID_PHYREG]		= 0x1000000,
+	[MASK_AON_APB_USB2_PHY_IDDIG]			= 0x8,
+	[MASK_AON_APB_USB20_CTRL_MUX_REG]		= 0x0008,
+	[MASK_AON_APB_USB20_ISO_SW_EN]			= 0x0010,
+	[MASK_AON_APB_C2G_ANALOG_USB20_USB20_PS_PD_S]	= 0x0002,
+	[MASK_AON_APB_C2G_ANALOG_USB20_USB20_PS_PD_L]	= 0x0001,
+	[MASK_ANALOG_USB20_USB20_VBUSVLDEXT]		= 0x10000,
+	[MASK_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN]	= 0x4,
+	[MASK_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN]	= 0x8,
+	[MASK_ANALOG_USB20_USB20_DMPULLDOWN]		= 0x8,
+	[MASK_ANALOG_USB20_USB20_DPPULLDOWN]		= 0x10,
+	[MASK_ANALOG_USB20_USB20_RESERVED]		= 0x0000FFFF,
+	[MASK_ANALOG_USB20_USB20_ISO_SW_EN]		= 0x1,
+	[MASK_ANALOG_USB20_USB20_TUNEHSAMP]		= 0x06000000,
+	[MASK_ANALOG_USB20_USB20_TUNEEQ]		= 0x7,
+	[MASK_ANALOG_USB20_USB20_TFREGRES]		= 0x01f80000,
+};
+
+static const unsigned int uis8520_masks_layout[] = {
+	[MASK_AON_APB_AON_USB2_TOP_EB]			= 0x0100,
+	[MASK_AON_APB_OTG_PHY_EB]			= 0x0200,
+	[MASK_AON_APB_CGM_OTG_REF_EN]			= 0x1000,
+	[MASK_AON_APB_OTG_PHY_SOFT_RST]			= 0x200,
+	[MASK_AON_APB_OTG_UTMI_SOFT_RST]		= 0x100,
+	[MASK_AON_APB_OTG_VBUS_VALID_PHYREG]		= 0x1000000,
+	[MASK_AON_APB_USB2_PHY_IDDIG]			= 0x8,
+	[MASK_AON_APB_USB20_CTRL_MUX_REG]		= 0x0008,
+	[MASK_AON_APB_USB20_ISO_SW_EN]			= 0x0010,
+	[MASK_AON_APB_C2G_ANALOG_USB20_USB20_PS_PD_S]	= 0x0002,
+	[MASK_AON_APB_C2G_ANALOG_USB20_USB20_PS_PD_L]	= 0x0001,
+	[MASK_ANALOG_USB20_USB20_VBUSVLDEXT]		= 0x10000,
+	[MASK_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN]	= 0x4,
+	[MASK_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN]	= 0x8,
+	[MASK_ANALOG_USB20_USB20_DMPULLDOWN]		= 0x8,
+	[MASK_ANALOG_USB20_USB20_DPPULLDOWN]		= 0x10,
+	[MASK_ANALOG_USB20_USB20_RESERVED]		= 0x0000FFFF,
+	[MASK_ANALOG_USB20_USB20_ISO_SW_EN]		= 0x1,
+	[MASK_ANALOG_USB20_USB20_TUNEHSAMP]		= 0xC0,
+	[MASK_ANALOG_USB20_USB20_TUNEEQ]		= 0x7,
+	[MASK_ANALOG_USB20_USB20_TFREGRES]		= 0x1F,
+};
+
+static const unsigned int phy_pike2_parameters[] = {
+	[TUNEHSAMP_SHIFT]		= 30,
+	[TUNEEQ_SHIFT]			= 0,
+	[TFREGRES_SHIFT]		= 8,
+	[FULLSPEED_USB33_TUNE]		= 2700000,
+};
+
+static const unsigned int phy_sharkle_parameters[] = {
+	[TUNEHSAMP_SHIFT]		= 30,
+	[TUNEEQ_SHIFT]			= 0,
+	[TFREGRES_SHIFT]		= 8,
+	[FULLSPEED_USB33_TUNE]		= 2700000,
+};
+
+static const unsigned int phy_sharkl3_parameters[] = {
+	[TUNEHSAMP_SHIFT]		= 27,
+	[TUNEEQ_SHIFT]			= 2,
+	[TFREGRES_SHIFT]		= 21,
+	[FULLSPEED_USB33_TUNE]		= 2700000,
+};
+
+static const unsigned int phy_sharkl5_parameters[] = {
+	[TUNEHSAMP_SHIFT]		= 25,
+	[TUNEEQ_SHIFT]			= 0,
+	[TFREGRES_SHIFT]		= 19,
+	[FULLSPEED_USB33_TUNE]		= 2700000,
+};
+
+static const unsigned int phy_sharkl5pro_parameters[] = {
+	[TUNEHSAMP_SHIFT]		= 25,
+	[TUNEEQ_SHIFT]			= 0,
+	[TFREGRES_SHIFT]		= 19,
+	[FULLSPEED_USB33_TUNE]		= 2700000,
+};
+
+static const unsigned int phy_qogirl6_parameters[] = {
+	[TUNEHSAMP_SHIFT]		= 25,
+	[TUNEEQ_SHIFT]			= 0,
+	[TFREGRES_SHIFT]		= 19,
+	[FULLSPEED_USB33_TUNE]		= 2700000,
+};
+
+static const unsigned int phy_qogirn6lite_parameters[] = {
+	[TUNEHSAMP_SHIFT]		= 25,
+	[TUNEEQ_SHIFT]			= 0,
+	[TFREGRES_SHIFT]		= 19,
+	[FULLSPEED_USB33_TUNE]		= 3300000,
+};
+
+static const unsigned int phy_uis8520_parameters[] = {
+	[TUNEHSAMP_SHIFT]		= 6,
+	[TUNEEQ_SHIFT]			= 0,
+	[TFREGRES_SHIFT]		= 0,
+	[FULLSPEED_USB33_TUNE]		= 3300000,
+};
+
+#endif
-- 
2.17.1

