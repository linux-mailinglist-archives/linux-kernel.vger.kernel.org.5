Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777577A0DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbjINTB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbjINTBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:01:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E559E1FC8;
        Thu, 14 Sep 2023 12:00:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B60C433C7;
        Thu, 14 Sep 2023 19:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694718040;
        bh=e/WqClIhZFIvxsH2m/vcZyh47owt6UND8vvCxVGOp3A=;
        h=From:To:Cc:Subject:Date:From;
        b=Fdu3g6acgNeWRXRtXWywO5/uC/2b5ExwuI4KqocoA62A2COH3+y92OYVKzlMnQ3jG
         eXbFaqn0dhrw0q3lNNntAMly6+6TMivTL29K0+esWcY3m4r+2QsOEzHlR57XXGk7G+
         1Yul+eqdwV7JD4A0WOrNygJ8/65BFyaOQbHabmR/sImVn4xOGE+4FRHyGSmaahg8gG
         z0uqaIVnkEBqVZQfNcsgPc63REpAl2X8jwfKh3OimorCs/8yWweV1YJk7oZxFXL9q5
         O4ud2LpaGQ5ygovHBiHoDcvcIRtSAqIOjo5MRPbMdH+oJHqHBUTvmO6ypaq7bmt7E1
         pM1yNXSxTN3aQ==
Received: (nullmailer pid 1853065 invoked by uid 1000);
        Thu, 14 Sep 2023 19:00:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: dt-bindings: arm,pl022: Move child node properties to separate schema
Date:   Thu, 14 Sep 2023 14:00:17 -0500
Message-Id: <20230914190033.1852600-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to validate SPI peripherals, SPI controller-specific child node
properties need to be in a separate schema, spi-peripheral-props.yaml,
which SPI peripheral schemas reference. Move the arm,pl022 child
properties to their own schema file and add a $ref in
spi-peripheral-props.yaml.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../spi/arm,pl022-peripheral-props.yaml       | 61 +++++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml    |  1 +
 .../devicetree/bindings/spi/spi-pl022.yaml    | 51 ----------------
 3 files changed, 62 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/arm,pl022-peripheral-props.yaml

diff --git a/Documentation/devicetree/bindings/spi/arm,pl022-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/arm,pl022-peripheral-props.yaml
new file mode 100644
index 000000000000..bb8b6863b109
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/arm,pl022-peripheral-props.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/arm,pl022-peripheral-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Peripheral-specific properties for Arm PL022 SPI controller
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+select: false
+
+properties:
+  pl022,interface:
+    description: SPI interface type
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0      # SPI
+      - 1      # Texas Instruments Synchronous Serial Frame Format
+      - 2      # Microwire (Half Duplex)
+
+  pl022,com-mode:
+    description: Specifies the transfer mode
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0      # interrupt mode
+      - 1      # polling mode
+      - 2      # DMA mode
+    default: 1
+
+  pl022,rx-level-trig:
+    description: Rx FIFO watermark level
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 4
+
+  pl022,tx-level-trig:
+    description: Tx FIFO watermark level
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 4
+
+  pl022,ctrl-len:
+    description: Microwire interface - Control length
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x03
+    maximum: 0x1f
+
+  pl022,wait-state:
+    description: Microwire interface - Wait state
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+  pl022,duplex:
+    description: Microwire interface - Full/Half duplex
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+additionalProperties: true
+...
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 782a014b63a7..dc4f7bb47090 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -115,6 +115,7 @@ properties:
 
 # The controller specific properties go here.
 allOf:
+  - $ref: arm,pl022-peripheral-props.yaml#
   - $ref: cdns,qspi-nor-peripheral-props.yaml#
   - $ref: samsung,spi-peripheral-props.yaml#
   - $ref: nvidia,tegra210-quad-peripheral-props.yaml#
diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index 5e5a704a766e..7f174b7d0a26 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -74,57 +74,6 @@ properties:
   resets:
     maxItems: 1
 
-patternProperties:
-  "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-f]+$":
-    type: object
-    # SPI slave nodes must be children of the SPI master node and can
-    # contain the following properties.
-    properties:
-      pl022,interface:
-        description: SPI interface type
-        $ref: /schemas/types.yaml#/definitions/uint32
-        enum:
-          - 0      # SPI
-          - 1      # Texas Instruments Synchronous Serial Frame Format
-          - 2      # Microwire (Half Duplex)
-
-      pl022,com-mode:
-        description: Specifies the transfer mode
-        $ref: /schemas/types.yaml#/definitions/uint32
-        enum:
-          - 0      # interrupt mode
-          - 1      # polling mode
-          - 2      # DMA mode
-        default: 1
-
-      pl022,rx-level-trig:
-        description: Rx FIFO watermark level
-        $ref: /schemas/types.yaml#/definitions/uint32
-        minimum: 0
-        maximum: 4
-
-      pl022,tx-level-trig:
-        description: Tx FIFO watermark level
-        $ref: /schemas/types.yaml#/definitions/uint32
-        minimum: 0
-        maximum: 4
-
-      pl022,ctrl-len:
-        description: Microwire interface - Control length
-        $ref: /schemas/types.yaml#/definitions/uint32
-        minimum: 0x03
-        maximum: 0x1f
-
-      pl022,wait-state:
-        description: Microwire interface - Wait state
-        $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [0, 1]
-
-      pl022,duplex:
-        description: Microwire interface - Full/Half duplex
-        $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [0, 1]
-
 required:
   - compatible
   - reg
-- 
2.40.1

