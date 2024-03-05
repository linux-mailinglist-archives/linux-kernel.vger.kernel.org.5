Return-Path: <linux-kernel+bounces-92600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835178722B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0DC7B241DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC53127B64;
	Tue,  5 Mar 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dxiKXjqJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66905126F14;
	Tue,  5 Mar 2024 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652402; cv=none; b=RMYtEo1d/nJcBoj8dH8hZHVvlurVWpeVtw9hrUy0oXYyGiJ1kyPWKy/dxbF8xar4dG80ce0bCoTuNEoqkB0UQJ2Q5HTffMq5XF9J5W2pWfIy5QGiHisMbAIIm7/VdKEDUgdeKb0Ra9GPFt3Yvk4kQiw/Rwqui6XPYaOrEkIcuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652402; c=relaxed/simple;
	bh=KN/IHXFSFNrV18K9w+Pxn5YG+gSGNUW++jQMPlXW7Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1bZUJBMqFbVIBwcwwTYvahmKYAcy8/66KKANIP+vLFJV8KpfmK2GkQNv4bmbsv9htiOJNz1TQUxpK0by/aqLsTIV2VbfhePD/XjcV5sQ+s8+0voyTtBPoc0XvWvl2cbEV7EBzzReRSY9CZBHymzAllIXC5ruTJ8e2N390W7YRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dxiKXjqJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709652398;
	bh=KN/IHXFSFNrV18K9w+Pxn5YG+gSGNUW++jQMPlXW7Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxiKXjqJ6hf7sCK9KO0hFOULul54IJPHY3/ii3agYPUSmqEju/14N5fA2Q3aLPKYb
	 QNYd8ADu4CCOZmolnQ3JFAZWlPZDXNHBr070Wz/Ilo0yzjF7RrVo56Qf2Zaoza3uxR
	 VLIbs9tcuMcKdDuIxkEMikJqum1BoForfnYRH2uKVnEI9x025qnqbIjlh7FKKPOJ4x
	 Bi7Ga9JOGiSvEtx3v0mys1//yxPyRWtNtmnqXZk0xPZGN/jGzGgDnCBiUTZO91VXvr
	 4tbwT+YZ7loV1AMDcXIBnQo4gQbUMnXDZnliHj2jtZkDPzeMP+17WTCQ4mAwOBe+M8
	 opBLVTjqtll8g==
Received: from stla-brain-8255-1.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EB6B2378149B;
	Tue,  5 Mar 2024 15:26:37 +0000 (UTC)
From: Julien Massot <julien.massot@collabora.com>
To: linux-media@vger.kernel.org
Cc: kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	sakari.ailus@iki.fi,
	Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v4 1/4] dt-bindings: media: add Maxim MAX96717 GMSL2 Serializer
Date: Tue,  5 Mar 2024 16:26:05 +0100
Message-ID: <20240305152608.287527-2-julien.massot@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305152608.287527-1-julien.massot@collabora.com>
References: <20240305152608.287527-1-julien.massot@collabora.com>
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
Change since v3:
 - Renamed file to maxim,max96717.yaml dropped the 'f' suffix
 - Added lane-polarities and bus type properties to the CSI endpoint

Change since v2:
 - remove reg description
 - add data lanes min/maxItems
 - Use generic node name 
---
 .../bindings/media/i2c/maxim,max96717.yaml    | 158 ++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
new file mode 100644
index 000000000000..83f4f1068709
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
@@ -0,0 +1,158 @@
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
+description: |
+  The MAX96717F serializer converts MIPI CSI-2 D-PHY or C-PHY formatted input
+  into GMSL2 serial outputs. The device allows the GMSL2 link to
+  simultaneously transmit bidirectional control-channel data while forward
+  video transmissions are in progress. The MAX96717F can connect to one
+  remotely located deserializer using industry-standard coax or STP
+  interconnects. The device cans operate in pixel or tunnel mode. In pixel mode
+  the MAX96717F can select the MIPI datatype, while the tunnel mode forward all the MIPI
+  data received by the serializer.
+  The MAX96717F supports Reference Over Reverse (channel),
+  to generate a clock output for the sensor from the GMSL reverse channel.
+
+  The GMSL2 serial link operates at a fixed rate of 3Gbps in the
+  forward direction and 187.5Mbps in the reverse direction.
+
+properties:
+  compatible:
+    const: maxim,max96717f
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
+    $ref: /schemas/i2c/i2c-controller.yaml
+    unevaluatedProperties: false
+    description:
+      The MAX96717F will forward the I2C requests from the
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


