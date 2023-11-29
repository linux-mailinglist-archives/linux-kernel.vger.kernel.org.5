Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EF37FDEFB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjK2SAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjK2SAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:00:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A439D;
        Wed, 29 Nov 2023 10:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701280849; x=1732816849;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=OWZeIDc6rIex0tECUFYw4oKCBrisJGx/p6wwk/Rst3U=;
  b=Vru/5TZgoNcWLvaCBeqq+vI+WKOA9QPWV9vBEGcZz9WuzbsqAcTeciT8
   KbzjNpLVbrPUhbKTW8/7MiMt9bLMp3v89Dc1V3TTbViiFFF3N6aTQutL6
   HRx0zmOV0opIbrWb44EaXc6U0/aWXgYk+VBj5ADn1Tl9RjBNZsUYNzq42
   C3QBZgyKLVKBvWGE7G7RijGegu+nWcAPewpuqsNdp1KaccXnQvKIvRUmO
   5j0iYJW6rw36fHFw3XjMT9CvOAFiWlB/Z5aYM49kZ+rUYnaUOB+MVE8YS
   hYpWQkdcw6jo6W3+pN3TMCT9wF7kpPu0k6O42khzKHG6DZQgcToTwznan
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="457524459"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="457524459"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:00:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="835096097"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="835096097"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.127.168])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:00:48 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 29 Nov 2023 10:00:41 -0800
Subject: [PATCH 1/6] cxl/trace: Pass uuid explicitly to event traces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v1-1-d19f1ac18ab6@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701280847; l=5986;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=OWZeIDc6rIex0tECUFYw4oKCBrisJGx/p6wwk/Rst3U=;
 b=/I3lEQUUDQVtfDt9GNhlHpducc9YrBkRNVtLNfTvtI2RpnB7Lf0rGBayzwvZ0nTQ5YfO6M1tJ
 ro0unQ36Y4yCec1IJ3kGK5Rg+UkXJqExbmuGZuQcHviyHDVmhwPS/f7
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

CPER CXL events do not have a UUID associated with them.  It is
desirable to share event structures between the CPER CXL event and the
CXL event log events.

Pass the UUID explicitly to each trace event to be able to remove the
UUID from the event structures.

Originally it was desirable to remove the UUID from the well known event
because the UUID value was redundant.  However, the trace API was
already in place.[1]

[1] https://lore.kernel.org/all/36f2d12934d64a278f2c0313cbd01abc@huawei.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c  |  8 ++++----
 drivers/cxl/core/trace.h | 32 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 36270dcfb42e..00f429c440df 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -870,19 +870,19 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		struct cxl_event_gen_media *rec =
 				(struct cxl_event_gen_media *)record;
 
-		trace_cxl_general_media(cxlmd, type, rec);
+		trace_cxl_general_media(cxlmd, type, id, rec);
 	} else if (uuid_equal(id, &dram_event_uuid)) {
 		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
 
-		trace_cxl_dram(cxlmd, type, rec);
+		trace_cxl_dram(cxlmd, type, id, rec);
 	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
 		struct cxl_event_mem_module *rec =
 				(struct cxl_event_mem_module *)record;
 
-		trace_cxl_memory_module(cxlmd, type, rec);
+		trace_cxl_memory_module(cxlmd, type, id, rec);
 	} else {
 		/* For unknown record types print just the header */
-		trace_cxl_generic_event(cxlmd, type, record);
+		trace_cxl_generic_event(cxlmd, type, id, record);
 	}
 }
 
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a0b5819bc70b..2aef185f4cd0 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -189,7 +189,7 @@ TRACE_EVENT(cxl_overflow,
 	__string(memdev, dev_name(&cxlmd->dev))			\
 	__string(host, dev_name(cxlmd->dev.parent))		\
 	__field(int, log)					\
-	__field_struct(uuid_t, hdr_uuid)			\
+	__field_struct(uuid_t, uuid)				\
 	__field(u64, serial)					\
 	__field(u32, hdr_flags)					\
 	__field(u16, hdr_handle)				\
@@ -198,12 +198,12 @@ TRACE_EVENT(cxl_overflow,
 	__field(u8, hdr_length)					\
 	__field(u8, hdr_maint_op_class)
 
-#define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
+#define CXL_EVT_TP_fast_assign(cxlmd, l, uuid, hdr)				\
 	__assign_str(memdev, dev_name(&(cxlmd)->dev));				\
 	__assign_str(host, dev_name((cxlmd)->dev.parent));			\
 	__entry->log = (l);							\
 	__entry->serial = (cxlmd)->cxlds->serial;				\
-	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
+	memcpy(&__entry->uuid, (uuid), sizeof(uuid_t));				\
 	__entry->hdr_length = (hdr).length;					\
 	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
 	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
@@ -217,7 +217,7 @@ TRACE_EVENT(cxl_overflow,
 		"maint_op_class=%u : " fmt,					\
 		__get_str(memdev), __get_str(host), __entry->serial,		\
 		cxl_event_log_type_str(__entry->log),				\
-		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
+		__entry->hdr_timestamp, &__entry->uuid, __entry->hdr_length,	\
 		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
 		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
 		##__VA_ARGS__)
@@ -225,9 +225,9 @@ TRACE_EVENT(cxl_overflow,
 TRACE_EVENT(cxl_generic_event,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_event_record_raw *rec),
+		 const uuid_t *uuid, struct cxl_event_record_raw *rec),
 
-	TP_ARGS(cxlmd, log, rec),
+	TP_ARGS(cxlmd, log, uuid, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -235,7 +235,7 @@ TRACE_EVENT(cxl_generic_event,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
 		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
 	),
 
@@ -315,9 +315,9 @@ TRACE_EVENT(cxl_generic_event,
 TRACE_EVENT(cxl_general_media,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_event_gen_media *rec),
+		 const uuid_t *uuid, struct cxl_event_gen_media *rec),
 
-	TP_ARGS(cxlmd, log, rec),
+	TP_ARGS(cxlmd, log, uuid, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -336,7 +336,7 @@ TRACE_EVENT(cxl_general_media,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
 
 		/* General Media */
 		__entry->dpa = le64_to_cpu(rec->phys_addr);
@@ -398,9 +398,9 @@ TRACE_EVENT(cxl_general_media,
 TRACE_EVENT(cxl_dram,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_event_dram *rec),
+		 const uuid_t *uuid, struct cxl_event_dram *rec),
 
-	TP_ARGS(cxlmd, log, rec),
+	TP_ARGS(cxlmd, log, uuid, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -422,7 +422,7 @@ TRACE_EVENT(cxl_dram,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
 
 		/* DRAM */
 		__entry->dpa = le64_to_cpu(rec->phys_addr);
@@ -547,9 +547,9 @@ TRACE_EVENT(cxl_dram,
 TRACE_EVENT(cxl_memory_module,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_event_mem_module *rec),
+		 const uuid_t *uuid, struct cxl_event_mem_module *rec),
 
-	TP_ARGS(cxlmd, log, rec),
+	TP_ARGS(cxlmd, log, uuid, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -569,7 +569,7 @@ TRACE_EVENT(cxl_memory_module,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
 
 		/* Memory Module Event */
 		__entry->event_type = rec->event_type;

-- 
2.42.0

