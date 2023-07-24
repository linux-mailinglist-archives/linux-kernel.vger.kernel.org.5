Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2881475EE1A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjGXInb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjGXInM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:43:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3562BE4A;
        Mon, 24 Jul 2023 01:42:59 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O4tPBr032160;
        Mon, 24 Jul 2023 08:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=fMrn9ECe6KMDJaDU7ZpKF+aDh9c156rhba9JLy910LE=;
 b=g2agPcJjn7pD2xM20fXbBI8YHBmsOlskelEr4YWOOcQNwUql4eTxcPSHR0SRepR+Lu7m
 UAyV2BU9c6oEvNLv/NQKqy/12kaMtrg6EiarOkI3Ls+/I9nV4/G1ziLmimYaw7i3+yoO
 aMxja30BmQ80+uLlLVPcToLi6+E9/qE8JAPw4LC7GNecBS8RkaFKVBesEi/e9Z1UuyXc
 I0pVhE7IQjV3arwxMFdaYaKqHXwtn/dxQemnJBhfQPLyRgJ/O90UOD2oJ9+w3LvrJ1CP
 ItTAhxaNaTjhGcxt95zw4gvNEPxTr7UnAIREEZTb3xfKyojpUooO/fEqN9QA+SuycDNj cg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s06q9at5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:42:55 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36O8gsQB007471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:42:54 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 01:42:50 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v5 6/6] soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC support
Date:   Mon, 24 Jul 2023 14:11:55 +0530
Message-ID: <20230724084155.8682-7-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724084155.8682-1-quic_kbajaj@quicinc.com>
References: <20230724084155.8682-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qWsDkrpDn9RsVoKdzj6CQZ4GZxtCrvXu
X-Proofpoint-GUID: qWsDkrpDn9RsVoKdzj6CQZ4GZxtCrvXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 228ffb4a8971..95766260b3b8 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -364,6 +364,36 @@ static const struct llcc_slice_config sm8550_data[] =  {
 	{LLCC_VIDVSP,   28,  256, 4, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
 };
 
+static const struct llcc_slice_config qdu1000_data_2ch[] = {
+	{ LLCC_MDMHPGRW, 7, 512, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_MODHW,    9, 256, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_MDMPNG,  21, 256, 0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_ECC,     26, 512, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
+	{ LLCC_MODPE,   29, 256, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_APTCM,   30, 256, 3, 1, 0x0,   0xC, 1, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_WRCACHE, 31, 128, 1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
+};
+
+static const struct llcc_slice_config qdu1000_data_4ch[] = {
+	{ LLCC_MDMHPGRW, 7, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_MODHW,    9, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_MDMPNG,  21, 512,  0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_ECC,     26, 1024, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
+	{ LLCC_MODPE,   29, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_APTCM,   30, 512,  3, 1, 0x0,   0xC, 1, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_WRCACHE, 31, 256,  1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
+};
+
+static const struct llcc_slice_config qdu1000_data_8ch[] = {
+	{ LLCC_MDMHPGRW, 7, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_MODHW,    9, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_MDMPNG,  21, 1024, 0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_ECC,     26, 2048, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
+	{ LLCC_MODPE,   29, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_APTCM,   30, 1024, 3, 1, 0x0,   0xC, 1, 0, 0, 1, 0, 0, 0 },
+	{ LLCC_WRCACHE, 31, 512,  1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
+};
+
 static const struct llcc_edac_reg_offset llcc_v1_edac_reg_offset = {
 	.trp_ecc_error_status0 = 0x20344,
 	.trp_ecc_error_status1 = 0x20348,
@@ -551,6 +581,37 @@ static const struct qcom_llcc_config sm8550_cfg[] = {
 	},
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
 static const struct qcom_sct_config sc7180_cfgs = {
 	.llcc_config	= sc7180_cfg,
 	.num_cfgs	= 1,
@@ -611,6 +672,11 @@ static const struct qcom_sct_config sm8550_cfgs = {
 	.num_cfgs	= 1,
 };
 
+static const struct qcom_sct_config qdu1000_cfgs = {
+	.llcc_config	= qdu1000_cfg,
+	.num_cfgs	= 1,
+};
+
 static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
 
 /**
@@ -1167,6 +1233,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_llcc_of_match[] = {
+	{ .compatible = "qcom,qdu1000-llcc", .data = &qdu1000_cfgs},
 	{ .compatible = "qcom,sc7180-llcc", .data = &sc7180_cfgs },
 	{ .compatible = "qcom,sc7280-llcc", .data = &sc7280_cfgs },
 	{ .compatible = "qcom,sc8180x-llcc", .data = &sc8180x_cfgs },
-- 
2.40.1

