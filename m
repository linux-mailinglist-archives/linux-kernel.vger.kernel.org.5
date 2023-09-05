Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3042A7932A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 01:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbjIEXb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 19:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjIEXb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:31:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39ECCF4;
        Tue,  5 Sep 2023 16:31:44 -0700 (PDT)
Received: from pyrite.hamster-moth.ts.net (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 186FC1536;
        Wed,  6 Sep 2023 01:30:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693956616;
        bh=E6qIR6/SVB1fqZgbLfaas48X4WN5Vpk1EBnoG8kWBSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZ3blbWx7G0Ms22EL3dIAGVzvGMDmRcr5CBzaRaQ3CgGus63C0PeD2WW6j7VqsNCd
         UyQEiVRB2cxbx19HGXPUTzzzlsuffQbvMV71ijL4mXgUdu+wm3ENdZib07/OHav9Hj
         2vxmaLRhfkCxZy9qzZpYXkLDLs7kYMZYz2hEmfOY=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: media: Add THine THP7312 ISP
Date:   Wed,  6 Sep 2023 08:31:16 +0900
Message-Id: <20230905233118.183140-2-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905233118.183140-1-paul.elder@ideasonboard.com>
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the THine THP7312 ISP.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
Since the THP7312 supports multiple sensors, thine,rx-data-lanes alone
might not be enough. I was consdering using sensor nodes like what the
AP1302 does [1]. This way we can also move the power supplies that only
concern the sensor in there as well. I was wondering what to do about
the model name, though, as the thp7312 completely isolates that from the 
rest of the system.

I'm planning to add sensor nodes in somehow in a v2.

[1] https://lore.kernel.org/linux-media/20211006113254.3470-2-anil.mamidala@xilinx.com/

 .../bindings/media/thine,thp7312.yaml         | 170 ++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/thine,thp7312.yaml

diff --git a/Documentation/devicetree/bindings/media/thine,thp7312.yaml b/Documentation/devicetree/bindings/media/thine,thp7312.yaml
new file mode 100644
index 000000000000..e8d203dcda81
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/thine,thp7312.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2023 Ideas on Board
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/thine,thp7312.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: THine THP7312
+
+maintainers:
+  - Paul Elder <paul.elder@@ideasonboard.com>
+
+description:
+  The THP7312 is a standalone ISP controlled over i2c, and is capable of
+  various image processing and correction functions, including 3A control. It
+  can be connected to CMOS image sensors from various vendors, supporting both
+  MIPI CSI-2 and parallel interfaces. It can also output on either MIPI CSI-2
+  or parallel. The hardware is capable of transmitting and receiving MIPI
+  interlaved data strams with data types or multiple virtual channel
+  identifiers.
+
+allOf:
+  - $ref: ../video-interface-devices.yaml#
+
+properties:
+  compatible:
+    const: thine,thp7312
+
+  reg:
+    description: I2C device address
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+      - description: CLKI clock input
+
+  reset-gpios:
+    maxItems: 1
+    description: |-
+      Reference to the GPIO connected to the RESET_N pin, if any.
+      Must be released (set high) after all supplies are applied.
+
+  vddcore-supply:
+    description:
+      1.2V supply for core, PLL, MIPI rx and MIPI tx.
+
+  vhtermnx-supply:
+    description:
+      Supply for input (rx). 1.8V for MIPI, or 1.8/2.8/3.3V for parallel.
+
+  vddtx-supply:
+    description:
+      Supply for output (tx). 1.8V for MIPI, or 1.8/2.8/3.3V for parallel.
+
+  vddhost-supply:
+    description:
+      Supply for host interface. 1.8V, 2.8V, or 3.3V.
+
+  vddcmos-supply:
+    description:
+      Supply for sensor interface. 1.8V, 2.8V, or 3.3V.
+
+  vddgpio_0-supply:
+    description:
+      Supply for GPIO_0. 1.8V, 2.8V, or 3.3V.
+
+  vddgpio_1-supply:
+    description:
+      Supply for GPIO_1. 1.8V, 2.8V, or 3.3V.
+
+  DOVDD-supply:
+    description:
+      Digital I/O (1.8V) supply for image sensor.
+
+  AVDD-supply:
+    description:
+      Analog (2.8V) supply for image sensor.
+
+  DVDD-supply:
+    description:
+      Digital Core (1.2V) supply for image sensor.
+
+  orientation: true
+  rotation: true
+
+  thine,rx,data-lanes:
+    minItems: 4
+    maxItems: 4
+    $ref: /schemas/media/video-interfaces.yaml#data-lanes
+    description: |-
+      This property is for lane reordering between the THP7312 and the imaging
+      sensor that it is connected to.
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            description: |-
+              The sensor supports either two-lane, or four-lane operation.
+              This property is for lane reordering between the THP7312 and
+              the SoC. If this property is omitted four-lane operation is
+              assumed. For two-lane operation the property must be set to <1 2>.
+            minItems: 2
+            maxItems: 4
+            items:
+              maximum: 4
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - clocks
+  - vddcore-supply
+  - vhtermrx-supply
+  - vddtx-supply
+  - vddhost-supply
+  - vddcmos-supply
+  - vddgpio_0-supply
+  - vddgpio_1-supply
+  - DOVDD-supply
+  - AVDD-supply
+  - DVDD-supply
+  - thine,rx,data-lanes
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        camera@61 {
+            compatible = "thine,thp7312";
+            reg = <0x61>;
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&cam1_pins_default>;
+
+            reset-gpios = <&pio 119 GPIO_ACTIVE_LOW>;
+            clocks = <&camera61_clk>;
+
+            vddcore-supply = <&vsys_v4p2>;
+            AVDD-supply = <&vsys_v4p2>;
+            DVDD-supply = <&vsys_v4p2>;
+
+            orientation = <0>;
+            rotation = <0>;
+
+            thine,rx,data-lanes = <4 1 3 2>;
+
+            port {
+                thp7312_2_endpoint: endpoint {
+                    remote-endpoint = <&mipi_thp7312_2>;
+                    data-lanes = <4 2 1 3>;
+                };
+            };
+    	  };
+    };
+...
-- 
2.39.2

