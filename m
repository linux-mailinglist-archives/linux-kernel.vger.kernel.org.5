Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2476F78BDD1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbjH2FYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbjH2FYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:24:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A72B19B;
        Mon, 28 Aug 2023 22:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693286648; x=1724822648;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RaGculr/PnAD0FdsC4GZC3RN59KZmeYQTrpV5iUGtII=;
  b=EUmO+kW92GnQF2nDnJCJ8Zc8DEbvTIB9bn+aUL/oWBi7N+yI5UydXNQo
   9noX+soQTzNcT92KhDK4vVLUvKFOgCoJCBsqOaCVXMvJG3Oa+MCFY0+xc
   uHm8+X+ZETK8OGW8ZDR6boe4LwA+qJ5HP35BK9ruwe7KB7EGkZ/fJZ7Ic
   uzJ3HMpNLdBmjWVwfS5/58rZ0U2cmQfhVvU8Ap972aBipdpzlF4N/wbHw
   6S+VxvfzEcOZygojZMYMyS5gbqQGAqVeN/kR3+Nq2ilN+6DUPINS474Ra
   iyMhGPTLTZ+N7KmFdOUmJmZbHtosyfwiY/ESCVjWV6tX+QmDh9MPZOft+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441625229"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441625229"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="738556400"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="738556400"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.37.183])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:43 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 28 Aug 2023 22:21:01 -0700
Subject: [PATCH RFC v2 10/18] cxl/mem: Handle DCD add and release capacity
 events.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v2-10-f740c47e7916@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693286607; l=12104;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=RaGculr/PnAD0FdsC4GZC3RN59KZmeYQTrpV5iUGtII=;
 b=+Y1T5WuDw+Tal6Z559togfIjU10J697AT986kBWJtJi9QQ38zfZN7GdtrI44ulVfQHUd6WsEb
 gFUGxbcr5bNAlopZkYq1lOoMkUkLVn/vCPE3FJ8gtqt5xis7k4nGRNJ
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

A Dynamic Capacity Device (DCD) utilizes events to signal the host about
the changes to the allocation of Dynamic Capacity (DC) extents. The
device communicates the state of DC extents through an extent list that
describes the starting DPA, length, and meta data of the blocks the host
can access.

Process the dynamic capacity add and release events.  The addition or
removal of extents can occur at any time.  Adding asynchronous memory is
straight forward.  Also remember the host is under no obligation to
respond to a release event until it is done with the memory.  Introduce
extent kref's to handle the delay of extent release.

