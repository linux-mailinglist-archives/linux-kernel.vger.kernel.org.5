Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7734806F0C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377855AbjLFLvZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377925AbjLFLu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:50:56 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A942171D;
        Wed,  6 Dec 2023 03:50:57 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D5E997FD6;
        Wed,  6 Dec 2023 19:50:54 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 19:50:54 +0800
Received: from jsia-virtual-machine.localdomain (175.136.135.142) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 6 Dec 2023 19:50:47 +0800
From:   Sia Jee Heng <jeeheng.sia@starfivetech.com>
To:     <kernel@esmil.dk>, <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <emil.renner.berthing@canonical.com>,
        <hal.feng@starfivetech.com>, <xingyu.wu@starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>
Subject: [PATCH v1 05/16] dt-bindings: clock: Add StarFive JH8100 System clock and reset generator
Date:   Wed, 6 Dec 2023 19:49:49 +0800
Message-ID: <20231206115000.295825-6-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [175.136.135.142]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the System clocks and reset generator
(SYSCRG) on JH8100 SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 .../clock/starfive,jh8100-syscrg.yaml         |  66 ++++++++++
 .../dt-bindings/clock/starfive,jh8100-crg.h   | 123 ++++++++++++++++++
 .../dt-bindings/reset/starfive,jh8100-crg.h   |  23 ++++
 3 files changed, 212 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg.yaml
 create mode 100644 include/dt-bindings/clock/starfive,jh8100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jh8100-crg.h

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg.yaml
new file mode 100644
index 000000000000..14ff8e4ef564
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh8100-syscrg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 System Clock and Reset Generator
+
+maintainers:
+  - Sia Jee Heng <jeeheng.sia@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-syscrg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (24 MHz)
+      - description: External I2S Rx BCLK clock
+      - description: External I2S Rx LRCK clock
+      - description: External MCLK clock
+
+  clock-names:
+    items:
+      - const: clk_osc
+      - const: clk_i2srx_bclk_ext
+      - const: clk_i2srx_lrck_ext
+      - const: clk_mclk_ext
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jh8100-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive-jh8100-crg.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh8100-crg.h>
+
+    clock-controller@126d0000 {
+            compatible = "starfive,jh8100-syscrg";
+            reg = <0x126d0000 0x10000>;
+            clocks = <&clk_osc>, <&clk_i2srx_bclk_ext>,
+                     <&clk_i2srx_lrck_ext>, <&clk_mclk_ext>;
+            clock-names = "clk_osc", "clk_i2srx_bclk_ext",
+                          "clk_i2srx_lrck_ext", "clk_mclk_ext";
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh8100-crg.h b/include/dt-bindings/clock/starfive,jh8100-crg.h
new file mode 100644
index 000000000000..e5bb588ce798
--- /dev/null
+++ b/include/dt-bindings/clock/starfive,jh8100-crg.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Sia Jee Heng <jeeheng.sia@starfivetech.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__
+#define __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__
+
+/* SYSCRG_CLK */
+#define SYSCRG_CLK_VDEC_ROOT_PREOSC					0
+#define SYSCRG_CLK_VDEC_ROOT						1
+#define SYSCRG_CLK_VENC_ROOT_PREOSC					2
+#define SYSCRG_CLK_VENC_ROOT						3
+#define SYSCRG_CLK_GPU_ROOT						4
+#define SYSCRG_CLK_GPU_CORE						5
+#define SYSCRG_CLK_VOUT_ROOT0_PREOSC					6
+#define SYSCRG_CLK_VOUT_ROOT0						7
+#define SYSCRG_CLK_VOUT_ROOT1_PREOSC					8
+#define SYSCRG_CLK_VOUT_ROOT1						9
+#define SYSCRG_CLK_VOUT_SCAN_ATS					10
+#define SYSCRG_CLK_PERH_ROOT_PREOSC					11
+#define SYSCRG_CLK_PERH_ROOT						12
+#define SYSCRG_CLK_AXI_200_PREOSC					13
+#define SYSCRG_CLK_AXI_200						14
+#define SYSCRG_CLK_AXI_200_GMAC						15
+#define SYSCRG_CLK_AXI_500_PREOSC					16
+#define SYSCRG_CLK_AXI_500						17
+#define SYSCRG_CLK_AXI_500_PCIEX1A					18
+#define SYSCRG_CLK_AXI_500_PCIEX1B					19
+#define SYSCRG_CLK_AXI_500_PCIEX2					20
+#define SYSCRG_CLK_AXI_500_PCIEX8					21
+#define SYSCRG_CLK_AXI_400_PREOSC					22
+#define SYSCRG_CLK_AXI_400						23
+#define SYSCRG_CLK_AXI_400_APBOOTRAM					24
+#define SYSCRG_CLK_AXI_125_PREOSC					25
+#define SYSCRG_CLK_AXI_125						26
+#define SYSCRG_CLK_AHB0_PREOSC						27
+#define SYSCRG_CLK_AHB0							28
+#define SYSCRG_CLK_APB_BUS_FUNC						29
+#define SYSCRG_CLK_APB_BUS						30
+#define SYSCRG_CLK_APB_BUS_PER0						31
+#define SYSCRG_CLK_APB_BUS_PER1						32
+#define SYSCRG_CLK_APB_BUS_PER2						33
+#define SYSCRG_CLK_APB_BUS_PER3						34
+#define SYSCRG_CLK_APB_BUS_PER4						35
+#define SYSCRG_CLK_APB_BUS_PER5						36
+#define SYSCRG_CLK_APB_BUS_PER6						37
+#define SYSCRG_CLK_APB_BUS_PER7						38
+#define SYSCRG_CLK_APB_BUS_PER8						39
+#define SYSCRG_CLK_APB_BUS_PER9						40
+#define SYSCRG_CLK_APB_BUS_PER10					41
+#define SYSCRG_CLK_SPI_CORE_100						42
+#define SYSCRG_CLK_PLL1_DIV2						43
+#define SYSCRG_CLK_PLL2_DIV2						44
+#define SYSCRG_CLK_PLL3_DIV2						45
+#define SYSCRG_CLK_PLL4_DIV2						46
+#define SYSCRG_CLK_PLL6_DIV2						47
+#define SYSCRG_CLK_PLL7_DIV2						48
+#define SYSCRG_CLK_AUDIO_ROOT						49
+#define SYSCRG_CLK_MCLK_INNER						50
+#define SYSCRG_CLK_MCLK							51
+#define SYSCRG_CLK_MCLK_OUT						52
+#define SYSCRG_CLK_ISP_2X_PREOSC					53
+#define SYSCRG_CLK_ISP_2X						54
+#define SYSCRG_CLK_ISP_AXI						55
+#define SYSCRG_CLK_GCLK1						56
+#define SYSCRG_CLK_GCLK2						57
+#define SYSCRG_CLK_GCLK3						58
+#define SYSCRG_CLK_GCLK4						59
+#define SYSCRG_CLK_GCLK6						60
+#define SYSCRG_CLK_GCLK7						61
+#define SYSCRG_CLK_FLEXNOC0_PREOSC					62
+#define SYSCRG_CLK_FLEXNOC0						63
+#define SYSCRG_CLK_FLEXNOC1_PREOSC					64
+#define SYSCRG_CLK_FLEXNOC1						65
+#define SYSCRG_CLK_FLEXNOC2_PREOSC					66
+#define SYSCRG_CLK_FLEXNOC2						67
+#define SYSCRG_CLK_VDEC_CORE						68
+#define SYSCRG_CLK_GPU_CORE_ICG						69
+#define SYSCRG_CLK_IMG_GPU_CLK_APB					70
+#define SYSCRG_CLK_IMG_GPU_RTC_TOGGLE					71
+#define SYSCRG_CLK_IMG_GPU_TIMER_USC					72
+#define SYSCRG_CLK_HIFI4_CORE_PREOSC					73
+#define SYSCRG_CLK_HIFI4_CORE						74
+#define SYSCRG_CLK_ESPI_200_PREOSC					75
+#define SYSCRG_CLK_ESPI_200						76
+#define SYSCRG_CLK_HD_AUDIO_48M						77
+#define SYSCRG_CLK_VOUT_DC_CORE						78
+#define SYSCRG_CLK_VOUT_AXI						79
+#define SYSCRG_CLK_USB_WRAP_625						80
+#define SYSCRG_CLK_USB_WRAP_480						81
+#define SYSCRG_CLK_USB_WRAP_240						82
+#define SYSCRG_CLK_USB_WRAP_60						83
+#define SYSCRG_CLK_USB_WRAP_156P25					84
+#define SYSCRG_CLK_USB_WRAP_312P5					85
+#define SYSCRG_CLK_USB_125M						86
+#define SYSCRG_CLK_FLEXNOC_APBOOTRAM					87
+#define SYSCRG_CLK_FLEXNOC_PCIEX1AMST					88
+#define SYSCRG_CLK_FLEXNOC_PCIEX1ASLV					89
+#define SYSCRG_CLK_FLEXNOC_PCIEX1BMST					90
+#define SYSCRG_CLK_FLEXNOC_PCIEX1BSLV					91
+#define SYSCRG_CLK_FLEXNOC_PCIEX2MST					92
+#define SYSCRG_CLK_FLEXNOC_PCIEX2SLV					93
+#define SYSCRG_CLK_FLEXNOC_PCIEX8MST					94
+#define SYSCRG_CLK_FLEXNOC_PCIEX8SLV					95
+#define SYSCRG_CLK_FLEXNOC_GMACSYSSLV					96
+#define SYSCRG_CLK_GMAC_SRC						97
+#define SYSCRG_CLK_GMAC1_GTXCLK_TOP					98
+#define SYSCRG_CLK_GMAC1_PTP						99
+#define SYSCRG_CLK_HD_AUDIO_SYSTEM_CLOCK				100
+#define SYSCRG_CLK_HD_AUDIO_CLOCK_48					101
+#define SYSCRG_CLK_HD_AUDIO_BCLK_POST_OCC_IN				102
+#define SYSCRG_CLK_NNE_VIP_ACLK						103
+#define SYSCRG_CLK_NNE_VIP_HCLK						104
+#define SYSCRG_CLK_NNE_VIP_CLKCORE					105
+#define SYSCRG_CLK_GPU_ICG_EN						106
+#define SYSCRG_CLK_HD_AUDIO_ICG_EN					107
+#define SYSCRG_CLK_NNE_ICG_EN						108
+
+#define SYSCRG_CLK_END							109
+#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh8100-crg.h b/include/dt-bindings/reset/starfive,jh8100-crg.h
new file mode 100644
index 000000000000..3b7b92488e76
--- /dev/null
+++ b/include/dt-bindings/reset/starfive,jh8100-crg.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ *  Copyright (c) 2022-2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef __DT_BINDINGS_RESET_STARFIVE_JH8100_H__
+#define __DT_BINDINGS_RESET_STARFIVE_JH8100_H__
+
+/*
+ * syscrg: assert0
+ */
+#define SYSCRG_RSTN_SYS_SYSCON					0
+#define SYSCRG_RSTN_CLK_MOD					1
+#define SYSCRG_RSTN_GPU						2
+#define SYSCRG_RSTN_GPU_SPU					3
+#define SYSCRG_RSTN_GPU_TVSENSOR				4
+#define SYSCRG_RSTN_PPU_OP_NORET_GPU_RESET			5
+#define SYSCRG_RSTN_NNE						6
+#define SYSCRG_RSTN_HD_AUDIO					7
+
+#define SYSCRG_RESET_NR_RESETS					8
+
+#endif /* __DT_BINDINGS_RESET_STARFIVE_JH8100_H__ */
-- 
2.34.1

