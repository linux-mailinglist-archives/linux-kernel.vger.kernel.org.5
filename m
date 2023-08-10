Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A12777B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjHJPGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbjHJPGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:06:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35391270B;
        Thu, 10 Aug 2023 08:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691679963; x=1723215963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S8YzG04gocUZ9R3udkExKMtCGsxlemTcewQ0cbLcHDw=;
  b=go7UncKmK5OIsb+eR8hj/A1kn1uPEZmvuwMCfC0Jr/+oug3h9vvnPvVk
   CT04F0OwJ4S/bHewhyGIY0WwAFncyvSvNx3BujvcfpFcpn/kV4cPXk77W
   WIWsjUZqaX/QpQrBhrF9PTej9gl4xlge4ZvJVAefneQFaC8gwc61aLfMb
   78W8iuE7yYi22FVBcVGnNHo0gzjJr0R6Wk2j9qDswl3Lou8Gu8Z/si4SF
   0ljABbIJGfquHQqrt3xcTxjvjWpjLSXlskd4Nuul+MOdkUli9AhWVF9Pe
   fINIJtFQ/dVthwbSmsIMhmy743s379+YXviFQkEylF4l16Ut3nfpHI0GA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="368901759"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="368901759"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="978821689"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="978821689"
Received: from pglc00052.png.intel.com ([10.221.207.72])
  by fmsmga006.fm.intel.com with ESMTP; 10 Aug 2023 08:03:51 -0700
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
        Conor Dooley <conor+dt@kernel.org>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next 2/2] net: stmmac: Tx coe sw fallback
Date:   Thu, 10 Aug 2023 23:03:28 +0800
Message-Id: <20230810150328.19704-3-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20230810150328.19704-1-rohan.g.thomas@intel.com>
References: <20230810150328.19704-1-rohan.g.thomas@intel.com>
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

Add sw fallback of tx checksum calculation for those tx queues that
doesn't support  tx checksum offloading. Because, some DWMAC IPs
support tx checksum offloading  only for few initial tx queues,
starting from tx queue 0.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  4 ++++
 include/linux/stmmac.h                        |  1 +
 4 files changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 3401e888a9f6..f526bcaaaf64 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -219,6 +219,8 @@ struct stmmac_priv {
 	int hwts_tx_en;
 	bool tx_path_in_lpi_mode;
 	bool tso;
+	bool tx_q_coe_lmt;
+	u32 tx_q_with_coe;
 	int sph;
 	int sph_cap;
 	u32 sarc_type;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fcab363d8dfa..e095a9bd93b1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4409,6 +4409,17 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	WARN_ON(tx_q->tx_skbuff[first_entry]);
 
 	csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
+	/* Some DWMAC IPs support tx coe only for a few initial tx queues,
+	 * starting from tx queue 0. So checksum offloading for those queues
+	 * that doesn't support tx coe need to fallback to software checksum
+	 * calculation.
+	 */
+	if (csum_insertion && priv->tx_q_coe_lmt &&
+	    queue >= priv->tx_q_with_coe) {
+		if (unlikely(skb_checksum_help(skb)))
+			goto dma_map_err;
+		csum_insertion = !csum_insertion;
+	}
 
 	if (likely(priv->extend_desc))
 		desc = (struct dma_desc *)(tx_q->dma_etx + entry);
@@ -7386,6 +7397,14 @@ int stmmac_dvr_probe(struct device *device,
 		dev_info(priv->device, "SPH feature enabled\n");
 	}
 
+	if (priv->plat->tx_coe &&
+	    priv->plat->tx_queues_with_coe < priv->plat->tx_queues_to_use) {
+		priv->tx_q_coe_lmt = true;
+		priv->tx_q_with_coe = priv->plat->tx_queues_with_coe;
+		dev_info(priv->device, "TX COE limited to %u tx queues\n",
+			 priv->tx_q_with_coe);
+	}
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
index 652404c03944..795c10d19c1c 100644
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
2.26.2

