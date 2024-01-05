Return-Path: <linux-kernel+bounces-17652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7687C8250A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D5AB22AA5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6422241F7;
	Fri,  5 Jan 2024 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="OwYEDpLa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2796D22F03;
	Fri,  5 Jan 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 0FFF11A7E20;
	Fri,  5 Jan 2024 10:16:26 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1704446186; bh=IA91l9oQAJG3Cb5MwM8dFH510F/uRqsyWC/CJO98CD0=;
	h=From:To:Cc:Subject:Date:From;
	b=OwYEDpLaiBiGi0H646H5Plj3Rkmh0n+//Ibti3ROB2MlL59gthwS/hMSz/hUDKQ61
	 YXuUgBWR1cUuC+NIMgQJM+eJQoFf145fwjkGFUz/0tLOkpahvggmbgE16CjjuRGI1a
	 T3hpmmSzq0gyLHte479TkVcALsG2naqk3CV+ljpWOzNkmQZel0vM3H0dbZuOIrz2Sc
	 UaO9wJtj7VXEKCGwNMmsolNiaPcAWFt1BiJBKZyeeDTGSrTUgn9a1xkkxKtsmKFApj
	 5T6CyeZ6TQgrqwF4GF0sf95ovRLyUQ2vPcVrqf9mb4/rJ6QG6qfK4GuM17T8V4V68o
	 yibQydKWPEyTg==
