Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4217EB060
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjKNM5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjKNM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:57:11 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3C7197;
        Tue, 14 Nov 2023 04:57:06 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SV5mX19Ndz6JB1R;
        Tue, 14 Nov 2023 20:52:28 +0800 (CST)
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
Subject: [RFC PATCH 2/6] cxl/memscrub: Add CXL device patrol scrub control feature
Date:   Tue, 14 Nov 2023 20:56:43 +0800
Message-ID: <20231114125648.1146-3-shiju.jose@huawei.com>
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

CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
feature. The device patrol scrub proactively locates and makes corrections
to errors in regular cycle. The patrol scrub control allows the request to
configure patrol scrub input configurations.

The patrol scrub control allows the requester to specify the number of
hours for which the patrol scrub cycles must be completed, provided that
the requested number is not less than the minimum number of hours for the
patrol scrub cycle that the device is capable of. In addition, the patrol
scrub controls allow the host to disable and enable the feature in case
disabling of the feature is needed for other purposes such as
performance-aware operations which require the background operations to be
turned off.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/Kconfig         |  23 ++
 drivers/cxl/core/Makefile   |   1 +
 drivers/cxl/core/memscrub.c | 455 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h        |   7 +
 drivers/cxl/pci.c           |   6 +
 5 files changed, 492 insertions(+)
 create mode 100644 drivers/cxl/core/memscrub.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 8ea1d340e438..45ee6d57d899 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -154,4 +154,27 @@ config CXL_PMU
 	  monitoring units and provide standard perf based interfaces.
 
 	  If unsure say 'm'.
