Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084337F573B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjKWEE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjKWEDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:03:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E80D43;
        Wed, 22 Nov 2023 20:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700712239; x=1732248239;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=TtKsydOx3gWnba4fJ4T6LAEwpRvLx4xg4R8u/y5POrM=;
  b=NRB4pSTu3uO0qF4e2EDpveGX6gs9PTXYC23HHEhZq25jyIgMPxrvrnYU
   icemf77cvFvbOMeotL0AoGJ+NU9CwM1Js8EPLNuIhANuxn8LjCm3BUNIQ
   dcgfANhsdTOiPhz+0kvuatEiKNcp5SrCOWCB3WYuea8aq4ZJSvJGrp3V6
   PbYJh3EAwtnZ0UXaiXfOspbIbZzQJ/PyOFTwDPpaZvYDWxUyB001gzGUP
   tpOmRsS4vKsF1GH7/fwpp4ASs3Iqi55LMyw8jrlpdG4wAJKLxqud+RWCT
   HPkGPGRAAcvrFkuM5nRyakxXjFFTk7ifwQwsg42YGvf1yNJOCW5lEJ5RG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="389347946"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="389347946"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 20:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="801925650"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="801925650"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 20:03:56 -0800
Received: from debox1-desk4.lan (snpatel1-mobl.amr.corp.intel.com [10.209.89.91])
        by linux.intel.com (Postfix) with ESMTP id 19DB1580D7B;
        Wed, 22 Nov 2023 20:03:56 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V5 06/20] platform/x86/intel/vsec: Add intel_vsec_register
Date:   Wed, 22 Nov 2023 20:03:41 -0800
Message-Id: <20231123040355.82139-7-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123040355.82139-1-david.e.box@linux.intel.com>
References: <20231123040355.82139-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
V5 - Add parent variable in intel_vsec_add_dev() and set parent to
     the pci device if info->parent is not set.

V4 - Move res cleanup to previous patch

V3 - Replace kfree on request_mem_region fail with use of cleanup.h helper.

V2 - New patch splitting previous PATCH 1

 drivers/platform/x86/intel/vsec.c | 24 +++++++++++++++++++++++-
 drivers/platform/x86/intel/vsec.h |  4 ++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 7a717183c58b..03eabb7d3d3d 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -159,9 +159,15 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
 	struct resource __free(kfree) *res = NULL;
 	struct resource *tmp;
+	struct device *parent;
 	unsigned long quirks = info->quirks;
 	int i;
 
+	if (info->parent)
+		parent = info->parent;
+	else
+		parent = &pdev->dev;
+
 	if (!intel_vsec_supported(header->id, info->caps))
 		return -EINVAL;
 
@@ -196,6 +202,12 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
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
@@ -212,7 +224,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	 * Pass the ownership of intel_vsec_dev and resource within it to
 	 * intel_vsec_add_aux()
 	 */
-	return intel_vsec_add_aux(pdev, &pdev->dev, no_free_ptr(intel_vsec_dev),
+	return intel_vsec_add_aux(pdev, parent, no_free_ptr(intel_vsec_dev),
 				  intel_vsec_name(header->id));
 }
 
@@ -330,6 +342,16 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
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

