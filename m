Return-Path: <linux-kernel+bounces-84275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 333E286A47A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91293B241EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF171370;
	Wed, 28 Feb 2024 00:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="g+cu04nS"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE79A23;
	Wed, 28 Feb 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709080258; cv=none; b=ioH0GOQn1z1fbQk/6jS5f31lJ1RXaInlgz+QrN7RNwh++lGXc22V3nRhwaNu1DHOnC0PnecWIS+gDmJTwLW5UR6Z067YVXzyVahbRwV/kvFYOGQsewqnlwFOBvgdC1cXKtymGKZlpzGN4EijFIKDfXBFBLK6uE+s9SBT6ksvUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709080258; c=relaxed/simple;
	bh=0IFCv/0aK6fypSuncnsHMiXiUxtvQ0GHZOxUPi4VJJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E+TCs05/VTauPhy9NDEqpzrRn1SyndXm6RLbHJZ8osuOlgaZiQuE2B62+z0+EqcecmWzgOloxT5eHuOa0ugDmclpGx/IepSoIaI+PmDFZXDGpxXJJBRFdMarkxJy+CFvz85AVz1BPUNo5jStBzpeHfqPGx44oJCecSdeiDMnabw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=g+cu04nS; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from localhost.localdomain (ppp14-2-70-176.adl-apt-pir-bras31.tpg.internode.on.net [14.2.70.176])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A4706200B6;
	Wed, 28 Feb 2024 08:30:49 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1709080252;
	bh=L4gBKjwP0JrUsbJ9rNJ5WClpLLZ7sriH9iUkPu4ER04=;
	h=From:To:Cc:Subject:Date;
	b=g+cu04nSihry64l1um7FpaPu3lbfmWecOynlwgfh/gThSEAJ83v6Q4be/C9GvTvKc
	 fBgyvauN+XqKnWs+hpgF2mx5Lax0p/FljK5OycTCG6JYifbT/V263tZ//L0ZbJetA3
	 l5/Lku9gNfULFkBc4v+Q/7LN8KB1pe8ZPPgXwFF+lNOhPuPfeUl+kkegfwBqlDrqeQ
	 p3YdeNWHNc6FgmynHYEWsKgufRw7vO9ooAYh94b56+oP4uNU4FRJnprSWjsCC95xSw
	 FvfT38D4tM/codsZjGIgiA5Idyc9AiThfAaV5NBiRWhKT1ZDqlLFOrhCjqXwgLoTsi
	 kaWbZ+1ABEFCw==
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	krzysztof.kozlowski+dt@linaro.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to DT schema
Date: Wed, 28 Feb 2024 11:00:43 +1030
Message-Id: <20240228003043.1167394-1-andrew@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Squash warnings such as:

```
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e600000/gpio@1e780000: failed to match any schema with compatible: ['aspeed,ast2400-gpio']
```

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
v6: Address more constraint feedback from Krzysztof:
    https://lore.kernel.org/all/f69ef2ad-8ace-40c8-b923-4dde20eda2ec@linaro.org/

v5: https://lore.kernel.org/all/20240227052353.1060306-1-andrew@codeconstruct.com.au/

    Resolve macro definition clashes from aspeed clock headers in examples
    identified by Rob's bot:

    https://lore.kernel.org/all/170900020204.2360855.790404478830111761.robh@kernel.org/

    Clearly I missed running `make dt_binding_check` on the final iteration of
    the v4 patch I sent. Hopefully I'm running out of rakes to step on here!

v4: https://lore.kernel.org/all/20240227004414.841391-1-andrew@codeconstruct.com.au/

    Add constraints for gpio-line-names, ngpios as requested by Krzysztof:
    https://lore.kernel.org/all/458becdb-fb1e-4808-87b6-3037ec945647@linaro.org/

    Add more examples to exercise constraints.

v3: https://lore.kernel.org/all/20240226051645.414935-1-andrew@codeconstruct.com.au/

    Base on v6.8-rc6, fix yamllint warning

    Rob's bot picked the missing `#interrupt-cells` in the example on v2[1]. The
    patch was based on v6.8-rc1, and going back over my shell history I missed
    the following output from `make dt_binding_check`:

    ```
    ...
      LINT    Documentation/devicetree/bindings
      usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [-f {parsable,standard,colored,github,auto}] [-s] [--no-warnings] [-v] [FILE_OR_DIR ...]
      yamllint: error: one of the arguments FILE_OR_DIR - is required   
    ...
    ```

    I've rebased on v6.8-rc6 and no-longer see the issue with the invocation
    of `yamllint`.

