Return-Path: <linux-kernel+bounces-162307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF318B5946
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357FC1F21F28
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C20274E0A;
	Mon, 29 Apr 2024 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHjDByE7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980AB71727
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395714; cv=none; b=bjiHV7wB6SWlSHv7Slc1m+n7xgkPKzpUBhAbkSH47jlGmTi3q8+PA3P5vy6mzuvTZgTvBXdx28NvyaVTQGdF+4fm2s+DeDWPMcmY+WClyjTrx9Ytp8/eayr/M5SYRYu0Dj3bItmgc9VkNZM+f3MHtUByoyLdJvh1OFANJgxpF+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395714; c=relaxed/simple;
	bh=dJCLkDppjN/Ufgt5KZBYseEOdz+RGtxNFrfVMP03WhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvIADxKdRLuEMokPgOs1bgZSENX5bx4q3GomJ3Te/ETEq6hep7Jpr64Zy6JMfrlen7+mwHvo9umDpdObIfYeqD4ZA+rLAms3mGBPabeC2CxZGt6TVLjSBwF02a5Ijwzh6dUTgeL13NdPD2XW60cjEhOzJz2VWgluWXr8+o0y1Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHjDByE7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395713; x=1745931713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dJCLkDppjN/Ufgt5KZBYseEOdz+RGtxNFrfVMP03WhQ=;
  b=KHjDByE7IqfJQBWQ33d9l9uun5/ZYGSURBbokMq/DRAFAlkzAewbE9/A
   WBelsPXy9Wz/c77Zkdd9drBnNOcZubRVgOY/qhuu5Fskrg9Xcfb7yuGkS
   bbE9uVJwesu3uHhuPvvc5cTv/+xPxeVlSYi0qE9QJhSPobr/8Avv3QlVM
   Zo5FAZlt4O13Z/TXUWGcU43zfz0UxWdFZFPTswqg8VoTFhVW4qhcbnX94
   XLCopaPv9KExqsj2IW72HnQQQVw2HA4w+/fI3OTLQtl661LAknZiWqJhX
   kUvcrcDTt5W3j0E/b4UQuIBXrqnRLSE3HfZkE0BKcVnKO3bFDtJ1UJpOI
   g==;
X-CSE-ConnectionGUID: YwUr0g7zSQivOjPGbDbEDQ==
X-CSE-MsgGUID: e0d1gDtFRCqwLp1Gf1nBiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986864"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986864"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:01:52 -0700
X-CSE-ConnectionGUID: t4bOZk+JQv6mUfldiznOwQ==
X-CSE-MsgGUID: vVZa0E+nSnC+ZgJTtKNwRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507072"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:01:50 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 05/15] intel_th: Convert to platform remove callback returning void
Date: Mon, 29 Apr 2024 16:01:09 +0300
Message-ID: <20240429130119.1518073-6-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
References: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/acpi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/intel_th/acpi.c b/drivers/hwtracing/intel_th/acpi.c
index 87f9024e4bbb..503620e9fd10 100644
--- a/drivers/hwtracing/intel_th/acpi.c
+++ b/drivers/hwtracing/intel_th/acpi.c
@@ -60,18 +60,16 @@ static int intel_th_acpi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int intel_th_acpi_remove(struct platform_device *pdev)
+static void intel_th_acpi_remove(struct platform_device *pdev)
 {
 	struct intel_th *th = platform_get_drvdata(pdev);
 
 	intel_th_free(th);
-
-	return 0;
 }
 
 static struct platform_driver intel_th_acpi_driver = {
 	.probe		= intel_th_acpi_probe,
-	.remove		= intel_th_acpi_remove,
+	.remove_new	= intel_th_acpi_remove,
 	.driver		= {
 		.name			= DRIVER_NAME,
 		.acpi_match_table	= intel_th_acpi_ids,
-- 
2.43.0


