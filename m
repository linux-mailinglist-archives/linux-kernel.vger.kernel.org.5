Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF67C604B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjJKWV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJKWVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:21:25 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C9AB8;
        Wed, 11 Oct 2023 15:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=j0lKlo34pg/0a0B2e7rNH4hcNejowX7t2+Le7q0Qbrg=; b=cBQSMF35Hown+M2FtHLQx7n63s
        qfppfY99To5Ke/yfP2U/YkPiXtBqy7Wikl6cB4yayoeBSEDKkPg8DqDaONAjIvETNYIqwb3DtVHdB
        K6+cAkgTL4vjolnN1z4s9FNtYGwc+eK/elTPCcPuQO7zv8QdJdE8KBWgR4SIWaolgrac=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:53922 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qqhZr-0007QE-2I; Wed, 11 Oct 2023 18:21:16 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc:     hugo@hugovil.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Date:   Wed, 11 Oct 2023 18:21:05 -0400
Message-Id: <20231011222105.2587175-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH] dt-bindings: max310x: convert to YAML
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
 .../bindings/serial/maxim,max310x.txt         |  48 --------
 .../bindings/serial/maxim,max310x.yaml        | 107 ++++++++++++++++++
 2 files changed, 107 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/maxim,max310x.txt
 create mode 100644 Documentation/devicetree/bindings/serial/maxim,max310x.yaml

diff --git a/Documentation/devicetree/bindings/serial/maxim,max310x.txt b/Documentation/devicetree/bindings/serial/maxim,max310x.txt
deleted file mode 100644
index 79e10a05a96a..000000000000
--- a/Documentation/devicetree/bindings/serial/maxim,max310x.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-* Maxim MAX310X advanced Universal Asynchronous Receiver-Transmitter (UART)
-
-Required properties:
-- compatible: Should be one of the following:
-  - "maxim,max3107" for Maxim MAX3107,
-  - "maxim,max3108" for Maxim MAX3108,
-  - "maxim,max3109" for Maxim MAX3109,
-  - "maxim,max14830" for Maxim MAX14830.
-- reg: SPI chip select number.
-- interrupts: Specifies the interrupt source of the parent interrupt
-  controller. The format of the interrupt specifier depends on the
-  parent interrupt controller.
-- clocks: phandle to the IC source clock.
-- clock-names: Should be "xtal" if clock is an external crystal or
-  "osc" if an external clock source is used.
-
-Optional properties:
-- gpio-controller: Marks the device node as a GPIO controller.
-- #gpio-cells: Should be two. The first cell is the GPIO number and
-  the second cell is used to specify the GPIO polarity:
-    0 = active high,
-    1 = active low.
-
-Example:
-
-/ {
-	clocks {
-		spi_uart_clk: osc_max14830 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <3686400>;
-		};
-
-	};
-};
-
-&spi0 {
-	max14830: max14830@0 {
-		compatible = "maxim,max14830";
-		reg = <0>;
-		clocks = <&spi_uart_clk>;
-		clock-names = "osc";
-		interrupt-parent = <&gpio3>;
-		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/serial/maxim,max310x.yaml b/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
new file mode 100644
index 000000000000..05fd00d95260
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/maxim,max310x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX310X Advanced Universal Asynchronous Receiver-Transmitter (UART)
+
+maintainers:
+  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
+
+properties:
+  compatible:
+    enum:
+      - maxim,max3107
+      - maxim,max3108
+      - maxim,max3109
+      - maxim,max14830
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency:
+    description:
+      When there is no clock provider visible to the platform, this
+      is the source crystal frequency for the IC in Hz.
+    minimum: 1000000
+    maximum: 4000000
+
+  clock-names:
+    enum:
+      - xtal # External crystal
+      - osc  # External clock source
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-line-names:
+    minItems: 1
+    maxItems: 16
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
+      - clock-names
+  - required:
+      - clock-frequency
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        serial@2c {
+            compatible = "maxim,max3107";
+            reg = <0x2c>;
+            clocks = <&xtal4m>;
+            clock-names = "xtal";
+            interrupt-parent = <&gpio3>;
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+
+        serial@60 {
+            compatible = "maxim,max3108";
+            reg = <0x60>;
+            clocks = <&clk20m>;
+            clock-names = "osc";
+            interrupt-parent = <&gpio3>;
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+
+        serial@6f {
+            compatible = "maxim,max14830";
+            reg = <0x6f>;
+            clock-frequency = <3000000>;
+            interrupt-parent = <&gpio3>;
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };

base-commit: 8182d7a3f1b8982c0136dca82a846ea375a4d6e9
-- 
2.39.2

