Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD10975E3B0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGWQXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGWQXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:23:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064D91BCE;
        Sun, 23 Jul 2023 09:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F1E460DE1;
        Sun, 23 Jul 2023 16:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B70DC433C7;
        Sun, 23 Jul 2023 16:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690129359;
        bh=MaxTaoMyyDWzQBV6I+FK3rgck7sS3ApGLGnjzW2cn+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFSME35aBjT6vZDW9QtPvsJj3vL8Jw7DHgV+gZyPMXkzG4NSP4D+lrFRLSXwXtbL9
         zdLu1VVnA4MommD+Zf4IYG8ybqdroqfL0UEeXaChihhkq5IOJrqF+dV09mhxRIkvIQ
         KADe5leCtMBc9JMgAoL/RJp4DMANuD+9UPpQsNRAhLwrFAak9Q9DbTi727MJs+zqu9
         Agb90tdhpyPnoWI98JCyWYupXpOv3/Uht+kStuVUUCMOt0MOGDhpZsZoE8F0Yj9Fc7
         fVJhKx/xsOhbU6PGnMwLcyIC11xZf7rILVaOT2WasdCXAMEMquADxvCRHhWlzSQOVP
         h8x5Nmhhp50hw==
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
Subject: [PATCH net-next 08/10] net: stmmac: platform: support parsing safety irqs from DT
Date:   Mon, 24 Jul 2023 00:10:27 +0800
Message-Id: <20230723161029.1345-9-jszhang@kernel.org>
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

The snps dwmac IP may support safety features, and those Safety
Feature Correctible Error and Uncorrectible Error irqs may be
separate irqs. Add support to parse the safety irqs from DT.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 23d53ea04b24..e1b7a3fefd1a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -738,6 +738,18 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
 	}
 
+	stmmac_res->sfty_ce_irq = platform_get_irq_byname_optional(pdev, "sfty_ce_irq");
+	if (stmmac_res->sfty_ce_irq < 0) {
+		if (stmmac_res->sfty_ce_irq == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
+	stmmac_res->sfty_ue_irq = platform_get_irq_byname_optional(pdev, "sfty_ue_irq");
+	if (stmmac_res->sfty_ue_irq < 0) {
+		if (stmmac_res->sfty_ue_irq == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
 	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
 
 	return PTR_ERR_OR_ZERO(stmmac_res->addr);
-- 
2.40.1

