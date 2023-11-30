Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309027FFB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376450AbjK3TXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376393AbjK3TX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:23:29 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA9110E3;
        Thu, 30 Nov 2023 11:23:34 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sh5b144hdz67V6P;
        Fri,  1 Dec 2023 03:18:53 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
        by mail.maildlp.com (Postfix) with ESMTPS id AB30714058E;
        Fri,  1 Dec 2023 03:23:32 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 19:23:31 +0000
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
Subject: [PATCH v4 07/11] cxl/memscrub: Register CXL device patrol scrub with scrub configure driver
Date:   Fri, 1 Dec 2023 03:23:09 +0800
Message-ID: <20231130192314.1220-8-shiju.jose@huawei.com>
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

Register with the scrub configure driver to expose the sysfs attributes
to the user for configuring the CXL device memory patrol scrub. Add the
callback functions to support configuring the CXL memory device patrol
scrub.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/Kconfig         |   6 ++
 drivers/cxl/core/memscrub.c | 210 +++++++++++++++++++++++++++++++++++-
 2 files changed, 213 insertions(+), 3 deletions(-)

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
index 7c58d56762b3..4d778ffa3322 100644
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
@@ -63,6 +68,16 @@ static int cxl_mem_get_supported_feature_entry(struct cxl_memdev *cxlmd, const u
 #define CXL_MEMDEV_PS_GET_FEAT_VERSION	0x01
 #define CXL_MEMDEV_PS_SET_FEAT_VERSION	0x01
 
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
 static const uuid_t cxl_patrol_scrub_uuid =
 	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,     \
 		  0x06, 0xdb, 0x8a);
@@ -159,9 +174,8 @@ static int cxl_mem_ps_get_attrbs(struct device *dev,
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
@@ -232,11 +246,193 @@ cxl_mem_ps_set_attrbs(struct device *dev, struct cxl_memdev_ps_params *params,
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
+static int cxl_mem_ps_speed_read(struct device *dev, u64 *val)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	ret = cxl_mem_ps_get_attrbs(dev, &params);
+	if (ret) {
+		dev_err(dev, "Get CXL patrol scrub params fail ret=%d\n", ret);
+		return ret;
+	}
+	*val = params.speed;
+
+	return 0;
+}
+
+static int cxl_mem_ps_speed_write(struct device *dev, long val)
+{
+	struct cxl_memdev_ps_params params;
+	int ret;
+
+	params.speed = val;
+	ret = cxl_mem_ps_set_attrbs(dev, &params, CXL_MEMDEV_PS_PARAM_SPEED);
+	if (ret) {
+		dev_err(dev, "Set CXL patrol scrub params for speed fail ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_ps_speed_available_read(struct device *dev, char *buf)
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
+	sysfs_emit(buf, "%s\n", params.speed_avail);
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
+static umode_t cxl_mem_patrol_scrub_is_visible(const void *drv_data,
+					       u32 attr, int region_id)
+{
+	const struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
+
+	if (attr == scrub_speed_available ||
+	    attr == scrub_speed) {
+		if (!cxl_ps_ctx->scrub_cycle_changeable)
+			return 0;
+	}
+
+	switch (attr) {
+	case scrub_speed_available:
+		return 0444;
+	case scrub_enable:
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
+static int cxl_mem_patrol_scrub_read(struct device *dev, u32 attr,
+				     int region_id, u64 *val)
+{
+
+	switch (attr) {
+	case scrub_enable:
+		return cxl_mem_ps_enable_read(dev->parent, val);
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
+static int cxl_mem_patrol_scrub_write(struct device *dev, u32 attr,
+				      int region_id, u64 val)
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
+static int cxl_mem_patrol_scrub_read_strings(struct device *dev, u32 attr,
+					     int region_id, char *buf)
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
 int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
 {
+	char scrub_name[CXL_MEMDEV_MAX_NAME_LENGTH];
 	struct cxl_patrol_scrub_context *cxl_ps_ctx;
 	struct cxl_mbox_supp_feat_entry feat_entry;
 	struct cxl_memdev_ps_params params;
+	struct device *cxl_scrub_dev;
 	int ret;
 
 	ret = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_patrol_scrub_uuid,
@@ -261,6 +457,14 @@ int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
 	}
 	cxl_ps_ctx->scrub_cycle_changeable =  params.scrub_cycle_changeable;
 
+	snprintf(scrub_name, sizeof(scrub_name), "%s_%s",
+		 CXL_PATROL_SCRUB, dev_name(&cxlmd->dev));
+	cxl_scrub_dev = devm_scrub_device_register(&cxlmd->dev, scrub_name,
+						   cxl_ps_ctx, &cxl_ps_scrub_ops,
+						   CXL_MEMDEV_PATROL_SCRUB_NUM_REGIONS);
+	if (IS_ERR(cxl_scrub_dev))
+		return PTR_ERR(cxl_scrub_dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
-- 
2.34.1

