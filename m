Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979D780E2AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345851AbjLLDS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjLLDSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:18:54 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E951CD;
        Mon, 11 Dec 2023 19:19:00 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1rCtII-0002gc-13;
        Tue, 12 Dec 2023 03:18:51 +0000
Date:   Tue, 12 Dec 2023 03:18:47 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Daniel Golle <daniel@makrotopia.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: [PATCH v5 3/5] dt-bindings: clock: mediatek: add clock controllers
 of MT7988
Message-ID: <ce9b1e777090724794cf9f0c52bcd8618385fd06.1702350213.git.daniel@makrotopia.org>
References: <152b256d253508cdc7514c0f1c5a9324bde83d46.1702350213.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152b256d253508cdc7514c0f1c5a9324bde83d46.1702350213.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add various clock controllers found in the MT7988 SoC to existing
bindings (if applicable) and add files for the new ethwarp, mcusys
and xfi-pll clock controllers not previously present in any SoC.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v5:
 * drop use of ti,syscon-reset and hence also syscon and simple-mfd
   compatibles from mt7988-ethwarp clock controller which now got the
   clock controller provide the reset(s).

v4:
 * add subnodes for controllers acting as MFD

v3:
 * move clock bindings to clock folder
 * drop ti,syscon-reset from bindings and example
 * merge mcusys with topckgen bindings

v2:
 * dropped unused labels
 * add 'type: object' declaration for reset-controller found in new
   ethwarp controller and represented as ti,syscon-reset
 * rebase on top of
   "dt-bindings: arm: mediatek: move ethsys controller & convert to DT schema"

 .../arm/mediatek/mediatek,infracfg.yaml       |  1 +
 .../bindings/clock/mediatek,apmixedsys.yaml   |  1 +
 .../bindings/clock/mediatek,ethsys.yaml       |  1 +
 .../clock/mediatek,mt7988-ethwarp.yaml        | 52 ++++++++++++++++
 .../clock/mediatek,mt7988-xfi-pll.yaml        | 48 +++++++++++++++
 .../bindings/clock/mediatek,topckgen.yaml     |  2 +
 .../bindings/net/pcs/mediatek,sgmiisys.yaml   | 61 ++++++++++++++++---
 7 files changed, 157 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7988-xfi-pll.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
index ea98043c6ba3d..230b5188a88db 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
@@ -30,6 +30,7 @@ properties:
               - mediatek,mt7629-infracfg
               - mediatek,mt7981-infracfg
               - mediatek,mt7986-infracfg
+              - mediatek,mt7988-infracfg
               - mediatek,mt8135-infracfg
               - mediatek,mt8167-infracfg
               - mediatek,mt8173-infracfg
diff --git a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
index 372c1d744bc27..685535846cbb7 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
@@ -22,6 +22,7 @@ properties:
           - mediatek,mt7622-apmixedsys
           - mediatek,mt7981-apmixedsys
           - mediatek,mt7986-apmixedsys
+          - mediatek,mt7988-apmixedsys
           - mediatek,mt8135-apmixedsys
           - mediatek,mt8173-apmixedsys
           - mediatek,mt8516-apmixedsys
diff --git a/Documentation/devicetree/bindings/clock/mediatek,ethsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,ethsys.yaml
index 94d42c8647777..f9cddacc2eae1 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,ethsys.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,ethsys.yaml
@@ -22,6 +22,7 @@ properties:
               - mediatek,mt7629-ethsys
               - mediatek,mt7981-ethsys
               - mediatek,mt7986-ethsys
+              - mediatek,mt7988-ethsys
           - const: syscon
       - items:
           - const: mediatek,mt7623-ethsys
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml
new file mode 100644
index 0000000000000..b7f3b42438662
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7988-ethwarp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7988 ethwarp Controller
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+description:
+  The Mediatek MT7988 ethwarp controller provides clocks and resets for the
+  Ethernet related subsystems found the MT7988 SoC.
+  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt7988-ethwarp
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/ti-syscon.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@15031000 {
+            compatible = "mediatek,mt7988-ethwarp";
+            reg = <0 0x15031000 0 0x1000>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7988-xfi-pll.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7988-xfi-pll.yaml
new file mode 100644
index 0000000000000..fe5e3a70299fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7988-xfi-pll.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7988-xfi-pll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7988 XFI PLL Clock Controller
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+description:
+  The MediaTek XFI PLL controller provides the 156.25MHz clock for the
+  Ethernet SerDes PHY from the 40MHz top_xtal clock.
+
+properties:
+  compatible:
+    const: mediatek,mt7988-xfi-pll
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - resets
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        clock-controller@11f40000 {
+            compatible = "mediatek,mt7988-xfi-pll";
+            reg = <0 0x11f40000 0 0x1000>;
+            resets = <&watchdog 16>;
+            #clock-cells = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
index 6d087ded7437a..bdf3b55bd56fd 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
@@ -37,6 +37,8 @@ properties:
               - mediatek,mt7629-topckgen
               - mediatek,mt7981-topckgen
               - mediatek,mt7986-topckgen
+              - mediatek,mt7988-mcusys
+              - mediatek,mt7988-topckgen
               - mediatek,mt8167-topckgen
               - mediatek,mt8183-topckgen
           - const: syscon
diff --git a/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml b/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
index 66a95191bd776..f5f1fd97c50eb 100644
--- a/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
+++ b/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
@@ -15,15 +15,22 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - mediatek,mt7622-sgmiisys
-          - mediatek,mt7629-sgmiisys
-          - mediatek,mt7981-sgmiisys_0
-          - mediatek,mt7981-sgmiisys_1
-          - mediatek,mt7986-sgmiisys_0
-          - mediatek,mt7986-sgmiisys_1
-      - const: syscon
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt7622-sgmiisys
+              - mediatek,mt7629-sgmiisys
+              - mediatek,mt7981-sgmiisys_0
+              - mediatek,mt7981-sgmiisys_1
+              - mediatek,mt7986-sgmiisys_0
+              - mediatek,mt7986-sgmiisys_1
+          - const: syscon
+      - items:
+          - enum:
+              - mediatek,mt7988-sgmiisys_0
+              - mediatek,mt7988-sgmiisys_1
+          - const: simple-mfd
+          - const: syscon
 
   reg:
     maxItems: 1
@@ -35,11 +42,47 @@ properties:
     description: Invert polarity of the SGMII data lanes
     type: boolean
 
+  pcs:
+    type: object
+    description: HSGMII PCS logic
+    properties:
+      compatible:
+        const: mediatek,mt7988-sgmii
+
+      clocks:
+        maxItems: 3
+        minItems: 3
+
+      clock-names:
+        items:
+          - const: sgmii_sel
+          - const: sgmii_tx
+          - const: sgmii_rx
+
+    required:
+      - compatible
+      - clocks
+      - clock-names
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
   - '#clock-cells'
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - mediatek,mt7988-sgmiisys_0
+          - mediatek,mt7988-sgmiisys_1
+
+then:
+  required:
+    - pcs
+
 additionalProperties: false
 
 examples:
-- 
2.43.0
