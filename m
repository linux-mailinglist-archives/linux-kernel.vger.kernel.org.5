Return-Path: <linux-kernel+bounces-23640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A8182AF7C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B001C23881
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D74C171DE;
	Thu, 11 Jan 2024 13:18:13 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12033D55E;
	Thu, 11 Jan 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T9lYC5HYcz6J6Zg;
	Thu, 11 Jan 2024 21:16:15 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CD0F140CB1;
	Thu, 11 Jan 2024 21:18:08 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 13:18:07 +0000
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
Subject: [RFC PATCH v5 07/12] cxl/memscrub: Register CXL device patrol scrub with scrub configure driver
Date: Thu, 11 Jan 2024 21:17:36 +0800
Message-ID: <20240111131741.1356-8-shiju.jose@huawei.com>
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
to the user for configuring the CXL device memory patrol scrub. Add the
callback functions to support configuring the CXL memory device patrol
scrub.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/Kconfig         |   6 ++
 drivers/cxl/core/memscrub.c | 201 +++++++++++++++++++++++++++++++++++-
 2 files changed, 204 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 67d88f9bf52b..964b5f789770 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -159,11 +159,17 @@ config CXL_SCRUB
 	bool "CXL: Memory scrub feature"
 	depends on CXL_PCI
 	depends on CXL_MEM
+	depends on SCRUB
 	help
 	  The CXL memory scrub control is an optional feature allows host to
 	  control the scrub configurations of CXL Type 3 devices, which
 	  support patrol scrub and/or DDR5 ECS(Error Check Scrub).
 
+	  Register with the scrub configure driver to expose sysfs attributes
+	  to the user for configuring the CXL device memory patrol and DDR5 ECS
+	  scrubs. Provides the interface functions to support configuring the
+	  CXL memory device patrol and ECS scrubs.
+
 	  Say 'y/n' to enable/disable the CXL memory scrub driver that will
 	  attach to CXL.mem devices for memory scrub control feature. See
 	  sections 8.2.9.9.11.1 and 8.2.9.9.11.2 in the CXL 3.1 specification
diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
index e7741e2fdbdb..48fd02a4bfaf 100644
--- a/drivers/cxl/core/memscrub.c
+++ b/drivers/cxl/core/memscrub.c
@@ -6,14 +6,19 @@
  *
  *  - Provides functions to configure patrol scrub
  *    and DDR5 ECS features of the CXL memory devices.
+ *  - Registers with the scrub driver to expose
+ *    the sysfs attributes to the user for configuring
+ *    the memory patrol scrub and DDR5 ECS features.
  */
 
 #define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
 
 #include <cxlmem.h>
+#include <memory/memory-scrub.h>
 
 /* CXL memory scrub feature common definitions */
 #define CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH	128
+#define CXL_MEMDEV_MAX_NAME_LENGTH	128
 
 static int cxl_mem_get_supported_feature_entry(struct cxl_memdev *cxlmd, const uuid_t *feat_uuid,
 					       struct cxl_mbox_supp_feat_entry *feat_entry_out)
@@ -63,6 +68,8 @@ static int cxl_mem_get_supported_feature_entry(struct cxl_memdev *cxlmd, const u
 #define CXL_MEMDEV_PS_GET_FEAT_VERSION	0x01
 #define CXL_MEMDEV_PS_SET_FEAT_VERSION	0x01
 
+#define CXL_PATROL_SCRUB	"cxl_patrol_scrub"
+
 static const uuid_t cxl_patrol_scrub_uuid =
 	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,     \
 		  0x06, 0xdb, 0x8a);
@@ -159,9 +166,8 @@ static int cxl_mem_ps_get_attrbs(struct device *dev,
 	return 0;
 }
 
