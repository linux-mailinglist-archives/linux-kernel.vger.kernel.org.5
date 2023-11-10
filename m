Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFECE7E807C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344819AbjKJSMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345632AbjKJSLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:11:16 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708262F37A;
        Fri, 10 Nov 2023 03:26:22 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA6PAcp019808;
        Fri, 10 Nov 2023 03:26:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=zl2HlKcr5Pt6RTNEFcpgQxr4W363o91/P/S7ozU/UBw=;
 b=J2L2QbR5/uATQMOYMba8PKJIcHJduUZNYMqlmsctTesOt9JWu3KjyeIgWRDW306JEwbw
 8Y+OSYmKH5940vKhZ79tJf0cRpo/7z6C8dZpz6lcaDtTkUwiyUpEAQRTyI2bXv9PosyK
 yvowvAhchyHVPraqqXsBv7vYVVg5/8ZMAJ8OmeDPFBhb1Y2C/BwTxOj/wlHb5jYo8Trz
 fQNK4dOFsbw2EgJU/NHn8GY2FL5OgOj3Ki3Cmb0stB8AFNJbW1bPFFTeFpj1PbOclUEg
 7hTAmNn1EIlT8vKsbe1FkeDO3JmEhDavL4J7Or8vyYA7qXdxK4OYEiiG/J9X5cyixzLl eg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3u9f7x0x92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 03:26:13 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 10 Nov
 2023 03:26:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 10 Nov 2023 03:26:11 -0800
Received: from virtx40.. (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id A73543F7052;
        Fri, 10 Nov 2023 03:26:07 -0800 (PST)
From:   Linu Cherian <lcherian@marvell.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH] coresight: tmc: Enable panic sync handling
Date:   Fri, 10 Nov 2023 16:55:30 +0530
Message-ID: <20231110112533.2499437-5-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110112533.2499437-1-lcherian@marvell.com>
References: <20231110112533.2499437-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7Y-ewXtvt5pSy_8TXanMQMrJbcQ7Nl3J
X-Proofpoint-ORIG-GUID: 7Y-ewXtvt5pSy_8TXanMQMrJbcQ7Nl3J
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

- Get reserved region from device tree node for metadata
- Define metadata format for TMC
- Add TMC ETR panic sync handler that syncs register snapshot
  to metadata region
- Add TMC ETF panic sync handler that syncs register snapshot
  to metadata region and internal SRAM to reserved trace buffer
  region.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v4:
* Added crc32 computation for ETR/ETF crash metadata and tracedata 
* Size field in "struct tmc_crash_metadata" refers to RSZ register and hence
  indicates the size in 32 bit words. ETR metadata follows this convention, the same
  has been extended to ETF metadata as well. 
* "struct tmc_drvdata"
   - Rename field metadata -> crash_mdata to make the purpose explicit
   - Comments has been updated on the usage of crash_mdata
* "struct tmc_crash_metadata"
   - comments updated to identify fields that are register snapshots  
* Reuse macro, "is_tmc_reserved_region_valid" for validation checks
* Use boolean (true/false) for mdata->valid initialization


 .../hwtracing/coresight/coresight-tmc-core.c  | 26 ++++++++
 .../hwtracing/coresight/coresight-tmc-etf.c   | 65 +++++++++++++++++++
 .../hwtracing/coresight/coresight-tmc-etr.c   | 60 +++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h   | 42 +++++++++++-
 4 files changed, 192 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 224b969d7d90..4d7530d6ac91 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -415,6 +415,32 @@ static void tmc_get_reserved_region(struct device *parent)
 	drvdata->crash_tbuf.paddr = res.start;
 	drvdata->crash_tbuf.size  = resource_size(&res);
 
+	/* Metadata region */
+	node = tmc_get_region_byname(parent->of_node, "metadata");
+	if (IS_ERR_OR_NULL(node)) {
+		dev_dbg(parent, "No metadata memory-region specified\n");
+		goto out;
+	}
+
+	rc = of_address_to_resource(node, 0, &res);
+	of_node_put(node);
+	if (rc || res.start == 0 || resource_size(&res) == 0) {
+		dev_err(parent, "Metadata memory is invalid\n");
+		goto out;
+	}
+
+	drvdata->crash_mdata.vaddr = memremap(res.start,
+					       resource_size(&res),
+					       MEMREMAP_WC);
+	if (IS_ERR_OR_NULL(drvdata->crash_mdata.vaddr)) {
+		dev_err(parent, "Metadata memory mapping failed\n");
+		rc = PTR_ERR(drvdata->crash_mdata.vaddr);
+		goto out;
+	}
+
+	drvdata->crash_mdata.paddr = res.start;
+	drvdata->crash_mdata.size  = resource_size(&res);
+
 out:
 	return;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 7406b65e2cdd..b53cef7628ff 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -588,6 +588,66 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	return to_read;
 }
 
