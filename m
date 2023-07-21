Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A1A75C4E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjGUKm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGUKmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:42:53 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBA01701;
        Fri, 21 Jul 2023 03:42:50 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4EA1020054E;
        Fri, 21 Jul 2023 12:42:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DD4B9200567;
        Fri, 21 Jul 2023 12:42:48 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 080711802202;
        Fri, 21 Jul 2023 18:42:46 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, shengjiu.wang@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] dt-bindings: clock: fsl,imx8-acm: Add audio clock mux support
Date:   Fri, 21 Jul 2023 18:08:55 +0800
Message-Id: <1689934137-21430-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689934137-21430-1-git-send-email-shengjiu.wang@nxp.com>
References: <1689934137-21430-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock dt-binding file for audio clock mux. which
is the IP for i.MX8QM, i.MX8QXP, i.MX8DXL.

The Audio clock mux is binded with all the audio IP and audio clocks
in the subsystem, so need to list the power domain of related clocks
and IPs. Each clock and IP has a power domain, so there are so many
power domains.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
changes in v6:
- add clocks and clock-names, for using .fw_name in driver, the clocks
  need to be list in DT.

changes in v5:
- none

changes in v4:
- add Reviewed-by tag

changes in v3:
- change compatible string fron nxp to fsl, align with file name.
- add commit message for power domains numbers.
- remove description of power domain

changes in v2:
- update the file name to fsl,imx8-acm.yaml
- remove "binding" in title
- add power domains list
- change the node name in example
- change to lower-case for hex

 .../bindings/clock/fsl,imx8-acm.yaml          | 329 ++++++++++++++++++
 1 file changed, 329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml
