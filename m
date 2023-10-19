Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF37CF305
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345167AbjJSIm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345098AbjJSIm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:42:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238FC121;
        Thu, 19 Oct 2023 01:42:14 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J7sepB023327;
        Thu, 19 Oct 2023 08:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=71SDrbCHhggW77N4ET/lTU7t3o/T2Zf+gfsOoMco9/w=;
 b=HZfg9jWVBwIs9gNHy60xLlSLYraor3NrH4KgcpBrv03hZ39UpnYPTcPHV34o9yuHI1Lu
 VKaZ3yDbOPG2MoeRpfY5OWI7LgRNz/GuG6ldEDItuipiQHOTXgLDA+KKPmHPhpb/BeZp
 yklQED2bCf02CvAcHnkEKuzEjxphkEpOxlcrfVMQBkiZVm2z6+ZRUNGRg5eZqJI+pLR/
 IFVoFxlCYpTbYEAsFeABU3bLor/us72NAtdCTczeolkRCg8eE4rLv7mdecKYXb4weFJW
 0wIEracEQtWJxTDPp2BSg941MQ9d1YwYUZ7u80kCLQnvsVsJXxsZxkFcluS3LDIiiQ76 2Q== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttfeuaac0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:41:46 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J8fiT5021884
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:41:44 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 01:41:38 -0700
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
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Praveenkumar I <ipkumar@codeaurora.org>
Subject: [PATCH v4 8/9] cpufreq: qti: Introduce cpufreq for ipq95xx
Date:   Thu, 19 Oct 2023 14:10:42 +0530
Message-ID: <7369c6d5186d2b9b5f62a210878e9f864b57e11a.1697694811.git.quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: oY5i0sE-XvSP9ec7O35JUtOXzmhHnniR
X-Proofpoint-GUID: oY5i0sE-XvSP9ec7O35JUtOXzmhHnniR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_06,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ95xx SoCs have different OPPs available for the CPU based on
the SoC variant. This can be determined from an eFuse register
present in the silicon.

Added support for ipq95xx on nvmem driver which helps to
determine OPPs at runtime based on the eFuse register which
has the CPU frequency limits. opp-supported-hw dt binding
can be used to indicate the available OPPs for each limit.

Signed-off-by: Praveenkumar I <ipkumar@codeaurora.org>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2:	Simplify bin selection by tweaking the order in dts
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index f43e5cd..4f794ba 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -183,6 +183,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,ipq5332", },
 	{ .compatible = "qcom,ipq8064", },
 	{ .compatible = "qcom,ipq8074", },
+	{ .compatible = "qcom,ipq9574", },
 	{ .compatible = "qcom,apq8064", },
 	{ .compatible = "qcom,msm8974", },
 	{ .compatible = "qcom,msm8960", },
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 0014909..d44be4e 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -166,6 +166,13 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 	case QCOM_ID_IPQ5300:
 		drv->versions = 1 << (unsigned int)(*speedbin);
 		break;
+	case QCOM_ID_IPQ9514:
+	case QCOM_ID_IPQ9550:
+	case QCOM_ID_IPQ9554:
+	case QCOM_ID_IPQ9570:
+	case QCOM_ID_IPQ9574:
+		drv->versions = 1 << (unsigned int)(*speedbin);
+		break;
 	default:
 		BUG();
 		break;
@@ -417,6 +424,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
 	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
 	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
+	{ .compatible = "qcom,ipq9574", .data = &match_data_kryo },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8960", .data = &match_data_krait },
 	{},
-- 
2.7.4

