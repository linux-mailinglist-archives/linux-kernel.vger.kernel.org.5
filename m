Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78FA7910B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352111AbjIDFGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351892AbjIDFGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:06:51 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F196119;
        Sun,  3 Sep 2023 22:06:43 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383LEOKJ010966;
        Sun, 3 Sep 2023 22:06:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=5bbmhCnubCgu5th6pvVSZtWVX3a848ZW6fj9gRP8YrI=;
 b=SyMZPje+3OoRe1SPr4yw5xE2gDQH33HW02f14HSDTDpFkTJZyks3jW9NUeqzMN75M07f
 pK+wt6OvBnFFvgLHGNLPmMYli3YdzoI9QaAnLMUu/mU6LqyCTqZhk/6LrleGSXw7OnEg
 HY403AZ/ZGT1p1B1WCfvyoNgGrMo2Q6aPXA/unKstgDurrlFWLJmBRcqtBNuUmAnATPZ
 Q19g2eBiz/LOtgP9mg16vBTgpGMWRvUShy4yVGxYklc4vaHlH+ZstovxGkhkBh1j29xk
 FMeHDnHiIb3OrV8qyND/ZkhZ02uxh7vC32L7US9qg6hxYVqSB5GIsYMuXbyYRFqBJHzd vQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sv2dp4hrd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 03 Sep 2023 22:06:31 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 3 Sep
 2023 22:06:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 3 Sep 2023 22:06:28 -0700
Received: from localhost.localdomain (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id 93DAF3F7070;
        Sun,  3 Sep 2023 22:06:24 -0700 (PDT)
From:   Linu Cherian <lcherian@marvell.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [RFC PATCH v3 4/7] coresight: tmc: Enable panic sync handling
Date:   Mon, 4 Sep 2023 10:35:44 +0530
Message-ID: <20230904050548.28047-5-lcherian@marvell.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904050548.28047-1-lcherian@marvell.com>
References: <20230904050548.28047-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: psMgese3u7WKmVqDnFfoFmk5Qdtlifd5
X-Proofpoint-GUID: psMgese3u7WKmVqDnFfoFmk5Qdtlifd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_02,2023-08-31_01,2023-05-22_02
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
index c37dc629408b..d69da50136ec 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -403,6 +403,32 @@ static void tmc_get_reserved_region(struct device *parent)
 	drvdata->resrv_buf.paddr = res.start;
 	drvdata->resrv_buf.size  = resource_size(&res);
 
+	/* Metadata region */
+	node = of_parse_phandle(parent->of_node, "memory-region", 1);
+	if (!node) {
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
+					       MEMREMAP_WB);
+	if (IS_ERR(drvdata->metadata.vaddr)) {
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
index 79d8c64eac49..1dfaa3ccfff7 100644
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
index 334226cd7201..1983a6772775 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1803,6 +1803,53 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
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
+	tmc->sts = csdev_access_relaxed_read32(csa, TMC_RSZ);
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
@@ -1811,8 +1858,13 @@ static const struct coresight_ops_sink tmc_etr_sink_ops = {
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
index 942fcd960586..af93d3ce0e78 100644
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
2.41.0

