Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5CF77FCB9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353892AbjHQRKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353869AbjHQRKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449472136;
        Thu, 17 Aug 2023 10:10:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE194675C1;
        Thu, 17 Aug 2023 17:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795D1C433CC;
        Thu, 17 Aug 2023 17:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292202;
        bh=IR6gUNrGlpvXPqUl6ePu23Yb6z5yLdZcfdC0Vl1Tk5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOgqtLSvVE7GaAYuEOY1QQVKqR/aWnRL6qArTZKkIzyUuFnur3EN4pXVMdXyyIYOF
         MpqH4+lNowBpEX69kkTJ9u5ZRywciLVWgwl58JF6KcwE8CXAZCWSKv8akgnm9KvVxf
         yNfhZUEHyw6xMo4a4XSkbD1ghvJV1XNN4nPgxyQ+MlyjTfoLbEjXswY1YTgBPRunkR
         vtU2EkuO5Izs/qJlL5qkomGoI/SkEn0NMwh3mJ7Ng/BM3BXMlp/NkeEtgIYaEC1Oo4
         KmxizblmMKBLZvZu5b2KGdEL3jZwCsRAGNSKI3lJUK8gdDoKfgIXLxCuki8g8wnyJb
         piBqRfmbMcSWw==
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
Subject: [PATCH net-next v5 9/9] net: stmmac: platform: support parsing per channel irq from DT
Date:   Fri, 18 Aug 2023 00:57:49 +0800
Message-Id: <20230817165749.672-10-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230817165749.672-1-jszhang@kernel.org>
References: <20230817165749.672-1-jszhang@kernel.org>
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

