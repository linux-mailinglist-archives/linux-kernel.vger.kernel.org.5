Return-Path: <linux-kernel+bounces-31051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A47883281E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76D5B22251
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B6D537ED;
	Fri, 19 Jan 2024 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4Shbc6VR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278A3D393;
	Fri, 19 Jan 2024 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661168; cv=none; b=V3s+E93iy7J978+BF+iil1zMgFsrRA3Rn8mm3wSXUGHA5ISQnXn0dbN82UnuIuovhTeVlZFa6xST6o8zqHaoayTuzOW1ZTgxPTz02LYlw21ry356vtsfhvI+JKVV2ZICLjf3eerBkyxTe9SVBB3k1iprjpvX72R8CotQBOpSn1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661168; c=relaxed/simple;
	bh=yMBnHD84devz8pBb0bWiL0F28mWeot+MVGjDOv5Z7as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQxG9/qKgIaMulevMROLzq/l78MIdXheqQqGQdJ8ugAca/GmDXb6V6Mn1tRvMFkc723MD2NvK4C2j4CO8uMWybwyxEX6wLtPZtiE+EBakTsRTlxIE52dLCPL1Jv3UMxGr2amxQTOJqMmirtwC3HOU1VjYOmhL0ZSN4Cb4MwWQPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4Shbc6VR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705661158;
	bh=yMBnHD84devz8pBb0bWiL0F28mWeot+MVGjDOv5Z7as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=4Shbc6VRqhEa23YWSU8byPvUmRnm4h/gsWjKVJhGi4eNs0oVeQXY19FIolPUAkJZS
	 D8hkRHxuIAD44Cblwc1NDspTmtaWc5wiABxeT4KHJQd7fCBmoietIgWiSRARDi2ZgO
	 yxSuCne0OPu0K93fPILgjxmmT+6D15aCmQIzNM9fAnmOrEyYIb0/AVw1+su1Kqc3IY
	 nnXnuRb5Xl1kMBDvy31HhqzdzfwcD3jBEXUsF1M9uKyNl/Rnmco32CeHZyUPZQHCx+
	 ClE/mvHn4RWZ7PP4ChBtaRvDDHpVwPKVA/2BhyocRzHwR2H5zWhOPBSyirf2Evm8c1
	 HjEDlonA0/tpw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7E00A378207E;
	Fri, 19 Jan 2024 10:45:57 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: gregkh@linuxfoundation.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heikki.krogerus@linux.intel.com,
	matthias.bgg@gmail.com,
	dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org,
	andersson@kernel.org,
	nathan@kernel.org,
	luca.weiss@fairphone.com,
	tianping.fang@mediatek.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] dt-bindings: usb: Introduce ITE IT5205 Alt. Mode Passive MUX
Date: Fri, 19 Jan 2024 11:45:49 +0100
Message-ID: <20240119104550.140061-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119104550.140061-1-angelogioacchino.delregno@collabora.com>
References: <20240119104550.140061-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a binding for the ITE IT5205 Alternate Mode Passive MUX,
used for connecting, disconnecting and switching orientation and
control the SBU signals for alternate modes on USB Type-C ports.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/usb/ite,it5205.yaml   | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ite,it5205.yaml

diff --git a/Documentation/devicetree/bindings/usb/ite,it5205.yaml b/Documentation/devicetree/bindings/usb/ite,it5205.yaml
new file mode 100644
index 000000000000..36ec4251b5f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ite,it5205.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ite,it5205.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ITE IT5202 Type-C USB Alternate Mode Passive MUX
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+  - Tianping Fang <tianping.fang@mediatek.com>
+
+properties:
+  compatible:
+    const: ite,it5205
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description: Power supply for VCC pin (3.3V)
+
+  mode-switch:
+    description: Flag the port as possible handle of altmode switching
+    type: boolean
+
+  orientation-switch:
+    description: Flag the port as possible handler of orientation switching
+    type: boolean
+
+  ite,ovp-enable:
+    description: Enable Over Voltage Protection functionality
+    type: boolean
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      A port node to link the IT5205 to a TypeC controller for the purpose of
+      handling altmode muxing and orientation switching.
+
+required:
+  - compatible
+  - reg
+  - orientation-switch
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c2 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        typec-mux@48 {
+          compatible = "ite,it5205";
+          reg = <0x48>;
+
+          mode-switch;
+          orientation-switch;
+
+          vcc-supply = <&mt6359_vibr_ldo_reg>;
+
+          port {
+            it5205_usbss_sbu: endpoint {
+              remote-endpoint = <&typec_controller>;
+            };
+          };
+        };
+    };
+...
-- 
2.43.0


