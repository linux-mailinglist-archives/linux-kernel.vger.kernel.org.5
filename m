Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A317CBFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343520AbjJQJnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbjJQJnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:43:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B23A2;
        Tue, 17 Oct 2023 02:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697535813; x=1729071813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tSyrbWwaQ4drESiuwSP8VD13GCIFaDSfA2bI/Vj9s8E=;
  b=z6nR2MO0QBmVX+gCeum14cBtrwxMLMspRGDdMFM7nVNzV4vVXz5Mlkzq
   J1Z8PbA4ScqzMmfFhJOKkhNWaN8rDTVikdRR298Q/fOaq+JDMaf5PWep3
   720ZteN1j54n4Bg+Eja7Q9SgZ8NS3+1l+GrNgKQSxG2d6LyXLmPBikII7
   bgL+0jmtFVjK4a8N4iBM44BUKT03FCX4FtZDRiNIugqzuY7PLl2OaSzuq
   P9mu2Cd+BOIXju9Zp5EAx8pme2IZ4F0pYxDQ3iJpAM7sZVdhc+ch86DNm
   HF6jRtSsYxl0MmOm3Of6GTTei45T5rSHzBBR2uunhrAV7rgVoScbU8xqC
   A==;
X-CSE-ConnectionGUID: Ak13SLc/QnG3Q9MHCoEDCQ==
X-CSE-MsgGUID: iOI+Qxd3TVSe4uHCOyMzkg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="10624544"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2023 02:43:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 17 Oct 2023 02:43:25 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 17 Oct 2023 02:43:22 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <Bryan.Whitehead@microchip.com>, <linux-kernel@vger.kernel.org>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V1 2/7] net: lan743x: Create separate Link Speed Duplex state function
Date:   Tue, 17 Oct 2023 15:12:03 +0530
Message-ID: <20231017094208.4956-3-Raju.Lakkaraju@microchip.com>
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

Create separate Link Speed Duplex (LSD) update state function from
lan743x_sgmii_config () to use as subroutine.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 75 +++++++++++--------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 1432032b795b..e47f0ae1770d 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -990,6 +990,42 @@ static int lan743x_sgmii_write(struct lan743x_adapter *adapter,
 	return ret;
 }
 
+static int lan743x_get_lsd(int speed, int duplex, u8 mss)
+{
+	enum lan743x_sgmii_lsd lsd = POWER_DOWN;
+
+	switch (speed) {
+	case SPEED_2500:
+		if (mss == MASTER_SLAVE_STATE_SLAVE)
+			lsd = LINK_2500_SLAVE;
+		else
+			lsd = LINK_2500_MASTER;
+		break;
+	case SPEED_1000:
+		if (mss == MASTER_SLAVE_STATE_SLAVE)
+			lsd = LINK_1000_SLAVE;
+		else
+			lsd = LINK_1000_MASTER;
+		break;
+	case SPEED_100:
+		if (duplex == DUPLEX_FULL)
+			lsd = LINK_100FD;
+		else
+			lsd = LINK_100HD;
+		break;
+	case SPEED_10:
+		if (duplex == DUPLEX_FULL)
+			lsd = LINK_10FD;
+		else
+			lsd = LINK_10HD;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return lsd;
+}
+
 static int lan743x_sgmii_mpll_set(struct lan743x_adapter *adapter,
 				  u16 baud)
 {
@@ -1177,42 +1213,21 @@ static int lan743x_sgmii_config(struct lan743x_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct phy_device *phydev = netdev->phydev;
-	enum lan743x_sgmii_lsd lsd = POWER_DOWN;
 	bool status;
 	int ret;
 
-	switch (phydev->speed) {
-	case SPEED_2500:
-		if (phydev->master_slave_state == MASTER_SLAVE_STATE_MASTER)
-			lsd = LINK_2500_MASTER;
-		else
-			lsd = LINK_2500_SLAVE;
-		break;
-	case SPEED_1000:
-		if (phydev->master_slave_state == MASTER_SLAVE_STATE_MASTER)
-			lsd = LINK_1000_MASTER;
-		else
-			lsd = LINK_1000_SLAVE;
-		break;
-	case SPEED_100:
-		if (phydev->duplex)
-			lsd = LINK_100FD;
-		else
-			lsd = LINK_100HD;
-		break;
-	case SPEED_10:
-		if (phydev->duplex)
-			lsd = LINK_10FD;
-		else
-			lsd = LINK_10HD;
-		break;
-	default:
+	ret = lan743x_get_lsd(phydev->speed, phydev->duplex,
+			      phydev->master_slave_state);
+	if (ret < 0) {
 		netif_err(adapter, drv, adapter->netdev,
-			  "Invalid speed %d\n", phydev->speed);
-		return -EINVAL;
+			  "error %d link-speed-duplex(LSD) invalid\n", ret);
+		return ret;
 	}
 
-	adapter->sgmii_lsd = lsd;
+	adapter->sgmii_lsd = ret;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "Link Speed Duplex (lsd) : 0x%X\n", adapter->sgmii_lsd);
+
 	ret = lan743x_sgmii_aneg_update(adapter);
 	if (ret < 0) {
 		netif_err(adapter, drv, adapter->netdev,
-- 
2.34.1

