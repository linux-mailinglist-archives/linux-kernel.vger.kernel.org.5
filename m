Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E6275BE26
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGUGCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGUGBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:01:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8598E2D71;
        Thu, 20 Jul 2023 23:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689919266; x=1721455266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PDWlDkn/pWv4jXpv9tJcSNXd2XuUOWNjlBIyyKr9PC4=;
  b=tLxUIX5izNG03CH792s/eACXvt5lhEH+G7G6dfZrsbKmNRRKp18xyfM3
   k1px2UeXvOZU+utrxN0Hv4qDn75kJjb3HHMXNe7q2sV8/5cVgjx+LQWIL
   utJ0bcsNQMFB3l4AQvk9bRjSOkfkcpzSo6ypv95JTL+84A67xzwMyhyY9
   1wB6313MpSlGoiUWtfVuNyiIs20SSLqRBOfRN8zU4FJPzDo6PF3SBL3qS
   eCh7Z9w7Z+hbUJgrH0h65f0tQ6Mtd0cW1YIWmYsFBScVEgxw5L0d9z4RP
   rpaNhuwJflVEkqP8zydFq9CnQjcKWBn15wW+7uPw8f2uBhcEDUl7qtVH1
   A==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="236881439"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 23:00:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 23:00:57 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 20 Jul 2023 23:00:54 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bryan.whitehead@microchip.com>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next 7/7] net: lan743x: Register the platform device for sfp pluggable module
Date:   Fri, 21 Jul 2023 11:30:19 +0530
Message-ID: <20230721060019.2737-8-Raju.Lakkaraju@microchip.com>
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

Add support for SFP pluggable module as platform device handle the GPIO
input and output signals and i2c bus access the SFP EEPROM data.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 39 +++++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.h |  1 +
 2 files changed, 40 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 9b6326d035a8..2dd0965982fb 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -17,6 +17,7 @@
 #include <linux/crc16.h>
 #include <linux/gpio/machine.h>
 #include <linux/i2c.h>
+#include <linux/platform_device.h>
 #include "../../../misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h"
 #include "lan743x_main.h"
 #include "lan743x_ethtool.h"
@@ -3228,6 +3229,31 @@ static int lan743x_swnodes_register(struct lan743x_adapter *adapter)
 	return software_node_register_node_group(nodes->group);
 }
 
+static int lan743x_sfp_register(struct lan743x_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct platform_device_info sfp_info;
+	struct platform_device *sfp_dev;
+
+	memset(&sfp_info, 0, sizeof(sfp_info));
+	sfp_info.parent = &adapter->pdev->dev;
+	sfp_info.fwnode = software_node_fwnode(adapter->nodes->group[SWNODE_SFP]);
+	sfp_info.name = "sfp";
+	sfp_info.id = (pdev->bus->number << 8) | pdev->devfn;
+	sfp_dev = platform_device_register_full(&sfp_info);
+	if (IS_ERR(sfp_dev)) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "Failed to register SFP device\n");
+		return PTR_ERR(sfp_dev);
+	}
+
+	adapter->sfp_dev = sfp_dev;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "SFP platform device registered");
+
+	return 0;
+}
+
 static void lan743x_mac_cfg_update(struct lan743x_adapter *adapter, bool link,
 				   int speed, const unsigned long *advertise)
 {
@@ -3715,6 +3741,9 @@ static void lan743x_hardware_cleanup(struct lan743x_adapter *adapter)
 	if (adapter->phylink)
 		phylink_destroy(adapter->phylink);
 
+	if (adapter->sfp_dev)
+		platform_device_unregister(adapter->sfp_dev);
+
 	if (adapter->nodes)
 		software_node_unregister_node_group(adapter->nodes->group);
 
@@ -3942,6 +3971,16 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 	adapter->sgmii_lsd = LINK_2500_MASTER;
 
 	if (adapter->is_sfp_support_en) {
+		adapter->i2c_adap->dev.fwnode =
+			software_node_fwnode(adapter->nodes->group[SWNODE_I2C]);
+
+		ret = lan743x_sfp_register(adapter);
+		if (ret < 0) {
+			netif_err(adapter, probe, netdev,
+				  "failed to sfp register (%d)\n", ret);
+			goto cleanup_hardware;
+		}
+
 		ret = lan743x_phylink_create(adapter->netdev);
 		if (ret) {
 			netif_err(adapter, probe, netdev,
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 6b94d0e93cbb..d23cf1ca888c 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -1083,6 +1083,7 @@ struct lan743x_adapter {
 	struct i2c_adapter	*i2c_adap;
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
+	struct platform_device	*sfp_dev;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
-- 
2.25.1

