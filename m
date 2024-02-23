Return-Path: <linux-kernel+bounces-79063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB25861D01
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5747288CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8C714CABD;
	Fri, 23 Feb 2024 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAb3t4HU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02391493B4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717883; cv=none; b=AVs3wfUisDXS2lVc7IhvIYd2HV0CHh7I/5qu/9pewDreE11wLKyRkJW9DwhhefSnQhN9j2oJI7UQdpDmiGS53SWf9XRjf0/Ll0TAQ6e0RwyGFVoEgtXCWnuArbJxXyLZxatwN1XNdln8ZMMX9/eymr5bHmw0YMLFvVsXrnZLaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717883; c=relaxed/simple;
	bh=0PKdh4pEIrqDSQO7ZRWs0TVdP0lCYrCSx8iDEn/lkVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maaweI5YbJDzr8Tiipzdrz0X98zWYyAEe6oQeYXbmA7rVnxYuo1dHc5CCXQTSCDt1kUEXZ10Ax8EF14+mES3rc2W4vofZ/g7a9HXg10GA0Utb69BltyXHao+WzCLAv6NAMW1XQ0KibhKVrONhL7mY+3CRM47Ul9MEgFsg3ZfUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAb3t4HU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708717882; x=1740253882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0PKdh4pEIrqDSQO7ZRWs0TVdP0lCYrCSx8iDEn/lkVs=;
  b=hAb3t4HUBUl3zBlB/a7OjwUDRIEVS57tTUQSTyoyUYkHicJiD5sW+QMJ
   vlqoYr6aMmoAkClKqd0jVSUxwTgoCgJTEApLJuA0ApZyyvHj4IgjagnLI
   ou3ZpndePmqRA0/boK4gJcFPK/JYhVFPtHnvYHhwve3QmVg8tl2rZzNf7
   ruIXNF5Ty5XD2cpK7KfrKA0ctK0kXf52U3q5Q0qg45k60NsZuwWk1W4z3
   tJ1TjA0jsLk6otoCsmtNcH+Sed28VTdera68ZIVquohZ8K190hkv24fkZ
   yu8++u9VXTVX6ygYir6dbO+Fz0Rq+di5tOepU3LtXaDyJtbwVoKborM3G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6837328"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6837328"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 11:51:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="937025653"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="937025653"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 11:51:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AF78479A; Fri, 23 Feb 2024 21:51:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>
Subject: [PATCH v1 3/6] mfd: kempld: Simplify device registration
Date: Fri, 23 Feb 2024 21:49:52 +0200
Message-ID: <20240223195113.880121-4-andriy.shevchenko@linux.intel.com>
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

Use platform_device_register_full() instead of open coding this
function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/kempld-core.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index e8ac30528085..e207a62d6577 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -6,6 +6,7 @@
  * Author: Michael Brunner <michael.brunner@kontron.com>
  */
 
+#include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/kempld.h>
@@ -131,28 +132,20 @@ static struct platform_device *kempld_pdev;
 static int kempld_create_platform_device(const struct dmi_system_id *id)
 {
 	const struct kempld_platform_data *pdata = id->driver_data;
-	int ret;
+	const struct platform_device_info pdevinfo = {
+		.name = "kempld",
+		.id = PLATFORM_DEVID_NONE,
+		.res = pdata->ioresource,
+		.num_res = 1,
+		.data = pdata,
+		.size_data = sizeof(*pdata),
+	};
 
-	kempld_pdev = platform_device_alloc("kempld", -1);
-	if (!kempld_pdev)
-		return -ENOMEM;
-
-	ret = platform_device_add_data(kempld_pdev, pdata, sizeof(*pdata));
-	if (ret)
-		goto err;
-
-	ret = platform_device_add_resources(kempld_pdev, pdata->ioresource, 1);
-	if (ret)
-		goto err;
-
-	ret = platform_device_add(kempld_pdev);
-	if (ret)
-		goto err;
+	kempld_pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(kempld_pdev))
+		return PTR_ERR(kempld_pdev);
 
 	return 0;
-err:
-	platform_device_put(kempld_pdev);
-	return ret;
 }
 
 /**
@@ -424,7 +417,7 @@ static int kempld_probe(struct platform_device *pdev)
 	struct resource *ioport;
 	int ret;
 
-	if (kempld_pdev == NULL) {
+	if (IS_ERR_OR_NULL(kempld_pdev)) {
 		/*
 		 * No kempld_pdev device has been registered in kempld_init,
 		 * so we seem to be probing an ACPI platform device.
-- 
2.43.0.rc1.1.gbec44491f096


