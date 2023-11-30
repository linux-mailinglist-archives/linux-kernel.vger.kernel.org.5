Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764EE7FFB2C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376430AbjK3TXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376377AbjK3TX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:23:26 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730FAD67;
        Thu, 30 Nov 2023 11:23:31 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sh5gt3pfSz6JB5V;
        Fri,  1 Dec 2023 03:23:06 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
        by mail.maildlp.com (Postfix) with ESMTPS id AD0D31402CD;
        Fri,  1 Dec 2023 03:23:29 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 19:23:28 +0000
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
Subject: [PATCH v4 04/11] cxl/memscrub: Add CXL device patrol scrub control feature
Date:   Fri, 1 Dec 2023 03:23:06 +0800
Message-ID: <20231130192314.1220-5-shiju.jose@huawei.com>
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
 drivers/cxl/Kconfig         |  17 +++
 drivers/cxl/core/Makefile   |   1 +
 drivers/cxl/core/memscrub.c | 266 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h        |   8 ++
 drivers/cxl/pci.c           |   5 +
 5 files changed, 297 insertions(+)
 create mode 100644 drivers/cxl/core/memscrub.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 8ea1d340e438..67d88f9bf52b 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -154,4 +154,21 @@ config CXL_PMU
 	  monitoring units and provide standard perf based interfaces.
 
 	  If unsure say 'm'.
