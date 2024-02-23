Return-Path: <linux-kernel+bounces-78490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B86B861415
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F6F28558F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79FFF9CB;
	Fri, 23 Feb 2024 14:37:44 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7CD4C9F;
	Fri, 23 Feb 2024 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699064; cv=none; b=bq3Y1Nx1dgIEguszRsfh4716v5BAqqTc6DVOMsSjlaR1/o+ttYzzcdbRTOe7UiQJgkuNTKsbi0/ypz7Y1ejXbTjmzorNQsFUpa2jk9MKuZIYHLGn+QY/31SXcWx/88YQjLOUQzOnOigpaWQP3RjNMUqucHHgM2mgIq6Wk7EqQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699064; c=relaxed/simple;
	bh=lvbjD2z9NHzDWPv/TQz12bdxnv+pmG3sMvEDkHDpAKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/jjZRjO3rDSky6fbTPJlZo2Vq+kn0tiXgLuvB+6JTiF7MK+4GfpBWf6rH1NlPg2PfW2DbRuf2D2deKJacX3I4eZLaQxJNZ/r+p1qB7kGvuh80UEpddA8cnbwuTH4VBJh1irlHbld+0cR3f7aswcme5ngSWu4mooMwzcrYC28pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThCF44XpBz6K8d2;
	Fri, 23 Feb 2024 22:34:00 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id B5B62140D26;
	Fri, 23 Feb 2024 22:37:39 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 14:37:38 +0000
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
Subject: [RFC PATCH v7 02/12] cxl/mbox: Add GET_FEATURE mailbox command
Date: Fri, 23 Feb 2024 22:37:13 +0800
Message-ID: <20240223143723.1574-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240223143723.1574-1-shiju.jose@huawei.com>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for GET_FEATURE mailbox command.

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
The settings of a feature can be retrieved using Get Feature command.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c | 49 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 25 +++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 79cc7fd433aa..c078e62ea194 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1317,6 +1317,55 @@ int cxl_get_supported_features(struct cxl_memdev_state *mds,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
 
+size_t cxl_get_feature(struct cxl_memdev_state *mds,
+		       const uuid_t feat_uuid, void *feat_out,
+		       size_t feat_out_size,
+		       size_t feat_out_min_size,
+		       enum cxl_get_feat_selection selection)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct cxl_mbox_get_feat_in pi;
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t data_rcvd_size = 0;
+	size_t data_to_rd_size;
+	int rc;
+
+	if (feat_out_size < feat_out_min_size) {
+		dev_err(cxlds->dev,
+			"%s: feature out buffer size(%lu) is not big enough\n",
+			__func__, feat_out_size);
+		return 0;
+	}
+
+	pi.uuid = feat_uuid;
+	pi.selection = selection;
+	do {
+		if ((feat_out_min_size - data_rcvd_size) <= mds->payload_size)
+			data_to_rd_size = feat_out_min_size - data_rcvd_size;
+		else
+			data_to_rd_size = mds->payload_size;
+
+		pi.offset = cpu_to_le16(data_rcvd_size);
+		pi.count = cpu_to_le16(data_to_rd_size);
+
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_GET_FEATURE,
+			.size_in = sizeof(pi),
+			.payload_in = &pi,
+			.size_out = data_to_rd_size,
+			.payload_out = feat_out + data_rcvd_size,
+			.min_out = data_to_rd_size,
+		};
+		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		if (rc < 0 || mbox_cmd.size_out == 0)
+			return 0;
+		data_rcvd_size += mbox_cmd.size_out;
+	} while (data_rcvd_size < feat_out_min_size);
+
+	return data_rcvd_size;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
+
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index dd66523cd96a..bcfefff062a6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -530,6 +530,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
+	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -753,6 +754,25 @@ struct cxl_mbox_get_supp_feats_out {
 	struct cxl_mbox_supp_feat_entry feat_entries[];
 } __packed;
 
+/* Get Feature CXL 3.1 Spec 8.2.9.6.2 */
+/*
+ * Get Feature input payload
+ * CXL rev 3.1 section 8.2.9.6.2 Table 8-99
+ */
+enum cxl_get_feat_selection {
+	CXL_GET_FEAT_SEL_CURRENT_VALUE,
+	CXL_GET_FEAT_SEL_DEFAULT_VALUE,
+	CXL_GET_FEAT_SEL_SAVED_VALUE,
+	CXL_GET_FEAT_SEL_MAX
+};
+
+struct cxl_mbox_get_feat_in {
+	uuid_t uuid;
+	__le16 offset;
+	__le16 count;
+	u8 selection;
+}  __packed;
+
 /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
 struct cxl_mbox_poison_in {
 	__le64 offset;
@@ -887,6 +907,11 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_get_supported_features(struct cxl_memdev_state *mds,
 			       u32 count, u16 start_index,
 			       struct cxl_mbox_get_supp_feats_out *feats_out);
+size_t cxl_get_feature(struct cxl_memdev_state *mds,
+		       const uuid_t feat_uuid, void *feat_out,
+		       size_t feat_out_size,
+		       size_t feat_out_min_size,
+		       enum cxl_get_feat_selection selection);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
-- 
2.34.1


