Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07E7EF27C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345833AbjKQMSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjKQMSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:18:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CDFD71
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:18:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FD8C433CC;
        Fri, 17 Nov 2023 12:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700223490;
        bh=xSB7SheKHhkYfVFVkOtml7Aoo5TYoTJR9HuadaGSiGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=At15yDr+SU7SvFQHNWQ8F7jGIsqsb8lrBs5MnBCc0zVz5dFFsaGzRKbL6EGlVbt5R
         JhqLVj7YDpWgpV/2uUzb0+xSDgQwLqHD2HqyMed5iXTmcwRJYMogCZ7fLtzllagxU5
         G05no8MhSvdJiUB4DqAOSzlTHuoHa7Ol47Meo3huYF/hu88EIK/BVvtf3EZnUxv985
         mBvETg4FUEeR/3o0Ig2EASwDneIw7rfy3kgbei/XDKQValJN4bUnPSmNO8CPWowkyO
         EFwQ4sNNztZMfiRMb7+EQvJ79Ay2WAhO1bZLQcqFeU0vW/4xZdEmwKt8DGp0RBtrmb
         F31tJqtveDZKw==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, andrew@lunn.ch,
        u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 net-next 2/4] net: ethernet: ti: am65-cpsw: Re-arrange functions to avoid forward declaration
Date:   Fri, 17 Nov 2023 14:17:53 +0200
Message-Id: <20231117121755.104547-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117121755.104547-1-rogerq@kernel.org>
References: <20231117121755.104547-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-arrange am65_cpsw_nuss_rx_cleanup(), am65_cpsw_nuss_xmit_free() and
am65_cpsw_nuss_tx_cleanup() to avoid forward declaration.

No functional change.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 145 +++++++++++------------
 1 file changed, 71 insertions(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index ece9f8df98ae..adb29e8e8026 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -367,6 +367,77 @@ static void am65_cpsw_init_host_port_emac(struct am65_cpsw_common *common);
 static void am65_cpsw_init_port_switch_ale(struct am65_cpsw_port *port);
 static void am65_cpsw_init_port_emac_ale(struct am65_cpsw_port *port);
 
+static void am65_cpsw_nuss_rx_cleanup(void *data, dma_addr_t desc_dma)
+{
+	struct am65_cpsw_rx_chn *rx_chn = data;
+	struct cppi5_host_desc_t *desc_rx;
+	struct sk_buff *skb;
+	dma_addr_t buf_dma;
+	u32 buf_dma_len;
+	void **swdata;
+
+	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
+	swdata = cppi5_hdesc_get_swdata(desc_rx);
+	skb = *swdata;
+	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
+	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
+
+	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
+	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
+
+	dev_kfree_skb_any(skb);
+}
+
+static void am65_cpsw_nuss_xmit_free(struct am65_cpsw_tx_chn *tx_chn,
+				     struct cppi5_host_desc_t *desc)
+{
+	struct cppi5_host_desc_t *first_desc, *next_desc;
+	dma_addr_t buf_dma, next_desc_dma;
+	u32 buf_dma_len;
+
+	first_desc = desc;
+	next_desc = first_desc;
+
+	cppi5_hdesc_get_obuf(first_desc, &buf_dma, &buf_dma_len);
+	k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &buf_dma);
+
+	dma_unmap_single(tx_chn->dma_dev, buf_dma, buf_dma_len, DMA_TO_DEVICE);
+
+	next_desc_dma = cppi5_hdesc_get_next_hbdesc(first_desc);
+	k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &next_desc_dma);
+	while (next_desc_dma) {
+		next_desc = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool,
+						       next_desc_dma);
+		cppi5_hdesc_get_obuf(next_desc, &buf_dma, &buf_dma_len);
+		k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &buf_dma);
+
+		dma_unmap_page(tx_chn->dma_dev, buf_dma, buf_dma_len,
+			       DMA_TO_DEVICE);
+
+		next_desc_dma = cppi5_hdesc_get_next_hbdesc(next_desc);
+		k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &next_desc_dma);
+
+		k3_cppi_desc_pool_free(tx_chn->desc_pool, next_desc);
+	}
+
+	k3_cppi_desc_pool_free(tx_chn->desc_pool, first_desc);
+}
+
+static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma)
+{
+	struct am65_cpsw_tx_chn *tx_chn = data;
+	struct cppi5_host_desc_t *desc_tx;
+	struct sk_buff *skb;
+	void **swdata;
+
+	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
+	swdata = cppi5_hdesc_get_swdata(desc_tx);
+	skb = *(swdata);
+	am65_cpsw_nuss_xmit_free(tx_chn, desc_tx);
+
+	dev_kfree_skb_any(skb);
+}
+
 static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 {
 	struct am65_cpsw_host *host_p = am65_common_get_host(common);
@@ -470,9 +541,6 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 	return 0;
 }
 
