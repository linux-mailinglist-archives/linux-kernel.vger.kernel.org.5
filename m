Return-Path: <linux-kernel+bounces-17538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDD0824F0B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6421C22B8E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834DF200CC;
	Fri,  5 Jan 2024 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEhGEes8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D1134A2;
	Fri,  5 Jan 2024 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704438617; x=1735974617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jKRp9iRvAm9GuBLgpwNJYxVqDu1ubCTAkbYv82hvvk0=;
  b=EEhGEes87jjIARuvLrViC05T6c4DfkZk48tu1j+i5H/LCbrgoKjgFQZu
   n47EYX29g0qip0O3geQkUwx9bt82VFUWvzTaSh98x+CzkA+DmPYTE5gBd
   SJQl8W2dl2aqf1X+bKTAL297jtXCCJAvXJWCAG95x7BRcpD4bJOmu2qbf
   TAoX8Rf87T7othRi/ps1QZ6bbaaGKci8rFQkmIsYezAyASQu9//yCJsMH
   6d4p0+Ae6yuDSEgCH0Kf+n86+TIODN3BHe2JHDgNsQC4U4n+rANOh7esM
   cbuIW7oV6Rvcq3mbR3pDPs5YxV2OELqYmULbro3L/Mu5rHgC4I7lzzws8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="463845895"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="463845895"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 23:10:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="871167373"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="871167373"
Received: from pg-esw-build.png.intel.com ([10.226.214.65])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jan 2024 23:10:02 -0800
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
Subject: [PATCH net-next v2 4/4] net: stmmac: Use interrupt mode INTM=1 for per channel irq
Date: Fri,  5 Jan 2024 15:09:25 +0800
Message-Id: <20240105070925.2948871-5-leong.ching.swee@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105070925.2948871-1-leong.ching.swee@intel.com>
References: <20240105070925.2948871-1-leong.ching.swee@intel.com>
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


