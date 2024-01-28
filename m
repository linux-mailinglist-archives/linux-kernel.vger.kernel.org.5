Return-Path: <linux-kernel+bounces-41909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 803DB83F97A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFDB0B20C43
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B900E3B7A0;
	Sun, 28 Jan 2024 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="4eWiAjec"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E542E856;
	Sun, 28 Jan 2024 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706470552; cv=none; b=YSl4jY2C/ByaKyL7gF85cJxM+FqhovZXb0ixkFyZR7oWAHk6JsggHJdQsQUNtoJwFII+96lZFQ9iav2gA6Mmb5sf+xePwvHmSc+4+SGgTQfn9j8CYEtgdYvot9VSw2djrrZeejtz62VRSo+BEp/w7OeltFCqdxfdHw/iEwUroT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706470552; c=relaxed/simple;
	bh=q+6iazhzN6qMbgE6nKNebjiKKHOJ5s/aPztOeXnQtA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxw7ueM1kKhFQ3b3MvpSojYyuRD92DQgGk0N1JvR6bQ+Qs95LKBNRjeqxQIvUwleNyqsXFcUUhuUOOqfNyqVrVGgjYZDlKchdb+J/tBhC2q7UM9Wby7Bw8Pgku9rd5vKcFuVjf+dcAovAbKFd1a0tESRDmSFuo5t2frGfnl1TCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=4eWiAjec; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id CCD22198256;
	Sun, 28 Jan 2024 20:35:39 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1706470540; bh=q+6iazhzN6qMbgE6nKNebjiKKHOJ5s/aPztOeXnQtA8=;
	h=From:To:Cc:Subject:Date:From;
	b=4eWiAjecj8XdQphBFeARqLgKlE+m9bWSXrDkHSj8JaDwUttAG71vSRYhHqnv7oj+J
	 n09s9JToQqlSKA+51RIIRqWuRJ0FI3EbigeVdpBMryKYGj7Rxc+3gIHZIiH5Dc4O4r
	 rRAr+5OPEHQYP3LHo1Efus4HatWgzKoggwlbyicbSBbIifLBaOwEV12f7m6SfWXsYm
	 6/gcA/xdRakhDyArxWM/tmkYh4pItk6uk4c0SNHTRe3mubyn8HZDv6LLhXnvpTqYJr
	 IRfEMvXrQNd9NxdV4zMeyNZRIv/FtPg735uLPNejjNRvf02rXh6PDCQMaQ7KQ6Vig2
	 vnr7R8Aup7fMQ==
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
	Jisheng Zhang <jszhang@kernel.org>,
	netdev@vger.kernel.org (open list:STMMAC ETHERNET DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Cc: Marc Haber <mh+netdev@zugschlus.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Tesarik <petr@tesarici.cz>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: stmmac: protect updates of 64-bit statistics counters
Date: Sun, 28 Jan 2024 20:35:29 +0100
Message-ID: <20240128193529.24677-1-petr@tesarici.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As explained by a comment in <linux/u64_stats_sync.h>, write side of struct
u64_stats_sync must ensure mutual exclusion, or one seqcount update could
be lost on 32-bit platforms, thus blocking readers forever. Such lockups
have been observed in real world after stmmac_xmit() on one CPU raced with
stmmac_napi_poll_tx() on another CPU.

To fix the issue without introducing a new lock, split the statics into
three parts:

1. fields updated only under the tx queue lock,
2. fields updated only during NAPI poll,
3. fields updated only from interrupt context,

Updates to fields in the first two groups are already serialized through
other locks. It is sufficient to split the existing struct u64_stats_sync
so that each group has its own.

Note that tx_set_ic_bit is updated from both contexts. Split this counter
so that each context gets its own, and calculate their sum to get the total
value in stmmac_get_ethtool_stats().

For the third group, multiple interrupts may be processed by different CPUs
at the same time, but interrupts on the same CPU will not nest. Move fields
from this group to a newly created per-cpu struct stmmac_pcpu_stats.

Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where necessary")
Link: https://lore.kernel.org/netdev/Za173PhviYg-1qIn@torres.zugschlus.de/t/
Cc: stable@vger.kernel.org
Signed-off-by: Petr Tesarik <petr@tesarici.cz>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  56 +++++--
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  15 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |  15 +-
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  15 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  15 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 129 ++++++++++------
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 141 +++++++++---------
 7 files changed, 227 insertions(+), 159 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 721c1f8e892f..4aca20feb4b7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -59,28 +59,51 @@
 #undef FRAME_FILTER_DEBUG
 /* #define FRAME_FILTER_DEBUG */
 
+struct stmmac_q_tx_stats {
+	u64_stats_t tx_bytes;
+	u64_stats_t tx_set_ic_bit;
+	u64_stats_t tx_tso_frames;
+	u64_stats_t tx_tso_nfrags;
+};
+
+struct stmmac_napi_tx_stats {
+	u64_stats_t tx_packets;
+	u64_stats_t tx_pkt_n;
+	u64_stats_t poll;
+	u64_stats_t tx_clean;
+	u64_stats_t tx_set_ic_bit;
+};
+
 struct stmmac_txq_stats {
-	u64 tx_bytes;
-	u64 tx_packets;
-	u64 tx_pkt_n;
-	u64 tx_normal_irq_n;
-	u64 napi_poll;
-	u64 tx_clean;
-	u64 tx_set_ic_bit;
-	u64 tx_tso_frames;
-	u64 tx_tso_nfrags;
-	struct u64_stats_sync syncp;
+	/* Updates protected by tx queue lock. */
+	struct u64_stats_sync q_syncp;
+	struct stmmac_q_tx_stats q;
+
+	/* Updates protected by NAPI poll logic. */
+	struct u64_stats_sync napi_syncp;
+	struct stmmac_napi_tx_stats napi;
 } ____cacheline_aligned_in_smp;
 
+struct stmmac_napi_rx_stats {
+	u64_stats_t rx_bytes;
+	u64_stats_t rx_packets;
+	u64_stats_t rx_pkt_n;
+	u64_stats_t poll;
+};
+
 struct stmmac_rxq_stats {
-	u64 rx_bytes;
-	u64 rx_packets;
-	u64 rx_pkt_n;
-	u64 rx_normal_irq_n;
-	u64 napi_poll;
-	struct u64_stats_sync syncp;
+	/* Updates protected by NAPI poll logic. */
+	struct u64_stats_sync napi_syncp;
+	struct stmmac_napi_rx_stats napi;
 } ____cacheline_aligned_in_smp;
 
+/* Updates on each CPU protected by not allowing nested irqs. */
+struct stmmac_pcpu_stats {
+	struct u64_stats_sync syncp;
+	u64_stats_t rx_normal_irq_n[MTL_MAX_TX_QUEUES];
+	u64_stats_t tx_normal_irq_n[MTL_MAX_RX_QUEUES];
+};
+
 /* Extra statistic and debug information exposed by ethtool */
 struct stmmac_extra_stats {
 	/* Transmit errors */
@@ -205,6 +228,7 @@ struct stmmac_extra_stats {
 	/* per queue statistics */
 	struct stmmac_txq_stats txq_stats[MTL_MAX_TX_QUEUES];
 	struct stmmac_rxq_stats rxq_stats[MTL_MAX_RX_QUEUES];
+	struct stmmac_pcpu_stats __percpu *pcpu_stats;
 	unsigned long rx_dropped;
 	unsigned long rx_errors;
 	unsigned long tx_dropped;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 137741b94122..b21d99faa2d0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -441,8 +441,7 @@ static int sun8i_dwmac_dma_interrupt(struct stmmac_priv *priv,
 				     struct stmmac_extra_stats *x, u32 chan,
 				     u32 dir)
 {
-	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[chan];
-	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
+	struct stmmac_pcpu_stats *stats = this_cpu_ptr(priv->xstats.pcpu_stats);
 	int ret = 0;
 	u32 v;
 
@@ -455,9 +454,9 @@ static int sun8i_dwmac_dma_interrupt(struct stmmac_priv *priv,
 
 	if (v & EMAC_TX_INT) {
 		ret |= handle_tx;
-		u64_stats_update_begin(&txq_stats->syncp);
-		txq_stats->tx_normal_irq_n++;
-		u64_stats_update_end(&txq_stats->syncp);
+		u64_stats_update_begin(&stats->syncp);
+		u64_stats_inc(&stats->tx_normal_irq_n[chan]);
+		u64_stats_update_end(&stats->syncp);
 	}
 
 	if (v & EMAC_TX_DMA_STOP_INT)
@@ -479,9 +478,9 @@ static int sun8i_dwmac_dma_interrupt(struct stmmac_priv *priv,
 
 	if (v & EMAC_RX_INT) {
 		ret |= handle_rx;
-		u64_stats_update_begin(&rxq_stats->syncp);
-		rxq_stats->rx_normal_irq_n++;
-		u64_stats_update_end(&rxq_stats->syncp);
+		u64_stats_update_begin(&stats->syncp);
+		u64_stats_inc(&stats->rx_normal_irq_n[chan]);
+		u64_stats_update_end(&stats->syncp);
 	}
 
 	if (v & EMAC_RX_BUF_UA_INT)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 9470d3fd2ded..0d185e54eb7e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -171,8 +171,7 @@ int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 	const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;
 	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(dwmac4_addrs, chan));
 	u32 intr_en = readl(ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
-	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[chan];
-	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
+	struct stmmac_pcpu_stats *stats = this_cpu_ptr(priv->xstats.pcpu_stats);
 	int ret = 0;
 
 	if (dir == DMA_DIR_RX)
@@ -201,15 +200,15 @@ int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 	}
 	/* TX/RX NORMAL interrupts */
 	if (likely(intr_status & DMA_CHAN_STATUS_RI)) {
-		u64_stats_update_begin(&rxq_stats->syncp);
-		rxq_stats->rx_normal_irq_n++;
-		u64_stats_update_end(&rxq_stats->syncp);
+		u64_stats_update_begin(&stats->syncp);
+		u64_stats_inc(&stats->rx_normal_irq_n[chan]);
+		u64_stats_update_end(&stats->syncp);
 		ret |= handle_rx;
 	}
 	if (likely(intr_status & DMA_CHAN_STATUS_TI)) {
-		u64_stats_update_begin(&txq_stats->syncp);
-		txq_stats->tx_normal_irq_n++;
-		u64_stats_update_end(&txq_stats->syncp);
+		u64_stats_update_begin(&stats->syncp);
+		u64_stats_inc(&stats->tx_normal_irq_n[chan]);
+		u64_stats_update_end(&stats->syncp);
 		ret |= handle_tx;
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 7907d62d3437..85e18f9a22f9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -162,8 +162,7 @@ static void show_rx_process_state(unsigned int status)
 int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			struct stmmac_extra_stats *x, u32 chan, u32 dir)
 {
-	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[chan];
-	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
+	struct stmmac_pcpu_stats *stats = this_cpu_ptr(priv->xstats.pcpu_stats);
 	int ret = 0;
 	/* read the status register (CSR5) */
 	u32 intr_status = readl(ioaddr + DMA_STATUS);
@@ -215,16 +214,16 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			u32 value = readl(ioaddr + DMA_INTR_ENA);
 			/* to schedule NAPI on real RIE event. */
 			if (likely(value & DMA_INTR_ENA_RIE)) {
-				u64_stats_update_begin(&rxq_stats->syncp);
-				rxq_stats->rx_normal_irq_n++;
-				u64_stats_update_end(&rxq_stats->syncp);
+				u64_stats_update_begin(&stats->syncp);
+				u64_stats_inc(&stats->rx_normal_irq_n[chan]);
+				u64_stats_update_end(&stats->syncp);
 				ret |= handle_rx;
 			}
 		}
 		if (likely(intr_status & DMA_STATUS_TI)) {
-			u64_stats_update_begin(&txq_stats->syncp);
-			txq_stats->tx_normal_irq_n++;
-			u64_stats_update_end(&txq_stats->syncp);
+			u64_stats_update_begin(&stats->syncp);
+			u64_stats_inc(&stats->tx_normal_irq_n[chan]);
+			u64_stats_update_end(&stats->syncp);
 			ret |= handle_tx;
 		}
 		if (unlikely(intr_status & DMA_STATUS_ERI))
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 3cde695fec91..dd2ab6185c40 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -337,8 +337,7 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 				  struct stmmac_extra_stats *x, u32 chan,
 				  u32 dir)
 {
-	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[chan];
-	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
+	struct stmmac_pcpu_stats *stats = this_cpu_ptr(priv->xstats.pcpu_stats);
 	u32 intr_status = readl(ioaddr + XGMAC_DMA_CH_STATUS(chan));
 	u32 intr_en = readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
 	int ret = 0;
@@ -367,15 +366,15 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 	/* TX/RX NORMAL interrupts */
 	if (likely(intr_status & XGMAC_NIS)) {
 		if (likely(intr_status & XGMAC_RI)) {
-			u64_stats_update_begin(&rxq_stats->syncp);
-			rxq_stats->rx_normal_irq_n++;
-			u64_stats_update_end(&rxq_stats->syncp);
+			u64_stats_update_begin(&stats->syncp);
+			u64_stats_inc(&stats->rx_normal_irq_n[chan]);
+			u64_stats_update_end(&stats->syncp);
 			ret |= handle_rx;
 		}
 		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
-			u64_stats_update_begin(&txq_stats->syncp);
-			txq_stats->tx_normal_irq_n++;
-			u64_stats_update_end(&txq_stats->syncp);
+			u64_stats_update_begin(&stats->syncp);
+			u64_stats_inc(&stats->tx_normal_irq_n[chan]);
+			u64_stats_update_end(&stats->syncp);
 			ret |= handle_tx;
 		}
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 42d27b97dd1d..ec44becf0e2d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -549,44 +549,79 @@ stmmac_set_pauseparam(struct net_device *netdev,
 	}
 }
 
+static u64 stmmac_get_rx_normal_irq_n(struct stmmac_priv *priv, int q)
+{
+	u64 total;
+	int cpu;
+
+	total = 0;
+	for_each_possible_cpu(cpu) {
+		struct stmmac_pcpu_stats *pcpu;
+		unsigned int start;
+		u64 irq_n;
+
+		pcpu = per_cpu_ptr(priv->xstats.pcpu_stats, cpu);
+		do {
+			start = u64_stats_fetch_begin(&pcpu->syncp);
+			irq_n = u64_stats_read(&pcpu->rx_normal_irq_n[q]);
+		} while (u64_stats_fetch_retry(&pcpu->syncp, start));
+		total += irq_n;
+	}
+	return total;
+}
+
+static u64 stmmac_get_tx_normal_irq_n(struct stmmac_priv *priv, int q)
+{
+	u64 total;
+	int cpu;
+
+	total = 0;
+	for_each_possible_cpu(cpu) {
+		struct stmmac_pcpu_stats *pcpu;
+		unsigned int start;
+		u64 irq_n;
+
+		pcpu = per_cpu_ptr(priv->xstats.pcpu_stats, cpu);
+		do {
+			start = u64_stats_fetch_begin(&pcpu->syncp);
+			irq_n = u64_stats_read(&pcpu->tx_normal_irq_n[q]);
+		} while (u64_stats_fetch_retry(&pcpu->syncp, start));
+		total += irq_n;
+	}
+	return total;
+}
+
 static void stmmac_get_per_qstats(struct stmmac_priv *priv, u64 *data)
 {
 	u32 tx_cnt = priv->plat->tx_queues_to_use;
 	u32 rx_cnt = priv->plat->rx_queues_to_use;
 	unsigned int start;
-	int q, stat;
-	char *p;
+	int q;
 
 	for (q = 0; q < tx_cnt; q++) {
 		struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[q];
-		struct stmmac_txq_stats snapshot;
+		u64 pkt_n;
 
 		do {
-			start = u64_stats_fetch_begin(&txq_stats->syncp);
-			snapshot = *txq_stats;
-		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
+			start = u64_stats_fetch_begin(&txq_stats->napi_syncp);
+			pkt_n = u64_stats_read(&txq_stats->napi.tx_pkt_n);
+		} while (u64_stats_fetch_retry(&txq_stats->napi_syncp, start));
 
-		p = (char *)&snapshot + offsetof(struct stmmac_txq_stats, tx_pkt_n);
-		for (stat = 0; stat < STMMAC_TXQ_STATS; stat++) {
-			*data++ = (*(u64 *)p);
-			p += sizeof(u64);
-		}
+		*data++ = pkt_n;
+		*data++ = stmmac_get_tx_normal_irq_n(priv, q);
 	}
 
 	for (q = 0; q < rx_cnt; q++) {
 		struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[q];
-		struct stmmac_rxq_stats snapshot;
+		u64 pkt_n;
 
 		do {
-			start = u64_stats_fetch_begin(&rxq_stats->syncp);
-			snapshot = *rxq_stats;
-		} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
+			start = u64_stats_fetch_begin(&rxq_stats->napi_syncp);
+			pkt_n = u64_stats_read(&rxq_stats->napi.rx_pkt_n);
+		} while (u64_stats_fetch_retry(&rxq_stats->napi_syncp, start));
 
-		p = (char *)&snapshot + offsetof(struct stmmac_rxq_stats, rx_pkt_n);
-		for (stat = 0; stat < STMMAC_RXQ_STATS; stat++) {
-			*data++ = (*(u64 *)p);
-			p += sizeof(u64);
-		}
+		*data++ = pkt_n;
+		*data++ = stmmac_get_rx_normal_irq_n(priv, q);
 	}
 }
 
@@ -645,39 +680,49 @@ static void stmmac_get_ethtool_stats(struct net_device *dev,
 	pos = j;
 	for (i = 0; i < rx_queues_count; i++) {
 		struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[i];
-		struct stmmac_rxq_stats snapshot;
+		struct stmmac_napi_rx_stats snapshot;
+		u64 n_irq;
 
 		j = pos;
 		do {
-			start = u64_stats_fetch_begin(&rxq_stats->syncp);
-			snapshot = *rxq_stats;
-		} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
-
-		data[j++] += snapshot.rx_pkt_n;
-		data[j++] += snapshot.rx_normal_irq_n;
-		normal_irq_n += snapshot.rx_normal_irq_n;
-		napi_poll += snapshot.napi_poll;
+			start = u64_stats_fetch_begin(&rxq_stats->napi_syncp);
+			snapshot = rxq_stats->napi;
+		} while (u64_stats_fetch_retry(&rxq_stats->napi_syncp, start));
+
+		data[j++] += u64_stats_read(&snapshot.rx_pkt_n);
+		n_irq = stmmac_get_rx_normal_irq_n(priv, i);
+		data[j++] += n_irq;
+		normal_irq_n += n_irq;
+		napi_poll += u64_stats_read(&snapshot.poll);
 	}
 
 	pos = j;
 	for (i = 0; i < tx_queues_count; i++) {
 		struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[i];
-		struct stmmac_txq_stats snapshot;
+		struct stmmac_napi_tx_stats napi_snapshot;
+		struct stmmac_q_tx_stats q_snapshot;
+		u64 n_irq;
 
 		j = pos;
 		do {
-			start = u64_stats_fetch_begin(&txq_stats->syncp);
-			snapshot = *txq_stats;
-		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
-
-		data[j++] += snapshot.tx_pkt_n;
-		data[j++] += snapshot.tx_normal_irq_n;
-		normal_irq_n += snapshot.tx_normal_irq_n;
-		data[j++] += snapshot.tx_clean;
-		data[j++] += snapshot.tx_set_ic_bit;
-		data[j++] += snapshot.tx_tso_frames;
-		data[j++] += snapshot.tx_tso_nfrags;
-		napi_poll += snapshot.napi_poll;
+			start = u64_stats_fetch_begin(&txq_stats->q_syncp);
+			q_snapshot = txq_stats->q;
+		} while (u64_stats_fetch_retry(&txq_stats->q_syncp, start));
+		do {
+			start = u64_stats_fetch_begin(&txq_stats->napi_syncp);
+			napi_snapshot = txq_stats->napi;
+		} while (u64_stats_fetch_retry(&txq_stats->napi_syncp, start));
+
+		data[j++] += u64_stats_read(&napi_snapshot.tx_pkt_n);
+		n_irq = stmmac_get_tx_normal_irq_n(priv, i);
+		data[j++] += n_irq;
+		normal_irq_n += n_irq;
+		data[j++] += u64_stats_read(&napi_snapshot.tx_clean);
+		data[j++] += u64_stats_read(&q_snapshot.tx_set_ic_bit) +
+			u64_stats_read(&napi_snapshot.tx_set_ic_bit);
+		data[j++] += u64_stats_read(&q_snapshot.tx_tso_frames);
+		data[j++] += u64_stats_read(&q_snapshot.tx_tso_nfrags);
+		napi_poll += u64_stats_read(&napi_snapshot.poll);
 	}
 	normal_irq_n += priv->xstats.rx_early_irq;
 	data[j++] = normal_irq_n;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a0e46369ae15..530ee7ccae9a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2482,7 +2482,6 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 	struct xdp_desc xdp_desc;
 	bool work_done = true;
 	u32 tx_set_ic_bit = 0;
-	unsigned long flags;
 
 	/* Avoids TX time-out as we are sharing with slow path */
 	txq_trans_cond_update(nq);
@@ -2566,9 +2565,9 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 		entry = tx_q->cur_tx;
 	}
-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
-	txq_stats->tx_set_ic_bit += tx_set_ic_bit;
-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
+	u64_stats_update_begin(&txq_stats->napi_syncp);
+	u64_stats_add(&txq_stats->napi.tx_set_ic_bit, tx_set_ic_bit);
+	u64_stats_update_end(&txq_stats->napi_syncp);
 
 	if (tx_desc) {
 		stmmac_flush_tx_descriptors(priv, queue);
@@ -2616,7 +2615,6 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 	unsigned int bytes_compl = 0, pkts_compl = 0;
 	unsigned int entry, xmits = 0, count = 0;
 	u32 tx_packets = 0, tx_errors = 0;
-	unsigned long flags;
 
 	__netif_tx_lock_bh(netdev_get_tx_queue(priv->dev, queue));
 
@@ -2782,11 +2780,11 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 	if (tx_q->dirty_tx != tx_q->cur_tx)
 		*pending_packets = true;
 
-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
-	txq_stats->tx_packets += tx_packets;
-	txq_stats->tx_pkt_n += tx_packets;
-	txq_stats->tx_clean++;
-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
+	u64_stats_update_begin(&txq_stats->napi_syncp);
+	u64_stats_add(&txq_stats->napi.tx_packets, tx_packets);
+	u64_stats_add(&txq_stats->napi.tx_pkt_n, tx_packets);
+	u64_stats_inc(&txq_stats->napi.tx_clean);
+	u64_stats_update_end(&txq_stats->napi_syncp);
 
 	priv->xstats.tx_errors += tx_errors;
 
@@ -4210,7 +4208,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct stmmac_tx_queue *tx_q;
 	bool has_vlan, set_ic;
 	u8 proto_hdr_len, hdr;
-	unsigned long flags;
 	u32 pay_len, mss;
 	dma_addr_t des;
 	int i;
@@ -4375,13 +4372,13 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
 	}
 
-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
-	txq_stats->tx_bytes += skb->len;
-	txq_stats->tx_tso_frames++;
-	txq_stats->tx_tso_nfrags += nfrags;
+	u64_stats_update_begin(&txq_stats->q_syncp);
+	u64_stats_add(&txq_stats->q.tx_bytes, skb->len);
+	u64_stats_inc(&txq_stats->q.tx_tso_frames);
+	u64_stats_add(&txq_stats->q.tx_tso_nfrags, nfrags);
 	if (set_ic)
-		txq_stats->tx_set_ic_bit++;
-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
+		u64_stats_inc(&txq_stats->q.tx_set_ic_bit);
+	u64_stats_update_end(&txq_stats->q_syncp);
 
 	if (priv->sarc_type)
 		stmmac_set_desc_sarc(priv, first, priv->sarc_type);
@@ -4480,7 +4477,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct stmmac_tx_queue *tx_q;
 	bool has_vlan, set_ic;
 	int entry, first_tx;
-	unsigned long flags;
 	dma_addr_t des;
 
 	tx_q = &priv->dma_conf.tx_queue[queue];
@@ -4650,11 +4646,11 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
 	}
 
-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
-	txq_stats->tx_bytes += skb->len;
+	u64_stats_update_begin(&txq_stats->q_syncp);
+	u64_stats_add(&txq_stats->q.tx_bytes, skb->len);
 	if (set_ic)
-		txq_stats->tx_set_ic_bit++;
-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
+		u64_stats_inc(&txq_stats->q.tx_set_ic_bit);
+	u64_stats_update_end(&txq_stats->q_syncp);
 
 	if (priv->sarc_type)
 		stmmac_set_desc_sarc(priv, first, priv->sarc_type);
@@ -4918,12 +4914,11 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		set_ic = false;
 
 	if (set_ic) {
-		unsigned long flags;
 		tx_q->tx_count_frames = 0;
 		stmmac_set_tx_ic(priv, tx_desc);
-		flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
-		txq_stats->tx_set_ic_bit++;
-		u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
+		u64_stats_update_begin(&txq_stats->q_syncp);
+		u64_stats_inc(&txq_stats->q.tx_set_ic_bit);
+		u64_stats_update_end(&txq_stats->q_syncp);
 	}
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr);
@@ -5073,7 +5068,6 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 	unsigned int len = xdp->data_end - xdp->data;
 	enum pkt_hash_types hash_type;
 	int coe = priv->hw->rx_csum;
