Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED7975BE1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGUGAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjGUGAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:00:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF30E62;
        Thu, 20 Jul 2023 23:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689919245; x=1721455245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pDx+xIc1pKw69N9rcGWkTVyLaxLMsH85HpuhblKYyE4=;
  b=p6MmXsC8fVtcYPzIIwpmdiHfoBu+92jb+l4ppVMeZXDcaiUkpiqLJaj+
   4nBkdcFewSTqQTb12vomUMXdP4DgkQ4khU2ILkHRrukHcZNguBFIO/wb5
   zran0cThTWzfWMPXzfxM9QWFqirtjmIC0cDeffHSjol4euM4Y3V0v5BkJ
   NBryNKvi5pIBXCwbjksUXC15gFtiDzwaV1O87DVSWwnKoXcgG7EQhYldz
   LhXXEBPPWg/yc1WPOOKy63aQyEYMeebpj3SSafXSc4XfJkTHzy4Qnb0mQ
   wDFBIO51U4q/dxFqHm1MpggRzIeDyn/ZXBc2DcwiNAsksHBW4W4/Dli/K
   A==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="225102735"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 23:00:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 23:00:43 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 20 Jul 2023 23:00:41 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bryan.whitehead@microchip.com>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next 3/7] net: lan743x: Add SFP support check flag
Date:   Fri, 21 Jul 2023 11:30:15 +0530
Message-ID: <20230721060019.2737-4-Raju.Lakkaraju@microchip.com>
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

PCI11x1x chip support the Pluggable module (SFP) depend on Board requirement.
SFP support information programmed in EEPROM.
Flag "is_sfp_support_en" update on "STRAP" register.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 10 ++++++++++
 drivers/net/ethernet/microchip/lan743x_main.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index e8dd272a591a..822576b088a9 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
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
@@ -63,8 +68,12 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 			adapter->is_sgmii_en = false;
 		}
 	}
+
 	netif_dbg(adapter, drv, adapter->netdev,
 		  "SGMII I/F %sable\n", adapter->is_sgmii_en ? "En" : "Dis");
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "SFP support %sable\n", adapter->is_sfp_support_en ?
+		  "En" : "Dis");
 }
 
 static bool is_pci11x1x_chip(struct lan743x_adapter *adapter)
@@ -3408,6 +3417,7 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 			      NETIF_MSG_LINK | NETIF_MSG_IFUP |
 			      NETIF_MSG_IFDOWN | NETIF_MSG_TX_QUEUED;
 	netdev->max_mtu = LAN743X_MAX_FRAME_SIZE;
+	adapter->is_sfp_support_en = false;
 
 	of_get_mac_address(pdev->dev.of_node, adapter->mac_address);
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 0cd3fe71dfad..3889bb20a524 100644
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
2.25.1

