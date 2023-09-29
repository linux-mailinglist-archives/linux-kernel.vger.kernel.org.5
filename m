Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DB57B33CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjI2Nix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjI2Nis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:38:48 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECF01708;
        Fri, 29 Sep 2023 06:38:40 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TCPgfc005333;
        Fri, 29 Sep 2023 06:38:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=bdlccjm95LY6DgB73mXfZVgQiUA8BdwN4x6Um0XMI+0=;
 b=QRRuYZxjpXLqU4fBY/GbgqevnUX4OmM7OsABlfPLMyizTCi6qob9A0e9P42kQJKPSHXi
 zx7mDdc+d0DwID42MhQ9YVpHnZwbMaGf2vci0N5R9kkfOBR91ocPOfa+fXjcaG3AoLYF
 ZP5oaJ9YLq41kUQxJ8SU5E/ciuQ+TkmgTgeAzeC97BICLLu+Gi4IPmGa1hPqSrLvTaPi
 8rTqinAg0u75QAdJEjpyp2pnFeNQh0ZTZwOnkywml2TsZnHhBawaG1vueEnLSn6VUbU+
 3m3rtZZYpz5k4Z5LEOll5pQLBeMXwZiygknr/lyMlW+yWla1AkN1bRb1UOiAKwl4i+8n lg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tdxk08ehg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 06:38:27 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Sep
 2023 06:38:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 29 Sep 2023 06:38:25 -0700
Received: from virtx40.. (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id 531205B6923;
        Fri, 29 Sep 2023 06:38:21 -0700 (PDT)
From:   Linu Cherian <lcherian@marvell.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH 4/7] coresight: tmc: Enable panic sync handling
Date:   Fri, 29 Sep 2023 19:07:51 +0530
Message-ID: <20230929133754.857678-5-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929133754.857678-1-lcherian@marvell.com>
References: <20230929133754.857678-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wUhQTbJiASwoBMttKdLjDfBOieRaJ4Gx
X-Proofpoint-ORIG-GUID: wUhQTbJiASwoBMttKdLjDfBOieRaJ4Gx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 .../hwtracing/coresight/coresight-tmc-core.c  | 26 +++++++++
 .../hwtracing/coresight/coresight-tmc-etf.c   | 56 +++++++++++++++++++
 .../hwtracing/coresight/coresight-tmc-etr.c   | 52 +++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h   | 19 ++++++-
 4 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 1e94215ac148..6658ce76777b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -415,6 +415,32 @@ static void tmc_get_reserved_region(struct device *parent)
 	drvdata->resrv_buf.paddr = res.start;
 	drvdata->resrv_buf.size  = resource_size(&res);
 
+	/* Metadata region */
+	node = tmc_get_region_byname(parent->of_node, "metadata-mem");
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
+	drvdata->metadata.vaddr = memremap(res.start,
+					       resource_size(&res),
+					       MEMREMAP_WC);
+	if (IS_ERR_OR_NULL(drvdata->metadata.vaddr)) {
+		dev_err(parent, "Metadata memory mapping failed\n");
+		rc = PTR_ERR(drvdata->metadata.vaddr);
+		goto out;
+	}
+
+	drvdata->metadata.paddr = res.start;
+	drvdata->metadata.size  = resource_size(&res);
+
 out:
 	return;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 7406b65e2cdd..40204d5f200f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -588,6 +588,57 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	return to_read;
 }
 
+static int tmc_panic_sync_etf(struct coresight_device *csdev)
+{
+	u32 val;
+	struct tmc_register_snapshot *tmc;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct csdev_access *csa = &drvdata->csdev->access;
+
+	/* Make sure we have valid reserved memory */
+	if (!drvdata->metadata.vaddr || !drvdata->resrv_buf.vaddr)
+		return 0;
+
+	tmc = (struct tmc_register_snapshot *)drvdata->metadata.vaddr;
+	tmc->valid = 0x0;
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
+	tmc->sts = csdev_access_relaxed_read32(csa, TMC_STS);
+	tmc->trc_paddr = drvdata->resrv_buf.paddr;
+
+	/* Sync Internal SRAM to reserved trace buffer region */
+	tmc_etb_dump_hw(drvdata);
+	memcpy(drvdata->resrv_buf.vaddr, drvdata->buf, drvdata->len);
+	tmc->size = drvdata->len;
+
+	/*
+	 * Make sure all previous writes are completed,
+	 * before we mark valid
+	 */
+	dsb(sy);
+	tmc->valid = 0x1;
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
@@ -601,6 +652,10 @@ static const struct coresight_ops_link tmc_etf_link_ops = {
 	.disable	= tmc_disable_etf_link,
 };
 
+static const struct coresight_ops_panic tmc_etf_sync_ops = {
+	.sync		= tmc_panic_sync_etf,
+};
+
 const struct coresight_ops tmc_etb_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 };
