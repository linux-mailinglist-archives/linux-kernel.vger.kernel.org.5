Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100D5806F1D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377905AbjLFLwg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378126AbjLFLwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:52:18 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B4E19B5;
        Wed,  6 Dec 2023 03:51:36 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id B665424E2F7;
        Wed,  6 Dec 2023 19:51:34 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 19:51:34 +0800
Received: from jsia-virtual-machine.localdomain (175.136.135.142) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 6 Dec 2023 19:51:27 +0800
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
Subject: [PATCH v1 10/16] clk: starfive: Add JH8100 System-North-East clock generator driver
Date:   Wed, 6 Dec 2023 19:49:54 +0800
Message-ID: <20231206115000.295825-11-jeeheng.sia@starfivetech.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for JH8100 System-North-East clock generator.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/clk/starfive/Kconfig             |   8 +
 drivers/clk/starfive/jh8100/Makefile     |   1 +
 drivers/clk/starfive/jh8100/clk-sys-ne.c | 566 +++++++++++++++++++++++
 3 files changed, 575 insertions(+)
 create mode 100644 drivers/clk/starfive/jh8100/clk-sys-ne.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index e55f783d73ac..acd530c3897b 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -89,3 +89,11 @@ config CLK_STARFIVE_JH8100_SYS_NW
 	help
 	  Say yes here to support the System-North-West clock controller on the StarFive JH8100
 	  SoC.