new file mode 100644
index 000000000000..4274c5410c3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml
@@ -0,0 +1,329 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,imx8-acm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8 Audio Clock Mux
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+description: |
+  NXP i.MX8 Audio Clock Mux is dedicated clock muxing IP
+  used to control Audio related clock on the SoC.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-acm
+      - fsl,imx8qxp-acm
+      - fsl,imx8dxl-acm
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    minItems: 13
+    maxItems: 21
+
+  '#clock-cells':
+    const: 1
+    description:
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8-clock.h
+      for the full list of i.MX8 ACM clock IDs.
+
+  clocks:
+    minItems: 13
+    maxItems: 27
+
+  clock-names:
+    minItems: 13
+    maxItems: 27
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - '#clock-cells'
+  - clocks
+  - clock-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qxp-acm
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: power domain of IMX_SC_R_AUDIO_CLK_0
+            - description: power domain of IMX_SC_R_AUDIO_CLK_1
+            - description: power domain of IMX_SC_R_MCLK_OUT_0
+            - description: power domain of IMX_SC_R_MCLK_OUT_1
+            - description: power domain of IMX_SC_R_AUDIO_PLL_0
+            - description: power domain of IMX_SC_R_AUDIO_PLL_1
+            - description: power domain of IMX_SC_R_ASRC_0
+            - description: power domain of IMX_SC_R_ASRC_1
+            - description: power domain of IMX_SC_R_ESAI_0
+            - description: power domain of IMX_SC_R_SAI_0
+            - description: power domain of IMX_SC_R_SAI_1
+            - description: power domain of IMX_SC_R_SAI_2
+            - description: power domain of IMX_SC_R_SAI_3
+            - description: power domain of IMX_SC_R_SAI_4
+            - description: power domain of IMX_SC_R_SAI_5
+            - description: power domain of IMX_SC_R_SPDIF_0
+            - description: power domain of IMX_SC_R_MQS_0
+
+        clocks:
+          minItems: 18
+          maxItems: 18
+
+        clock-names:
+          items:
+            - const: aud_rec_clk0_lpcg_clk
+            - const: aud_rec_clk1_lpcg_clk
+            - const: aud_pll_div_clk0_lpcg_clk
+            - const: aud_pll_div_clk1_lpcg_clk
+            - const: ext_aud_mclk0
+            - const: ext_aud_mclk1
+            - const: esai0_rx_clk
+            - const: esai0_rx_hf_clk
+            - const: esai0_tx_clk
+            - const: esai0_tx_hf_clk
+            - const: spdif0_rx
+            - const: sai0_rx_bclk
+            - const: sai0_tx_bclk
+            - const: sai1_rx_bclk
+            - const: sai1_tx_bclk
+            - const: sai2_rx_bclk
+            - const: sai3_rx_bclk
+            - const: sai4_rx_bclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-acm
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: power domain of IMX_SC_R_AUDIO_CLK_0
+            - description: power domain of IMX_SC_R_AUDIO_CLK_1
+            - description: power domain of IMX_SC_R_MCLK_OUT_0
+            - description: power domain of IMX_SC_R_MCLK_OUT_1
+            - description: power domain of IMX_SC_R_AUDIO_PLL_0
+            - description: power domain of IMX_SC_R_AUDIO_PLL_1
+            - description: power domain of IMX_SC_R_ASRC_0
+            - description: power domain of IMX_SC_R_ASRC_1
+            - description: power domain of IMX_SC_R_ESAI_0
+            - description: power domain of IMX_SC_R_ESAI_1
+            - description: power domain of IMX_SC_R_SAI_0
+            - description: power domain of IMX_SC_R_SAI_1
+            - description: power domain of IMX_SC_R_SAI_2
+            - description: power domain of IMX_SC_R_SAI_3
+            - description: power domain of IMX_SC_R_SAI_4
+            - description: power domain of IMX_SC_R_SAI_5
+            - description: power domain of IMX_SC_R_SAI_6
+            - description: power domain of IMX_SC_R_SAI_7
+            - description: power domain of IMX_SC_R_SPDIF_0
+            - description: power domain of IMX_SC_R_SPDIF_1
+            - description: power domain of IMX_SC_R_MQS_0
+
+        clocks:
+          minItems: 27
+          maxItems: 27
+
+        clock-names:
+          items:
+            - const: aud_rec_clk0_lpcg_clk
+            - const: aud_rec_clk1_lpcg_clk
+            - const: aud_pll_div_clk0_lpcg_clk
+            - const: aud_pll_div_clk1_lpcg_clk
+            - const: mlb_clk
+            - const: hdmi_rx_mclk
+            - const: ext_aud_mclk0
+            - const: ext_aud_mclk1
+            - const: esai0_rx_clk
+            - const: esai0_rx_hf_clk
+            - const: esai0_tx_clk
+            - const: esai0_tx_hf_clk
+            - const: esai1_rx_clk
+            - const: esai1_rx_hf_clk
+            - const: esai1_tx_clk
+            - const: esai1_tx_hf_clk
+            - const: spdif0_rx
+            - const: spdif1_rx
+            - const: sai0_rx_bclk
+            - const: sai0_tx_bclk
+            - const: sai1_rx_bclk
+            - const: sai1_tx_bclk
+            - const: sai2_rx_bclk
+            - const: sai3_rx_bclk
+            - const: sai4_rx_bclk
+            - const: sai5_tx_bclk
+            - const: sai6_rx_bclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8dxl-acm
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: power domain of IMX_SC_R_AUDIO_CLK_0
+            - description: power domain of IMX_SC_R_AUDIO_CLK_1
+            - description: power domain of IMX_SC_R_MCLK_OUT_0
+            - description: power domain of IMX_SC_R_MCLK_OUT_1
+            - description: power domain of IMX_SC_R_AUDIO_PLL_0
+            - description: power domain of IMX_SC_R_AUDIO_PLL_1
+            - description: power domain of IMX_SC_R_ASRC_0
+            - description: power domain of IMX_SC_R_SAI_0
+            - description: power domain of IMX_SC_R_SAI_1
+            - description: power domain of IMX_SC_R_SAI_2
+            - description: power domain of IMX_SC_R_SAI_3
+            - description: power domain of IMX_SC_R_SPDIF_0
+            - description: power domain of IMX_SC_R_MQS_0
+
+        clocks:
+          minItems: 13
+          maxItems: 13
+
+        clock-names:
+          items:
+            - const: aud_rec_clk0_lpcg_clk
+            - const: aud_rec_clk1_lpcg_clk
+            - const: aud_pll_div_clk0_lpcg_clk
+            - const: aud_pll_div_clk1_lpcg_clk
+            - const: ext_aud_mclk0
+            - const: ext_aud_mclk1
+            - const: spdif0_rx
+            - const: sai0_rx_bclk
+            - const: sai0_tx_bclk
+            - const: sai1_rx_bclk
+            - const: sai1_tx_bclk
+            - const: sai2_rx_bclk
+            - const: sai3_rx_bclk
+
+additionalProperties: false
+
+examples:
+  # Clock Control Module node:
+  - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+
+    aud_rec0_lpcg: clock-controller@59d00000 {
+        compatible = "fsl,imx8qxp-lpcg";
+        reg = <0x59d00000 0x10000>;
+        #clock-cells = <1>;
+        clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>;
+        clock-indices = <IMX_LPCG_CLK_0>;
+        clock-output-names = "aud_rec_clk0_lpcg_clk";
+        power-domains = <&pd IMX_SC_R_AUDIO_PLL_0>;
+    };
+
+    aud_rec1_lpcg: clock-controller@59d10000 {
+        compatible = "fsl,imx8qxp-lpcg";
+        reg = <0x59d10000 0x10000>;
+        #clock-cells = <1>;
+        clocks = <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>;
+        clock-indices = <IMX_LPCG_CLK_0>;
+        clock-output-names = "aud_rec_clk1_lpcg_clk";
+        power-domains = <&pd IMX_SC_R_AUDIO_PLL_1>;
+    };
+
+    aud_pll_div0_lpcg: clock-controller@59d20000 {
+        compatible = "fsl,imx8qxp-lpcg";
+        reg = <0x59d20000 0x10000>;
+        #clock-cells = <1>;
+        clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>;
+        clock-indices = <IMX_LPCG_CLK_0>;
+        clock-output-names = "aud_pll_div_clk0_lpcg_clk";
+        power-domains = <&pd IMX_SC_R_AUDIO_PLL_0>;
+    };
+
+    aud_pll_div1_lpcg: clock-controller@59d30000 {
+        compatible = "fsl,imx8qxp-lpcg";
+        reg = <0x59d30000 0x10000>;
+        #clock-cells = <1>;
+        clocks = <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>;
+        clock-indices = <IMX_LPCG_CLK_0>;
+        clock-output-names = "aud_pll_div_clk1_lpcg_clk";
+        power-domains = <&pd IMX_SC_R_AUDIO_PLL_1>;
+    };
+
+    clk_dummy: clock-dummy {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <0>;
+        clock-output-names = "clk_dummy";
+    };
+
+    clock-controller@59e00000 {
+        compatible = "fsl,imx8qxp-acm";
+        reg = <0x59e00000 0x1d0000>;
+        #clock-cells = <1>;
+        power-domains = <&pd IMX_SC_R_AUDIO_CLK_0>,
+                        <&pd IMX_SC_R_AUDIO_CLK_1>,
+                        <&pd IMX_SC_R_MCLK_OUT_0>,
+                        <&pd IMX_SC_R_MCLK_OUT_1>,
+                        <&pd IMX_SC_R_AUDIO_PLL_0>,
+                        <&pd IMX_SC_R_AUDIO_PLL_1>,
+                        <&pd IMX_SC_R_ASRC_0>,
+                        <&pd IMX_SC_R_ASRC_1>,
+                        <&pd IMX_SC_R_ESAI_0>,
+                        <&pd IMX_SC_R_SAI_0>,
+                        <&pd IMX_SC_R_SAI_1>,
+                        <&pd IMX_SC_R_SAI_2>,
+                        <&pd IMX_SC_R_SAI_3>,
+                        <&pd IMX_SC_R_SAI_4>,
+                        <&pd IMX_SC_R_SAI_5>,
+                        <&pd IMX_SC_R_SPDIF_0>,
+                        <&pd IMX_SC_R_MQS_0>;
+        clocks = <&aud_rec0_lpcg IMX_LPCG_CLK_0>,
+                 <&aud_rec1_lpcg IMX_LPCG_CLK_0>,
+                 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+                 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
+                 <&clk_dummy>,
+                 <&clk_dummy>,
+                 <&clk_dummy>,
+                 <&clk_dummy>,
+                 <&clk_dummy>,
+                 <&clk_dummy>,
+                 <&clk_dummy>,
+                 <&clk_dummy>,
+                 <&clk_dummy>,
+                 <&clk_dummy>,
+                 <&clk_dummy>,
+                 <&clk_dummy>,
+                 <&clk_dummy>,
+                 <&clk_dummy>;
+        clock-names = "aud_rec_clk0_lpcg_clk",
+                      "aud_rec_clk1_lpcg_clk",
+                      "aud_pll_div_clk0_lpcg_clk",
+                      "aud_pll_div_clk1_lpcg_clk",
+                      "ext_aud_mclk0",
+                      "ext_aud_mclk1",
+                      "esai0_rx_clk",
+                      "esai0_rx_hf_clk",
+                      "esai0_tx_clk",
+                      "esai0_tx_hf_clk",
+                      "spdif0_rx",
+                      "sai0_rx_bclk",
+                      "sai0_tx_bclk",
+                      "sai1_rx_bclk",
+                      "sai1_tx_bclk",
+                      "sai2_rx_bclk",
+                      "sai3_rx_bclk",
+                      "sai4_rx_bclk";
+    };
-- 
2.34.1

