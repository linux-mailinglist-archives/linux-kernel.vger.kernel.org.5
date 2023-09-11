Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880AA79B34A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbjIKVUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbjIKOHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:07:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A57FE4D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:07:41 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BE7BVU019834;
        Mon, 11 Sep 2023 09:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694441231;
        bh=yUIVDHM73GVN85ouQKGhovdttM7uqSrGqTd+WPmXDQA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Mfj3pXN/gGB9422NCrA1WoxDZzLxxK8STtO8VckUxdNjP6t4+NvhnzYSxp/TvrEHw
         CrJTH2LXoCT/mOpZqATqLhzLL8A6yOxdoIU5H8LcrBa5nSuDMnFEPWIO3DbiX+Wcqu
         ueUNicp6PpNEQvARDHcwNmmEYp/7natkKOfZXpgM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BE7B82014144
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 09:07:11 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 09:07:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 09:07:11 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BE765j120291;
        Mon, 11 Sep 2023 09:07:10 -0500
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
Subject: [PATCH v2 7/8] ARM: mach-sunplus: Rework support and directory structure
Date:   Mon, 11 Sep 2023 09:07:04 -0500
Message-ID: <20230911140705.59297-8-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911140705.59297-1-afd@ti.com>
References: <20230911140705.59297-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index bece2a6dff399..1cde1173e8ae2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2795,7 +2795,6 @@ F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.ya
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
 F:	arch/arm/boot/dts/sunplus/
 F:	arch/arm/configs/sp7021_*defconfig
-F:	arch/arm/mach-sunplus/
 F:	drivers/clk/clk-sp7021.c
 F:	drivers/irqchip/irq-sp7021-intc.c
 F:	drivers/reset/reset-sunplus.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5002d507bd081..772e7f4df3cd5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -446,8 +446,6 @@ source "arch/arm/mach-sti/Kconfig"
 
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
index e20c8af34d518..63808ed5cf9fd 100644
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

