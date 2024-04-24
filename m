Return-Path: <linux-kernel+bounces-156665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5128B0686
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7879B1C22E00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4791598ED;
	Wed, 24 Apr 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uZaNCGaY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B74315921B;
	Wed, 24 Apr 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952470; cv=none; b=V4JAhZbysNOPPn68E9DOjtJah4gNZO+KW8HN0tJecOwshxHeP8tutD1ZueOnkjUouzuYfkggfBQLT4FohPIztY72k3ENGJFn8Sv1nW7YYs3aqkbiEtgpjMCY2F9rVt2vTz7AuRSc9JbVk90pBq76Lfr83cTBhF8f78xQcWiQ+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952470; c=relaxed/simple;
	bh=Jh5vpJjmKeRNGvYOlTEiY00JGA1l2grGTbUO6N8If1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bj7h28guou87ovpHtSrNwrgDDeNdx9Akfb9FE+pbG+zvMMT7CArMy00LBlGVtgzNO0B4QlaCVLs1Zj+mrIH2WxPU53SDzuZQSyChgN9VIPcmpzAZJHeYKGBIBrsdzo24+wSoqAYunROssOMsXED86kNpRelIhwuV+w2WS1bVi6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uZaNCGaY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713952467;
	bh=Jh5vpJjmKeRNGvYOlTEiY00JGA1l2grGTbUO6N8If1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZaNCGaYqFDCFQkZ/hDQQavJJC7CwCsNbW7K/WWgUIZMAXmROKbdBJjXi29kRM2Nq
	 xj0199VqkaoUM60GZ/zvkJSinV0FUjDwSfZkdhvJOnw6h4iAuB3Xynl+vUdWyv4Tlz
	 17OZoyM+dJSmMe4m3cqANgnv6bPjxRmKhZ40dtIe4SY2VYPGRkLbcVpBGad1Qv2Yyk
	 uPOus3tbRLJnWoN1d1iDqRigtwS7NWo+pBuIZPW/MXKrmmVEq5LI13a1fVN2cosuU0
	 VL+ouKLFf0OVyrqctYNcVKTJgDjOma51LvRMrWajea7PGndjXB1VzdcwnY+OYpys7/
	 QCoKuRwoQTdWA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 151C63782150;
	Wed, 24 Apr 2024 09:54:26 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: djakov@kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	keescook@chromium.org,
	gustavoars@kernel.org,
	henryc.chen@mediatek.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org,
	amergnat@baylibre.com
Subject: [PATCH v5 3/7] dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
Date: Wed, 24 Apr 2024 11:54:12 +0200
Message-ID: <20240424095416.1105639-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424095416.1105639-1-angelogioacchino.delregno@collabora.com>
References: <20240424095416.1105639-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the MediaTek Dynamic Voltage and Frequency Scaling
Resource Collector (DVFSRC), a hardware module used to collect all the
requests from both software and the various remote processors embedded
into the SoC and decide about a minimum operating voltage and a minimum
DRAM frequency to fulfill those requests in an effort to provide the
best achievable performance per watt.

This hardware IP is capable of transparently performing direct register
R/W on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml  | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
new file mode 100644
index 000000000000..1ad5b61b249f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt8183-dvfsrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC)
+
+description:
+  The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
+  Hardware module used to collect all the requests from both software and the
+  various remote processors embedded into the SoC and decide about a minimum
+  operating voltage and a minimum DRAM frequency to fulfill those requests in
+  an effort to provide the best achievable performance per watt.
+  This hardware IP is capable of transparently performing direct register R/W
+  on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+  - Henry Chen <henryc.chen@mediatek.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt8183-dvfsrc
+          - mediatek,mt8195-dvfsrc
+      - items:
+          - const: mediatek,mt8192-dvfsrc
+          - const: mediatek,mt8195-dvfsrc
+
+  reg:
+    maxItems: 1
+    description: DVFSRC common register address and length.
+
+  regulators:
+    type: object
+    $ref: /schemas/regulator/mediatek,mt6873-dvfsrc-regulator.yaml#
+
+  interconnect:
+    type: object
+    $ref: /schemas/interconnect/mediatek,mt8183-emi.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        system-controller@10012000 {
+            compatible = "mediatek,mt8195-dvfsrc";
+            reg = <0 0x10012000 0 0x1000>;
+
+            regulators {
+                compatible = "mediatek,mt8195-dvfsrc-regulator";
+
+                dvfsrc_vcore: dvfsrc-vcore {
+                        regulator-name = "dvfsrc-vcore";
+                        regulator-min-microvolt = <550000>;
+                        regulator-max-microvolt = <750000>;
+                        regulator-always-on;
+                };
+
+                dvfsrc_vscp: dvfsrc-vscp {
+                        regulator-name = "dvfsrc-vscp";
+                        regulator-min-microvolt = <550000>;
+                        regulator-max-microvolt = <750000>;
+                        regulator-always-on;
+                };
+            };
+
+            emi_icc: interconnect {
+                compatible = "mediatek,mt8195-emi";
+                #interconnect-cells = <1>;
+            };
+        };
+    };
-- 
2.44.0


