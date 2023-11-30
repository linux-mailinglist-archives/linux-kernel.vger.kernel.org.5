Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A107FFB33
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376365AbjK3TXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376409AbjK3TXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:23:31 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAD710FA;
        Thu, 30 Nov 2023 11:23:36 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sh5fY6CBtz6DBCT;
        Fri,  1 Dec 2023 03:21:57 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
        by mail.maildlp.com (Postfix) with ESMTPS id A61A61402CD;
        Fri,  1 Dec 2023 03:23:34 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 19:23:33 +0000
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
Subject: [PATCH v4 09/11] cxl/memscrub: Register CXL device DDR5 ECS with scrub configure driver
Date:   Fri, 1 Dec 2023 03:23:11 +0800
Message-ID: <20231130192314.1220-10-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231130192314.1220-1-shiju.jose@huawei.com>
References: <20231130192314.1220-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Register with the scrub configure driver to expose the sysfs attributes
to the user for configuring the CXL memory device's ECS feature. Add
the callback functions to support configuring the CXL memory device ECS.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/memscrub.c | 239 +++++++++++++++++++++++++++++++++++-
 1 file changed, 236 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
index 4d778ffa3322..f1273615bbdd 100644
--- a/drivers/cxl/core/memscrub.c
+++ b/drivers/cxl/core/memscrub.c
@@ -473,6 +473,11 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
 #define CXL_MEMDEV_ECS_GET_FEAT_VERSION	0x01
 #define CXL_MEMDEV_ECS_SET_FEAT_VERSION	0x01
 
+#define CXL_DDR5_ECS	"cxl_ecs"
+
+/* The default number of regions for CXL memory device ECS */
+#define CXL_MEMDEV_ECS_NUM_REGIONS	1
+
 static const uuid_t cxl_ecs_uuid =
 	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,     \
 		  0x89, 0x33, 0x86);
@@ -590,9 +595,8 @@ static int cxl_mem_ecs_get_attrbs(struct device *dev, int fru_id,
 	return 0;
 }
 
