Return-Path: <linux-kernel+bounces-129614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F57896D55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8FACB21F31
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED4213A417;
	Wed,  3 Apr 2024 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djKPriSZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C2136980
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141710; cv=none; b=l7e304d1JApOCbahv3In6+mb/HU55RAeNUAsaMpmdILjhu1dyE8tIxHaVXjInTIaav7DjkqggkSkRxUBZX7t7IcoQX1+pxQwn0cLUR0fKeTt5rA1kTFVVuW5XfEIiEfuXmyxNyX1QusvKV/ogi9Sbr0eYiIWi4p3Hy5xOVYMcxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141710; c=relaxed/simple;
	bh=+zEzKaMWhoPEdYiBNRyCWeVk2M3rTPfRQ1A8hK2rdsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLpOEzrwSAR/hXDQyivWVAgrudhpCesQ5XroqNuhoymBfwi5wbc/sCPimlaeNpS7H6ItlhDMAIvnwC4hKO9yHe38KiQ7kCfitJ+YcH11VMarvp+sGuWw2VbL6SdT5qDa86MuD24c/EklnKzWqeClIAbaaeV4jF4mWoWzDIDf1kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djKPriSZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712141709; x=1743677709;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+zEzKaMWhoPEdYiBNRyCWeVk2M3rTPfRQ1A8hK2rdsk=;
  b=djKPriSZ85bWrtIQVgTn40q+137LZpBxNseata81QB5bdGWq+fdb4+O+
   pUz/0eD6WNcAc4OEWdm/vUHZMxnCoBVw9+tkrjl4ahUoe2gFVGYhPxmaV
   01x3L3gATYoZHr1belxa/8FQbYnPsh1ShmsTaq4yPuuG6RXKa8HvTK3V9
   Rn6ZgBU45dyuOhELSrAIreitFr5FjkTE9CkphMkXunIoCMxEkFEVPUGKg
   0wsdlitQo/uWdxvtEIZQxsAGbGWDBqKZK2NMNI88oqRfS+YMt1BgN2Mht
   4HUb60+AWgkPMrDBHnaWtGQ3awtIm/w8PbpFvw7lXLZ78rFOAGOxClp1N
   g==;
X-CSE-ConnectionGUID: fwGLIQLfT/ik+qzfZ/SJmw==
X-CSE-MsgGUID: hw8blbCyQr2wF72U5dkJYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10334235"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="10334235"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937084886"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937084886"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 03:55:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 117FF3E5; Wed,  3 Apr 2024 13:55:06 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dan Callaghan <dcallagh@chromium.org>,
	=?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] platform/chrome: cros_hps_i2c: Replace deprecated UNIVERSAL_DEV_PM_OPS()
Date: Wed,  3 Apr 2024 13:55:02 +0300
Message-ID: <20240403105502.558351-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UNIVERSAL_DEV_PM_OPS() macro is deprecated. Replace it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/chrome/cros_hps_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_hps_i2c.c b/drivers/platform/chrome/cros_hps_i2c.c
index b31313080332..dd14957ec39f 100644
--- a/drivers/platform/chrome/cros_hps_i2c.c
+++ b/drivers/platform/chrome/cros_hps_i2c.c
@@ -126,7 +126,7 @@ static int hps_resume(struct device *dev)
 	hps_set_power(hps, true);
 	return 0;
 }
-static UNIVERSAL_DEV_PM_OPS(hps_pm_ops, hps_suspend, hps_resume, NULL);
+static DEFINE_RUNTIME_DEV_PM_OPS(hps_pm_ops, hps_suspend, hps_resume, NULL);
 
 static const struct i2c_device_id hps_i2c_id[] = {
 	{ "cros-hps", 0 },
@@ -148,7 +148,7 @@ static struct i2c_driver hps_i2c_driver = {
 	.id_table = hps_i2c_id,
 	.driver = {
 		.name = "cros-hps",
-		.pm = &hps_pm_ops,
+		.pm = pm_ptr(&hps_pm_ops),
 		.acpi_match_table = ACPI_PTR(hps_acpi_id),
 	},
 };
-- 
2.43.0.rc1.1.gbec44491f096