-static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma);
-static void am65_cpsw_nuss_rx_cleanup(void *data, dma_addr_t desc_dma);
-
 static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
 {
 	int i;
@@ -646,27 +714,6 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
 	return ret;
 }
 
-static void am65_cpsw_nuss_rx_cleanup(void *data, dma_addr_t desc_dma)
-{
-	struct am65_cpsw_rx_chn *rx_chn = data;
-	struct cppi5_host_desc_t *desc_rx;
-	struct sk_buff *skb;
-	dma_addr_t buf_dma;
-	u32 buf_dma_len;
-	void **swdata;
-
-	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
-	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	skb = *swdata;
-	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
-	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
-
-	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
-	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
-
-	dev_kfree_skb_any(skb);
-}
-
 static void am65_cpsw_nuss_rx_ts(struct sk_buff *skb, u32 *psdata)
 {
 	struct skb_shared_hwtstamps *ssh;
@@ -840,56 +887,6 @@ static int am65_cpsw_nuss_rx_poll(struct napi_struct *napi_rx, int budget)
 	return num_rx;
 }
 
-static void am65_cpsw_nuss_xmit_free(struct am65_cpsw_tx_chn *tx_chn,
-				     struct cppi5_host_desc_t *desc)
-{
-	struct cppi5_host_desc_t *first_desc, *next_desc;
-	dma_addr_t buf_dma, next_desc_dma;
-	u32 buf_dma_len;
-
-	first_desc = desc;
-	next_desc = first_desc;
-
-	cppi5_hdesc_get_obuf(first_desc, &buf_dma, &buf_dma_len);
-	k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &buf_dma);
-
-	dma_unmap_single(tx_chn->dma_dev, buf_dma, buf_dma_len, DMA_TO_DEVICE);
-
-	next_desc_dma = cppi5_hdesc_get_next_hbdesc(first_desc);
-	k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &next_desc_dma);
-	while (next_desc_dma) {
-		next_desc = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool,
-						       next_desc_dma);
-		cppi5_hdesc_get_obuf(next_desc, &buf_dma, &buf_dma_len);
-		k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &buf_dma);
-
-		dma_unmap_page(tx_chn->dma_dev, buf_dma, buf_dma_len,
-			       DMA_TO_DEVICE);
-
-		next_desc_dma = cppi5_hdesc_get_next_hbdesc(next_desc);
-		k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &next_desc_dma);
-
-		k3_cppi_desc_pool_free(tx_chn->desc_pool, next_desc);
-	}
-
-	k3_cppi_desc_pool_free(tx_chn->desc_pool, first_desc);
-}
-
-static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma)
-{
-	struct am65_cpsw_tx_chn *tx_chn = data;
-	struct cppi5_host_desc_t *desc_tx;
-	struct sk_buff *skb;
-	void **swdata;
-
-	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
-	swdata = cppi5_hdesc_get_swdata(desc_tx);
-	skb = *(swdata);
-	am65_cpsw_nuss_xmit_free(tx_chn, desc_tx);
-
-	dev_kfree_skb_any(skb);
-}
-
 static struct sk_buff *
 am65_cpsw_nuss_tx_compl_packet(struct am65_cpsw_tx_chn *tx_chn,
 			       dma_addr_t desc_dma)
-- 
2.34.1

