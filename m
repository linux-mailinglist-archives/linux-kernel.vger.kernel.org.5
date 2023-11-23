Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16CA7F5731
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344566AbjKWEEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjKWEDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:03:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8170F1B5;
        Wed, 22 Nov 2023 20:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700712238; x=1732248238;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=gLcHQ9sSpRvNAc/JiEVqzwzgfQlZmnW1+ez8U6GM0yo=;
  b=nBVy1VBo5Ih/us4VR+z9qW5HPEaK6/7XqSrhnVsH3ZR60ZCvY73FeaBF
   G8yTtmzymJ6OSMbfy5qK4dlnitiFhcgNJ34fsvf5EFWGUqclSWsWXZPKY
   NJue6fBTIWX8xWtmMTJzB16qAFqcWugpGuwhcNRdYKK1MOkLozITjxTv6
   H4X1KxozeRBNDFJlVSR+3b7kSwKTo/9H0ZMcqxF2r2FIGiPjxYOMlvf2h
   19Ndasgx0COOTqtJxFZPeSjOTYhQE9+1lMmHGR8WfgnBSs6Ddgi8qUF2V
   C4l5oIK2G2dxCYZggwd0U2gU/zyf9nIj2W0zG/St0ekoPQsINOZtn+cfo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5334659"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="5334659"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 20:03:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="837671147"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="837671147"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 20:03:56 -0800
Received: from debox1-desk4.lan (snpatel1-mobl.amr.corp.intel.com [10.209.89.91])
        by linux.intel.com (Postfix) with ESMTP id D4ABC580CA6;
        Wed, 22 Nov 2023 20:03:55 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V5 04/20] platform/x86/intel/vsec: Use cleanup.h
Date:   Wed, 22 Nov 2023 20:03:39 -0800
Message-Id: <20231123040355.82139-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123040355.82139-1-david.e.box@linux.intel.com>
References: <20231123040355.82139-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
V5 - Assign no_free_ptr(res) to resource member. This fixes __must_check_fn
     warning.
   - Remove unsed ret variable.

V4 - Do no_free_ptr() before and in call to intel_vsec_add_aux().
   - Add resource cleanup in this patch.

V3 - New patch.

 drivers/platform/x86/intel/vsec.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 15866b7d3117..7dc3650f2757 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -15,6 +15,7 @@
 
 #include <linux/auxiliary_bus.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/idr.h>
@@ -155,8 +156,9 @@ EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, INTEL_VSEC);
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
 
@@ -178,10 +180,8 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 		return -ENOMEM;
 
 	res = kcalloc(header->num_entries, sizeof(*res), GFP_KERNEL);
-	if (!res) {
-		kfree(intel_vsec_dev);
+	if (!res)
 		return -ENOMEM;
-	}
 
 	if (quirks & VSEC_QUIRK_TABLE_SHIFT)
 		header->offset >>= TABLE_OFFSET_SHIFT;
@@ -199,7 +199,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	}
 
 	intel_vsec_dev->pcidev = pdev;
-	intel_vsec_dev->resource = res;
+	intel_vsec_dev->resource = no_free_ptr(res);
 	intel_vsec_dev->num_resources = header->num_entries;
 	intel_vsec_dev->quirks = info->quirks;
 
@@ -208,7 +208,11 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
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

