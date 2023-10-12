Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB67C62EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376922AbjJLCjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376688AbjJLCiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:38:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B47BA;
        Wed, 11 Oct 2023 19:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697078324; x=1728614324;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=pO1E3835P+LdNYS0j3twJPg5eBQFsYzBKgSmmSamrCI=;
  b=n++Rde7Plr6z3JZ+gROR5DBpiNiaGnqM2ndGDhifvBfyk90AhxIYQ2Z5
   FIN1t17zz4ifmWS82fYkIZhelP1mn8F9CIzwB2r1brvctsr5ZxSqPwWQL
   7IgVCdmeZCFLUjyd2XPFCZ9X8sHvfq31cFfUV7RaPMAud7jgk0PjxVixk
   PD+SeFQ0oK1bbbSEN55pRdNZY00bkYdUp1VLSwiNbQNno98bkGCfsl3bA
   o+HwThNRCFWW7d6bHv3wccaoLqr15wJSOp/5qeA3AHA/APAcVMEnNbhiN
   AlevIna7+5YfUMvLPD8v+eCwUwxakBY8u+ILwbs5+Qo9M+VJSyuxlWCUX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3402625"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="3402625"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783507861"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="783507861"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:41 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.105.238])
        by linux.intel.com (Postfix) with ESMTP id 6321D580D95;
        Wed, 11 Oct 2023 19:38:41 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V3 05/16] platform/x86/intel/vsec: Add base address field
Date:   Wed, 11 Oct 2023 19:38:29 -0700
Message-Id: <20231012023840.3845703-6-david.e.box@linux.intel.com>
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

Some devices may emulate PCI VSEC capabilities in MMIO. In such cases the
BAR is not readable from a config space. Provide a field for drivers to
indicate the base address to be used.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V3 - No change

V2 - No change

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
index 1d005077024a..5e18a06395e0 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -160,6 +160,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	struct resource __free(kfree) *res = NULL;
 	struct resource *tmp;
 	unsigned long quirks = info->quirks;
+	u64 base_addr;
 	int ret, i;
 
 	if (!intel_vsec_supported(header->id, info->caps))
@@ -186,14 +187,18 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
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
 
@@ -208,6 +213,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	intel_vsec_dev->resource = res;
 	intel_vsec_dev->num_resources = header->num_entries;
 	intel_vsec_dev->quirks = info->quirks;
+	intel_vsec_dev->base_addr = info->base_addr;
 
 	if (header->id == VSEC_ID_SDSI)
 		intel_vsec_dev->ida = &intel_vsec_sdsi_ida;
diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
index bb8b6452df70..e23e76129691 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -73,6 +73,7 @@ struct intel_vsec_platform_info {
 	struct intel_vsec_header **headers;
 	unsigned long caps;
 	unsigned long quirks;
+	u64 base_addr;
 };
 
 struct intel_vsec_device {
@@ -85,6 +86,7 @@ struct intel_vsec_device {
 	void *priv_data;
 	size_t priv_data_size;
 	unsigned long quirks;
+	u64 base_addr;
 };
 
 int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
-- 
2.34.1

