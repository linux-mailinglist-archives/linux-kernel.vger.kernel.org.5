Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AFA762272
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjGYTgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGYTgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:36:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94C32109;
        Tue, 25 Jul 2023 12:36:17 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJ9Ush010994;
        Tue, 25 Jul 2023 19:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=4l4bTEbJlnWNOQeZJ7sihbjGIVWSaO4Ah7pWorPs2IY=;
 b=m9itybXF0UTehuuXZzmy2kDiff0iD5N1eRn3BWbrzSp4h3pam1371QexJ86hOd7+0ojY
 d8+zVwmy+fKSJsQUR6eEx9hTJbMirltOwlpmSJUK+bsbprMCyOj+Wypb1Q61muZJ3HXc
 LnNReQTXKq2eIkyF8ltjsnYXXhuXgAC7U6wgEfOE1o/DWGMJCy5kDSPn6R5xt0eZ8sOa
 Rb41nrR51rDk9yGa5iJd4tYCoR60rMwinykxHfejrWf4sfV2y4nxzQgYt3mNZN+LdGkM
 3j9KkUKwzQ9vL51ugpXRr/YvBNWRQneQHbYpqlMvEuAxWMcDXLoyVnq3rP2tXjFPZiUn 4g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2fms0u81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 19:36:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PJa5tE013101
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 19:36:05 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 12:36:05 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v2 3/7] soc: qcom: add QCOM PBS driver
Date:   Tue, 25 Jul 2023 12:34:19 -0700
Message-ID: <20230725193423.25047-4-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725193423.25047-1-quic_amelende@quicinc.com>
References: <20230725193423.25047-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gyg3oj3y1FAsD2nUVdDPpfplymSahMpN
X-Proofpoint-ORIG-GUID: gyg3oj3y1FAsD2nUVdDPpfplymSahMpN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_10,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250168
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Qualcomm PBS (Programmable Boot Sequencer) driver. The QCOM PBS
driver supports configuring software PBS trigger events through PBS RAM
on Qualcomm Technologies, Inc (QTI) PMICs.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/soc/qcom/Kconfig          |   9 +
 drivers/soc/qcom/Makefile         |   1 +
 drivers/soc/qcom/qcom-pbs.c       | 302 ++++++++++++++++++++++++++++++
 include/linux/soc/qcom/qcom-pbs.h |  30 +++
 4 files changed, 342 insertions(+)
 create mode 100644 drivers/soc/qcom/qcom-pbs.c
 create mode 100644 include/linux/soc/qcom/qcom-pbs.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e597799e8121..8cf690e46bf7 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -271,6 +271,15 @@ config QCOM_APR
 	  used by audio driver to configure QDSP6
 	  ASM, ADM and AFE modules.
 
+config QCOM_PBS
+	tristate "PBS trigger support for Qualcomm PMIC"
+	depends on SPMI
+	help
+	  This driver supports configuring software programmable boot sequencer (PBS)
+	  trigger event through PBS RAM on Qualcomm Technologies, Inc. PMICs.
+	  This module provides the APIs to the client drivers that wants to send the
+	  PBS trigger event to the PBS RAM.
+
 config QCOM_ICC_BWMON
 	tristate "QCOM Interconnect Bandwidth Monitor driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 99114c71092b..3ffb04e2a275 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
 obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
 obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
+obj-$(CONFIG_QCOM_PBS) +=	qcom-pbs.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
 qcom_ice-objs			+= ice.o
 obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
