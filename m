Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B12E767699
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjG1Tud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjG1Tua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:50:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11594233;
        Fri, 28 Jul 2023 12:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5597A621E8;
        Fri, 28 Jul 2023 19:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1254C433C8;
        Fri, 28 Jul 2023 19:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690573827;
        bh=Uhb4CoVwQdUAFNAoTx59QYDdvOku9LQN7I2Xj235slo=;
        h=From:To:Cc:Subject:Date:From;
        b=kMkDzkupEJ7UwhLqRLDz0S/7K9GODS+QjM73pQ76JpSMCGgY2cheYZwDBWisFTaVW
         +6dvlZ9K4yUFZ3SwH3vHr46xa/0AnL5nfie9Aea3/O6k+j8Uw1+O+rrTe8WBTzbwB5
         m4o8uniBCCowQ8svcvdGJ6fni/CT6mzqUI0tpeQMh+EjFYOF4T2LMwM5pdGZYvLbrb
         3YYsBvF1RNax1Bw4a45EpH7wdiG3aHv2BZ84Qvd8RRhGN23ltYj4DW8prytWIz7csT
         ZFLfUmXaTTu7PVmuD2biiCo/faf6KD2eu27YF5R0fHCTNfJ6KLZa28lCFNRxU0P59U
         lCE7rOP4yl4HA==
Received: (nullmailer pid 1198653 invoked by uid 1000);
        Fri, 28 Jul 2023 19:50:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] watchdog: Enable COMPILE_TEST for more drivers
Date:   Fri, 28 Jul 2023 13:50:21 -0600
Message-Id: <20230728195022.1198555-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's quite a few watchdog drivers which are easily enabled for
COMPILE_TEST, so let's enable them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Passed allyesconfig builds on arm, arm64, x86, riscv, powerpc, sparc
---
 drivers/watchdog/Kconfig         | 80 ++++++++++++++++----------------
 drivers/watchdog/loongson1_wdt.c |  1 +
 2 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ee97d89dfc11..ce293378e548 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -307,7 +307,7 @@ config XILINX_WATCHDOG
 config XILINX_WINDOW_WATCHDOG
 	tristate "Xilinx window watchdog timer"
 	depends on HAS_IOMEM
-	depends on ARM64
+	depends on ARM64 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Window watchdog driver for the versal_wwdt IP core.
@@ -343,7 +343,7 @@ config RAVE_SP_WATCHDOG
 
 config MLX_WDT
 	tristate "Mellanox Watchdog"
-	depends on MELLANOX_PLATFORM
+	depends on MELLANOX_PLATFORM || COMPILE_TEST
 	select WATCHDOG_CORE
 	select REGMAP
 	help
@@ -493,7 +493,7 @@ config FTWDT010_WATCHDOG
 
 config IXP4XX_WATCHDOG
 	tristate "IXP4xx Watchdog"
-	depends on ARCH_IXP4XX
+	depends on ARCH_IXP4XX || (ARM && COMPILE_TEST)
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
@@ -529,7 +529,7 @@ config S3C2410_WATCHDOG
 
 config SA1100_WATCHDOG
 	tristate "SA1100/PXA2xx watchdog"
-	depends on ARCH_SA1100 || ARCH_PXA
+	depends on ARCH_SA1100 || ARCH_PXA || COMPILE_TEST
 	help
 	  Watchdog timer embedded into SA11x0 and PXA2xx chips. This will
 	  reboot your system when timeout is reached.
@@ -720,7 +720,7 @@ config IMX2_WDT
 config IMX_SC_WDT
 	tristate "IMX SC Watchdog"
 	depends on HAVE_ARM_SMCCC
-	depends on IMX_SCU
+	depends on IMX_SCU || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This is the driver for the system controller watchdog
@@ -931,7 +931,7 @@ config ASPEED_WATCHDOG
 
 config STM32_WATCHDOG
 	tristate "STM32 Independent WatchDoG (IWDG) support"
-	depends on ARCH_STM32
+	depends on ARCH_STM32 || COMPILE_TEST
 	select WATCHDOG_CORE
 	default y
 	help
