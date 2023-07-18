Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC136758313
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjGRQ5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjGRQzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:55:08 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AE81BF7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:54:57 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5803:2d6d:5bbc:e252])
        by andre.telenet-ops.be with bizsmtp
        id Ngur2A0050ucMBo01gurGX; Tue, 18 Jul 2023 18:54:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyD-001nXW-1o;
        Tue, 18 Jul 2023 18:54:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyN-000gbH-2t;
        Tue, 18 Jul 2023 18:54:51 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 02/41] dt-bindings: display: Add Renesas SH-Mobile LCDC bindings
Date:   Tue, 18 Jul 2023 18:54:07 +0200
Message-Id: <3333e8e50572480dd57d7f0388ca7f06d76155d9.1689698048.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689698048.git.geert+renesas@glider.be>
References: <cover.1689698048.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the LCD Controller (LCDC) found in Renesas
SuperH SH-Mobile and ARM SH/R-Mobile SOCs.

Based on a plain text prototype by Laurent Pinchart.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org

v2:
  - Add myself as co-maintainer,
  - Make fck clock required,
  - Drop ports description referring to obsolete graph.txt,
  - Condition ports to compatible strings,
  - Drop label and status from example.

Changes compared to Laurent's original:
  - Convert to json-schema,
  - Rename compatible values from "renesas,lcdc-<SoC>" to
    "renesas,<SoC>-lcdc",
  - Add power-domains property,
  - Add MIPI-DSI port on SH-Mobile AG5,
  - Update example to reflect reality,
  - Add to MAINTAINERS.
---
 .../display/renesas,shmobile-lcdc.yaml        | 130 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml

diff --git a/Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml b/Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
new file mode 100644
index 0000000000000000..9816c4cacc7d9a7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/renesas,shmobile-lcdc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH-Mobile LCD Controller (LCDC)
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+properties:
+  compatible:
+    enum:
+      - renesas,r8a7740-lcdc # R-Mobile A1
+      - renesas,sh73a0-lcdc  # SH-Mobile AG5
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 5
+    description:
+      Only the functional clock is mandatory.
+      Some of the optional clocks are model-dependent (e.g. "video" (a.k.a.
+      "vou" or "dv_clk") is available on R-Mobile A1 only).
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: fck
+      - enum: [ media, lclk, hdmi, video ]
+      - enum: [ media, lclk, hdmi, video ]
+      - enum: [ media, lclk, hdmi, video ]
+      - enum: [ media, lclk, hdmi, video ]
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: LCD port (R-Mobile A1 and SH-Mobile AG5)
+        unevaluatedProperties: false
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: HDMI port (R-Mobile A1 LCDC1 and SH-Mobile AG5)
+        unevaluatedProperties: false
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: MIPI-DSI port (SH-Mobile AG5)
+        unevaluatedProperties: false
+
+    required:
+      - port@0
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - ports
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r8a7740-lcdc
+    then:
+      properties:
+        ports:
+          properties:
+            port@2: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,sh73a0-lcdc
+    then:
+      properties:
+        ports:
+          required:
+            - port@1
+            - port@2
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7740-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    lcd-controller@fe940000 {
+        compatible = "renesas,r8a7740-lcdc";
+        reg = <0xfe940000 0x4000>;
+        interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&mstp1_clks R8A7740_CLK_LCDC0>,
+                 <&cpg_clocks R8A7740_CLK_M3>, <&lcdlclk0_clk>,
+                 <&vou_clk>;
+        clock-names = "fck", "media", "lclk", "video";
+        power-domains = <&pd_a4lc>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                lcdc0_rgb: endpoint {
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index dc6bef7738f50741..1d12c07efae1c347 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6993,6 +6993,7 @@ M:	Geert Uytterhoeven <geert+renesas@glider.be>
 L:	dri-devel@lists.freedesktop.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
 F:	drivers/gpu/drm/renesas/shmobile/
 F:	include/linux/platform_data/shmob_drm.h
 
-- 
2.34.1