-	unsigned long flags;
 	struct sk_buff *skb;
 	u32 hash;
 
@@ -5103,10 +5097,10 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 	skb_record_rx_queue(skb, queue);
 	napi_gro_receive(&ch->rxtx_napi, skb);
 
-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
-	rxq_stats->rx_pkt_n++;
-	rxq_stats->rx_bytes += len;
-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
+	u64_stats_update_begin(&rxq_stats->napi_syncp);
+	u64_stats_inc(&rxq_stats->napi.rx_pkt_n);
+	u64_stats_add(&rxq_stats->napi.rx_bytes, len);
+	u64_stats_update_end(&rxq_stats->napi_syncp);
 }
 
 static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
@@ -5188,7 +5182,6 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int desc_size;
 	struct bpf_prog *prog;
 	bool failure = false;
-	unsigned long flags;
 	int xdp_status = 0;
 	int status = 0;
 
@@ -5343,9 +5336,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 
 	stmmac_finalize_xdp_rx(priv, xdp_status);
 
-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
-	rxq_stats->rx_pkt_n += count;
-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
+	u64_stats_update_begin(&rxq_stats->napi_syncp);
+	u64_stats_add(&rxq_stats->napi.rx_pkt_n, count);
+	u64_stats_update_end(&rxq_stats->napi_syncp);
 
 	priv->xstats.rx_dropped += rx_dropped;
 	priv->xstats.rx_errors += rx_errors;
