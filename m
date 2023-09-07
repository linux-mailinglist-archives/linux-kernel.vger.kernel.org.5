Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D34796FEC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 07:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbjIGFWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 01:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243185AbjIGFWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 01:22:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B951BD0;
        Wed,  6 Sep 2023 22:22:29 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3872dl6B018368;
        Thu, 7 Sep 2023 05:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/WmI8wsVRAVdrw5/a19tlbQiCkJceggErAbjp9Ta5sA=;
 b=H7PKjjfM0fDBhmewQLS9ICQYOKXoBEqeDxKn54z6cNcHZCXpEEYjy7J+V++ZUC/5mIwK
 pcOleZOvMukbHaAhx1wm0NCidG7Bsp2EkkHo/mHY3elm6xjbwBIdvOvPJWlagl5VHaGE
 HioNiPt7gm8fqbvyAwbhKe4LbkZpZD6vOYVTEdCbgJCawR0x1mFkZOHcVBvrosY/QXGA
 ri3PAfXkIX/PoBnRNg293yBBsdcus6X7FVVhfHcHVuMH1hazOEn8Lbbqrphg74Lmj9i2
 oEp4OJu5F8Jll+D34zKsKZ7GdWLAMVeqMEZdEUuhVcnvazGbapDDttQvTZq2ANB8rhXi pw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy4bqgebq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 05:22:22 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3875MLZU016172
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 05:22:21 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 6 Sep 2023 22:22:16 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <ilia.lin@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_kathirav@quicinc.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v1 04/10] clk: qcom: apss-ipq6018: ipq5332: add safe source switch for a53pll
Date:   Thu, 7 Sep 2023 10:51:39 +0530
Message-ID: <5e3c29df2b42cceb8072b00546a78e1b99b2d374.1693996662.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1693996662.git.quic_varada@quicinc.com>
References: <cover.1693996662.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zBuqeQ_fBzb0LgdK5udURgEk22RBEVi2
X-Proofpoint-ORIG-GUID: zBuqeQ_fBzb0LgdK5udURgEk22RBEVi2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070045
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/clk/qcom/apss-ipq6018.c | 54 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index 4e13a08..ffb6ab5 100644
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
@@ -84,15 +87,64 @@ static const struct qcom_cc_desc apss_ipq6018_desc = {
 	.num_clks = ARRAY_SIZE(apss_ipq6018_clks),
 };
 
+static int cpu_clk_notifier_fn(struct notifier_block *nb, unsigned long action,
+				void *data)
+{
+	u8 index;
+	int err;
+
+	if (action == PRE_RATE_CHANGE)
+		index = P_GPLL0;
+	else if (action == POST_RATE_CHANGE)
+		index = P_APSS_PLL_EARLY;
+	else
+		return 0;
+
+	err = clk_rcg2_mux_closest_ops.set_parent(&apcs_alias0_clk_src.clkr.hw,
+						  index);
+
+	return notifier_from_errno(err);
+}
+
+static struct notifier_block cpu_clk_notifier = {
+	.notifier_call = cpu_clk_notifier_fn,
+};
+
 static int apss_ipq6018_probe(struct platform_device *pdev)
 {
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
+	/*
+	 * Only below variants of IPQ53xx support scaling
+	 */
+	case QCOM_ID_IPQ5332:
+	case QCOM_ID_IPQ5322:
+	case QCOM_ID_IPQ5300:
+		ret = clk_notifier_register(apcs_alias0_clk_src.clkr.hw.clk,
+						&cpu_clk_notifier);
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