[1]: https://lore.kernel.org/all/170892197611.2260479.15343562563553959436.robh@kernel.org/

v2: https://lore.kernel.org/all/20240226031951.284847-1-andrew@codeconstruct.com.au/

    Address feedback from Krzysztof:
    https://lore.kernel.org/all/0d1dd262-b6dd-4d71-9239-8b0aec8cceff@linaro.org/

v1: https://lore.kernel.org/all/20240220052918.742793-1-andrew@codeconstruct.com.au/

 .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 148 ++++++++++++++++++
 .../devicetree/bindings/gpio/gpio-aspeed.txt  |  39 -----
 2 files changed, 148 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
new file mode 100644
index 000000000000..cf11aa7ec8c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
@@ -0,0 +1,148 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed GPIO controller
+
+maintainers:
+  - Andrew Jeffery <andrew@codeconstruct.com.au>
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-gpio
+      - aspeed,ast2500-gpio
+      - aspeed,ast2600-gpio
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: The clock to use for debounce timings
+
+  gpio-controller: true
+  gpio-line-names:
+    minItems: 36
+    maxItems: 232
+
+  gpio-ranges: true
+
+  "#gpio-cells":
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  ngpios:
+    minimum: 36
+    maximum: 232
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - gpio-controller
+  - "#gpio-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2400-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 220
+          maxItems: 220
+        ngpios:
+          const: 220
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2500-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 232
+          maxItems: 232
+        ngpios:
+          const: 232
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2600-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 36
+          maxItems: 208
+        ngpios:
+          enum: [ 36, 208 ]
+      required:
+        - ngpios
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio@1e780000 {
+        compatible = "aspeed,ast2400-gpio";
+        reg = <0x1e780000 0x1000>;
+        interrupts = <20>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
+  - |
+    gpio: gpio@1e780000 {
+        compatible = "aspeed,ast2500-gpio";
+        reg = <0x1e780000 0x200>;
+        interrupts = <20>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&pinctrl 0 0 232>;
+    };
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    gpio0: gpio@1e780000 {
+        compatible = "aspeed,ast2600-gpio";
+        reg = <0x1e780000 0x400>;
+        clocks = <&syscon ASPEED_CLK_APB2>;
+        interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        #gpio-cells = <2>;
+        gpio-controller;
+        gpio-ranges = <&pinctrl 0 0 208>;
+        ngpios = <208>;
+    };
+    gpio1: gpio@1e780800 {
+        compatible = "aspeed,ast2600-gpio";
+        reg = <0x1e780800 0x800>;
+        clocks = <&syscon ASPEED_CLK_APB1>;
+        interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&pinctrl 0 208 36>;
+        ngpios = <36>;
+    };
diff --git a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt b/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
deleted file mode 100644
index b2033fc3a71a..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-Aspeed GPIO controller Device Tree Bindings
--------------------------------------------
-
-Required properties:
-- compatible		: Either "aspeed,ast2400-gpio", "aspeed,ast2500-gpio",
-					or "aspeed,ast2600-gpio".
-
-- #gpio-cells 		: Should be two
-			  - First cell is the GPIO line number
-			  - Second cell is used to specify optional
-			    parameters (unused)
-
-- reg			: Address and length of the register set for the device
-- gpio-controller	: Marks the device node as a GPIO controller.
-- interrupts		: Interrupt specifier (see interrupt bindings for
-			  details)
-- interrupt-controller	: Mark the GPIO controller as an interrupt-controller
-
-Optional properties:
-
-- clocks		: A phandle to the clock to use for debounce timings
-- ngpios		: Number of GPIOs controlled by this controller. Should	be set
-				  when there are multiple GPIO controllers on a SoC (ast2600).
-
-The gpio and interrupt properties are further described in their respective
-bindings documentation:
-
-- Documentation/devicetree/bindings/gpio/gpio.txt
-- Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-  Example:
-	gpio@1e780000 {
-		#gpio-cells = <2>;
-		compatible = "aspeed,ast2400-gpio";
-		gpio-controller;
-		interrupts = <20>;
-		reg = <0x1e780000 0x1000>;
-		interrupt-controller;
-	};

base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
-- 
2.39.2


