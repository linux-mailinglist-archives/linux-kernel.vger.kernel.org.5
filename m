Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D469880DF1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345064AbjLKW5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345163AbjLKW5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:57:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5EBA9;
        Mon, 11 Dec 2023 14:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702335466; x=1733871466;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=XW/bbIWeEkyoIKlSkiodCvmvilmI65wzy37oXpNTcPQ=;
  b=fL0Qy2zefdNo17ZoaoxHLx3IHXwqAtXzCEiTMopdNjyDAssdqpsHqFsB
   8IIo5vb3TnxhTfpMlrvrNdmbIvEEmAJdVVS5RQs+Qf29pWOaWj+X/jGzG
   QBLTcclX26J5LE0V3fm2l3gdXrdrF7lOksVKXjP4muKiAJjdqkgnZDJZ9
   QlADmqCV3cGb4y+Yr/11S69AzvJJpZXzdsuuRskzrGHQIrBsRYkx+H8Tj
   BM0hW2RSSTPrZ8q0sxR2pWcJ67stmnR9tdo7qAsOevRHr+N+UK9Uyq9lN
   VRH8ddy7ATZOLEgv7fmBV0cBjnlJyywO3o2r+LRBghnBpA31rLm/tOVX5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8084347"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="8084347"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:57:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946513460"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="946513460"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.189.178])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:57:44 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 11 Dec 2023 14:57:41 -0800
Subject: [PATCH v2 1/7] cxl/trace: Pass uuid explicitly to event traces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-cxl-cper-v2-1-c116900ba658@intel.com>
References: <20231211-cxl-cper-v2-0-c116900ba658@intel.com>
In-Reply-To: <20231211-cxl-cper-v2-0-c116900ba658@intel.com>
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
X-Mailer: b4 0.13-dev-2539e
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702335462; l=5966;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=XW/bbIWeEkyoIKlSkiodCvmvilmI65wzy37oXpNTcPQ=;
 b=h+MMeUWVd9+AzROhLL6/MZTdH8U1LGJpsTXiktAdd4JWTt8YL6uQhq6qdMFbOOuJK8g8PPFB+
 IVNNYNumn9hCRFdLpa3TPsO/0f6ap1JWZC1eKII4pRIyH77rW0N3Enb
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CXL CPER events are identified by the CPER Section Type GUID. The GUID
correlates with the CXL UUID for the event record. It turns out that a
CXL CPER record is a strict subset of the CXL event record, only the
UUID header field is chopped.

In order to unify handling between native and CPER flavors of CXL
events, prepare the code for the UUID to be passed in rather than
inferred from the record itself.

Later patches update the passed in record to only refer to the common
data between the formats.

Pass the UUID explicitly to each trace event to be able to remove the
UUID from the event structures.

Originally it was desirable to remove the UUID from the well known event
because the UUID value was redundant.  However, the trace API was
already in place.[1]

[1] https://lore.kernel.org/all/36f2d12934d64a278f2c0313cbd01abc@huawei.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2:
[djbw: reword commit message]
[djbw: keep uuid field name hdr_uuid]
---
 drivers/cxl/core/mbox.c  |  8 ++++----
 drivers/cxl/core/trace.h | 30 +++++++++++++++---------------
 2 files changed, 19 insertions(+), 19 deletions(-)

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
index a0b5819bc70b..68973a101a75 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -189,7 +189,7 @@ TRACE_EVENT(cxl_overflow,
 	__string(memdev, dev_name(&cxlmd->dev))			\
 	__string(host, dev_name(cxlmd->dev.parent))		\
 	__field(int, log)					\
-	__field_struct(uuid_t, hdr_uuid)			\
+	__field_struct(uuid_t, hdr_uuid)				\
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
+	memcpy(&__entry->hdr_uuid, (uuid), sizeof(uuid_t));				\
 	__entry->hdr_length = (hdr).length;					\
 	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
 	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
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
2.43.0

