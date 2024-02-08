Return-Path: <linux-kernel+bounces-58439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC77B84E688
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AC9DB2881F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C41127B45;
	Thu,  8 Feb 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="inMS7K2y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022438121B;
	Thu,  8 Feb 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412657; cv=none; b=Rv9KnAlqkyHuRSAhr9ewA0D6x4NSOUXhU86+KB9bW825HsqMqiJgk7IcSUP+Ys9kbvRFXCu+29bekThv2YH7/RbFIMrms/SkkEfGRBFda/2MnS28sbNBfbDtkEYFMXdzlLnGwOWJ223yWrNwapCkJoc16OlQqKT9IHbQJ+n3U0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412657; c=relaxed/simple;
	bh=Fg8HFd6qXwgrRuKizTmdQy4zN2vPEsdI81OkVtdnatg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZ5TFir34wpbmLgSaM2ymKOzrUcJJBMJtpjVpabUzMqQNKqNwAX4+H9QA1sMPksjDJEhgjUELJB9u6CYwxoKVOAejP5PD2qKwBjbTpvyuFANe+3/joESmRwMTdDhLFxpmT8Wiluc8KzR9C/y2VBkNAUqqPyJ5eHdWZR8VcQqYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=inMS7K2y; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707412655; x=1738948655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fg8HFd6qXwgrRuKizTmdQy4zN2vPEsdI81OkVtdnatg=;
  b=inMS7K2y4NKgs4TmUojWeFTQYcLpmiR0bk/Ch8CkMFrp8ThyJLBhG8NE
   drYRM3C2w/TpbG/USSMEVBJ2f3zNQH1PRIIHqB2qwdl/nd2GDvChKrOyv
   ygNJw22cFBClhc7WSuvo5xh8R6u5Zfjl+kF+r7cZKyVihTH1L8nusioYf
   7lXA6jv12BHgu56hpw866Qz9lpxZcasDW81QeGm+YLuLIjHQ8jTbfR/s1
   z77qdPPkdELhPYUxxHuaomDsoF5VOwHbC4RCaG+8zvBhxCbUPG1FIIYOP
   +ahV7KS06Ul2kEsN6s1KNzJRamJ6/OFWe36dpyegOdBpHyvYR/iuK+teM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1565667"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1565667"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934195371"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934195371"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 09:17:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5B2E6147B; Thu,  8 Feb 2024 18:59:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v1 07/15] auxdisplay: linedisp: Group line display drivers together
Date: Thu,  8 Feb 2024 18:58:50 +0200
Message-ID: <20240208165937.2221193-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
References: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For better usability group the line display drivers together in Kconfig
and Makefile.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/Kconfig  | 32 ++++++++++++++++----------------
 drivers/auxdisplay/Makefile | 12 ++++++------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index d944d5298eca..a34a9a52158f 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -25,12 +25,6 @@ config CHARLCD
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
@@ -52,6 +46,16 @@ config HD44780
 	  kernel and started at boot.
 	  If you don't understand what all this is about, say N.
 
+config LCD2S
+	tristate "lcd2s 20x4 character display over I2C console"
+	depends on I2C
+	select CHARLCD
+	help
+	  This is a driver that lets you use the lcd2s 20x4 character display
+	  from Modtronix engineering as a console output device. The display
+	  is a simple single color character display. You have to connect it
+	  to an I2C bus.
+
 config KS0108
 	tristate "KS0108 LCD Controller"
 	depends on PARPORT_PC
@@ -153,6 +157,12 @@ config CFAG12864B_RATE
 	  If you compile this as a module, you can still override this
 	  value using the module parameters.
 
+config LINEDISP
+	tristate "Character line display core support" if COMPILE_TEST
+	help
+	  This is the core support for single-line character displays, to be
+	  selected by drivers that use it.
+
 config IMG_ASCII_LCD
 	tristate "Imagination Technologies ASCII LCD Display"
 	depends on HAS_IOMEM
@@ -177,16 +187,6 @@ config HT16K33
 	  Say yes here to add support for Holtek HT16K33, RAM mapping 16*8
 	  LED controller driver with keyscan.
 
-config LCD2S
-	tristate "lcd2s 20x4 character display over I2C console"
-	depends on I2C
-	select CHARLCD
-	help
-	  This is a driver that lets you use the lcd2s 20x4 character display
-	  from Modtronix engineering as a console output device. The display
-	  is a simple single color character display. You have to connect it
-	  to an I2C bus.
-
 config ARM_CHARLCD
 	bool "ARM Ltd. Character LCD Driver"
 	depends on PLAT_VERSATILE
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index 6968ed4d3f0a..43bad850481c 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -5,12 +5,12 @@
 
 obj-$(CONFIG_CHARLCD)		+= charlcd.o
 obj-$(CONFIG_HD44780_COMMON)	+= hd44780_common.o
-obj-$(CONFIG_ARM_CHARLCD)	+= arm-charlcd.o
+obj-$(CONFIG_HD44780)		+= hd44780.o
+obj-$(CONFIG_LCD2S)		+= lcd2s.o
 obj-$(CONFIG_KS0108)		+= ks0108.o
 obj-$(CONFIG_CFAG12864B)	+= cfag12864b.o cfag12864bfb.o
-obj-$(CONFIG_IMG_ASCII_LCD)	+= img-ascii-lcd.o
-obj-$(CONFIG_HD44780)		+= hd44780.o
-obj-$(CONFIG_HT16K33)		+= ht16k33.o
-obj-$(CONFIG_PARPORT_PANEL)	+= panel.o
-obj-$(CONFIG_LCD2S)		+= lcd2s.o
 obj-$(CONFIG_LINEDISP)		+= line-display.o
+obj-$(CONFIG_IMG_ASCII_LCD)	+= img-ascii-lcd.o
+obj-$(CONFIG_HT16K33)		+= ht16k33.o
+obj-$(CONFIG_ARM_CHARLCD)	+= arm-charlcd.o
+obj-$(CONFIG_PARPORT_PANEL)	+= panel.o
-- 
2.43.0.rc1.1.gbec44491f096


