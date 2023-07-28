Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E9E7667BD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjG1Ivj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbjG1IvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:51:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3A8D2D5E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:49:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A3A12F4;
        Fri, 28 Jul 2023 01:49:32 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.51.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62A923F67D;
        Fri, 28 Jul 2023 01:48:46 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: tmc: Make etr buffer mode user configurable from sysfs
Date:   Fri, 28 Jul 2023 14:18:37 +0530
Message-Id: <20230728084837.276551-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently TMC-ETR automatically selects the buffer mode from all available
methods in the following sequentially fallback manner - also in that order.

1. FLAT mode with or without IOMMU
2. TMC-ETR-SG (scatter gather) mode when available
3. CATU mode when available

But this order might not be ideal for all situations. For example if there
is a CATU connected to ETR, it may be better to use TMC-ETR scatter gather
method, rather than CATU. But hard coding such order changes will prevent
us from testing or using a particular mode. This change provides following
new sysfs tunables for the user to control TMC-ETR buffer mode explicitly,
if required.

/sys/bus/coresight/devices/tmc_etr<N>/etr_buf_modes_available
/sys/bus/coresight/devices/tmc_etr<N>/etr_buf_mode_current

$ cat etr_buf_modes_available
auto flat tmc-sg catu	------------------> Supported TMC-ETR buffer modes
$ echo catu > etr_buf_mode_current -------> Explicit buffer mode request

But explicit user request has to be within supported ETR buffer modes only.
These sysfs interface files are exclussive to ETR, and hence not available
for other TMC devices such as ETB or ETF etc. This required separating out
new 'coresight_etr_groups' from common 'coresight_tmc_groups'.

This adds a new element 'etr_mode' in 'struct tmc_drvdata' which will track
such explicit user directives. 'auto' mode has been added to help fallback
to the existing default behaviour. ETR_MODE_FLAT mode availability follows
existing logic as in tmc_alloc_etr_buf() creating a common helper function
i.e etr_supports_flat_mode().

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 .../testing/sysfs-bus-coresight-devices-tmc   |  16 +++
 .../hwtracing/coresight/coresight-tmc-core.c  | 103 +++++++++++++++++-
 .../hwtracing/coresight/coresight-tmc-etr.c   |  27 +++--
 drivers/hwtracing/coresight/coresight-tmc.h   |  10 ++
 4 files changed, 143 insertions(+), 13 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
