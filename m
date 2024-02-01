Return-Path: <linux-kernel+bounces-48962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A218463D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1061F28B0A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2754644E;
	Thu,  1 Feb 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fNutw4m8"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D61E4AA;
	Thu,  1 Feb 2024 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827830; cv=none; b=PuhHv7E1+g+2N2qGDXWoqcd3TJjk/hu4n8m33JMW1gjnwqCZotrWuhbkI1J9qWeXw6F2pP91edkT24EucNhtL55Pof0uCuDhtcyoSUTr1gKzvuGhQkKW5/xpYwr6EakJP/gz/ZO3oXLKUviCwrBjpleRo0tgRs2VdMfoL4segew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827830; c=relaxed/simple;
	bh=kw6lbtwuXTyE12kjbln/pYyWsx4JGQLotoAUb5+Y44U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SBqrGAmUR1vb2WOjgSDuSckc7ktg9a+J3TY+PfkfktlML0/sTO8beIABIS1ddTTUmbkHONd1XRkroXdwKtFJyFKApMcxVuyAi4BB+WlvGwzu9pwEZITWcCHp2x0fzU/L1tT0/ps4J22xdmXBl+IP+cJHpaBQFm6JnR+/GiqH0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fNutw4m8; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411MoN5i122746;
	Thu, 1 Feb 2024 16:50:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706827823;
	bh=7bV9UFHFxuctv1bBwYfxErClt4nS+SELS/8SJDM4HcA=;
	h=From:To:CC:Subject:Date;
	b=fNutw4m84o66r21RLvfJRNknsFIpLgBaJBHPNxQXGgYWLL9vDRr2A6zZD0v69zR74
	 hnUdkxAasz71TPks7gbP3p0glc3jgQKPUwvNt1RxawRf1nClV479m/QIbKyV7iL9jq
	 mnflESIrxh1w4BFHeOmcpSuU/Fmi5mAe5/g0e/Ws=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411MoNpY094228
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 16:50:23 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 16:50:23 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 16:50:23 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411MoNUD109168;
	Thu, 1 Feb 2024 16:50:23 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v3 1/4] dt-bindings: spi: Convert spi-davinci.txt to YAML
Date: Thu, 1 Feb 2024 16:50:19 -0600
Message-ID: <20240201225022.144476-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Convert spi-davinci.txt to ti,dm6441-spi.yaml.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes for v3:
 - Add tags and rebase

Changes for v2:
 - Fix typo s/dm6446/dm6441

 .../devicetree/bindings/spi/spi-davinci.txt   | 100 ------------------
 .../bindings/spi/ti,dm6441-spi.yaml           |  76 +++++++++++++
 2 files changed, 76 insertions(+), 100 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-davinci.txt
 create mode 100644 Documentation/devicetree/bindings/spi/ti,dm6441-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
