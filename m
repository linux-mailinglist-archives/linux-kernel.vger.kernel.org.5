Return-Path: <linux-kernel+bounces-149831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351B8A9678
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAC11F22067
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6980415DBB9;
	Thu, 18 Apr 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gpE8FDEd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABFA15B554;
	Thu, 18 Apr 2024 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433303; cv=none; b=PJQWw8jgbyAauavkGR97N/FTMbgGmHZxDUrgwRROgJ8GWNe+HD4OeSM4ZiPLYVILDNYU+S4KhPwaZ82Uou6LMXIliFpB/WaWY8Rh3jkqczJqhKNINdF8HFc1VNhsuH00v7lksaMxf1uDsFPWuB8NrzMnVCsxQ+spftBNvzY1mOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433303; c=relaxed/simple;
	bh=SkUYYn0eHATkAsqIfLE949/ZGGxCD5NkUpcK3VNkCE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8fsVpAixZ/XQvPXVFMZhOVguUCIbcVY5ImRJNj8YNvDvC5qfoVNrfaHwdRWdWtyOFBtr5xOLHHvRsi+B6NqeTgNR4mA9GhL+zPOboFP1gwy41YVAYxr5b/GANiI53Xw4DvZeUNwUIcd0HjRxaikHoZxkTSbxPdkEFupseafVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gpE8FDEd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713433300;
	bh=SkUYYn0eHATkAsqIfLE949/ZGGxCD5NkUpcK3VNkCE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gpE8FDEd2WZd5vVRlq1tyWx13gSbx8mg1bY4ZuOgM4hAO9VyYp9F+JG1FRw92PHZZ
	 etF4Wuh+GA2OqwuVjdmRFyD0nnTRculvfUj/r5EtjBlH1ryo024XrIpN9Jtqe0Y7qk
	 lgw3rOfswP4c9DtZzbR0syD24E9Df9HM8W0fl/aj0dIhVxxPeRc2DMl/wfWgt9Tthz
	 yEHvoBbIobQnZLzA7LK5yK3k/7geLoOBf15ZxB3bgNhK3Bbc/F0rSC2bPFXAeD2FCl
	 3AieVxKlybWICAUBgXq1B2L6E3r+rTvQA4Nc0H8NyI7SF+lt5XP6IFiODBz8vfanhu
	 QJvnfSP3OZAMw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0B0F43782146;
	Thu, 18 Apr 2024 09:41:38 +0000 (UTC)
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
Subject: [PATCH v4 2/7] dt-bindings: interconnect: Add MediaTek EMI Interconnect bindings
Date: Thu, 18 Apr 2024 11:41:29 +0200
Message-ID: <20240418094134.203330-3-angelogioacchino.delregno@collabora.com>
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

Add bindings for the MediaTek External Memory Interface Interconnect,
which providers support system bandwidth requirements through Dynamic
Voltage Frequency Scaling Resource Collector (DVFSRC) hardware.

This adds bindings for MediaTek MT8183 and MT8195 SoCs.

Note that this is modeled as a subnode of DVFSRC for multiple reasons:
 - Some SoCs have more than one interconnect on the DVFSRC (and two
   different kinds of EMI interconnect, and also a SMI interconnect);

 - Some boards will want to not enable the interconnect driver because
   some of those are not battery powered (so they just keep the knobs
   at full thrust from the bootloader and never care scaling busses);

 - Some DVFSRC interconnect features may depend on firmware.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../interconnect/mediatek,mt8183-emi.yaml     | 51 +++++++++++++++++++
 .../interconnect/mediatek,mt8183.h            | 23 +++++++++
 .../interconnect/mediatek,mt8195.h            | 44 ++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
 create mode 100644 include/dt-bindings/interconnect/mediatek,mt8183.h
 create mode 100644 include/dt-bindings/interconnect/mediatek,mt8195.h

diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml b/Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
new file mode 100644
index 000000000000..017c8478b2a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/mediatek,mt8183-emi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek External Memory Interface (EMI) Interconnect
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description: |
+  EMI interconnect providers support system bandwidth requirements through
+  Dynamic Voltage Frequency Scaling Resource Collector (DVFSRC) hardware.
+  The provider is able to communicate with the DVFSRC through Secure Monitor
+  Call (SMC).
+
+             ICC provider         ICC Nodes
+                              ----          ----
+             _________       |CPU |   |--- |VPU |
+    _____   |         |-----  ----    |     ----
+   |     |->|  DRAM   |       ----    |     ----
+   |DRAM |->|scheduler|----- |GPU |   |--- |DISP|
+   |     |->|  (EMI)  |       ----    |     ----
+   |_____|->|_________|---.   -----   |     ----
+               /|\         `-|MMSYS|--|--- |VDEC|
+                |             -----   |     ----
+                |                     |     ----
+                | change DRAM freq    |--- |VENC|
+             --------                 |     ----
+    SMC --> | DVFSRC |                |     ----
+             --------                 |--- |IMG |
+                                      |     ----
+                                      |     ----
+                                      |--- |CAM |
+                                            ----
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8183-emi
+      - mediatek,mt8195-emi
+
+  '#interconnect-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#interconnect-cells'
+
+unevaluatedProperties: false
diff --git a/include/dt-bindings/interconnect/mediatek,mt8183.h b/include/dt-bindings/interconnect/mediatek,mt8183.h
new file mode 100644
index 000000000000..1088c350258d
--- /dev/null
+++ b/include/dt-bindings/interconnect/mediatek,mt8183.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Copyright (c) 2024 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_MEDIATEK_MT8183_H
+#define __DT_BINDINGS_INTERCONNECT_MEDIATEK_MT8183_H
+
+#define SLAVE_DDR_EMI		0
+#define MASTER_MCUSYS		1
+#define MASTER_MFG		2
+#define MASTER_MMSYS		3
+#define MASTER_MM_VPU		4
+#define MASTER_MM_DISP		5
+#define MASTER_MM_VDEC		6
+#define MASTER_MM_VENC		7
+#define MASTER_MM_CAM		8
+#define MASTER_MM_IMG		9
+#define MASTER_MM_MDP		10
+
+#endif
diff --git a/include/dt-bindings/interconnect/mediatek,mt8195.h b/include/dt-bindings/interconnect/mediatek,mt8195.h
new file mode 100644
index 000000000000..33e0e6cde732
--- /dev/null
+++ b/include/dt-bindings/interconnect/mediatek,mt8195.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Copyright (c) 2024 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_MEDIATEK_MT8195_H
+#define __DT_BINDINGS_INTERCONNECT_MEDIATEK_MT8195_H
+
+#define SLAVE_DDR_EMI		0
+#define MASTER_MCUSYS		1
+#define MASTER_GPUSYS		2
+#define MASTER_MMSYS		3
+#define MASTER_MM_VPU		4
+#define MASTER_MM_DISP		5
+#define MASTER_MM_VDEC		6
+#define MASTER_MM_VENC		7
+#define MASTER_MM_CAM		8
+#define MASTER_MM_IMG		9
+#define MASTER_MM_MDP		10
+#define MASTER_VPUSYS		11
+#define MASTER_VPU_0		12
+#define MASTER_VPU_1		13
+#define MASTER_MDLASYS		14
+#define MASTER_MDLA_0		15
+#define MASTER_UFS		16
+#define MASTER_PCIE_0		17
+#define MASTER_PCIE_1		18
+#define MASTER_USB		19
+#define MASTER_DBGIF		20
+#define SLAVE_HRT_DDR_EMI	21
+#define MASTER_HRT_MMSYS	22
+#define MASTER_HRT_MM_DISP	23
+#define MASTER_HRT_MM_VDEC	24
+#define MASTER_HRT_MM_VENC	25
+#define MASTER_HRT_MM_CAM	26
+#define MASTER_HRT_MM_IMG	27
+#define MASTER_HRT_MM_MDP	28
+#define MASTER_HRT_DBGIF	29
+#define MASTER_WIFI		30
+#define MASTER_BT		31
+#define MASTER_NETSYS		32
+#endif
-- 
2.44.0


