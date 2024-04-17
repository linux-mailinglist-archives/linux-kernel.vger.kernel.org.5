Return-Path: <linux-kernel+bounces-148211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA358A7F60
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADA2283453
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE0412FF75;
	Wed, 17 Apr 2024 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="noC8WT9n"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CDA12AAE3;
	Wed, 17 Apr 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345290; cv=none; b=FE3aqbGcEU4H9PfOIueNkJaiUC5RLWSaq7qt42M4ejoydEHuU7YQ97/YCbGpUIxvnARcoPwbRJ4YSSv++o3GtGYU4LxYYx8VwBRLBzdiRBFCRB8cZR9cqew9SHP8JtJgG9c+tF1xcCx24NPz8ELiKRB4fbXj+NIFiXzRlJWzHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345290; c=relaxed/simple;
	bh=pqobeqHfUVbkypqHwHSiTkFR/HCjK7XkjC8AjPfYgX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTAsbMAsFpy+wlVozR2Nmx1BlcJv7X3vFDFFZa8mAWa3abF5gHz1yocUqjjFBOO1/yvlrpg9GWAjMVMhTjLTU1COXIWsRIKKeAOS2GTLsGlzjByaFED2B+gKd0RdsW9eZf/pXFXWkWLz5qK8hqapTfjxenD+QI35ZK3IWVs1ci4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=noC8WT9n; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713345287;
	bh=pqobeqHfUVbkypqHwHSiTkFR/HCjK7XkjC8AjPfYgX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=noC8WT9nMOVHMivvk5E86wS0K0xe7U7pcqTdYF6o82RCaJUy7Bb4pnU1rmn4NtoIW
	 0KpDMmIYs1M0IBTBnjhtEw1U0oDUp5myi2V1WvylkYOwL74Bf7ggl1t9etkG0Pjwa/
	 A+Pf9FYps396ki1qrpOe8d10btmQkGLkqoUvNmcBeVbwk+jO7MEvQikDkCGUjui3XF
	 D7jV09wM7BK+BnfqcGvIonfV0ZUDNyZmfklFQongeQikMtdzIxTOKSuKhY9zt3dSjk
	 tQqiq85aPurX3+G9nljn5uaL65rfHJF2cv8k4sB7ICnteqOSpPHsmWax6f51GcIyeg
	 fpP5dAwVcO1VA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 988E637820F9;
	Wed, 17 Apr 2024 09:14:46 +0000 (UTC)
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
Subject: [PATCH v2 1/7] dt-bindings: regulator: Add bindings for MediaTek DVFSRC Regulators
Date: Wed, 17 Apr 2024 11:14:36 +0200
Message-ID: <20240417091442.170505-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
References: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Dynamic Voltage and Frequency Scaling Resource Collector Regulators
are controlled with votes to the DVFSRC hardware.

This adds support for the regulators found in MT6873, MT8183, MT8192
and MT8195 SoCs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mediatek,mt6873-dvfsrc-regulator.yaml     | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
new file mode 100644
index 000000000000..446f1dab4d2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mediatek,mt6873-dvfsrc-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek DVFSRC-controlled Regulators
+
+description:
+  The Dynamic Voltage and Frequency Scaling Resource Collector Regulators
+  are controlled with votes to the DVFSRC hardware.
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6873-dvfsrc-regulator
+      - mediatek,mt8183-dvfsrc-regulator
+      - mediatek,mt8192-dvfsrc-regulator
+      - mediatek,mt8195-dvfsrc-regulator
+
+  reg:
+    maxItems: 1
+
+  dvfsrc-vcore:
+    description: DVFSRC-controlled SoC Vcore regulator
+    $ref: regulator.yaml#
+
+  dvfsrc-vscp:
+    description: DVFSRC-controlled System Control Processor regulator
+    $ref: regulator.yaml#
+
+required:
+  - compatible
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
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            regulators@0 {
+                compatible = "mediatek,mt8195-dvfsrc-regulator";
+                reg = <0>;
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
+        };
+    };
-- 
2.44.0


