Return-Path: <linux-kernel+bounces-80455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA66866894
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073001C215AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DA81401B;
	Mon, 26 Feb 2024 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="lO5wNnL/"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3490C11737;
	Mon, 26 Feb 2024 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917626; cv=none; b=tiLKols6PNHfTUT5S+iCSOVapra+NqGh/S9x0m5BWbq21ftcaaT9aqHWdofP/UgJ6H4Jl4rx+cEP+T+rEOpkiRGCOz2Co43vjZBlqFJzutb1MoMpU/hF+TCn7JCIeB69GjPkIlXbIOeG9MgB6zWcCoYYOEHiqKrasBtuUTjKflI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917626; c=relaxed/simple;
	bh=qNyxXNVKh3rYR+lfM0KuOhVs8XEV+DHoZej5cgSnoF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A7oaPVJoDeaHt3kBtHDBbgP69Nxphf0fnxrhCFXsYX+g9v6NP11Ro3UWOxrpSa0sXofyrOOXVoJlfFJFUWG+8OG3zmJQiFTKKTAVjmCRyNdEEnBAF+wfYpQmM6oRWk1DgE9Ly2JZNUBRhFysmJq56v+f7S9CU8hW35TxBOw/nPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=lO5wNnL/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from localhost.localdomain (ppp118-210-168-240.adl-adc-lon-bras34.tpg.internode.on.net [118.210.168.240])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C384A2014E;
	Mon, 26 Feb 2024 11:20:10 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708917614;
	bh=LNLPAUiRFnZl/7VHr8STDz7uh32Y54i1QIk4cgSLlRM=;
	h=From:To:Cc:Subject:Date;
	b=lO5wNnL/oJkFpK7pr0cijMRFZxr4Dnou6xRPTIB7bjv+v5iAQtbt2mAZw7TkqZadJ
	 C9/nLWyAw8QBnFfpkAMkNrLQT+jKY1WvOJ4skySh4O/lCXze70qwc9kjkjjKag2Kce
	 Sjs1rvcK8IBcbmp3YZus2BD8ppszTSt0U6sIWZ2oXJNZtkU5BgXZ+XP/OUIkQtJyMh
	 FzsFfRaJiwd+ET6IT536vzo3BM7qUqP5ifDmp3G+Kj/Att/olv8rpwouOHvCaCos4D
	 R7Vm7DskK1PBOELGnpFUkEkog9MEG/Mr4udmfZf6q/U+dKf5++ifyrghgvsoWRY8LP
	 opkZEfKKS4gdA==
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
Subject: [PATCH v2] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to DT schema
Date: Mon, 26 Feb 2024 13:49:51 +1030
Message-Id: <20240226031951.284847-1-andrew@codeconstruct.com.au>
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
v2: Address feedback from Krzysztof:
    https://lore.kernel.org/all/0d1dd262-b6dd-4d71-9239-8b0aec8cceff@linaro.org/

v1: https://lore.kernel.org/all/20240220052918.742793-1-andrew@codeconstruct.com.au/

 .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 73 +++++++++++++++++++
 .../devicetree/bindings/gpio/gpio-aspeed.txt  | 39 ----------
 2 files changed, 73 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
new file mode 100644
index 000000000000..74d376567dfc
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
@@ -0,0 +1,73 @@
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
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+  gpio-line-names: true
+  gpio-ranges: true
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
+  - "#gpio-cells"
+  - gpio-controller
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2600-gpio
+    then:
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
+        #gpio-cells = <2>;
+        gpio-controller;
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
-- 
2.39.2


