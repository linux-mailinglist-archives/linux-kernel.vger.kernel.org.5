Return-Path: <linux-kernel+bounces-11364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F6C81E52B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1B4282BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3310F4C3A9;
	Tue, 26 Dec 2023 05:40:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FE14D111;
	Tue, 26 Dec 2023 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 17B99804A;
	Tue, 26 Dec 2023 13:39:56 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 26 Dec
 2023 13:39:55 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 26 Dec 2023 13:39:50 +0800
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
Subject: [RFC 08/16] clk: starfive: Add JH8100 North-West clock generator driver
Date: Tue, 26 Dec 2023 13:38:40 +0800
Message-ID: <20231226053848.25089-9-jeeheng.sia@starfivetech.com>
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

Add support for JH8100 North-West (NWCRG) clock generator.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   7 +
 drivers/clk/starfive/Makefile                 |   1 +
 drivers/clk/starfive/clk-starfive-jh8100-nw.c | 237 ++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-nw.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 1dddf1415360..6a15c45473ff 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -82,3 +82,10 @@ config CLK_STARFIVE_JH8100_SYS
 	help
 	  Say yes here to support the System clock controller on the StarFive J=
H8100 SoC.
=20
+config CLK_STARFIVE_JH8100_NW
+	bool "StarFive JH8100 North-West clock support"
+	depends on CLK_STARFIVE_JH8100_SYS
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the North-West clock controller on the StarFi=
ve JH8100 SoC.
+
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefil=
e
index af6903c4f987..2ba07d3398f0 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+=3D clk-starfive=
-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+=3D clk-starfive-jh7110-vout.o
=20
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)	+=3D clk-starfive-jh8100-sys.o
+obj-$(CONFIG_CLK_STARFIVE_JH8100_NW)	+=3D clk-starfive-jh8100-nw.o
diff --git a/drivers/clk/starfive/clk-starfive-jh8100-nw.c b/drivers/clk/=
starfive/clk-starfive-jh8100-nw.c
new file mode 100644
index 000000000000..db97884245b7
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh8100-nw.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH8100 North-West Clock Driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/starfive,jh8100-crg.h>
+
+#include "clk-starfive-jh8100.h"
+
+#define JH8100_NWCLK_NUM_CLKS				(JH8100_NWCLK_UART6_ICG_EN + 1)
+
+/* external clocks */
+#define JH8100_NWCLK_OSC				(JH8100_NWCLK_NUM_CLKS + 0)
+#define JH8100_NWCLK_APB_BUS				(JH8100_NWCLK_NUM_CLKS + 1)
+#define JH8100_NWCLK_APB_BUS_PER4			(JH8100_NWCLK_NUM_CLKS + 2)
+#define JH8100_NWCLK_SPI_CORE_100			(JH8100_NWCLK_NUM_CLKS + 3)
+#define JH8100_NWCLK_ISP_2X				(JH8100_NWCLK_NUM_CLKS + 4)
+#define JH8100_NWCLK_ISP__AXI				(JH8100_NWCLK_NUM_CLKS + 5)
+#define JH8100_NWCLK_VOUT_ROOT0				(JH8100_NWCLK_NUM_CLKS + 6)
+#define JH8100_NWCLK_VOUT_ROOT1				(JH8100_NWCLK_NUM_CLKS + 7)
+#define JH8100_NWCLK_VOUT_SCAN__ATS			(JH8100_NWCLK_NUM_CLKS + 8)
+#define JH8100_NWCLK_VOUT_DC__CORE			(JH8100_NWCLK_NUM_CLKS + 9)
+#define JH8100_NWCLK_VOUT__AXI				(JH8100_NWCLK_NUM_CLKS + 10)
+#define JH8100_NWCLK_AXI_400				(JH8100_NWCLK_NUM_CLKS + 11)
+#define JH8100_NWCLK_DVP_EXT				(JH8100_NWCLK_NUM_CLKS + 12)
+#define JH8100_NWCLK_ISP_DPHY_TAP_TCK_EXT		(JH8100_NWCLK_NUM_CLKS + 13)
+#define JH8100_NWCLK_GLB_EXT				(JH8100_NWCLK_NUM_CLKS + 14)
+#define JH8100_NWCLK_VOUT_MIPI_DPHY_TAP_TCK_EXT		(JH8100_NWCLK_NUM_CLKS =
+ 15)
+#define JH8100_NWCLK_VOUT_EDP_TAP_TCK_EXT		(JH8100_NWCLK_NUM_CLKS + 16)
+#define JH8100_NWCLK_SPI_IN2_EXT			(JH8100_NWCLK_NUM_CLKS + 17)
+#define JH8100_NWCLK_PERH_ROOT_PREOSC			(JH8100_NWCLK_NUM_CLKS + 18)
+#define JH8100_NWCLK_AHB_VOUT				(JH8100_NWCLK_NUM_CLKS + 19)
+#define JH8100_NWCLK_PLL5_OUT				(JH8100_NWCLK_NUM_CLKS + 20)
+
+static const struct starfive_clk_data jh8100_nwcrg_clk_data[] =3D {
+	/* root */
+	STARFIVE__DIV(JH8100_NWCLK_PLL5_DIV2, "pll5_div2", 2, JH8100_NWCLK_PLL5=
_OUT),
+	STARFIVE_GDIV(JH8100_NWCLK_GCLK5, "gclk5", CLK_IS_CRITICAL, 120, JH8100=
_NWCLK_PLL5_DIV2),
+	/* gpio */
+	STARFIVE_GATE(JH8100_NWCLK_GPIO_100, "gpio_100", CLK_IS_CRITICAL, JH810=
0_NWCLK_PLL5_OUT),
+	STARFIVE_GATE(JH8100_NWCLK_GPIO_50, "gpio_50", CLK_IS_CRITICAL, JH8100_=
NWCLK_PLL5_OUT),
+	STARFIVE_GATE(JH8100_NWCLK_GPIO_150, "gpio_150", CLK_IS_CRITICAL, JH810=
0_NWCLK_PLL5_OUT),
+	STARFIVE_GDIV(JH8100_NWCLK_GPIO_60, "gpio_60", CLK_IS_CRITICAL, 30, JH8=
100_NWCLK_PLL5_OUT),
+	/* iomux */
+	STARFIVE_GATE(JH8100_NWCLK_IOMUX_WEST_PCLK, "iomux_west_pclk", 0,
+		      JH8100_NWCLK_APB_BUS_PER4),
+	/* i2c */
+	STARFIVE_GATE(JH8100_NWCLK_I2C6_APB, "i2c6_apb", 0, JH8100_NWCLK_APB_BU=
S_PER4),
+	STARFIVE_GATE(JH8100_NWCLK_I2C7_APB, "i2c7_apb", 0, JH8100_NWCLK_APB_BU=
S_PER4),
+	/* spi */
+	STARFIVE_GATE(JH8100_NWCLK_SPI2_APB, "spi2_apb", 0, JH8100_NWCLK_APB_BU=
S_PER4),
+	STARFIVE_GATE(JH8100_NWCLK_SPI2_CORE, "spi2_core", 0, JH8100_NWCLK_SPI_=
CORE_100),
+	STARFIVE__MUX(JH8100_NWCLK_SPI2_SCLK_IN, "spi2_sclk_in", 2,
+		      JH8100_NWCLK_SPI_IN2_EXT, JH8100_NWCLK_GPIO_100),
+	/* smbus */
+	STARFIVE_GATE(JH8100_NWCLK_SMBUS1_APB, "smbus1_apb", CLK_IGNORE_UNUSED,
+		      JH8100_NWCLK_APB_BUS_PER4),
+	STARFIVE_GDIV(JH8100_NWCLK_SMBUS1_CORE, "smbus1_core", CLK_IGNORE_UNUSE=
D, 120,
+		      JH8100_NWCLK_PERH_ROOT_PREOSC),
+	/* isp */
+	STARFIVE__MUX(JH8100_NWCLK_ISP_DVP, "isp_dvp", 2, JH8100_NWCLK_DVP_EXT,
+		      JH8100_NWCLK_GPIO_150),
+	STARFIVE_GATE(JH8100_NWCLK_ISP_CORE_2X, "isp_core_2x", 0, JH8100_NWCLK_=
ISP_2X),
+	STARFIVE_GATE(JH8100_NWCLK_ISP_AXI, "isp_axi_nw", 0, JH8100_NWCLK_ISP__=
AXI),
+	STARFIVE__MUX(JH8100_NWCLK_ISP_DPHY_TAP_TCK, "isp_dphy_tap_tck", 2,
+		      JH8100_NWCLK_ISP_DPHY_TAP_TCK_EXT, JH8100_NWCLK_GLB_EXT),
+	STARFIVE_GATE(JH8100_NWCLK_FLEXNOC_ISPSLV, "flexnoc_ispslv", 0, JH8100_=
NWCLK_ISP__AXI),
+	/* vout */
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_PIX0, "vout_pix0", CLK_IGNORE_UNUSED,
+		      JH8100_NWCLK_VOUT_ROOT0),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_PIX1, "vout_pix1", CLK_IGNORE_UNUSED,
+		      JH8100_NWCLK_VOUT_ROOT1),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_SCAN_ATS, "vout_scan_ats_nw",
+		      CLK_IGNORE_UNUSED, JH8100_NWCLK_VOUT_SCAN__ATS),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_DC_CORE, "vout_dc_core_nw",
+		      CLK_IGNORE_UNUSED, JH8100_NWCLK_VOUT_DC__CORE),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_APB, "vout_apb", CLK_IGNORE_UNUSED, JH8=
100_NWCLK_APB_BUS),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_DSI, "vout_dsi", CLK_IGNORE_UNUSED, JH8=
100_NWCLK_AXI_400),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_AHB, "vout_ahb", CLK_IGNORE_UNUSED, JH8=
100_NWCLK_AHB_VOUT),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_AXI, "vout_axi_nw", CLK_IGNORE_UNUSED,
+		      JH8100_NWCLK_VOUT__AXI),
+	STARFIVE__MUX(JH8100_NWCLK_VOUT_MIPI_DPHY_TAP_TCK, "vout_mipi_dphy_tap_=
tck", 2,
+		      JH8100_NWCLK_VOUT_MIPI_DPHY_TAP_TCK_EXT, JH8100_NWCLK_GLB_EXT),
+	STARFIVE__MUX(JH8100_NWCLK_VOUT_EDP_PHY_TAP_TCK, "vout_edp_phy_tap_tck"=
, 2,
+		      JH8100_NWCLK_VOUT_EDP_TAP_TCK_EXT, JH8100_NWCLK_GLB_EXT),
+	/* uart */
+	STARFIVE__DIV(JH8100_NWCLK_UART5_CORE_PREOSC, "uart5_core_preosc", 1310=
71,
+		      JH8100_NWCLK_PERH_ROOT_PREOSC),
+	STARFIVE_GATE(JH8100_NWCLK_UART5_APB, "uart5_apb", 0, JH8100_NWCLK_APB_=
BUS_PER4),
+	STARFIVE_GMUX(JH8100_NWCLK_UART5_CORE, "uart5_core", 0, 2,
+		      JH8100_NWCLK_OSC, JH8100_NWCLK_UART5_CORE_PREOSC),
+	STARFIVE__DIV(JH8100_NWCLK_UART6_CORE_PREOSC, "uart6_core_preosc", 1310=
71,
+		      JH8100_NWCLK_PERH_ROOT_PREOSC),
+	STARFIVE_GATE(JH8100_NWCLK_UART6_APB, "uart6_apb", 0, JH8100_NWCLK_APB_=
BUS_PER4),
+	STARFIVE_GMUX(JH8100_NWCLK_UART6_CORE, "uart6_core", 0, 2,
+		      JH8100_NWCLK_OSC, JH8100_NWCLK_UART6_CORE_PREOSC),
+	/* icg_en */
+	STARFIVE_GATE(JH8100_NWCLK_SPI2_ICG_EN, "spi2_en", 0, JH8100_NWCLK_APB_=
BUS_PER4),
+	STARFIVE_GATE(JH8100_NWCLK_SMBUS1_ICG_EN, "smbus1_en", 0, JH8100_NWCLK_=
APB_BUS_PER4),
+	STARFIVE_GATE(JH8100_NWCLK_ISP_ICG_EN, "isp_en", 0, JH8100_NWCLK_ISP__A=
XI),
+	STARFIVE_GATE(JH8100_NWCLK_VOUT_ICG_EN, "vout_en", 0, JH8100_NWCLK_VOUT=
_ROOT0),
+	STARFIVE_GATE(JH8100_NWCLK_UART5_ICG_EN, "uart5_en", 0, JH8100_NWCLK_AP=
B_BUS_PER4),
+	STARFIVE_GATE(JH8100_NWCLK_UART6_ICG_EN, "uart6_en", 0, JH8100_NWCLK_AP=
B_BUS_PER4),
+};
+
+struct clk_hw *jh8100_nwcrg_clk_get(struct of_phandle_args *clkspec, voi=
d *data)
+{
+	struct starfive_clk_priv *priv =3D data;
+	unsigned int idx =3D clkspec->args[0];
+
+	if (idx < JH8100_NWCLK_NUM_CLKS)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int jh8100_nwcrg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv =3D devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JH8100_NWCLK_NUM_CLKS),
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
+	for (idx =3D 0; idx < JH8100_NWCLK_NUM_CLKS; idx++) {
+		u32 max =3D jh8100_nwcrg_clk_data[idx].max;
+		struct clk_parent_data parents[4] =3D {};
+		struct clk_init_data init =3D {
+			.name =3D jh8100_nwcrg_clk_data[idx].name,
+			.ops =3D starfive_clk_ops(max),
+			.parent_data =3D parents,
+			.num_parents =3D
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags =3D jh8100_nwcrg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk =3D &priv->reg[idx];
+		unsigned int i;
+
+		for (i =3D 0; i < init.num_parents; i++) {
+			unsigned int pidx =3D jh8100_nwcrg_clk_data[idx].parents[i];
+
+			if (pidx < JH8100_NWCLK_NUM_CLKS)
+				parents[i].hw =3D &priv->reg[pidx].hw;
+			else if (pidx =3D=3D JH8100_NWCLK_OSC)
+				parents[i].fw_name =3D "osc";
+			else if (pidx =3D=3D JH8100_NWCLK_APB_BUS)
+				parents[i].fw_name =3D "apb_bus";
+			else if (pidx =3D=3D JH8100_NWCLK_APB_BUS_PER4)
+				parents[i].fw_name =3D "apb_bus_per4";
+			else if (pidx =3D=3D JH8100_NWCLK_SPI_CORE_100)
+				parents[i].fw_name =3D "spi_core_100";
+			else if (pidx =3D=3D JH8100_NWCLK_ISP_2X)
+				parents[i].fw_name =3D "isp_2x";
+			else if (pidx =3D=3D JH8100_NWCLK_ISP__AXI)
+				parents[i].fw_name =3D "isp_axi";
+			else if (pidx =3D=3D JH8100_NWCLK_VOUT_ROOT0)
+				parents[i].fw_name =3D "vout_root0";
+			else if (pidx =3D=3D JH8100_NWCLK_VOUT_ROOT1)
+				parents[i].fw_name =3D "vout_root1";
+			else if (pidx =3D=3D JH8100_NWCLK_VOUT_SCAN__ATS)
+				parents[i].fw_name =3D "vout_scan_ats";
+			else if (pidx =3D=3D JH8100_NWCLK_VOUT_DC__CORE)
+				parents[i].fw_name =3D "vout_dc_core";
+			else if (pidx =3D=3D JH8100_NWCLK_VOUT__AXI)
+				parents[i].fw_name =3D "vout_axi";
+			else if (pidx =3D=3D JH8100_NWCLK_AXI_400)
+				parents[i].fw_name =3D "axi_400";
+			else if (pidx =3D=3D JH8100_NWCLK_DVP_EXT)
+				parents[i].fw_name =3D "dvp-ext";
+			else if (pidx =3D=3D JH8100_NWCLK_ISP_DPHY_TAP_TCK_EXT)
+				parents[i].fw_name =3D "isp-dphy-tap-tck-ext";
+			else if (pidx =3D=3D JH8100_NWCLK_GLB_EXT)
+				parents[i].fw_name =3D "glb-ext-clk";
+			else if (pidx =3D=3D JH8100_NWCLK_VOUT_MIPI_DPHY_TAP_TCK_EXT)
+				parents[i].fw_name =3D "vout-mipi-dphy-tap-tck-ext";
+			else if (pidx =3D=3D JH8100_NWCLK_VOUT_EDP_TAP_TCK_EXT)
+				parents[i].fw_name =3D "vout-edp-tap-tck-ext";
+			else if (pidx =3D=3D JH8100_NWCLK_SPI_IN2_EXT)
+				parents[i].fw_name =3D "spi-in2-ext";
+			else if (pidx =3D=3D JH8100_NWCLK_PERH_ROOT_PREOSC)
+				parents[i].fw_name =3D "perh_root_preosc";
+			else if (pidx =3D=3D JH8100_NWCLK_AHB_VOUT)
+				parents[i].fw_name =3D "ahb0";
+			else
+				parents[i].fw_name =3D "pll5";
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
+	ret =3D devm_of_clk_add_hw_provider(&pdev->dev, jh8100_nwcrg_clk_get, p=
riv);
+	if (ret)
+		return ret;
+
+	return jh8100_reset_controller_register(priv, "rst-nw", 1);
+}
+
+static const struct of_device_id jh8100_nwcrg_match[] =3D {
+	{ .compatible =3D "starfive,jh8100-nwcrg" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jh8100_nwcrg_driver =3D {
+	.driver =3D {
+		.name =3D "clk-starfive-jh8100-nw",
+		.of_match_table =3D jh8100_nwcrg_match,
+		.suppress_bind_attrs =3D true,
+	},
+};
+builtin_platform_driver_probe(jh8100_nwcrg_driver, jh8100_nwcrg_probe);
--=20
2.34.1


