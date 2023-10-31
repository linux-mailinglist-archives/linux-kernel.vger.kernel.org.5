Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9277DC6FA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343570AbjJaHMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343565AbjJaHMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:12:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870FCD8;
        Tue, 31 Oct 2023 00:12:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V6NIt1015035;
        Tue, 31 Oct 2023 07:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fI79fCu7u7JtqeAo3O8pgl49D1o129Qrn5JbKv9fzRQ=;
 b=Y/d2Szs27U43kVCQr8k2z/kdDfYMbf1fQXVvtAxYcAEBEMiwXefEk2r7p4QpAW5Py8bh
 JjL+K5+RVGP/SJCRU3vwcgRkv3xD6MiOj7Gfig/QvCzu8kQxEcmkQnvpnqyPc1UcHj0K
 RDrqun1LL8NwcoPwwBj5zPIGvKlQIFgNdS1OVKa8+A21QFNy3pX1mo2op1oCwTST0FeI
 PVRv2XcjVitZfzT0j+V+IF8vCaNpwxsEBroaSLYZALF5awoutK5EzwStnoXH2XfiCovb
 +vqlMNMytH9nmMEwhmcbgQeF+2k6YNnUS4FTevA2iOTYh+n7tmxZsKkfN3nASawDfHCU pA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2mcygwxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 07:12:18 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V7CHpT004161
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 07:12:17 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 31 Oct 2023 00:12:10 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <sivaprak@codeaurora.org>, <quic_kathirav@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v6 1/2] cpufreq: qti: Enable cpufreq for ipq53xx
Date:   Tue, 31 Oct 2023 12:41:38 +0530
Message-ID: <cce70842d0ea7d46406fa7d25138d3e38018fe3b.1698735972.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1698735972.git.quic_varada@quicinc.com>
References: <cover.1698735972.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 30cwzmSCJm0XsI5kH8KCJIyFcJ9oZpF0
X-Proofpoint-ORIG-GUID: 30cwzmSCJm0XsI5kH8KCJIyFcJ9oZpF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ53xx have different OPPs available for the CPU based on
SoC variant. This can be determined through use of an eFuse
register present in the silicon.

Added support for ipq53xx on nvmem driver which helps to
determine OPPs at runtime based on the eFuse register which
has the CPU frequency limits. opp-supported-hw dt binding
can be used to indicate the available OPPs for each limit.

nvmem driver also creates the "cpufreq-dt" platform_device after
passing the version matching data to the OPP framework so that the
cpufreq-dt handles the actual cpufreq implementation.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v6:	Rebase to top of tree
v5:	Merge IPQ53xx with existing APQ8096 case
v2:	Move IPQ53xx after APQ8096SG
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 0718191..53da255 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -180,6 +180,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,am62a7", },
 	{ .compatible = "ti,am62p5", },
 
+	{ .compatible = "qcom,ipq5332", },
 	{ .compatible = "qcom,ipq6018", },
 	{ .compatible = "qcom,ipq8064", },
 	{ .compatible = "qcom,ipq8074", },
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 158c0e1..4f7af70 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -183,6 +183,11 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 	switch (msm_id) {
 	case QCOM_ID_MSM8996:
 	case QCOM_ID_APQ8096:
+	case QCOM_ID_IPQ5332:
+	case QCOM_ID_IPQ5322:
+	case QCOM_ID_IPQ5312:
+	case QCOM_ID_IPQ5302:
+	case QCOM_ID_IPQ5300:
 		drv->versions = 1 << (unsigned int)(*speedbin);
 		break;
 	case QCOM_ID_MSM8996SG:
@@ -541,6 +546,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,msm8909", .data = &match_data_msm8909 },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
+	{ .compatible = "qcom,ipq5332", .data = &match_data_kryo },
 	{ .compatible = "qcom,ipq6018", .data = &match_data_ipq6018 },
 	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
 	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
-- 
2.7.4

