Return-Path: <linux-kernel+bounces-156663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36B28B0680
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C2A1C22D79
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C20B15921D;
	Wed, 24 Apr 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ic6MqJwk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F333158DC7;
	Wed, 24 Apr 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952467; cv=none; b=vA1Spfc4dtI7+ElfqFwsbHeRTmatw/6vgKUbM9TcTRmy+ZX/SoNo0U3/LcFm/O3U9hPu+WHLka8Si1+bOQVVUBfKEwW9nsVRaPtnwYHm4a2dHpx89dpEfEPTsC/QMDq/1BpruHbkvIYlrwfr0H6oAfRZTqhXMPytZlKuDp7o7Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952467; c=relaxed/simple;
	bh=b5a2Wcqavx5u14XwPbZnk8lSyIDPK9K90uqoWXPtIRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUcazAddtijna5OR3HQUVUTlOuQ6vkrFDG0eQc0+hi0LVDxdxMBCde+R8wJo9zodKBc/lMStjLogHxEEKVwUyPHpfc4iyfjeSqoOXtG79VHDt9hprhZ0fKhEbBT0ZALm9sQDTyF62xaSwY97wUG4HZkDhDy0eetb6h4CnWpE2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ic6MqJwk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713952464;
	bh=b5a2Wcqavx5u14XwPbZnk8lSyIDPK9K90uqoWXPtIRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ic6MqJwkY42GPFzyKHe4sctm8fR7zLEu4VNJtHeJ2HWSyJEyarky3t+EVq8MTUrR2
	 IvA/0BUBEa54XtJAiW7NoZyLA94ubsJM9fwF/WeUHWPFJCz/UqprxKonQXtZ4I1m+f
	 xeJqPiIdAjtBbQB6lE4Nx5U+rk2YYfkoVklQ/YsLl+5mt4IDGg+Kd50za7ZFjbAnc5
	 BlCq/u94GrSV73jnCqbRRLEQ7Z++Pq8qyN85SfzEu2Nkvn8XLzsRKfRPMHABwSGCsO
	 q8xi0FXzw8uKeiVwtEGjzV74yWoLlPXYczDhiFm0e14PM6+zrKTtSq+/fOZE9Q2YDS
	 FrpHLzLbv/YxA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7EF0E37820F9;
	Wed, 24 Apr 2024 09:54:23 +0000 (UTC)
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
Subject: [PATCH v5 1/7] dt-bindings: regulator: Add bindings for MediaTek DVFSRC Regulators
Date: Wed, 24 Apr 2024 11:54:10 +0200
Message-ID: <20240424095416.1105639-2-angelogioacchino.delregno@collabora.com>
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

The Dynamic Voltage and Frequency Scaling Resource Collector Regulators
are controlled with votes to the DVFSRC hardware.

This adds support for the regulators found in MT6873, MT8183, MT8192
and MT8195 SoCs.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mediatek,mt6873-dvfsrc-regulator.yaml     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
new file mode 100644
index 000000000000..704828687970
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
@@ -0,0 +1,43 @@
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
+  dvfsrc-vcore:
+    description: DVFSRC-controlled SoC Vcore regulator
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  dvfsrc-vscp:
+    description: DVFSRC-controlled System Control Processor regulator
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+anyOf:
+  - required:
+      - dvfsrc-vcore
+  - required:
+      - dvfsrc-vscp
+
+additionalProperties: false
-- 
2.44.0


