Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F054B7DCCB4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344175AbjJaMEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344100AbjJaMEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:04:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CEA5584;
        Tue, 31 Oct 2023 05:04:01 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VBbmM9005612;
        Tue, 31 Oct 2023 12:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=tXXZs7JIoDyFZBGHOR6mc8x7JDAQkCFlQPDMdomQ8Uc=;
 b=i7Z4/+BMb8cjyTzFvfCldzfjm4FGo1vvYpVa0LdGGJkpOV9wWzSRPNez6VYM7xx3/4hP
 4lBozw+W9IktnxF+xFX9hvzgY+UM3F3tAsFLP4GphEJMJ7JXvZGQzzp3e5xnY26bGevQ
 jetE+8sB8Zjz2afg2zN0sReI8hd4u6yYIs4zKNkoL2DDV5vh1a18Zaun1UxPRKyIcsHp
 BB8JQiKLgj1HuJaGlz+6W3LaCCH0eqdQo42WLbLJQmIZ6obcyNkdqTljmtzLqT2JF5C9
 xxGwBjCHzefPAPSo4U16HKgSO2IQkC1TfhHVZrnuz/MIvNvrSc45+jYDP5Jh8L8TEMwP OQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2dey2thq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:15 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39VC3CaZ005285;
        Tue, 31 Oct 2023 12:03:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3u0uckvvpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:12 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39VC3CvD005280;
        Tue, 31 Oct 2023 12:03:12 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 39VC3BqD005279
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:12 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
        id EB0074162D; Tue, 31 Oct 2023 17:33:10 +0530 (+0530)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, quic_srichara@quicinc.com,
        qpic_varada@quicinc.com
Cc:     quic_mdalam@quicinc.com
Subject: [RFC PATCH 3/5] mtd: nand: qpic_common: Add support for qpic common API
Date:   Tue, 31 Oct 2023 17:33:05 +0530
Message-Id: <20231031120307.1600689-4-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iP8437Rk-jtPRVYD_faqzceRPpkejnMn
X-Proofpoint-GUID: iP8437Rk-jtPRVYD_faqzceRPpkejnMn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310310094
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qpic command API in sperate file so that it will be
use by both spi and request and raw nand request.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
---
 drivers/mtd/nand/qpic_common.c       | 840 +++++++++++++++++++++++++++
 include/linux/mtd/nand-qpic-common.h | 641 ++++++++++++++++++++
 2 files changed, 1481 insertions(+)
 create mode 100644 drivers/mtd/nand/qpic_common.c
 create mode 100644 include/linux/mtd/nand-qpic-common.h

diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
new file mode 100644
index 000000000000..983768a1ea94
--- /dev/null
+++ b/drivers/mtd/nand/qpic_common.c
@@ -0,0 +1,840 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * QPIC common API file.
+ * Copyright (C) 2023  Qualcomm Inc.
+ * Authors:	Md sadre Alam		<quic_mdalam@quicinc.com>
+ *		Sricharan R		<quic_srichara@quicinc.com>
+ */
+
+#include <linux/mtd/nand-qpic-common.h>
+
+/* Frees the BAM transaction memory */
+void free_bam_transaction(struct qcom_nand_controller *nandc)
+{
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+
+	devm_kfree(nandc->dev, bam_txn);
+}
+EXPORT_SYMBOL(free_bam_transaction);
+
+/* Callback for DMA descriptor completion */
+void qpic_bam_dma_done(void *data)
+{
+	struct bam_transaction *bam_txn = data;
+
+	/*
+	 * In case of data transfer with NAND, 2 callbacks will be generated.
+	 * One for command channel and another one for data channel.
+	 * If current transaction has data descriptors
+	 * (i.e. wait_second_completion is true), then set this to false
+	 * and wait for second DMA descriptor completion.
+	 */
+	if (bam_txn->wait_second_completion)
+		bam_txn->wait_second_completion = false;
+	else
+		complete(&bam_txn->txn_done);
+}
+EXPORT_SYMBOL(qpic_bam_dma_done);
+
+u32 nandc_read(struct qcom_nand_controller *nandc, int offset)
+{
+	return ioread32(nandc->base + offset);
+}
+EXPORT_SYMBOL(nandc_read);
+
+void nandc_write(struct qcom_nand_controller *nandc, int offset,
+			       u32 val)
+{
+	iowrite32(val, nandc->base + offset);
+}
+EXPORT_SYMBOL(nandc_write);
+
+void nandc_read_buffer_sync(struct qcom_nand_controller *nandc,
+					  bool is_cpu)
+{
+	if (!nandc->props->is_bam)
+		return;
+
+	if (is_cpu)
+		dma_sync_single_for_cpu(nandc->dev, nandc->reg_read_dma,
+					MAX_REG_RD *
+					sizeof(*nandc->reg_read_buf),
+					DMA_FROM_DEVICE);
+	else
+		dma_sync_single_for_device(nandc->dev, nandc->reg_read_dma,
+					   MAX_REG_RD *
+					   sizeof(*nandc->reg_read_buf),
+					   DMA_FROM_DEVICE);
+}
+EXPORT_SYMBOL(nandc_read_buffer_sync);
+
+__le32 *offset_to_nandc_reg(struct nandc_regs *regs, int offset)
+{
+	switch (offset) {
+	case NAND_FLASH_CMD:
+		return &regs->cmd;
+	case NAND_ADDR0:
+		return &regs->addr0;
+	case NAND_ADDR1:
+		return &regs->addr1;
+	case NAND_FLASH_CHIP_SELECT:
+		return &regs->chip_sel;
+	case NAND_EXEC_CMD:
+		return &regs->exec;
+	case NAND_FLASH_STATUS:
+		return &regs->clrflashstatus;
+	case NAND_DEV0_CFG0:
+		return &regs->cfg0;
+	case NAND_DEV0_CFG1:
+		return &regs->cfg1;
+	case NAND_DEV0_ECC_CFG:
+		return &regs->ecc_bch_cfg;
+	case NAND_READ_STATUS:
+		return &regs->clrreadstatus;
+	case NAND_DEV_CMD1:
+		return &regs->cmd1;
+	case NAND_DEV_CMD1_RESTORE:
+		return &regs->orig_cmd1;
+	case NAND_DEV_CMD_VLD:
+		return &regs->vld;
+	case NAND_DEV_CMD_VLD_RESTORE:
+		return &regs->orig_vld;
+	case NAND_EBI2_ECC_BUF_CFG:
+		return &regs->ecc_buf_cfg;
+	case NAND_READ_LOCATION_0:
+		return &regs->read_location0;
+	case NAND_READ_LOCATION_1:
+		return &regs->read_location1;
+	case NAND_READ_LOCATION_2:
+		return &regs->read_location2;
+	case NAND_READ_LOCATION_3:
+		return &regs->read_location3;
+	case NAND_READ_LOCATION_LAST_CW_0:
+		return &regs->read_location_last0;
+	case NAND_READ_LOCATION_LAST_CW_1:
+		return &regs->read_location_last1;
+	case NAND_READ_LOCATION_LAST_CW_2:
+		return &regs->read_location_last2;
+	case NAND_READ_LOCATION_LAST_CW_3:
+		return &regs->read_location_last3;
+	case NAND_FLASH_SPI_CFG:
+		return &regs->spi_cfg;
+	case NAND_NUM_ADDR_CYCLES:
+		return &regs->num_addr_cycle;
+	case NAND_BUSY_CHECK_WAIT_CNT:
+		return &regs->busy_wait_cnt;
+	case NAND_MSTR_CONFIG:
+		return &regs->mstr_cfg;
+	case NAND_FLASH_FEATURES:
+		return &regs->flash_feature;
+	default:
+		return NULL;
+	}
+}
+EXPORT_SYMBOL(offset_to_nandc_reg);
+
+/* reset the register read buffer for next NAND operation */
+void clear_read_regs(struct qcom_nand_controller *nandc)
+{
+	nandc->reg_read_pos = 0;
+	nandc_read_buffer_sync(nandc, false);
+}
+EXPORT_SYMBOL(clear_read_regs);
+
+int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
+			     int reg_off, const void *vaddr, int size,
+			     bool flow_control)
+{
+	struct desc_info *desc;
+	struct dma_async_tx_descriptor *dma_desc;
+	struct scatterlist *sgl;
+	struct dma_slave_config slave_conf;
+	struct qcom_adm_peripheral_config periph_conf = {};
+	enum dma_transfer_direction dir_eng;
+	int ret;
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	sgl = &desc->adm_sgl;
+
+	sg_init_one(sgl, vaddr, size);
+
+	if (read) {
+		dir_eng = DMA_DEV_TO_MEM;
+		desc->dir = DMA_FROM_DEVICE;
+	} else {
+		dir_eng = DMA_MEM_TO_DEV;
+		desc->dir = DMA_TO_DEVICE;
+	}
+
+	ret = dma_map_sg(nandc->dev, sgl, 1, desc->dir);
+	if (ret == 0) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	memset(&slave_conf, 0x00, sizeof(slave_conf));
+
+	slave_conf.device_fc = flow_control;
+	if (read) {
+		slave_conf.src_maxburst = 16;
+		slave_conf.src_addr = nandc->base_dma + reg_off;
+		if (nandc->data_crci) {
+			periph_conf.crci = nandc->data_crci;
+			slave_conf.peripheral_config = &periph_conf;
+			slave_conf.peripheral_size = sizeof(periph_conf);
+		}
+	} else {
+		slave_conf.dst_maxburst = 16;
+		slave_conf.dst_addr = nandc->base_dma + reg_off;
+		if (nandc->cmd_crci) {
+			periph_conf.crci = nandc->cmd_crci;
+			slave_conf.peripheral_config = &periph_conf;
+			slave_conf.peripheral_size = sizeof(periph_conf);
+		}
+	}
+
+	ret = dmaengine_slave_config(nandc->chan, &slave_conf);
+	if (ret) {
+		dev_err(nandc->dev, "failed to configure dma channel\n");
+		goto err;
+	}
+
+	dma_desc = dmaengine_prep_slave_sg(nandc->chan, sgl, 1, dir_eng, 0);
+	if (!dma_desc) {
+		dev_err(nandc->dev, "failed to prepare desc\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	desc->dma_desc = dma_desc;
+
+	list_add_tail(&desc->node, &nandc->desc_list);
+
+	return 0;
+err:
+	kfree(desc);
+
+	return ret;
+}
+
+/* helpers to submit/free our list of dma descriptors */
+int submit_descs(struct qcom_nand_controller *nandc)
+{
+	struct desc_info *desc;
+	dma_cookie_t cookie = 0;
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+	int r;
+
+	if (nandc->props->is_bam) {
+		if (bam_txn->rx_sgl_pos > bam_txn->rx_sgl_start) {
+			r = prepare_bam_async_desc(nandc, nandc->rx_chan, 0);
+			if (r)
+				return r;
+		}
+
+		if (bam_txn->tx_sgl_pos > bam_txn->tx_sgl_start) {
+			r = prepare_bam_async_desc(nandc, nandc->tx_chan,
+						   DMA_PREP_INTERRUPT);
+			if (r)
+				return r;
+		}
+
+		if (bam_txn->cmd_sgl_pos > bam_txn->cmd_sgl_start) {
+			r = prepare_bam_async_desc(nandc, nandc->cmd_chan,
+						   DMA_PREP_CMD);
+			if (r)
+				return r;
+		}
+	}
+
+	list_for_each_entry(desc, &nandc->desc_list, node)
+		cookie = dmaengine_submit(desc->dma_desc);
+
+	if (nandc->props->is_bam) {
+		bam_txn->last_cmd_desc->callback = qpic_bam_dma_done;
+		bam_txn->last_cmd_desc->callback_param = bam_txn;
+		if (bam_txn->last_data_desc) {
+			bam_txn->last_data_desc->callback = qpic_bam_dma_done;
+			bam_txn->last_data_desc->callback_param = bam_txn;
+			bam_txn->wait_second_completion = true;
+		}
+
+		dma_async_issue_pending(nandc->tx_chan);
+		dma_async_issue_pending(nandc->rx_chan);
+		dma_async_issue_pending(nandc->cmd_chan);
+
+		if (!wait_for_completion_timeout(&bam_txn->txn_done,
+						 QPIC_NAND_COMPLETION_TIMEOUT))
+			return -ETIMEDOUT;
+	} else {
+		if (dma_sync_wait(nandc->chan, cookie) != DMA_COMPLETE)
+			return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(submit_descs);
+
+void free_descs(struct qcom_nand_controller *nandc)
+{
+	struct desc_info *desc, *n;
+
+	list_for_each_entry_safe(desc, n, &nandc->desc_list, node) {
+		list_del(&desc->node);
+
+		if (nandc->props->is_bam)
+			dma_unmap_sg(nandc->dev, desc->bam_sgl,
+				     desc->sgl_cnt, desc->dir);
+		else
+			dma_unmap_sg(nandc->dev, &desc->adm_sgl, 1,
+				     desc->dir);
+
+		kfree(desc);
+	}
+}
+EXPORT_SYMBOL(free_descs);
+
+/*
+ * Maps the scatter gather list for DMA transfer and forms the DMA descriptor
+ * for BAM. This descriptor will be added in the NAND DMA descriptor queue
+ * which will be submitted to DMA engine.
+ */
+int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
+				  struct dma_chan *chan,
+				  unsigned long flags)
+{
+	struct desc_info *desc;
+	struct scatterlist *sgl;
+	unsigned int sgl_cnt;
+	int ret;
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+	enum dma_transfer_direction dir_eng;
+	struct dma_async_tx_descriptor *dma_desc;
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	if (chan == nandc->cmd_chan) {
+		sgl = &bam_txn->cmd_sgl[bam_txn->cmd_sgl_start];
+		sgl_cnt = bam_txn->cmd_sgl_pos - bam_txn->cmd_sgl_start;
+		bam_txn->cmd_sgl_start = bam_txn->cmd_sgl_pos;
+		dir_eng = DMA_MEM_TO_DEV;
+		desc->dir = DMA_TO_DEVICE;
+	} else if (chan == nandc->tx_chan) {
+		sgl = &bam_txn->data_sgl[bam_txn->tx_sgl_start];
+		sgl_cnt = bam_txn->tx_sgl_pos - bam_txn->tx_sgl_start;
+		bam_txn->tx_sgl_start = bam_txn->tx_sgl_pos;
+		dir_eng = DMA_MEM_TO_DEV;
+		desc->dir = DMA_TO_DEVICE;
+	} else {
+		sgl = &bam_txn->data_sgl[bam_txn->rx_sgl_start];
+		sgl_cnt = bam_txn->rx_sgl_pos - bam_txn->rx_sgl_start;
+		bam_txn->rx_sgl_start = bam_txn->rx_sgl_pos;
+		dir_eng = DMA_DEV_TO_MEM;
+		desc->dir = DMA_FROM_DEVICE;
+	}
+
+	sg_mark_end(sgl + sgl_cnt - 1);
+	ret = dma_map_sg(nandc->dev, sgl, sgl_cnt, desc->dir);
+	if (ret == 0) {
+		dev_err(nandc->dev, "failure in mapping desc\n");
+		kfree(desc);
+		return -ENOMEM;
+	}
+
+	desc->sgl_cnt = sgl_cnt;
+	desc->bam_sgl = sgl;
+
+	dma_desc = dmaengine_prep_slave_sg(chan, sgl, sgl_cnt, dir_eng,
+					   flags);
+
+	if (!dma_desc) {
+		dev_err(nandc->dev, "failure in prep desc\n");
+		dma_unmap_sg(nandc->dev, sgl, sgl_cnt, desc->dir);
+		kfree(desc);
+		return -EINVAL;
+	}
+
+	desc->dma_desc = dma_desc;
+
+	/* update last data/command descriptor */
+	if (chan == nandc->cmd_chan)
+		bam_txn->last_cmd_desc = dma_desc;
+	else
+		bam_txn->last_data_desc = dma_desc;
+
+	list_add_tail(&desc->node, &nandc->desc_list);
+
+	return 0;
+}
+EXPORT_SYMBOL(prepare_bam_async_desc);
+
+/*
+ * Prepares the command descriptor for BAM DMA which will be used for NAND
+ * register reads and writes. The command descriptor requires the command
+ * to be formed in command element type so this function uses the command
+ * element from bam transaction ce array and fills the same with required
+ * data. A single SGL can contain multiple command elements so
+ * NAND_BAM_NEXT_SGL will be used for starting the separate SGL
+ * after the current command element.
+ */
+int prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
+				 int reg_off, const void *vaddr,
+				 int size, unsigned int flags)
+{
+	int bam_ce_size;
+	int i, ret;
+	struct bam_cmd_element *bam_ce_buffer;
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+
+	bam_ce_buffer = &bam_txn->bam_ce[bam_txn->bam_ce_pos];
+
+	/* fill the command desc */
+	for (i = 0; i < size; i++) {
+		if (read)
+			bam_prep_ce(&bam_ce_buffer[i],
+				    nandc_reg_phys(nandc, reg_off + 4 * i),
+				    BAM_READ_COMMAND,
+				    reg_buf_dma_addr(nandc,
+						     (__le32 *)vaddr + i));
+		else
+			bam_prep_ce_le32(&bam_ce_buffer[i],
+					 nandc_reg_phys(nandc, reg_off + 4 * i),
+					 BAM_WRITE_COMMAND,
+					 *((__le32 *)vaddr + i));
+	}
+
+	bam_txn->bam_ce_pos += size;
+
+	/* use the separate sgl after this command */
+	if (flags & NAND_BAM_NEXT_SGL) {
+		bam_ce_buffer = &bam_txn->bam_ce[bam_txn->bam_ce_start];
+		bam_ce_size = (bam_txn->bam_ce_pos -
+				bam_txn->bam_ce_start) *
+				sizeof(struct bam_cmd_element);
+		sg_set_buf(&bam_txn->cmd_sgl[bam_txn->cmd_sgl_pos],
+			   bam_ce_buffer, bam_ce_size);
+		bam_txn->cmd_sgl_pos++;
+		bam_txn->bam_ce_start = bam_txn->bam_ce_pos;
+
+		if (flags & NAND_BAM_NWD) {
+			ret = prepare_bam_async_desc(nandc, nandc->cmd_chan,
+						     DMA_PREP_FENCE |
+						     DMA_PREP_CMD);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(prep_bam_dma_desc_cmd);
+
+/*
+ * Prepares the data descriptor for BAM DMA which will be used for NAND
+ * data reads and writes.
+ */
+int prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
+				  const void *vaddr,
+				  int size, unsigned int flags)
+{
+	int ret;
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+
+	if (read) {
+		sg_set_buf(&bam_txn->data_sgl[bam_txn->rx_sgl_pos],
+			   vaddr, size);
+		bam_txn->rx_sgl_pos++;
+	} else {
+		sg_set_buf(&bam_txn->data_sgl[bam_txn->tx_sgl_pos],
+			   vaddr, size);
+		bam_txn->tx_sgl_pos++;
+
+		/*
+		 * BAM will only set EOT for DMA_PREP_INTERRUPT so if this flag
+		 * is not set, form the DMA descriptor
+		 */
+		if (!(flags & NAND_BAM_NO_EOT)) {
+			ret = prepare_bam_async_desc(nandc, nandc->tx_chan,
+						     DMA_PREP_INTERRUPT);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(prep_bam_dma_desc_data);
+
+/*
+ * read_reg_dma:	prepares a descriptor to read a given number of
+ *			contiguous registers to the reg_read_buf pointer
+ *
+ * @first:		offset of the first register in the contiguous block
+ * @num_regs:		number of registers to read
+ * @flags:		flags to control DMA descriptor preparation
+ */
+int read_reg_dma(struct qcom_nand_controller *nandc, int first,
+			int num_regs, unsigned int flags)
+{
+	bool flow_control = false;
+	void *vaddr;
+
+	vaddr = nandc->reg_read_buf + nandc->reg_read_pos;
+	nandc->reg_read_pos += num_regs;
+
+	if (first == NAND_DEV_CMD_VLD || first == NAND_DEV_CMD1)
+		first = dev_cmd_reg_addr(nandc, first);
+
+	if (nandc->props->is_bam)
+		return prep_bam_dma_desc_cmd(nandc, true, first, vaddr,
+					     num_regs, flags);
+
+	if (first == NAND_READ_ID || first == NAND_FLASH_STATUS)
+		flow_control = true;
+
+	return prep_adm_dma_desc(nandc, true, first, vaddr,
+				 num_regs * sizeof(u32), flow_control);
+}
+EXPORT_SYMBOL(read_reg_dma);
+
+/*
+ * write_reg_dma:	prepares a descriptor to write a given number of
+ *			contiguous registers
+ *
+ * @first:		offset of the first register in the contiguous block
+ * @num_regs:		number of registers to write
+ * @flags:		flags to control DMA descriptor preparation
+ */
+int write_reg_dma(struct qcom_nand_controller *nandc, int first,
+			 int num_regs, unsigned int flags)
+{
+	bool flow_control = false;
+	struct nandc_regs *regs = nandc->regs;
+	void *vaddr;
+
+	vaddr = offset_to_nandc_reg(regs, first);
+
+	if (first == NAND_ERASED_CW_DETECT_CFG) {
+		if (flags & NAND_ERASED_CW_SET)
+			vaddr = &regs->erased_cw_detect_cfg_set;
+		else
+			vaddr = &regs->erased_cw_detect_cfg_clr;
+	}
+
+	if (first == NAND_EXEC_CMD)
+		flags |= NAND_BAM_NWD;
+
+	if (first == NAND_FLASH_SPI_CFG || first == NAND_NUM_ADDR_CYCLES
+		|| first == NAND_BUSY_CHECK_WAIT_CNT
+		|| first == NAND_MSTR_CONFIG)
+		first = dev_cmd_reg_addr(nandc, first);
+
+	if (first == NAND_DEV_CMD1_RESTORE || first == NAND_DEV_CMD1)
+		first = dev_cmd_reg_addr(nandc, NAND_DEV_CMD1);
+
+	if (first == NAND_DEV_CMD_VLD_RESTORE || first == NAND_DEV_CMD_VLD)
+		first = dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD);
+
+	if (nandc->props->is_bam)
+		return prep_bam_dma_desc_cmd(nandc, false, first, vaddr,
+					     num_regs, flags);
+
+	if (first == NAND_FLASH_CMD)
+		flow_control = true;
+
+	return prep_adm_dma_desc(nandc, false, first, vaddr,
+				 num_regs * sizeof(u32), flow_control);
+}
+EXPORT_SYMBOL(write_reg_dma);
+
+/*
+ * read_data_dma:	prepares a DMA descriptor to transfer data from the
+ *			controller's internal buffer to the buffer 'vaddr'
+ *
+ * @reg_off:		offset within the controller's data buffer
+ * @vaddr:		virtual address of the buffer we want to write to
+ * @size:		DMA transaction size in bytes
+ * @flags:		flags to control DMA descriptor preparation
+ */
+int read_data_dma(struct qcom_nand_controller *nandc, int reg_off,
+			 const u8 *vaddr, int size, unsigned int flags)
+{
+	if (nandc->props->is_bam)
+		return prep_bam_dma_desc_data(nandc, true, vaddr, size, flags);
+
+	return prep_adm_dma_desc(nandc, true, reg_off, vaddr, size, false);
+}
+EXPORT_SYMBOL(read_data_dma);
+
+/*
+ * write_data_dma:	prepares a DMA descriptor to transfer data from
+ *			'vaddr' to the controller's internal buffer
+ *
+ * @reg_off:		offset within the controller's data buffer
+ * @vaddr:		virtual address of the buffer we want to read from
+ * @size:		DMA transaction size in bytes
+ * @flags:		flags to control DMA descriptor preparation
+ */
+int write_data_dma(struct qcom_nand_controller *nandc, int reg_off,
+			  const u8 *vaddr, int size, unsigned int flags)
+{
+	if (nandc->props->is_bam)
+		return prep_bam_dma_desc_data(nandc, false, vaddr, size, flags);
+
+	return prep_adm_dma_desc(nandc, false, reg_off, vaddr, size, false);
+}
+EXPORT_SYMBOL(write_data_dma);
+
+void nandc_set_reg(struct qcom_nand_controller *nandc, int offset,
+			  u32 val)
+{
+	struct nandc_regs *regs = nandc->regs;
+	__le32 *reg;
+
+	reg = offset_to_nandc_reg(regs, offset);
+	if (reg)
+		*reg = cpu_to_le32(val);
+}
+EXPORT_SYMBOL(nandc_set_reg);
+
+/* Allocates and Initializes the BAM transaction */
+struct bam_transaction *
+alloc_bam_transaction(struct qcom_nand_controller *nandc)
+{
+	struct bam_transaction *bam_txn;
+	size_t bam_txn_size;
+	unsigned int num_cw = nandc->max_cwperpage;
+	void *bam_txn_buf;
+
+	bam_txn_size =
+		sizeof(*bam_txn) + num_cw *
+		((sizeof(*bam_txn->bam_ce) * QPIC_PER_CW_CMD_ELEMENTS) +
+		(sizeof(*bam_txn->cmd_sgl) * QPIC_PER_CW_CMD_SGL) +
+		(sizeof(*bam_txn->data_sgl) * QPIC_PER_CW_DATA_SGL));
+
+	bam_txn_buf = devm_kzalloc(nandc->dev, bam_txn_size, GFP_KERNEL);
+	if (!bam_txn_buf)
+		return NULL;
+
+	bam_txn = bam_txn_buf;
+	bam_txn_buf += sizeof(*bam_txn);
+
+	bam_txn->bam_ce = bam_txn_buf;
+	bam_txn_buf +=
+		sizeof(*bam_txn->bam_ce) * QPIC_PER_CW_CMD_ELEMENTS * num_cw;
+
+	bam_txn->cmd_sgl = bam_txn_buf;
+	bam_txn_buf +=
+		sizeof(*bam_txn->cmd_sgl) * QPIC_PER_CW_CMD_SGL * num_cw;
+
+	bam_txn->data_sgl = bam_txn_buf;
+
+	init_completion(&bam_txn->txn_done);
+
+	return bam_txn;
+}
+EXPORT_SYMBOL(alloc_bam_transaction);
+
+/* Clears the BAM transaction indexes */
+void clear_bam_transaction(struct qcom_nand_controller *nandc)
+{
+	struct bam_transaction *bam_txn = nandc->bam_txn;
+
+	if (!nandc->props->is_bam)
+		return;
+
+	bam_txn->bam_ce_pos = 0;
+	bam_txn->bam_ce_start = 0;
+	bam_txn->cmd_sgl_pos = 0;
+	bam_txn->cmd_sgl_start = 0;
+	bam_txn->tx_sgl_pos = 0;
+	bam_txn->tx_sgl_start = 0;
+	bam_txn->rx_sgl_pos = 0;
+	bam_txn->rx_sgl_start = 0;
+	bam_txn->last_data_desc = NULL;
+	bam_txn->wait_second_completion = false;
+
+	sg_init_table(bam_txn->cmd_sgl, nandc->max_cwperpage *
+		      QPIC_PER_CW_CMD_SGL);
+	sg_init_table(bam_txn->data_sgl, nandc->max_cwperpage *
+		      QPIC_PER_CW_DATA_SGL);
+
+	reinit_completion(&bam_txn->txn_done);
+}
+EXPORT_SYMBOL(clear_bam_transaction);
+
+/* one time setup of a few nand controller registers */
+int qcom_nandc_setup(struct qcom_nand_controller *nandc)
+{
+	u32 nand_ctrl;
+
+	/* kill onenand */
+	if (!nandc->props->is_qpic)
+		nandc_write(nandc, SFLASHC_BURST_CFG, 0);
+
+	if (!nandc->props->qpic_v2)
+		nandc_write(nandc, dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD),
+			    NAND_DEV_CMD_VLD_VAL);
+
+	/* enable ADM or BAM DMA */
+	if (nandc->props->is_bam) {
+		nand_ctrl = nandc_read(nandc, NAND_CTRL);
+
+		/*
+		 *NAND_CTRL is an operational registers, and CPU
+		 * access to operational registers are read only
+		 * in BAM mode. So update the NAND_CTRL register
+		 * only if it is not in BAM mode. In most cases BAM
+		 * mode will be enabled in bootloader
+		 */
+		if (!(nand_ctrl & BAM_MODE_EN))
+			nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
+	} else {
+		nandc_write(nandc, NAND_FLASH_CHIP_SELECT, DM_EN);
+	}
+
+	/* save the original values of these registers */
+	if (!nandc->props->qpic_v2) {
+		nandc->cmd1 = nandc_read(nandc, dev_cmd_reg_addr(nandc, NAND_DEV_CMD1));
+		nandc->vld = NAND_DEV_CMD_VLD_VAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(qcom_nandc_setup);
+
+void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
+{
+	if (nandc->props->is_bam) {
+		if (!dma_mapping_error(nandc->dev, nandc->reg_read_dma))
+			dma_unmap_single(nandc->dev, nandc->reg_read_dma,
+					 MAX_REG_RD *
+					 sizeof(*nandc->reg_read_buf),
+					 DMA_FROM_DEVICE);
+
+		if (nandc->tx_chan)
+			dma_release_channel(nandc->tx_chan);
+
+		if (nandc->rx_chan)
+			dma_release_channel(nandc->rx_chan);
+
+		if (nandc->cmd_chan)
+			dma_release_channel(nandc->cmd_chan);
+	} else {
+		if (nandc->chan)
+			dma_release_channel(nandc->chan);
+	}
+}
+EXPORT_SYMBOL(qcom_nandc_unalloc);
+
+int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
+{
+	int ret;
+
+	ret = dma_set_coherent_mask(nandc->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(nandc->dev, "failed to set DMA mask\n");
+		return ret;
+	}
+
+	/*
+	 * we use the internal buffer for reading ONFI params, reading small
+	 * data like ID and status, and preforming read-copy-write operations
+	 * when writing to a codeword partially. 532 is the maximum possible
+	 * size of a codeword for our nand controller
+	 */
+	nandc->buf_size = 532;
+
+	nandc->data_buffer = devm_kzalloc(nandc->dev, nandc->buf_size,
+					GFP_KERNEL);
+	if (!nandc->data_buffer)
+		return -ENOMEM;
+
+	nandc->regs = devm_kzalloc(nandc->dev, sizeof(*nandc->regs),
+					GFP_KERNEL);
+	if (!nandc->regs)
+		return -ENOMEM;
+
+	nandc->reg_read_buf = devm_kcalloc(nandc->dev,
+				MAX_REG_RD, sizeof(*nandc->reg_read_buf),
+				GFP_KERNEL);
+	if (!nandc->reg_read_buf)
+		return -ENOMEM;
+
+	if (nandc->props->is_bam) {
+		nandc->reg_read_dma =
+			dma_map_single(nandc->dev, nandc->reg_read_buf,
+				       MAX_REG_RD *
+				       sizeof(*nandc->reg_read_buf),
+				       DMA_FROM_DEVICE);
+		if (dma_mapping_error(nandc->dev, nandc->reg_read_dma)) {
+			dev_err(nandc->dev, "failed to DMA MAP reg buffer\n");
+			return -EIO;
+		}
+
+		nandc->tx_chan = dma_request_chan(nandc->dev, "tx");
+		if (IS_ERR(nandc->tx_chan)) {
+			ret = PTR_ERR(nandc->tx_chan);
+			nandc->tx_chan = NULL;
+			dev_err_probe(nandc->dev, ret,
+				      "tx DMA channel request failed\n");
+			goto unalloc;
+		}
+
+		nandc->rx_chan = dma_request_chan(nandc->dev, "rx");
+		if (IS_ERR(nandc->rx_chan)) {
+			ret = PTR_ERR(nandc->rx_chan);
+			nandc->rx_chan = NULL;
+			dev_err_probe(nandc->dev, ret,
+				      "rx DMA channel request failed\n");
+			goto unalloc;
+		}
+
+		nandc->cmd_chan = dma_request_chan(nandc->dev, "cmd");
+		if (IS_ERR(nandc->cmd_chan)) {
+			ret = PTR_ERR(nandc->cmd_chan);
+			nandc->cmd_chan = NULL;
+			dev_err_probe(nandc->dev, ret,
+				      "cmd DMA channel request failed\n");
+			goto unalloc;
+		}
+
+		/*
+		 * Initially allocate BAM transaction to read ONFI param page.
+		 * After detecting all the devices, this BAM transaction will
+		 * be freed and the next BAM tranasction will be allocated with
+		 * maximum codeword size
+		 */
+		nandc->max_cwperpage = 1;
+		nandc->bam_txn = alloc_bam_transaction(nandc);
+		if (!nandc->bam_txn) {
+			dev_err(nandc->dev,
+				"failed to allocate bam transaction\n");
+			ret = -ENOMEM;
+			goto unalloc;
+		}
+	} else {
+		nandc->chan = dma_request_chan(nandc->dev, "rxtx");
+		if (IS_ERR(nandc->chan)) {
+			ret = PTR_ERR(nandc->chan);
+			nandc->chan = NULL;
+			dev_err_probe(nandc->dev, ret,
+				      "rxtx DMA channel request failed\n");
+			return ret;
+		}
+	}
+
+	INIT_LIST_HEAD(&nandc->desc_list);
+	INIT_LIST_HEAD(&nandc->host_list);
+
+	return 0;
+unalloc:
+	qcom_nandc_unalloc(nandc);
+	return ret;
+}
+EXPORT_SYMBOL(qcom_nandc_alloc);
diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
new file mode 100644
index 000000000000..c461c1781330
--- /dev/null
+++ b/include/linux/mtd/nand-qpic-common.h
@@ -0,0 +1,641 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * QCOM QPIC common APIs
+ *
+ * Copyright (c) 2023 Qualcomm Inc.
+ * Authors:	Md Sadre Alam		<quic_mdalam@quicinc.com>
+ *		Sricharan R		<quic_srichara@quicinc.com>
+ */
+
+#ifndef __DRIVERS_MTD_NAND_QCOM_ECC_H__
+#define __DRIVERS_MTD_NAND_QCOM_ECC_H__
+#include <linux/clk.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/dma/qcom_adm.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/delay.h>
+#include <linux/dma/qcom_bam_dma.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/types.h>
+
+/* NANDc reg offsets */
+#define	NAND_FLASH_CMD			0x00
+#define	NAND_ADDR0			0x04
+#define	NAND_ADDR1			0x08
+#define	NAND_FLASH_CHIP_SELECT		0x0c
+#define	NAND_EXEC_CMD			0x10
+#define	NAND_FLASH_STATUS		0x14
+#define	NAND_BUFFER_STATUS		0x18
+#define	NAND_DEV0_CFG0			0x20
+#define	NAND_DEV0_CFG1			0x24
+#define	NAND_DEV0_ECC_CFG		0x28
+#define	NAND_AUTO_STATUS_EN		0x2c
+#define	NAND_DEV1_CFG0			0x30
+#define	NAND_DEV1_CFG1			0x34
+#define	NAND_READ_ID			0x40
+#define	NAND_READ_STATUS		0x44
+#define	NAND_DEV_CMD0			0xa0
+#define	NAND_DEV_CMD1			0xa4
+#define	NAND_DEV_CMD2			0xa8
+#define	NAND_DEV_CMD_VLD		0xac
+#define NAND_FLASH_SPI_CFG              0xc0
+#define NAND_NUM_ADDR_CYCLES        	0xc4
+#define NAND_BUSY_CHECK_WAIT_CNT    	0xc8
+#define	SFLASHC_BURST_CFG		0xe0
+#define	NAND_ERASED_CW_DETECT_CFG	0xe8
+#define	NAND_ERASED_CW_DETECT_STATUS	0xec
+#define	NAND_EBI2_ECC_BUF_CFG		0xf0
+#define	FLASH_BUF_ACC			0x100
+
+#define	NAND_CTRL			0xf00
+#define	NAND_VERSION			0xf08
+#define	NAND_READ_LOCATION_0		0xf20
+#define	NAND_READ_LOCATION_1		0xf24
+#define	NAND_READ_LOCATION_2		0xf28
+#define	NAND_READ_LOCATION_3		0xf2c
+#define	NAND_READ_LOCATION_LAST_CW_0	0xf40
+#define	NAND_READ_LOCATION_LAST_CW_1	0xf44
+#define	NAND_READ_LOCATION_LAST_CW_2	0xf48
+#define	NAND_READ_LOCATION_LAST_CW_3	0xf4c
+#define NAND_MSTR_CONFIG           	0xf60
+#define NAND_FLASH_FEATURES             0xf64
+
+/*
+ * the NAND controller performs reads/writes with ECC in 516 byte chunks.
+ * the driver calls the chunks 'step' or 'codeword' interchangeably
+ */
+#define	NANDC_STEP_SIZE			512
+
+/* dummy register offsets, used by write_reg_dma */
+#define	NAND_DEV_CMD1_RESTORE		0xdead
+#define	NAND_DEV_CMD_VLD_RESTORE	0xbeef
+
+/* NAND_FLASH_CMD bits */
+#define	PAGE_ACC			BIT(4)
+#define	LAST_PAGE			BIT(5)
+
+/* NAND_FLASH_CHIP_SELECT bits */
+#define	NAND_DEV_SEL			0
+#define	DM_EN				BIT(2)
+
+/* NAND_FLASH_STATUS bits */
+#define	FS_OP_ERR			BIT(4)
+#define	FS_READY_BSY_N			BIT(5)
+#define	FS_MPU_ERR			BIT(8)
+#define	FS_DEVICE_STS_ERR		BIT(16)
+#define	FS_DEVICE_WP			BIT(23)
+
+/* NAND_BUFFER_STATUS bits */
+#define	BS_UNCORRECTABLE_BIT		BIT(8)
+#define	BS_CORRECTABLE_ERR_MSK		0x1f
+
+/* NAND_DEVn_CFG0 bits */
+#define	DISABLE_STATUS_AFTER_WRITE	4
+#define	CW_PER_PAGE			6
+#define	UD_SIZE_BYTES			9
+#define	UD_SIZE_BYTES_MASK		GENMASK(18, 9)
+#define	ECC_PARITY_SIZE_BYTES_RS	19
+#define	SPARE_SIZE_BYTES		23
+#define	SPARE_SIZE_BYTES_MASK		GENMASK(26, 23)
+#define	NUM_ADDR_CYCLES			27
+#define	STATUS_BFR_READ			30
+#define	SET_RD_MODE_AFTER_STATUS	31
+
+/* NAND_DEVn_CFG0 bits */
+#define	DEV0_CFG1_ECC_DISABLE		0
+#define	WIDE_FLASH			1
+#define	NAND_RECOVERY_CYCLES		2
+#define	CS_ACTIVE_BSY			5
+#define	BAD_BLOCK_BYTE_NUM		6
+#define	BAD_BLOCK_IN_SPARE_AREA		16
+#define	WR_RD_BSY_GAP			17
+#define	ENABLE_BCH_ECC			27
+
+/* NAND_DEV0_ECC_CFG bits */
+#define	ECC_CFG_ECC_DISABLE		0
+#define	ECC_SW_RESET			1
+#define	ECC_MODE			4
+#define	ECC_PARITY_SIZE_BYTES_BCH	8
+#define	ECC_NUM_DATA_BYTES		16
+#define	ECC_NUM_DATA_BYTES_MASK		GENMASK(25, 16)
+#define	ECC_FORCE_CLK_OPEN		30
+
+/* NAND_DEV_CMD1 bits */
+#define	READ_ADDR			0
+
+/* NAND_DEV_CMD_VLD bits */
+#define	READ_START_VLD			BIT(0)
+#define	READ_STOP_VLD			BIT(1)
+#define	WRITE_START_VLD			BIT(2)
+#define	ERASE_START_VLD			BIT(3)
+#define	SEQ_READ_START_VLD		BIT(4)
+
+/* NAND_EBI2_ECC_BUF_CFG bits */
+#define	NUM_STEPS			0
+
+/* NAND_ERASED_CW_DETECT_CFG bits */
+#define	ERASED_CW_ECC_MASK		1
+#define	AUTO_DETECT_RES			0
+#define	MASK_ECC			(1 << ERASED_CW_ECC_MASK)
+#define	RESET_ERASED_DET		(1 << AUTO_DETECT_RES)
+#define	ACTIVE_ERASED_DET		(0 << AUTO_DETECT_RES)
+#define	CLR_ERASED_PAGE_DET		(RESET_ERASED_DET | MASK_ECC)
+#define	SET_ERASED_PAGE_DET		(ACTIVE_ERASED_DET | MASK_ECC)
+
+/* NAND_ERASED_CW_DETECT_STATUS bits */
+#define	PAGE_ALL_ERASED			BIT(7)
+#define	CODEWORD_ALL_ERASED		BIT(6)
+#define	PAGE_ERASED			BIT(5)
+#define	CODEWORD_ERASED			BIT(4)
+#define	ERASED_PAGE			(PAGE_ALL_ERASED | PAGE_ERASED)
+#define	ERASED_CW			(CODEWORD_ALL_ERASED | CODEWORD_ERASED)
+
+/* NAND_READ_LOCATION_n bits */
+#define READ_LOCATION_OFFSET		0
+#define READ_LOCATION_SIZE		16
+#define READ_LOCATION_LAST		31
+
+/* Version Mask */
+#define	NAND_VERSION_MAJOR_MASK		0xf0000000
+#define	NAND_VERSION_MAJOR_SHIFT	28
+#define	NAND_VERSION_MINOR_MASK		0x0fff0000
+#define	NAND_VERSION_MINOR_SHIFT	16
+
+/* NAND OP_CMDs */
+#define	OP_PAGE_READ			0x2
+#define	OP_PAGE_READ_WITH_ECC		0x3
+#define	OP_PAGE_READ_WITH_ECC_SPARE	0x4
+#define	OP_PAGE_READ_ONFI_READ		0x5
+#define	OP_PROGRAM_PAGE			0x6
+#define	OP_PAGE_PROGRAM_WITH_ECC	0x7
+#define	OP_PROGRAM_PAGE_SPARE		0x9
+#define	OP_BLOCK_ERASE			0xa
+#define	OP_CHECK_STATUS			0xc
+#define	OP_FETCH_ID			0xb
+#define	OP_RESET_DEVICE			0xd
+#define ACC_FEATURE			0xe
+
+/* Default Value for NAND_DEV_CMD_VLD */
+#define NAND_DEV_CMD_VLD_VAL		(READ_START_VLD | WRITE_START_VLD | \
+					 ERASE_START_VLD | SEQ_READ_START_VLD)
+/* NAND_CTRL bits */
+#define	BAM_MODE_EN			BIT(0)
+
+/*
+ * the largest page size we support is 8K, this will have 16 steps/codewords
+ * of 512 bytes each
+ */
+#define	MAX_NUM_STEPS			(SZ_8K / NANDC_STEP_SIZE)
+
+/* we read at most 3 registers per codeword scan */
+#define	MAX_REG_RD			(3 * MAX_NUM_STEPS)
+
+/* ECC modes supported by the controller */
+#define	ECC_NONE	BIT(0)
+#define	ECC_RS_4BIT	BIT(1)
+#define	ECC_BCH_4BIT	BIT(2)
+#define	ECC_BCH_8BIT	BIT(3)
+
+#define nandc_set_read_loc_first(chip, reg, cw_offset, read_size, is_last_read_loc)	\
+nandc_set_reg(chip, reg,			\
+	      ((cw_offset) << READ_LOCATION_OFFSET) |		\
+	      ((read_size) << READ_LOCATION_SIZE) |			\
+	      ((is_last_read_loc) << READ_LOCATION_LAST))
+
+#define nandc_set_read_loc_last(chip, reg, cw_offset, read_size, is_last_read_loc)	\
+nandc_set_reg(chip, reg,			\
+	      ((cw_offset) << READ_LOCATION_OFFSET) |		\
+	      ((read_size) << READ_LOCATION_SIZE) |			\
+	      ((is_last_read_loc) << READ_LOCATION_LAST))
+
+/*
+ * Returns the actual register address for all NAND_DEV_ registers
+ * (i.e. NAND_DEV_CMD0, NAND_DEV_CMD1, NAND_DEV_CMD2 and NAND_DEV_CMD_VLD)
+ */
+#define dev_cmd_reg_addr(nandc, reg) ((nandc)->props->dev_cmd_reg_start + (reg))
+
+/* Returns the NAND register physical address */
+#define nandc_reg_phys(chip, offset) ((chip)->base_phys + (offset))
+
+/* Returns the dma address for reg read buffer */
+#define reg_buf_dma_addr(chip, vaddr) \
+	((chip)->reg_read_dma + \
+	((uint8_t *)(vaddr) - (uint8_t *)(chip)->reg_read_buf))
+
+#define QPIC_PER_CW_CMD_ELEMENTS	32
+#define QPIC_PER_CW_CMD_SGL		32
+#define QPIC_PER_CW_DATA_SGL		8
+
+#define QPIC_NAND_COMPLETION_TIMEOUT	msecs_to_jiffies(2000)
+
+/*
+ * Flags used in DMA descriptor preparation helper functions
+ * (i.e. read_reg_dma/write_reg_dma/read_data_dma/write_data_dma)
+ */
+/* Don't set the EOT in current tx BAM sgl */
+#define NAND_BAM_NO_EOT			BIT(0)
+/* Set the NWD flag in current BAM sgl */
+#define NAND_BAM_NWD			BIT(1)
+/* Finish writing in the current BAM sgl and start writing in another BAM sgl */
+#define NAND_BAM_NEXT_SGL		BIT(2)
+/*
+ * Erased codeword status is being used two times in single transfer so this
+ * flag will determine the current value of erased codeword status register
+ */
+#define NAND_ERASED_CW_SET		BIT(4)
+
+#define MAX_ADDRESS_CYCLE		5
+
+struct qpic_ecc {
+	struct device *dev;
+	const struct qpic_ecc_caps *caps;
+	struct completion done;
+	struct mutex lock;
+	u32 sectors;
+	u8 *eccdata;
+	bool use_ecc;
+	u32 ecc_modes;
+	int ecc_bytes_hw;
+	int spare_bytes;
+	int bbm_size;
+	int ecc_mode;
+	int bytes;
+	int steps;
+	int step_size;
+	int strength;
+	bool bch_enabled;
+};
+
+
+struct device_node;
+struct qpic_ecc;
+
+struct qcom_ecc_stats {
+	u32 corrected;
+	u32 bitflips;
+	u32 failed;
+};
+
+struct qcom_ecc {
+	bool use_ecc;
+	u32 ecc_modes;
+	int ecc_bytes_hw;
+	int spare_bytes;
+	int bbm_size;
+	int ecc_mode;
+	int bytes;
+	int steps;
+	bool bch_enabled;
+};
+
+/*
+ * This data type corresponds to the BAM transaction which will be used for all
+ * NAND transfers.
+ * @bam_ce - the array of BAM command elements
+ * @cmd_sgl - sgl for NAND BAM command pipe
+ * @data_sgl - sgl for NAND BAM consumer/producer pipe
+ * @last_data_desc - last DMA desc in data channel (tx/rx).
+ * @last_cmd_desc - last DMA desc in command channel.
+ * @txn_done - completion for NAND transfer.
+ * @bam_ce_pos - the index in bam_ce which is available for next sgl
+ * @bam_ce_start - the index in bam_ce which marks the start position ce
+ *		   for current sgl. It will be used for size calculation
+ *		   for current sgl
+ * @cmd_sgl_pos - current index in command sgl.
+ * @cmd_sgl_start - start index in command sgl.
+ * @tx_sgl_pos - current index in data sgl for tx.
+ * @tx_sgl_start - start index in data sgl for tx.
+ * @rx_sgl_pos - current index in data sgl for rx.
+ * @rx_sgl_start - start index in data sgl for rx.
+ * @wait_second_completion - wait for second DMA desc completion before making
+ *			     the NAND transfer completion.
+ */
+struct bam_transaction {
+	struct bam_cmd_element *bam_ce;
+	struct scatterlist *cmd_sgl;
+	struct scatterlist *data_sgl;
+	struct dma_async_tx_descriptor *last_data_desc;
+	struct dma_async_tx_descriptor *last_cmd_desc;
+	struct completion txn_done;
+	u32 bam_ce_pos;
+	u32 bam_ce_start;
+	u32 cmd_sgl_pos;
+	u32 cmd_sgl_start;
+	u32 tx_sgl_pos;
+	u32 tx_sgl_start;
+	u32 rx_sgl_pos;
+	u32 rx_sgl_start;
+	bool wait_second_completion;
+};
+
+/*
+ * This data type corresponds to the nand dma descriptor
+ * @dma_desc - low level DMA engine descriptor
+ * @list - list for desc_info
+ *
+ * @adm_sgl - sgl which will be used for single sgl dma descriptor. Only used by
+ *	      ADM
+ * @bam_sgl - sgl which will be used for dma descriptor. Only used by BAM
+ * @sgl_cnt - number of SGL in bam_sgl. Only used by BAM
+ * @dir - DMA transfer direction
+ */
+struct desc_info {
+	struct dma_async_tx_descriptor *dma_desc;
+	struct list_head node;
+
+	union {
+		struct scatterlist adm_sgl;
+		struct {
+			struct scatterlist *bam_sgl;
+			int sgl_cnt;
+		};
+	};
+	enum dma_data_direction dir;
+};
+
+/*
+ * holds the current register values that we want to write. acts as a contiguous
+ * chunk of memory which we use to write the controller registers through DMA.
+ */
+struct nandc_regs {
+	__le32 cmd;
+	__le32 addr0;
+	__le32 addr1;
+	__le32 chip_sel;
+	__le32 exec;
+
+	__le32 cfg0;
+	__le32 cfg1;
+	__le32 ecc_bch_cfg;
+
+	__le32 clrflashstatus;
+	__le32 clrreadstatus;
+
+	__le32 cmd1;
+	__le32 vld;
+
+	__le32 orig_cmd1;
+	__le32 orig_vld;
+
+	__le32 ecc_buf_cfg;
+	__le32 read_location0;
+	__le32 read_location1;
+	__le32 read_location2;
+	__le32 read_location3;
+	__le32 read_location_last0;
+	__le32 read_location_last1;
+	__le32 read_location_last2;
+	__le32 read_location_last3;
+	__le32 flash_feature;
+	__le32 spi_cfg;
+	__le32 num_addr_cycle;
+	__le32 busy_wait_cnt;
+	__le32 mstr_cfg;
+
+	__le32 erased_cw_detect_cfg_clr;
+	__le32 erased_cw_detect_cfg_set;
+};
+
+/*
+ * This data type corresponds to the NAND controller properties which varies
+ * among different NAND controllers.
+ * @dev_cmd_reg_start - NAND_DEV_CMD_* registers starting offset
+ * @is_bam - whether NAND controller is using BAM
+ * @is_qpic - whether NAND CTRL is part of qpic IP
+ * @qpic_v2 - flag to indicate QPIC IP version 2
+ * @use_codeword_fixup - whether NAND has different layout for boot partitions
+ */
+struct qcom_nandc_props {
+	u32 dev_cmd_reg_start;
+	bool is_bam;
+	bool is_qpic;
+	bool qpic_v2;
+	bool use_codeword_fixup;
+};
+
+/*
+ * NAND controller data struct
+ *
+ * @dev:			parent device
+ *
+ * @base:			MMIO base
+ *
+ * @core_clk:			controller clock
+ * @aon_clk:			another controller clock
+ *
+ * @regs:			a contiguous chunk of memory for DMA register
+ *				writes. contains the register values to be
+ *				written to controller
+ *
+ * @props:			properties of current NAND controller,
+ *				initialized via DT match data
+ *
+ * @controller:			base controller structure
+ * @host_list:			list containing all the chips attached to the
+ *				controller
+ *
+ * @chan:			dma channel
+ * @cmd_crci:			ADM DMA CRCI for command flow control
+ * @data_crci:			ADM DMA CRCI for data flow control
+ *
+ * @desc_list:			DMA descriptor list (list of desc_infos)
+ *
+ * @data_buffer:		our local DMA buffer for page read/writes,
+ *				used when we can't use the buffer provided
+ *				by upper layers directly
+ * @reg_read_buf:		local buffer for reading back registers via DMA
+ *
+ * @base_phys:			physical base address of controller registers
+ * @base_dma:			dma base address of controller registers
+ * @reg_read_dma:		contains dma address for register read buffer
+ *
+ * @buf_size/count/start:	markers for chip->legacy.read_buf/write_buf
+ *				functions
+ * @max_cwperpage:		maximum QPIC codewords required. calculated
+ *				from all connected NAND devices pagesize
+ *
+ * @reg_read_pos:		marker for data read in reg_read_buf
+ *
+ * @cmd1/vld:			some fixed controller register values
+ *
+ * @exec_opwrite:		flag to select correct number of code word
+ *				while reading status
+ */
+struct qcom_nand_controller {
+	struct spi_controller *ctlr;
+	struct device *dev;
+
+	void __iomem *base;
+
+	struct clk *core_clk;
+	struct clk *aon_clk;
+	struct clk *iomacro_clk;
+
+	struct nandc_regs *regs;
+	struct bam_transaction *bam_txn;
+
+	const struct qcom_nandc_props *props;
+
+	struct nand_controller controller;
+	struct list_head host_list;
+
+	union {
+		/* will be used only by QPIC for BAM DMA */
+		struct {
+			struct dma_chan *tx_chan;
+			struct dma_chan *rx_chan;
+			struct dma_chan *cmd_chan;
+		};
+
+		/* will be used only by EBI2 for ADM DMA */
+		struct {
+			struct dma_chan *chan;
+			unsigned int cmd_crci;
+			unsigned int data_crci;
+		};
+	};
+
+	struct list_head desc_list;
+
+	u8		*data_buffer;
+	__le32		*reg_read_buf;
+
+	struct qpic_ecc *ecc;
+	struct qcom_ecc_stats ecc_stats;
+	struct nand_ecc_engine ecc_eng;
+	phys_addr_t base_phys;
+	dma_addr_t base_dma;
+	dma_addr_t reg_read_dma;
+
+	int		buf_size;
+	int		buf_count;
+	int		buf_start;
+	unsigned int	max_cwperpage;
+
+	int reg_read_pos;
+
+	u32 cmd1, vld;
+	bool exec_opwrite;
+};
+
+/*
+ * NAND chip structure
+ *
+ * @boot_partitions:		array of boot partitions where offset and size of the
+ *				boot partitions are stored
+ *
+ * @chip:			base NAND chip structure
+ * @node:			list node to add itself to host_list in
+ *				qcom_nand_controller
+ *
+ * @nr_boot_partitions:		count of the boot partitions where spare data is not
+ *				protected by ECC
+ *
+ * @cs:				chip select value for this chip
+ * @cw_size:			the number of bytes in a single step/codeword
+ *				of a page, consisting of all data, ecc, spare
+ *				and reserved bytes
+ * @cw_data:			the number of bytes within a codeword protected
+ *				by ECC
+ * @ecc_bytes_hw:		ECC bytes used by controller hardware for this
+ *				chip
+ *
+ * @last_command:		keeps track of last command on this chip. used
+ *				for reading correct status
+ *
+ * @cfg0, cfg1, cfg0_raw..:	NANDc register configurations needed for
+ *				ecc/non-ecc mode for the current nand flash
+ *				device
+ *
+ * @status:			value to be returned if NAND_CMD_STATUS command
+ *				is executed
+ * @codeword_fixup:		keep track of the current layout used by
+ *				the driver for read/write operation.
+ * @use_ecc:			request the controller to use ECC for the
+ *				upcoming read/write
+ * @bch_enabled:		flag to tell whether BCH ECC mode is used
+ */
+struct qcom_nand_host {
+	struct qcom_nand_boot_partition *boot_partitions;
+
+	struct nand_chip chip;
+	struct list_head node;
+
+	int nr_boot_partitions;
+
+	int cs;
+	int cw_size;
+	int cw_data;
+	int ecc_bytes_hw;
+	int spare_bytes;
+	int bbm_size;
+
+	int last_command;
+
+	u32 cfg0, cfg1;
+	u32 cfg0_raw, cfg1_raw;
+	u32 ecc_buf_cfg;
+	u32 ecc_bch_cfg;
+	u32 clrflashstatus;
+	u32 clrreadstatus;
+
+	u8 status;
+	bool codeword_fixup;
+	bool use_ecc;
+	bool bch_enabled;
+};
+
+struct qcom_nand_host *to_qcom_nand_host(struct nand_chip *chip);
+
+struct qcom_nand_controller *get_qcom_nand_controller(struct nand_chip *chip);
+
+void qcom_ecc_enable(struct qcom_ecc *ecc);
+
+void qcom_ecc_disable(struct qcom_ecc *ecc);
+
+struct qcom_ecc *of_qcom_ecc_get(struct device_node *);
+
+int qcom_ecc_config(struct qpic_ecc *ecc, int ecc_strength,
+			bool wide_bus);
+
+int qcom_nandc_alloc(struct qcom_nand_controller *nandc);
+
+void qcom_nandc_unalloc(struct qcom_nand_controller *nandc);
+
+int qcom_nandc_setup(struct qcom_nand_controller *nandc);
+
+struct bam_transaction *
+alloc_bam_transaction(struct qcom_nand_controller *nandc);
+
+void clear_bam_transaction(struct qcom_nand_controller *nandc);
+int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
+				  struct dma_chan *chan,
+				  unsigned long flags);
+int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
+			     int reg_off, const void *vaddr, int size,
+			     bool flow_control);
+
+int submit_descs(struct qcom_nand_controller *nandc);
+
+void free_descs(struct qcom_nand_controller *nandc);
+
+void nandc_set_reg(struct qcom_nand_controller *nandc, int offset,
+			  u32 val);
+int write_reg_dma(struct qcom_nand_controller *nandc, int first,
+			 int num_regs, unsigned int flags);
+
+int read_reg_dma(struct qcom_nand_controller *nandc, int first,
+			int num_regs, unsigned int flags);
+void clear_read_regs(struct qcom_nand_controller *nandc);
+
+void nandc_read_buffer_sync(struct qcom_nand_controller *nandc,
+					  bool is_cpu);
+struct qpic_ecc *of_qpic_ecc_get(struct device_node *);
+#endif
+
-- 
2.34.1

