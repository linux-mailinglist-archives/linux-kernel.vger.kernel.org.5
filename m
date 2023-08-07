Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BCB772BB3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjHGQys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjHGQyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:54:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534CE1FC8;
        Mon,  7 Aug 2023 09:54:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8984D61FBE;
        Mon,  7 Aug 2023 16:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D94CC07616;
        Mon,  7 Aug 2023 16:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691427240;
        bh=DbCsnFuIRCDw4RClbgLWL7mrfxpciKVOySkovPw9qFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqZc/lNm3p5A0/axSHPM+HKodX/2okxj2yUncPg8/EuidVFfhDFrPQXfyH4p2TbqL
         Sss7KEJd7Kshoa771W7BJ4/pvsFSUUsjfebuEHNP6B5a2q4+sZkGjpeRMwKVdym6XK
         rybcVtLL6zDgSQHTm+9ngtp+lgZNJv0ety3ISoCYcWUNWJaD/CFQF1imyrH9kY7xfy
         OpWCyW3bYYlhti8Jb5DEkVLC3H2m8AURoMGaLxbt3FoAVsksJvGC0Q4CoAh+oIU0G5
         SLzEWFACPwGQAp1QWkk2ZC5eqA28r6loGcSxYCYIYNHiGu2yAEqOJZYEOziKlF26Wo
         VBcZ/LnCfvb1g==
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
Subject: [PATCH net-next v2 07/10] dt-bindings: net: snps,dwmac: add safety irq support
Date:   Tue,  8 Aug 2023 00:41:48 +0800
Message-Id: <20230807164151.1130-8-jszhang@kernel.org>
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

The snps dwmac IP support safety features, and those Safety Feature
Correctible Error and Uncorrectible Error irqs may be separate irqs.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..5d81042f5634 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -107,6 +107,8 @@ properties:
       - description: Combined signal for various interrupt events
       - description: The interrupt to manage the remote wake-up packet detection
       - description: The interrupt that occurs when Rx exits the LPI state
+      - description: The interrupt that occurs when Safety Feature Correctible Errors happen
+      - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
 
   interrupt-names:
     minItems: 1
@@ -114,6 +116,8 @@ properties:
       - const: macirq
       - enum: [eth_wake_irq, eth_lpi]
       - const: eth_lpi
+      - const: sfty_ce
+      - const: sfty_ue
 
   clocks:
     minItems: 1
-- 
2.40.1

