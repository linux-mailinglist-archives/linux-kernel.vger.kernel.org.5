Return-Path: <linux-kernel+bounces-66756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2965485612E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F76282E44
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65F12BE86;
	Thu, 15 Feb 2024 11:15:12 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32217127B62;
	Thu, 15 Feb 2024 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995712; cv=none; b=ggElO6Imjfl+8vBfgmBOL8wEnDE1ciR0eJ8pSz+04rl36xFs6Eak0G7GqIGBr7wBY6lYFVZOBVxFL3ETyPsf1Bk7rNuNecw8aP+AqvmrD8lnJhTWlyITWiOwFD5oVxrU8KnGem3hlPlgBLOXew771mITULW0LDm/KPrWCmOprws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995712; c=relaxed/simple;
	bh=eNnY42J9aUqQwOcptqM3vzEXq5MytzSfG8IsDJyu2X8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nU9JW0kwYx5F6XyAgScFyr9IAVgy2pxJ3ZBw8bl8LSG/QZyfQIwZnujQIK+1gg6nvKSlEG75zrkGyxeobSSRr6WQBoS9mfARNfepuVgex/saKCPtaP2KdHPNGS7Bof44WWSg2ipijWgGK167IT0+tiuJgzbbsoB45B9C/G+3NX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbC6d1wZSz6J9xX;
	Thu, 15 Feb 2024 19:11:05 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E39D140B55;
	Thu, 15 Feb 2024 19:15:07 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:15:06 +0000
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
Subject: [RFC PATCH v6 03/12] cxl/mbox: Add SET_FEATURE mailbox command
Date: Thu, 15 Feb 2024 19:14:45 +0800
Message-ID: <20240215111455.1462-4-shiju.jose@huawei.com>
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

Add support for SET_FEATURE mailbox command.

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
CXL devices supports features with changeable attributes.
The settings of a feature can be optionally modified using Set Feature
command.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c | 14 ++++++++++++++
 drivers/cxl/cxlmem.h    | 27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f43189b6859a..056576862b8a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1335,6 +1335,20 @@ int cxl_get_feature(struct cxl_memdev_state *mds,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
 
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
index eaecc3234cfd..2223ef3d3140 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -531,6 +531,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
+	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -778,6 +779,31 @@ struct cxl_mbox_get_feat_in {
 	u8 selection;
 }  __packed;
 
+/* Set Feature CXL 3.1 Spec 8.2.9.6.3 */
+/*
+ * Set Feature input payload
+ * CXL rev 3.1 section 8.2.9.6.3 Table 8-101
+ */
+/* Set Feature : Payload in flags */
+#define CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK	GENMASK(2, 0)
+enum cxl_set_feat_flag_data_transfer {
+	CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_ABORT_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_DATA_TRANSFER_MAX
+};
+#define CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET	BIT(3)
+
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
@@ -914,6 +940,7 @@ int cxl_get_supported_features(struct cxl_memdev_state *mds,
 			       void *feats_out);
 int cxl_get_feature(struct cxl_memdev_state *mds,
 		    struct cxl_mbox_get_feat_in *pi, void *feat_out);
+int cxl_set_feature(struct cxl_memdev_state *mds, void *feat_in, size_t size);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
-- 
2.34.1