+
+config CLK_STARFIVE_JH8100_SYS_NE
+	bool "StarFive JH8100 System-North-East clock support"
+	depends on CLK_STARFIVE_JH8100_SYS
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the System-North-East clock controller on the StarFive JH8100
+	  SoC.
diff --git a/drivers/clk/starfive/jh8100/Makefile b/drivers/clk/starfive/jh8100/Makefile
index eca7970a0e45..164c1d55b97c 100644
--- a/drivers/clk/starfive/jh8100/Makefile
+++ b/drivers/clk/starfive/jh8100/Makefile
@@ -2,3 +2,4 @@
 # StarFive JH8100 Clock
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)		+= clk-sys.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS_NW)	+= clk-sys-nw.o
+obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS_NE)	+= clk-sys-ne.o
diff --git a/drivers/clk/starfive/jh8100/clk-sys-ne.c b/drivers/clk/starfive/jh8100/clk-sys-ne.c
new file mode 100644
index 000000000000..325571f52c29
--- /dev/null
+++ b/drivers/clk/starfive/jh8100/clk-sys-ne.c
@@ -0,0 +1,566 @@
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
+/* external clocks */
+#define SYSCRG_NE_CLK_OSC		(SYSCRG_NE_CLK_END + 0)
+#define SYSCRG_NE_CLK_APB_BUS		(SYSCRG_NE_CLK_END + 1)
+#define SYSCRG_NE_CLK_AXI_400		(SYSCRG_NE_CLK_END + 3)
+#define SYSCRG_NE_CLK_VOUT_ROOT0	(SYSCRG_NE_CLK_END + 5)
+#define SYSCRG_NE_CLK_VOUT_ROOT1	(SYSCRG_NE_CLK_END + 6)
+#define SYSCRG_NE_CLK_USB_WRAP_480	(SYSCRG_NE_CLK_END + 7)
+#define SYSCRG_NE_CLK_USB_WRAP_625	(SYSCRG_NE_CLK_END + 8)
+#define SYSCRG_NE_CLK_USB_WRAP_240	(SYSCRG_NE_CLK_END + 9)
+#define SYSCRG_NE_CLK_USB_WRAP_60	(SYSCRG_NE_CLK_END + 10)
+#define SYSCRG_NE_CLK_USB_WRAP_156P25	(SYSCRG_NE_CLK_END + 11)
+#define SYSCRG_NE_CLK_USB_WRAP_312P5	(SYSCRG_NE_CLK_END + 12)
+#define SYSCRG_NE_CLK_USB_125M		(SYSCRG_NE_CLK_END + 13)
+#define SYSCRG_NE_CLK_GPIO_100		(SYSCRG_NE_CLK_END + 14)
+#define SYSCRG_NE_CLK_PERH_ROOT		(SYSCRG_NE_CLK_END + 15)
+#define SYSCRG_NE_CLK_MCLK		(SYSCRG_NE_CLK_END + 16)
+#define SYSCRG_NE_CLK_USB3_TAP_TCK_EXT	(SYSCRG_NE_CLK_END + 17)
+#define SYSCRG_NE_CLK_GLB_EXT		(SYSCRG_NE_CLK_END + 18)
+#define SYSCRG_NE_CLK_USB1_TAP_TCK_EXT	(SYSCRG_NE_CLK_END + 19)
+#define SYSCRG_NE_CLK_USB2_TAP_TCK_EXT	(SYSCRG_NE_CLK_END + 20)
+#define SYSCRG_NE_CLK_TYPEC_TAP_TCK_EXT	(SYSCRG_NE_CLK_END + 22)
+#define SYSCRG_NE_CLK_SPI_IN0_EXT	(SYSCRG_NE_CLK_END + 23)
+#define SYSCRG_NE_CLK_SPI_IN1_EXT	(SYSCRG_NE_CLK_END + 24)
+#define SYSCRG_NE_CLK_I2STX_BCLK_EXT	(SYSCRG_NE_CLK_END + 25)
+#define SYSCRG_NE_CLK_I2STX_LRCK_EXT	(SYSCRG_NE_CLK_END + 26)
+#define SYSCRG_NE_CLK_PERH_ROOT_PREOSC	(SYSCRG_NE_CLK_END + 27)
+#define SYSCRG_NE_CLK_AHB_DMA		(SYSCRG_NE_CLK_END + 28)
+#define SYSCRG_NE_CLK_APB_BUS_PER1	(SYSCRG_NE_CLK_END + 29)
+#define SYSCRG_NE_CLK_APB_BUS_PER2	(SYSCRG_NE_CLK_END + 30)
+#define SYSCRG_NE_CLK_APB_BUS_PER3	(SYSCRG_NE_CLK_END + 31)
+#define SYSCRG_NE_CLK_APB_BUS_PER5	(SYSCRG_NE_CLK_END + 32)
+#define SYSCRG_NE_CLK_VENC_ROOT		(SYSCRG_NE_CLK_END + 33)
+#define SYSCRG_NE_CLK_SPI_CORE_100	(SYSCRG_NE_CLK_END + 34)
+
+static const struct starfive_clk_data jh8100_syscrg_ne_clk_data[] = {
+	/* flexnoc */
+	STARFIVE_GATE(SYSCRG_NE_CLK_FLEXNOC_DMASLV, "sys_ne_clk_flexnoc_dmaslv",
+		      CLK_IS_CRITICAL, SYSCRG_NE_CLK_AHB_DMA),
+	/* mailbox */
+	STARFIVE_GATE(SYSCRG_NE_CLK_MAILBOX_APB, "sys_ne_clk_mailbox_apb",
+		      CLK_IS_CRITICAL, SYSCRG_NE_CLK_APB_BUS_PER1),
+	/* timer */
+	STARFIVE_GATE(SYSCRG_NE_CLK_SR5_TIMER0_APB, "sys_ne_clk_timer0_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SR5_TIMER0_CH0, "sys_ne_clk_timer0_ch0", 0,
+		      SYSCRG_NE_CLK_OSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SR5_TIMER0_CH1, "sys_ne_clk_timer0_ch1", 0,
+		      SYSCRG_NE_CLK_OSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SR5_TIMER0_CH2, "sys_ne_clk_timer0_ch2", 0,
+		      SYSCRG_NE_CLK_OSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SR5_TIMER0_CH3, "sys_ne_clk_timer0_ch3", 0,
+		      SYSCRG_NE_CLK_OSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SR5_TIMER1_APB, "sys_ne_clk_timer1_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SR5_TIMER1_CH0, "sys_ne_clk_timer1_ch0", 0,
+		      SYSCRG_NE_CLK_OSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SR5_TIMER1_CH1, "sys_ne_clk_timer1_ch1", 0,
+		      SYSCRG_NE_CLK_OSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SR5_TIMER1_CH2, "sys_ne_clk_timer1_ch2", 0,
+		      SYSCRG_NE_CLK_OSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SR5_TIMER1_CH3, "sys_ne_clk_timer1_ch3", 0,
+		      SYSCRG_NE_CLK_OSC),
+	/* usb3 */
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB3_CMN_SCAN_PLL, "sys_ne_clk_usb3_scan_pll",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB3_CMN_SCAN_SER, "sys_ne_clk_usb3_scan_ser",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB3_PIPE_IN_SCAN, "sys_ne_clk_usb3_pipe_in_scan",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_125M),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB3_SCAN_PIPE, "sys_ne_clk_usb3_scan_pipe",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_125M),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB3_SCAN_PSM, "sys_ne_clk_usb3_scan_psm",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_125M),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB3_SCAN_REF, "sys_ne_clk_usb3_scan_ref",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_OSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB3_USB2_SCAN, "sys_ne_clk_usb3_usb2_scan",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_APB_BUS_PER3),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB3_HSCLK, "sys_ne_clk_usb3_hsclk",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_480),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB3_HSSICLK, "sys_ne_clk_usb3_hssiclk",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_240),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB3_SIECLK, "sys_ne_clk_usb3_sieclk",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_60),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB3_XCVR_SCAN_PLL, "sys_ne_clk_usb3_xcvr_scan_pll",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB3_XCVR_SCAN_SER, "sys_ne_clk_usb3_xcvr_scan_ser",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE__MUX(SYSCRG_NE_CLK_USB3_TAP_TCK, "sys_ne_clk_usb3_tap_tck", 2,
+		      SYSCRG_NE_CLK_USB3_TAP_TCK_EXT, SYSCRG_NE_CLK_GLB_EXT),
+	/* usb1 */
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB1_CMN_SCAN_PLL, "sys_ne_clk_usb1_scan_pll",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB1_CMN_SCAN_SER, "sys_ne_clk_usb1_scan_ser",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB1_PIPE_IN_SCAN, "sys_ne_clk_usb1_pipe_in_scan",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_125M),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB1_SCAN_PIPE, "sys_ne_clk_usb1_scan_pipe",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_125M),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB1_SCAN_PSM, "sys_ne_clk_usb1_scan_psm",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_125M),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB1_SCAN_REF, "sys_ne_clk_usb1_scan_ref",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_OSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB1_USB2_SCAN, "sys_ne_clk_usb1_usb2_scan",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_APB_BUS_PER3),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB1_HSCLK, "sys_ne_clk_usb1_hsclk",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_480),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB1_HSSICLK, "sys_ne_clk_usb1_hssiclk",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_240),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB1_SIECLK, "sys_ne_clk_usb1_sieclk",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_60),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB1_XCVR_SCAN_PLL, "sys_ne_clk_usb1_xcvr_scan_pll",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB1_XCVR_SCAN_SER, "sys_ne_clk_usb1_xcvr_scan_ser",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE__MUX(SYSCRG_NE_CLK_USB1_TAP_TCK, "sys_ne_clk_usb1_tap_tck", 2,
+		      SYSCRG_NE_CLK_USB1_TAP_TCK_EXT, SYSCRG_NE_CLK_GLB_EXT),
+	/* usb2 */
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB2_CMN_SCAN_PLL, "sys_ne_clk_usb2_scan_pll",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB2_CMN_SCAN_SER, "sys_ne_clk_usb2_scan_ser",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB2_PIPE_IN_SCAN, "sys_ne_clk_usb2_pipe_in_scan",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_125M),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB2_SCAN_PIPE, "sys_ne_clk_usb2_scan_pipe",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_125M),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB2_SCAN_PSM, "sys_ne_clk_usb2_scan_psm",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_125M),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB2_SCAN_REF, "sys_ne_clk_usb2_scan_ref",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_OSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB2_USB2_SCAN, "sys_ne_clk_usb2_usb2_scan",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_APB_BUS_PER3),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB2_HSCLK, "sys_ne_clk_usb2_hsclk",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_480),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB2_HSSICLK, "sys_ne_clk_usb2_hssiclk",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_240),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB2_SIECLK, "sys_ne_clk_usb2_sieclk",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_60),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB2_XCVR_SCAN_PLL, "sys_ne_clk_usb2_xcvr_scan_pll",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB2_XCVR_SCAN_SER, "sys_ne_clk_usb2_xcvr_scan_ser",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE__MUX(SYSCRG_NE_CLK_USB2_TAP_TCK, "sys_ne_clk_usb2_tap_tck", 2,
+		      SYSCRG_NE_CLK_USB2_TAP_TCK_EXT, SYSCRG_NE_CLK_GLB_EXT),
+	/* usb typec */
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_PIPE_DIV_SCAN, "sys_ne_clk_typec_pipe_div_scan",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_156P25),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_CMN_SCAN_PLL, "sys_ne_clk_typec_scan_pll",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_CMN_SCAN_SER, "sys_ne_clk_typec_scan_ser",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_SCAN_PIPE, "sys_ne_clk_typec_scan_pipe",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_312P5),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_SCAN_PSM, "sys_ne_clk_typec_scan_psm",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_125M),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_SCAN_REF, "sys_ne_clk_typec_scan_ref",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_OSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_USB2_SCAN, "sys_ne_clk_typec_usb2_scan",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_APB_BUS_PER5),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_HSCLK, "sys_ne_clk_typec_hsclk", CLK_IGNORE_UNUSED,
+		      SYSCRG_NE_CLK_USB_WRAP_480),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_HSSICLK, "sys_ne_clk_typec_hssiclk",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_240),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_SIECLK, "sys_ne_clk_typec_sieclk",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_60),
+	STARFIVE_GMUX(SYSCRG_NE_CLK_TYPEC_VID0, "sys_ne_clk_typec_vid0", CLK_IGNORE_UNUSED,
+		      2, SYSCRG_NE_CLK_VOUT_ROOT0, SYSCRG_NE_CLK_VOUT_ROOT1),
+	STARFIVE_GMUX(SYSCRG_NE_CLK_TYPEC_VID1, "sys_ne_clk_typec_vid1", CLK_IGNORE_UNUSED,
+		      2, SYSCRG_NE_CLK_VOUT_ROOT0, SYSCRG_NE_CLK_VOUT_ROOT1),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_PLL0, "sys_ne_clk_typec_xcvr_scan_pll0",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_PLL1, "sys_ne_clk_typec_xcvr_scan_pll1",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_PLL2, "sys_ne_clk_typec_xcvr_scan_pll2",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_PLL3, "sys_ne_clk_typec_xcvr_scan_pll3",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_SER0, "sys_ne_clk_typec_xcvr_scan_ser0",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_SER1, "sys_ne_clk_typec_xcvr_scan_ser1",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_SER2, "sys_ne_clk_typec_xcvr_scan_ser2",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_SER3, "sys_ne_clk_typec_xcvr_scan_ser3",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE__MUX(SYSCRG_NE_CLK_TYPEC_TAP_TCK, "sys_ne_clk_typec_tap_tck", 2,
+		      SYSCRG_NE_CLK_TYPEC_TAP_TCK_EXT, SYSCRG_NE_CLK_GLB_EXT),
+	/* video enc */
+	STARFIVE__DIV(SYSCRG_NE_CLK_VENC_AXI, "sys_ne_clk_venc_axi",
+		      20, SYSCRG_NE_CLK_VENC_ROOT),
+	STARFIVE_GATE(SYSCRG_NE_CLK_VC9000LE_AXI, "sys_ne_clk_vc9000le_axi",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_VENC_AXI),
+	STARFIVE_GATE(SYSCRG_NE_CLK_VC9000LE_APB, "sys_ne_clk_vc9000le_apb",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_APB_BUS_PER5),
+	STARFIVE_GDIV(SYSCRG_NE_CLK_VC9000LE_CORECLK, "sys_ne_clk_vc9000le_coreclk",
+		      0, 40, SYSCRG_NE_CLK_VENC_ROOT),
+	/* intc */
+	STARFIVE_GATE(SYSCRG_NE_CLK_INT_CTRL_APB, "sys_ne_clk_int_ctrl_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER2),
+	/* pwm */
+	STARFIVE_GATE(SYSCRG_NE_CLK_PWM_8CH_APB, "sys_ne_clk_pwm_8ch_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER2),
+	/* wdt */
+	STARFIVE_GATE(SYSCRG_NE_CLK_WDT_APB, "sys_ne_clk_wdt_apb", CLK_IGNORE_UNUSED,
+		      SYSCRG_NE_CLK_APB_BUS_PER2),
+	STARFIVE_GATE(SYSCRG_NE_CLK_WDT, "sys_ne_clk_wdt", CLK_IGNORE_UNUSED,
+		      SYSCRG_NE_CLK_OSC),
+	/* SPI */
+	STARFIVE_GATE(SYSCRG_NE_CLK_SPI0_APB, "sys_ne_clk_spi0_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER2),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SPI0_CORE, "sys_ne_clk_spi0_core", 0,
+		      SYSCRG_NE_CLK_SPI_CORE_100),
+	STARFIVE__MUX(SYSCRG_NE_CLK_SPI0_SCLK_IN, "sys_ne_clk_spi0_sclk_in", 2,
+		      SYSCRG_NE_CLK_SPI_IN0_EXT, SYSCRG_NE_CLK_GPIO_100),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SPI1_APB, "sys_ne_clk_spi1_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER2),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SPI1_CORE, "sys_ne_clk_spi1_core", 0,
+		      SYSCRG_NE_CLK_SPI_CORE_100),
+	STARFIVE__MUX(SYSCRG_NE_CLK_SPI1_SCLK_IN, "sys_ne_clk_spi1_sclk_in", 2,
+		      SYSCRG_NE_CLK_SPI_IN1_EXT, SYSCRG_NE_CLK_GPIO_100),
+	/* i2c */
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2C0_APB, "sys_ne_clk_i2c0_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2C1_APB, "sys_ne_clk_i2c1_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2C2_APB, "sys_ne_clk_i2c2_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2C3_APB, "sys_ne_clk_i2c3_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2C4_APB, "sys_ne_clk_i2c4_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2C5_APB, "sys_ne_clk_i2c5_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	/* uart */
+	STARFIVE_GATE(SYSCRG_NE_CLK_UART0_APB, "sys_ne_clk_uart0_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GATE(SYSCRG_NE_CLK_UART0_CORE, "sys_ne_clk_uart0_core", 0,
+		      SYSCRG_NE_CLK_OSC),
+	STARFIVE__DIV(SYSCRG_NE_CLK_UART1_CORE_PREOSC, "sys_ne_clk_uart1_core_preosc",
+		      131071, SYSCRG_NE_CLK_PERH_ROOT_PREOSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_UART1_APB, "sys_ne_clk_uart1_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GMUX(SYSCRG_NE_CLK_UART1_CORE, "sys_ne_clk_uart1_core", 0, 2,
+		      SYSCRG_NE_CLK_OSC, SYSCRG_NE_CLK_UART1_CORE_PREOSC),
+	STARFIVE__DIV(SYSCRG_NE_CLK_UART2_CORE_PREOSC, "sys_ne_clk_uart2_core_preosc",
+		      131071, SYSCRG_NE_CLK_PERH_ROOT_PREOSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_UART2_APB, "sys_ne_clk_uart2_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GMUX(SYSCRG_NE_CLK_UART2_CORE, "sys_ne_clk_uart2_core", 0, 2,
+		      SYSCRG_NE_CLK_OSC, SYSCRG_NE_CLK_UART2_CORE_PREOSC),
+	STARFIVE__DIV(SYSCRG_NE_CLK_UART3_CORE_PREOSC, "sys_ne_clk_uart3_core_preosc",
+		      131071, SYSCRG_NE_CLK_PERH_ROOT_PREOSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_UART3_APB, "sys_ne_clk_uart3_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GMUX(SYSCRG_NE_CLK_UART3_CORE, "sys_ne_clk_uart3_core", 0, 2,
+		      SYSCRG_NE_CLK_OSC, SYSCRG_NE_CLK_UART3_CORE_PREOSC),
+	STARFIVE__DIV(SYSCRG_NE_CLK_UART4_CORE_PREOSC, "sys_ne_clk_uart4_core_preosc",
+		      131071, SYSCRG_NE_CLK_PERH_ROOT_PREOSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_UART4_APB, "sys_ne_clk_uart4_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GMUX(SYSCRG_NE_CLK_UART4_CORE, "sys_ne_clk_uart4_core", 0, 2,
+		      SYSCRG_NE_CLK_OSC, SYSCRG_NE_CLK_UART4_CORE_PREOSC),
+	/* i2s */
+	STARFIVE__DIV(SYSCRG_NE_CLK_I2S0_BCLK, "sys_ne_clk_i2s0_bclk", 32,
+		      SYSCRG_NE_CLK_MCLK),
+	STARFIVE__DIV(SYSCRG_NE_CLK_I2S0_LRCK, "sys_ne_clk_i2s0_lrck", 128,
+		      SYSCRG_NE_CLK_I2S0_BCLK),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2S0_APB, "sys_ne_clk_i2s0_apb", CLK_IGNORE_UNUSED,
+		      SYSCRG_NE_CLK_APB_BUS_PER2),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2S0, "sys_ne_clk_i2s0", CLK_IGNORE_UNUSED,
+		      SYSCRG_NE_CLK_MCLK),
+	STARFIVE_GINV(SYSCRG_NE_CLK_I2S0_N, "sys_ne_clk_i2s0_n",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_MCLK),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S0_BCLK_TX, "sys_ne_clk_i2s0_bclk_tx", 2,
+		      SYSCRG_NE_CLK_I2S0_BCLK, SYSCRG_NE_CLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S0_LRCK_TX, "sys_ne_clk_i2s0_lrck_tx", 2,
+		      SYSCRG_NE_CLK_I2S0_LRCK, SYSCRG_NE_CLK_I2STX_LRCK_EXT),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S0_BCLK_RX, "sys_ne_clk_i2s0_bclk_rx", 2,
+		      SYSCRG_NE_CLK_I2S0_BCLK, SYSCRG_NE_CLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S0_LRCK_RX, "sys_ne_clk_i2s0_lrck_rx", 2,
+		      SYSCRG_NE_CLK_I2S0_LRCK, SYSCRG_NE_CLK_I2STX_LRCK_EXT),
+	STARFIVE__DIV(SYSCRG_NE_CLK_I2S1_BCLK, "sys_ne_clk_i2s1_bclk", 32,
+		      SYSCRG_NE_CLK_MCLK),
+	STARFIVE__DIV(SYSCRG_NE_CLK_I2S1_LRCK, "sys_ne_clk_i2s1_lrck", 128,
+		      SYSCRG_NE_CLK_I2S1_BCLK),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2S1_APB, "sys_ne_clk_i2s1_apb", CLK_IGNORE_UNUSED,
+		      SYSCRG_NE_CLK_APB_BUS_PER2),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2S1, "sys_ne_clk_i2s1", CLK_IGNORE_UNUSED,
+		      SYSCRG_NE_CLK_MCLK),
+	STARFIVE_GINV(SYSCRG_NE_CLK_I2S1_N, "sys_ne_clk_i2s1_n",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_MCLK),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S1_BCLK_TX, "sys_ne_clk_i2s1_bclk_tx", 2,
+		      SYSCRG_NE_CLK_I2S1_BCLK, SYSCRG_NE_CLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S1_LRCK_TX, "sys_ne_clk_i2s1_lrck_tx", 2,
+		      SYSCRG_NE_CLK_I2S1_LRCK, SYSCRG_NE_CLK_I2STX_LRCK_EXT),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S1_BCLK_RX, "sys_ne_clk_i2s1_bclk_rx", 2,
+		      SYSCRG_NE_CLK_I2S1_BCLK, SYSCRG_NE_CLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S1_LRCK_RX, "sys_ne_clk_i2s1_lrck_rx", 2,
+		      SYSCRG_NE_CLK_I2S1_LRCK, SYSCRG_NE_CLK_I2STX_LRCK_EXT),
+	STARFIVE__DIV(SYSCRG_NE_CLK_I2S2_BCLK, "sys_ne_clk_i2s2_bclk", 32,
+		      SYSCRG_NE_CLK_MCLK),
+	STARFIVE__DIV(SYSCRG_NE_CLK_I2S2_LRCK, "sys_ne_clk_i2s2_lrck", 128,
+		      SYSCRG_NE_CLK_I2S2_BCLK),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2S2_APB, "sys_ne_clk_i2s2_apb", CLK_IGNORE_UNUSED,
+		      SYSCRG_NE_CLK_APB_BUS_PER2),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2S2, "sys_ne_clk_i2s2", CLK_IGNORE_UNUSED,
+		      SYSCRG_NE_CLK_MCLK),
+	STARFIVE_GINV(SYSCRG_NE_CLK_I2S2_N, "sys_ne_clk_i2s2_n",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_MCLK),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S2_BCLK_TX, "sys_ne_clk_i2s2_bclk_tx", 2,
+		      SYSCRG_NE_CLK_I2S2_BCLK, SYSCRG_NE_CLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S2_LRCK_TX, "sys_ne_clk_i2s2_lrck_tx", 2,
+		      SYSCRG_NE_CLK_I2S2_LRCK, SYSCRG_NE_CLK_I2STX_LRCK_EXT),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S2_BCLK_RX, "sys_ne_clk_i2s2_bclk_rx", 2,
+		      SYSCRG_NE_CLK_I2S2_BCLK, SYSCRG_NE_CLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S2_LRCK_RX, "sys_ne_clk_i2s2_lrck_rx", 2,
+		      SYSCRG_NE_CLK_I2S2_LRCK, SYSCRG_NE_CLK_I2STX_LRCK_EXT),
+	STARFIVE__DIV(SYSCRG_NE_CLK_I2S3_BCLK, "sys_ne_clk_i2s3_bclk", 32,
+		      SYSCRG_NE_CLK_MCLK),
+	STARFIVE__DIV(SYSCRG_NE_CLK_I2S3_LRCK, "sys_ne_clk_i2s3_lrck", 128,
+		      SYSCRG_NE_CLK_I2S3_BCLK),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2S0_STEREO_APB, "sys_ne_clk_i2s0_stereo_apb",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_APB_BUS_PER2),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2S0_STEREO, "sys_ne_clk_i2s0_stereo", CLK_IGNORE_UNUSED,
+		      SYSCRG_NE_CLK_MCLK),
+	STARFIVE_GINV(SYSCRG_NE_CLK_I2S0_STEREO_N, "sys_ne_clk_i2s0_stereo_n",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_MCLK),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S0_STEREO_BCLK_TX, "sys_ne_clk_i2s0_stereo_bclk_tx", 2,
+		      SYSCRG_NE_CLK_I2S3_BCLK, SYSCRG_NE_CLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S0_STEREO_LRCK_TX, "sys_ne_clk_i2s0_stereo_lrck_tx", 2,
+		      SYSCRG_NE_CLK_I2S3_LRCK, SYSCRG_NE_CLK_I2STX_LRCK_EXT),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S0_STEREO_BCLK_RX_ICG, "sys_ne_clk_i2s0_stereo_bclk_rx_icg",
+		      2, SYSCRG_NE_CLK_I2S3_BCLK, SYSCRG_NE_CLK_I2STX_BCLK_EXT),
+	STARFIVE__MUX(SYSCRG_NE_CLK_I2S0_STEREO_LRCK_RX, "sys_ne_clk_i2s0_stereo_lrck_rx", 2,
+		      SYSCRG_NE_CLK_I2S3_LRCK, SYSCRG_NE_CLK_I2STX_LRCK_EXT),
+	STARFIVE_GDIV(SYSCRG_NE_CLK_PDM_4MIC_DMIC, "sys_ne_clk_pdm_4mic_dmic",
+		      0, 64, SYSCRG_NE_CLK_MCLK),
+	STARFIVE_GATE(SYSCRG_NE_CLK_PDM_4MIC_APB, "sys_ne_clk_pdm_4mic_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER2),
+	STARFIVE_GATE(SYSCRG_NE_CLK_PDM_4MIC_SCAN, "sys_ne_clk_pdm_4mic_scan", 0,
+		      SYSCRG_NE_CLK_I2S3_BCLK),
+	STARFIVE_GATE(SYSCRG_NE_CLK_CAN0_CTRL_PCLK, "sys_ne_clk_can0_ctrl_pclk",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_APB_BUS_PER2),
+	STARFIVE_GDIV(SYSCRG_NE_CLK_CAN0_CTRL, "sys_ne_clk_can0_ctrl", CLK_IGNORE_UNUSED, 50,
+		      SYSCRG_NE_CLK_AXI_400),
+	STARFIVE_GATE(SYSCRG_NE_CLK_CAN0_CTRL_TIMER, "sys_ne_clk_can0_ctrl_timer",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_OSC),
+	STARFIVE_GATE(SYSCRG_NE_CLK_CAN1_CTRL_PCLK, "sys_ne_clk_can1_ctrl_pclk",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_APB_BUS_PER2),
+	STARFIVE_GDIV(SYSCRG_NE_CLK_CAN1_CTRL, "sys_ne_clk_can1_ctrl", CLK_IGNORE_UNUSED, 50,
+		      SYSCRG_NE_CLK_AXI_400),
+	STARFIVE_GATE(SYSCRG_NE_CLK_CAN1_CTRL_TIMER, "sys_ne_clk_can1_ctrl_timer",
+		      CLK_IGNORE_UNUSED, SYSCRG_NE_CLK_OSC),
+	/* smbus */
+	STARFIVE_GATE(SYSCRG_NE_CLK_SMBUS0_APB, "sys_ne_clk_smbus0_apb", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER2),
+	STARFIVE_GDIV(SYSCRG_NE_CLK_SMBUS0_CORE, "sys_ne_clk_smbus0_core", 0, 120,
+		      SYSCRG_NE_CLK_PERH_ROOT_PREOSC),
+	/* iomux */
+	STARFIVE_GATE(SYSCRG_NE_CLK_IOMUX_EAST_PCLK, "sys_ne_clk_iomux_east_pclk", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER2),
+	/* icg_en */
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB3_ICG_EN, "sys_ne_clk_usb3_en", 0,
+		      SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB1_ICG_EN, "sys_ne_clk_usb1_en", 0,
+		      SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USB2_ICG_EN, "sys_ne_clk_usb2_en", 0,
+		      SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_USBC_ICG_EN, "sys_ne_clk_usbc_en", 0,
+		      SYSCRG_NE_CLK_USB_WRAP_625),
+	STARFIVE_GATE(SYSCRG_NE_CLK_VENC_ICG_EN, "sys_ne_clk_venc_en", 0,
+		      SYSCRG_NE_CLK_AXI_400),
+	STARFIVE_GATE(SYSCRG_NE_CLK_WDT0_ICG_EN, "sys_ne_clk_wdt0_en", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER2),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SPI0_ICG_EN, "sys_ne_clk_spi0_en", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER2),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SPI1_ICG_EN, "sys_ne_clk_spi1_en", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER2),
+	STARFIVE_GATE(SYSCRG_NE_CLK_UART0_ICG_EN, "sys_ne_clk_uart0_en", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GATE(SYSCRG_NE_CLK_UART1_ICG_EN, "sys_ne_clk_uart1_en", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GATE(SYSCRG_NE_CLK_UART2_ICG_EN, "sys_ne_clk_uart2_en", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GATE(SYSCRG_NE_CLK_UART3_ICG_EN, "sys_ne_clk_uart3_en", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GATE(SYSCRG_NE_CLK_UART4_ICG_EN, "sys_ne_clk_uart4_en", 0,
+		      SYSCRG_NE_CLK_APB_BUS_PER1),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2S0_ICG_EN, "sys_ne_clk_i2s0_en", 0,
+		      SYSCRG_NE_CLK_MCLK),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2S1_ICG_EN, "sys_ne_clk_i2s1_en", 0,
+		      SYSCRG_NE_CLK_MCLK),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2S2_ICG_EN, "sys_ne_clk_i2s2_en", 0,
+		      SYSCRG_NE_CLK_MCLK),
+	STARFIVE_GATE(SYSCRG_NE_CLK_I2S_STEREO_ICG_EN, "sys_ne_clk_i2s_stereo_en", 0,
+		      SYSCRG_NE_CLK_MCLK),
+	STARFIVE_GATE(SYSCRG_NE_CLK_PDM_4MIC_ICG_EN, "sys_ne_clk_pdm_4mic_en", 0,
+		      SYSCRG_NE_CLK_MCLK),
+	STARFIVE_GATE(SYSCRG_NE_CLK_CAN0_ICG_EN, "sys_ne_clk_can0_en", 0,
+		      SYSCRG_NE_CLK_AXI_400),
+	STARFIVE_GATE(SYSCRG_NE_CLK_CAN1_ICG_EN, "sys_ne_clk_can1_en", 0,
+		      SYSCRG_NE_CLK_AXI_400),
+	STARFIVE_GATE(SYSCRG_NE_CLK_SMBUS0_ICG_EN, "sys_ne_clk_smbus0_en", 0,
+		      SYSCRG_NE_CLK_PERH_ROOT_PREOSC),
+};
+
+static struct clk_hw *jh8100_syscrg_ne_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct starfive_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < SYSCRG_NE_CLK_END)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int jh8100_syscrg_ne_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, SYSCRG_NE_CLK_END),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	for (idx = 0; idx < SYSCRG_NE_CLK_END; idx++) {
+		u32 max = jh8100_syscrg_ne_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh8100_syscrg_ne_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jh8100_syscrg_ne_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh8100_syscrg_ne_clk_data[idx].parents[i];
+
+			if (pidx < SYSCRG_NE_CLK_END)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == SYSCRG_NE_CLK_OSC)
+				parents[i].fw_name = "clk_osc";
+			else if (pidx == SYSCRG_NE_CLK_AXI_400)
+				parents[i].fw_name = "sys_clk_axi_400";
+			else if (pidx == SYSCRG_NE_CLK_VOUT_ROOT0)
+				parents[i].fw_name = "sys_clk_vout_root0";
+			else if (pidx == SYSCRG_NE_CLK_VOUT_ROOT1)
+				parents[i].fw_name = "sys_clk_vout_root1";
+			else if (pidx == SYSCRG_NE_CLK_USB_WRAP_480)
+				parents[i].fw_name = "sys_clk_usb_wrap_480";
+			else if (pidx == SYSCRG_NE_CLK_USB_WRAP_625)
+				parents[i].fw_name = "sys_clk_usb_wrap_625";
+			else if (pidx == SYSCRG_NE_CLK_USB_WRAP_240)
+				parents[i].fw_name = "sys_clk_usb_wrap_240";
+			else if (pidx == SYSCRG_NE_CLK_USB_WRAP_60)
+				parents[i].fw_name = "sys_clk_usb_wrap_60";
+			else if (pidx == SYSCRG_NE_CLK_USB_WRAP_156P25)
+				parents[i].fw_name = "sys_clk_usb_wrap_156p25";
+			else if (pidx == SYSCRG_NE_CLK_USB_WRAP_312P5)
+				parents[i].fw_name = "sys_clk_usb_wrap_312p5";
+			else if (pidx == SYSCRG_NE_CLK_USB_125M)
+				parents[i].fw_name = "sys_clk_usb_125m";
+			else if (pidx == SYSCRG_NE_CLK_GPIO_100)
+				parents[i].fw_name = "sys_nw_clk_gpio_100";
+			else if (pidx == SYSCRG_NE_CLK_PERH_ROOT)
+				parents[i].fw_name = "sys_clk_perh_root";
+			else if (pidx == SYSCRG_NE_CLK_MCLK)
+				parents[i].fw_name = "sys_clk_mclk";
+			else if (pidx == SYSCRG_NE_CLK_USB3_TAP_TCK_EXT)
+				parents[i].fw_name = "clk_usb3_tap_tck_ext";
+			else if (pidx == SYSCRG_NE_CLK_GLB_EXT)
+				parents[i].fw_name = "clk_glb_ext_clk";
+			else if (pidx == SYSCRG_NE_CLK_USB1_TAP_TCK_EXT)
+				parents[i].fw_name = "clk_usb1_tap_tck_ext";
+			else if (pidx == SYSCRG_NE_CLK_USB2_TAP_TCK_EXT)
+				parents[i].fw_name = "clk_usb2_tap_tck_ext";
+			else if (pidx == SYSCRG_NE_CLK_TYPEC_TAP_TCK_EXT)
+				parents[i].fw_name = "clk_typec_tap_tck_ext";
+			else if (pidx == SYSCRG_NE_CLK_SPI_IN0_EXT)
+				parents[i].fw_name = "clk_spi_in0_ext";
+			else if (pidx == SYSCRG_NE_CLK_SPI_IN1_EXT)
+				parents[i].fw_name = "clk_spi_in1_ext";
+			else if (pidx == SYSCRG_NE_CLK_I2STX_BCLK_EXT)
+				parents[i].fw_name = "clk_i2stx_bclk_ext";
+			else if (pidx == SYSCRG_NE_CLK_I2STX_LRCK_EXT)
+				parents[i].fw_name = "clk_i2stx_lrck_ext";
+			else if (pidx == SYSCRG_NE_CLK_PERH_ROOT_PREOSC)
+				parents[i].fw_name = "sys_clk_perh_root_preosc";
+			else if (pidx == SYSCRG_NE_CLK_AHB_DMA)
+				parents[i].fw_name = "sys_clk_ahb0";
+			else if (pidx == SYSCRG_NE_CLK_APB_BUS_PER1)
+				parents[i].fw_name = "sys_clk_apb_bus_per1";
+			else if (pidx == SYSCRG_NE_CLK_APB_BUS_PER2)
+				parents[i].fw_name = "sys_clk_apb_bus_per2";
+			else if (pidx == SYSCRG_NE_CLK_APB_BUS_PER3)
+				parents[i].fw_name = "sys_clk_apb_bus_per3";
+			else if (pidx == SYSCRG_NE_CLK_APB_BUS_PER5)
+				parents[i].fw_name = "sys_clk_apb_bus_per5";
+			else if (pidx == SYSCRG_NE_CLK_VENC_ROOT)
+				parents[i].fw_name = "sys_clk_venc_root";
+			else if (pidx == SYSCRG_NE_CLK_SPI_CORE_100)
+				parents[i].fw_name = "sys_clk_spi_core_100";
+		}
+
+		clk->hw.init = &init;
+		clk->idx = idx;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
+
+		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh8100_syscrg_ne_clk_get, priv);
+	if (ret)
+		return ret;
+
+	return jh8100_reset_controller_register(priv, "rst-sys-ne", 2);
+}
+
+static const struct of_device_id jh8100_syscrg_ne_match[] = {
+	{ .compatible = "starfive,jh8100-syscrg-ne" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jh8100_syscrg_ne_driver = {
+	.driver = {
+		.name = "clk-starfive-jh8100-sys-ne",
+		.of_match_table = jh8100_syscrg_ne_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jh8100_syscrg_ne_driver, jh8100_syscrg_ne_probe);
-- 
2.34.1

