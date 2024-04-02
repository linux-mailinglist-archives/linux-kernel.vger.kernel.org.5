Return-Path: <linux-kernel+bounces-127419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87514894B16
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0DF1C21975
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B643829429;
	Tue,  2 Apr 2024 06:02:23 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0C1CAA3;
	Tue,  2 Apr 2024 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037742; cv=none; b=ZjoMmOKtADdxG7g4T7hIefoNTr2QnnrXQcfA10VmQkXSE5GHX5R6nUHpHmv4+43TLuqhemphA6FpqO3CUqQY6emXlgNPyfk1dxgFi5WEwlj9+TujAFsewbIormodT6AGxw6lY4lI/NY9l0k5oSZlSXhHvszF88ij7Ec50ivH+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037742; c=relaxed/simple;
	bh=zlQZWfIe1kVBbJIA7bkjb9fwGdIMjC0mrLU/lEnxMQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XPtnLu4clfx17/Iagsn19KBCmxPiKmmPPZVk/NdJnIIG9XKMaSunzoIAiKaE+APHTk1zL9ORsYgjUcDZMNUR78rXWmF8lL3o9G6DZ19JYt3SZza0BWXkjZvMAhT+A7cKpn9mVZ+AG+rtEMgHOUFFZabl1DQ350B+ZWVljzSzvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DC1521A04E5;
	Tue,  2 Apr 2024 08:02:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5FC1E1A19BC;
	Tue,  2 Apr 2024 08:02:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0100A183ACAF;
	Tue,  2 Apr 2024 14:02:16 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	frank.li@nxp.com,
	conor+dt@kernel.org
Cc: hongxing.zhu@nxp.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v2 3/3] phy: freescale: imx8q-hsio: Add i.MX8Q HSIO PHY driver support
Date: Tue,  2 Apr 2024 13:45:04 +0800
Message-Id: <1712036704-21064-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1712036704-21064-1-git-send-email-hongxing.zhu@nxp.com>
References: <1712036704-21064-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add i.MX8Q HSIO PHY driver support.
- Add one HSIO configuration property, that used to select the
"PCIE_AB_SELECT" and "PHY_X1_EPCS_SEL" during the initialization.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/phy/freescale/Kconfig              |   8 +
 drivers/phy/freescale/Makefile             |   1 +
 drivers/phy/freescale/phy-fsl-imx8q-hsio.c | 518 +++++++++++++++++++++
 3 files changed, 527 insertions(+)
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8q-hsio.c

diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
index 853958fb2c06..bcddddef1cbb 100644
--- a/drivers/phy/freescale/Kconfig
+++ b/drivers/phy/freescale/Kconfig
@@ -35,6 +35,14 @@ config PHY_FSL_IMX8M_PCIE
 	  Enable this to add support for the PCIE PHY as found on
 	  i.MX8M family of SOCs.
 
+config PHY_FSL_IMX8Q_HSIO
+	tristate "Freescale i.MX8Q HSIO PHY"
+	depends on OF && HAS_IOMEM
+	select GENERIC_PHY
+	help
+	  Enable this to add support for the HSIO PHY as found on
+	  i.MX8Q family of SOCs.
+
 endif
 
 config PHY_FSL_LYNX_28G
diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makefile
index cedb328bc4d2..db888c37fcf9 100644
--- a/drivers/phy/freescale/Makefile
+++ b/drivers/phy/freescale/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)	+= phy-fsl-imx8mq-usb.o
 obj-$(CONFIG_PHY_MIXEL_LVDS_PHY)	+= phy-fsl-imx8qm-lvds-phy.o
 obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)	+= phy-fsl-imx8-mipi-dphy.o
 obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)	+= phy-fsl-imx8m-pcie.o
+obj-$(CONFIG_PHY_FSL_IMX8Q_HSIO)	+= phy-fsl-imx8q-hsio.o
 obj-$(CONFIG_PHY_FSL_LYNX_28G)		+= phy-fsl-lynx-28g.o
