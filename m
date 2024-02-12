Return-Path: <linux-kernel+bounces-61114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEC1850D78
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289341C222CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A6C79F6;
	Mon, 12 Feb 2024 06:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMwoE8Y8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787866FC9;
	Mon, 12 Feb 2024 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707718257; cv=none; b=GPDzBt2db2yKUilFeitMjQlp88oZvteu7/dGUbF4TCQaDm6Pq8cJS889PiyG9bAhyks8up56H4+IA/PlXg64enj2iZISNnqWZzQrbyO+d/ZQgaI9O7iSvc+yTdrDL8MVU9caoAqmPehkSwutMmzukl7jyK4vASoZ/Ulb+s0r9ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707718257; c=relaxed/simple;
	bh=jvvTX9xGLG4IzLGwjlGRdcVBdlqwqLpdd4kYuOzMO0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qX1r2e3ccolklZp3AjX0tzZN/gRIxhVmbpx+FkjAnbOThWnT+oI66uGu1jeQrVtjeu3ykRR5Y4yjT7yCZRcfK7hAU9jj7Y7zgbScl8eelbkG0Ce1M7gtDKZ8KA7iMufCCZDTGHY6H6nm9775wR8SYS+kvVBjev4MJ52qKlgj7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMwoE8Y8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707718257; x=1739254257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jvvTX9xGLG4IzLGwjlGRdcVBdlqwqLpdd4kYuOzMO0Q=;
  b=hMwoE8Y8yH2X+u47vqerGiAnd8Pu+/a9n25REKi6q4LbHNvsZWXT/Na0
   uSqDWiHb/ReWHTHXExcbCfsfOAdi9RGgEYT4y3xq5CSoUjEXmF6GsCs79
   /mUga63RFbZLKMz+UE3brBWFoV1f0g1zzs3YJ39d7Y6movMQwrTzU8tyU
   T6DZ2FSiZqA3tdQ3WrAgQfUolTm+h7lZu7hQZDXqgNlf0lXWkTyCBH4O1
   3M9U86O0oj65YK+crBV4n1xOsUq5d0D/vqqWlpHh2KUP5nZe/gdsI/lT/
   0VGE9KZCPBCBYLn+fXpYPtYfCHHmotfPN/A7UEQ2HaPLkUVGHz3M1TCLE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1833042"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1833042"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 22:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="33574488"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2024 22:10:40 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 55A291CAE9;
	Mon, 12 Feb 2024 11:40:39 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 52FF81600101; Mon, 12 Feb 2024 11:40:39 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 1/2] pwm: lpss: use devm_pm_runtime_enable() helper
Date: Mon, 12 Feb 2024 11:40:36 +0530
Message-Id: <20240212061037.4271-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240212061037.4271-1-raag.jadav@intel.com>
References: <20240212061037.4271-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_pm_runtime_enable() helper to enable runtime PM and drop redundant
platform ->remove() callback.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-platform.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 319809aac2c4..60b376393352 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -57,14 +57,7 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 						    DPM_FLAG_SMART_SUSPEND);
 
 	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
-	return 0;
-}
-
-static void pwm_lpss_remove_platform(struct platform_device *pdev)
-{
-	pm_runtime_disable(&pdev->dev);
+	return devm_pm_runtime_enable(&pdev->dev);
 }
 
 static const struct acpi_device_id pwm_lpss_acpi_match[] = {
@@ -82,7 +75,6 @@ static struct platform_driver pwm_lpss_driver_platform = {
 		.acpi_match_table = pwm_lpss_acpi_match,
 	},
 	.probe = pwm_lpss_probe_platform,
-	.remove_new = pwm_lpss_remove_platform,
 };
 module_platform_driver(pwm_lpss_driver_platform);
 
-- 
2.35.3


