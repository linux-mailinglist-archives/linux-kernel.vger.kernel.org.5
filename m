Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0522F7E742F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345338AbjKIWHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjKIWH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:07:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566BD3C03;
        Thu,  9 Nov 2023 14:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699567644; x=1731103644;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=VU2y18Jv/zPJaRG39Rf7RXnTo1ED1AjeuhuoVpLw31o=;
  b=Uf6LUtQfk7NRp1WqATX5H2mmIkA2kgumdvoX4t9q2Jvy/t+ePRzK/0vR
   Pie7cM20GwiP7T+D2EWqneJzJ9OaLFMBN0o52vSxBI0JDtFqErohCEFB6
   7jbvMnDBbrz3SJnBAamhWMivuDns540claaISwJ4F1l7igTz+moPuuPHm
   ynEctlHMOzXg3wgciMgJSX64BOCR5OYeO9QruyQqss9tyWybGzQK0mniM
   YJ5Cd6HC4lSNWDj4Qzh20qmQnRhOgHSiiixfBTqETebQ28FCkiiM0CuA8
   wiIyEX9JBQdElHkgSNFSOXk2Tc3MUW+HzKeSzM6ib+ppUP1zxYtqO4uuT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375124174"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="375124174"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:07:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="713453312"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="713453312"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.16.95])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:07:23 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 09 Nov 2023 14:07:16 -0800
Subject: [PATCH RFC v4 3/6] cxl/events: Separate UUID from event structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v4-3-47bb901f135e@intel.com>
References: <20230601-cxl-cper-v4-0-47bb901f135e@intel.com>
In-Reply-To: <20230601-cxl-cper-v4-0-47bb901f135e@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699567638; l=8281;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=VU2y18Jv/zPJaRG39Rf7RXnTo1ED1AjeuhuoVpLw31o=;
 b=CHHNQHeEf1vsFpqbJps9YNaDLH7r1YhSe3T9f8LuK/wNzmy8yW1jftPNynYRGE+MwIdVcXsdn
 uSpHwNFi2m6DUpVSluEsnG0Q6IIx+t1lvsK8vKHQRRiwQAUSyUkB7YL
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UEFI CXL CPER structure does not include the UUID.  Now that the
UUID is passed separately to the trace event there is no need to have
the UUID in those structures.

Move UUID from the event record header to the raw structures.  Adjust
cxl-test to Create dummy structures for creating test records.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC v3:
[iweiny: reword the commit message]

