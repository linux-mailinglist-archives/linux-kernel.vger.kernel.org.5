Return-Path: <linux-kernel+bounces-62050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC1D851ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3979E284337
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC044BAA6;
	Mon, 12 Feb 2024 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdbcK+O3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7A84653A;
	Mon, 12 Feb 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757495; cv=none; b=mZBMIZptXxtkX9hBEgwqtWxYVgNtRPn/AN9lBvMnRTGvLcnib7rvdW6z3ECaE9eWve6239WeW8cx6Zg2nIIH4J7s04FbXZXn1m4DPO6RYO8kXQkyZlOmCaRLT6nY3Z68nECqRcTbm3AcsMUfq6AhoGiG40k30fo6pmDL4/t4VE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757495; c=relaxed/simple;
	bh=bXuKJcg7HA+0Vb4HJgUnDZd4G/OsktT5Y7OPT252SMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5EhPTuapfMLiGazIAo44BD0LSOtSyyVca7OMkHtZZ0k1udGVMA97uyIB2Z4/BCVUetKHSTvOe+syNGPq3vPf7r5fZbT76qk+KMBxrDymnnHM6MyIHNiB5GWFrNwL/Tth8xzdjz9orYPVNy2qEc8BSC8dJ6znURRUxwdVMT2VD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdbcK+O3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757494; x=1739293494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bXuKJcg7HA+0Vb4HJgUnDZd4G/OsktT5Y7OPT252SMI=;
  b=HdbcK+O3YVj012egshvSaE2a5sx00TXMmyLj4CCAeJKIEyuenFrfwD4G
   4EIPQ1/157D3F6lywrt4DAya+0UxKk4eGLfLaI6G4TNTO3t8L7/UFghou
   sBLQa7TAZ9eHrLzx/n++kTf9DJsg8LT8mlqDdqMNFnvzcsAfOGVqp9jQd
   GoHcEXU/ozV01DXb18qAZ4chlN5zJi7kxptxZz33ROrw4lgj96eNmfLl9
   emWaAnFfuS6o8YLrjCQbo1LsFAf0PeNLb7FqeTXZYzCe+u/XJs7KtpH4J
   KhOd+DTEpMjg9L2G2RsmoZZ1vN21gbpN/z0ugsHaOTiaZVlyi3kpeejyt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19153214"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19153214"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:04:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935116821"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935116821"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 09:04:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CFD172DC; Mon, 12 Feb 2024 19:04:42 +0200 (EET)
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
Subject: [PATCH v2 06/15] auxdisplay: linedisp: Move exported symbols to a namespace
Date: Mon, 12 Feb 2024 19:01:39 +0200
Message-ID: <20240212170423.2860895-7-andriy.shevchenko@linux.intel.com>
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
index a0339e4b5939..8d0ebdf0f10d 100644
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


