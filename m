Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958B77E9F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjKMOpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjKMOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:44:45 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E046810FB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:44:40 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEi6UT019412;
        Mon, 13 Nov 2023 08:44:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699886646;
        bh=2j2rZ0wAfPXMdUDaibcPxRQk4yh1F+v0/Ydsjhdm1W8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GRSJs4Vk+qhInhB/SOKF0wzoRUA7c3BJPmK3NOHtxGAEaeXpqbeuDA6j8BbMTY9qs
         PovTvoTbArwX06cI3Y4o2gSnnyHCSP36sf5C5llGzwFn9/Lzai4qw1Ld19uwzCisy+
         dYxkoZdj1L3MFh1Sh/PXGtQM+yHLXXozcfgoBETU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADEi63I020188
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Nov 2023 08:44:06 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 08:44:06 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 08:44:06 -0600
Received: from fllv0040.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEi0u1065232;
        Mon, 13 Nov 2023 08:44:05 -0600
From:   Andrew Davis <afd@ti.com>
To:     Russell King <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v3 7/9] ARM: mach-sunplus: Rework support and directory structure
Date:   Mon, 13 Nov 2023 08:43:57 -0600
Message-ID: <20231113144359.174140-8-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231113144359.174140-1-afd@ti.com>
References: <20231113144359.174140-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a platform need a mach-* directory should be seen as a negative,
it means the platform needs special non-standard handling. ARM64 support
does not allow mach-* directories at all. While we may not get to that
given all the non-standard architectures we support, we should still try
to get as close as we can and reduce the number of mach directories.

The mach-sunplus/ directory and files, provides just one "feature":
having the kernel print the machine name if the DTB does not also contain
a "model" string (which they always do). To reduce the number of mach-*
directories let's do without that feature and remove this directory.

NOTE: The default l2c_aux_mask is now ~0 but these devices never have
this type of cache controller so this is safe.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 MAINTAINERS                    |  1 -
 arch/arm/Kconfig               |  2 --
 arch/arm/Kconfig.platforms     | 29 +++++++++++++++++++++++++++++
 arch/arm/Makefile              |  1 -
 arch/arm/mach-sunplus/Kconfig  | 27 ---------------------------
 arch/arm/mach-sunplus/Makefile |  8 --------
 arch/arm/mach-sunplus/sp7021.c | 16 ----------------
 7 files changed, 29 insertions(+), 55 deletions(-)
 delete mode 100644 arch/arm/mach-sunplus/Kconfig
 delete mode 100644 arch/arm/mach-sunplus/Makefile
 delete mode 100644 arch/arm/mach-sunplus/sp7021.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b1ee757a4306d..73f1100014218 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2837,7 +2837,6 @@ F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.ya
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
 F:	arch/arm/boot/dts/sunplus/
 F:	arch/arm/configs/sp7021_*defconfig
-F:	arch/arm/mach-sunplus/
 F:	drivers/clk/clk-sp7021.c
 F:	drivers/irqchip/irq-sp7021-intc.c
 F:	drivers/reset/reset-sunplus.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fbdf366d260a6..395530fe22402 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -447,8 +447,6 @@ source "arch/arm/mach-sti/Kconfig"
 
 source "arch/arm/mach-stm32/Kconfig"
 
-source "arch/arm/mach-sunplus/Kconfig"
-
 source "arch/arm/mach-sunxi/Kconfig"
 
 source "arch/arm/mach-tegra/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index 38457d5a18fff..acaced2f0ab04 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -123,6 +123,35 @@ config ARCH_RDA
 	help
 	  This enables support for the RDA Micro 8810PL SoC family.
 