diff --git a/drivers/soc/qcom/qcom-pbs.c b/drivers/soc/qcom/qcom-pbs.c
new file mode 100644
index 000000000000..73efef16650f
--- /dev/null
+++ b/drivers/soc/qcom/qcom-pbs.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/spmi.h>
+#include <linux/soc/qcom/qcom-pbs.h>
+
+#define PBS_CLIENT_TRIG_CTL		0x42
+#define PBS_CLIENT_SW_TRIG_BIT		BIT(7)
+#define PBS_CLIENT_SCRATCH1		0x50
+#define PBS_CLIENT_SCRATCH2		0x51
+
+struct pbs_dev {
+	struct device		*dev;
+	struct regmap		*regmap;
+	struct mutex		lock;
+	struct device_link	*link;
+
+	u32			base;
+};
+
+static int qcom_pbs_read(struct pbs_dev *pbs, u32 address, u8 *val)
+{
+	int ret;
+
+	address += pbs->base;
+	ret = regmap_bulk_read(pbs->regmap, address, val, 1);
+	if (ret)
+		dev_err(pbs->dev, "Failed to read address=%#x sid=%#x ret=%d\n",
+			address, to_spmi_device(pbs->dev->parent)->usid, ret);
+
+	return ret;
+}
+
+static int qcom_pbs_write(struct pbs_dev *pbs, u16 address, u8 val)
+{
+	int ret;
+
+	address += pbs->base;
+	ret = regmap_bulk_write(pbs->regmap, address, &val, 1);
+	if (ret < 0)
+		dev_err(pbs->dev, "Failed to write address=%#x sid=%#x ret=%d\n",
+			  address, to_spmi_device(pbs->dev->parent)->usid, ret);
+
+	return ret;
+}
+
+static int qcom_pbs_masked_write(struct pbs_dev *pbs, u16 address, u8 mask, u8 val)
+{
+	int ret;
+
+	address += pbs->base;
+	ret = regmap_update_bits(pbs->regmap, address, mask, val);
+	if (ret < 0)
+		dev_err(pbs->dev, "Failed to write address=%#x ret=%d\n", address, ret);
+
+	return ret;
+}
+
+static int qcom_pbs_wait_for_ack(struct pbs_dev *pbs, u8 bit_pos)
+{
+	u16 retries = 2000, delay = 1000;
+	int ret;
+	u8 val;
+
+	while (retries--) {
+		ret = qcom_pbs_read(pbs, PBS_CLIENT_SCRATCH2, &val);
+		if (ret < 0)
+			return ret;
+
+		if (val == 0xFF) {
+			/* PBS error - clear SCRATCH2 register */
+			ret = qcom_pbs_write(pbs, PBS_CLIENT_SCRATCH2, 0);
+			if (ret < 0)
+				return ret;
+
+			dev_err(pbs->dev, "NACK from PBS for bit %u\n", bit_pos);
+			return -EINVAL;
+		}
+
+		if (val & BIT(bit_pos)) {
+			dev_dbg(pbs->dev, "PBS sequence for bit %u executed!\n", bit_pos);
+			break;
+		}
+
+		usleep_range(delay, delay + 100);
+	}
+
+	if (!retries) {
+		dev_err(pbs->dev, "Timeout for PBS ACK/NACK for bit %u\n", bit_pos);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/**
+ * qcom_pbs_trigger_event() - Trigger the PBS RAM sequence
+ * @pbs: Pointer to PBS device
+ * @bitmap: bitmap
+ *
+ * This function is used to trigger the PBS RAM sequence to be
+ * executed by the client driver.
+ *
+ * The PBS trigger sequence involves
+ * 1. setting the PBS sequence bit in PBS_CLIENT_SCRATCH1
+ * 2. Initiating the SW PBS trigger
+ * 3. Checking the equivalent bit in PBS_CLIENT_SCRATCH2 for the
+ *    completion of the sequence.
+ * 4. If PBS_CLIENT_SCRATCH2 == 0xFF, the PBS sequence failed to execute
+ *
+ * Returns: 0 on success, < 0 on failure
+ */
+int qcom_pbs_trigger_event(struct pbs_dev *pbs, u8 bitmap)
+{
+	u8 val, mask;
+	u16 bit_pos;
+	int ret;
+
+	if (!bitmap) {
+		dev_err(pbs->dev, "Invalid bitmap passed by client\n");
+		return -EINVAL;
+	}
+
+	if (IS_ERR_OR_NULL(pbs))
+		return -EINVAL;
+
+	mutex_lock(&pbs->lock);
+	ret = qcom_pbs_read(pbs, PBS_CLIENT_SCRATCH2, &val);
+	if (ret < 0)
+		goto out;
+
+	if (val == 0xFF) {
+		/* PBS error - clear SCRATCH2 register */
+		ret = qcom_pbs_write(pbs, PBS_CLIENT_SCRATCH2, 0);
+		if (ret < 0)
+			goto out;
+	}
+
+	for (bit_pos = 0; bit_pos < 8; bit_pos++) {
+		if (bitmap & BIT(bit_pos)) {
+			/*
+			 * Clear the PBS sequence bit position in
+			 * PBS_CLIENT_SCRATCH2 mask register.
+			 */
+			ret = qcom_pbs_masked_write(pbs, PBS_CLIENT_SCRATCH2, BIT(bit_pos), 0);
+			if (ret < 0)
+				goto error;
+
+			/*
+			 * Set the PBS sequence bit position in
+			 * PBS_CLIENT_SCRATCH1 register.
+			 */
+			val = mask = BIT(bit_pos);
+			ret = qcom_pbs_masked_write(pbs, PBS_CLIENT_SCRATCH1, mask, val);
+			if (ret < 0)
+				goto error;
+
+			/* Initiate the SW trigger */
+			val = mask = PBS_CLIENT_SW_TRIG_BIT;
+			ret = qcom_pbs_masked_write(pbs, PBS_CLIENT_TRIG_CTL, mask, val);
+			if (ret < 0)
+				goto error;
+
+			ret = qcom_pbs_wait_for_ack(pbs, bit_pos);
+			if (ret < 0)
+				goto error;
+
+			/*
+			 * Clear the PBS sequence bit position in
+			 * PBS_CLIENT_SCRATCH1 register.
+			 */
+			ret = qcom_pbs_masked_write(pbs, PBS_CLIENT_SCRATCH1, BIT(bit_pos), 0);
+			if (ret < 0)
+				goto error;
+
+			/*
+			 * Clear the PBS sequence bit position in
+			 * PBS_CLIENT_SCRATCH2 mask register.
+			 */
+			ret = qcom_pbs_masked_write(pbs, PBS_CLIENT_SCRATCH2, BIT(bit_pos), 0);
+			if (ret < 0)
+				goto error;
+		}
+	}
+
+error:
+	/* Clear all the requested bitmap */
+	ret = qcom_pbs_masked_write(pbs, PBS_CLIENT_SCRATCH1, bitmap, 0);
+
+out:
+	mutex_unlock(&pbs->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(qcom_pbs_trigger_event);
+
+/**
+ * get_pbs_client_device() - Get the PBS device used by client
+ * @dev: Client device
+ *
+ * This function is used to get the PBS device that is being
+ * used by the client.
+ *
+ * Returns: pbs_dev on success, ERR_PTR on failure
+ */
+struct pbs_dev *get_pbs_client_device(struct device *dev)
+{
+	struct device_node *pbs_dev_node;
+	struct platform_device *pdev;
+	struct pbs_dev *pbs;
+
+	pbs_dev_node = of_parse_phandle(dev->of_node, "qcom,pbs", 0);
+	if (!pbs_dev_node) {
+		dev_err(dev, "Missing qcom,pbs property\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	pdev = of_find_device_by_node(pbs_dev_node);
+	if (!pdev) {
+		dev_err(dev, "Unable to find PBS dev_node\n");
+		pbs = ERR_PTR(-EPROBE_DEFER);
+		goto out;
+	}
+
+	pbs = platform_get_drvdata(pdev);
+	if (!pbs) {
+		dev_err(dev, "Cannot get pbs instance from %s\n", dev_name(&pdev->dev));
+		platform_device_put(pdev);
+		pbs = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	pbs->link = device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_SUPPLIER);
+	if (!pbs->link) {
+		dev_err(&pdev->dev, "Failed to create device link to consumer %s\n", dev_name(dev));
+		platform_device_put(pdev);
+		pbs = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+out:
+	of_node_put(pbs_dev_node);
+	return pbs;
+}
+EXPORT_SYMBOL(get_pbs_client_device);
+
+static int qcom_pbs_probe(struct platform_device *pdev)
+{
+	struct pbs_dev *pbs;
+	u32 val;
+	int ret;
+
+	pbs = devm_kzalloc(&pdev->dev, sizeof(*pbs), GFP_KERNEL);
+	if (!pbs)
+		return -ENOMEM;
+
+	pbs->dev = &pdev->dev;
+	pbs->regmap = dev_get_regmap(pbs->dev->parent, NULL);
+	if (!pbs->regmap) {
+		dev_err(pbs->dev, "Couldn't get parent's regmap\n");
+		return -EINVAL;
+	}
+
+	ret = device_property_read_u32(pbs->dev, "reg", &val);
+	if (ret < 0) {
+		dev_err(pbs->dev, "Couldn't find reg, ret = %d\n", ret);
+		return ret;
+	}
+	pbs->base = val;
+	mutex_init(&pbs->lock);
+
+	platform_set_drvdata(pdev, pbs);
+
+	return 0;
+}
+
+static const struct of_device_id qcom_pbs_match_table[] = {
+	{ .compatible = "qcom,pmi632-pbs" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_pbs_match_table);
+
+static struct platform_driver qcom_pbs_driver = {
+	.driver = {
+		.name		= "qcom-pbs",
+		.of_match_table	= qcom_pbs_match_table,
+	},
+	.probe = qcom_pbs_probe,
+};
+module_platform_driver(qcom_pbs_driver)
+
+MODULE_DESCRIPTION("QCOM PBS DRIVER");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/soc/qcom/qcom-pbs.h b/include/linux/soc/qcom/qcom-pbs.h
new file mode 100644
index 000000000000..8a46209ccf13
--- /dev/null
+++ b/include/linux/soc/qcom/qcom-pbs.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _QCOM_PBS_H
+#define _QCOM_PBS_H
+
+#include <linux/errno.h>
+#include <linux/types.h>
+
+struct device_node;
+struct pbs_dev;
+
+#if IS_ENABLED(CONFIG_QCOM_PBS)
+int qcom_pbs_trigger_event(struct pbs_dev *pbs, u8 bitmap);
+struct pbs_dev *get_pbs_client_device(struct device *client_dev);
+#else
+static inline int qcom_pbs_trigger_event(struct pbs_dev *pbs, u8 bitmap)
+{
+	return -ENODEV;
+}
+
+static inline struct pbs_dev *get_pbs_client_device(struct device *client_dev)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+
+#endif
-- 
2.41.0