In the case of a force removal, access to the memory will fail and may
cause a crash.  However, the extent tracking object is preserved for the
region to safely tear down as long as the memory is not accessed.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
changes for v2:
[iweiny: Totally new version of the patch]
[iweiny: use kref to track when to release an extent]
[iweiny: rebased to latest master/type2 work]
[iweiny: use a kref to track if extents are being referenced]
[alison: align commit message paragraphs]
[alison: remove unnecessary return]
[iweiny: Adjust for the new __devm_cxl_add_dax_region()]
[navneet: Fix debug prints in adding/releasing extent]
[alison: deal with odd if/else logic]
[alison: reverse x-tree]
[alison: reverse x-tree]
[alison: s/total_extent_cnt/count/]
[alison: make handle event reverse x-tree]
[alison: cleanup/shorten/remove handle event comment]
[iweiny/Alison: refactor cxl_handle_dcd_event_records function]
[iweiny: keep cxl_dc_extent_data local to mbox.c]
[jonathan: eliminate 'rc']
[iweiny: use proper type for mailbox size]
[jonathan: put dc_extents on the stack]
[jonathan: use direct returns instead of goto]
[iweiny: Clean up comment]
[Jonathan: define CXL_DC_EXTENT_TAG_LEN]
[Jonathan: remove extraneous changes]
[Jonathan: fix blank line issues]
---
 drivers/cxl/core/mbox.c | 186 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h       |   9 +++
 drivers/cxl/cxlmem.h    |  30 ++++++++
 3 files changed, 224 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9b08c40ef484..8474a28b16ca 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -839,6 +839,8 @@ static int cxl_store_dc_extent(struct cxl_memdev_state *mds,
 	extent->length = le64_to_cpu(dc_extent->length);
 	memcpy(extent->tag, dc_extent->tag, sizeof(extent->tag));
 	extent->shared_extent_seq = le16_to_cpu(dc_extent->shared_extn_seq);
+	kref_init(&extent->region_ref);
+	extent->mds = mds;
 
 	dev_dbg(dev, "dynamic capacity extent DPA:0x%llx LEN:%llx\n",
 		extent->dpa_start, extent->length);
@@ -879,6 +881,14 @@ static const uuid_t mem_mod_event_uuid =
 	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
 		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
 
+/* 
+ * Dynamic Capacity Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+static const uuid_t dc_event_uuid =
+	UUID_INIT(0xca95afa7, 0xf183, 0x4018, 0x8c,
+		  0x2f, 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a);
+
 static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 				   enum cxl_event_log_type type,
 				   struct cxl_event_record_raw *record)
@@ -973,6 +983,171 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	return rc;
 }
 
+static int cxl_send_dc_cap_response(struct cxl_memdev_state *mds,
+				struct cxl_mbox_dc_response *res,
+				int extent_cnt, int opcode)
+{
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t size;
+
+	size = struct_size(res, extent_list, extent_cnt);
+	res->extent_list_size = cpu_to_le32(extent_cnt);
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = opcode,
+		.size_in = size,
+		.payload_in = res,
+	};
+
+	return cxl_internal_send_cmd(mds, &mbox_cmd);
+}
+
+static int cxl_prepare_ext_list(struct cxl_mbox_dc_response **res,
+				int *n, struct range *extent)
+{
+	struct cxl_mbox_dc_response *dc_res;
+	unsigned int size;
+
+	if (!extent)
+		size = struct_size(dc_res, extent_list, 0);
+	else
+		size = struct_size(dc_res, extent_list, *n + 1);
+
+	dc_res = krealloc(*res, size, GFP_KERNEL);
+	if (!dc_res)
+		return -ENOMEM;
+
+	if (extent) {
+		dc_res->extent_list[*n].dpa_start = cpu_to_le64(extent->start);
+		memset(dc_res->extent_list[*n].reserved, 0, 8);
+		dc_res->extent_list[*n].length = cpu_to_le64(range_len(extent));
+		(*n)++;
+	}
+
+	*res = dc_res;
+	return 0;
+}
+
+static void dc_extent_release(struct kref *kref)
+{
+	struct cxl_dc_extent_data *extent = container_of(kref,
+						struct cxl_dc_extent_data,
+						region_ref);
+	struct cxl_memdev_state *mds = extent->mds;
+	struct cxl_mbox_dc_response *dc_res = NULL;
+	struct range rel_range = (struct range) {
+		.start = extent->dpa_start,
+		.end = extent->dpa_start + extent->length - 1,
+	};
+	struct device *dev = mds->cxlds.dev;
+	int extent_cnt = 0, rc;
+
+	rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, &rel_range);
+	if (rc < 0) {
+		dev_err(dev, "Failed to create release response %d\n", rc);
+		goto free_extent;
+	}
+	rc = cxl_send_dc_cap_response(mds, dc_res, extent_cnt,
+				      CXL_MBOX_OP_RELEASE_DC);
+	kfree(dc_res);
+
+free_extent:
+	kfree(extent);
+}
+
+void cxl_dc_extent_put(struct cxl_dc_extent_data *extent)
+{
+	kref_put(&extent->region_ref, dc_extent_release);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dc_extent_put, CXL);
+
+static int cxl_handle_dcd_release_event(struct cxl_memdev_state *mds,
+					struct cxl_dc_extent *rel_extent)
+{
+	struct device *dev = mds->cxlds.dev;
+	struct cxl_dc_extent_data *extent;
+	resource_size_t dpa, size;
+
+	dpa = le64_to_cpu(rel_extent->start_dpa);
+	size = le64_to_cpu(rel_extent->length);
+	dev_dbg(dev, "Release DC extent DPA:0x%llx LEN:%llx\n",
+		dpa, size);
+
+	extent = xa_erase(&mds->dc_extent_list, dpa);
+	if (!extent) {
+		dev_err(dev, "No extent found with DPA:0x%llx\n", dpa);
+		return -EINVAL;
+	}
+	cxl_dc_extent_put(extent);
+	return 0;
+}
+
+static int cxl_handle_dcd_add_event(struct cxl_memdev_state *mds,
+				    struct cxl_dc_extent *add_extent)
+{
+	struct cxl_mbox_dc_response *dc_res = NULL;
+	struct range alloc_range, *resp_range;
+	struct device *dev = mds->cxlds.dev;
+	int extent_cnt = 0;
+	int rc;
+
+	dev_dbg(dev, "Add DC extent DPA:0x%llx LEN:%llx\n",
+		le64_to_cpu(add_extent->start_dpa),
+		le64_to_cpu(add_extent->length));
+
+	alloc_range = (struct range){
+		.start = le64_to_cpu(add_extent->start_dpa),
+		.end = le64_to_cpu(add_extent->start_dpa) +
+			le64_to_cpu(add_extent->length) - 1,
+	};
+	resp_range = &alloc_range;
+
+	rc = cxl_store_dc_extent(mds, add_extent);
+	if (rc) {
+		dev_dbg(dev, "unconsumed DC extent DPA:0x%llx LEN:%llx\n",
+			le64_to_cpu(add_extent->start_dpa),
+			le64_to_cpu(add_extent->length));
+		resp_range = NULL;
+	}
+
+	rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, resp_range);
+	if (rc < 0) {
+		dev_err(dev, "Couldn't create extent list %d\n", rc);
+		return rc;
+	}
+
+	rc = cxl_send_dc_cap_response(mds, dc_res, extent_cnt,
+				      CXL_MBOX_OP_ADD_DC_RESPONSE);
+	kfree(dc_res);
+	return rc;
+}
+
+/* Returns 0 if the event was handled successfully. */
+static int cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
+					struct cxl_event_record_raw *rec)
+{
+	struct dcd_event_dyn_cap *record = (struct dcd_event_dyn_cap *)rec;
+	uuid_t *id = &rec->hdr.id;
+	int rc;
+
+	if (!uuid_equal(id, &dc_event_uuid))
+		return -EINVAL;
+
+	switch (record->data.event_type) {
+	case DCD_ADD_CAPACITY:
+		rc = cxl_handle_dcd_add_event(mds, &record->data.extent);
+		break;
+	case DCD_RELEASE_CAPACITY:
+        case DCD_FORCED_CAPACITY_RELEASE:
+		rc = cxl_handle_dcd_release_event(mds, &record->data.extent);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rc;
+}
+
 static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 				    enum cxl_event_log_type type)
 {
@@ -1016,6 +1191,13 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 				le16_to_cpu(payload->records[i].hdr.handle));
 			cxl_event_trace_record(cxlmd, type,
 					       &payload->records[i]);
