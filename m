Return-Path: <linux-kernel+bounces-147134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EDC8A6FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028101C21303
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C7013172A;
	Tue, 16 Apr 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OVbxoN87"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5E439FCE;
	Tue, 16 Apr 2024 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281893; cv=none; b=HjpUflYuq1BEgn1Ko+42vKw439ncpvHQBjm1VCXu7yMwTnkjUw6S2+B9w85SO5N0NsO+NvO2uuR/NNCZDJisVeeXI4QpxpUVSP9MAqSZ38onxMIiwvnq4cJETwu/DlUH+J8KO/Ab+64JqrWDo/+wye6pL7cO0i55CpcHVNJQnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281893; c=relaxed/simple;
	bh=NtlYHJ2Zc6slwfHdKI3lwZXF9IsJrotDWW+2OK00kz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWApMpOdEAy2eE9l7e6EpooVCZgTPwezV0dVCzUbbdT+LanRS2w9ma9V/2Mnhko1KJKzxFf1tMIc3tCZmM0kkiC8LuoODOtqCMHAkc4fLkWwnUMBKLknoBc67yo2CVCP87nkA8Kuc4guB0dDC8yqJ/BZmCRuFqdsaVmGpVgyI8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OVbxoN87; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713281889;
	bh=NtlYHJ2Zc6slwfHdKI3lwZXF9IsJrotDWW+2OK00kz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVbxoN87FhZ85XmxhVfJfCoLfkIXONQYRmFa/HmTrSpFc51q9W2VYhrDoOy8C7yHk
	 WZ/Ga3OUc+gnwMIkRs8Od1ce5m0P+spc8hqffpn92QIwdXXqoONQQxOr98P1+nkJHW
	 Gc43nJQS16ReYVA8lr+ZUA5eMaSDnYLV8owqwWt9ZHjV9t1daioWYOEQhGQmqFOD1x
	 1+RxGtLHvN9BhkcDWVNcmYtXYFuyTL7ceZyg3VLDJNF2eX1JmVwueClfC7wwg5qtW7
	 Nsxq36clhSfhXEIYuwmfPeStq3sWMXrWGC3Yqh1hEybbKp6fBIdbDebKxfsaYzi8VS
	 SB+5uZiP0iVMQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AA2D4378213F;
	Tue, 16 Apr 2024 15:38:08 +0000 (UTC)
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
Subject: [PATCH v1 1/6] dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
Date: Tue, 16 Apr 2024 17:38:00 +0200
Message-ID: <20240416153805.431118-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416153805.431118-1-angelogioacchino.delregno@collabora.com>
References: <20240416153805.431118-1-angelogioacchino.delregno@collabora.com>
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
 .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml  | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
new file mode 100644
index 000000000000..12bcc3fdfd07
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
@@ -0,0 +1,57 @@
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
+      - items:
+          - enum:
+              - mediatek,mt8183-dvfsrc
+              - mediatek,mt8195-dvfsrc
+      - items:
+          - const: mediatek,mt8192-dvfsrc
+          - const: mediatek,mt8195-dvfsrc
+
+  reg:
+    maxItems: 1
+    description: DVFSRC common register address and length.
+
+patternProperties:
+  "@[0-9a-f]+$":
+    type: object
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
+        dvfsrc@10012000 {
+            compatible = "mediatek,mt8195-dvfsrc";
+            reg = <0 0x10012000 0 0x1000>;
+        };
+    };
-- 
2.44.0


