Return-Path: <linux-kernel+bounces-165607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9BC8B8E86
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1D41C20C5A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CD313ADA;
	Wed,  1 May 2024 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RczkqTMa"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B2C748D;
	Wed,  1 May 2024 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582337; cv=none; b=u8AhVpCmTCJxsiCHKuFmwdYBLj9ursNzup4eautgaKhuYbPYsGVtbS2OKZ9sgI+0CzcccBYGsOo79eEA4WCLEeeBCE9kUUwCw/aWxRiD4cmZoHaZNbrN70MMhOjoP5zIaC5/RjMTtTxr+ujMgfHqqw4MlrLp/+AwCghztX252+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582337; c=relaxed/simple;
	bh=EoTNNFNmdiSJ+ihhxP7N6TMOpU57rtyD9Vd0HKERdZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhNY4eEbQVbaoSg8UQz+4xSTN+EQWimq6m3HWrbhKTqY3Am3VMnLf33N3ZxjdWtBgovKt5pNI840QsohxlKYALHc/Ca+M5xq8Dx3iWP7Gsdr/hd+v0md8A33QxwFIrSofqnnsy/oIfcSiXluf3nVCg4EVpnN6Zu1Em0lhsRStAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RczkqTMa; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f4178aec15so1482108b3a.0;
        Wed, 01 May 2024 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714582335; x=1715187135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+kLWLzH38TvjMAPOyIaIJoNEWichEBjYFHCLTsZASU=;
        b=RczkqTMaw6+/lEwp6+gdvvuF2HLS/W3drvRC5yl/IOfMjpu6eUDEp8yjiFZPpx8Bpu
         nF51wDsuxb366T3x0NlSjJ2bJLqzJYziOKKlGbYrK6bKpjrfsDkc6CxYacqlJjfYeT9V
         tA0Yl7u3o3jXu4zWFG5Seakoz6tVL4+J+huFgef1W0zpOvuTASlXutLaN+ftLHznmABb
         g3VbYpGrvvWbUCALMP9NPfi6BSmEPAaST6DxjtZjvJw+YJb3NceQhOFLp6aRrbxg8xbG
         PXdFN8qC3ebO9pJq/PZGSxLKdbO9I5oIMV1iAcjlPkNF6JJQjawXrL5hDzHRRXsbjwzm
         un8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582335; x=1715187135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+kLWLzH38TvjMAPOyIaIJoNEWichEBjYFHCLTsZASU=;
        b=vaCaQMAd5MfDhRyqTrIAE0iwbiI8/+Bh6V374G/Tn4vr5It4JFc6qpKX/9i66VZEu1
         cLal8DVArxpFJy3vtKo5o9XXOGe87OZmpCRyogz2ECv+5p3Dr/lnKlUwT6ND6muhY5Fo
         2iQ6cr9QzbxTJWv7PcmhsOwF0yogiE6sIM7GmCYJVvsutt/mfpXNJQ1rtrqKWJoQsgyZ
         n3qkG+3d4dLYybP8D9lbsuS6E1kJzj3O12lPFRUgtCIeyvKL8nuyhzRdwEK1xoQjWOc5
         eisFHVf3/pgyvAOd4bBCDUiqKxfYYB+safb/C1Eg8itQB2KWHmBd7GQ08cBp4ULjBseI
         GNZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgsL1yDcfrnaMqQ+zEwulSzYZTRJ2BHrjwCLRwK5IvoQHtSiHpJ+ms/fvmzGQ0WZh+pFZGygmaXTF1i2xn6HXlsky/mqRw3mruC19RCcYVtPL68qjFBl4Js9FvbZA+/7ls1COH5krUpw==
X-Gm-Message-State: AOJu0YxA/0xmkOFfmme9EydLuifOAXW0QyJwWNhS95zcUmpiyihYcBQd
	AK2J1s6zPQMPHlO3zC/m384NQNvF1K00Kmivc0xYnms6sIbjIfuI
X-Google-Smtp-Source: AGHT+IFoLPLaa10OmlKHdeMWUQfAXY6nicn0jqB5kR0cepCobySIMzdTUmrXKqUApZ+BDGQJOD7ZNA==
X-Received: by 2002:a05:6a21:339f:b0:1ad:7e4d:2ea6 with SMTP id yy31-20020a056a21339f00b001ad7e4d2ea6mr3618013pzb.20.1714582335399;
        Wed, 01 May 2024 09:52:15 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:31f8:c3a6:8218:5d12:51ef])
        by smtp.gmail.com with ESMTPSA id gd22-20020a056a00831600b006e6fc52ecd0sm22758866pfb.123.2024.05.01.09.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:52:14 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v3] spi: dt-bindings: ti,qspi: convert to dtschema
Date: Wed,  1 May 2024 22:18:53 +0530
Message-ID: <20240501165203.13763-1-five231003@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.8.ge326e52010
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert txt binding of TI's qspi controller (found on their omap SoCs) to
dtschema to allow for validation.

