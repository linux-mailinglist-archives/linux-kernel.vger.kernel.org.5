Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8DB7F5730
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjKWEDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjKWEDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:03:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D5B199;
        Wed, 22 Nov 2023 20:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700712237; x=1732248237;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=hkm+jeGPBOqrZ8gKj7Tyxv9MfRKh2Cd6aKQPwSKyuJM=;
  b=d1eS7eApVCh/pQwdbp/xbiJPrhGiPOLPYSyKJRnZU7fTPofz9YFbDTcT
   k03cuqwWlojb0oFp/E2gwgnT1fE6vBr3OVfnWUgS8M+sHHR/hLeWATifH
   GH53NmjOWkOX+uoal1MSR92LsWX6l576lFsiweZCK5DtZ402fbXftF4GC
   Osu7Vxf8ADPrdNNySQpL07z+IM+uHy5qVpv58N+IpTRX4qeEAtljlNNQ6
   DkDiKMHUIA83Pm02kBCFMIALtHgy2iC71SjyYLvraMr5VeLC6ANe9fTwn
   70DWNUPgI00mI6P1TCJXxTmkigO1P6qiCDQ7tY1PrE3fwsNGSmwRCMMDn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5334658"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="5334658"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 20:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="837671146"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="837671146"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 20:03:56 -0800
Received: from debox1-desk4.lan (snpatel1-mobl.amr.corp.intel.com [10.209.89.91])
        by linux.intel.com (Postfix) with ESMTP id B83C9580CA4;
        Wed, 22 Nov 2023 20:03:55 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V5 03/20] platform/x86/intel/vsec: remove platform_info from vsec device structure
Date:   Wed, 22 Nov 2023 20:03:38 -0800
Message-Id: <20231123040355.82139-4-david.e.box@linux.intel.com>
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

In preparation for exporting an API to register Intel Vendor Specific
Extended Capabilities (VSEC) from other drivers, remove the pointer to
platform_info from intel_vsec_device. This prevents a potential page fault
when auxiliary drivers probe and attempt to dereference this pointer to
access the needed quirks field. Instead, just add the quirks to
intel_vsec_device.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V5 - No change

V4 - No change

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

