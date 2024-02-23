Return-Path: <linux-kernel+bounces-78497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7D686142C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB731C22C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150F281AC0;
	Fri, 23 Feb 2024 14:37:51 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C2F80C0E;
	Fri, 23 Feb 2024 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699070; cv=none; b=XLEzDCsMD+xz2kZEjFxv9BzHZ6O1X5QlNQ1Kzo0h1/p+DnITgeI3fcfqGhesoWaB1Mc+yPKJTXf/gIPI/YoLigieOTQC8mSB/UwlCw1evCPhxsIbHyZbfkmlW+nonhH6GdDKUdtjjK+XiGLNRKM99xZO+GJsUYJNxOHORu2gj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699070; c=relaxed/simple;
	bh=HjRjQJjpaGOU/Bd4AZEvaexaL9/hGrjKwCHKesdEaNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erdQyr8EtObNdY0tFZbh4BPvOgI80x5H8whhA3CzuxRcC8p2xDE+jI0Ytj+HzYcBVj4SLWBEmgGMTszK3Tq9q8pMnZ+i8voxTTzdcipf2DRO9b1ELGBiNKXPibpT3bOvQLK9M3GJ8pc6Ktf8eAlBs8dW4FTlpQwwG2I/iX04pIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThCDc2NQZz6K5p5;
	Fri, 23 Feb 2024 22:33:36 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id A657C140B33;
	Fri, 23 Feb 2024 22:37:45 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 14:37:44 +0000
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
Subject: [RFC PATCH v7 08/12] cxl/memscrub: Register CXL device ECS with scrub subsystem driver
Date: Fri, 23 Feb 2024 22:37:19 +0800
Message-ID: <20240223143723.1574-9-shiju.jose@huawei.com>
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

Register with the scrub subsystem driver to expose the sysfs attributes
to the user for configuring the CXL memory device's ECS feature.
Add the static CXL ECS specific attributes to support configuring the
CXL memory device ECS feature.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 .../ABI/testing/sysfs-class-cxl-ecs-configure |  79 ++++++
 drivers/cxl/core/memscrub.c                   | 251 +++++++++++++++++-
 2 files changed, 327 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-cxl-ecs-configure

diff --git a/Documentation/ABI/testing/sysfs-class-cxl-ecs-configure b/Documentation/ABI/testing/sysfs-class-cxl-ecs-configure
new file mode 100644
index 000000000000..541b150db71c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-cxl-ecs-configure
@@ -0,0 +1,79 @@
+See `Documentation/ABI/testing/sysfs-class-scrub-configure` for the
+documentation of common scrub configure directory layout (/sys/class/scrub/),
+including the attributes used for configuring the CXL patrol scrub.
+Following are the attributes defined for configuring the CXL ECS.
+
+What:		/sys/class/scrub/scrubX/regionN/ecs_log_entry_type
+Date:		February 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The log entry type of how the DDR5 ECS log is
+		reported.
+		00b - per DRAM.
+		01b - per memory media FRU.
+
+What:		/sys/class/scrub/scrubX/regionN/ecs_log_entry_type_per_dram
+Date:		February 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Returns true if current log entry type of DDR5 ECS
+		region is per DRAM.
+
+What:		/sys/class/scrub/scrubX/regionN/ecs_log_entry_type_per_memory_media
+Date:		February 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Returns true if current log entry type of DDR5 ECS
+		region is per memory media FRU.
+
+What:		/sys/class/scrub/scrubX/regionN/mode
+Date:		February 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The mode of how the DDR5 ECS counts the errors.
+		0 - ECS counts rows with errors.
+		1 - ECS counts codewords with errors.
+
+What:		/sys/class/scrub/scrubX/regionN/mode_counts_rows
+Date:		February 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Returns true if current mode of DDR5 ECS region
+		is counts rows with errors.
+
+What:		/sys/class/scrub/scrubX/regionN/mode_counts_codewords
+Date:		February 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Returns true if current mode of DDR5 ECS region
+		is counts codewords with errors.
+
+What:		/sys/class/scrub/scrubX/regionN/reset_counter
+Date:		February 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(WO) DDR5 ECS reset ECC counter.
+		0 - normal, ECC counter running actively.
+		1 - reset ECC counter to the default value.
+
+What:		/sys/class/scrub/scrubX/regionN/threshold
+Date:		February 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) DDR5 ECS threshold count per GB of memory cells.
+
+What:		/sys/class/scrub/scrubX/regionN/threshold_available
+Date:		February 2024
+KernelVersion:	6.8
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Supported list of DDR5 ECS threshold count per GB of
+		memory cells.
diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
index b053dcb9197e..e227ea2f1508 100644
--- a/drivers/cxl/core/memscrub.c
+++ b/drivers/cxl/core/memscrub.c
@@ -558,9 +558,9 @@ cxl_mem_ecs_get_attrs(struct device *scrub_dev, int fru_id,
 	return 0;
 }
 
-static int __maybe_unused
-cxl_mem_ecs_set_attrs(struct device *scrub_dev, int fru_id,
-		      struct cxl_memdev_ecs_params *params, u8 param_type)
+static int cxl_mem_ecs_set_attrs(struct device *scrub_dev, int fru_id,
+				 struct cxl_memdev_ecs_params *params,
+				 u8 param_type)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(scrub_dev->parent);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -677,8 +677,243 @@ cxl_mem_ecs_set_attrs(struct device *scrub_dev, int fru_id,
 	return 0;
 }
 
