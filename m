Return-Path: <linux-kernel+bounces-11363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E31681E528
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24CD1C21C76
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BAC4CB58;
	Tue, 26 Dec 2023 05:39:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9924D10C;
	Tue, 26 Dec 2023 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6B9658016;
	Tue, 26 Dec 2023 13:39:49 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 26 Dec
 2023 13:39:49 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 26 Dec 2023 13:39:43 +0800
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
Subject: [RFC 07/16] dt-bindings: clock: Add StarFive JH8100 North-West clock and reset generator
Date: Tue, 26 Dec 2023 13:38:39 +0800
Message-ID: <20231226053848.25089-8-jeeheng.sia@starfivetech.com>
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

Add bindings for the North-West clock and reset generator (NWCRG) on
JH8100 SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 .../bindings/clock/starfive,jh8100-nwcrg.yaml | 119 ++++++++++++++++++
 .../dt-bindings/clock/starfive,jh8100-crg.h   |  43 +++++++
 .../dt-bindings/reset/starfive,jh8100-crg.h   |  14 +++
 3 files changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh81=
00-nwcrg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh8100-nwcr=
g.yaml b/Documentation/devicetree/bindings/clock/starfive,jh8100-nwcrg.ya=
ml
new file mode 100644
index 000000000000..be0f94e64e6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh8100-nwcrg.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh8100-nwcrg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 North-West Clock and Reset Generator
+
+maintainers:
+  - Sia Jee Heng <jeeheng.sia@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-nwcrg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (24 MHz)
+      - description: APB_BUS clock from SYSCRG
+      - description: APB_BUS_PER4 clock from SYSCRG
+      - description: SPI_CORE_100 clock from SYSCRG
+      - description: ISP_2X clock from SYSCRG
+      - description: ISP_AXI clock from SYSCRG
+      - description: VOUT_ROOT0 clock from SYSCRG
+      - description: VOUT_ROOT1 clock from SYSCRG
+      - description: VOUT_SCAN_ATS clock from SYSCRG
+      - description: VOUT_DC_CORE clock from SYSCRG
+      - description: VOUT_AXI clock from SYSCRG
+      - description: AXI_400 clock from SYSCRG
+      - description: AHB0 clock from SYSCRG
+      - description: PERH_ROOT_PREOSC from SYSCRG
+      - description: External DVP clock
+      - description: External ISP DPHY TAP TCK clock
+      - description: External golbal clock
+      - description: External VOUT MIPI DPHY TAP TCK
+      - description: External VOUT eDP TAP TCK
+      - description: External SPI In2 clock
+      - description: PLL5
+
+  clock-names:
+    items:
+      - const: osc
+      - const: apb_bus
+      - const: apb_bus_per4
+      - const: spi_core_100
+      - const: isp_2x
+      - const: isp_axi
+      - const: vout_root0
+      - const: vout_root1
+      - const: vout_scan_ats
+      - const: vout_dc_core
+      - const: vout_axi
+      - const: axi_400
+      - const: ahb0
+      - const: perh_root_preosc
+      - const: dvp-ext
+      - const: isp-dphy-tap-tck-ext
+      - const: glb-ext-clk
+      - const: vout-mipi-dphy-tap-tck-ext
+      - const: vout-edp-tap-tck-ext
+      - const: spi-in2-ext
+      - const: pll5
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
+    clock-controller@123c0000 {
+        compatible =3D "starfive,jh8100-nwcrg";
+        reg =3D <0x123c0000 0x10000>;
+        clocks =3D <&osc>, <&syscrg JH8100_SYSCLK_APB_BUS>,
+                 <&syscrg JH8100_SYSCLK_APB_BUS_PER4>,
+                 <&syscrh JH8100_SYSCLK_SPI_CORE_100>,
+                 <&syscrg JH8100_SYSCLK_ISP_2X>,
+                 <&syscrg JH8100_SYSCLK_ISP_AXI>,
+                 <&syscrg JH8100_SYSCLK_VOUT_ROOT0>,
+                 <&syscrg JH8100_SYSCLK_VOUT_ROOT1>,
+                 <&syscrg JH8100_SYSCLK_VOUT_SCAN_ATS>,
+                 <&syscrg JH8100_SYSCLK_VOUT_DC_CORE>,
+                 <&syscrg JH8100_SYSCLK_VOUT_AXI>,
+                 <&syscrg JH8100_SYSCLK_AXI_400>,
+                 <&syscrg JH8100_SYSCLK_AHB0>,
+                 <&syscrg JH8100_SYSCLK_PERH_ROOT_PREOSC>,
+                 <&dvp_ext>, <&isp_dphy_tap_tck_ext>,
+                 <&glb_ext_clk>, <&vout_mipi_dphy_tap_tck_ext>,
+                 <&vout_edp_tap_tck_ext>, <&spi_in2_ext>, <&pll5>;
+        clock-names =3D "osc", "apb_bus", "apb_bus_per4", "spi_core_100"=
,
+                      "isp_2x", "isp_axi", "vout_root0", "vout_root1",
+                      "vout_scan_ats", "vout_dc_core", "vout_axi",
+                      "axi_400", "ahb0", "perh_root_preosc", "dvp-ext",
+                      "isp-dphy-tap-tck-ext", "glb-ext-clk",
+                      "vout-mipi-dphy-tap-tck-ext", "vout-edp-tap-tck-ex=
t",
+                      "spi-in2-ext", "pll5";
+        #clock-cells =3D <1>;
+        #reset-cells =3D <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh8100-crg.h b/include/dt=
-bindings/clock/starfive,jh8100-crg.h
index 611613961e17..626173e14940 100644
--- a/include/dt-bindings/clock/starfive,jh8100-crg.h
+++ b/include/dt-bindings/clock/starfive,jh8100-crg.h
@@ -119,4 +119,47 @@
 #define JH8100_SYSCLK_HD_AUDIO_ICG_EN					107
 #define JH8100_SYSCLK_NNE_ICG_EN					108
=20
+/* NWCRG clocks */
+#define JH8100_NWCLK_PLL5_DIV2						0
+#define JH8100_NWCLK_GCLK5						1
+#define JH8100_NWCLK_GPIO_100						2
+#define JH8100_NWCLK_GPIO_50						3
+#define JH8100_NWCLK_GPIO_150						4
+#define JH8100_NWCLK_GPIO_60						5
+#define JH8100_NWCLK_IOMUX_WEST_PCLK					6
+#define JH8100_NWCLK_I2C6_APB						7
+#define JH8100_NWCLK_I2C7_APB						8
+#define JH8100_NWCLK_SPI2_APB						9
+#define JH8100_NWCLK_SPI2_CORE						10
+#define JH8100_NWCLK_SPI2_SCLK_IN					11
+#define JH8100_NWCLK_SMBUS1_APB						12
+#define JH8100_NWCLK_SMBUS1_CORE					13
+#define JH8100_NWCLK_ISP_DVP						14
+#define JH8100_NWCLK_ISP_CORE_2X					15
+#define JH8100_NWCLK_ISP_AXI						16
+#define JH8100_NWCLK_ISP_DPHY_TAP_TCK					17
+#define JH8100_NWCLK_FLEXNOC_ISPSLV					18
+#define JH8100_NWCLK_VOUT_PIX0						19
+#define JH8100_NWCLK_VOUT_PIX1						20
+#define JH8100_NWCLK_VOUT_SCAN_ATS					21
+#define JH8100_NWCLK_VOUT_DC_CORE					22
+#define JH8100_NWCLK_VOUT_APB						23
+#define JH8100_NWCLK_VOUT_DSI						24
+#define JH8100_NWCLK_VOUT_AHB						25
+#define JH8100_NWCLK_VOUT_AXI						26
+#define JH8100_NWCLK_VOUT_MIPI_DPHY_TAP_TCK				27
+#define JH8100_NWCLK_VOUT_EDP_PHY_TAP_TCK				28
+#define JH8100_NWCLK_UART5_CORE_PREOSC					29
+#define JH8100_NWCLK_UART5_APB						30
+#define JH8100_NWCLK_UART5_CORE						31
+#define JH8100_NWCLK_UART6_CORE_PREOSC					32
+#define JH8100_NWCLK_UART6_APB						33
+#define JH8100_NWCLK_UART6_CORE						34
+#define JH8100_NWCLK_SPI2_ICG_EN					35
+#define JH8100_NWCLK_SMBUS1_ICG_EN					36
+#define JH8100_NWCLK_ISP_ICG_EN						37
+#define JH8100_NWCLK_VOUT_ICG_EN					38
+#define JH8100_NWCLK_UART5_ICG_EN					39
+#define JH8100_NWCLK_UART6_ICG_EN					40
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh8100-crg.h b/include/dt=
-bindings/reset/starfive,jh8100-crg.h
index c4e2501491ab..b25f6522f3d4 100644
--- a/include/dt-bindings/reset/starfive,jh8100-crg.h
+++ b/include/dt-bindings/reset/starfive,jh8100-crg.h
@@ -18,4 +18,18 @@
 #define JH8100_SYSRST_NNE					6
 #define JH8100_SYSRST_HD_AUDIO					7
=20
+/*
+ * NWCRG resets: assert0
+ */
+#define JH8100_NWRST_PRESETN					0
+#define JH8100_NWRST_SYS_IOMUX_W				1
+#define JH8100_NWRST_I2C6					2
+#define JH8100_NWRST_I2C7					3
+#define JH8100_NWRST_SPI2					4
+#define JH8100_NWRST_SMBUS1					5
+#define JH8100_NWRST_UART5					6
+#define JH8100_NWRST_UART6					7
+#define JH8100_NWRST_MERAK0_TVSENSOR				8
+#define JH8100_NWRST_MERAK1_TVSENSOR				9
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JH8100_H__ */
--=20
2.34.1


