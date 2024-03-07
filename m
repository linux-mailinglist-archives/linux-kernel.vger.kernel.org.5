Return-Path: <linux-kernel+bounces-95749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771E0875207
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8A4B25C20
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BF312F591;
	Thu,  7 Mar 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAu+gyf0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E62012C7F5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822212; cv=none; b=jiZe3Rvpngh+QBIF6ZxYUvRVqjsgpAS8oozIj6/FfPNKCH+M5TDafWkwdMNFVMYXn7jMEQMSPrMLukb0LiEyjamtEw962VsOTWSzgwqoBebt5obIV0EKlsssEY4EkXwXCEKst7esqZcU5T0mj+5ki/9si+X9ZfvLtEPK5UORyYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822212; c=relaxed/simple;
	bh=++4aIXY+dzGT+hv5axuOYMIB1kIX/RNjVM6yezNWmhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMbfnQeIhDSOQ64i3PRakGsPMhsfMHkbwoyhVsdJXkrIYAoHRKceEJlx1Kwz5lR3zlx309PAtV7zoL8os7Pt2wygnpBZgFGvNfsLUjEeQI81kLzuV0Ci9i3/ibL78eifhpawsHyF96Q9RbBxWOz73G73eD/6SDV2OjImWJvSYqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAu+gyf0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709822211; x=1741358211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=++4aIXY+dzGT+hv5axuOYMIB1kIX/RNjVM6yezNWmhI=;
  b=lAu+gyf07RZDEJ6kNbyXaXrE+fojJXl3UDA0n7cp3GrWo+pkJDb2q8Ng
   KlB52dVQSwtiXlXibGH0xShvbNGKQ1GVWLgHmZ8yKHqXF7mQiTRn6YNjQ
   S/S2pc037WO+YFDFHHKObTTv4Q0RCDO5AYEEW63Nx+UX0qidKMtcExEoh
   lJLY6M2A5qVrd6k+yigWQIYiATw8iPDzvgkxLevgGW2j4xgdIZptgFh8u
   BLzVMNOie7t0jljlYvk6jFLcaaxiyFoe/ryN7n4BJ7bbxF824QlIcSW9s
   yPEpicXSj3MnezvnL2C8k9wUgxo29IWY4YxzlVGdeuzQoa/y+8XSb/1Ea
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4348213"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4348213"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 06:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046243"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046243"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 06:36:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 213A75BB; Thu,  7 Mar 2024 16:36:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] w1: gpio: Remove duplicate NULL checks
Date: Thu,  7 Mar 2024 16:35:50 +0200
Message-ID: <20240307143644.3787260-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
References: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gpiod_set_value() is NULL-aware, no need to check that in the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/w1/masters/w1-gpio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index 3881f2eaed2f..8fd9fedd8c56 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -117,8 +117,7 @@ static int w1_gpio_probe(struct platform_device *pdev)
 	if (err)
 		return dev_err_probe(dev, err, "w1_add_master device failed\n");
 
-	if (ddata->pullup_gpiod)
-		gpiod_set_value(ddata->pullup_gpiod, 1);
+	gpiod_set_value(ddata->pullup_gpiod, 1);
 
 	platform_set_drvdata(pdev, master);
 
@@ -130,8 +129,7 @@ static void w1_gpio_remove(struct platform_device *pdev)
 	struct w1_bus_master *master = platform_get_drvdata(pdev);
 	struct w1_gpio_ddata *ddata = master->data;
 
-	if (ddata->pullup_gpiod)
-		gpiod_set_value(ddata->pullup_gpiod, 0);
+	gpiod_set_value(ddata->pullup_gpiod, 0);
 
 	w1_remove_master_device(master);
 }
-- 
2.43.0.rc1.1.gbec44491f096


