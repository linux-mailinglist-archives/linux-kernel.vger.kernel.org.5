Return-Path: <linux-kernel+bounces-117592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EA588ACFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD13F29D79B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A9212C7E9;
	Mon, 25 Mar 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h79AbBty"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35B717BAB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387611; cv=none; b=BlhK4aDScvEICJuYQjZQVLv2uga4qlKUXCIpEeR5OA0S3hp4L8+IeSO2rB89ju7O8QijzhMcXHHyOI3mp+fCCrAvrSIsa4//dBFZuJvb+kiNZ1rK76XC4w8twfxZEiaf8VJNZmRkOpBaHSvoFUol47hIH2RmFUWGmLYsReLH/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387611; c=relaxed/simple;
	bh=thu0i8d3/K6PBXttxlctleGVFw/h91JFq459w4xpbTA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a+3VNjNX+RPev3vA7BRXf1DLLBO6cwPNSUqHc9W0wNStCki3dbB/eArQNAZeJkYLD0UsHFGvPyAO6dJRQtrdKsnpRCdSE3UecYwyRoXxNaA0AYA7r+kvL0lCD82OUao7MM8GEv7GrHSEwXlqrBJwZRTbWKzX2rAEkeoErJcHEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h79AbBty; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHQKx1061960;
	Mon, 25 Mar 2024 12:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387580;
	bh=LQCWHfRfk2zps5GrMrRcYXVrZU5MK69gK8L47AXSiH0=;
	h=From:To:CC:Subject:Date;
	b=h79AbBty/k3XWIx7j5bAYQme8+nwnGAvU/Zv76EL69LTnMk8aCJC7J3P2eJhKtSbF
	 Kee5EvtZyzcWKj1SWjzpxkgL5jlIAH/uqa1FlvEpMfz7wSuHDu6TksExGPos9EJ9lB
	 ghjEcNe9ScIRcPaBtZXU22v9gUXzg5rh5mIUNuVg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHQKBZ109596
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:26:20 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:26:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:26:20 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHQK80042985;
	Mon, 25 Mar 2024 12:26:20 -0500
From: Andrew Davis <afd@ti.com>
To: Russell King <linux@armlinux.org.uk>, Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 1/3] ARM: mach-hpe: Rework support and directory structure
Date: Mon, 25 Mar 2024 12:26:17 -0500
Message-ID: <20240325172619.113661-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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

The mach-hpe/ directory and files, provides just one "feature":
having the kernel print the machine name if the DTB does not also contain
a "model" string (which they always do). To reduce the number of mach-*
directories let's do without that feature and remove this directory.

Note, we drop the l2c_aux_mask = ~0 line, but this is safe as
the fallback GENERIC_DT machine has that as the default.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes from v1:
 - Updated commit desc with l2c_aux_mask info
 - Rebased on v6.9-rc1

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
index aa3b947fb0801..947186f0b0c64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2244,7 +2244,6 @@ F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
 F:	Documentation/hwmon/gxp-fan-ctrl.rst
 F:	arch/arm/boot/dts/hpe/
-F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
 F:	drivers/hwmon/gxp-fan-ctrl.c
 F:	drivers/i2c/busses/i2c-gxp.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b14aed3a17abb..9f55fd24c163a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -386,8 +386,6 @@ source "arch/arm/mach-highbank/Kconfig"
 
 source "arch/arm/mach-hisi/Kconfig"
 
-source "arch/arm/mach-hpe/Kconfig"
-
 source "arch/arm/mach-imx/Kconfig"
 
 source "arch/arm/mach-ixp4xx/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index 845ab08e20a4b..5c19c1f2cff61 100644
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
index d82908b1b1bb4..131778fbc6827 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -182,7 +182,6 @@ machine-$(CONFIG_ARCH_FOOTBRIDGE)	+= footbridge
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


