Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394D77816B5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 04:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbjHSCcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 22:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244079AbjHSCcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:32:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883A44220;
        Fri, 18 Aug 2023 19:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692412331; x=1723948331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LEjADStVhAAijpcwNiIM9Zhi3t+hw0nFfACu76UjFKk=;
  b=FGxWCbqpArvYTnYQHdG+uPBfmp/iBAsrXW3RwdNe0O2sLDEQu8ypZ1Im
   Lan4vHUuNtdNRudpb+I89iraSc9OzD7PbkWlcHnz4mEg/aKx6tGyRY0/2
   mADp5qYWFNSZVHbM0LgwNgpxSBm545WiYIgEf40BMfo1dEn5xjWODOAwT
   cE7SbWW350UgHulTsuzF12jjg7JoIfbHUoxLOknKIhbgNRtj50LSfOJiw
   gs92Q4pgc+cF7gCDVxmBNb/QLGnoX/yOFShezq/bJY9akdQqe3MT80HQQ
   jKvVHUeQrm88/kxYl3tfjshylXy/cgayVstJWWP4MBqgbTtRvWuhZPTAT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="439629473"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="439629473"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 19:31:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="800660811"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="800660811"
Received: from pglc00067.png.intel.com ([10.221.207.87])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2023 19:31:49 -0700
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
Subject: [PATCH net-next v5 2/2] net: stmmac: Tx coe sw fallback
Date:   Sat, 19 Aug 2023 10:31:32 +0800
Message-Id: <20230819023132.23082-3-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230819023132.23082-1-rohan.g.thomas@intel.com>
References: <20230819023132.23082-1-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sw fallback of tx checksum calculation for those tx queues that
don't support tx checksum offloading. Because, some DWMAC IPs support
tx checksum offloading only for a few initial tx queues, starting
from tx queue 0.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c  |  4 ++++
 include/linux/stmmac.h                         |  1 +
 3 files changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 733b5e900817..3ffef45a2861 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4409,6 +4409,16 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	WARN_ON(tx_q->tx_skbuff[first_entry]);
 
 	csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
+	/* Some DWMAC IPs support tx coe only for a few initial tx queues,
+	 * starting from tx queue 0. So checksum offloading for those queues
+	 * that don't support tx coe needs to fallback to software checksum
+	 * calculation.
+	 */
+	if (csum_insertion && queue >= priv->plat->tx_queues_with_coe) {
+		if (unlikely(skb_checksum_help(skb)))
+			goto dma_map_err;
+		csum_insertion = !csum_insertion;
+	}
 
 	if (likely(priv->extend_desc))
 		desc = (struct dma_desc *)(tx_q->dma_etx + entry);
@@ -7401,6 +7411,14 @@ int stmmac_dvr_probe(struct device *device,
 		dev_info(priv->device, "SPH feature enabled\n");
 	}
 
+	if (priv->plat->tx_coe && !priv->plat->tx_queues_with_coe)
+		priv->plat->tx_queues_with_coe = priv->plat->tx_queues_to_use;
+	else if (!priv->plat->tx_coe)
+		priv->plat->tx_queues_with_coe = 0;
+	else if (priv->plat->tx_queues_with_coe < priv->plat->tx_queues_to_use)
+		dev_info(priv->device, "TX COE only available for %u queues\n",
+			 priv->plat->tx_queues_with_coe);
+
 	/* Ideally our host DMA address width is the same as for the
 	 * device. However, it may differ and then we have to use our
 	 * host DMA width for allocation and the device DMA width for
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index be8e79c7aa34..0138b7c9c7ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -225,6 +225,10 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 				 &plat->tx_queues_to_use))
 		plat->tx_queues_to_use = 1;
 
+	if (of_property_read_u32(tx_node, "snps,tx-queues-with-coe",
+				 &plat->tx_queues_with_coe))
+		plat->tx_queues_with_coe = plat->tx_queues_to_use;
+
 	if (of_property_read_bool(tx_node, "snps,tx-sched-wrr"))
 		plat->tx_sched_algorithm = MTL_TX_ALGORITHM_WRR;
 	else if (of_property_read_bool(tx_node, "snps,tx-sched-wfq"))
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 784277d666eb..cb508164eaea 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -252,6 +252,7 @@ struct plat_stmmacenet_data {
 	u32 host_dma_width;
 	u32 rx_queues_to_use;
 	u32 tx_queues_to_use;
+	u32 tx_queues_with_coe;
 	u8 rx_sched_algorithm;
 	u8 tx_sched_algorithm;
 	struct stmmac_rxq_cfg rx_queues_cfg[MTL_MAX_RX_QUEUES];
-- 
2.19.0

