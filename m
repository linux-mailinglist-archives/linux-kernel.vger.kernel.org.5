Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589CC7D3B53
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjJWPtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjJWPtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:49:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A925CBC;
        Mon, 23 Oct 2023 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698076168; x=1729612168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EIAWZnz+aluTlA+jsc27kElv023QDhk3i4+lvfGU06U=;
  b=oR60E7njDXyiXiUIlAn9gYGJe11y4BDMAtLvYM+Xkr83DI2EKjPrcm/2
   cGey8Wsgr2rCJ0WmVvxWZEY3H0p005Qkk7u9ms9FXngWLQvG2DUi2a0yy
   Kzt2RfG7rBLY8TGQ8rrkpo0dKao+jI+weVJJjm7JijQRA+AgVB3c7AsxL
   R3m+kxfEFj3DvjRbYqTQF53HV0YyUqTYTFQYJx27C9s3WxVdAGJILbPHn
   BJyl1T6/mYOlfVggsGBQNkQdC5LJ2pAoi7R2Oqj2m5WzpSBA5ZOxwBPRw
   8kmgg8xO/EFXOPNyZvtDnAUMQ3FfOUPbdMtM23INO++zeVUh2JJTE8qQ0
   w==;
X-CSE-ConnectionGUID: R4tFaVLSQ02v5bYQOZNT7Q==
X-CSE-MsgGUID: 6LR9DXzTRyiGay5Whjwrxg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="177613922"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 08:49:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 23 Oct 2023 08:48:57 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 23 Oct 2023 08:48:45 -0700
From:   Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <steen.hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 8/9] microchip: lan865x: add driver support for Microchip's LAN865X MACPHY
Date:   Mon, 23 Oct 2023 21:16:48 +0530
Message-ID: <20231023154649.45931-9-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LAN8650/1 is designed to conform to the OPEN Alliance 10BASE‑T1x
MAC‑PHY Serial Interface specification, Version 1.1. The IEEE Clause 4
MAC integration provides the low pin count standard SPI interface to any
microcontroller therefore providing Ethernet functionality without
requiring MAC integration within the microcontroller. The LAN8650/1
operates as an SPI client supporting SCLK clock rates up to a maximum of
25 MHz. This SPI interface supports the transfer of both data (Ethernet
frames) and control (register access).

By default, the chunk data payload is 64 bytes in size. A smaller payload
data size of 32 bytes is also supported and may be configured in the
Chunk Payload Size (CPS) field of the Configuration 0 (OA_CONFIG0)
register. Changing the chunk payload size requires the LAN8650/1 be reset
and shall not be done during normal operation.

The Ethernet Media Access Controller (MAC) module implements a 10 Mbps
half duplex Ethernet MAC, compatible with the IEEE 802.3 standard.
10BASE-T1S physical layer transceiver integrated into the LAN8650/1. The
PHY and MAC are connected via an internal Media Independent Interface
(MII).

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 MAINTAINERS                              |   6 +
 drivers/net/ethernet/microchip/Kconfig   |  11 +
 drivers/net/ethernet/microchip/Makefile  |   2 +
 drivers/net/ethernet/microchip/lan865x.c | 415 +++++++++++++++++++++++
 4 files changed, 434 insertions(+)
 create mode 100644 drivers/net/ethernet/microchip/lan865x.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9580be91f5e9..1b1bd3218a2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14001,6 +14001,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan743x_*
 
+MICROCHIP LAN8650/1 10BASE-T1S MACPHY ETHERNET DRIVER
+M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/microchip/lan865x.c
+
 MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
 M:	Arun Ramadoss <arun.ramadoss@microchip.com>
 R:	UNGLinuxDriver@microchip.com
diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 329e374b9539..596caf59dea6 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -59,4 +59,15 @@ source "drivers/net/ethernet/microchip/lan966x/Kconfig"
 source "drivers/net/ethernet/microchip/sparx5/Kconfig"
 source "drivers/net/ethernet/microchip/vcap/Kconfig"
 