diff --git a/drivers/phy/freescale/phy-fsl-imx8q-hsio.c b/drivers/phy/freescale/phy-fsl-imx8q-hsio.c
new file mode 100644
index 000000000000..14fc925c4f57
--- /dev/null
+++ b/drivers/phy/freescale/phy-fsl-imx8q-hsio.c
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/pci_regs.h>
+#include <linux/phy/phy.h>
+#include <linux/phy/pcie.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+
+#define MAX_NUM_LANES	3
+#define LANE_NUM_CLKS	5
+
+/* Parameters for the waiting for PCIe PHY PLL to lock */
+#define PHY_INIT_WAIT_USLEEP_MAX	10
+#define PHY_INIT_WAIT_TIMEOUT		(1000 * PHY_INIT_WAIT_USLEEP_MAX)
+
+/* i.MX8Q HSIO registers */
+#define CTRL0			0x0
+#define APB_RSTN_0		BIT(0)
+#define APB_RSTN_1		BIT(1)
+#define PIPE_RSTN_0_MASK	GENMASK(25, 24)
+#define PIPE_RSTN_1_MASK	GENMASK(27, 26)
+#define MODE_MASK		GENMASK(20, 17)
+#define MODE_PCIE		0x0
+#define MODE_SATA		0x4
+#define DEVICE_TYPE_MASK	GENMASK(27, 24)
+#define EPCS_TXDEEMP		BIT(5)
+#define EPCS_TXDEEMP_SEL	BIT(6)
+#define EPCS_PHYRESET_N		BIT(7)
+#define RESET_N			BIT(12)
+
+#define IOB_RXENA		BIT(0)
+#define IOB_TXENA		BIT(1)
+#define IOB_A_0_TXOE		BIT(2)
+#define IOB_A_0_M1M0_2		BIT(4)
+#define IOB_A_0_M1M0_MASK	GENMASK(4, 3)
+#define PHYX1_EPCS_SEL		BIT(12)
+#define PCIE_AB_SELECT		BIT(13)
+#define CLKREQN_OUT_OVERRIDE	GENMASK(25, 24)
+
+#define PHY_STTS0		0x4
+#define LANE0_TX_PLL_LOCK	BIT(4)
+#define LANE1_TX_PLL_LOCK	BIT(12)
+
+#define CTRL2			0x8
+#define LTSSM_ENABLE		BIT(4)
+#define BUTTON_RST_N		BIT(21)
+#define PERST_N			BIT(22)
+#define POWER_UP_RST_N		BIT(23)
+
+#define PCIE_STTS0		0xc
+#define PM_REQ_CORE_RST		BIT(19)
+
+#define REG48_PMA_STATUS	0x30
+#define REG48_PMA_RDY		BIT(7)
+
+struct imx8q_hsio_drvdata {
+	int num_lane;
+};
+
+struct imx8q_hsio_lane {
+	const char * const *clk_names;
+	struct clk_bulk_data clks[LANE_NUM_CLKS];
+	u32 clks_cnt;
+	u32 ctrl_id;
+	u32 ctrl_off;
+	u32 idx;
+	u32 phy_off;
+	struct imx8q_hsio_priv *priv;
+	struct phy *phy;
+	enum phy_mode lane_mode;
+};
+
+struct imx8q_hsio_priv {
+	void __iomem *base;
+	struct device *dev;
+	u32 refclk_pad_mode;
+	u32 hsio_cfg;
+	struct regmap *phy;
+	struct regmap *ctrl;
+	struct regmap *misc;
+	const struct imx8q_hsio_drvdata *drvdata;
+	struct imx8q_hsio_lane lane[MAX_NUM_LANES];
+};
+
+static const char * const imx8q_hsio_lan0_pcie_clks[] = {"apb_pclk0", "pclk0",
+	"ctl0_crr", "phy0_crr", "misc_crr"};
+static const char * const imx8q_hsio_lan1_pciea_clks[] = {"apb_pclk1", "pclk1",
+	"ctl0_crr", "phy0_crr", "misc_crr"};
+static const char * const imx8q_hsio_lan1_pcieb_clks[] = {"apb_pclk1", "pclk1",
+	"ctl1_crr", "phy0_crr", "misc_crr"};
+static const char * const imx8q_hsio_lan2_pcieb_clks[] = {"apb_pclk2", "pclk2",
+	"ctl1_crr", "phy1_crr", "misc_crr"};
+static const char * const imx8q_hsio_lane_sata_clks[] = {"pclk2", "epcs_tx",
+	"epcs_rx", "phy1_crr", "misc_crr"};
+
+static const struct regmap_config regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static int imx8q_hsio_init(struct phy *phy)
+{
+	int ret, i;
+	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
+	struct imx8q_hsio_priv *priv = lane->priv;
+	struct device *dev = priv->dev;
+
+	/* Assign clocks refer to different modes */
+	switch (lane->ctrl_id) {
+	case IMX8Q_HSIO_PCIEA_ID:
+		if (lane->idx > 1) {
+			dev_err(dev, "invalid lane ID.");
+			return -EINVAL;
+		}
+
+		lane->lane_mode = PHY_MODE_PCIE;
+		lane->ctrl_off = 0;
+		lane->phy_off = 0;
+
+		for (i = 0; i < LANE_NUM_CLKS; i++) {
+			if (lane->idx)
+				lane->clks[i].id = imx8q_hsio_lan1_pciea_clks[i];
+			else
+				lane->clks[i].id = imx8q_hsio_lan0_pcie_clks[i];
+		}
+		break;
+	case IMX8Q_HSIO_PCIEB_ID:
+		if (lane->idx > 2) {
+			dev_err(dev, "invalid lane ID.");
+			return -EINVAL;
+		}
+
+		lane->lane_mode = PHY_MODE_PCIE;
+		if (lane->idx == 0) {
+			/* i.MX8QXP */
+			lane->ctrl_off = 0;
+			lane->phy_off = 0;
+		} else {
+			/*
+			 * On i.MX8QM, only second or third lane PHY can
+			 * be binded to PCIEB.
+			 */
+			lane->ctrl_off = SZ_64K;
+			if (lane->idx == 1)
+				lane->phy_off = 0;
+			else /* idx == 2, the third lane is binded to PCIEB */
+				lane->phy_off = SZ_64K;
+		}
+
+		for (i = 0; i < LANE_NUM_CLKS; i++) {
+			if (lane->idx == 1)
+				lane->clks[i].id = imx8q_hsio_lan1_pcieb_clks[i];
+			else if (lane->idx == 2)
+				lane->clks[i].id = imx8q_hsio_lan2_pcieb_clks[i];
+			else /* i.MX8QXP only has PCIEB, it's idx == 0 */
+				lane->clks[i].id = imx8q_hsio_lan0_pcie_clks[i];
+
+		}
+		break;
+	case IMX8Q_HSIO_SATA_ID:
+		/* On i.MX8QM, only the third lane PHY can be binded to SATA */
+		if (lane->idx != 2) {
+			dev_err(dev, "invalid lane ID.");
+			return -EINVAL;
+		}
+		lane->ctrl_off = SZ_128K;
+		lane->lane_mode = PHY_MODE_SATA;
+		lane->phy_off = SZ_64K;
+
+		for (i = 0; i < LANE_NUM_CLKS; i++)
+			lane->clks[i].id = imx8q_hsio_lane_sata_clks[i];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Fetch clocks */
+	ret = devm_clk_bulk_get(dev, LANE_NUM_CLKS, lane->clks);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare_enable(LANE_NUM_CLKS, lane->clks);
+	if (ret)
+		return ret;
+
+	/* allow the clocks to stabilize */
+	usleep_range(200, 500);
+	return 0;
+}
+
+static int imx8q_hsio_exit(struct phy *phy)
+{
+	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
+
+	clk_bulk_disable_unprepare(LANE_NUM_CLKS, lane->clks);
+
+	return 0;
+}
+
+static void imx8q_hsio_pcie_phy_resets(struct phy *phy)
+{
+	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
+	struct imx8q_hsio_priv *priv = lane->priv;
+
+	regmap_clear_bits(priv->ctrl, lane->ctrl_off + CTRL2, BUTTON_RST_N);
+	regmap_clear_bits(priv->ctrl, lane->ctrl_off + CTRL2, PERST_N);
+	regmap_clear_bits(priv->ctrl, lane->ctrl_off + CTRL2, POWER_UP_RST_N);
+	regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL2, BUTTON_RST_N);
+	regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL2, PERST_N);
+	regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL2, POWER_UP_RST_N);
+
+	if (lane->idx == 1) {
+		/* The second lane */
+		regmap_set_bits(priv->phy, lane->phy_off + CTRL0, APB_RSTN_1);
+		regmap_set_bits(priv->phy, lane->phy_off + CTRL0, PIPE_RSTN_1_MASK);
+	} else {
+		regmap_set_bits(priv->phy, lane->phy_off + CTRL0, APB_RSTN_0);
+		regmap_set_bits(priv->phy, lane->phy_off + CTRL0, PIPE_RSTN_0_MASK);
+	}
+}
+
+static void imx8q_hsio_sata_phy_resets(struct phy *phy)
+{
+	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
+	struct imx8q_hsio_priv *priv = lane->priv;
+
+	/* clear PHY RST, then set it */
+	regmap_clear_bits(priv->ctrl, lane->ctrl_off + CTRL0, EPCS_PHYRESET_N);
+
+	regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL0, EPCS_PHYRESET_N);
+
+	/* CTRL RST: SET -> delay 1 us -> CLEAR -> SET */
+	regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL0, RESET_N);
+	udelay(1);
+	regmap_clear_bits(priv->ctrl, lane->ctrl_off + CTRL0, RESET_N);
+	regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL0, RESET_N);
+}
+
+static void imx8q_hsio_configure_clk_pad(struct phy *phy)
+{
+	bool pll = false;
+	u32 pad_mode;
+	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
+	struct imx8q_hsio_priv *priv = lane->priv;
+
+	pad_mode = priv->refclk_pad_mode;
+	if (pad_mode == IMX8_PCIE_REFCLK_PAD_OUTPUT) {
+		pll = true;
+		regmap_update_bits(priv->misc, CTRL0,
+				   IOB_A_0_TXOE | IOB_A_0_M1M0_MASK,
+				   IOB_A_0_TXOE | IOB_A_0_M1M0_2);
+	}
+
+	regmap_update_bits(priv->misc, CTRL0, IOB_RXENA, pll ? 0 : IOB_RXENA);
+	regmap_update_bits(priv->misc, CTRL0, IOB_TXENA, pll ? IOB_TXENA : 0);
+}
+
+static int imx8q_hsio_power_on(struct phy *phy)
+{
+	int ret;
+	u32 val, cond;
+	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
+	struct imx8q_hsio_priv *priv = lane->priv;
+
+	if (lane->lane_mode == PHY_MODE_PCIE)
+		imx8q_hsio_pcie_phy_resets(phy);
+	else
+		/* SATA */
+		regmap_set_bits(priv->phy, lane->phy_off + CTRL0, APB_RSTN_0);
+
+	if (priv->hsio_cfg & IMX8Q_HSIO_CFG_PCIEB)
+		regmap_set_bits(priv->misc, CTRL0, PCIE_AB_SELECT);
+	if (priv->hsio_cfg & IMX8Q_HSIO_CFG_SATA)
+		regmap_set_bits(priv->misc, CTRL0, PHYX1_EPCS_SEL);
+
+	imx8q_hsio_configure_clk_pad(phy);
+
+	if (lane->lane_mode == PHY_MODE_SATA) {
+		/*
+		 * It is possible, for PCIe and SATA are sharing
+		 * the same clock source, HPLL or external oscillator.
+		 * When PCIe is in low power modes (L1.X or L2 etc),
+		 * the clock source can be turned off. In this case,
+		 * if this clock source is required to be toggling by
+		 * SATA, then SATA functions will be abnormal.
+		 * Set the override here to avoid it.
+		 */
+		regmap_set_bits(priv->misc, CTRL0, CLKREQN_OUT_OVERRIDE);
+		regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL0, EPCS_TXDEEMP);
+		regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL0, EPCS_TXDEEMP_SEL);
+
+		imx8q_hsio_sata_phy_resets(phy);
+	} else {
+		/* Toggle apb_pclk to make sure clear the PM_REQ_CORE_RST bit */
+		clk_disable_unprepare(lane->clks[0].clk);
+		mdelay(1);
+		ret = clk_prepare_enable(lane->clks[0].clk);
+		if (ret) {
+			dev_err(priv->dev, "unable to enable phy apb_pclk\n");
+			return ret;
+		}
+
+		/* Bit19 PM_REQ_CORE_RST of pcie_stts0 should be cleared. */
+		ret = regmap_read_poll_timeout(priv->ctrl,
+				lane->ctrl_off + PCIE_STTS0,
+				val, (val & PM_REQ_CORE_RST) == 0,
+				PHY_INIT_WAIT_USLEEP_MAX,
+				PHY_INIT_WAIT_TIMEOUT);
+		if (ret) {
+			dev_err(priv->dev, "PM_REQ_CORE_RST is set\n");
+			return ret;
+		}
+	}
+
+	/* Polling to check the PHY is ready or not. */
+	if (lane->idx == 1)
+		cond = LANE1_TX_PLL_LOCK;
+	else
+		cond = LANE0_TX_PLL_LOCK;
+
+	ret = regmap_read_poll_timeout(priv->phy, lane->phy_off + PHY_STTS0,
+			val, ((val & cond) == cond),
+			PHY_INIT_WAIT_USLEEP_MAX, PHY_INIT_WAIT_TIMEOUT);
+	if (ret)
+		dev_err(priv->dev, "IMX8Q PHY%d PLL lock timeout\n", lane->idx);
+	else
+		dev_info(priv->dev, "IMX8Q PHY%d PLL is locked\n", lane->idx);
+
+	if (lane->lane_mode == PHY_MODE_SATA) {
+		cond = REG48_PMA_RDY;
+		ret = read_poll_timeout(readb, val, ((val & cond) == cond),
+				PHY_INIT_WAIT_USLEEP_MAX, PHY_INIT_WAIT_TIMEOUT,
+				false, priv->base + REG48_PMA_STATUS);
+		if (ret)
+			dev_err(priv->dev, "PHY calibration is timeout\n");
+		else
+			dev_info(priv->dev, "PHY calibration is done\n");
+	}
+
+	return ret;
+}
+
+static int imx8q_hsio_set_mode(struct phy *phy, enum phy_mode mode,
+				   int submode)
+{
+	u32 val;
+	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
+	struct imx8q_hsio_priv *priv = lane->priv;
+
+	if (lane->lane_mode != mode)
+		return -EINVAL;
+
+	val = (mode == PHY_MODE_PCIE) ? MODE_PCIE : MODE_SATA;
+	val = FIELD_PREP(MODE_MASK, val);
+	regmap_update_bits(priv->phy, lane->phy_off + CTRL0, MODE_MASK, val);
+
+	switch (submode) {
+	case PHY_MODE_PCIE_RC:
+		val = FIELD_PREP(DEVICE_TYPE_MASK, PCI_EXP_TYPE_ROOT_PORT);
+		break;
+	case PHY_MODE_PCIE_EP:
+		val = FIELD_PREP(DEVICE_TYPE_MASK, PCI_EXP_TYPE_ENDPOINT);
+		break;
+	default: /* Support only PCIe EP and RC now. */
+		return 0;
+	}
+	if (submode)
+		regmap_update_bits(priv->ctrl, lane->ctrl_off + CTRL0,
+				   DEVICE_TYPE_MASK, val);
+
+	return 0;
+}
+
+static int imx8q_hsio_set_speed(struct phy *phy, int speed)
+{
+	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
+	struct imx8q_hsio_priv *priv = lane->priv;
+
+	regmap_update_bits(priv->ctrl, lane->ctrl_off + CTRL2, LTSSM_ENABLE,
+			   speed ? LTSSM_ENABLE : 0);
+	return 0;
+}
+
+static const struct phy_ops imx8q_hsio_ops = {
+	.init = imx8q_hsio_init,
+	.exit = imx8q_hsio_exit,
+	.power_on = imx8q_hsio_power_on,
+	.set_mode = imx8q_hsio_set_mode,
+	.set_speed = imx8q_hsio_set_speed,
+	.owner = THIS_MODULE,
+};
+
+static const struct imx8q_hsio_drvdata imx8qxp_serdes_drvdata = {
+	.num_lane = 1,
+};
+
+static const struct imx8q_hsio_drvdata imx8qm_serdes_drvdata = {
+	.num_lane = 3,
+};
+
+static const struct of_device_id imx8q_hsio_of_match[] = {
+	{.compatible = "fsl,imx8qxp-serdes", .data = &imx8qxp_serdes_drvdata},
+	{.compatible = "fsl,imx8qm-serdes", .data = &imx8qm_serdes_drvdata},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, imx8q_hsio_of_match);
+
+static struct phy *imx8q_hsio_xlate(struct device *dev,
+				    const struct of_phandle_args *args)
+{
+	struct imx8q_hsio_priv *priv = dev_get_drvdata(dev);
+	int idx = args->args[0];
+	int ctrl_id = args->args[1];
+	int hsio_cfg = args->args[2];
+
+	if (idx >= priv->drvdata->num_lane)
+		return ERR_PTR(-EINVAL);
+	priv->lane[idx].idx = idx;
+	priv->lane[idx].ctrl_id = ctrl_id;
+	priv->hsio_cfg = hsio_cfg;
+
+	return priv->lane[idx].phy;
+}
+
+static int imx8q_hsio_probe(struct platform_device *pdev)
+{
+	int i;
+	void __iomem *off;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct of_device_id *of_id;
+	struct imx8q_hsio_priv *priv;
+	struct phy_provider *provider;
+
+	of_id = of_match_device(imx8q_hsio_of_match, dev);
+	if (!of_id)
+		return -EINVAL;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = &pdev->dev;
+	priv->drvdata = of_device_get_match_data(dev);
+
+	/* Get PHY refclk pad mode */
+	of_property_read_u32(np, "fsl,refclk-pad-mode", &priv->refclk_pad_mode);
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	off = devm_platform_ioremap_resource_byname(pdev, "phy");
+	priv->phy = devm_regmap_init_mmio(dev, off, &regmap_config);
+	if (IS_ERR(priv->phy))
+		return dev_err_probe(dev, PTR_ERR(priv->phy),
+				     "unable to find phy csr registers\n");
+
+	off = devm_platform_ioremap_resource_byname(pdev, "ctrl");
+	priv->ctrl = devm_regmap_init_mmio(dev, off, &regmap_config);
+	if (IS_ERR(priv->ctrl))
+		return dev_err_probe(dev, PTR_ERR(priv->ctrl),
+				     "unable to find ctrl csr registers\n");
+
+	off = devm_platform_ioremap_resource_byname(pdev, "misc");
+	priv->misc = devm_regmap_init_mmio(dev, off, &regmap_config);
+	if (IS_ERR(priv->misc))
+		return dev_err_probe(dev, PTR_ERR(priv->misc),
+				     "unable to find misc csr registers\n");
+
+	for (i = 0; i < priv->drvdata->num_lane; i++) {
+		struct imx8q_hsio_lane *lane = &priv->lane[i];
+		struct phy *phy;
+
+		memset(lane, 0, sizeof(*lane));
+
+		phy = devm_phy_create(&pdev->dev, NULL, &imx8q_hsio_ops);
+		if (IS_ERR(phy))
+			return PTR_ERR(phy);
+
+		lane->priv = priv;
+		lane->phy = phy;
+		lane->idx = i;
+		phy_set_drvdata(phy, lane);
+	}
+
+	dev_set_drvdata(dev, priv);
+	dev_set_drvdata(&pdev->dev, priv);
+
+	provider = devm_of_phy_provider_register(&pdev->dev, imx8q_hsio_xlate);
+
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static struct platform_driver imx8q_hsio_driver = {
+	.probe	= imx8q_hsio_probe,
+	.driver = {
+		.name	= "imx8q-hsio-phy",
+		.of_match_table	= imx8q_hsio_of_match,
+	}
+};
+module_platform_driver(imx8q_hsio_driver);
+
+MODULE_DESCRIPTION("FSL IMX8Q HSIO SERDES PHY driver");
+MODULE_LICENSE("GPL");
-- 
2.37.1


