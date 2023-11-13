Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D2A7E9F05
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjKMOoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjKMOoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:44:44 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5FA171C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:44:40 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEi7Xl129635;
        Mon, 13 Nov 2023 08:44:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699886647;
        bh=bzGE9Yrc+rwi/fH2bDKqDEhxMKUPsrtHRJDtG0zTHLM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZvoqTeYrpJQv0vr5eIGC7/LIHOJKXTvAmDo1D1z4yL2rbPUinVU4PuhWaMQXFQgDi
         qxhNQolusIaiH9CKzXgAuG07WKFuJ1iSfyLfj5vIqWljDMTq09377aku4+FARJ2mAD
         SamzWS8jNqZ5d1Sp5njLOvjImlBPu9UoeoXiDUoI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADEi7d3007976
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Nov 2023 08:44:07 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 08:44:07 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 08:44:07 -0600
Received: from fllv0040.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEi0u3065232;
        Mon, 13 Nov 2023 08:44:06 -0600
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
Subject: [PATCH v3 9/9] ARM: mach-nspire: Rework support and directory structure
Date:   Mon, 13 Nov 2023 08:43:59 -0600
Message-ID: <20231113144359.174140-10-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231113144359.174140-1-afd@ti.com>
References: <20231113144359.174140-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

The mach-nspire/ directory and files, provides just one "feature":
having the kernel print the machine name if the DTB does not also contain
a "model" string (which they always do). To reduce the number of mach-*
directories let's do without that feature and remove this directory.

NOTE: The default l2c_aux_mask is now ~0 but these devices never have
this type of cache controller so this is safe.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/Kconfig              |  2 --
 arch/arm/Kconfig.platforms    | 15 +++++++++++++++
 arch/arm/Makefile             |  1 -
 arch/arm/mach-nspire/Kconfig  | 15 ---------------
 arch/arm/mach-nspire/Makefile |  2 --
 arch/arm/mach-nspire/nspire.c | 18 ------------------
 6 files changed, 15 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm/mach-nspire/Kconfig
 delete mode 100644 arch/arm/mach-nspire/Makefile
 delete mode 100644 arch/arm/mach-nspire/nspire.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ed069b336c308..038cc4ccc8d16 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -411,8 +411,6 @@ source "arch/arm/mach-nomadik/Kconfig"
 
 source "arch/arm/mach-npcm/Kconfig"
 
-source "arch/arm/mach-nspire/Kconfig"
-
 source "arch/arm/mach-omap1/Kconfig"
 
 source "arch/arm/mach-omap2/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index b4ad800a17b7e..5c19c1f2cff61 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -140,6 +140,21 @@ config MACH_UC7112LX
 
 endif
 
+config ARCH_NSPIRE
+	bool "TI-NSPIRE based"
+	depends on ARCH_MULTI_V4T
+	depends on CPU_LITTLE_ENDIAN
+	select CPU_ARM926T
+	select GENERIC_IRQ_CHIP
+	select ARM_AMBA
+	select ARM_VIC
+	select ARM_TIMER_SP804
+	select NSPIRE_TIMER
+	select POWER_RESET
+	select POWER_RESET_SYSCON
+	help
+	  This enables support for systems using the TI-NSPIRE CPU
+
 config ARCH_RDA
 	bool "RDA Micro SoCs"
 	depends on ARCH_MULTI_V7
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 47c53c068e3d8..05b425b0fc9d3 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -199,7 +199,6 @@ machine-$(CONFIG_ARCH_MXS)		+= mxs
 machine-$(CONFIG_ARCH_MSTARV7)		+= mstar
 machine-$(CONFIG_ARCH_NOMADIK)		+= nomadik
 machine-$(CONFIG_ARCH_NPCM)		+= npcm
-machine-$(CONFIG_ARCH_NSPIRE)		+= nspire
 machine-$(CONFIG_ARCH_OMAP1)		+= omap1
 machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
 machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
diff --git a/arch/arm/mach-nspire/Kconfig b/arch/arm/mach-nspire/Kconfig
deleted file mode 100644
index 0ffdcaca1e6b4..0000000000000
--- a/arch/arm/mach-nspire/Kconfig
+++ /dev/null
@@ -1,15 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-config ARCH_NSPIRE
-	bool "TI-NSPIRE based"
-	depends on ARCH_MULTI_V4T
-	depends on CPU_LITTLE_ENDIAN
-	select CPU_ARM926T
-	select GENERIC_IRQ_CHIP
-	select ARM_AMBA
-	select ARM_VIC
-	select ARM_TIMER_SP804
-	select NSPIRE_TIMER
-	select POWER_RESET
-	select POWER_RESET_SYSCON
-	help
-	  This enables support for systems using the TI-NSPIRE CPU
diff --git a/arch/arm/mach-nspire/Makefile b/arch/arm/mach-nspire/Makefile
deleted file mode 100644
index 4716b9b9aa7bb..0000000000000
--- a/arch/arm/mach-nspire/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-y				+= nspire.o
diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
deleted file mode 100644
index 2fbfc23237ffe..0000000000000
--- a/arch/arm/mach-nspire/nspire.c
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
- */
-
-#include <asm/mach/arch.h>
-
-static const char *const nspire_dt_match[] __initconst = {
-	"ti,nspire",
-	"ti,nspire-cx",
-	"ti,nspire-tp",
-	"ti,nspire-clp",
-	NULL,
-};
-
-DT_MACHINE_START(NSPIRE, "TI-NSPIRE")
-	.dt_compat	= nspire_dt_match,
-MACHINE_END
-- 
2.39.2

