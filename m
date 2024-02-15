Return-Path: <linux-kernel+bounces-66759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE8856135
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89BF287AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E822612C80F;
	Thu, 15 Feb 2024 11:15:14 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A3012A142;
	Thu, 15 Feb 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995714; cv=none; b=QbUmL27+wrhgI4NSGwMIvQ3MITEUVNaN4Pd3c96K5j6b9ULej0Y2dFDKzOzZJXYCsobm1bajai3b7olm0xKqVBLVnLhx8MvDnYcEz9bTPObvjblI9CTk10oaAKviccDiwDCwOECWZ8uXvx2TN5868N9NIpjrZcMqYeBKVq28fuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995714; c=relaxed/simple;
	bh=Dw8AiOxiE1vo+f54ThRNsgQFxtrsrb+aOWi5gtTde8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAd72o3Fh9Z8urF7fChp1MpEDR2vURBJj0UsCNb3IknBrCcQpapXZNb9edXguXJwWS7aj5scejOcl/uOzZaA9cygRWr64YodSsVnTSQjHWTgtCdiYz9RavwQ6PHCLpM+EZaMaBPgo5wftSczJjJo2g9gGkK9qA/muHRtKDFQgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbC7K6KkFz6K8wg;
	Thu, 15 Feb 2024 19:11:41 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 7087A1400D4;
	Thu, 15 Feb 2024 19:15:09 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:15:08 +0000
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
Subject: [RFC PATCH v6 05/12] cxl/memscrub: Add CXL device ECS control feature
Date: Thu, 15 Feb 2024 19:14:47 +0800
Message-ID: <20240215111455.1462-6-shiju.jose@huawei.com>
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

CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check
Scrub (ECS) control feature.

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

Open Question:
Is cxl_mem_ecs_init() invoked in the right function in cxl/core/region.c?

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/memscrub.c | 303 +++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/region.c   |   1 +
 drivers/cxl/cxlmem.h        |   3 +
 3 files changed, 306 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
index be8d9a9743eb..a3a371c5aa7b 100644
--- a/drivers/cxl/core/memscrub.c
+++ b/drivers/cxl/core/memscrub.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2023 HiSilicon Limited.
  *
  *  - Provides functions to configure patrol scrub
- *    feature of the CXL memory devices.
+ *    and DDR5 ECS features of the CXL memory devices.
  */
 
 #define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
