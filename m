Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE6E7ABB18
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjIVVao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjIVVak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:30:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11467EE;
        Fri, 22 Sep 2023 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695418234; x=1726954234;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ehtzflnkXJ/6Zn26B3bD8kZ3gA8KPD3Ei24NzR5rzP8=;
  b=dXmyTGRM0lb+pGvV8g7RUB/B1KPlhJgeOf5KNaJ0O/7lp4ZENzj+EXqA
   IuLCizd62qSx2EFOOFW6aAq1f2KI5PiHWSBpM5mXghpjK+KO/kVSzsttr
   VWseVLMtW5LKT6S2fSYtbo+pCfIUV6BUjo5pNa5uRmD19ciWbIPJiBZ+B
   GqJ/kgqcBS+b3c7eWtFBg8yV3uAkzbjfeTpk+Iqvm5dWa9eSQ0YHuUz7u
   ptyYCOodUKu4Srqv3lg0c/l7urGuWQL+cYNcFbDa17+5fkKxniWzcGWau
   qXap/4wX7t66MObfYinNGgaDDJD70ibPfBYn+/iXQCHJig516WntB6kUF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="371264686"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="371264686"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 14:30:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="747685309"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="747685309"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 14:30:32 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.188.234])
        by linux.intel.com (Postfix) with ESMTP id A9D5C580DB2;
        Fri, 22 Sep 2023 14:30:32 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, david.e.box@linux.intel.com,
        platform-driver-x86@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        rajvi.jingar@linux.intel.com
Subject: [PATCH 01/11] platform/x86/intel/vsec: Add intel_vsec_register
Date:   Fri, 22 Sep 2023 14:30:22 -0700
Message-Id: <20230922213032.1770590-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922213032.1770590-1-david.e.box@linux.intel.com>
References: <20230922213032.1770590-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
conflicts before registering a new capability.

Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/class.c |  2 +-
 drivers/platform/x86/intel/vsec.c      | 58 ++++++++++----------------
 drivers/platform/x86/intel/vsec.h      | 42 ++++++++++++++++++-
 3 files changed, 63 insertions(+), 39 deletions(-)

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
index c1f9e4471b28..c5d0202068cf 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -24,13 +24,6 @@
 
 #include "vsec.h"
 
-/* Intel DVSEC offsets */
-#define INTEL_DVSEC_ENTRIES		0xA
-#define INTEL_DVSEC_SIZE		0xB
-#define INTEL_DVSEC_TABLE		0xC
-#define INTEL_DVSEC_TABLE_BAR(x)	((x) & GENMASK(2, 0))
-#define INTEL_DVSEC_TABLE_OFFSET(x)	((x) & GENMASK(31, 3))
-#define TABLE_OFFSET_SHIFT		3
 #define PMT_XA_START			0
 #define PMT_XA_MAX			INT_MAX
 #define PMT_XA_LIMIT			XA_LIMIT(PMT_XA_START, PMT_XA_MAX)
@@ -39,34 +32,6 @@ static DEFINE_IDA(intel_vsec_ida);
 static DEFINE_IDA(intel_vsec_sdsi_ida);
 static DEFINE_XARRAY_ALLOC(auxdev_array);
 
