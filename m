Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D297ABB15
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjIVVam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjIVVaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:30:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88E6CA;
        Fri, 22 Sep 2023 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695418233; x=1726954233;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tNCrq0UCcwWZxRQu2a0ZKbXVzG5T9sXvN3JlA1Gge7Y=;
  b=bmkPyO4EIuf6pgqLjqfq5z3i2v837LXkJDzHHhmd8ZI/E8LlyLIPw5n/
   GU17486UeqchkED5zd819mj8rL5nrVtvDzc/xwqJ9n0gOlZt7lBNFhvMS
   txNfA0NykuulMan9VWRGc+ZS4khHSzUfyHiBVOYIJUn9rbt3J61MYlm0Y
   TUrCzSIHOG8VN/35gtfYBXMCneCeo3mKKQYhxaf9ya82ZUQLu59eSWXn7
   THDaJnTDLpgjIv2Pm2RUoTxNaIo97OWSScHdje2/JpMtbL0scx2RA9Pq7
   oImMFvOVL11JZvCp7Cg0JRyI2GZEwG6J/mcU9YEslcg1XYxfXLb+xiyzZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="379828416"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="379828416"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 14:30:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="813237844"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="813237844"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 14:30:33 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.188.234])
        by linux.intel.com (Postfix) with ESMTP id D34C5580BB9;
        Fri, 22 Sep 2023 14:30:32 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, david.e.box@linux.intel.com,
        platform-driver-x86@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        rajvi.jingar@linux.intel.com
Subject: [PATCH 02/11] platform/x86/intel/vsec: Add base address field
Date:   Fri, 22 Sep 2023 14:30:23 -0700
Message-Id: <20230922213032.1770590-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922213032.1770590-1-david.e.box@linux.intel.com>
References: <20230922213032.1770590-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices may emulate PCI VSEC capabilities in MMIO. In such cases the
BAR is not readable from a config space. Provide a field for drivers to
indicate the base address to be used.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
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
index ab0f161f86c5..bddd33e1c17e 100644
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

