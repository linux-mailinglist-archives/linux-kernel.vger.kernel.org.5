Return-Path: <linux-kernel+bounces-23641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CDE82AF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB09B287095
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB9E3FE27;
	Thu, 11 Jan 2024 13:18:14 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466F3D56F;
	Thu, 11 Jan 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T9lXN0bLXz6K8xn;
	Thu, 11 Jan 2024 21:15:32 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C6D2140D37;
	Thu, 11 Jan 2024 21:18:09 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 13:18:08 +0000
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dan.j.williams@intel.com>
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
Subject: [RFC PATCH v5 08/12] cxl/memscrub: Register CXL device ECS with scrub configure driver
Date: Thu, 11 Jan 2024 21:17:37 +0800
Message-ID: <20240111131741.1356-9-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240111131741.1356-1-shiju.jose@huawei.com>
References: <20240111131741.1356-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Register with the scrub configure driver to expose the sysfs attributes
to the user for configuring the CXL memory device's ECS feature.
Add the static CXL ECS specific attributes to support configuring the
CXL memory device ECS feature.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/memscrub.c | 253 +++++++++++++++++++++++++++++++++++-
 1 file changed, 250 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
index 48fd02a4bfaf..e76b1be3876d 100644
--- a/drivers/cxl/core/memscrub.c
+++ b/drivers/cxl/core/memscrub.c
@@ -464,6 +464,8 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
 #define CXL_MEMDEV_ECS_GET_FEAT_VERSION	0x01
 #define CXL_MEMDEV_ECS_SET_FEAT_VERSION	0x01
 
+#define CXL_DDR5_ECS	"cxl_ecs"
+
 static const uuid_t cxl_ecs_uuid =
 	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,     \
 		  0x89, 0x33, 0x86);
