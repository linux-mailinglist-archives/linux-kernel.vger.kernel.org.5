Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C626275BE23
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjGUGBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjGUGBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:01:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB833588;
        Thu, 20 Jul 2023 23:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689919256; x=1721455256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hsXHaUgeRKhymmmE9mLF/nwxqCUXefsE5jGEfnG1L10=;
  b=FJSpIwbb31/62cbTpoM/JTCCWzvjZcMDBdChTLInNvNeKmRW+Bor0ayE
   1u9w32isVFdyOjCesfB7+TcsDmHhIpdsvaOewuheQ4J77BPsqpkTDhF9O
   knsVc6aG5TnIfDiecxvx8buLSaErC2vi3YNPHBJxblx3+UtPqpUHz3sZ1
   3LjtaaYB3GMSNvSDgE5elZzMr9ibt8El5ErJwWJzLemoeFBxiGbgQRRVr
   wbxheqRMhyQcXkCyvTESuNTfprcTMjirwzb5OeI7/9CJnOR1popYjvX+S
   caVlFzWwlnrB2pDPKfZ0BSgcxYQZojLREL5npVV5JkhisP827oQBxjGrj
   g==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="221463601"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 23:00:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 23:00:50 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 20 Jul 2023 23:00:47 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bryan.whitehead@microchip.com>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next 5/7] net: lan743x: Add support to the Phylink framework
Date:   Fri, 21 Jul 2023 11:30:17 +0530
Message-ID: <20230721060019.2737-6-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721060019.2737-1-Raju.Lakkaraju@microchip.com>
References: <20230721060019.2737-1-Raju.Lakkaraju@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phylink framework will be helpful in the future for boards using this
controller with SFP cages.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/ethernet/microchip/Kconfig        |   2 +-
 drivers/net/ethernet/microchip/lan743x_main.c | 314 +++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |   6 +
 3 files changed, 314 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index b1d361b412d1..1c947e3437b7 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -46,7 +46,7 @@ config LAN743X
 	tristate "LAN743x support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
-	select FIXED_PHY
+	select PHYLINK
 	select CRC16
 	select CRC32
 	select I2C_PCI1XXXX
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index aef64747a952..9b6326d035a8 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1618,7 +1618,11 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 	data = lan743x_csr_read(adapter, MAC_CR);
 	id_rev = adapter->csr.id_rev & ID_REV_ID_MASK_;
 
-	if (adapter->is_pci11x1x && adapter->is_sgmii_en)
+	if (adapter->is_pci11x1x &&
+	    adapter->is_sgmii_en &&
+	    adapter->is_sfp_support_en)
+		adapter->phy_interface = PHY_INTERFACE_MODE_2500BASEX;
+	else if (adapter->is_pci11x1x && adapter->is_sgmii_en)
 		adapter->phy_interface = PHY_INTERFACE_MODE_SGMII;
 	else if (id_rev == ID_REV_ID_LAN7430_)
 		adapter->phy_interface = PHY_INTERFACE_MODE_GMII;
@@ -1626,6 +1630,9 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 		adapter->phy_interface = PHY_INTERFACE_MODE_MII;
 	else
 		adapter->phy_interface = PHY_INTERFACE_MODE_RGMII;
+
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "selected phy interface: 0x%X\n", adapter->phy_interface);
 }
 
 static int lan743x_phy_open(struct lan743x_adapter *adapter)
@@ -3221,6 +3228,266 @@ static int lan743x_swnodes_register(struct lan743x_adapter *adapter)
 	return software_node_register_node_group(nodes->group);
 }
 
