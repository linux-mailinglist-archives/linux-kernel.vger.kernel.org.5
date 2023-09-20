Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD377A881C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjITPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjITPVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:21:06 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195A2D6;
        Wed, 20 Sep 2023 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=4scuTDFThnKNZT0kBJP6miFC8QUgbQ0WglCdxy6a73A=; b=McthI7dHIcgtALHCYekt0Cgq6h
        2ecR4MMY/RotTem4AEg75O12MwZTLdmX+e0nKr5toYl8jMXeY1iJJb0tqsJg3VVCRsB3kCNQkCFIN
        5sRM6GXqlsc74gLTF76f8mxSmKDzYIp8cQi4g9YdZDH+Lxm+ZJrXcLkB07uVA2UYctq4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:43190 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qiz0a-0008Co-EN; Wed, 20 Sep 2023 11:20:57 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, hugo@hugovil.com
Date:   Wed, 20 Sep 2023 11:20:15 -0400
Message-Id: <20230920152015.1376838-5-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230920152015.1376838-1-hugo@hugovil.com>
References: <20230920152015.1376838-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 4/4] dt-bindings: sc16is7xx: convert to YAML
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Convert binding from text format to YAML.

Additions to original text binding:
  - add rs485 reference.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 .../bindings/serial/nxp,sc16is7xx.txt         | 118 ----------------
 .../bindings/serial/nxp,sc16is7xx.yaml        | 126 ++++++++++++++++++
 2 files changed, 126 insertions(+), 118 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
 create mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
