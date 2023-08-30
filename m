Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0556178E002
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbjH3TJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243425AbjH3K55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:57:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5B31A1;
        Wed, 30 Aug 2023 03:57:54 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9WmNe001030;
        Wed, 30 Aug 2023 10:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=m3Czc64DGWLVCqvYMHHFouVPqVO46F5Pn6ZIHh4mCVc=;
 b=j5drKJsEaRgSc/HmuFZky1jDGZd2LOCFIjfxDPFOO2EMxethmNVPjNKL63CNve6/upkK
 ISQji25285mKzVsnAE+Q2gFllsQZNQ3bXGQX91Nr++796EGWP+rSaz7RDf2G6LBztiWG
 49Bm17VEkVd/rQQJUc9fCQb17SV6bVyhJycz1e9dY+zC1OAo0W1GulzRgesESLypjk0V
 hXI3Bazlot1TEnmKynhbmBw/+N8qpcYxTCiBMf8IvkxHij+8T6o5jvHr6HauRCIKoItJ
 FIvz8hCtzRUYbTESDUHbIZUge2X8cwK4CTdzyjjbdlvbFMFFTox8rXFsjJILNedXn7Hs ag== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssy5q0fv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:57:51 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UAvoK3030622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:57:50 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 30 Aug 2023 03:57:46 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bryan.odonoghue@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v8 6/6] soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC support
Date:   Wed, 30 Aug 2023 16:26:54 +0530
Message-ID: <20230830105654.28057-7-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
References: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PnScoIuvc0s0QIXtCw72maEKeN2qhe2y
X-Proofpoint-GUID: PnScoIuvc0s0QIXtCw72maEKeN2qhe2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC configuration data for QDU1000 and QRU1000 SoCs.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c | 67 ++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 3bd841e67eba..feb21637ac20 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -362,6 +362,36 @@ static const struct llcc_slice_config sm8550_data[] =  {
 	{LLCC_VIDVSP,   28,  256, 4, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
 };

+static const struct llcc_slice_config qdu1000_data_2ch[] = {
+	{ LLCC_MDMHPGRW, 7, 512, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_MODHW,    9, 256, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_MDMPNG,  21, 256, 0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_ECC,     26, 512, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
+	{ LLCC_MODPE,   29, 256, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_APTCM,   30, 256, 3, 1, 0x0,   0xc, 1, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_WRCACHE, 31, 128, 1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
+};
+
+static const struct llcc_slice_config qdu1000_data_4ch[] = {
+	{ LLCC_MDMHPGRW, 7, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_MODHW,    9, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_MDMPNG,  21, 512,  0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_ECC,     26, 1024, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
+	{ LLCC_MODPE,   29, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_APTCM,   30, 512,  3, 1, 0x0,   0xc, 1, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_WRCACHE, 31, 256,  1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
+};
+
+static const struct llcc_slice_config qdu1000_data_8ch[] = {
+	{ LLCC_MDMHPGRW, 7, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_MODHW,    9, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_MDMPNG,  21, 1024, 0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_ECC,     26, 2048, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
+	{ LLCC_MODPE,   29, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_APTCM,   30, 1024, 3, 1, 0x0,   0xc, 1, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_WRCACHE, 31, 512,  1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
+};
+
 static const struct llcc_edac_reg_offset llcc_v1_edac_reg_offset = {
 	.trp_ecc_error_status0 = 0x20344,
 	.trp_ecc_error_status1 = 0x20348,
@@ -428,6 +458,37 @@ static const u32 llcc_v2_1_reg_offset[] = {
 	[LLCC_COMMON_STATUS0]	= 0x0003400c,
 };

+static const struct qcom_llcc_config qdu1000_cfg[] = {
+	{
+		.sct_data       = qdu1000_data_8ch,
+		.size		= ARRAY_SIZE(qdu1000_data_8ch),
+		.need_llcc_cfg	= true,
+		.reg_offset	= llcc_v2_1_reg_offset,
+		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
+	},
+	{
+		.sct_data       = qdu1000_data_4ch,
+		.size           = ARRAY_SIZE(qdu1000_data_4ch),
+		.need_llcc_cfg  = true,
+		.reg_offset     = llcc_v2_1_reg_offset,
+		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
+	},
+	{
+		.sct_data       = qdu1000_data_4ch,
+		.size           = ARRAY_SIZE(qdu1000_data_4ch),
+		.need_llcc_cfg  = true,
+		.reg_offset     = llcc_v2_1_reg_offset,
+		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
+	},
+	{
+		.sct_data       = qdu1000_data_2ch,
+		.size           = ARRAY_SIZE(qdu1000_data_2ch),
+		.need_llcc_cfg  = true,
+		.reg_offset     = llcc_v2_1_reg_offset,
+		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
+	},
+};
+
 static const struct qcom_llcc_config sc7180_cfg[] = {
 	{
 		.sct_data	= sc7180_data,
@@ -549,6 +610,11 @@ static const struct qcom_llcc_config sm8550_cfg[] = {
 	},
 };

+static const struct qcom_sct_config qdu1000_cfgs = {
+	.llcc_config	= qdu1000_cfg,
+	.num_config	= ARRAY_SIZE(qdu1000_cfg),
+};
+
 static const struct qcom_sct_config sc7180_cfgs = {
 	.llcc_config	= sc7180_cfg,
 	.num_config	= ARRAY_SIZE(sc7180_cfg),
@@ -1168,6 +1234,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 }

 static const struct of_device_id qcom_llcc_of_match[] = {
+	{ .compatible = "qcom,qdu1000-llcc", .data = &qdu1000_cfgs},
 	{ .compatible = "qcom,sc7180-llcc", .data = &sc7180_cfgs },
 	{ .compatible = "qcom,sc7280-llcc", .data = &sc7280_cfgs },
 	{ .compatible = "qcom,sc8180x-llcc", .data = &sc8180x_cfgs },
--
2.41.0