@@ -1065,7 +1065,7 @@ config ACQUIRE_WDT
 
 config ADVANTECH_WDT
 	tristate "Advantech SBC Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  If you are configuring a Linux kernel for the Advantech single-board
 	  computer, say `Y' here to support its built-in watchdog timer
@@ -1074,14 +1074,14 @@ config ADVANTECH_WDT
 
 config ADVANTECH_EC_WDT
 	tristate "Advantech Embedded Controller Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 		This driver supports Advantech products with ITE based Embedded Controller.
 		It does not support Advantech products with other ECs or without EC.
 
 config ALIM1535_WDT
 	tristate "ALi M1535 PMU Watchdog Timer"
-	depends on X86 && PCI
+	depends on (X86 || COMPILE_TEST) && PCI
 	help
 	  This is the driver for the hardware watchdog on the ALi M1535 PMU.
 
@@ -1105,7 +1105,7 @@ config ALIM7101_WDT
 
 config EBC_C384_WDT
 	tristate "WinSystems EBC-C384 Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	select ISA_BUS_API
 	select WATCHDOG_CORE
 	help
@@ -1115,7 +1115,7 @@ config EBC_C384_WDT
 
 config EXAR_WDT
 	tristate "Exar Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Enables watchdog timer support for the watchdog timer present
@@ -1126,7 +1126,7 @@ config EXAR_WDT
 
 config F71808E_WDT
 	tristate "Fintek F718xx, F818xx Super I/O Watchdog"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This is the driver for the hardware watchdog on the Fintek F71808E,
@@ -1138,7 +1138,7 @@ config F71808E_WDT
 
 config SP5100_TCO
 	tristate "AMD/ATI SP5100 TCO Timer/Watchdog"
-	depends on X86 && PCI
+	depends on (X86 || COMPILE_TEST) && PCI
 	select WATCHDOG_CORE
 	help
 	  Hardware watchdog driver for the AMD/ATI SP5100 chipset. The TCO
@@ -1177,7 +1177,7 @@ config SC520_WDT
 
 config SBC_FITPC2_WATCHDOG
 	tristate "Compulab SBC-FITPC2 watchdog"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  This is the driver for the built-in watchdog timer on the fit-PC2,
 	  fit-PC2i, CM-iAM single-board computers made by Compulab.
@@ -1202,7 +1202,7 @@ config SBC_FITPC2_WATCHDOG
 
 config EUROTECH_WDT
 	tristate "Eurotech CPU-1220/1410 Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  Enable support for the watchdog timer on the Eurotech CPU-1220 and
 	  CPU-1410 cards.  These are PC/104 SBCs. Spec sheets and product
@@ -1210,7 +1210,7 @@ config EUROTECH_WDT
 
 config IB700_WDT
 	tristate "IB700 SBC Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  This is the driver for the hardware watchdog on the IB700 Single
 	  Board Computer produced by TMC Technology (www.tmc-uk.com). This
@@ -1227,7 +1227,7 @@ config IB700_WDT
 
 config IBMASR
 	tristate "IBM Automatic Server Restart"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  This is the driver for the IBM Automatic Server Restart watchdog
 	  timer built-in into some eServer xSeries machines.
@@ -1237,7 +1237,7 @@ config IBMASR
 
 config WAFER_WDT
 	tristate "ICP Single Board Computer Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  This is a driver for the hardware watchdog on the ICP Single
 	  Board Computer. This driver is working on (at least) the following
@@ -1259,7 +1259,7 @@ config I6300ESB_WDT
 
 config IE6XX_WDT
 	tristate "Intel Atom E6xx Watchdog"
-	depends on X86 && PCI
+	depends on (X86 || COMPILE_TEST) && PCI
 	select WATCHDOG_CORE
 	select MFD_CORE
 	select LPC_SCH
@@ -1319,7 +1319,7 @@ config ITCO_VENDOR_SUPPORT
 
 config IT8712F_WDT
 	tristate "IT8712F (Smart Guardian) Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  This is the driver for the built-in watchdog timer on the IT8712F
 	  Super I/0 chipset used on many motherboards.
@@ -1332,7 +1332,7 @@ config IT8712F_WDT
 
 config IT87_WDT
 	tristate "IT87 Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This is the driver for the hardware watchdog on the ITE IT8607,
@@ -1350,7 +1350,7 @@ config IT87_WDT
 config HP_WATCHDOG
 	tristate "HP ProLiant iLO2+ Hardware Watchdog Timer"
 	select WATCHDOG_CORE
-	depends on (ARM64 || X86) && PCI
+	depends on (ARM64 || X86 || COMPILE_TEST) && PCI
 	help
 	  A software monitoring watchdog and NMI handling driver. This driver
 	  will detect lockups and provide a stack trace. This is a driver that
@@ -1380,7 +1380,7 @@ config KEMPLD_WDT
 
 config SC1200_WDT
 	tristate "National Semiconductor PC87307/PC97307 (ala SC1200) Watchdog"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  This is a driver for National Semiconductor PC87307/PC97307 hardware
 	  watchdog cards as found on the SC1200. This watchdog is mainly used
@@ -1403,7 +1403,7 @@ config SCx200_WDT
 
 config PC87413_WDT
 	tristate "NS PC87413 watchdog"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  This is the driver for the hardware watchdog on the PC87413 chipset
 	  This watchdog simply watches your kernel to make sure it doesn't
@@ -1417,7 +1417,7 @@ config PC87413_WDT
 
 config NV_TCO
 	tristate "nVidia TCO Timer/Watchdog"
-	depends on X86 && PCI
+	depends on (X86 || COMPILE_TEST) && PCI
 	help
 	  Hardware driver for the TCO timer built into the nVidia Hub family
 	  (such as the MCP51).  The TCO (Total Cost of Ownership) timer is a
@@ -1446,7 +1446,7 @@ config RDC321X_WDT
 
 config 60XX_WDT
 	tristate "SBC-60XX Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  This driver can be used with the watchdog timer found on some
 	  single board computers, namely the 6010 PII based computer.
@@ -1486,7 +1486,7 @@ config SBC7240_WDT
 
 config CPU5_WDT
 	tristate "SMA CPU5 Watchdog"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  TBD.
 	  To compile this driver as a module, choose M here: the
@@ -1494,7 +1494,7 @@ config CPU5_WDT
 
 config SMSC_SCH311X_WDT
 	tristate "SMSC SCH311X Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  This is the driver for the hardware watchdog timer on the
 	  SMSC SCH3112, SCH3114 and SCH3116 Super IO chipset
@@ -1506,7 +1506,7 @@ config SMSC_SCH311X_WDT
 
 config SMSC37B787_WDT
 	tristate "Winbond SMsC37B787 Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  This is the driver for the hardware watchdog component on the
 	  Winbond SMsC37B787 chipset as used on the NetRunner Mainboard
@@ -1526,7 +1526,7 @@ config SMSC37B787_WDT
 
 config TQMX86_WDT
 	tristate "TQ-Systems TQMX86 Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This is the driver for the hardware watchdog timer in the TQMX86 IO
@@ -1539,7 +1539,7 @@ config TQMX86_WDT
 
 config VIA_WDT
 	tristate "VIA Watchdog Timer"
-	depends on X86 && PCI
+	depends on (X86 || COMPILE_TEST) && PCI
 	select WATCHDOG_CORE
 	help
 	  This is the driver for the hardware watchdog timer on VIA
@@ -1552,7 +1552,7 @@ config VIA_WDT
 
 config W83627HF_WDT
 	tristate "Watchdog timer for W83627HF/W83627DHG and compatibles"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This is the driver for the hardware watchdog on the following
@@ -1582,7 +1582,7 @@ config W83627HF_WDT
 
 config W83877F_WDT
 	tristate "W83877F (EMACS) Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  This is the driver for the hardware watchdog on the W83877F chipset
 	  as used in EMACS PC-104 motherboards (and likely others).  This
@@ -1597,7 +1597,7 @@ config W83877F_WDT
 
 config W83977F_WDT
 	tristate "W83977F (PCM-5335) Watchdog Timer"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  This is the driver for the hardware watchdog on the W83977F I/O chip
 	  as used in AAEON's PCM-5335 SBC (and likely others).  This
@@ -1610,7 +1610,7 @@ config W83977F_WDT
 
 config MACHZ_WDT
 	tristate "ZF MachZ Watchdog"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  If you are using a ZF Micro MachZ processor, say Y here, otherwise
 	  N.  This is the driver for the watchdog timer built-in on that
@@ -1623,7 +1623,7 @@ config MACHZ_WDT
 
 config SBC_EPX_C3_WATCHDOG
 	tristate "Winsystems SBC EPX-C3 watchdog"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	help
 	  This is the driver for the built-in watchdog timer on the EPX-C3
 	  Single-board computer made by Winsystems, Inc.
@@ -1738,7 +1738,7 @@ config INDYDOG
 
 config JZ4740_WDT
 	tristate "Ingenic jz4740 SoC hardware watchdog"
-	depends on MIPS
+	depends on MIPS || COMPILE_TEST
 	depends on COMMON_CLK
 	select WATCHDOG_CORE
 	select MFD_SYSCON
@@ -1822,7 +1822,7 @@ config BCM_KONA_WDT
 
 config BCM_KONA_WDT_DEBUG
 	bool "DEBUGFS support for BCM Kona Watchdog"
-	depends on BCM_KONA_WDT
+	depends on BCM_KONA_WDT || COMPILE_TEST
 	help
 	  If enabled, adds /sys/kernel/debug/bcm_kona_wdt/info which provides
 	  access to the driver's internal data structures as well as watchdog
@@ -1863,7 +1863,7 @@ config LANTIQ_WDT
 
 config LOONGSON1_WDT
 	tristate "Loongson1 SoC hardware watchdog"
-	depends on MACH_LOONGSON32
+	depends on MACH_LOONGSON32 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Hardware driver for the Loongson1 SoC Watchdog Timer.
@@ -1877,7 +1877,7 @@ config RALINK_WDT
 
 config GXP_WATCHDOG
 	tristate "HPE GXP watchdog support"
-	depends on ARCH_HPE_GXP
+	depends on ARCH_HPE_GXP || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include support for the watchdog timer
diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
index 4ac7810a314d..0587ff44d3a1 100644
--- a/drivers/watchdog/loongson1_wdt.c
+++ b/drivers/watchdog/loongson1_wdt.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-- 
2.40.1

