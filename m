Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D167FE309
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343770AbjK2WW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343546AbjK2WVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:21:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF692D5E;
        Wed, 29 Nov 2023 14:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701296504; x=1732832504;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=7NVpmNIbGkzNR5bKws5rMhWK4Hzsb6NBLKtyScjr2do=;
  b=SYdFi688ISdGeQXwsSKB3H5KLNAy5DEoxbCP6rWTUOPlvID8rWDmAu/u
   LIsf7xonVJWD+0Yd09YnMtEeSb1/jdQsnAHkgeNkJnJcTNJ+3R35C2EJx
   ac/hGRWJWg7YOgSKDQRS3AR+UHBgGexRzdbDvLAgvfBbqW5CGRO6XIDHI
   WGFVzWGhtGDLMb8qJPi75eCT0vhzKZ3jdCpwtc3DwKIidmhYexLsaYxRv
   C2iTi+n2NTSrtHUttS2+CgBuYO1mAIIDtbG5rcwoyJrwtCZ0at+GRTF+T
   LlnhgfUN76K/rAWmNyIyZu6IG2za1FQNSK5JZk9BTm9XIK+Yk0jGQQezJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="11936999"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="11936999"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:21:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="798070415"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="798070415"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:21:33 -0800
Received: from debox1-desk4.lan (unknown [10.209.108.167])
        by linux.intel.com (Postfix) with ESMTP id 4E0B4580BF8;
        Wed, 29 Nov 2023 14:21:33 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V6 05/20] platform/x86/intel/vsec: Use cleanup.h
Date:   Wed, 29 Nov 2023 14:21:17 -0800
Message-Id: <20231129222132.2331261-6-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129222132.2331261-1-david.e.box@linux.intel.com>
References: <20231129222132.2331261-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use cleanup.h helpers to handle cleanup of resources in
intel_vsec_add_dev() after failures.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V6 - No change

V5 - Assign no_free_ptr(res) to resource member. This fixes __must_check_fn
     warning.
   - Remove unsed ret variable.

V4 - Do no_free_ptr() before and in call to intel_vsec_add_aux().
   - Add resource cleanup in this patch.

V3 - New patch.

 drivers/platform/x86/intel/vsec.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index ba352af65dde..27e8698ebe5e 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -15,6 +15,7 @@
 
 #include <linux/auxiliary_bus.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/idr.h>
@@ -147,8 +148,9 @@ EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, INTEL_VSEC);
 static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *header,
 			      struct intel_vsec_platform_info *info)
 {
-	struct intel_vsec_device *intel_vsec_dev;
-	struct resource *res, *tmp;
+	struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
+	struct resource __free(kfree) *res = NULL;
+	struct resource *tmp;
 	unsigned long quirks = info->quirks;
 	int i;
 
@@ -170,10 +172,8 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 		return -ENOMEM;
 
 	res = kcalloc(header->num_entries, sizeof(*res), GFP_KERNEL);
-	if (!res) {
-		kfree(intel_vsec_dev);
+	if (!res)
 		return -ENOMEM;
-	}
 
 	if (quirks & VSEC_QUIRK_TABLE_SHIFT)
 		header->offset >>= TABLE_OFFSET_SHIFT;
@@ -191,7 +191,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	}
 
 	intel_vsec_dev->pcidev = pdev;
-	intel_vsec_dev->resource = res;
+	intel_vsec_dev->resource = no_free_ptr(res);
 	intel_vsec_dev->num_resources = header->num_entries;
 	intel_vsec_dev->quirks = info->quirks;
 
@@ -200,7 +200,11 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	else
 		intel_vsec_dev->ida = &intel_vsec_ida;
 
-	return intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
+	/*
+	 * Pass the ownership of intel_vsec_dev and resource within it to
+	 * intel_vsec_add_aux()
+	 */
+	return intel_vsec_add_aux(pdev, NULL, no_free_ptr(intel_vsec_dev),
 				  intel_vsec_name(header->id));
 }
 
-- 
2.34.1