+static int tmc_panic_sync_etf(struct coresight_device *csdev)
+{
+	u32 val;
+	struct csdev_access *csa;
+	struct tmc_crash_metadata *mdata;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	csa = &drvdata->csdev->access;
+
+	/* Make sure we have valid reserved memory */
+	if (!is_tmc_reserved_region_valid(csdev->dev.parent))
+		return 0;
+
+	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
+	mdata->valid = false;
+
+	CS_UNLOCK(drvdata->base);
+
+	/* Proceed only if ETF is enabled or configured as sink */
+	val = readl(drvdata->base + TMC_CTL);
+	if (!(val & TMC_CTL_CAPT_EN))
+		goto out;
+
+	val = readl(drvdata->base + TMC_MODE);
+	if (val != TMC_MODE_CIRCULAR_BUFFER)
+		goto out;
+
+	tmc_flush_and_stop(drvdata);
+
+	/* Sync registers from hardware to metadata region */
+	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
+	mdata->trc_paddr = drvdata->crash_tbuf.paddr;
+
+	/* Sync Internal SRAM to reserved trace buffer region */
+	tmc_etb_dump_hw(drvdata);
+	memcpy(drvdata->crash_tbuf.vaddr, drvdata->buf, drvdata->len);
+	/* Store as per RSZ register convention */
+	mdata->size = drvdata->len >> 2;
+
+	/*
+	 * Make sure all previous writes are completed,
+	 * before we mark valid
+	 */
+	dsb(sy);
+	mdata->valid = true;
+	/*
+	 * Below order need to maintained, since crc of metadata
+	 * is dependent on first
+	 */
+	mdata->crc32_tdata = find_crash_tracedata_crc(drvdata, mdata);
+	mdata->crc32_mdata = find_crash_metadata_crc(mdata);
+
+	tmc_disable_hw(drvdata);
+
+	dev_info(&csdev->dev, "%s: success\n", __func__);
+out:
+	CS_UNLOCK(drvdata->base);
+	return 0;
+}
+
 static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.enable		= tmc_enable_etf_sink,
 	.disable	= tmc_disable_etf_sink,
@@ -601,6 +661,10 @@ static const struct coresight_ops_link tmc_etf_link_ops = {
 	.disable	= tmc_disable_etf_link,
 };
 
+static const struct coresight_ops_panic tmc_etf_sync_ops = {
+	.sync		= tmc_panic_sync_etf,
+};
+
 const struct coresight_ops tmc_etb_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 };
@@ -608,6 +672,7 @@ const struct coresight_ops tmc_etb_cs_ops = {
 const struct coresight_ops tmc_etf_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 	.link_ops	= &tmc_etf_link_ops,
+	.panic_ops	= &tmc_etf_sync_ops,
 };
 
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 7fd8c4afef74..23eb35f50571 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1818,6 +1818,61 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	return 0;
 }
 
