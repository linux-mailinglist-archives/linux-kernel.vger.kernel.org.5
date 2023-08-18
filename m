Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749E6780707
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358549AbjHRIVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358559AbjHRIVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:21:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F639E55
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:21:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AF68D75;
        Fri, 18 Aug 2023 01:22:08 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3BBB93F762;
        Fri, 18 Aug 2023 01:21:25 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] coresight: tmc: Make etr buffer mode user configurable from sysfs
Date:   Fri, 18 Aug 2023 13:51:12 +0530
Message-Id: <20230818082112.554638-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
if required. This adds following new sysfs files for buffer mode selection
purpose explicitly in the user space.

/sys/bus/coresight/devices/tmc_etr<N>/buf_modes_available
/sys/bus/coresight/devices/tmc_etr<N>/buf_mode_preferred

$ cat buf_modes_available
auto flat tmc-sg catu	------------------> Supported TMC-ETR buffer modes

$ echo catu > buf_mode_preferred   -------> Explicit buffer mode request

But explicit user request has to be within supported ETR buffer modes only.
These sysfs interface files are exclussive to ETR, and hence these are not
available for other TMC devices such as ETB or ETF etc.

A new auto' mode (i.e ETR_MODE_AUTO) has been added to help fallback to the
existing default behaviour, when user provided preferred buffer mode fails.
ETR_MODE_FLAT and ETR_MODE_AUTO are always available as preferred modes.

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
This applies on v6.5-rc6

Changes in V2:

- Renamed sysfs file etr_buf_modes_available as buf_modes_available
- Renamed sysfs file buf_mode_current as buf_mode_preferred
- Renamed etr_supports_flat_mode() as etr_can_use_flat_mode()
- Renamed coresight_tmc_groups[] as coresight_etf_groups[]
- Reused coresight_tmc_group[] for trigger_cntr and buffer_size
- Fallback trying ETR_MODE_AUTO when user preferred mode fails
- Moved ETR sysfs details into coresight-tmc-etr.c
- Dropped etr_can_use_flat_mode() check while offering ETR_MODE_FLAT in sysfs
- Moved struct etr_buf_hw inside coresight-tmc-etr.c
- Moved get_etr_buf_hw() and etr_can_use_flat_mode() inside coresight-tmc-etr.c
- Updated month in Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc

Changes in V1:

https://lore.kernel.org/all/20230728084837.276551-1-anshuman.khandual@arm.com/

 .../testing/sysfs-bus-coresight-devices-tmc   |  16 +++
 .../hwtracing/coresight/coresight-tmc-core.c  |  15 ++-
 .../hwtracing/coresight/coresight-tmc-etr.c   | 111 ++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.h   |   3 +
 4 files changed, 131 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
index 6aa527296c71..50833ce97300 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
@@ -91,3 +91,19 @@ Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
 Description:	(RW) Size of the trace buffer for TMC-ETR when used in SYSFS
 		mode. Writable only for TMC-ETR configurations. The value
 		should be aligned to the kernel pagesize.
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/buf_modes_available
+Date:		August 2023
+KernelVersion:	6.6
+Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
+Description:	(Read) Shows all supported Coresight TMC-ETR buffer modes available
+		for the users to configure explicitly. This file is avaialble only
+		for TMC ETR devices.
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/buf_mode_preferred
+Date:		August 2023
+KernelVersion:	6.6
+Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
+Description:	(RW) Current Coresight TMC-ETR buffer mode selected. But user could
+		only provide a mode which is supported for a given ETR device. This
+		file is available only for TMC ETR devices.
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index c106d142e632..7ec5365e2b64 100644
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
@@ -344,7 +345,14 @@ static const struct attribute_group coresight_tmc_mgmt_group = {
 	.name = "mgmt",
 };
 
