Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160897E7405
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjKIVws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjKIVwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:52:38 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED5C4211;
        Thu,  9 Nov 2023 13:52:36 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r1Cwq-0003aK-2T;
        Thu, 09 Nov 2023 21:52:24 +0000
Date:   Thu, 9 Nov 2023 21:52:21 +0000
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
Subject: [RFC PATCH 8/8] net: ethernet: mtk_eth_soc: add paths and SerDes
 modes for MT7988
Message-ID: <cad139116f916ae4f63d3df9900835af3f6b5cd2.1699565880.git.daniel@makrotopia.org>
References: <cover.1699565880.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699565880.git.daniel@makrotopia.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT7988 comes with a built-in 2.5G PHY as well as SerDes lanes to
connect external PHYs or transceivers in USXGMII, 10GBase-R, 5GBase-R,
2500Base-X, 1000Base-X and Cisco SGMII interface modes.

Implement support for configuring for the new paths to SerDes interfaces
and the internal 2.5G PHY.

Add USXGMII PCS driver for 10GBase-R, 5GBase-R and USXGMII mode, and
setup the new PHYA on MT7988 to access the also still existing old
LynxI PCS for 1000Base-X, 2500Base-X and Cisco SGMII PCS interface
modes.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/Kconfig        |  17 ++
 drivers/net/ethernet/mediatek/mtk_eth_path.c | 122 ++++++++++++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c  | 178 ++++++++++++++++---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h  | 105 +++++++++--
 4 files changed, 379 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/Kconfig b/drivers/net/ethernet/mediatek/Kconfig
index da0db417ab690..b63723b8d1d2c 100644
--- a/drivers/net/ethernet/mediatek/Kconfig
+++ b/drivers/net/ethernet/mediatek/Kconfig
@@ -21,10 +21,27 @@ config NET_MEDIATEK_SOC
 	select PAGE_POOL_STATS
 	select PCS_MTK_LYNXI
 	select REGMAP_MMIO
+	select PCS_MTK_USXGMII if NET_MEDIATEK_SOC_USXGMII
 	help
 	  This driver supports the gigabit ethernet MACs in the
 	  MediaTek SoC family.
 
+config NET_MEDIATEK_SOC_USXGMII
+	bool "Support USXGMII SerDes on MT7988"
+	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
+	def_bool NET_MEDIATEK_SOC != n
+	help
+	  Include support for 10GE SerDes which can be found on MT7988.
+	  If this kernel should run on SoCs with 10 GBit/s Ethernet you
+	  will need to select this option to use GMAC2 and GMAC3 with
+	  external PHYs, SFP(+) cages in 10GBase-R, 5GBase-R or USXGMII
+	  interface modes.
+
+	  Note that as the 2500Base-X/1000Base-X/Cisco SGMII SerDes PCS
+	  unit (MediaTek LynxI) in MT7988 is connected via the new 10GE
+	  SerDes, you will also need to select this option in case you
+	  want to use any of those SerDes modes.
+
 config NET_MEDIATEK_STAR_EMAC
 	tristate "MediaTek STAR Ethernet MAC support"
 	select PHYLIB
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_path.c b/drivers/net/ethernet/mediatek/mtk_eth_path.c
index 7c27a19c4d8f4..3f4f4cfe6a233 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_path.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_path.c
@@ -31,10 +31,20 @@ static const char *mtk_eth_path_name(u64 path)
 		return "gmac2_rgmii";
 	case MTK_ETH_PATH_GMAC2_SGMII:
 		return "gmac2_sgmii";
+	case MTK_ETH_PATH_GMAC2_2P5GPHY:
+		return "gmac2_2p5gphy";
 	case MTK_ETH_PATH_GMAC2_GEPHY:
 		return "gmac2_gephy";
+	case MTK_ETH_PATH_GMAC3_SGMII:
+		return "gmac3_sgmii";
 	case MTK_ETH_PATH_GDM1_ESW:
 		return "gdm1_esw";
+	case MTK_ETH_PATH_GMAC1_USXGMII:
+		return "gmac1_usxgmii";
+	case MTK_ETH_PATH_GMAC2_USXGMII:
+		return "gmac2_usxgmii";
+	case MTK_ETH_PATH_GMAC3_USXGMII:
+		return "gmac3_usxgmii";
 	default:
 		return "unknown path";
 	}
@@ -127,6 +137,27 @@ static int set_mux_u3_gmac2_to_qphy(struct mtk_eth *eth, u64 path)
 	return 0;
 }
 
+static int set_mux_gmac2_to_2p5gphy(struct mtk_eth *eth, u64 path)
+{
+	int ret;
+
+	if (path == MTK_ETH_PATH_GMAC2_2P5GPHY) {
+		ret = regmap_clear_bits(eth->ethsys, ETHSYS_SYSCFG0, SYSCFG0_SGMII_GMAC2_V2);
+		if (ret)
+			return ret;
+
+		/* Setup mux to 2p5g PHY */
+		ret = regmap_clear_bits(eth->infra, TOP_MISC_NETSYS_PCS_MUX, MUX_G2_USXGMII_SEL);
+		if (ret)
+			return ret;
+
+		dev_dbg(eth->dev, "path %s in %s updated\n",
+			mtk_eth_path_name(path), __func__);
+	}
+
+	return 0;
+}
+
 static int set_mux_gmac1_gmac2_to_sgmii_rgmii(struct mtk_eth *eth, u64 path)
 {
 	unsigned int val = 0;
@@ -165,7 +196,48 @@ static int set_mux_gmac1_gmac2_to_sgmii_rgmii(struct mtk_eth *eth, u64 path)
 	return 0;
 }
 