Changes from RFC v2:
[iweiny: new patch]
---
 drivers/cxl/core/mbox.c      |   2 +-
 include/linux/cxl-event.h    |  10 ++--
 tools/testing/cxl/test/mem.c | 135 +++++++++++++++++++++++++------------------
 3 files changed, 84 insertions(+), 63 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 43aad71810e2..74446c6a990a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -864,7 +864,7 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 				   enum cxl_event_log_type type,
 				   struct cxl_event_record_raw *record)
 {
-	uuid_t *id = &record->hdr.id;
+	uuid_t *id = &record->id;
 
 	if (uuid_equal(id, &gen_media_event_uuid)) {
 		struct cxl_event_gen_media *rec =
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 1c94e8fdd227..ebb00ead1496 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -8,12 +8,7 @@
  * Copyright(c) 2023 Intel Corporation.
  */
 
-/*
- * Common Event Record Format
- * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
- */
 struct cxl_event_record_hdr {
-	uuid_t id;
 	u8 length;
 	u8 flags[3];
 	__le16 handle;
@@ -23,8 +18,13 @@ struct cxl_event_record_hdr {
 	u8 reserved[15];
 } __packed;
 
+/*
+ * Common Event Record Format
+ * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
+ */
 #define CXL_EVENT_RECORD_DATA_LENGTH 0x50
 struct cxl_event_record_raw {
+	uuid_t id;
 	struct cxl_event_record_hdr hdr;
 	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
 } __packed;
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 464fc39ed277..85862be00c48 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -330,9 +330,9 @@ static void cxl_mock_event_trigger(struct device *dev)
 }
 
 struct cxl_event_record_raw maint_needed = {
+	.id = UUID_INIT(0xBA5EBA11, 0xABCD, 0xEFEB,
+			0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
 	.hdr = {
-		.id = UUID_INIT(0xBA5EBA11, 0xABCD, 0xEFEB,
-				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
 		.length = sizeof(struct cxl_event_record_raw),
 		.flags[0] = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
 		/* .handle = Set dynamically */
@@ -342,9 +342,9 @@ struct cxl_event_record_raw maint_needed = {
 };
 
 struct cxl_event_record_raw hardware_replace = {
+	.id = UUID_INIT(0xABCDEFEB, 0xBA11, 0xBA5E,
+			0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
 	.hdr = {
-		.id = UUID_INIT(0xABCDEFEB, 0xBA11, 0xBA5E,
-				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
 		.length = sizeof(struct cxl_event_record_raw),
 		.flags[0] = CXL_EVENT_RECORD_FLAG_HW_REPLACE,
 		/* .handle = Set dynamically */
@@ -353,64 +353,85 @@ struct cxl_event_record_raw hardware_replace = {
 	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
 };
 
-struct cxl_event_gen_media gen_media = {
-	.hdr = {
-		.id = UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
-				0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
-		.length = sizeof(struct cxl_event_gen_media),
-		.flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
-		/* .handle = Set dynamically */
-		.related_handle = cpu_to_le16(0),
+struct cxl_test_gen_media {
+	uuid_t id;
+	struct cxl_event_gen_media rec;
+} __packed;
+
+struct cxl_test_gen_media gen_media = {
+	.id = UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
+			0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
+	.rec = {
+		.hdr = {
+			.length = sizeof(struct cxl_test_gen_media),
+			.flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
+			/* .handle = Set dynamically */
+			.related_handle = cpu_to_le16(0),
+		},
+		.phys_addr = cpu_to_le64(0x2000),
+		.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
+		.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
+		.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
+		/* .validity_flags = <set below> */
+		.channel = 1,
+		.rank = 30
 	},
-	.phys_addr = cpu_to_le64(0x2000),
-	.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
-	.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
-	.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
-	/* .validity_flags = <set below> */
-	.channel = 1,
-	.rank = 30
 };
 
-struct cxl_event_dram dram = {
-	.hdr = {
-		.id = UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
-				0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
-		.length = sizeof(struct cxl_event_dram),
-		.flags[0] = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
-		/* .handle = Set dynamically */
-		.related_handle = cpu_to_le16(0),
+struct cxl_test_dram {
+	uuid_t id;
+	struct cxl_event_dram rec;
+} __packed;
+
+struct cxl_test_dram dram = {
+	.id = UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
+			0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
+	.rec = {
+		.hdr = {
+			.length = sizeof(struct cxl_test_dram),
+			.flags[0] = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
+			/* .handle = Set dynamically */
+			.related_handle = cpu_to_le16(0),
+		},
+		.phys_addr = cpu_to_le64(0x8000),
+		.descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
+		.type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
+		.transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
+		/* .validity_flags = <set below> */
+		.channel = 1,
+		.bank_group = 5,
+		.bank = 2,
+		.column = {0xDE, 0xAD},
 	},
-	.phys_addr = cpu_to_le64(0x8000),
-	.descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
-	.type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
-	.transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
-	/* .validity_flags = <set below> */
-	.channel = 1,
-	.bank_group = 5,
-	.bank = 2,
-	.column = {0xDE, 0xAD},
 };
 
-struct cxl_event_mem_module mem_module = {
-	.hdr = {
-		.id = UUID_INIT(0xfe927475, 0xdd59, 0x4339,
-				0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
-		.length = sizeof(struct cxl_event_mem_module),
-		/* .handle = Set dynamically */
-		.related_handle = cpu_to_le16(0),
+struct cxl_test_mem_module {
+	uuid_t id;
+	struct cxl_event_mem_module rec;
+} __packed;
+
+struct cxl_test_mem_module mem_module = {
+	.id = UUID_INIT(0xfe927475, 0xdd59, 0x4339,
+			0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
+	.rec = {
+		.hdr = {
+			.length = sizeof(struct cxl_test_mem_module),
+			/* .handle = Set dynamically */
+			.related_handle = cpu_to_le16(0),
+		},
+		.event_type = CXL_MMER_TEMP_CHANGE,
+		.info = {
+			.health_status = CXL_DHI_HS_PERFORMANCE_DEGRADED,
+			.media_status = CXL_DHI_MS_ALL_DATA_LOST,
+			.add_status = (CXL_DHI_AS_CRITICAL << 2) |
+				      (CXL_DHI_AS_WARNING << 4) |
+				      (CXL_DHI_AS_WARNING << 5),
+			.device_temp = { 0xDE, 0xAD},
+			.dirty_shutdown_cnt = { 0xde, 0xad, 0xbe, 0xef },
+			.cor_vol_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
+			.cor_per_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
+		}
 	},
-	.event_type = CXL_MMER_TEMP_CHANGE,
-	.info = {
-		.health_status = CXL_DHI_HS_PERFORMANCE_DEGRADED,
-		.media_status = CXL_DHI_MS_ALL_DATA_LOST,
-		.add_status = (CXL_DHI_AS_CRITICAL << 2) |
-			      (CXL_DHI_AS_WARNING << 4) |
-			      (CXL_DHI_AS_WARNING << 5),
-		.device_temp = { 0xDE, 0xAD},
-		.dirty_shutdown_cnt = { 0xde, 0xad, 0xbe, 0xef },
-		.cor_vol_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
-		.cor_per_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
-	}
 };
 
 static int mock_set_timestamp(struct cxl_dev_state *cxlds,
@@ -432,11 +453,11 @@ static int mock_set_timestamp(struct cxl_dev_state *cxlds,
 static void cxl_mock_add_event_logs(struct mock_event_store *mes)
 {
 	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
-			   &gen_media.validity_flags);
+			   &gen_media.rec.validity_flags);
 
 	put_unaligned_le16(CXL_DER_VALID_CHANNEL | CXL_DER_VALID_BANK_GROUP |
 			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN,
-			   &dram.validity_flags);
+			   &dram.rec.validity_flags);
 
 	mes_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
 	mes_add_event(mes, CXL_EVENT_TYPE_INFO,

-- 
2.41.0

