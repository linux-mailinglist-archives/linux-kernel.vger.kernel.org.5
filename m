Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C97E75E3AD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjGWQXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjGWQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:23:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBDD10C2;
        Sun, 23 Jul 2023 09:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0966A60E05;
        Sun, 23 Jul 2023 16:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF1BC433C8;
        Sun, 23 Jul 2023 16:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690129362;
        bh=77r49RSSQhAozO3HusyMgOJivNEdF2Oycm6v24MDK60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbJaNcSBqDv3TqTL9DOpOFtVQAvmOZDNAcpGCIvWPiAC2ss+7LaTuU60MqlD3oTgS
         9zdjwsNlMnz6VUppT+/I9iJyH5BjziWnzaae2/gm//cQwmkfhqPnjGNY7KcPEq2+ZS
         rgWhVRJaUs/QPnBKydu23WlOGcwokmagkMVqM/4YxcDEXm1irn67kRre/lpUYbbLSk
         tSJxCz/v6imyZGVT0Hn2/ZJYVroskvzK3TxOwHQT7M8l/+t1+OW/hdKSeDmDRpgby0
         9HcL5rXrCzFT7VhH8g3m9QOQco33FQC+fw+ReDl5VuxORDQg2D3IIj1REb9QY6L4v5
         SnGealjZlXjLQ==
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
Subject: [PATCH net-next 09/10] dt-bindings: net: snps,dwmac: add per channel irq support
Date:   Mon, 24 Jul 2023 00:10:28 +0800
Message-Id: <20230723161029.1345-10-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230723161029.1345-1-jszhang@kernel.org>
References: <20230723161029.1345-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP supports per channel interrupt, add support for this usage case.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index bb80ca205d26..525210c2c06c 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -101,6 +101,11 @@ properties:
     minItems: 1
     maxItems: 2
 
+  snps,per-channel-interrupt:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates that Rx and Tx complete will generate a unique interrupt for each channel
+
   interrupts:
     minItems: 1
     items:
@@ -109,6 +114,8 @@ properties:
       - description: The interrupt that occurs when Rx exits the LPI state
       - description: The interrupt that occurs when Safety Feature Correctible Errors happen
       - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
+      - description: All of the rx per-channel interrupts
+      - description: All of the tx per-channel interrupts
 
   interrupt-names:
     minItems: 1
@@ -118,6 +125,22 @@ properties:
       - const: eth_lpi
       - const: sfty_ce_irq
       - const: sfty_ue_irq
+      - const: rx0
+      - const: rx1
+      - const: rx2
+      - const: rx3
+      - const: rx4
+      - const: rx5
+      - const: rx6
+      - const: rx7
+      - const: tx0
+      - const: tx1
+      - const: tx2
+      - const: tx3
+      - const: tx4
+      - const: tx5
+      - const: tx6
+      - const: tx7
 
   clocks:
     minItems: 1
-- 
2.40.1

