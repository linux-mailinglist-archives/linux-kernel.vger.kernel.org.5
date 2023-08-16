Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6277E56F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbjHPPmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344278AbjHPPlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:41:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D696B26A6;
        Wed, 16 Aug 2023 08:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AFA065150;
        Wed, 16 Aug 2023 15:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5050FC433CC;
        Wed, 16 Aug 2023 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692200510;
        bh=IR6gUNrGlpvXPqUl6ePu23Yb6z5yLdZcfdC0Vl1Tk5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDBHKHzTzqYtf84tuKMNpO7JrsBxgJrYjlAJD7mOc/vcFT4TR5PZYH166vxaDX7w/
         myNG8+jyyjHhCuqo5YSIE1Z0qBk3QhHLRaP9OPM/VX0XKhRtLwzesQGf4Nm2dbZrCH
         EhxstAPdlpX+6sFHg0xvQ9dXjXAkUvmhyk8Cv9rTdeLAwnGmqsnNFXRf2/lhTyK3Pk
         lfoeka0qnkHDb8sDyiPc44BcNxycCi01HfGe8vJyYw7y+GEZzLhnyyGml6HOFuo3gm
         eELsWcnl+5cVAuvySfHx/1EPNtiSJSWUi6BAZTjJ4p0/vAPD88TGDm+C+F594DkI2L
         AjYhvf8ec/31w==
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
Subject: [PATCH net-next v4 9/9] net: stmmac: platform: support parsing per channel irq from DT
Date:   Wed, 16 Aug 2023 23:29:26 +0800
Message-Id: <20230816152926.4093-10-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230816152926.4093-1-jszhang@kernel.org>
References: <20230816152926.4093-1-jszhang@kernel.org>
MIME-Version: 1.0
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

The snps dwmac IP may support per channel interrupt. Add support to
parse the per channel irq from DT.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++----
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 23 +++++++++++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 64c55024d69d..d4a8d7b48ad2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3619,7 +3619,7 @@ static int stmmac_request_irq_multi_channel(struct net_device *dev)
 	for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
 		if (i >= MTL_MAX_RX_QUEUES)
 			break;
-		if (priv->rx_irq[i] == 0)
+		if (priv->rx_irq[i] <= 0)
 			continue;
 
 		int_name = priv->int_name_rx_irq[i];
@@ -3644,7 +3644,7 @@ static int stmmac_request_irq_multi_channel(struct net_device *dev)
 	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 		if (i >= MTL_MAX_TX_QUEUES)
 			break;
-		if (priv->tx_irq[i] == 0)
+		if (priv->tx_irq[i] <= 0)
 			continue;
 
 		int_name = priv->int_name_tx_irq[i];
@@ -7300,8 +7300,10 @@ int stmmac_dvr_probe(struct device *device,
 	priv->plat = plat_dat;
 	priv->ioaddr = res->addr;
 	priv->dev->base_addr = (unsigned long)res->addr;
-	priv->plat->dma_cfg->perch_irq_en =
-		(priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN);
+	if (res->rx_irq[0] > 0 && res->tx_irq[0] > 0) {
+		priv->plat->flags |= STMMAC_FLAG_PERCH_IRQ_EN;
+		priv->plat->dma_cfg->perch_irq_en = true;
+	}
 
 	priv->dev->irq = res->irq;
 	priv->wol_irq = res->wol_irq;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 4a2002eea870..0fb9868aeffc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -704,6 +704,9 @@ EXPORT_SYMBOL_GPL(stmmac_remove_config_dt);
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res)
 {
+	char irq_name[8];
+	int i;
+
 	memset(stmmac_res, 0, sizeof(*stmmac_res));
 
 	/* Get IRQ information early to have an ability to ask for deferred
@@ -737,6 +740,26 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
 	}
 
+	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
+		snprintf(irq_name, sizeof(irq_name), "rx%i", i);
+		stmmac_res->rx_irq[i] = platform_get_irq_byname_optional(pdev, irq_name);
+		if (stmmac_res->rx_irq[i] < 0) {
+			if (stmmac_res->rx_irq[i] == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			break;
+		}
+	}
+
+	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
+		snprintf(irq_name, sizeof(irq_name), "tx%i", i);
+		stmmac_res->tx_irq[i] = platform_get_irq_byname_optional(pdev, irq_name);
+		if (stmmac_res->tx_irq[i] < 0) {
+			if (stmmac_res->tx_irq[i] == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			break;
+		}
+	}
+
 	stmmac_res->sfty_ce_irq = platform_get_irq_byname_optional(pdev, "sfty_ce");
 	if (stmmac_res->sfty_ce_irq < 0) {
 		if (stmmac_res->sfty_ce_irq == -EPROBE_DEFER)
-- 
2.40.1

