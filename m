Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2BF7CF2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbjJSImU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344946AbjJSImB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:42:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF21D43;
        Thu, 19 Oct 2023 01:41:54 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J8Pv1H031841;
        Thu, 19 Oct 2023 08:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=J+RrOxHnHVj5svT/nwmDwiuOMNv1BKVPDHfQq+9ETLs=;
 b=YoBInFCqGSzgviV+MEZyD4JxyIm7PtK7U+qV5w891O7+j5c7IAUWQizvoFUjNKAbjQFX
 o9iYnrzhAzZV1aLsBK/ky/DlneZ9ZhlVa9lHo8BUKHK8+GGAzbvThBrNg+81GqwM1Vb9
 MOUc/lTDhTUa7MIzU7cwQlPt7qolHdOJkfllesSSPIc/aeEyohwEAu0fAUqaV/R3NWZM
 4xe4ihaXXWJCfjMRceS0xXSekv1+Bd6+Yu332dCAzD4Ku9N/YlFBEj7v1QG5tHHiXyM9
 tqrImVxuz3dXwlXwrVMW+gJBkhY/+NiQ/lydHJP06wc3IyAg1BT07dIYvGKTHYmr/Lmd kA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt5v83fy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:41:28 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J8fQgs018827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:41:26 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 01:41:20 -0700
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
Subject: [PATCH v4 5/9] clk: qcom: apss-ipq6018: ipq5332: add safe source switch for a53pll
Date:   Thu, 19 Oct 2023 14:10:39 +0530
Message-ID: <9ebae0e9780745091274562a2b9afd856241dbdc.1697694811.git.quic_varada@quicinc.com>
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
X-Proofpoint-GUID: odQDSIoyIPih1IKpssoZ4X-d9BKL0k8K
X-Proofpoint-ORIG-GUID: odQDSIoyIPih1IKpssoZ4X-d9BKL0k8K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_06,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stromer Plus PLL found on IPQ53xx doesn't support dynamic
frequency scaling. To achieve the same, we need to park the APPS
PLL source to GPLL0, re configure the PLL and then switch the
source to APSS_PLL_EARLY.

To support this, register a clock notifier to get the PRE_RATE
and POST_RATE notification. Change the APSS PLL source to GPLL0
when PRE_RATE notification is received, then configure the PLL
and then change back the source to APSS_PLL_EARLY.

Additionally, not all SKUs of IPQ53xx support scaling. Hence,
do the above to the SKUs that support scaling.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3:	devm_kzalloc for cpu_clk_notifier instead of global static
v2:	Handle ABORT_RATE_CHANGE
	Use local variable for apcs_alias0_clk_src.clkr.hw
	Use single line comment instead of multi line style
---
 drivers/clk/qcom/apss-ipq6018.c | 58 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index 4e13a08..db65b0d 100644
--- a/drivers/clk/qcom/apss-ipq6018.c
+++ b/drivers/clk/qcom/apss-ipq6018.c
@@ -9,8 +9,11 @@
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
 #include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/soc/qcom/smem.h>
 
 #include <dt-bindings/clock/qcom,apss-ipq.h>
+#include <dt-bindings/arm/qcom,ids.h>
 
 #include "common.h"
 #include "clk-regmap.h"
@@ -84,15 +87,68 @@ static const struct qcom_cc_desc apss_ipq6018_desc = {
 	.num_clks = ARRAY_SIZE(apss_ipq6018_clks),
 };
 
+static int cpu_clk_notifier_fn(struct notifier_block *nb, unsigned long action,
+				void *data)
+{
+	struct clk_hw *hw;
+	u8 index;
+	int err;
+
+	if (action == PRE_RATE_CHANGE)
+		index = P_GPLL0;
+	else if (action == POST_RATE_CHANGE || action == ABORT_RATE_CHANGE)
+		index = P_APSS_PLL_EARLY;
+	else
+		return NOTIFY_OK;
+
+	hw = &apcs_alias0_clk_src.clkr.hw;
+	err = clk_rcg2_mux_closest_ops.set_parent(hw, index);
+
+	return notifier_from_errno(err);
+}
+
 static int apss_ipq6018_probe(struct platform_device *pdev)
 {
+	struct notifier_block *cpu_clk_notifier;
 	struct regmap *regmap;
+	u32 soc_id;
+	int ret;
+
+	ret = qcom_smem_get_soc_id(&soc_id);
+	if (ret)
+		return ret;
 
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!regmap)
 		return -ENODEV;
 
-	return qcom_cc_really_probe(pdev, &apss_ipq6018_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &apss_ipq6018_desc, regmap);
+	if (ret)
+		return ret;
+
+	switch (soc_id) {
+	/* Only below variants of IPQ53xx support scaling */
+	case QCOM_ID_IPQ5332:
+	case QCOM_ID_IPQ5322:
+	case QCOM_ID_IPQ5300:
+		cpu_clk_notifier = devm_kzalloc(&pdev->dev,
+						sizeof(*cpu_clk_notifier),
+						GFP_KERNEL);
+		if (!cpu_clk_notifier)
+			return -ENOMEM;
+
+		cpu_clk_notifier->notifier_call = cpu_clk_notifier_fn;
+
+		ret = clk_notifier_register(apcs_alias0_clk_src.clkr.hw.clk,
+					    cpu_clk_notifier);
+		if (ret)
+			return ret;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
 }
 
 static struct platform_driver apss_ipq6018_driver = {
-- 
2.7.4

