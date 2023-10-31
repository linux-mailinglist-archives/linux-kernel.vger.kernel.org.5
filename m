Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A007DCCC0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbjJaMES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbjJaMED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:04:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A365588;
        Tue, 31 Oct 2023 05:04:00 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VAv16i031351;
        Tue, 31 Oct 2023 12:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=O+c9M8C5GR+TgYgBDxM9t9RqvPvvoHQZYrVrZn0AMSQ=;
 b=hTL9czh/SL7UFk7ELNOQpP5G81ufvktzH+KO3WZeA6tB4o0sxdC7ctfMRVXfmya8hByb
 7D9VoWha7JxBfiIrH15S7sWpROa7sNufGQw5rn7jcw9gwE5t1PBHrBMaIvRWhdFBOiAO
 i0rGsBOU2Kl6U5/xaMTi4gIb6DIGChwDJq4+UaB50f2BEcc+ZboT8wPhhG4s7/51z1EO
 QF2cAYqKORHVIysBWDu0u6e7qIYzZ52rLUNozGh4/2XvOfUXkui4UxXr1vJUMkv1Q+19
 2aMdmyrCcn+ExjsdzHwAB0OoczCYXIxJKPrmTqW1KyUKnF5o/5V71w5myuKzsMkKgPuL Sw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2fcb2crs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:16 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39VC3DXe005297;
        Tue, 31 Oct 2023 12:03:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3u0uckvvpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:13 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39VC3BKd005266;
        Tue, 31 Oct 2023 12:03:12 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 39VC3COL005288
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:12 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
        id 93436414B1; Tue, 31 Oct 2023 17:33:11 +0530 (+0530)
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
Subject: [RFC PATCH 4/5] spi: qpic: Add support for qpic spi nand driver
Date:   Tue, 31 Oct 2023 17:33:06 +0530
Message-Id: <20231031120307.1600689-5-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GwmH9e_J4Djzt240FcMATfsDrikv9bU5
X-Proofpoint-GUID: GwmH9e_J4Djzt240FcMATfsDrikv9bU5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310094
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qpic spi nand driver support for qcom soc.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
---
 drivers/spi/Kconfig          |   7 +
 drivers/spi/Makefile         |   1 +
 drivers/spi/spi-qpic-snand.c | 604 +++++++++++++++++++++++++++++++++++
 3 files changed, 612 insertions(+)
 create mode 100644 drivers/spi/spi-qpic-snand.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 35dbfacecf1c..8dc96bda8b17 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -206,6 +206,13 @@ config SPI_BCM_QSPI
 	  based platforms. This driver works for both SPI master for SPI NOR
 	  flash device as well as MSPI device.
 
+config SPI_QPIC_SNAND
+	tristate "QPIC SNAND controller"
+	default y
+	depends on ARCH_QCOM
+	help
+	  QPIC_SNAND(Quad SPI) driver for Qualcomm QPIC_SNAND controller.
+
 config SPI_BCMBCA_HSSPI
 	tristate "Broadcom BCMBCA HS SPI controller driver"
 	depends on ARCH_BCMBCA || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 4ff8d725ba5e..1ac3bac35007 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -153,6 +153,7 @@ obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
 obj-$(CONFIG_SPI_ZYNQ_QSPI)		+= spi-zynq-qspi.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 obj-$(CONFIG_SPI_AMD)			+= spi-amd.o
