Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCEA760948
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjGYFai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjGYFa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:30:27 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78869E63;
        Mon, 24 Jul 2023 22:30:25 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BB09C201580;
        Tue, 25 Jul 2023 07:30:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5444720157E;
        Tue, 25 Jul 2023 07:30:23 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 639941800318;
        Tue, 25 Jul 2023 13:30:21 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, shengjiu.wang@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] dt-bindings: clock: fsl,imx8-acm: Add audio clock mux support
Date:   Tue, 25 Jul 2023 12:56:23 +0800
Message-Id: <1690260984-25744-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690260984-25744-1-git-send-email-shengjiu.wang@nxp.com>
References: <1690260984-25744-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock dt-binding file for Audio Clock Mux. which
is the IP for i.MX8QM, i.MX8QXP, i.MX8DXL.

Add the clockid for clocks in header file.

The Audio Clock Mux is binded with all the audio IP and audio clocks
in the subsystem, so need to list the power domain of related clocks
and IPs. Each clock and IP has a power domain, so there are so many
power domains.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v7:
- remove Reviewed-by tag
- remove unneeds nodes in example
- reorder compatible string
- squash header file to this patch

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

 .../bindings/clock/fsl,imx8-acm.yaml          | 282 ++++++++++++++++++
 include/dt-bindings/clock/imx8-clock.h        |  28 ++
 2 files changed, 310 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml
new file mode 100644
index 000000000000..07b9d21719c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml
@@ -0,0 +1,282 @@
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
+      - fsl,imx8dxl-acm
+      - fsl,imx8qm-acm
+      - fsl,imx8qxp-acm
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
+                 <&clk_ext_aud_mclk0>,
+                 <&clk_ext_aud_mclk1>,
+                 <&clk_esai0_rx_clk>,
+                 <&clk_esai0_rx_hf_clk>,
+                 <&clk_esai0_tx_clk>,
+                 <&clk_esai0_tx_hf_clk>,
+                 <&clk_spdif0_rx>,
+                 <&clk_sai0_rx_bclk>,
+                 <&clk_sai0_tx_bclk>,
+                 <&clk_sai1_rx_bclk>,
+                 <&clk_sai1_tx_bclk>,
+                 <&clk_sai2_rx_bclk>,
+                 <&clk_sai3_rx_bclk>,
+                 <&clk_sai4_rx_bclk>;
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
diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
index 2e60ce4d2622..2242ff54fc5e 100644
--- a/include/dt-bindings/clock/imx8-clock.h
+++ b/include/dt-bindings/clock/imx8-clock.h
@@ -164,4 +164,32 @@
 
 #define IMX_ADMA_LPCG_CLK_END				45
 
+#define IMX_ADMA_ACM_AUD_CLK0_SEL			0
+#define IMX_ADMA_ACM_AUD_CLK1_SEL			1
+#define IMX_ADMA_ACM_MCLKOUT0_SEL			2
+#define IMX_ADMA_ACM_MCLKOUT1_SEL			3
+#define IMX_ADMA_ACM_ESAI0_MCLK_SEL			4
+#define IMX_ADMA_ACM_ESAI1_MCLK_SEL			5
+#define IMX_ADMA_ACM_GPT0_MUX_CLK_SEL			6
+#define IMX_ADMA_ACM_GPT1_MUX_CLK_SEL			7
+#define IMX_ADMA_ACM_GPT2_MUX_CLK_SEL			8
+#define IMX_ADMA_ACM_GPT3_MUX_CLK_SEL			9
+#define IMX_ADMA_ACM_GPT4_MUX_CLK_SEL			10
+#define IMX_ADMA_ACM_GPT5_MUX_CLK_SEL			11
+#define IMX_ADMA_ACM_SAI0_MCLK_SEL			12
+#define IMX_ADMA_ACM_SAI1_MCLK_SEL			13
+#define IMX_ADMA_ACM_SAI2_MCLK_SEL			14
+#define IMX_ADMA_ACM_SAI3_MCLK_SEL			15
+#define IMX_ADMA_ACM_SAI4_MCLK_SEL			16
+#define IMX_ADMA_ACM_SAI5_MCLK_SEL			17
+#define IMX_ADMA_ACM_SAI6_MCLK_SEL			18
+#define IMX_ADMA_ACM_SAI7_MCLK_SEL			19
+#define IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL			20
+#define IMX_ADMA_ACM_SPDIF1_TX_CLK_SEL			21
+#define IMX_ADMA_ACM_MQS_TX_CLK_SEL			22
+#define IMX_ADMA_ACM_ASRC0_MUX_CLK_SEL			23
+#define IMX_ADMA_ACM_ASRC1_MUX_CLK_SEL			24
+
+#define IMX_ADMA_ACM_CLK_END				25
+
 #endif /* __DT_BINDINGS_CLOCK_IMX_H */
-- 
2.34.1

