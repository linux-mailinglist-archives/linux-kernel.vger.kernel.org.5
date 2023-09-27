Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498737B058C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjI0Ndr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjI0Ndm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:33:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF3B11D;
        Wed, 27 Sep 2023 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695821620; x=1727357620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dtL29E/BwrOaZOSvMgF27vlanWODXVxmTDllXA3PIbI=;
  b=gVLZqqb+mxIppnp7WIKIssI8LG+2KPE1BPhGVGouTinIVtd9TGXFdOus
   gseFM7SfbvST70aKlPY1mJ/D6yJJD5x8cQBz4vf2nRHfPBmKdC6D2PPYk
   z1spuDvuDHPEeQtgVzQaDxKaEWFwDkLI4uNxWf2JJexIVktrvc3piKHRH
   cdEnmZjA21UViRdemlSHhB97CX4LTDXgxgtM1lZACZohGyTk68mPPaKGi
   b/f8a8fyO5fVrgo7RAmmeUQbiThwosiPRo0iC7Hv1scXCjcHLnefpF0AE
   KyZoDIFuVcpDrE4uTgPrSX4v2fSsj/lbF7FP8PlQda38qMf3XP7sQp/Gu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="380700777"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="380700777"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:09:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="698867015"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="698867015"
Received: from pglc00352.png.intel.com ([10.221.235.155])
  by orsmga003.jf.intel.com with ESMTP; 27 Sep 2023 06:09:38 -0700
From:   Rohan G Thomas <rohan.g.thomas@intel.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next 2/2] net: stmmac: TBS support for platform driver
Date:   Wed, 27 Sep 2023 21:09:19 +0800
Message-Id: <20230927130919.25683-3-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230927130919.25683-1-rohan.g.thomas@intel.com>
References: <20230927130919.25683-1-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Time Based Scheduling(TBS) support for Tx queues through the
stmmac platform driver. For this a new per-queue tx-config property,
tbs-enabled is added to the devicetree.

Commit 7eadf57290ec ("net: stmmac: pci: Enable TBS on GMAC5 IPK PCI
entry") enables similar support for the stmmac pci driver.

Also add check whether TBS support is available for a Tx DMA channel
before enabling TBS support for that Tx DMA channel.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 +++++++++++++++----
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  4 +++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 81b6f3ecdf92..7333f0640b3d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3773,12 +3773,18 @@ stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
 		dma_conf->dma_rx_size = DMA_DEFAULT_RX_SIZE;
 
 	/* Earlier check for TBS */
-	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++) {
-		struct stmmac_tx_queue *tx_q = &dma_conf->tx_queue[chan];
-		int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;
+	if (priv->dma_cap.tbssel) {
+		/* TBS is available only for tbs_ch_num of Tx DMA channels,
+		 * starting from the highest Tx DMA channel.
+		 */
+		chan = priv->dma_cap.number_tx_channel - priv->dma_cap.tbs_ch_num;
+		for (; chan < priv->plat->tx_queues_to_use; chan++) {
+			struct stmmac_tx_queue *tx_q = &dma_conf->tx_queue[chan];
+			int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;
 
-		/* Setup per-TXQ tbs flag before TX descriptor alloc */
-		tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
+			/* Setup per-TXQ tbs flag before TX descriptor alloc */
+			tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
+		}
 	}
 
 	ret = alloc_dma_desc_resources(priv, dma_conf);
@@ -7505,6 +7511,15 @@ int stmmac_dvr_probe(struct device *device,
 		}
 	}
 
+	/* If TBS feature is supported(i.e. tbssel is true), then at least 1 Tx
+	 * DMA channel supports TBS. So if tbs_ch_num is 0 and tbssel is true,
+	 * assume all Tx DMA channels support TBS. TBS_CH field, which gives
+	 * number of Tx DMA channels with TBS support is only available only for
+	 * DW xGMAC IP. For other DWMAC IPs all Tx DMA channels can support TBS.
+	 */
+	if (priv->dma_cap.tbssel && !priv->dma_cap.tbs_ch_num)
+		priv->dma_cap.tbs_ch_num = priv->dma_cap.number_tx_channel;
+
 	ndev->features |= ndev->hw_features | NETIF_F_HIGHDMA;
 	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
 #ifdef STMMAC_VLAN_TAG_USED
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 843bd8804bfa..6c0191c84071 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -279,6 +279,10 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 		plat->tx_queues_cfg[queue].coe_unsupported =
 			of_property_read_bool(q_node, "snps,coe-unsupported");
 
+		/* Select TBS for supported queues */
+		plat->tx_queues_cfg[queue].tbs_en =
+			of_property_read_bool(q_node, "snps,tbs-enabled");
+
 		queue++;
 	}
 	if (queue != plat->tx_queues_to_use) {
-- 
2.26.2

