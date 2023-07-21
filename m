Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8665C75BE1E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGUGBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGUGAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:00:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F62719;
        Thu, 20 Jul 2023 23:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689919248; x=1721455248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hQq8jx/iDqfuUs5wo0Ef4tMhA1ko59EYgPsFu80mUf0=;
  b=Qf0qJA8lLBiAROJe4eOnyXtkyy2/yyYw2Li1mlEpEE6MZYgioncj1PWI
   udK2KKKZ4SwiYXM7Eag0a5trw0Qlm1K6HqQmQOy6GXKBhYtW+kYTyE3gO
   R9YYTdvUZrlT5IJojxcUw25+0KRCCPsGo8CNMpmJ9RaoJkrxkSNuu/dci
   r/R3L1Ai9q7yI5GacN78eMMeA/xNlfiw7Dt0v2XhoXeT8lQPzf/VzwfTo
   kg8UUHiKGh7B4VR+OfMcvMyoU1jpGICpRHfFKdJvqhg8GGaw9Wn9+LApj
   /7LXILaM/kzI1yrbb3yi0RdtZySkbQp9d0k0VtTU5zDLLzQIGrZBejRRC
   g==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="225102780"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 23:00:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 23:00:47 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 20 Jul 2023 23:00:44 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bryan.whitehead@microchip.com>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next 4/7] net: lan743x: Add support to software-nodes for SFP and PHYLINK
Date:   Fri, 21 Jul 2023 11:30:16 +0530
Message-ID: <20230721060019.2737-5-Raju.Lakkaraju@microchip.com>
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

Register software nodes and define the device properties.
software-node contains following properties.
  - GPIO pin details
  - I2C bus information
  - SFP signals
  - phylink modes

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/ethernet/microchip/Kconfig        |   2 +
 drivers/net/ethernet/microchip/lan743x_main.c | 214 +++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  31 +++
 3 files changed, 244 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 329e374b9539..b1d361b412d1 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -49,6 +49,8 @@ config LAN743X
 	select FIXED_PHY
 	select CRC16
 	select CRC32
+	select I2C_PCI1XXXX
+	select GP_PCI1XXXX
 	help
 	  Support for the Microchip LAN743x PCI Express Gigabit Ethernet chip
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 822576b088a9..aef64747a952 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -15,6 +15,9 @@
 #include <linux/rtnetlink.h>
 #include <linux/iopoll.h>
 #include <linux/crc16.h>
+#include <linux/gpio/machine.h>
+#include <linux/i2c.h>
+#include "../../../misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h"
 #include "lan743x_main.h"
 #include "lan743x_ethtool.h"
 
@@ -24,6 +27,30 @@
 #define MMD_ACCESS_READ_INC	3
 #define PCS_POWER_STATE_DOWN	0x6
 #define PCS_POWER_STATE_UP	0x4
+#define PCI1XXXX_VENDOR_ID	0x1055
+#define PCI1XXXX_BR_PERIF_ID	0xA00C
+#define PCI1XXXX_PERIF_I2C_ID	0xA003
+#define PCI1XXXX_PERIF_GPIO_ID	0xA005
+#define PCI1XXXX_DEV_MASK	GENMASK(7, 4)
+
+#define NODE_PROP(_NAME, _PROP)          \
+	((const struct software_node) {  \
+		.name = _NAME,           \
+		.properties = _PROP,     \
+	})
+
+struct pci1xxxx_i2c {
+	struct completion i2c_xfer_done;
+	bool i2c_xfer_in_progress;
+	struct i2c_adapter adap;
+	void __iomem *i2c_base;
+	u32 freq;
+	u32 flags;
+};
+
+struct aux_bus_device {
+	struct auxiliary_device_wrapper *aux_device_wrapper[2];
+};
 
 static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 {
@@ -96,6 +123,91 @@ static void lan743x_pci_cleanup(struct lan743x_adapter *adapter)
 	pci_disable_device(adapter->pdev);
 }
 
