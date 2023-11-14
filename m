Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE8C7EB065
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjKNM50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbjKNM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:57:14 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3FC19D;
        Tue, 14 Nov 2023 04:57:09 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SV5rW06Qtz6K9Kw;
        Tue, 14 Nov 2023 20:55:54 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 12:57:06 +0000
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
Subject: [RFC PATCH 5/6] cxl/memscrub: Add CXL device DDR5 ECS control feature
Date:   Tue, 14 Nov 2023 20:56:46 +0800
Message-ID: <20231114125648.1146-6-shiju.jose@huawei.com>
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

CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
control feature.

The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
Specification (JESD79-5) and allows the DRAM to internally read, correct
single-bit errors, and write back corrected data bits to the DRAM array
while providing transparency to error counts. The ECS control feature
allows the request to configure ECS input configurations during system
boot or at run-time.

The ECS control allows the requester to change the log entry type, the ECS
threshold count provided that the request is within the definition
specified in DDR5 mode registers, change mode between codeword mode and
row count mode, and reset the ECS counter.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/memscrub.c | 557 +++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxlmem.h        |   2 +
 drivers/cxl/pci.c           |   2 +
 3 files changed, 559 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
index ec67ffc81363..1c7031166ba0 100644
--- a/drivers/cxl/core/memscrub.c
+++ b/drivers/cxl/core/memscrub.c
@@ -5,9 +5,9 @@
  * Copyright (c) 2023 HiSilicon Limited.
  *
  *  - Provides functions to configure patrol scrub
- *    feature of the CXL memory devices.
+ *    and DDR5 ECS features of the CXL memory devices.
  *  - Registers with the scrub driver for the
- *    memory patrol scrub feature.
+ *    memory patrol scrub and DDR5 ECS features.
  */
 
 #define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
