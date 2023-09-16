Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD9B7A2E41
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 08:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbjIPGeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 02:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238796AbjIPGdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 02:33:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDED19BA;
        Fri, 15 Sep 2023 23:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694846011; x=1726382011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dlwnheLHWrheCZf+0lnqyF5y1gAk0XJDuzApxL+C0IU=;
  b=buFXf6XO+XGRNS1SGLuxjClGvhDCO8be5fhqZnsgTuTI//MPOZdf8FU0
   X5zA71cYwmXWm/AGtW6YDoDCv3O/X1IRXbB4Rs/6c8wRF02SZnaNiKaKs
   VbwmQ2HTvSFB9L9yc15NcFwRu9bsG3k4prU9htqvQbzQpP/ujde/gHTT4
   xAE4DSLwSlxsfyjMSTuthUR7kNeAWo3Hch4+twlxDgM4Y5aQmYoAEFDIV
   i6T4BjuU7fx/sPLXZ0+/Yg4kmuD2B4exs46sFTgshgEdSXVA3m7ns2pOF
   KO/wEUzSfvzfYh4L1gQBisG3Eh8vuaSQ2DhRr6mvbmeYKan/8nnfO/nkx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="359637818"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="359637818"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 23:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="780351428"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="780351428"
Received: from pglc00032.png.intel.com ([10.221.207.52])
  by orsmga001.jf.intel.com with ESMTP; 15 Sep 2023 23:33:27 -0700
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
        fancer.lancer@gmail.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next v7 2/2] net: stmmac: Tx coe sw fallback
Date:   Sat, 16 Sep 2023 14:33:12 +0800
Message-Id: <20230916063312.7011-3-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230916063312.7011-1-rohan.g.thomas@intel.com>
References: <20230916063312.7011-1-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sw fallback of tx checksum calculation for those tx queues that
don't support tx checksum offloading. DW xGMAC IP can be synthesized
such that it can support tx checksum offloading only for a few
initial tx queues. Also as Serge pointed out, for the DW QoS IP, tx
coe can be individually configured for each tx queue.

So when tx coe is enabled, for any tx queue that doesn't support
tx coe with 'coe-unsupported' flag set will have a sw fallback
happen in the driver for tx checksum calculation when any packets to
be transmitted on these tx queues.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 10 ++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  3 +++
 include/linux/stmmac.h                                |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2206789802bf..9201ed778ebc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4401,6 +4401,16 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	WARN_ON(tx_q->tx_skbuff[first_entry]);
 
 	csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
+	/* DWMAC IPs can be synthesized to support tx coe only for a few tx
+	 * queues. In that case, checksum offloading for those queues that don't
+	 * support tx coe needs to fallback to software checksum calculation.
+	 */
+	if (csum_insertion &&
+	    priv->plat->tx_queues_cfg[queue].coe_unsupported) {
+		if (unlikely(skb_checksum_help(skb)))
+			goto dma_map_err;
+		csum_insertion = !csum_insertion;
+	}
 
 	if (likely(priv->extend_desc))
 		desc = (struct dma_desc *)(tx_q->dma_etx + entry);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 0f28795e581c..a09014c9e7d0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -276,6 +276,9 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 			plat->tx_queues_cfg[queue].use_prio = true;
 		}
 
+		plat->tx_queues_cfg[queue].coe_unsupported =
+			of_property_read_bool(q_node, "snps,coe-unsupported");
+
 		queue++;
 	}
 	if (queue != plat->tx_queues_to_use) {
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index ce89cc3e4913..c0079a7574ae 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -139,6 +139,7 @@ struct stmmac_rxq_cfg {
 
 struct stmmac_txq_cfg {
 	u32 weight;
+	bool coe_unsupported;
 	u8 mode_to_use;
 	/* Credit Base Shaper parameters */
 	u32 send_slope;
-- 
2.25.1

