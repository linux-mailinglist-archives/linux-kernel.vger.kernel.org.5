Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1131977FCB8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353886AbjHQRKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353851AbjHQRKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:10:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1178A121;
        Thu, 17 Aug 2023 10:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3C7E675C4;
        Thu, 17 Aug 2023 17:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58620C433C8;
        Thu, 17 Aug 2023 17:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292199;
        bh=v5fyU7tg4Nnh4L70QOucdCfrXw036MbbJKXSnKFoTps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0zd0vYzj5RIm7r4P7jqUMcvizI3Uo6SZHTMtk6YIHNxScbD8HFahRYRfgSljP0Un
         aXAOML2bm9czAizJHttgDm0YypWO/YRsm4XgULiAvpxhLnhixTdqGUfNgFwnCqOqAk
         uFl+D48lx12pSqgo2DLXvX82GpQhhgUGa23AEGf1DgIAX9vfj8aPcuHhVjO2aZEQ75
         UOgkhnOK4dHbbVOSTsfMx5EcWJCMobqno8ohLwVbq6xc0aJl96cmQ4ywoyP5Z102eI
         qNryxpTaNVxZQw9jpf30Kmu8r49lsMRqFYNRyk1Kw2vVdN1feFqb39qpYPH2Qqm+GB
         FMG+NYF2eZt4Q==
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
Subject: [PATCH net-next v5 8/9] dt-bindings: net: snps,dwmac: add per channel irq support
Date:   Fri, 18 Aug 2023 00:57:48 +0800
Message-Id: <20230817165749.672-9-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230817165749.672-1-jszhang@kernel.org>
References: <20230817165749.672-1-jszhang@kernel.org>
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

The IP supports optional per channel interrupt, add support for this
usage case.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   | 68 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ee9174f77d97..a916701474dc 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -103,7 +103,7 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 5
+    maxItems: 37
     additionalItems: true
     items:
       - description: Combined signal for various interrupt events
@@ -111,10 +111,42 @@ properties:
       - description: The interrupt that occurs when Rx exits the LPI state
       - description: The interrupt that occurs when Safety Feature Correctible Errors happen
       - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
+      - description: rx0 per-channel interrupt
+      - description: rx1 per-channel interrupt
+      - description: rx2 per-channel interrupt
+      - description: rx3 per-channel interrupt
+      - description: rx4 per-channel interrupt
+      - description: rx5 per-channel interrupt
+      - description: rx6 per-channel interrupt
+      - description: rx7 per-channel interrupt
+      - description: rx8 per-channel interrupt
+      - description: rx9 per-channel interrupt
+      - description: rx10 per-channel interrupt
+      - description: rx11 per-channel interrupt
+      - description: rx12 per-channel interrupt
+      - description: rx13 per-channel interrupt
+      - description: rx14 per-channel interrupt
+      - description: rx15 per-channel interrupt
+      - description: tx0 per-channel interrupt
+      - description: tx1 per-channel interrupt
+      - description: tx2 per-channel interrupt
+      - description: tx3 per-channel interrupt
+      - description: tx4 per-channel interrupt
+      - description: tx5 per-channel interrupt
+      - description: tx6 per-channel interrupt
+      - description: tx7 per-channel interrupt
+      - description: tx8 per-channel interrupt
+      - description: tx9 per-channel interrupt
+      - description: tx10 per-channel interrupt
+      - description: tx11 per-channel interrupt
+      - description: tx12 per-channel interrupt
+      - description: tx13 per-channel interrupt
+      - description: tx14 per-channel interrupt
+      - description: tx15 per-channel interrupt
 
   interrupt-names:
     minItems: 1
-    maxItems: 5
+    maxItems: 37
     additionalItems: true
     items:
       - const: macirq
@@ -123,6 +155,38 @@ properties:
           - eth_lpi
           - sfty_ce
           - sfty_ue
+          - rx0
+          - rx1
+          - rx2
+          - rx3
+          - rx4
+          - rx5
+          - rx6
+          - rx7
+          - rx8
+          - rx9
+          - rx10
+          - rx11
+          - rx12
+          - rx13
+          - rx14
+          - rx15
+          - tx0
+          - tx1
+          - tx2
+          - tx3
+          - tx4
+          - tx5
+          - tx6
+          - tx7
+          - tx8
+          - tx9
+          - tx10
+          - tx11
+          - tx12
+          - tx13
+          - tx14
+          - tx15
 
   clocks:
     minItems: 1
-- 
2.40.1

