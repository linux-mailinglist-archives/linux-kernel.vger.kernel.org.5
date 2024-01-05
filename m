Return-Path: <linux-kernel+bounces-17536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476BE824F04
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2987282666
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F8220DD0;
	Fri,  5 Jan 2024 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaVI/yb9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ACE20B38;
	Fri,  5 Jan 2024 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704438596; x=1735974596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qpk5fzveoFhUluV2ZN4VFXoIMNZqp+151K6IiI2ClQg=;
  b=TaVI/yb95v1btNBesay1WVtS/HQcd6NdCABpqi5ghCvaftvoWVWhlYOa
   KlfSweuhRl0VUjOYnppI7tZYeUipzhePw+zQF35Uydj4YXp3SdCS201Va
   s2+0T+da2dLHZ/EeZJAwLJWUg/o1jRS5jypaZ2p9B+Zi8HqQoiT75fXql
   RlGo2vq+QlQmEFNWcgye1816bkySxSp4loF0nwGyYFZRuhXLOwjOMwvc+
   s29ud0BD2/of4D8YmgF/NC5Ye7kT18gFv/Q0bQn6QB0rvjbw5Oj35v9kc
   3nCIpv7RhMwnumvnN9iHUKYCw0W99p/jB3+b2pkEye3iVDCeq3IYWZLvS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="463845836"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="463845836"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 23:09:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="871167275"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="871167275"
Received: from pg-esw-build.png.intel.com ([10.226.214.65])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jan 2024 23:09:51 -0800
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
Subject: [PATCH net-next v2 2/4] net: stmmac: Make MSI interrupt routine generic
Date: Fri,  5 Jan 2024 15:09:23 +0800
Message-Id: <20240105070925.2948871-3-leong.ching.swee@intel.com>
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

There is no support for per DMA channel interrupt for non-MSI platform,
where the MAC's per channel interrupt hooks up to interrupt controller(GIC)
through shared peripheral interrupt(SPI) to handle interrupt from TX/RX
transmit channel.

This patch generalize the existing MSI ISR to also support non-MSI
platform.

Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +--
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  3 ++
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 30 +++++++++----------
 include/linux/stmmac.h                        |  4 +--
 5 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 60283543ffc8..f0ec69af96c9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -952,7 +952,7 @@ static int stmmac_config_single_msi(struct pci_dev *pdev,
 
 	res->irq = pci_irq_vector(pdev, 0);
 	res->wol_irq = res->irq;
-	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
+	plat->flags &= ~STMMAC_FLAG_MULTI_IRQ_EN;
 	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
 		 __func__);
 
@@ -1004,7 +1004,7 @@ static int stmmac_config_multi_msi(struct pci_dev *pdev,
 	if (plat->msi_sfty_ue_vec < STMMAC_MSI_VEC_MAX)
 		res->sfty_ue_irq = pci_irq_vector(pdev, plat->msi_sfty_ue_vec);
 
-	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+	plat->flags |= STMMAC_FLAG_MULTI_IRQ_EN;
 	dev_info(&pdev->dev, "%s: multi MSI enablement successful\n", __func__);
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index ba2ce776bd4d..cf43fb3c6cc5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -427,6 +427,9 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
 
+	if (stmmac_res.rx_irq[0] > 0 && stmmac_res.tx_irq[0] > 0)
+		plat_dat->flags |= STMMAC_FLAG_MULTI_IRQ_EN;
+
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
 		return ret;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 84d3a8551b03..5f649106ffcd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -175,7 +175,7 @@ static void dwmac4_dma_init(void __iomem *ioaddr,
 
 	value = readl(ioaddr + DMA_BUS_MODE);
 
-	if (dma_cfg->multi_msi_en) {
+	if (dma_cfg->multi_irq_en) {
 		value &= ~DMA_BUS_MODE_INTM_MASK;
 		value |= (DMA_BUS_MODE_INTM_MODE1 << DMA_BUS_MODE_INTM_SHIFT);
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 47de466e432c..57873b879b33 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -129,8 +129,8 @@ static irqreturn_t stmmac_interrupt(int irq, void *dev_id);
 /* For MSI interrupts handling */
 static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id);
 static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id);
-static irqreturn_t stmmac_msi_intr_tx(int irq, void *data);
-static irqreturn_t stmmac_msi_intr_rx(int irq, void *data);
+static irqreturn_t stmmac_dma_tx_interrupt(int irq, void *data);
+static irqreturn_t stmmac_dma_rx_interrupt(int irq, void *data);
 static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue);
 static void stmmac_reset_tx_queue(struct stmmac_priv *priv, u32 queue);
 static void stmmac_reset_queues_param(struct stmmac_priv *priv);
@@ -3602,7 +3602,7 @@ static void stmmac_free_irq(struct net_device *dev,
 	}
 }
 
