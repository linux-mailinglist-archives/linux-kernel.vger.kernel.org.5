Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6B979AF59
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358382AbjIKWIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238919AbjIKOHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:07:46 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8208BE50
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:07:41 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BE7Ai9037629;
        Mon, 11 Sep 2023 09:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694441230;
        bh=Tlai5dfSJ3TOj6LaG9S6ySzj0M3wG4GsXFVfilxEnqQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jC3MV9D/vYafbay8UrZtvcNa5/e3+lsC352F9CgN8eekUKumr6zimfMpPCIpEFTMo
         eFazGEfQisWGYh1HJEM11nwqTaKtM62T8JJv/63N/zqXNHZ9n1wdBi2ilNttTH773a
         0sbJo6v+hikSK3PXDZj1OgDb/cQhOk+JJGhPQk+s=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BE7A2q055260
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 09:07:10 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 09:07:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 09:07:10 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BE765i120291;
        Mon, 11 Sep 2023 09:07:09 -0500
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
Subject: [PATCH v2 6/8] ARM: mach-airoha: Rework support and directory structure
Date:   Mon, 11 Sep 2023 09:07:03 -0500
Message-ID: <20230911140705.59297-7-afd@ti.com>
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

The mach-airoha/ directory, and files within, provide just one "feature":
having the kernel print the machine name if the DTB does not also contain
a "model" string (which they always do). To reduce the number of mach-*
directories let's do without that feature and remove this directory.

It also seems there was a copy/paste error and the "MEDIATEK_DT"
name was re-used in the DT_MACHINE_START macro. This may have caused
conflicts if this was built in a multi-arch configuration.

NOTE: The default l2c_aux_mask is now ~0 but these devices never have
this type of cache controller so this is safe.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/Kconfig              | 11 -----------
 arch/arm/Kconfig.platforms    | 11 +++++++++++
 arch/arm/Makefile             |  1 -
 arch/arm/mach-airoha/Makefile |  2 --
 arch/arm/mach-airoha/airoha.c | 16 ----------------
 5 files changed, 11 insertions(+), 30 deletions(-)
 delete mode 100644 arch/arm/mach-airoha/Makefile
 delete mode 100644 arch/arm/mach-airoha/airoha.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 09fa512932ab4..5002d507bd081 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -341,17 +341,6 @@ config ARCH_MULTIPLATFORM
 
 source "arch/arm/Kconfig.platforms"
 
-config ARCH_AIROHA
-	bool "Airoha SoC Support"
-	depends on ARCH_MULTI_V7
-	select ARM_AMBA
-	select ARM_GIC
-	select ARM_GIC_V3
-	select ARM_PSCI
-	select HAVE_ARM_ARCH_TIMER
-	help
-	  Support for Airoha EN7523 SoCs
-
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
 # Kconfigs may be included either alphabetically (according to the
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index 4b5fad18ca8b0..38457d5a18fff 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -67,6 +67,17 @@ config ARCH_VIRT
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
 
+config ARCH_AIROHA
+	bool "Airoha SoC Support"
+	depends on ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_GIC_V3
+	select ARM_PSCI
+	select HAVE_ARM_ARCH_TIMER
+	help
+	  Support for Airoha EN7523 SoCs
+
 config MACH_ASM9260
 	bool "Alphascale ASM9260"
 	depends on ARCH_MULTI_V5
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 32e99aa282bf9..e20c8af34d518 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -167,7 +167,6 @@ textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
 machine-$(CONFIG_ARCH_ACTIONS)		+= actions
-machine-$(CONFIG_ARCH_AIROHA)		+= airoha
 machine-$(CONFIG_ARCH_ALPINE)		+= alpine
 machine-$(CONFIG_ARCH_ARTPEC)		+= artpec
 machine-$(CONFIG_ARCH_ASPEED)           += aspeed
diff --git a/arch/arm/mach-airoha/Makefile b/arch/arm/mach-airoha/Makefile
deleted file mode 100644
index a5857d0d02ebf..0000000000000
--- a/arch/arm/mach-airoha/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-y			+= airoha.o
diff --git a/arch/arm/mach-airoha/airoha.c b/arch/arm/mach-airoha/airoha.c
deleted file mode 100644
index ea23b5abb478e..0000000000000
--- a/arch/arm/mach-airoha/airoha.c
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Device Tree support for Airoha SoCs
- *
- * Copyright (c) 2022 Felix Fietkau <nbd@nbd.name>
- */
-#include <asm/mach/arch.h>
-
-static const char * const airoha_board_dt_compat[] = {
-	"airoha,en7523",
-	NULL,
-};
-
-DT_MACHINE_START(MEDIATEK_DT, "Airoha Cortex-A53 (Device Tree)")
-	.dt_compat	= airoha_board_dt_compat,
-MACHINE_END
-- 
2.39.2