+static void *pci1xxxx_perif_drvdata_get(struct lan743x_adapter *adapter,
+					u16 perif_id)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct pci_bus *perif_bus;
+	struct pci_dev *perif_dev;
+	struct pci_dev *br_dev;
+	struct pci_bus *br_bus;
+	struct pci_dev *dev;
+
+	/* PCI11x1x devices' PCIe topology consists of a top level pcie
+	 * switch with up to four downstream ports, some of which have
+	 * integrated endpoints connected to them. One of the downstream ports
+	 * has an embedded single function pcie ethernet controller which is
+	 * handled by this driver. Another downstream port has an
+	 * embedded multifunction pcie endpoint, with four pcie functions
+	 * (the "peripheral controllers": I2C controller, GPIO controller,
+	 * UART controllers, SPIcontrollers)
+	 * The code below navigates the PCI11x1x topology
+	 * to find (by matching its PCI device ID) the peripheral controller
+	 * that should be paired to the embedded ethernet controller.
+	 */
+	br_dev = pci_upstream_bridge(pdev);
+	if (!br_dev) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "upstream bridge not found\n");
+		return br_dev;
+	}
+
+	br_bus = br_dev->bus;
+	list_for_each_entry(dev, &br_bus->devices, bus_list) {
+		if (dev->vendor == PCI1XXXX_VENDOR_ID &&
+		    (dev->device & ~PCI1XXXX_DEV_MASK) ==
+		     PCI1XXXX_BR_PERIF_ID) {
+			perif_bus = dev->subordinate;
+			list_for_each_entry(perif_dev, &perif_bus->devices,
+					    bus_list) {
+				if (perif_dev->vendor == PCI1XXXX_VENDOR_ID &&
+				    (perif_dev->device & ~PCI1XXXX_DEV_MASK) ==
+				     perif_id)
+					return pci_get_drvdata(perif_dev);
+			}
+		}
+	}
+
+	netif_err(adapter, drv, adapter->netdev,
+		  "pci1xxxx peripheral (0x%X) device not found\n", perif_id);
+
+	return NULL;
+}
+
+static int pci1xxxx_i2c_adapter_get(struct lan743x_adapter *adapter)
+{
+	struct pci1xxxx_i2c *i2c_drvdata;
+
+	i2c_drvdata = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_I2C_ID);
+	if (!i2c_drvdata)
+		return -EPROBE_DEFER;
+
+	adapter->i2c_adap = &i2c_drvdata->adap;
+	snprintf(adapter->nodes->i2c_name, sizeof(adapter->nodes->i2c_name),
+		 adapter->i2c_adap->name);
+	netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
+		  adapter->i2c_adap->name);
+
+	return 0;
+}
+
+static int pci1xxxx_gpio_dev_get(struct lan743x_adapter *adapter)
+{
+	struct aux_bus_device *aux_bus;
+	struct device *gpio_dev;
+
+	aux_bus = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_GPIO_ID);
+	if (!aux_bus)
+		return -EPROBE_DEFER;
+
+	gpio_dev = &aux_bus->aux_device_wrapper[1]->aux_dev.dev;
+	snprintf(adapter->nodes->gpio_name, sizeof(adapter->nodes->gpio_name),
+		 dev_name(gpio_dev));
+	netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
+		  adapter->nodes->gpio_name);
+	return 0;
+}
+
 static int lan743x_pci_init(struct lan743x_adapter *adapter,
 			    struct pci_dev *pdev)
 {
@@ -3030,6 +3142,85 @@ static int lan743x_rx_open(struct lan743x_rx *rx)
 	return ret;
 }
 
+static int lan743x_swnodes_register(struct lan743x_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct lan743x_sw_nodes *nodes;
+	struct software_node *swnodes;
+	int ret;
+	u32 id;
+
+	nodes = kzalloc(sizeof(*nodes), GFP_KERNEL);
+	if (!nodes)
+		return -ENOMEM;
+
+	adapter->nodes = nodes;
+
+	ret = pci1xxxx_gpio_dev_get(adapter);
+	if (ret < 0)
+		return ret;
+
+	ret = pci1xxxx_i2c_adapter_get(adapter);
+	if (ret < 0)
+		return ret;
+
+	id = (pdev->bus->number << 8) | pdev->devfn;
+	snprintf(nodes->sfp_name, sizeof(nodes->sfp_name),
+		 "sfp-%x", id);
+	snprintf(nodes->phylink_name, sizeof(nodes->phylink_name),
+		 "mchp-pci1xxxx-phylink-%x", id);
+
+	swnodes = nodes->swnodes;
+
+	nodes->gpio_props[0] = PROPERTY_ENTRY_STRING("pinctrl-names",
+						     "default");
+	swnodes[SWNODE_GPIO] = NODE_PROP(nodes->gpio_name, nodes->gpio_props);
+
+	nodes->tx_fault_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							 46, GPIO_ACTIVE_HIGH);
+	nodes->tx_disable_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							   47, GPIO_ACTIVE_HIGH);
+	nodes->mod_def0_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							 51, GPIO_ACTIVE_LOW);
+	nodes->los_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+						    49, GPIO_ACTIVE_HIGH);
+	nodes->rate_select0_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							     48, GPIO_ACTIVE_HIGH);
+
+	nodes->i2c_props[0] = PROPERTY_ENTRY_STRING("pinctrl-names", "default");
+	swnodes[SWNODE_I2C] = NODE_PROP(nodes->i2c_name, nodes->i2c_props);
+	nodes->i2c_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_I2C]);
+
+	nodes->sfp_props[0] = PROPERTY_ENTRY_STRING("compatible", "sff,sfp");
+	nodes->sfp_props[1] = PROPERTY_ENTRY_REF_ARRAY("i2c-bus",
+						       nodes->i2c_ref);
+	nodes->sfp_props[2] = PROPERTY_ENTRY_REF_ARRAY("tx-fault-gpios",
+						       nodes->tx_fault_ref);
+	nodes->sfp_props[3] = PROPERTY_ENTRY_REF_ARRAY("tx-disable-gpios",
+						       nodes->tx_disable_ref);
+	nodes->sfp_props[4] = PROPERTY_ENTRY_REF_ARRAY("mod-def0-gpios",
+						       nodes->mod_def0_ref);
+	nodes->sfp_props[5] = PROPERTY_ENTRY_REF_ARRAY("los-gpios",
+						       nodes->los_ref);
+	nodes->sfp_props[6] = PROPERTY_ENTRY_REF_ARRAY("rate-select0-gpios",
+						       nodes->rate_select0_ref);
+	swnodes[SWNODE_SFP] = NODE_PROP(nodes->sfp_name, nodes->sfp_props);
+	nodes->sfp_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_SFP]);
+	nodes->phylink_props[0] = PROPERTY_ENTRY_STRING("managed",
+							"in-band-status");
+	nodes->phylink_props[1] = PROPERTY_ENTRY_REF_ARRAY("sfp",
+							   nodes->sfp_ref);
+	swnodes[SWNODE_PHYLINK] = NODE_PROP(nodes->phylink_name,
+					    nodes->phylink_props);
+
+	nodes->group[SWNODE_GPIO] = &swnodes[SWNODE_GPIO];
+	nodes->group[SWNODE_I2C] = &swnodes[SWNODE_I2C];
+	nodes->group[SWNODE_SFP] = &swnodes[SWNODE_SFP];
+	nodes->group[SWNODE_PHYLINK] = &swnodes[SWNODE_PHYLINK];
+
+	return software_node_register_node_group(nodes->group);
+}
+
 static int lan743x_netdev_close(struct net_device *netdev)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