@@ -5383,7 +5376,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
-	unsigned long flags;
 	int xdp_status = 0;
 	int buf_sz;
 
@@ -5643,11 +5635,11 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 	stmmac_rx_refill(priv, queue);
 
-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
-	rxq_stats->rx_packets += rx_packets;
-	rxq_stats->rx_bytes += rx_bytes;
-	rxq_stats->rx_pkt_n += count;
-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
+	u64_stats_update_begin(&rxq_stats->napi_syncp);
+	u64_stats_add(&rxq_stats->napi.rx_packets, rx_packets);
+	u64_stats_add(&rxq_stats->napi.rx_bytes, rx_bytes);
+	u64_stats_add(&rxq_stats->napi.rx_pkt_n, count);
+	u64_stats_update_end(&rxq_stats->napi_syncp);
 
 	priv->xstats.rx_dropped += rx_dropped;
 	priv->xstats.rx_errors += rx_errors;
@@ -5662,13 +5654,12 @@ static int stmmac_napi_poll_rx(struct napi_struct *napi, int budget)
 	struct stmmac_priv *priv = ch->priv_data;
 	struct stmmac_rxq_stats *rxq_stats;
 	u32 chan = ch->index;
-	unsigned long flags;
 	int work_done;
 
 	rxq_stats = &priv->xstats.rxq_stats[chan];
