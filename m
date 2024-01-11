Return-Path: <linux-kernel+bounces-23615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DD682AF26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4161F2292A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84E3168D3;
	Thu, 11 Jan 2024 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sPLxaW9Q"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923F71642A;
	Thu, 11 Jan 2024 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704978265;
	bh=RegqtFPQFnNs3Snnh6OR3b5590EazmrO+nXmHlkd/KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPLxaW9Q0JpRotqDuYwfsVjh8nEM2KfSQ/AkbcEB5dZabhNveFqFCnc3k4thGiCv+
	 T8Kekf1BRVj7FdTma0EQDnPO2/3ZuA5BM2HkFtulDhwP668pMBJ2ZnpiaScixly6dh
	 ik8TMlbnvXue//0AqhRlgh+JVs1BU+6fN8f7Z3nblUp4TBzG/fp54mfmFPy7zKN+VE
	 RhizqH7fjUTnkfykGhv3B9ICFBvAKOeESJbx0p4MeLNYQza/iDlIqaCPCeWSR5rr8S
	 vUiin62C00tiTm8w/zk/7H5Fk9iYYAuPBztowqsq6ROnnKixvKVmEG4+EHs+og/jWD
	 OwsYecPv8xAOA==
Received: from stla-brain-8255-1.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 32AA23781FE5;
	Thu, 11 Jan 2024 13:04:25 +0000 (UTC)
From: Julien Massot <julien.massot@collabora.com>
To: linux-media@vger.kernel.org
Cc: kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v3 2/4] dt-bindings: media: add Maxim MAX96714F GMSL2 Deserializer
Date: Thu, 11 Jan 2024 14:03:47 +0100
Message-ID: <20240111130349.2776699-3-julien.massot@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111130349.2776699-1-julien.massot@collabora.com>
References: <20240111130349.2776699-1-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings for Maxim MAX96714F GMSL2 Deserializer.

Signed-off-by: Julien Massot <julien.massot@collabora.com>

---
Change since v2:
 - remove reg description
 - rename enable gpio to powerdown
 - use generic node name: i2c, serializer, deserializer
---
 .../bindings/media/i2c/maxim,max96714f.yaml   | 171 ++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96714f.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96714f.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96714f.yaml
new file mode 100644
index 000000000000..2423d166c954
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96714f.yaml
@@ -0,0 +1,171 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024 Collabora Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/maxim,max96714f.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX96714 GMSL2 to CSI-2 Deserializer
+
+maintainers:
+  - Julien Massot <julien.massot@collabora.com>
+
+description: |
+  The MAX96714F deserializer converts GMSL2 serial inputs into MIPI
+  CSI-2 D-PHY or C-PHY formatted output. The device allows the GMSL2 link to
+  simultaneously transmit bidirectional control-channel data while forward
+  video transmissions are in progress. The MAX96714F can connect to one
+  remotely located serializer using industry-standard coax or STP
+  interconnects. The device cans operate in pixel or tunnel mode. In pixel mode
+  the MAX96714F can select individual video stream, while the tunnel mode forward all
+  the MIPI data received by the serializer.
+
+  The GMSL2 serial link operates at a fixed rate of 3Gbps in the
+  forward direction and 187.5Mbps in the reverse direction.
+
+properties:
+  compatible:
+    const: maxim,max96714f
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
+              link-frequencies:
+                maxItems: 1
+
+              bus-type:
+                enum:
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
+            required:
+              - data-lanes
+              - bus-type
+
+    required:
+      - port@1
+
+  i2c-gate:
+    $ref: /schemas/i2c/i2c-controller.yaml
+    unevaluatedProperties: false
+    description: |
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
+                        bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
+                        clock-lanes = <0>;
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
2.43.0


