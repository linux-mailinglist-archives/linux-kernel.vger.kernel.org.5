Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1875C7F2A29
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjKUKUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjKUKTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:19:53 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D661716;
        Tue, 21 Nov 2023 02:19:02 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SZKwW5hG9z6J9Sj;
        Tue, 21 Nov 2023 18:14:03 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 Nov 2023 10:18:59 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
        <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
        <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
        <jiaqiyan@google.com>, <tony.luck@intel.com>, <Jon.Grimm@amd.com>,
        <dave.hansen@linux.intel.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <james.morse@arm.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <pgonda@google.com>, <duenwen@google.com>,
        <mike.malvestuto@intel.com>, <gthelen@google.com>,
        <wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
        <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
        <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 01/10] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox command
Date:   Tue, 21 Nov 2023 18:18:34 +0800
Message-ID: <20231121101844.1161-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231121101844.1161-1-shiju.jose@huawei.com>
References: <20231121101844.1161-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Add support for GET_SUPPORTED_FEATURES mailbox command.

CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
CXL devices supports features with changeable attributes.
Get Supported Features retrieves the list of supported device specific
features. The settings of a feature can be retrieved using Get Feature
and optionally modified using Set Feature.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c      | 24 +++++++++++++++
 drivers/cxl/cxlmem.h         | 59 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h |  1 +
 3 files changed, 84 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 36270dcfb42e..06ec9ef50e7f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -63,6 +63,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
 	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
+	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
 };
 
 /*
@@ -1303,6 +1304,29 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
 
+int cxl_get_supported_features(struct cxl_memdev_state *mds,
+						struct cxl_mbox_get_supp_feats_in *pi,
+						void *feats_out)
+{
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
+		.size_in = sizeof(*pi),
+		.payload_in = pi,
+		.size_out = pi->count,
+		.payload_out = feats_out,
+		.min_out = sizeof(struct cxl_mbox_get_supp_feats_out),
+	};
+	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
+
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a2fcbca253f3..d831dad748f5 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -506,6 +506,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -740,6 +741,61 @@ struct cxl_mbox_set_timestamp_in {
 
 } __packed;
 
+/* Get Supported Features CXL 3.0 Spec 8.2.9.6.1 */
+/*
+ * Get Supported Features input payload
+ * CXL rev 3.0 section 8.2.9.6.1; Table 8-75
+ */
+struct cxl_mbox_get_supp_feats_in {
+	__le32 count;
+	__le16 start_index;
+	u16 reserved;
+} __packed;
+
+/*
+ * Get Supported Features Supported Feature Entry
+ * CXL rev 3.0 section 8.2.9.6.1; Table 8-77
+ */
+/* Supported Feature Entry : Payload out attribute flags */
+#define CXL_FEAT_ENTRY_FLAG_CHANGABLE	BIT(0)
+#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_MASK	GENMASK(3, 1)
+
+enum cxl_feat_attrib_value_persistence {
+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_NONE = 0x0,
+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_CXL_RESET = 0x1,
+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_HOT_RESET = 0x2,
+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_WARM_RESET = 0x3,
+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_COLD_RESET = 0x4,
+	CXL_FEAT_ATTRIB_VALUE_PERSISTENCE_MAX
+};
+
+#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_ACROSS_FW_UPDATE_MASK	BIT(4)
+#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_DEFAULT_SEL_SUPPORT_MASK	BIT(5)
+#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_SAVED_SEL_SUPPORT_MASK	BIT(6)
+
+struct cxl_mbox_supp_feat_entry {
+	uuid_t uuid;
+	__le16 feat_index;
+	__le16 get_feat_size;
+	__le16 set_feat_size;
+	__le32 attrb_flags;
+	u8 get_feat_version;
+	u8 set_feat_version;
+	__le16 set_feat_effects;
+	u8 rsvd[18];
+}  __packed;
+
+/*
+ * Get Supported Features output payload
+ * CXL rev 3.0 section 8.2.9.6.1; Table 8-76
+ */
+struct cxl_mbox_get_supp_feats_out {
+	__le16 entries;
+	__le16 nsuppfeats_dev;
+	u32 reserved;
+	struct cxl_mbox_supp_feat_entry feat_entries[];
+} __packed;
+
 /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
 struct cxl_mbox_poison_in {
 	__le64 offset;
@@ -867,6 +923,9 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
+int cxl_get_supported_features(struct cxl_memdev_state *mds,
+			       struct cxl_mbox_get_supp_feats_in *pi,
+			       void *feats_out);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 14bc6e742148..656450274001 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -46,6 +46,7 @@
 	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
 	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
 	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
+	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),           \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.34.1

