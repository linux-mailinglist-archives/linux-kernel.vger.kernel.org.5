Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C40C7D3B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjJWPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjJWPuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:50:15 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A8F127;
        Mon, 23 Oct 2023 08:50:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2FB91BF208;
        Mon, 23 Oct 2023 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698076208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yuCpGuToREVg41/lmByogXykAGaEM+x67Szl0gpgQI4=;
        b=dv9LlfqineMcniEywwvOfYShADtiCDoO0eYL7fzbATZnKBu6/rlUCyAqxZgleo5oEcl1ES
        r18R4RouunwSRtYbFHhFN1R+lQDGfZ0IiTh5EquLEEFMmkPldMWSjCMxL/YEDBR9sHlJ6M
        F3lLF8udVJPbXd9tfc5YE5RTYO0KLBmlyDQCgDA+r3/OYouvO8ttr8RntvnCqpnMxuH7SU
        Pxter4DPidWvxDkzbrtMPZyw322PT4kS18O1CRAMF3Syir1XKbYKUCAlLpAKeFk8JPeUzp
        z1/RELsDbPl0ESyjqMSXD4Mxqcf43k1j2yOMY2RABxceE8Lg9/MBQfJy5l+kyQ==
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
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next 1/5] net: dt-bindings: Introduce the Qualcomm IPQESS Ethernet switch
Date:   Mon, 23 Oct 2023 17:50:08 +0200
Message-ID: <20231023155013.512999-2-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023155013.512999-1-romain.gantois@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..9bb6b010ea6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml
@@ -0,0 +1,152 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qcom,ipq4019-ess.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ4019 Ethernet switch subsystem driver
+
+maintainers:
+  - Romain Gantois <romain.gantois@bootlin.com>
+
+$ref: ethernet-switch.yaml#
+
+properties:
+  compatible:
+    const: qca,ipq4019-qca8337n
+
+  reg:
+    maxItems: 3
+    description: Base ESS registers, PSGMII registers and EDMA registers
+
+  reg-names:
+    maxItems: 3
+
+  resets:
+    maxItems: 2
+    description: Handles to the PSGMII and ESS reset lines
+
+  reset-names:
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+    description: Handle to the GCC ESS clock
+
+  clock-names:
+    maxItems: 1
+
+  psgmii-ethphy:
+    maxItems: 1
+    description: Handle to the MDIO bus node corresponding to the PSGMII
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
+  - clock-names
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
+        compatible = "qca,ipq4019-qca8337n";
+        reg = <0xc000000 0x80000>, <0x98000 0x800>, <0xc080000 0x80000>;
+        reg-names = "base", "psgmii_phy", "edma";
+        resets = <&gcc ESS_PSGMII_ARES>, <&gcc ESS_RESET>;
+        reset-names = "psgmii_rst", "ess";
+        clocks = <&gcc GCC_ESS_CLK>;
+        clock-names = "ess";
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

