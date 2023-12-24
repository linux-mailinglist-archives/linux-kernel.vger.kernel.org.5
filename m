Return-Path: <linux-kernel+bounces-10723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF8A81DAE9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0D1B21471
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C537EC8D2;
	Sun, 24 Dec 2023 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="BNJ0qFZP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBE623CD;
	Sun, 24 Dec 2023 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 3C69C28B539;
	Sun, 24 Dec 2023 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703428510;
	bh=CeojQm5YJLUA6vqpb0TQgDQe551dZqsj31EWZZIFRqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BNJ0qFZPipoL+gkre9Ih6basEQVqF+3PMwoktIVC/lQDcnGGDISLFMmD83y21jMyA
	 Y4hhVxFg5J2EAHHkFZ//6G3Yg5OpjN2nvcLllxP2PfA6cyiZSIGs0V5WWheMsu4y46
	 0QeqI314RkB+Du+FXh9FIGLIUvFFXFljdLFHcnWE=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 02/10] dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add pressure-triplet
Date: Sun, 24 Dec 2023 16:34:47 +0200
Message-ID: <20231224143500.10940-3-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231224143500.10940-1-petre.rodan@subdimension.ro>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change order of properties in order for the end user to de-prioritize
pmin-pascal and pmax-pascal which are superseded by pressure-triplet.

Add pressure-triplet property which automatically initializes
pmin-pascal and pmax-pascal inside the driver

Rework honeywell,pmXX-pascal requirements based on feedback from
Jonathan and Conor.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../iio/pressure/honeywell,mprls0025pa.yaml   | 64 ++++++++++++++-----
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
index 84ced4e5a7da..e4021306d187 100644
--- a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
@@ -19,14 +19,17 @@ description: |
   calls them "mpr series". All of them have the identical programming model and
   differ in the pressure range, unit and transfer function.

-  To support different models one need to specify the pressure range as well as
-  the transfer function. Pressure range needs to be converted from its unit to
+  To support different models one need to specify its pressure triplet as well
+  as the transfer function.
+
+  For custom models the pressure values can alternatively be specified manually.
+  The minimal range value stands for the minimum pressure and the maximum value
+  also for the maximum pressure with linear relation inside the range.
+  Pressure range needs to be converted from the datasheet specified unit to
   pascal.

   The transfer function defines the ranges of numerical values delivered by the
-  sensor. The minimal range value stands for the minimum pressure and the
-  maximum value also for the maximum pressure with linear relation inside the
-  range.
+  sensor.

   Specifications about the devices can be found at:
     https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/
@@ -54,14 +57,6 @@ properties:
       If not present the device is not reset during the probe.
     maxItems: 1

-  honeywell,pmin-pascal:
-    description:
-      Minimum pressure value the sensor can measure in pascal.
-
-  honeywell,pmax-pascal:
-    description:
-      Maximum pressure value the sensor can measure in pascal.
-
   honeywell,transfer-function:
     description: |
       Transfer function which defines the range of valid values delivered by the
@@ -72,17 +67,52 @@ properties:
     enum: [1, 2, 3]
     $ref: /schemas/types.yaml#/definitions/uint32

+  honeywell,pressure-triplet:
+    description: |
+      Case-sensitive five character string that defines pressure range, unit
+      and type as part of the device nomenclature. In the unlikely case of a
+      custom chip, unset and provide pmin-pascal and pmax-pascal instead.
+    enum: [0001BA, 01.6BA, 02.5BA, 0060MG, 0100MG, 0160MG, 0250MG, 0400MG,
+           0600MG, 0001BG, 01.6BG, 02.5BG, 0100KA, 0160KA, 0250KA, 0006KG,
+           0010KG, 0016KG, 0025KG, 0040KG, 0060KG, 0100KG, 0160KG, 0250KG,
+           0015PA, 0025PA, 0030PA, 0001PG, 0005PG, 0015PG, 0030PG, 0300YG]
+    $ref: /schemas/types.yaml#/definitions/string
+
+  honeywell,pmin-pascal:
+    description:
+      Minimum pressure value the sensor can measure in pascal.
+      To be specified only if honeywell,pressure-triplet is not set.
+
+  honeywell,pmax-pascal:
+    description:
+      Maximum pressure value the sensor can measure in pascal.
+      To be specified only if honeywell,pressure-triplet is not set.
+
   vdd-supply:
     description: provide VDD power to the sensor.

 required:
   - compatible
   - reg
-  - honeywell,pmin-pascal
-  - honeywell,pmax-pascal
   - honeywell,transfer-function
   - vdd-supply

+oneOf:
+  - required:
+      - honeywell,pmin-pascal
+      - honeywell,pmax-pascal
+  - required:
+      - honeywell,pressure-triplet
+
+allOf:
+  - if:
+      required:
+        - honeywell,pressure-triplet
+    then:
+      properties:
+        honeywell,pmin-pascal: false
+        honeywell,pmax-pascal: false
+
 additionalProperties: false

 examples:
@@ -99,8 +129,8 @@ examples:
             reset-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
             interrupt-parent = <&gpio3>;
             interrupts = <21 IRQ_TYPE_EDGE_RISING>;
-            honeywell,pmin-pascal = <0>;
-            honeywell,pmax-pascal = <172369>;
+
+            honeywell,pressure-triplet = "0025PA";
             honeywell,transfer-function = <1>;
             vdd-supply = <&vcc_3v3>;
         };
--
2.41.0


