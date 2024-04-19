Return-Path: <linux-kernel+bounces-151771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC058AB3AE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF041F230FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C73313CF9A;
	Fri, 19 Apr 2024 16:47:53 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C113AD1B;
	Fri, 19 Apr 2024 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545272; cv=none; b=Y86V9H1+X8MJ1vj0t1JcJ9e5clqHElC/HAcf+MPZ1XWHm8N4lesBgfEOuJvuiwAZvqTE/nXProXmssdL2YysP6YqcSw4vidQbja7y2H3z8390gJ73IIKT9hnTk4jwqCqCN7BNivZtQUUi9JtQOMnot+k+31Ye0nBg6CynbMhL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545272; c=relaxed/simple;
	bh=/CinCs2Fq+4HX9AWVODe8ElHHF3SMTDntQaPjQydwyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1Rv1LCiBxXjhIwxjEBoBKbPdJeSfo/pqg3En0w201YIrqaVL0+Z24BtJ2ZqYqbcx3NxIqgdSlzXgovf5VMdtW8cvEHAlRah5e+wP6+am1fzrL7IaQQpNigvLjV9+B0faDbvdTX0eR+EYExXRomdcSnV7hJZUDqt3MCQAjyTNJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VLgYZ3xc9z6K8xv;
	Sat, 20 Apr 2024 00:47:46 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id E9E25140B63;
	Sat, 20 Apr 2024 00:47:47 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 17:47:45 +0100
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
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH v8 05/10] cxl/memscrub: Add CXL device patrol scrub control feature
Date: Sat, 20 Apr 2024 00:47:14 +0800
Message-ID: <20240419164720.1765-6-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240419164720.1765-1-shiju.jose@huawei.com>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
feature. The device patrol scrub proactively locates and makes corrections
to errors in regular cycle.

Allow specifying the number of hours within which the patrol scrub must be
completed, subject to minimum and maximum limits reported by the device.
Also allow disabling scrub allowing trade-off error rates against
performance.

Register with scrub subsystem to provide scrub control attributes to the
user.

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/scrub/scrub-configure.rst |  52 ++++
 drivers/cxl/Kconfig                     |  19 ++
 drivers/cxl/core/Makefile               |   1 +
 drivers/cxl/core/memscrub.c             | 314 ++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |   8 +
 drivers/cxl/mem.c                       |   6 +
 6 files changed, 400 insertions(+)
 create mode 100644 Documentation/scrub/scrub-configure.rst
 create mode 100644 drivers/cxl/core/memscrub.c

diff --git a/Documentation/scrub/scrub-configure.rst b/Documentation/scrub/scrub-configure.rst
new file mode 100644
index 000000000000..2275366b60d3
--- /dev/null
+++ b/Documentation/scrub/scrub-configure.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Scrub subsystem
+================
+
+Copyright (c) 2024 HiSilicon Limited.
+
+:Author:   Shiju Jose <shiju.jose@huawei.com>
+:License:  The GNU Free Documentation License, Version 1.2
+          (dual licensed under the GPL v2)
+:Original Reviewers:
+
+- Written for: 6.9
+- Updated for:
+
+Introduction
+------------
+The scrub subsystem provides interface for controlling attributes
+of memory scrubbers in the system. The scrub device drivers
+in the system register with the scrub subsystem.The scrub subsystem
+driver exposes the scrub controls to the user in the sysfs.
+
+The File System
+---------------
+
+The control attributes of the registered scrubbers could be
+accessed in the /sys/class/ras/rasX/scrub/
+
+sysfs
+-----
+
+Sysfs files are documented in
+`Documentation/ABI/testing/sysfs-class-scrub-configure`.
+
+Example
+-------
+
+The usage takes the form shown in this example::
+
+1. CXL patrol scrubber
+    # cat /sys/class/ras/ras0/scrub/rate_available
+    # 0x1-0xff
+    # echo 30 > /sys/class/ras/ras0/scrub/rate
+    # cat /sys/class/ras/ras0/scrub/rate
+    # 0x1e
+    # echo 1 > /sys/class/ras/ras0/scrub/enable_background
+    # cat /sys/class/ras/ras0/scrub/enable_background
+    # 1
+    # echo 0 > /sys/class/ras/ras0/scrub/enable_background
+    # cat /sys/class/ras/ras0/scrub/enable_background
+    # 0
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 5f3c9c5529b9..3621b9f27e80 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -144,4 +144,23 @@ config CXL_REGION_INVALIDATION_TEST
 	  If unsure, or if this kernel is meant for production environments,
 	  say N.
 
