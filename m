Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9956D75E3B3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjGWQXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGWQXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982B61BE4;
        Sun, 23 Jul 2023 09:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71D5060E03;
        Sun, 23 Jul 2023 16:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE3FC433C9;
        Sun, 23 Jul 2023 16:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690129365;
        bh=qDI0Xb5iaQWdsQql8g8clSdLAw51YwA2gB/y/HlqbvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fVXln860LhUZcxF5EYN3gLM6af9tazNAY7YXKWeCJndIKqyXeMu8VBtbEEPrnnJJf
         pgz4q/ToKIP59p1+VzHxLLHDojPmJpfu0VZcIeBw499UMjt6dovJefE8Bm6ebXkBzE
         e3GORnARNutWgspjrF8VJVtzJFUV9kXshfdBhK3NLiM0tstmPOEX65Y/pLoCWvthUF
         yBj/TQlm45C85bQyDIsPSsVK6aGGJlJPVTuMfLewFSeD2ttgfHGRpi+lbPKHUa4+ds
         01IoMUIfk6k+eucfSvTVZiopFDKcMOsJYKFFC1WCH56N91vHrSJnw54cSH8BS6irtC
         JMTiTPs3TaUMw==
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
Subject: [PATCH net-next 10/10] net: stmmac: platform: support parsing per channel irq from DT
Date:   Mon, 24 Jul 2023 00:10:29 +0800
Message-Id: <20230723161029.1345-11-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230723161029.1345-1-jszhang@kernel.org>
References: <20230723161029.1345-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index e1b7a3fefd1a..16fff66c578b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -539,10 +539,14 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	if (of_device_is_compatible(np, "snps,dwxgmac")) {
 		plat->has_xgmac = 1;
 		plat->pmt = 1;
+
 		if (of_property_read_bool(np, "snps,tso"))
 			plat->flags |= STMMAC_FLAG_TSO_EN;
 	}
 
+	if (of_property_read_bool(np, "snps,per-channel-interrupt"))
+		plat->flags |= STMMAC_FLAG_PERCH_IRQ_EN;
+
 	dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*dma_cfg),
 			       GFP_KERNEL);
 	if (!dma_cfg) {
@@ -705,6 +709,9 @@ EXPORT_SYMBOL_GPL(stmmac_remove_config_dt);
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res)
 {
+	char irq_name[8];
+	int i;
+
 	memset(stmmac_res, 0, sizeof(*stmmac_res));
 
 	/* Get IRQ information early to have an ability to ask for deferred
@@ -738,6 +745,26 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
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
 	stmmac_res->sfty_ce_irq = platform_get_irq_byname_optional(pdev, "sfty_ce_irq");
 	if (stmmac_res->sfty_ce_irq < 0) {
 		if (stmmac_res->sfty_ce_irq == -EPROBE_DEFER)
-- 
2.40.1