From: Petr Tesarik <petr@tesarici.cz>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	netdev@vger.kernel.org (open list:STMMAC ETHERNET DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Cc: Petr Tesarik <petr@tesarici.cz>
Subject: [PATCH] net: stmmac: protect statistics updates with a spinlock
Date: Fri,  5 Jan 2024 10:15:56 +0100
Message-ID: <20240105091556.15516-1-petr@tesarici.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a spinlock to fix race conditions while updating Tx/Rx statistics.

As explained by a comment in <linux/u64_stats_sync.h>, write side of struct
u64_stats_sync must ensure mutual exclusion, or one seqcount update could
be lost on 32-bit platforms, thus blocking readers forever.

Such lockups have been actually observed on 32-bit Arm after stmmac_xmit()
on one core raced with stmmac_napi_poll_tx() on another core.

Signed-off-by: Petr Tesarik <petr@tesarici.cz>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  2 +
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  4 +
 .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |  4 +
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  4 +
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  4 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 80 +++++++++++++------
 6 files changed, 72 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index e3f650e88f82..9a17dfc1055d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -70,6 +70,7 @@ struct stmmac_txq_stats {
 	u64 tx_tso_frames;
 	u64 tx_tso_nfrags;
 	struct u64_stats_sync syncp;
+	spinlock_t lock;	/* mutual writer exclusion */
 } ____cacheline_aligned_in_smp;
 
 struct stmmac_rxq_stats {
@@ -79,6 +80,7 @@ struct stmmac_rxq_stats {
 	u64 rx_normal_irq_n;
 	u64 napi_poll;
 	struct u64_stats_sync syncp;
+	spinlock_t lock;	/* mutual writer exclusion */
 } ____cacheline_aligned_in_smp;
 
 /* Extra statistic and debug information exposed by ethtool */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 137741b94122..9c568996321d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -455,9 +455,11 @@ static int sun8i_dwmac_dma_interrupt(struct stmmac_priv *priv,
 
 	if (v & EMAC_TX_INT) {
 		ret |= handle_tx;
+		spin_lock(&txq_stats->lock);
 		u64_stats_update_begin(&txq_stats->syncp);
 		txq_stats->tx_normal_irq_n++;
 		u64_stats_update_end(&txq_stats->syncp);
+		spin_unlock(&txq_stats->lock);
 	}
 
 	if (v & EMAC_TX_DMA_STOP_INT)
@@ -479,9 +481,11 @@ static int sun8i_dwmac_dma_interrupt(struct stmmac_priv *priv,
 
 	if (v & EMAC_RX_INT) {
 		ret |= handle_rx;
+		spin_lock(&rxq_stats->lock);
 		u64_stats_update_begin(&rxq_stats->syncp);
 		rxq_stats->rx_normal_irq_n++;
 		u64_stats_update_end(&rxq_stats->syncp);
+		spin_unlock(&rxq_stats->lock);
 	}
 
 	if (v & EMAC_RX_BUF_UA_INT)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 9470d3fd2ded..e50e8b07724b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -201,15 +201,19 @@ int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 	}
 	/* TX/RX NORMAL interrupts */
 	if (likely(intr_status & DMA_CHAN_STATUS_RI)) {
+		spin_lock(&rxq_stats->lock);
 		u64_stats_update_begin(&rxq_stats->syncp);
 		rxq_stats->rx_normal_irq_n++;
 		u64_stats_update_end(&rxq_stats->syncp);
+		spin_unlock(&rxq_stats->lock);
 		ret |= handle_rx;
 	}
 	if (likely(intr_status & DMA_CHAN_STATUS_TI)) {
+		spin_lock(&txq_stats->lock);
 		u64_stats_update_begin(&txq_stats->syncp);
 		txq_stats->tx_normal_irq_n++;
 		u64_stats_update_end(&txq_stats->syncp);
+		spin_unlock(&txq_stats->lock);
 		ret |= handle_tx;
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 7907d62d3437..a43396a7f852 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -215,16 +215,20 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			u32 value = readl(ioaddr + DMA_INTR_ENA);
 			/* to schedule NAPI on real RIE event. */
 			if (likely(value & DMA_INTR_ENA_RIE)) {
+				spin_lock(&rxq_stats->lock);
 				u64_stats_update_begin(&rxq_stats->syncp);
 				rxq_stats->rx_normal_irq_n++;
 				u64_stats_update_end(&rxq_stats->syncp);
+				spin_unlock(&rxq_stats->lock);
 				ret |= handle_rx;
 			}
 		}
 		if (likely(intr_status & DMA_STATUS_TI)) {
+			spin_lock(&txq_stats->lock);
 			u64_stats_update_begin(&txq_stats->syncp);
 			txq_stats->tx_normal_irq_n++;
 			u64_stats_update_end(&txq_stats->syncp);
+			spin_unlock(&txq_stats->lock);
 			ret |= handle_tx;
 		}
 		if (unlikely(intr_status & DMA_STATUS_ERI))
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 3cde695fec91..f4e01436d4cc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -367,15 +367,19 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 	/* TX/RX NORMAL interrupts */
 	if (likely(intr_status & XGMAC_NIS)) {
 		if (likely(intr_status & XGMAC_RI)) {
+			spin_lock(&rxq_stats->lock);
 			u64_stats_update_begin(&rxq_stats->syncp);
 			rxq_stats->rx_normal_irq_n++;
 			u64_stats_update_end(&rxq_stats->syncp);
+			spin_unlock(&rxq_stats->lock);
 			ret |= handle_rx;
 		}
 		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
+			spin_lock(&txq_stats->lock);
 			u64_stats_update_begin(&txq_stats->syncp);
 			txq_stats->tx_normal_irq_n++;
 			u64_stats_update_end(&txq_stats->syncp);
+			spin_unlock(&txq_stats->lock);
 			ret |= handle_tx;
 		}
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 37e64283f910..82d8db04d0d1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2515,9 +2515,11 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 		entry = tx_q->cur_tx;
 	}
-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
+	spin_lock_irqsave(&txq_stats->lock, flags);
+	u64_stats_update_begin(&txq_stats->syncp);
 	txq_stats->tx_set_ic_bit += tx_set_ic_bit;
-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
+	u64_stats_update_end(&txq_stats->syncp);
+	spin_unlock_irqrestore(&txq_stats->lock, flags);
 
 	if (tx_desc) {
 		stmmac_flush_tx_descriptors(priv, queue);
@@ -2721,11 +2723,13 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 	if (tx_q->dirty_tx != tx_q->cur_tx)
 		*pending_packets = true;
 
-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
+	spin_lock_irqsave(&txq_stats->lock, flags);
+	u64_stats_update_begin(&txq_stats->syncp);
 	txq_stats->tx_packets += tx_packets;
 	txq_stats->tx_pkt_n += tx_packets;
 	txq_stats->tx_clean++;
-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
+	u64_stats_update_end(&txq_stats->syncp);
+	spin_unlock_irqrestore(&txq_stats->lock, flags);
 
 	priv->xstats.tx_errors += tx_errors;
 
@@ -4311,13 +4315,15 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
 	}
 
-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
+	spin_lock_irqsave(&txq_stats->lock, flags);
+	u64_stats_update_begin(&txq_stats->syncp);
 	txq_stats->tx_bytes += skb->len;
 	txq_stats->tx_tso_frames++;
 	txq_stats->tx_tso_nfrags += nfrags;
 	if (set_ic)
 		txq_stats->tx_set_ic_bit++;
-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
+	u64_stats_update_end(&txq_stats->syncp);
+	spin_unlock_irqrestore(&txq_stats->lock, flags);
 
 	if (priv->sarc_type)
 		stmmac_set_desc_sarc(priv, first, priv->sarc_type);
@@ -4560,11 +4566,13 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
 	}
 
-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
+	spin_lock_irqsave(&txq_stats->lock, flags);
+	u64_stats_update_begin(&txq_stats->syncp);
 	txq_stats->tx_bytes += skb->len;
 	if (set_ic)
 		txq_stats->tx_set_ic_bit++;
-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
+	u64_stats_update_end(&txq_stats->syncp);
+	spin_unlock_irqrestore(&txq_stats->lock, flags);
 
 	if (priv->sarc_type)
 		stmmac_set_desc_sarc(priv, first, priv->sarc_type);
@@ -4831,9 +4839,11 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		unsigned long flags;
 		tx_q->tx_count_frames = 0;
 		stmmac_set_tx_ic(priv, tx_desc);
-		flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
+		spin_lock_irqsave(&txq_stats->lock, flags);
+		u64_stats_update_begin(&txq_stats->syncp);
 		txq_stats->tx_set_ic_bit++;
-		u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
+		u64_stats_update_end(&txq_stats->syncp);
+		spin_unlock_irqrestore(&txq_stats->lock, flags);
 	}
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr);
@@ -5008,10 +5018,12 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 	skb_record_rx_queue(skb, queue);
 	napi_gro_receive(&ch->rxtx_napi, skb);
 
