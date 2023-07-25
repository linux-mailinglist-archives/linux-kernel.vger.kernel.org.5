Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF950760998
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjGYFn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjGYFnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:43:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2298B1FE5;
        Mon, 24 Jul 2023 22:42:51 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P2fmfx011210;
        Tue, 25 Jul 2023 05:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=XF8fJ8Hs4A8dq+beYbJXiUQ6DpD1XTf1Ro/4sa6Hq8k=;
 b=akfQGrMEJygvVAs+8YgPfQDMjCENKJ+3IXeWS55u9wwTwUZXbChCXBekjcim6DJZCBuI
 Qj3B2DpQCQdDPhVEOvPXOW70EWd/Z/AefWv75pER0PF6EknLTQeK4B0zeSxSBkImCH9O
 PqPgqKik9+t0HMGysvpiBeQVgAo0hHbzuktcSFn0cm5SN5coCMFwcU1vLoVy1dPdu4zg
 zumrVVSi4GbaRMz97UViLC7rf53NhUmqPXkwI38Gtt9RYel7zHDJFBROSgcCffM8toSn
 V3Bspp9yQrd2WGlaiH6dSb/YZAf62UtnntQKyBcOOSVfXE9AGwMAbBrIa8LsX5ja7jQ0 Vw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1qcyt579-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:42:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P5gkQI031096
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:42:46 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 22:42:42 -0700
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
Subject: [PATCH v3 3/3] input: pm8xxx-vibrator: add new SPMI vibrator support
Date:   Tue, 25 Jul 2023 13:41:38 +0800
Message-ID: <20230725054138.129497-4-quic_fenglinw@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6nLixslO8TXaOp0HLlaGbPrIv-p7Vavh
X-Proofpoint-GUID: 6nLixslO8TXaOp0HLlaGbPrIv-p7Vavh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_02,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add new SPMI vibrator module which is very similar to the SPMI vibrator
module inside PM8916 but just has a finer drive voltage step (1mV vs
100mV) hence its drive level control is expanded to across 2 registers.
Name the module as 'qcom,spmi-vib-gen2', and it can be found in
following Qualcomm PMICs: PMI632, PM7250B, PM7325B, PM7550BA. Also, add
a compatible string 'qcom,spmi-vib-gen1' for SPMI vibrator inside PM8916
to maintain the completeness of the hardware version history.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/input/misc/pm8xxx-vibrator.c | 37 ++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 77bb0018d4e1..2cbccc5c6cf3 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -17,6 +17,8 @@
 #define SSBI_VIB_DRV_SHIFT		3
 #define SPMI_VIB_DRV_LEVEL_MASK		0xff
 #define SPMI_VIB_DRV_SHIFT		0
+#define SPMI_VIB_DRV2_LEVEL_MASK	0x0f
+#define SPMI_VIB_DRV2_SHIFT		8
 
 #define VIB_MAX_LEVEL_mV	(3100)
 #define VIB_MIN_LEVEL_mV	(1200)
@@ -27,11 +29,13 @@
 enum pm8xxx_vib_type {
 	SSBI_VIB,
 	SPMI_VIB_GEN1,
+	SPMI_VIB_GEN2,
 };
 
 enum {
 	VIB_DRV_REG,
 	VIB_EN_REG,
+	VIB_DRV2_REG,
 	VIB_MAX_REG,
 };
 
@@ -44,6 +48,12 @@ static struct reg_field spmi_vib_gen1_regs[VIB_MAX_REG] = {
 	REG_FIELD(0x46, 7, 7),
 };
 
+static struct reg_field spmi_vib_gen2_regs[VIB_MAX_REG] = {
+	REG_FIELD(0x40, 0, 7),
+	REG_FIELD(0x46, 7, 7),
+	REG_FIELD(0x41, 0, 3),
+};
+
 /**
  * struct pm8xxx_vib - structure to hold vibrator data
  * @vib_input_dev: input device supporting force feedback
@@ -94,6 +104,22 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 
 	vib->reg_vib_drv = val;
 
+	if (vib->hw_type == SPMI_VIB_GEN2) {
+		mask = SPMI_VIB_DRV2_LEVEL_MASK;
+		shift = SPMI_VIB_DRV2_SHIFT;
+
+		if (on)
+			val = (vib->level >> shift) & mask;
+		else
+			val = 0;
+
+		rc = regmap_field_write(vib->r_fields[VIB_DRV2_REG], val);
+		if (rc < 0)
+			return rc;
+
+		vib->reg_vib_drv |= val << shift;
+	}
+
 	if (vib->hw_type != SSBI_VIB)
 		rc = regmap_field_write(vib->r_fields[VIB_EN_REG], on);
 
@@ -116,10 +142,13 @@ static void pm8xxx_work_handler(struct work_struct *work)
 		vib->active = true;
 		vib->level = ((VIB_MAX_LEVELS * vib->speed) / MAX_FF_SPEED) +
 						VIB_MIN_LEVEL_mV;
-		vib->level /= 100;
+		if (vib->hw_type != SPMI_VIB_GEN2)
+			vib->level /= 100;
 	} else {
 		vib->active = false;
-		vib->level = VIB_MIN_LEVEL_mV / 100;
+		vib->level = VIB_MIN_LEVEL_mV;
+		if (vib->hw_type != SPMI_VIB_GEN2)
+			vib->level /= 100;
 	}
 
 	pm8xxx_vib_set(vib, vib->active);
@@ -200,6 +229,8 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 
 		if (vib->hw_type == SPMI_VIB_GEN1)
 			regs = spmi_vib_gen1_regs;
+		else
+			regs = spmi_vib_gen2_regs;
 
 		for (i = 0; i < VIB_MAX_REG; i++)
 			if (regs[i].reg != 0)
@@ -266,6 +297,8 @@ static const struct of_device_id pm8xxx_vib_id_table[] = {
 	{ .compatible = "qcom,pm8058-vib", .data = (void *)SSBI_VIB },
 	{ .compatible = "qcom,pm8921-vib", .data = (void *)SSBI_VIB },
 	{ .compatible = "qcom,pm8916-vib", .data = (void *)SPMI_VIB_GEN1 },
+	{ .compatible = "qcom,spmi-vib-gen1", .data = (void *)SPMI_VIB_GEN1 },
+	{ .compatible = "qcom,spmi-vib-gen2", .data = (void *)SPMI_VIB_GEN2 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);
-- 
2.25.1

