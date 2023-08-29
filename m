Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7278BDE3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbjH2FYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbjH2FYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:24:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7185319B;
        Mon, 28 Aug 2023 22:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693286651; x=1724822651;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DZMaf28aqfjymKMjlQYhoxICqfP5W5OJWqpOsQJfEv4=;
  b=d+CE8HVHwruafsvotXhxSzTxxPWOGTJvldAlsJsT5KRU3L8L9S7YECxk
   M8yebkT9AG3fC/7SzvYNkcqy7V5Op1ogX995cnadfKKXP45YgFbMtigg4
   zkUWPyUgA+tai8nmCFdHapkjbCaqZOTIk3t0XbEXIu7ATt635Usmi+OPr
   0zwCw+jaRcdV1LJWbhZUKjaxV53Rlpgcr7UyHIG8LPZbPrKWthQd/wjQ/
   6HmxlJ55Fyb0Dm5TYmQJuogO+Nge6519DiGXV7eKuyPTrkVmIDHSi3zB/
   Zs3xoIb4aPOTQTmAET+LFSgYhSK5KKEW1lMb0aBw64jO6+oSrJUImaxn5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441625251"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441625251"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="738556431"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="738556431"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.37.183])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:49 -0700
From:   ira.weiny@intel.com
Date:   Mon, 28 Aug 2023 22:21:06 -0700
Subject: [PATCH RFC v2 15/18] cxl/mem: Trace Dynamic capacity Event Record
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v2-15-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693286607; l=3471;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=SkFWqVM1cpX13lEJuDcPSmo7A5I8/gNre3e4u4Y5C1o=;
 b=fHj3NceUK4qggURnK1NFp9VSp2SqReAkE5YbMlRMT5Nh504PzIxI1151YDCCrvlobitFjkU/Z
 jQ0JWRfjiZACR6gyzJu6+Kg7UPofwhlhi93pnLyDcPmbirDSOynxJIE
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navneet Singh <navneet.singh@intel.com>

CXL rev 3.0 section 8.2.9.2.1.5 defines the Dynamic Capacity Event Record
Determine if the event read is a Dynamic capacity event record and
if so trace the record for the debug purpose.

Add DC trace points to the trace log.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
[iweiny: fixups]
---
 drivers/cxl/core/mbox.c  |  5 ++++
 drivers/cxl/core/trace.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9d9c13e13ecf..9462c34aa1dc 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -939,6 +939,11 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 				(struct cxl_event_mem_module *)record;
 
 		trace_cxl_memory_module(cxlmd, type, rec);
+	} else if (uuid_equal(id, &dc_event_uuid)) {
+		struct dcd_event_dyn_cap *rec =
+				(struct dcd_event_dyn_cap *)record;
+
+		trace_cxl_dynamic_capacity(cxlmd, type, rec);
 	} else {
 		/* For unknown record types print just the header */
 		trace_cxl_generic_event(cxlmd, type, record);
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a0b5819bc70b..1899c5cc96b9 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -703,6 +703,71 @@ TRACE_EVENT(cxl_poison,
 	)
 );
 
+/*
+ * DYNAMIC CAPACITY Event Record - DER
+ *
+ * CXL rev 3.0 section 8.2.9.2.1.5 Table 8-47
+ */
+
+#define CXL_DC_ADD_CAPACITY			0x00
+#define CXL_DC_REL_CAPACITY			0x01
+#define CXL_DC_FORCED_REL_CAPACITY		0x02
+#define CXL_DC_REG_CONF_UPDATED			0x03
+#define show_dc_evt_type(type)	__print_symbolic(type,		\
+	{ CXL_DC_ADD_CAPACITY,	"Add capacity"},		\
+	{ CXL_DC_REL_CAPACITY,	"Release capacity"},		\
+	{ CXL_DC_FORCED_REL_CAPACITY,	"Forced capacity release"},	\
+	{ CXL_DC_REG_CONF_UPDATED,	"Region Configuration Updated"	} \
+)
+
+TRACE_EVENT(cxl_dynamic_capacity,
+
+	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
+		 struct dcd_event_dyn_cap  *rec),
+
+	TP_ARGS(cxlmd, log, rec),
+
+	TP_STRUCT__entry(
+		CXL_EVT_TP_entry
+
+		/* Dynamic capacity Event */
+		__field(u8, event_type)
+		__field(u16, hostid)
+		__field(u8, region_id)
+		__field(u64, dpa_start)
+		__field(u64, length)
+		__array(u8, tag, CXL_DC_EXTENT_TAG_LEN)
+		__field(u16, sh_extent_seq)
+	),
+
+	TP_fast_assign(
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+
+		/* Dynamic_capacity Event */
+		__entry->event_type = rec->data.event_type;
+
+		/* DCD event record data */
+		__entry->hostid = le16_to_cpu(rec->data.host_id);
+		__entry->region_id = rec->data.region_index;
+		__entry->dpa_start = le64_to_cpu(rec->data.extent.start_dpa);
+		__entry->length = le64_to_cpu(rec->data.extent.length);
+		memcpy(__entry->tag, &rec->data.extent.tag, CXL_DC_EXTENT_TAG_LEN);
+		__entry->sh_extent_seq = le16_to_cpu(rec->data.extent.shared_extn_seq);
+	),
+
+	CXL_EVT_TP_printk("event_type='%s' host_id='%d' region_id='%d' " \
+		"starting_dpa=%llx length=%llx tag=%s " \
+		"shared_extent_sequence=%d",
+		show_dc_evt_type(__entry->event_type),
+		__entry->hostid,
+		__entry->region_id,
+		__entry->dpa_start,
+		__entry->length,
+		__print_hex(__entry->tag, CXL_DC_EXTENT_TAG_LEN),
+		__entry->sh_extent_seq
+	)
+);
+
 #endif /* _CXL_EVENTS_H */
 
 #define TRACE_INCLUDE_FILE trace

-- 
2.41.0