-static int set_mux_gmac12_to_gephy_sgmii(struct mtk_eth *eth, u64 path)
+static int set_mux_gmac123_to_usxgmii(struct mtk_eth *eth, u64 path)
+{
+	unsigned int val = 0;
+	bool updated = true;
+	int mac_id = 0;
+
+	/* Disable SYSCFG1 SGMII */
+	regmap_read(eth->ethsys, ETHSYS_SYSCFG0, &val);
+
+	switch (path) {
+	case MTK_ETH_PATH_GMAC1_USXGMII:
+		val &= ~(u32)SYSCFG0_SGMII_GMAC1_V2;
+		mac_id = MTK_GMAC1_ID;
+		break;
+	case MTK_ETH_PATH_GMAC2_USXGMII:
+		val &= ~(u32)SYSCFG0_SGMII_GMAC2_V2;
+		mac_id = MTK_GMAC2_ID;
+		break;
+	case MTK_ETH_PATH_GMAC3_USXGMII:
+		val &= ~(u32)SYSCFG0_SGMII_GMAC3_V2;
+		mac_id = MTK_GMAC3_ID;
+		break;
+	default:
+		updated = false;
+	};
+
+	if (updated) {
+		regmap_update_bits(eth->ethsys, ETHSYS_SYSCFG0,
+				   SYSCFG0_SGMII_MASK, val);
+
+		if (mac_id == MTK_GMAC2_ID)
+			regmap_set_bits(eth->infra, TOP_MISC_NETSYS_PCS_MUX,
+					MUX_G2_USXGMII_SEL);
+	}
+
+	dev_dbg(eth->dev, "path %s in %s updated = %d\n",
+		mtk_eth_path_name(path), __func__, updated);
+
+	return 0;
+}
+
+static int set_mux_gmac123_to_gephy_sgmii(struct mtk_eth *eth, u64 path)
 {
 	unsigned int val = 0;
 	bool updated = true;
@@ -182,6 +254,9 @@ static int set_mux_gmac12_to_gephy_sgmii(struct mtk_eth *eth, u64 path)
 	case MTK_ETH_PATH_GMAC2_SGMII:
 		val |= SYSCFG0_SGMII_GMAC2_V2;
 		break;
+	case MTK_ETH_PATH_GMAC3_SGMII:
+		val |= SYSCFG0_SGMII_GMAC3_V2;
+		break;
 	default:
 		updated = false;
 	}
@@ -209,6 +284,10 @@ static const struct mtk_eth_muxc mtk_eth_muxc[] = {
 		.name = "mux_u3_gmac2_to_qphy",
 		.cap_bit = MTK_ETH_MUX_U3_GMAC2_TO_QPHY,
 		.set_path = set_mux_u3_gmac2_to_qphy,
+	}, {
+		.name = "mux_gmac2_to_2p5gphy",
+		.cap_bit = MTK_ETH_MUX_GMAC2_TO_2P5GPHY,
+		.set_path = set_mux_gmac2_to_2p5gphy,
 	}, {
 		.name = "mux_gmac1_gmac2_to_sgmii_rgmii",
 		.cap_bit = MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII,
@@ -216,7 +295,15 @@ static const struct mtk_eth_muxc mtk_eth_muxc[] = {
 	}, {
 		.name = "mux_gmac12_to_gephy_sgmii",
 		.cap_bit = MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII,
-		.set_path = set_mux_gmac12_to_gephy_sgmii,
+		.set_path = set_mux_gmac123_to_gephy_sgmii,
+	}, {
+		.name = "mux_gmac123_to_gephy_sgmii",
+		.cap_bit = MTK_ETH_MUX_GMAC123_TO_GEPHY_SGMII,
+		.set_path = set_mux_gmac123_to_gephy_sgmii,
+	}, {
+		.name = "mux_gmac123_to_usxgmii",
+		.cap_bit = MTK_ETH_MUX_GMAC123_TO_USXGMII,
+		.set_path = set_mux_gmac123_to_usxgmii,
 	},
 };
 
@@ -249,12 +336,39 @@ static int mtk_eth_mux_setup(struct mtk_eth *eth, u64 path)
 	return err;
 }
 
