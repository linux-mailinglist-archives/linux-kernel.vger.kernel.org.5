Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120FE79BB50
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376286AbjIKWTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238911AbjIKOHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:07:45 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F947E4B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:07:40 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BE7Ccm002273;
        Mon, 11 Sep 2023 09:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694441232;
        bh=8FAlNaoK0DNRCOuHhPsCy+Grb868tPFNeabgQpNF+ig=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SMpcMhD8z7RjaT5OkwKatqcsr0AMllF7hrBY71ay9IRKXakoni46VWGzanB9to1pN
         aSe/Wb1MUd/MpfnBaSAbUGyus9A+kNFGON6GOg0lMS6vNQombDLVI0rOv9PN5/HjG6
         ZRTdA2NMC8Pm2J/n32H+zL4ZYQgo/ETBKu/FAnTY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BE7C7X014154
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 09:07:12 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 09:07:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 09:07:11 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BE765k120291;
        Mon, 11 Sep 2023 09:07:11 -0500
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
Subject: [PATCH v2 8/8] ARM: mach-hpe: Rework support and directory structure
Date:   Mon, 11 Sep 2023 09:07:05 -0500
Message-ID: <20230911140705.59297-9-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911140705.59297-1-afd@ti.com>
References: <20230911140705.59297-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

The mach-hpe/ directory and files, provides just one "feature":
having the kernel print the machine name if the DTB does not also contain
a "model" string (which they always do). To reduce the number of mach-*
directories let's do without that feature and remove this directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 MAINTAINERS                |  1 -
 arch/arm/Kconfig           |  2 --
 arch/arm/Kconfig.platforms | 25 +++++++++++++++++++++++++
 arch/arm/Makefile          |  1 -
 arch/arm/mach-hpe/Kconfig  | 23 -----------------------
 arch/arm/mach-hpe/Makefile |  1 -
 arch/arm/mach-hpe/gxp.c    | 15 ---------------
 7 files changed, 25 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/mach-hpe/Kconfig
 delete mode 100644 arch/arm/mach-hpe/Makefile
 delete mode 100644 arch/arm/mach-hpe/gxp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cde1173e8ae2..11bcf8164a3a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2193,7 +2193,6 @@ F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
 F:	Documentation/hwmon/gxp-fan-ctrl.rst
 F:	arch/arm/boot/dts/hpe/
-F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
 F:	drivers/hwmon/gxp-fan-ctrl.c
 F:	drivers/i2c/busses/i2c-gxp.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 772e7f4df3cd5..808608f0e157c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -382,8 +382,6 @@ source "arch/arm/mach-highbank/Kconfig"
 
 source "arch/arm/mach-hisi/Kconfig"
 
-source "arch/arm/mach-hpe/Kconfig"
-
 source "arch/arm/mach-imx/Kconfig"
 
 source "arch/arm/mach-ixp4xx/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index acaced2f0ab04..b4ad800a17b7e 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -87,6 +87,31 @@ config MACH_ASM9260
 	help
 	  Support for Alphascale ASM9260 based platform.
 
+menuconfig ARCH_HPE
+	bool "HPE SoC support"
+	depends on ARCH_MULTI_V7
+	help
+	  This enables support for HPE ARM based BMC chips.
+
+if ARCH_HPE
+
+config ARCH_HPE_GXP
+	bool "HPE GXP SoC"
+	depends on ARCH_MULTI_V7
+	select ARM_VIC
+	select GENERIC_IRQ_CHIP
+	select CLKSRC_MMIO
+	help
+	  HPE GXP is the name of the HPE Soc. This SoC is used to implement many
+	  BMC features at HPE. It supports ARMv7 architecture based on the Cortex
+	  A9 core. It is capable of using an AXI bus to which a memory controller
+	  is attached. It has multiple SPI interfaces to connect boot flash and
+	  BIOS flash. It uses a 10/100/1000 MAC for network connectivity. It
+	  has multiple i2c engines to drive connectivity with a host
+	  infrastructure.
+
+endif
+
 menuconfig ARCH_MOXART
 	bool "MOXA ART SoC"
 	depends on ARCH_MULTI_V4
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 63808ed5cf9fd..0a7eb41313b6a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -184,7 +184,6 @@ machine-$(CONFIG_ARCH_FOOTBRIDGE)	+= footbridge
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
 machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_HISI)		+= hisi
-machine-$(CONFIG_ARCH_HPE)		+= hpe
 machine-$(CONFIG_ARCH_IXP4XX)		+= ixp4xx
 machine-$(CONFIG_ARCH_KEYSTONE)		+= keystone
 machine-$(CONFIG_ARCH_LPC18XX)		+= lpc18xx
diff --git a/arch/arm/mach-hpe/Kconfig b/arch/arm/mach-hpe/Kconfig
deleted file mode 100644
index 3372bbf38d383..0000000000000
--- a/arch/arm/mach-hpe/Kconfig
+++ /dev/null
@@ -1,23 +0,0 @@
-menuconfig ARCH_HPE
-	bool "HPE SoC support"
-	depends on ARCH_MULTI_V7
-	help
-	  This enables support for HPE ARM based BMC chips.
-if ARCH_HPE
-
-config ARCH_HPE_GXP
-	bool "HPE GXP SoC"
-	depends on ARCH_MULTI_V7
-	select ARM_VIC
-	select GENERIC_IRQ_CHIP
-	select CLKSRC_MMIO
-	help
-	  HPE GXP is the name of the HPE Soc. This SoC is used to implement many
-	  BMC features at HPE. It supports ARMv7 architecture based on the Cortex
-	  A9 core. It is capable of using an AXI bus to which a memory controller
-	  is attached. It has multiple SPI interfaces to connect boot flash and
-	  BIOS flash. It uses a 10/100/1000 MAC for network connectivity. It
-	  has multiple i2c engines to drive connectivity with a host
-	  infrastructure.
-
-endif
diff --git a/arch/arm/mach-hpe/Makefile b/arch/arm/mach-hpe/Makefile
deleted file mode 100644
index 8b0a91234df4e..0000000000000
--- a/arch/arm/mach-hpe/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_ARCH_HPE_GXP) += gxp.o
diff --git a/arch/arm/mach-hpe/gxp.c b/arch/arm/mach-hpe/gxp.c
deleted file mode 100644
index 581c8da517b86..0000000000000
--- a/arch/arm/mach-hpe/gxp.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
-
-#include <asm/mach/arch.h>
-
-static const char * const gxp_board_dt_compat[] = {
-	"hpe,gxp",
-	NULL,
-};
-
-DT_MACHINE_START(GXP_DT, "HPE GXP")
-	.dt_compat	= gxp_board_dt_compat,
-	.l2c_aux_val = 0,
-	.l2c_aux_mask = ~0,
-MACHINE_END
-- 
2.39.2