-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
-	rxq_stats->napi_poll++;
-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
+	u64_stats_update_begin(&rxq_stats->napi_syncp);
+	u64_stats_inc(&rxq_stats->napi.poll);
+	u64_stats_update_end(&rxq_stats->napi_syncp);
 
 	work_done = stmmac_rx(priv, budget, chan);
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
@@ -5690,13 +5681,12 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 	struct stmmac_txq_stats *txq_stats;
 	bool pending_packets = false;
 	u32 chan = ch->index;
-	unsigned long flags;
 	int work_done;
 
 	txq_stats = &priv->xstats.txq_stats[chan];
-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
-	txq_stats->napi_poll++;
-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
+	u64_stats_update_begin(&txq_stats->napi_syncp);
+	u64_stats_inc(&txq_stats->napi.poll);
+	u64_stats_update_end(&txq_stats->napi_syncp);
 
 	work_done = stmmac_tx_clean(priv, budget, chan, &pending_packets);
 	work_done = min(work_done, budget);
@@ -5726,17 +5716,16 @@ static int stmmac_napi_poll_rxtx(struct napi_struct *napi, int budget)
 	struct stmmac_rxq_stats *rxq_stats;
 	struct stmmac_txq_stats *txq_stats;
 	u32 chan = ch->index;