+config CXL_SCRUB
+	bool "CXL: Memory scrub feature"
+	depends on CXL_PCI
+	depends on CXL_MEM
+	depends on SCRUB
+	help
+	  The CXL memory scrub control is an optional feature allows host to
+	  control the scrub configurations of CXL Type 3 devices, which
+	  supports patrol scrubbing.
+
+	  Registers with the scrub subsystem to provide control attributes
+	  of CXL memory device scrubber to the user.
+	  Provides interface functions to support configuring the CXL memory
+	  device patrol scrubber.
+
+	  Say 'y/n' to enable/disable control of memory scrub parameters for
+	  CXL.mem devices. See section 8.2.9.9.11.1 of CXL 3.1 specification
+	  for detailed description of CXL memory patrol scrub control feature.
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 9259bcc6773c..e0fc814c3983 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -16,3 +16,4 @@ cxl_core-y += pmu.o
 cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+cxl_core-$(CONFIG_CXL_SCRUB) += memscrub.o
diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
new file mode 100644
index 000000000000..a50f6e384394
--- /dev/null
+++ b/drivers/cxl/core/memscrub.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * CXL memory scrub driver.
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ *
+ *  - Provides functions to configure patrol scrub feature of the
+ *    CXL memory devices.
+ *  - Registers with the scrub subsystem driver to expose the sysfs attributes
+ *    to the user for configuring the CXL memory patrol scrub feature.
+ */
+
+#define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
+
+#include <cxlmem.h>
+#include <linux/cleanup.h>
+#include <linux/limits.h>
+#include <linux/memory_scrub.h>
+
+static int cxl_mem_get_supported_feature_entry(struct cxl_memdev *cxlmd, const uuid_t *feat_uuid,
+					       struct cxl_mbox_supp_feat_entry *feat_entry_out)
+{
+	struct cxl_mbox_supp_feat_entry *feat_entry;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	int feat_index, feats_out_size;
+	int nentries, count;
+	int ret;
+
+	feat_index = 0;
+	feats_out_size = sizeof(struct cxl_mbox_get_supp_feats_out) +
+			  sizeof(struct cxl_mbox_supp_feat_entry);
+	struct cxl_mbox_get_supp_feats_out *feats_out __free(kfree) =
+					kmalloc(feats_out_size, GFP_KERNEL);
+	if (!feats_out)
+		return -ENOMEM;
+
+	while (true) {
+		memset(feats_out, 0, feats_out_size);
+		ret = cxl_get_supported_features(mds, feats_out_size,
+						 feat_index, feats_out);
+		if (ret)
+			return ret;
+
+		nentries = feats_out->nr_entries;
+		if (!nentries)
+			return -EOPNOTSUPP;
+
+		/* Check CXL memdev supports the feature */
+		feat_entry = feats_out->feat_entries;
+		for (count = 0; count < nentries; count++, feat_entry++) {
+			if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
+				memcpy(feat_entry_out, feat_entry,
+				       sizeof(*feat_entry_out));
+				return 0;
+			}
+		}
+		feat_index += nentries;
+	}
+}
+
+/* CXL memory patrol scrub control definitions */
+#define CXL_MEMDEV_PS_GET_FEAT_VERSION	0x01
+#define CXL_MEMDEV_PS_SET_FEAT_VERSION	0x01
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
+	bool scrub_cycle_changeable;
+};
+
+/**
+ * struct cxl_memdev_ps_params - CXL memory patrol scrub parameter data structure.
+ * @enable:     [IN & OUT] enable(1)/disable(0) patrol scrub.
+ * @scrub_cycle_changeable: [OUT] scrub cycle attribute of patrol scrub is changeable.
+ * @rate:       [IN] Requested patrol scrub cycle in hours.
+ *              [OUT] Current patrol scrub cycle in hours.
+ * @min_rate:[OUT] minimum patrol scrub cycle, in hours, supported.
+ */
+struct cxl_memdev_ps_params {
+	bool enable;
+	bool scrub_cycle_changeable;
+	u16 rate;
+	u16 min_rate;
+};
+
+enum cxl_scrub_param {
+	cxl_ps_param_enable,
+	cxl_ps_param_rate,
+};
+
+#define	CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK	BIT(0)
+#define	CXL_MEMDEV_PS_SCRUB_CYCLE_REALTIME_REPORT_CAP_MASK	BIT(1)
+#define	CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK	GENMASK(7, 0)
+#define	CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK	GENMASK(15, 8)
+#define	CXL_MEMDEV_PS_FLAG_ENABLED_MASK	BIT(0)
+
+struct cxl_memdev_ps_rd_attrs {
+	u8 scrub_cycle_cap;
+	__le16 scrub_cycle;
+	u8 scrub_flags;
+}  __packed;
+
+struct cxl_memdev_ps_wr_attrs {
+	u8 scrub_cycle_hr;
+	u8 scrub_flags;
+}  __packed;
+
+static int cxl_mem_ps_get_attrs(struct device *dev,
+				struct cxl_memdev_ps_params *params)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	size_t rd_data_size = sizeof(struct cxl_memdev_ps_rd_attrs);
+	size_t data_size;
+
+	if (!mds)
+		return -EFAULT;
+
+	struct cxl_memdev_ps_rd_attrs *rd_attrs __free(kfree) =
+						kmalloc(rd_data_size, GFP_KERNEL);
+	if (!rd_attrs)
+		return -ENOMEM;
+
+	data_size = cxl_get_feature(mds, cxl_patrol_scrub_uuid, rd_attrs,
+				    rd_data_size, rd_data_size,
+				    CXL_GET_FEAT_SEL_CURRENT_VALUE);
+	if (!data_size)
+		return -EIO;
+
+	params->scrub_cycle_changeable = FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,
+						   rd_attrs->scrub_cycle_cap);
+	params->enable = FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
+				   rd_attrs->scrub_flags);
+	params->rate = FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
+				 rd_attrs->scrub_cycle);
+	params->min_rate = FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,
+				      rd_attrs->scrub_cycle);
+
+	return 0;
+}
+
+static int cxl_mem_ps_set_attrs(struct device *dev, struct cxl_memdev_ps_params *params,
+				enum cxl_scrub_param param_type)
+{
+	struct cxl_memdev_ps_wr_attrs wr_attrs;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_memdev_ps_params rd_params;
+	int ret;
+
+	ret = cxl_mem_ps_get_attrs(dev, &rd_params);
+	if (ret) {
+		dev_err(dev, "Get cxlmemdev patrol scrub params failed ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	switch (param_type) {
+	case cxl_ps_param_enable:
+		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
+						   params->enable);
+		wr_attrs.scrub_cycle_hr = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
+						      rd_params.rate);
+		break;
+	case cxl_ps_param_rate:
+		if (params->rate < rd_params.min_rate) {
+			dev_err(dev, "Invalid CXL patrol scrub cycle(%d) to set\n",
+				params->rate);
+			dev_err(dev, "Minimum supported CXL patrol scrub cycle in hour %d\n",
+			       params->min_rate);
+			return -EINVAL;
+		}
+		wr_attrs.scrub_cycle_hr = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
+						     params->rate);
+		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
+						  rd_params.enable);
+		break;
+	}
+
+	ret = cxl_set_feature(mds, cxl_patrol_scrub_uuid, CXL_MEMDEV_PS_SET_FEAT_VERSION,
+			      &wr_attrs, sizeof(wr_attrs),
+			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET);
+	if (ret)
+		dev_err(dev, "CXL patrol scrub set feature failed ret=%d\n",
+			ret);
+
+	return ret;
+}
+
+static int cxl_patrol_scrub_get_enabled_bg(struct device *dev, bool *enabled)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_mem_ps_get_attrs(dev->parent, &params);
+	if (ret)
+		return ret;
+
+	*enabled = params.enable;
+
+	return 0;
+}
+
+static int cxl_patrol_scrub_set_enabled_bg(struct device *dev, bool enable)
+{
+	struct cxl_memdev_ps_params params = {
+		.enable = enable,
+	};
+
+	return cxl_mem_ps_set_attrs(dev->parent, &params, cxl_ps_param_enable);
+}
+
+static int cxl_patrol_scrub_get_name(struct device *dev, char *name)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev->parent);
+
+	return sysfs_emit(name, "%s_%s\n", "cxl_patrol_scrub",
+			  dev_name(&cxlmd->dev));
+}
+
+static int cxl_patrol_scrub_write_rate(struct device *dev, u64 rate)
+{
+	struct cxl_memdev_ps_params params = {
+		.rate = rate,
+	};
+
+	return cxl_mem_ps_set_attrs(dev->parent, &params, cxl_ps_param_rate);
+}
+
+static int cxl_patrol_scrub_read_rate(struct device *dev, u64 *rate)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_mem_ps_get_attrs(dev->parent, &params);
+	if (ret)
+		return ret;
+
+	*rate = params.rate;
+
+	return 0;
+}
+
+static int cxl_patrol_scrub_read_rate_avail(struct device *dev, u64 *min, u64 *max)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_mem_ps_get_attrs(dev->parent, &params);
+	if (ret)
+		return ret;
+	*min = params.min_rate;
+	*max = U8_MAX; /* Max set by register size */
+
+	return 0;
+}
+
+static const struct scrub_ops cxl_ps_scrub_ops = {
+	.get_enabled_bg = cxl_patrol_scrub_get_enabled_bg,
+	.set_enabled_bg = cxl_patrol_scrub_set_enabled_bg,
+	.get_name = cxl_patrol_scrub_get_name,
+	.rate_read = cxl_patrol_scrub_read_rate,
+	.rate_write = cxl_patrol_scrub_write_rate,
+	.rate_avail_range = cxl_patrol_scrub_read_rate_avail,
+};
+
+int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
+{
+	struct cxl_patrol_scrub_context *cxl_ps_ctx;
+	struct cxl_mbox_supp_feat_entry feat_entry;
+	struct cxl_memdev_ps_params params;
+	struct device *cxl_scrub_dev;
+	int ret;
+
+	ret = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_patrol_scrub_uuid,
+						  &feat_entry);
+	if (ret < 0)
+		return ret;
+
+	if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
+		return -EOPNOTSUPP;
+
+	ret = cxl_mem_ps_get_attrs(&cxlmd->dev, &params);
+	if (ret)
+		return dev_err_probe(&cxlmd->dev, ret,
+				     "Get CXL patrol scrub params failed\n");
+
+	cxl_ps_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
+	if (!cxl_ps_ctx)
+		return -ENOMEM;
+
+	*cxl_ps_ctx = (struct cxl_patrol_scrub_context) {
+		.get_feat_size = feat_entry.get_size,
+		.set_feat_size = feat_entry.set_size,
+		.scrub_cycle_changeable =  params.scrub_cycle_changeable,
+	};
+
+	cxl_scrub_dev = devm_scrub_device_register(&cxlmd->dev, cxl_ps_ctx,
+						   &cxl_ps_scrub_ops);
+	if (IS_ERR(cxl_scrub_dev))
+		return PTR_ERR(cxl_scrub_dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 1c50a3e2eced..f95e39febd73 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -956,6 +956,14 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
+/* cxl memory scrub functions */
+#ifdef CONFIG_CXL_SCRUB
+int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd);
+#else
+static inline int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
+{ return 0; }
+#endif
+
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 0c79d9ce877c..399e43463626 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -117,6 +117,12 @@ static int cxl_mem_probe(struct device *dev)
 	if (!cxlds->media_ready)
 		return -EBUSY;
 
+	rc = cxl_mem_patrol_scrub_init(cxlmd);
+	if (rc) {
+		dev_dbg(&cxlmd->dev, "CXL patrol scrub init failed\n");
+		return rc;
+	}
+
 	/*
 	 * Someone is trying to reattach this device after it lost its port
 	 * connection (an endpoint port previously registered by this memdev was
-- 
2.34.1


