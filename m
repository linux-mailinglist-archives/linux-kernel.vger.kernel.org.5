Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22A07B7678
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 04:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbjJDCC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 22:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJDCC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:02:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F31A7;
        Tue,  3 Oct 2023 19:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696384943; x=1727920943;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=iEmk47kpctYmdUdUWTBWxL4ntTjZnej65/K8CZoabXs=;
  b=BQBuztCZnFaoRUdWP/cNOB7izKHWoIxOQ/srvtolLRjaOqCtVtam3MGU
   0maYWTIX8MPA1lzzCJVt9oZm9KW/4UfviHDLgJoN4DV9mAzngtg9CI5tk
   rJkM3OqAlL0zuU4y7cRaeQcGXYaN9vaeG+vGLwzVBDsw2CMoKJD9ls9cq
   ezSN3zAB5REIX980WRhpZ/5FDOY5V5KLePVxrhHxGp+VMZoW6vpzue4ZA
   ivIkXzS8BDirL0beHtnWoaPc4kXKMDEztVi9lRTtH9+0shhWek1CQKQaN
   BYplADQV4KBSu3Qmt4nFu584G/KS7C1czG03RykNYntn2+pMEHWgLTFPu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="413947547"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="413947547"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841596670"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="841596670"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:22 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.24.172])
        by linux.intel.com (Postfix) with ESMTP id B27E7580C73;
        Tue,  3 Oct 2023 19:02:22 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V2 03/13] platform/x86/intel/vsec: Add intel_vsec_register
Date:   Tue,  3 Oct 2023 19:02:12 -0700
Message-Id: <20231004020222.193445-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004020222.193445-1-david.e.box@linux.intel.com>
References: <20231004020222.193445-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@linux.intel.com>

Add and export intel_vsec_register() to allow the registration of Intel
extended capabilities from other drivers. Add check to look for memory
conflicts before registering a new capability. Add a parent field to
intel_vsec_platform_info to allow specifying the parent device for
device managed cleanup.

Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V2 - New patch splitting previous PATCH 1

 drivers/platform/x86/intel/vsec.c | 21 ++++++++++++++++++++-
 drivers/platform/x86/intel/vsec.h |  4 ++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index b14eba545770..c5d0202068cf 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -188,6 +188,15 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 			     header->offset + i * (header->entry_size * sizeof(u32));
 		tmp->end = tmp->start + (header->entry_size * sizeof(u32)) - 1;
 		tmp->flags = IORESOURCE_MEM;
+
+		/* Check resource is not in use */
+		if (!request_mem_region(tmp->start, resource_size(tmp), "")) {
+			kfree(res);
+			kfree(intel_vsec_dev);
+			return -EBUSY;
+		}
+
+		release_mem_region(tmp->start, resource_size(tmp));
 	}
 
 	intel_vsec_dev->pcidev = pdev;
@@ -200,7 +209,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	else
 		intel_vsec_dev->ida = &intel_vsec_ida;
 
-	return intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
+	return intel_vsec_add_aux(pdev, info->parent, intel_vsec_dev,
 				  intel_vsec_name(header->id));
 }
 
@@ -318,6 +327,16 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
 	return have_devices;
 }
 
+void intel_vsec_register(struct pci_dev *pdev,
+			 struct intel_vsec_platform_info *info)
+{
+	if (!pdev || !info)
+		return;
+
+	intel_vsec_walk_header(pdev, info);
+}
+EXPORT_SYMBOL_NS_GPL(intel_vsec_register, INTEL_VSEC);
+
 static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct intel_vsec_platform_info *info;
diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
index d3fefba3e623..a15fda2fcd28 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -69,6 +69,7 @@ enum intel_vsec_quirks {
 
 /* Platform specific data */
 struct intel_vsec_platform_info {
+	struct device *parent;
 	struct intel_vsec_header **headers;
 	unsigned long caps;
 	unsigned long quirks;
@@ -98,4 +99,7 @@ static inline struct intel_vsec_device *auxdev_to_ivdev(struct auxiliary_device
 {
 	return container_of(auxdev, struct intel_vsec_device, auxdev);
 }
+
+void intel_vsec_register(struct pci_dev *pdev,
+			 struct intel_vsec_platform_info *info);
 #endif
-- 
2.34.1