deleted file mode 100644
index f012888656eca..0000000000000
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ /dev/null
@@ -1,100 +0,0 @@
-Davinci SPI controller device bindings
-
-Links on DM:
-Keystone 2 - https://www.ti.com/lit/ug/sprugp2a/sprugp2a.pdf
-dm644x - https://www.ti.com/lit/ug/sprue32a/sprue32a.pdf
-OMAP-L138/da830 - http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf
-
-Required properties:
-- #address-cells: number of cells required to define a chip select
-	address on the SPI bus. Should be set to 1.
-- #size-cells: should be zero.
-- compatible:
-	- "ti,dm6441-spi" for SPI used similar to that on DM644x SoC family
-	- "ti,da830-spi" for SPI used similar to that on DA8xx SoC family
-	- "ti,keystone-spi" for SPI used similar to that on Keystone2 SoC
-		family
-- reg: Offset and length of SPI controller register space
-- num-cs: Number of chip selects. This includes internal as well as
-	GPIO chip selects.
-- ti,davinci-spi-intr-line: interrupt line used to connect the SPI
-	IP to the interrupt controller within the SoC. Possible values
-	are 0 and 1. Manual says one of the two possible interrupt
-	lines can be tied to the interrupt controller. Set this
-	based on a specific SoC configuration.
-- interrupts: interrupt number mapped to CPU.
-- clocks: spi clk phandle
-          For 66AK2G this property should be set per binding,
-          Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
-
-SoC-specific Required Properties:
-
-The following are mandatory properties for Keystone 2 66AK2G SoCs only:
-
-- power-domains:	Should contain a phandle to a PM domain provider node
-			and an args specifier containing the SPI device id
-			value. This property is as per the binding,
-
-Optional:
-- cs-gpios: gpio chip selects
-	For example to have 3 internal CS and 2 GPIO CS, user could define
-	cs-gpios = <0>, <0>, <0>, <&gpio1 30 0>, <&gpio1 31 0>;
-	where first three are internal CS and last two are GPIO CS.
-
-Optional properties for slave devices:
-SPI slave nodes can contain the following properties.
-Not all SPI Peripherals from Texas Instruments support this.
-Please check SPI peripheral documentation for a device before using these.
-
-- ti,spi-wdelay : delay between transmission of words
-	(SPIFMTn.WDELAY, SPIDAT1.WDEL) must be specified in number of SPI module
-	clock periods.
-
-	delay = WDELAY * SPI_module_clock_period + 2 * SPI_module_clock_period
-
-Below is timing diagram which shows functional meaning of
-"ti,spi-wdelay" parameter.
-
-             +-+ +-+ +-+ +-+ +-+                           +-+ +-+ +-+
-SPI_CLK      | | | | | | | | | |                           | | | | | |
-  +----------+ +-+ +-+ +-+ +-+ +---------------------------+ +-+ +-+ +-
-
-SPI_SOMI/SIMO+-----------------+                           +-----------
-  +----------+ word1           +---------------------------+word2
-             +-----------------+                           +-----------
-                                          WDELAY
-                                <-------------------------->
-
-Example of a NOR flash slave device (n25q032) connected to DaVinci
-SPI controller device over the SPI bus.
-
-spi0:spi@20bf0000 {
-	#address-cells			= <1>;
-	#size-cells			= <0>;
-	compatible			= "ti,dm6446-spi";
-	reg				= <0x20BF0000 0x1000>;
-	num-cs				= <4>;
-	ti,davinci-spi-intr-line	= <0>;
-	interrupts			= <338>;
-	clocks				= <&clkspi>;
-
-	flash: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "st,m25p32";
-		spi-max-frequency = <25000000>;
-		reg = <0>;
-		ti,spi-wdelay = <8>;
-
-		partition@0 {
-			label = "u-boot-spl";
-			reg = <0x0 0x80000>;
-			read-only;
-		};
-
-		partition@1 {
-			label = "test";
-			reg = <0x80000 0x380000>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/spi/ti,dm6441-spi.yaml b/Documentation/devicetree/bindings/spi/ti,dm6441-spi.yaml
new file mode 100644
index 0000000000000..a71e51fb87e4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/ti,dm6441-spi.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/ti,dm6441-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Davinci SPI Controller
+
+description:
+  SPI controllers on TI Davinci, OMAP-L138, and Keystone2 SoCs.
+
+maintainers:
+  - Andrew Davis <afd@ti.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ti,dm6441-spi # for SPI used on DM644x SoC family
+          - ti,da830-spi # for SPI used on DA8xx SoC family
+          - ti,keystone-spi # for SPI used on Keystone2 SoC family
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  ti,davinci-spi-intr-line:
+    description:
+      Interrupt line used to connect the SPI IP to the interrupt controller
+        within the SoC. Possible values are 0 and 1. Manual says one of the
+        two possible interrupt lines can be tied to the interrupt controller.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@20bf0000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "ti,dm6441-spi";
+        reg = <0x20bf0000 0x1000>;
+        interrupts = <338>;
+        clocks = <&clkspi>;
+
+        num-cs = <4>;
+        ti,davinci-spi-intr-line = <0>;
+
+        flash@0 {
+            compatible = "st,m25p32";
+            spi-max-frequency = <50000000>;
+            reg = <0>;
+            ti,spi-wdelay = <8>;
+        };
+    };
-- 
2.39.2


