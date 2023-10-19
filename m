Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C5C7CF2FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345120AbjJSIm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345028AbjJSImO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:42:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC13119D;
        Thu, 19 Oct 2023 01:41:58 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J7vUjv011410;
        Thu, 19 Oct 2023 08:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=S9tJ9+JOei8WOcb1eZodn1s3Spl1uKC7BDTiX9m3sD8=;
 b=pB/LGDLp6A32y7/JMF6+6yxquDmWCECbkoCyc3j8jXCFMDOv6wVw50s8FVZA30KxQ909
 E7Rol+jEpOKa7Azu+sAEpn0lJndtCN3+8zPNOBu0kkFMfe738VmZKg9ryJPQQY2efS/o
 8JiJM44KqOQHnWKvbvgwiDvG+9jjeCmZvlHko9gZkh+jn6dBREXT6n5Ugb6UoUOI7M+Y
 fVTl/cV3Ez2++Iv1wId2Yz20yXDi30WfUNlbkiGGm1n45NUeR5VchbfubKX9V19ufYBZ
 2HvNlc+2dgv8rDfPoWqD3+3pU6spBCE29yRJ2xUR5Y1IgbIK8IDakW1dZoEfx7YVr12i 2g== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt6mw3f46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:41:33 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J8fWon018892
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:41:32 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 01:41:26 -0700
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
Subject: [PATCH v4 6/9] cpufreq: qti: Enable cpufreq for ipq53xx
Date:   Thu, 19 Oct 2023 14:10:40 +0530
Message-ID: <c7bfa2233ce4bbdc326e8aa1967cc5efd1f89932.1697694811.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1697694811.git.quic_varada@quicinc.com>
References: <cover.1697694811.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g_Go06p6IClbAw4FjqKHqotr46NOTkdM
X-Proofpoint-GUID: g_Go06p6IClbAw4FjqKHqotr46NOTkdM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_05,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2:	Move IPQ53xx after APQ8096SG
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 675da7f..f43e5cd 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -180,6 +180,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,am62a7", },
 	{ .compatible = "ti,am62p5", },
 
+	{ .compatible = "qcom,ipq5332", },
 	{ .compatible = "qcom,ipq8064", },
 	{ .compatible = "qcom,ipq8074", },
 	{ .compatible = "qcom,apq8064", },
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3fa1264..0014909 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -159,6 +159,13 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 	case QCOM_ID_APQ8096SG:
 		drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
 		break;
+	case QCOM_ID_IPQ5332:
+	case QCOM_ID_IPQ5322:
+	case QCOM_ID_IPQ5312:
+	case QCOM_ID_IPQ5302:
+	case QCOM_ID_IPQ5300:
+		drv->versions = 1 << (unsigned int)(*speedbin);
+		break;
 	default:
 		BUG();
 		break;
@@ -406,6 +413,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
+	{ .compatible = "qcom,ipq5332", .data = &match_data_kryo },
 	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
 	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
 	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
-- 
2.7.4

