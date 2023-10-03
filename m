Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DAB7B6B46
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239530AbjJCOVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbjJCOVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:21:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29017AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696342889; x=1727878889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jyChkOm5+0E4fBJW+xbiyHU6ardeklxm2J2AA01Zy/M=;
  b=RVZmicK9g9VpEGyX8ATS8RIsZxLUlg7bDbZ7nlDc668RUJO04K3fArMB
   BOAfHCZJdhbcCPw+0O1j49dTydWVIr30eQeusH1b9lUimzCZ0K9dG3FKB
   JxX4gcBG/6jeIMN/VZE+T4+6CH1zE9N4A6UWkDWmIFVzJarDoYd6AuwoH
   qb5MDaE21dTMutRwzEU8NU2PIEgKjkC33NyIuPm+BIKJPUBKBv9lucyjU
   siTM+nhcCq6uWi+oIaDzD9nUbLrG1lWbdWrWw3DQxUYJhvdplndzs0YWH
   PsAtwExOIiAGHoBRtvY3vNTaMn7aXGcGD9qFuwFMSV7hU7v/6wuNRKGWa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="469163015"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="469163015"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:21:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="866892442"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="866892442"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2023 07:21:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 569D818DE; Tue,  3 Oct 2023 17:21:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] driver core: platform: Use temporary variable in platform_device_add()
Date:   Tue,  3 Oct 2023 17:21:21 +0300
Message-Id: <20231003142122.3072824-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231003142122.3072824-1-andriy.shevchenko@linux.intel.com>
References: <20231003142122.3072824-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the temporary variable for the struct device pointer the code
looks better and slightly easier to read and parse by human being.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/platform.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 2b8645911d51..55891c11dd03 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -655,20 +655,21 @@ EXPORT_SYMBOL_GPL(platform_device_add_data);
  */
 int platform_device_add(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	u32 i;
 	int ret;
 
-	if (!pdev->dev.parent)
-		pdev->dev.parent = &platform_bus;
+	if (!dev->parent)
+		dev->parent = &platform_bus;
 
-	pdev->dev.bus = &platform_bus_type;
+	dev->bus = &platform_bus_type;
 
 	switch (pdev->id) {
 	default:
-		dev_set_name(&pdev->dev, "%s.%d", pdev->name,  pdev->id);
+		dev_set_name(dev, "%s.%d", pdev->name,  pdev->id);
 		break;
 	case PLATFORM_DEVID_NONE:
-		dev_set_name(&pdev->dev, "%s", pdev->name);
+		dev_set_name(dev, "%s", pdev->name);
 		break;
 	case PLATFORM_DEVID_AUTO:
 		/*
@@ -681,7 +682,7 @@ int platform_device_add(struct platform_device *pdev)
 			return ret;
 		pdev->id = ret;
 		pdev->id_auto = true;
-		dev_set_name(&pdev->dev, "%s.%d.auto", pdev->name, pdev->id);
+		dev_set_name(dev, "%s.%d.auto", pdev->name, pdev->id);
 		break;
 	}
 
@@ -689,7 +690,7 @@ int platform_device_add(struct platform_device *pdev)
 		struct resource *p, *r = &pdev->resource[i];
 
 		if (r->name == NULL)
-			r->name = dev_name(&pdev->dev);
+			r->name = dev_name(dev);
 
 		p = r->parent;
 		if (!p) {
@@ -702,16 +703,16 @@ int platform_device_add(struct platform_device *pdev)
 		if (p) {
 			ret = insert_resource(p, r);
 			if (ret) {
-				dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
+				dev_err(dev, "failed to claim resource %d: %pR\n", i, r);
 				goto failed;
 			}
 		}
 	}
 
-	pr_debug("Registering platform device '%s'. Parent at %s\n",
-		 dev_name(&pdev->dev), dev_name(pdev->dev.parent));
+	pr_debug("Registering platform device '%s'. Parent at %s\n", dev_name(dev),
+		 dev_name(dev->parent));
 
-	ret = device_add(&pdev->dev);
+	ret = device_add(dev);
 	if (ret)
 		goto failed;
 
-- 
2.40.0.1.gaa8946217a0b

