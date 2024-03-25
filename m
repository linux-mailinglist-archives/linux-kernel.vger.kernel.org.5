Return-Path: <linux-kernel+bounces-117593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D21F88ACFE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535CD2C2AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6971312C7EB;
	Mon, 25 Mar 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aBNLEp5W"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C2E54756
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387611; cv=none; b=kv/+7Nfe5SzDYdAkRnRfK/M3P05EExCWjNr8FL2+bG5CekCcTg/ca5hyhIdFw+uZrWnhu07uW687dk+sbIvHIPALe6BCgm0hdK8756bQlBs+NxiTYq2sA9FW1NJMgHyzV3rCZhwMhxKLtCMP7T9xN0MjfVyUio4lOfahXMqb/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387611; c=relaxed/simple;
	bh=FWDizHwRbtcUVJzobSiCgNS3VDD3O/7xE3wAvattHIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoPU6qeRXxuPmDR87jQW9N9O6GcJ2Rwx5MJ3fnIKX8FABwh8oV/Ky4c1Q7SHVqH0B4xyjhdMfUD7TJRoYcIbfLkqVMOu75Wve7zAHGJlhu9beCZo58zU34weFtavSMjdMD9s7R+IFzSZk1QQAuziTOkJ+yBjdgTludq2VKCUuQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aBNLEp5W; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHQL12061966;
	Mon, 25 Mar 2024 12:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387581;
	bh=u2R75byDJ62cMgKm2V1bDaB3tq9bjRG3tOWnOwtsXzc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=aBNLEp5Wzf03RkEY1T66D4gpVGTtK8LdgGzBe9h8yOx18a92ruvv+30kgia40L0rT
	 v+9/9VLpMJvh8+J1b0pdUSlxseUrsqy5Nvw9mwqXqTHaF46tdU+PWP1NJlDI6Yc2/D
	 flZek70rkE0G27NBspllT+jOs/9IujN5P1m8vmLU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHQL8K094182
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:26:21 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:26:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:26:21 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHQK81042985;
	Mon, 25 Mar 2024 12:26:20 -0500
From: Andrew Davis <afd@ti.com>
To: Russell King <linux@armlinux.org.uk>, Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 2/3] ARM: mach-lpc18xx: Rework support and directory structure
Date: Mon, 25 Mar 2024 12:26:18 -0500
Message-ID: <20240325172619.113661-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325172619.113661-1-afd@ti.com>
References: <20240325172619.113661-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Having a platform need a mach-* directory should be seen as a negative,
it means the platform needs special non-standard handling. ARM64 support
does not allow mach-* directories at all. While we may not get to that
given all the non-standard architectures we support, we should still try
to get as close as we can and reduce the number of mach directories.

The mach-lpc18xx/ directory and files, provides just one "feature":
having the kernel print the machine name if the DTB does not also contain
a "model" string (which they always do). To reduce the number of mach-*
directories let's do without that feature and remove this directory.

Note the fallback machine has a default l2c_aux_mask value set to ~0,
which is different than the value of 0 used when none is provided. This
is safe here as this platform does not use an l2x0 cache controller.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes from v1:
 - Updated commit desc with l2c_aux_mask info
 - Rebased on v6.9-rc1

 arch/arm/Kconfig                 | 11 -----------
 arch/arm/Kconfig.platforms       | 11 +++++++++++
 arch/arm/Makefile                |  1 -
 arch/arm/mach-lpc18xx/Makefile   |  2 --
 arch/arm/mach-lpc18xx/board-dt.c | 19 -------------------
 5 files changed, 11 insertions(+), 33 deletions(-)
 delete mode 100644 arch/arm/mach-lpc18xx/Makefile
 delete mode 100644 arch/arm/mach-lpc18xx/board-dt.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f55fd24c163a..66a16ee1ed8f1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -459,17 +459,6 @@ source "arch/arm/mach-vt8500/Kconfig"
 source "arch/arm/mach-zynq/Kconfig"
 
 # ARMv7-M architecture
-config ARCH_LPC18XX
-	bool "NXP LPC18xx/LPC43xx"
-	depends on ARM_SINGLE_ARMV7M
-	select ARCH_HAS_RESET_CONTROLLER
-	select ARM_AMBA
-	select CLKSRC_LPC32XX
-	select PINCTRL
-	help
-	  Support for NXP's LPC18xx Cortex-M3 and LPC43xx Cortex-M4
-	  high performance microcontrollers.
-
 config ARCH_MPS2
 	bool "ARM MPS2 platform"
 	depends on ARM_SINGLE_ARMV7M
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index 5c19c1f2cff61..29fbed968d361 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -112,6 +112,17 @@ config ARCH_HPE_GXP
 
 endif
 
+config ARCH_LPC18XX
+	bool "NXP LPC18xx/LPC43xx"
+	depends on ARM_SINGLE_ARMV7M
+	select ARCH_HAS_RESET_CONTROLLER
+	select ARM_AMBA
+	select CLKSRC_LPC32XX
+	select PINCTRL
+	help
+	  Support for NXP's LPC18xx Cortex-M3 and LPC43xx Cortex-M4
+	  high performance microcontrollers.
+
 menuconfig ARCH_MOXART
 	bool "MOXA ART SoC"
 	depends on ARCH_MULTI_V4
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 131778fbc6827..8da36594c2f3f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -184,7 +184,6 @@ machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_HISI)		+= hisi
 machine-$(CONFIG_ARCH_IXP4XX)		+= ixp4xx
 machine-$(CONFIG_ARCH_KEYSTONE)		+= keystone
-machine-$(CONFIG_ARCH_LPC18XX)		+= lpc18xx
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
 machine-$(CONFIG_ARCH_MESON)		+= meson
 machine-$(CONFIG_ARCH_MMP)		+= mmp
diff --git a/arch/arm/mach-lpc18xx/Makefile b/arch/arm/mach-lpc18xx/Makefile
deleted file mode 100644
index c80d80c199d37..0000000000000
--- a/arch/arm/mach-lpc18xx/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-y += board-dt.o
diff --git a/arch/arm/mach-lpc18xx/board-dt.c b/arch/arm/mach-lpc18xx/board-dt.c
deleted file mode 100644
index 4729eb83401ae..0000000000000
--- a/arch/arm/mach-lpc18xx/board-dt.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Device Tree board file for NXP LPC18xx/43xx
- *
- * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
- */
-
-#include <asm/mach/arch.h>
-
-static const char *const lpc18xx_43xx_compat[] __initconst = {
-	"nxp,lpc1850",
-	"nxp,lpc4350",
-	"nxp,lpc4370",
-	NULL
-};
-
-DT_MACHINE_START(LPC18XXDT, "NXP LPC18xx/43xx (Device Tree)")
-	.dt_compat = lpc18xx_43xx_compat,
-MACHINE_END
-- 
2.39.2