+int mtk_gmac_usxgmii_path_setup(struct mtk_eth *eth, int mac_id)
+{
+	u64 path;
+
+	path = (mac_id == MTK_GMAC1_ID) ?  MTK_ETH_PATH_GMAC1_USXGMII :
+	       (mac_id == MTK_GMAC2_ID) ?  MTK_ETH_PATH_GMAC2_USXGMII :
+					   MTK_ETH_PATH_GMAC3_USXGMII;
+
+	/* Setup proper MUXes along the path */
+	return mtk_eth_mux_setup(eth, path);
+}
+
 int mtk_gmac_sgmii_path_setup(struct mtk_eth *eth, int mac_id)
 {
 	u64 path;
 
-	path = (mac_id == 0) ?  MTK_ETH_PATH_GMAC1_SGMII :
-				MTK_ETH_PATH_GMAC2_SGMII;
+	path = (mac_id == MTK_GMAC1_ID) ? MTK_ETH_PATH_GMAC1_SGMII :
+	       (mac_id == MTK_GMAC2_ID) ? MTK_ETH_PATH_GMAC2_SGMII :
+					  MTK_ETH_PATH_GMAC3_SGMII;
+
+	/* Setup proper MUXes along the path */
+	return mtk_eth_mux_setup(eth, path);
+}
+
+int mtk_gmac_2p5gphy_path_setup(struct mtk_eth *eth, int mac_id)
+{
+	u64 path = 0;
+
+	if (mac_id == MTK_GMAC2_ID)
+		path = MTK_ETH_PATH_GMAC2_2P5GPHY;
+
+	if (!path)
+		return -EINVAL;
 
 	/* Setup proper MUXes along the path */
 	return mtk_eth_mux_setup(eth, path);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 3cf6589cfdacf..a550cf7ab0d91 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -22,6 +22,7 @@
 #include <linux/pinctrl/devinfo.h>
 #include <linux/phylink.h>
 #include <linux/pcs/pcs-mtk-lynxi.h>
+#include <linux/pcs/pcs-mtk-usxgmii.h>
 #include <linux/jhash.h>
 #include <linux/bitfield.h>
 #include <net/dsa.h>
@@ -260,12 +261,8 @@ static const char * const mtk_clks_source_name[] = {
 	"ethwarp_wocpu2",
 	"ethwarp_wocpu1",
 	"ethwarp_wocpu0",
-	"top_usxgmii0_sel",
-	"top_usxgmii1_sel",
 	"top_sgm0_sel",
 	"top_sgm1_sel",
-	"top_xfi_phy0_xtal_sel",
-	"top_xfi_phy1_xtal_sel",
 	"top_eth_gmii_sel",
 	"top_eth_refck_50m_sel",
 	"top_eth_sys_200m_sel",
@@ -508,6 +505,30 @@ static void mtk_setup_bridge_switch(struct mtk_eth *eth)
 		MTK_GSW_CFG);
 }
 
+static bool mtk_check_gmac23_idle(struct mtk_mac *mac)
+{
+	u32 mac_fsm, gdm_fsm;
+
+	mac_fsm = mtk_r32(mac->hw, MTK_MAC_FSM(mac->id));
+
+	switch (mac->id) {
+	case MTK_GMAC2_ID:
+		gdm_fsm = mtk_r32(mac->hw, MTK_FE_GDM2_FSM);
+		break;
+	case MTK_GMAC3_ID:
+		gdm_fsm = mtk_r32(mac->hw, MTK_FE_GDM3_FSM);
+		break;
+	default:
+		return true;
+	};
+
+	if ((mac_fsm & 0xFFFF0000) == 0x01010000 &&
+	    (gdm_fsm & 0xFFFF0000) == 0x00000000)
+		return true;
+
+	return false;
+}
+
 static struct phylink_pcs *mtk_mac_select_pcs(struct phylink_config *config,
 					      phy_interface_t interface)
 {
@@ -516,6 +537,14 @@ static struct phylink_pcs *mtk_mac_select_pcs(struct phylink_config *config,
 	struct mtk_eth *eth = mac->hw;
 	unsigned int sid;
 
+	if (mtk_is_netsys_v3_or_greater(eth)) {
+#if IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_USXGMII)
+		return mtk_usxgmii_select_pcs(mac->pcs_of_node, interface);
+#else
+		return NULL;
+#endif
+	}
+
 	if (interface == PHY_INTERFACE_MODE_SGMII ||
 	    phy_interface_mode_is_8023z(interface)) {
 		sid = (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_SGMII)) ?
@@ -567,7 +596,22 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 					goto init_err;
 			}
 			break;
+		case PHY_INTERFACE_MODE_USXGMII:
+		case PHY_INTERFACE_MODE_10GBASER:
+		case PHY_INTERFACE_MODE_5GBASER:
+			if (MTK_HAS_CAPS(eth->soc->caps, MTK_USXGMII)) {
+				err = mtk_gmac_usxgmii_path_setup(eth, mac->id);
+				if (err)
+					goto init_err;
+			}
+			break;
 		case PHY_INTERFACE_MODE_INTERNAL:
+			if (mac->id == MTK_GMAC2_ID &&
+			    MTK_HAS_CAPS(eth->soc->caps, MTK_2P5GPHY)) {
+				err = mtk_gmac_2p5gphy_path_setup(eth, mac->id);
+				if (err)
+					goto init_err;
+			}
 			break;
 		default:
 			goto err_phy;
@@ -614,8 +658,6 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 		val &= ~SYSCFG0_GE_MODE(SYSCFG0_GE_MASK, mac->id);
 		val |= SYSCFG0_GE_MODE(ge_mode, mac->id);
 		regmap_write(eth->ethsys, ETHSYS_SYSCFG0, val);
-
-		mac->interface = state->interface;
 	}
 
 	/* SGMII */
@@ -632,21 +674,40 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 
 		/* Save the syscfg0 value for mac_finish */
 		mac->syscfg0 = val;
-	} else if (phylink_autoneg_inband(mode)) {
+	} else if (state->interface != PHY_INTERFACE_MODE_USXGMII &&
+		   state->interface != PHY_INTERFACE_MODE_10GBASER &&
+		   state->interface != PHY_INTERFACE_MODE_5GBASER &&
+		   phylink_autoneg_inband(mode)) {
 		dev_err(eth->dev,
-			"In-band mode not supported in non SGMII mode!\n");
+			"In-band mode not supported in non-SerDes modes!\n");
 		return;
 	}
 
 	/* Setup gmac */
