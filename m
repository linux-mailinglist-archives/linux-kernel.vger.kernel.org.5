Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F3E7D6E49
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344756AbjJYOAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344685AbjJYOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:00:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6559C;
        Wed, 25 Oct 2023 07:00:28 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39P9VgoM003134;
        Wed, 25 Oct 2023 14:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ypZW6YDknrSjp4Z0Tc7VoK7ZfYKqwjhnfLRxRoEWhBs=;
 b=VcSjjfJGdsedKR99c8UrD36zc6I2wwTkc3Md5KqSSoeuWAvtKbzYIryjcjcXanv3l2Eo
 c7DoY66BFkf7fPQJeb+DaFQ9oO+lHVQMWGdDOpihgoDc07t8aPRzrEUQdB8VA3kRIi7K
 3TOVngmhXLcDLpYTQdADQjN8MqR23mC/0PRF+tskcN8rA8qtSq4TpQsuK6DqB8Es8CmE
 xv/lSDsQBYF4mxAwvmFZAwYcZ2+1eOFXrVT5V3THNyiBOQs4zS5Anr925tiRUUhlmMkZ
 bQZc7gGhQewaxQyUdUGvf8yZQ9lCLTRmGa0xkiDVUCYmOyouOUv5twDaqv65kc0iLKPO WA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tx7r83t1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 14:00:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PE0PG2029716
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 14:00:25 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 25 Oct 2023 07:00:19 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <neil.armstrong@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 3/3] pmdomain: qcom: rpmhpd: Add SC8380XP power domains
Date:   Wed, 25 Oct 2023 19:29:43 +0530
Message-ID: <20231025135943.13854-4-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025135943.13854-1-quic_sibis@quicinc.com>
References: <20231025135943.13854-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fp5K797bd-vo9z2Q7f8psKXSxuqQf4vf
X-Proofpoint-GUID: Fp5K797bd-vo9z2Q7f8psKXSxuqQf4vf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_03,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=846 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

Add the power domains exposed by RPMH in the Qualcomm SC8380XP platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index a631fe1f9a06..28b7f5fcea7e 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -202,6 +202,11 @@ static struct rpmhpd qphy = {
 	.res_name = "qphy.lvl",
 };
 
+static struct rpmhpd gmxc = {
+	.pd = { .name = "gmxc", },
+	.res_name = "gmxc.lvl",
+};
+
 /* SA8540P RPMH powerdomains */
 static struct rpmhpd *sa8540p_rpmhpds[] = {
 	[SC8280XP_CX] = &cx,
@@ -564,6 +569,28 @@ static const struct rpmhpd_desc sc8280xp_desc = {
 	.num_pds = ARRAY_SIZE(sc8280xp_rpmhpds),
 };
 
+/* SC8380xp RPMH powerdomains */
+static struct rpmhpd *sc8380xp_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_NSP] = &nsp,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_GMXC] = &gmxc,
+};
+
+static const struct rpmhpd_desc sc8380xp_desc = {
+	.rpmhpds = sc8380xp_rpmhpds,
+	.num_pds = ARRAY_SIZE(sc8380xp_rpmhpds),
+};
+
 static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
 	{ .compatible = "qcom,sa8155p-rpmhpd", .data = &sa8155p_desc },
@@ -573,6 +600,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
 	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },
 	{ .compatible = "qcom,sc8280xp-rpmhpd", .data = &sc8280xp_desc },
+	{ .compatible = "qcom,sc8380xp-rpmhpd", .data = &sc8380xp_desc },
 	{ .compatible = "qcom,sdm670-rpmhpd", .data = &sdm670_desc },
 	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
 	{ .compatible = "qcom,sdx55-rpmhpd", .data = &sdx55_desc},
-- 
2.17.1

