Return-Path: <linux-kernel+bounces-71732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A2785A998
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EF91C21520
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E69481A0;
	Mon, 19 Feb 2024 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLyvLS4b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BB0446D0;
	Mon, 19 Feb 2024 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362232; cv=none; b=WZTmMCXroFDr4SMr62REn2x2pgSnghSWtBa4CDarkfb1RubQ3yFsK8bRQPXYQdzOLhJYGoGUoTuGRUqIoEn39R/rb/mKz1EK4mAEIDuwkZDj0RAEnHZt3eh3yYx0LZDKjB1a1anQlnfCFcXccBWdWvjkiWQ6sN7tu/NNNpuDw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362232; c=relaxed/simple;
	bh=2V6K2WvRgilQJzTyY5J8rzEpLbmO3v/oZJMKcEItRHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pir6BP3NM2a0/xFsehlyPfEK7Y/6pgMkNN8hw3ljJuMWcRJIt8iLPuF8J0fElznd4UysUaPe015ghYG2I5KPwksxHtGDRx5mYi+HhxywG+7keD52A4XqEA16zQjir9chc1QZfpfpBb2uYjAY0l7J6c2XYoeYHRLr4zvltCemdjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLyvLS4b; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708362230; x=1739898230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2V6K2WvRgilQJzTyY5J8rzEpLbmO3v/oZJMKcEItRHM=;
  b=aLyvLS4bqrI8xOWRlUbrNiiKVrniNmO2Xtahk89YWh6Cnofh6jZ+wq9m
   gyi7/gIwWQdp/QEuO3fAgC5uzECCOhZtpdqZJLTOBaJqVGWGgFfo++E7/
   7Ad7Soi/gVLRc7YemOAvs5x1yYXH3jYu9WLbhYxMErafsM+U505xpR5xA
   MJeG6tP60LzAM+YfRAxnzd0NzQwIyQ0sEoQpgfm1ZLUH7SN17XbxIjyvt
   VvK5V9q8uVCtiPEL9x1WrPPP6niZyJpd0Tbv7yaIheGAyi8DG+0iNPgs+
   2tNarAb+rfAhYC6DfaDDI1r5vKBopou7glhJF0I+VMXcXvSXUEEfIMEu0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2577414"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2577414"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 09:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936315356"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936315356"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 09:03:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2E9AD2A6; Mon, 19 Feb 2024 19:03:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: [PATCH v3 1/9] auxdisplay: linedisp: Group display drivers together
Date: Mon, 19 Feb 2024 18:58:00 +0200
Message-ID: <20240219170337.2161754-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For better usability group the display drivers together in Kconfig
and Makefile. With this we will have the following sections:
  - Character LCD
  - Samsung KS0108 LCD controller
  - Single character line display
  - Character LCD with non-conforming interface