-static const struct attribute_group *coresight_tmc_groups[] = {
+static const struct attribute_group *coresight_etf_groups[] = {
+	&coresight_tmc_group,
+	&coresight_tmc_mgmt_group,
+	NULL,
+};
+
+static const struct attribute_group *coresight_etr_groups[] = {
+	&coresight_etr_group,
 	&coresight_tmc_group,
 	&coresight_tmc_mgmt_group,
 	NULL,
@@ -465,6 +473,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->memwidth = tmc_get_memwidth(devid);
 	/* This device is not associated with a session */
 	drvdata->pid = -1;
+	drvdata->etr_mode = ETR_MODE_AUTO;
 
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
 		drvdata->size = tmc_etr_get_default_buffer_size(dev);
@@ -474,16 +483,17 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	desc.dev = dev;
-	desc.groups = coresight_tmc_groups;
 
 	switch (drvdata->config_type) {
 	case TMC_CONFIG_TYPE_ETB:
+		desc.groups = coresight_etf_groups;
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
@@ -496,6 +506,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		dev_list = &etr_devs;
 		break;
 	case TMC_CONFIG_TYPE_ETF:
+		desc.groups = coresight_etf_groups;
 		desc.type = CORESIGHT_DEV_TYPE_LINKSINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 		desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 766325de0e29..52ce24afa323 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -26,6 +26,12 @@ struct etr_flat_buf {
 	size_t		size;
 };
 
+struct etr_buf_hw {
+	bool	has_iommu;
+	bool	has_etr_sg;
+	bool	has_catu;
+};
+
 /*
  * etr_perf_buffer - Perf buffer used for ETR
  * @drvdata		- The ETR drvdaga this buffer has been allocated for.
@@ -828,6 +834,22 @@ static inline int tmc_etr_mode_alloc_buf(int mode,
 	}
 }
 
+static void get_etr_buf_hw(struct device *dev, struct etr_buf_hw *buf_hw)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	buf_hw->has_iommu = iommu_get_domain_for_dev(dev->parent);
+	buf_hw->has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
+	buf_hw->has_catu = !!tmc_etr_get_catu_device(drvdata);
+}
+
+static bool etr_can_use_flat_mode(struct etr_buf_hw *buf_hw, ssize_t etr_buf_size)
+{
+	bool has_sg = buf_hw->has_catu || buf_hw->has_etr_sg;
+
+	return !has_sg || buf_hw->has_iommu || etr_buf_size < SZ_1M;
+}
+
 /*
  * tmc_alloc_etr_buf: Allocate a buffer use by ETR.
  * @drvdata	: ETR device details.
@@ -841,23 +863,22 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
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
+	if (drvdata->etr_mode != ETR_MODE_AUTO)
+		rc = tmc_etr_mode_alloc_buf(drvdata->etr_mode, drvdata,
+					    etr_buf, node, pages);
+
 	/*
 	 * If we have to use an existing list of pages, we cannot reliably
 	 * use a contiguous DMA memory (even if we have an IOMMU). Otherwise,
@@ -870,14 +891,13 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
 	 * Fallback to available mechanisms.
 	 *
 	 */
-	if (!pages &&
-	    (!has_sg || has_iommu || size < SZ_1M))
+	if (rc && !pages && etr_can_use_flat_mode(&buf_hw, size))
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
@@ -1800,3 +1820,70 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 
 	return 0;
 }
+
+static const char *const buf_modes_str[] = {
+	[ETR_MODE_FLAT]		= "flat",
+	[ETR_MODE_ETR_SG]	= "tmc-sg",
+	[ETR_MODE_CATU]		= "catu",
+	[ETR_MODE_AUTO]		= "auto",
+};
+
+static ssize_t buf_modes_available_show(struct device *dev,
+					    struct device_attribute *attr, char *buf)
+{
+	struct etr_buf_hw buf_hw;
+	ssize_t size = 0;
+
+	get_etr_buf_hw(dev, &buf_hw);
+	size += sysfs_emit(buf, "%s ", buf_modes_str[ETR_MODE_AUTO]);
+	size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_FLAT]);
+	if (buf_hw.has_etr_sg)
+		size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_ETR_SG]);
+
+	if (buf_hw.has_catu)
+		size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_CATU]);
+
+	size += sysfs_emit_at(buf, size, "\n");
+	return size;
+}
+static DEVICE_ATTR_RO(buf_modes_available);
+
+static ssize_t buf_mode_preferred_show(struct device *dev,
+					 struct device_attribute *attr, char *buf)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%s\n", buf_modes_str[drvdata->etr_mode]);
+}
+
+static ssize_t buf_mode_preferred_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t size)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etr_buf_hw buf_hw;
+
+	get_etr_buf_hw(dev, &buf_hw);
+	if (sysfs_streq(buf, buf_modes_str[ETR_MODE_FLAT]))
+		drvdata->etr_mode = ETR_MODE_FLAT;
+	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_ETR_SG]) && buf_hw.has_etr_sg)
+		drvdata->etr_mode = ETR_MODE_ETR_SG;
+	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_CATU]) && buf_hw.has_catu)
+		drvdata->etr_mode = ETR_MODE_CATU;
+	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_AUTO]))
+		drvdata->etr_mode = ETR_MODE_AUTO;
+	else
+		return -EINVAL;
+	return size;
+}
+static DEVICE_ATTR_RW(buf_mode_preferred);
+
+static struct attribute *coresight_etr_attrs[] = {
+	&dev_attr_buf_modes_available.attr,
+	&dev_attr_buf_mode_preferred.attr,
+	NULL,
+};
+
+const struct attribute_group coresight_etr_group = {
+	.attrs = coresight_etr_attrs,
+};
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index b97da39652d2..e59d423a9749 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -135,6 +135,7 @@ enum etr_mode {
 	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
 	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
 	ETR_MODE_CATU,		/* Use SG mechanism in CATU */
+	ETR_MODE_AUTO,		/* Use the default mechanism */
 };
 
 struct etr_buf_operations;
@@ -207,6 +208,7 @@ struct tmc_drvdata {
 	enum tmc_mem_intf_width	memwidth;
 	u32			trigger_cntr;
 	u32			etr_caps;
+	enum etr_mode		etr_mode;
 	struct idr		idr;
 	struct mutex		idr_mutex;
 	struct etr_buf		*sysfs_buf;
@@ -334,5 +336,6 @@ void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
 void tmc_etr_remove_catu_ops(void);
 struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
 				   enum cs_mode mode, void *data);
+extern const struct attribute_group coresight_etr_group;
 
 #endif
-- 
2.25.1

