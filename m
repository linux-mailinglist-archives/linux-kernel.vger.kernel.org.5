Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944F9772BB7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjHGQy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjHGQy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA92102;
        Mon,  7 Aug 2023 09:54:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27B8961FAC;
        Mon,  7 Aug 2023 16:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A18C433C8;
        Mon,  7 Aug 2023 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691427243;
        bh=2GxVXefyNbdQErExbmg0/pws/HcbyG4JyeKhzXvRnBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isNPA8VjsZLDLmk3teiuHGbXo4lE9uRIceVNL+NUBpMZljoqr0M2pYuIKf4nMpvxE
         VAqO3uRfxyTjsDvb6kDq+ERekznq4fiUU6yDdP6is/OzJE/OWat0MKryk0g/rzMh6T
         mZCDRUCKZ/vf62PQu9T+uUEgR7Cq5z2Pbk6quX9fgRzdRYiuTzfugYpM+GW3tL/vQF
         fkjcTJSK/Ar/a/ogARUGLBJUof6J33LRFi8ThH4WTvjnR9/A0rdCD9jxsCqaBF8YGd
         lFfx0H971y3hIDT46KdB/veZgNv4n5M9euSfpeH7a4KC1HpLyJ1+zc3Bw8Ri3Nrl3x
         9XHLXYDZIL/Ig==
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
Subject: [PATCH net-next v2 08/10] net: stmmac: platform: support parsing safety irqs from DT
Date:   Tue,  8 Aug 2023 00:41:49 +0800
Message-Id: <20230807164151.1130-9-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230807164151.1130-1-jszhang@kernel.org>
References: <20230807164151.1130-1-jszhang@kernel.org>
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
---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 23d53ea04b24..29145682b57b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -738,6 +738,18 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
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

