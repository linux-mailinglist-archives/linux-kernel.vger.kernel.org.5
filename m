Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4C77D06DA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346888AbjJTD24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbjJTD2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:28:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245B3D4C;
        Thu, 19 Oct 2023 20:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697772530; x=1729308530;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=96Gky6mpZZHpzgNi964Tps4EK4L+Pft4fZHmTBB7PZs=;
  b=SZ5pGjCx+5SdJ/o0PCwaYnm8gfySxrz1JJNucTi/XSx7Q7L8Li+9ByK8
   bL/+tCdVU/JYrJ0Hwi77jDyHwYqrCgpKgDoJoZJT4ftxZh7sgJYZmZbjg
   ecIHF5aWZyP0KoS4SpkVZ8kIYoQwIbFXoa3rHig4LErYH5BgYNCiV40e0
   Bvr/TGa6t//NmZlCAVOqgWzbqA5OqJcwpGoH+RY/UNC2jVgUopVQrDL9R
   SaqJgQX+P7+45khGHwHnLIMcENTJU5BQgzxpDlhGuvAVW3NO4IWg8Bz76
   9pW95xj36WGtZoOY3QSzpX0A6NRmG37tu/zYmKzQGaNcM0yqL4Kht0bXH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472645905"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="472645905"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 20:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="827592040"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="827592040"
Received: from ssid-ilbpg3-teeminta.png.intel.com ([10.88.227.74])
  by fmsmga004.fm.intel.com with ESMTP; 19 Oct 2023 20:28:45 -0700
From:   Gan Yi Fang <yi.fang.gan@intel.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>,
        Gan Yi Fang <yi.fang.gan@intel.com>
Subject: [PATCH net v2 1/1] net: stmmac: update MAC capabilities when tx queues are updated
Date:   Fri, 20 Oct 2023 11:25:35 +0800
Message-Id: <20231020032535.1777746-1-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>

Upon boot up, the driver will configure the MAC capabilities based on
the maximum number of tx and rx queues. When the user changes the
tx queues to single queue, the MAC should be capable of supporting Half
Duplex, but the driver does not update the MAC capabilities when it is
configured so.

Using the stmmac_reinit_queues() to check the number of tx queues
and set the MAC capabilities accordingly.

Fixes: 0366f7e06a6b ("net: stmmac: add ethtool support for get/set channels")
Cc: <stable@vger.kernel.org> # 5.17+
Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c   | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ed1a5a31a491..5801f4d50f95 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1197,6 +1197,17 @@ static int stmmac_init_phy(struct net_device *dev)
 	return ret;
 }
 
+static void stmmac_set_half_duplex(struct stmmac_priv *priv)
+{
+	/* Half-Duplex can only work with single tx queue */
+	if (priv->plat->tx_queues_to_use > 1)
+		priv->phylink_config.mac_capabilities &=
+			~(MAC_10HD | MAC_100HD | MAC_1000HD);
+	else
+		priv->phylink_config.mac_capabilities |=
+			(MAC_10HD | MAC_100HD | MAC_1000HD);
+}
+
 static int stmmac_phy_setup(struct stmmac_priv *priv)
 {
 	struct stmmac_mdio_bus_data *mdio_bus_data;
@@ -1228,10 +1239,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 						MAC_10FD | MAC_100FD |
 						MAC_1000FD;
 
-	/* Half-Duplex can only work with single queue */
-	if (priv->plat->tx_queues_to_use <= 1)
-		priv->phylink_config.mac_capabilities |= MAC_10HD | MAC_100HD |
-							 MAC_1000HD;
+	stmmac_set_half_duplex(priv);
 
 	/* Get the MAC specific capabilities */
 	stmmac_mac_phylink_get_caps(priv);
@@ -7172,6 +7180,7 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
 			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
 									rx_cnt);
 
+	stmmac_set_half_duplex(priv);
 	stmmac_napi_add(dev);
 
 	if (netif_running(dev))
-- 
2.34.1

