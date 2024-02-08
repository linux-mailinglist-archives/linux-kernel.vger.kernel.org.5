Return-Path: <linux-kernel+bounces-58442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E529A84E68D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835CC1F2A48F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352281292D2;
	Thu,  8 Feb 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jiu7mqAZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7034781AAA;
	Thu,  8 Feb 2024 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412659; cv=none; b=JUEgTD8oZZ4WtURLr0lcldAJDzZ/e6alT8M2MmnN8FjZt5p8zkD78itUOjglCzSxS+DivC+yY2/UI7pmHQQCORaqOoIEwsMem78i3AYF2tttta2xjUN21SxOTdFDYtF4ZZefrby5mgw6pdjcFs9OeDiUENPhScBZEpSkF4nMKzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412659; c=relaxed/simple;
	bh=CF1pX065yGAbwnIQLmXi74KKJnRft9elRt9o2Olm5iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBadysBbwNUz8DELFtDL/En/fr/wAvR/FWwqAbmdb6WVicSCAPtJFAA0Pqgyuc/AQW3xp54jpakGzSMNfxdOQPGsCbcxZKOzNHEwCnMiO7Yrk1GmmGP7gSym288KpQa/lr2mNY+QoKksxBcabh8cYygA4PAWL2dB/a6ixJBSirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jiu7mqAZ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707412657; x=1738948657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CF1pX065yGAbwnIQLmXi74KKJnRft9elRt9o2Olm5iY=;
  b=Jiu7mqAZLe5Mlq1X1gYTOo8SDIih0dE85t29c5zpp9XQB94OKyImN29m
   b48X9cEOyTWlcqRPh5WcDLF095o4SauRY8+I+Rcq2+YI75fQ6ZMeMtkA8
   Taze+ZAcP2U7NAsoD4z23zhoyEKPnYySxB0PD+JBhWntly/Z3Xj1VravH
   eX1JfaM99OlmLM666vRff+NJQylCh/GRua7z2aFK0A48BpZPF112m9pua
   CPImNcof7pA2FDqOhC1VbU3QinNdobJlBFKlpITVxqhOv5J9yPZBBPvdt
   m4VRf1L/dqe3PCKuLncQB+21OyTQExeSDZXSmiDAemi4uD3lGTuhSJ433
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1565699"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1565699"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:17:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934195385"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934195385"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 09:17:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 496DA144A; Thu,  8 Feb 2024 18:59:41 +0200 (EET)
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
Subject: [PATCH v1 06/15] auxdisplay: linedisp: Move exported symbols to a namespace
Date: Thu,  8 Feb 2024 18:58:49 +0200
Message-ID: <20240208165937.2221193-7-andriy.shevchenko@linux.intel.com>
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

Avoid unnecessary pollution of the global symbol namespace by
moving library functions in to a specific namespace and import
that into the drivers that make use of the functions.

For more info: https://lwn.net/Articles/760045/

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/ht16k33.c       | 1 +
 drivers/auxdisplay/img-ascii-lcd.c | 1 +
 drivers/auxdisplay/line-display.c  | 4 ++--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index a90430b7d07b..c6a42c5c128f 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -831,4 +831,5 @@ module_i2c_driver(ht16k33_driver);
 
 MODULE_DESCRIPTION("Holtek HT16K33 driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(LINEDISP);
 MODULE_AUTHOR("Robin van der Gracht <robin@protonic.nl>");
diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index 09014ada38bd..c571e54d9eb5 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -298,3 +298,4 @@ module_platform_driver(img_ascii_lcd_driver);
 MODULE_DESCRIPTION("Imagination Technologies ASCII LCD Display");
 MODULE_AUTHOR("Paul Burton <paul.burton@mips.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(LINEDISP);
diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 6b3d25e20eeb..851b2c0f9443 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -263,7 +263,7 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 	put_device(&linedisp->dev);
 	return err;
 }
-EXPORT_SYMBOL_GPL(linedisp_register);
+EXPORT_SYMBOL_NS_GPL(linedisp_register, LINEDISP);
 
 /**
  * linedisp_unregister - unregister a character line display
@@ -276,6 +276,6 @@ void linedisp_unregister(struct linedisp *linedisp)
 	del_timer_sync(&linedisp->timer);
 	put_device(&linedisp->dev);
 }
-EXPORT_SYMBOL_GPL(linedisp_unregister);
+EXPORT_SYMBOL_NS_GPL(linedisp_unregister, LINEDISP);
 
 MODULE_LICENSE("GPL");
-- 
2.43.0.rc1.1.gbec44491f096


