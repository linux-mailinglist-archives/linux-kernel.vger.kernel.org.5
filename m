Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AE3760993
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjGYFnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjGYFmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:42:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0984E1BFD;
        Mon, 24 Jul 2023 22:42:43 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P5L3Lm024702;
        Tue, 25 Jul 2023 05:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=VEz1l/R/ZiNzMPh3tMakQzdUDXnN/JlP7leK0rj4oaA=;
 b=c5z6CM6Hrzl3bG1yNT5IDCrkULG0GrxMow2c0oyKPMrIvmJ5QDwLUmP7KHE1H3Se0KDB
 31Sjw07AiL1Y0J+H7m0TlHG227QQd9ppT/0u/EtJJ03wf9nvW+OU4JZA9x8mpjWEG86G
 gvL8OjoTmq5Msz/FdYgOv2vYmVTBvoGg51Qj5iIM67njZ0N+LE2+wVbwNhbJukSTd2Fh
 R405paOYDblqMSCtx3ugw18dSS0F450ZRn0A8eono44hPxpyLwVw09ZQjHFVk8Da5HF4
 8psSfPx0lPk0+fUrYhFq/dFsp1ilyDC+RezagKa+oQ4sOggUmjLAQSX6Wp3J+qE8dtd3 aw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1y6m0yqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:42:39 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P5gcYH031033
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:42:38 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 22:42:34 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_fenglinw@quicinc.com>, <quic_kamalw@quicinc.com>,
        <jestar@qti.qualcomm.com>
