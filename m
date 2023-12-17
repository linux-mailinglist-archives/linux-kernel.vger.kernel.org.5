Return-Path: <linux-kernel+bounces-2607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0670815F59
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF34B21B1F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC1E4436D;
	Sun, 17 Dec 2023 13:24:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de [80.67.31.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E12374CA;
	Sun, 17 Dec 2023 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apitzsch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apitzsch.eu
Received: from [92.206.191.209] (helo=note-book.lan)
	by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.1)
	(envelope-from <git@apitzsch.eu>)
	id 1rEr68-0008FK-1V;
	Sun, 17 Dec 2023 14:22:24 +0100
From: =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date: Sun, 17 Dec 2023 14:21:39 +0100
Subject: [PATCH] dt-bindings: regulator: Convert ti,tps65133 to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231217-tps65132-v1-1-73c69a960d28@apitzsch.eu>
X-B4-Tracking: v=1; b=H4sIAOL1fmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDI0Nz3ZKCYjNTQ2MjXfM0CyMjy5TkxBRTSyWg8oKi1LTMCrBR0bG1tQD
 mV7z8WgAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.4
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=

Convert TI TPS65132 bindings from .txt to .yaml format.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
Note, we still have to find a person willing to be listed as maintainer.
Suggestions are welcome.
---
 .../devicetree/bindings/regulator/ti,tps65132.yaml | 81 ++++++++++++++++++++++
 .../bindings/regulator/tps65132-regulator.txt      | 46 ------------
 2 files changed, 81 insertions(+), 46 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65132.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65132.yaml
new file mode 100644
index 000000000000..0add88dd0e80
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/ti,tps65132.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/ti,tps65132.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TPS65132 Dual Output Power Regulators
+
+description: |
+  The TPS65132 is designed to supply positive/negative driven applications.
+
+  Datasheet is available at:
+  https://www.ti.com/lit/gpn/tps65132
+
+properties:
+  compatible:
+    enum:
+      - ti,tps65132
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^out[pn]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for single regulator.
+
+    properties:
+      enable-gpios:
+        maxItems: 1
+        description:
+          GPIO specifier to enable the GPIO control (on/off) for regulator.
+
+      active-discharge-gpios:
+        maxItems: 1
+        description:
+          GPIO specifier to actively discharge the delay mechanism.
+
+      ti,active-discharge-time-us:
+        description: Regulator active discharge time in microseconds.
+
+    dependencies:
+      active-discharge-gpios: [ 'ti,active-discharge-time-us' ]
+
+required:
+  - compatible
+  - reg
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
+        regulator@3e {
+            compatible = "ti,tps65132";
+            reg = <0x3e>;
+
+            outp {
+                regulator-name = "outp";
+                regulator-boot-on;
+                regulator-always-on;
+                enable-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+            };
+
+            outn {
+                regulator-name = "outn";
+                regulator-boot-on;
+                regulator-always-on;
+                regulator-active-discharge = <0>;
+                enable-gpios = <&gpio 40 GPIO_ACTIVE_HIGH>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/regulator/tps65132-regulator.txt b/Documentation/devicetree/bindings/regulator/tps65132-regulator.txt
deleted file mode 100644
index 3a3505520c69..000000000000
--- a/Documentation/devicetree/bindings/regulator/tps65132-regulator.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-TPS65132 regulators
-
-Required properties:
-- compatible: "ti,tps65132"
-- reg: I2C slave address
-
-Optional Subnode:
-Device supports two regulators OUTP and OUTN. A sub node within the
-   device node describe the properties of these regulators. The sub-node
-   names must be as follows:
-	-For regulator outp, the sub node name should be "outp".
-	-For regulator outn, the sub node name should be "outn".
-
--enable-gpios:(active high, output) Regulators are controlled by the input pins.
-   If it is connected to GPIO through host system then provide the
-   gpio number as per gpio.txt.
--active-discharge-gpios: (active high, output) Some configurations use delay mechanisms
-  on the enable pin, to keep the regulator enabled for some time after
-  the enable signal goes low. This GPIO is used to actively discharge
-  the delay mechanism. Requires specification of ti,active-discharge-time-us
--ti,active-discharge-time-us: how long the active discharge gpio should be
-  asserted for during active discharge, in microseconds.
-
-Each regulator is defined using the standard binding for regulators.
-
-Example:
-
-	tps65132@3e {
-		compatible = "ti,tps65132";
-		reg = <0x3e>;
-
-		outp {
-			regulator-name = "outp";
-			regulator-boot-on;
-			regulator-always-on;
-			enable-gpios = <&gpio 23 0>;
-		};
-
-		outn {
-			regulator-name = "outn";
-			regulator-boot-on;
-			regulator-always-on;
-			regulator-active-discharge = <0>;
-			enable-gpios = <&gpio 40 0>;
-		};
-	};

---
base-commit: 17cb8a20bde66a520a2ca7aad1063e1ce7382240
change-id: 20231217-tps65132-7f8229dcad59

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>


