Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A53806F10
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378119AbjLFLvn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378010AbjLFLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:51:08 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE2CD4F;
        Wed,  6 Dec 2023 03:51:04 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id F02FA24E308;
        Wed,  6 Dec 2023 19:51:02 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 19:51:02 +0800
Received: from jsia-virtual-machine.localdomain (175.136.135.142) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 6 Dec 2023 19:50:55 +0800
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
Subject: [PATCH v1 06/16] clk: starfive: Add JH8100 System clock generator driver
Date:   Wed, 6 Dec 2023 19:49:50 +0800
Message-ID: <20231206115000.295825-7-jeeheng.sia@starfivetech.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for JH8100 System clock generator.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 MAINTAINERS                                   |   8 +
 drivers/clk/starfive/Kconfig                  |   9 +
 drivers/clk/starfive/Makefile                 |   1 +
 drivers/clk/starfive/clk-starfive-common.h    |   9 +-
 drivers/clk/starfive/jh8100/Makefile          |   3 +
 .../clk/starfive/jh8100/clk-starfive-jh8100.h |  11 +
 drivers/clk/starfive/jh8100/clk-sys.c         | 455 ++++++++++++++++++
 7 files changed, 495 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/starfive/jh8100/Makefile
 create mode 100644 drivers/clk/starfive/jh8100/clk-starfive-jh8100.h
 create mode 100644 drivers/clk/starfive/jh8100/clk-sys.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 788be9ab5b73..87bcb25becc1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20763,6 +20763,14 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
 F:	drivers/phy/starfive/phy-jh7110-pcie.c
 F:	drivers/phy/starfive/phy-jh7110-usb.c
 
+STARFIVE JH8100 CLOCK DRIVERS
+M:	Sia Jee Heng <jeeheng.sia@starfivetech.com>
+M:	Ley Foon Tan <leyfoon.tan@starfivetech.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/starfive,jh81*.yaml
+F:	drivers/clk/starfive/jh8100
+F:	include/dt-bindings/clock/starfive?jh81*.h
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index ff8eace36e64..d8c7b9bb3895 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -72,3 +72,12 @@ config CLK_STARFIVE_JH7110_VOUT
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
+	  Say yes here to support the System clock controller on the StarFive JH8100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 012f7ee83f8e..6cb3ce823330 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)	+= clk-starfive-jh7110-aon.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_STG)	+= clk-starfive-jh7110-stg.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
+obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)	+= jh8100/
diff --git a/drivers/clk/starfive/clk-starfive-common.h b/drivers/clk/starfive/clk-starfive-common.h
index fed45311360c..ec30af0658cf 100644
--- a/drivers/clk/starfive/clk-starfive-common.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -103,6 +103,13 @@ struct starfive_clk_data {
 	.parents = { [0] = _parent },						\
 }
 
