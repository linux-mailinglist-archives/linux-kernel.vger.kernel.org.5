Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812B17CBFBC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjJQJni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjJQJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:43:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A638E;
        Tue, 17 Oct 2023 02:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697535813; x=1729071813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+X2kCoRy+dl1KBYTHqUJu0TAPbBI+uMaaA3lR14/a70=;
  b=HA/lxa3y5oHvZM7oyJ8+h0C9PBPgOOvhq6eK2K5VuueaAdNveBW8Y4yR
   QM72vEIcII2zUMyvj8gOyQaROF1aBJOZEk9n3dNJoMJZwF/UsDIybrM3i
   4Roe5Baa1onHzoAC47BI2UcwNVLkMJVweeST6itDhNhlL70PXj2FJVbmU
   Y3HKX2YuUOW3vPhXZCvFk8ilnQ+NTvd3OKYkhwlMO73bLZt6Qq02591Yt
   pnvOd3I0UD5OhiAjg9Jvspd3C8VaL6As03JV3osvVUFADWuDEh8tYZiQ4
   pP6RHr916Do9oxXfRh0sCmVMEdMuR5P412+lHlT2ipuL+DOToO6LHSsfL
   Q==;
X-CSE-ConnectionGUID: Ak13SLc/QnG3Q9MHCoEDCQ==
X-CSE-MsgGUID: OSvluaMUQGCwa+04zUm8bw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="10624543"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2023 02:43:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 17 Oct 2023 02:43:22 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 17 Oct 2023 02:43:19 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <Bryan.Whitehead@microchip.com>, <linux-kernel@vger.kernel.org>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V1 1/7] net: lan743x: Create separate PCS power reset function
Date:   Tue, 17 Oct 2023 15:12:02 +0530
Message-ID: <20231017094208.4956-2-Raju.Lakkaraju@microchip.com>
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

Create separate PCS power reset function from lan743x_sgmii_config () to use
as subroutine.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 55 ++++++++++---------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index f940895b14e8..1432032b795b 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1145,12 +1145,39 @@ static int lan743x_pcs_seq_state(struct lan743x_adapter *adapter, u8 state)
 	return 0;
 }
 
+static int lan743x_pcs_power_reset(struct lan743x_adapter *adapter)
+{
+	int mii_ctl;
+	int ret;
+
+	/* SGMII/1000/2500BASE-X PCS power down */
+	mii_ctl = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2, MII_BMCR);
+	if (mii_ctl < 0)
+		return mii_ctl;
+
+	mii_ctl |= BMCR_PDOWN;
+	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR, mii_ctl);
+	if (ret < 0)
+		return ret;
+
+	ret = lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_DOWN);
+	if (ret < 0)
+		return ret;
+
+	/* SGMII/1000/2500BASE-X PCS power up */
+	mii_ctl &= ~BMCR_PDOWN;
+	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR, mii_ctl);
+	if (ret < 0)
+		return ret;
+
+	return lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_UP);
+}
+
 static int lan743x_sgmii_config(struct lan743x_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct phy_device *phydev = netdev->phydev;
 	enum lan743x_sgmii_lsd lsd = POWER_DOWN;
-	int mii_ctl;
 	bool status;
 	int ret;
 
@@ -1207,31 +1234,7 @@ static int lan743x_sgmii_config(struct lan743x_adapter *adapter)
 		netif_dbg(adapter, drv, adapter->netdev,
 			  "SGMII 1G mode enable\n");
 
-	/* SGMII/1000/2500BASE-X PCS power down */
-	mii_ctl = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2, MII_BMCR);
-	if (mii_ctl < 0)
-		return mii_ctl;
-
-	mii_ctl |= BMCR_PDOWN;
-	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR, mii_ctl);
-	if (ret < 0)
-		return ret;
-
-	ret = lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_DOWN);
-	if (ret < 0)
-		return ret;
-
-	/* SGMII/1000/2500BASE-X PCS power up */
-	mii_ctl &= ~BMCR_PDOWN;
-	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR, mii_ctl);
-	if (ret < 0)
-		return ret;
-
-	ret = lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_UP);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return lan743x_pcs_power_reset(adapter);
 }
 
 static void lan743x_mac_set_address(struct lan743x_adapter *adapter,
-- 
2.34.1

