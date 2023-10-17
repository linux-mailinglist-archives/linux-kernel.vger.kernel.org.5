Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C0B7CBFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbjJQJnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjJQJng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:43:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2249898;
        Tue, 17 Oct 2023 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697535814; x=1729071814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wcv8pqAO8OQ374H9lFZSKzVI0+s+4AB7n4Yk/ovWK/o=;
  b=xSzrZ1EEnPEaVi6gaU2fMagY/Yd+K17c0BiKF/uPaJDsNhKrL8bcSeDx
   u/+fyjd+GOnhLSiwQ/mcHrFk39UdDr3kFP9W1ziOsQk+0r73zi3OgZkkW
   ufAMUmt+AOfPiUINq0JxbHzVq/rJw0hzFU2itKgikSFpfKUjXkKb76pZ9
   mhIa+ftghA+XhH+aMZlMt83ytfIERlSVDBsAx+zeabpTmRAy0mw6T3Te+
   pxnVszkAWGxXm7AZIE1s5iVsoFhseFsGQdhOcT8/dY7pAHAIl3osEFDMC
   IqHPs1PxlbN3OytuZ0PPUwHteAVGiNdPF0Hp6wu55S3pHB8bs0xgdESko
   w==;
X-CSE-ConnectionGUID: Ak13SLc/QnG3Q9MHCoEDCQ==
X-CSE-MsgGUID: lWNk6O2dTryOt8xpSCQxgg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="10624545"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2023 02:43:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 17 Oct 2023 02:43:29 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 17 Oct 2023 02:43:26 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <Bryan.Whitehead@microchip.com>, <linux-kernel@vger.kernel.org>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V1 3/7] net: lan743x: Add SFP support check flag
Date:   Tue, 17 Oct 2023 15:12:04 +0530
Message-ID: <20231017094208.4956-4-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017094208.4956-1-Raju.Lakkaraju@microchip.com>
References: <20231017094208.4956-1-Raju.Lakkaraju@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI11x1x chip support the Pluggable module (SFP) depend on Board requirement.
sfp support information programmed in eeprom.
Flag "is_sfp_support_en" update on "STRAP" register.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 27 ++++++++++++++++---
 drivers/net/ethernet/microchip/lan743x_main.h |  3 +++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index e47f0ae1770d..eee3fe7e0c66 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -25,7 +25,7 @@
 #define PCS_POWER_STATE_DOWN	0x6
 #define PCS_POWER_STATE_UP	0x4
 
-static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
+static int pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 {
 	u32 chip_rev;
 	u32 cfg_load;
@@ -38,7 +38,7 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 	if (ret < 0) {
 		netif_err(adapter, drv, adapter->netdev,
 			  "Sys Lock acquire failed ret:%d\n", ret);
-		return;
+		return ret;
 	}
 
 	cfg_load = lan743x_csr_read(adapter, ETH_SYS_CONFIG_LOAD_STARTED_REG);
@@ -52,6 +52,11 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 			adapter->is_sgmii_en = true;
 		else
 			adapter->is_sgmii_en = false;
+
+		if ((strap & STRAP_SFP_USE_EN_) && (strap & STRAP_SFP_EN_))
+			adapter->is_sfp_support_en = true;
+		else
+			adapter->is_sfp_support_en = false;
 	} else {
 		chip_rev = lan743x_csr_read(adapter, FPGA_REV);
 		if (chip_rev) {
@@ -63,8 +68,21 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 			adapter->is_sgmii_en = false;
 		}
 	}
+
+	if (adapter->is_pci11x1x && !adapter->is_sgmii_en &&
+	    adapter->is_sfp_support_en) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "Invalid eeprom sgmii support configuration\n");
+		return -EINVAL;
+	}
+
 	netif_dbg(adapter, drv, adapter->netdev,
 		  "SGMII I/F %sable\n", adapter->is_sgmii_en ? "En" : "Dis");
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "SFP support %sable\n", adapter->is_sfp_support_en ?
+		  "En" : "Dis");
+
+	return 0;
 }
 
 static bool is_pci11x1x_chip(struct lan743x_adapter *adapter)
@@ -3259,7 +3277,9 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 		adapter->max_tx_channels = PCI11X1X_MAX_TX_CHANNELS;
 		adapter->used_tx_channels = PCI11X1X_USED_TX_CHANNELS;
 		adapter->max_vector_count = PCI11X1X_MAX_VECTOR_COUNT;
-		pci11x1x_strap_get_status(adapter);
+		ret = pci11x1x_strap_get_status(adapter);
+		if (ret < 0)
+			return ret;
 		spin_lock_init(&adapter->eth_syslock_spinlock);
 		mutex_init(&adapter->sgmii_rw_lock);
 	} else {
@@ -3414,6 +3434,7 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 			      NETIF_MSG_LINK | NETIF_MSG_IFUP |
 			      NETIF_MSG_IFDOWN | NETIF_MSG_TX_QUEUED;
 	netdev->max_mtu = LAN743X_MAX_FRAME_SIZE;
+	adapter->is_sfp_support_en = false;
 
 	of_get_mac_address(pdev->dev.of_node, adapter->mac_address);
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 52609fc13ad9..6a3a45b98140 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -34,6 +34,8 @@
 
 #define STRAP_READ			(0x0C)
 #define STRAP_READ_USE_SGMII_EN_	BIT(22)
+#define STRAP_SFP_USE_EN_		BIT(31)
+#define STRAP_SFP_EN_			BIT(15)
 #define STRAP_READ_SGMII_EN_		BIT(6)
 #define STRAP_READ_SGMII_REFCLK_	BIT(5)
 #define STRAP_READ_SGMII_2_5G_		BIT(4)
@@ -1038,6 +1040,7 @@ struct lan743x_adapter {
 	u8			max_tx_channels;
 	u8			used_tx_channels;
 	u8			max_vector_count;
+	bool			is_sfp_support_en;
 
 #define LAN743X_ADAPTER_FLAG_OTP		BIT(0)
 	u32			flags;
-- 
2.34.1

