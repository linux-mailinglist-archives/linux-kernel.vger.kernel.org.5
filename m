Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FDC7DCC88
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344129AbjJaMEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344186AbjJaMEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:04:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F0A5586;
        Tue, 31 Oct 2023 05:03:58 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VBo1qO031040;
        Tue, 31 Oct 2023 12:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=AuA+t3/r+JWkHJYnQkTl6/U/0J6YgPnNxPXKN17FIh8=;
 b=eUQ3E53H8zHWCLYUq67ehRCwxTDm17SfNL6iWxzPoR2gTvF7PWEd2+ZvfnaM2RgqLVjY
 Y0zujWxAoZSi0lcKi4Eeh9AKt4QwHcQIOgbvTlP0k8qil32nLq3uDA0hKpvNV8BCPYtB
 YA9VyHApdN1on2GhltGwtcW3Qih+QGOkIuf5MJLK3PwdKmaKm63C80uu+ZeSRrzDC8OA
 t+p5uOdRDZ6tBicmVXz/+AHAXsOcLeTysnVK+aQkbHkpjUT09SthVm+nmBGnj3gpl97h
 VsZCq0+jGd9mlHU1xVkg2CLtPEJ73rf6E4lxWc4S24lFK1ujBPaof4yMYe6jhOPfvwQL 7w== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2dey2thn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:13 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39VC3AH9005259;
        Tue, 31 Oct 2023 12:03:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3u0uckvvp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:10 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39VC3AjF005252;
        Tue, 31 Oct 2023 12:03:10 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 39VC3AnZ005251
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:10 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
        id 9B6D64162D; Tue, 31 Oct 2023 17:33:09 +0530 (+0530)
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
Subject: [RFC PATCH 1/5] mtd: nand: ecc-qcom: Add support for ECC Engine Driver
Date:   Tue, 31 Oct 2023 17:33:03 +0530
Message-Id: <20231031120307.1600689-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LA_jYFVdTJG1wQuJR_Athd-pxEwgUZVJ
X-Proofpoint-GUID: LA_jYFVdTJG1wQuJR_Athd-pxEwgUZVJ
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

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
---
 drivers/mtd/nand/Kconfig    |   7 ++
 drivers/mtd/nand/Makefile   |   1 +
 drivers/mtd/nand/ecc-qcom.c | 198 ++++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 drivers/mtd/nand/ecc-qcom.c

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 5b0c2c95f10c..333cec8187c8 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -61,6 +61,13 @@ config MTD_NAND_ECC_MEDIATEK
 	help
 	  This enables support for the hardware ECC engine from Mediatek.
 
+config MTD_NAND_ECC_QCOM
+	tristate "Qualcomm hardware ECC engine"
+	depends on ARCH_QCOM
+	select MTD_NAND_ECC
+	help
+	  This enables support for the hardware ECC engine from Qualcomm.
+
 endmenu
 
 endmenu
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 19e1291ac4d5..c73b8a3456ec 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -3,6 +3,7 @@
 nandcore-objs := core.o bbt.o
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_NAND_ECC_MEDIATEK) += ecc-mtk.o
+obj-$(CONFIG_MTD_NAND_ECC_QCOM) += ecc-qcom.o qpic_common.o
 
 obj-y	+= onenand/
 obj-y	+= raw/