-static int __maybe_unused
-cxl_mem_ps_set_attrbs(struct device *dev, struct cxl_memdev_ps_params *params,
-		      u8 param_type)
+static int cxl_mem_ps_set_attrbs(struct device *dev,
+				 struct cxl_memdev_ps_params *params, u8 param_type)
 {
 	struct cxl_memdev_ps_set_feat_pi set_pi = {
 		.pi.uuid = cxl_patrol_scrub_uuid,
@@ -232,11 +238,192 @@ cxl_mem_ps_set_attrbs(struct device *dev, struct cxl_memdev_ps_params *params,
 	return 0;
 }
 
+static int cxl_mem_ps_enable_read(struct device *dev, u64 *val)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_mem_ps_get_attrbs(dev, &params);
+	if (ret) {
+		dev_err(dev, "Get CXL patrol scrub params fail ret=%d\n", ret);
+		return ret;
+	}
+	*val = params.enable;
+
+	return 0;
+}
+
+static int cxl_mem_ps_enable_write(struct device *dev, long val)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
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
+static int cxl_mem_ps_rate_read(struct device *dev, u64 *val)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_mem_ps_get_attrbs(dev, &params);
+	if (ret) {
+		dev_err(dev, "Get CXL patrol scrub params fail ret=%d\n", ret);
+		return ret;
+	}
+	*val = params.rate;
+
+	return 0;
+}
+
+static int cxl_mem_ps_rate_write(struct device *dev, long val)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	params.rate = val;
+	ret = cxl_mem_ps_set_attrbs(dev, &params, CXL_MEMDEV_PS_PARAM_RATE);
+	if (ret) {
+		dev_err(dev, "Set CXL patrol scrub params for rate fail ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_ps_rate_available_read(struct device *dev, char *buf)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_mem_ps_get_attrbs(dev, &params);
+	if (ret) {
+		dev_err(dev, "Get CXL patrol scrub params fail ret=%d\n", ret);
+		return ret;
+	}
+
+	sysfs_emit(buf, "%s\n", params.rate_avail);
+
+	return 0;
+}
+
+/**
+ * cxl_mem_patrol_scrub_is_visible() - Callback to return attribute visibility
+ * @dev: Pointer to scrub device
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+static umode_t cxl_mem_patrol_scrub_is_visible(struct device *dev,
+					       u32 attr_id, int region_id)
+{
+	const struct cxl_patrol_scrub_context *cxl_ps_ctx = dev_get_drvdata(dev);
+
+	if (attr_id == scrub_rate_available ||
+	    attr_id == scrub_rate) {
+		if (!cxl_ps_ctx->scrub_cycle_changeable)
+			return 0;
+	}
+
+	switch (attr_id) {
+	case scrub_rate_available:
+		return 0444;
+	case scrub_enable:
+	case scrub_rate:
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
+static int cxl_mem_patrol_scrub_read(struct device *dev, u32 attr,
+				     int region_id, u64 *val)
+{
+
+	switch (attr) {
+	case scrub_enable:
+		return cxl_mem_ps_enable_read(dev->parent, val);
+	case scrub_rate:
+		return cxl_mem_ps_rate_read(dev->parent, val);
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
+static int cxl_mem_patrol_scrub_write(struct device *dev, u32 attr,
+				      int region_id, u64 val)
+{
+	switch (attr) {
+	case scrub_enable:
+		return cxl_mem_ps_enable_write(dev->parent, val);
+	case scrub_rate:
+		return cxl_mem_ps_rate_write(dev->parent, val);
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
+static int cxl_mem_patrol_scrub_read_strings(struct device *dev, u32 attr,
+					     int region_id, char *buf)
+{
+	switch (attr) {
+	case scrub_rate_available:
+		return cxl_mem_ps_rate_available_read(dev->parent, buf);
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
 int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
 {
+	char scrub_name[CXL_MEMDEV_MAX_NAME_LENGTH];
 	struct cxl_patrol_scrub_context *cxl_ps_ctx;
 	struct cxl_mbox_supp_feat_entry feat_entry;
 	struct cxl_memdev_ps_params params;
+	struct device *cxl_scrub_dev;
 	int ret;
 
 	ret = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_patrol_scrub_uuid,
@@ -261,6 +448,14 @@ int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
 	}
 	cxl_ps_ctx->scrub_cycle_changeable =  params.scrub_cycle_changeable;
 
+	snprintf(scrub_name, sizeof(scrub_name), "%s_%s",
+		 CXL_PATROL_SCRUB, dev_name(&cxlmd->dev));
+	cxl_scrub_dev = devm_scrub_device_register(&cxlmd->dev, scrub_name,
+						   cxl_ps_ctx, &cxl_ps_scrub_ops,
+						   0, NULL);
+	if (IS_ERR(cxl_scrub_dev))
+		return PTR_ERR(cxl_scrub_dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
-- 
2.34.1