+obj-$(CONFIG_SPI_QPIC_SNAND)            += spi-qpic-snand.o
 
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
new file mode 100644
index 000000000000..1c7957079741
--- /dev/null
+++ b/drivers/spi/spi-qpic-snand.c
@@ -0,0 +1,604 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * Authors:
+ * 	Md Sadre Alam <quic_mdalam@quicinc.com>
+ * 	Sricharan R <quic_srichara@quicinc.com>
+ */
+
+#include <linux/mtd/spinand.h>
+#include <linux/mtd/nand-qpic-common.h>
+
+/* QSPI NAND config reg bits */
+#define LOAD_CLK_CNTR_INIT_EN   (1 << 28)
+#define CLK_CNTR_INIT_VAL_VEC   0x924
+#define FEA_STATUS_DEV_ADDR     0xc0
+#define SPI_CFG (1 << 0)
+#define SPI_NUM_ADDR    0xDA4DB
+#define SPI_WAIT_CNT        0x10
+#define QPIC_QSPI_NUM_CS	1
+#define SPI_TRANSFER_MODE_x1	(1 << 29)
+#define SPI_TRANSFER_MODE_x4	(3 << 29)
+#define SPI_WP			(1 << 28)
+#define SPI_HOLD		(1 << 27)
+#define QPIC_SET_FEATURE	(1 << 31)
+
+
+#define SPINAND_RESET		0xff
+#define SPINAND_READID		0x9f
+#define SPINAND_GET_FEATURE	0x0f
+#define SPINAND_SET_FEATURE	0x1f
+
+struct qpic_snand_xfer {
+	union {
+		const void *snand_tx_buf;
+		void *snand_rx_buf;
+	};
+	unsigned int snand_rem_bytes;
+	unsigned int snand_buswidth;
+};
+
+struct qpic_snand_op {
+	u32 cmd_reg;
+	u32 addr1_reg;
+	u32 addr2_reg;
+};
+
+static struct qcom_nand_controller *nand_to_qcom_snand(struct nand_device *nand)
+{
+	struct nand_ecc_engine *eng = nand->ecc.engine;
+
+	return container_of(eng, struct qcom_nand_controller, ecc_eng);
+}
+
+static int qcom_snand_init(struct qcom_nand_controller *snandc)
+{
+	u32 snand_cfg_val = 0x0;
+	int ret;
+
+	snand_cfg_val |= (LOAD_CLK_CNTR_INIT_EN | (CLK_CNTR_INIT_VAL_VEC << 16)
+			| (FEA_STATUS_DEV_ADDR << 8) | SPI_CFG);
+
+	nandc_set_reg(snandc, NAND_FLASH_SPI_CFG, 0);
+	nandc_set_reg(snandc, NAND_FLASH_SPI_CFG, snand_cfg_val);
+	nandc_set_reg(snandc, NAND_NUM_ADDR_CYCLES, SPI_NUM_ADDR);
+	nandc_set_reg(snandc, NAND_BUSY_CHECK_WAIT_CNT, SPI_WAIT_CNT);
+
+	write_reg_dma(snandc, NAND_FLASH_SPI_CFG, 1, 0);
+	write_reg_dma(snandc, NAND_FLASH_SPI_CFG, 1, 0);
+
+	snand_cfg_val &= ~LOAD_CLK_CNTR_INIT_EN;
+	nandc_set_reg(snandc, NAND_FLASH_SPI_CFG, snand_cfg_val);
+
+	write_reg_dma(snandc, NAND_FLASH_SPI_CFG, 1, 0);
+
+	write_reg_dma(snandc, NAND_NUM_ADDR_CYCLES, 1, 0);
+	write_reg_dma(snandc, NAND_BUSY_CHECK_WAIT_CNT, 1, NAND_BAM_NEXT_SGL);
+
+	ret = submit_descs(snandc);
+	if (ret)
+		dev_err(snandc->dev, "failure in sbumitting spiinit descriptor\n");
+
+	free_descs(snandc);
+
+	return 0;
+}
+
+static int qcom_snand_ooblayout_ecc(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *oobregion)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
+	struct qpic_ecc *qecc = snandc->ecc;
+
+	if (section > 1)
+		return -ERANGE;
+
+	if (!section) {
+		oobregion->length = (qecc->bytes * (qecc->steps - 1)) +
+			qecc->bbm_size;
+		oobregion->offset = 0;
+	} else {
+		 oobregion->length = qecc->ecc_bytes_hw + qecc->spare_bytes;
+		 oobregion->offset = mtd->oobsize - oobregion->length;
+	}
+
+	return 0;
+}
+
+static int qcom_snand_ooblayout_free(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *oobregion)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
+	struct qpic_ecc *qecc = snandc->ecc;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = qecc->steps * 4;
+	oobregion->offset = ((qecc->steps - 1) * qecc->bytes) + qecc->bbm_size;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops qcom_snand_ooblayout = {
+	.ecc = qcom_snand_ooblayout_ecc,
+	.free = qcom_snand_ooblayout_free,
+};
+
+static int qpic_snand_ecc_init_ctx(struct nand_device *nand)
+{
+	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
+	struct nand_ecc_props *conf = &nand->ecc.ctx.conf;
+	struct nand_ecc_props *reqs = &nand->ecc.requirements;
+	struct nand_ecc_props *user = &nand->ecc.user_conf;
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	int step_size = 0, strength = 0, desired_correction = 0, steps;
+	bool ecc_user = false;
+	int ret;
+	struct qpic_ecc *ecc_cfg;
+
+	ecc_cfg = kzalloc(sizeof(*ecc_cfg), GFP_KERNEL);
+	if (!ecc_cfg)
+		return -ENOMEM;
+
+	nand->ecc.ctx.priv = ecc_cfg;
+
+	if (user->step_size && user->strength) {
+		step_size = user->step_size;
+		strength = user->strength;
+		ecc_user = true;
+	} else if (reqs->step_size && reqs->strength) {
+		step_size = reqs->step_size;
+		strength = reqs->strength;
+	}
+
+	if (step_size && strength) {
+		steps = mtd->writesize / step_size;
+		desired_correction = steps * strength;
+	}
+
+	qcom_ecc_config(ecc_cfg, 4, false);
+
+	ecc_cfg->bytes = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes + ecc_cfg->bbm_size;
+
+	ecc_cfg->steps = 4;
+	ecc_cfg->strength = 4;
+	ecc_cfg->step_size = 512;
+
+	mtd_set_ooblayout(mtd, &qcom_snand_ooblayout);
+
+	conf->step_size = ecc_cfg->step_size;
+	conf->strength = ecc_cfg->strength;
+
+	if (ecc_cfg->strength < strength)
+		dev_warn(snandc->dev, "Unable to fulfill ECC requirements of %u bits.\n",
+			strength);
+
+	dev_info(snandc->dev, "ECC strength: %u bits per %u bytes\n",
+		ecc_cfg->strength,ecc_cfg->step_size);
+
+	return 0;
+}
+
+static void qpic_snand_ecc_cleanup_ctx(struct nand_device *nand)
+{
+	struct qcom_ecc *ecc_cfg = nand_to_ecc_ctx(nand);
+
+	kfree(ecc_cfg);
+}
+
+static int qpic_snand_ecc_prepare_io_req(struct nand_device *nand,
+					struct nand_page_io_req *req)
+{
+	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
+	struct qpic_ecc *ecc_cfg = nand_to_ecc_ctx(nand);
+	int ret;
+
+	snandc->ecc = ecc_cfg;
+	return 0;
+}
+
+static int qpic_snand_ecc_finish_io_req(struct nand_device *nand,
+				       struct nand_page_io_req *req)
+{
+	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+
+	snandc->ecc = NULL;
+	if ((req->mode == MTD_OPS_RAW) || (req->type != NAND_PAGE_READ))
+		return 0;
+
+	if (snandc->ecc_stats.failed)
+		mtd->ecc_stats.failed += snandc->ecc_stats.failed;
+	mtd->ecc_stats.corrected += snandc->ecc_stats.corrected;
+
+	return snandc->ecc_stats.failed ? -EBADMSG : snandc->ecc_stats.bitflips;
+}
+
+static struct nand_ecc_engine_ops qcom_snand_ecc_engine_ops = {
+	.init_ctx = qpic_snand_ecc_init_ctx,
+	.cleanup_ctx = qpic_snand_ecc_cleanup_ctx,
+	.prepare_io_req = qpic_snand_ecc_prepare_io_req,
+	.finish_io_req = qpic_snand_ecc_finish_io_req,
+};
+
+static int qpic_snand_read_page(struct qcom_nand_controller *snandc,
+				const struct spi_mem_op *op)
+{
+	return 0;
+}
+
+static int qpic_snand_write_page(struct qcom_nand_controller *snandc,
+				const struct spi_mem_op *op)
+{
+	return 0;
+}
+
+static u32 qpic_snand_cmd_mapping(u32 opcode)
+{
+	u32 cmd = 0x0;
+	switch (opcode) {
+
+		case SPINAND_RESET:
+			cmd = (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 |
+				OP_RESET_DEVICE);
+			break;
+		case SPINAND_READID:
+			cmd = (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 |
+				OP_FETCH_ID);
+			break;
+		case SPINAND_GET_FEATURE:
+			cmd = (SPI_TRANSFER_MODE_x1 | SPI_WP |
+				SPI_HOLD | ACC_FEATURE);
+			break;
+		case SPINAND_SET_FEATURE:
+			cmd = (SPI_TRANSFER_MODE_x1 | SPI_WP |
+				SPI_HOLD | ACC_FEATURE |
+				QPIC_SET_FEATURE);
+			break;
+		default:
+			break;
+	}
+
+	return cmd;
+}
+
+static int qpic_snand_send_cmdaddr(const struct spi_mem_op *op,
+			struct qcom_nand_controller *snandc)
+{
+	struct qpic_snand_op s_op = {};
+	u32 cmd;
+	int ret, i;
+
+	cmd = qpic_snand_cmd_mapping(op->cmd.opcode);
+
+	s_op.cmd_reg = cmd;
+
+	for (i = 0; i < op->addr.nbytes; i++) {
+		s_op.addr1_reg = op->addr.val;
+		s_op.addr2_reg = 0;
+	}
+
+	snandc->buf_count = 0;
+	snandc->buf_start = 0;
+	clear_read_regs(snandc);
+	clear_bam_transaction(snandc);
+
+	nandc_set_reg(snandc, NAND_FLASH_CMD, s_op.cmd_reg);
+	nandc_set_reg(snandc, NAND_EXEC_CMD, 0x1);
+	nandc_set_reg(snandc, NAND_ADDR0, s_op.addr1_reg);
+	nandc_set_reg(snandc, NAND_ADDR1, s_op.addr2_reg);
+
+	write_reg_dma(snandc, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
+	write_reg_dma(snandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+
+	ret = submit_descs(snandc);
+	if (ret)
+		dev_err(snandc->dev, "failure in sbumitting cmd descriptor\n");
+
+	free_descs(snandc);
+
+	return ret;
+}
+
+static int qpic_snand_io_op(struct qcom_nand_controller *snandc,
+		const struct spi_mem_op *op)
+{
+	int ret, val;
+	bool sub_desc = false;
+
+	ret = qpic_snand_send_cmdaddr(op, snandc);
+	if (ret)
+		return ret;
+
+	snandc->buf_count = 0;
+	snandc->buf_start = 0;
+	clear_read_regs(snandc);
+	clear_bam_transaction(snandc);
+
+	if (op->cmd.opcode == SPINAND_READID) {
+		snandc->buf_count = 4;
+		read_reg_dma(snandc, NAND_READ_ID, 1,
+			NAND_BAM_NEXT_SGL);
+		sub_desc = true;
+	}
+
+	if (sub_desc) {
+		ret = submit_descs(snandc);
+		if (ret)
+			dev_err(snandc->dev, "failure in submitting descriptor\n");
+
+		free_descs(snandc);
+		nandc_read_buffer_sync(snandc, true);
+		memcpy(op->data.buf.in, snandc->reg_read_buf, snandc->buf_count);
+
+		return ret;
+	}
+
+	if (op->cmd.opcode == SPINAND_GET_FEATURE) {
+
+		snandc->buf_count = 4;
+		read_reg_dma(snandc, NAND_FLASH_FEATURES, 1,
+				NAND_BAM_NEXT_SGL);
+
+		ret = submit_descs(snandc);
+		if (ret)
+			dev_err(snandc->dev, "failure in submitting descriptor\n");
+
+		free_descs(snandc);
+		nandc_read_buffer_sync(snandc, true);
+
+		val = le32_to_cpu(*(__le32 *)snandc->reg_read_buf);
+		val >>= 8;
+		memcpy(op->data.buf.in, &val, snandc->buf_count);
+	}
+
+	if (op->cmd.opcode == SPINAND_SET_FEATURE) {
+
+		nandc_set_reg(snandc, NAND_FLASH_FEATURES, *(u32 *)op->data.buf.out);
+		write_reg_dma(snandc, NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL);
+
+		ret = submit_descs(snandc);
+		if (ret)
+			dev_err(snandc->dev, "failure in submitting descriptor\n");
+
+		free_descs(snandc);
+	}
+
+	return ret;
+}
+
+static bool qpic_snand_is_page_op(const struct spi_mem_op *op)
+{
+	if (op->addr.nbytes != 3)
+		return false;
+
+	if (op->addr.buswidth != 1 && op->addr.buswidth != 2 &&
+	    op->addr.buswidth != 4)
+		return false;
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		/* quad io */
+		if ((op->addr.buswidth == 4 || op->addr.buswidth == 1) &&
+		     op->data.buswidth == 4)
+			return true;
+
+		/* standard spi */
+		if (op->addr.buswidth == 1 && op->data.buswidth == 1)
+			return true;
+
+	} else if (op->data.dir == SPI_MEM_DATA_OUT) {
+		/* quad io*/
+		if (op->addr.buswidth == 1 && op->data.buswidth == 4)
+			return true;
+
+		/* standard spi */
+		if (op->addr.buswidth == 1 && op->data.buswidth == 1)
+			return true;
+	}
+
+	return false;
+}
+
+static bool qpic_snand_supports_op(struct spi_mem *mem,
+				   const struct spi_mem_op *op)
+{
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
+	if (op->cmd.nbytes != 1 || op->cmd.buswidth != 1)
+		return false;
+
+	return ((op->addr.nbytes == 0 || op->addr.buswidth == 1) &&
+		(op->dummy.nbytes == 0 || op->dummy.buswidth == 1) &&
+		(op->data.nbytes == 0 || op->data.buswidth == 1));
+}
+
+static int qpic_snand_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct qcom_nand_controller *snandc = spi_controller_get_devdata(mem->spi->master);
+	dev_dbg(snandc->dev, "OP %02x ADDR %08llX@%d:%u DATA %d:%u", op->cmd.opcode,
+		op->addr.val, op->addr.buswidth, op->addr.nbytes,
+		op->data.buswidth, op->data.nbytes);
+
+	/*
+	 * Check for page ops or normal ops
+	 */
+	if (qpic_snand_is_page_op(op)) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			return qpic_snand_read_page(snandc, op);
+		else
+			return qpic_snand_write_page(snandc, op);
+	} else {
+		return qpic_snand_io_op(snandc, op);
+	}
+
+	return 0;
+}
+
+static const struct spi_controller_mem_ops qcom_spi_mem_ops = {
+	.supports_op = qpic_snand_supports_op,
+	.exec_op = qpic_snand_exec_op,
+};
+
+static const struct spi_controller_mem_caps qcom_snand_mem_caps = {
+	.ecc = true,
+};
+
+static int qcom_snand_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct spi_controller *ctlr;
+	struct qcom_nand_controller *snandc;
+	struct resource *res;
+	const void *dev_data;
+	int ret;
+
+	ctlr = devm_spi_alloc_master(dev, sizeof(*snandc));
+	if (!ctlr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ctlr);
+
+	snandc = spi_controller_get_devdata(ctlr);
+
+	snandc->ctlr = ctlr;
+	snandc->dev = dev;
+
+	snandc->ecc = of_qpic_ecc_get(np);
+	if (IS_ERR(snandc->ecc))
+		return PTR_ERR(snandc->ecc);
+	else if (!snandc->ecc)
+		return -ENODEV;
+
+	dev_data = of_device_get_match_data(dev);
+	if (!dev_data) {
+		dev_err(&pdev->dev, "failed to get device data\n");
+		return -ENODEV;
+	}
+
+	snandc->props = dev_data;
+	snandc->dev = &pdev->dev;
+
+	snandc->core_clk = devm_clk_get(dev, "core");
+	if (IS_ERR(snandc->core_clk))
+		return PTR_ERR(snandc->core_clk);
+
+	snandc->core_clk = devm_clk_get(dev, "aon");
+	if (IS_ERR(snandc->core_clk))
+		return PTR_ERR(snandc->core_clk);
+
+	snandc->core_clk = devm_clk_get(dev, "io_macro");
+	if (IS_ERR(snandc->core_clk))
+		return PTR_ERR(snandc->core_clk);
+
+	snandc->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(snandc->base))
+		return PTR_ERR(snandc->base);
+
+	snandc->base_phys = res->start;
+	snandc->base_dma = dma_map_resource(dev, res->start,
+					   resource_size(res),
+					   DMA_BIDIRECTIONAL, 0);
+	if (dma_mapping_error(dev, snandc->base_dma))
+		return -ENXIO;
+
+	ret = clk_prepare_enable(snandc->core_clk);
+	if (ret)
+		goto err_core_clk;
+
+	ret = clk_prepare_enable(snandc->aon_clk);
+	if (ret)
+		goto err_aon_clk;
+
+	ret = clk_prepare_enable(snandc->iomacro_clk);
+	if (ret)
+		goto err_snandc_alloc;
+
+	ret = qcom_nandc_alloc(snandc);
+	if (ret)
+		goto err_snandc_alloc;
+
+	ret = qcom_snand_init(snandc);
+	if (ret)
+		goto err_init;
+
+	// setup ECC engine
+	snandc->ecc_eng.dev = &pdev->dev;
+	snandc->ecc_eng.integration = NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
+	snandc->ecc_eng.ops = &qcom_snand_ecc_engine_ops;
+	snandc->ecc_eng.priv = snandc;
+
+	ret = nand_ecc_register_on_host_hw_engine(&snandc->ecc_eng);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register ecc engine.\n");
+		goto err_init;
+	}
+
+	ctlr->num_chipselect = QPIC_QSPI_NUM_CS;
+	ctlr->mem_ops = &qcom_spi_mem_ops;
+	ctlr->mem_caps = &qcom_snand_mem_caps;
+	ctlr->dev.of_node = pdev->dev.of_node;
+	ctlr->mode_bits = SPI_TX_DUAL | SPI_RX_DUAL |
+			    SPI_TX_QUAD | SPI_RX_QUAD;
+
+	ret = spi_register_master(ctlr);
+	if (ret) {
+		dev_err(&pdev->dev, "spi_register_controller failed.\n");
+		goto err_init;
+	}
+
+	return 0;
+err_init:
+	qcom_nandc_unalloc(snandc);
+err_snandc_alloc:
+	clk_disable_unprepare(snandc->aon_clk);
+err_aon_clk:
+	clk_disable_unprepare(snandc->core_clk);
+err_core_clk:
+	dma_unmap_resource(dev, res->start, resource_size(res),
+			   DMA_BIDIRECTIONAL, 0);
+
+	return ret;
+}
+
+static int qcom_snand_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	spi_unregister_master(ctlr);
+
+	return 0;
+}
+
+static const struct qcom_nandc_props ipq9574_snandc_props = {
+	.dev_cmd_reg_start = 0x7000,
+	.is_bam = true,
+	.qpic_v2 = true,
+};
+
+static const struct of_device_id qcom_snandc_of_match[] = {
+	{
+		.compatible = "qcom,ipq9574-nand",
+		.data = &ipq9574_snandc_props,
+	},
+	{}
+}
+MODULE_DEVICE_TABLE(of, qcom_snandc_of_match);
+
+static struct platform_driver qcom_snand_driver = {
+	.driver = {
+		.name		= "qcom_snand",
+		.of_match_table = qcom_snandc_of_match,
+	},
+	.probe = qcom_snand_probe,
+	.remove = qcom_snand_remove,
+};
+module_platform_driver(qcom_snand_driver);
+
+MODULE_DESCRIPTION("SPI driver for QPIC QSPI cores");
+MODULE_AUTHOR("Md Sadre Alam <quic_mdalam@quicinc.com>");
+MODULE_LICENSE("GPL");
-- 
2.34.1

