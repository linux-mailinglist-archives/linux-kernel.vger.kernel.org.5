Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ACA7E80EB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjKJSTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346099AbjKJSQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:36 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962E62F375;
        Fri, 10 Nov 2023 03:26:21 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA6P5xS019696;
        Fri, 10 Nov 2023 03:26:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=G8Zkf+yCQVklBhyCYXEXBaArg9LPcowLZdAf12KnmvU=;
 b=D5bbnvdJFVH8OQezTc4vbnJo5URhgRg2iEUrnlcZgHP4LLvBqHktJ3FelMQQz2MWvCz9
 Huivp5pAG16FEfG40+VKswOM5god6G6mpO2nirsFfAlwhCA2Z75syywTB4u9nB/+2OB1
 lpTBduZvR83/V7M0YovDJsspG6mhokJN33o3EainIwPKxb0w5beppwR+MDHmF8sjr0lB
 MNmtZn3mXQQahFCoEgjy/OMI8jTwV/uqtKCEN9paVbaRt0TDryeEiIsWfEGb2U/c9STc
 S96ALJuUcS6c8368XUjLCtWL5v0vV1cySuaXxgMOTlN2P1WchzFw17tD/Rf47ysPp+lh +Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3u9f7x0x8u-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 03:26:04 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 10 Nov
 2023 03:26:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 10 Nov 2023 03:26:02 -0800
Received: from virtx40.. (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id 330793F7052;
        Fri, 10 Nov 2023 03:25:57 -0800 (PST)
From:   Linu Cherian <lcherian@marvell.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Anil Kumar Reddy <areddy3@marvell.com>
Subject: [PATCH v5 2/7] coresight: tmc-etr: Add support to use reserved trace memory
Date:   Fri, 10 Nov 2023 16:55:28 +0530
Message-ID: <20231110112533.2499437-3-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110112533.2499437-1-lcherian@marvell.com>
References: <20231110112533.2499437-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: afUVjej_X2NDqM-IVmJkOUOlnRmnDPHb
X-Proofpoint-ORIG-GUID: afUVjej_X2NDqM-IVmJkOUOlnRmnDPHb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_07,2023-11-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to use reserved memory for coresight ETR trace buffer.

Introduce a new ETR buffer mode called ETR_MODE_RESRV, which
becomes available when ETR device tree node is supplied with a valid
reserved memory region.

ETR_MODE_RESRV can be selected only by explicit user request.

$ echo resrv >/sys/bus/coresight/devices/tmc_etr<N>/buf_mode_preferred

Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v4:
* Mismatch in memory region names in dts binding and driver fixed
* Rename "struct tmc_drvdata" member resrv_buf ->crash_tbuf
  to make the purpose more explicit. Also comments has been updated,
  to reflect this.
  

 .../hwtracing/coresight/coresight-tmc-core.c  | 51 +++++++++++
 .../hwtracing/coresight/coresight-tmc-etr.c   | 87 ++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc.h   | 27 ++++++
 3 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 7ec5365e2b64..224b969d7d90 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
 
@@ -370,6 +371,54 @@ static inline bool tmc_etr_has_non_secure_access(struct tmc_drvdata *drvdata)
 	return (auth & TMC_AUTH_NSID_MASK) == 0x3;
 }
 
+static struct device_node *tmc_get_region_byname(struct device_node *node,
+						 char *name)
+{
+	int index;
+
+	index = of_property_match_string(node, "memory-region-names", name);
+	if (index < 0)
+		return ERR_PTR(-ENODEV);
+
+	return of_parse_phandle(node, "memory-region", index);
+}
+
+static void tmc_get_reserved_region(struct device *parent)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
+	struct device_node *node;
+	struct resource res;
+	int rc;
+
+	node = tmc_get_region_byname(parent->of_node, "tracedata");
+	if (IS_ERR_OR_NULL(node)) {
+		dev_dbg(parent, "No reserved trace buffer specified\n");
+		goto out;
+	}
+
+	rc = of_address_to_resource(node, 0, &res);
+	of_node_put(node);
+	if (rc || res.start == 0 || resource_size(&res) == 0) {
+		dev_err(parent, "Reserved trace buffer memory is invalid\n");
+		goto out;
+	}
+
+	drvdata->crash_tbuf.vaddr = memremap(res.start,
+						resource_size(&res),
+						MEMREMAP_WC);
+	if (IS_ERR_OR_NULL(drvdata->crash_tbuf.vaddr)) {
+		dev_err(parent, "Reserved trace buffer mapping failed\n");
+		rc = PTR_ERR(drvdata->crash_tbuf.vaddr);
+		goto out;
+	}
+
+	drvdata->crash_tbuf.paddr = res.start;
+	drvdata->crash_tbuf.size  = resource_size(&res);
+
+out:
+	return;
+}
+
 /* Detect and initialise the capabilities of a TMC ETR */
 static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
 {
@@ -482,6 +531,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
 	}
 
