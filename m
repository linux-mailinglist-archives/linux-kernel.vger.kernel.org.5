Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111DD78BF20
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjH2HVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjH2HVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:21:18 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474171AB;
        Tue, 29 Aug 2023 00:21:16 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D9D8B200923;
        Tue, 29 Aug 2023 09:21:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 734B020028B;
        Tue, 29 Aug 2023 09:21:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 80C7C1802202;
        Tue, 29 Aug 2023 15:21:12 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        l.stach@pengutronix.de, a.fatoum@pengutronix.de,
        u.kleine-koenig@pengutronix.de
Cc:     hongxing.zhu@nxp.com, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v1 1/3] dt-bindings: phy: Add i.MX8QM PCIe PHY binding
Date:   Tue, 29 Aug 2023 14:45:32 +0800
Message-Id: <1693291534-32092-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1693291534-32092-1-git-send-email-hongxing.zhu@nxp.com>
References: <1693291534-32092-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QM PCIe PHY binding.

i.MX8QM HSIO(High Speed IO) module has three instances of single lane
SERDES PHYs, an instance of two lanes PCIe GEN3 controller, an
instance of single lane PCIe GEN3 controller, as well as an instance
of SATA 3.0 controller.

The HSIO module can be configured as the following different usecases.
1 - A two lanes PCIea and a single lane SATA.
2 - A single lane PCIea, a single lane PCIeb and a single lane SATA.
3 - A two lanes PCIea, a single lane PCIeb.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../bindings/phy/fsl,imx8-pcie-phy.yaml       | 70 ++++++++++++++++++-
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
index 182a219387b0..764790f2b10b 100644
--- a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
@@ -17,16 +17,18 @@ properties:
     enum:
       - fsl,imx8mm-pcie-phy
       - fsl,imx8mp-pcie-phy
+      - fsl,imx8qm-pcie-phy
 
   reg:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 5
 
   clock-names:
-    items:
-      - const: ref
+    minItems: 1
+    maxItems: 5
 
   resets:
     minItems: 1
@@ -70,6 +72,36 @@ properties:
     description: PCIe PHY  power domain (optional).
     maxItems: 1
 
+  hsio-cfg:
+    description: |
+      Specifies the different usecases supported by the HSIO(High Speed IO)
+      module. PCIEAX2SATA means two lanes PCIea and a single lane SATA.
+      PCIEAX1PCIEBX1SATA represents a single lane PCIea, a single lane
+      PCIeb and a single lane SATA. PCIEAX2PCIEBX1 on behalf of a two
+      lanes PCIea, a single lane PCIeb.
+      Refer include/dt-bindings/phy/phy-imx8-pcie.h for the constants to
+      be used (optional).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 3 ]
+
+  ctrl-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the ctrl-csr region containing the HSIO control and
+      status registers for PCIe or SATA controller (optional).
+
+  misc-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the misc-csr region containing the HSIO control and
+      status registers for misc (optional).
+
+  phy-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the phy-csr region containing the HSIO control and
+      status registers for phy (optional).
+
 required:
   - "#phy-cells"
   - compatible
@@ -78,6 +110,38 @@ required:
   - clock-names
   - fsl,refclk-pad-mode
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8qm-pcie-phy
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 5
+        clock-names:
+          oneOf:
+            - items:
+                - const: pipe_pclk
+                - const: ctrl_ips_clk
+                - const: phy_ips_clk
+                - const: misc_ips_clk
+            - items:
+                - const: apb_pclk
+                - const: pipe_pclk
+                - const: ctrl_ips_clk
+                - const: phy_ips_clk
+                - const: misc_ips_clk
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: ref
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

