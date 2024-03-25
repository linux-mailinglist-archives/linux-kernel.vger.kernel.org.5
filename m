Return-Path: <linux-kernel+bounces-117119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9769488A794
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07680321A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B5616FF50;
	Mon, 25 Mar 2024 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p5VO5/S9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AFE16F82C;
	Mon, 25 Mar 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372672; cv=none; b=uEtC+Fgz9oKuKu6rXhbHRBxI7B1v+DKxDYqWPNwTO/7aaOa89/gkEMutT4/tYMR5Lm8NX5su+aHYyjKe3gUhvMztmxPZxkACoH/thg11za149ZjYc8Z7ZoOLzfqTOkxjYszL4GJeVaei/VuwIuK+kUQoZtcHJBwmJ3Xi+qQl/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372672; c=relaxed/simple;
	bh=tqhRn7aY4jXwTtjVre34DbkQtJfAQfE1eebK6HWRAjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ0kBRdr2XS/e2ZLGHgvd6W8vGYiG5xsLU5/JrUsT/5Qn6VAK0E7ZpIZ7diiUwhFuMTlsmf7yXoC0aHVRpP0ipRmTy5oo/dHR96FnEaGUvzER9PIiuFRhSc/vKm74wiyLj6G0ZuiZZGqnnzgtBC1SJ7/sqkGp2Vf2nc+XbaMpl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p5VO5/S9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711372669;
	bh=tqhRn7aY4jXwTtjVre34DbkQtJfAQfE1eebK6HWRAjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5VO5/S98kgWG4J+B9iaOIFpbiAho9gMeU7gRpOxAyvafKmbUGnSh0DAwV6gZT7sg
	 X6FdRSUwAJUGTjAPpD3t2eRyVFH4EoYmPwS/mvh+J2tHSQBUUqFj0h+kyOU9GN8HBk
	 epnjuUTrZ3cYn//5qnJV9oHRGKfjzkPpu7zeUOT6CktLmYomMLq5Wj93Iy5SiBaGOP
	 KlZsOaUoPywCCWA+gCEBXmxvAs9FsYd2bepNE/61MFPjXEHrbuqGMq5MEt+lyrzarD
	 olYZeEQQHklx3qRn1DPM/5t/pg3EpZ+GIrBzd6pH4BpkEqndM8opItkgcrNNKDPED6
	 0YyXqyP1s6DMw==
Received: from stla-brain-8255-1.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6460D3782039;
	Mon, 25 Mar 2024 13:17:48 +0000 (UTC)
From: Julien Massot <julien.massot@collabora.com>
To: linux-media@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	sakari.ailus@iki.fi,
	Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v6 1/4] dt-bindings: media: add Maxim MAX96717 GMSL2 Serializer
Date: Mon, 25 Mar 2024 14:16:31 +0100
Message-ID: <20240325131634.165361-2-julien.massot@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325131634.165361-1-julien.massot@collabora.com>
References: <20240325131634.165361-1-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings for Maxim MAX96717 GMSL2 Serializer.

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
Change since v5:
 - Reverse the fallback MAX96717 can fallback to MAX96717F
 - Use const instead of enum for MAX96717F compatible
 
Change since v4:
 - Add compatible for MAX96717 and use it as a fallback for MAX96717F
 - Remove extra '|' for decriptions
 - Reference 'i2c-gate' instead of 'i2c-controller'

Change since v3:
 - Renamed file to maxim,max96717.yaml dropped the 'f' suffix
 - Added lane-polarities and bus type properties to the CSI endpoint

Change since v2:
 - remove reg description
 - add data lanes min/maxItems
 - Use generic node name 
---
 .../bindings/media/i2c/maxim,max96717.yaml    | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
new file mode 100644
index 000000000000..ac8bf11a6fa5
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024 Collabora Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/maxim,max96717.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX96717 CSI-2 to GMSL2 Serializer
+
+maintainers:
+  - Julien Massot <julien.massot@collabora.com>
+
+description:
+  The MAX96717 serializer converts MIPI CSI-2 D-PHY or C-PHY formatted input
+  into GMSL2 serial outputs. The device allows the GMSL2 link to
+  simultaneously transmit bidirectional control-channel data while forward
+  video transmissions are in progress. The MAX96717 can connect to one
+  remotely located deserializer using industry-standard coax or STP
+  interconnects. The device cans operate in pixel or tunnel mode. In pixel mode
+  the MAX96717 can select the MIPI datatype, while the tunnel mode forward all the MIPI
+  data received by the serializer.
+  The MAX96717 supports Reference Over Reverse (channel),
+  to generate a clock output for the sensor from the GMSL reverse channel.
+
+  The GMSL2 serial link operates at a fixed rate of 3Gbps or 6Gbps in the
+  forward direction and 187.5Mbps in the reverse direction.
+  MAX96717F only supports a fixed rate of 3Gbps in the forward direction.
+
+properties:
+  compatible:
+    oneOf:
+      - const: maxim,max96717f
+      - items:
+          - enum:
+              - maxim,max96717
+          - const: maxim,max96717f
+
+  '#gpio-cells':
+    const: 2
+    description:
+      First cell is the GPIO pin number, second cell is the flags. The GPIO pin
+      number must be in range of [0, 10].
+
+  gpio-controller: true
+
+  '#clock-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI-2 Input port
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+              lane-polarities:
+                minItems: 1
+                maxItems: 5
+
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
+            required:
+              - data-lanes
+              - bus-type
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        unevaluatedProperties: false
+        description: GMSL Output port
+
+    required:
+      - port@1
+
+  i2c-gate:
+    $ref: /schemas/i2c/i2c-gate.yaml
+    unevaluatedProperties: false
+    description:
+      The MAX96717 will forward the I2C requests from the
+      incoming GMSL2 link. Therefore, it supports an i2c-gate
+      subnode to configure a sensor.
+
+required:
+  - compatible
+  - reg
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/media/video-interfaces.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        serializer: serializer@40 {
+            compatible = "maxim,max96717f";
+            reg = <0x40>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            #clock-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    max96717f_csi_in: endpoint {
+                        bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
+                        data-lanes = <1 2 3 4>;
+                        remote-endpoint = <&sensor_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    max96917f_gmsl_out: endpoint {
+                        remote-endpoint = <&deser_gmsl_in>;
+                    };
+                };
+            };
+
+            i2c-gate {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                sensor@10 {
+                    compatible = "st,st-vgxy61";
+                    reg = <0x10>;
+                    reset-gpios = <&serializer 0 GPIO_ACTIVE_LOW>;
+                    clocks = <&serializer>;
+                    VCORE-supply = <&v1v2>;
+                    VDDIO-supply = <&v1v8>;
+                    VANA-supply = <&v2v8>;
+                    port {
+                        sensor_out: endpoint {
+                            data-lanes = <1 2 3 4>;
+                            remote-endpoint = <&max96717f_csi_in>;
+                        };
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.44.0


