Return-Path: <linux-kernel+bounces-11362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2411A81E525
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457C3281155
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8AF4CDF3;
	Tue, 26 Dec 2023 05:39:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D954CB3C;
	Tue, 26 Dec 2023 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id EB80724E28B;
	Tue, 26 Dec 2023 13:39:42 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 26 Dec
 2023 13:39:42 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 26 Dec 2023 13:39:36 +0800
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
Subject: [RFC 06/16] clk: starfive: Add JH8100 System clock generator driver
Date: Tue, 26 Dec 2023 13:38:38 +0800
Message-ID: <20231226053848.25089-7-jeeheng.sia@starfivetech.com>
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

Add support for JH8100 System clock generator (SYSCRG).

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 MAINTAINERS                                   |   8 +
 drivers/clk/starfive/Kconfig                  |  10 +
 drivers/clk/starfive/Makefile                 |   2 +
 .../clk/starfive/clk-starfive-jh8100-sys.c    | 415 ++++++++++++++++++
 drivers/clk/starfive/clk-starfive-jh8100.h    |  11 +
 5 files changed, 446 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-sys.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7cef2d2ef8d7..1ea4a694ed31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20684,6 +20684,14 @@ F:	Documentation/devicetree/bindings/phy/starfiv=
e,jh7110-usb-phy.yaml
 F:	drivers/phy/starfive/phy-jh7110-pcie.c
 F:	drivers/phy/starfive/phy-jh7110-usb.c
=20
+STARFIVE JH8100 CLOCK DRIVERS
+M:	Sia Jee Heng <jeeheng.sia@starfivetech.com>
+M:	Ley Foon Tan <leyfoon.tan@starfivetech.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/starfive,jh81*.yaml
+F:	drivers/clk/starfive/clk-starfive-jh81*
+F:	include/dt-bindings/clock/starfive?jh81*.h
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index ff8eace36e64..1dddf1415360 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -72,3 +72,13 @@ config CLK_STARFIVE_JH7110_VOUT
 	help
 	  Say yes here to support the Video-Output clock controller
 	  on the StarFive JH7110 SoC.
