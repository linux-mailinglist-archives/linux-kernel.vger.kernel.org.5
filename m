Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6287CEBBE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjJRXQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJRXQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:16:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47950114;
        Wed, 18 Oct 2023 16:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697670985; x=1729206985;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=dhkcdx0Z5stemRLZk2m5+FoSc4jFxU8Ye9jkgwCkoNo=;
  b=AnJjYFZ8jy83YgpyNfLisZ3Mo7JFHN2GdjbGjGuE1hkMQDt1gemBQorb
   xPccgGm8D2hEtoCGFCVkQlv8W1LKHZ7nbs6kT2VaPSK5S5OpuWDB41Uo9
   q+cRgvRysYSP5tYBB97l4qJKeBuwUfkNOzVbVnhNHuQnS5ezS+1Y52bwI
   bp9uKgYGajJ0MZ93kVl7M5jwR7vNmvpu1V/1NIQmpuBgOqEtEycF6cNWz
   daaGMzooa0Bplvco4q5MgCEknKPeEjoSZq+R6cvbfI0VgLw68YhhjtN7y
   cWe2hpsTFOLsZ/ZdqIz474XbfI0A8ocQYkaM2k2O/ZHqYcC8ae3gk5vr9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452605952"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452605952"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756782167"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="756782167"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:24 -0700
Received: from debox1-desk4.lan (unknown [10.209.71.91])
        by linux.intel.com (Postfix) with ESMTP id B559A580DD4;
        Wed, 18 Oct 2023 16:16:24 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V4 01/17] platform/x86/intel/vsec: Move structures to header
Date:   Wed, 18 Oct 2023 16:16:08 -0700
Message-Id: <20231018231624.1044633-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018231624.1044633-1-david.e.box@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com>
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
Extended Capabilities (VSEC) from other drivers, move needed structures to
the header file.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V4 - No change

V3 - No change

V2 - New patch splitting previous PATCH 1

 drivers/platform/x86/intel/vsec.c | 35 ------------------------------
 drivers/platform/x86/intel/vsec.h | 36 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index c1f9e4471b28..e82a009be630 100644
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
diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
index 0fd042c171ba..8900cb95afd3 100644
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
+ * @rev:         Revision ID of the VSEC/DVSEC register space
+ * @length:      Length of the VSEC/DVSEC register space
+ * @id:          ID of the feature
+ * @num_entries: Number of instances of the feature
+ * @entry_size:  Size of the discovery table for each feature
+ * @tbir:        BAR containing the discovery tables
+ * @offset:      BAR offset of start of the first discovery table
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
-- 
2.34.1