deleted file mode 100644
index d89815c5c562..000000000000
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
+++ /dev/null
@@ -1,118 +0,0 @@
-* NXP SC16IS7xx advanced Universal Asynchronous Receiver-Transmitter (UART)
-* i2c as bus
-
-Required properties:
-- compatible: Should be one of the following:
-  - "nxp,sc16is740" for NXP SC16IS740,
-  - "nxp,sc16is741" for NXP SC16IS741,
-  - "nxp,sc16is750" for NXP SC16IS750,
-  - "nxp,sc16is752" for NXP SC16IS752,
-  - "nxp,sc16is760" for NXP SC16IS760,
-  - "nxp,sc16is762" for NXP SC16IS762.
-- reg: I2C address of the SC16IS7xx device.
-- interrupts: Should contain the UART interrupt
-- clocks: Reference to the IC source clock.
-	OR (when there is no clock provider visible to the platform)
-- clock-frequency: The source clock frequency for the IC.
-
-Optional properties:
-- gpio-controller: Marks the device node as a GPIO controller.
-- #gpio-cells: Should be two. The first cell is the GPIO number and
-  the second cell is used to specify the GPIO polarity:
-    0 = active high,
-    1 = active low.
-- nxp,irda-mode-ports: An array that lists the indices of the port that
-		       should operate in IrDA mode.
-- nxp,modem-control-line-ports: An array that lists the indices of the port that
-				should have shared GPIO lines configured as
-				modem control lines.
-
-Example:
-        sc16is750: sc16is750@51 {
-                compatible = "nxp,sc16is750";
-                reg = <0x51>;
-                clocks = <&clk20m>;
-                interrupt-parent = <&gpio3>;
-                interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
-                gpio-controller;
-                #gpio-cells = <2>;
-        };
-
-	sc16is752: sc16is752@53 {
-		compatible = "nxp,sc16is752";
-		reg = <0x53>;
-		clocks = <&clk20m>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
-		nxp,modem-control-line-ports = <1>; /* Port 1 as modem control lines */
-		gpio-controller; /* Port 0 as GPIOs */
-		#gpio-cells = <2>;
-	};
-
-	sc16is752: sc16is752@54 {
-		compatible = "nxp,sc16is752";
-		reg = <0x54>;
-		clocks = <&clk20m>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
-		nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
-	};
-
-* spi as bus
-
-Required properties:
-- compatible: Should be one of the following:
-  - "nxp,sc16is740" for NXP SC16IS740,
-  - "nxp,sc16is741" for NXP SC16IS741,
-  - "nxp,sc16is750" for NXP SC16IS750,
-  - "nxp,sc16is752" for NXP SC16IS752,
-  - "nxp,sc16is760" for NXP SC16IS760,
-  - "nxp,sc16is762" for NXP SC16IS762.
-- reg: SPI chip select number.
-- interrupts: Specifies the interrupt source of the parent interrupt
-  controller. The format of the interrupt specifier depends on the
-  parent interrupt controller.
-- clocks: phandle to the IC source clock.
-
-Optional properties:
-- gpio-controller: Marks the device node as a GPIO controller.
-- #gpio-cells: Should be two. The first cell is the GPIO number and
-  the second cell is used to specify the GPIO polarity:
-    0 = active high,
-    1 = active low.
-- nxp,irda-mode-ports: An array that lists the indices of the port that
-		       should operate in IrDA mode.
-- nxp,modem-control-line-ports: An array that lists the indices of the port that
-				should have shared GPIO lines configured as
-				modem control lines.
-
-Example:
-	sc16is750: sc16is750@0 {
-		compatible = "nxp,sc16is750";
-		reg = <0>;
-		clocks = <&clk20m>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	sc16is752: sc16is752@1 {
-		compatible = "nxp,sc16is752";
-		reg = <1>;
-		clocks = <&clk20m>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
-		nxp,modem-control-line-ports = <1>; /* Port 1 as modem control lines */
-		gpio-controller; /* Port 0 as GPIOs */
-		#gpio-cells = <2>;
-	};
-
-	sc16is752: sc16is752@2 {
-		compatible = "nxp,sc16is752";
-		reg = <2>;
-		clocks = <&clk20m>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
-		nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
-	};
diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
new file mode 100644
index 000000000000..508639e09e06
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/nxp,sc16is7xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP SC16IS7xx advanced Universal Asynchronous Receiver-Transmitter (UART)
+
+maintainers:
+  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,sc16is740
+      - nxp,sc16is741
+      - nxp,sc16is750
+      - nxp,sc16is752
+      - nxp,sc16is760
+      - nxp,sc16is762
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: Reference to the IC source clock.
+
+  clock-frequency:
+    description: |
+      When there is no clock provider visible to the platform, this
+      is the source crystal or external clock frequency for the IC in Hz.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 80000000
+
+  gpio-controller:
+    description: Marks the device node as a GPIO controller.
+    type: boolean
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-line-names:
+    minItems: 1
+    maxItems: 8
+
+  nxp,irda-mode-ports:
+    description: |
+      An array that lists the indices of the port that should operate in IrDA
+      mode:
+      0: port A
+      1: port B
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 2
+    items:
+      minimum: 0
+      maximum: 1
+
+  nxp,modem-control-line-ports:
+    description: |
+      An array that lists the indices of the port that should have shared GPIO
+      lines configured as modem control lines:
+      0: port A
+      1: port B
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 2
+    items:
+      minimum: 0
+      maximum: 1
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: /schemas/serial/serial.yaml#
+  - $ref: /schemas/serial/rs485.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+oneOf:
+  - required:
+      - clocks
+  - required:
+      - clock-frequency
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    serial0: serial@51 {
+        compatible = "nxp,sc16is750";
+        reg = <0x51>;
+        clocks = <&clk20m>;
+        interrupt-parent = <&gpio3>;
+        interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
+
+    serial1: serial@53 {
+        compatible = "nxp,sc16is752";
+        reg = <0x53>;
+        clocks = <&clk20m>;
+        interrupt-parent = <&gpio3>;
+        interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+        nxp,modem-control-line-ports = <1>; /* Port 1 as modem control lines */
+        gpio-controller; /* Port 0 as GPIOs */
+        #gpio-cells = <2>;
+    };
+
+    serial2: serial@54 {
+        compatible = "nxp,sc16is752";
+        reg = <0x54>;
+        clocks = <&clk20m>;
+        interrupt-parent = <&gpio3>;
+        interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+        nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
+    };
-- 
2.30.2

