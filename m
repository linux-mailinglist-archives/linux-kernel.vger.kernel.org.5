Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68977E56D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbjHPPmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbjHPPln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:41:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6C426A6;
        Wed, 16 Aug 2023 08:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A1EB65150;
        Wed, 16 Aug 2023 15:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA46C433C7;
        Wed, 16 Aug 2023 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692200502;
        bh=kv75d6y4CuM21MoxPELNwCryPzdrLaz2U6/TZ1c2g/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V8sQgisoo15AHP3j6yHL9E3pgXFlue0Sq+NgZp1L8JyIfxnDSEteT6T+ROFOvk367
         W6XX6TcGdPRX3GSu0ZlqjSwl8IBhmyd5f8TqJrHx/r+WaWuUoQHTY1/8Ag6I2LdUvB
         6oTGcLA8h6UbSwMQJ03n+Mxfr4yHUiLKPxwKvADu48ifLdYwBam5eJPgZ64KuqhbT9
         5tgtmhn7bRElDi+VvdpdHNyAY7kaCP9gHDSM5SX/wrILVJ2lSklRMGIWu5VG0CIWND
         15C/PXB8sbhNotlqujxMS/y/HYYbQdp/He0lXm/NzSS5aogoaJimyfONRYRXkvIRDT
         gKsMlJoD2pIaA==
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
Subject: [PATCH net-next v4 7/9] net: stmmac: platform: support parsing safety irqs from DT
Date:   Wed, 16 Aug 2023 23:29:24 +0800
Message-Id: <20230816152926.4093-8-jszhang@kernel.org>
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

The snps dwmac IP may support safety features, and those Safety
Feature Correctible Error and Uncorrectible Error irqs may be
separate irqs. Add support to parse the safety irqs from DT.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index be8e79c7aa34..4a2002eea870 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -737,6 +737,18 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
 	}
 
+	stmmac_res->sfty_ce_irq = platform_get_irq_byname_optional(pdev, "sfty_ce");
+	if (stmmac_res->sfty_ce_irq < 0) {
+		if (stmmac_res->sfty_ce_irq == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
+	stmmac_res->sfty_ue_irq = platform_get_irq_byname_optional(pdev, "sfty_ue");
+	if (stmmac_res->sfty_ue_irq < 0) {
+		if (stmmac_res->sfty_ue_irq == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
 	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
 
 	return PTR_ERR_OR_ZERO(stmmac_res->addr);
-- 
2.40.1

