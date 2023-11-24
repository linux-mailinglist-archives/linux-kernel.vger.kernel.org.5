Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5686F7F8504
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 21:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346107AbjKXUDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 15:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjKXUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 15:03:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A73F170B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700856187; x=1732392187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wjIuz3y60umWAMMG08jdscB6p7782TQh9CFOLAOBo9c=;
  b=i3A6gwIEG2nND+KvFE1ZCpH22Gw2ThnHgYEHcFx6Y6n9Jn5m0qHz6JYq
   kaAF1Ici8mRqiBf5e6DKX0dqt3gVihE6xItWVSBndpDK5Cl/NrsV08pq2
   8B235rfTCSaMZnv+1eoqtG+x9QDhn8HZweAP+2ZRd4ZnNYNzFhOXv41so
   XxUUtmUEunmXmPTjaOKK9JXZm3UNCc2FH38C1p+6txlBGQdziH4okcnKd
   aj1q+sMuTOyNQvdmpTrX6CSh57EbORz/0bgU3wIpTmEJrABiG+CTWzPDb
   xuYUWW2j9hpPfaA3ZCfM5yUoV6kMZJzN9z+krZpFnswLbcv0zjWTKTxl8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="391338128"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="391338128"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 12:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="1014983739"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="1014983739"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 24 Nov 2023 12:03:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B8079305; Fri, 24 Nov 2023 22:03:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>
Subject: [PATCH v1 4/5] mfd: intel-lpss: Move exported symbols to INTEL_LPSS namespace
Date:   Fri, 24 Nov 2023 21:31:27 +0200
Message-ID: <20231124200258.3682979-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231124200258.3682979-1-andriy.shevchenko@linux.intel.com>
References: <20231124200258.3682979-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid unnecessary pollution of the global symbol namespace by
moving library functions in to a specific namespace and import
that into the drivers that make use of the functions.

For more info: https://lwn.net/Articles/760045/

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-acpi.c |  1 +
 drivers/mfd/intel-lpss-pci.c  |  1 +
 drivers/mfd/intel-lpss.c      | 10 +++++-----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index e4a62cc02cfc..a9e2d9308a01 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -223,3 +223,4 @@ MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_DESCRIPTION("Intel LPSS ACPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(INTEL_LPSS);
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index bc15379afe3b..e1d89423daa6 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -603,3 +603,4 @@ MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_DESCRIPTION("Intel LPSS PCI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(INTEL_LPSS);
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 79ea5e2ad0a6..4a63703b6da5 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -456,7 +456,7 @@ int intel_lpss_probe(struct device *dev,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(intel_lpss_probe);
+EXPORT_SYMBOL_NS_GPL(intel_lpss_probe, INTEL_LPSS);
 
 void intel_lpss_remove(struct device *dev)
 {
@@ -468,7 +468,7 @@ void intel_lpss_remove(struct device *dev)
 	intel_lpss_unregister_clock(lpss);
 	ida_free(&intel_lpss_devid_ida, lpss->devid);
 }
-EXPORT_SYMBOL_GPL(intel_lpss_remove);
+EXPORT_SYMBOL_NS_GPL(intel_lpss_remove, INTEL_LPSS);
 
 #ifdef CONFIG_PM
 static int resume_lpss_device(struct device *dev, void *data)
@@ -488,7 +488,7 @@ int intel_lpss_prepare(struct device *dev)
 	device_for_each_child_reverse(dev, NULL, resume_lpss_device);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(intel_lpss_prepare);
+EXPORT_SYMBOL_NS_GPL(intel_lpss_prepare, INTEL_LPSS);
 
 int intel_lpss_suspend(struct device *dev)
 {
@@ -509,7 +509,7 @@ int intel_lpss_suspend(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(intel_lpss_suspend);
+EXPORT_SYMBOL_NS_GPL(intel_lpss_suspend, INTEL_LPSS);
 
 int intel_lpss_resume(struct device *dev)
 {
@@ -524,7 +524,7 @@ int intel_lpss_resume(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(intel_lpss_resume);
+EXPORT_SYMBOL_NS_GPL(intel_lpss_resume, INTEL_LPSS);
 #endif
 
 static int __init intel_lpss_init(void)
-- 
2.43.0.rc1.1.gbec44491f096