+#define STARFIVE_GINV(_idx, _name, _flags, _parent)[_idx] = {			\
+	.name = _name,								\
+	.flags = _flags,							\
+	.max = STARFIVE_CLK_ENABLE | STARFIVE_CLK_INVERT,			\
+	.parents = { [0] = _parent },						\
+}
+
 struct starfive_clk {
 	struct clk_hw hw;
 	unsigned int idx;
@@ -114,7 +121,7 @@ struct starfive_clk_priv {
 	spinlock_t rmw_lock;
 	struct device *dev;
 	void __iomem *base;
-	struct clk_hw *pll[3];
+	struct clk_hw *pll[8];
 	struct starfive_clk reg[];
 };
 
diff --git a/drivers/clk/starfive/jh8100/Makefile b/drivers/clk/starfive/jh8100/Makefile
new file mode 100644
index 000000000000..af6a09e220d3
--- /dev/null
+++ b/drivers/clk/starfive/jh8100/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+# StarFive JH8100 Clock
+obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)		+= clk-sys.o
diff --git a/drivers/clk/starfive/jh8100/clk-starfive-jh8100.h b/drivers/clk/starfive/jh8100/clk-starfive-jh8100.h
new file mode 100644
index 000000000000..7c8249c11464
--- /dev/null
+++ b/drivers/clk/starfive/jh8100/clk-starfive-jh8100.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CLK_STARFIVE_JH8100_H
+#define __CLK_STARFIVE_JH8100_H
+
+#include "../clk-starfive-common.h"
+
+int jh8100_reset_controller_register(struct starfive_clk_priv *priv,
+				     const char *adev_name,
+				     u32 adev_id);
+
+#endif
diff --git a/drivers/clk/starfive/jh8100/clk-sys.c b/drivers/clk/starfive/jh8100/clk-sys.c
new file mode 100644
index 000000000000..e2c802523c7d
--- /dev/null
+++ b/drivers/clk/starfive/jh8100/clk-sys.c
@@ -0,0 +1,455 @@
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
+/* external clocks */
+#define SYSCRG_CLK_OSC				(SYSCRG_CLK_END + 0)
+#define SYSCRG_CLK_MCLK_EXT			(SYSCRG_CLK_END + 1)
+#define SYSCRG_CLK_PLL0_OUT			(SYSCRG_CLK_END + 2)
+#define SYSCRG_CLK_PLL1_OUT			(SYSCRG_CLK_END + 3)
+#define SYSCRG_CLK_PLL2_OUT			(SYSCRG_CLK_END + 4)
+#define SYSCRG_CLK_PLL3_OUT			(SYSCRG_CLK_END + 5)
+#define SYSCRG_CLK_PLL4_OUT			(SYSCRG_CLK_END + 6)
+#define SYSCRG_CLK_PLL6_OUT			(SYSCRG_CLK_END + 7)
+#define SYSCRG_CLK_PLL7_OUT			(SYSCRG_CLK_END + 8)
+
+static const struct starfive_clk_data jh8100_syscrg_clk_data[] __initconst = {
+	/* root */
+	STARFIVE__DIV(SYSCRG_CLK_VDEC_ROOT_PREOSC, "sys_clk_vdec_root_preosc", 10,
+		      SYSCRG_CLK_PLL7_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_VDEC_ROOT, "sys_clk_vdec_root", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_VDEC_ROOT_PREOSC),
+	STARFIVE__DIV(SYSCRG_CLK_VENC_ROOT_PREOSC, "sys_clk_venc_root_preosc", 10,
+		      SYSCRG_CLK_PLL7_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_VENC_ROOT, "sys_clk_venc_root", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_VENC_ROOT_PREOSC),
+	STARFIVE__DIV(SYSCRG_CLK_GPU_ROOT, "sys_clk_gpu_root", 7,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_GPU_CORE, "sys_clk_gpu_core", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_GPU_ROOT),
+	STARFIVE__DIV(SYSCRG_CLK_VOUT_ROOT0_PREOSC, "sys_clk_vout_root0_preosc", 127,
+		      SYSCRG_CLK_PLL1_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_VOUT_ROOT0, "sys_clk_vout_root0", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_VOUT_ROOT0_PREOSC),
+	STARFIVE__DIV(SYSCRG_CLK_VOUT_ROOT1_PREOSC, "sys_clk_vout_root1_preosc", 127,
+		      SYSCRG_CLK_PLL6_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_VOUT_ROOT1, "sys_clk_vout_root1", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_VOUT_ROOT1_PREOSC),
+	STARFIVE__DIV(SYSCRG_CLK_VOUT_SCAN_ATS, "sys_clk_vout_scan_ats", 6,
+		      SYSCRG_CLK_PLL3_OUT),
+	STARFIVE__DIV(SYSCRG_CLK_PERH_ROOT_PREOSC, "sys_clk_perh_root_preosc", 4,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_PERH_ROOT, "sys_clk_perh_root", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_PERH_ROOT_PREOSC),
+	STARFIVE__DIV(SYSCRG_CLK_AXI_200_PREOSC, "sys_clk_axi_200_preosc", 4,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_AXI_200, "sys_clk_axi_200", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_200_PREOSC),
+	STARFIVE__MUX(SYSCRG_CLK_AXI_200_GMAC, "sys_clk_axi_200_gmac", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_200_PREOSC),
+	STARFIVE__DIV(SYSCRG_CLK_AXI_500_PREOSC, "sys_clk_axi_500_preosc", 10,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_AXI_500, "sys_clk_axi_500", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_500_PREOSC),
+	STARFIVE__MUX(SYSCRG_CLK_AXI_500_PCIEX1A, "sys_clk_axi_500_pciex1a", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_500_PREOSC),
+	STARFIVE__MUX(SYSCRG_CLK_AXI_500_PCIEX1B, "sys_clk_axi_500_pciex1b", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_500_PREOSC),
+	STARFIVE__MUX(SYSCRG_CLK_AXI_500_PCIEX2, "sys_clk_axi_500_pciex2", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_500_PREOSC),
+	STARFIVE__MUX(SYSCRG_CLK_AXI_500_PCIEX8, "sys_clk_axi_500_pciex8", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_500_PREOSC),
+	STARFIVE__DIV(SYSCRG_CLK_AXI_400_PREOSC, "sys_clk_axi_400_preosc", 10,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_AXI_400, "sys_clk_axi_400", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_400_PREOSC),
+	STARFIVE__MUX(SYSCRG_CLK_AXI_400_APBOOTRAM, "sys_clk_axi_400_apbootram", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_400_PREOSC),
+	STARFIVE__DIV(SYSCRG_CLK_AXI_125_PREOSC, "sys_clk_axi_125_preosc", 32,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_AXI_125, "sys_clk_axi_125", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_AXI_125_PREOSC),
+	STARFIVE__DIV(SYSCRG_CLK_AHB0_PREOSC, "sys_clk_ahb0_preosc", 15,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_AHB0, "sys_clk_ahb0", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_AHB0_PREOSC),
+	STARFIVE__DIV(SYSCRG_CLK_APB_BUS_FUNC, "sys_clk_apb_bus_func", 30,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_APB_BUS, "sys_clk_apb_bus", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
+	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER0, "sys_clk_apb_bus_per0", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
+	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER1, "sys_clk_apb_bus_per1", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
+	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER2, "sys_clk_apb_bus_per2", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
+	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER3, "sys_clk_apb_bus_per3", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
+	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER4, "sys_clk_apb_bus_per4", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
+	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER5, "sys_clk_apb_bus_per5", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
+	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER6, "sys_clk_apb_bus_per6", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
+	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER7, "sys_clk_apb_bus_per7", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
+	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER8, "sys_clk_apb_bus_per8", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
+	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER9, "sys_clk_apb_bus_per9", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
+	STARFIVE__MUX(SYSCRG_CLK_APB_BUS_PER10, "sys_clk_apb_bus_per10", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
+	STARFIVE__MUX(SYSCRG_CLK_SPI_CORE_100, "sys_clk_spi_core_100", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_APB_BUS_FUNC),
+	STARFIVE__DIV(SYSCRG_CLK_PLL1_DIV2, "sys_clk_pll1_div2", 2,
+		      SYSCRG_CLK_PLL1_OUT),
+	STARFIVE__DIV(SYSCRG_CLK_PLL2_DIV2, "sys_clk_pll2_div2", 2,
+		      SYSCRG_CLK_PLL2_OUT),
+	STARFIVE__DIV(SYSCRG_CLK_PLL3_DIV2, "sys_clk_pll3_div2", 2,
+		      SYSCRG_CLK_PLL3_OUT),
+	STARFIVE__DIV(SYSCRG_CLK_PLL4_DIV2, "sys_clk_pll4_div2", 2,
+		      SYSCRG_CLK_PLL4_OUT),
+	STARFIVE__DIV(SYSCRG_CLK_PLL6_DIV2, "sys_clk_pll6_div2", 2,
+		      SYSCRG_CLK_PLL6_OUT),
+	STARFIVE__DIV(SYSCRG_CLK_PLL7_DIV2, "sys_clk_pll7_div2", 2,
+		      SYSCRG_CLK_PLL7_OUT),
+	STARFIVE__DIV(SYSCRG_CLK_AUDIO_ROOT, "sys_clk_audio_root", 8,
+		      SYSCRG_CLK_PLL2_OUT),
+	STARFIVE__DIV(SYSCRG_CLK_MCLK_INNER, "sys_clk_mclk_inner", 64,
+		      SYSCRG_CLK_AUDIO_ROOT),
+	STARFIVE__MUX(SYSCRG_CLK_MCLK, "sys_clk_mclk", 2,
+		      SYSCRG_CLK_MCLK_INNER, SYSCRG_CLK_MCLK_EXT),
+	STARFIVE_GATE(SYSCRG_CLK_MCLK_OUT, "sys_clk_mclk_out", 0,
+		      SYSCRG_CLK_MCLK_INNER),
+	STARFIVE_MDIV(SYSCRG_CLK_ISP_2X_PREOSC, "sys_clk_isp_2x_preosc", 8, 2,
+		      SYSCRG_CLK_PLL7_OUT, SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_ISP_2X, "sys_clk_isp_2x", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_ISP_2X_PREOSC),
+	STARFIVE__DIV(SYSCRG_CLK_ISP_AXI, "sys_clk_isp_axi", 4,
+		      SYSCRG_CLK_ISP_2X),
+	STARFIVE_GDIV(SYSCRG_CLK_GCLK1, "sys_clk_gclk1", CLK_IS_CRITICAL, 120,
+		      SYSCRG_CLK_PLL1_DIV2),
+	STARFIVE_GDIV(SYSCRG_CLK_GCLK2, "sys_clk_gclk2", CLK_IS_CRITICAL, 120,
+		      SYSCRG_CLK_PLL2_DIV2),
+	STARFIVE_GDIV(SYSCRG_CLK_GCLK3, "sys_clk_gclk3", CLK_IS_CRITICAL, 120,
+		      SYSCRG_CLK_PLL3_DIV2),
+	STARFIVE_GDIV(SYSCRG_CLK_GCLK4, "sys_clk_gclk4", CLK_IS_CRITICAL, 120,
+		      SYSCRG_CLK_PLL4_DIV2),
+	STARFIVE_GDIV(SYSCRG_CLK_GCLK6, "sys_clk_gclk6", CLK_IS_CRITICAL, 120,
+		      SYSCRG_CLK_PLL6_DIV2),
+	STARFIVE_GDIV(SYSCRG_CLK_GCLK7, "sys_clk_gclk7", CLK_IS_CRITICAL, 120,
+		      SYSCRG_CLK_PLL7_DIV2),
+	/* flexnoc (se) */
+	STARFIVE__DIV(SYSCRG_CLK_FLEXNOC0_PREOSC, "sys_clk_flexnoc0_preosc", 8,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_FLEXNOC0, "sys_clk_flexnoc0", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_FLEXNOC0_PREOSC),
+	STARFIVE__DIV(SYSCRG_CLK_FLEXNOC1_PREOSC, "sys_clk_flexnoc1_preosc", 8,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_FLEXNOC1, "sys_clk_flexnoc1", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_FLEXNOC1_PREOSC),
+	STARFIVE__DIV(SYSCRG_CLK_FLEXNOC2_PREOSC, "sys_clk_flexnoc2_preosc", 12,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_FLEXNOC2, "sys_clk_flexnoc2", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_FLEXNOC2_PREOSC),
+	STARFIVE__MUX(SYSCRG_CLK_VDEC_CORE, "sys_clk_vdec_core", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_FLEXNOC1_PREOSC),
+	/* img_gpu (se) */
+	STARFIVE_GATE(SYSCRG_CLK_GPU_CORE_ICG, "sys_clk_gpu_core_icg", 0,
+		      SYSCRG_CLK_GPU_CORE),
+	STARFIVE_GATE(SYSCRG_CLK_IMG_GPU_CLK_APB, "sys_clk_img_gpu_clk_apb", 0,
+		      SYSCRG_CLK_APB_BUS_PER7),
+	STARFIVE_GATE(SYSCRG_CLK_IMG_GPU_RTC_TOGGLE, "sys_clk_img_gpu_rtc_toggle", 0,
+		      SYSCRG_CLK_OSC),
+	STARFIVE_GATE(SYSCRG_CLK_IMG_GPU_TIMER_USC, "sys_clk_img_gpu_timer_usc", 0,
+		      SYSCRG_CLK_OSC),
+	/* hifi4 (se) */
+	STARFIVE__DIV(SYSCRG_CLK_HIFI4_CORE_PREOSC, "sys_clk_hifi4_core_preosc", 15,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_HIFI4_CORE, "sys_clk_hifi4_core", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_HIFI4_CORE_PREOSC),
+	/* espi */
+	STARFIVE__DIV(SYSCRG_CLK_ESPI_200_PREOSC, "sys_clk_espi_200_preosc", 2,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__MUX(SYSCRG_CLK_ESPI_200, "sys_clk_espi_200", 2,
+		      SYSCRG_CLK_OSC, SYSCRG_CLK_ESPI_200_PREOSC),
+	/* hd audio */
+	STARFIVE__DIV(SYSCRG_CLK_HD_AUDIO_48M, "sys_clk_hd_audio_48m", 80,
+		      SYSCRG_CLK_PLL7_OUT),
+	/* dom vout */
+	STARFIVE__DIV(SYSCRG_CLK_VOUT_DC_CORE, "sys_clk_vout_dc_core", 10,
+		      SYSCRG_CLK_PLL7_OUT),
+	STARFIVE__DIV(SYSCRG_CLK_VOUT_AXI, "sys_clk_vout_axi", 10,
+		      SYSCRG_CLK_PLL7_OUT),
+	/* stg2_usb_wrap (se) */
+	STARFIVE__DIV(SYSCRG_CLK_USB_WRAP_625, "sys_clk_usb_wrap_625", 6,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__DIV(SYSCRG_CLK_USB_WRAP_480, "sys_clk_usb_wrap_480", 8,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__DIV(SYSCRG_CLK_USB_WRAP_240, "sys_clk_usb_wrap_240", 2,
+		      SYSCRG_CLK_USB_WRAP_480),
+	STARFIVE__DIV(SYSCRG_CLK_USB_WRAP_60, "sys_clk_usb_wrap_60", 10,
+		      SYSCRG_CLK_USB_WRAP_480),
+	STARFIVE__DIV(SYSCRG_CLK_USB_WRAP_156P25, "sys_clk_usb_wrap_156p25", 4,
+		      SYSCRG_CLK_USB_WRAP_625),
+	STARFIVE__DIV(SYSCRG_CLK_USB_WRAP_312P5, "sys_clk_usb_wrap_312p5", 2,
+		      SYSCRG_CLK_USB_WRAP_625),
+	/* stg */
+	STARFIVE__DIV(SYSCRG_CLK_USB_125M, "sys_clk_usb_125m", 32,
+		      SYSCRG_CLK_PLL0_OUT),
+	/* Flexnoc (se) */
+	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_APBOOTRAM, "sys_clk_flexnoc_apbootram",
+		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_400_APBOOTRAM),
+	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX1AMST, "sys_clk_flexnoc_pciex1amst",
+		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX1A),
+	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX1ASLV, "sys_clk_flexnoc_pciex1aslv",
+		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX1A),
+	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX1BMST, "sys_clk_flexnoc_pciex1bmst",
+		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX1B),
+	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX1BSLV, "sys_clk_flexnoc_pciex1bslv",
+		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX1B),
+	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX2MST, "sys_clk_flexnoc_pciex2mst",
+		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX2),
+	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX2SLV, "sys_clk_flexnoc_pciex2slv",
+		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX2),
+	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX8MST, "sys_clk_flexnoc_pciex8mst",
+		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX8),
+	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_PCIEX8SLV, "sys_clk_flexnoc_pciex8slv",
+		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_500_PCIEX8),
+	STARFIVE_GATE(SYSCRG_CLK_FLEXNOC_GMACSYSSLV, "sys_clk_flexnoc_gmacsysslv",
+		      CLK_IS_CRITICAL, SYSCRG_CLK_AXI_200_GMAC),
+	/* gmac1 (se) */
+	STARFIVE__DIV(SYSCRG_CLK_GMAC_SRC, "sys_clk_gmac_src", 7,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__DIV(SYSCRG_CLK_GMAC1_GTXCLK_TOP, "sys_clk_gmac1_gtxclk_top", 400,
+		      SYSCRG_CLK_PLL0_OUT),
+	STARFIVE__DIV(SYSCRG_CLK_GMAC1_PTP, "sys_clk_gmac1_ptp", 31,
+		      SYSCRG_CLK_GMAC_SRC),
+	/* hd audio */
+	STARFIVE_GATE(SYSCRG_CLK_HD_AUDIO_SYSTEM_CLOCK, "sys_clk_hd_audio_system_clock",
+		      0, SYSCRG_CLK_APB_BUS_PER7),
+	STARFIVE_GATE(SYSCRG_CLK_HD_AUDIO_CLOCK_48, "sys_clk_hd_audio_clock_48",
+		      0, SYSCRG_CLK_HD_AUDIO_48M),
+	STARFIVE_GATE(SYSCRG_CLK_HD_AUDIO_BCLK_POST_OCC_IN, "sys_clk_hd_audio_bclk_post_occ_in",
+		      0, SYSCRG_CLK_HD_AUDIO_48M),
+	/* nne_vip (se) */
+	STARFIVE_GATE(SYSCRG_CLK_NNE_VIP_ACLK, "sys_clk_nne_vip_aclk",
+		      0, SYSCRG_CLK_AXI_500),
+	STARFIVE_GATE(SYSCRG_CLK_NNE_VIP_HCLK, "sys_clk_nne_vip_hclk",
+		      0, SYSCRG_CLK_AXI_200),
+	STARFIVE_GMUX(SYSCRG_CLK_NNE_VIP_CLKCORE, "sys_clk_nne_vip_clkcore", 0, 2,
+		      SYSCRG_CLK_PLL2_OUT,
+		      SYSCRG_CLK_PLL0_OUT),
+	/* icg_en */
+	STARFIVE_GATE(SYSCRG_CLK_GPU_ICG_EN, "sys_clk_gpu_en",
+		      0, SYSCRG_CLK_GPU_CORE),
+	STARFIVE_GATE(SYSCRG_CLK_HD_AUDIO_ICG_EN, "sys_clk_hd_audio_en",
+		      0, SYSCRG_CLK_APB_BUS),
+	STARFIVE_GATE(SYSCRG_CLK_NNE_ICG_EN, "sys_clk_nne_en",
+		      CLK_IGNORE_UNUSED, SYSCRG_CLK_PLL2_OUT),
+};
+
+static struct clk_hw *jh8100_sysclk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct starfive_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < SYSCRG_CLK_END)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static void jh8100_reset_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void jh8100_reset_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
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
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return -ENOMEM;
+
+	rdev->base = priv->base;
+
+	adev = &rdev->adev;
+	adev->name = adev_name;
+	adev->dev.parent = priv->dev;
+	adev->dev.release = jh8100_reset_adev_release;
+	adev->id = adev_id;
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(adev);
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
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, SYSCRG_CLK_END),
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
+	/* 24MHz -> 2000.0MHz */
+	priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "clk_pll0_out",
+							 "clk_osc", 0, 250, 3);
+	if (IS_ERR(priv->pll[0]))
+		return PTR_ERR(priv->pll[0]);
+
+	/* 24MHz -> 1782.0MHz */
+	priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "clk_pll1_out",
+							 "clk_osc", 0, 445, 6);
+	if (IS_ERR(priv->pll[1]))
+		return PTR_ERR(priv->pll[1]);
+
+	/* 24MHz -> 1843.2MHz */
+	priv->pll[2] = devm_clk_hw_register_fixed_factor(priv->dev, "clk_pll2_out",
+							 "clk_osc", 0, 767, 10);
+	if (IS_ERR(priv->pll[2]))
+		return PTR_ERR(priv->pll[2]);
+
+	/* 24MHz -> 1866MHz */
+	priv->pll[3] = devm_clk_hw_register_fixed_factor(priv->dev, "clk_pll3_out",
+							 "clk_osc", 0, 4665, 60);
+	if (IS_ERR(priv->pll[3]))
+		return PTR_ERR(priv->pll[3]);
+
+	/* 24MHz -> 2000MHz */
+	priv->pll[4] = devm_clk_hw_register_fixed_factor(priv->dev, "clk_pll4_out",
+							 "clk_osc", 0, 250, 3);
+	if (IS_ERR(priv->pll[4]))
+		return PTR_ERR(priv->pll[4]);
+
+	/* 24MHz -> 1782MHz */
+	priv->pll[5] = devm_clk_hw_register_fixed_factor(priv->dev, "clk_pll6_out",
+							 "clk_osc", 0, 445, 6);
+	if (IS_ERR(priv->pll[5]))
+		return PTR_ERR(priv->pll[5]);
+
+	/* 24MHz -> 2400MHz */
+	priv->pll[6] = devm_clk_hw_register_fixed_factor(priv->dev, "clk_pll7_out",
+							 "clk_osc", 0, 100, 1);
+	if (IS_ERR(priv->pll[6]))
+		return PTR_ERR(priv->pll[6]);
+
+	for (idx = 0; idx < SYSCRG_CLK_END; idx++) {
+		u32 max = jh8100_syscrg_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh8100_syscrg_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jh8100_syscrg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh8100_syscrg_clk_data[idx].parents[i];
+
+			if (pidx < SYSCRG_CLK_END)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == SYSCRG_CLK_OSC)
+				parents[i].fw_name = "clk_osc";
+			else if (pidx == SYSCRG_CLK_MCLK_EXT)
+				parents[i].fw_name = "clk_mclk_ext";
+			else if (pidx == SYSCRG_CLK_PLL1_OUT && !priv->pll[1])
+				parents[i].fw_name = "clk_pll1_out";
+			else if (pidx == SYSCRG_CLK_PLL2_OUT && !priv->pll[2])
+				parents[i].fw_name = "clk_pll2_out";
+			else if (pidx == SYSCRG_CLK_PLL6_OUT && !priv->pll[5])
+				parents[i].fw_name = "clk_pll6_out";
+			else
+				parents[i].hw = priv->pll[pidx - SYSCRG_CLK_PLL0_OUT];
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
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh8100_sysclk_get, priv);
+	if (ret)
+		return ret;
+
+	return jh8100_reset_controller_register(priv, "rst-sys", 0);
+}
+
+static const struct of_device_id jh8100_syscrg_match[] = {
+	{ .compatible = "starfive,jh8100-syscrg" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jh8100_syscrg_driver = {
+	.driver = {
+		.name = "clk-starfive-jh8100-sys",
+		.of_match_table = jh8100_syscrg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jh8100_syscrg_driver, jh8100_syscrg_probe);
-- 
2.34.1