+static void lan743x_mac_cfg_update(struct lan743x_adapter *adapter, bool link,
+				   int speed, const unsigned long *advertise)
+{
+	int mac_cr;
+
+	mac_cr = lan743x_csr_read(adapter, MAC_CR);
+	mac_cr &= ~(MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
+	if (link) {
+		if (speed == SPEED_2500)
+			mac_cr |= (MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
+		else if (speed == SPEED_1000)
+			mac_cr |= (MAC_CR_CFG_H_);
+		else if (speed == SPEED_100)
+			mac_cr |= (MAC_CR_CFG_L_);
+	} else if (test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, advertise) ||
+		   test_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, advertise)) {
+		mac_cr |= (MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
+		adapter->sgmii_lsd = LINK_2500_MASTER;
+	} else if (test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, advertise) ||
+		   test_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, advertise)) {
+		mac_cr |= (MAC_CR_CFG_H_);
+		adapter->sgmii_lsd = LINK_1000_MASTER;
+	} else if (test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, advertise) ||
+		   test_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, advertise) ||
+		   test_bit(ETHTOOL_LINK_MODE_100baseFX_Full_BIT, advertise) ||
+		   test_bit(ETHTOOL_LINK_MODE_100baseFX_Half_BIT, advertise)) {
+		mac_cr |= (MAC_CR_CFG_L_);
+		adapter->sgmii_lsd = LINK_1000_MASTER;
+	} else {
+		adapter->sgmii_lsd = LINK_1000_MASTER;
+	}
+
+	lan743x_csr_write(adapter, MAC_CR, mac_cr);
+}
+
+static void lan743x_phylink_mac_config(struct phylink_config *config,
+				       unsigned int link_an_mode,
+				       const struct phylink_link_state *state)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	bool status;
+	int ret;
+
+	lan743x_mac_cfg_update(adapter, state->link, state->speed,
+			       state->advertising);
+
+	if (!state->link && adapter->is_sgmii_en) {
+		ret = lan743x_sgmii_aneg_update(adapter);
+		if (ret < 0) {
+			netif_err(adapter, drv, adapter->netdev,
+				  "error %d SGMII cfg failed\n", ret);
+			return;
+		}
+
+		ret = lan743x_is_sgmii_2_5G_mode(adapter, &status);
+		if (ret < 0) {
+			netif_err(adapter, drv, adapter->netdev,
+				  "erro %d SGMII get mode failed\n", ret);
+			return;
+		}
+
+		if (status)
+			netif_dbg(adapter, drv, adapter->netdev,
+				  "SGMII 2.5G mode enable\n");
+		else
+			netif_dbg(adapter, drv, adapter->netdev,
+				  "SGMII 1G mode enable\n");
+
+		ret = lan743x_pcs_power_reset(adapter);
+		if (ret < 0) {
+			netif_err(adapter, drv, adapter->netdev,
+				  "error %d pcs power reset failed\n", ret);
+			return;
+		}
+
+		phylink_mac_change(adapter->phylink, state->link);
+	}
+}
+
+static void lan743x_phylink_mac_link_down(struct phylink_config *config,
+					  unsigned int link_an_mode,
+					  phy_interface_t interface)
+{
+	netif_tx_stop_all_queues(to_net_dev(config->dev));
+}
+
+static void lan743x_phylink_mac_link_up(struct phylink_config *config,
+					struct phy_device *phydev,
+					unsigned int link_an_mode,
+					phy_interface_t interface,
+					int speed, int duplex,
+					bool tx_pause, bool rx_pause)
+{
+	netif_tx_wake_all_queues(to_net_dev(config->dev));
+}
+
+static void lan743x_phylink_mac_pcs_get_state(struct phylink_config *config,
+					      struct phylink_link_state *state)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	int intr_sts;
+	int wait_cnt;
+	bool status;
+	int mii_sts;
+	bool link;
+	int ret;
+
+	wait_cnt = 0;
+	link = false;
+	while (wait_cnt++ < 10) {
+		mii_sts = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2, MII_BMSR);
+		if (mii_sts < 0) {
+			netif_err(adapter, drv, adapter->netdev,
+				  "erro %d MMD VEND2 MII BMSR read failed\n",
+				   mii_sts);
+			return;
+		}
+
+		mii_sts = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2, MII_BMSR);
+		if (mii_sts < 0) {
+			netif_err(adapter, drv, adapter->netdev,
+				  "erro %d MMD VEND2 MII BMSR read failed\n",
+				   mii_sts);
+			return;
+		}
+
+		if (mii_sts & SR_MII_STS_LINK_STS_) {
+			link = true;
+			break;
+		}
+
+		usleep_range(1000, 2000);
+	}
+
+	state->speed = SPEED_UNKNOWN;
+	state->duplex = DUPLEX_UNKNOWN;
+	if (link) {
+		int speed = SPEED_UNKNOWN;
+		int duplex = DUPLEX_UNKNOWN;
+
+		intr_sts = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2,
+					      VR_MII_AN_INTR_STS);
+		if (intr_sts < 0) {
+			netif_err(adapter, drv, adapter->netdev,
+				  "erro %d VR_MII_AN_INTR_STS read failed\n",
+				  intr_sts);
+			return;
+		}
+
+		if ((intr_sts & VR_MII_AN_INTR_STS_SPEED_MASK_) !=
+		    VR_MII_AN_INTR_STS_SPEED_MASK_) {
+			if (intr_sts & VR_MII_AN_INTR_STS_1000_MBPS_)
+				speed = SPEED_1000;
+			else if (intr_sts & VR_MII_AN_INTR_STS_100_MBPS_)
+				speed = SPEED_100;
+			else
+				speed = SPEED_10;
+		}
+
+		if (intr_sts & VR_MII_AN_INTR_STS_FDX_)
+			duplex = DUPLEX_FULL;
+		else
+			duplex = DUPLEX_HALF;
+
+		ret = lan743x_is_sgmii_2_5G_mode(adapter, &status);
+		if (ret < 0) {
+			netif_err(adapter, drv, adapter->netdev,
+				  "erro %d SGMII get mode failed\n", ret);
+			return;
+		}
+
+		if (adapter->is_sgmii_en && status) {
+			state->speed = SPEED_2500;
+			state->duplex = DUPLEX_FULL;
+		} else if (adapter->is_sgmii_en) {
+			state->speed = speed;
+			state->duplex = duplex;
+		}
+	}
+
+	state->link = link;
+
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "Link: %s, Speed:%d, %s Duplex\n",
+		  state->link ? "Up" : "Down",
+		  state->speed, (state->duplex == DUPLEX_FULL ? "Full" :
+		  (state->duplex == DUPLEX_HALF ? "Half" : "Unknown")));
+}
+
+static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
+	.validate = phylink_generic_validate,
+	.mac_config = lan743x_phylink_mac_config,
+	.mac_link_down = lan743x_phylink_mac_link_down,
+	.mac_link_up = lan743x_phylink_mac_link_up,
+	.mac_pcs_get_state = lan743x_phylink_mac_pcs_get_state,
+};
+
+static int lan743x_phylink_create(struct net_device *netdev)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	struct fwnode_handle *fwnode;
+	struct phylink *phylink;
+	int ret;
+
+	adapter->phylink_config.dev = &netdev->dev;
+	adapter->phylink_config.type = PHYLINK_NETDEV;
+	adapter->phylink_config.mac_managed_pm = true;
+	/* This driver makes use of state->speed in mac_config */
+	adapter->phylink_config.legacy_pre_march2020 = true;
+
+	adapter->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
+		MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD;
+
+	/* Config serdes Interface */
+	lan743x_phy_interface_select(adapter);
+
+	if (adapter->is_sgmii_en) {
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  adapter->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  adapter->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  adapter->phylink_config.supported_interfaces);
+	}
+
+	fwnode = software_node_fwnode(adapter->nodes->group[SWNODE_PHYLINK]);
+	if (!fwnode)
+		return -ENODEV;
+
+	phylink = phylink_create(&adapter->phylink_config,
+				 fwnode,
+				 adapter->phy_interface,
+				 &lan743x_phylink_mac_ops);
+
+	if (IS_ERR(phylink)) {
+		ret = PTR_ERR(phylink);
+		netdev_err(netdev, "Could not create phylink (%pe)\n", phylink);
+		return ret;
+	}
+
+	adapter->phylink = phylink;
+	netdev_dbg(netdev, "lan743x phylink created");
+
+	return 0;
+}
+
+static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
+{
+	phylink_start(adapter->phylink);
+
+	return 0;
+}
+
+static void lan743x_phylink_close(struct lan743x_adapter *adapter)
+{
+	phylink_stop(adapter->phylink);
+}
+
 static int lan743x_netdev_close(struct net_device *netdev)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
