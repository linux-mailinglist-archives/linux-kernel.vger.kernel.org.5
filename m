Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4177F7C62E3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376784AbjJLCiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjJLCio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:38:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF13A9;
        Wed, 11 Oct 2023 19:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697078323; x=1728614323;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=mdXRrafSW2vaWofevfN0nlDG8rsooz2jVNY8wgQKLnE=;
  b=SFxASy0AIWikny/QwYCKHUKEqrX35rFokCGnx5VF9h8aHAuKWBRcrbGm
   uMdUqpOe69sWj+DqNUdJ5pYrGPxm0AMoc625LzQNcRJz7nl5o7enXEL8+
   GBhCe4ImmS0SEq4L859ZI52J/4NC3Bwufb6ViLOstJnOVcuIe++OyVlRc
   fZkIXbXxrpQu8+uPxvn745GALlg11c3xLdCOUnsmL6t+wqeDJT7HxrXTG
   ttZEJgSIoY/2hcTymAlvtc8AsaHs7cjJwHvfT+LakVlkZaj++hAaiUboR
   wvmSJJRpP79AZrJWxi5CEcKTjtI6FS/xb3rEqEt7R4uCLZjLH7FQakAxR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3402623"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="3402623"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783507858"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="783507858"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:41 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.105.238])
        by linux.intel.com (Postfix) with ESMTP id 18E3A580E33;
        Wed, 11 Oct 2023 19:38:41 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V3 03/16] platform/x86/intel/vsec: Use cleanup.h
Date:   Wed, 11 Oct 2023 19:38:27 -0700
Message-Id: <20231012023840.3845703-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012023840.3845703-1-david.e.box@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use cleanup.h helpers to handle cleanup of resources in
intel_vsec_add_dev() after failures.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V3 - New patch.

 drivers/platform/x86/intel/vsec.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 15866b7d3117..f03ab89ab7c0 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -15,6 +15,7 @@
 
 #include <linux/auxiliary_bus.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/idr.h>
@@ -155,10 +156,10 @@ EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, INTEL_VSEC);
 static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *header,
 			      struct intel_vsec_platform_info *info)
 {
-	struct intel_vsec_device *intel_vsec_dev;
+	struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
 	struct resource *res, *tmp;
 	unsigned long quirks = info->quirks;
-	int i;
+	int ret, i;
 
 	if (!intel_vsec_supported(header->id, info->caps))
 		return -EINVAL;
@@ -178,10 +179,8 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 		return -ENOMEM;
 
 	res = kcalloc(header->num_entries, sizeof(*res), GFP_KERNEL);
-	if (!res) {
-		kfree(intel_vsec_dev);
+	if (!res)
 		return -ENOMEM;
-	}
 
 	if (quirks & VSEC_QUIRK_TABLE_SHIFT)
 		header->offset >>= TABLE_OFFSET_SHIFT;
@@ -208,8 +207,12 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	else
 		intel_vsec_dev->ida = &intel_vsec_ida;
 
-	return intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
-				  intel_vsec_name(header->id));
+	ret = intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
+				 intel_vsec_name(header->id));
+
+	no_free_ptr(intel_vsec_dev);
+
+	return ret;
 }
 
 static bool intel_vsec_walk_header(struct pci_dev *pdev,
-- 
2.34.1

