Return-Path: <linux-kernel+bounces-11361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28CD81E522
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5A2B20AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8664CB42;
	Tue, 26 Dec 2023 05:39:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED24C63C;
	Tue, 26 Dec 2023 05:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 70A838022;
	Tue, 26 Dec 2023 13:39:36 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 26 Dec
 2023 13:39:36 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 26 Dec 2023 13:39:30 +0800
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: <kernel@esmil.dk>, <conor@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<emil.renner.berthing@canonical.com>, <hal.feng@starfivetech.com>,
	<xingyu.wu@starfivetech.com>
CC: <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>
Subject: [RFC 05/16] dt-bindings: clock: Add StarFive JH8100 System clock and reset generator
Date: Tue, 26 Dec 2023 13:38:37 +0800
Message-ID: <20231226053848.25089-6-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231226053848.25089-1-jeeheng.sia@starfivetech.com>
References: <20231226053848.25089-1-jeeheng.sia@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add bindings for the System clocks and reset generator (SYSCRG) on
JH8100 SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 .../clock/starfive,jh8100-syscrg.yaml         |  77 +++++++++++
 .../dt-bindings/clock/starfive,jh8100-crg.h   | 122 ++++++++++++++++++
 .../dt-bindings/reset/starfive,jh8100-crg.h   |  21 +++
 3 files changed, 220 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh81=