-	if (mtk_is_netsys_v3_or_greater(eth) &&
-	    mac->interface == PHY_INTERFACE_MODE_INTERNAL) {
-		mtk_w32(mac->hw, MTK_GDMA_XGDM_SEL, MTK_GDMA_EG_CTRL(mac->id));
-		mtk_w32(mac->hw, MAC_MCR_FORCE_LINK_DOWN, MTK_MAC_MCR(mac->id));
+	if (mtk_is_netsys_v3_or_greater(eth)) {
+		if (mtk_interface_mode_is_xgmii(state->interface)) {
+			mtk_w32(mac->hw, MTK_GDMA_XGDM_SEL, MTK_GDMA_EG_CTRL(mac->id));
+			mtk_w32(mac->hw, MAC_MCR_FORCE_LINK_DOWN, MTK_MAC_MCR(mac->id));
 
-		mtk_setup_bridge_switch(eth);
+			if (mac->id == MTK_GMAC1_ID)
+				mtk_setup_bridge_switch(eth);
+		} else {
+			mtk_w32(eth, 0, MTK_GDMA_EG_CTRL(mac->id));
+
+			/* FIXME: In current hardware design, we have to reset FE
+			 * when swtiching XGDM to GDM. Therefore, here trigger an SER
+			 * to let GDM go back to the initial state.
+			 */
+			if ((mtk_interface_mode_is_xgmii(mac->interface) ||
+			     mac->interface == PHY_INTERFACE_MODE_NA) &&
+			    !mtk_check_gmac23_idle(mac) &&
+			    !test_bit(MTK_RESETTING, &eth->state))
+				schedule_work(&eth->pending_work);
+		}
 	}
 
+	mac->interface = state->interface;
+
 	return;
 
 err_phy:
@@ -692,10 +753,13 @@ static void mtk_mac_link_down(struct phylink_config *config, unsigned int mode,
 {
 	struct mtk_mac *mac = container_of(config, struct mtk_mac,
 					   phylink_config);
-	u32 mcr = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
 
-	mcr &= ~(MAC_MCR_TX_EN | MAC_MCR_RX_EN);
-	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
+	if (!mtk_interface_mode_is_xgmii(interface)) {
+		mtk_m32(mac->hw, MAC_MCR_TX_EN | MAC_MCR_RX_EN, 0, MTK_MAC_MCR(mac->id));
+		mtk_m32(mac->hw, MTK_XGMAC_FORCE_LINK(mac->id), 0, MTK_XGMAC_STS(mac->id));
+	} else if (mac->id != MTK_GMAC1_ID) {
+		mtk_m32(mac->hw, XMAC_MCR_TRX_DISABLE, XMAC_MCR_TRX_DISABLE, MTK_XMAC_MCR(mac->id));
+	}
 }
 
 static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
@@ -767,13 +831,11 @@ static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
 	mtk_w32(eth, val, soc->reg_map->qdma.qtx_sch + ofs);
 }
 
-static void mtk_mac_link_up(struct phylink_config *config,
-			    struct phy_device *phy,
-			    unsigned int mode, phy_interface_t interface,
-			    int speed, int duplex, bool tx_pause, bool rx_pause)
+static void mtk_gdm_mac_link_up(struct mtk_mac *mac,
+				struct phy_device *phy,
+				unsigned int mode, phy_interface_t interface,
+				int speed, int duplex, bool tx_pause, bool rx_pause)
 {
-	struct mtk_mac *mac = container_of(config, struct mtk_mac,
-					   phylink_config);
 	u32 mcr;
 
 	mcr = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
@@ -807,6 +869,55 @@ static void mtk_mac_link_up(struct phylink_config *config,
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 }
 
+static void mtk_xgdm_mac_link_up(struct mtk_mac *mac,
+				 struct phy_device *phy,
+				 unsigned int mode, phy_interface_t interface,
+				 int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	u32 mcr, force_link = 0;
+
+	if (mac->id == MTK_GMAC1_ID)
+		return;
+
+	/* Eliminate the interference(before link-up) caused by PHY noise */
+	mtk_m32(mac->hw, XMAC_LOGIC_RST, 0, MTK_XMAC_LOGIC_RST(mac->id));
+	mdelay(20);
+	mtk_m32(mac->hw, XMAC_GLB_CNTCLR, XMAC_GLB_CNTCLR, MTK_XMAC_CNT_CTRL(mac->id));
+
+	if (mac->interface == PHY_INTERFACE_MODE_INTERNAL || mac->id == MTK_GMAC3_ID)
+		force_link = MTK_XGMAC_FORCE_LINK(mac->id);
+
+	mtk_m32(mac->hw, MTK_XGMAC_FORCE_LINK(mac->id), force_link, MTK_XGMAC_STS(mac->id));
+
+	mcr = mtk_r32(mac->hw, MTK_XMAC_MCR(mac->id));
+	mcr &= ~(XMAC_MCR_FORCE_TX_FC | XMAC_MCR_FORCE_RX_FC | XMAC_MCR_TRX_DISABLE);
+	/* Configure pause modes -
+	 * phylink will avoid these for half duplex
+	 */
+	if (tx_pause)
+		mcr |= XMAC_MCR_FORCE_TX_FC;
+	if (rx_pause)
+		mcr |= XMAC_MCR_FORCE_RX_FC;
+
+	mtk_w32(mac->hw, mcr, MTK_XMAC_MCR(mac->id));
+}
+
+static void mtk_mac_link_up(struct phylink_config *config,
+			    struct phy_device *phy,
+			    unsigned int mode, phy_interface_t interface,
+			    int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	struct mtk_mac *mac = container_of(config, struct mtk_mac,
+					   phylink_config);
+
+	if (mtk_interface_mode_is_xgmii(interface))
+		mtk_xgdm_mac_link_up(mac, phy, mode, interface, speed, duplex,
+				     tx_pause, rx_pause);
+	else
+		mtk_gdm_mac_link_up(mac, phy, mode, interface, speed, duplex,
+				    tx_pause, rx_pause);
+}
+
 static const struct phylink_mac_ops mtk_phylink_ops = {
 	.mac_select_pcs = mtk_mac_select_pcs,
 	.mac_config = mtk_mac_config,
@@ -4484,6 +4595,7 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	const __be32 *_id = of_get_property(np, "reg", NULL);
 	phy_interface_t phy_mode;
 	struct phylink *phylink;
+	struct phylink_pcs *pcs;
 	struct mtk_mac *mac;
 	int id, err;
 	int txqs = 1;
@@ -4518,6 +4630,12 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	mac->id = id;
 	mac->hw = eth;
 	mac->of_node = np;
+	mac->pcs_of_node = of_parse_phandle(mac->of_node, "pcs-handle", 0);
+	if (mac->pcs_of_node) {
+		pcs = mtk_usxgmii_select_pcs(mac->pcs_of_node, PHY_INTERFACE_MODE_NA);
+		if (IS_ERR(pcs))
+			return PTR_ERR(pcs);
+	}
 
 	err = of_get_ethdev_address(mac->of_node, eth->netdev[id]);
 	if (err == -EPROBE_DEFER)
@@ -4610,8 +4728,21 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 		phy_interface_zero(mac->phylink_config.supported_interfaces);
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  mac->phylink_config.supported_interfaces);
+	} else if (MTK_HAS_CAPS(mac->hw->soc->caps, MTK_USXGMII)) {
+		mac->phylink_config.mac_capabilities |= MAC_5000FD | MAC_10000FD;
+		__set_bit(PHY_INTERFACE_MODE_5GBASER,
+			  mac->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_10GBASER,
+			  mac->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_USXGMII,
+			  mac->phylink_config.supported_interfaces);
 	}
 
+	if (MTK_HAS_CAPS(mac->hw->soc->caps, MTK_2P5GPHY) &&
+	    id == MTK_GMAC2_ID)
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  mac->phylink_config.supported_interfaces);
+
 	phylink = phylink_create(&mac->phylink_config,
 				 of_fwnode_handle(mac->of_node),
 				 phy_mode, &mtk_phylink_ops);
