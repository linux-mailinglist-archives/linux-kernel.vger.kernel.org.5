Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007D77A359B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 14:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjIQMst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 08:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbjIQMsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 08:48:17 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C32D9;
        Sun, 17 Sep 2023 05:48:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CAA4C0002;
        Sun, 17 Sep 2023 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694954889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAozQf5veG9fcNRrq+yazpmSWFWK3c8BmsCcPtHQ9n8=;
        b=aqoyFajfqCCla3hh1RxRwP5PcE9fy9aHZJE+JpUZ7sksitMubsP93Qeh602LvI1QYeN2DZ
        xekhyIyxJHykKbeT+Udfu6Jl+T4UUgdWc+M5fNYVrcfdEkS52xDCPy3TRAXBu77GZTcoJC
        Va7kFC6lu1wTP7wIZpiM+0z1qk+7nEohD+9moSLnv2/MAsM18sVwdwmjc6oTTCEit8HPdJ
        Kb6CrP8kLzUvG3+H8cZe3F0ufLEbxcNDMsIrCPIPl122Y9ghUP45FmFV3KWNU3GrBmM3YQ
        rrfo45y4X4yaXHTdbDo+24Bd7rdUCTvW4b9oPjmQfAueZrmxIqcW6x+oaK9uMA==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Daniel Golle <daniel@makrotopia.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 2/2] dt-bindings: net: mediatek,net: move mediatek,mt7621-eth to another schema
Date:   Sun, 17 Sep 2023 15:47:23 +0300
Message-Id: <20230917124723.143202-2-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230917124723.143202-1-arinc.unal@arinc9.com>
References: <20230917124723.143202-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings for mediatek,mt7621-eth contradict with some of the rules on
the top level schema of mediatek,net.yaml:
- resets must be two items. resets with "maxItems: 3" at the top level
  implies "minItems: 3" and cannot be overriden under a subschema.
- reset-names items must be "fe" and "eth". reset-names items defined on
  the top level schema cannot be overridden under a subschema.

Therefore, move mediatek,mt7621-eth to another schema. Fix the order of
clock-names items. Do not define the properties that don't apply to this
hardware. Require more properties. Add an example.

Fixes: 1cbf487d7d3a ("dt-bindings: net: mediatek,net: add missing mediatek,mt7621-eth")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../bindings/net/mediatek,mt7621-eth.yaml     | 143 ++++++++++++++++++
 .../devicetree/bindings/net/mediatek,net.yaml |  27 ----
 2 files changed, 143 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek,mt7621-eth.yaml

diff --git a/Documentation/devicetree/bindings/net/mediatek,mt7621-eth.yaml b/Documentation/devicetree/bindings/net/mediatek,mt7621-eth.yaml
new file mode 100644
index 000000000000..4f39d7124693
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mediatek,mt7621-eth.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/mediatek,mt7621-eth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7621 Frame Engine Ethernet controller
+
+maintainers:
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
+
+description:
+  The frame engine ethernet controller can be found on MediaTek MT7621 SoC. This
+  SoC has got dual GMAC ports.
+
+properties:
+  compatible:
+    const: mediatek,mt7621-eth
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: fe
+      - const: ethif
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: fe
+      - const: eth
+
+  mediatek,ethsys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon node that handles the port setup.
+
+  mdio-bus:
+    $ref: mdio.yaml#
+    unevaluatedProperties: false
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^mac@[0-1]$":
+    type: object
+    unevaluatedProperties: false
+    allOf:
+      - $ref: ethernet-controller.yaml#
+    description:
+      Ethernet MAC node
+    properties:
+      compatible:
+        const: mediatek,eth-mac
+
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - mediatek,ethsys
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+    #include <dt-bindings/clock/mt7621-clk.h>
+    #include <dt-bindings/reset/mt7621-reset.h>
+
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        ethernet: ethernet@1e100000 {
+            compatible = "mediatek,mt7621-eth";
+            reg = <0x1e100000 0x10000>;
+
+            clocks = <&sysc MT7621_CLK_FE>, <&sysc MT7621_CLK_ETH>;
+            clock-names = "fe", "ethif";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            resets = <&sysc MT7621_RST_FE>, <&sysc MT7621_RST_ETH>;
+            reset-names = "fe", "eth";
+
+            interrupt-parent = <&gic>;
+            interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
+
+            mediatek,ethsys = <&sysc>;
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&mdio_pins>, <&rgmii1_pins>, <&rgmii2_pins>;
+
+            gmac0: mac@0 {
+                compatible = "mediatek,eth-mac";
+                reg = <0>;
+                phy-mode = "rgmii";
+
+                fixed-link {
+                    speed = <1000>;
+                    full-duplex;
+                    pause;
+                };
+            };
+
+            gmac1: mac@1 {
+                compatible = "mediatek,eth-mac";
+                reg = <1>;
+                phy-mode = "rgmii";
+
+                fixed-link {
+                    speed = <1000>;
+                    full-duplex;
+                    pause;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 0b2cb1897310..dc6f2424002e 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -19,7 +19,6 @@ properties:
     enum:
       - mediatek,mt2701-eth
       - mediatek,mt7623-eth
-      - mediatek,mt7621-eth
       - mediatek,mt7622-eth
       - mediatek,mt7629-eth
       - mediatek,mt7981-eth
@@ -140,32 +139,6 @@ allOf:
 
         mediatek,wed-pcie: false
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - mediatek,mt7621-eth
-    then:
-      properties:
-        interrupts:
-          maxItems: 1
-
-        clocks:
-          minItems: 2
-          maxItems: 2
-
-        clock-names:
-          items:
-            - const: ethif
-            - const: fe
-
-        mediatek,infracfg: false
-
-        mediatek,wed: false
-
-        mediatek,wed-pcie: false
-
   - if:
       properties:
         compatible:
-- 
2.39.2

