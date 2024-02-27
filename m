Return-Path: <linux-kernel+bounces-82478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED92786851E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2A31F2214F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85D94C80;
	Tue, 27 Feb 2024 00:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="D5Y1UnlA"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92364C61;
	Tue, 27 Feb 2024 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994670; cv=none; b=N6ocYTynWTkLhferNu4iOkzyX9A/MqBE/Ti3xIcEkj+sk7UsWv5Nr2ieIB9O8Z74EjPl1qD+Pa8jvc//2uq6SZFYO4d/6uPSWolkl6LXD6YviM3QWiiMp7T+UfUD0SWuejHyHJRAejpUTOv6+/J88nO+BUW7Af3BcRFtEN0oy88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994670; c=relaxed/simple;
	bh=cNFhcR6UKdzppE+9Oo4xN02Xl4wSTkTv4lkPpxARzlc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UmjDU9d06zaoScc15+saP96XKv4K0PdncvfeLOTivGpHxbz5M2lbcz+DYZUFPvbUCZrC4AremuguuxR4ZlpsEs8QRed07k19By5rsnvqV+UceMldC9knLXWsofY93WqF90hMJF0X5ddni8dVnj2noxu6N9OAXYyFahiZ2Ajp9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=D5Y1UnlA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from localhost.localdomain (unknown [120.20.22.137])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 086E520127;
	Tue, 27 Feb 2024 08:44:21 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708994665;
	bh=Ca/9sKvjcNdwT2jNocS9+Pqis6uqPGYxjdQcRGzr4PM=;
	h=From:To:Cc:Subject:Date;
	b=D5Y1UnlAi2V621CUNK7697LYH4CARfNwf1mia/d0VwmEYUKErtNJblhxT5Fi9ojaI
	 jNacK8lV13+I3mbFr0tFuVes8884k4sEq5AY10/KmUVFLY9GASJO7jgyKIyinB5Vgk
	 4zniK4LqOHZ0G6J8vVySYfCxtdpfa0058pA+BlREUrjs9+/pD3iO7w5H/zanD3D4sf
	 xdLrfNKv9vrtps6bughv26Tq3/HDB6AUzUcBmtA8fXI694874WepNXYGFnaXho1UiT
	 iwD3tDXQ3cREJYa/yhB7iasrOjogEG3O1E2r8yhXSGIRX1fbpb1W1EvrSLFTXQ12Cg
	 osFEgKVS3+wtw==
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
Subject: [PATCH v4] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to DT schema
Date: Tue, 27 Feb 2024 11:14:14 +1030
Message-Id: <20240227004414.841391-1-andrew@codeconstruct.com.au>
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
v4: Add constraints for gpio-line-names, ngpios as requested by Krzysztof:
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

 .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 149 ++++++++++++++++++
 .../devicetree/bindings/gpio/gpio-aspeed.txt  |  39 -----
 2 files changed, 149 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
new file mode 100644
index 000000000000..25f938b442e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
@@ -0,0 +1,149 @@
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
+  gpio-line-names: true
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
+  ngpios: true
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
+    #include <dt-bindings/clock/aspeed-clock.h>
+    gpio: gpio@1e780000 {
+        compatible = "aspeed,ast2500-gpio";
+        reg = <0x1e780000 0x200>;
+        clocks = <&syscon ASPEED_CLK_APB>;
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
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
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