@@ -582,9 +584,8 @@ static int cxl_mem_ecs_get_attrbs(struct device *dev, int fru_id,
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
@@ -731,10 +732,247 @@ cxl_mem_ecs_set_attrbs(struct device *dev, int fru_id,
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
+enum cxl_mem_ecs_scrub_attributes {
+	cxl_ecs_log_entry_type,
+	cxl_ecs_log_entry_type_per_dram,
+	cxl_ecs_log_entry_type_per_memory_media,
+	cxl_ecs_mode,
+	cxl_ecs_mode_counts_codewords,
+	cxl_ecs_mode_counts_rows,
+	cxl_ecs_reset,
+	cxl_ecs_threshold,
+	cxl_ecs_threshold_available,
+	cxl_ecs_max_attrs,
+};
+
+static ssize_t cxl_mem_ecs_show_scrub_attr(struct device *dev, char *buf,
+					   int attr_id)
+{
+	struct cxl_ecs_context *cxl_ecs_ctx = dev_get_drvdata(dev);
+	int region_id = cxl_ecs_ctx->region_id;
+	struct cxl_memdev_ecs_params params;
+	int ret;
+
+	if (attr_id == cxl_ecs_log_entry_type ||
+	    attr_id == cxl_ecs_log_entry_type_per_dram ||
+	    attr_id == cxl_ecs_log_entry_type_per_memory_media ||
+	    attr_id == cxl_ecs_mode ||
+	    attr_id == cxl_ecs_mode_counts_codewords ||
+	    attr_id == cxl_ecs_mode_counts_rows ||
+	    attr_id == cxl_ecs_threshold) {
+		ret = cxl_mem_ecs_get_attrbs(dev, region_id, &params);
+		if (ret) {
+			dev_err(dev->parent, "Get CXL ECS params fail ret=%d\n", ret);
+			return ret;
+		}
+	}
+
+	switch (attr_id) {
+	case cxl_ecs_log_entry_type:
+		return sprintf(buf, "%d\n", params.log_entry_type);
+	case cxl_ecs_log_entry_type_per_dram:
+		if (params.log_entry_type == ECS_LOG_ENTRY_TYPE_DRAM)
+			return sysfs_emit(buf, "1\n");
+		else
+			return sysfs_emit(buf, "0\n");
+	case cxl_ecs_log_entry_type_per_memory_media:
+		if (params.log_entry_type == ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU)
+			return sysfs_emit(buf, "1\n");
+		else
+			return sysfs_emit(buf, "0\n");
+	case cxl_ecs_mode:
+		return sprintf(buf, "%d\n", params.mode);
+	case cxl_ecs_mode_counts_codewords:
+		if (params.mode == ECS_MODE_COUNTS_CODEWORDS)
+			return sysfs_emit(buf, "1\n");
+		else
+			return sysfs_emit(buf, "0\n");
+	case cxl_ecs_mode_counts_rows:
+		if (params.mode == ECS_MODE_COUNTS_ROWS)
+			return sysfs_emit(buf, "1\n");
+		else
+			return sysfs_emit(buf, "0\n");
+	case cxl_ecs_threshold:
+		return sprintf(buf, "%d\n", params.threshold);
+	case cxl_ecs_threshold_available:
+		return sysfs_emit(buf, "256,1024,4096\n");
+	}
+
+	return -ENOTSUPP;
+}
+
+static ssize_t cxl_mem_ecs_store_scrub_attr(struct device *dev, const char *buf,
+					    size_t count, int attr_id)
+{
+	struct cxl_ecs_context *cxl_ecs_ctx = dev_get_drvdata(dev);
+	int region_id = cxl_ecs_ctx->region_id;
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	switch (attr_id) {
+	case cxl_ecs_log_entry_type:
+		ret = cxl_mem_ecs_log_entry_type_write(dev, region_id, val);
+		if (ret)
+			return -ENOTSUPP;
+		break;
+	case cxl_ecs_mode:
+		ret = cxl_mem_ecs_mode_write(dev, region_id, val);
+		if (ret)
+			return -ENOTSUPP;
+		break;
+	case cxl_ecs_reset:
+		ret = cxl_mem_ecs_reset_counter_write(dev, region_id, val);
+		if (ret)
+			return -ENOTSUPP;
+		break;
+	case cxl_ecs_threshold:
+		ret = cxl_mem_ecs_threshold_write(dev, region_id, val);
+		if (ret)
+			return -ENOTSUPP;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	return count;
+}
+
+#define CXL_ECS_SCRUB_ATTR_RW(attrb)						\
+static ssize_t attrb##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	return cxl_mem_ecs_show_scrub_attr(dev, buf, (cxl_ecs_##attrb));	\
+}									\
+static ssize_t attrb##_store(struct device *dev,			\
+			     struct device_attribute *attr,		\
+			     const char *buf, size_t count)		\
+{									\
+	return cxl_mem_ecs_store_scrub_attr(dev, buf, count, (cxl_ecs_##attrb));\
+}									\
+static DEVICE_ATTR_RW(attrb)
+
+#define CXL_ECS_SCRUB_ATTR_RO(attrb)						\
+static ssize_t attrb##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	return cxl_mem_ecs_show_scrub_attr(dev, buf, (cxl_ecs_##attrb));	\
+}									\
+static DEVICE_ATTR_RO(attrb)
+
+#define CXL_ECS_SCRUB_ATTR_WO(attrb)						\
+static ssize_t attrb##_store(struct device *dev,			\
+			     struct device_attribute *attr,		\
+			     const char *buf, size_t count)		\
+{									\
+	return cxl_mem_ecs_store_scrub_attr(dev, buf, count, (cxl_ecs_##attrb));\
+}									\
+static DEVICE_ATTR_WO(attrb)
+
+CXL_ECS_SCRUB_ATTR_RW(log_entry_type);
+CXL_ECS_SCRUB_ATTR_RO(log_entry_type_per_dram);
+CXL_ECS_SCRUB_ATTR_RO(log_entry_type_per_memory_media);
+CXL_ECS_SCRUB_ATTR_RW(mode);
+CXL_ECS_SCRUB_ATTR_RO(mode_counts_codewords);
+CXL_ECS_SCRUB_ATTR_RO(mode_counts_rows);
+CXL_ECS_SCRUB_ATTR_WO(reset);
+CXL_ECS_SCRUB_ATTR_RW(threshold);
+CXL_ECS_SCRUB_ATTR_RO(threshold_available);
+
+static struct attribute *cxl_mem_ecs_scrub_attrs[] = {
+	&dev_attr_log_entry_type.attr,
+	&dev_attr_log_entry_type_per_dram.attr,
+	&dev_attr_log_entry_type_per_memory_media.attr,
+	&dev_attr_mode.attr,
+	&dev_attr_mode_counts_codewords.attr,
+	&dev_attr_mode_counts_rows.attr,
+	&dev_attr_reset.attr,
+	&dev_attr_threshold.attr,
+	&dev_attr_threshold_available.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_mem_ecs_attr_group = {
+	.attrs = cxl_mem_ecs_scrub_attrs,
+};
+
 int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id)
 {
+	char scrub_name[CXL_MEMDEV_MAX_NAME_LENGTH];
 	struct cxl_mbox_supp_feat_entry feat_entry;
 	struct cxl_ecs_context *cxl_ecs_ctx;
+	struct device *cxl_scrub_dev;
 	int nmedia_frus;
 	int ret;
 
@@ -755,6 +993,15 @@ int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id)
 		cxl_ecs_ctx->get_feat_size = feat_entry.get_feat_size;
 		cxl_ecs_ctx->set_feat_size = feat_entry.set_feat_size;
 		cxl_ecs_ctx->region_id = region_id;
+
+		snprintf(scrub_name, sizeof(scrub_name), "%s_%s_region%d",
+			 CXL_DDR5_ECS, dev_name(&cxlmd->dev), cxl_ecs_ctx->region_id);
+		cxl_scrub_dev = devm_scrub_device_register(&cxlmd->dev, scrub_name,
+							  cxl_ecs_ctx, NULL,
+							  cxl_ecs_ctx->region_id,
+							  &cxl_mem_ecs_attr_group);
+		if (IS_ERR(cxl_scrub_dev))
+			return PTR_ERR(cxl_scrub_dev);
 	}
 
 	return 0;
-- 
2.34.1


