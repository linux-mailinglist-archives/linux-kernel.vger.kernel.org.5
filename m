Return-Path: <linux-kernel+bounces-156396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2F48B0252
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03CAB23F05
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF3E158869;
	Wed, 24 Apr 2024 06:39:57 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C015956A;
	Wed, 24 Apr 2024 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940796; cv=none; b=nea4eq3mSBhBwcCoL3DYhx7PvHZ2366mfeJoWnH4z/fcSTUqKYl4LtPx5HAx4nn0rZdynhgrtLy1m6XFanIwlBEm73RJZ3D4wJ/cGkcBkr7feECnmP5f31e9mzbhJLTwGr2qeAQpliaRMTkF5K/y3rldxvhfWgWBtXyygQjTFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940796; c=relaxed/simple;
	bh=PsiqgtWQuNzt1KHICBa1BiR+9zW5KcuF+wQRum5qQK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YSTLaV3u8IPecZWVzvazj/CvV3Ri3bVbTHkFwpkF4/u0byVTePBmF8H3bigrd1nkbh8bSsuyFkVL3Qh5gws8DeZIq/msMmkuZ048H0ykttXm/ElHgpi1gsv3RQhPP4/d8civKIc3atk90OUMug3RYtqCjqoDQunQrG4Q9Q5TOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8DCFC1A2312;
	Wed, 24 Apr 2024 08:39:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F6B91A1E98;
	Wed, 24 Apr 2024 08:39:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 057F2181D0FE;
	Wed, 24 Apr 2024 14:39:41 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: conor@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	frank.li@nxp.com,
	conor+dt@kernel.org
Cc: hongxing.zhu@nxp.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v3 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY binding
Date: Wed, 24 Apr 2024 14:21:22 +0800
Message-Id: <1713939683-15328-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713939683-15328-1-git-send-email-hongxing.zhu@nxp.com>
References: <1713939683-15328-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add i.MX8QM and i.MX8QXP HSIO SerDes PHY binding.
Introduce one HSIO configuration 'fsl,hsio-cfg', which need be set at
initialization according to board design.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../bindings/phy/fsl,imx8qm-hsio.yaml         | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
new file mode 100644
index 000000000000..3e2824d1616c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/fsl,imx8qm-hsio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8QM SoC series HSIO SERDES PHY
+
+maintainers:
+  - Richard Zhu <hongxing.zhu@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-hsio
+      - fsl,imx8qxp-hsio
+  reg:
+    minItems: 4
+    maxItems: 4
+
+  "#phy-cells":
+    const: 3
+    description:
+      The first defines the type of the PHY refer to the include phy.h.
+      The second defines controller index.
+      The third defines the lane mask of the lane ID, indicated which
+      lane is used by the PHY. They are defined as HSIO_LAN* in
+      dt-bindings/phy/phy-imx8-pcie.h
+
+  reg-names:
+    items:
+      - const: reg
+      - const: phy
+      - const: ctrl
+      - const: misc
+
+  clocks:
+    minItems: 5
+    maxItems: 14
+
+  clock-names:
+    minItems: 5
+    maxItems: 14
+
+  fsl,hsio-cfg:
+    description: Refer macro HSIO_CFG* include/dt-bindings/phy/phy-imx8-pcie.h.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  fsl,refclk-pad-mode:
+    description:
+      Specifies the mode of the refclk pad used. It can be UNUSED(PHY
+      refclock is derived from SoC internal source), INPUT(PHY refclock
+      is provided externally via the refclk pad) or OUTPUT(PHY refclock
+      is derived from SoC internal source and provided on the refclk pad).
+      Refer include/dt-bindings/phy/phy-imx8-pcie.h for the constants
+      to be used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: IMX8_PCIE_REFCLK_PAD_OUTPUT
+
+  power-domains:
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#phy-cells"
+  - clocks
+  - clock-names
+  - fsl,hsio-cfg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qxp-hsio
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: pclk0
+            - const: apb_pclk0
+            - const: phy0_crr
+            - const: ctl0_crr
+            - const: misc_crr
+        power-domains:
+          minItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-hsio
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: pclk0
+            - const: pclk1
+            - const: apb_pclk0
+            - const: apb_pclk1
+            - const: pclk2
+            - const: epcs_tx
+            - const: epcs_rx
+            - const: apb_pclk2
+            - const: phy0_crr
+            - const: phy1_crr
+            - const: ctl0_crr
+            - const: ctl1_crr
+            - const: ctl2_crr
+            - const: misc_crr
+        power-domains:
+          minItems: 2
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-clock.h>
+    #include <dt-bindings/clock/imx8-lpcg.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/phy/phy-imx8-pcie.h>
+
+    phy@5f1a0000 {
+        compatible = "fsl,imx8qxp-hsio";
+        reg = <0x5f1a0000 0x10000>,
+              <0x5f120000 0x10000>,
+              <0x5f140000 0x10000>,
+              <0x5f160000 0x10000>;
+        reg-names = "reg", "phy", "ctrl", "misc";
+        clocks = <&phyx1_lpcg IMX_LPCG_CLK_0>,
+                 <&phyx1_lpcg IMX_LPCG_CLK_4>,
+                 <&phyx1_crr1_lpcg IMX_LPCG_CLK_4>,
+                 <&pcieb_crr3_lpcg IMX_LPCG_CLK_4>,
+                 <&misc_crr5_lpcg IMX_LPCG_CLK_4>;
+        clock-names = "pclk0", "apb_pclk0", "phy0_crr", "ctl0_crr", "misc_crr";
+        power-domains = <&pd IMX_SC_R_SERDES_1>;
+        #phy-cells = <3>;
+        fsl,hsio-cfg = <IMX8Q_HSIO_CFG_PCIEB>;
+        fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+    };
+...
-- 
2.37.1


