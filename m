Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6A77FCB0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353884AbjHQRKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353910AbjHQRJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:09:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BE830C5;
        Thu, 17 Aug 2023 10:09:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76685675BC;
        Thu, 17 Aug 2023 17:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2026DC433C8;
        Thu, 17 Aug 2023 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292192;
        bh=aRyV6xNSnXzwR4k61lnQ+ZQcy3oDuCpZ9xSwfK+jJGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXMO8lhnQylzgU03Kg2syfvcIqhkAKyMBJjNJJKg+Fkmvz6kLvT2YV1raUGLF1LM3
         sZLun519nVvQF43RtwIpvoGSWB1wRTTVyUfnSfp9u4t+uUmA1AcjVrm9pQ3hRGymBx
         bkPgxdHuiyhTMMaYqxPXZIqQ+sbxE7I0Z6JZlUpyBzeXkjnBLG6pisBaRyWydMIBQt
         tvG3d5Q2Q3rmjQfIYoex/ARMrtWSE5y6BGUs+hQULZv6O5WoIc37MwOKmgP1vLHI9Y
         64Ncu6uyvd5vhmL2l3hdA7soXhpFkppM3YuAn5FSV0wr13ZAnMdsAwWciqvf6XQ+uq
         CPAcCxyy75LEg==
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
Subject: [PATCH net-next v5 6/9] dt-bindings: net: snps,dwmac: add safety irq support
Date:   Fri, 18 Aug 2023 00:57:46 +0800
Message-Id: <20230817165749.672-7-jszhang@kernel.org>
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

The snps dwmac IP support safety features, and those Safety Feature
Correctible Error and Uncorrectible Error irqs may be separate irqs.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../devicetree/bindings/net/snps,dwmac.yaml         | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..ee9174f77d97 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -103,17 +103,26 @@ properties:
 
   interrupts:
     minItems: 1
+    maxItems: 5
+    additionalItems: true
     items:
       - description: Combined signal for various interrupt events
       - description: The interrupt to manage the remote wake-up packet detection
       - description: The interrupt that occurs when Rx exits the LPI state
+      - description: The interrupt that occurs when Safety Feature Correctible Errors happen
+      - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
 
   interrupt-names:
     minItems: 1
+    maxItems: 5
+    additionalItems: true
     items:
       - const: macirq
-      - enum: [eth_wake_irq, eth_lpi]
-      - const: eth_lpi
+      - enum:
+          - eth_wake_irq
+          - eth_lpi
+          - sfty_ce
+          - sfty_ue
 
   clocks:
     minItems: 1
-- 
2.40.1

