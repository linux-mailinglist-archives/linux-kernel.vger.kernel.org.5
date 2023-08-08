Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901A9773C1A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjHHQAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjHHP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:58:36 -0400
Received: from TWMBX02.aspeed.com (mail.aspeedtech.com [211.20.114.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8019E2709;
        Tue,  8 Aug 2023 08:44:19 -0700 (PDT)
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Aug
 2023 23:42:45 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Aug 2023 23:42:45 +0800
From:   Dylan Hung <dylan_hung@aspeedtech.com>
To:     <jk@codeconstruct.com.au>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <linux-i3c@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>, <kobedylan@gmail.com>
Subject: [PATCH 2/3] dt-bindings: i3c: ast2600: Add resets and reset-names
Date:   Tue, 8 Aug 2023 23:42:40 +0800
Message-ID: <20230808154241.749641-3-dylan_hung@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808154241.749641-1-dylan_hung@aspeedtech.com>
References: <20230808154241.749641-1-dylan_hung@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: Fail (TWMBX02.aspeed.com: domain of dylan_hung@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=localhost.localdomain;
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_FAIL,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two reset lines to the AST2600 I3C controller:
- core_rst: the reset line of the controller itself
- global_rst: the reset line of the I3C global register block. Since all
six I3C controllers in AST2600 share this global register block, the
driver needs to handle this carefully. Generally, this reset line should
only need to be de-asserted.

Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
---
 .../devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml  | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml b/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
index fcc3dbff9c9a..3166d6f3a39c 100644
--- a/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
+++ b/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
@@ -23,7 +23,12 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 1
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: core_rst
+      - const: global_rst
 
   interrupts:
     maxItems: 1
@@ -48,6 +53,8 @@ required:
   - compatible
   - reg
   - clocks
+  - resets
+  - reset-names
   - interrupts
   - aspeed,global-regs
 
@@ -63,7 +70,8 @@ examples:
         #address-cells = <3>;
         #size-cells = <0>;
         clocks = <&syscon 0>;
-        resets = <&syscon 0>;
+        resets = <&syscon 40>, <&syscon 39>;
+        reset-names = "core_rst", "global_rst";
         aspeed,global-regs = <&i3c_global 0>;
         pinctrl-names = "default";
         pinctrl-0 = <&pinctrl_i3c1_default>;
-- 
2.25.1

