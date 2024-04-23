Return-Path: <linux-kernel+bounces-155903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58FB8AF8B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47701C236DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C28D142E98;
	Tue, 23 Apr 2024 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWesDHrx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7366142E79
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713906436; cv=none; b=eN4IAaCKnVRnsVDSTnkRnYWJMX3vjyebHHSwaTgcLnMoOEqNI2Z6KBGbpKQBXV0fXWV8zBdpdkyFaUaptZIWVF51Yw7LU0yv3+ZxQpJ8RPlvfUZuRsmWYeFMTZYdOLoW/OGBPbzlhAL10iJJbYd1KTBVftjdEBJmo7RY76koK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713906436; c=relaxed/simple;
	bh=rIqgELUr3gbdZHIP9UItgtuJvQ7yBKB414xbroUkfqo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NNSqp+0m/I7HlbgH8RZJ/ykccCtQ0IlBtpmG7jHckHuF/+Pc64NADPVzubjdYgrAuEzr7zbkrVh6pECrFuY4Zpbb9uAz2pSdXe0Xd41vx1FwpHvnlXAG4+SAh/vEDJMCJcJ4RMZvc9hPLKu9UnosIS1P/fjI0BLP7jI1z4dylLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWesDHrx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713906434; x=1745442434;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rIqgELUr3gbdZHIP9UItgtuJvQ7yBKB414xbroUkfqo=;
  b=MWesDHrx+eKZFgvsva+qnNTaB1Pg1L+4b66OadqivxCxiDXN4TD56mho
   f1OKu4GjYNLWS5k7h5kHaYBeTqJ4yRryUJfC/foImzXzWYm+ozt6rtn5m
   eevyEJGlBRTXb2F5QOFAc/TRrStsvUbSvQFSkx9oTZWdENB2mEu6KQoSS
   va3V9sN7Y420nGRtOhsuvUgg8P1w3KvX1V8634wRRJQ7737VOY70LfXIj
   y/2IDZTszMPxARY0L/91OdE7kCxRU+F+Sa7etWMJxrRoHKgZGC1SE/UN+
   4WTlhME5iJGLtVtAywDcZtzIVN6JYlLhfhR0HEuix6qCS3017XUOYelWf
   A==;
X-CSE-ConnectionGUID: sTOd5KGgQHWjViz1q4TqHw==
X-CSE-MsgGUID: SkMQ/CrKTRWnsthNWJRqig==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20662861"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20662861"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 14:07:14 -0700
X-CSE-ConnectionGUID: weQIvzxgR1WB3l2Gw3anUg==
X-CSE-MsgGUID: gYpubLOHQIK6O9Z0m5Pmfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="47764589"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 23 Apr 2024 14:07:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 880C151E; Wed, 24 Apr 2024 00:07:11 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] mfd: kempld: Remove custom DMI matching code
Date: Wed, 24 Apr 2024 00:06:44 +0300
Message-ID: <20240423210706.3709568-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ->init() open codes the functionality of DMI matching code.
Moreover, all DMI quirks are using the same callback and driver_data.
With this in mind, refactor the DMI matching code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed obvious typo
 drivers/mfd/kempld-core.c | 120 +++++---------------------------------
 1 file changed, 14 insertions(+), 106 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index ce7d52a62e51..8a332852bf97 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -129,9 +129,8 @@ static const struct kempld_platform_data kempld_platform_data_generic = {
 
 static struct platform_device *kempld_pdev;
 
-static int kempld_create_platform_device(const struct dmi_system_id *id)
+static int kempld_create_platform_device(const struct kempld_platform_data *pdata)
 {
-	const struct kempld_platform_data *pdata = id->driver_data;
 	const struct platform_device_info pdevinfo = {
 		.name = "kempld",
 		.id = PLATFORM_DEVID_NONE,
@@ -497,375 +496,281 @@ static const struct dmi_system_id kempld_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-bBD"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "BBL6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-bBL6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "BDV7",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-bDV7"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "BHL6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-bHL6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "BKL6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-bKL6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "BSL6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-bSL6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CAL6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-cAL"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CBL6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-cBL6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CBW6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-cBW6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CCR2",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-bIP2"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CCR6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-bIP6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CDV7",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-cDV7"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CHL6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-cHL6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CHR2",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "ETXexpress-SC T2"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CHR2",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "ETXe-SC T2"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CHR2",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-bSC2"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CHR6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "ETXexpress-SC T6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CHR6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "ETXe-SC T6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CHR6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-bSC6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CKL6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-cKL6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CNTG",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "ETXexpress-PC"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CNTG",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-bPC2"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CNTX",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "PXT"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CSL6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-cSL6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "CVV6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-cBT"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "FRI2",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BIOS_VERSION, "FRI2"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "FRI2",
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Fish River Island II"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "A203",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "KBox A-203"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "M4A1",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-m4AL"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "MAL1",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-mAL10"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "MAPL",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "mITX-APL"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "MBR1",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "ETX-OH"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "MVV1",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-mBT"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "NTC1",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "nanoETXexpress-TT"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "NTC1",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "nETXe-TT"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "NTC1",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-mTT"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "NUP1",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-mCT"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "PAPL",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "pITX-APL"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "SXAL",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "SMARC-sXAL"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "SXAL4",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "SMARC-sXA4"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "UNP1",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "microETXexpress-DC"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "UNP1",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-cDC2"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "UNTG",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "microETXexpress-PC"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "UNTG",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-cPC2"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "UUP6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-cCT6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "UTH6",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "COMe-cTH6"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	}, {
 		.ident = "Q7AL",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
 			DMI_MATCH(DMI_BOARD_NAME, "Qseven-Q7AL"),
 		},
-		.driver_data = (void *)&kempld_platform_data_generic,
-		.callback = kempld_create_platform_device,
 	},
 	{}
 };
@@ -874,18 +779,21 @@ MODULE_DEVICE_TABLE(dmi, kempld_dmi_table);
 static int __init kempld_init(void)
 {
 	const struct dmi_system_id *id;
+	int ret = -ENODEV;
 
-	if (force_device_id[0]) {
-		for (id = kempld_dmi_table;
-		     id->matches[0].slot != DMI_NONE; id++)
-			if (strstr(id->ident, force_device_id))
-				if (id->callback && !id->callback(id))
-					break;
-		if (id->matches[0].slot == DMI_NONE)
-			return -ENODEV;
-	} else {
-		dmi_check_system(kempld_dmi_table);
+	for (id = dmi_first_match(kempld_dmi_table); id; id = dmi_first_match(id + 1)) {
+		/* Check, if user asked for the exact device ID match */
+		if (force_device_id[0] && !strstr(id->ident, force_device_id))
+			continue;
+
+		ret = kempld_create_platform_device(&kempld_platform_data_generic);
+		if (ret)
+			continue;
+
+		break;
 	}
+	if (ret)
+		return ret;
 
 	return platform_driver_register(&kempld_driver);
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac


