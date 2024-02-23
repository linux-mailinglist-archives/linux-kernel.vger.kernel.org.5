Return-Path: <linux-kernel+bounces-79062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAAE861D00
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4FB1F26508
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E3A14CAB5;
	Fri, 23 Feb 2024 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jsv4uSfg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01ED1493B3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717883; cv=none; b=ljz8wt/K+erjjyZxxGupzOHPWT9WOQFp62jNezLbn8sD6umaHOFVp1p6vPWro68+yPvMRtcOipV8mAJaxO6mCIc/pAwkrUNxzKJ1eJHRx0y2ZoUPyO7qhTP1v51fJ34aWGNKNALSZ6nmmurLrO9W1R1HD8rzkqUwjLpQGxZjX7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717883; c=relaxed/simple;
	bh=JOR5ZbgquS01wBvWAK1H9MXS0YUwJRqWZazvt54flDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aP2KyOY+YljhT9FnzR6heLqieJfNb6RJ7yR8sguebs0RAz2i/R7mAhBLKGaTocx/A2SJl1Y2/o5G59QYeIBD8kW+kDA8FRu5aftmdLmyc0uRoA1HirUaGyCfn2cFnZ7bqempPod/fWe9R5x52XVk7Ox7tiDQABknWVzu1gho1go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jsv4uSfg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708717882; x=1740253882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JOR5ZbgquS01wBvWAK1H9MXS0YUwJRqWZazvt54flDI=;
  b=Jsv4uSfgUXwdTHJXrzzPaojcnTBHgIohnNZi91BBIuylQQxlp+ujUCtd
   h1SKm60m/uANQAu1s20lTNbX8nW917s/ZGqskA0tRK/z/6Snn0X8ztGKL
   wEnJphsdFLoSXNCbHazRLJsstMY+ko46KuQckBpJCTZIJSUZDpq++xyTc
   ZcImKuig2mkEGAiyVOPD6U87VvwWGCNCKciicQev7H2RMHC9csXKzQ3HT
   lI8ikJb7FIYD9AQHkhhCJnEhohqVl+CpG0v/rZcz4vsHFdK3Vrrq5Tx1l
   fpPy8SXrH48zcEgXY4TImvNB8jDJR7pcbyJ+5RUG4D0ApBwuQgBGuhWJz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6837330"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6837330"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 11:51:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="937025654"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="937025654"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 11:51:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BF63B80C; Fri, 23 Feb 2024 21:51:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>
Subject: [PATCH v1 4/6] mfd: kempld: Use PLATFORM_DEVID_NONE instead of -1
Date: Fri, 23 Feb 2024 21:49:53 +0200
Message-ID: <20240223195113.880121-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
References: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the `PLATFORM_DEVID_NONE` constant instead of hard-coding -1
when creating a platform device.

No functional changes are intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/kempld-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index e207a62d6577..c3bc61dcd098 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -109,7 +109,7 @@ static int kempld_register_cells_generic(struct kempld_device_data *pld)
 	if (pld->feature_mask & KEMPLD_FEATURE_MASK_UART)
 		devs[i++].name = kempld_dev_names[KEMPLD_UART];
 
-	return mfd_add_devices(pld->dev, -1, devs, i, NULL, 0, NULL);
+	return mfd_add_devices(pld->dev, PLATFORM_DEVID_NONE, devs, i, NULL, 0, NULL);
 }
 
 static struct resource kempld_ioresource = {
-- 
2.43.0.rc1.1.gbec44491f096


