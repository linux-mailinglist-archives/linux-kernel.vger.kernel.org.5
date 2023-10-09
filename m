Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C9F7BE7AE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377481AbjJIRVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377315AbjJIRVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:21:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E894;
        Mon,  9 Oct 2023 10:21:34 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-211-168.ewe-ip-backbone.de [91.248.211.168])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5CD7866057B6;
        Mon,  9 Oct 2023 18:21:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696872093;
        bh=gX1sh9tNcdiHJy/P3FU5j/FQag6VcA3nlE7BjqH+NDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBMEh6KKbKIXdXfA5OwUqMT0CI3myXDMFMlq79XiS8qWCBrzb4edUtoFEGSH5QpGL
         AD1xVPHvFQIlG+kAN1zQG+UXg1rcr7T6a38B9AKVyOPaM5vZbJ+riWu/HGJSLdpi//
         Gp0TGQG1Q2y9P5a2VCyxdRzbzd2u1hyjrySVYVLyvYMhzCvfgjD6wK621gZqQXrp6a
         DfPOvoxWc9D9wk6v2hJl5Vz9b02Nd4JQNHgg2DoVE+Yv+UUPTVq2y7XR2oGCFnoS3L
         pW8NBbWZr4bzjl7OkM8RpkNpdSvmKSz2f19YtuUNauf4jlMJMCe5Ms1EnvvEFH0kUp
         GxQ0K6q4wa1mw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1C6FC4800CA; Mon,  9 Oct 2023 19:21:31 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 1/3] dt-bindings: usb: add rk3588 compatible to rockchip,dwc3
Date:   Mon,  9 Oct 2023 19:20:09 +0200
Message-ID: <20231009172129.43568-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009172129.43568-1-sebastian.reichel@collabora.com>
References: <20231009172129.43568-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3588 has three DWC3 controllers. Two of them are fully functional in
host, device and OTG mode including USB2 support. They are connected to
dedicated PHYs, that also support USB-C's DisplayPort alternate mode.

The third controller is connected to one of the combphy's shared
with PCIe and SATA. It can only be used in host mode and does not
support USB2. Compared to the other controllers this one needs
some extra clocks.

While adding the extra clocks required by RK3588, I noticed grf_clk
is not available on RK3568, so I disallowed it for that platform.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/usb/rockchip,dwc3.yaml           | 66 +++++++++++++++++--
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index 291844c8f3e1..517879290099 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -20,9 +20,6 @@ description:
   Type-C PHY
   Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
 
-allOf:
-  - $ref: snps,dwc3.yaml#
-
 select:
   properties:
     compatible:
@@ -30,6 +27,7 @@ select:
         enum:
           - rockchip,rk3328-dwc3
           - rockchip,rk3568-dwc3
+          - rockchip,rk3588-dwc3
   required:
     - compatible
 
@@ -39,6 +37,7 @@ properties:
       - enum:
           - rockchip,rk3328-dwc3
           - rockchip,rk3568-dwc3
+          - rockchip,rk3588-dwc3
       - const: snps,dwc3
 
   reg:
@@ -58,7 +57,9 @@ properties:
           Master/Core clock, must to be >= 62.5 MHz for SS
           operation and >= 30MHz for HS operation
       - description:
-          Controller grf clock
+          Controller grf clock OR UTMI clock
+      - description:
+          PIPE clock
 
   clock-names:
     minItems: 3
@@ -66,7 +67,10 @@ properties:
       - const: ref_clk
       - const: suspend_clk
       - const: bus_clk
-      - const: grf_clk
+      - enum:
+          - grf_clk
+          - utmi
+      - const: pipe
 
   power-domains:
     maxItems: 1
@@ -86,6 +90,58 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: snps,dwc3.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3328-dwc3
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 4
+        clock-names:
+          minItems: 3
+          items:
+            - const: ref_clk
+            - const: suspend_clk
+            - const: bus_clk
+            - const: grf_clk
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-dwc3
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: ref_clk
+            - const: suspend_clk
+            - const: bus_clk
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-dwc3
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 5
+        clock-names:
+          minItems: 3
+          items:
+            - const: ref_clk
+            - const: suspend_clk
+            - const: bus_clk
+            - const: utmi
+            - const: pipe
+
 examples:
   - |
     #include <dt-bindings/clock/rk3328-cru.h>
-- 
2.42.0