+
+config CLK_STARFIVE_JH8100_SYS
+	bool "StarFive JH8100 System clock support"
+	depends on SOC_STARFIVE || COMPILE_TEST
+	select AUXILIARY_BUS
+	select CLK_STARFIVE_COMMON
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the System clock controller on the StarFive J=
H8100 SoC.
+
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefil=
e
index 012f7ee83f8e..af6903c4f987 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)	+=3D clk-starfive=
-jh7110-aon.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_STG)	+=3D clk-starfive-jh7110-stg.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+=3D clk-starfive-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+=3D clk-starfive-jh7110-vout.o
+
+obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)	+=3D clk-starfive-jh8100-sys.o
diff --git a/drivers/clk/starfive/clk-starfive-jh8100-sys.c b/drivers/clk=
/starfive/clk-starfive-jh8100-sys.c
new file mode 100644
index 000000000000..6d7e750dce82
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh8100-sys.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH8100 System Clock Driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <soc/starfive/reset-starfive-common.h>
+
+#include <dt-bindings/clock/starfive,jh8100-crg.h>
+
+#include "clk-starfive-jh8100.h"
+
+#define JH8100_SYSCLK_NUM_CLKS			(JH8100_SYSCLK_NNE_ICG_EN + 1)
+
+/* external clocks */
+#define JH8100_SYSCLK_OSC			(JH8100_SYSCLK_NUM_CLKS + 0)
+#define JH8100_SYSCLK_MCLK_EXT			(JH8100_SYSCLK_NUM_CLKS + 1)
+#define JH8100_SYSCLK_PLL0_OUT			(JH8100_SYSCLK_NUM_CLKS + 2)
+#define JH8100_SYSCLK_PLL1_OUT			(JH8100_SYSCLK_NUM_CLKS + 3)
+#define JH8100_SYSCLK_PLL2_OUT			(JH8100_SYSCLK_NUM_CLKS + 4)
+#define JH8100_SYSCLK_PLL3_OUT			(JH8100_SYSCLK_NUM_CLKS + 5)
+#define JH8100_SYSCLK_PLL4_OUT			(JH8100_SYSCLK_NUM_CLKS + 6)
+#define JH8100_SYSCLK_PLL6_OUT			(JH8100_SYSCLK_NUM_CLKS + 7)
+#define JH8100_SYSCLK_PLL7_OUT			(JH8100_SYSCLK_NUM_CLKS + 8)
+
+static const struct starfive_clk_data jh8100_syscrg_clk_data[] __initcon=
st =3D {
+	/* root */
+	STARFIVE__DIV(JH8100_SYSCLK_VDEC_ROOT_PREOSC, "vdec_root_preosc", 10,
+		      JH8100_SYSCLK_PLL7_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_VDEC_ROOT, "vdec_root", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_VDEC_ROOT_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_VENC_ROOT_PREOSC, "venc_root_preosc", 10,
+		      JH8100_SYSCLK_PLL7_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_VENC_ROOT, "venc_root", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_VENC_ROOT_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_GPU_ROOT, "gpu_root", 7,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_GPU_CORE, "gpu_core", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_GPU_ROOT),
+	STARFIVE__DIV(JH8100_SYSCLK_VOUT_ROOT0_PREOSC, "vout_root0_preosc", 127=
,
+		      JH8100_SYSCLK_PLL1_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_VOUT_ROOT0, "vout_root0", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_VOUT_ROOT0_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_VOUT_ROOT1_PREOSC, "vout_root1_preosc", 127=
,
+		      JH8100_SYSCLK_PLL6_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_VOUT_ROOT1, "vout_root1", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_VOUT_ROOT1_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_VOUT_SCAN_ATS, "vout_scan_ats", 6,
+		      JH8100_SYSCLK_PLL3_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_PERH_ROOT_PREOSC, "perh_root_preosc", 4,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_PERH_ROOT, "perh_root", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_PERH_ROOT_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_AXI_200_PREOSC, "axi_200_preosc", 4,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_200, "axi_200", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_200_PREOSC),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_200_GMAC, "axi_200_gmac", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_200_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_AXI_500_PREOSC, "axi_500_preosc", 10,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_500, "axi_500", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_500_PREOSC),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_500_PCIEX1A, "axi_500_pciex1a", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_500_PREOSC),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_500_PCIEX1B, "axi_500_pciex1b", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_500_PREOSC),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_500_PCIEX2, "axi_500_pciex2", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_500_PREOSC),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_500_PCIEX8, "axi_500_pciex8", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_500_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_AXI_400_PREOSC, "axi_400_preosc", 10,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_400, "axi_400", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_400_PREOSC),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_400_APBOOTRAM, "axi_400_apbootram", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_400_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_AXI_125_PREOSC, "axi_125_preosc", 32,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_AXI_125, "axi_125", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AXI_125_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_AHB0_PREOSC, "ahb0_preosc", 15,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_AHB0, "ahb0", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_AHB0_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_APB_BUS_FUNC, "apb_bus_func", 30,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS, "apb_bus", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER0, "apb_bus_per0", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER1, "apb_bus_per1", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER2, "apb_bus_per2", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER3, "apb_bus_per3", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER4, "apb_bus_per4", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER5, "apb_bus_per5", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER6, "apb_bus_per6", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER7, "apb_bus_per7", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER8, "apb_bus_per8", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER9, "apb_bus_per9", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_APB_BUS_PER10, "apb_bus_per10", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__MUX(JH8100_SYSCLK_SPI_CORE_100, "spi_core_100", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_APB_BUS_FUNC),
+	STARFIVE__DIV(JH8100_SYSCLK_PLL1_DIV2, "pll1_div2", 2,
+		      JH8100_SYSCLK_PLL1_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_PLL2_DIV2, "pll2_div2", 2,
+		      JH8100_SYSCLK_PLL2_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_PLL3_DIV2, "pll3_div2", 2,
+		      JH8100_SYSCLK_PLL3_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_PLL4_DIV2, "pll4_div2", 2,
+		      JH8100_SYSCLK_PLL4_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_PLL6_DIV2, "pll6_div2", 2,
+		      JH8100_SYSCLK_PLL6_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_PLL7_DIV2, "pll7_div2", 2,
+		      JH8100_SYSCLK_PLL7_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_AUDIO_ROOT, "audio_root", 8,
+		      JH8100_SYSCLK_PLL2_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_MCLK_INNER, "mclk_inner", 64,
+		      JH8100_SYSCLK_AUDIO_ROOT),
+	STARFIVE__MUX(JH8100_SYSCLK_MCLK, "mclk", 2,
+		      JH8100_SYSCLK_MCLK_INNER, JH8100_SYSCLK_MCLK_EXT),
+	STARFIVE_GATE(JH8100_SYSCLK_MCLK_OUT, "mclk_out", 0,
+		      JH8100_SYSCLK_MCLK_INNER),
+	STARFIVE_MDIV(JH8100_SYSCLK_ISP_2X_PREOSC, "isp_2x_preosc", 8, 2,
+		      JH8100_SYSCLK_PLL7_OUT, JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_ISP_2X, "isp_2x", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_ISP_2X_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_ISP_AXI, "isp_axi", 4,
+		      JH8100_SYSCLK_ISP_2X),
+	STARFIVE_GDIV(JH8100_SYSCLK_GCLK1, "gclk1", CLK_IS_CRITICAL, 120,
+		      JH8100_SYSCLK_PLL1_DIV2),
+	STARFIVE_GDIV(JH8100_SYSCLK_GCLK2, "gclk2", CLK_IS_CRITICAL, 120,
+		      JH8100_SYSCLK_PLL2_DIV2),
+	STARFIVE_GDIV(JH8100_SYSCLK_GCLK3, "gclk3", CLK_IS_CRITICAL, 120,
+		      JH8100_SYSCLK_PLL3_DIV2),
+	STARFIVE_GDIV(JH8100_SYSCLK_GCLK4, "gclk4", CLK_IS_CRITICAL, 120,
+		      JH8100_SYSCLK_PLL4_DIV2),
+	STARFIVE_GDIV(JH8100_SYSCLK_GCLK6, "gclk6", CLK_IS_CRITICAL, 120,
+		      JH8100_SYSCLK_PLL6_DIV2),
+	STARFIVE_GDIV(JH8100_SYSCLK_GCLK7, "gclk7", CLK_IS_CRITICAL, 120,
+		      JH8100_SYSCLK_PLL7_DIV2),
+	/* flexnoc (se) */
+	STARFIVE__DIV(JH8100_SYSCLK_FLEXNOC0_PREOSC, "flexnoc0_preosc", 8,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_FLEXNOC0, "flexnoc0", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_FLEXNOC0_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_FLEXNOC1_PREOSC, "flexnoc1_preosc", 8,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_FLEXNOC1, "flexnoc1", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_FLEXNOC1_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_FLEXNOC2_PREOSC, "flexnoc2_preosc", 12,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_FLEXNOC2, "flexnoc2", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_FLEXNOC2_PREOSC),
+	STARFIVE__MUX(JH8100_SYSCLK_VDEC_CORE, "vdec_core", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_FLEXNOC1_PREOSC),
+	/* img_gpu (se) */
+	STARFIVE_GATE(JH8100_SYSCLK_GPU_CORE_ICG, "gpu_core_icg", 0,
+		      JH8100_SYSCLK_GPU_CORE),
+	STARFIVE_GATE(JH8100_SYSCLK_IMG_GPU_CLK_APB, "img_gpu_clk_apb", 0,
+		      JH8100_SYSCLK_APB_BUS_PER7),
+	STARFIVE_GATE(JH8100_SYSCLK_IMG_GPU_RTC_TOGGLE, "img_gpu_rtc_toggle", 0=
,
+		      JH8100_SYSCLK_OSC),
+	STARFIVE_GATE(JH8100_SYSCLK_IMG_GPU_TIMER_USC, "img_gpu_timer_usc", 0,
+		      JH8100_SYSCLK_OSC),
+	/* hifi4 (se) */
+	STARFIVE__DIV(JH8100_SYSCLK_HIFI4_CORE_PREOSC, "hifi4_core_preosc", 15,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_HIFI4_CORE, "hifi4_core", 2,
+		      JH8100_SYSCLK_OSC, JH8100_SYSCLK_HIFI4_CORE_PREOSC),
+	STARFIVE__DIV(JH8100_SYSCLK_E_200_PREOSC, "e_200_preosc", 2,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__MUX(JH8100_SYSCLK_E_200, "e_200", 2, JH8100_SYSCLK_OSC,
+		      JH8100_SYSCLK_E_200_PREOSC),
+	/* hd audio */
+	STARFIVE__DIV(JH8100_SYSCLK_HD_AUDIO_48M, "hd_audio_48m", 80,
+		      JH8100_SYSCLK_PLL7_OUT),
+	/* dom vout */
+	STARFIVE__DIV(JH8100_SYSCLK_VOUT_DC_CORE, "vout_dc_core", 10,
+		      JH8100_SYSCLK_PLL7_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_VOUT_AXI, "vout_axi", 10,
+		      JH8100_SYSCLK_PLL7_OUT),
+	/* stg2_usb_wrap (se) */
+	STARFIVE__DIV(JH8100_SYSCLK_USB_WRAP_625, "usb_wrap_625", 6,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_USB_WRAP_480, "usb_wrap_480", 8,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_USB_WRAP_240, "usb_wrap_240", 2,
+		      JH8100_SYSCLK_USB_WRAP_480),
+	STARFIVE__DIV(JH8100_SYSCLK_USB_WRAP_60, "usb_wrap_60", 10,
+		      JH8100_SYSCLK_USB_WRAP_480),
+	STARFIVE__DIV(JH8100_SYSCLK_USB_WRAP_156P25, "usb_wrap_156p25", 4,
+		      JH8100_SYSCLK_USB_WRAP_625),
+	STARFIVE__DIV(JH8100_SYSCLK_USB_WRAP_312P5, "usb_wrap_312p5", 2,
+		      JH8100_SYSCLK_USB_WRAP_625),
+	/* stg */
+	STARFIVE__DIV(JH8100_SYSCLK_USB_125M, "usb_125m", 32,
+		      JH8100_SYSCLK_PLL0_OUT),
+	/* Flexnoc (se) */
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_APBOOTRAM, "flexnoc_apbootram", CLK=
_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_400_APBOOTRAM),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX1AMST, "flexnoc_pciex1amst", C=
LK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX1A),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX1ASLV, "flexnoc_pciex1aslv", C=
LK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX1A),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX1BMST, "flexnoc_pciex1bmst", C=
LK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX1B),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX1BSLV, "flexnoc_pciex1bslv", C=
LK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX1B),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX2MST, "flexnoc_pciex2mst", CLK=
_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX2),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX2SLV, "flexnoc_pciex2slv", CLK=
_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX2),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX8MST, "flexnoc_pciex8mst", CLK=
_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX8),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_PCIEX8SLV, "flexnoc_pciex8slv", CLK=
_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_500_PCIEX8),
+	STARFIVE_GATE(JH8100_SYSCLK_FLEXNOC_GMACSYSSLV, "flexnoc_gmacsysslv", C=
LK_IS_CRITICAL,
+		      JH8100_SYSCLK_AXI_200_GMAC),
+	/* gmac1 (se) */
+	STARFIVE__DIV(JH8100_SYSCLK_GMAC_SRC, "gmac_src", 7,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_GMAC1_GTXCLK_TOP, "gmac1_gtxclk_top", 400,
+		      JH8100_SYSCLK_PLL0_OUT),
+	STARFIVE__DIV(JH8100_SYSCLK_GMAC1_PTP, "gmac1_ptp", 31,
+		      JH8100_SYSCLK_GMAC_SRC),
+	/* hd audio */
+	STARFIVE_GATE(JH8100_SYSCLK_HD_AUDIO_SYSTEM_CLOCK, "hd_audio_system_clo=
ck", 0,
+		      JH8100_SYSCLK_APB_BUS_PER7),
+	STARFIVE_GATE(JH8100_SYSCLK_HD_AUDIO_CLOCK_48, "hd_audio_clock_48", 0,
+		      JH8100_SYSCLK_HD_AUDIO_48M),
+	STARFIVE_GATE(JH8100_SYSCLK_HD_AUDIO_BCLK_POST_OCC_IN, "hd_audio_bclk_p=
ost_occ_in", 0,
+		      JH8100_SYSCLK_HD_AUDIO_48M),
+	/* nne_vip (se) */
+	STARFIVE_GATE(JH8100_SYSCLK_NNE_VIP_ACLK, "nne_vip_aclk", 0, JH8100_SYS=
CLK_AXI_500),
+	STARFIVE_GATE(JH8100_SYSCLK_NNE_VIP_HCLK, "nne_vip_hclk", 0, JH8100_SYS=
CLK_AXI_200),
+	STARFIVE_GMUX(JH8100_SYSCLK_NNE_VIP_CLKCORE, "nne_vip_clkcore", 0, 2,
+		      JH8100_SYSCLK_PLL2_OUT, JH8100_SYSCLK_PLL0_OUT),
+	/* icg_en */
+	STARFIVE_GATE(JH8100_SYSCLK_GPU_ICG_EN, "gpu_en", 0, JH8100_SYSCLK_GPU_=
CORE),
+	STARFIVE_GATE(JH8100_SYSCLK_HD_AUDIO_ICG_EN, "hd_audio_en", 0, JH8100_S=
YSCLK_APB_BUS),
+	STARFIVE_GATE(JH8100_SYSCLK_NNE_ICG_EN, "nne_en", CLK_IGNORE_UNUSED,
+		      JH8100_SYSCLK_PLL2_OUT),
+};
+
+static struct clk_hw *jh8100_sysclk_get(struct of_phandle_args *clkspec,=
 void *data)
