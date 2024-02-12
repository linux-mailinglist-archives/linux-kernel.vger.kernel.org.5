Return-Path: <linux-kernel+bounces-62048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CF1851AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3605028904D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E242947F46;
	Mon, 12 Feb 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8LV/yz1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4E34596E;
	Mon, 12 Feb 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757494; cv=none; b=Kf2b5amUD3Wj6dby25Io0gbGmy9fzR1D5O7ZVG1TmerwFTIiR9S2v2jU4owar/uQ/MtwzCWQVgadlxM55k5xwNc9KBmYwnOoGJ4MKMaKAGSOSzhpbVQWkRJZhOI2ujcRsb+OgNEPaRKcinis0pjM7CPZsAGZ1ZpwnvE2VJwhIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757494; c=relaxed/simple;
	bh=Fg8HFd6qXwgrRuKizTmdQy4zN2vPEsdI81OkVtdnatg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPJPzsgZxMfoq78W8TUUy+ykAqnI01KpHuxCj+0H3E0BPaHWO8ZFEWWIf0uDgeY40wkiF/uss/XbeMkMiB7QKrlv6gQ7WPfHXwzGcVHHPRwdOgSOM8GrR74AAmuRefHSZaNwp5qBvfwzy+LDwTcPpTM411ljiOf43CA4hhV76S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8LV/yz1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757493; x=1739293493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fg8HFd6qXwgrRuKizTmdQy4zN2vPEsdI81OkVtdnatg=;
  b=k8LV/yz1igpk/NVNBVSN4fCFBVSqRaVN/juIR0QuYKCVW4xKWBJ3CEXD
   20DJ8tplemiltLzATsTcCrVfMh9lDwfp75cDsZ+pQpfLG6HqdNSy7AZt5
   5vmhKZmqk0dJ0ZV7zCy8xFpRJBLCFqOM6KjKl9PkY338cpB5xhgflRx6X
   p0bRRu/ex+PjWsc7mD4e9RUeOM6RgfgwVcS7PitOnntIgkhLI5XsS5gpD
   NRacAxSe5XC4AxJaqBbcmVWPiP6l8ZePq5Tv2ehr4iRpsdwA4v9pETUwh
   /3O5n6C51QpfD7fsHO6hUxXxWBqfe8A66cKpLMViBnYtYPAKLUOAYeurO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19153215"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19153215"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:04:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935116825"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935116825"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 09:04:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D5900161; Mon, 12 Feb 2024 19:04:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: [PATCH v2 07/15] auxdisplay: linedisp: Group line display drivers together
Date: Mon, 12 Feb 2024 19:01:40 +0200
Message-ID: <20240212170423.2860895-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
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