Subject: [PATCH v3 1/3] input: pm8xxx-vib: refactor to easily support new SPMI vibrator
Date:   Tue, 25 Jul 2023 13:41:36 +0800
Message-ID: <20230725054138.129497-2-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230725054138.129497-1-quic_fenglinw@quicinc.com>
References: <20230725054138.129497-1-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vw691Kb55XPsXH-tOKzQHH8CnZodqSYK
X-Proofpoint-ORIG-GUID: vw691Kb55XPsXH-tOKzQHH8CnZodqSYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_02,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=929 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all vibrator control register addresses are hard coded,
including the base address and the offset, it's not flexible to support
new SPMI vibrator module which is usually included in different PMICs
with different base address. Refactor this by introducing the HW type
terminology and contain the register offsets/masks/shifts in reg_filed
data structures corresponding to each vibrator type, and the base address
value defined in 'reg' property will be added for SPMI vibrators.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/input/misc/pm8xxx-vibrator.c | 130 ++++++++++++++++-----------
 1 file changed, 77 insertions(+), 53 deletions(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 04cb87efd799..77bb0018d4e1 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -12,36 +12,36 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
+#define SSBI_VIB_DRV_EN_MANUAL_MASK	0xfc
+#define SSBI_VIB_DRV_LEVEL_MASK		0xf8
+#define SSBI_VIB_DRV_SHIFT		3
+#define SPMI_VIB_DRV_LEVEL_MASK		0xff
+#define SPMI_VIB_DRV_SHIFT		0
+
 #define VIB_MAX_LEVEL_mV	(3100)
 #define VIB_MIN_LEVEL_mV	(1200)
 #define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
 
 #define MAX_FF_SPEED		0xff
 
-struct pm8xxx_regs {
-	unsigned int enable_addr;
-	unsigned int enable_mask;
+enum pm8xxx_vib_type {
+	SSBI_VIB,
+	SPMI_VIB_GEN1,
+};
 
-	unsigned int drv_addr;
-	unsigned int drv_mask;
-	unsigned int drv_shift;
-	unsigned int drv_en_manual_mask;
+enum {
+	VIB_DRV_REG,
+	VIB_EN_REG,
+	VIB_MAX_REG,
 };
 
-static const struct pm8xxx_regs pm8058_regs = {
-	.drv_addr = 0x4A,
-	.drv_mask = 0xf8,
-	.drv_shift = 3,
-	.drv_en_manual_mask = 0xfc,
+static struct reg_field ssbi_vib_regs[VIB_MAX_REG] = {
+	REG_FIELD(0xf8, 0, 7),
 };
 
-static struct pm8xxx_regs pm8916_regs = {
-	.enable_addr = 0xc046,
-	.enable_mask = BIT(7),
-	.drv_addr = 0xc041,
-	.drv_mask = 0x1F,
-	.drv_shift = 0,
-	.drv_en_manual_mask = 0,
+static struct reg_field spmi_vib_gen1_regs[VIB_MAX_REG] = {
+	REG_FIELD(0x41, 0, 4),
+	REG_FIELD(0x46, 7, 7),
 };
 
 /**
@@ -58,12 +58,12 @@ static struct pm8xxx_regs pm8916_regs = {
 struct pm8xxx_vib {
 	struct input_dev *vib_input_dev;
 	struct work_struct work;
-	struct regmap *regmap;
-	const struct pm8xxx_regs *regs;
+	struct regmap_field *r_fields[VIB_MAX_REG];
 	int speed;
 	int level;
 	bool active;
 	u8  reg_vib_drv;
+	enum pm8xxx_vib_type hw_type;
 };
 
 /**
@@ -75,22 +75,27 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 {
 	int rc;
 	unsigned int val = vib->reg_vib_drv;
-	const struct pm8xxx_regs *regs = vib->regs;
+	u32 mask = SPMI_VIB_DRV_LEVEL_MASK;
+	u32 shift = SPMI_VIB_DRV_SHIFT;
+
+	if (vib->hw_type == SSBI_VIB) {
+		mask = SSBI_VIB_DRV_LEVEL_MASK;
+		shift = SSBI_VIB_DRV_SHIFT;
+	}
 
 	if (on)
-		val |= (vib->level << regs->drv_shift) & regs->drv_mask;
+		val |= (vib->level << shift) & mask;
 	else
-		val &= ~regs->drv_mask;
+		val &= ~mask;
 
-	rc = regmap_write(vib->regmap, regs->drv_addr, val);
+	rc = regmap_field_write(vib->r_fields[VIB_DRV_REG], val);
 	if (rc < 0)
 		return rc;
 
 	vib->reg_vib_drv = val;
 
-	if (regs->enable_mask)
-		rc = regmap_update_bits(vib->regmap, regs->enable_addr,
-					regs->enable_mask, on ? ~0 : 0);
+	if (vib->hw_type != SSBI_VIB)
+		rc = regmap_field_write(vib->r_fields[VIB_EN_REG], on);
 
 	return rc;
 }
@@ -102,13 +107,6 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 static void pm8xxx_work_handler(struct work_struct *work)
 {
 	struct pm8xxx_vib *vib = container_of(work, struct pm8xxx_vib, work);
-	const struct pm8xxx_regs *regs = vib->regs;
-	int rc;
-	unsigned int val;
-
-	rc = regmap_read(vib->regmap, regs->drv_addr, &val);
-	if (rc < 0)
-		return;
 
 	/*
 	 * pmic vibrator supports voltage ranges from 1.2 to 3.1V, so
@@ -168,38 +166,65 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 {
 	struct pm8xxx_vib *vib;
 	struct input_dev *input_dev;
-	int error;
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	struct reg_field *regs;
+	int error, i;
 	unsigned int val;
-	const struct pm8xxx_regs *regs;
+	u32 reg_base;
 
-	vib = devm_kzalloc(&pdev->dev, sizeof(*vib), GFP_KERNEL);
+	vib = devm_kzalloc(dev, sizeof(*vib), GFP_KERNEL);
 	if (!vib)
 		return -ENOMEM;
 
-	vib->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!vib->regmap)
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
 		return -ENODEV;
 
-	input_dev = devm_input_allocate_device(&pdev->dev);
+	input_dev = devm_input_allocate_device(dev);
 	if (!input_dev)
 		return -ENOMEM;
 
 	INIT_WORK(&vib->work, pm8xxx_work_handler);
 	vib->vib_input_dev = input_dev;
 
-	regs = of_device_get_match_data(&pdev->dev);
+	vib->hw_type = (enum pm8xxx_vib_type)of_device_get_match_data(dev);
 
-	/* operate in manual mode */
-	error = regmap_read(vib->regmap, regs->drv_addr, &val);
+	regs = ssbi_vib_regs;
+	if (vib->hw_type != SSBI_VIB) {
+		error = fwnode_property_read_u32(dev->fwnode, "reg", &reg_base);
+		if (error < 0) {
+			dev_err(dev, "Failed to read reg address, rc=%d\n", error);
+			return error;
+		}
+
+		if (vib->hw_type == SPMI_VIB_GEN1)
+			regs = spmi_vib_gen1_regs;
+
+		for (i = 0; i < VIB_MAX_REG; i++)
+			if (regs[i].reg != 0)
+				regs[i].reg += reg_base;
+	}
+
+	error = devm_regmap_field_bulk_alloc(dev, regmap, vib->r_fields, regs, VIB_MAX_REG);
 	if (error < 0)
+	{
+		dev_err(dev, "Failed to allocate regmap failed, rc=%d\n", error);
 		return error;
+	}
 
-	val &= regs->drv_en_manual_mask;
-	error = regmap_write(vib->regmap, regs->drv_addr, val);
+	error = regmap_field_read(vib->r_fields[VIB_DRV_REG], &val);
 	if (error < 0)
 		return error;
 
-	vib->regs = regs;
+	/* operate in manual mode */
+	if (vib->hw_type == SSBI_VIB) {
+		val &= SSBI_VIB_DRV_EN_MANUAL_MASK;
+		error = regmap_field_write(vib->r_fields[VIB_DRV_REG], val);
+		if (error < 0)
+			return error;
+	}
+
 	vib->reg_vib_drv = val;
 
 	input_dev->name = "pm8xxx_vib_ffmemless";
@@ -211,14 +236,13 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 	error = input_ff_create_memless(input_dev, NULL,
 					pm8xxx_vib_play_effect);
 	if (error) {
-		dev_err(&pdev->dev,
-			"couldn't register vibrator as FF device\n");
+		dev_err(dev, "couldn't register vibrator as FF device\n");
 		return error;
 	}
 
 	error = input_register_device(input_dev);
 	if (error) {
-		dev_err(&pdev->dev, "couldn't register input device\n");
+		dev_err(dev, "couldn't register input device\n");
 		return error;
 	}
 
@@ -239,9 +263,9 @@ static int pm8xxx_vib_suspend(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(pm8xxx_vib_pm_ops, pm8xxx_vib_suspend, NULL);
 
 static const struct of_device_id pm8xxx_vib_id_table[] = {
-	{ .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
-	{ .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
-	{ .compatible = "qcom,pm8916-vib", .data = &pm8916_regs },
+	{ .compatible = "qcom,pm8058-vib", .data = (void *)SSBI_VIB },
+	{ .compatible = "qcom,pm8921-vib", .data = (void *)SSBI_VIB },
+	{ .compatible = "qcom,pm8916-vib", .data = (void *)SPMI_VIB_GEN1 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);
-- 
2.25.1