-static int stmmac_request_irq_multi_msi(struct net_device *dev)
+static int stmmac_request_irq_multi(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	enum request_irq_err irq_err;
@@ -3697,7 +3697,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		}
 	}
 
-	/* Request Rx MSI irq */
+	/* Request Rx irq */
 	for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
 		if (i >= MTL_MAX_RX_QUEUES)
 			break;
@@ -3707,11 +3707,11 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		int_name = priv->int_name_rx_irq[i];
 		sprintf(int_name, "%s:%s-%d", dev->name, "rx", i);
 		ret = request_irq(priv->rx_irq[i],
-				  stmmac_msi_intr_rx,
+				  stmmac_dma_rx_interrupt,
 				  0, int_name, &priv->dma_conf.rx_queue[i]);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
-				   "%s: alloc rx-%d  MSI %d (error: %d)\n",
+				   "%s: alloc rx-%d  dma rx_irq %d (error: %d)\n",
 				   __func__, i, priv->rx_irq[i], ret);
 			irq_err = REQ_IRQ_ERR_RX;
 			irq_idx = i;
@@ -3722,7 +3722,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		irq_set_affinity_hint(priv->rx_irq[i], &cpu_mask);
 	}
 
-	/* Request Tx MSI irq */
+	/* Request Tx irq */
 	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 		if (i >= MTL_MAX_TX_QUEUES)
 			break;
@@ -3732,11 +3732,11 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		int_name = priv->int_name_tx_irq[i];
 		sprintf(int_name, "%s:%s-%d", dev->name, "tx", i);
 		ret = request_irq(priv->tx_irq[i],
-				  stmmac_msi_intr_tx,
+				  stmmac_dma_tx_interrupt,
 				  0, int_name, &priv->dma_conf.tx_queue[i]);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
-				   "%s: alloc tx-%d  MSI %d (error: %d)\n",
+				   "%s: alloc tx-%d  dma tx_irq %d (error: %d)\n",
 				   __func__, i, priv->tx_irq[i], ret);
 			irq_err = REQ_IRQ_ERR_TX;
 			irq_idx = i;
@@ -3811,8 +3811,8 @@ static int stmmac_request_irq(struct net_device *dev)
 	int ret;
 
 	/* Request the IRQ lines */
-	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
-		ret = stmmac_request_irq_multi_msi(dev);
+	if (priv->plat->flags & STMMAC_FLAG_MULTI_IRQ_EN)
+		ret = stmmac_request_irq_multi(dev);
 	else
 		ret = stmmac_request_irq_single(dev);
 
@@ -6075,7 +6075,7 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
+static irqreturn_t stmmac_dma_tx_interrupt(int irq, void *data)
 {
 	struct stmmac_tx_queue *tx_q = (struct stmmac_tx_queue *)data;
 	struct stmmac_dma_conf *dma_conf;
@@ -6107,7 +6107,7 @@ static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
+static irqreturn_t stmmac_dma_rx_interrupt(int irq, void *data)
 {
 	struct stmmac_rx_queue *rx_q = (struct stmmac_rx_queue *)data;
 	struct stmmac_dma_conf *dma_conf;
@@ -7456,8 +7456,8 @@ int stmmac_dvr_probe(struct device *device,
 	priv->plat = plat_dat;
 	priv->ioaddr = res->addr;
 	priv->dev->base_addr = (unsigned long)res->addr;
-	priv->plat->dma_cfg->multi_msi_en =
-		(priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN);
+	priv->plat->dma_cfg->multi_irq_en =
+		(priv->plat->flags & STMMAC_FLAG_MULTI_IRQ_EN);
 
 	priv->dev->irq = res->irq;
 	priv->wol_irq = res->wol_irq;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dee5ad6e48c5..b950e6f9761d 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -98,7 +98,7 @@ struct stmmac_dma_cfg {
 	int mixed_burst;
 	bool aal;
 	bool eame;
-	bool multi_msi_en;
+	bool multi_irq_en;
 	bool dche;
 };
 
@@ -215,7 +215,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_TSO_EN			BIT(4)
 #define STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP	BIT(5)
 #define STMMAC_FLAG_VLAN_FAIL_Q_EN		BIT(6)
-#define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
+#define STMMAC_FLAG_MULTI_IRQ_EN		BIT(7)
 #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
 #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
 #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
-- 
2.34.1


