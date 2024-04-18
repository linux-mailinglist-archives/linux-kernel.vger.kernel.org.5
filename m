Return-Path: <linux-kernel+bounces-149849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B50F8A96BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF16281210
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEE115B540;
	Thu, 18 Apr 2024 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZVUStAv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC3415B10E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434006; cv=none; b=si0p/xcqbXeCc47yzgQondHDwRqcEi/4MAbT8LIrklFQD2NodCFMvq7Sjl9qh97fKC8Azg8rGAksFbNhSFe9Y2B8gzkgacjdWseMfPnjySh9YQkSuctbe/cJwMgwHb96d0EefrrKrtri/wR+xyT8WyiatpSQr8LUbJpCt90x5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434006; c=relaxed/simple;
	bh=8Ws9FNbaDILUf5UHYeLuT/D3VlPRU63hP9RLgfjzec4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jX+vpjZzXJLY1XZtJrmo3jp59h/NYFuJA2mnurrKvZ9JPuyZGb5l7Hqc8wco6qa0PqL9Nso2KgqffDt7pBfEktf9ms+BcSLFBdUtbgq3VFbCe5BExmUm+aHv2uV/p7UsKRKZY7kkkF4vqxLR3Ond+3ANlbYiFS3JMYGu8ulopQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZVUStAv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713434004; x=1744970004;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Ws9FNbaDILUf5UHYeLuT/D3VlPRU63hP9RLgfjzec4=;
  b=JZVUStAv32aEuiACDDZ25+x7OQWuMdoNfF8qC6hHs4Bb6bE7rxaZcDzZ
   tgjkyIZMxPNQDuArqHBI2xTXrBkWO+C67wl2sEj9rVtabxUkBffeOGEE+
   ITp4cwxj0hR/q9Pzy2/mjytqvHd0HVdWky2BYXib+gfy5r8MEYadeNF8Y
   kjqn3ovghnx7244luotsjl81V4zv/j3D/b38bH0ZrinCRcrDNN78jFm9g
   bsgR0NigVUgmMzIKvEv/1zMA/SH8XQCpCkfMSo0trqlsxXE7oiJZ/L1et
   X/JJcIALTVlC00geqdAggAKVv5KFNbDhelvqaGU+zQyl2BzMo1ibX9bIF
   g==;
X-CSE-ConnectionGUID: aLjzGtnYRbOon62U7PfV9g==
X-CSE-MsgGUID: rSdwxVZAT2WtzXcr/kVLTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9192312"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="9192312"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:53:23 -0700
X-CSE-ConnectionGUID: pumgAZ06S8yo1xV5yTi7hQ==
X-CSE-MsgGUID: uVMXD8GcRLy5Y2x7DqyB8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="22986698"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 18 Apr 2024 02:53:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 41A7A24D; Thu, 18 Apr 2024 12:53:21 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] mfd: kempld: Remove custom DMI matching code
Date: Thu, 18 Apr 2024 12:53:19 +0300
Message-ID: <20240418095319.3232118-1-andriy.shevchenko@linux.intel.com>
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
 drivers/mfd/kempld-core.c | 120 +++++---------------------------------
 1 file changed, 14 insertions(+), 106 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index ce7d52a62e51..02e5855eabaf 100644
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
+	int ret -ENODEV;
 
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


