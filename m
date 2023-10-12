Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3638B7C62E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376763AbjJLCis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjJLCin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:38:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CDEB6;
        Wed, 11 Oct 2023 19:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697078322; x=1728614322;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=K3cYNR9dHNWIHJ58ypiFOF8RbjVsqUQwkNF18MKRWjs=;
  b=CWgYxSN95sIW9GyrosmSdr4X7kXPEIlWQIFA2BRpyEmvMIJVkMmSfrfz
   wgz7Axn9MQRZCv/UfMm8DM4UM0JAWPTu40s+zfXnSCJWxI6U55vn/GEZv
   24gv/PWe0MAfF0lg0ZoThOySdiqc8V6Mno42tbdc7N8TdGL5Q6lOFi1oc
   6zoUiOf7nblsuZ7hncZfTleXuQcDG4btAs8thRxjuu8ipIaoDXtoavNbR
   0PvAvIUVbekqfolRHeGO6JV98thLGK4WeucB/H+fu1nuPW+p9qHJF3UJf
   0hCBY8zBLX9lLz3V58tGYTqHy7rNWHT34asXCOOB/kPghccjDK5scSkP1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3402622"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="3402622"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783507853"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="783507853"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:41 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.105.238])
        by linux.intel.com (Postfix) with ESMTP id EB298580DBE;
        Wed, 11 Oct 2023 19:38:40 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V3 02/16] platform/x86/intel/vsec: remove platform_info from vsec device structure
Date:   Wed, 11 Oct 2023 19:38:26 -0700
Message-Id: <20231012023840.3845703-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012023840.3845703-1-david.e.box@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for exporting an API to register Intel Vendor Specific
Extended Capabilities (VSEC) from other drivers, remove the pointer to
platform_info from intel_vsec_device. This prevents a potential page fault
when auxiliary drivers probe and attempt to dereference this pointer to
access the needed quirks field. Instead, just add the quirks to
intel_vsec_device.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V3 - No change

V2 - New patch splitting previous PATCH 1

 drivers/platform/x86/intel/pmt/class.c | 2 +-
 drivers/platform/x86/intel/vsec.c      | 2 +-
 drivers/platform/x86/intel/vsec.h      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index f32a233470de..2ad91d2fd954 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -31,7 +31,7 @@ bool intel_pmt_is_early_client_hw(struct device *dev)
 	 * differences from the server platforms (which use the Out Of Band
 	 * Management Services Module OOBMSM).
 	 */
-	return !!(ivdev->info->quirks & VSEC_QUIRK_EARLY_HW);
+	return !!(ivdev->quirks & VSEC_QUIRK_EARLY_HW);
 }
 EXPORT_SYMBOL_NS_GPL(intel_pmt_is_early_client_hw, INTEL_PMT);
 
diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 6bb233a23414..15866b7d3117 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -201,7 +201,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	intel_vsec_dev->pcidev = pdev;
 	intel_vsec_dev->resource = res;
 	intel_vsec_dev->num_resources = header->num_entries;
-	intel_vsec_dev->info = info;
+	intel_vsec_dev->quirks = info->quirks;
 
 	if (header->id == VSEC_ID_SDSI)
 		intel_vsec_dev->ida = &intel_vsec_sdsi_ida;
diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
index c242c07ea69c..8b9fad170503 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -79,11 +79,11 @@ struct intel_vsec_device {
 	struct pci_dev *pcidev;
 	struct resource *resource;
 	struct ida *ida;
-	struct intel_vsec_platform_info *info;
 	int num_resources;
 	int id; /* xa */
 	void *priv_data;
 	size_t priv_data_size;
+	unsigned long quirks;
 };
 
 int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
-- 
2.34.1