@@ -453,3 +453,556 @@ int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
+
+/* CXL DDR5 ECS control definitions */
+#define CXL_MEMDEV_ECS_GET_FEAT_VERSION	0x01
+#define CXL_MEMDEV_ECS_SET_FEAT_VERSION	0x01
+
+#define CXL_DDR5_ECS	"cxl_ecs"
+
+/* The default number of regions for CXL memory device patrol scrubber */
+#define CXL_MEMDEV_ECS_NUM_REGIONS	1
+
+static const uuid_t cxl_ecs_uuid =
+	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,     \
+		  0x89, 0x33, 0x86);
+
+/* CXL DDR5 ECS control functions */
+struct cxl_ecs_context {
+	struct device *dev;
+	u16 nregions;
+	u16 get_feat_size;
+	u16 set_feat_size;
+};
+
+/**
+ * struct cxl_memdev_ecs_params - CXL memory DDR5 ECS parameter data structure.
+ * @log_entry_type: ECS log entry type, per DRAM or per memory media FRU.
+ * @threshold: ECS threshold count per GB of memory cells.
+ * @mode:	codeword/row count mode
+ *		0 : ECS counts rows with errors
+ *		1 : ECS counts codeword with errors
+ * @reset_counter: [IN] reset ECC counter to default value.
+ * @log_entry_type_avail: Supported ECS log entry types.
+ * @threshold_avail: Supported ECS threshold counts.
+ * @mode_avail: Supported ECS count mode.
+ */
+struct cxl_memdev_ecs_params {
+	u8 log_entry_type;
+	u16 threshold;
+	u8 mode;
+	bool reset_counter;
+	char log_entry_type_avail[CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH];
+	char threshold_avail[CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH];
+	char mode_avail[CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH];
+};
+
+enum {
+	CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE = 0,
+	CXL_MEMDEV_ECS_PARAM_THRESHOLD,
+	CXL_MEMDEV_ECS_PARAM_MODE,
+	CXL_MEMDEV_ECS_PARAM_RESET_COUNTER,
+};
+
+#define	CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK	GENMASK(1, 0)
+#define	CXL_MEMDEV_ECS_REALTIME_REPORT_CAP_MASK	BIT(0)
+#define	CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK	GENMASK(2, 0)
+#define	CXL_MEMDEV_ECS_MODE_MASK	BIT(3)
+#define	CXL_MEMDEV_ECS_RESET_COUNTER_MASK	BIT(4)
+
+static const u16 ecs_supp_threshold[] = { 0, 0, 0, 256, 1024, 4096 };
+
+enum {
+	ECS_LOG_ENTRY_TYPE_DRAM = 0x0,
+	ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU = 0x1,
+};
+
+enum {
+	ECS_THRESHOLD_256 = 3,
+	ECS_THRESHOLD_1024 = 4,
+	ECS_THRESHOLD_4096 = 5,
+};
+
+enum {
+	ECS_MODE_COUNTS_ROWS = 0,
+	ECS_MODE_COUNTS_CODEWORDS = 1,
+};
+
+struct cxl_memdev_ecs_feat_read_attrbs {
+	u8 ecs_log_cap;
+	u8 ecs_cap;
+	__le16 ecs_config;
+	u8 ecs_flags;
+}  __packed;
+
+struct cxl_memdev_ecs_set_feat_pi {
+	struct cxl_mbox_set_feat_in pi;
+	struct cxl_memdev_ecs_feat_wr_attrbs {
+		u8 ecs_log_cap;
+		__le16 ecs_config;
+	} __packed wr_attrbs[];
+}  __packed;
+
+static int cxl_mem_ecs_get_attrbs(struct device *dev, int fru_id,
+				  struct cxl_memdev_ecs_params *params)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev->parent);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_mbox_get_feat_in pi = {
+		.uuid = cxl_ecs_uuid,
+		.offset = 0,
+		.selection = CXL_GET_FEAT_CURRENT_VALUE,
+	};
+	struct cxl_memdev_ecs_feat_read_attrbs *rd_attrbs;
+	struct cxl_ecs_context *cxl_ecs_ctx;
+	u8 threshold_index;
+
+	if (!mds)
+		return -EFAULT;
+	cxl_ecs_ctx = dev_get_drvdata(dev);
+
+	pi.count = cxl_ecs_ctx->get_feat_size;
+	rd_attrbs = cxl_get_feature(mds, &pi);
+	if (PTR_ERR_OR_ZERO(rd_attrbs)) {
+		params->log_entry_type = 0;
+		params->threshold = 0;
+		params->mode = 0;
+		snprintf(params->log_entry_type_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
+			 "Unavailable");
+		snprintf(params->threshold_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
+			 "Unavailable");
+		snprintf(params->mode_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
+			 "Unavailable");
+		return PTR_ERR_OR_ZERO(rd_attrbs);
+	}
+	params->log_entry_type = FIELD_GET(CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK,
+					   rd_attrbs[fru_id].ecs_log_cap);
+	threshold_index = FIELD_GET(CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
+				    rd_attrbs[fru_id].ecs_config);
+	params->threshold = ecs_supp_threshold[threshold_index];
+	params->mode = FIELD_GET(CXL_MEMDEV_ECS_MODE_MASK,
+				 rd_attrbs[fru_id].ecs_config);
+	snprintf(params->log_entry_type_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
+		 "Log Entry Type 0:per DRAM  1:per Memory Media FRU");
+	snprintf(params->threshold_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
+		 "Threshold count per Gb of memory cells: 256,1024,4096");
+	snprintf(params->mode_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
+		 "Mode 0:ECS counts rows with errors  1:ECS counts codewords with errors");
+
+	kvfree(rd_attrbs);
+
+	return 0;
+}
+
+static int cxl_mem_ecs_set_attrbs(struct device *dev, int fru_id,
+				  struct cxl_memdev_ecs_params *params, u8 param_type)
+{
+	int ret = 0;
+	u32 set_pi_size;
+	u16 nmedia_frus, count;
+	struct cxl_memdev_ecs_set_feat_pi *set_pi;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev->parent);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_mbox_get_feat_in pi = {
+		.uuid = cxl_ecs_uuid,
+		.offset = 0,
+		.selection = CXL_GET_FEAT_CURRENT_VALUE,
+	};
+	struct cxl_memdev_ecs_feat_read_attrbs *rd_attrbs;
+	struct cxl_memdev_ecs_feat_wr_attrbs *wr_attrbs;
+	struct cxl_ecs_context *cxl_ecs_ctx;
+	struct cxl_memdev_ecs_params rd_params;
+
+	if (!mds)
+		return -EFAULT;
+
+	cxl_ecs_ctx = dev_get_drvdata(dev);
+	nmedia_frus = cxl_ecs_ctx->nregions;
+
+	pi.count = cxl_ecs_ctx->get_feat_size;
+	rd_attrbs = cxl_get_feature(mds, &pi);
+	if (PTR_ERR_OR_ZERO(rd_attrbs))
+		return PTR_ERR_OR_ZERO(rd_attrbs);
+	set_pi_size = sizeof(struct cxl_mbox_set_feat_in) +
+				cxl_ecs_ctx->set_feat_size;
+	set_pi = kvmalloc(set_pi_size, GFP_KERNEL);
+	if (!set_pi) {
+		kvfree(rd_attrbs);
+		return -ENOMEM;
+	}
+
+	set_pi->pi.uuid = cxl_ecs_uuid;
+	set_pi->pi.flags = CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET |
+				CXL_SET_FEAT_FLAG_ACTION_FULL_DATA_TRANSFER;
+	set_pi->pi.offset = 0;
+	set_pi->pi.version = CXL_MEMDEV_ECS_SET_FEAT_VERSION;
+	/* Fill writable attributes from the current attributes read for all the media FRUs */
+	count = 0;
+	wr_attrbs = set_pi->wr_attrbs;
+	while (count < nmedia_frus) {
+		wr_attrbs[count].ecs_log_cap = rd_attrbs[count].ecs_log_cap;
+		wr_attrbs[count].ecs_config = rd_attrbs[count].ecs_config;
+		count++;
+	}
+	kvfree(rd_attrbs);
+
+	/* Fill attribute to be set for the media FRU */
+	if (param_type == CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE) {
+		if (params->log_entry_type != ECS_LOG_ENTRY_TYPE_DRAM &&
+		    params->log_entry_type != ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU) {
+			dev_err(dev->parent,
+				"Invalid CXL ECS scrub log entry type(%d) to set\n",
+			       params->log_entry_type);
+			dev_err(dev->parent,
+				"Log Entry Type 0: per DRAM  1: per Memory Media FRU\n");
+			ret = -EINVAL;
+			goto set_attrbs_exit;
+		}
+		wr_attrbs[fru_id].ecs_log_cap = FIELD_PREP(CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK,
+							   params->log_entry_type);
+	} else if (param_type == CXL_MEMDEV_ECS_PARAM_THRESHOLD) {
+		wr_attrbs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK;
+		switch (params->threshold) {
+		case 256:
+			wr_attrbs[fru_id].ecs_config |= FIELD_PREP(
+						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
+						ECS_THRESHOLD_256);
+			break;
+		case 1024:
+			wr_attrbs[fru_id].ecs_config |= FIELD_PREP(
+						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
+						ECS_THRESHOLD_1024);
+			break;
+		case 4096:
+			wr_attrbs[fru_id].ecs_config |= FIELD_PREP(
+						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
+						ECS_THRESHOLD_4096);
+			break;
+		default:
+			dev_err(dev->parent,
+				"Invalid CXL ECS scrub threashol count(%d) to set\n",
+				params->threshold);
+			dev_err(dev->parent,
+				"Threshold count per Gb pf memory cells: 256,1024,4096\n");
+			ret = -EINVAL;
+			goto set_attrbs_exit;
+		}
+	} else if (param_type == CXL_MEMDEV_ECS_PARAM_MODE) {
+		if (params->mode != ECS_MODE_COUNTS_ROWS &&
+		    params->mode != ECS_MODE_COUNTS_CODEWORDS) {
+			dev_err(dev->parent,
+				"Invalid CXL ECS scrub mode(%d) to set\n",
+				params->mode);
+			dev_err(dev->parent,
+				"Mode 0: ECS counts rows with errors"
+				" 1: ECS counts codewords with errors\n");
+			ret = -EINVAL;
+			goto set_attrbs_exit;
+		}
+		wr_attrbs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_MODE_MASK;
+		wr_attrbs[fru_id].ecs_config |= FIELD_PREP(CXL_MEMDEV_ECS_MODE_MASK,
+							  params->mode);
+	} else if (param_type == CXL_MEMDEV_ECS_PARAM_RESET_COUNTER) {
+		wr_attrbs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_RESET_COUNTER_MASK;
+		wr_attrbs[fru_id].ecs_config |= FIELD_PREP(CXL_MEMDEV_ECS_RESET_COUNTER_MASK,
+							   params->reset_counter);
+	} else {
+		dev_err(dev->parent, "Invalid CXL ECS parameter to set\n");
+		ret = -EINVAL;
+		goto set_attrbs_exit;
+	}
+
+	ret = cxl_set_feature(mds, set_pi, set_pi_size);
+	if (ret) {
+		dev_err(dev->parent, "CXL ECS set feature fail ret=%d\n", ret);
+		goto set_attrbs_exit;
+	}
+
+	/* Verify attribute is set successfully */
+	ret = cxl_mem_ecs_get_attrbs(dev, fru_id, &rd_params);
+	if (ret) {
+		dev_err(dev->parent, "Get cxlmemdev ECS params fail ret=%d\n", ret);
+		return ret;
+	}
+	switch (param_type) {
+	case CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE:
+		if (rd_params.log_entry_type != params->log_entry_type)
+			return -EFAULT;
+		break;
+	case CXL_MEMDEV_ECS_PARAM_THRESHOLD:
+		if (rd_params.threshold != params->threshold)
+			return -EFAULT;
+		break;
+	case CXL_MEMDEV_ECS_PARAM_MODE:
+		if (rd_params.mode != params->mode)
+			return -EFAULT;
+		break;
+	}
+
+set_attrbs_exit:
+	kvfree(set_pi);
+	return ret;
+}
+
+static int cxl_mem_ecs_log_entry_type_write(struct device *dev, int region_id, long val)
+{
+	int ret;
+	struct cxl_memdev_ecs_params params;
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
+	int ret;
+	struct cxl_memdev_ecs_params params;
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
+	int ret;
+	struct cxl_memdev_ecs_params params;
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
+	int ret;
+	struct cxl_memdev_ecs_params params;
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
+	int ret;
+	struct cxl_memdev_ecs_params params;
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
+		return 0;
+	case scrub_ecs_log_entry_type_per_dram:
+		if (params.log_entry_type == ECS_LOG_ENTRY_TYPE_DRAM)
+			*val = 1;
+		else
+			*val = 0;
+		return 0;
+	case scrub_ecs_log_entry_type_per_memory_media:
+		if (params.log_entry_type == ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU)
+			*val = 1;
+		else
+			*val = 0;
+		return 0;
+	case scrub_mode:
+		*val = params.mode;
+		return 0;
+	case scrub_mode_counts_rows:
+		if (params.mode == ECS_MODE_COUNTS_ROWS)
+			*val = 1;
+		else
+			*val = 0;
+		return 0;
+	case scrub_mode_counts_codewords:
+		if (params.mode == ECS_MODE_COUNTS_CODEWORDS)
+			*val = 1;
+		else
+			*val = 0;
+		return 0;
+	case scrub_threshold:
+		*val = params.threshold;
+		return 0;
+	default:
+		return -ENOTSUPP;
+	}
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
+		sprintf(buf, "256,1024,4096\n");
+		return 0;
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
+int cxl_mem_ddr5_ecs_init(struct cxl_memdev *cxlmd)
+{
+	int nmedia_frus; /* number of memory media FRUs in the device */
+	int ret = 0;
+	struct device *cxl_scrub_dev;
+	char scrub_name[CXL_MEMDEV_MAX_NAME_LENGTH];
+	struct cxl_mbox_supp_feat_entry feat_entry;
+	struct cxl_ecs_context *cxl_ecs_ctx;
+
+	ret = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_ecs_uuid, &feat_entry);
+	if (ret < 0)
+		goto cxl_ecs_reg_fail;
+
+	if (!(feat_entry.attrb_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
+		goto cxl_ecs_init_exit;
+	nmedia_frus = feat_entry.get_feat_size/
+				sizeof(struct cxl_memdev_ecs_feat_read_attrbs);
+	if (nmedia_frus) {
+		cxl_ecs_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx), GFP_KERNEL);
+		if (!cxl_ecs_ctx)
+			goto cxl_ecs_init_exit;
+
+		cxl_ecs_ctx->nregions = nmedia_frus;
+		cxl_ecs_ctx->get_feat_size = feat_entry.get_feat_size;
+		cxl_ecs_ctx->set_feat_size = feat_entry.set_feat_size;
+
+		snprintf(scrub_name, sizeof(scrub_name), "%s_%s",
+			 CXL_DDR5_ECS, dev_name(&cxlmd->dev));
+		cxl_scrub_dev = devm_scrub_device_register(&cxlmd->dev, scrub_name,
+							  cxl_ecs_ctx, &cxl_ecs_ops,
+							  cxl_ecs_ctx->nregions);
+		if (PTR_ERR_OR_ZERO(cxl_scrub_dev)) {
+			ret = PTR_ERR_OR_ZERO(cxl_scrub_dev);
+			goto cxl_ecs_reg_fail;
+		}
+	}
+
+cxl_ecs_reg_fail:
+cxl_ecs_init_exit:
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_ddr5_ecs_init, CXL);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 1d0fad0dc5ae..4da0b0ec3b1e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -972,8 +972,10 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 /* cxl memory scrub functions */
 #ifdef CONFIG_CXL_SCRUB
 int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd);
+int cxl_mem_ddr5_ecs_init(struct cxl_memdev *cxlmd);
 #else
 int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd) { return -ENOTSUP; }
+int cxl_mem_ddr5_ecs_init(struct cxl_memdev *cxlmd) { return -ENOTSUP; }
 #endif
 
 #ifdef CONFIG_CXL_SUSPEND
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 86bba8794bb4..75ce4f41c5c0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -886,6 +886,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 */
 	if (cxl_mem_patrol_scrub_init(cxlmd))
 		dev_dbg(&pdev->dev, "cxl_mem_patrol_scrub_init failed\n");
+	if (cxl_mem_ddr5_ecs_init(cxlmd))
+		dev_dbg(&pdev->dev, "cxl_mem_ddr5_ecs_init failed\n");
 
 	rc = devm_cxl_sanitize_setup_notifier(&pdev->dev, cxlmd);
 	if (rc)
-- 
2.34.1