+			if (type == CXL_EVENT_TYPE_DCD) {
+				rc = cxl_handle_dcd_event_records(mds,
+								  &payload->records[i]);
+				if (rc) 
+					dev_err_ratelimited(dev, "dcd event failed: %d\n",
+							    rc);
+			}
 		}
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
@@ -1056,6 +1238,8 @@ void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
 		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_WARN);
 	if (status & CXLDEV_EVENT_STATUS_INFO)
 		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_INFO);
+	if (status & CXLDEV_EVENT_STATUS_DCD)
+		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_DCD);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
 
@@ -1712,7 +1896,7 @@ static void cxl_destroy_mds(void *_mds)
 
 	xa_for_each(&mds->dc_extent_list, index, extent) {
 		xa_erase(&mds->dc_extent_list, index);
-		kfree(extent);
+		cxl_dc_extent_put(extent);
 	}
 	xa_destroy(&mds->dc_extent_list);
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0a225b0c20bf..81ca76ae1d02 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -163,6 +163,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
 #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
 #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
+#define CXLDEV_EVENT_STATUS_DCD                 BIT(4)
 
 #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
 				 CXLDEV_EVENT_STATUS_WARN |	\
@@ -601,6 +602,14 @@ struct cxl_pmem_region {
 	struct cxl_pmem_region_mapping mapping[];
 };
 
+/* See CXL 3.0 8.2.9.2.1.5 */
+enum dc_event {
+        DCD_ADD_CAPACITY,
+        DCD_RELEASE_CAPACITY,
+        DCD_FORCED_CAPACITY_RELEASE,
+        DCD_REGION_CONFIGURATION_UPDATED,
+};
+
 struct cxl_dax_region {
 	struct device dev;
 	struct cxl_region *cxlr;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ad690600c1b9..118392229174 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -582,6 +582,16 @@ enum cxl_opcode {
 	UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19,     \
 		  0x40, 0x3d, 0x86)
 
+struct cxl_mbox_dc_response {
+	__le32 extent_list_size;
+	u8 reserved[4];
+	struct updated_extent_list {
+		__le64 dpa_start;
+		__le64 length;
+		u8 reserved[8];
+	} __packed extent_list[];
+} __packed;
+
 struct cxl_mbox_get_supported_logs {
 	__le16 entries;
 	u8 rsvd[6];
@@ -667,6 +677,7 @@ enum cxl_event_log_type {
 	CXL_EVENT_TYPE_WARN,
 	CXL_EVENT_TYPE_FAIL,
 	CXL_EVENT_TYPE_FATAL,
+	CXL_EVENT_TYPE_DCD,
 	CXL_EVENT_TYPE_MAX
 };
 
@@ -757,6 +768,8 @@ struct cxl_dc_extent_data {
 	u64 length;
 	u8 tag[CXL_DC_EXTENT_TAG_LEN];
 	u16 shared_extent_seq;
+	struct cxl_memdev_state *mds;
+	struct kref region_ref;
 };
 
 /*
@@ -771,6 +784,21 @@ struct cxl_dc_extent {
 	u8 reserved[6];
 } __packed;
 
+struct dcd_record_data {
+	u8 event_type;
+	u8 reserved;
+	__le16 host_id;
+	u8 region_index;
+	u8 reserved1[3];
+	struct cxl_dc_extent extent;
+	u8 reserved2[32];
+} __packed;
+
+struct dcd_event_dyn_cap {
+	struct cxl_event_record_hdr hdr; 
+	struct dcd_record_data data;
+} __packed;
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;
@@ -974,6 +1002,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
+void cxl_dc_extent_put(struct cxl_dc_extent_data *extent);
+
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);

-- 
2.41.0

