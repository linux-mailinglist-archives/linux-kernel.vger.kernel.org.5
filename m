Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262CF7EB05F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjKNM5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjKNM5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:57:09 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85746199;
        Tue, 14 Nov 2023 04:57:05 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SV5mV6Mvlz6JBJb;
        Tue, 14 Nov 2023 20:52:26 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 12:57:03 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <Vilas.Sridharan@amd.com>,
        <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
        <rientjes@google.com>, <jiaqiyan@google.com>,
        <tony.luck@intel.com>, <Jon.Grimm@amd.com>,
        <dave.hansen@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <james.morse@arm.com>, <david@redhat.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <"pgonda@pgonda"@google.com>, <duenwen@google.com>,
        <mike.malvestuto@intel.com>, <gthelen@google.com>,
        <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
        <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 1/6] cxl/mbox: Add GET_SUPPORTED_FEATURES, GET_FEATURE and SET_FEATURE mailbox commands
Date:   Tue, 14 Nov 2023 20:56:42 +0800
Message-ID: <20231114125648.1146-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231114125648.1146-1-shiju.jose@huawei.com>
References: <20231114125648.1146-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

Add support for GET_SUPPORTED_FEATURES, GET_FEATURE and SET_FEATURE mailbox
commands.

CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
CXL devices supports features with changeable attributes.
Get Supported Features retrieves the list of supported device specific
features. The settings of a feature can be retrieved using Get
Feature and optionally modified using Set Feature.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c      | 74 ++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h         | 95 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h |  3 ++
 3 files changed, 172 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 36270dcfb42e..2a6d8ab927bd 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -63,6 +63,9 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
 	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
+	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_CMD(GET_FEATURE, 0x15, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_CMD(SET_FEATURE, CXL_VARIABLE_PAYLOAD, 0, 0),
 };
 
 /*
@@ -1303,6 +1306,77 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
 
+struct cxl_mbox_get_supp_feats_out *cxl_get_supported_features(struct cxl_memdev_state *mds,
+						struct cxl_mbox_get_supp_feats_in *pi)
+{
+	int rc;
+	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_mbox_get_supp_feats_out *feats_out;
+
+	feats_out = kvmalloc(pi->count, GFP_KERNEL);
+	if (!feats_out)
+		return ERR_PTR(-ENOMEM);
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
+	if (rc < 0) {
+		kvfree(feats_out);
+		return ERR_PTR(rc);
+	}
+
+	return feats_out;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
+
+void *cxl_get_feature(struct cxl_memdev_state *mds, struct cxl_mbox_get_feat_in *pi)
+{
+	int rc;
+	void *feat_out;
+	struct cxl_mbox_cmd mbox_cmd;
+
+	feat_out = kvmalloc(pi->count, GFP_KERNEL);
+	if (!feat_out)
+		return ERR_PTR(-ENOMEM);
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_FEATURE,
+		.size_in = sizeof(*pi),
+		.payload_in = pi,
+		.size_out = pi->count,
+		.payload_out = feat_out,
+		.min_out = pi->count,
+	};
+	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	if (rc < 0) {
+		kvfree(feat_out);
+		return ERR_PTR(rc);
+	}
+
+	return feat_out;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
+
+int cxl_set_feature(struct cxl_memdev_state *mds, void *feat_in, size_t size)
+{
+	struct cxl_mbox_cmd mbox_cmd;
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_SET_FEATURE,
+		.size_in = size,
+		.payload_in = feat_in,
+	};
+
+	return cxl_internal_send_cmd(mds, &mbox_cmd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
+
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a2fcbca253f3..fdac686560d4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -506,6 +506,9 @@ enum cxl_opcode {
 	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
+	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
+	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -740,6 +743,94 @@ struct cxl_mbox_set_timestamp_in {
 
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
+#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_NONE	0x0
+#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_CXL_RESET	0x1
+#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_HOT_RESET	0x2
+#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_WARM_RESET	0x3
+#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_COLD_RESET	0x4
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
+/* Get Feature CXL 3.0 Spec 8.2.9.6.2 */
+/*
+ * Get Feature input payload
+ * CXL rev 3.0 section 8.2.9.6.2; Table 8-79
+ */
+/* Get Feature : Payload in selection */
+#define CXL_GET_FEAT_CURRENT_VALUE	0x00
+#define CXL_GET_FEAT_DEFAULT_VALUE	0x01
+#define CXL_GET_FEAT_SAVED_VALUE	0x02
+
+struct cxl_mbox_get_feat_in {
+	uuid_t uuid;
+	__le16 offset;
+	__le16 count;
+	u8 selection;
+}  __packed;
+
+/* Set Feature CXL 3.0 Spec 8.2.9.6.3 */
+/*
+ * Set Feature input payload
+ * CXL rev 3.0 section 8.2.9.6.3; Table 8-81
+ */
+/* Set Feature : Payload in flags */
+#define CXL_SET_FEAT_FLAG_ACTION_MASK	GENMASK(2, 0)
+#define CXL_SET_FEAT_FLAG_ACTION_FULL_DATA_TRANSFER	0x0
+#define CXL_SET_FEAT_FLAG_ACTION_INITIATE_DATA_TRANSFER	0x1
+#define CXL_SET_FEAT_FLAG_ACTION_CONTINUE_DATA_TRANSFER	0x2
+#define CXL_SET_FEAT_FLAG_ACTION_FINISH_DATA_TRANSFER	0x3
+#define CXL_SET_FEAT_FLAG_ACTION_ABORT_DATA_TRANSFER	0x4
+#define CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET	BIT(3)
+struct cxl_mbox_set_feat_in {
+	uuid_t uuid;
+	__le32 flags;
+	__le16 offset;
+	u8 version;
+	u8 rsvd[9];
+}  __packed;
+
 /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
 struct cxl_mbox_poison_in {
 	__le64 offset;
@@ -867,6 +958,10 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
+struct cxl_mbox_get_supp_feats_out *cxl_get_supported_features(struct cxl_memdev_state *mds,
+						struct cxl_mbox_get_supp_feats_in *pi);
+void *cxl_get_feature(struct cxl_memdev_state *mds, struct cxl_mbox_get_feat_in *pi);
+int cxl_set_feature(struct cxl_memdev_state *mds, void *feat_in, size_t size);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 14bc6e742148..8c89d323cc41 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -46,6 +46,9 @@
 	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
 	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
 	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
+	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),           \
+	___C(GET_FEATURE, "Get Feature"),                                 \
+	___C(SET_FEATURE, "Set Feature"),                                 \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.34.1

