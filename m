Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A617D759360
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGSKm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjGSKmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:42:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A346211D;
        Wed, 19 Jul 2023 03:42:00 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J7X3eM014261;
        Wed, 19 Jul 2023 10:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=x60G42eNuF7nFXzByj4TtMv/iTknPmrm9366a01EIp8=;
 b=RLVWXWBTqgjN/ToQpp7fjyfo9D9b/2p/D1DcPgrv+s2eitAlIzaZmnN7cXow46ctcmot
 2A+a65g1yHIfbC8fUaX4PRwaaX10PdyYxzLopmfjYs1d6vaVuI0yanALuHkd6WhJTEWR
 TlZM8dfUjZ+UFuZO0eWLg3qFhmsUF95nD+GbCs5YjsmDupSOEgoTpM+1qZjdqh1tgpA+
 EzoMzKLtVwHohX61gPvVefyOiMNgXlj8TznpaHy1y7nIHOmzfdc8YuqSehJ/HGqcd2sq
 Nemy0ZU2QnJMW08WNVEQ+2vXpkPlAAY2lynrRkPUFpvdp2kYLbfLZsxUSy0ruIACqTm/ uQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rx7410thr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 10:41:54 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36JAfqse025613
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 10:41:53 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 03:41:48 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH v4 5/5] thermal/drivers/tsens: Add IPQ5332 support
Date:   Wed, 19 Jul 2023 16:10:41 +0530
Message-ID: <20230719104041.126718-6-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719104041.126718-1-quic_ipkumar@quicinc.com>
References: <20230719104041.126718-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UH8YYaLI35IVSqGVMDdzO_UhpFTU6in3
X-Proofpoint-ORIG-GUID: UH8YYaLI35IVSqGVMDdzO_UhpFTU6in3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5332 uses tsens v2.3.3 IP and it is having combined interrupt.
It does not have RPM and kernel needs to take care of sensor
enablement, calibration. Hence introduced new feature_config,
ops and data for IPQ5332.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
[v4]:
	No changes.
[v3]:
	No changes.
[v2]:
	Added tsens_features for ipq5332 with VER_2_X_NO_RPM. Used
	hw_ids to mention the available sensors. Dropped v2 in
	ops_ipq5332.

 drivers/thermal/qcom/tsens-v2.c | 25 +++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c    |  3 +++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 3d674be2bbe4..77191f36bb03 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -68,6 +68,17 @@ static struct tsens_features ipq8074_feat = {
 	.trip_max_temp	= 204000,
 };
 
+static struct tsens_features ipq5332_feat = {
+	.ver_major	= VER_2_X_NO_RPM,
+	.crit_int	= 1,
+	.combo_int	= 1,
+	.adc		= 0,
+	.srot_split	= 1,
+	.max_sensors	= 16,
+	.trip_min_temp	= 0,
+	.trip_max_temp	= 204000,
+};
+
 static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* VERSION */
@@ -269,6 +280,20 @@ struct tsens_plat_data data_ipq8074 = {
 	.fields	= tsens_v2_regfields,
 };
 
+static const struct tsens_ops ops_ipq5332 = {
+	.init		= init_tsens_v2_no_rpm,
+	.get_temp	= get_temp_tsens_valid,
+	.calibrate	= tsens_v2_calibration,
+};
+
+struct tsens_plat_data data_ipq5332 = {
+	.num_sensors	= 5,
+	.ops		= &ops_ipq5332,
+	.hw_ids		= (unsigned int []){11, 12, 13, 14, 15},
+	.feat		= &ipq5332_feat,
+	.fields		= tsens_v2_regfields,
+};
+
 /* Kept around for backward compatibility with old msm8996.dtsi */
 struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 9dc0c2150948..af58a94628a8 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1106,6 +1106,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,ipq8074-tsens",
 		.data = &data_ipq8074,
+	}, {
+		.compatible = "qcom,ipq5332-tsens",
+		.data = &data_ipq5332,
 	}, {
 		.compatible = "qcom,mdm9607-tsens",
 		.data = &data_9607,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index b2e8f0f2b466..1dde363914cd 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -648,6 +648,6 @@ extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8
 extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
 
 /* TSENS v2 targets */
-extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
+extern struct tsens_plat_data data_8996, data_ipq8074, data_ipq5332, data_tsens_v2;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

