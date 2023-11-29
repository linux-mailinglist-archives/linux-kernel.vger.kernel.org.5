Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A007FDEFE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjK2SAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjK2SAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:00:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049C0B9;
        Wed, 29 Nov 2023 10:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701280851; x=1732816851;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pCVKj8vuUarbESLjTOuomdk0wRab1FdZCSK6q+mH8WA=;
  b=Jc+xY+CmAhAruNoju1pX6dbWRVI/5a8/TgT4fdMJ6NQ6Zc5c+9o+scn3
   6D6jj/3a9MyX9IWWCu518VhDhc+hezR5pk5ww5qBzpSQPEZZli838wiWz
   H2L8osWGQc8xH15Yag/4AAYHoNVtqcb98cOS7oefEjoinuYWcb9wxNjp6
   dwbUSIJry8HMFpa/sdQv+F1EVYIcCsfVZxw3DZspWDLXmUiiCmkw4iwKr
   Bt/n9+QRWs6mvdDIu28SjBMkfBDz09a91HuCX5MK5UkOQAoQVKo/Tt8b5
   gvEFDzIfsYyLv0+nvtKYLM9s5QYqEOdvbK9tlCsdBXViSIxt7e09Bv3mO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="457524471"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="457524471"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:00:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="835096108"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="835096108"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.127.168])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:00:49 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 29 Nov 2023 10:00:42 -0800
Subject: [PATCH 2/6] cxl/events: Promote CXL event structures to a core
 header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v1-2-d19f1ac18ab6@intel.com>
References: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
In-Reply-To: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Shiju Jose <shiju.jose@huawei.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-0f7f0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701280847; l=5614;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=pCVKj8vuUarbESLjTOuomdk0wRab1FdZCSK6q+mH8WA=;
 b=OzFftQs9z8MRz0Lflq81g04CyF/lY7su2oZQztXGUdkx4mRuiP6I606y/XX0ecm9K9uaeaafD
 DbGboYdzTxBBG6ddB8D/TkCffdla/e5ZxrFfMSPni+BSW3X5rPukcN9
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UEFI code can process CXL events through CPER records.  Those records
use almost the same format as the CXL events.

Lift the CXL event structures to a core header to be shared.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/cxlmem.h      |  90 +----------------------------------------
 include/linux/cxl-event.h | 100 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 89 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a2fcbca253f3..f0e7ebb84f02 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -6,6 +6,7 @@
 #include <linux/cdev.h>
 #include <linux/uuid.h>
 #include <linux/rcuwait.h>
+#include <linux/cxl-event.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -579,27 +580,6 @@ struct cxl_mbox_identify {
 	u8 qos_telemetry_caps;
 } __packed;
 
-/*
- * Common Event Record Format
- * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
- */
-struct cxl_event_record_hdr {
-	uuid_t id;
-	u8 length;
-	u8 flags[3];
-	__le16 handle;
-	__le16 related_handle;
-	__le64 timestamp;
-	u8 maint_op_class;
-	u8 reserved[15];
-} __packed;
-
-#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
-struct cxl_event_record_raw {
-	struct cxl_event_record_hdr hdr;
-	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
-} __packed;
-
 /*
  * Get Event Records output payload
  * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
@@ -641,74 +621,6 @@ struct cxl_mbox_clear_event_payload {
 } __packed;
 #define CXL_CLEAR_EVENT_MAX_HANDLES U8_MAX
 
-/*
- * General Media Event Record
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
- */
-#define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
-struct cxl_event_gen_media {
-	struct cxl_event_record_hdr hdr;
-	__le64 phys_addr;
-	u8 descriptor;
-	u8 type;
-	u8 transaction_type;
-	u8 validity_flags[2];
-	u8 channel;
-	u8 rank;
-	u8 device[3];
-	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
-	u8 reserved[46];
-} __packed;
-
-/*
- * DRAM Event Record - DER
- * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
- */
-#define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
-struct cxl_event_dram {
-	struct cxl_event_record_hdr hdr;
-	__le64 phys_addr;
-	u8 descriptor;
-	u8 type;
-	u8 transaction_type;
-	u8 validity_flags[2];
-	u8 channel;
-	u8 rank;
-	u8 nibble_mask[3];
-	u8 bank_group;
-	u8 bank;
-	u8 row[3];
-	u8 column[2];
-	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
-	u8 reserved[0x17];
-} __packed;
-
-/*
- * Get Health Info Record
- * CXL rev 3.0 section 8.2.9.8.3.1; Table 8-100
- */
-struct cxl_get_health_info {
-	u8 health_status;
-	u8 media_status;
-	u8 add_status;
-	u8 life_used;
-	u8 device_temp[2];
-	u8 dirty_shutdown_cnt[4];
-	u8 cor_vol_err_cnt[4];
-	u8 cor_per_err_cnt[4];
-} __packed;
-
-/*
- * Memory Module Event Record
- * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
- */
-struct cxl_event_mem_module {
-	struct cxl_event_record_hdr hdr;
-	u8 event_type;
-	struct cxl_get_health_info info;
-	u8 reserved[0x3d];
-} __packed;
-
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
new file mode 100644
index 000000000000..1c94e8fdd227
--- /dev/null
+++ b/include/linux/cxl-event.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CXL_EVENT_H
+#define _LINUX_CXL_EVENT_H
+
+/*
+ * CXL event records; CXL rev 3.0
+ *
+ * Copyright(c) 2023 Intel Corporation.
+ */
+
+/*
+ * Common Event Record Format
+ * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
+ */
+struct cxl_event_record_hdr {
+	uuid_t id;
+	u8 length;
+	u8 flags[3];
+	__le16 handle;
+	__le16 related_handle;
+	__le64 timestamp;
+	u8 maint_op_class;
+	u8 reserved[15];
+} __packed;
+
+#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
+struct cxl_event_record_raw {
+	struct cxl_event_record_hdr hdr;
+	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
+} __packed;
+
+/*
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
+struct cxl_event_gen_media {
+	struct cxl_event_record_hdr hdr;
+	__le64 phys_addr;
+	u8 descriptor;
+	u8 type;
+	u8 transaction_type;
+	u8 validity_flags[2];
+	u8 channel;
+	u8 rank;
+	u8 device[3];
+	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+	u8 reserved[46];
+} __packed;
+
+/*
+ * DRAM Event Record - DER
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
+ */
+#define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
+struct cxl_event_dram {
+	struct cxl_event_record_hdr hdr;
+	__le64 phys_addr;
+	u8 descriptor;
+	u8 type;
+	u8 transaction_type;
+	u8 validity_flags[2];
+	u8 channel;
+	u8 rank;
+	u8 nibble_mask[3];
+	u8 bank_group;
+	u8 bank;
+	u8 row[3];
+	u8 column[2];
+	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
+	u8 reserved[0x17];
+} __packed;
+
+/*
+ * Get Health Info Record
+ * CXL rev 3.0 section 8.2.9.8.3.1; Table 8-100
+ */
+struct cxl_get_health_info {
+	u8 health_status;
+	u8 media_status;
+	u8 add_status;
+	u8 life_used;
+	u8 device_temp[2];
+	u8 dirty_shutdown_cnt[4];
+	u8 cor_vol_err_cnt[4];
+	u8 cor_per_err_cnt[4];
+} __packed;
+
+/*
+ * Memory Module Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+struct cxl_event_mem_module {
+	struct cxl_event_record_hdr hdr;
+	u8 event_type;
+	struct cxl_get_health_info info;
+	u8 reserved[0x3d];
+} __packed;
+
+#endif /* _LINUX_CXL_EVENT_H */

-- 
2.42.0

