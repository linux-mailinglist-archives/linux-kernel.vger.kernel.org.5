Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3993E7A36BB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbjIQRGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbjIQRFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:05:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A06B12A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:05:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09825C433C7;
        Sun, 17 Sep 2023 17:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694970333;
        bh=7hFrYEgVBlKEg2RstG8XaCVqEA59jrgsdTBeE8ZhYuM=;
        h=From:To:Cc:Subject:Date:From;
        b=rNRSvpeWN6E0ap9CvJTTvrbrhzKiKZkoqv3yTUm0FFOU5xNVejTpTc8K4u55Tb+xM
         mf4LVmPuvyBZev9/4f+Xbz4ejXpiHUBFhn7PDOD46zxtz66gr2ZFbYgnLk3U7eG9wr
         t4+Dh2ZxLEuzntbdl26qWxfnjeyqIIeAVKQks5GwkIxqyJQpkwT9AiTCSNJ7go782q
         WRgfxknjaL8XJqtKklcxbLZRq3sw7ixnPf+FxRoyPEaGHgS0qbw0LcOb7snVHlDvtm
         v3VrbVbRt4GC0kVeGXKGAfggLaA1awQR/tgst/SEGg0NgVWs3y4mq+X6nRKN4lTvF8
         6MIlhQXoXel7Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-stm32@st-md-mailman.stormreply.com,
        johannes@sipsolutions.net,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] net: stmmac: fix incorrect rxq|txq_stats reference
Date:   Mon, 18 Sep 2023 00:53:28 +0800
Message-Id: <20230917165328.3403-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics
where necessary") caused one regression as found by Uwe, the backtrace
looks like:

	INFO: trying to register non-static key.
	The code is fine but needs lockdep annotation, or maybe
	you didn't initialize this object before use?
	turning off the locking correctness validator.
	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc1-00449-g133466c3bbe1-dirty #21
	Hardware name: STM32 (Device Tree Support)
	 unwind_backtrace from show_stack+0x18/0x1c
	 show_stack from dump_stack_lvl+0x60/0x90
	 dump_stack_lvl from register_lock_class+0x98c/0x99c
	 register_lock_class from __lock_acquire+0x74/0x293c
	 __lock_acquire from lock_acquire+0x134/0x398
	 lock_acquire from stmmac_get_stats64+0x2ac/0x2fc
	 stmmac_get_stats64 from dev_get_stats+0x44/0x130
	 dev_get_stats from rtnl_fill_stats+0x38/0x120
	 rtnl_fill_stats from rtnl_fill_ifinfo+0x834/0x17f4
	 rtnl_fill_ifinfo from rtmsg_ifinfo_build_skb+0xc0/0x144
	 rtmsg_ifinfo_build_skb from rtmsg_ifinfo+0x50/0x88
	 rtmsg_ifinfo from __dev_notify_flags+0xc0/0xec
	 __dev_notify_flags from dev_change_flags+0x50/0x5c
	 dev_change_flags from ip_auto_config+0x2f4/0x1260
	 ip_auto_config from do_one_initcall+0x70/0x35c
	 do_one_initcall from kernel_init_freeable+0x2ac/0x308
	 kernel_init_freeable from kernel_init+0x1c/0x138
	 kernel_init from ret_from_fork+0x14/0x2c

The reason is the rxq|txq_stats structures are not what expected
because stmmac_open() -> __stmmac_open() the structure is overwritten
by "memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));"
This causes the well initialized syncp member of rxq|txq_stats is
overwritten unexpectedly as pointed out by Johannes and Uwe.

Fix this issue by moving rxq|txq_stats back to stmmac_extra_stats. For
SMP cache friendly, we also mark stmmac_txq_stats and stmmac_rxq_stats
as ____cacheline_aligned_in_smp.

Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where necessary")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---

