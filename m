Return-Path: <linux-kernel+bounces-38982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2880183C953
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA1F1F221FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12EC1386AC;
	Thu, 25 Jan 2024 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V/ztUaxx"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7428B130E4F;
	Thu, 25 Jan 2024 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201917; cv=none; b=GgFc2juWnINsDkcw9Rlk+3iKwrhw6Ptu3eLOcIKVwxof682hhB6iacdNSXRbA1l9I+X4M28yoi9JyttS4HUlon7al2MY6V0MOefIaYGJ4bFJk7VpHkbuLHT7CCM2fHY9hQsYB40uO7xfayAkB5TpN2nBhp/Vwezy7osYKMKrR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201917; c=relaxed/simple;
	bh=34I2TzE6pPxcxeAktNAgVF69e5f8gw9GO2UUBSYi4I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdbXmD/+XkE6ggvdSW+It5T4STRVDGaxpeJURi5w81785fRLxMjtOzp/PYbIHuFy47q2Os6xkJWK5GcF1660f1zhkJkGLOOkXy5nHLS/G4IsJ9r1eDCNsekbtR/Qlyp9lD/mgRgJCxCcCHCAUbU2yz9VGYzHsXt84Ut3Ahz3Y7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V/ztUaxx; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76BEAC0002;
	Thu, 25 Jan 2024 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706201912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=foL/GX/UZVkyGwenKRmQ87OjZHOFjGP4EogO0kNEEEM=;
	b=V/ztUaxxhFKNxhXEOwWLqEk3km0/sTmRcqjsdRRKDcB6gaG9b0byGeZzGqAV8LGuBuvz7S
	Bd79wueVJQpZr1MkqvcaJz/QzWhcfbVne+qSp1IowQKQVpZ5EhrJqwgemqAazoWI5owHhA
	cW4M6NO0TY8INRIORWOnD3cXLZCgLcggco7A3pKOvhqMJ2HbzczHX20xTYclzDKfpoWlQM
	marxuUtvFnnNhOeF+r5KlXQh4hPDnkgTXsUC2VepBr1SGM0LTqOHXLVrxeKm90HjVMDsf7
	sK2b3SPac4O0vJ0HV51tKxFdMTYE6/B1cYr4X0BGDqBTvkOx8Cxf0hkd25uA6A==
From: Kamel Bouhara <kamel.bouhara@bootlin.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Jeff LaBundy <jeff@labundy.com>
Cc: catalin.popescu@leica-geosystems.com,
	mark.satterthwaite@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v6 2/3] dt-bindings: input: Add TouchNetix axiom touchscreen
Date: Thu, 25 Jan 2024 17:58:21 +0100
Message-ID: <20240125165823.996910-3-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125165823.996910-1-kamel.bouhara@bootlin.com>
References: <20240125165823.996910-1-kamel.bouhara@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kamel.bouhara@bootlin.com

Add the TouchNetix axiom I2C touchscreen device tree bindings
documentation.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
 .../input/touchscreen/touchnetix,ax54a.yaml   | 67 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
new file mode 100644
index 000000000000..7b3997457fa5
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/touchnetix,ax54a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TouchNetix Axiom series touchscreen controller
+
+maintainers:
+  - Kamel Bouhara <kamel.bouhara@bootlin.com>
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+  - $ref: /schemas/input/input.yaml#
+
+properties:
+  compatible:
+    const: touchnetix,ax54a
+
+  reg:
+    const: 0x66
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vdda-supply:
+    description: Analog power supply regulator on VDDA pin
+
+  vddi-supply:
+    description: I/O power supply regulator on VDDI pin
+
+  startup-time-ms:
+    description: delay after power supply regulator is applied in ms
+
+required:
+  - compatible
+  - reg
+  - vdda-supply
+  - vddi-supply
+  - startup-time-ms
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      touchscreen@66 {
+        compatible = "touchnetix,ax54a";
+        reg = <0x66>;
+        interrupt-parent = <&gpio2>;
+        interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+        vdda-supply = <&vdda_reg>;
+        vddi-supply = <&vddi_reg>;
+        poll-interval = <20>;
+        startup-time-ms = <100>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 7608b714653f..4752d8436dbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21431,6 +21431,12 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-firmware-attributes
 F:	drivers/platform/x86/think-lmi.?
 
+TOUCHNETIX AXIOM I2C TOUCHSCREEN DRIVER
+M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
+
 THUNDERBOLT DMA TRAFFIC TEST DRIVER
 M:	Isaac Hazan <isaac.hazan@intel.com>
 L:	linux-usb@vger.kernel.org
-- 
2.25.1


