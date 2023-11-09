Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB5D7E73FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjKIVwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjKIVwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:52:16 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96773C3C;
        Thu,  9 Nov 2023 13:52:13 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r1CwT-0003Ym-0Z;
        Thu, 09 Nov 2023 21:52:01 +0000
Date:   Thu, 9 Nov 2023 21:51:57 +0000
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
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: [RFC PATCH 6/8] net: pcs: add driver for MediaTek USXGMII PCS
Message-ID: <b9f787f3e4aa36e148d7595495af60db53f74417.1699565880.git.daniel@makrotopia.org>
References: <cover.1699565880.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699565880.git.daniel@makrotopia.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for USXGMII PCS found in the MediaTek MT7988 SoC and supporting
USXGMII, 10GBase-R and 5GBase-R interface modes. In order to support
Cisco SGMII, 1000Base-X and 2500Base-X via the also present LynxI PCS
create a wrapped PCS taking care of the components shared between the
new USXGMII PCS and the legacy LynxI PCS.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 MAINTAINERS                         |   2 +
 drivers/net/pcs/Kconfig             |  10 +
 drivers/net/pcs/Makefile            |   1 +
 drivers/net/pcs/pcs-mtk-usxgmii.c   | 688 ++++++++++++++++++++++++++++
 include/linux/pcs/pcs-mtk-usxgmii.h |  18 +
 5 files changed, 719 insertions(+)
 create mode 100644 drivers/net/pcs/pcs-mtk-usxgmii.c
 create mode 100644 include/linux/pcs/pcs-mtk-usxgmii.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6499acd8f3874..026f62243f595 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13517,7 +13517,9 @@ M:	Daniel Golle <daniel@makrotopia.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/pcs/pcs-mtk-lynxi.c
+F:	drivers/net/pcs/pcs-mtk-usxgmii.c
 F:	include/linux/pcs/pcs-mtk-lynxi.h
+F:	include/linux/pcs/pcs-mtk-usxgmii.h
 
 MEDIATEK ETHERNET PHY DRIVERS
 M:	Daniel Golle <daniel@makrotopia.org>
diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index 87cf308fc6d8b..5df5b19c4eb93 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -25,6 +25,16 @@ config PCS_MTK_LYNXI
 	  This module provides helpers to phylink for managing the LynxI PCS
 	  which is part of MediaTek's SoC and Ethernet switch ICs.
 
+config PCS_MTK_USXGMII
+	tristate "MediaTek USXGMII PCS"
+	select PCS_MTK_LYNXI
+	select PHY_MTK_PEXTP
+	help
+	  This module provides a driver for MediaTek's USXGMII PCS supporting
+	  10GBase-R, 5GBase-R and USXGMII interface modes.
+	  1000Base-X, 2500Base-X and Cisco SGMII are supported on the same
+	  differential pairs via an embedded LynxI PHY.
+
 config PCS_RZN1_MIIC
 	tristate "Renesas RZ/N1 MII converter"
 	depends on OF && (ARCH_RZN1 || COMPILE_TEST)
diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
index fb1694192ae63..cc355152ca1ca 100644
--- a/drivers/net/pcs/Makefile
+++ b/drivers/net/pcs/Makefile
@@ -6,4 +6,5 @@ pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-nxp.o pcs-xpcs-wx.o
 obj-$(CONFIG_PCS_XPCS)		+= pcs_xpcs.o
 obj-$(CONFIG_PCS_LYNX)		+= pcs-lynx.o
 obj-$(CONFIG_PCS_MTK_LYNXI)	+= pcs-mtk-lynxi.o
+obj-$(CONFIG_PCS_MTK_USXGMII)	+= pcs-mtk-usxgmii.o
 obj-$(CONFIG_PCS_RZN1_MIIC)	+= pcs-rzn1-miic.o
