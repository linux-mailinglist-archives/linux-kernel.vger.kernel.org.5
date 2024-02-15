Return-Path: <linux-kernel+bounces-66754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACCD856126
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835E11F21645
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7891412A162;
	Thu, 15 Feb 2024 11:15:11 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09B66B2D;
	Thu, 15 Feb 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995711; cv=none; b=rZt/eeh9kyv+4vsAX+DVKDvvlWmwEZ1Iqf+Sshrl15hcHuRoWEBdWK4fcnOqYhUwt8iuz+FmgFyqt+YTpy2R/fATr2glIS2RLuSMraj2AGGVa4/PQunWlOlFdiV04UEIrvu5W7yDOXqohafxdbcnXp3+STN928hJbuoZdsgySjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995711; c=relaxed/simple;
	bh=QQvnXMSi++sGfD6je4Srj/GDNSsMMgr8SC5M7Oowa+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VeN5m8O+JOYp1sUZFVqlUm549KVuYEeT4/LAeyoIq7bKvQCCWbi7ycI1DwDQQUFtnHpBL86LBnCri8E81MnqO+D/3BUT3yo+Jh2pT4lMQUbsJD1sA0slCtWPSRjMLJ2sZEYuh6apGBgLs3amkq4QXSJIOSX4gQmE9cy4W+NC6Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbC6x3XWYz67MfY;
	Thu, 15 Feb 2024 19:11:21 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 7334114025A;
	Thu, 15 Feb 2024 19:15:05 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:15:04 +0000
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH v6 01/12] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox command
Date: Thu, 15 Feb 2024 19:14:43 +0800
Message-ID: <20240215111455.1462-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240215111455.1462-1-shiju.jose@huawei.com>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for GET_SUPPORTED_FEATURES mailbox command.

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
CXL devices supports features with changeable attributes.
Get Supported Features retrieves the list of supported device specific
features. The settings of a feature can be retrieved using Get Feature
and optionally modified using Set Feature.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c | 23 +++++++++++++++
 drivers/cxl/cxlmem.h    | 62 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 27166a411705..191f51f3df0e 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1290,6 +1290,29 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
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
+		.size_out = le32_to_cpu(pi->count),
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
index 5303d6942b88..23e4d98b9bae 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -529,6 +529,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -698,6 +699,64 @@ struct cxl_mbox_set_timestamp_in {
 
 } __packed;
 
+/* Get Supported Features CXL 3.1 Spec 8.2.9.6.1 */
+/*
+ * Get Supported Features input payload
+ * CXL rev 3.1 section 8.2.9.6.1 Table 8-95
+ */
+struct cxl_mbox_get_supp_feats_in {
+	__le32 count;
+	__le16 start_index;
+	u16 reserved;
+} __packed;
+
+/*
+ * Get Supported Features Supported Feature Entry
+ * CXL rev 3.1 section 8.2.9.6.1 Table 8-97
+ */
+/* Supported Feature Entry : Payload out attribute flags */
+#define CXL_FEAT_ENTRY_FLAG_CHANGABLE	BIT(0)
+#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_MASK	GENMASK(3, 1)
+#define CXL_FEAT_ENTRY_FLAG_PERSIST_ACROSS_FIRMWARE_UPDATE	BIT(4)
+#define CXL_FEAT_ENTRY_FLAG_SUPPORT_DEFAULT_SELECTION	BIT(5)
+#define CXL_FEAT_ENTRY_FLAG_SUPPORT_SAVED_SELECTION	BIT(6)
+
+enum cxl_feat_attr_value_persistence {
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_NONE,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_CXL_RESET,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_HOT_RESET,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_WARM_RESET,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_COLD_RESET,
+	CXL_FEAT_ATTR_VALUE_PERSISTENCE_MAX
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
+	__le32 attr_flags;
+	u8 get_feat_version;
+	u8 set_feat_version;
+	__le16 set_feat_effects;
+	u8 rsvd[18];
+}  __packed;
+
+/*
+ * Get Supported Features output payload
+ * CXL rev 3.1 section 8.2.9.6.1 Table 8-96
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
@@ -829,6 +888,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
+int cxl_get_supported_features(struct cxl_memdev_state *mds,
+			       struct cxl_mbox_get_supp_feats_in *pi,
+			       void *feats_out);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
-- 
2.34.1


