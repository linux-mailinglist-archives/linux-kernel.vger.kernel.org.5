Return-Path: <linux-kernel+bounces-58571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D330D84E86D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA271C28E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC14044365;
	Thu,  8 Feb 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXJR22dM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A613241E1;
	Thu,  8 Feb 2024 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418174; cv=none; b=pvaV5NRaIwGfvkn9Je3oAnk+RMy5GgnpQ3C6c4GIu2wlS/2eI6gpy0d7J8GDmACE9GfVa/oNjO/fSY0mgEtn5IO36MCgTnjFB9tDvedEKEAREQEhXQLNvjZLHh1EaiJSgY261X23HHaCzRyvIxENO0oCFnKP0OPrDzoez6id5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418174; c=relaxed/simple;
	bh=CF1pX065yGAbwnIQLmXi74KKJnRft9elRt9o2Olm5iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ml0gfN7JqZ0tTo0sQcYtqa+wyL8vwzQiGDH+tS4ar86+RPtUEg3itOldKKpric/3jMsRMeLupyeG7Ua+FGOz1CM7gOTGXeRPGIER5buewhAwWpHzBZO2pVEU7YF3/NdRyrnzVaVyZ7fen8CijyGoUkQEZkm7NIav2AYYCc0HpAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXJR22dM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418172; x=1738954172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CF1pX065yGAbwnIQLmXi74KKJnRft9elRt9o2Olm5iY=;
  b=kXJR22dM4kGGLMdYM5E7umSwxoRLAkXpSgk/LrRN1q/1zuYEcdJiYqNt
   LEhdev3OSBLWXo6+GbTVrGJJvkkFNbqIEOwoduNOSaMDxjenSkQzl1Q0d
   MSIqlReqJ3sz170aNiGeFNM1sp5slTTylg/wGtXX4J30uXD+KBXXIMyVw
   ntu9L2UaSaAsi/mrgn8osCOrYaaNHXwj/Txqh6Vj1zg/dx8DwsaFQlUsB
   GmSiquQ1zAY0e74qG42QRV3I/RTHRjhxFDSZDiTWgC+djXzlWgQspgnyv
   noI8p3m9rKT7caSCkdcZk2PpvZy21IRhxq2TcHkiwMDfUwN2aEpAjByoq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1186131"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1186131"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934215532"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934215532"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:49:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 661E5B2C; Thu,  8 Feb 2024 20:49:21 +0200 (EET)
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
Date: Thu,  8 Feb 2024 20:48:04 +0200
Message-ID: <20240208184919.2224986-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
References: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
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


