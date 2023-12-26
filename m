Return-Path: <linux-kernel+bounces-11366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784A381E531
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F83E282D92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254894D5AD;
	Tue, 26 Dec 2023 05:40:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DCA4D586;
	Tue, 26 Dec 2023 05:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 57E0A24E29B;
	Tue, 26 Dec 2023 13:40:09 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 26 Dec
 2023 13:40:09 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 26 Dec 2023 13:40:03 +0800
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
Subject: [RFC 10/16] clk: starfive: Add JH8100 North-East clock generator driver
Date: Tue, 26 Dec 2023 13:38:42 +0800
Message-ID: <20231226053848.25089-11-jeeheng.sia@starfivetech.com>
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

Add support for JH8100 North-East (NECRG) clock generator.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   6 +
 drivers/clk/starfive/Makefile                 |   1 +
 drivers/clk/starfive/clk-starfive-common.h    |   7 +
 drivers/clk/starfive/clk-starfive-jh8100-ne.c | 499 ++++++++++++++++++
 4 files changed, 513 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-ne.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 6a15c45473ff..23968e97969b 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -89,3 +89,9 @@ config CLK_STARFIVE_JH8100_NW
 	help
 	  Say yes here to support the North-West clock controller on the StarFi=
ve JH8100 SoC.
=20
+config CLK_STARFIVE_JH8100_NE
+	bool "StarFive JH8100 North-East clock support"
+	depends on CLK_STARFIVE_JH8100_SYS
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the North-East clock controller on the StarFi=
ve JH8100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefil=
e
index 2ba07d3398f0..cecce3655600 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+=3D clk-starfiv=
e-jh7110-vout.o
=20
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)	+=3D clk-starfive-jh8100-sys.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_NW)	+=3D clk-starfive-jh8100-nw.o
+obj-$(CONFIG_CLK_STARFIVE_JH8100_NE)	+=3D clk-starfive-jh8100-ne.o
diff --git a/drivers/clk/starfive/clk-starfive-common.h b/drivers/clk/sta=
rfive/clk-starfive-common.h
index fed45311360c..23c8236873a4 100644
--- a/drivers/clk/starfive/clk-starfive-common.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -103,6 +103,13 @@ struct starfive_clk_data {
 	.parents =3D { [0] =3D _parent },						\
 }