@@ -264,3 +264,304 @@ int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
+
+/* CXL DDR5 ECS control definitions */
+#define CXL_MEMDEV_ECS_GET_FEAT_VERSION	0x01
+#define CXL_MEMDEV_ECS_SET_FEAT_VERSION	0x01
+
+static const uuid_t cxl_ecs_uuid =
+	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,     \
+		  0x89, 0x33, 0x86);
+
+struct cxl_ecs_context {
+	struct device *dev;
+	u16 nregions;
+	int region_id;
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
+ */
+struct cxl_memdev_ecs_params {
+	u8 log_entry_type;
+	u16 threshold;
+	u8 mode;
+	bool reset_counter;
+};
+
+enum {
+	CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE,
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
+struct cxl_memdev_ecs_feat_read_attrs {
+	u8 ecs_log_cap;
+	u8 ecs_cap;
+	__le16 ecs_config;
+	u8 ecs_flags;
+}  __packed;
+
+struct cxl_memdev_ecs_set_feat_pi {
+	struct cxl_mbox_set_feat_in pi;
+	struct cxl_memdev_ecs_feat_wr_attrs {
+		u8 ecs_log_cap;
+		__le16 ecs_config;
+	} __packed wr_attrs[];
+}  __packed;
+
+/* CXL DDR5 ECS control functions */
+static int cxl_mem_ecs_get_attrs(struct device *dev, int fru_id,
+				 struct cxl_memdev_ecs_params *params)
+{
+	struct cxl_memdev_ecs_feat_read_attrs *rd_attrs __free(kvfree) = NULL;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev->parent);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_mbox_get_feat_in pi = {
+		.uuid = cxl_ecs_uuid,
+		.offset = 0,
+		.selection = CXL_GET_FEAT_SEL_CURRENT_VALUE,
+	};
+	struct cxl_ecs_context *cxl_ecs_ctx;
+	u8 threshold_index;
+	int ret;
+
+	if (!mds)
+		return -EFAULT;
+	cxl_ecs_ctx = dev_get_drvdata(dev);
+
+	pi.count = cxl_ecs_ctx->get_feat_size;
+	rd_attrs = kvmalloc(pi.count, GFP_KERNEL);
+	if (!rd_attrs)
+		return -ENOMEM;
+
+	ret = cxl_get_feature(mds, &pi, rd_attrs);
+	if (ret) {
+		params->log_entry_type = 0;
+		params->threshold = 0;
+		params->mode = 0;
+		return ret;
+	}
+	params->log_entry_type = FIELD_GET(CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK,
+					   rd_attrs[fru_id].ecs_log_cap);
+	threshold_index = FIELD_GET(CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
+				    rd_attrs[fru_id].ecs_config);
+	params->threshold = ecs_supp_threshold[threshold_index];
+	params->mode = FIELD_GET(CXL_MEMDEV_ECS_MODE_MASK,
+				 rd_attrs[fru_id].ecs_config);
+
+	return 0;
+}
+
+static int __maybe_unused
+cxl_mem_ecs_set_attrs(struct device *dev, int fru_id,
+		      struct cxl_memdev_ecs_params *params, u8 param_type)
+{
+	struct cxl_memdev_ecs_feat_read_attrs *rd_attrs __free(kvfree) = NULL;
+	struct cxl_memdev_ecs_set_feat_pi *set_pi __free(kvfree) = NULL;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev->parent);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_mbox_get_feat_in pi = {
+		.uuid = cxl_ecs_uuid,
+		.offset = 0,
+		.selection = CXL_GET_FEAT_SEL_CURRENT_VALUE,
+	};
+	struct cxl_memdev_ecs_feat_wr_attrs *wr_attrs;
+	struct cxl_memdev_ecs_params rd_params;
+	struct cxl_ecs_context *cxl_ecs_ctx;
+	u16 nmedia_frus, count;
+	u32 set_pi_size;
+	int ret;
+
+	if (!mds)
+		return -EFAULT;
+
+	cxl_ecs_ctx = dev_get_drvdata(dev);
+	nmedia_frus = cxl_ecs_ctx->nregions;
+
+	rd_attrs = kvmalloc(cxl_ecs_ctx->get_feat_size, GFP_KERNEL);
+	if (!rd_attrs)
+		return -ENOMEM;
+
+	pi.count = cxl_ecs_ctx->get_feat_size;
+	ret = cxl_get_feature(mds, &pi, rd_attrs);
+	if (ret)
+		return ret;
+	set_pi_size = sizeof(struct cxl_mbox_set_feat_in) +
+				cxl_ecs_ctx->set_feat_size;
+	set_pi = kvmalloc(set_pi_size, GFP_KERNEL);
+	if (!set_pi)
+		return -ENOMEM;
+
+	set_pi->pi.uuid = cxl_ecs_uuid;
+	set_pi->pi.flags = CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET |
+				CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER;
+	set_pi->pi.offset = 0;
+	set_pi->pi.version = CXL_MEMDEV_ECS_SET_FEAT_VERSION;
+	/* Fill writable attributes from the current attributes read for all the media FRUs */
+	wr_attrs = set_pi->wr_attrs;
+	for (count = 0; count < nmedia_frus; count++) {
+		wr_attrs[count].ecs_log_cap = rd_attrs[count].ecs_log_cap;
+		wr_attrs[count].ecs_config = rd_attrs[count].ecs_config;
+	}
+
+	/* Fill attribute to be set for the media FRU */
+	switch (param_type) {
+	case CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE:
+		if (params->log_entry_type != ECS_LOG_ENTRY_TYPE_DRAM &&
+		    params->log_entry_type != ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU) {
+			dev_err(dev->parent,
+				"Invalid CXL ECS scrub log entry type(%d) to set\n",
+			       params->log_entry_type);
+			dev_err(dev->parent,
+				"Log Entry Type 0: per DRAM  1: per Memory Media FRU\n");
+			return -EINVAL;
+		}
+		wr_attrs[fru_id].ecs_log_cap = FIELD_PREP(CXL_MEMDEV_ECS_LOG_ENTRY_TYPE_MASK,
+							  params->log_entry_type);
+		break;
+	case CXL_MEMDEV_ECS_PARAM_THRESHOLD:
+		wr_attrs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK;
+		switch (params->threshold) {
+		case 256:
+			wr_attrs[fru_id].ecs_config |= FIELD_PREP(
+						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
+						ECS_THRESHOLD_256);
+			break;
+		case 1024:
+			wr_attrs[fru_id].ecs_config |= FIELD_PREP(
+						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
+						ECS_THRESHOLD_1024);
+			break;
+		case 4096:
+			wr_attrs[fru_id].ecs_config |= FIELD_PREP(
+						CXL_MEMDEV_ECS_THRESHOLD_COUNT_MASK,
+						ECS_THRESHOLD_4096);
+			break;
+		default:
+			dev_err(dev->parent,
+				"Invalid CXL ECS scrub threshold count(%d) to set\n",
+				params->threshold);
+			dev_err(dev->parent,
+				"Supported scrub threshold count: 256,1024,4096\n");
+			return -EINVAL;
+		}
+		break;
+	case CXL_MEMDEV_ECS_PARAM_MODE:
+		if (params->mode != ECS_MODE_COUNTS_ROWS &&
+		    params->mode != ECS_MODE_COUNTS_CODEWORDS) {
+			dev_err(dev->parent,
+				"Invalid CXL ECS scrub mode(%d) to set\n",
+				params->mode);
+			dev_err(dev->parent,
+				"Mode 0: ECS counts rows with errors"
+				" 1: ECS counts codewords with errors\n");
+			return -EINVAL;
+		}
+		wr_attrs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_MODE_MASK;
+		wr_attrs[fru_id].ecs_config |= FIELD_PREP(CXL_MEMDEV_ECS_MODE_MASK,
+							  params->mode);
+		break;
+	case CXL_MEMDEV_ECS_PARAM_RESET_COUNTER:
+		wr_attrs[fru_id].ecs_config &= ~CXL_MEMDEV_ECS_RESET_COUNTER_MASK;
+		wr_attrs[fru_id].ecs_config |= FIELD_PREP(CXL_MEMDEV_ECS_RESET_COUNTER_MASK,
+							  params->reset_counter);
+		break;
+	default:
+		dev_err(dev->parent, "Invalid CXL ECS parameter to set\n");
+		return -EINVAL;
+	}
+	ret = cxl_set_feature(mds, set_pi, set_pi_size);
+	if (ret) {
+		dev_err(dev->parent, "CXL ECS set feature fail ret=%d\n", ret);
+		return ret;
+	}
+
+	/* Verify attribute is set successfully */
+	ret = cxl_mem_ecs_get_attrs(dev, fru_id, &rd_params);
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
+	return 0;
+}
+
+int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id)
+{
+	struct cxl_mbox_supp_feat_entry feat_entry;
+	struct cxl_ecs_context *cxl_ecs_ctx;
+	int nmedia_frus;
+	int ret;
+
+	ret = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_ecs_uuid, &feat_entry);
+	if (ret < 0)
+		return ret;
+
+	if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
+		return -ENOTSUPP;
+	nmedia_frus = feat_entry.get_feat_size/
+				sizeof(struct cxl_memdev_ecs_feat_read_attrs);
+	if (nmedia_frus) {
+		cxl_ecs_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx), GFP_KERNEL);
+		if (!cxl_ecs_ctx)
+			return -ENOMEM;
+
+		cxl_ecs_ctx->nregions = nmedia_frus;
+		cxl_ecs_ctx->get_feat_size = feat_entry.get_feat_size;
+		cxl_ecs_ctx->set_feat_size = feat_entry.set_feat_size;
+		cxl_ecs_ctx->region_id = region_id;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_ecs_init, CXL);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ce0e2d82bb2b..35b57f0d85fa 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2913,6 +2913,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 			dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
 				p->res);
 	}
+	cxl_mem_ecs_init(cxlmd, atomic_read(&cxlrd->region_id));
 
 	put_device(region_dev);
 out:
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 7025c4fd66f3..06965ba89085 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -951,9 +951,12 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 /* cxl memory scrub functions */
 #ifdef CONFIG_CXL_SCRUB
 int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd);
+int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id);
 #else
 static inline int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
 { return -ENOTSUPP; }
+static inline int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id)
+{ return -ENOTSUPP; }
 #endif
 
 #ifdef CONFIG_CXL_SUSPEND
-- 
2.34.1


