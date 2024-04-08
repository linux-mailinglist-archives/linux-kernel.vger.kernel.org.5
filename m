Return-Path: <linux-kernel+bounces-135612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEAC89C882
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386071F232C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B87A1411E5;
	Mon,  8 Apr 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1IG8IZp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F92561F;
	Mon,  8 Apr 2024 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590697; cv=none; b=omFh1QRcqIfj/IAsVYc5BfDSlhqABfn0J/+6Y9ySnkzMyQ3avGz+E9fzaI7Zr3EBRE6Bd5c8rsJcA5uLA5tzRHm0hk6aowUIE+J01nlIE8cuIPZFjvPp2W4EomPy5YAprwBWteHTQ/M9OMLoEVedtiuM3a1dzhJ3SpD86tF06vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590697; c=relaxed/simple;
	bh=guvuqxnXVGJWUOz34Xxm6gLdYS67IOdUwd2f5vSl8+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6lAioTrK5OIwpD3y+zRew9JdFkFEZReEatK1cQan1hzse1ntJlIieOPDGzgtl55IBdv9NbTsZcEAQ6Ea4KBU9856NAh2Fu3zd2bCyftonPAAj3GwCTHy84icgwYIltOdjBo6yHa9lTWlcSUDzDQIpKxXBSHLKQxTOGo7iyHoxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1IG8IZp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712590696; x=1744126696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=guvuqxnXVGJWUOz34Xxm6gLdYS67IOdUwd2f5vSl8+4=;
  b=V1IG8IZpIncZnrOxqrrbaQM/733O5xzr5R+380lUtr+Mtg6D4j6t2cVK
   7lCuR3e/xLNiemRfeukzfV0gVg3yHwzKWwXhfIWMqkyMgaUO/desOS140
   ed0H+53MVerJ6WBwjYvgjzZqqQa9YB0/kRTTOztG3dhjcAbWSj0mLXTuT
   hgBUPWh7bJE5dKhYAMeUX6LKUJzz/5ABqw2o5TA4QLsMZO08bBPww9Yrr
   NvEGfPGrsUqSc8xfUKBkf5deuoyg52MEqU/o5jHuIBbcCab6pQX3RF4yw
   p/7NgbY3aRFth/z1JM4gYlUYDCkVpHBUQvXpDAVkx7jV8IKEM/AV6fU/C
   w==;
X-CSE-ConnectionGUID: rC+vuNcLQmK9f1X49XZT1A==
X-CSE-MsgGUID: snFlj6K3SRulHCJ1ctGnyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11666515"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="11666515"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:38:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937091742"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="937091742"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2024 08:38:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5A1FB24D; Mon,  8 Apr 2024 18:38:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86: android-tablets: Use GPIO_LOOKUP() macro
Date: Mon,  8 Apr 2024 18:37:49 +0300
Message-ID: <20240408153749.119394-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use GPIO_LOOKUP() macro which provides a compound literal
and can be used with dynamic data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/x86-android-tablets/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index a3415f1c0b5f..3f56a9dcba52 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -52,10 +52,8 @@ int x86_android_tablet_get_gpiod(const char *chip, int pin, const char *con_id,
 		return -ENOMEM;
 
 	lookup->dev_id = KBUILD_MODNAME;
-	lookup->table[0].key = chip;
-	lookup->table[0].chip_hwnum = pin;
-	lookup->table[0].con_id = con_id;
-	lookup->table[0].flags = active_low ? GPIO_ACTIVE_LOW : GPIO_ACTIVE_HIGH;
+	lookup->table[0] =
+		GPIO_LOOKUP(chip, pin, con_id, active_low ? GPIO_ACTIVE_LOW : GPIO_ACTIVE_HIGH);
 
 	gpiod_add_lookup_table(lookup);
 	gpiod = devm_gpiod_get(&x86_android_tablet_device->dev, con_id, dflags);
-- 
2.43.0.rc1.1.gbec44491f096


