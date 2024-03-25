Return-Path: <linux-kernel+bounces-117120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8BA88A789
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF531C6037D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3371816F8FB;
	Mon, 25 Mar 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0RUMwNi8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0216F831;
	Mon, 25 Mar 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372673; cv=none; b=bSl6GSVO2s5UeS7tUPlEL/NeO5xFKCEpMUg1HwUl1LlA3HyUKiTvhNjmp4xA8FXCQ4pWNY/rSHAeQmjPRm3tBvS73/jIuiV5+0KBS4lAEl2rjqDdURTj8wfegsw4UJrIkN208J0daQHMjsfcnx91qoDpq4gb5f8WkGwunKcmeFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372673; c=relaxed/simple;
	bh=5iWGjHxt8ZWFZhQnPk2ARczEXPRNBEdu+RGl4jbmpo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCJrMTNOSmXecfbTdFjN8wVFzSnRyyJLj4wDcVp4QzwRlcLt69L37Jr7aSja43kcCzcJ3/PoQyCyyG6K7DP1IsUv8oBvmucNT3og9LhKiVwYsiQqg1bJyPdYEj7YE4s0uKL8C6xEhexJn2llqxtwrIebJQfOZYVsuFNEx6WMKtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0RUMwNi8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711372669;
	bh=5iWGjHxt8ZWFZhQnPk2ARczEXPRNBEdu+RGl4jbmpo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0RUMwNi8/BvQNGbk71yOcZ/nVKGyVFTlwGJQBoKkXlHIVktKsQeuH+/xG7kwA4naC
	 ba+9qKQ5dgnBw512mluBNTSQquTgeVz+Bo6ZoL9f2nwn2PaPyFQNsYOxyKp6c8n2uJ
	 +V6/Qub+NYRCnR+v7Qx1DnhLiSsYTZ11aTOfjlgXBiJr9eKCKkmUid6qABpm+m21m9
	 m1UvXn2KbyelBGS84GXFPHBatCSB+z/iGgFQeiRekevZqx4v5+LuMWaLluy19qjvkD
	 aDO20MABFOuNy/23xKwXyuykku0n+inXTK8Gt2rTWqHsRSoCVGZUd40VORYCI0lnNG
	 bIaL/e4VwHzlQ==
Received: from stla-brain-8255-1.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3D059378209E;
	Mon, 25 Mar 2024 13:17:49 +0000 (UTC)
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
Subject: [PATCH v6 2/4] dt-bindings: media: add Maxim MAX96714 GMSL2 Deserializer
Date: Mon, 25 Mar 2024 14:16:32 +0100
Message-ID: <20240325131634.165361-3-julien.massot@collabora.com>
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

Add DT bindings for Maxim MAX96714 GMSL2 Deserializer.

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
Change since v5:
 - Reverse the fallback MAX96714 can fallback to MAX96714F
 - Use const instead of enum for MAX96714F compatible

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
 .../bindings/media/i2c/maxim,max96714.yaml    | 175 ++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
new file mode 100644
index 000000000000..fdcba14fcde9
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
@@ -0,0 +1,175 @@
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
+      - const: maxim,max96714f
+      - items:
+          - enum:
+              - maxim,max96714
+          - const: maxim,max96714f
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
+            compatible = "maxim,max96714f";
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
+                    compatible = "maxim,max96717f";
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


