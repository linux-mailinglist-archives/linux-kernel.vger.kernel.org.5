Return-Path: <linux-kernel+bounces-149832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52888A967B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BE82815FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7573C15E1FA;
	Thu, 18 Apr 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FguDnr1m"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F31B15B961;
	Thu, 18 Apr 2024 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433304; cv=none; b=dfIM0O6WOxutHURBWnyLvZBs+/hZe2dDAQWYjiKN08t5Fdavt7V3eXNpJvhikEMUbdiKkGv1potsSrMJvWkC3l2I4jJumlYM8kHeoTHVCyC2c29755SwTHUKJjbt+iO130CWg2xnE4+WE7/ZzbRgf1Amr8+mMxce73hZ2QWymDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433304; c=relaxed/simple;
	bh=K4ENQ0G/iOyX1eqQHNDF/2A2BFhvCIgBX5ebTFPQd6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlhHEhxHqbzHnlDHrTqazy7g2IEBEIYPGcvOPvdJwtMKgZZOjcYujGvDVUK7aav31Z2SQlkEA493qYIyDuweOCVSS61qKNvYx+6XGy2+0dhFv1oE2yhBXeI6F6tdKCimZzxJH9EBQdixkO3MUYMBRynMud1nJ4yDVi0mh5g87UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FguDnr1m; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713433301;
	bh=K4ENQ0G/iOyX1eqQHNDF/2A2BFhvCIgBX5ebTFPQd6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FguDnr1mlF0ksnkjT5OCQwL2pvi+czArsbsgqmzf2iKZ3lEYlj0hCm9d3dOq5QPy4
	 P9yVzZJTAdFmsvrzcP/tnc+l6isPmo8a/JqwfR+NTejP503tjZK+Nc0zdjW70KgAlt
	 kdyF7xN5jwGjRiyhtWrrf1/yI2haJs4APmxy1EuYbzSpMCoN4JPw0RbLlaowzEKTZZ
	 TZpBLVTRIylSMWxt0BIJr/15QugWaYSGxyydGiKVU+9xLRR544AIhP24PO4LCVRPbM
	 rZCv3KNgYoPMoydSmOd1BeY04eZ2vImlU+q1eIZyok993R2Z47jQOl+CWxQXC3C2b0
	 OSRk1G/qypBHA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 853A93782147;
	Thu, 18 Apr 2024 09:41:40 +0000 (UTC)
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
Subject: [PATCH v4 3/7] dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
Date: Thu, 18 Apr 2024 11:41:30 +0200
Message-ID: <20240418094134.203330-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418094134.203330-1-angelogioacchino.delregno@collabora.com>
References: <20240418094134.203330-1-angelogioacchino.delregno@collabora.com>
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


