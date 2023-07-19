Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A65D759CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjGSRke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjGSRk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:40:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82A91FE9;
        Wed, 19 Jul 2023 10:40:20 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-009.ewe-ip-backbone.de [91.248.208.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F2EB6606FCE;
        Wed, 19 Jul 2023 18:40:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689788419;
        bh=LlUh7Fn0cj04qJmOdkCXn8GhQI6+9wcTUh77kHYpm+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mId2p9mv1C0V9ofkmv80IFSeXy7Dod5LmGeSNOVTRWn+aumEFnzwSJt8PhFyRI5Ng
         n4UubNfF51wVwIkymVzRcwci+XM+ospEBgV+CfTkRv47yFYjDeoJgJpXaZRZji48xr
         UeMg9z2rH6u1IhneCdSsAKiMft2EJVrStEJv/EVgMnVNaQFNLGCV6bGjg/8ZL0PaZW
         hdMoXYOdJNi+12XtDlskQM5FlEkkrEskp1QiARs1t4ueXsHR+2cCp4LTAw/vQL/k9K
         k0agJfPQ2nTearEeZmqwTqy/fsqL2ldcANHxDcX2CSvwNbCPRpYFrUTI2K3Us6Fmwt
         DhZCKdG3yi1wg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 20E6C480DA8; Wed, 19 Jul 2023 19:40:17 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 1/2] dt-bindings: usb: rockchip,dwc3: Add RK3588 binding
Date:   Wed, 19 Jul 2023 19:40:14 +0200
Message-Id: <20230719174015.68153-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719174015.68153-1-sebastian.reichel@collabora.com>
References: <20230719174015.68153-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3588 contains three DWC3 cores. Two of them are connected to
dedicated USBDP PHY and can be used in dual-role. The third is
connected to one of the shared combo PHYs used for PCIe/SATA/USB3
and can only be used in host mode. Since the binding is all about
the PHY glueing and involved clocks, separate compatible values
have been created for these two types.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/usb/rockchip,rk3399-dwc3.yaml    | 107 ++++++++++++++----
 1 file changed, 85 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml
index 3159f9a6a0f7..0db4dc86e506 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml
@@ -11,7 +11,13 @@ maintainers:
 
 properties:
   compatible:
-    const: rockchip,rk3399-dwc3
+    oneOf:
+      - items:
+          - enum:
+              - rockchip,rk3588-dwc3-otg
+              - rockchip,rk3588-dwc3-host
+          - const: rockchip,rk3399-dwc3
+      - const: rockchip,rk3399-dwc3
 
   '#address-cells':
     const: 2
@@ -22,35 +28,37 @@ properties:
   ranges: true
 
   clocks:
-    items:
-      - description:
-          Controller reference clock, must to be 24 MHz
-      - description:
-          Controller suspend clock, must to be 24 MHz or 32 KHz
-      - description:
-          Master/Core clock, must to be >= 62.5 MHz for SS
-          operation and >= 30MHz for HS operation
-      - description:
-          USB3 aclk peri
-      - description:
-          USB3 aclk
-      - description:
-          Controller grf clock
+    minItems: 3
+    maxItems: 6
 
   clock-names:
     items:
-      - const: ref_clk
-      - const: suspend_clk
-      - const: bus_clk
-      - const: aclk_usb3_rksoc_axi_perf
-      - const: aclk_usb3
-      - const: grf_clk
+      oneOf:
+        - enum:
+            - ref
+            - ref_clk
+        - enum:
+            - suspend
+            - suspend_clk
+        - enum:
+            - bus
+            - bus_clk
+        - const: aclk_usb3_rksoc_axi_perf
+        - const: aclk_usb3
+        - const: grf_clk
+        - const: utmi
+        - const: php
+        - const: pipe
+    minItems: 3
+    maxItems: 6
 
   resets:
     maxItems: 1
 
   reset-names:
-    const: usb3-otg
+    enum:
+      - usb3-host
+      - usb3-otg
 
 patternProperties:
   '^usb@':
@@ -68,6 +76,61 @@ required:
   - resets
   - reset-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: rockchip,rk3399-dwc3
+    then:
+      properties:
+        clocks:
+          minItems: 6
+        clock-names:
+          items:
+            - const: ref_clk
+            - const: suspend_clk
+            - const: bus_clk
+            - const: aclk_usb3_rksoc_axi_perf
+            - const: aclk_usb3
+            - const: grf_clk
+        reset-names:
+          const: usb3-otg
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-dwc3-otg
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: ref
+            - const: suspend
+            - const: bus
+        reset-names:
+          const: usb3-otg
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-dwc3-host
+    then:
+      properties:
+        clocks:
+          minItems: 6
+        clock-names:
+          items:
+            - const: ref
+            - const: suspend
+            - const: bus
+            - const: utmi
+            - const: php
+            - const: pipe
+        reset-names:
+          const: usb3-host
+
 examples:
   - |
     #include <dt-bindings/clock/rk3399-cru.h>
-- 
2.40.1