While at it, drop redundant 'default n' entries.

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/Kconfig  | 296 +++++++++++++++++++-----------------
 drivers/auxdisplay/Makefile |  15 +-
 2 files changed, 163 insertions(+), 148 deletions(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index d944d5298eca..109ac253d160 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -16,6 +16,9 @@ menuconfig AUXDISPLAY
 
 if AUXDISPLAY
 
+#
+# Character LCD section
+#
 config CHARLCD
 	tristate "Character LCD core support" if COMPILE_TEST
 	help
@@ -25,12 +28,6 @@ config CHARLCD
 	  This is some character LCD core interface that multiple drivers can
 	  use.
 
-config LINEDISP
-	tristate "Character line display core support" if COMPILE_TEST
-	help
-	  This is the core support for single-line character displays, to be
-	  selected by drivers that use it.
-
 config HD44780_COMMON
 	tristate "Common functions for HD44780 (and compatibles) LCD displays" if COMPILE_TEST
 	select CHARLCD
@@ -52,131 +49,6 @@ config HD44780
 	  kernel and started at boot.
 	  If you don't understand what all this is about, say N.
 
-config KS0108
-	tristate "KS0108 LCD Controller"
-	depends on PARPORT_PC
-	default n
-	help
-	  If you have a LCD controlled by one or more KS0108
-	  controllers, say Y. You will need also another more specific
-	  driver for your LCD.
-
-	  Depends on Parallel Port support. If you say Y at
-	  parport, you will be able to compile this as a module (M)
-	  and built-in as well (Y).
-
-	  To compile this as a module, choose M here:
-	  the module will be called ks0108.
-
-	  If unsure, say N.
-
-config KS0108_PORT
-	hex "Parallel port where the LCD is connected"
-	depends on KS0108
-	default 0x378
-	help
-	  The address of the parallel port where the LCD is connected.
-
-	  The first  standard parallel port address is 0x378.
-	  The second standard parallel port address is 0x278.
-	  The third  standard parallel port address is 0x3BC.
-
-	  You can specify a different address if you need.
-
-	  If you don't know what I'm talking about, load the parport module,
-	  and execute "dmesg" or "cat /proc/ioports". You can see there how
-	  many parallel ports are present and which address each one has.
-
-	  Usually you only need to use 0x378.
-
-	  If you compile this as a module, you can still override this
-	  using the module parameters.
-
-config KS0108_DELAY
-	int "Delay between each control writing (microseconds)"
-	depends on KS0108
-	default "2"
-	help
-	  Amount of time the ks0108 should wait between each control write
-	  to the parallel port.
-
-	  If your LCD seems to miss random writings, increment this.
-
-	  If you don't know what I'm talking about, ignore it.
-
-	  If you compile this as a module, you can still override this
-	  value using the module parameters.
-
-config CFAG12864B
-	tristate "CFAG12864B LCD"
-	depends on X86
-	depends on FB
-	depends on KS0108
-	select FB_SYSMEM_HELPERS
-	default n
-	help
-	  If you have a Crystalfontz 128x64 2-color LCD, cfag12864b Series,
-	  say Y. You also need the ks0108 LCD Controller driver.
-
-	  For help about how to wire your LCD to the parallel port,
-	  check Documentation/admin-guide/auxdisplay/cfag12864b.rst
-
-	  Depends on the x86 arch and the framebuffer support.
-
-	  The LCD framebuffer driver can be attached to a console.
-	  It will work fine. However, you can't attach it to the fbdev driver
-	  of the xorg server.
-
-	  To compile this as a module, choose M here:
-	  the modules will be called cfag12864b and cfag12864bfb.
-
-	  If unsure, say N.
-
-config CFAG12864B_RATE
-	int "Refresh rate (hertz)"
-	depends on CFAG12864B
-	default "20"
-	help
-	  Refresh rate of the LCD.
-
-	  As the LCD is not memory mapped, the driver has to make the work by
-	  software. This means you should be careful setting this value higher.
-	  If your CPUs are really slow or you feel the system is slowed down,
-	  decrease the value.
-
-	  Be careful modifying this value to a very high value:
-	  You can freeze the computer, or the LCD maybe can't draw as fast as you
-	  are requesting.
-
-	  If you don't know what I'm talking about, ignore it.
-
-	  If you compile this as a module, you can still override this
-	  value using the module parameters.
-
-config IMG_ASCII_LCD
-	tristate "Imagination Technologies ASCII LCD Display"
-	depends on HAS_IOMEM
-	default y if MIPS_MALTA
-	select MFD_SYSCON
-	select LINEDISP
-	help
-	  Enable this to support the simple ASCII LCD displays found on
-	  development boards such as the MIPS Boston, MIPS Malta & MIPS SEAD3
-	  from Imagination Technologies.
-
-config HT16K33
-	tristate "Holtek Ht16K33 LED controller with keyscan"
-	depends on FB && I2C && INPUT
-	select FB_SYSMEM_HELPERS
-	select INPUT_MATRIXKMAP
-	select FB_BACKLIGHT
-	select NEW_LEDS
-	select LEDS_CLASS
-	select LINEDISP
-	help
-	  Say yes here to add support for Holtek HT16K33, RAM mapping 16*8
-	  LED controller driver with keyscan.
-
 config LCD2S
 	tristate "lcd2s 20x4 character display over I2C console"
 	depends on I2C
@@ -187,16 +59,6 @@ config LCD2S
 	  is a simple single color character display. You have to connect it
 	  to an I2C bus.
 
-config ARM_CHARLCD
-	bool "ARM Ltd. Character LCD Driver"
-	depends on PLAT_VERSATILE
-	help
-	  This is a driver for the character LCD found on the ARM Ltd.
-	  Versatile and RealView Platform Baseboards. It doesn't do
-	  very much more than display the text "ARM Linux" on the first
-	  line and the Linux version on the second line, but that's
-	  still useful.
-
 menuconfig PARPORT_PANEL
 	tristate "Parallel port LCD/Keypad Panel support"
 	depends on PARPORT
@@ -455,7 +317,6 @@ endif # PARPORT_PANEL
 config PANEL_CHANGE_MESSAGE
 	bool "Change LCD initialization message ?"
 	depends on CHARLCD
-	default "n"
 	help
 	  This allows you to replace the boot message indicating the kernel version
 	  and the driver version with a custom message. This is useful on appliances
@@ -504,8 +365,159 @@ choice
 
 endchoice
 
+#
+# Samsung KS0108 LCD controller section
+#
+config KS0108
+	tristate "KS0108 LCD Controller"
+	depends on PARPORT_PC
+	help
+	  If you have a LCD controlled by one or more KS0108
+	  controllers, say Y. You will need also another more specific
+	  driver for your LCD.
+
+	  Depends on Parallel Port support. If you say Y at
+	  parport, you will be able to compile this as a module (M)
+	  and built-in as well (Y).
+
+	  To compile this as a module, choose M here:
+	  the module will be called ks0108.
+
+	  If unsure, say N.
+
+config KS0108_PORT
+	hex "Parallel port where the LCD is connected"
+	depends on KS0108
+	default 0x378
+	help
+	  The address of the parallel port where the LCD is connected.
+
+	  The first  standard parallel port address is 0x378.
+	  The second standard parallel port address is 0x278.
+	  The third  standard parallel port address is 0x3BC.
+
+	  You can specify a different address if you need.
+
+	  If you don't know what I'm talking about, load the parport module,
+	  and execute "dmesg" or "cat /proc/ioports". You can see there how
+	  many parallel ports are present and which address each one has.
+
+	  Usually you only need to use 0x378.
+
+	  If you compile this as a module, you can still override this
+	  using the module parameters.
+
+config KS0108_DELAY
+	int "Delay between each control writing (microseconds)"
+	depends on KS0108
+	default "2"
+	help
+	  Amount of time the ks0108 should wait between each control write
+	  to the parallel port.
+
+	  If your LCD seems to miss random writings, increment this.
+
+	  If you don't know what I'm talking about, ignore it.
+
+	  If you compile this as a module, you can still override this
+	  value using the module parameters.
+
+config CFAG12864B
+	tristate "CFAG12864B LCD"
+	depends on X86
+	depends on FB
+	depends on KS0108
+	select FB_SYSMEM_HELPERS
+	help
+	  If you have a Crystalfontz 128x64 2-color LCD, cfag12864b Series,
+	  say Y. You also need the ks0108 LCD Controller driver.
+
+	  For help about how to wire your LCD to the parallel port,
+	  check Documentation/admin-guide/auxdisplay/cfag12864b.rst
+
+	  Depends on the x86 arch and the framebuffer support.
+
+	  The LCD framebuffer driver can be attached to a console.
+	  It will work fine. However, you can't attach it to the fbdev driver
+	  of the xorg server.
+
+	  To compile this as a module, choose M here:
+	  the modules will be called cfag12864b and cfag12864bfb.
+
+	  If unsure, say N.
+
+config CFAG12864B_RATE
+	int "Refresh rate (hertz)"
+	depends on CFAG12864B
+	default "20"
+	help
+	  Refresh rate of the LCD.
+
+	  As the LCD is not memory mapped, the driver has to make the work by
+	  software. This means you should be careful setting this value higher.
+	  If your CPUs are really slow or you feel the system is slowed down,
+	  decrease the value.
+
+	  Be careful modifying this value to a very high value:
+	  You can freeze the computer, or the LCD maybe can't draw as fast as you
+	  are requesting.
+
+	  If you don't know what I'm talking about, ignore it.
+
+	  If you compile this as a module, you can still override this
+	  value using the module parameters.
+
+#
+# Single character line display section
+#
+config LINEDISP
+	tristate "Character line display core support" if COMPILE_TEST
+	help
+	  This is the core support for single-line character displays, to be
+	  selected by drivers that use it.
+
+config IMG_ASCII_LCD
+	tristate "Imagination Technologies ASCII LCD Display"
+	depends on HAS_IOMEM
+	default y if MIPS_MALTA
+	select MFD_SYSCON
+	select LINEDISP
+	help
+	  Enable this to support the simple ASCII LCD displays found on
+	  development boards such as the MIPS Boston, MIPS Malta & MIPS SEAD3
+	  from Imagination Technologies.
+
+config HT16K33
+	tristate "Holtek Ht16K33 LED controller with keyscan"
+	depends on FB && I2C && INPUT
+	select FB_SYSMEM_HELPERS
+	select INPUT_MATRIXKMAP
+	select FB_BACKLIGHT
+	select NEW_LEDS
+	select LEDS_CLASS
+	select LINEDISP
+	help
+	  Say yes here to add support for Holtek HT16K33, RAM mapping 16*8
+	  LED controller driver with keyscan.
+
+#
+# Character LCD with non-conforming interface section
+#
+config ARM_CHARLCD
+	bool "ARM Ltd. Character LCD Driver"
+	depends on PLAT_VERSATILE
+	help
+	  This is a driver for the character LCD found on the ARM Ltd.
+	  Versatile and RealView Platform Baseboards. It doesn't do
+	  very much more than display the text "ARM Linux" on the first
+	  line and the Linux version on the second line, but that's
+	  still useful.
+
 endif # AUXDISPLAY
 
+#
+# Deprecated options
+#
 config PANEL
 	tristate "Parallel port LCD/Keypad Panel support (OLD OPTION)"
 	depends on PARPORT
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index 6968ed4d3f0a..9197ea34e2d6 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -5,12 +5,15 @@
 
 obj-$(CONFIG_CHARLCD)		+= charlcd.o
 obj-$(CONFIG_HD44780_COMMON)	+= hd44780_common.o
-obj-$(CONFIG_ARM_CHARLCD)	+= arm-charlcd.o
+obj-$(CONFIG_HD44780)		+= hd44780.o
+obj-$(CONFIG_LCD2S)		+= lcd2s.o
+obj-$(CONFIG_PARPORT_PANEL)	+= panel.o
+
 obj-$(CONFIG_KS0108)		+= ks0108.o
 obj-$(CONFIG_CFAG12864B)	+= cfag12864b.o cfag12864bfb.o
-obj-$(CONFIG_IMG_ASCII_LCD)	+= img-ascii-lcd.o
-obj-$(CONFIG_HD44780)		+= hd44780.o
-obj-$(CONFIG_HT16K33)		+= ht16k33.o
-obj-$(CONFIG_PARPORT_PANEL)	+= panel.o
-obj-$(CONFIG_LCD2S)		+= lcd2s.o
+
 obj-$(CONFIG_LINEDISP)		+= line-display.o
+obj-$(CONFIG_IMG_ASCII_LCD)	+= img-ascii-lcd.o
+obj-$(CONFIG_HT16K33)		+= ht16k33.o
+
+obj-$(CONFIG_ARM_CHARLCD)	+= arm-charlcd.o
-- 
2.43.0.rc1.1.gbec44491f096