-/**
- * struct intel_vsec_header - Common fields of Intel VSEC and DVSEC registers.
- * @rev:         Revision ID of the VSEC/DVSEC register space
- * @length:      Length of the VSEC/DVSEC register space
- * @id:          ID of the feature
- * @num_entries: Number of instances of the feature
- * @entry_size:  Size of the discovery table for each feature
- * @tbir:        BAR containing the discovery tables
- * @offset:      BAR offset of start of the first discovery table
- */
-struct intel_vsec_header {
-	u8	rev;
-	u16	length;
-	u16	id;
-	u8	num_entries;
-	u8	entry_size;
-	u8	tbir;
-	u32	offset;
-};
-
-enum intel_vsec_id {
-	VSEC_ID_TELEMETRY	= 2,
-	VSEC_ID_WATCHER		= 3,
-	VSEC_ID_CRASHLOG	= 4,
-	VSEC_ID_SDSI		= 65,
-	VSEC_ID_TPMI		= 66,
-};
-
 static const char *intel_vsec_name(enum intel_vsec_id id)
 {
 	switch (id) {
@@ -223,19 +188,28 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
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
 	intel_vsec_dev->resource = res;
 	intel_vsec_dev->num_resources = header->num_entries;
-	intel_vsec_dev->info = info;
+	intel_vsec_dev->quirks = info->quirks;
 
 	if (header->id == VSEC_ID_SDSI)
 		intel_vsec_dev->ida = &intel_vsec_sdsi_ida;
 	else
 		intel_vsec_dev->ida = &intel_vsec_ida;
 
-	return intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
+	return intel_vsec_add_aux(pdev, info->parent, intel_vsec_dev,
 				  intel_vsec_name(header->id));
 }
 
@@ -353,6 +327,16 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
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
index 0fd042c171ba..ab0f161f86c5 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -11,9 +11,45 @@
 #define VSEC_CAP_SDSI		BIT(3)
 #define VSEC_CAP_TPMI		BIT(4)
 
+/* Intel DVSEC offsets */
+#define INTEL_DVSEC_ENTRIES		0xA
+#define INTEL_DVSEC_SIZE		0xB
+#define INTEL_DVSEC_TABLE		0xC
+#define INTEL_DVSEC_TABLE_BAR(x)	((x) & GENMASK(2, 0))
+#define INTEL_DVSEC_TABLE_OFFSET(x)	((x) & GENMASK(31, 3))
+#define TABLE_OFFSET_SHIFT		3
+
 struct pci_dev;
 struct resource;
 
+enum intel_vsec_id {
+	VSEC_ID_TELEMETRY	= 2,
+	VSEC_ID_WATCHER		= 3,
+	VSEC_ID_CRASHLOG	= 4,
+	VSEC_ID_SDSI		= 65,
+	VSEC_ID_TPMI		= 66,
+};
+
+/**
+ * struct intel_vsec_header - Common fields of Intel VSEC and DVSEC registers.
+ * @rev:	Revision ID of the VSEC/DVSEC register space
+ * @length:	Length of the VSEC/DVSEC register space
+ * @id:		ID of the feature
+ * @num_entries:Number of instances of the feature
+ * @entry_size:	Size of the discovery table for each feature
+ * @tbir:	BAR containing the discovery tables
+ * @offset:	BAR offset of start of the first discovery table
+ */
+struct intel_vsec_header {
+	u8	rev;
+	u16	length;
+	u16	id;
+	u8	num_entries;
+	u8	entry_size;
+	u8	tbir;
+	u32	offset;
+};
+
 enum intel_vsec_quirks {
 	/* Watcher feature not supported */
 	VSEC_QUIRK_NO_WATCHER	= BIT(0),
@@ -33,6 +69,7 @@ enum intel_vsec_quirks {
 
 /* Platform specific data */
 struct intel_vsec_platform_info {
+	struct device *parent;
 	struct intel_vsec_header **headers;
 	unsigned long caps;
 	unsigned long quirks;
@@ -43,10 +80,10 @@ struct intel_vsec_device {
 	struct pci_dev *pcidev;
 	struct resource *resource;
 	struct ida *ida;
-	struct intel_vsec_platform_info *info;
 	int num_resources;
 	void *priv_data;
 	size_t priv_data_size;
+	unsigned long quirks;
 };
 
 int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
@@ -62,4 +99,7 @@ static inline struct intel_vsec_device *auxdev_to_ivdev(struct auxiliary_device
 {
 	return container_of(auxdev, struct intel_vsec_device, auxdev);
 }
+
+void intel_vsec_register(struct pci_dev *pdev,
+			 struct intel_vsec_platform_info *info);
 #endif
-- 
2.34.1