00-syscrg.yaml
 create mode 100644 include/dt-bindings/clock/starfive,jh8100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jh8100-crg.h

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh8100-sysc=
rg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg.=
yaml
new file mode 100644
index 000000000000..853b13ce5562
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg.yaml
@@ -0,0 +1,77 @@
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
+      - description: External MCLK clock
+      - description: PLL0
+      - description: PLL1
+      - description: PLL2
+      - description: PLL3
+      - description: PLL4
+      - description: PLL6
+      - description: PLL7
+
+  clock-names:
+    items:
+      - const: osc
+      - const: mclk-ext
+      - const: pll0
+      - const: pll1
+      - const: pll2
+      - const: pll3
+      - const: pll4
+      - const: pll6
+      - const: pll7
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jh8100-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive,jh8100-crg.h> for valid indices.
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
+        compatible =3D "starfive,jh8100-syscrg";
+        reg =3D <0x126d0000 0x10000>;
+        clocks =3D <&osc>, <&mclk_ext>, <&pll0>, <&pll1>,
+                 <&pll2>, <&pll3>, <&pll4>, <&pll6>, <&pll7>;
+        clock-names =3D "osc", "mclk-ext", "pll0", "pll1",
+                      "pll2", "pll3", "pll4",
+                      "pll6", "pll7";
+        #clock-cells =3D <1>;
+        #reset-cells =3D <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh8100-crg.h b/include/dt=
-bindings/clock/starfive,jh8100-crg.h
new file mode 100644
index 000000000000..611613961e17
--- /dev/null
+++ b/include/dt-bindings/clock/starfive,jh8100-crg.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Sia Jee Heng <jeeheng.sia@starfivetech.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__
+#define __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__
+
+/* SYSCRG clocks */
+#define JH8100_SYSCLK_VDEC_ROOT_PREOSC					0
+#define JH8100_SYSCLK_VDEC_ROOT						1
+#define JH8100_SYSCLK_VENC_ROOT_PREOSC					2
+#define JH8100_SYSCLK_VENC_ROOT						3
+#define JH8100_SYSCLK_GPU_ROOT						4
+#define JH8100_SYSCLK_GPU_CORE						5
+#define JH8100_SYSCLK_VOUT_ROOT0_PREOSC					6
+#define JH8100_SYSCLK_VOUT_ROOT0					7
+#define JH8100_SYSCLK_VOUT_ROOT1_PREOSC					8
+#define JH8100_SYSCLK_VOUT_ROOT1					9
+#define JH8100_SYSCLK_VOUT_SCAN_ATS					10
+#define JH8100_SYSCLK_PERH_ROOT_PREOSC					11
+#define JH8100_SYSCLK_PERH_ROOT						12
+#define JH8100_SYSCLK_AXI_200_PREOSC					13
+#define JH8100_SYSCLK_AXI_200						14
+#define JH8100_SYSCLK_AXI_200_GMAC					15
+#define JH8100_SYSCLK_AXI_500_PREOSC					16
+#define JH8100_SYSCLK_AXI_500						17
+#define JH8100_SYSCLK_AXI_500_PCIEX1A					18
+#define JH8100_SYSCLK_AXI_500_PCIEX1B					19
+#define JH8100_SYSCLK_AXI_500_PCIEX2					20
+#define JH8100_SYSCLK_AXI_500_PCIEX8					21
+#define JH8100_SYSCLK_AXI_400_PREOSC					22
+#define JH8100_SYSCLK_AXI_400						23
+#define JH8100_SYSCLK_AXI_400_APBOOTRAM					24
+#define JH8100_SYSCLK_AXI_125_PREOSC					25
+#define JH8100_SYSCLK_AXI_125						26
+#define JH8100_SYSCLK_AHB0_PREOSC					27
+#define JH8100_SYSCLK_AHB0						28
+#define JH8100_SYSCLK_APB_BUS_FUNC					29
+#define JH8100_SYSCLK_APB_BUS						30
+#define JH8100_SYSCLK_APB_BUS_PER0					31
+#define JH8100_SYSCLK_APB_BUS_PER1					32
+#define JH8100_SYSCLK_APB_BUS_PER2					33
+#define JH8100_SYSCLK_APB_BUS_PER3					34
+#define JH8100_SYSCLK_APB_BUS_PER4					35
+#define JH8100_SYSCLK_APB_BUS_PER5					36
+#define JH8100_SYSCLK_APB_BUS_PER6					37
+#define JH8100_SYSCLK_APB_BUS_PER7					38
+#define JH8100_SYSCLK_APB_BUS_PER8					39
+#define JH8100_SYSCLK_APB_BUS_PER9					40
+#define JH8100_SYSCLK_APB_BUS_PER10					41
+#define JH8100_SYSCLK_SPI_CORE_100					42
+#define JH8100_SYSCLK_PLL1_DIV2						43
+#define JH8100_SYSCLK_PLL2_DIV2						44
+#define JH8100_SYSCLK_PLL3_DIV2						45
+#define JH8100_SYSCLK_PLL4_DIV2						46
+#define JH8100_SYSCLK_PLL6_DIV2						47
+#define JH8100_SYSCLK_PLL7_DIV2						48
+#define JH8100_SYSCLK_AUDIO_ROOT					49
+#define JH8100_SYSCLK_MCLK_INNER					50
+#define JH8100_SYSCLK_MCLK						51
+#define JH8100_SYSCLK_MCLK_OUT						52
+#define JH8100_SYSCLK_ISP_2X_PREOSC					53
+#define JH8100_SYSCLK_ISP_2X						54
+#define JH8100_SYSCLK_ISP_AXI						55
+#define JH8100_SYSCLK_GCLK1						56
+#define JH8100_SYSCLK_GCLK2						57
+#define JH8100_SYSCLK_GCLK3						58
+#define JH8100_SYSCLK_GCLK4						59
+#define JH8100_SYSCLK_GCLK6						60
+#define JH8100_SYSCLK_GCLK7						61
+#define JH8100_SYSCLK_FLEXNOC0_PREOSC					62
+#define JH8100_SYSCLK_FLEXNOC0						63
+#define JH8100_SYSCLK_FLEXNOC1_PREOSC					64
+#define JH8100_SYSCLK_FLEXNOC1						65
+#define JH8100_SYSCLK_FLEXNOC2_PREOSC					66
+#define JH8100_SYSCLK_FLEXNOC2						67
+#define JH8100_SYSCLK_VDEC_CORE						68
+#define JH8100_SYSCLK_GPU_CORE_ICG					69
+#define JH8100_SYSCLK_IMG_GPU_CLK_APB					70
+#define JH8100_SYSCLK_IMG_GPU_RTC_TOGGLE				71
+#define JH8100_SYSCLK_IMG_GPU_TIMER_USC					72
+#define JH8100_SYSCLK_HIFI4_CORE_PREOSC					73
+#define JH8100_SYSCLK_HIFI4_CORE					74
+#define JH8100_SYSCLK_E_200_PREOSC					75
+#define JH8100_SYSCLK_E_200						76
+#define JH8100_SYSCLK_HD_AUDIO_48M					77
+#define JH8100_SYSCLK_VOUT_DC_CORE					78
+#define JH8100_SYSCLK_VOUT_AXI						79
+#define JH8100_SYSCLK_USB_WRAP_625					80
+#define JH8100_SYSCLK_USB_WRAP_480					81
+#define JH8100_SYSCLK_USB_WRAP_240					82
+#define JH8100_SYSCLK_USB_WRAP_60					83
+#define JH8100_SYSCLK_USB_WRAP_156P25					84
+#define JH8100_SYSCLK_USB_WRAP_312P5					85
+#define JH8100_SYSCLK_USB_125M						86
+#define JH8100_SYSCLK_FLEXNOC_APBOOTRAM					87
+#define JH8100_SYSCLK_FLEXNOC_PCIEX1AMST				88
+#define JH8100_SYSCLK_FLEXNOC_PCIEX1ASLV				89
+#define JH8100_SYSCLK_FLEXNOC_PCIEX1BMST				90
+#define JH8100_SYSCLK_FLEXNOC_PCIEX1BSLV				91
+#define JH8100_SYSCLK_FLEXNOC_PCIEX2MST					92
+#define JH8100_SYSCLK_FLEXNOC_PCIEX2SLV					93
+#define JH8100_SYSCLK_FLEXNOC_PCIEX8MST					94
+#define JH8100_SYSCLK_FLEXNOC_PCIEX8SLV					95
+#define JH8100_SYSCLK_FLEXNOC_GMACSYSSLV				96
+#define JH8100_SYSCLK_GMAC_SRC						97
+#define JH8100_SYSCLK_GMAC1_GTXCLK_TOP					98
+#define JH8100_SYSCLK_GMAC1_PTP						99
+#define JH8100_SYSCLK_HD_AUDIO_SYSTEM_CLOCK				100
+#define JH8100_SYSCLK_HD_AUDIO_CLOCK_48					101
+#define JH8100_SYSCLK_HD_AUDIO_BCLK_POST_OCC_IN				102
+#define JH8100_SYSCLK_NNE_VIP_ACLK					103
+#define JH8100_SYSCLK_NNE_VIP_HCLK					104
+#define JH8100_SYSCLK_NNE_VIP_CLKCORE					105
+#define JH8100_SYSCLK_GPU_ICG_EN					106
+#define JH8100_SYSCLK_HD_AUDIO_ICG_EN					107
+#define JH8100_SYSCLK_NNE_ICG_EN					108
+
+#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh8100-crg.h b/include/dt=
-bindings/reset/starfive,jh8100-crg.h
new file mode 100644
index 000000000000..c4e2501491ab
--- /dev/null
+++ b/include/dt-bindings/reset/starfive,jh8100-crg.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ *  Copyright (c) 2022-2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef __DT_BINDINGS_RESET_STARFIVE_JH8100_H__
+#define __DT_BINDINGS_RESET_STARFIVE_JH8100_H__
+
+/*
+ * SYSCRG resets: assert0
+ */
+#define JH8100_SYSRST_SYS_SYSCON				0
+#define JH8100_SYSRST_CLK_MOD					1
+#define JH8100_SYSRST_GPU					2
+#define JH8100_SYSRST_GPU_SPU					3
+#define JH8100_SYSRST_GPU_TVSENSOR				4
+#define JH8100_SYSRST_PPU_OP_NORET_GPU_RESET			5
+#define JH8100_SYSRST_NNE					6
+#define JH8100_SYSRST_HD_AUDIO					7
+
+#endif /* __DT_BINDINGS_RESET_STARFIVE_JH8100_H__ */
--=20
2.34.1


