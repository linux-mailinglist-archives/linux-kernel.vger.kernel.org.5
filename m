Return-Path: <linux-kernel+bounces-101298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF99487A538
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 303ECB21D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05100374E0;
	Wed, 13 Mar 2024 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BMKrkpaz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5F2D629;
	Wed, 13 Mar 2024 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323407; cv=none; b=uIJnyWAPzgbVc8bjZftI1dS0corFSDajXPPDwLhc9/F156hHEZ38o4uz8QxbqPWeghcIVBfA6neoG0gX/itMdU1mnD/Zkm/x+11gABtLms4vFLFjcMnZQJjsMQf9hmYQCWTAjJJuHCMj8BlGL7xyX3WPOQkOTk+V2sqDoOmmLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323407; c=relaxed/simple;
	bh=UnkbfDbxRFGPMxa1b1dJ/LjAmYTx0rdy3cfMOQOSdA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltQyxWyJ73tHUcKTGduwknJlGNahdBqHB0z/PV0Zun6PZ6ry3A1nrY9MavdSpWH3FAIH9yFiSHinJYbAeUjd036QLzP1Pg9KJlNZ48Q0PhrcmwjtEOr27VLxK+qOFRtGatt8EHf7R+JX/8UJTcUvkvWQQkjSrBgnWF5UxRsxvrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BMKrkpaz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710323398;
	bh=UnkbfDbxRFGPMxa1b1dJ/LjAmYTx0rdy3cfMOQOSdA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMKrkpaz2z9ZPMwKXkkdynhUikxGZ2E2aIzJMWv8U/4XjGhHxH1QMEVVanSU+h37R
	 eb2NxXBb5C7ueEgNjSXoBhILM+snHLBWidDvEaJJLXjrYUhwniIKFP3qnVq3GXnRAZ
	 NfvZOHILJrzytM+7CSZwICp0t5exYlIsrHVk/ECZzHJSsqMAPTent+y8dkHuHKJGiH
	 EC7Tjts9ID5II0WO8EReJ7T249RDMez9u+4RieOsXABqaYNQKiGkfempJKsX49VcZZ
	 JpmZkIhC2K83pbvdVkql7AYaDcN0uirM5O5w3vbH5yZF1MPs9617iEwgwLiTOd8I+R
	 5mwwfDfUFT8sA==
Received: from stla-brain-8255-1.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9489837820C6;
	Wed, 13 Mar 2024 09:49:57 +0000 (UTC)
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
Subject: [PATCH v5 2/4] dt-bindings: media: add Maxim MAX96714 GMSL2 Deserializer
Date: Wed, 13 Mar 2024 10:49:20 +0100
Message-ID: <20240313094922.311743-3-julien.massot@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313094922.311743-1-julien.massot@collabora.com>
References: <20240313094922.311743-1-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings for Maxim MAX96714 GMSL2 Deserializer.

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
Change since v4:
 - Add compatible for MAX96714 and use it as a fallback for MAX96714F
 - Remove extra '|' for decriptions
 - Reference 'i2c-gate' instead of 'i2c-controller'

Change since v3:
 - Renamed file to maxim,max96714.yaml dropped the 'f' suffix
 - Removed mention to C-PHY since it's not supported by MAX96714 deserializers
 - Removed bus-type requirement on CSI endpoint since the device only support D-PHY
 - Removed the clock-lanes property in the dt example

Change since v2:
 - remove reg description
 - rename enable gpio to powerdown
 - use generic node name: i2c, serializer, deserializer
---
 .../bindings/media/i2c/maxim,max96714.yaml    | 176 ++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
new file mode 100644
index 000000000000..59b116092834
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
@@ -0,0 +1,176 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024 Collabora Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/maxim,max96714.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX96714 GMSL2 to CSI-2 Deserializer
+
+maintainers:
+  - Julien Massot <julien.massot@collabora.com>
+
+description:
+  The MAX96714 deserializer converts GMSL2 serial inputs into MIPI
+  CSI-2 D-PHY formatted output. The device allows the GMSL2 link to
+  simultaneously transmit bidirectional control-channel data while forward
+  video transmissions are in progress. The MAX96714 can connect to one
+  remotely located serializer using industry-standard coax or STP
+  interconnects. The device cans operate in pixel or tunnel mode. In pixel mode
+  the MAX96714 can select individual video stream, while the tunnel mode forward all
+  the MIPI data received by the serializer.
+
+  The GMSL2 serial link operates at a fixed rate of 3Gbps or 6Gbps in the
+  forward direction and 187.5Mbps in the reverse direction.
+  MAX96714F only supports a fixed rate of 3Gbps in the forward direction.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - maxim,max96714
+      - items:
+          - enum:
+              - maxim,max96714f
+          - const: maxim,max96714 # fallback for 'f' variant
+
+  reg:
+    maxItems: 1
+
+  powerdown-gpios:
+    maxItems: 1
+    description:
+      Specifier for the GPIO connected to the PWDNB pin.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        unevaluatedProperties: false
+        description: GMSL Input
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+            description:
+              Endpoint for GMSL2-Link port.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI-2 Output port
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
+              link-frequencies:
+                maxItems: 1
+
+            required:
+              - data-lanes
+
+    required:
+      - port@1
+
+  i2c-gate:
+    $ref: /schemas/i2c/i2c-gate.yaml
+    unevaluatedProperties: false
+    description:
+      The MAX96714 will pass through and forward the I2C requests from the
+      incoming I2C bus over the GMSL2 link. Therefore it supports an i2c-gate
+      subnode to configure a serializer.
+
+  port0-poc-supply:
+    description: Regulator providing Power over Coax for the GMSL port
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
+
+        deserializer@28 {
+            compatible = "maxim,max96714f", "maxim,max96714";
+            reg = <0x28>;
+            powerdown-gpios = <&main_gpio0 37 GPIO_ACTIVE_LOW>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    reg = <0>;
+                    max96714_gmsl_in: endpoint {
+                        remote-endpoint = <&max96917f_gmsl_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    max96714_csi_out: endpoint {
+                        data-lanes = <1 2 3 4>;
+                        link-frequencies = /bits/ 64 <400000000>;
+                        remote-endpoint = <&csi_in>;
+                    };
+                };
+            };
+
+            i2c-gate {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                serializer@40 {
+                    compatible = "maxim,max96717f", "maxim,max96717";
+                    reg = <0x40>;
+                    gpio-controller;
+                    #gpio-cells = <2>;
+                    #clock-cells = <0>;
+
+                    ports {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+
+                        port@0 {
+                            reg = <0>;
+                            max96717f_csi_in: endpoint {
+                                bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
+                                data-lanes = <1 2>;
+                                lane-polarities = <1 0 1>;
+                                remote-endpoint = <&sensor_out>;
+                            };
+                        };
+
+                        port@1 {
+                            reg = <1>;
+                            max96917f_gmsl_out: endpoint {
+                                remote-endpoint = <&max96714_gmsl_in>;
+                            };
+                        };
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.44.0


