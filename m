Return-Path: <linux-kernel+bounces-9377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F7481C4C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518C928814A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628AE9475;
	Fri, 22 Dec 2023 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dY98KLm9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D40BD530;
	Fri, 22 Dec 2023 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703223986; x=1734759986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jKRp9iRvAm9GuBLgpwNJYxVqDu1ubCTAkbYv82hvvk0=;
  b=dY98KLm9GcJddDdUEzvEZ6nxPLnhxeJK88g56ZM5qFJuwB2fmfdSM9Wp
   JTU+ph/CNMCA1MC+hdOz866tnWcOe/UVzJy3JBgc6IzTSBY0r62lnjErX
   NabGus/LaLVAuEOONaB/9+4S51xUJgu4whyMBfWO9a3SC//zrIbwSniH3
   GM6RxAseGCNVkPH4RbAc0geIsRXgP2u4Y9WqH99Gc6IlgRL6+NiqzHMBf
   0554amnJO4UiBBo8Gw86cpG812+epFU5ySW+VvVFZhbPzkyWQvKgCTh+T
   82puphggOLGKbz3xxCZ02kJPikPjMkyUTbzVywOHpy3y8KPkFvckumwPq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="9470609"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="9470609"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 21:46:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="900324247"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="900324247"
Received: from pg-esw-build.png.intel.com ([10.226.214.57])
  by orsmga004.jf.intel.com with ESMTP; 21 Dec 2023 21:46:21 -0800
From: Leong Ching Swee <leong.ching.swee@intel.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Swee Leong Ching <leong.ching.swee@intel.com>,
	Teoh Ji Sheng <ji.sheng.teoh@intel.com>
Subject: [PATCH net-next v1 4/4] net: stmmac: Use interrupt mode INTM=1 for per channel irq
Date: Fri, 22 Dec 2023 13:44:51 +0800
Message-Id: <20231222054451.2683242-5-leong.ching.swee@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222054451.2683242-1-leong.ching.swee@intel.com>
References: <20231222054451.2683242-1-leong.ching.swee@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Swee Leong Ching <leong.ching.swee@intel.com>

Enable per DMA channel interrupt that uses shared peripheral
interrupt (SPI), so only per channel TX and RX intr (TI/RI)
are handled by TX/RX ISR without calling common interrupt ISR.

Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 32 +++++++++++--------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 207ff1799f2c..04bf731cb7ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -346,6 +346,9 @@
 /* DMA Registers */
 #define XGMAC_DMA_MODE			0x00003000
 #define XGMAC_SWR			BIT(0)
+#define XGMAC_DMA_MODE_INTM_MASK	GENMASK(13, 12)
+#define XGMAC_DMA_MODE_INTM_SHIFT	12
+#define XGMAC_DMA_MODE_INTM_MODE1	0x1
 #define XGMAC_DMA_SYSBUS_MODE		0x00003004
 #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
 #define XGMAC_WR_OSR_LMT_SHIFT		24
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 3cde695fec91..dcb9f094415d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -31,6 +31,13 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
 		value |= XGMAC_EAME;
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	if (dma_cfg->multi_irq_en) {
+		value = readl(ioaddr + XGMAC_DMA_MODE);
+		value &= ~XGMAC_DMA_MODE_INTM_MASK;
+		value |= (XGMAC_DMA_MODE_INTM_MODE1 << XGMAC_DMA_MODE_INTM_SHIFT);
+		writel(value, ioaddr + XGMAC_DMA_MODE);
+	}
 }
 
 static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
@@ -365,19 +372,18 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 	}
 
 	/* TX/RX NORMAL interrupts */
-	if (likely(intr_status & XGMAC_NIS)) {
-		if (likely(intr_status & XGMAC_RI)) {
-			u64_stats_update_begin(&rxq_stats->syncp);
-			rxq_stats->rx_normal_irq_n++;
-			u64_stats_update_end(&rxq_stats->syncp);
-			ret |= handle_rx;
-		}
-		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
-			u64_stats_update_begin(&txq_stats->syncp);
-			txq_stats->tx_normal_irq_n++;
-			u64_stats_update_end(&txq_stats->syncp);
-			ret |= handle_tx;
-		}
+	if (likely(intr_status & XGMAC_RI)) {
+		u64_stats_update_begin(&rxq_stats->syncp);
+		rxq_stats->rx_normal_irq_n++;
+		u64_stats_update_end(&rxq_stats->syncp);
+		ret |= handle_rx;
+	}
+
+	if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
+		u64_stats_update_begin(&txq_stats->syncp);
+		txq_stats->tx_normal_irq_n++;
+		u64_stats_update_end(&txq_stats->syncp);
+		ret |= handle_tx;
 	}
 
 	/* Clear interrupts */
-- 
2.34.1


