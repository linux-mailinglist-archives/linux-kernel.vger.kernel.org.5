Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBE175BE21
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGUGB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjGUGBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:01:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9CA30FD;
        Thu, 20 Jul 2023 23:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689919255; x=1721455255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IJ4zMep/FrHtkrZh2iWP+xN+ImKeKg5u57KkhqSuw2I=;
  b=Nm/P8HjBZXokHMFAI7c4C/nHvrpR4wwyamp+axblIUMlYUjBaRcsUYEr
   IgbWZMhQGkmevxK/aCBhsXySycw4Y8WPNWa9lpkiCPbIxGeV2fAPGqoaE
   UIWeN0aHlbhwjw6H1lWoNul2WBNT2yC/oaubG+0JkFRY8cdd3q53X9RIE
   bo2s1RTwKvweaylpa/iKC1OWaDfkJDPrL8+3joDCvWL52wi59n5bnj1RZ
   qm5T0RxkycpSFgUBYfZ8JSAKvQFy6mEumLCgWkIgJJg/kLyvEHd/sMNHk
   w06K+BOIAiav/kk2Av01MuxoxNVI6ZGrBhwGSvdLO+3oUKmBmO9NIWCpl
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="236881402"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 23:00:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 23:00:54 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 20 Jul 2023 23:00:51 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bryan.whitehead@microchip.com>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next 6/7] net: lan743x: Add support to ethtool phylink get and set settings
Date:   Fri, 21 Jul 2023 11:30:18 +0530
Message-ID: <20230721060019.2737-7-Raju.Lakkaraju@microchip.com>
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

Add support to ethtool phylink get/set settings for the network interface via
ethtool like speed, duplex etc.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 .../net/ethernet/microchip/lan743x_ethtool.c  | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 2db5949b4c7e..3004863bebf8 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1134,6 +1134,36 @@ static int lan743x_ethtool_set_eee(struct net_device *netdev,
 	return phy_ethtool_set_eee(phydev, eee);
 }
 
+static int lan743x_ethtool_set_link_ksettings(struct net_device *netdev,
+					      const struct ethtool_link_ksettings *cmd)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	int ret;
+
+	if (adapter->phylink) {
+		ret = lan743x_lsd_update(cmd->base.speed, cmd->base.duplex,
+					 cmd->base.master_slave_state);
+		if (ret < 0)
+			return ret;
+
+		adapter->sgmii_lsd = ret;
+		return phylink_ethtool_ksettings_set(adapter->phylink, cmd);
+	}
+
+	return phy_ethtool_set_link_ksettings(netdev, cmd);
+}
+
+static int lan743x_ethtool_get_link_ksettings(struct net_device *netdev,
+					      struct ethtool_link_ksettings *cmd)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
+	if (adapter->phylink)
+		return phylink_ethtool_ksettings_get(adapter->phylink, cmd);
+
+	return phy_ethtool_get_link_ksettings(netdev, cmd);
+}
+
 #ifdef CONFIG_PM
 static void lan743x_ethtool_get_wol(struct net_device *netdev,
 				    struct ethtool_wolinfo *wol)
@@ -1400,8 +1430,8 @@ const struct ethtool_ops lan743x_ethtool_ops = {
 	.get_ts_info = lan743x_ethtool_get_ts_info,
 	.get_eee = lan743x_ethtool_get_eee,
 	.set_eee = lan743x_ethtool_set_eee,
-	.get_link_ksettings = phy_ethtool_get_link_ksettings,
-	.set_link_ksettings = phy_ethtool_set_link_ksettings,
+	.get_link_ksettings = lan743x_ethtool_get_link_ksettings,
+	.set_link_ksettings = lan743x_ethtool_set_link_ksettings,
 	.get_regs_len = lan743x_get_regs_len,
 	.get_regs = lan743x_get_regs,
 	.get_pauseparam = lan743x_get_pauseparam,
-- 
2.25.1