index 6aa527296c71..956a2f090950 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
@@ -91,3 +91,19 @@ Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
 Description:	(RW) Size of the trace buffer for TMC-ETR when used in SYSFS
 		mode. Writable only for TMC-ETR configurations. The value
 		should be aligned to the kernel pagesize.
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/etr_buf_modes_available
+Date:		July 2023
+KernelVersion:	6.6
+Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
+Description:	(Read) Shows all supported Coresight TMC-ETR buffer modes available
+		for the users to configure explicitly. This file is avaialble only
+		for TMC ETR devices.
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/etr_buf_mode_current
+Date:		July 2023
+KernelVersion:	6.6
+Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
+Description:	(RW) Current Coresight TMC-ETR buffer mode selected. But user could
+		only provide a mode which is supported for a given ETR device. This
+		file is available only for TMC ETR devices.
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index c106d142e632..ce97ff5e0997 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/io.h>
+#include <linux/iommu.h>
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
@@ -329,6 +330,85 @@ static ssize_t buffer_size_store(struct device *dev,
 
 static DEVICE_ATTR_RW(buffer_size);
 
+static const char *const buf_modes_str[] = {
+	[ETR_MODE_FLAT]		= "flat",
+	[ETR_MODE_ETR_SG]	= "tmc-sg",
+	[ETR_MODE_CATU]		= "catu",
+	[ETR_MODE_AUTO]		= "auto",
+};
+
+void get_etr_buf_hw(struct device *dev, struct etr_buf_hw *buf_hw)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	buf_hw->has_iommu = iommu_get_domain_for_dev(dev->parent);
+	buf_hw->has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
+	buf_hw->has_catu = !!tmc_etr_get_catu_device(drvdata);
+}
+
+bool etr_supports_flat_mode(struct etr_buf_hw *buf_hw, ssize_t etr_buf_size)
+{
+	bool has_sg = buf_hw->has_catu || buf_hw->has_etr_sg;
+
+	return !has_sg || buf_hw->has_iommu || etr_buf_size < SZ_1M;
+}
+
+static ssize_t etr_buf_modes_available_show(struct device *dev,
+					    struct device_attribute *attr, char *buf)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etr_buf_hw buf_hw;
+	ssize_t size = 0;
+
+	get_etr_buf_hw(dev, &buf_hw);
+	size += sysfs_emit(buf, "%s ", buf_modes_str[ETR_MODE_AUTO]);
+	if (etr_supports_flat_mode(&buf_hw, drvdata->size))
+		size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_FLAT]);
+
+	if (buf_hw.has_etr_sg)
+		size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_ETR_SG]);
+
+	if (buf_hw.has_catu)
+		size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_CATU]);
+
+	size += sysfs_emit_at(buf, size, "\n");
+	return size;
+}
+static DEVICE_ATTR_RO(etr_buf_modes_available);
+
+static ssize_t etr_buf_mode_current_show(struct device *dev,
+					 struct device_attribute *attr, char *buf)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%s\n", buf_modes_str[drvdata->etr_mode]);
+}
+
+static ssize_t etr_buf_mode_current_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t size)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etr_buf_hw buf_hw;
+
+	get_etr_buf_hw(dev, &buf_hw);
+	if (sysfs_streq(buf, buf_modes_str[ETR_MODE_FLAT]) &&
+	    etr_supports_flat_mode(&buf_hw, drvdata->size))
+		drvdata->etr_mode = ETR_MODE_FLAT;
+	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_ETR_SG]) && buf_hw.has_etr_sg)
+		drvdata->etr_mode = ETR_MODE_ETR_SG;
+	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_CATU]) && buf_hw.has_catu)
+		drvdata->etr_mode = ETR_MODE_CATU;
+	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_AUTO]))
+		drvdata->etr_mode = ETR_MODE_AUTO;
+	else
+		return -EINVAL;
+
+	return size;
+
+}
+static DEVICE_ATTR_RW(etr_buf_mode_current);
+
 static struct attribute *coresight_tmc_attrs[] = {
 	&dev_attr_trigger_cntr.attr,
 	&dev_attr_buffer_size.attr,
@@ -350,6 +430,24 @@ static const struct attribute_group *coresight_tmc_groups[] = {
 	NULL,
 };
 
+static struct attribute *coresight_etr_attrs[] = {
+	&dev_attr_trigger_cntr.attr,
+	&dev_attr_buffer_size.attr,
+	&dev_attr_etr_buf_modes_available.attr,
+	&dev_attr_etr_buf_mode_current.attr,
+	NULL,
+};
+
+static const struct attribute_group coresight_etr_group = {
+	.attrs = coresight_etr_attrs,
+};
+
+static const struct attribute_group *coresight_etr_groups[] = {
+	&coresight_etr_group,
+	&coresight_tmc_mgmt_group,
+	NULL,
+};
+
 static inline bool tmc_etr_can_use_sg(struct device *dev)
 {
 	return fwnode_property_present(dev->fwnode, "arm,scatter-gather");
@@ -465,6 +563,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->memwidth = tmc_get_memwidth(devid);
 	/* This device is not associated with a session */
 	drvdata->pid = -1;
+	drvdata->etr_mode = ETR_MODE_AUTO;
 
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
 		drvdata->size = tmc_etr_get_default_buffer_size(dev);
@@ -474,16 +573,17 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	desc.dev = dev;
-	desc.groups = coresight_tmc_groups;
 
 	switch (drvdata->config_type) {
 	case TMC_CONFIG_TYPE_ETB:
+		desc.groups = coresight_tmc_groups;
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 		desc.ops = &tmc_etb_cs_ops;
 		dev_list = &etb_devs;
 		break;
 	case TMC_CONFIG_TYPE_ETR:
+		desc.groups = coresight_etr_groups;
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
 		desc.ops = &tmc_etr_cs_ops;
@@ -496,6 +596,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		dev_list = &etr_devs;
 		break;
 	case TMC_CONFIG_TYPE_ETF:
+		desc.groups = coresight_tmc_groups;
 		desc.type = CORESIGHT_DEV_TYPE_LINKSINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 		desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 766325de0e29..d48455188243 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -841,23 +841,27 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
 					 int node, void **pages)
 {
 	int rc = -ENOMEM;
-	bool has_etr_sg, has_iommu;
-	bool has_sg, has_catu;
 	struct etr_buf *etr_buf;
+	struct etr_buf_hw buf_hw;
 	struct device *dev = &drvdata->csdev->dev;
 
-	has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
-	has_iommu = iommu_get_domain_for_dev(dev->parent);
-	has_catu = !!tmc_etr_get_catu_device(drvdata);
-
-	has_sg = has_catu || has_etr_sg;
-
+	get_etr_buf_hw(dev, &buf_hw);
 	etr_buf = kzalloc(sizeof(*etr_buf), GFP_KERNEL);
 	if (!etr_buf)
 		return ERR_PTR(-ENOMEM);
 
 	etr_buf->size = size;
 
+	/* If there is user directive for buffer mode, try that first */
+	if (drvdata->etr_mode != ETR_MODE_AUTO) {
+		rc = tmc_etr_mode_alloc_buf(drvdata->etr_mode, drvdata,
+					    etr_buf, node, pages);
+		if (rc) {
+			kfree(etr_buf);
+			return ERR_PTR(rc);
+		}
+	}
+
 	/*
 	 * If we have to use an existing list of pages, we cannot reliably
 	 * use a contiguous DMA memory (even if we have an IOMMU). Otherwise,
@@ -870,14 +874,13 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
 	 * Fallback to available mechanisms.
 	 *
 	 */
-	if (!pages &&
-	    (!has_sg || has_iommu || size < SZ_1M))
+	if (!pages && etr_supports_flat_mode(&buf_hw, size))
 		rc = tmc_etr_mode_alloc_buf(ETR_MODE_FLAT, drvdata,
 					    etr_buf, node, pages);
-	if (rc && has_etr_sg)
+	if (rc && buf_hw.has_etr_sg)
 		rc = tmc_etr_mode_alloc_buf(ETR_MODE_ETR_SG, drvdata,
 					    etr_buf, node, pages);
-	if (rc && has_catu)
+	if (rc && buf_hw.has_catu)
 		rc = tmc_etr_mode_alloc_buf(ETR_MODE_CATU, drvdata,
 					    etr_buf, node, pages);
 	if (rc) {
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index b97da39652d2..ca15ccb1d807 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -135,6 +135,13 @@ enum etr_mode {
 	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
 	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
 	ETR_MODE_CATU,		/* Use SG mechanism in CATU */
+	ETR_MODE_AUTO,		/* Use the default mechanism */
+};
+
+struct etr_buf_hw {
+	bool	has_iommu;
+	bool	has_etr_sg;
+	bool	has_catu;
 };
 
 struct etr_buf_operations;
@@ -207,6 +214,7 @@ struct tmc_drvdata {
 	enum tmc_mem_intf_width	memwidth;
 	u32			trigger_cntr;
 	u32			etr_caps;
+	enum etr_mode		etr_mode;
 	struct idr		idr;
 	struct mutex		idr_mutex;
 	struct etr_buf		*sysfs_buf;
@@ -334,5 +342,7 @@ void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
 void tmc_etr_remove_catu_ops(void);
 struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
 				   enum cs_mode mode, void *data);
+void get_etr_buf_hw(struct device *dev, struct etr_buf_hw *buf_hw);
+bool etr_supports_flat_mode(struct etr_buf_hw *buf_hw, ssize_t etr_buf_size);
 
 #endif
-- 
2.25.1