+menuconfig ARCH_SUNPLUS
+	bool "Sunplus SoCs"
+	depends on ARCH_MULTI_V7
+	help
+	  Support for Sunplus SoC family: SP7021 and succeeding SoC-based systems,
+	  such as the Banana Pi BPI-F2S development board (and derivatives).
+	  (<http://www.sinovoip.com.cn/ecp_view.asp?id=586>)
+	  (<https://tibbo.com/store/plus1.html>)
+
+if ARCH_SUNPLUS
+
+config SOC_SP7021
+	bool "Sunplus SP7021 SoC support"
+	default ARCH_SUNPLUS
+	select HAVE_ARM_ARCH_TIMER
+	select ARM_GIC
+	select ARM_PSCI
+	select PINCTRL
+	select PINCTRL_SPPCTL
+	select SERIAL_SUNPLUS if TTY
+	select SERIAL_SUNPLUS_CONSOLE if TTY
+	help
+	  Support for Sunplus SP7021 SoC. It is based on ARM 4-core
+	  Cortex-A7 with various peripherals (e.g.: I2C, SPI, SDIO,
+	  Ethernet, etc.), FPGA interface,  chip-to-chip bus.
+	  It is designed for industrial control.
+
+endif
+
 config ARCH_UNIPHIER
 	bool "Socionext UniPhier SoCs"
 	depends on ARCH_MULTI_V7
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index eb72b092d7b4a..699be64a74be6 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -216,7 +216,6 @@ machine-$(CONFIG_ARCH_RENESAS)	 	+= shmobile
 machine-$(CONFIG_ARCH_INTEL_SOCFPGA)	+= socfpga
 machine-$(CONFIG_ARCH_STI)		+= sti
 machine-$(CONFIG_ARCH_STM32)		+= stm32
-machine-$(CONFIG_ARCH_SUNPLUS)		+= sunplus
 machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U8500)		+= ux500
diff --git a/arch/arm/mach-sunplus/Kconfig b/arch/arm/mach-sunplus/Kconfig
deleted file mode 100644
index d0c2416e6f241..0000000000000
--- a/arch/arm/mach-sunplus/Kconfig
+++ /dev/null
@@ -1,27 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-
-menuconfig ARCH_SUNPLUS
-	bool "Sunplus SoCs"
-	depends on ARCH_MULTI_V7
-	help
-	  Support for Sunplus SoC family: SP7021 and succeeding SoC-based systems,
-	  such as the Banana Pi BPI-F2S development board (and derivatives).
-	  (<http://www.sinovoip.com.cn/ecp_view.asp?id=586>)
-	  (<https://tibbo.com/store/plus1.html>)
-
-config SOC_SP7021
-	bool "Sunplus SP7021 SoC support"
-	depends on ARCH_SUNPLUS
-	default ARCH_SUNPLUS
-	select HAVE_ARM_ARCH_TIMER
-	select ARM_GIC
-	select ARM_PSCI
-	select PINCTRL
-	select PINCTRL_SPPCTL
-	select SERIAL_SUNPLUS if TTY
-	select SERIAL_SUNPLUS_CONSOLE if TTY
-	help
-	  Support for Sunplus SP7021 SoC. It is based on ARM 4-core
-	  Cortex-A7 with various peripherals (e.g.: I2C, SPI, SDIO,
-	  Ethernet, etc.), FPGA interface,  chip-to-chip bus.
-	  It is designed for industrial control.
diff --git a/arch/arm/mach-sunplus/Makefile b/arch/arm/mach-sunplus/Makefile
deleted file mode 100644
index d211de6af2db9..0000000000000
--- a/arch/arm/mach-sunplus/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for the linux kernel.
-#
-
-# Object file lists.
-
-obj-$(CONFIG_SOC_SP7021)	+= sp7021.o
diff --git a/arch/arm/mach-sunplus/sp7021.c b/arch/arm/mach-sunplus/sp7021.c
deleted file mode 100644
index 774d0a5bd4eb0..0000000000000
--- a/arch/arm/mach-sunplus/sp7021.c
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-/*
- * Copyright (C) Sunplus Technology Co., Ltd.
- *       All rights reserved.
- */
-#include <linux/kernel.h>
-#include <asm/mach/arch.h>
-
-static const char *sp7021_compat[] __initconst = {
-	"sunplus,sp7021",
-	NULL
-};
-
-DT_MACHINE_START(SP7021_DT, "SP7021")
-	.dt_compat	= sp7021_compat,
-MACHINE_END
-- 
2.39.2