@@ -608,6 +663,7 @@ const struct coresight_ops tmc_etb_cs_ops = {
 const struct coresight_ops tmc_etf_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 	.link_ops	= &tmc_etf_link_ops,
+	.panic_ops	= &tmc_etf_sync_ops,
 };
 
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index fca82eaf073f..27fc9fdb84cc 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1817,6 +1817,53 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	return 0;
 }
 
+static int tmc_panic_sync_etr(struct coresight_device *csdev)
+{
+	u32 val;
+	struct tmc_register_snapshot *tmc;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct csdev_access *csa = &drvdata->csdev->access;
+
+	/* Being in RESRV mode implies valid reserved memory as well */
+	if (drvdata->etr_mode != ETR_MODE_RESRV)
+		return 0;
+
+	tmc = (struct tmc_register_snapshot *)drvdata->metadata.vaddr;
+	tmc->valid = 0x0;
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
+	tmc->size = csdev_access_relaxed_read32(csa, TMC_RSZ);
+	tmc->sts = csdev_access_relaxed_read32(csa, TMC_STS);
+	tmc->rrp = tmc_read_rrp(drvdata);
+	tmc->rwp = tmc_read_rwp(drvdata);
+	tmc->dba = tmc_read_dba(drvdata);
+	tmc->trc_paddr = drvdata->resrv_buf.paddr;
+
+	/*
+	 * Make sure all previous writes are completed,
+	 * before we mark valid
+	 */
+	dsb(sy);
+	tmc->valid = 0x1;
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
@@ -1825,8 +1872,13 @@ static const struct coresight_ops_sink tmc_etr_sink_ops = {
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
index 5400e1ef1f1b..24ef7bbb0611 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -131,6 +131,19 @@ enum tmc_mem_intf_width {
 #define CORESIGHT_SOC_600_ETR_CAPS	\
 	(TMC_ETR_SAVE_RESTORE | TMC_ETR_AXI_ARCACHE)
 
+/* TMC metadata region for ETR and ETF configurations */
+struct tmc_register_snapshot {
+	uint32_t valid;         /* Indicate if this ETF/ETR was enabled */
+	uint32_t size;          /* Size of trace data */
+	uint32_t sts;           /* Status register */
+	uint32_t reserved32[3];
+	uint64_t rrp;           /* Read pointer */
+	uint64_t rwp;           /* Write pointer */
+	uint64_t dba;		/* Data buffer address */
+	uint64_t trc_paddr;	/* Phys address of trace buffer */
+	uint64_t reserved64[3];
+};
+
 enum etr_mode {
 	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
 	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
@@ -201,6 +214,7 @@ struct tmc_resrv_buf {
  * @sysfs_buf:	SYSFS buffer for ETR.
  * @perf_buf:	PERF buffer for ETR.
  * @resrv_buf: Reserved Memory for trace data buffer. Used by ETR/ETF.
+ * @metadata: Reserved memory for metadata. Used by ETR/ETF.
  */
 struct tmc_drvdata {
 	void __iomem		*base;
@@ -227,6 +241,7 @@ struct tmc_drvdata {
 	struct etr_buf		*sysfs_buf;
 	struct etr_buf		*perf_buf;
 	struct tmc_resrv_buf	resrv_buf;
+	struct tmc_resrv_buf	metadata;
 };
 
 struct etr_buf_operations {
@@ -349,7 +364,9 @@ static inline bool is_tmc_reserved_region_valid(struct device *dev)
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
 
 	if (drvdata->resrv_buf.paddr &&
-		drvdata->resrv_buf.size)
+		drvdata->resrv_buf.size &&
+		drvdata->metadata.paddr &&
+		drvdata->metadata.size)
 		return true;
 	return false;
 }
-- 
2.34.1