=20
+#define STARFIVE_GINV(_idx, _name, _flags, _parent)[_idx] =3D {			\
+	.name =3D _name,								\
+	.flags =3D _flags,							\
+	.max =3D STARFIVE_CLK_ENABLE | STARFIVE_CLK_INVERT,			\
+	.parents =3D { [0] =3D _parent },						\
+}
+
 struct starfive_clk {
 	struct clk_hw hw;
 	unsigned int idx;
diff --git a/drivers/clk/starfive/clk-starfive-jh8100-ne.c b/drivers/clk/=
starfive/clk-starfive-jh8100-ne.c
new file mode 100644
index 000000000000..84b2b4411b0c
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh8100-ne.c
@@ -0,0 +1,499 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH8100 North-East Clock Driver
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
+#define JH8100_NECLK_NUM_CLKS		(JH8100_NECLK_SMBUS0_ICG_EN + 1)
+
+/* external clocks */
+#define JH8100_NECLK_OSC		(JH8100_NECLK_NUM_CLKS + 0)
+#define JH8100_NECLK_APB_BUS		(JH8100_NECLK_NUM_CLKS + 1)
+#define JH8100_NECLK_AXI_400		(JH8100_NECLK_NUM_CLKS + 2)
+#define JH8100_NECLK_VOUT_ROOT0		(JH8100_NECLK_NUM_CLKS + 3)
+#define JH8100_NECLK_VOUT_ROOT1		(JH8100_NECLK_NUM_CLKS + 4)
+#define JH8100_NECLK_USB_WRAP_480	(JH8100_NECLK_NUM_CLKS + 5)
+#define JH8100_NECLK_USB_WRAP_625	(JH8100_NECLK_NUM_CLKS + 6)
+#define JH8100_NECLK_USB_WRAP_240	(JH8100_NECLK_NUM_CLKS + 7)
+#define JH8100_NECLK_USB_WRAP_60	(JH8100_NECLK_NUM_CLKS + 8)
+#define JH8100_NECLK_USB_WRAP_156P25	(JH8100_NECLK_NUM_CLKS + 9)
+#define JH8100_NECLK_USB_WRAP_312P5	(JH8100_NECLK_NUM_CLKS + 10)
+#define JH8100_NECLK_USB_125M		(JH8100_NECLK_NUM_CLKS + 11)
+#define JH8100_NECLK_GPIO_100		(JH8100_NECLK_NUM_CLKS + 12)
+#define JH8100_NECLK_PERH_ROOT		(JH8100_NECLK_NUM_CLKS + 13)
+#define JH8100_NECLK_MCLK		(JH8100_NECLK_NUM_CLKS + 14)
+#define JH8100_NECLK_USB3_TAP_TCK_EXT	(JH8100_NECLK_NUM_CLKS + 15)
+#define JH8100_NECLK_GLB_EXT		(JH8100_NECLK_NUM_CLKS + 16)
+#define JH8100_NECLK_USB1_TAP_TCK_EXT	(JH8100_NECLK_NUM_CLKS + 17)
+#define JH8100_NECLK_USB2_TAP_TCK_EXT	(JH8100_NECLK_NUM_CLKS + 18)
+#define JH8100_NECLK_TYPEC_TAP_TCK_EXT	(JH8100_NECLK_NUM_CLKS + 19)
+#define JH8100_NECLK_SPI_IN0_EXT	(JH8100_NECLK_NUM_CLKS + 20)
+#define JH8100_NECLK_SPI_IN1_EXT	(JH8100_NECLK_NUM_CLKS + 21)
+#define JH8100_NECLK_I2STX_BCLK_EXT	(JH8100_NECLK_NUM_CLKS + 22)
+#define JH8100_NECLK_I2STX_LRCK_EXT	(JH8100_NECLK_NUM_CLKS + 23)
+#define JH8100_NECLK_PERH_ROOT_PREOSC	(JH8100_NECLK_NUM_CLKS + 24)
+#define JH8100_NECLK_AHB_DMA		(JH8100_NECLK_NUM_CLKS + 25)
+#define JH8100_NECLK_APB_BUS_PER1	(JH8100_NECLK_NUM_CLKS + 26)
+#define JH8100_NECLK_APB_BUS_PER2	(JH8100_NECLK_NUM_CLKS + 27)
+#define JH8100_NECLK_APB_BUS_PER3	(JH8100_NECLK_NUM_CLKS + 28)
+#define JH8100_NECLK_APB_BUS_PER5	(JH8100_NECLK_NUM_CLKS + 29)
+#define JH8100_NECLK_VENC_ROOT		(JH8100_NECLK_NUM_CLKS + 30)
+#define JH8100_NECLK_SPI_CORE_100	(JH8100_NECLK_NUM_CLKS + 31)
+
+static const struct starfive_clk_data jh8100_necrg_clk_data[] =3D {
+	/* flexnoc */
+	STARFIVE_GATE(JH8100_NECLK_FLEXNOC_DMASLV, "flexnoc_dmaslv", CLK_IS_CRI=
TICAL,
+		      JH8100_NECLK_AHB_DMA),
+	/* mailbox */
+	STARFIVE_GATE(JH8100_NECLK_MAILBOX_APB, "mailbox_apb", CLK_IS_CRITICAL,
+		      JH8100_NECLK_APB_BUS_PER1),
+	/* timer */
+	STARFIVE_GATE(JH8100_NECLK_SR5_TIMER0_APB, "timer0_apb", 0, JH8100_NECL=
K_APB_BUS_PER1),
+	STARFIVE_GATE(JH8100_NECLK_SR5_TIMER0_CH0, "timer0_ch0", 0, JH8100_NECL=
K_OSC),
+	STARFIVE_GATE(JH8100_NECLK_SR5_TIMER0_CH1, "timer0_ch1", 0, JH8100_NECL=
K_OSC),
+	STARFIVE_GATE(JH8100_NECLK_SR5_TIMER0_CH2, "timer0_ch2", 0, JH8100_NECL=
K_OSC),
+	STARFIVE_GATE(JH8100_NECLK_SR5_TIMER0_CH3, "timer0_ch3", 0, JH8100_NECL=
K_OSC),
+	STARFIVE_GATE(JH8100_NECLK_SR5_TIMER1_APB, "timer1_apb", 0, JH8100_NECL=
K_APB_BUS_PER1),
+	STARFIVE_GATE(JH8100_NECLK_SR5_TIMER1_CH0, "timer1_ch0", 0, JH8100_NECL=
K_OSC),
+	STARFIVE_GATE(JH8100_NECLK_SR5_TIMER1_CH1, "timer1_ch1", 0, JH8100_NECL=
K_OSC),
+	STARFIVE_GATE(JH8100_NECLK_SR5_TIMER1_CH2, "timer1_ch2", 0, JH8100_NECL=
K_OSC),
+	STARFIVE_GATE(JH8100_NECLK_SR5_TIMER1_CH3, "timer1_ch3", 0, JH8100_NECL=
K_OSC),
+	/* usb3 */
+	STARFIVE_GATE(JH8100_NECLK_USB3_CMN_SCAN_PLL, "usb3_scan_pll", CLK_IGNO=
RE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_USB3_CMN_SCAN_SER, "usb3_scan_ser", CLK_IGNO=
RE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_USB3_PIPE_IN_SCAN, "usb3_pipe_in_scan", CLK_=
IGNORE_UNUSED,
+		      JH8100_NECLK_USB_125M),
+	STARFIVE_GATE(JH8100_NECLK_USB3_SCAN_PIPE, "usb3_scan_pipe", CLK_IGNORE=
_UNUSED,
+		      JH8100_NECLK_USB_125M),
+	STARFIVE_GATE(JH8100_NECLK_USB3_SCAN_PSM, "usb3_scan_psm", CLK_IGNORE_U=
NUSED,
+		      JH8100_NECLK_USB_125M),
+	STARFIVE_GATE(JH8100_NECLK_USB3_SCAN_REF, "usb3_scan_ref", CLK_IGNORE_U=
NUSED,
+		      JH8100_NECLK_OSC),
+	STARFIVE_GATE(JH8100_NECLK_USB3_USB2_SCAN, "usb3_usb2_scan", CLK_IGNORE=
_UNUSED,
+		      JH8100_NECLK_APB_BUS_PER3),
+	STARFIVE_GATE(JH8100_NECLK_USB3_HSCLK, "usb3_hsclk", CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_480),
+	STARFIVE_GATE(JH8100_NECLK_USB3_HSSICLK, "usb3_hssiclk", CLK_IGNORE_UNU=
SED,
+		      JH8100_NECLK_USB_WRAP_240),
+	STARFIVE_GATE(JH8100_NECLK_USB3_SIECLK, "usb3_sieclk", CLK_IGNORE_UNUSE=
D,
+		      JH8100_NECLK_USB_WRAP_60),
+	STARFIVE_GATE(JH8100_NECLK_USB3_XCVR_SCAN_PLL, "usb3_xcvr_scan_pll", CL=
K_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_USB3_XCVR_SCAN_SER, "usb3_xcvr_scan_ser", CL=
K_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE__MUX(JH8100_NECLK_USB3_TAP_TCK, "usb3_tap_tck", 2,
+		      JH8100_NECLK_USB3_TAP_TCK_EXT, JH8100_NECLK_GLB_EXT),
+	/* usb1 */
+	STARFIVE_GATE(JH8100_NECLK_USB1_CMN_SCAN_PLL, "usb1_scan_pll", CLK_IGNO=
RE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_USB1_CMN_SCAN_SER, "usb1_scan_ser", CLK_IGNO=
RE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_USB1_PIPE_IN_SCAN, "usb1_pipe_in_scan", CLK_=
IGNORE_UNUSED,
+		      JH8100_NECLK_USB_125M),
+	STARFIVE_GATE(JH8100_NECLK_USB1_SCAN_PIPE, "usb1_scan_pipe", CLK_IGNORE=
_UNUSED,
+		      JH8100_NECLK_USB_125M),
+	STARFIVE_GATE(JH8100_NECLK_USB1_SCAN_PSM, "usb1_scan_psm", CLK_IGNORE_U=
NUSED,
+		      JH8100_NECLK_USB_125M),
+	STARFIVE_GATE(JH8100_NECLK_USB1_SCAN_REF, "usb1_scan_ref", CLK_IGNORE_U=
NUSED,
+		      JH8100_NECLK_OSC),
+	STARFIVE_GATE(JH8100_NECLK_USB1_USB2_SCAN, "usb1_usb2_scan", CLK_IGNORE=
_UNUSED,
+		      JH8100_NECLK_APB_BUS_PER3),
+	STARFIVE_GATE(JH8100_NECLK_USB1_HSCLK, "usb1_hsclk", CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_480),
+	STARFIVE_GATE(JH8100_NECLK_USB1_HSSICLK, "usb1_hssiclk", CLK_IGNORE_UNU=
SED,
+		      JH8100_NECLK_USB_WRAP_240),
+	STARFIVE_GATE(JH8100_NECLK_USB1_SIECLK, "usb1_sieclk", CLK_IGNORE_UNUSE=
D,
+		      JH8100_NECLK_USB_WRAP_60),
+	STARFIVE_GATE(JH8100_NECLK_USB1_XCVR_SCAN_PLL, "usb1_xcvr_scan_pll", CL=
K_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_USB1_XCVR_SCAN_SER, "usb1_xcvr_scan_ser", CL=
K_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE__MUX(JH8100_NECLK_USB1_TAP_TCK, "usb1_tap_tck", 2,
+		      JH8100_NECLK_USB1_TAP_TCK_EXT, JH8100_NECLK_GLB_EXT),
+	/* usb2 */
+	STARFIVE_GATE(JH8100_NECLK_USB2_CMN_SCAN_PLL, "usb2_scan_pll", CLK_IGNO=
RE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_USB2_CMN_SCAN_SER, "usb2_scan_ser", CLK_IGNO=
RE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_USB2_PIPE_IN_SCAN, "usb2_pipe_in_scan", CLK_=
IGNORE_UNUSED,
+		      JH8100_NECLK_USB_125M),
+	STARFIVE_GATE(JH8100_NECLK_USB2_SCAN_PIPE, "usb2_scan_pipe", CLK_IGNORE=
_UNUSED,
+		      JH8100_NECLK_USB_125M),
+	STARFIVE_GATE(JH8100_NECLK_USB2_SCAN_PSM, "usb2_scan_psm", CLK_IGNORE_U=
NUSED,
+		      JH8100_NECLK_USB_125M),
+	STARFIVE_GATE(JH8100_NECLK_USB2_SCAN_REF, "usb2_scan_ref", CLK_IGNORE_U=
NUSED,
+		      JH8100_NECLK_OSC),
+	STARFIVE_GATE(JH8100_NECLK_USB2_USB2_SCAN, "usb2_usb2_scan", CLK_IGNORE=
_UNUSED,
+		      JH8100_NECLK_APB_BUS_PER3),
+	STARFIVE_GATE(JH8100_NECLK_USB2_HSCLK, "usb2_hsclk", CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_480),
+	STARFIVE_GATE(JH8100_NECLK_USB2_HSSICLK, "usb2_hssiclk", CLK_IGNORE_UNU=
SED,
+		      JH8100_NECLK_USB_WRAP_240),
+	STARFIVE_GATE(JH8100_NECLK_USB2_SIECLK, "usb2_sieclk", CLK_IGNORE_UNUSE=
D,
+		      JH8100_NECLK_USB_WRAP_60),
+	STARFIVE_GATE(JH8100_NECLK_USB2_XCVR_SCAN_PLL, "usb2_xcvr_scan_pll", CL=
K_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_USB2_XCVR_SCAN_SER, "usb2_xcvr_scan_ser", CL=
K_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE__MUX(JH8100_NECLK_USB2_TAP_TCK, "usb2_tap_tck", 2, JH8100_NECL=
K_USB2_TAP_TCK_EXT,
+		      JH8100_NECLK_GLB_EXT),
+	/* usb typec */
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_PIPE_DIV_SCAN, "typec_pipe_div_scan", =
CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_156P25),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_CMN_SCAN_PLL, "typec_scan_pll", CLK_IG=
NORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_CMN_SCAN_SER, "typec_scan_ser", CLK_IG=
NORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_SCAN_PIPE, "typec_scan_pipe", CLK_IGNO=
RE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_312P5),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_SCAN_PSM, "typec_scan_psm", CLK_IGNORE=
_UNUSED,
+		      JH8100_NECLK_USB_125M),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_SCAN_REF, "typec_scan_ref", CLK_IGNORE=
_UNUSED,
+		      JH8100_NECLK_OSC),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_USB2_SCAN, "typec_usb2_scan", CLK_IGNO=
RE_UNUSED,
+		      JH8100_NECLK_APB_BUS_PER5),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_HSCLK, "typec_hsclk", CLK_IGNORE_UNUSE=
D,
+		      JH8100_NECLK_USB_WRAP_480),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_HSSICLK, "typec_hssiclk", CLK_IGNORE_U=
NUSED,
+		      JH8100_NECLK_USB_WRAP_240),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_SIECLK, "typec_sieclk", CLK_IGNORE_UNU=
SED,
+		      JH8100_NECLK_USB_WRAP_60),
+	STARFIVE_GMUX(JH8100_NECLK_TYPEC_VID0, "typec_vid0", CLK_IGNORE_UNUSED,=
 2,
+		      JH8100_NECLK_VOUT_ROOT0, JH8100_NECLK_VOUT_ROOT1),
+	STARFIVE_GMUX(JH8100_NECLK_TYPEC_VID1, "typec_vid1", CLK_IGNORE_UNUSED,=
 2,
+		      JH8100_NECLK_VOUT_ROOT0, JH8100_NECLK_VOUT_ROOT1),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_XCVR_SCAN_PLL0, "typec_xcvr_scan_pll0"=
, CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_XCVR_SCAN_PLL1, "typec_xcvr_scan_pll1"=
, CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_XCVR_SCAN_PLL2, "typec_xcvr_scan_pll2"=
, CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_XCVR_SCAN_PLL3, "typec_xcvr_scan_pll3"=
, CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_XCVR_SCAN_SER0, "typec_xcvr_scan_ser0"=
, CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_XCVR_SCAN_SER1, "typec_xcvr_scan_ser1"=
, CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_XCVR_SCAN_SER2, "typec_xcvr_scan_ser2"=
, CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_TYPEC_XCVR_SCAN_SER3, "typec_xcvr_scan_ser3"=
, CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_USB_WRAP_625),
+	STARFIVE__MUX(JH8100_NECLK_TYPEC_TAP_TCK, "typec_tap_tck", 2,
+		      JH8100_NECLK_TYPEC_TAP_TCK_EXT, JH8100_NECLK_GLB_EXT),
+	/* video enc */
+	STARFIVE__DIV(JH8100_NECLK_VENC_AXI, "venc_axi", 20, JH8100_NECLK_VENC_=
ROOT),
+	STARFIVE_GATE(JH8100_NECLK_VC9000LE_AXI, "vc9000le_axi", CLK_IGNORE_UNU=
SED,
+		      JH8100_NECLK_VENC_AXI),
+	STARFIVE_GATE(JH8100_NECLK_VC9000LE_APB, "vc9000le_apb", CLK_IGNORE_UNU=
SED,
+		      JH8100_NECLK_APB_BUS_PER5),
+	STARFIVE_GDIV(JH8100_NECLK_VC9000LE_CORECLK, "vc9000le_coreclk", 0, 40,
+		      JH8100_NECLK_VENC_ROOT),
+	/* intc */
+	STARFIVE_GATE(JH8100_NECLK_INT_CTRL_APB, "int_ctrl_apb", 0, JH8100_NECL=
K_APB_BUS_PER2),
+	/* pwm */
+	STARFIVE_GATE(JH8100_NECLK_PWM_8CH_APB, "pwm_8ch_apb", 0, JH8100_NECLK_=
APB_BUS_PER2),
+	/* wdt */
+	STARFIVE_GATE(JH8100_NECLK_WDT_APB, "wdt_apb", CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_APB_BUS_PER2),
+	STARFIVE_GATE(JH8100_NECLK_WDT, "wdt", CLK_IGNORE_UNUSED, JH8100_NECLK_=
OSC),
+	/* SPI */
+	STARFIVE_GATE(JH8100_NECLK_SPI0_APB, "spi0_apb", 0, JH8100_NECLK_APB_BU=
S_PER2),
+	STARFIVE_GATE(JH8100_NECLK_SPI0_CORE, "spi0_core", 0, JH8100_NECLK_SPI_=
CORE_100),
+	STARFIVE__MUX(JH8100_NECLK_SPI0_SCLK_IN, "spi0_sclk_in", 2, JH8100_NECL=
K_SPI_IN0_EXT,
+		      JH8100_NECLK_GPIO_100),
+	STARFIVE_GATE(JH8100_NECLK_SPI1_APB, "spi1_apb", 0, JH8100_NECLK_APB_BU=
S_PER2),
+	STARFIVE_GATE(JH8100_NECLK_SPI1_CORE, "spi1_core", 0, JH8100_NECLK_SPI_=
CORE_100),
+	STARFIVE__MUX(JH8100_NECLK_SPI1_SCLK_IN, "spi1_sclk_in", 2, JH8100_NECL=
K_SPI_IN1_EXT,
+		      JH8100_NECLK_GPIO_100),
+	/* i2c */
+	STARFIVE_GATE(JH8100_NECLK_I2C0_APB, "i2c0_apb", 0, JH8100_NECLK_APB_BU=
S_PER1),
+	STARFIVE_GATE(JH8100_NECLK_I2C1_APB, "i2c1_apb", 0, JH8100_NECLK_APB_BU=
S_PER1),
+	STARFIVE_GATE(JH8100_NECLK_I2C2_APB, "i2c2_apb", 0, JH8100_NECLK_APB_BU=
S_PER1),
+	STARFIVE_GATE(JH8100_NECLK_I2C3_APB, "i2c3_apb", 0, JH8100_NECLK_APB_BU=
S_PER1),
+	STARFIVE_GATE(JH8100_NECLK_I2C4_APB, "i2c4_apb", 0, JH8100_NECLK_APB_BU=
S_PER1),
+	STARFIVE_GATE(JH8100_NECLK_I2C5_APB, "i2c5_apb", 0, JH8100_NECLK_APB_BU=
S_PER1),
+	/* uart */
+	STARFIVE_GATE(JH8100_NECLK_UART0_APB, "uart0_apb", 0, JH8100_NECLK_APB_=
BUS_PER1),
+	STARFIVE_GATE(JH8100_NECLK_UART0_CORE, "uart0_core", 0, JH8100_NECLK_OS=
C),
+	STARFIVE__DIV(JH8100_NECLK_UART1_CORE_PREOSC, "uart1_core_preosc", 1310=
71,
+		      JH8100_NECLK_PERH_ROOT_PREOSC),
+	STARFIVE_GATE(JH8100_NECLK_UART1_APB, "uart1_apb", 0, JH8100_NECLK_APB_=
BUS_PER1),
+	STARFIVE_GMUX(JH8100_NECLK_UART1_CORE, "uart1_core", 0, 2, JH8100_NECLK=
_OSC,
+		      JH8100_NECLK_UART1_CORE_PREOSC),
+	STARFIVE__DIV(JH8100_NECLK_UART2_CORE_PREOSC, "uart2_core_preosc", 1310=
71,
+		      JH8100_NECLK_PERH_ROOT_PREOSC),
+	STARFIVE_GATE(JH8100_NECLK_UART2_APB, "uart2_apb", 0, JH8100_NECLK_APB_=
BUS_PER1),
+	STARFIVE_GMUX(JH8100_NECLK_UART2_CORE, "uart2_core", 0, 2, JH8100_NECLK=
_OSC,
+		      JH8100_NECLK_UART2_CORE_PREOSC),
+	STARFIVE__DIV(JH8100_NECLK_UART3_CORE_PREOSC, "uart3_core_preosc", 1310=
71,
+		      JH8100_NECLK_PERH_ROOT_PREOSC),
+	STARFIVE_GATE(JH8100_NECLK_UART3_APB, "uart3_apb", 0, JH8100_NECLK_APB_=
BUS_PER1),
+	STARFIVE_GMUX(JH8100_NECLK_UART3_CORE, "uart3_core", 0, 2, JH8100_NECLK=
_OSC,
+		      JH8100_NECLK_UART3_CORE_PREOSC),
+	STARFIVE__DIV(JH8100_NECLK_UART4_CORE_PREOSC, "uart4_core_preosc", 1310=
71,
+		      JH8100_NECLK_PERH_ROOT_PREOSC),
+	STARFIVE_GATE(JH8100_NECLK_UART4_APB, "uart4_apb", 0, JH8100_NECLK_APB_=
BUS_PER1),
+	STARFIVE_GMUX(JH8100_NECLK_UART4_CORE, "uart4_core", 0, 2, JH8100_NECLK=
_OSC,
+		      JH8100_NECLK_UART4_CORE_PREOSC),
+	/* i2s */
+	STARFIVE__DIV(JH8100_NECLK_I2S0_BCLK, "i2s0_bclk", 32, JH8100_NECLK_MCL=
K),
+	STARFIVE__DIV(JH8100_NECLK_I2S0_LRCK, "i2s0_lrck", 128, JH8100_NECLK_I2=
S0_BCLK),
+	STARFIVE_GATE(JH8100_NECLK_I2S0_APB, "i2s0_apb", CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_APB_BUS_PER2),
+	STARFIVE_GATE(JH8100_NECLK_I2S0, "i2s0", CLK_IGNORE_UNUSED, JH8100_NECL=
K_MCLK),
+	STARFIVE_GINV(JH8100_NECLK_I2S0_N, "i2s0_n", CLK_IGNORE_UNUSED, JH8100_=
NECLK_MCLK),
+	STARFIVE__MUX(JH8100_NECLK_I2S0_BCLK_TX, "i2s0_bclk_tx", 2, JH8100_NECL=
K_I2S0_BCLK,
+		      JH8100_NECLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(JH8100_NECLK_I2S0_LRCK_TX, "i2s0_lrck_tx", 2, JH8100_NECL=
K_I2S0_LRCK,
+		      JH8100_NECLK_I2STX_LRCK_EXT),
+	STARFIVE__MUX(JH8100_NECLK_I2S0_BCLK_RX, "i2s0_bclk_rx", 2, JH8100_NECL=
K_I2S0_BCLK,
+		      JH8100_NECLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(JH8100_NECLK_I2S0_LRCK_RX, "i2s0_lrck_rx", 2, JH8100_NECL=
K_I2S0_LRCK,
+		      JH8100_NECLK_I2STX_LRCK_EXT),
+	STARFIVE__DIV(JH8100_NECLK_I2S1_BCLK, "i2s1_bclk", 32, JH8100_NECLK_MCL=
K),
+	STARFIVE__DIV(JH8100_NECLK_I2S1_LRCK, "i2s1_lrck", 128, JH8100_NECLK_I2=
S1_BCLK),
+	STARFIVE_GATE(JH8100_NECLK_I2S1_APB, "i2s1_apb", CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_APB_BUS_PER2),
+	STARFIVE_GATE(JH8100_NECLK_I2S1, "i2s1", CLK_IGNORE_UNUSED, JH8100_NECL=
K_MCLK),
+	STARFIVE_GINV(JH8100_NECLK_I2S1_N, "i2s1_n", CLK_IGNORE_UNUSED, JH8100_=
NECLK_MCLK),
+	STARFIVE__MUX(JH8100_NECLK_I2S1_BCLK_TX, "i2s1_bclk_tx", 2, JH8100_NECL=
K_I2S1_BCLK,
+		      JH8100_NECLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(JH8100_NECLK_I2S1_LRCK_TX, "i2s1_lrck_tx", 2, JH8100_NECL=
K_I2S1_LRCK,
+		      JH8100_NECLK_I2STX_LRCK_EXT),
+	STARFIVE__MUX(JH8100_NECLK_I2S1_BCLK_RX, "i2s1_bclk_rx", 2, JH8100_NECL=
K_I2S1_BCLK,
+		      JH8100_NECLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(JH8100_NECLK_I2S1_LRCK_RX, "i2s1_lrck_rx", 2, JH8100_NECL=
K_I2S1_LRCK,
+		      JH8100_NECLK_I2STX_LRCK_EXT),
+	STARFIVE__DIV(JH8100_NECLK_I2S2_BCLK, "i2s2_bclk", 32, JH8100_NECLK_MCL=
K),
+	STARFIVE__DIV(JH8100_NECLK_I2S2_LRCK, "i2s2_lrck", 128, JH8100_NECLK_I2=
S2_BCLK),
+	STARFIVE_GATE(JH8100_NECLK_I2S2_APB, "i2s2_apb", CLK_IGNORE_UNUSED,
+		      JH8100_NECLK_APB_BUS_PER2),
+	STARFIVE_GATE(JH8100_NECLK_I2S2, "i2s2", CLK_IGNORE_UNUSED, JH8100_NECL=
K_MCLK),
+	STARFIVE_GINV(JH8100_NECLK_I2S2_N, "i2s2_n", CLK_IGNORE_UNUSED, JH8100_=
NECLK_MCLK),
+	STARFIVE__MUX(JH8100_NECLK_I2S2_BCLK_TX, "i2s2_bclk_tx", 2, JH8100_NECL=
K_I2S2_BCLK,
+		      JH8100_NECLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(JH8100_NECLK_I2S2_LRCK_TX, "i2s2_lrck_tx", 2, JH8100_NECL=
K_I2S2_LRCK,
+		      JH8100_NECLK_I2STX_LRCK_EXT),
+	STARFIVE__MUX(JH8100_NECLK_I2S2_BCLK_RX, "i2s2_bclk_rx", 2, JH8100_NECL=
K_I2S2_BCLK,
+		      JH8100_NECLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(JH8100_NECLK_I2S2_LRCK_RX, "i2s2_lrck_rx", 2, JH8100_NECL=
K_I2S2_LRCK,
+		      JH8100_NECLK_I2STX_LRCK_EXT),
+	STARFIVE__DIV(JH8100_NECLK_I2S3_BCLK, "i2s3_bclk", 32, JH8100_NECLK_MCL=
K),
+	STARFIVE__DIV(JH8100_NECLK_I2S3_LRCK, "i2s3_lrck", 128, JH8100_NECLK_I2=
S3_BCLK),
+	STARFIVE_GATE(JH8100_NECLK_I2S0_STEREO_APB, "i2s0_stereo_apb", CLK_IGNO=
RE_UNUSED,
+		      JH8100_NECLK_APB_BUS_PER2),
+	STARFIVE_GATE(JH8100_NECLK_I2S0_STEREO, "i2s0_stereo", CLK_IGNORE_UNUSE=
D,
+		      JH8100_NECLK_MCLK),
+	STARFIVE_GINV(JH8100_NECLK_I2S0_STEREO_N, "i2s0_stereo_n", CLK_IGNORE_U=
NUSED,
+		      JH8100_NECLK_MCLK),
+	STARFIVE__MUX(JH8100_NECLK_I2S0_STEREO_BCLK_TX, "i2s0_stereo_bclk_tx", =
2,
+		      JH8100_NECLK_I2S3_BCLK, JH8100_NECLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(JH8100_NECLK_I2S0_STEREO_LRCK_TX, "i2s0_stereo_lrck_tx", =
2,
+		      JH8100_NECLK_I2S3_LRCK, JH8100_NECLK_I2STX_LRCK_EXT),
+	STARFIVE__MUX(JH8100_NECLK_I2S0_STEREO_BCLK_RX_ICG, "i2s0_stereo_bclk_r=
x_icg", 2,
+		      JH8100_NECLK_I2S3_BCLK, JH8100_NECLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(JH8100_NECLK_I2S0_STEREO_LRCK_RX, "i2s0_stereo_lrck_rx", =
2,
+		      JH8100_NECLK_I2S3_LRCK, JH8100_NECLK_I2STX_LRCK_EXT),
+	STARFIVE_GDIV(JH8100_NECLK_PDM_4MIC_DMIC, "pdm_4mic_dmic", 0, 64, JH810=
0_NECLK_MCLK),
+	STARFIVE_GATE(JH8100_NECLK_PDM_4MIC_APB, "pdm_4mic_apb", 0, JH8100_NECL=
K_APB_BUS_PER2),
+	STARFIVE_GATE(JH8100_NECLK_PDM_4MIC_SCAN, "pdm_4mic_scan", 0, JH8100_NE=
CLK_I2S3_BCLK),
+	STARFIVE_GATE(JH8100_NECLK_CAN0_CTRL_PCLK, "can0_ctrl_pclk", CLK_IGNORE=
_UNUSED,
+		      JH8100_NECLK_APB_BUS_PER2),
+	STARFIVE_GDIV(JH8100_NECLK_CAN0_CTRL, "can0_ctrl", CLK_IGNORE_UNUSED, 5=
0,
+		      JH8100_NECLK_AXI_400),
+	STARFIVE_GATE(JH8100_NECLK_CAN0_CTRL_TIMER, "can0_ctrl_timer", CLK_IGNO=
RE_UNUSED,
+		      JH8100_NECLK_OSC),
+	STARFIVE_GATE(JH8100_NECLK_CAN1_CTRL_PCLK, "can1_ctrl_pclk", CLK_IGNORE=
_UNUSED,
+		      JH8100_NECLK_APB_BUS_PER2),
+	STARFIVE_GDIV(JH8100_NECLK_CAN1_CTRL, "can1_ctrl", CLK_IGNORE_UNUSED, 5=
0,
+		      JH8100_NECLK_AXI_400),
+	STARFIVE_GATE(JH8100_NECLK_CAN1_CTRL_TIMER, "can1_ctrl_timer", CLK_IGNO=
RE_UNUSED,
+		      JH8100_NECLK_OSC),
+	/* smbus */
+	STARFIVE_GATE(JH8100_NECLK_SMBUS0_APB, "smbus0_apb", 0, JH8100_NECLK_AP=
B_BUS_PER2),
+	STARFIVE_GDIV(JH8100_NECLK_SMBUS0_CORE, "smbus0_core", 0, 120,
+		      JH8100_NECLK_PERH_ROOT_PREOSC),
+	/* iomux */
+	STARFIVE_GATE(JH8100_NECLK_IOMUX_EAST_PCLK, "iomux_east_pclk", 0,
+		      JH8100_NECLK_APB_BUS_PER2),
+	/* icg_en */
+	STARFIVE_GATE(JH8100_NECLK_USB3_ICG_EN, "usb3_en", 0, JH8100_NECLK_USB_=
WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_USB1_ICG_EN, "usb1_en", 0, JH8100_NECLK_USB_=
WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_USB2_ICG_EN, "usb2_en", 0, JH8100_NECLK_USB_=
WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_USBC_ICG_EN, "usbc_en", 0, JH8100_NECLK_USB_=
WRAP_625),
+	STARFIVE_GATE(JH8100_NECLK_VENC_ICG_EN, "venc_en", 0, JH8100_NECLK_AXI_=
400),
+	STARFIVE_GATE(JH8100_NECLK_WDT0_ICG_EN, "wdt0_en", 0, JH8100_NECLK_APB_=
BUS_PER2),
+	STARFIVE_GATE(JH8100_NECLK_SPI0_ICG_EN, "spi0_en", 0, JH8100_NECLK_APB_=
BUS_PER2),
+	STARFIVE_GATE(JH8100_NECLK_SPI1_ICG_EN, "spi1_en", 0, JH8100_NECLK_APB_=
BUS_PER2),
+	STARFIVE_GATE(JH8100_NECLK_UART0_ICG_EN, "uart0_en", 0, JH8100_NECLK_AP=
B_BUS_PER1),
+	STARFIVE_GATE(JH8100_NECLK_UART1_ICG_EN, "uart1_en", 0, JH8100_NECLK_AP=
B_BUS_PER1),
+	STARFIVE_GATE(JH8100_NECLK_UART2_ICG_EN, "uart2_en", 0, JH8100_NECLK_AP=
B_BUS_PER1),
+	STARFIVE_GATE(JH8100_NECLK_UART3_ICG_EN, "uart3_en", 0, JH8100_NECLK_AP=
B_BUS_PER1),
+	STARFIVE_GATE(JH8100_NECLK_UART4_ICG_EN, "uart4_en", 0, JH8100_NECLK_AP=
B_BUS_PER1),
+	STARFIVE_GATE(JH8100_NECLK_I2S0_ICG_EN, "i2s0_en", 0, JH8100_NECLK_MCLK=
),
+	STARFIVE_GATE(JH8100_NECLK_I2S1_ICG_EN, "i2s1_en", 0, JH8100_NECLK_MCLK=
),
+	STARFIVE_GATE(JH8100_NECLK_I2S2_ICG_EN, "i2s2_en", 0, JH8100_NECLK_MCLK=
),
+	STARFIVE_GATE(JH8100_NECLK_I2S_STEREO_ICG_EN, "i2s_stereo_en", 0, JH810=
0_NECLK_MCLK),
+	STARFIVE_GATE(JH8100_NECLK_PDM_4MIC_ICG_EN, "pdm_4mic_en", 0, JH8100_NE=
CLK_MCLK),
+	STARFIVE_GATE(JH8100_NECLK_CAN0_ICG_EN, "can0_en", 0, JH8100_NECLK_AXI_=
400),
+	STARFIVE_GATE(JH8100_NECLK_CAN1_ICG_EN, "can1_en", 0, JH8100_NECLK_AXI_=
400),
+	STARFIVE_GATE(JH8100_NECLK_SMBUS0_ICG_EN, "smbus0_en", 0, JH8100_NECLK_=
PERH_ROOT_PREOSC),
+};
+
+static struct clk_hw *jh8100_necrg_clk_get(struct of_phandle_args *clksp=
ec, void *data)
+{
+	struct starfive_clk_priv *priv =3D data;
+	unsigned int idx =3D clkspec->args[0];
+
+	if (idx < JH8100_NECLK_NUM_CLKS)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int jh8100_necrg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv =3D devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JH8100_NECLK_NUM_CLKS),
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
+	for (idx =3D 0; idx < JH8100_NECLK_NUM_CLKS; idx++) {
+		u32 max =3D jh8100_necrg_clk_data[idx].max;
+		struct clk_parent_data parents[4] =3D {};
+		struct clk_init_data init =3D {
+			.name =3D jh8100_necrg_clk_data[idx].name,
+			.ops =3D starfive_clk_ops(max),
+			.parent_data =3D parents,
+			.num_parents =3D
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags =3D jh8100_necrg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk =3D &priv->reg[idx];
+		unsigned int i;
+
+		for (i =3D 0; i < init.num_parents; i++) {
+			unsigned int pidx =3D jh8100_necrg_clk_data[idx].parents[i];
+
+			if (pidx < JH8100_NECLK_NUM_CLKS)
+				parents[i].hw =3D &priv->reg[pidx].hw;
+			else if (pidx =3D=3D JH8100_NECLK_OSC)
+				parents[i].fw_name =3D "osc";
+			else if (pidx =3D=3D JH8100_NECLK_AXI_400)
+				parents[i].fw_name =3D "axi_400";
+			else if (pidx =3D=3D JH8100_NECLK_VOUT_ROOT0)
+				parents[i].fw_name =3D "vout_root0";
+			else if (pidx =3D=3D JH8100_NECLK_VOUT_ROOT1)
+				parents[i].fw_name =3D "vout_root1";
+			else if (pidx =3D=3D JH8100_NECLK_USB_WRAP_480)
+				parents[i].fw_name =3D "usb_wrap_480";
+			else if (pidx =3D=3D JH8100_NECLK_USB_WRAP_625)
+				parents[i].fw_name =3D "usb_wrap_625";
+			else if (pidx =3D=3D JH8100_NECLK_USB_WRAP_240)
+				parents[i].fw_name =3D "usb_wrap_240";
+			else if (pidx =3D=3D JH8100_NECLK_USB_WRAP_60)
+				parents[i].fw_name =3D "usb_wrap_60";
+			else if (pidx =3D=3D JH8100_NECLK_USB_WRAP_156P25)
+				parents[i].fw_name =3D "usb_wrap_156p25";
+			else if (pidx =3D=3D JH8100_NECLK_USB_WRAP_312P5)
+				parents[i].fw_name =3D "usb_wrap_312p5";
+			else if (pidx =3D=3D JH8100_NECLK_USB_125M)
+				parents[i].fw_name =3D "usb_125m";
+			else if (pidx =3D=3D JH8100_NECLK_GPIO_100)
+				parents[i].fw_name =3D "gpio_100";
+			else if (pidx =3D=3D JH8100_NECLK_PERH_ROOT)
+				parents[i].fw_name =3D "perh_root";
+			else if (pidx =3D=3D JH8100_NECLK_MCLK)
+				parents[i].fw_name =3D "mclk";
+			else if (pidx =3D=3D JH8100_NECLK_USB3_TAP_TCK_EXT)
+				parents[i].fw_name =3D "usb3-tap-tck-ext";
+			else if (pidx =3D=3D JH8100_NECLK_GLB_EXT)
+				parents[i].fw_name =3D "glb-ext-clk";
+			else if (pidx =3D=3D JH8100_NECLK_USB1_TAP_TCK_EXT)
+				parents[i].fw_name =3D "usb1-tap-tck-ext";
+			else if (pidx =3D=3D JH8100_NECLK_USB2_TAP_TCK_EXT)
+				parents[i].fw_name =3D "usb2-tap-tck-ext";
+			else if (pidx =3D=3D JH8100_NECLK_TYPEC_TAP_TCK_EXT)
+				parents[i].fw_name =3D "typec-tap-tck-ext";
+			else if (pidx =3D=3D JH8100_NECLK_SPI_IN0_EXT)
+				parents[i].fw_name =3D "spi-in0-ext";
+			else if (pidx =3D=3D JH8100_NECLK_SPI_IN1_EXT)
+				parents[i].fw_name =3D "spi-in1-ext";
+			else if (pidx =3D=3D JH8100_NECLK_I2STX_BCLK_EXT)
+				parents[i].fw_name =3D "i2stx-bclk-ext";
+			else if (pidx =3D=3D JH8100_NECLK_I2STX_LRCK_EXT)
+				parents[i].fw_name =3D "i2stx-lrck-ext";
+			else if (pidx =3D=3D JH8100_NECLK_PERH_ROOT_PREOSC)
+				parents[i].fw_name =3D "perh_root_preosc";
+			else if (pidx =3D=3D JH8100_NECLK_AHB_DMA)
+				parents[i].fw_name =3D "ahb0";
+			else if (pidx =3D=3D JH8100_NECLK_APB_BUS_PER1)
+				parents[i].fw_name =3D "apb_bus_per1";
+			else if (pidx =3D=3D JH8100_NECLK_APB_BUS_PER2)
+				parents[i].fw_name =3D "apb_bus_per2";
+			else if (pidx =3D=3D JH8100_NECLK_APB_BUS_PER3)
+				parents[i].fw_name =3D "apb_bus_per3";
+			else if (pidx =3D=3D JH8100_NECLK_APB_BUS_PER5)
+				parents[i].fw_name =3D "apb_bus_per5";
+			else if (pidx =3D=3D JH8100_NECLK_VENC_ROOT)
+				parents[i].fw_name =3D "venc_root";
+			else if (pidx =3D=3D JH8100_NECLK_SPI_CORE_100)
+				parents[i].fw_name =3D "spi_core_100";
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
+	ret =3D devm_of_clk_add_hw_provider(&pdev->dev, jh8100_necrg_clk_get, p=
riv);
+	if (ret)
+		return ret;
+
+	return jh8100_reset_controller_register(priv, "rst-ne", 2);
+}
+
+static const struct of_device_id jh8100_necrg_match[] =3D {
+	{ .compatible =3D "starfive,jh8100-necrg" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jh8100_necrg_driver =3D {
+	.driver =3D {
+		.name =3D "clk-starfive-jh8100-ne",
+		.of_match_table =3D jh8100_necrg_match,
+		.suppress_bind_attrs =3D true,
+	},
+};
+builtin_platform_driver_probe(jh8100_necrg_driver, jh8100_necrg_probe);
--=20
2.34.1


