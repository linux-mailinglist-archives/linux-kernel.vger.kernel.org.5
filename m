Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BBE7AACD7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjIVIim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjIVIii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:38:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1EC83;
        Fri, 22 Sep 2023 01:38:31 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M5TljH011552;
        Fri, 22 Sep 2023 08:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=w3H+w2i9i25VHAqCSTbXgTQgMD2PoTCIEA7OBbxNaTg=;
 b=pCYKEZwb8zmXVbhPL078B4EjUo6v9RcwQohqhATCi7cDa+w1VzHf87pHGPlbnSpQ2Jyx
 fIvVNuzFlO6O/mb1DXHfMmRGnbmPTAQy7qQofgXg02Ec+sI8zlDWJ+B/S9AzEAJiKtzg
 l3vmW5RUjHPAVqsb3NtWs2ro1axgUuruDpkjF9q+MvDYn9nB9NxmO7Qp7DOZUAWXlt0n
 TUEYI2nsTqjE0egjk2J/clW7Gdy21l2IUGv7sCuo+7QFE9EIlckyDHzEP/xpDpo2qP9X
 qJQ9izbIRqr2iv2CsFLvELXIEUS6OQ6nfCCtQRVpTt1G4m0aWlrQAO4E0GDSjPwst+Um Fw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8txphbr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 08:38:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38M8cQFv005348
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 08:38:26 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 22 Sep 2023 01:38:21 -0700
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
Subject: [RESEND PATCH v6 1/3] input: pm8xxx-vib: refactor to easily support new SPMI vibrator
Date:   Fri, 22 Sep 2023 16:37:59 +0800
Message-ID: <20230922083801.3056724-2-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922083801.3056724-1-quic_fenglinw@quicinc.com>
References: <20230922083801.3056724-1-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VoRhcX1QJRMcMV2j9H2E6mZv1QO_HxuZ
X-Proofpoint-GUID: VoRhcX1QJRMcMV2j9H2E6mZv1QO_HxuZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_06,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=983 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all vibrator control register addresses are hard coded,
including the base address and the offset, it's not flexible to support
new SPMI vibrator module which is usually included in different PMICs
with different base address. Refactor this by defining register offset
with HW type combination, and register base address which is defined
in 'reg' property is added for SPMI vibrators.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/input/misc/pm8xxx-vibrator.c | 122 ++++++++++++++++-----------
 1 file changed, 73 insertions(+), 49 deletions(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 04cb87efd799..d6b468324c77 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -12,36 +12,44 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
+#define SSBL_VIB_DRV_REG		0x4A
+#define SSBI_VIB_DRV_EN_MANUAL_MASK	GENMASK(7, 2)
+#define SSBI_VIB_DRV_LEVEL_MASK		GENMASK(7, 3)
+#define SSBI_VIB_DRV_SHIFT		3
+
+#define SPMI_VIB_DRV_REG		0x41
+#define SPMI_VIB_DRV_LEVEL_MASK		GENMASK(4, 0)
+#define SPMI_VIB_DRV_SHIFT		0
+
+#define SPMI_VIB_EN_REG			0x46
+#define SPMI_VIB_EN_BIT			BIT(7)
+
 #define VIB_MAX_LEVEL_mV	(3100)
 #define VIB_MIN_LEVEL_mV	(1200)
 #define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
 
 #define MAX_FF_SPEED		0xff
 
-struct pm8xxx_regs {
-	unsigned int enable_addr;
-	unsigned int enable_mask;
+enum vib_hw_type {
+	SSBI_VIB,
+	SPMI_VIB,
+};
 
-	unsigned int drv_addr;
-	unsigned int drv_mask;
-	unsigned int drv_shift;
-	unsigned int drv_en_manual_mask;
+struct pm8xxx_vib_data {
+	enum vib_hw_type	hw_type;
+	unsigned int		enable_addr;
+	unsigned int		drv_addr;
 };
 
-static const struct pm8xxx_regs pm8058_regs = {
-	.drv_addr = 0x4A,
-	.drv_mask = 0xf8,
-	.drv_shift = 3,
-	.drv_en_manual_mask = 0xfc,
+static const struct pm8xxx_vib_data ssbi_vib_data = {
+	.hw_type	= SSBI_VIB,
+	.drv_addr	= SSBL_VIB_DRV_REG,
 };
 
-static struct pm8xxx_regs pm8916_regs = {
-	.enable_addr = 0xc046,
-	.enable_mask = BIT(7),
-	.drv_addr = 0xc041,
-	.drv_mask = 0x1F,
-	.drv_shift = 0,
-	.drv_en_manual_mask = 0,
+static const struct pm8xxx_vib_data spmi_vib_data = {
+	.hw_type	= SPMI_VIB,
+	.enable_addr	= SPMI_VIB_EN_REG,
+	.drv_addr	= SPMI_VIB_DRV_REG,
 };
 
 /**
@@ -49,7 +57,8 @@ static struct pm8xxx_regs pm8916_regs = {
  * @vib_input_dev: input device supporting force feedback
  * @work: work structure to set the vibration parameters
  * @regmap: regmap for register read/write
- * @regs: registers' info
+ * @data: vibrator HW info
+ * @reg_base: the register base of the module
  * @speed: speed of vibration set from userland
  * @active: state of vibrator
  * @level: level of vibration to set in the chip
@@ -59,7 +68,8 @@ struct pm8xxx_vib {
 	struct input_dev *vib_input_dev;
 	struct work_struct work;
 	struct regmap *regmap;
-	const struct pm8xxx_regs *regs;
+	const struct pm8xxx_vib_data *data;
+	unsigned int reg_base;
 	int speed;
 	int level;
 	bool active;
@@ -75,24 +85,31 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 {
 	int rc;
 	unsigned int val = vib->reg_vib_drv;
-	const struct pm8xxx_regs *regs = vib->regs;
+	u32 mask = SPMI_VIB_DRV_LEVEL_MASK;
+	u32 shift = SPMI_VIB_DRV_SHIFT;
+
+	if (vib->data->hw_type == SSBI_VIB) {
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
+	rc = regmap_update_bits(vib->regmap, vib->reg_base + vib->data->drv_addr, mask, val);
 	if (rc < 0)
 		return rc;
 
 	vib->reg_vib_drv = val;
 
-	if (regs->enable_mask)
-		rc = regmap_update_bits(vib->regmap, regs->enable_addr,
-					regs->enable_mask, on ? ~0 : 0);
+	if (vib->data->hw_type == SSBI_VIB)
+		return 0;
 
-	return rc;
+	mask = SPMI_VIB_EN_BIT;
+	val = on ? SPMI_VIB_EN_BIT : 0;
+	return regmap_update_bits(vib->regmap, vib->reg_base + vib->data->enable_addr, mask, val);
 }
 
 /**
@@ -102,13 +119,6 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
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
@@ -168,9 +178,9 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 {
 	struct pm8xxx_vib *vib;
 	struct input_dev *input_dev;
+	const struct pm8xxx_vib_data *data;
 	int error;
-	unsigned int val;
-	const struct pm8xxx_regs *regs;
+	unsigned int val, reg_base;
 
 	vib = devm_kzalloc(&pdev->dev, sizeof(*vib), GFP_KERNEL);
 	if (!vib)
@@ -187,19 +197,33 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 	INIT_WORK(&vib->work, pm8xxx_work_handler);
 	vib->vib_input_dev = input_dev;
 
-	regs = of_device_get_match_data(&pdev->dev);
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
+		return -EINVAL;
 
-	/* operate in manual mode */
-	error = regmap_read(vib->regmap, regs->drv_addr, &val);
-	if (error < 0)
-		return error;
+	if (data->hw_type != SSBI_VIB) {
+		error = fwnode_property_read_u32(pdev->dev.fwnode, "reg", &reg_base);
+		if (error < 0) {
+			dev_err(&pdev->dev, "Failed to read reg address, rc=%d\n", error);
+			return error;
+		}
+
+		vib->reg_base += reg_base;
+	}
 
-	val &= regs->drv_en_manual_mask;
-	error = regmap_write(vib->regmap, regs->drv_addr, val);
+	error = regmap_read(vib->regmap, vib->reg_base + data->drv_addr, &val);
 	if (error < 0)
 		return error;
 
-	vib->regs = regs;
+	/* operate in manual mode */
+	if (data->hw_type == SSBI_VIB) {
+		val &= SSBI_VIB_DRV_EN_MANUAL_MASK;
+		error = regmap_write(vib->regmap, vib->reg_base + data->drv_addr, val);
+		if (error < 0)
+			return error;
+	}
+
+	vib->data = data;
 	vib->reg_vib_drv = val;
 
 	input_dev->name = "pm8xxx_vib_ffmemless";
@@ -239,9 +263,9 @@ static int pm8xxx_vib_suspend(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(pm8xxx_vib_pm_ops, pm8xxx_vib_suspend, NULL);
 
 static const struct of_device_id pm8xxx_vib_id_table[] = {
-	{ .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
-	{ .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
-	{ .compatible = "qcom,pm8916-vib", .data = &pm8916_regs },
+	{ .compatible = "qcom,pm8058-vib", .data = &ssbi_vib_data },
+	{ .compatible = "qcom,pm8921-vib", .data = &ssbi_vib_data },
+	{ .compatible = "qcom,pm8916-vib", .data = &spmi_vib_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);
-- 
2.25.1

