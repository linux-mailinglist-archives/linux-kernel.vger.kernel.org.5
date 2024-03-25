Return-Path: <linux-kernel+bounces-117594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CF388AE1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 518AFC2517C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BA612D74D;
	Mon, 25 Mar 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZU6vH8dC"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248112B170
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387613; cv=none; b=N78cAPlCLzQXeAY0utmdR9GQWkkRaLvZm1szQQRLS0n5Ejbvo+irKlyoKifeI8EkjtbXYgqL1IrQunVNqBHPMR5SOB34BsaB7CPnmPXR9rFNJzHdfsehL9W42eXp5DnvZHmgMAVvrmK8jc61QsgjQBq48eKgAgHqBC+pDRuMBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387613; c=relaxed/simple;
	bh=OKLVCdttSinQ3sbvhWVItaOuc2gFz6b/AAKicKml1zY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJ46fSPQyYpKl0dAWzGZZC344RFiA8IP8+YQcqli/hQ9Vwf4sJNgRuEijDRF8RBn47VKXsgQiuBAh6lWkAhoJQzFPETCh9wP7D7zPg5WDl6n1G1mE/tzYyQEoAwa/sJAoxaw0Q/QD7N+fB0tdltYiKjzGkyjZiqy5vwkZeQjWPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZU6vH8dC; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHQL5h041264;
	Mon, 25 Mar 2024 12:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387581;
	bh=3OMPh6dmxdlpe6Hnodj4089wI8A2TXp1Am7XOmBFFKE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZU6vH8dCXu0KqVU/jyl+PzajEEULJVHtp4Fvi981ZH3mFZ6Gp5UbL6wEe0r7lajIf
	 jHASJxUPdAB9WpQU7/JjWzDPBhBjqHVBk8uQ4smUBvALRZMaVfgo/SK/uO/seHeN/u
	 xx4gTMi3g0valJUce5hhKN/HjUhkst8Te6JCR1l4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHQLdX109602
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:26:21 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:26:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:26:21 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHQK82042985;
	Mon, 25 Mar 2024 12:26:21 -0500
From: Andrew Davis <afd@ti.com>
To: Russell King <linux@armlinux.org.uk>, Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 3/3] ARM: mach-ixp4xx: Rework support and directory structure
Date: Mon, 25 Mar 2024 12:26:19 -0500
Message-ID: <20240325172619.113661-3-afd@ti.com>
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

The mach-ixp4xx/ directory and files, provides just one "feature":
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

 MAINTAINERS                      |  1 -
 arch/arm/Kconfig.platforms       | 19 +++++++++++++++++++
 arch/arm/mach-ixp4xx/Kconfig     | 19 -------------------
 arch/arm/mach-ixp4xx/Makefile    |  2 --
 arch/arm/mach-ixp4xx/ixp4xx-of.c | 22 ----------------------
 5 files changed, 19 insertions(+), 44 deletions(-)
 delete mode 100644 arch/arm/mach-ixp4xx/Kconfig
 delete mode 100644 arch/arm/mach-ixp4xx/Makefile
 delete mode 100644 arch/arm/mach-ixp4xx/ixp4xx-of.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 947186f0b0c64..a0fcb6d27c0e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2270,7 +2270,6 @@ F:	Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion*
 F:	Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml
 F:	Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
 F:	arch/arm/boot/dts/intel/ixp/
-F:	arch/arm/mach-ixp4xx/
 F:	drivers/bus/intel-ixp4xx-eb.c
 F:	drivers/char/hw_random/ixp4xx-rng.c
 F:	drivers/clocksource/timer-ixp4xx.c
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index 29fbed968d361..bf2185f87180c 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -112,6 +112,25 @@ config ARCH_HPE_GXP
 
 endif
 
+config ARCH_IXP4XX
+	bool "IXP4xx-based platforms"
+	depends on ARCH_MULTI_V5
+	depends on CPU_BIG_ENDIAN
+	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
+	select CPU_XSCALE
+	select GPIO_IXP4XX
+	select GPIOLIB
+	select FORCE_PCI
+	select I2C
+	select I2C_IOP3XX
+	select IXP4XX_IRQ
+	select IXP4XX_TIMER
+	select USB_EHCI_BIG_ENDIAN_DESC
+	select USB_EHCI_BIG_ENDIAN_MMIO
+	select USE_OF
+	help
+	  Support for Intel's IXP4XX (XScale) family of processors.
+
 config ARCH_LPC18XX
 	bool "NXP LPC18xx/LPC43xx"
 	depends on ARM_SINGLE_ARMV7M
diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
deleted file mode 100644
index cb46802f5ce52..0000000000000
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ /dev/null
@@ -1,19 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-menuconfig ARCH_IXP4XX
-	bool "IXP4xx-based platforms"
-	depends on ARCH_MULTI_V5
-	depends on CPU_BIG_ENDIAN
-	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
-	select CPU_XSCALE
-	select GPIO_IXP4XX
-	select GPIOLIB
-	select FORCE_PCI
-	select I2C
-	select I2C_IOP3XX
-	select IXP4XX_IRQ
-	select IXP4XX_TIMER
-	select USB_EHCI_BIG_ENDIAN_DESC
-	select USB_EHCI_BIG_ENDIAN_MMIO
-	select USE_OF
-	help
-	  Support for Intel's IXP4XX (XScale) family of processors.
diff --git a/arch/arm/mach-ixp4xx/Makefile b/arch/arm/mach-ixp4xx/Makefile
deleted file mode 100644
index 3d1c9d854c7f3..0000000000000
--- a/arch/arm/mach-ixp4xx/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-y	+= ixp4xx-of.o
diff --git a/arch/arm/mach-ixp4xx/ixp4xx-of.c b/arch/arm/mach-ixp4xx/ixp4xx-of.c
deleted file mode 100644
index 1b4d84a5b02f6..0000000000000
--- a/arch/arm/mach-ixp4xx/ixp4xx-of.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * IXP4xx Device Tree boot support
- */
-#include <asm/mach/arch.h>
-
-/*
- * We handle 4 different SoC families. These compatible strings are enough
- * to provide the core so that different boards can add their more detailed
- * specifics.
- */
-static const char *ixp4xx_of_board_compat[] = {
-	"intel,ixp42x",
-	"intel,ixp43x",
-	"intel,ixp45x",
-	"intel,ixp46x",
-	NULL,
-};
-
-DT_MACHINE_START(IXP4XX_DT, "IXP4xx (Device Tree)")
-	.dt_compat	= ixp4xx_of_board_compat,
-MACHINE_END
-- 
2.39.2


