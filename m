Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD167765F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjHIRCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjHIRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:02:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73732123;
        Wed,  9 Aug 2023 10:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68C6F641D6;
        Wed,  9 Aug 2023 17:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9D7C433C9;
        Wed,  9 Aug 2023 17:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691600523;
        bh=WYZtdfxDSNw9B+qNMFLdT206U/oHYajMdyw1mHyU1go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIqeT8gR5t01YZTbcT3H/SeM22/g1KthXDkJ+jNZXECi135sPuznPxZ9EKWSOd9Z0
         +E1J96k/s8djVqQF3erkve/8XraqBLblki820aI3o/4nblU6Nw2/xwsi5TKYcYDNgi
         Kvf0XYIqVguz/25Juc+C33TzpNY7MJRmZ3Us5haw8vZe0c+K+JqYLIAxIaucshuU6f
         aPrVd1v4Nx2tTqYdU/mKGFsJXwppHjAjC8gKP9yILrbu2XSPXYBc/d/yGX5gUWwQzO
         JvunHlUjT/1R9jhvY2DJv2lRZdESSq2yckgh5QZ1pNaxO0v/rk7nzGxNuqkRL5b4tU
         cKEVLJe9CuByg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v3 05/10] net: stmmac: reflect multi irqs for tx/rx channels and mac and safety
Date:   Thu, 10 Aug 2023 00:50:02 +0800
Message-Id: <20230809165007.1439-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230809165007.1439-1-jszhang@kernel.org>
References: <20230809165007.1439-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP supports per channel interrupt, when intel adds the per channel
interrupt support, the per channel irq is from MSI vector, but this
feature can also be supported on non-MSI platforms. Do some necessary
renaming to reflects this fact.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 48 +++++++++----------
 include/linux/stmmac.h                        |  4 +-
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 0ffae785d8bd..99a072907008 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -953,7 +953,7 @@ static int stmmac_config_single_msi(struct pci_dev *pdev,
 
 	res->irq = pci_irq_vector(pdev, 0);
 	res->wol_irq = res->irq;
-	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
+	plat->flags &= ~STMMAC_FLAG_PERCH_IRQ_EN;
 	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
 		 __func__);
 
@@ -1005,7 +1005,7 @@ static int stmmac_config_multi_msi(struct pci_dev *pdev,
 	if (plat->msi_sfty_ue_vec < STMMAC_MSI_VEC_MAX)
 		res->sfty_ue_irq = pci_irq_vector(pdev, plat->msi_sfty_ue_vec);
 
-	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+	plat->flags |= STMMAC_FLAG_PERCH_IRQ_EN;
 	dev_info(&pdev->dev, "%s: multi MSI enablement successful\n", __func__);
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 84d3a8551b03..9bf8adf466a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -175,7 +175,7 @@ static void dwmac4_dma_init(void __iomem *ioaddr,
 
 	value = readl(ioaddr + DMA_BUS_MODE);
 
-	if (dma_cfg->multi_msi_en) {
+	if (dma_cfg->perch_irq_en) {
 		value &= ~DMA_BUS_MODE_INTM_MASK;
 		value |= (DMA_BUS_MODE_INTM_MODE1 << DMA_BUS_MODE_INTM_SHIFT);
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 15ed3947361b..4ed5c976c7a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -125,11 +125,11 @@ module_param(chain_mode, int, 0444);
 MODULE_PARM_DESC(chain_mode, "To use chain instead of ring mode");
 
 static irqreturn_t stmmac_interrupt(int irq, void *dev_id);
-/* For MSI interrupts handling */
+/* For multi interrupts handling */
 static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id);
 static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id);
-static irqreturn_t stmmac_msi_intr_tx(int irq, void *data);
-static irqreturn_t stmmac_msi_intr_rx(int irq, void *data);
+static irqreturn_t stmmac_queue_intr_tx(int irq, void *data);
+static irqreturn_t stmmac_queue_intr_rx(int irq, void *data);
 static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue);
 static void stmmac_reset_tx_queue(struct stmmac_priv *priv, u32 queue);
 static void stmmac_reset_queues_param(struct stmmac_priv *priv);
@@ -3513,7 +3513,7 @@ static void stmmac_free_irq(struct net_device *dev,
 	}
 }
 
-static int stmmac_request_irq_multi_msi(struct net_device *dev)
+static int stmmac_request_irq_multi(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	enum request_irq_err irq_err;
@@ -3530,7 +3530,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 			  0, int_name, dev);
 	if (unlikely(ret < 0)) {
 		netdev_err(priv->dev,
-			   "%s: alloc mac MSI %d (error: %d)\n",
+			   "%s: alloc mac irq %d (error: %d)\n",
 			   __func__, dev->irq, ret);
 		irq_err = REQ_IRQ_ERR_MAC;
 		goto irq_error;
@@ -3547,7 +3547,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 				  0, int_name, dev);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
-				   "%s: alloc wol MSI %d (error: %d)\n",
+				   "%s: alloc wol irq %d (error: %d)\n",
 				   __func__, priv->wol_irq, ret);
 			irq_err = REQ_IRQ_ERR_WOL;
 			goto irq_error;
@@ -3565,7 +3565,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 				  0, int_name, dev);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
-				   "%s: alloc lpi MSI %d (error: %d)\n",
+				   "%s: alloc lpi irq %d (error: %d)\n",
 				   __func__, priv->lpi_irq, ret);
 			irq_err = REQ_IRQ_ERR_LPI;
 			goto irq_error;