Since v1
 - rebase on net instead of net-next

 drivers/net/ethernet/stmicro/stmmac/common.h  |   7 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  16 +--
 .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |  16 +--
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  16 +--
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  16 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   2 -
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  32 ++---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 125 ++++++++++--------
 8 files changed, 120 insertions(+), 110 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 403cb397d4d3..1e996c29043d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -70,7 +70,7 @@ struct stmmac_txq_stats {
 	u64 tx_tso_frames;
 	u64 tx_tso_nfrags;
 	struct u64_stats_sync syncp;
-};
+} ____cacheline_aligned_in_smp;
 
 struct stmmac_rxq_stats {
 	u64 rx_bytes;
@@ -79,7 +79,7 @@ struct stmmac_rxq_stats {
 	u64 rx_normal_irq_n;
 	u64 napi_poll;
 	struct u64_stats_sync syncp;
-};
+} ____cacheline_aligned_in_smp;
 
 /* Extra statistic and debug information exposed by ethtool */
 struct stmmac_extra_stats {
@@ -202,6 +202,9 @@ struct stmmac_extra_stats {
 	unsigned long mtl_est_hlbf;
 	unsigned long mtl_est_btre;
 	unsigned long mtl_est_btrlm;
+	/* per queue statistics */
+	struct stmmac_txq_stats txq_stats[MTL_MAX_TX_QUEUES];
+	struct stmmac_rxq_stats rxq_stats[MTL_MAX_RX_QUEUES];
 	unsigned long rx_dropped;
 	unsigned long rx_errors;
 	unsigned long tx_dropped;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 01e77368eef1..465ff1fd4785 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -441,8 +441,8 @@ static int sun8i_dwmac_dma_interrupt(struct stmmac_priv *priv,
 				     struct stmmac_extra_stats *x, u32 chan,
 				     u32 dir)
 {
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[chan];
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[chan];
+	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[chan];
+	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
 	int ret = 0;
 	u32 v;
 
@@ -455,9 +455,9 @@ static int sun8i_dwmac_dma_interrupt(struct stmmac_priv *priv,
 
 	if (v & EMAC_TX_INT) {
 		ret |= handle_tx;
-		u64_stats_update_begin(&tx_q->txq_stats.syncp);
-		tx_q->txq_stats.tx_normal_irq_n++;
-		u64_stats_update_end(&tx_q->txq_stats.syncp);
+		u64_stats_update_begin(&txq_stats->syncp);
+		txq_stats->tx_normal_irq_n++;
+		u64_stats_update_end(&txq_stats->syncp);
 	}
 
 	if (v & EMAC_TX_DMA_STOP_INT)
@@ -479,9 +479,9 @@ static int sun8i_dwmac_dma_interrupt(struct stmmac_priv *priv,
 
 	if (v & EMAC_RX_INT) {
 		ret |= handle_rx;
-		u64_stats_update_begin(&rx_q->rxq_stats.syncp);
-		rx_q->rxq_stats.rx_normal_irq_n++;
-		u64_stats_update_end(&rx_q->rxq_stats.syncp);
+		u64_stats_update_begin(&rxq_stats->syncp);
+		rxq_stats->rx_normal_irq_n++;
+		u64_stats_update_end(&rxq_stats->syncp);
 	}
 
 	if (v & EMAC_RX_BUF_UA_INT)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 980e5f8a37ec..9470d3fd2ded 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -171,8 +171,8 @@ int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 	const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;
 	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(dwmac4_addrs, chan));
 	u32 intr_en = readl(ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[chan];
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[chan];
+	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[chan];
+	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
 	int ret = 0;
 
 	if (dir == DMA_DIR_RX)
@@ -201,15 +201,15 @@ int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 	}
 	/* TX/RX NORMAL interrupts */
 	if (likely(intr_status & DMA_CHAN_STATUS_RI)) {
-		u64_stats_update_begin(&rx_q->rxq_stats.syncp);
-		rx_q->rxq_stats.rx_normal_irq_n++;
-		u64_stats_update_end(&rx_q->rxq_stats.syncp);
+		u64_stats_update_begin(&rxq_stats->syncp);
+		rxq_stats->rx_normal_irq_n++;
+		u64_stats_update_end(&rxq_stats->syncp);
 		ret |= handle_rx;
 	}
 	if (likely(intr_status & DMA_CHAN_STATUS_TI)) {
-		u64_stats_update_begin(&tx_q->txq_stats.syncp);
-		tx_q->txq_stats.tx_normal_irq_n++;
-		u64_stats_update_end(&tx_q->txq_stats.syncp);
+		u64_stats_update_begin(&txq_stats->syncp);
+		txq_stats->tx_normal_irq_n++;
+		u64_stats_update_end(&txq_stats->syncp);
 		ret |= handle_tx;
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index aaa09b16b016..7907d62d3437 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -162,8 +162,8 @@ static void show_rx_process_state(unsigned int status)
 int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			struct stmmac_extra_stats *x, u32 chan, u32 dir)
 {
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[chan];
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[chan];
+	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[chan];
+	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
 	int ret = 0;
 	/* read the status register (CSR5) */
 	u32 intr_status = readl(ioaddr + DMA_STATUS);
@@ -215,16 +215,16 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			u32 value = readl(ioaddr + DMA_INTR_ENA);
 			/* to schedule NAPI on real RIE event. */
 			if (likely(value & DMA_INTR_ENA_RIE)) {
-				u64_stats_update_begin(&rx_q->rxq_stats.syncp);
-				rx_q->rxq_stats.rx_normal_irq_n++;
-				u64_stats_update_end(&rx_q->rxq_stats.syncp);
+				u64_stats_update_begin(&rxq_stats->syncp);
+				rxq_stats->rx_normal_irq_n++;
+				u64_stats_update_end(&rxq_stats->syncp);
 				ret |= handle_rx;
 			}
 		}
 		if (likely(intr_status & DMA_STATUS_TI)) {
-			u64_stats_update_begin(&tx_q->txq_stats.syncp);
-			tx_q->txq_stats.tx_normal_irq_n++;
-			u64_stats_update_end(&tx_q->txq_stats.syncp);
+			u64_stats_update_begin(&txq_stats->syncp);
+			txq_stats->tx_normal_irq_n++;
+			u64_stats_update_end(&txq_stats->syncp);
 			ret |= handle_tx;
 		}
 		if (unlikely(intr_status & DMA_STATUS_ERI))
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index fa69d64a8694..3cde695fec91 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -337,8 +337,8 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 				  struct stmmac_extra_stats *x, u32 chan,
 				  u32 dir)
 {
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[chan];
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[chan];
+	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[chan];
+	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
 	u32 intr_status = readl(ioaddr + XGMAC_DMA_CH_STATUS(chan));
 	u32 intr_en = readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
 	int ret = 0;
@@ -367,15 +367,15 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 	/* TX/RX NORMAL interrupts */
 	if (likely(intr_status & XGMAC_NIS)) {
 		if (likely(intr_status & XGMAC_RI)) {
-			u64_stats_update_begin(&rx_q->rxq_stats.syncp);
-			rx_q->rxq_stats.rx_normal_irq_n++;
-			u64_stats_update_end(&rx_q->rxq_stats.syncp);
+			u64_stats_update_begin(&rxq_stats->syncp);
+			rxq_stats->rx_normal_irq_n++;
+			u64_stats_update_end(&rxq_stats->syncp);
 			ret |= handle_rx;
 		}
 		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
-			u64_stats_update_begin(&tx_q->txq_stats.syncp);
-			tx_q->txq_stats.tx_normal_irq_n++;
-			u64_stats_update_end(&tx_q->txq_stats.syncp);
+			u64_stats_update_begin(&txq_stats->syncp);
+			txq_stats->tx_normal_irq_n++;
+			u64_stats_update_end(&txq_stats->syncp);
 			ret |= handle_tx;
 		}
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 3401e888a9f6..cd7a9768de5f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -78,7 +78,6 @@ struct stmmac_tx_queue {
 	dma_addr_t dma_tx_phy;
 	dma_addr_t tx_tail_addr;
 	u32 mss;
-	struct stmmac_txq_stats txq_stats;
 };
 
 struct stmmac_rx_buffer {
@@ -123,7 +122,6 @@ struct stmmac_rx_queue {
 		unsigned int len;
 		unsigned int error;
 	} state;
-	struct stmmac_rxq_stats rxq_stats;
 };
 
 struct stmmac_channel {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index b7ac7abecdd3..6aa5c0556d22 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -548,14 +548,14 @@ static void stmmac_get_per_qstats(struct stmmac_priv *priv, u64 *data)
 
 	pos = data;
 	for (q = 0; q < tx_cnt; q++) {
-		struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[q];
+		struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[q];
 		struct stmmac_txq_stats snapshot;
 
 		data = pos;
 		do {
-			start = u64_stats_fetch_begin(&tx_q->txq_stats.syncp);
-			snapshot = tx_q->txq_stats;
-		} while (u64_stats_fetch_retry(&tx_q->txq_stats.syncp, start));
+			start = u64_stats_fetch_begin(&txq_stats->syncp);
+			snapshot = *txq_stats;
+		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
 
 		p = (char *)&snapshot + offsetof(struct stmmac_txq_stats, tx_pkt_n);
 		for (stat = 0; stat < STMMAC_TXQ_STATS; stat++) {
@@ -566,14 +566,14 @@ static void stmmac_get_per_qstats(struct stmmac_priv *priv, u64 *data)
 
 	pos = data;
 	for (q = 0; q < rx_cnt; q++) {
-		struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[q];
+		struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[q];
 		struct stmmac_rxq_stats snapshot;
 
 		data = pos;
 		do {
-			start = u64_stats_fetch_begin(&rx_q->rxq_stats.syncp);
-			snapshot = rx_q->rxq_stats;
-		} while (u64_stats_fetch_retry(&rx_q->rxq_stats.syncp, start));
+			start = u64_stats_fetch_begin(&rxq_stats->syncp);
+			snapshot = *rxq_stats;
+		} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
 
 		p = (char *)&snapshot + offsetof(struct stmmac_rxq_stats, rx_pkt_n);
 		for (stat = 0; stat < STMMAC_RXQ_STATS; stat++) {
@@ -637,14 +637,14 @@ static void stmmac_get_ethtool_stats(struct net_device *dev,
 
 	pos = j;
 	for (i = 0; i < rx_queues_count; i++) {
-		struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[i];
+		struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[i];
 		struct stmmac_rxq_stats snapshot;
 
 		j = pos;
 		do {
-			start = u64_stats_fetch_begin(&rx_q->rxq_stats.syncp);
-			snapshot = rx_q->rxq_stats;
-		} while (u64_stats_fetch_retry(&rx_q->rxq_stats.syncp, start));
+			start = u64_stats_fetch_begin(&rxq_stats->syncp);
+			snapshot = *rxq_stats;
+		} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
 
 		data[j++] += snapshot.rx_pkt_n;
 		data[j++] += snapshot.rx_normal_irq_n;
@@ -654,14 +654,14 @@ static void stmmac_get_ethtool_stats(struct net_device *dev,
 
 	pos = j;
 	for (i = 0; i < tx_queues_count; i++) {
-		struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[i];
+		struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[i];
 		struct stmmac_txq_stats snapshot;
 
 		j = pos;
 		do {
-			start = u64_stats_fetch_begin(&tx_q->txq_stats.syncp);
-			snapshot = tx_q->txq_stats;
-		} while (u64_stats_fetch_retry(&tx_q->txq_stats.syncp, start));
+			start = u64_stats_fetch_begin(&txq_stats->syncp);
+			snapshot = *txq_stats;
+		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
 
 		data[j++] += snapshot.tx_pkt_n;
 		data[j++] += snapshot.tx_normal_irq_n;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2206789802bf..83c567a89a46 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2426,6 +2426,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 {
 	struct netdev_queue *nq = netdev_get_tx_queue(priv->dev, queue);
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
 	struct xsk_buff_pool *pool = tx_q->xsk_pool;
 	unsigned int entry = tx_q->cur_tx;
 	struct dma_desc *tx_desc = NULL;
@@ -2505,9 +2506,9 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 		entry = tx_q->cur_tx;
 	}
-	flags = u64_stats_update_begin_irqsave(&tx_q->txq_stats.syncp);
-	tx_q->txq_stats.tx_set_ic_bit += tx_set_ic_bit;
-	u64_stats_update_end_irqrestore(&tx_q->txq_stats.syncp, flags);
+	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
+	txq_stats->tx_set_ic_bit += tx_set_ic_bit;
+	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
 
 	if (tx_desc) {
 		stmmac_flush_tx_descriptors(priv, queue);
@@ -2547,6 +2548,7 @@ static void stmmac_bump_dma_threshold(struct stmmac_priv *priv, u32 chan)
 static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 {
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
 	unsigned int bytes_compl = 0, pkts_compl = 0;
 	unsigned int entry, xmits = 0, count = 0;
 	u32 tx_packets = 0, tx_errors = 0;
@@ -2706,11 +2708,11 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 	if (tx_q->dirty_tx != tx_q->cur_tx)
 		stmmac_tx_timer_arm(priv, queue);
 
-	flags = u64_stats_update_begin_irqsave(&tx_q->txq_stats.syncp);
-	tx_q->txq_stats.tx_packets += tx_packets;
-	tx_q->txq_stats.tx_pkt_n += tx_packets;
-	tx_q->txq_stats.tx_clean++;
-	u64_stats_update_end_irqrestore(&tx_q->txq_stats.syncp, flags);
+	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
+	txq_stats->tx_packets += tx_packets;
+	txq_stats->tx_pkt_n += tx_packets;
+	txq_stats->tx_clean++;
+	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
 
 	priv->xstats.tx_errors += tx_errors;
 
@@ -4114,6 +4116,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	int nfrags = skb_shinfo(skb)->nr_frags;
 	u32 queue = skb_get_queue_mapping(skb);
 	unsigned int first_entry, tx_packets;
+	struct stmmac_txq_stats *txq_stats;
 	int tmp_pay_len = 0, first_tx;
 	struct stmmac_tx_queue *tx_q;
 	bool has_vlan, set_ic;
@@ -4124,6 +4127,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	int i;
 
 	tx_q = &priv->dma_conf.tx_queue[queue];
+	txq_stats = &priv->xstats.txq_stats[queue];
 	first_tx = tx_q->cur_tx;
 
 	/* Compute header lengths */
@@ -4282,13 +4286,13 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
 	}
 
-	flags = u64_stats_update_begin_irqsave(&tx_q->txq_stats.syncp);
-	tx_q->txq_stats.tx_bytes += skb->len;
-	tx_q->txq_stats.tx_tso_frames++;
-	tx_q->txq_stats.tx_tso_nfrags += nfrags;
+	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
+	txq_stats->tx_bytes += skb->len;
+	txq_stats->tx_tso_frames++;
+	txq_stats->tx_tso_nfrags += nfrags;
 	if (set_ic)
-		tx_q->txq_stats.tx_set_ic_bit++;
-	u64_stats_update_end_irqrestore(&tx_q->txq_stats.syncp, flags);
+		txq_stats->tx_set_ic_bit++;
+	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
 
 	if (priv->sarc_type)
 		stmmac_set_desc_sarc(priv, first, priv->sarc_type);
@@ -4359,6 +4363,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	u32 queue = skb_get_queue_mapping(skb);
 	int nfrags = skb_shinfo(skb)->nr_frags;
 	int gso = skb_shinfo(skb)->gso_type;
+	struct stmmac_txq_stats *txq_stats;
 	struct dma_edesc *tbs_desc = NULL;
 	struct dma_desc *desc, *first;
 	struct stmmac_tx_queue *tx_q;
@@ -4368,6 +4373,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	dma_addr_t des;
 
 	tx_q = &priv->dma_conf.tx_queue[queue];
+	txq_stats = &priv->xstats.txq_stats[queue];
 	first_tx = tx_q->cur_tx;
 
 	if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
@@ -4519,11 +4525,11 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
 	}
 
-	flags = u64_stats_update_begin_irqsave(&tx_q->txq_stats.syncp);
-	tx_q->txq_stats.tx_bytes += skb->len;
+	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
+	txq_stats->tx_bytes += skb->len;
 	if (set_ic)
-		tx_q->txq_stats.tx_set_ic_bit++;
-	u64_stats_update_end_irqrestore(&tx_q->txq_stats.syncp, flags);
+		txq_stats->tx_set_ic_bit++;
+	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
 
 	if (priv->sarc_type)
 		stmmac_set_desc_sarc(priv, first, priv->sarc_type);
@@ -4730,6 +4736,7 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
 static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 				struct xdp_frame *xdpf, bool dma_map)
 {
+	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 	unsigned int entry = tx_q->cur_tx;
 	struct dma_desc *tx_desc;
@@ -4789,9 +4796,9 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		unsigned long flags;
 		tx_q->tx_count_frames = 0;
 		stmmac_set_tx_ic(priv, tx_desc);
-		flags = u64_stats_update_begin_irqsave(&tx_q->txq_stats.syncp);
-		tx_q->txq_stats.tx_set_ic_bit++;
-		u64_stats_update_end_irqrestore(&tx_q->txq_stats.syncp, flags);
+		flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
+		txq_stats->tx_set_ic_bit++;
+		u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
 	}
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr);
@@ -4936,7 +4943,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 				   struct dma_desc *p, struct dma_desc *np,
 				   struct xdp_buff *xdp)
 {
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
+	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
 	unsigned int len = xdp->data_end - xdp->data;
 	enum pkt_hash_types hash_type;
@@ -4966,10 +4973,10 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 	skb_record_rx_queue(skb, queue);
 	napi_gro_receive(&ch->rxtx_napi, skb);
 
-	flags = u64_stats_update_begin_irqsave(&rx_q->rxq_stats.syncp);
-	rx_q->rxq_stats.rx_pkt_n++;
-	rx_q->rxq_stats.rx_bytes += len;
-	u64_stats_update_end_irqrestore(&rx_q->rxq_stats.syncp, flags);
+	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
+	rxq_stats->rx_pkt_n++;
+	rxq_stats->rx_bytes += len;
+	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
 }
 
 static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
@@ -5042,6 +5049,7 @@ static struct stmmac_xdp_buff *xsk_buff_to_stmmac_ctx(struct xdp_buff *xdp)
 
 static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 {
+	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 	unsigned int count = 0, error = 0, len = 0;
 	int dirty = stmmac_rx_dirty(priv, queue);
@@ -5205,9 +5213,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 
 	stmmac_finalize_xdp_rx(priv, xdp_status);
 
-	flags = u64_stats_update_begin_irqsave(&rx_q->rxq_stats.syncp);
-	rx_q->rxq_stats.rx_pkt_n += count;
-	u64_stats_update_end_irqrestore(&rx_q->rxq_stats.syncp, flags);
+	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
+	rxq_stats->rx_pkt_n += count;
+	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
 
 	priv->xstats.rx_dropped += rx_dropped;
 	priv->xstats.rx_errors += rx_errors;
@@ -5235,6 +5243,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 {
 	u32 rx_errors = 0, rx_dropped = 0, rx_bytes = 0, rx_packets = 0;
+	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
 	unsigned int count = 0, error = 0, len = 0;
@@ -5496,11 +5505,11 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 	stmmac_rx_refill(priv, queue);
 
-	flags = u64_stats_update_begin_irqsave(&rx_q->rxq_stats.syncp);
-	rx_q->rxq_stats.rx_packets += rx_packets;
-	rx_q->rxq_stats.rx_bytes += rx_bytes;
-	rx_q->rxq_stats.rx_pkt_n += count;
-	u64_stats_update_end_irqrestore(&rx_q->rxq_stats.syncp, flags);
+	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
+	rxq_stats->rx_packets += rx_packets;
+	rxq_stats->rx_bytes += rx_bytes;
+	rxq_stats->rx_pkt_n += count;
+	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
 
 	priv->xstats.rx_dropped += rx_dropped;
 	priv->xstats.rx_errors += rx_errors;
@@ -5513,15 +5522,15 @@ static int stmmac_napi_poll_rx(struct napi_struct *napi, int budget)
 	struct stmmac_channel *ch =
 		container_of(napi, struct stmmac_channel, rx_napi);
 	struct stmmac_priv *priv = ch->priv_data;
-	struct stmmac_rx_queue *rx_q;
+	struct stmmac_rxq_stats *rxq_stats;
 	u32 chan = ch->index;
 	unsigned long flags;
 	int work_done;
 
-	rx_q = &priv->dma_conf.rx_queue[chan];
-	flags = u64_stats_update_begin_irqsave(&rx_q->rxq_stats.syncp);
-	rx_q->rxq_stats.napi_poll++;
-	u64_stats_update_end_irqrestore(&rx_q->rxq_stats.syncp, flags);
+	rxq_stats = &priv->xstats.rxq_stats[chan];
+	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
+	rxq_stats->napi_poll++;
+	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
 
 	work_done = stmmac_rx(priv, budget, chan);
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
@@ -5540,15 +5549,15 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 	struct stmmac_channel *ch =
 		container_of(napi, struct stmmac_channel, tx_napi);
 	struct stmmac_priv *priv = ch->priv_data;
-	struct stmmac_tx_queue *tx_q;
+	struct stmmac_txq_stats *txq_stats;
 	u32 chan = ch->index;
 	unsigned long flags;
 	int work_done;
 
-	tx_q = &priv->dma_conf.tx_queue[chan];
-	flags = u64_stats_update_begin_irqsave(&tx_q->txq_stats.syncp);
-	tx_q->txq_stats.napi_poll++;
-	u64_stats_update_end_irqrestore(&tx_q->txq_stats.syncp, flags);
+	txq_stats = &priv->xstats.txq_stats[chan];
+	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
+	txq_stats->napi_poll++;
+	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
 
 	work_done = stmmac_tx_clean(priv, budget, chan);
 	work_done = min(work_done, budget);
@@ -5570,20 +5579,20 @@ static int stmmac_napi_poll_rxtx(struct napi_struct *napi, int budget)
 		container_of(napi, struct stmmac_channel, rxtx_napi);
 	struct stmmac_priv *priv = ch->priv_data;
 	int rx_done, tx_done, rxtx_done;
-	struct stmmac_rx_queue *rx_q;
-	struct stmmac_tx_queue *tx_q;
+	struct stmmac_rxq_stats *rxq_stats;
+	struct stmmac_txq_stats *txq_stats;
 	u32 chan = ch->index;
 	unsigned long flags;
 
-	rx_q = &priv->dma_conf.rx_queue[chan];
-	flags = u64_stats_update_begin_irqsave(&rx_q->rxq_stats.syncp);
-	rx_q->rxq_stats.napi_poll++;
-	u64_stats_update_end_irqrestore(&rx_q->rxq_stats.syncp, flags);
+	rxq_stats = &priv->xstats.rxq_stats[chan];
+	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
+	rxq_stats->napi_poll++;
+	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
 
-	tx_q = &priv->dma_conf.tx_queue[chan];
-	flags = u64_stats_update_begin_irqsave(&tx_q->txq_stats.syncp);
-	tx_q->txq_stats.napi_poll++;
-	u64_stats_update_end_irqrestore(&tx_q->txq_stats.syncp, flags);
+	txq_stats = &priv->xstats.txq_stats[chan];
+	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
+	txq_stats->napi_poll++;
+	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
 
 	tx_done = stmmac_tx_clean(priv, budget, chan);
 	tx_done = min(tx_done, budget);
@@ -6926,7 +6935,7 @@ static void stmmac_get_stats64(struct net_device *dev, struct rtnl_link_stats64
 	int q;
 
 	for (q = 0; q < tx_cnt; q++) {
-		struct stmmac_txq_stats *txq_stats = &priv->dma_conf.tx_queue[q].txq_stats;
+		struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[q];
 		u64 tx_packets;
 		u64 tx_bytes;
 
@@ -6941,7 +6950,7 @@ static void stmmac_get_stats64(struct net_device *dev, struct rtnl_link_stats64
 	}
 
 	for (q = 0; q < rx_cnt; q++) {
-		struct stmmac_rxq_stats *rxq_stats = &priv->dma_conf.rx_queue[q].rxq_stats;
+		struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[q];
 		u64 rx_packets;
 		u64 rx_bytes;
 
@@ -7342,9 +7351,9 @@ int stmmac_dvr_probe(struct device *device,
 	priv->dev = ndev;
 
 	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
-		u64_stats_init(&priv->dma_conf.rx_queue[i].rxq_stats.syncp);
+		u64_stats_init(&priv->xstats.rxq_stats[i].syncp);
 	for (i = 0; i < MTL_MAX_TX_QUEUES; i++)
-		u64_stats_init(&priv->dma_conf.tx_queue[i].txq_stats.syncp);
+		u64_stats_init(&priv->xstats.txq_stats[i].syncp);
 
 	stmmac_set_ethtool_ops(ndev);
 	priv->pause = pause;
-- 
2.40.1

