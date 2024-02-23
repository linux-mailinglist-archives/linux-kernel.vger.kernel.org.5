Return-Path: <linux-kernel+bounces-78715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E2B8617BA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B53281DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B8C126F0E;
	Fri, 23 Feb 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5YuVDCL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29B12CD90;
	Fri, 23 Feb 2024 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705302; cv=none; b=GxXKLPe5OnkVr4tR/Q2KUuU617tO7PQ2SJtmvV/ebdibTPpm+YMhXExnHcy0CSK5/FPkJlzFDsITsPlgrhZBC8et6ei8t+GcJg+sqhATWaDDG056Txfw+CHtAhVfOugyX7ulKV/8yYN1lgHOhDdPkmuUZG/Kdk8dWv25CQHFIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705302; c=relaxed/simple;
	bh=0X7Yo77IwoX+OlGIjRRgP1KpwS96thIJDoZvlw0AoCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFOSls9jx7TTXZGcOAmacDPq4QC3rFRqTHr0xc4a5LKivSzD4yIbOt0yHJKGsF2sWGtXxLmurWRttOmWRwaEnhMTXPrY2B0wYUZxEiQaElptcXvdgjZgwbd3XkvUBd5covaYxX5N1r/KzdSdYhhoo3147aEVvPNXIm030o71x5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5YuVDCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFBAC43390;
	Fri, 23 Feb 2024 16:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708705302;
	bh=0X7Yo77IwoX+OlGIjRRgP1KpwS96thIJDoZvlw0AoCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5YuVDCLN/T/KWUpCn5FpVgVR14S+/1nnajs9jAVZ9CUpLRBrXklv+SLFZFH4cX1r
	 ACYjSrcyLQm3V2GPbiaKC9uW3y47pStQS5ssywWEVZqoXiUIsyW8jWRuE51E0M0Izf
	 SrsemgXcHSokFakkV6kG4a9GiQ+VexBsuCCq4Ehx4swq+POZ2jNWb5Q5TtbR0Fh4d7
	 egmLQkNjCUcOPIYjVTfzXpTwNctKfwLQeFeLKPeRdhEjS8XusR+093QMUXAzLF79ml
	 8Isxt9eYebwzizrwHrQjpQPSPrSrpOSvCTKNtwjTUx/oO/gta/2XJ5lCXCJ/5YJhSj
	 HjUWNhcLR6feQ==
From: Conor Dooley <conor@kernel.org>
To: linux@roeck-us.net
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Zev Weiss <zev@bewilderbeest.net>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] regulator: dt-bindings: promote infineon buck converters to their own binding
Date: Fri, 23 Feb 2024 16:21:06 +0000
Message-ID: <20240223-blabber-obnoxious-353e519541a6@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
References: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2647; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=u1pFfi4y8oia/3MILbtpYBE5pLdSu5ZPbthI3AYMSvI=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKk3jv5YdUj93sezWrMyVONvtd/51rnmYaPx0o25tQ1xm W7Cwe6cHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIgwJGhtkaCfmGmwJ5zDad nvdj0tIDS1W23j/1OnPr9m/JL+dFbzRk+J9yY7/blLcGCfcc3v08ervovfCsuo4Hx0sEGsXE5ib +9GUEAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

These devices are regulators may need to make use of the common
regulator properties, but these are not permitted while only documented
in trivial-devices.yaml

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/regulator/infineon,ir38060.yaml  | 46 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  8 ----
 2 files changed, 46 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml

diff --git a/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml b/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
new file mode 100644
index 000000000000..bb0114f7e13f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/infineon,ir38060.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Infineon Buck Regulators with PMBUS interfaces
+
+maintainers:
+  - Not Me.
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - infineon,ir38060
+      - infineon,ir38064
+      - infineon,ir38164
+      - infineon,ir38263
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      regulator@34 {
+        compatible = "infineon,ir38060";
+        reg = <0x34>;
+
+        regulator-min-microvolt = <437500>;
+        regulator-max-microvolt = <1387500>;
+      };
+    };
+
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 9cdd5a534120..e07be7bf8395 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -130,14 +130,6 @@ properties:
           - infineon,dps310
             # Infineon IR36021 digital POL buck controller
           - infineon,ir36021
-            # Infineon IR38060 Voltage Regulator
-          - infineon,ir38060
-            # Infineon IR38064 Voltage Regulator
-          - infineon,ir38064
-            # Infineon IR38164 Voltage Regulator
-          - infineon,ir38164
-            # Infineon IR38263 Voltage Regulator
-          - infineon,ir38263
             # Infineon IRPS5401 Voltage Regulator (PMIC)
           - infineon,irps5401
             # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
-- 
2.43.0