+
+config CXL_SCRUB
+	tristate "CXL: Memory scrub feature"
+	depends on CXL_PCI
+	depends on CXL_MEM
+	depends on SCRUB
+	help
+	  The CXL memory scrub control is an optional feature allows host to
+	  control the scrub configurations of CXL Type 3 devices, which
+	  support patrol scrub and/or DDR5 ECS(Error Check Scrub).
+
+	  Register with the scrub configure driver to provide sysfs interfaces
+	  for configuring the CXL device memory patrol and DDR5 ECS scrubs.
+	  Provides the interface functions support configuring the CXL memory
+	  device patrol and ECS scrubs.
+
+	  Say 'y/m' to enable the CXL memory scrub driver that will attach to
+	  CXL.mem devices for memory scrub control feature. See sections
+	  8.2.9.9.11.1 and 8.2.9.9.11.2 in the CXL 3.1 specification for a
+	  detailed description of CXL memory scrub control features.
+
+	  If unsure say 'm'.
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 1f66b5d4d935..99e3202f868f 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -15,3 +15,4 @@ cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+cxl_core-$(CONFIG_CXL_SCRUB) += memscrub.o
diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
new file mode 100644
index 000000000000..ec67ffc81363
--- /dev/null
+++ b/drivers/cxl/core/memscrub.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * cxl_memscrub.c - CXL memory scrub driver
+ *
+ * Copyright (c) 2023 HiSilicon Limited.
+ *
+ *  - Provides functions to configure patrol scrub
+ *    feature of the CXL memory devices.
+ *  - Registers with the scrub driver for the
+ *    memory patrol scrub feature.
+ */
+
+#define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
+
+#include <cxlmem.h>
+#include <memory/memory-scrub.h>
+
+/* CXL memory scrub feature common definitions */
+#define CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH	128
+#define CXL_MEMDEV_MAX_NAME_LENGTH	128
+
+static int cxl_mem_get_supported_feature_entry(struct cxl_memdev *cxlmd, const uuid_t *feat_uuid,
+					       struct cxl_mbox_supp_feat_entry *feat_entry_out)
+{
+	int nentries; /* number of supported feature entries in output payload */
+	int feat_index, count;
+	bool is_support_feature = false;
+	struct cxl_mbox_get_supp_feats_in pi;
+	struct cxl_mbox_supp_feat_entry *feat_entry;
+	struct cxl_mbox_get_supp_feats_out *feats_out;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+
+	feat_index = 0;
+	do {
+		pi.count = sizeof(struct cxl_mbox_get_supp_feats_out) +
+				  sizeof(struct cxl_mbox_supp_feat_entry);
+		pi.start_index = feat_index;
+		nentries = 0;
+		feats_out = cxl_get_supported_features(mds, &pi);
+		if (PTR_ERR_OR_ZERO(feats_out))
+			return  PTR_ERR_OR_ZERO(feats_out);
+		nentries = feats_out->entries;
+		if (!nentries) {
+			kvfree(feats_out);
+			break;
+		}
+		/* Check CXL memdev supports the feature */
+		feat_entry = (void *)feats_out->feat_entries;
+		for (count = 0; count < nentries; count++, feat_entry++) {
+			if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
+				is_support_feature = true;
+				memcpy(feat_entry_out, feat_entry, sizeof(*feat_entry_out));
+				break;
+			}
+		}
+		kvfree(feats_out);
+		if (is_support_feature)
+			break;
+		feat_index += nentries;
+	} while (nentries);
+
+	if (!is_support_feature)
+		return -ENOTSUPP;
+
+	return 0;
+}
+
+/* CXL memory patrol scrub control definitions */
+#define CXL_MEMDEV_PS_GET_FEAT_VERSION	0x01
+#define CXL_MEMDEV_PS_SET_FEAT_VERSION	0x01
+
+#define CXL_PATROL_SCRUB	"cxl_patrol_scrub"
+
+/* The default number of regions for CXL memory device patrol scrubber
+ * Patrol scrub is a feature where the device controller scrubs the
+ * memory at a regular interval accroding to the CXL specification.
+ * Hence the number of memory regions to scrub assosiated to the patrol
+ * scrub is 1.
+ */
+#define CXL_MEMDEV_PATROL_SCRUB_NUM_REGIONS	1
+
+static const uuid_t cxl_patrol_scrub_uuid =
+	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,     \
+		  0x06, 0xdb, 0x8a);
+
+/* CXL memory patrol scrub control functions */
+struct cxl_patrol_scrub_context {
+	struct device *dev;
+	u16 get_feat_size;
+	u16 set_feat_size;
+	bool scrub_cycle_changable;
+};
+
+/**
+ * struct cxl_memdev_ps_params - CXL memory patrol scrub parameter data structure.
+ * @enable:     [IN] enable(1)/disable(0) patrol scrub.
+ * @scrub_cycle_changable: [OUT] scrub cycle attribute of patrol scrub is changeable.
+ * @speed:      [IN] Requested patrol scrub cycle in hours.
+ *              [OUT] Current patrol scrub cycle in hours.
+ * @min_speed:[OUT] minimum patrol scrub cycle, in hours, supported.
+ * @speed_avail:[OUT] Supported patrol scrub cycle in hours.
+ */
+struct cxl_memdev_ps_params {
+	bool enable;
+	bool scrub_cycle_changable;
+	u16 speed;
+	u16 min_speed;
+	char speed_avail[CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH];
+};
+
+enum {
+	CXL_MEMDEV_PS_PARAM_ENABLE = 0,
+	CXL_MEMDEV_PS_PARAM_SPEED,
+};
+
+#define	CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK	BIT(0)
+#define	CXL_MEMDEV_PS_SCRUB_CYCLE_REALTIME_REPORT_CAP_MASK	BIT(1)
+#define	CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK	GENMASK(7, 0)
+#define	CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK	GENMASK(15, 8)
+#define	CXL_MEMDEV_PS_FLAG_ENABLED_MASK	BIT(0)
+
+struct cxl_memdev_ps_feat_read_attrbs {
+	u8 scrub_cycle_cap;
+	__le16 scrub_cycle;
+	u8 scrub_flags;
+}  __packed;
+
+struct cxl_memdev_ps_set_feat_pi {
+	struct cxl_mbox_set_feat_in pi;
+	u8 scrub_cycle_hr;
+	u8 scrub_flags;
+}  __packed;
+
+static int cxl_mem_ps_get_attrbs(struct device *dev,
+				 struct cxl_memdev_ps_params *params)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_mbox_get_feat_in pi = {
+		.uuid = cxl_patrol_scrub_uuid,
+		.offset = 0,
+		.count = sizeof(struct cxl_memdev_ps_feat_read_attrbs),
+		.selection = CXL_GET_FEAT_CURRENT_VALUE,
+	};
+	struct cxl_memdev_ps_feat_read_attrbs *rd_attrbs;
+
+	if (!mds)
+		return -EFAULT;
+
+	rd_attrbs = cxl_get_feature(mds, &pi);
+	if (PTR_ERR_OR_ZERO(rd_attrbs)) {
+		params->enable = 0;
+		params->speed = 0;
+		snprintf(params->speed_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
+			"Unavailable");
+		return PTR_ERR_OR_ZERO(rd_attrbs);
+	}
+	params->scrub_cycle_changable = FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,
+						  rd_attrbs->scrub_cycle_cap);
+	params->enable = FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
+				   rd_attrbs->scrub_flags);
+	params->speed = FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
+				  rd_attrbs->scrub_cycle);
+	params->min_speed  = FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,
+				       rd_attrbs->scrub_cycle);
+	snprintf(params->speed_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
+		 "Minimum scrub cycle = %d hour", params->min_speed);
+	kvfree(rd_attrbs);
+
+	return 0;
+}
+
+static int cxl_mem_ps_set_attrbs(struct device *dev,
+				 struct cxl_memdev_ps_params *params, u8 param_type)
+{
+	int ret;
+	struct cxl_memdev_ps_params rd_params;
+	struct cxl_memdev_ps_set_feat_pi set_pi = {
+		.pi.uuid = cxl_patrol_scrub_uuid,
+		.pi.flags = CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET |
+			    CXL_SET_FEAT_FLAG_ACTION_FULL_DATA_TRANSFER,
+		.pi.offset = 0,
+		.pi.version = CXL_MEMDEV_PS_SET_FEAT_VERSION,
+	};
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+
+	if (!mds)
+		return -EFAULT;
+
+	ret = 0;
+	ret = cxl_mem_ps_get_attrbs(dev, &rd_params);
+	if (ret) {
+		dev_err(dev, "Get cxlmemdev patrol scrub params fail ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	if (param_type == CXL_MEMDEV_PS_PARAM_ENABLE) {
+		set_pi.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
+						   params->enable);
+		set_pi.scrub_cycle_hr = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
+						      rd_params.speed);
+	} else if (param_type == CXL_MEMDEV_PS_PARAM_SPEED) {
+		if (params->speed < rd_params.min_speed) {
+			dev_err(dev, "Invalid CXL patrol scrub cycle(%d) to set\n",
+				params->speed);
+			dev_err(dev, "Minimum supported CXL patrol scrub cycle in hour %d\n",
+			       params->min_speed);
+			return -EINVAL;
+		}
+		set_pi.scrub_cycle_hr = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
+						      params->speed);
+		set_pi.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
+						   rd_params.enable);
+	} else {
+		dev_err(dev, "Invalid CXL patrol scrub parameter to set\n");
+		return -EINVAL;
+	}
+
+	ret = 0;
+	ret = cxl_set_feature(mds, &set_pi, sizeof(set_pi));
+	if (ret) {
+		dev_err(dev, "CXL patrol scrub set feature fail ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	/* Verify attribute set successfully */
+	if (param_type == CXL_MEMDEV_PS_PARAM_SPEED) {
+		ret = cxl_mem_ps_get_attrbs(dev, &rd_params);
+		if (ret) {
+			dev_err(dev, "Get cxlmemdev patrol scrub params fail ret=%d\n", ret);
+			return ret;
+		}
+		if (rd_params.speed != params->speed)
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_ps_enable_write(struct device *dev, long val)
+{
+	int ret;
+	struct cxl_memdev_ps_params params;
+
+	params.enable = val;
+	ret = cxl_mem_ps_set_attrbs(dev, &params, CXL_MEMDEV_PS_PARAM_ENABLE);
+	if (ret) {
+		dev_err(dev, "CXL patrol scrub enable fail, enable=%d ret=%d\n",
+		       params.enable, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_ps_speed_read(struct device *dev, u64 *val)
+{
+	int ret;
+	struct cxl_memdev_ps_params params;
+
+	ret = cxl_mem_ps_get_attrbs(dev, &params);
+	if (ret) {
+		dev_err(dev, "Get CXL patrol scrub params fail ret=%d\n",
+			ret);
+		return ret;
+	}
+	*val = params.speed;
+
+	return 0;
+}
+
+static int cxl_mem_ps_speed_write(struct device *dev, long val)
+{
+	int ret;
+	struct cxl_memdev_ps_params params;
+
+	params.speed = val;
+	ret = cxl_mem_ps_set_attrbs(dev, &params, CXL_MEMDEV_PS_PARAM_SPEED);
+	if (ret) {
+		dev_err(dev, "Set CXL patrol scrub params for speed fail ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_ps_speed_available_read(struct device *dev, char *buf)
+{
+	int ret;
+	struct cxl_memdev_ps_params params;
+
+	ret = cxl_mem_ps_get_attrbs(dev, &params);
+	if (ret) {
+		dev_err(dev, "Get CXL patrol scrub params fail ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	sprintf(buf, "%s\n", params.speed_avail);
+
+	return 0;
+}
+
+/**
+ * cxl_mem_patrol_scrub_is_visible() - Callback to return attribute visibility
+ * @drv_data: Pointer to driver-private data structure passed
+ *	      as argument to devm_scrub_device_register().
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+umode_t cxl_mem_patrol_scrub_is_visible(const void *drv_data, u32 attr, int region_id)
+{
+	const struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
+
+	if (attr == scrub_speed_available ||
+	    attr == scrub_speed) {
+		if (!cxl_ps_ctx->scrub_cycle_changable)
+			return 0;
+	}
+
+	switch (attr) {
+	case scrub_speed_available:
+		return 0444;
+	case scrub_enable:
+		return 0200;
+	case scrub_speed:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+/**
+ * cxl_mem_patrol_scrub_read() - Read callback for data attributes
+ * @dev: Pointer to scrub device
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ * @val: Pointer to the returned data
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int cxl_mem_patrol_scrub_read(struct device *dev, u32 attr, int region_id, u64 *val)
+{
+
+	switch (attr) {
+	case scrub_speed:
+		return cxl_mem_ps_speed_read(dev->parent, val);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+/**
+ * cxl_mem_patrol_scrub_write() - Write callback for data attributes
+ * @dev: Pointer to scrub device
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ * @val: Value to write
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int cxl_mem_patrol_scrub_write(struct device *dev, u32 attr, int region_id, u64 val)
+{
+	switch (attr) {
+	case scrub_enable:
+		return cxl_mem_ps_enable_write(dev->parent, val);
+	case scrub_speed:
+		return cxl_mem_ps_speed_write(dev->parent, val);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+/**
+ * cxl_mem_patrol_scrub_read_strings() - Read callback for string attributes
+ * @dev: Pointer to scrub device
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ * @buf: Pointer to the buffer for copying returned string
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int cxl_mem_patrol_scrub_read_strings(struct device *dev, u32 attr, int region_id,
+				      char *buf)
+{
+	switch (attr) {
+	case scrub_speed_available:
+		return cxl_mem_ps_speed_available_read(dev->parent, buf);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static const struct scrub_ops cxl_ps_scrub_ops = {
+	.is_visible = cxl_mem_patrol_scrub_is_visible,
+	.read = cxl_mem_patrol_scrub_read,
+	.write = cxl_mem_patrol_scrub_write,
+	.read_string = cxl_mem_patrol_scrub_read_strings,
+};
+
+int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
+{
+	int ret = 0;
+	struct device *cxl_scrub_dev;
+	struct cxl_memdev_ps_params params;
+	struct cxl_mbox_supp_feat_entry feat_entry;
+	char scrub_name[CXL_MEMDEV_MAX_NAME_LENGTH];
+	struct cxl_patrol_scrub_context *cxl_ps_ctx;
+
+	ret = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_patrol_scrub_uuid,
+						  &feat_entry);
+	if (ret < 0)
+		goto cxl_ps_init_exit;
+
+	if (!(feat_entry.attrb_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
+		goto cxl_ps_init_exit;
+
+	cxl_ps_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
+	if (!cxl_ps_ctx)
+		goto cxl_ps_init_exit;
+
+	cxl_ps_ctx->get_feat_size = feat_entry.get_feat_size;
+	cxl_ps_ctx->set_feat_size = feat_entry.set_feat_size;
+	ret = cxl_mem_ps_get_attrbs(&cxlmd->dev, &params);
+	if (ret) {
+		dev_err(&cxlmd->dev, "Get CXL patrol scrub params fail ret=%d\n",
+			ret);
+		goto cxl_ps_init_exit;
+	}
+	cxl_ps_ctx->scrub_cycle_changable =  params.scrub_cycle_changable;
+
+	snprintf(scrub_name, sizeof(scrub_name), "%s_%s",
+		 CXL_PATROL_SCRUB, dev_name(&cxlmd->dev));
+	cxl_scrub_dev = devm_scrub_device_register(&cxlmd->dev, scrub_name,
+						   cxl_ps_ctx, &cxl_ps_scrub_ops,
+						   CXL_MEMDEV_PATROL_SCRUB_NUM_REGIONS);
+	if (PTR_ERR_OR_ZERO(cxl_scrub_dev)) {
+		ret = PTR_ERR_OR_ZERO(cxl_scrub_dev);
+		goto cxl_ps_reg_fail;
+	}
+
+cxl_ps_reg_fail:
+cxl_ps_init_exit:
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index fdac686560d4..1d0fad0dc5ae 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -969,6 +969,13 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
+/* cxl memory scrub functions */
+#ifdef CONFIG_CXL_SCRUB
+int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd);
+#else
+int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd) { return -ENOTSUP; }
+#endif
+
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0155fb66b580..86bba8794bb4 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -881,6 +881,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	/*
+	 * Initialize optional CXL scrub features
+	 */
+	if (cxl_mem_patrol_scrub_init(cxlmd))
+		dev_dbg(&pdev->dev, "cxl_mem_patrol_scrub_init failed\n");
+
 	rc = devm_cxl_sanitize_setup_notifier(&pdev->dev, cxlmd);
 	if (rc)
 		return rc;
-- 
2.34.1