@@ -4805,7 +4936,8 @@ static int mtk_probe(struct platform_device *pdev)
 			regmap_write(cci, 0, 3);
 	}
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SGMII)) {
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SGMII) &&
+	    !mtk_is_netsys_v3_or_greater(eth)) {
 		err = mtk_sgmii_init(eth);
 
 		if (err)
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 9ae3b8a71d0e6..ba5998ef7965e 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -15,6 +15,7 @@
 #include <linux/u64_stats_sync.h>
 #include <linux/refcount.h>
 #include <linux/phylink.h>
+#include <linux/reset.h>
 #include <linux/rhashtable.h>
 #include <linux/dim.h>
 #include <linux/bitfield.h>
@@ -503,6 +504,21 @@
 #define INTF_MODE_RGMII_1000    (TRGMII_MODE | TRGMII_CENTRAL_ALIGNED)
 #define INTF_MODE_RGMII_10_100  0
 
+/* XFI Mac control registers */
+#define MTK_XMAC_BASE(x)	(0x12000 + (((x) - 1) * 0x1000))
+#define MTK_XMAC_MCR(x)		(MTK_XMAC_BASE(x))
+#define XMAC_MCR_TRX_DISABLE	0xf
+#define XMAC_MCR_FORCE_TX_FC	BIT(5)
+#define XMAC_MCR_FORCE_RX_FC	BIT(4)
+
+/* XFI Mac logic reset registers */
+#define MTK_XMAC_LOGIC_RST(x)	(MTK_XMAC_BASE(x) + 0x10)
+#define XMAC_LOGIC_RST		BIT(0)
+
+/* XFI Mac count global control */
+#define MTK_XMAC_CNT_CTRL(x)	(MTK_XMAC_BASE(x) + 0x100)
+#define XMAC_GLB_CNTCLR		BIT(0)
+
 /* GPIO port control registers for GMAC 2*/
 #define GPIO_OD33_CTRL8		0x4c0
 #define GPIO_BIAS_CTRL		0xed0
@@ -528,6 +544,7 @@
 #define SYSCFG0_SGMII_GMAC2    ((3 << 8) & SYSCFG0_SGMII_MASK)
 #define SYSCFG0_SGMII_GMAC1_V2 BIT(9)
 #define SYSCFG0_SGMII_GMAC2_V2 BIT(8)
+#define SYSCFG0_SGMII_GMAC3_V2 BIT(7)
 
 
 /* ethernet subsystem clock register */
@@ -566,6 +583,11 @@
 #define GEPHY_MAC_SEL          BIT(1)
 
 /* Top misc registers */
+#define TOP_MISC_NETSYS_PCS_MUX	0x84
+#define NETSYS_PCS_MUX_MASK	GENMASK(1, 0)
+#define	MUX_G2_USXGMII_SEL	BIT(1)
+#define MUX_HSGMII1_G1_SEL	BIT(0)
+
 #define USB_PHY_SWITCH_REG	0x218
 #define QPHY_SEL_MASK		GENMASK(1, 0)
 #define SGMII_QPHY_SEL		0x2
@@ -590,6 +612,8 @@
 #define MT7628_SDM_RBCNT	(MT7628_SDM_OFFSET + 0x10c)
 #define MT7628_SDM_CS_ERR	(MT7628_SDM_OFFSET + 0x110)
 
+/* Debug Purpose Register */
+#define MTK_PSE_FQFC_CFG	0x100
 #define MTK_FE_CDM1_FSM		0x220
 #define MTK_FE_CDM2_FSM		0x224
 #define MTK_FE_CDM3_FSM		0x238
@@ -598,6 +622,11 @@
 #define MTK_FE_CDM6_FSM		0x328
 #define MTK_FE_GDM1_FSM		0x228
 #define MTK_FE_GDM2_FSM		0x22C
+#define MTK_FE_GDM3_FSM		0x23C
+#define MTK_FE_PSE_FREE		0x240
+#define MTK_FE_DROP_FQ		0x244
+#define MTK_FE_DROP_FC		0x248
+#define MTK_FE_DROP_PPE		0x24C
 
 #define MTK_MAC_FSM(x)		(0x1010C + ((x) * 0x100))
 
@@ -722,12 +751,8 @@ enum mtk_clks_map {
 	MTK_CLK_ETHWARP_WOCPU2,
 	MTK_CLK_ETHWARP_WOCPU1,
 	MTK_CLK_ETHWARP_WOCPU0,
-	MTK_CLK_TOP_USXGMII_SBUS_0_SEL,
-	MTK_CLK_TOP_USXGMII_SBUS_1_SEL,
 	MTK_CLK_TOP_SGM_0_SEL,
 	MTK_CLK_TOP_SGM_1_SEL,
-	MTK_CLK_TOP_XFI_PHY_0_XTAL_SEL,
-	MTK_CLK_TOP_XFI_PHY_1_XTAL_SEL,
 	MTK_CLK_TOP_ETH_GMII_SEL,
 	MTK_CLK_TOP_ETH_REFCK_50M_SEL,
 	MTK_CLK_TOP_ETH_SYS_200M_SEL,
@@ -798,19 +823,9 @@ enum mtk_clks_map {
 				 BIT_ULL(MTK_CLK_GP3) | BIT_ULL(MTK_CLK_XGP1) | \
 				 BIT_ULL(MTK_CLK_XGP2) | BIT_ULL(MTK_CLK_XGP3) | \
 				 BIT_ULL(MTK_CLK_CRYPTO) | \
-				 BIT_ULL(MTK_CLK_SGMII_TX_250M) | \
-				 BIT_ULL(MTK_CLK_SGMII_RX_250M) | \
-				 BIT_ULL(MTK_CLK_SGMII2_TX_250M) | \
-				 BIT_ULL(MTK_CLK_SGMII2_RX_250M) | \
 				 BIT_ULL(MTK_CLK_ETHWARP_WOCPU2) | \
 				 BIT_ULL(MTK_CLK_ETHWARP_WOCPU1) | \
 				 BIT_ULL(MTK_CLK_ETHWARP_WOCPU0) | \
-				 BIT_ULL(MTK_CLK_TOP_USXGMII_SBUS_0_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_USXGMII_SBUS_1_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_SGM_0_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_SGM_1_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_XFI_PHY_0_XTAL_SEL) | \
-				 BIT_ULL(MTK_CLK_TOP_XFI_PHY_1_XTAL_SEL) | \
 				 BIT_ULL(MTK_CLK_TOP_ETH_GMII_SEL) | \
 				 BIT_ULL(MTK_CLK_TOP_ETH_REFCK_50M_SEL) | \
 				 BIT_ULL(MTK_CLK_TOP_ETH_SYS_200M_SEL) | \
@@ -944,6 +959,8 @@ enum mkt_eth_capabilities {
 	MTK_RGMII_BIT = 0,
 	MTK_TRGMII_BIT,
 	MTK_SGMII_BIT,
+	MTK_USXGMII_BIT,
+	MTK_2P5GPHY_BIT,
 	MTK_ESW_BIT,
 	MTK_GEPHY_BIT,
 	MTK_MUX_BIT,
@@ -964,8 +981,11 @@ enum mkt_eth_capabilities {
 	MTK_ETH_MUX_GDM1_TO_GMAC1_ESW_BIT,
 	MTK_ETH_MUX_GMAC2_GMAC0_TO_GEPHY_BIT,
 	MTK_ETH_MUX_U3_GMAC2_TO_QPHY_BIT,
+	MTK_ETH_MUX_GMAC2_TO_2P5GPHY_BIT,
 	MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII_BIT,
 	MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII_BIT,
+	MTK_ETH_MUX_GMAC123_TO_GEPHY_SGMII_BIT,
+	MTK_ETH_MUX_GMAC123_TO_USXGMII_BIT,
 
 	/* PATH BITS */
 	MTK_ETH_PATH_GMAC1_RGMII_BIT,
@@ -973,14 +993,21 @@ enum mkt_eth_capabilities {
 	MTK_ETH_PATH_GMAC1_SGMII_BIT,
 	MTK_ETH_PATH_GMAC2_RGMII_BIT,
 	MTK_ETH_PATH_GMAC2_SGMII_BIT,
+	MTK_ETH_PATH_GMAC2_2P5GPHY_BIT,
 	MTK_ETH_PATH_GMAC2_GEPHY_BIT,
+	MTK_ETH_PATH_GMAC3_SGMII_BIT,
 	MTK_ETH_PATH_GDM1_ESW_BIT,
+	MTK_ETH_PATH_GMAC1_USXGMII_BIT,
+	MTK_ETH_PATH_GMAC2_USXGMII_BIT,
+	MTK_ETH_PATH_GMAC3_USXGMII_BIT,
 };
 
 /* Supported hardware group on SoCs */
 #define MTK_RGMII		BIT_ULL(MTK_RGMII_BIT)
 #define MTK_TRGMII		BIT_ULL(MTK_TRGMII_BIT)
 #define MTK_SGMII		BIT_ULL(MTK_SGMII_BIT)
+#define MTK_USXGMII		BIT_ULL(MTK_USXGMII_BIT)
+#define MTK_2P5GPHY		BIT_ULL(MTK_2P5GPHY_BIT)
 #define MTK_ESW			BIT_ULL(MTK_ESW_BIT)
 #define MTK_GEPHY		BIT_ULL(MTK_GEPHY_BIT)
 #define MTK_MUX			BIT_ULL(MTK_MUX_BIT)
@@ -1003,10 +1030,16 @@ enum mkt_eth_capabilities {
 	BIT_ULL(MTK_ETH_MUX_GMAC2_GMAC0_TO_GEPHY_BIT)
 #define MTK_ETH_MUX_U3_GMAC2_TO_QPHY		\
 	BIT_ULL(MTK_ETH_MUX_U3_GMAC2_TO_QPHY_BIT)
+#define MTK_ETH_MUX_GMAC2_TO_2P5GPHY		\
+	BIT_ULL(MTK_ETH_MUX_GMAC2_TO_2P5GPHY_BIT)
 #define MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII	\
 	BIT_ULL(MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII_BIT)
 #define MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII	\
 	BIT_ULL(MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII_BIT)
+#define MTK_ETH_MUX_GMAC123_TO_GEPHY_SGMII	\
+	BIT_ULL(MTK_ETH_MUX_GMAC123_TO_GEPHY_SGMII_BIT)
+#define MTK_ETH_MUX_GMAC123_TO_USXGMII	\
+	BIT_ULL(MTK_ETH_MUX_GMAC123_TO_USXGMII_BIT)
 
 /* Supported path present on SoCs */
 #define MTK_ETH_PATH_GMAC1_RGMII	BIT_ULL(MTK_ETH_PATH_GMAC1_RGMII_BIT)
@@ -1014,8 +1047,13 @@ enum mkt_eth_capabilities {
 #define MTK_ETH_PATH_GMAC1_SGMII	BIT_ULL(MTK_ETH_PATH_GMAC1_SGMII_BIT)
 #define MTK_ETH_PATH_GMAC2_RGMII	BIT_ULL(MTK_ETH_PATH_GMAC2_RGMII_BIT)
 #define MTK_ETH_PATH_GMAC2_SGMII	BIT_ULL(MTK_ETH_PATH_GMAC2_SGMII_BIT)
+#define MTK_ETH_PATH_GMAC2_2P5GPHY	BIT_ULL(MTK_ETH_PATH_GMAC2_2P5GPHY_BIT)
 #define MTK_ETH_PATH_GMAC2_GEPHY	BIT_ULL(MTK_ETH_PATH_GMAC2_GEPHY_BIT)
+#define MTK_ETH_PATH_GMAC3_SGMII	BIT_ULL(MTK_ETH_PATH_GMAC3_SGMII_BIT)
 #define MTK_ETH_PATH_GDM1_ESW		BIT_ULL(MTK_ETH_PATH_GDM1_ESW_BIT)
+#define MTK_ETH_PATH_GMAC1_USXGMII	BIT_ULL(MTK_ETH_PATH_GMAC1_USXGMII_BIT)
+#define MTK_ETH_PATH_GMAC2_USXGMII	BIT_ULL(MTK_ETH_PATH_GMAC2_USXGMII_BIT)
+#define MTK_ETH_PATH_GMAC3_USXGMII	BIT_ULL(MTK_ETH_PATH_GMAC3_USXGMII_BIT)
 
 #define MTK_GMAC1_RGMII		(MTK_ETH_PATH_GMAC1_RGMII | MTK_RGMII)
 #define MTK_GMAC1_TRGMII	(MTK_ETH_PATH_GMAC1_TRGMII | MTK_TRGMII)
@@ -1023,7 +1061,12 @@ enum mkt_eth_capabilities {
 #define MTK_GMAC2_RGMII		(MTK_ETH_PATH_GMAC2_RGMII | MTK_RGMII)
 #define MTK_GMAC2_SGMII		(MTK_ETH_PATH_GMAC2_SGMII | MTK_SGMII)
 #define MTK_GMAC2_GEPHY		(MTK_ETH_PATH_GMAC2_GEPHY | MTK_GEPHY)
+#define MTK_GMAC2_2P5GPHY	(MTK_ETH_PATH_GMAC2_2P5GPHY | MTK_2P5GPHY)
+#define MTK_GMAC3_SGMII		(MTK_ETH_PATH_GMAC3_SGMII | MTK_SGMII)
 #define MTK_GDM1_ESW		(MTK_ETH_PATH_GDM1_ESW | MTK_ESW)
+#define MTK_GMAC1_USXGMII	(MTK_ETH_PATH_GMAC1_USXGMII | MTK_USXGMII)
+#define MTK_GMAC2_USXGMII	(MTK_ETH_PATH_GMAC2_USXGMII | MTK_USXGMII)
+#define MTK_GMAC3_USXGMII	(MTK_ETH_PATH_GMAC3_USXGMII | MTK_USXGMII)
 
 /* MUXes present on SoCs */
 /* 0: GDM1 -> GMAC1, 1: GDM1 -> ESW */
@@ -1042,10 +1085,20 @@ enum mkt_eth_capabilities {
 	(MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII | MTK_MUX | \
 	MTK_SHARED_SGMII)
 
+/* 2: GMAC2 -> XGMII */
+#define MTK_MUX_GMAC2_TO_2P5GPHY      \
+	(MTK_ETH_MUX_GMAC2_TO_2P5GPHY | MTK_MUX | MTK_INFRA)
+
 /* 0: GMACx -> GEPHY, 1: GMACx -> SGMII where x is 1 or 2 */
 #define MTK_MUX_GMAC12_TO_GEPHY_SGMII   \
 	(MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII | MTK_MUX)
 
+#define MTK_MUX_GMAC123_TO_GEPHY_SGMII   \
+	(MTK_ETH_MUX_GMAC123_TO_GEPHY_SGMII | MTK_MUX)
+
+#define MTK_MUX_GMAC123_TO_USXGMII   \
+	(MTK_ETH_MUX_GMAC123_TO_USXGMII | MTK_MUX | MTK_INFRA)
+
 #define MTK_HAS_CAPS(caps, _x)		(((caps) & (_x)) == (_x))
 
 #define MT7621_CAPS  (MTK_GMAC1_RGMII | MTK_GMAC1_TRGMII | \
@@ -1077,8 +1130,12 @@ enum mkt_eth_capabilities {
 		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA | \
 		      MTK_RSTCTRL_PPE1 | MTK_SRAM)
 
-#define MT7988_CAPS  (MTK_36BIT_DMA | MTK_GDM1_ESW | MTK_QDMA | \
-		      MTK_RSTCTRL_PPE1 | MTK_RSTCTRL_PPE2 | MTK_SRAM)
+#define MT7988_CAPS  (MTK_36BIT_DMA | MTK_GDM1_ESW | MTK_GMAC1_SGMII | \
+		      MTK_GMAC2_2P5GPHY | MTK_GMAC2_SGMII | MTK_GMAC2_USXGMII | \
+		      MTK_GMAC3_SGMII | MTK_GMAC3_USXGMII | \
+		      MTK_MUX_GMAC123_TO_GEPHY_SGMII | \
+		      MTK_MUX_GMAC123_TO_USXGMII | MTK_MUX_GMAC2_TO_2P5GPHY | \
+		      MTK_QDMA | MTK_RSTCTRL_PPE1 | MTK_RSTCTRL_PPE2 | MTK_SRAM)
 
 struct mtk_tx_dma_desc_info {
 	dma_addr_t	addr;
@@ -1313,6 +1370,7 @@ struct mtk_mac {
 	phy_interface_t			interface;
 	int				speed;
 	struct device_node		*of_node;
+	struct device_node		*pcs_of_node;
 	struct phylink			*phylink;
 	struct phylink_config		phylink_config;
 	struct mtk_eth			*hw;
@@ -1421,6 +1479,19 @@ static inline u32 mtk_get_ib2_multicast_mask(struct mtk_eth *eth)
 	return MTK_FOE_IB2_MULTICAST;
 }
 
+static inline bool mtk_interface_mode_is_xgmii(phy_interface_t interface)
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
 /* read the hardware status register */
 void mtk_stats_update_mac(struct mtk_mac *mac);
 
@@ -1429,8 +1500,10 @@ u32 mtk_r32(struct mtk_eth *eth, unsigned reg);
 u32 mtk_m32(struct mtk_eth *eth, u32 mask, u32 set, unsigned int reg);
 
 int mtk_gmac_sgmii_path_setup(struct mtk_eth *eth, int mac_id);
+int mtk_gmac_2p5gphy_path_setup(struct mtk_eth *eth, int mac_id);
 int mtk_gmac_gephy_path_setup(struct mtk_eth *eth, int mac_id);
 int mtk_gmac_rgmii_path_setup(struct mtk_eth *eth, int mac_id);
+int mtk_gmac_usxgmii_path_setup(struct mtk_eth *eth, int mac_id);
 
 int mtk_eth_offload_init(struct mtk_eth *eth);
 int mtk_eth_setup_tc(struct net_device *dev, enum tc_setup_type type,
-- 
2.42.1
