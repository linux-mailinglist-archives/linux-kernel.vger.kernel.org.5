Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA1C7F19A7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjKTRTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjKTRTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:19:13 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F5E3;
        Mon, 20 Nov 2023 09:19:09 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r57vG-0008Kf-11;
        Mon, 20 Nov 2023 17:18:59 +0000
Date:   Mon, 20 Nov 2023 17:18:55 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Daniel Golle <daniel@makrotopia.org>,
        Jianhui Zhao <zhaojh329@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: clock: mediatek: add clock controllers
 of MT7988
Message-ID: <8a30ae45b55842bc04f57714c8e0a962f3288a67.1700498124.git.daniel@makrotopia.org>
References: <b277c5f084ff35849efb8250510b2536053d1316.1700498124.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b277c5f084ff35849efb8250510b2536053d1316.1700498124.git.daniel@makrotopia.org>
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
v2:
 * dropped unused labels
 * add 'type: object' declaration for reset-controller found in new
   ethwarp controller and represented as ti,syscon-reset
 * rebase on top of
   "dt-bindings: arm: mediatek: move ethsys controller & convert to DT schema"

 .../arm/mediatek/mediatek,infracfg.yaml       |  1 +
 .../arm/mediatek/mediatek,mt7988-ethwarp.yaml | 61 +++++++++++++++++++
 .../arm/mediatek/mediatek,mt7988-mcusys.yaml  | 46 ++++++++++++++
 .../arm/mediatek/mediatek,mt7988-xfi-pll.yaml | 49 +++++++++++++++
 .../bindings/clock/mediatek,apmixedsys.yaml   |  1 +
 .../bindings/clock/mediatek,ethsys.yaml       |  1 +
 .../bindings/clock/mediatek,topckgen.yaml     |  1 +
 .../bindings/net/pcs/mediatek,sgmiisys.yaml   |  2 +
 8 files changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-ethwarp.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-mcusys.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-xfi-pll.yaml

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
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-ethwarp.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-ethwarp.yaml
new file mode 100644
index 0000000000000..5b988efe0cb74
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-ethwarp.yaml
@@ -0,0 +1,61 @@
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
+  The reset-controller can be represented using the ti,syscon-reset bindings.
+  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt7988-ethwarp
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  reset-controller:
+    type: object
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
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
+            compatible = "mediatek,mt7988-ethwarp", "syscon", "simple-mfd";
+            reg = <0 0x15031000 0 0x1000>;
+            #clock-cells = <1>;
+
+            reset-controller {
+                compatible = "ti,syscon-reset";
+                #reset-cells = <1>;
+                ti,reset-bits = <
+                    0x8 9 0x8 9 0 0 (ASSERT_SET | DEASSERT_CLEAR | STATUS_NONE)
+                >;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-mcusys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-mcusys.yaml
new file mode 100644
index 0000000000000..b30bd13616875
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-mcusys.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7988-mcusys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7988 MCU System Clock Controller
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+description:
+  The Mediatek mcusys controller provides ARM and bus clocks to the system.
+  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt7988-mcusys
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@100e0000 {
+            compatible = "mediatek,mt7988-mcusys", "syscon";
+            reg = <0 0x100e0000 0 0x1000>;
+            #clock-cells = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-xfi-pll.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-xfi-pll.yaml
new file mode 100644
index 0000000000000..5d9e466c0b406
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7988-xfi-pll.yaml
@@ -0,0 +1,49 @@
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
+    #define MT7988_TOPRGU_XFI_PLL_GRST              16
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        clock-controller@11f40000 {
+            compatible = "mediatek,mt7988-xfi-pll";
+            reg = <0 0x11f40000 0 0x1000>;
+            resets = <&watchdog MT7988_TOPRGU_XFI_PLL_GRST>;
+            #clock-cells = <1>;
+        };
+    };
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
diff --git a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
index 6d087ded7437a..539830b581cc5 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
@@ -37,6 +37,7 @@ properties:
               - mediatek,mt7629-topckgen
               - mediatek,mt7981-topckgen
               - mediatek,mt7986-topckgen
+              - mediatek,mt7988-topckgen
               - mediatek,mt8167-topckgen
               - mediatek,mt8183-topckgen
           - const: syscon
diff --git a/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml b/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
index 66a95191bd776..7b611d7e5bb1e 100644
--- a/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
+++ b/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
@@ -23,6 +23,8 @@ properties:
           - mediatek,mt7981-sgmiisys_1
           - mediatek,mt7986-sgmiisys_0
           - mediatek,mt7986-sgmiisys_1
+          - mediatek,mt7988-sgmiisys_0
+          - mediatek,mt7988-sgmiisys_1
       - const: syscon
 
   reg:
-- 
2.42.1