-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
+	spin_lock_irqsave(&rxq_stats->lock, flags);
+	u64_stats_update_begin(&rxq_stats->syncp);
 	rxq_stats->rx_pkt_n++;
 	rxq_stats->rx_bytes += len;
-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
+	u64_stats_update_end(&rxq_stats->syncp);
+	spin_unlock_irqrestore(&rxq_stats->lock, flags);
 }
 
 static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
@@ -5248,9 +5260,11 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 
 	stmmac_finalize_xdp_rx(priv, xdp_status);
 
-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
+	spin_lock_irqsave(&rxq_stats->lock, flags);
+	u64_stats_update_begin(&rxq_stats->syncp);
 	rxq_stats->rx_pkt_n += count;
-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
+	u64_stats_update_end(&rxq_stats->syncp);
+	spin_unlock_irqrestore(&rxq_stats->lock, flags);
 
 	priv->xstats.rx_dropped += rx_dropped;
 	priv->xstats.rx_errors += rx_errors;
@@ -5541,11 +5555,13 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 	stmmac_rx_refill(priv, queue);
 
-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
+	spin_lock_irqsave(&rxq_stats->lock, flags);
+	u64_stats_update_begin(&rxq_stats->syncp);
 	rxq_stats->rx_packets += rx_packets;
 	rxq_stats->rx_bytes += rx_bytes;
 	rxq_stats->rx_pkt_n += count;
-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
+	u64_stats_update_end(&rxq_stats->syncp);
+	spin_unlock_irqrestore(&rxq_stats->lock, flags);
 
 	priv->xstats.rx_dropped += rx_dropped;
 	priv->xstats.rx_errors += rx_errors;
@@ -5564,9 +5580,11 @@ static int stmmac_napi_poll_rx(struct napi_struct *napi, int budget)
 	int work_done;
 
 	rxq_stats = &priv->xstats.rxq_stats[chan];
-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
+	spin_lock_irqsave(&rxq_stats->lock, flags);
+	u64_stats_update_begin(&rxq_stats->syncp);
 	rxq_stats->napi_poll++;
-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
+	u64_stats_update_end(&rxq_stats->syncp);
+	spin_unlock_irqrestore(&rxq_stats->lock, flags);
 
 	work_done = stmmac_rx(priv, budget, chan);
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
@@ -5592,9 +5610,11 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 	int work_done;
 
 	txq_stats = &priv->xstats.txq_stats[chan];
-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
+	spin_lock_irqsave(&txq_stats->lock, flags);
+	u64_stats_update_begin(&txq_stats->syncp);
 	txq_stats->napi_poll++;
-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
+	u64_stats_update_end(&txq_stats->syncp);
+	spin_unlock_irqrestore(&txq_stats->lock, flags);
 
 	work_done = stmmac_tx_clean(priv, budget, chan, &pending_packets);
 	work_done = min(work_done, budget);
@@ -5627,14 +5647,18 @@ static int stmmac_napi_poll_rxtx(struct napi_struct *napi, int budget)
 	unsigned long flags;
 
 	rxq_stats = &priv->xstats.rxq_stats[chan];
-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
+	spin_lock_irqsave(&rxq_stats->lock, flags);
+	u64_stats_update_begin(&rxq_stats->syncp);
 	rxq_stats->napi_poll++;
-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
+	u64_stats_update_end(&rxq_stats->syncp);
+	spin_unlock(&rxq_stats->lock);
 
 	txq_stats = &priv->xstats.txq_stats[chan];
-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
+	spin_lock(&txq_stats->lock);
+	u64_stats_update_begin(&txq_stats->syncp);
 	txq_stats->napi_poll++;
-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
+	u64_stats_update_end(&txq_stats->syncp);
+	spin_unlock_irqrestore(&txq_stats->lock, flags);
 
 	tx_done = stmmac_tx_clean(priv, budget, chan, &tx_pending_packets);
 	tx_done = min(tx_done, budget);
@@ -7371,10 +7395,14 @@ int stmmac_dvr_probe(struct device *device,
 	priv->device = device;
 	priv->dev = ndev;
 
-	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
+	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
 		u64_stats_init(&priv->xstats.rxq_stats[i].syncp);
-	for (i = 0; i < MTL_MAX_TX_QUEUES; i++)
+		spin_lock_init(&priv->xstats.rxq_stats[i].lock);
+	}
+	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
 		u64_stats_init(&priv->xstats.txq_stats[i].syncp);
+		spin_lock_init(&priv->xstats.txq_stats[i].lock);
+	}
 
 	stmmac_set_ethtool_ops(ndev);
 	priv->pause = pause;
-- 
2.43.0