@@ -3583,7 +3583,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 				  0, int_name, dev);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
-				   "%s: alloc sfty ce MSI %d (error: %d)\n",
+				   "%s: alloc sfty ce irq %d (error: %d)\n",
 				   __func__, priv->sfty_ce_irq, ret);
 			irq_err = REQ_IRQ_ERR_SFTY_CE;
 			goto irq_error;
@@ -3601,14 +3601,14 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 				  0, int_name, dev);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
-				   "%s: alloc sfty ue MSI %d (error: %d)\n",
+				   "%s: alloc sfty ue irq %d (error: %d)\n",
 				   __func__, priv->sfty_ue_irq, ret);
 			irq_err = REQ_IRQ_ERR_SFTY_UE;
 			goto irq_error;
 		}
 	}
 
-	/* Request Rx MSI irq */
+	/* Request Rx queue irq */
 	for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
 		if (i >= MTL_MAX_RX_QUEUES)
 			break;
@@ -3618,11 +3618,11 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		int_name = priv->int_name_rx_irq[i];
 		sprintf(int_name, "%s:%s-%d", dev->name, "rx", i);
 		ret = request_irq(priv->rx_irq[i],
-				  stmmac_msi_intr_rx,
+				  stmmac_queue_intr_rx,
 				  0, int_name, &priv->dma_conf.rx_queue[i]);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
-				   "%s: alloc rx-%d  MSI %d (error: %d)\n",
+				   "%s: alloc rx-%d irq %d (error: %d)\n",
 				   __func__, i, priv->rx_irq[i], ret);
 			irq_err = REQ_IRQ_ERR_RX;
 			irq_idx = i;
@@ -3633,7 +3633,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		irq_set_affinity_hint(priv->rx_irq[i], &cpu_mask);
 	}
 
-	/* Request Tx MSI irq */
+	/* Request Tx queue irq */
 	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 		if (i >= MTL_MAX_TX_QUEUES)
 			break;
@@ -3643,11 +3643,11 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		int_name = priv->int_name_tx_irq[i];
 		sprintf(int_name, "%s:%s-%d", dev->name, "tx", i);
 		ret = request_irq(priv->tx_irq[i],
-				  stmmac_msi_intr_tx,
+				  stmmac_queue_intr_tx,
 				  0, int_name, &priv->dma_conf.tx_queue[i]);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
-				   "%s: alloc tx-%d  MSI %d (error: %d)\n",
+				   "%s: alloc tx-%d irq %d (error: %d)\n",
 				   __func__, i, priv->tx_irq[i], ret);
 			irq_err = REQ_IRQ_ERR_TX;
 			irq_idx = i;
@@ -3722,8 +3722,8 @@ static int stmmac_request_irq(struct net_device *dev)
 	int ret;
 
 	/* Request the IRQ lines */
-	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
-		ret = stmmac_request_irq_multi_msi(dev);
+	if (priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN)
+		ret = stmmac_request_irq_multi(dev);
 	else
 		ret = stmmac_request_irq_single(dev);
 
@@ -5938,7 +5938,7 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
+static irqreturn_t stmmac_queue_intr_tx(int irq, void *data)
 {
 	struct stmmac_tx_queue *tx_q = (struct stmmac_tx_queue *)data;
 	struct stmmac_dma_conf *dma_conf;
@@ -5970,7 +5970,7 @@ static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
+static irqreturn_t stmmac_queue_intr_rx(int irq, void *data)
 {
 	struct stmmac_rx_queue *rx_q = (struct stmmac_rx_queue *)data;
 	struct stmmac_dma_conf *dma_conf;
@@ -6007,12 +6007,12 @@ static void stmmac_poll_controller(struct net_device *dev)
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return;
 
-	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN) {
+	if (priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN) {
 		for (i = 0; i < priv->plat->rx_queues_to_use; i++)
-			stmmac_msi_intr_rx(0, &priv->dma_conf.rx_queue[i]);
+			stmmac_queue_intr_rx(0, &priv->dma_conf.rx_queue[i]);
 
 		for (i = 0; i < priv->plat->tx_queues_to_use; i++)
-			stmmac_msi_intr_tx(0, &priv->dma_conf.tx_queue[i]);
+			stmmac_queue_intr_tx(0, &priv->dma_conf.tx_queue[i]);
 	} else {
 		disable_irq(dev->irq);
 		stmmac_interrupt(dev->irq, dev);
@@ -7278,8 +7278,8 @@ int stmmac_dvr_probe(struct device *device,
 	priv->plat = plat_dat;
 	priv->ioaddr = res->addr;
 	priv->dev->base_addr = (unsigned long)res->addr;
-	priv->plat->dma_cfg->multi_msi_en =
-		(priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN);
+	priv->plat->dma_cfg->perch_irq_en =
+		(priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN);
 
 	priv->dev->irq = res->irq;
 	priv->wol_irq = res->wol_irq;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 11671fd6adee..76249117c0ff 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -96,7 +96,7 @@ struct stmmac_dma_cfg {
 	int mixed_burst;
 	bool aal;
 	bool eame;
-	bool multi_msi_en;
+	bool perch_irq_en;
 	bool dche;
 };
 
@@ -211,7 +211,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_TSO_EN			BIT(4)
 #define STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP	BIT(5)
 #define STMMAC_FLAG_VLAN_FAIL_Q_EN		BIT(6)
-#define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
+#define STMMAC_FLAG_PERCH_IRQ_EN		BIT(7)
 #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
 #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
 #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
-- 
2.40.1

