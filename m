Return-Path: <linux-kernel+bounces-31152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBACB8329D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446F9B22CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA96452F79;
	Fri, 19 Jan 2024 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HGOGU6Uz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FAE3C470;
	Fri, 19 Jan 2024 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669101; cv=none; b=DGUyF/yuFyLJpR88IAYzUszQsBtmjLsMzDyl8BWh4BuKwNACFBge+IxuY4sP6Gsfe34IEZeCZBoPIoCyWPinFD/sTr7k7OHs8xL8Uqn4wNFcgvkQYXcaeZ57Hl9NyVOHE4hkSAR6U4PlJmoqUK87POoVb0cV2X05k7gymtx9SzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669101; c=relaxed/simple;
	bh=yMBnHD84devz8pBb0bWiL0F28mWeot+MVGjDOv5Z7as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOs1824emG6xxXOQ7s19HF/VC/ww6KDHz2+lz5s72NOC4gOYQFk6JtvpL7kHbgkNhkqu7pytNFXt0hlaBbNRlpWx4d47AMkDpj/igdtXNztZxU5IeP9+ATU2+dEF4aeQvPzpKa4AVqLrMHKlN0CiJQAeLC2YzM+7ANIDyQrKTiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HGOGU6Uz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705669098;
	bh=yMBnHD84devz8pBb0bWiL0F28mWeot+MVGjDOv5Z7as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGOGU6UzfoCntF4nff5F3P7Kmb4VSOuGSAJcJt5rGkh7SLFwKkhZELITmVDexpyMy
	 5jvj5EgS8n3dlezI1Uvk7WRMFjvav5UPYoT78yGrDKncLZd+OmCifztXmolRKsyT5M
	 DAxcRt8/OEBxc51p1n+r6aEcc17NRbdwMxjvYmtfwxxVagPJKeAXbccYQGLhs7+ocF
	 IMdxgebaGpIoKktyclXXGyPmkV8f4hpkv40DSGeVhtYDQ+7yxBe4cZe2WuCfsTPTMV
	 avtiBPrbc9+jP5Aygx1dfIqi60mi83XJbev1FAbF/fJQmbx3m38NPGRgjJ/GV3YfpA
	 wZgML5/d9XoRA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B54BB3781FF2;
	Fri, 19 Jan 2024 12:58:16 +0000 (UTC)
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
Subject: [PATCH v2 1/2] dt-bindings: usb: Introduce ITE IT5205 Alt. Mode Passive MUX
Date: Fri, 19 Jan 2024 13:58:11 +0100
Message-ID: <20240119125812.239197-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119125812.239197-1-angelogioacchino.delregno@collabora.com>
References: <20240119125812.239197-1-angelogioacchino.delregno@collabora.com>
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