+static int tmc_panic_sync_etr(struct coresight_device *csdev)
+{
+	u32 val;
+	struct csdev_access *csa;
+	struct tmc_crash_metadata *mdata;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	csa = &drvdata->csdev->access;
+
+	/* Being in RESRV mode implies valid reserved memory as well */
+	if (drvdata->etr_mode != ETR_MODE_RESRV)
+		return 0;
+
+	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
+	mdata->valid = false;
+
+	CS_UNLOCK(drvdata->base);
+
+	/* Proceed only if ETR is enabled */
+	val = readl(drvdata->base + TMC_CTL);
+	if (!(val & TMC_CTL_CAPT_EN))
+		goto out;
+
+	tmc_flush_and_stop(drvdata);
+
+	/* Sync registers from hardware to metadata region */
+	mdata->size = csdev_access_relaxed_read32(csa, TMC_RSZ);
+	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
+	mdata->rrp = tmc_read_rrp(drvdata);
+	mdata->rwp = tmc_read_rwp(drvdata);
+	mdata->dba = tmc_read_dba(drvdata);
+	mdata->trc_paddr = drvdata->crash_tbuf.paddr;
+
+	/*
+	 * Make sure all previous writes are completed,
+	 * before we mark valid
+	 */
+	dsb(sy);
+	mdata->valid = true;
+	/*
+	 * Below order need to maintained, since crc of metadata
+	 * is dependent on first
+	 */
+	mdata->crc32_tdata = find_crash_tracedata_crc(drvdata, mdata);
+	mdata->crc32_mdata = find_crash_metadata_crc(mdata);
+
+	tmc_disable_hw(drvdata);
+
+	dev_info(&csdev->dev, "%s: success\n", __func__);
+out:
+	CS_UNLOCK(drvdata->base);
+
+	return 0;
+}
+
 static const struct coresight_ops_sink tmc_etr_sink_ops = {
 	.enable		= tmc_enable_etr_sink,
 	.disable	= tmc_disable_etr_sink,
@@ -1826,8 +1881,13 @@ static const struct coresight_ops_sink tmc_etr_sink_ops = {
 	.free_buffer	= tmc_free_etr_buffer,
 };
 
+static const struct coresight_ops_panic tmc_etr_sync_ops = {
+	.sync		= tmc_panic_sync_etr,
+};
+
 const struct coresight_ops tmc_etr_cs_ops = {
 	.sink_ops	= &tmc_etr_sink_ops,
+	.panic_ops	= &tmc_etr_sync_ops,
 };
 
 int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 10dba9f7d76a..6f13caae6495 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -12,6 +12,7 @@
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
+#include <linux/crc32.h>
 
 #define TMC_RSZ			0x004
 #define TMC_STS			0x00c
@@ -131,6 +132,21 @@ enum tmc_mem_intf_width {
 #define CORESIGHT_SOC_600_ETR_CAPS	\
 	(TMC_ETR_SAVE_RESTORE | TMC_ETR_AXI_ARCACHE)
 
+/* TMC metadata region for ETR and ETF configurations */
+struct tmc_crash_metadata {
+	uint32_t crc32_mdata;	/* crc of metadata */
+	uint32_t crc32_tdata;	/* crc of tracedata */
+	uint32_t valid;         /* Indicate if this ETF/ETR was enabled */
+	uint32_t size;          /* Ram Size register */
+	uint32_t sts;           /* Status register */
+	uint32_t reserved32[3];
+	uint64_t rrp;           /* Ram Read pointer register */
+	uint64_t rwp;           /* Ram Write pointer register */
+	uint64_t dba;		/* Data buffer address register */
+	uint64_t trc_paddr;	/* Phys address of trace buffer */
+	uint64_t reserved64[3];
+};
+
 enum etr_mode {
 	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
 	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
@@ -204,6 +220,8 @@ struct tmc_resrv_buf {
  *		retention (after crash) only when ETR_MODE_RESRV buffer
  *		mode is enabled. Used by ETF for trace data retention
  *		(after crash) by default.
+ * @crash_mdata: Reserved memory for storing tmc crash metadata.
+ *		 Used by ETR/ETF.
  */
 struct tmc_drvdata {
 	void __iomem		*base;
@@ -230,6 +248,7 @@ struct tmc_drvdata {
 	struct etr_buf		*sysfs_buf;
 	struct etr_buf		*perf_buf;
 	struct tmc_resrv_buf	crash_tbuf;
+	struct tmc_resrv_buf	crash_mdata;
 };
 
 struct etr_buf_operations {
@@ -352,11 +371,32 @@ static inline bool is_tmc_reserved_region_valid(struct device *dev)
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
 
 	if (drvdata->crash_tbuf.paddr &&
-		drvdata->crash_tbuf.size)
+		drvdata->crash_tbuf.size &&
+		drvdata->crash_mdata.paddr &&
+		drvdata->crash_mdata.size)
 		return true;
 	return false;
 }
 
+static inline uint32_t find_crash_metadata_crc(struct tmc_crash_metadata *md)
+{
+	unsigned long crc_size;
+
+	crc_size = sizeof(struct tmc_crash_metadata) -
+		offsetof(struct tmc_crash_metadata, crc32_tdata);
+	return crc32_le(0, (void *)&md->crc32_tdata, crc_size);
+}
+
+static inline uint32_t find_crash_tracedata_crc(struct tmc_drvdata *drvdata,
+						struct tmc_crash_metadata *md)
+{
+	unsigned long crc_size;
+
+	/* Take CRC of configured buffer size to keep it simple */
+	crc_size = md->size << 2;
+	return crc32_le(0, (void *)drvdata->crash_tbuf.vaddr, crc_size);
+}
+
 struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
 
 void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
-- 
2.34.1

