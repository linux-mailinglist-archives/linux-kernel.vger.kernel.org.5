Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EDE7C62DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbjJLCi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbjJLCip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:38:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B8AA4;
        Wed, 11 Oct 2023 19:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697078324; x=1728614324;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=SndSPJp6f/Dsiby12bNuX1NFU1+tow32oLCZ7DwzsmA=;
  b=hyY+l7KNyjvskz1UP8HpNypqo4CzmowVqEZxtIAOY6eb9feuQoRut1rs
   Ud7xhfjGXpBcdqx6EYtb968Tx4SwVSPEwc1PKeL9UQiML/f80q0DzvDGd
   RYdVfnkCee+Svh4M8UxHvxeT09IzdVU1byndKzprre7nGZbljtYrp0Vq4
   gy9eGqjKVeHmNz+KSarqxQNhqsW08PfwyFx+l4Dvr3gZmzQNffdPKfgh1
   5QKWpzbYBarKVsZaT0Whb27iF6MwN4WFRIaP9St7uYbxRFo9M4G29FX69
   KVNLhs6DbKfBHkGnMYGEL6MTK7ePyLAVHIK9UEcimbOR5o77/JvbGq2dR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3402624"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="3402624"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783507859"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="783507859"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:41 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.105.238])
        by linux.intel.com (Postfix) with ESMTP id 3F0AA580D79;
        Wed, 11 Oct 2023 19:38:41 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V3 04/16] platform/x86/intel/vsec: Add intel_vsec_register
Date:   Wed, 11 Oct 2023 19:38:28 -0700
Message-Id: <20231012023840.3845703-5-david.e.box@linux.intel.com>
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

From: Gayatri Kammela <gayatri.kammela@linux.intel.com>

Add and export intel_vsec_register() to allow the registration of Intel
extended capabilities from other drivers. Add check to look for memory
conflicts before registering a new capability. Add a parent field to
intel_vsec_platform_info to allow specifying the parent device for
device managed cleanup.

Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V3 - Replace kfree on request_mem_region fail with use of cleanup.h helper.

V2 - New patch splitting previous PATCH 1

 drivers/platform/x86/intel/vsec.c | 22 ++++++++++++++++++++--
 drivers/platform/x86/intel/vsec.h |  4 ++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index f03ab89ab7c0..1d005077024a 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -157,7 +157,8 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 			      struct intel_vsec_platform_info *info)
 {
 	struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
-	struct resource *res, *tmp;
+	struct resource __free(kfree) *res = NULL;
+	struct resource *tmp;
 	unsigned long quirks = info->quirks;
 	int ret, i;
 
@@ -195,6 +196,12 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 			     header->offset + i * (header->entry_size * sizeof(u32));
 		tmp->end = tmp->start + (header->entry_size * sizeof(u32)) - 1;
 		tmp->flags = IORESOURCE_MEM;
+
+		/* Check resource is not in use */
+		if (!request_mem_region(tmp->start, resource_size(tmp), ""))
+			return -EBUSY;
+
+		release_mem_region(tmp->start, resource_size(tmp));
 	}
 
 	intel_vsec_dev->pcidev = pdev;
@@ -207,9 +214,10 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	else
 		intel_vsec_dev->ida = &intel_vsec_ida;
 
-	ret = intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
+	ret = intel_vsec_add_aux(pdev, info->parent, intel_vsec_dev,
 				 intel_vsec_name(header->id));
 
+	no_free_ptr(res);
 	no_free_ptr(intel_vsec_dev);
 
 	return ret;
@@ -329,6 +337,16 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
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
index 8b9fad170503..bb8b6452df70 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -69,6 +69,7 @@ enum intel_vsec_quirks {
 
 /* Platform specific data */
 struct intel_vsec_platform_info {
+	struct device *parent;
 	struct intel_vsec_header **headers;
 	unsigned long caps;
 	unsigned long quirks;
@@ -99,4 +100,7 @@ static inline struct intel_vsec_device *auxdev_to_ivdev(struct auxiliary_device
 {
 	return container_of(auxdev, struct intel_vsec_device, auxdev);
 }
+
+void intel_vsec_register(struct pci_dev *pdev,
+			 struct intel_vsec_platform_info *info);
 #endif
-- 
2.34.1