+
+config CXL_SCRUB
+	bool "CXL: Memory scrub feature"
+	depends on CXL_PCI
+	depends on CXL_MEM
+	help
+	  The CXL memory scrub control is an optional feature allows host to
+	  control the scrub configurations of CXL Type 3 devices, which
+	  support patrol scrub and/or DDR5 ECS(Error Check Scrub).
+
+	  Say 'y/n' to enable/disable the CXL memory scrub driver that will
+	  attach to CXL.mem devices for memory scrub control feature. See
+	  sections 8.2.9.9.11.1 and 8.2.9.9.11.2 in the CXL 3.1 specification
+	  for a detailed description of CXL memory scrub control features.
+
+	  If unsure say 'n'.
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
index 000000000000..a74f4efa207e
--- /dev/null
+++ b/drivers/cxl/core/memscrub.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * cxl_memscrub.c - CXL memory scrub driver
+ *
+ * Copyright (c) 2023 HiSilicon Limited.
+ *
+ *  - Provides functions to configure patrol scrub
+ *    feature of the CXL memory devices.
+ */
+
+#define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
+
+#include <cxlmem.h>
+
+/* CXL memory scrub feature common definitions */
+#define CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH	128
+
+static int cxl_mem_get_supported_feature_entry(struct cxl_memdev *cxlmd, const uuid_t *feat_uuid,
+					       struct cxl_mbox_supp_feat_entry *feat_entry_out)
+{
+	struct cxl_mbox_get_supp_feats_out *feats_out __free(kvfree) = NULL;
+	struct cxl_mbox_supp_feat_entry *feat_entry;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_mbox_get_supp_feats_in pi;
+	int feat_index, count;
+	int nentries;
+	int ret;
+
+	feat_index = 0;
+	pi.count = sizeof(struct cxl_mbox_get_supp_feats_out) +
+			  sizeof(struct cxl_mbox_supp_feat_entry);
+	feats_out = kvmalloc(pi.count, GFP_KERNEL);
+	if (!feats_out)
+		return -ENOMEM;
+
+	do {
+		pi.start_index = feat_index;
+		memset(feats_out, 0, pi.count);
+		ret = cxl_get_supported_features(mds, &pi, feats_out);
+		if (ret)
+			return ret;
+
+		nentries = feats_out->entries;
+		if (!nentries)
+			break;
+
+		/* Check CXL memdev supports the feature */
+		feat_entry = (void *)feats_out->feat_entries;
+		for (count = 0; count < nentries; count++, feat_entry++) {
+			if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
+				memcpy(feat_entry_out, feat_entry, sizeof(*feat_entry_out));
+				return 0;
+			}
+		}
+		feat_index += nentries;
+	} while (nentries);
+
+	return -ENOTSUPP;
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
+ * @enable:     [IN] enable(1)/disable(0) patrol scrub.
+ * @scrub_cycle_changeable: [OUT] scrub cycle attribute of patrol scrub is changeable.
+ * @speed:      [IN] Requested patrol scrub cycle in hours.
+ *              [OUT] Current patrol scrub cycle in hours.
+ * @min_speed:[OUT] minimum patrol scrub cycle, in hours, supported.
+ * @speed_avail:[OUT] Supported patrol scrub cycle in hours.
+ */
+struct cxl_memdev_ps_params {
+	bool enable;
+	bool scrub_cycle_changeable;
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
+	struct cxl_memdev_ps_feat_read_attrbs *rd_attrbs __free(kvfree) = NULL;
+	struct cxl_mbox_get_feat_in pi = {
+		.uuid = cxl_patrol_scrub_uuid,
+		.offset = 0,
+		.count = sizeof(struct cxl_memdev_ps_feat_read_attrbs),
+		.selection = CXL_GET_FEAT_SEL_CURRENT_VALUE,
+	};
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	int ret;
+
+	if (!mds)
+		return -EFAULT;
+
+	rd_attrbs = kvmalloc(pi.count, GFP_KERNEL);
+	if (!rd_attrbs)
+		return -ENOMEM;
+
+	ret = cxl_get_feature(mds, &pi, rd_attrbs);
+	if (ret) {
+		params->enable = 0;
+		params->speed = 0;
+		snprintf(params->speed_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
+			"Unavailable");
+		return ret;
+	}
+	params->scrub_cycle_changeable = FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,
+						   rd_attrbs->scrub_cycle_cap);
+	params->enable = FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
+				   rd_attrbs->scrub_flags);
+	params->speed = FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
+				  rd_attrbs->scrub_cycle);
+	params->min_speed  = FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,
+				       rd_attrbs->scrub_cycle);
+	snprintf(params->speed_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
+		 "Minimum scrub cycle = %d hour", params->min_speed);
+
+	return 0;
+}
+
+static int __maybe_unused
+cxl_mem_ps_set_attrbs(struct device *dev, struct cxl_memdev_ps_params *params,
+		      u8 param_type)
+{
+	struct cxl_memdev_ps_set_feat_pi set_pi = {
+		.pi.uuid = cxl_patrol_scrub_uuid,
+		.pi.flags = CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET |
+			    CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER,
+		.pi.offset = 0,
+		.pi.version = CXL_MEMDEV_PS_SET_FEAT_VERSION,
+	};
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_memdev_ps_params rd_params;
+	int ret;
+
+	if (!mds)
+		return -EFAULT;
+
+	ret = cxl_mem_ps_get_attrbs(dev, &rd_params);
+	if (ret) {
+		dev_err(dev, "Get cxlmemdev patrol scrub params fail ret=%d\n",
+			ret);
+		return ret;
+	}
+
+	switch (param_type) {
+	case CXL_MEMDEV_PS_PARAM_ENABLE:
+		set_pi.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
+						   params->enable);
+		set_pi.scrub_cycle_hr = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
+						      rd_params.speed);
+		break;
+	case CXL_MEMDEV_PS_PARAM_SPEED:
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
+		break;
+	default:
+		dev_err(dev, "Invalid CXL patrol scrub parameter to set\n");
+		return -EINVAL;
+	}
+
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
+int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
+{
+	struct cxl_patrol_scrub_context *cxl_ps_ctx;
+	struct cxl_mbox_supp_feat_entry feat_entry;
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_patrol_scrub_uuid,
+						  &feat_entry);
+	if (ret < 0)
+		return ret;
+
+	if (!(feat_entry.attrb_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
+		return -ENOTSUPP;
+
+	cxl_ps_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
+	if (!cxl_ps_ctx)
+		return -ENOMEM;
+
+	cxl_ps_ctx->get_feat_size = feat_entry.get_feat_size;
+	cxl_ps_ctx->set_feat_size = feat_entry.set_feat_size;
+	ret = cxl_mem_ps_get_attrbs(&cxlmd->dev, &params);
+	if (ret) {
+		dev_err(&cxlmd->dev, "Get CXL patrol scrub params fail ret=%d\n",
+			ret);
+		return ret;
+	}
+	cxl_ps_ctx->scrub_cycle_changeable =  params.scrub_cycle_changeable;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 46131dcd0900..25c46e72af16 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -983,6 +983,14 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
+/* cxl memory scrub functions */
+#ifdef CONFIG_CXL_SCRUB
+int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd);
+#else
+static inline int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
+{ return -ENOTSUPP; }
+#endif
+
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0155fb66b580..acc337b8c365 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -881,6 +881,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	/*
+	 * Initialize optional CXL scrub features
+	 */
+	cxl_mem_patrol_scrub_init(cxlmd);
+
 	rc = devm_cxl_sanitize_setup_notifier(&pdev->dev, cxlmd);
 	if (rc)
 		return rc;
-- 
2.34.1

