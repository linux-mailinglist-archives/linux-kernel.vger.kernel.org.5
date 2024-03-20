Return-Path: <linux-kernel+bounces-108677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20688880E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB892834A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF7D39AC7;
	Wed, 20 Mar 2024 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIh55/Jn"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE5381AC;
	Wed, 20 Mar 2024 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925679; cv=none; b=TA4Nw5DHTl4/+YFvW4XUe54AlBog5NtyQcEVIuypljtkXeH3xxVcccxw6sNKduvVuNl1gD+JK/jN8m3mBp4oBtCRnred2/Fic/89fa2mTIWmxdbn7olQe+2qJaBW1MKmNz5oAjx8zniGHhnVv2rIC7UXMWGeKAHfgDW2vTm3nPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925679; c=relaxed/simple;
	bh=BVbpZjD8QaD7y17IHDhfMTdTYGJnFARN6zjQHua00eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CY9WxADf8j0XzNRabqJZ9mV7CxZF3cTOIax3DDI8LS1pDj7X/mrPbMVuzELQ5UMZEx+2NVnulRvfb1RsHCmzSqgjfLy9z2YoKeKUV8wY52qawu7rA7xMBtJPbCvt8taG5rJ/CLbLXZ7yDuCSovXkEu+IOwcpyTF2pjWW3C10aJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIh55/Jn; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-22963f0e12cso1227291fac.1;
        Wed, 20 Mar 2024 02:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710925677; x=1711530477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6LYzgeSraIQWph2DLzGUmFCxbm6oNIHNvAA92fmfgfw=;
        b=VIh55/Jnjr3X9VSUrwXc52Nv/LC69rtjbE5yBp8tKRC9RnNfvh9yG2M0bR079/2JuL
         ngcCLca9FY4Rfj3eZZlhHitz9l6QIRMaE4AC6zh3H/peQBkLBoy/VvRPrz84dih8qUEW
         mCLrBMgyu6CveGXJX+UoYXAaUEWvfBanmSANNIEZq56Y8xKhr7U4Hwhgh8w5i1GrKvkL
         EguZQAtI85vmLJnSVKzRXFKkC5sKZjcSv3Hc+/rCBv9RIMKI8Iq9UpdGtRPvKEutSskT
         xpxf5QVGiILGjN3OBsB9+u2xcDO5QMkMzfm39Si1OvjwgYthKS9g1fLXba6dhzm3/9ik
         WRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710925677; x=1711530477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LYzgeSraIQWph2DLzGUmFCxbm6oNIHNvAA92fmfgfw=;
        b=DQtPjp50SeD6jT5P9K5YyVl+oeFZL+OGHrRyMXrxUYbXUwKyd/BmFstEKvblio932Q
         GqeDN9QC1m2ohQoO2EmWjcFvJ5MP3oMaqkNJOt9ym/V2t0PwWUEaA0xaTDLSiNNx/rit
         zcLKZT8pYmmI8kjEMgz5RPs5HZjHDX2+JaAXlQfgwtV/FIRaGy6oq4aJqm+btjCM+T+p
         1X/qsZ7botjV6NRygVFljao8NXi0z3W0yHDrfnFir+2OWSDkBvdyHY4pE1eYECNx+Y5z
         o93jfSA0xnmRjBFfCHkwJYz736Yzasm9JyvXbrQavfb2ESIquAfQMKYkCqzCw7lpeJVS
         zE5w==
X-Forwarded-Encrypted: i=1; AJvYcCVIeCna18B105Xw5XyzQW8U0B16l+t3xQ9489pXUma5lC8XgT4RGZS3bWxcF2Q8vqpO7L2W7YNtt3ehaGNQKKVBI5TKsy1O6IpAXzjJewwMF0qQEpngI7+CKyUyqTnINpISLMi2wG9pXIL40UrvDU3Z/DRIfn1qJRog1bgJNnTYqS9vrQ==
X-Gm-Message-State: AOJu0YznFHxH+3u7aDvQaM8CfrtIh0QJbnSBPT2a8TAcLJxTVrJ1WIFV
	rNhDWZ6kVhTh0SA6YrtLUSkunOO/virPOrXsIfrXLo6mrfQBqQNf
X-Google-Smtp-Source: AGHT+IE2HShA9tzq7LK/MZr8vowvV1oJMzrwKIWizneyhfLiYWfkofVYT92Zz2xWszZIjg8lo9tqOw==
X-Received: by 2002:a05:6871:a58d:b0:222:69b4:fccd with SMTP id wd13-20020a056871a58d00b0022269b4fccdmr5292748oab.24.1710925677036;
        Wed, 20 Mar 2024 02:07:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:40f4:a4:a590:2a15:ea77:7177:18e3])
        by smtp.gmail.com with ESMTPSA id k1-20020aa79981000000b006e6f96ecc30sm9021369pfh.2.2024.03.20.02.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 02:07:56 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8] dt-bindings: ata: imx-pata: Convert to dtschema
Date: Wed, 20 Mar 2024 14:37:30 +0530
Message-ID: <20240320090733.96828-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the imx-pata bindings to DT schema.
Add missing fsl,imx31-pata and fsl,imx51-pata compatibles during
conversion, because they are already being used in existing DTS.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

---
Changes in v8:
- added missing space after comma in examples' compatible property

Changes in v7:
- removed blank space at the end of file.

Changes in v6:
- removed items before const due to single element.

Changes in v5:
- added oneOf in compatible property to allow the usage of imx27 alone.

Changes in v4:
- added fsl,imx31-pata in compatible property as enum.

Changes in v3:
- added fsl,imx51-pata in compatible property as enum
- fsl,imx27-pata is added as a const to ensure it is present always

Changes in v2:
- fixed style issues
- compatible property now matches the examples
- fixed yamllint warnings/errors
---
 .../devicetree/bindings/ata/fsl,imx-pata.yaml | 42 +++++++++++++++++++
 .../devicetree/bindings/ata/imx-pata.txt      | 16 -------
 2 files changed, 42 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt

diff --git a/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
new file mode 100644
index 000000000000..324e2413bba8
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/fsl,imx-pata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX PATA Controller
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx31-pata
+              - fsl,imx51-pata
+          - const: fsl,imx27-pata
+      - const: fsl,imx27-pata
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: PATA Controller interrupts
+
+  clocks:
+    items:
+      - description: PATA Controller clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pata: pata@83fe0000 {
+        compatible = "fsl,imx51-pata", "fsl,imx27-pata";
+        reg = <0x83fe0000 0x4000>;
+        interrupts = <70>;
+        clocks = <&clks 161>;
+    };
diff --git a/Documentation/devicetree/bindings/ata/imx-pata.txt b/Documentation/devicetree/bindings/ata/imx-pata.txt
deleted file mode 100644
index f1172f00188a..000000000000
--- a/Documentation/devicetree/bindings/ata/imx-pata.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-* Freescale i.MX PATA Controller
-
-Required properties:
-- compatible: "fsl,imx27-pata"
-- reg: Address range of the PATA Controller
-- interrupts: The interrupt of the PATA Controller
-- clocks: the clocks for the PATA Controller
-
-Example:
-
-	pata: pata@83fe0000 {
-		compatible = "fsl,imx51-pata", "fsl,imx27-pata";
-		reg = <0x83fe0000 0x4000>;
-		interrupts = <70>;
-		clocks = <&clks 161>;
-	};
-- 
2.44.0