diff --git a/drivers/net/pcs/pcs-mtk-usxgmii.c b/drivers/net/pcs/pcs-mtk-usxgmii.c
new file mode 100644
index 0000000000000..b3ca66c9df2a9
--- /dev/null
+++ b/drivers/net/pcs/pcs-mtk-usxgmii.c
@@ -0,0 +1,688 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Henry Yen <henry.yen@mediatek.com>
+ *         Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mdio.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/pcs/pcs-mtk-lynxi.h>
+#include <linux/pcs/pcs-mtk-usxgmii.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+/* USXGMII subsystem config registers */
+/* Register to control speed */
+#define RG_PHY_TOP_SPEED_CTRL1			0x80c
+#define USXGMII_RATE_UPDATE_MODE		BIT(31)
+#define USXGMII_MAC_CK_GATED			BIT(29)
+#define USXGMII_IF_FORCE_EN			BIT(28)
+#define USXGMII_RATE_ADAPT_MODE			GENMASK(10, 8)
+#define USXGMII_RATE_ADAPT_MODE_X1		0
+#define USXGMII_RATE_ADAPT_MODE_X2		1
+#define USXGMII_RATE_ADAPT_MODE_X4		2
+#define USXGMII_RATE_ADAPT_MODE_X10		3
+#define USXGMII_RATE_ADAPT_MODE_X100		4
+#define USXGMII_RATE_ADAPT_MODE_X5		5
+#define USXGMII_RATE_ADAPT_MODE_X50		6
+#define USXGMII_XFI_RX_MODE			GENMASK(6, 4)
+#define USXGMII_XFI_TX_MODE			GENMASK(2, 0)
+#define USXGMII_XFI_MODE_10G			0
+#define USXGMII_XFI_MODE_5G			1
+#define USXGMII_XFI_MODE_2P5G			3
+
+/* Register to control PCS AN */
+#define RG_PCS_AN_CTRL0				0x810
+#define USXGMII_AN_RESTART			BIT(31)
+#define USXGMII_AN_SYNC_CNT			GENMASK(30, 11)
+#define USXGMII_AN_ENABLE			BIT(0)
+
+#define RG_PCS_AN_CTRL2				0x818
+#define USXGMII_LINK_TIMER_IDLE_DETECT		GENMASK(29, 20)
+#define USXGMII_LINK_TIMER_COMP_ACK_DETECT	GENMASK(19, 10)
+#define USXGMII_LINK_TIMER_AN_RESTART		GENMASK(9, 0)
+
+/* Register to read PCS AN status */
+#define RG_PCS_AN_STS0				0x81c
+#define USXGMII_LPA				GENMASK(15, 0)
+#define USXGMII_LPA_LATCH			BIT(31)
+
+/* Register to read PCS link status */
+#define RG_PCS_RX_STATUS0			0x904
+#define RG_PCS_RX_STATUS_UPDATE			BIT(16)
+#define RG_PCS_RX_LINK_STATUS			BIT(2)
+
+#define MTK_NETSYS_V3_AMA_RGC3			0x128
+
+/* struct mtk_usxgmii_pcs - This structure holds each usxgmii PCS
+ * @pcs:		Phylink PCS structure
+ * @dev:		Pointer to device structure
+ * @base:		IO memory to access PCS hardware
+ * @clk:		Pointer to USXGMII clk
+ * @xfi_pll:		Pointer to XFI PLL clk
+ * @pextp:		The PHYA instance attached to the PCS
+ * @reset:		Pointer to USXGMII reset control
+ * @interface:		Currently selected interface mode
+ * @neg_mode:		Currently used phylink neg_mode
+ */
+struct mtk_usxgmii_pcs {
+	struct phylink_pcs		pcs;
+	struct phylink_pcs		*sgmii_pcs;
+	struct device			*dev;
+	void __iomem			*base;
+	struct clk			*clk;
+	struct clk			*xfi_pll;
+	struct phy			*pextp;
+	struct reset_control		*reset;
+	struct regmap			*regmap_pll;
+	phy_interface_t			interface;
+	unsigned int			neg_mode;
+};
+
+/* struct mtk_sgmii_wrapper_pcs - Structure holding wrapped SGMII PCS
+ * @usxgmii_pcs		Pointer to owning mtk_usxgmii_pcs structure
+ * @pcs			Phylink PCS structure
+ * @clks:		Pointers to 3 SGMII clks
+ * @reset:		Pointer to SGMII reset control
+ * @interface:		Currently selected interface mode
+ * @neg_mode:		Currently used phylink neg_mode
+ */
+struct mtk_sgmii_wrapper_pcs {
+	struct mtk_usxgmii_pcs		*usxgmii_pcs;
+	struct phylink_pcs		*lynxi_pcs;
+	struct phylink_pcs		pcs;
+	struct clk			*clks[3];
+	struct reset_control		*reset;
+	phy_interface_t			interface;
+	unsigned int			neg_mode;
+	bool				permit_pause_to_mac;
+};
+
+static u32 mtk_r32(struct mtk_usxgmii_pcs *mpcs, unsigned int reg)
+{
+	return ioread32(mpcs->base + reg);
+}
+
+static void mtk_m32(struct mtk_usxgmii_pcs *mpcs, unsigned int reg, u32 mask, u32 set)
+{
+	u32 val;
+
+	val = ioread32(mpcs->base + reg);
+	val &= ~mask;
+	val |= set;
+	iowrite32(val, mpcs->base + reg);
+}
+
+static struct mtk_usxgmii_pcs *pcs_to_mtk_usxgmii_pcs(struct phylink_pcs *pcs)
+{
+	return container_of(pcs, struct mtk_usxgmii_pcs, pcs);
+}
+
+static int mtk_xfi_pextp_init(struct mtk_usxgmii_pcs *mpcs)
+{
+	struct device *dev = mpcs->dev;
+
+	mpcs->pextp = devm_phy_get(dev, NULL);
+	if (IS_ERR(mpcs->pextp))
+		return dev_err_probe(dev, PTR_ERR(mpcs->pextp), "cannot acquire PHYA\n");
+
+	if (!mpcs->pextp)
+		return dev_err_probe(dev, -ENODEV, "PHYA not found\n");
+
+	return 0;
+}
+
+static void mtk_usxgmii_reset(struct mtk_usxgmii_pcs *mpcs)
+{
+	if (!mpcs->pextp)
+		return;
+
+	phy_reset(mpcs->pextp);
+
+	reset_control_assert(mpcs->reset);
+	usleep_range(100, 500);
+	reset_control_deassert(mpcs->reset);
+
+	mdelay(10);
+}
+
+static void mtk_sgmii_reset(struct mtk_sgmii_wrapper_pcs *wp)
+{
+	if (!wp->usxgmii_pcs->pextp)
+		return;
+
+	phy_reset(wp->usxgmii_pcs->pextp);
+
+	reset_control_assert(wp->reset);
+	usleep_range(100, 500);
+	reset_control_deassert(wp->reset);
+
+	mdelay(10);
+}
+
+static int mtk_sgmii_wrapped_pcs_config(struct phylink_pcs *pcs,
+					unsigned int neg_mode,
+					phy_interface_t interface,
+					const unsigned long *advertising,
+					bool permit_pause_to_mac)
+{
+	struct mtk_sgmii_wrapper_pcs *wp = container_of(pcs, struct mtk_sgmii_wrapper_pcs, pcs);
+	bool full_reconf;
+	int ret;
+
+	phy_power_on(wp->usxgmii_pcs->pextp);
+
+	full_reconf = (interface != wp->interface);
+	if (full_reconf)
+		mtk_sgmii_reset(wp);
+
+	ret = wp->lynxi_pcs->ops->pcs_config(wp->lynxi_pcs, neg_mode, interface, advertising,
+					     permit_pause_to_mac);
+
+	if (full_reconf)
+		phy_set_mode_ext(wp->usxgmii_pcs->pextp, PHY_MODE_ETHERNET, interface);
+
+	wp->interface = interface;
+	wp->neg_mode = neg_mode;
+	wp->permit_pause_to_mac = permit_pause_to_mac;
+
+	return ret;
+}
+
+static void mtk_sgmii_wrapped_pcs_get_state(struct phylink_pcs *pcs,
+					    struct phylink_link_state *state)
+{
+	struct mtk_sgmii_wrapper_pcs *wp = container_of(pcs, struct mtk_sgmii_wrapper_pcs, pcs);
+
+	wp->lynxi_pcs->ops->pcs_get_state(wp->lynxi_pcs, state);
+
+	/* Continuously repeat re-configuration sequence until link comes up */
+	if (!state->link)
+		mtk_sgmii_wrapped_pcs_config(pcs, wp->neg_mode, state->interface,
+					     NULL, wp->permit_pause_to_mac);
+}
+
+static void mtk_sgmii_wrapped_pcs_an_restart(struct phylink_pcs *pcs)
+{
+	struct mtk_sgmii_wrapper_pcs *wp = container_of(pcs, struct mtk_sgmii_wrapper_pcs, pcs);
+
+	wp->lynxi_pcs->ops->pcs_an_restart(wp->lynxi_pcs);
+}
+
+static void mtk_sgmii_wrapped_pcs_link_up(struct phylink_pcs *pcs,
+					  unsigned int neg_mode,
+					  phy_interface_t interface, int speed,
+					  int duplex)
+{
+	struct mtk_sgmii_wrapper_pcs *wp = container_of(pcs, struct mtk_sgmii_wrapper_pcs, pcs);
+
+	wp->lynxi_pcs->ops->pcs_link_up(wp->lynxi_pcs, neg_mode, interface, speed, duplex);
+}
+
+static void mtk_sgmii_wrapped_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct mtk_sgmii_wrapper_pcs *wp = container_of(pcs, struct mtk_sgmii_wrapper_pcs, pcs);
+
+	wp->lynxi_pcs->ops->pcs_disable(wp->lynxi_pcs);
+	wp->interface = PHY_INTERFACE_MODE_NA;
+	wp->neg_mode = -1;
+}
+
+static int mtk_sgmii_wrapped_pcs_enable(struct phylink_pcs *pcs)
+{
+	struct mtk_sgmii_wrapper_pcs *wp = container_of(pcs, struct mtk_sgmii_wrapper_pcs, pcs);
+
+	if (wp->lynxi_pcs->ops->pcs_enable)
+		wp->lynxi_pcs->ops->pcs_enable(wp->lynxi_pcs);
+
+	wp->interface = PHY_INTERFACE_MODE_NA;
+	wp->neg_mode = -1;
+
+	phy_power_on(wp->usxgmii_pcs->pextp);
+
+	return 0;
+}
+
+static const struct phylink_pcs_ops mtk_sgmii_wrapped_pcs_ops = {
+	.pcs_get_state = mtk_sgmii_wrapped_pcs_get_state,
+	.pcs_config = mtk_sgmii_wrapped_pcs_config,
+	.pcs_an_restart = mtk_sgmii_wrapped_pcs_an_restart,
+	.pcs_link_up = mtk_sgmii_wrapped_pcs_link_up,
+	.pcs_disable = mtk_sgmii_wrapped_pcs_disable,
+	.pcs_enable = mtk_sgmii_wrapped_pcs_enable,
+};
+
+static int mtk_sgmii_wrapper_init(struct mtk_usxgmii_pcs *mpcs)
+{
+	struct device_node *r = mpcs->dev->of_node, *np;
+	struct mtk_sgmii_wrapper_pcs *wp;
+	struct phylink_pcs *lynxi_pcs;
+	struct reset_control *rstc;
+	struct regmap *regmap;
+	struct clk *sgmii_sel, *sgmii_rx, *sgmii_tx;
+
+	np = of_parse_phandle(r, "mediatek,sgmiisys", 0);
+	if (!np)
+		return -ENODEV;
+
+	regmap = syscon_node_to_regmap(np);
+	of_node_put(np);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	rstc = of_reset_control_get_shared(r, "sgmii");
+
+	if (IS_ERR(rstc))
+		return PTR_ERR(rstc);
+
+	sgmii_sel = devm_clk_get_enabled(mpcs->dev, "sgmii_sel");
+	if (IS_ERR(sgmii_sel))
+		return PTR_ERR(sgmii_sel);
+
+	sgmii_rx = devm_clk_get_enabled(mpcs->dev, "sgmii_rx");
+	if (IS_ERR(sgmii_rx))
+		return PTR_ERR(sgmii_rx);
+
+	sgmii_tx = devm_clk_get_enabled(mpcs->dev, "sgmii_tx");
+	if (IS_ERR(sgmii_tx))
+		return PTR_ERR(sgmii_tx);
+
+	lynxi_pcs = mtk_pcs_lynxi_create(mpcs->dev, regmap, MTK_NETSYS_V3_AMA_RGC3, 0);
+
+	if (IS_ERR(lynxi_pcs))
+		return PTR_ERR(lynxi_pcs);
+
+	if (!lynxi_pcs)
+		return -ENODEV;
+
+	/* Make sure all PCS ops are supported by wrapped PCS */
+	if (!lynxi_pcs->ops->pcs_get_state ||
+	    !lynxi_pcs->ops->pcs_config ||
+	    !lynxi_pcs->ops->pcs_an_restart ||
+	    !lynxi_pcs->ops->pcs_link_up ||
+	    !lynxi_pcs->ops->pcs_disable)
+		return -EOPNOTSUPP;
+
+	wp = devm_kzalloc(mpcs->dev, sizeof(*wp), GFP_KERNEL);
+	if (!wp)
+		return -ENOMEM;
+
+	wp->pcs.neg_mode = lynxi_pcs->neg_mode;
+	wp->pcs.ops = &mtk_sgmii_wrapped_pcs_ops;
+	wp->pcs.poll = true;
+	wp->lynxi_pcs = lynxi_pcs;
+	wp->usxgmii_pcs = mpcs;
+	wp->clks[0] = sgmii_sel;
+	wp->clks[1] = sgmii_rx;
+	wp->clks[2] = sgmii_tx;
+	wp->reset = rstc;
+	wp->interface = PHY_INTERFACE_MODE_NA;
+	wp->neg_mode = -1;
+
+	if (IS_ERR(wp->reset))
+		return PTR_ERR(wp->reset);
+
+	reset_control_deassert(wp->reset);
+
+	mpcs->sgmii_pcs = &wp->pcs;
+
+	return 0;
+}
+
+static void mtk_sgmii_wrapper_destroy(struct mtk_usxgmii_pcs *mpcs)
+{
+	struct mtk_sgmii_wrapper_pcs *wp = container_of(mpcs->sgmii_pcs,
+							struct mtk_sgmii_wrapper_pcs,
+							pcs);
+
+	mtk_pcs_lynxi_destroy(wp->lynxi_pcs);
+	reset_control_put(wp->reset);
+}
+
+static int mtk_usxgmii_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+				  phy_interface_t interface,
+				  const unsigned long *advertising,
+				  bool permit_pause_to_mac)
+{
+	struct mtk_usxgmii_pcs *mpcs = pcs_to_mtk_usxgmii_pcs(pcs);
+	unsigned int an_ctrl = 0, link_timer = 0, xfi_mode = 0, adapt_mode = 0;
+	bool mode_changed = false;
+
+	if (interface == PHY_INTERFACE_MODE_USXGMII) {
+		an_ctrl = FIELD_PREP(USXGMII_AN_SYNC_CNT, 0x1FF) | USXGMII_AN_ENABLE;
+		link_timer = FIELD_PREP(USXGMII_LINK_TIMER_IDLE_DETECT, 0x7B) |
+			     FIELD_PREP(USXGMII_LINK_TIMER_COMP_ACK_DETECT, 0x7B) |
+			     FIELD_PREP(USXGMII_LINK_TIMER_AN_RESTART, 0x7B);
+		xfi_mode = FIELD_PREP(USXGMII_XFI_RX_MODE, USXGMII_XFI_MODE_10G) |
+			   FIELD_PREP(USXGMII_XFI_TX_MODE, USXGMII_XFI_MODE_10G);
+	} else if (interface == PHY_INTERFACE_MODE_10GBASER) {
+		an_ctrl = FIELD_PREP(USXGMII_AN_SYNC_CNT, 0x1FF);
+		link_timer = FIELD_PREP(USXGMII_LINK_TIMER_IDLE_DETECT, 0x7B) |
+			     FIELD_PREP(USXGMII_LINK_TIMER_COMP_ACK_DETECT, 0x7B) |
+			     FIELD_PREP(USXGMII_LINK_TIMER_AN_RESTART, 0x7B);
+		xfi_mode = FIELD_PREP(USXGMII_XFI_RX_MODE, USXGMII_XFI_MODE_10G) |
+			   FIELD_PREP(USXGMII_XFI_TX_MODE, USXGMII_XFI_MODE_10G);
+		adapt_mode = USXGMII_RATE_UPDATE_MODE;
+	} else if (interface == PHY_INTERFACE_MODE_5GBASER) {
+		an_ctrl = FIELD_PREP(USXGMII_AN_SYNC_CNT, 0xFF);
+		link_timer = FIELD_PREP(USXGMII_LINK_TIMER_IDLE_DETECT, 0x3D) |
+			     FIELD_PREP(USXGMII_LINK_TIMER_COMP_ACK_DETECT, 0x3D) |
+			     FIELD_PREP(USXGMII_LINK_TIMER_AN_RESTART, 0x3D);
+		xfi_mode = FIELD_PREP(USXGMII_XFI_RX_MODE, USXGMII_XFI_MODE_5G) |
+			   FIELD_PREP(USXGMII_XFI_TX_MODE, USXGMII_XFI_MODE_5G);
+		adapt_mode = USXGMII_RATE_UPDATE_MODE;
+	} else {
+		return -EINVAL;
+	}
+
+	adapt_mode |= FIELD_PREP(USXGMII_RATE_ADAPT_MODE, USXGMII_RATE_ADAPT_MODE_X1);
+
+	if (mpcs->interface != interface) {
+		mpcs->interface = interface;
+		mode_changed = true;
+	}
+
+	phy_power_on(mpcs->pextp);
+	mtk_usxgmii_reset(mpcs);
+
+	/* Setup USXGMII AN ctrl */
+	mtk_m32(mpcs, RG_PCS_AN_CTRL0,
+		USXGMII_AN_SYNC_CNT | USXGMII_AN_ENABLE,
+		an_ctrl);
+
+	mtk_m32(mpcs, RG_PCS_AN_CTRL2,
+		USXGMII_LINK_TIMER_IDLE_DETECT |
+		USXGMII_LINK_TIMER_COMP_ACK_DETECT |
+		USXGMII_LINK_TIMER_AN_RESTART,
+		link_timer);
+
+	mpcs->neg_mode = neg_mode;
+
+	/* Gated MAC CK */
+	mtk_m32(mpcs, RG_PHY_TOP_SPEED_CTRL1,
+		USXGMII_MAC_CK_GATED, USXGMII_MAC_CK_GATED);
+
+	/* Enable interface force mode */
+	mtk_m32(mpcs, RG_PHY_TOP_SPEED_CTRL1,
+		USXGMII_IF_FORCE_EN, USXGMII_IF_FORCE_EN);
+
+	/* Setup USXGMII adapt mode */
+	mtk_m32(mpcs, RG_PHY_TOP_SPEED_CTRL1,
+		USXGMII_RATE_UPDATE_MODE | USXGMII_RATE_ADAPT_MODE,
+		adapt_mode);
+
+	/* Setup USXGMII speed */
+	mtk_m32(mpcs, RG_PHY_TOP_SPEED_CTRL1,
+		USXGMII_XFI_RX_MODE | USXGMII_XFI_TX_MODE,
+		xfi_mode);
+
+	usleep_range(1, 10);
+
+	/* Un-gated MAC CK */
+	mtk_m32(mpcs, RG_PHY_TOP_SPEED_CTRL1, USXGMII_MAC_CK_GATED, 0);
+
+	usleep_range(1, 10);
+
+	/* Disable interface force mode for the AN mode */
+	if (an_ctrl & USXGMII_AN_ENABLE)
+		mtk_m32(mpcs, RG_PHY_TOP_SPEED_CTRL1, USXGMII_IF_FORCE_EN, 0);
+
+	/* Setup PHY for interface mode */
+	phy_set_mode_ext(mpcs->pextp, PHY_MODE_ETHERNET, interface);
+
+	return mode_changed;
+}
+
+static void mtk_usxgmii_pcs_get_fixed_speed(struct mtk_usxgmii_pcs *mpcs,
+					    struct phylink_link_state *state)
+{
+	u32 val = mtk_r32(mpcs, RG_PHY_TOP_SPEED_CTRL1);
+	int speed;
+
+	/* Calculate speed from interface speed and rate adapt mode */
+	switch (FIELD_GET(USXGMII_XFI_RX_MODE, val)) {
+	case USXGMII_XFI_MODE_10G:
+		speed = 10000;
+		break;
+	case USXGMII_XFI_MODE_5G:
+		speed = 5000;
+		break;
+	case USXGMII_XFI_MODE_2P5G:
+		speed = 2500;
+		break;
+	default:
+		state->speed = SPEED_UNKNOWN;
+		return;
+	}
+
+	switch (FIELD_GET(USXGMII_RATE_ADAPT_MODE, val)) {
+	case USXGMII_RATE_ADAPT_MODE_X100:
+		speed /= 100;
+		break;
+	case USXGMII_RATE_ADAPT_MODE_X50:
+		speed /= 50;
+		break;
+	case USXGMII_RATE_ADAPT_MODE_X10:
+		speed /= 10;
+		break;
+	case USXGMII_RATE_ADAPT_MODE_X5:
+		speed /= 5;
+		break;
+	case USXGMII_RATE_ADAPT_MODE_X4:
+		speed /= 4;
+		break;
+	case USXGMII_RATE_ADAPT_MODE_X2:
+		speed /= 2;
+		break;
+	case USXGMII_RATE_ADAPT_MODE_X1:
+		break;
+	default:
+		state->speed = SPEED_UNKNOWN;
+		return;
+	}
+
+	state->speed = speed;
+	state->duplex = DUPLEX_FULL;
+}
+
+static void mtk_usxgmii_pcs_get_an_state(struct mtk_usxgmii_pcs *mpcs,
+					 struct phylink_link_state *state)
+{
+	u16 lpa;
+
+	/* Refresh LPA by toggling LPA_LATCH */
+	mtk_m32(mpcs, RG_PCS_AN_STS0, USXGMII_LPA_LATCH, USXGMII_LPA_LATCH);
+	ndelay(1020);
+	mtk_m32(mpcs, RG_PCS_AN_STS0, USXGMII_LPA_LATCH, 0);
+	ndelay(1020);
+	lpa = FIELD_GET(USXGMII_LPA, mtk_r32(mpcs, RG_PCS_AN_STS0));
+
+	phylink_decode_usxgmii_word(state, lpa);
+}
+
+static void mtk_usxgmii_pcs_get_state(struct phylink_pcs *pcs,
+				      struct phylink_link_state *state)
+{
+	struct mtk_usxgmii_pcs *mpcs = pcs_to_mtk_usxgmii_pcs(pcs);
+
+	/* Refresh USXGMII link status by toggling RG_PCS_AN_STATUS_UPDATE */
+	mtk_m32(mpcs, RG_PCS_RX_STATUS0, RG_PCS_RX_STATUS_UPDATE,
+		RG_PCS_RX_STATUS_UPDATE);
+	ndelay(1020);
+	mtk_m32(mpcs, RG_PCS_RX_STATUS0, RG_PCS_RX_STATUS_UPDATE, 0);
+	ndelay(1020);
+
+	/* Read USXGMII link status */
+	state->link = FIELD_GET(RG_PCS_RX_LINK_STATUS,
+				mtk_r32(mpcs, RG_PCS_RX_STATUS0));
+
+	/* Continuously repeat re-configuration sequence until link comes up */
+	if (!state->link) {
+		mtk_usxgmii_pcs_config(pcs, mpcs->neg_mode,
+				       state->interface, NULL, false);
+		return;
+	}
+
+	if (FIELD_GET(USXGMII_AN_ENABLE, mtk_r32(mpcs, RG_PCS_AN_CTRL0)))
+		mtk_usxgmii_pcs_get_an_state(mpcs, state);
+	else
+		mtk_usxgmii_pcs_get_fixed_speed(mpcs, state);
+}
+
+static void mtk_usxgmii_pcs_restart_an(struct phylink_pcs *pcs)
+{
+	struct mtk_usxgmii_pcs *mpcs = pcs_to_mtk_usxgmii_pcs(pcs);
+
+	mtk_m32(mpcs, RG_PCS_AN_CTRL0, USXGMII_AN_RESTART, USXGMII_AN_RESTART);
+}
+
+static void mtk_usxgmii_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
+				    phy_interface_t interface,
+				    int speed, int duplex)
+{
+	/* Reconfiguring USXGMII to ensure the quality of the RX signal
+	 * after the line side link up.
+	 */
+	mtk_usxgmii_pcs_config(pcs, neg_mode, interface, NULL, false);
+}
+
+static void mtk_usxgmii_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct mtk_usxgmii_pcs *mpcs = pcs_to_mtk_usxgmii_pcs(pcs);
+
+	mpcs->interface = PHY_INTERFACE_MODE_NA;
+	mpcs->neg_mode = -1;
+}
+
+static const struct phylink_pcs_ops mtk_usxgmii_pcs_ops = {
+	.pcs_config = mtk_usxgmii_pcs_config,
+	.pcs_get_state = mtk_usxgmii_pcs_get_state,
+	.pcs_an_restart = mtk_usxgmii_pcs_restart_an,
+	.pcs_link_up = mtk_usxgmii_pcs_link_up,
+	.pcs_disable = mtk_usxgmii_pcs_disable,
+};
+
+static int mtk_usxgmii_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_usxgmii_pcs *mpcs;
+	int ret;
+
+	mpcs = devm_kzalloc(dev, sizeof(*mpcs), GFP_KERNEL);
+	if (!mpcs)
+		return -ENOMEM;
+
+	mpcs->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mpcs->base))
+		return PTR_ERR(mpcs->base);
+
+	mpcs->dev = dev;
+	mpcs->pcs.ops = &mtk_usxgmii_pcs_ops;
+	mpcs->pcs.poll = true;
+	mpcs->pcs.neg_mode = true;
+	mpcs->interface = PHY_INTERFACE_MODE_NA;
+	mpcs->neg_mode = -1;
+
+	mpcs->clk = devm_clk_get_enabled(mpcs->dev, "usxgmii");
+	if (IS_ERR(mpcs->clk))
+		return PTR_ERR(mpcs->clk);
+
+	mpcs->xfi_pll = devm_clk_get_enabled(mpcs->dev, "xfi_pll");
+	if (IS_ERR(mpcs->xfi_pll))
+		return PTR_ERR(mpcs->xfi_pll);
+
+	mpcs->reset = devm_reset_control_get_shared(dev, "xfi");
+	if (IS_ERR(mpcs->reset))
+		return PTR_ERR(mpcs->reset);
+
+	reset_control_deassert(mpcs->reset);
+
+	ret = mtk_xfi_pextp_init(mpcs);
+	if (ret)
+		return ret;
+
+	ret = mtk_sgmii_wrapper_init(mpcs);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, mpcs);
+
+	return 0;
+}
+
+static int mtk_usxgmii_remove(struct platform_device *pdev)
+{
+	struct mtk_usxgmii_pcs *mpcs = platform_get_drvdata(pdev);
+
+	mtk_sgmii_wrapper_destroy(mpcs);
+	phy_power_off(mpcs->pextp);
+
+	return 0;
+}
+
+static const struct of_device_id mtk_usxgmii_of_mtable[] = {
+	{ .compatible = "mediatek,mt7988-usxgmiisys" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mtk_usxgmii_of_mtable);
+
+struct phylink_pcs *mtk_usxgmii_select_pcs(struct device_node *np, phy_interface_t mode)
+{
+	struct platform_device *pdev;
+	struct mtk_usxgmii_pcs *mpcs;
+
+	if (!np)
+		return NULL;
+
+	if (!of_device_is_available(np))
+		return ERR_PTR(-ENODEV);
+
+	if (!of_match_node(mtk_usxgmii_of_mtable, np))
+		return ERR_PTR(-EINVAL);
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev || !platform_get_drvdata(pdev)) {
+		if (pdev)
+			put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	mpcs = platform_get_drvdata(pdev);
+	put_device(&pdev->dev);
+
+	switch (mode) {
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_SGMII:
+		return mpcs->sgmii_pcs;
+	case PHY_INTERFACE_MODE_5GBASER:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_USXGMII:
+		return &mpcs->pcs;
+	default:
+		return NULL;
+	}
+}
+EXPORT_SYMBOL(mtk_usxgmii_select_pcs);
+
+static struct platform_driver mtk_usxgmii_driver = {
+	.driver = {
+		.name			= "mtk_usxgmii",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= mtk_usxgmii_of_mtable,
+	},
+	.probe = mtk_usxgmii_probe,
+	.remove = mtk_usxgmii_remove,
+};
+module_platform_driver(mtk_usxgmii_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MediaTek USXGMII PCS driver");
+MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
diff --git a/include/linux/pcs/pcs-mtk-usxgmii.h b/include/linux/pcs/pcs-mtk-usxgmii.h
new file mode 100644
index 0000000000000..7a3c49760ffa6
--- /dev/null
+++ b/include/linux/pcs/pcs-mtk-usxgmii.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_PCS_MTK_USXGMII_H
+#define __LINUX_PCS_MTK_USXGMII_H
+
+#include <linux/phylink.h>
+
+/**
+ * mtk_usxgmii_select_pcs
+ * Return PCS indentified by a device node and the PHY interface mode in use
+ *
+ * @param np	Pointer to device node indentifying a MediaTek USXGMII PCS
+ * @param mode	Ethernet PHY interface mode
+ *
+ * @return	Pointer to phylink PCS instance of NULL
+ */
+struct phylink_pcs *mtk_usxgmii_select_pcs(struct device_node *np, phy_interface_t mode);
+
+#endif /* __LINUX_PCS_MTK_USXGMII_H */
-- 
2.42.1
