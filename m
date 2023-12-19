Return-Path: <linux-kernel+bounces-5235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94212818852
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E565287795
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4EF18E34;
	Tue, 19 Dec 2023 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="W2nsSUMY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931318C08;
	Tue, 19 Dec 2023 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 8720728B538;
	Tue, 19 Dec 2023 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1702990961;
	bh=4bK2V3kb7TBdDicl8Aw4xuY1tgwPNmoDdxc6Bayl400=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W2nsSUMYMnOWAI03305s0KhwOJDTIYVozOhij181oBgbV1KJWi6nvt3jyjb3rFkJq
	 rXzHGB+/azijD3ZUYcW6S8V7hXoRD4/6gtAy9aCmfOUnQGOGsyZwCL0w8pxvrF60cr
	 qVuK2az3RrlfmyYeGEcc9CsLY8L1KfhfxlxAFf2A=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: pressure: honeywell,mprls0025pa
Date: Tue, 19 Dec 2023 15:02:20 +0200
Message-ID: <20231219130230.32584-2-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231219130230.32584-1-petre.rodan@subdimension.ro>
References: <20231219130230.32584-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ChangeLog
 - add honeywell,pressure-triplet property that autoconfigures pmin, pmax
    just like the hsc030pa sensor driver
 - add support for spi-based sensors

Datasheet:
https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 .../iio/pressure/honeywell,mprls0025pa.yaml   | 60 ++++++++++++++++---
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
index d9e903fbfd99..7c4be2dec174 100644
--- a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
@@ -53,33 +53,59 @@ properties:
   honeywell,pmin-pascal:
     description:
       Minimum pressure value the sensor can measure in pascal.
+      To be specified only if honeywell,pressure-triplet is set to "NA".
 
   honeywell,pmax-pascal:
     description:
       Maximum pressure value the sensor can measure in pascal.
+      To be specified only if honeywell,pressure-triplet is set to "NA".
 
   honeywell,transfer-function:
     description: |
-      Transfer function which defines the range of valid values delivered by the
-      sensor.
+      Transfer function which defines the range of valid values delivered by
+      the sensor.
       1 - A, 10% to 90% of 2^24 (1677722 .. 15099494)
       2 - B, 2.5% to 22.5% of 2^24 (419430 .. 3774874)
       3 - C, 20% to 80% of 2^24 (3355443 .. 13421773)
+    enum: [1, 2, 3]
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  honeywell,pressure-triplet:
+    description: |
+      Case-sensitive five character string that defines pressure range, unit
+      and type as part of the device nomenclature. In the unlikely case of a
+      custom chip, set to "NA" and provide pmin-pascal and pmax-pascal.
+    enum: [0001BA, 01.6BA, 02.5BA, 0060MG, 0100MG, 0160MG, 0250MG, 0400MG,
+           0600MG, 0001BG, 01.6BG, 02.5BG, 0100KA, 0160KA, 0250KA, 0006KG,
+           0010KG, 0016KG, 0025KG, 0040KG, 0060KG, 0100KG, 0160KG, 0250KG,
+           0015PA, 0025PA, 0030PA, 0001PG, 0005PG, 0015PG, 0030PG, 0300YG,
+           NA]
+    $ref: /schemas/types.yaml#/definitions/string
+
+  spi-max-frequency:
+    maximum: 800000
+
   vdd-supply:
     description: provide VDD power to the sensor.
 
 required:
   - compatible
   - reg
-  - honeywell,pmin-pascal
-  - honeywell,pmax-pascal
+  - honeywell,pressure-triplet
   - honeywell,transfer-function
-  - vdd-supply
 
 additionalProperties: false
 
+dependentSchemas:
+  honeywell,pmin-pascal:
+    properties:
+      honeywell,pressure-triplet:
+        const: NA
+  honeywell,pmax-pascal:
+    properties:
+      honeywell,pressure-triplet:
+        const: NA
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
@@ -93,10 +119,28 @@ examples:
             reg = <0x18>;
             reset-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
             interrupt-parent = <&gpio3>;
-            interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
-            honeywell,pmin-pascal = <0>;
-            honeywell,pmax-pascal = <172369>;
+            interrupts = <21 IRQ_TYPE_EDGE_RISING>;
+
+            honeywell,pressure-triplet = "0025PA";
             honeywell,transfer-function = <1>;
             vdd-supply = <&vcc_3v3>;
         };
     };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@0 {
+            compatible = "honeywell,mprls0025pa";
+            reg = <0>;
+            spi-max-frequency = <800000>;
+            reset-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <30 IRQ_TYPE_EDGE_RISING>;
+
+            honeywell,pressure-triplet = "0015PA";
+            honeywell,transfer-function = <1>;
+        };
+    };
+...
-- 
2.41.0


