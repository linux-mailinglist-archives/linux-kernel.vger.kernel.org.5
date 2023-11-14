Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C07C7EAC82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjKNJIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjKNJIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:08:15 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F395F19D;
        Tue, 14 Nov 2023 01:08:10 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F5DBC0005;
        Tue, 14 Nov 2023 09:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699952889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCcgkROjkqRmSaewuhx+Nh0bpW8Kj9/qV17c/F/G7C8=;
        b=bXPtkS/aWS+kQ+1mQID0hAEsnb+lPBQ1+iFqLPc3OEfvts5HaTNvj8MTjZy7cSJ4k63TC6
        7l8pm46Bhn5AnYLC9ez4TrEDnUmbk5FhyiO5O8F+LMrlfwKMyXicBBaQ/qXJH535RyNbWX
        jTish5jhgYq03cXIVaD5W6Y9ua7opZPc/sjrhTnP7jbKXwWMBtRctAaBSEr2/uUrdYgYvR
        a+a2Rm7kNyxUCv2B/3sllVK45musfB4NlKHEM0jraulh/CNWcAa9uaMork1BzW89zEO/SB
        Lggc29D8BqlQC1MjcJbwuCN6l3ancx3FG/QvUooL5Fz9kwtdCwKKM7pxmPsZFw==
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Romain Gantois <romain.gantois@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH net-next v2 1/8] dt-bindings: net: Introduce the Qualcomm IPQESS Ethernet switch
Date:   Tue, 14 Nov 2023 10:07:27 +0100
Message-ID: <20231114090743.865453-2-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114090743.865453-1-romain.gantois@bootlin.com>
References: <20231114090743.865453-1-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding for the IPQESS Ethernet switch subsystem, that
integrates a modified QCA8K switch and an EDMA MAC controller. It inherits
from a basic ethernet switch binding and adds three regmaps, a phandle and
reset line for the PSGMII, a phandle to the MDIO bus, a clock, and 32
interrupts.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../bindings/net/qcom,ipq4019-ess.yaml        | 152 ++++++++++++++++++
 1 file changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml
new file mode 100644
index 000000000000..85dff85e50b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml
@@ -0,0 +1,152 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qcom,ipq4019-ess.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ4019 Ethernet Switch Subsystem
+
+maintainers:
+  - Romain Gantois <romain.gantois@bootlin.com>
+
+$ref: ethernet-switch.yaml#
+
+properties:
+  compatible:
+    const: qcom,ipq4019-ess
+
+  reg:
+    items:
+      - description: Base ESS registers, which configure the integrated QCA8K switch.
+      - description: ESS PSGMII-related registers, which control VCO calibration and link
+                     modes.
+      - description: ESS EDMA controller registers. The EDMA controller is an Ethernet
+                     controller connected to the integrated switch's CPU port.
+  reg-names:
+    items:
+      - const: base
+      - const: psgmii_phy
+      - const: edma
+
+  resets:
+    items:
+      - description: Handle to the PSGMII reset line.
+      - description: Handle to the ESS reset line.
+
+  reset-names:
+    items:
+      - const: psgmii
+      - const: ess
+
+  clocks:
+    maxItems: 1
+    description: Handle to the GCC ESS clock
+
+  mdio:
+    maxItems: 1
+    description: Handle to the IPQ4019 MDIO Controller
+
+  interrupts:
+    maxItems: 32
+    description: One interrupt per tx and rx queue, the first 16 are rx queues
+                 and the last 16 are the tx queues
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - resets
+  - reset-names
+  - clocks
+  - mdio
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq4019.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    switch: switch@c000000 {
+        compatible = "qcom,ipq4019-ess";
+        reg = <0xc000000 0x80000>, <0x98000 0x800>, <0xc080000 0x80000>;
+        reg-names = "base", "psgmii_phy", "edma";
+        resets = <&gcc ESS_PSGMII_ARES>, <&gcc ESS_RESET>;
+        reset-names = "psgmii", "ess";
+        clocks = <&gcc GCC_ESS_CLK>;
+        mdio = <&mdio>;
+        interrupts = <GIC_SPI  65 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  66 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  67 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  68 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  69 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  70 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  71 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  72 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  73 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  74 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  75 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  76 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  77 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  78 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  79 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI  80 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 240 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 241 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 242 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 243 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 244 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 245 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 246 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 247 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 248 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 249 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 251 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 252 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 253 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 254 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 255 IRQ_TYPE_EDGE_RISING>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            swport1: port@1 { /* MAC1 */
+                 reg = <1>;
+                 label = "lan1";
+                 phy-handle = <&ethphy0>;
+                 phy-mode = "psgmii";
+            };
+
+            swport2: port@2 { /* MAC2 */
+                 reg = <2>;
+                 label = "lan2";
+                 phy-handle = <&ethphy1>;
+                 phy-mode = "psgmii";
+            };
+
+            swport3: port@3 { /* MAC3 */
+                 reg = <3>;
+                 label = "lan3";
+                 phy-handle = <&ethphy2>;
+                 phy-mode = "psgmii";
+            };
+
+            swport4: port@4 { /* MAC4 */
+                 reg = <4>;
+                 label = "lan4";
+                 phy-handle = <&ethphy3>;
+                 phy-mode = "psgmii";
+            };
+
+            swport5: port@5 { /* MAC5 */
+                 reg = <5>;
+                 label = "wan";
+                 phy-handle = <&ethphy4>;
+                 phy-mode = "psgmii";
+            };
+        };
+    };
+
+...
-- 
2.42.0

