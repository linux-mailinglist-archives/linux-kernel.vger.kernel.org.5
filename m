Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0A37CEBB5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjJRXQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjJRXQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:16:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5AF11F;
        Wed, 18 Oct 2023 16:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697670986; x=1729206986;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=EiqQPHnFVS6pUKJtmCiJu9NxgHDIMiqEYmzDV9uhkOE=;
  b=Enp1832cZDBOxPDbHhX0P3Y4HiYsqe9tmA0D4IgOnzi3T695MU5tgjoY
   XDqSY/JJXuIDIZH9cR5bcptobP4TJwhh7l6OxSaNPttXQEtctRB3rNkRk
   idDmh5VIFAj1stkm+z4/TAUuMqMt7z5zVqeB0RwIUPN94OWfVqBu92z7E
   E4M06fz3LE6UGij0h51bIpp9ezVmEFTLbw6M0B5pcIVcCXIHqHEd+pErS
   ZNWawDGiNrYLJJVugPfSSBXLlaFOkZdEzzw36IeLNIw2RRPtjz7VvmaMu
   ksla5k9g9db1cda00AbXbsRolCCeKPDFreIw69+M36w9GWmew7srwHnAo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452605954"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452605954"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756782169"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="756782169"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:25 -0700
Received: from debox1-desk4.lan (unknown [10.209.71.91])
        by linux.intel.com (Postfix) with ESMTP id EE08A580E33;
        Wed, 18 Oct 2023 16:16:24 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V4 03/17] platform/x86/intel/vsec: Use cleanup.h
Date:   Wed, 18 Oct 2023 16:16:10 -0700
Message-Id: <20231018231624.1044633-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018231624.1044633-1-david.e.box@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com>
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
V4 - Do no_free_ptr() before and in call to intel_vsec_add_aux().
   - Add resource cleanup in this patch.

V3 - New patch.

 drivers/platform/x86/intel/vsec.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index b14eba545770..28191313d515 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -15,6 +15,7 @@
 
 #include <linux/auxiliary_bus.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/idr.h>
@@ -147,10 +148,11 @@ EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, INTEL_VSEC);
 static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *header,
 			      struct intel_vsec_platform_info *info)
 {
-	struct intel_vsec_device *intel_vsec_dev;
-	struct resource *res, *tmp;
+	struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
+	struct resource __free(kfree) *res = NULL;
+	struct resource *tmp;
 	unsigned long quirks = info->quirks;
-	int i;
+	int ret, i;
 
 	if (!intel_vsec_supported(header->id, info->caps))
 		return -EINVAL;
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
@@ -200,8 +200,15 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	else
 		intel_vsec_dev->ida = &intel_vsec_ida;
 
-	return intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
-				  intel_vsec_name(header->id));
+	/*
+	 * Pass the ownership of intel_vsec_dev and resource within it to
+	 * intel_vsec_add_aux()
+	 */
+	no_free_ptr(res);
+	ret = intel_vsec_add_aux(pdev, NULL, no_free_ptr(intel_vsec_dev),
+				 intel_vsec_name(header->id));
+
+	return ret;
 }
 
 static bool intel_vsec_walk_header(struct pci_dev *pdev,
-- 
2.34.1

