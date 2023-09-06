Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D99579349D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbjIFE5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238805AbjIFE5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:57:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0ED1733;
        Tue,  5 Sep 2023 21:57:18 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3864fBpS029845;
        Wed, 6 Sep 2023 04:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=Ut09vrs5PJXLJkaQTYt3dAz38j8yZdYcMp/B1SMkZ8o=;
 b=WsHuRuilQDbMSPeBnsz7PQaAhq3gt0kHZFzdlUAtoFuZ1B3WMTF7tmytEk9Uc69FL8Qe
 LCXHBDb9CfhluVEoBK012GH5V0+Oev3SEXME0RB+GCWy8QQZZ2CH3ooGPDxKEF0h+ZuK
 rkg4JifehJd6Hm1ye83PxdvOSJ/OvMK0HflxYWp9+SqJY1Ew9bbFHHz13tL8R8kwrwb0
 7ZEdFnd5XefwroJ+09J6W9HvnvF7287JebNQcVOdfSPdhlNpB4E8nYH3dtLE04xKSG3G
 3t1hFVguFbYc6dv3Zuh6xuXQ4iXVG0M1u+QcbCeQF9Tv8ywOKQTZ902NxyEuyH5gM27c Wg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxhjf84mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 04:57:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3864v4wp023075
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 04:57:04 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 5 Sep 2023 21:57:00 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Wed, 6 Sep 2023 10:26:25 +0530
Subject: [PATCH RESEND 6/7] clk: qcom: apss-ipq6018: add the GPLL0 clock
 also as clock provider
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230904-gpll_cleanup-v1-6-de2c448f1188@quicinc.com>
References: <20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com>
In-Reply-To: <20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693976190; l=1100;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=rzyPZph7HIrhgxkcI3wZuDYmLF+kwvjjidrlw0worEA=;
 b=s7Q+hj57eJoczR9xNtO/A9LBcaf3bcBhHHtlmsFX2jTgGr5CR8qcYQ4OFsByZVFKA17WMp92K
 Inh4phkRvAhDxZh5vq37UZOQxk40lKdeWvYuhzPihAGiZB/8AU02wE3
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sW3FtLeHTnoI3MFBJd2R7FKhL1UOMCJ8
X-Proofpoint-GUID: sW3FtLeHTnoI3MFBJd2R7FKhL1UOMCJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=841
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the kernel is booting up, APSS PLL will be running at 800MHz with
GPLL0 as source. Once the cpufreq driver is available, APSS PLL will be
configured and select the rate based on the opp table and the source will
be changed to APSS_PLL_EARLY.

Without this patch, CPU Freq driver reports that CPU is running at 24MHz
instead of the 800MHz.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 drivers/clk/qcom/apss-ipq6018.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index f2f502e2d5a4..4e13a085a857 100644
--- a/drivers/clk/qcom/apss-ipq6018.c
+++ b/drivers/clk/qcom/apss-ipq6018.c
@@ -20,16 +20,19 @@
 
 enum {
 	P_XO,
+	P_GPLL0,
 	P_APSS_PLL_EARLY,
 };
 
 static const struct clk_parent_data parents_apcs_alias0_clk_src[] = {
 	{ .fw_name = "xo" },
+	{ .fw_name = "gpll0" },
 	{ .fw_name = "pll" },
 };
 
 static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
 	{ P_XO, 0 },
+	{ P_GPLL0, 4 },
 	{ P_APSS_PLL_EARLY, 5 },
 };
 

-- 
2.34.1