@@ -3234,7 +3501,10 @@ static int lan743x_netdev_close(struct net_device *netdev)
 
 	lan743x_ptp_close(adapter);
 
-	lan743x_phy_close(adapter);
+	if (adapter->phylink)
+		lan743x_phylink_close(adapter);
+	else
+		lan743x_phy_close(adapter);
 
 	lan743x_mac_close(adapter);
 
@@ -3257,9 +3527,15 @@ static int lan743x_netdev_open(struct net_device *netdev)
 	if (ret)
 		goto close_intr;
 
-	ret = lan743x_phy_open(adapter);
-	if (ret)
-		goto close_mac;
+	if (adapter->phylink) {
+		ret = lan743x_phylink_connect(adapter);
+		if (ret)
+			goto close_mac;
+	} else {
+		ret = lan743x_phy_open(adapter);
+		if (ret)
+			goto close_mac;
+	}
 
 	ret = lan743x_ptp_open(adapter);
 	if (ret)
@@ -3294,7 +3570,10 @@ static int lan743x_netdev_open(struct net_device *netdev)
 	lan743x_ptp_close(adapter);
 
 close_phy:
-	lan743x_phy_close(adapter);
+	if (adapter->phylink)
+		lan743x_phylink_close(adapter);
+	else
+		lan743x_phy_close(adapter);
 
 close_mac:
 	lan743x_mac_close(adapter);
