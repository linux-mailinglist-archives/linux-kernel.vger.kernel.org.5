Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05A87F65AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345806AbjKWRoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjKWRoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:44:01 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81CA10C6;
        Thu, 23 Nov 2023 09:44:07 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sblpp0g6cz6J9yw;
        Fri, 24 Nov 2023 01:44:02 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 Nov 2023 17:44:04 +0000
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
Subject: [PATCH v3 02/11] cxl/mbox: Add GET_FEATURE mailbox command
Date:   Fri, 24 Nov 2023 01:43:45 +0800
Message-ID: <20231123174355.1176-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231123174355.1176-1-shiju.jose@huawei.com>
References: <20231123174355.1176-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

Add support for GET_FEATURE mailbox command.

CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
The settings of a feature can be retrieved using Get Feature command.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c | 22 ++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 23 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index eb2741446b5f..759b7e7e6a09 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1326,6 +1326,28 @@ int cxl_get_supported_features(struct cxl_memdev_state *mds,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
 
+int cxl_get_feature(struct cxl_memdev_state *mds,
+		    struct cxl_mbox_get_feat_in *pi, void *feat_out)
+{
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_FEATURE,
+		.size_in = sizeof(*pi),
+		.payload_in = pi,
+		.size_out = (size_t)pi->count,
+		.payload_out = feat_out,
+		.min_out = (size_t)pi->count,
+	};
+	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
+
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index d831dad748f5..92c1f2a44713 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -507,6 +507,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
+	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -796,6 +797,26 @@ struct cxl_mbox_get_supp_feats_out {
 	struct cxl_mbox_supp_feat_entry feat_entries[];
 } __packed;
 
+/* Get Feature CXL 3.0 Spec 8.2.9.6.2 */
+/*
+ * Get Feature input payload
+ * CXL rev 3.0 section 8.2.9.6.2; Table 8-79
+ */
+/* Get Feature : Payload in selection */
+enum cxl_get_feat_selection {
+	CXL_GET_FEAT_SEL_CURRENT_VALUE = 0x0,
+	CXL_GET_FEAT_SEL_DEFAULT_VALUE = 0x1,
+	CXL_GET_FEAT_SEL_SAVED_VALUE = 0x2,
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
@@ -926,6 +947,8 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_get_supported_features(struct cxl_memdev_state *mds,
 			       struct cxl_mbox_get_supp_feats_in *pi,
 			       void *feats_out);
+int cxl_get_feature(struct cxl_memdev_state *mds,
+		    struct cxl_mbox_get_feat_in *pi, void *feat_out);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
-- 
2.34.1