-	unsigned long flags;
 
 	rxq_stats = &priv->xstats.rxq_stats[chan];
-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
-	rxq_stats->napi_poll++;
-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
+	u64_stats_update_begin(&rxq_stats->napi_syncp);
+	u64_stats_inc(&rxq_stats->napi.poll);
+	u64_stats_update_end(&rxq_stats->napi_syncp);
 
 	txq_stats = &priv->xstats.txq_stats[chan];
-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
-	txq_stats->napi_poll++;
-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
+	u64_stats_update_begin(&txq_stats->napi_syncp);
+	u64_stats_inc(&txq_stats->napi.poll);
+	u64_stats_update_end(&txq_stats->napi_syncp);
 
 	tx_done = stmmac_tx_clean(priv, budget, chan, &tx_pending_packets);
 	tx_done = min(tx_done, budget);
@@ -7062,10 +7051,13 @@ static void stmmac_get_stats64(struct net_device *dev, struct rtnl_link_stats64
 		u64 tx_bytes;
 
 		do {
-			start = u64_stats_fetch_begin(&txq_stats->syncp);
-			tx_packets = txq_stats->tx_packets;
-			tx_bytes   = txq_stats->tx_bytes;
-		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
+			start = u64_stats_fetch_begin(&txq_stats->q_syncp);
+			tx_bytes   = u64_stats_read(&txq_stats->q.tx_bytes);
+		} while (u64_stats_fetch_retry(&txq_stats->q_syncp, start));
+		do {
+			start = u64_stats_fetch_begin(&txq_stats->napi_syncp);
+			tx_packets = u64_stats_read(&txq_stats->napi.tx_packets);
+		} while (u64_stats_fetch_retry(&txq_stats->napi_syncp, start));
 
 		stats->tx_packets += tx_packets;
 		stats->tx_bytes += tx_bytes;
@@ -7077,10 +7069,10 @@ static void stmmac_get_stats64(struct net_device *dev, struct rtnl_link_stats64
 		u64 rx_bytes;
 
 		do {
-			start = u64_stats_fetch_begin(&rxq_stats->syncp);
-			rx_packets = rxq_stats->rx_packets;
-			rx_bytes   = rxq_stats->rx_bytes;
-		} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
+			start = u64_stats_fetch_begin(&rxq_stats->napi_syncp);
+			rx_packets = u64_stats_read(&rxq_stats->napi.rx_packets);
+			rx_bytes   = u64_stats_read(&rxq_stats->napi.rx_bytes);
+		} while (u64_stats_fetch_retry(&rxq_stats->napi_syncp, start));
 
 		stats->rx_packets += rx_packets;
 		stats->rx_bytes += rx_bytes;
@@ -7474,9 +7466,15 @@ int stmmac_dvr_probe(struct device *device,
 	priv->dev = ndev;
 
 	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
-		u64_stats_init(&priv->xstats.rxq_stats[i].syncp);
-	for (i = 0; i < MTL_MAX_TX_QUEUES; i++)
-		u64_stats_init(&priv->xstats.txq_stats[i].syncp);
+		u64_stats_init(&priv->xstats.rxq_stats[i].napi_syncp);
+	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
+		u64_stats_init(&priv->xstats.txq_stats[i].q_syncp);
+		u64_stats_init(&priv->xstats.txq_stats[i].napi_syncp);
+	}
+
+	priv->xstats.pcpu_stats = netdev_alloc_pcpu_stats(struct stmmac_pcpu_stats);
+	if (!priv->xstats.pcpu_stats)
+		return -ENOMEM;
 
 	stmmac_set_ethtool_ops(ndev);
 	priv->pause = pause;
@@ -7505,8 +7503,10 @@ int stmmac_dvr_probe(struct device *device,
 	stmmac_verify_args();
 
 	priv->af_xdp_zc_qps = bitmap_zalloc(MTL_MAX_TX_QUEUES, GFP_KERNEL);
-	if (!priv->af_xdp_zc_qps)
-		return -ENOMEM;
+	if (!priv->af_xdp_zc_qps) {
+		ret = -ENOMEM;
+		goto error_xdp_init;
+	}
 
 	/* Allocate workqueue */
 	priv->wq = create_singlethread_workqueue("stmmac_wq");
@@ -7762,6 +7762,8 @@ int stmmac_dvr_probe(struct device *device,
 	destroy_workqueue(priv->wq);
 error_wq_init:
 	bitmap_free(priv->af_xdp_zc_qps);
+error_xdp_init:
+	free_percpu(priv->xstats.pcpu_stats);
 
 	return ret;
 }
@@ -7800,6 +7802,7 @@ void stmmac_dvr_remove(struct device *dev)
 	destroy_workqueue(priv->wq);
 	mutex_destroy(&priv->lock);
 	bitmap_free(priv->af_xdp_zc_qps);
+	free_percpu(priv->xstats.pcpu_stats);
 
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
-- 
2.43.0