+	tmc_get_reserved_region(dev);
+
 	desc.dev = dev;
 
 	switch (drvdata->config_type) {
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index af02ba5d5f15..7fd8c4afef74 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -30,6 +30,7 @@ struct etr_buf_hw {
 	bool	has_iommu;
 	bool	has_etr_sg;
 	bool	has_catu;
+	bool	has_resrv;
 };
 
 /*
@@ -694,6 +695,74 @@ static const struct etr_buf_operations etr_flat_buf_ops = {
 	.get_data = tmc_etr_get_data_flat_buf,
 };
 
+/*
+ * tmc_etr_alloc_resrv_buf: Allocate a contiguous DMA buffer from reserved region.
+ */
+static int tmc_etr_alloc_resrv_buf(struct tmc_drvdata *drvdata,
+				  struct etr_buf *etr_buf, int node,
+				  void **pages)
+{
+	struct etr_flat_buf *resrv_buf;
+	struct device *real_dev = drvdata->csdev->dev.parent;
+
+	/* We cannot reuse existing pages for resrv buf */
+	if (pages)
+		return -EINVAL;
+
+	resrv_buf = kzalloc(sizeof(*resrv_buf), GFP_KERNEL);
+	if (!resrv_buf)
+		return -ENOMEM;
+
+	resrv_buf->daddr = dma_map_resource(real_dev, drvdata->crash_tbuf.paddr,
+					   etr_buf->size, DMA_FROM_DEVICE, 0);
+	if (dma_mapping_error(real_dev, resrv_buf->daddr)) {
+		dev_err(real_dev, "failed to map source buffer address\n");
+		kfree(resrv_buf);
+		return -ENOMEM;
+	}
+
+	resrv_buf->vaddr = drvdata->crash_tbuf.vaddr;
+	resrv_buf->size = etr_buf->size;
+	resrv_buf->dev = &drvdata->csdev->dev;
+	etr_buf->hwaddr = resrv_buf->daddr;
+	etr_buf->mode = ETR_MODE_RESRV;
+	etr_buf->private = resrv_buf;
+	return 0;
+}
+
+static void tmc_etr_free_resrv_buf(struct etr_buf *etr_buf)
+{
+	struct etr_flat_buf *resrv_buf = etr_buf->private;
+
+	if (resrv_buf && resrv_buf->daddr) {
+		struct device *real_dev = resrv_buf->dev->parent;
+
+		dma_unmap_resource(real_dev, resrv_buf->daddr,
+				resrv_buf->size, DMA_FROM_DEVICE, 0);
+	}
+	kfree(resrv_buf);
+}
+
+static void tmc_etr_sync_resrv_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
+{
+	/*
+	 * Adjust the buffer to point to the beginning of the trace data
+	 * and update the available trace data.
+	 */
+	etr_buf->offset = rrp - etr_buf->hwaddr;
+	if (etr_buf->full)
+		etr_buf->len = etr_buf->size;
+	else
+		etr_buf->len = rwp - rrp;
+}
+
+static const struct etr_buf_operations etr_resrv_buf_ops = {
+	.alloc = tmc_etr_alloc_resrv_buf,
+	.free = tmc_etr_free_resrv_buf,
+	.sync = tmc_etr_sync_resrv_buf,
+	.get_data = tmc_etr_get_data_flat_buf,
+};
+
 /*
  * tmc_etr_alloc_sg_buf: Allocate an SG buf @etr_buf. Setup the parameters
  * appropriately.
@@ -800,6 +869,7 @@ static const struct etr_buf_operations *etr_buf_ops[] = {
 	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
 	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
 	[ETR_MODE_CATU] = NULL,
+	[ETR_MODE_RESRV] = &etr_resrv_buf_ops
 };
 
 void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu)
@@ -825,6 +895,7 @@ static inline int tmc_etr_mode_alloc_buf(int mode,
 	case ETR_MODE_FLAT:
 	case ETR_MODE_ETR_SG:
 	case ETR_MODE_CATU:
+	case ETR_MODE_RESRV:
 		if (etr_buf_ops[mode] && etr_buf_ops[mode]->alloc)
 			rc = etr_buf_ops[mode]->alloc(drvdata, etr_buf,
 						      node, pages);
@@ -843,6 +914,7 @@ static void get_etr_buf_hw(struct device *dev, struct etr_buf_hw *buf_hw)
 	buf_hw->has_iommu = iommu_get_domain_for_dev(dev->parent);
 	buf_hw->has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
 	buf_hw->has_catu = !!tmc_etr_get_catu_device(drvdata);
+	buf_hw->has_resrv = is_tmc_reserved_region_valid(dev->parent);
 }
 
 static bool etr_can_use_flat_mode(struct etr_buf_hw *buf_hw, ssize_t etr_buf_size)
@@ -874,13 +946,19 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
 	if (!etr_buf)
 		return ERR_PTR(-ENOMEM);
 
-	etr_buf->size = size;
+	/* Overiride the buffer size here for reserved mode */
+	etr_buf->size = (drvdata->etr_mode == ETR_MODE_RESRV) ?
+		drvdata->crash_tbuf.size : size;
 
 	/* If there is user directive for buffer mode, try that first */
 	if (drvdata->etr_mode != ETR_MODE_AUTO)
 		rc = tmc_etr_mode_alloc_buf(drvdata->etr_mode, drvdata,
 					    etr_buf, node, pages);
 
+	/* Fallback mechanism is not valid for reserved mode */
+	if (rc && (drvdata->etr_mode == ETR_MODE_RESRV))
+		goto done;
+
 	/*
 	 * If we have to use an existing list of pages, we cannot reliably
 	 * use a contiguous DMA memory (even if we have an IOMMU). Otherwise,
@@ -902,6 +980,7 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
 	if (rc && buf_hw.has_catu)
 		rc = tmc_etr_mode_alloc_buf(ETR_MODE_CATU, drvdata,
 					    etr_buf, node, pages);
+done:
 	if (rc) {
 		kfree(etr_buf);
 		return ERR_PTR(rc);
@@ -1829,6 +1908,7 @@ static const char *const buf_modes_str[] = {
 	[ETR_MODE_FLAT]		= "flat",
 	[ETR_MODE_ETR_SG]	= "tmc-sg",
 	[ETR_MODE_CATU]		= "catu",
+	[ETR_MODE_RESRV]	= "resrv",
 	[ETR_MODE_AUTO]		= "auto",
 };
 
@@ -1847,6 +1927,9 @@ static ssize_t buf_modes_available_show(struct device *dev,
 	if (buf_hw.has_catu)
 		size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_CATU]);
 
+	if (buf_hw.has_resrv)
+		size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_RESRV]);
+
 	size += sysfs_emit_at(buf, size, "\n");
 	return size;
 }
@@ -1874,6 +1957,8 @@ static ssize_t buf_mode_preferred_store(struct device *dev,
 		drvdata->etr_mode = ETR_MODE_ETR_SG;
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_CATU]) && buf_hw.has_catu)
 		drvdata->etr_mode = ETR_MODE_CATU;
+	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_RESRV]) && buf_hw.has_resrv)
+		drvdata->etr_mode = ETR_MODE_RESRV;
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_AUTO]))
 		drvdata->etr_mode = ETR_MODE_AUTO;
 	else
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 8dcb426ac3e7..10dba9f7d76a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -135,6 +135,7 @@ enum etr_mode {
 	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
 	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
 	ETR_MODE_CATU,		/* Use SG mechanism in CATU */
+	ETR_MODE_RESRV,		/* Use reserved region contiguous buffer */
 	ETR_MODE_AUTO,		/* Use the default mechanism */
 };
 