diff --git a/drivers/mtd/nand/ecc-qcom.c b/drivers/mtd/nand/ecc-qcom.c
new file mode 100644
index 000000000000..a85423ed368a
--- /dev/null
+++ b/drivers/mtd/nand/ecc-qcom.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * QCOM ECC Engine  Driver.
+ * Copyright (C) 2023  Qualcomm Inc.
+ * Authors:	Md sadre Alam		<quic_mdalam@quicinc.com>
+ *		Sricharan R		<quic_srichara@quicinc.com>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/iopoll.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/mutex.h>
+#include <linux/mtd/nand-qpic-common.h>
+
+
+
+/* ECC modes supported by the controller */
+#define ECC_NONE        BIT(0)
+#define ECC_RS_4BIT     BIT(1)
+#define ECC_BCH_4BIT    BIT(2)
+#define ECC_BCH_8BIT    BIT(3)
+
+struct qpic_ecc_caps {
+	u32 err_mask;
+	u32 err_shift;
+	const u8 *ecc_strength;
+	const u32 *ecc_regs;
+	u8 num_ecc_strength;
+	u8 ecc_mode_shift;
+	u32 parity_bits;
+	int pg_irq_sel;
+};
+
+
+struct qcom_nand_host *to_qcom_nand_host(struct nand_chip *chip)
+{
+	return container_of(chip, struct qcom_nand_host, chip);
+}
+EXPORT_SYMBOL(to_qcom_nand_host);
+
+struct qcom_nand_controller *
+get_qcom_nand_controller(struct nand_chip *chip)
+{
+	return container_of(chip->controller, struct qcom_nand_controller,
+			    controller);
+}
+EXPORT_SYMBOL(get_qcom_nand_controller);
+
+static struct qpic_ecc *qpic_ecc_get(struct device_node *np)
+{
+	struct platform_device *pdev;
+	struct qpic_ecc *ecc;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	ecc = platform_get_drvdata(pdev);
+	if (!ecc) {
+		put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	return ecc;
+}
+
+struct qpic_ecc *of_qpic_ecc_get(struct device_node *of_node)
+{
+	struct qpic_ecc *ecc = NULL;
+	struct device_node *np;
+
+	np = of_parse_phandle(of_node, "nand-ecc-engine", 0);
+	/* for backward compatibility */
+	if (!np)
+		np = of_parse_phandle(of_node, "ecc-engine", 0);
+	if (np) {
+		ecc = qpic_ecc_get(np);
+		of_node_put(np);
+	}
+
+	return ecc;
+}
+EXPORT_SYMBOL(of_qpic_ecc_get);
+
+int qcom_ecc_config(struct qpic_ecc  *ecc, int ecc_strength,
+			bool wide_bus)
+{
+	ecc->ecc_modes = (ECC_RS_4BIT | ECC_BCH_8BIT);
+
+	if (ecc_strength >= 8) {
+		/* 8 bit ECC defaults to BCH ECC on all platforms */
+		ecc->bch_enabled = true;
+		ecc->ecc_mode = 1;
+
+		if (wide_bus) {
+			ecc->ecc_bytes_hw = 14;
+			ecc->spare_bytes = 0;
+			ecc->bbm_size = 2;
+		} else {
+			ecc->ecc_bytes_hw = 13;
+			ecc->spare_bytes = 2;
+			ecc->bbm_size = 1;
+		}
+	} else {
+		/*
+		 * if the controller supports BCH for 4 bit ECC, the controller
+		 * uses lesser bytes for ECC. If RS is used, the ECC bytes is
+		 * always 10 bytes
+		 */
+		if (ecc->ecc_modes & ECC_BCH_4BIT) {
+			/* BCH */
+			ecc->bch_enabled = true;
+			ecc->ecc_mode = 0;
+			if (wide_bus) {
+				ecc->ecc_bytes_hw = 8;
+				ecc->spare_bytes = 2;
+				ecc->bbm_size = 2;
+			} else {
+				ecc->ecc_bytes_hw = 7;
+				ecc->spare_bytes = 4;
+				ecc->bbm_size = 1;
+			}
+		} else {
+			/* RS */
+			ecc->ecc_bytes_hw = 10;
+			if (wide_bus) {
+				ecc->spare_bytes = 0;
+				ecc->bbm_size = 2;
+			} else {
+				ecc->spare_bytes = 1;
+				ecc->bbm_size = 1;
+			}
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(qcom_ecc_config);
+
+void qcom_ecc_enable(struct qcom_ecc *ecc)
+{
+	ecc->use_ecc = true;
+}
+EXPORT_SYMBOL(qcom_ecc_enable);
+
+void qcom_ecc_disable(struct qcom_ecc *ecc)
+{
+	ecc->use_ecc = false;
+}
+EXPORT_SYMBOL(qcom_ecc_disable);
+
+static const struct of_device_id qpic_ecc_dt_match[] = {
+	{
+		.compatible = "qcom,ipq9574-ecc",
+	},
+	{},
+};
+
+static int qpic_ecc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct qpic_ecc *ecc;
+	u32 max_eccdata_size;
+
+	ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
+	if (!ecc)
+		return -ENOMEM;
+
+	ecc->caps = of_device_get_match_data(dev);
+
+	ecc->dev = dev;
+	platform_set_drvdata(pdev, ecc);
+	dev_info(dev, "probed\n");
+
+	return 0;
+}
+
+
+MODULE_DEVICE_TABLE(of, qpic_ecc_dt_match);
+
+static struct platform_driver qpic_ecc_driver = {
+	.probe  = qpic_ecc_probe,
+	.driver = {
+		.name  = "qpic-ecc",
+		.of_match_table = qpic_ecc_dt_match,
+	},
+};
+
+module_platform_driver(qpic_ecc_driver);
+
+MODULE_AUTHOR("Md Sadre Alam <quic_mdalam@quicinc.com>");
+MODULE_DESCRIPTION("QPIC Nand ECC Driver");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.34.1