@@ -3323,10 +3602,16 @@ static netdev_tx_t lan743x_netdev_xmit_frame(struct sk_buff *skb,
 static int lan743x_netdev_ioctl(struct net_device *netdev,
 				struct ifreq *ifr, int cmd)
 {
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
 	if (!netif_running(netdev))
 		return -EINVAL;
 	if (cmd == SIOCSHWTSTAMP)
 		return lan743x_ptp_ioctl(netdev, ifr, cmd);
+
+	if (adapter->phylink)
+		return phylink_mii_ioctl(adapter->phylink, ifr, cmd);
+
 	return phy_mii_ioctl(netdev->phydev, ifr, cmd);
 }
 
@@ -3427,6 +3712,9 @@ static void lan743x_hardware_cleanup(struct lan743x_adapter *adapter)
 	if (adapter->i2c_adap)
 		adapter->i2c_adap = NULL;
 
+	if (adapter->phylink)
+		phylink_destroy(adapter->phylink);
+
 	if (adapter->nodes)
 		software_node_unregister_node_group(adapter->nodes->group);
 
@@ -3650,9 +3938,21 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 	adapter->netdev->features = NETIF_F_SG | NETIF_F_TSO |
 				    NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	adapter->netdev->hw_features = adapter->netdev->features;
+	/* Default Link-Speed-Duplex (LSD) state */
+	adapter->sgmii_lsd = LINK_2500_MASTER;
+
+	if (adapter->is_sfp_support_en) {
+		ret = lan743x_phylink_create(adapter->netdev);
+		if (ret) {
+			netif_err(adapter, probe, netdev,
+				  "failed to setup phylink (%d)\n", ret);
+			goto cleanup_hardware;
+		}
+	}
 
 	/* carrier off reporting is important to ethtool even BEFORE open */
-	netif_carrier_off(netdev);
+	if (!adapter->phylink)
+		netif_carrier_off(netdev);
 
 	ret = register_netdev(adapter->netdev);
 	if (ret < 0)
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 7f1c5673bc61..6b94d0e93cbb 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -6,6 +6,7 @@
 
 #include <linux/phy.h>
 #include <linux/property.h>
+#include <linux/phylink.h>
 #include "lan743x_ptp.h"
 
 #define DRIVER_AUTHOR   "Bryan Whitehead <Bryan.Whitehead@microchip.com>"
@@ -317,6 +318,9 @@
 /* Vendor Specific SGMII MMD details */
 #define SR_VSMMD_PCS_ID1		0x0004
 #define SR_VSMMD_PCS_ID2		0x0005
+#define SR_MII_CTRL			MII_BMCR
+#define SR_MII_STS			MII_BMSR
+#define SR_MII_STS_LINK_STS_		BIT(2)
 #define SR_VSMMD_STS			0x0008
 #define SR_VSMMD_CTRL			0x0009
 
@@ -1077,6 +1081,8 @@ struct lan743x_adapter {
 	phy_interface_t		phy_interface;
 	struct lan743x_sw_nodes	*nodes;
 	struct i2c_adapter	*i2c_adap;
+	struct phylink		*phylink;
+	struct phylink_config	phylink_config;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
-- 
2.25.1

