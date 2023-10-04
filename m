Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B257B7685
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 04:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbjJDCDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 22:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241163AbjJDCC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:02:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C38BFE;
        Tue,  3 Oct 2023 19:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696384961; x=1727920961;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=4wX77hCDNVTTHoQnVjWd5lAjIcxjPgZI1SXolQ9A6nk=;
  b=JtMFu+cd9xuibeGJ9pkKLkpjX/UDJ/C4WQXhhiKuYNel33w8tj/NvN0M
   PKZoqdmjmhGUNKJ2dXlrSR6yOW04qKc02ujWE1+Udme5AqJ/K9N+NYrj6
   1KTIQkllbq1crczj+KWkvUxvOPY+sW3hBmsijTDYwveYRL3eHPGSkX1Jd
   4MHNExBJW/c8XGenQ0jAFYazBdmZXGjQys6/lDEI3AnEcWuXQLXsKNgyg
   vteXiKpphmtUdLhCVOSHlp9j2zBPhZyxpmotKtSAjY1QObCOr+H1i3uuK
   lgMsGi0FdD21h9OJ8csi0GA4kSnZrvkyVGnjESuBxgetoAxUKwESbeSoM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1625864"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1625864"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="700926296"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="700926296"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:02:22 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.24.172])
        by linux.intel.com (Postfix) with ESMTP id CC648580CBC;
        Tue,  3 Oct 2023 19:02:22 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V2 04/13] platform/x86/intel/vsec: Add base address field
Date:   Tue,  3 Oct 2023 19:02:13 -0700
Message-Id: <20231004020222.193445-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004020222.193445-1-david.e.box@linux.intel.com>
References: <20231004020222.193445-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices may emulate PCI VSEC capabilities in MMIO. In such cases the
BAR is not readable from a config space. Provide a field for drivers to
indicate the base address to be used.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V2 - no change

 drivers/platform/x86/intel/pmt/class.c | 14 +++++++++++---
 drivers/platform/x86/intel/vsec.c      | 10 ++++++++--
 drivers/platform/x86/intel/vsec.h      |  2 ++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index 2ad91d2fd954..32608baaa56c 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -160,10 +160,11 @@ static struct class intel_pmt_class = {
 
 static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
 				    struct intel_pmt_header *header,
-				    struct device *dev,
+				    struct intel_vsec_device *ivdev,
 				    struct resource *disc_res)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev->parent);
+	struct pci_dev *pci_dev = ivdev->pcidev;
+	struct device *dev = &ivdev->auxdev.dev;
 	u8 bir;
 
 	/*
@@ -215,6 +216,13 @@ static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
 
 		break;
 	case ACCESS_BARID:
+		/* Use the provided base address if it exists */
+		if (ivdev->base_addr) {
+			entry->base_addr = ivdev->base_addr +
+				   GET_ADDRESS(header->base_offset);
+			break;
+		}
+
 		/*
 		 * If another BAR was specified then the base offset
 		 * represents the offset within that BAR. SO retrieve the
@@ -319,7 +327,7 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespa
 	if (ret)
 		return ret;
 
-	ret = intel_pmt_populate_entry(entry, &header, dev, disc_res);
+	ret = intel_pmt_populate_entry(entry, &header, intel_vsec_dev, disc_res);
 	if (ret)
 		return ret;
 
diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index c5d0202068cf..e0dd64dec9eb 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -150,6 +150,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	struct intel_vsec_device *intel_vsec_dev;
 	struct resource *res, *tmp;
 	unsigned long quirks = info->quirks;
+	u64 base_addr;
 	int i;
 
 	if (!intel_vsec_supported(header->id, info->caps))
@@ -178,14 +179,18 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	if (quirks & VSEC_QUIRK_TABLE_SHIFT)
 		header->offset >>= TABLE_OFFSET_SHIFT;
 
+	if (info->base_addr)
+		base_addr = info->base_addr;
+	else
+		base_addr = pdev->resource[header->tbir].start;
+
 	/*
 	 * The DVSEC/VSEC contains the starting offset and count for a block of
 	 * discovery tables. Create a resource array of these tables to the
 	 * auxiliary device driver.
 	 */
 	for (i = 0, tmp = res; i < header->num_entries; i++, tmp++) {
-		tmp->start = pdev->resource[header->tbir].start +
-			     header->offset + i * (header->entry_size * sizeof(u32));
+		tmp->start = base_addr + header->offset + i * (header->entry_size * sizeof(u32));
 		tmp->end = tmp->start + (header->entry_size * sizeof(u32)) - 1;
 		tmp->flags = IORESOURCE_MEM;
 
@@ -203,6 +208,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	intel_vsec_dev->resource = res;
 	intel_vsec_dev->num_resources = header->num_entries;
 	intel_vsec_dev->quirks = info->quirks;
+	intel_vsec_dev->base_addr = info->base_addr;
 
 	if (header->id == VSEC_ID_SDSI)
 		intel_vsec_dev->ida = &intel_vsec_sdsi_ida;
diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
index a15fda2fcd28..78848e2329fb 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -73,6 +73,7 @@ struct intel_vsec_platform_info {
 	struct intel_vsec_header **headers;
 	unsigned long caps;
 	unsigned long quirks;
+	u64 base_addr;
 };
 
 struct intel_vsec_device {
@@ -84,6 +85,7 @@ struct intel_vsec_device {
 	void *priv_data;
 	size_t priv_data_size;
 	unsigned long quirks;
+	u64 base_addr;
 };
 
 int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
-- 
2.34.1

