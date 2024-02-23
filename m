Return-Path: <linux-kernel+bounces-78496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABF6861429
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0AA1F245FF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19537823BD;
	Fri, 23 Feb 2024 14:37:50 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B407BAFD;
	Fri, 23 Feb 2024 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699069; cv=none; b=ZbC4LzPMEuMRKenSqBP3qIiOgLJchwqKjRjnwdGD0uVdGgHjlyhjMqUas2NPBbXsu3C3drmFCTldWoeLktMpmvUm+ON3oHCmaap1WwDZ6VafESglyj02d4oDZDDjvAjjdymSGf3suVVkzfnpK00s1C+6nK66PwTut1+Mmfl+4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699069; c=relaxed/simple;
	bh=8cGsSvfUZ9ecxlFhWZPPuPn8TOgCRhs193A2vjRRb54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJK5yjKjMjA7N5O9sxx5JamroJ6r8Y84spDz+EKrA4NBGBdf8CX6HBPar1G+7X/4ei6Rq9Gojnti0ZPvFSNotixQxb4blyTIgYnLxEflrlMRkdqfXmenj4IzDCMuN7udKGK5zlRO5vqdK15l2w0AVJ8Fdu/zJRMrZat4U9rlUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThCF94lsDz6K8xl;
	Fri, 23 Feb 2024 22:34:05 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id B8F98141B80;
	Fri, 23 Feb 2024 22:37:44 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 14:37:43 +0000
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
Subject: [RFC PATCH v7 07/12] cxl/memscrub: Register CXL device patrol scrub with scrub subsystem driver
Date: Fri, 23 Feb 2024 22:37:18 +0800
Message-ID: <20240223143723.1574-8-shiju.jose@huawei.com>
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
to the user for configuring the CXL device memory patrol scrub.
Add the callback functions to support configuring the CXL memory device
patrol scrub.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/Kconfig         |   6 ++
 drivers/cxl/core/memscrub.c | 199 +++++++++++++++++++++++++++++++++++-
 2 files changed, 202 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index e61c69fa7bf5..a0fe68b83cd0 100644
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
index 61a77fabca13..b053dcb9197e 100644
--- a/drivers/cxl/core/memscrub.c
+++ b/drivers/cxl/core/memscrub.c
@@ -6,14 +6,19 @@
  *
  *  - Provides functions to configure patrol scrub and DDR5 ECS features
  *    of the CXL memory devices.
+ *  - Registers with the scrub subsystem driver to expose the sysfs attributes
+ *    to the user for configuring the memory patrol scrub and DDR5 ECS features.
+
  */
 
 #define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
 
 #include <cxlmem.h>
+#include <memory/memory-scrub.h>
 
 /* CXL memory scrub feature common definitions */
 #define CXL_SCRUB_MAX_ATTR_RANGE_LENGTH	128
+#define CXL_MEMDEV_MAX_NAME_LENGTH     128
 
 static int cxl_mem_get_supported_feature_entry(struct cxl_memdev *cxlmd, const uuid_t *feat_uuid,
 					       struct cxl_mbox_supp_feat_entry *feat_entry_out)
@@ -157,9 +162,8 @@ static int cxl_mem_ps_get_attrs(struct device *dev,
 	return 0;
 }
 
-static int __maybe_unused
-cxl_mem_ps_set_attrs(struct device *dev, struct cxl_memdev_ps_params *params,
-		     u8 param_type)
+static int cxl_mem_ps_set_attrs(struct device *dev, struct cxl_memdev_ps_params *params,
+				u8 param_type)
 {
 	struct cxl_memdev_ps_wr_attrs wr_attrs;
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -215,11 +219,192 @@ cxl_mem_ps_set_attrs(struct device *dev, struct cxl_memdev_ps_params *params,
 	return 0;
 }
 
+static int cxl_mem_ps_enable_read(struct device *dev, u64 *val)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_mem_ps_get_attrs(dev, &params);
+	if (ret) {
+		dev_err(dev, "Get CXL patrol scrub params failed ret=%d\n", ret);
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
+		dev_err(dev, "CXL patrol scrub enable failed, enable=%d ret=%d\n",
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
+		dev_err(dev, "Get CXL patrol scrub params failed ret=%d\n", ret);
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
+		dev_err(dev, "Set CXL patrol scrub params for rate failed ret=%d\n", ret);
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
+		dev_err(dev, "Get CXL patrol scrub params failed ret=%d\n", ret);
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
+ * @mode: attribute's mode
+ * @region_id: ID of the memory region
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+static umode_t cxl_mem_patrol_scrub_is_visible(struct device *dev, u32 attr_id,
+					       umode_t mode, int region_id)
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
+	case scrub_enable:
+	case scrub_rate:
+		return mode;
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
+		return -EOPNOTSUPP;
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
+		return -EOPNOTSUPP;
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
+		return -EOPNOTSUPP;
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
@@ -243,6 +428,14 @@ int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
 	cxl_ps_ctx->set_feat_size = feat_entry.set_size;
 	cxl_ps_ctx->scrub_cycle_changeable =  params.scrub_cycle_changeable;
 
+	snprintf(scrub_name, sizeof(scrub_name), "%s_%s",
+		 "cxl_patrol_scrub", dev_name(&cxlmd->dev));
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


