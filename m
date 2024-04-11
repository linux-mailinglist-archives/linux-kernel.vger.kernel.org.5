Return-Path: <linux-kernel+bounces-140242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722D08A1002
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E63E287869
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE3A1474C4;
	Thu, 11 Apr 2024 10:29:46 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66268146D52;
	Thu, 11 Apr 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831386; cv=none; b=qErW55xdfbwiFrIL5L2QrxEvxLIj2vPGZ5HpZ3dIwFYnOWijPbyiuUur0OtrAD51fKsG8l7h3sOtgM0d+cUbxk7tstTOG8RF54WMSgaKOYp5k5vFFF+qGRFqBbxBegbKMupQAisDX03a0xitWjDuJHrmgxXuTuNSfe2Vf+G/v6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831386; c=relaxed/simple;
	bh=JAFeCKPAVOb0NOEyHFrJHhzUxg9evNHqa0c+BPuVMeA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=aDq5BntrlXvqOz03qnHEdGZprjVvSkKDCyTwH+4FTZIfZsh67ikUeDV7AW0Ft0vAbKnOkctKsKJ3adteewLmdAGnbq1sx6eXYIHBgpwTBAhwCD0ZPSFgNCU/rYDfkzmQoBHaFFgbwwH7zFoZesNZVBEQhFByFUR8S6km+AejkRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DE9921A00D5;
	Thu, 11 Apr 2024 12:29:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A4B11A0059;
	Thu, 11 Apr 2024 12:29:36 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 74DB4183ACAF;
	Thu, 11 Apr 2024 18:29:34 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/2] ASoC: dt-bindings: imx-audio-spdif: convert to YAML
Date: Thu, 11 Apr 2024 18:11:44 +0800
Message-Id: <1712830305-31350-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1712830305-31350-1-git-send-email-shengjiu.wang@nxp.com>
References: <1712830305-31350-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Convert the imx-audio-spdif binding to YAML.

When testing dtbs_check, found below compatible strings
are not listed in document:

fsl,imx-sabreauto-spdif
fsl,imx6sx-sdb-spdif

So add them in yaml file to pass the test.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/fsl,imx-audio-spdif.yaml   | 66 +++++++++++++++++++
 .../bindings/sound/imx-audio-spdif.txt        | 36 ----------
 2 files changed, 66 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-spdif.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-audio-spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-audio-spdif.yaml
new file mode 100644
index 000000000000..5fc543d02ecb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,imx-audio-spdif.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,imx-audio-spdif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX audio complex with S/PDIF transceiver
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx-sabreauto-spdif
+              - fsl,imx6sx-sdb-spdif
+          - const: fsl,imx-audio-spdif
+      - enum:
+          - fsl,imx-audio-spdif
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+  spdif-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the i.MX S/PDIF controller
+
+  spdif-out:
+    type: boolean
+    description:
+      If present, the transmitting function of S/PDIF will be enabled,
+      indicating there's a physical S/PDIF out connector or jack on the
+      board or it's connecting to some other IP block, such as an HDMI
+      encoder or display-controller.
+
+  spdif-in:
+    type: boolean
+    description:
+      If present, the receiving function of S/PDIF will be enabled,
+      indicating there is a physical S/PDIF in connector/jack on the board.
+
+required:
+  - compatible
+  - model
+  - spdif-controller
+
+anyOf:
+  - required:
+      - spdif-in
+  - required:
+      - spdif-out
+
+additionalProperties: false
+
+examples:
+  - |
+    sound-spdif {
+        compatible = "fsl,imx-audio-spdif";
+        model = "imx-spdif";
+        spdif-controller = <&spdif>;
+        spdif-out;
+        spdif-in;
+    };
diff --git a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
deleted file mode 100644
index da84a442ccea..000000000000
--- a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Freescale i.MX audio complex with S/PDIF transceiver
-
-Required properties:
-
-  - compatible		: "fsl,imx-audio-spdif"
-
-  - model		: The user-visible name of this sound complex
-
-  - spdif-controller	: The phandle of the i.MX S/PDIF controller
-
-
-Optional properties:
-
-  - spdif-out		: This is a boolean property. If present, the
-			  transmitting function of S/PDIF will be enabled,
-			  indicating there's a physical S/PDIF out connector
-			  or jack on the board or it's connecting to some
-			  other IP block, such as an HDMI encoder or
-			  display-controller.
-
-  - spdif-in		: This is a boolean property. If present, the receiving
-			  function of S/PDIF will be enabled, indicating there
-			  is a physical S/PDIF in connector/jack on the board.
-
-* Note: At least one of these two properties should be set in the DT binding.
-
-
-Example:
-
-sound-spdif {
-	compatible = "fsl,imx-audio-spdif";
-	model = "imx-spdif";
-	spdif-controller = <&spdif>;
-	spdif-out;
-	spdif-in;
-};
-- 
2.34.1