+static int cxl_mem_ecs_log_entry_type_write(struct device *dev, int region_id, long val)
+{
+	struct cxl_memdev_ecs_params params;
+	int ret;
+
+	params.log_entry_type = val;
+	ret = cxl_mem_ecs_set_attrs(dev, region_id, &params,
+				    CXL_MEMDEV_ECS_PARAM_LOG_ENTRY_TYPE);
+	if (ret) {
+		dev_err(dev->parent, "Set CXL ECS params for log entry type failed ret=%d\n",
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
+	ret = cxl_mem_ecs_set_attrs(dev, region_id, &params,
+				    CXL_MEMDEV_ECS_PARAM_THRESHOLD);
+	if (ret) {
+		dev_err(dev->parent, "Set CXL ECS params for threshold failed ret=%d\n",
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
+	ret = cxl_mem_ecs_set_attrs(dev, region_id, &params,
+				    CXL_MEMDEV_ECS_PARAM_MODE);
+	if (ret) {
+		dev_err(dev->parent, "Set CXL ECS params for mode failed ret=%d\n",
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
+	ret = cxl_mem_ecs_set_attrs(dev, region_id, &params,
+				    CXL_MEMDEV_ECS_PARAM_RESET_COUNTER);
+	if (ret) {
+		dev_err(dev->parent, "Set CXL ECS params for reset ECC counter failed ret=%d\n",
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
+	cxl_ecs_max_attrs
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
+		ret = cxl_mem_ecs_get_attrs(dev, region_id, &params);
+		if (ret) {
+			dev_err(dev->parent, "Get CXL ECS params failed ret=%d\n", ret);
+			return ret;
+		}
+	}
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
+	return -EOPNOTSUPP;
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
+			return -EOPNOTSUPP;
+		break;
+	case cxl_ecs_mode:
+		ret = cxl_mem_ecs_mode_write(dev, region_id, val);
+		if (ret)
+			return -EOPNOTSUPP;
+		break;
+	case cxl_ecs_reset:
+		ret = cxl_mem_ecs_reset_counter_write(dev, region_id, val);
+		if (ret)
+			return -EOPNOTSUPP;
+		break;
+	case cxl_ecs_threshold:
+		ret = cxl_mem_ecs_threshold_write(dev, region_id, val);
+		if (ret)
+			return -EOPNOTSUPP;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return count;
+}
+
+#define CXL_ECS_SCRUB_ATTR_RW(attr)						\
+static ssize_t attr##_show(struct device *dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	return cxl_mem_ecs_show_scrub_attr(dev, buf, (cxl_ecs_##attr));	\
+}									\
+static ssize_t attr##_store(struct device *dev,			\
+			    struct device_attribute *attr,		\
+			    const char *buf, size_t count)		\
+{									\
+	return cxl_mem_ecs_store_scrub_attr(dev, buf, count, (cxl_ecs_##attr));\
+}									\
+static DEVICE_ATTR_RW(attr)
+
+#define CXL_ECS_SCRUB_ATTR_RO(attr)						\
+static ssize_t attr##_show(struct device *dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	return cxl_mem_ecs_show_scrub_attr(dev, buf, (cxl_ecs_##attr));	\
+}									\
+static DEVICE_ATTR_RO(attr)
+
+#define CXL_ECS_SCRUB_ATTR_WO(attr)						\
+static ssize_t attr##_store(struct device *dev,			\
+			    struct device_attribute *attr,		\
+			    const char *buf, size_t count)		\
+{									\
+	return cxl_mem_ecs_store_scrub_attr(dev, buf, count, (cxl_ecs_##attr));\
+}									\
+static DEVICE_ATTR_WO(attr)
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
+	NULL
+};
+
+static struct attribute_group cxl_mem_ecs_attr_group = {
+	.attrs = cxl_mem_ecs_scrub_attrs
+};
+
 int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id)
 {
+	char scrub_name[CXL_MEMDEV_MAX_NAME_LENGTH];
 	struct cxl_mbox_supp_feat_entry feat_entry;
 	struct cxl_ecs_context *cxl_ecs_ctx;
 	int nr_media_frus;
@@ -704,6 +939,16 @@ int cxl_mem_ecs_init(struct cxl_memdev *cxlmd, int region_id)
 	cxl_ecs_ctx->set_feat_size = feat_entry.set_size;
 	cxl_ecs_ctx->region_id = region_id;
 
+	snprintf(scrub_name, sizeof(scrub_name), "%s_%s_region%d",
+		 "cxl_ecs", dev_name(&cxlmd->dev), cxl_ecs_ctx->region_id);
+	struct device *cxl_scrub_dev = devm_scrub_device_register(&cxlmd->dev,
+							scrub_name,
+							cxl_ecs_ctx, NULL,
+							cxl_ecs_ctx->region_id,
+							&cxl_mem_ecs_attr_group);
+	if (IS_ERR(cxl_scrub_dev))
+		return PTR_ERR(cxl_scrub_dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_ecs_init, CXL);
-- 
2.34.1


