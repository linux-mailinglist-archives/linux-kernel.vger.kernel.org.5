Return-Path: <linux-kernel+bounces-66761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A65585613A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AEE1F24177
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEE312D74F;
	Thu, 15 Feb 2024 11:15:16 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F0412C532;
	Thu, 15 Feb 2024 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995715; cv=none; b=E6NohPQ9AH3dpBl+TChsqB9mbZ+0xg5gmASpqE7UHwcTDW6U696vwtyad+UafFafegKm+I4oCuU4qid/NH+PT8o0wD+S8qHPXMa1/OGIa5dL93KUNywfIPEvm9TzcmUX4a+ARxPV3/jjgQnFloxiNkqcN7SdDJxfXsCyN1QUOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995715; c=relaxed/simple;
	bh=2ZqvWaibSJUGCap2j4MZEnm9w210JyUd2HxsQ8YYE3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pwe7UKdaeDJz80Q0unEsuAlslTwMHNecHZr8Bm2T2gVwwMiVZEeZ2XTNHaCo8HnvjLR0NWM503IW5Tblt4XZs6t4p1n0RfUapC+eGSC4bN8ie7vyoajvZ1+eNhJV8Je+1ysHccHOC4SW0y3MZY2IxQgJriz+MEG3sV2vbqsYgnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbC7N09lhz6K8sv;
	Thu, 15 Feb 2024 19:11:44 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 84C721400D4;
	Thu, 15 Feb 2024 19:15:11 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:15:10 +0000
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
Subject: [RFC PATCH v6 07/12] cxl/memscrub: Register CXL device patrol scrub with scrub configure driver
Date: Thu, 15 Feb 2024 19:14:49 +0800
Message-ID: <20240215111455.1462-8-shiju.jose@huawei.com>
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
index 873bdda5db32..ec9a1877b663 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -162,11 +162,17 @@ config CXL_SCRUB
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
index a3a371c5aa7b..a1fb40f8307f 100644
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
 #define CXL_SCRUB_MAX_ATTR_RANGE_LENGTH	128
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
@@ -159,9 +166,8 @@ static int cxl_mem_ps_get_attrs(struct device *dev,
 	return 0;
 }
 
-static int __maybe_unused
-cxl_mem_ps_set_attrs(struct device *dev, struct cxl_memdev_ps_params *params,
-		     u8 param_type)
+static int cxl_mem_ps_set_attrs(struct device *dev,
+				struct cxl_memdev_ps_params *params, u8 param_type)
 {
 	struct cxl_memdev_ps_set_feat_pi set_pi = {
 		.pi.uuid = cxl_patrol_scrub_uuid,
@@ -232,11 +238,192 @@ cxl_mem_ps_set_attrs(struct device *dev, struct cxl_memdev_ps_params *params,
 	return 0;
 }
 
+static int cxl_mem_ps_enable_read(struct device *dev, u64 *val)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_mem_ps_get_attrs(dev, &params);
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
+	ret = cxl_mem_ps_set_attrs(dev, &params, CXL_MEMDEV_PS_PARAM_ENABLE);
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
+	ret = cxl_mem_ps_get_attrs(dev, &params);
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
+	ret = cxl_mem_ps_set_attrs(dev, &params, CXL_MEMDEV_PS_PARAM_RATE);
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
+	ret = cxl_mem_ps_get_attrs(dev, &params);
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