+config LAN865X
+	tristate "LAN865x support"
+	depends on SPI
+	depends on OA_TC6
+	help
+      	  Support for the Microchip LAN8650/1 Rev.B0 MACPHY Ethernet chip. It
+	  uses OPEN Alliance 10BASE-T1x Serial Interface specification.
+
+      	  To compile this driver as a module, choose M here. The module will be
+          called lan865x.
+
 endif # NET_VENDOR_MICROCHIP
diff --git a/drivers/net/ethernet/microchip/Makefile b/drivers/net/ethernet/microchip/Makefile
index bbd349264e6f..1fa4e15a067d 100644
--- a/drivers/net/ethernet/microchip/Makefile
+++ b/drivers/net/ethernet/microchip/Makefile
@@ -12,3 +12,5 @@ lan743x-objs := lan743x_main.o lan743x_ethtool.o lan743x_ptp.o
 obj-$(CONFIG_LAN966X_SWITCH) += lan966x/
 obj-$(CONFIG_SPARX5_SWITCH) += sparx5/
 obj-$(CONFIG_VCAP) += vcap/
+
+obj-$(CONFIG_LAN865X) += lan865x.o
diff --git a/drivers/net/ethernet/microchip/lan865x.c b/drivers/net/ethernet/microchip/lan865x.c
new file mode 100644
index 000000000000..3ac6a0a31b37
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan865x.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Microchip's LAN865x 10BASE-T1S MAC-PHY driver
+ *
+ * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/etherdevice.h>
+#include <linux/mdio.h>
+#include <linux/phy.h>
+#include <linux/of.h>
+#include <linux/oa_tc6.h>
+
+#define DRV_NAME		"lan865x"
+
+/* MAC Network Control Register */
+#define LAN865X_MAC_NCR         0x00010000
+#define LAN865X_TXEN		BIT(3) /* Transmit Enable */
+#define LAN865X_RXEN		BIT(2) /* Receive Enable */
+#define LAN865X_MAC_NCFGR	0x00010001 /* MAC Network Configuration Register */
+#define LAN865X_MAC_HRB		0x00010020 /* MAC Hash Register Bottom */
+#define LAN865X_MAC_HRT		0x00010021 /* MAC Hash Register Top */
+#define LAN865X_MAC_SAB1	0x00010022 /* MAC Specific Address 1 Bottom Register */
+#define LAN865X_MAC_SAT1	0x00010023 /* MAC Specific Address 1 Top Register */
+/* Queue Transmit Configuration */
+#define LAN865X_QTXCFG		0x000A0081
+/* Queue Receive Configuration */
+#define LAN865X_QRXCFG		0x000A0082
+#define LAN865X_BUFSZ		GENMASK(22, 20) /* Buffer Size */
+
+#define MAC_PROMISCUOUS_MODE	BIT(4)
+#define MAC_MULTICAST_MODE	BIT(6)
+#define MAC_UNICAST_MODE	BIT(7)
+
+#define TX_TIMEOUT		(4 * HZ)
+#define LAN865X_MSG_DEFAULT	\
+	(NETIF_MSG_PROBE | NETIF_MSG_IFUP | NETIF_MSG_IFDOWN | NETIF_MSG_LINK)
+
+struct lan865x_priv {
+	struct net_device *netdev;
+	struct spi_device *spi;
+	struct oa_tc6 *tc6;
+	u32 msg_enable;
+	bool protected;
+	bool txcte;
+	bool rxcte;
+	u32 cps;
+};
+
+static int lan865x_set_hw_macaddr(struct net_device *netdev)
+{
+	u32 regval;
+	bool ret;
+	struct lan865x_priv *priv = netdev_priv(netdev);
+	const u8 *mac = netdev->dev_addr;
+
+	ret = oa_tc6_read_register(priv->tc6, LAN865X_MAC_NCR, &regval);
+	if (ret)
+		goto error_mac;
+	if ((regval & LAN865X_TXEN) | (regval & LAN865X_RXEN)) {
+		if (netif_msg_drv(priv))
+			netdev_warn(netdev, "Hardware must be disabled for MAC setting\n");
+		return -EBUSY;
+	}
+	/* MAC address setting */
+	regval = (mac[3] << 24) | (mac[2] << 16) | (mac[1] << 8) | mac[0];
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_MAC_SAB1, regval);
+	if (ret)
+		goto error_mac;
+
+	regval = (mac[5] << 8) | mac[4];
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_MAC_SAT1, regval);
+	if (ret)
+		goto error_mac;
+
+	return 0;
+
+error_mac:
+	return -ENODEV;
+}
+
+static void lan865x_set_msglevel(struct net_device *netdev, u32 val)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+
+	priv->msg_enable = val;
+}
+
+static u32 lan865x_get_msglevel(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+
+	return priv->msg_enable;
+}
+
+static void
+lan865x_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+	strscpy(info->bus_info, dev_name(netdev->dev.parent),
+		sizeof(info->bus_info));
+}
+
+static const struct ethtool_ops lan865x_ethtool_ops = {
+	.get_drvinfo	= lan865x_get_drvinfo,
+	.get_msglevel	= lan865x_get_msglevel,
+	.set_msglevel	= lan865x_set_msglevel,
+	.get_link_ksettings = phy_ethtool_get_link_ksettings,
+	.set_link_ksettings = phy_ethtool_set_link_ksettings,
+};
+
+static void lan865x_tx_timeout(struct net_device *netdev, unsigned int txqueue)
+{
+	netdev->stats.tx_errors++;
+}
+
+static int lan865x_set_mac_address(struct net_device *netdev, void *addr)
+{
+	struct sockaddr *address = addr;
+
+	if (netif_running(netdev))
+		return -EBUSY;
+
+	eth_hw_addr_set(netdev, address->sa_data);
+
+	return lan865x_set_hw_macaddr(netdev);
+}
+
+static u32 lan865x_hash(u8 addr[ETH_ALEN])
+{
+	return (ether_crc(ETH_ALEN, addr) >> 26) & 0x3f;
+}
+
+static void lan865x_set_multicast_list(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+	u32 regval = 0;
+
+	if (netdev->flags & IFF_PROMISC) {
+		/* Enabling promiscuous mode */
+		regval |= MAC_PROMISCUOUS_MODE;
+		regval &= (~MAC_MULTICAST_MODE);
+		regval &= (~MAC_UNICAST_MODE);
+	} else if (netdev->flags & IFF_ALLMULTI) {
+		/* Enabling all multicast mode */
+		regval &= (~MAC_PROMISCUOUS_MODE);
+		regval |= MAC_MULTICAST_MODE;
+		regval &= (~MAC_UNICAST_MODE);
+	} else if (!netdev_mc_empty(netdev)) {
+		/* Enabling specific multicast addresses */
+		struct netdev_hw_addr *ha;
+		u32 hash_lo = 0;
+		u32 hash_hi = 0;
+
+		netdev_for_each_mc_addr(ha, netdev) {
+			u32 bit_num = lan865x_hash(ha->addr);
+			u32 mask = 1 << (bit_num & 0x1f);
+
+			if (bit_num & 0x20)
+				hash_hi |= mask;
+			else
+				hash_lo |= mask;
+		}
+		if (oa_tc6_write_register(priv->tc6, LAN865X_MAC_HRT, hash_hi)) {
+			if (netif_msg_timer(priv))
+				netdev_err(netdev, "Failed to write reg_hashh");
+			return;
+		}
+		if (oa_tc6_write_register(priv->tc6, LAN865X_MAC_HRB, hash_lo)) {
+			if (netif_msg_timer(priv))
+				netdev_err(netdev, "Failed to write reg_hashl");
+			return;
+		}
+		regval &= (~MAC_PROMISCUOUS_MODE);
+		regval &= (~MAC_MULTICAST_MODE);
+		regval |= MAC_UNICAST_MODE;
+	} else {
+		/* enabling local mac address only */
+		if (oa_tc6_write_register(priv->tc6, LAN865X_MAC_HRT, regval)) {
+			if (netif_msg_timer(priv))
+				netdev_err(netdev, "Failed to write reg_hashh");
+			return;
+		}
+		if (oa_tc6_write_register(priv->tc6, LAN865X_MAC_HRB, regval)) {
+			if (netif_msg_timer(priv))
+				netdev_err(netdev, "Failed to write reg_hashl");
+			return;
+		}
+	}
+	if (oa_tc6_write_register(priv->tc6, LAN865X_MAC_NCFGR, regval)) {
+		if (netif_msg_timer(priv))
+			netdev_err(netdev, "Failed to enable promiscuous mode");
+	}
+}
+
+static netdev_tx_t lan865x_send_packet(struct sk_buff *skb,
+				       struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+
+	return oa_tc6_send_eth_pkt(priv->tc6, skb);
+}
+
+static int lan865x_hw_disable(struct lan865x_priv *priv)
+{
+	u32 regval;
+
+	if (oa_tc6_read_register(priv->tc6, LAN865X_MAC_NCR, &regval))
+		return -ENODEV;
+
+	regval &= ~(LAN865X_TXEN | LAN865X_RXEN);
+
+	if (oa_tc6_write_register(priv->tc6, LAN865X_MAC_NCR, regval))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int lan865x_net_close(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+	int ret;
+
+	netif_stop_queue(netdev);
+	if (netdev->phydev)
+		phy_stop(netdev->phydev);
+	ret = lan865x_hw_disable(priv);
+	if (ret) {
+		if (netif_msg_ifup(priv))
+			netdev_err(netdev, "Failed to disable the hardware\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lan865x_hw_enable(struct lan865x_priv *priv)
+{
+	u32 regval;
+
+	if (oa_tc6_read_register(priv->tc6, LAN865X_MAC_NCR, &regval))
+		return -ENODEV;
+
+	regval |= LAN865X_TXEN | LAN865X_RXEN;
+
+	if (oa_tc6_write_register(priv->tc6, LAN865X_MAC_NCR, regval))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int lan865x_net_open(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+
+	if (lan865x_hw_enable(priv) != 0) {
+		if (netif_msg_ifup(priv))
+			netdev_err(netdev, "Failed to enable hardware\n");
+		return -ENODEV;
+	}
+	phy_start(netdev->phydev);
+	netif_start_queue(netdev);
+
+	return 0;
+}
+
+static const struct net_device_ops lan865x_netdev_ops = {
+	.ndo_open		= lan865x_net_open,
+	.ndo_stop		= lan865x_net_close,
+	.ndo_start_xmit		= lan865x_send_packet,
+	.ndo_set_rx_mode	= lan865x_set_multicast_list,
+	.ndo_set_mac_address	= lan865x_set_mac_address,
+	.ndo_tx_timeout		= lan865x_tx_timeout,
+	.ndo_validate_addr	= eth_validate_addr,
+};
+
+/* Configures the number of bytes allocated to each buffer in the
+ * transmit/receive queue. LAN865x supports only 64 and 32 bytes cps and also 64
+ * is the default value. So it is enough to configure the queue buffer size only
+ * for 32 bytes. Generally cps can't be changed during run time and also it is
+ * configured in the device tree. The values for the Tx/Rx queue buffer size are
+ * taken from the LAN865x datasheet.
+ */
+static int lan865x_config_cps_buf(void *tc6, u32 cps)
+{
+	u32 regval;
+	int ret;
+
+	if (cps == 32) {
+		ret = oa_tc6_read_register(tc6, LAN865X_QTXCFG, &regval);
+		if (ret)
+			return ret;
+
+		regval &= ~LAN865X_BUFSZ;
+		regval |= FIELD_PREP(LAN865X_BUFSZ, 0x0);
+
+		ret = oa_tc6_write_register(tc6, LAN865X_QTXCFG, regval);
+		if (ret)
+			return ret;
+
+		ret = oa_tc6_read_register(tc6, LAN865X_QRXCFG, &regval);
+		if (ret)
+			return ret;
+
+		regval &= ~LAN865X_BUFSZ;
+		regval |= FIELD_PREP(LAN865X_BUFSZ, 0x0);
+
+		ret = oa_tc6_write_register(tc6, LAN865X_QRXCFG, regval);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int lan865x_probe(struct spi_device *spi)
+{
+	struct net_device *netdev;
+	struct lan865x_priv *priv;
+	int ret;
+
+	netdev = alloc_etherdev(sizeof(struct lan865x_priv));
+	if (!netdev)
+		return -ENOMEM;
+
+	priv = netdev_priv(netdev);
+	priv->netdev = netdev;
+	priv->spi = spi;
+	priv->msg_enable = 0;
+	spi_set_drvdata(spi, priv);
+
+	priv->tc6 = oa_tc6_init(spi, netdev, lan865x_config_cps_buf);
+	if (!priv->tc6) {
+		ret = -ENODEV;
+		goto err_oa_tc6_init;
+	}
+	if (device_get_ethdev_address(&spi->dev, netdev))
+		eth_hw_addr_random(netdev);
+
+	ret = lan865x_set_hw_macaddr(netdev);
+	if (ret) {
+		if (netif_msg_probe(priv))
+			dev_err(&spi->dev, "Failed to configure MAC");
+		goto err_config;
+	}
+
+	netdev->if_port = IF_PORT_10BASET;
+	netdev->irq = spi->irq;
+	netdev->netdev_ops = &lan865x_netdev_ops;
+	netdev->watchdog_timeo = TX_TIMEOUT;
+	netdev->ethtool_ops = &lan865x_ethtool_ops;
+	ret = register_netdev(netdev);
+	if (ret) {
+		if (netif_msg_probe(priv))
+			dev_err(&spi->dev, "Register netdev failed (ret = %d)",
+				ret);
+		goto err_config;
+	}
+
+	return 0;
+
+err_config:
+	oa_tc6_exit(priv->tc6);
+err_oa_tc6_init:
+	free_netdev(priv->netdev);
+	return ret;
+}
+
+static void lan865x_remove(struct spi_device *spi)
+{
+	struct lan865x_priv *priv = spi_get_drvdata(spi);
+
+	oa_tc6_exit(priv->tc6);
+	unregister_netdev(priv->netdev);
+	free_netdev(priv->netdev);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id lan865x_dt_ids[] = {
+	{ .compatible = "microchip,lan865x" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, lan865x_dt_ids);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id lan865x_acpi_ids[] = {
+	{ .id = "LAN865X",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, lan865x_acpi_ids);
+#endif
+
+static struct spi_driver lan865x_driver = {
+	.driver = {
+		.name = DRV_NAME,
+#ifdef CONFIG_OF
+		.of_match_table = lan865x_dt_ids,
+#endif
+#ifdef CONFIG_ACPI
+		   .acpi_match_table = ACPI_PTR(lan865x_acpi_ids),
+#endif
+	 },
+	.probe = lan865x_probe,
+	.remove = lan865x_remove,
+};
+module_spi_driver(lan865x_driver);
+
+MODULE_DESCRIPTION(DRV_NAME " 10Base-T1S MACPHY Ethernet Driver");
+MODULE_AUTHOR("Parthiban Veerasooran <parthiban.veerasooran@microchip.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("spi:" DRV_NAME);
-- 
2.34.1