The changes, w.r.t. the original txt binding, are:

- Introduce "clocks" and "clock-names" which was never mentioned.
- Reflect that "ti,hwmods" is deprecated and is not a "required"
  property anymore.
- Introduce "num-cs" which allows for setting the number of chip
  selects.
- Drop "qspi_ctrlmod".

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
Changes since v1:
- Removed a redundant paragraph in the commit message.
- Mention that we are dropping "qspi_ctrlmod", which I forgot to do in
  the last iteration.

Changes since v2:
- Don't make "num-cs" an array.
- The max number of syscon-chipselects is now 1.
- Make the unit-address in the example right.
- Fix a typo in "syscon-chipselects"'s description.

 .../devicetree/bindings/spi/ti,qspi.yaml      | 96 +++++++++++++++++++
 .../devicetree/bindings/spi/ti_qspi.txt       | 53 ----------
 2 files changed, 96 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/ti,qspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/ti_qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/ti,qspi.yaml b/Documentation/devicetree/bindings/spi/ti,qspi.yaml
new file mode 100644
index 000000000000..626a915b3d77
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/ti,qspi.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/ti,qspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI QSPI controller
+
+maintainers:
+  - Kousik Sanagavarapu <five231003@gmail.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,am4372-qspi
+      - ti,dra7xxx-qspi
+
+  reg:
+    items:
+      - description: base registers
+      - description: mapped memory
+
+  reg-names:
+    items:
+      - const: qspi_base
+      - const: qspi_mmap
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: fck
+
+  interrupts:
+    maxItems: 1
+
+  num-cs:
+    minimum: 1
+    maximum: 4
+    default: 1
+
+  ti,hwmods:
+    description:
+      Name of the hwmod associated to the QSPI.  This is for legacy
+      platforms only.
+    $ref: /schemas/types.yaml#/definitions/string
+    deprecated: true
+
+  syscon-chipselects:
+    description:
+      Handle to system control region containing QSPI chipselect register
+      and offset of that register.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to system control register
+          - description: register offset
+
+  spi-max-frequency:
+    description: Maximum SPI clocking speed of the controller in Hz.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/dra7.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi@4b300000 {
+        compatible = "ti,dra7xxx-qspi";
+        reg = <0x4b300000 0x100>,
+              <0x5c000000 0x4000000>;
+        reg-names = "qspi_base", "qspi_mmap";
+        syscon-chipselects = <&scm_conf 0x558>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&l4per2_clkctrl DRA7_L4PER2_QSPI_CLKCTRL 25>;
+        clock-names = "fck";
+        num-cs = <4>;
+        spi-max-frequency = <48000000>;
+        interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
deleted file mode 100644
index 47b184bce414..000000000000
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-TI QSPI controller.
-
-Required properties:
-- compatible : should be "ti,dra7xxx-qspi" or "ti,am4372-qspi".
-- reg: Should contain QSPI registers location and length.
-- reg-names: Should contain the resource reg names.
-	- qspi_base: Qspi configuration register Address space
-	- qspi_mmap: Memory mapped Address space
-	- (optional) qspi_ctrlmod: Control module Address space
-- interrupts: should contain the qspi interrupt number.
-- #address-cells, #size-cells : Must be present if the device has sub-nodes
-- ti,hwmods: Name of the hwmod associated to the QSPI
-
-Recommended properties:
-- spi-max-frequency: Definition as per
-                     Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Optional properties:
-- syscon-chipselects: Handle to system control region contains QSPI
-		      chipselect register and offset of that register.
-
-NOTE: TI QSPI controller requires different pinmux and IODelay
-parameters for Mode-0 and Mode-3 operations, which needs to be set up by
-the bootloader (U-Boot). Default configuration only supports Mode-0
-operation. Hence, "spi-cpol" and "spi-cpha" DT properties cannot be
-specified in the slave nodes of TI QSPI controller without appropriate
-modification to bootloader.
-
-Example:
-
-For am4372:
-qspi: qspi@47900000 {
-	compatible = "ti,am4372-qspi";
-	reg = <0x47900000 0x100>, <0x30000000 0x4000000>;
-	reg-names = "qspi_base", "qspi_mmap";
-	#address-cells = <1>;
-	#size-cells = <0>;
-	spi-max-frequency = <25000000>;
-	ti,hwmods = "qspi";
-};
-
-For dra7xx:
-qspi: qspi@4b300000 {
-	compatible = "ti,dra7xxx-qspi";
-	reg = <0x4b300000 0x100>,
-	      <0x5c000000 0x4000000>,
-	reg-names = "qspi_base", "qspi_mmap";
-	syscon-chipselects = <&scm_conf 0x558>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	spi-max-frequency = <48000000>;
-	ti,hwmods = "qspi";
-};
-- 
2.45.0.rc1.8.ge326e52010