+{
+	struct starfive_clk_priv *priv =3D data;
+	unsigned int idx =3D clkspec->args[0];
+
+	if (idx < JH8100_SYSCLK_NUM_CLKS)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static void jh8100_reset_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev =3D _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void jh8100_reset_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
+	struct starfive_reset_adev *rdev =3D to_starfive_reset_adev(adev);
+
+	kfree(rdev);
+}
+
+int jh8100_reset_controller_register(struct starfive_clk_priv *priv,
+				     const char *adev_name,
+				     u32 adev_id)
+{
+	struct starfive_reset_adev *rdev;
+	struct auxiliary_device *adev;
+	int ret;
+
+	rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return -ENOMEM;
+
+	rdev->base =3D priv->base;
+
+	adev =3D &rdev->adev;
+	adev->name =3D adev_name;
+	adev->dev.parent =3D priv->dev;
+	adev->dev.release =3D jh8100_reset_adev_release;
+	adev->id =3D adev_id;
+
+	ret =3D auxiliary_device_init(adev);
+	if (ret)
+		return ret;
+
+	ret =3D auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(priv->dev,
+					jh8100_reset_unregister_adev, adev);
+}
+EXPORT_SYMBOL_GPL(jh8100_reset_controller_register);
+
+static int __init jh8100_syscrg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv =3D devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JH8100_SYSCLK_NUM_CLKS),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->dev =3D &pdev->dev;
+	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	for (idx =3D 0; idx < JH8100_SYSCLK_NUM_CLKS; idx++) {
+		u32 max =3D jh8100_syscrg_clk_data[idx].max;
+		struct clk_parent_data parents[4] =3D {};
+		struct clk_init_data init =3D {
+			.name =3D jh8100_syscrg_clk_data[idx].name,
+			.ops =3D starfive_clk_ops(max),
+			.parent_data =3D parents,
+			.num_parents =3D
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags =3D jh8100_syscrg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk =3D &priv->reg[idx];
+		unsigned int i;
+
+		for (i =3D 0; i < init.num_parents; i++) {
+			unsigned int pidx =3D jh8100_syscrg_clk_data[idx].parents[i];
+
+			if (pidx < JH8100_SYSCLK_NUM_CLKS)
+				parents[i].hw =3D &priv->reg[pidx].hw;
+			else if (pidx =3D=3D JH8100_SYSCLK_OSC)
+				parents[i].fw_name =3D "osc";
+			else if (pidx =3D=3D JH8100_SYSCLK_MCLK_EXT)
+				parents[i].fw_name =3D "mclk-ext";
+			else if (pidx =3D=3D JH8100_SYSCLK_PLL0_OUT)
+				parents[i].fw_name =3D "pll0";
+			else if (pidx =3D=3D JH8100_SYSCLK_PLL1_OUT)
+				parents[i].fw_name =3D "pll1";
+			else if (pidx =3D=3D JH8100_SYSCLK_PLL2_OUT)
+				parents[i].fw_name =3D "pll2";
+			else if (pidx =3D=3D JH8100_SYSCLK_PLL3_OUT)
+				parents[i].fw_name =3D "pll3";
+			else if (pidx =3D=3D JH8100_SYSCLK_PLL4_OUT)
+				parents[i].fw_name =3D "pll4";
+			else if (pidx =3D=3D JH8100_SYSCLK_PLL6_OUT)
+				parents[i].fw_name =3D "pll6";
+			else
+				parents[i].fw_name =3D "pll7";
+		}
+
+		clk->hw.init =3D &init;
+		clk->idx =3D idx;
+		clk->max_div =3D max & STARFIVE_CLK_DIV_MASK;
+
+		ret =3D devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			return ret;
+	}
+
+	ret =3D devm_of_clk_add_hw_provider(&pdev->dev, jh8100_sysclk_get, priv=
);
+	if (ret)
+		return ret;
+
+	return jh8100_reset_controller_register(priv, "rst-sys", 0);
+}
+
+static const struct of_device_id jh8100_syscrg_match[] =3D {
+	{ .compatible =3D "starfive,jh8100-syscrg" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jh8100_syscrg_driver =3D {
+	.driver =3D {
+		.name =3D "clk-starfive-jh8100-sys",
+		.of_match_table =3D jh8100_syscrg_match,
+		.suppress_bind_attrs =3D true,
+	},
+};
+builtin_platform_driver_probe(jh8100_syscrg_driver, jh8100_syscrg_probe)=
;
diff --git a/drivers/clk/starfive/clk-starfive-jh8100.h b/drivers/clk/sta=
rfive/clk-starfive-jh8100.h
new file mode 100644
index 000000000000..9b69a56fe5fc
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh8100.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CLK_STARFIVE_JH8100_H
+#define __CLK_STARFIVE_JH8100_H
+
+#include "clk-starfive-common.h"
+
+int jh8100_reset_controller_register(struct starfive_clk_priv *priv,
+				     const char *adev_name,
+				     u32 adev_id);
+
+#endif
--=20
2.34.1