-static int __maybe_unused
-cxl_mem_ecs_set_attrbs(struct device *dev, int fru_id,
-		       struct cxl_memdev_ecs_params *params, u8 param_type)
+static int cxl_mem_ecs_set_attrbs(struct device *dev, int fru_id,
+				  struct cxl_memdev_ecs_params *params, u8 param_type)
 {
 	struct cxl_memdev_ecs_feat_read_attrbs *rd_attrbs __free(kvfree) = NULL;
 	struct cxl_memdev_ecs_set_feat_pi *set_pi __free(kvfree) = NULL;
@@ -739,10 +743,231 @@ cxl_mem_ecs_set_attrbs(struct device *dev, int fru_id,
 	return 0;
 }
 
+static int cxl_mem_ecs_log_entry_type_write(struct device *dev, int region_id, long val)
+{
+	struct cxl_memdev_ecs_params params;
+	int ret;
+
+	params.log_entry_type = val;
+	ret = cxl_mem_ecs_set_attrbs(dev, region_id, &params,
+				     CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE);
+	if (ret) {
+		dev_err(dev->parent, "Set CXL ECS params for log entry type fail ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_ecs_threshold_write(struct device *dev, int region_id, long val)
+{
+	struct cxl_memdev_ecs_params params;
+	int ret;
+
+	params.threshold = val;
+	ret = cxl_mem_ecs_set_attrbs(dev, region_id, &params,
+				     CXL_MEMDEV_ECS_PARAM_THRESHOLD);
+	if (ret) {
+		dev_err(dev->parent, "Set CXL ECS params for threshold fail ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_ecs_mode_write(struct device *dev, int region_id, long val)
+{
+	struct cxl_memdev_ecs_params params;
+	int ret;
+
+	params.mode = val;
+	ret = cxl_mem_ecs_set_attrbs(dev, region_id, &params,
+				     CXL_MEMDEV_ECS_PARAM_MODE);
+	if (ret) {
+		dev_err(dev->parent, "Set CXL ECS params for mode fail ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_ecs_reset_counter_write(struct device *dev, int region_id, long val)
+{
+	struct cxl_memdev_ecs_params params;
+	int ret;
+
+	params.reset_counter = val;
+	ret = cxl_mem_ecs_set_attrbs(dev, region_id, &params,
+				     CXL_MEMDEV_ECS_PARAM_RESET_COUNTER);
+	if (ret) {
+		dev_err(dev->parent, "Set CXL ECS params for reset ECC counter fail ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * cxl_mem_ecs_is_visible() - Callback to return attribute visibility
+ * @drv_data: Pointer to driver-private data structure passed
+ *	      as argument to devm_scrub_device_register().
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+static umode_t cxl_mem_ecs_is_visible(const void *drv_data, u32 attr, int region_id)
+{
+	switch (attr) {
+	case scrub_reset_counter:
+		return 0200;
+	case scrub_ecs_log_entry_type_per_dram:
+	case scrub_ecs_log_entry_type_per_memory_media:
+	case scrub_mode_counts_rows:
+	case scrub_mode_counts_codewords:
+	case scrub_threshold_available:
+		return 0444;
+	case scrub_ecs_log_entry_type:
+	case scrub_mode:
+	case scrub_threshold:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+/**
+ * cxl_mem_ecs_read() - Read callback for data attributes
+ * @dev: Pointer to scrub device
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ * @val: Pointer to the returned data
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+static int cxl_mem_ecs_read(struct device *dev, u32 attr, int region_id, u64 *val)
+{
+	struct cxl_memdev_ecs_params params;
+	int ret;
+
+	if (attr == scrub_ecs_log_entry_type ||
+	    attr == scrub_ecs_log_entry_type_per_dram ||
+	    attr == scrub_ecs_log_entry_type_per_memory_media ||
+	    attr == scrub_mode ||
+	    attr == scrub_mode_counts_rows ||
+	    attr == scrub_mode_counts_codewords ||
+	    attr == scrub_threshold) {
+		ret = cxl_mem_ecs_get_attrbs(dev, region_id, &params);
+		if (ret) {
+			dev_err(dev->parent, "Get CXL ECS params fail ret=%d\n", ret);
+			return ret;
+		}
+	}
+
+	switch (attr) {
+	case scrub_ecs_log_entry_type:
+		*val = params.log_entry_type;
+		break;
+	case scrub_ecs_log_entry_type_per_dram:
+		if (params.log_entry_type == ECS_LOG_ENTRY_TYPE_DRAM)
+			*val = 1;
+		else
+			*val = 0;
+		break;
+	case scrub_ecs_log_entry_type_per_memory_media:
+		if (params.log_entry_type == ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU)
+			*val = 1;
+		else
+			*val = 0;
+		break;
+	case scrub_mode:
+		*val = params.mode;
+		break;
+	case scrub_mode_counts_rows:
+		if (params.mode == ECS_MODE_COUNTS_ROWS)
+			*val = 1;
+		else
+			*val = 0;
+		break;
+	case scrub_mode_counts_codewords:
+		if (params.mode == ECS_MODE_COUNTS_CODEWORDS)
+			*val = 1;
+		else
+			*val = 0;
+		break;
+	case scrub_threshold:
+		*val = params.threshold;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
+/**
+ * cxl_mem_ecs_write() - Write callback for data attributes
+ * @dev: Pointer to scrub device
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ * @val: Value to write
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+static int cxl_mem_ecs_write(struct device *dev, u32 attr, int region_id, u64 val)
+{
+	switch (attr) {
+	case scrub_ecs_log_entry_type:
+		return cxl_mem_ecs_log_entry_type_write(dev, region_id, val);
+	case scrub_mode:
+		return cxl_mem_ecs_mode_write(dev, region_id, val);
+	case scrub_reset_counter:
+		return cxl_mem_ecs_reset_counter_write(dev, region_id, val);
+	case scrub_threshold:
+		return cxl_mem_ecs_threshold_write(dev, region_id, val);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+/**
+ * cxl_mem_ecs_read_strings() - Read callback for DDR5 ECS string attributes
+ * @dev: Pointer to ECS scrub device
+ * @attr: ECS scrub attribute
+ * @region_id: ID of the memory media FRU.
+ * @buf: Pointer to the buffer for copying returned string
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+static int cxl_mem_ecs_read_strings(struct device *dev, u32 attr,
+				    int region_id, char *buf)
+{
+
+	switch (attr) {
+	case scrub_threshold_available:
+		return sysfs_emit(buf, "256,1024,4096\n");
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static const struct scrub_ops cxl_ecs_ops = {
+	.is_visible = cxl_mem_ecs_is_visible,
+	.read = cxl_mem_ecs_read,
+	.write = cxl_mem_ecs_write,
+	.read_string = cxl_mem_ecs_read_strings,
+};
+
 int cxl_mem_ddr5_ecs_init(struct cxl_memdev *cxlmd)
 {
+	char scrub_name[CXL_MEMDEV_MAX_NAME_LENGTH];
 	struct cxl_mbox_supp_feat_entry feat_entry;
 	struct cxl_ecs_context *cxl_ecs_ctx;
+	struct device *cxl_scrub_dev;
 	int nmedia_frus;
 	int ret;
 
@@ -762,6 +987,14 @@ int cxl_mem_ddr5_ecs_init(struct cxl_memdev *cxlmd)
 		cxl_ecs_ctx->nregions = nmedia_frus;
 		cxl_ecs_ctx->get_feat_size = feat_entry.get_feat_size;
 		cxl_ecs_ctx->set_feat_size = feat_entry.set_feat_size;
+
+		snprintf(scrub_name, sizeof(scrub_name), "%s_%s",
+			 CXL_DDR5_ECS, dev_name(&cxlmd->dev));
+		cxl_scrub_dev = devm_scrub_device_register(&cxlmd->dev, scrub_name,
+							  cxl_ecs_ctx, &cxl_ecs_ops,
+							  cxl_ecs_ctx->nregions);
+		if (IS_ERR(cxl_scrub_dev))
+			return PTR_ERR(cxl_scrub_dev);
 	}
 
 	return 0;
-- 
2.34.1