@@ -164,6 +165,17 @@ struct etr_buf {
 	void				*private;
 };
 
+/**
+ * @paddr	: Start address of reserved memory region.
+ * @vaddr	: Corresponding CPU virtual address.
+ * @size	: Size of reserved memory region.
+ */
+struct tmc_resrv_buf {
+	phys_addr_t     paddr;
+	void		*vaddr;
+	size_t		size;
+};
+
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
  * @base:	memory mapped base address for this component.
@@ -188,6 +200,10 @@ struct etr_buf {
  * @idr_mutex:	Access serialisation for idr.
  * @sysfs_buf:	SYSFS buffer for ETR.
  * @perf_buf:	PERF buffer for ETR.
+ * @crash_tbuf: Used by ETR as hardware trace buffer and for trace data
+ *		retention (after crash) only when ETR_MODE_RESRV buffer
+ *		mode is enabled. Used by ETF for trace data retention
+ *		(after crash) by default.
  */
 struct tmc_drvdata {
 	void __iomem		*base;
@@ -213,6 +229,7 @@ struct tmc_drvdata {
 	struct mutex		idr_mutex;
 	struct etr_buf		*sysfs_buf;
 	struct etr_buf		*perf_buf;
+	struct tmc_resrv_buf	crash_tbuf;
 };
 
 struct etr_buf_operations {
@@ -330,6 +347,16 @@ tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
 	return (unsigned long)sg_table->data_pages.nr_pages << PAGE_SHIFT;
 }
 
+static inline bool is_tmc_reserved_region_valid(struct device *dev)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
+
+	if (drvdata->crash_tbuf.paddr &&
+		drvdata->crash_tbuf.size)
+		return true;
+	return false;
+}
+
 struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
 
 void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
-- 
2.34.1