@@ -3233,6 +3424,14 @@ static const struct net_device_ops lan743x_netdev_ops = {
 
 static void lan743x_hardware_cleanup(struct lan743x_adapter *adapter)
 {
+	if (adapter->i2c_adap)
+		adapter->i2c_adap = NULL;
+
+	if (adapter->nodes)
+		software_node_unregister_node_group(adapter->nodes->group);
+
+	kfree(adapter->nodes);
+
 	lan743x_csr_write(adapter, INT_EN_CLR, 0xFFFFFFFF);
 }
 
@@ -3282,9 +3481,18 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 	if (ret)
 		return ret;
 
-	ret = lan743x_phy_init(adapter);
-	if (ret)
-		return ret;
+	if (adapter->is_sfp_support_en) {
+		ret = lan743x_swnodes_register(adapter);
+		if (ret) {
+			netdev_err(adapter->netdev,
+				   "failed to register software nodes\n");
+			return ret;
+		}
+	} else {
+		ret = lan743x_phy_init(adapter);
+		if (ret)
+			return ret;
+	}
 
 	ret = lan743x_ptp_init(adapter);
 	if (ret)
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 3889bb20a524..7f1c5673bc61 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -5,6 +5,7 @@
 #define _LAN743X_H
 
 #include <linux/phy.h>
+#include <linux/property.h>
 #include "lan743x_ptp.h"
 
 #define DRIVER_AUTHOR   "Bryan Whitehead <Bryan.Whitehead@microchip.com>"
@@ -1008,6 +1009,34 @@ enum lan743x_sgmii_lsd {
 	LINK_2500_SLAVE
 };
 
+enum lan743x_swnodes {
+	SWNODE_GPIO = 0,
+	SWNODE_I2C,
+	SWNODE_SFP,
+	SWNODE_PHYLINK,
+	SWNODE_MAX
+};
+
+struct lan743x_sw_nodes {
+	char gpio_name[32];
+	char i2c_name[48];
+	char sfp_name[32];
+	char phylink_name[32];
+	struct property_entry gpio_props[1];
+	struct property_entry i2c_props[1];
+	struct property_entry sfp_props[8];
+	struct property_entry phylink_props[2];
+	struct software_node_ref_args i2c_ref[1];
+	struct software_node_ref_args tx_fault_ref[1];
+	struct software_node_ref_args tx_disable_ref[1];
+	struct software_node_ref_args mod_def0_ref[1];
+	struct software_node_ref_args los_ref[1];
+	struct software_node_ref_args rate_select0_ref[1];
+	struct software_node_ref_args sfp_ref[1];
+	struct software_node swnodes[SWNODE_MAX];
+	const struct software_node *group[SWNODE_MAX + 1];
+};
+
 struct lan743x_adapter {
 	struct net_device       *netdev;
 	struct mii_bus		*mdiobus;
@@ -1046,6 +1075,8 @@ struct lan743x_adapter {
 	u32			flags;
 	u32			hw_cfg;
 	phy_interface_t		phy_interface;
+	struct lan743x_sw_nodes	*nodes;
+	struct i2c_adapter	*i2c_adap;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
-- 
2.25.1

