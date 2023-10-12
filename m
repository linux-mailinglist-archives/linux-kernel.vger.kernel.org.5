Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477467C698E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjJLJ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbjJLJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:27:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AF710D;
        Thu, 12 Oct 2023 02:27:29 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C9Cl8G002009;
        Thu, 12 Oct 2023 09:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=MkKEkGgdaji2BYx828vsNi7wjDO6mp+4YeY+z1psZas=;
 b=MnsEhtw4bvbw9yfnHq+KR8fg3tg3oR2kMyf0CEbNzoT6zpAY/Gj31e0OAi5HMe0sU1md
 d4Hd7t6BC7yu7Naqxi32wc9N5RHB/xVS+vnwYpC3bWoAvgMRuxp55MkXToFP2XRfAv8B
 5LwRHsfHqughGRhv3zjsLQCB4tIeCWfsgKC8y8fZNU4zMFhsV1xVLcbNGqSZCcpbXzYT
 oDN/HkMly2naZWo0huoouo2gI7KFXWELcpd/XUu000hhbdqg+EOwGi81+WJR0PbV2UsQ
 928X/Llz0N+RUS2Quabs9nAea6I9cvUqMS9XHtJlXXDin3S2SJh836WnkwFsLkcbKbHC JA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnstytusg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 09:27:22 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39C9RLMG014211
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 09:27:21 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 12 Oct 2023 02:27:15 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v2 4/8] clk: qcom: apss-ipq6018: ipq5332: add safe source switch for a53pll
Date:   Thu, 12 Oct 2023 14:56:20 +0530
Message-ID: <000c61a028814f08a9fc6d1d5c446e8dad11a650.1697101543.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1697101543.git.quic_varada@quicinc.com>
References: <cover.1697101543.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cXZQ8qUZMTgGdKLB4t8etSwS2_RxlDTC
X-Proofpoint-GUID: cXZQ8qUZMTgGdKLB4t8etSwS2_RxlDTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v2:	Handle ABORT_RATE_CHANGE
	Use local variable for apcs_alias0_clk_src.clkr.hw
	Use single line comment instead of multi line style
---
 drivers/clk/qcom/apss-ipq6018.c | 53 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index 4e13a08..c05c2b2 100644
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
@@ -84,15 +87,63 @@ static const struct qcom_cc_desc apss_ipq6018_desc = {
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
+	else if ((action == POST_RATE_CHANGE) || (action == ABORT_RATE_CHANGE))
+		index = P_APSS_PLL_EARLY;
+	else
+		return 0;
+
+	hw = &apcs_alias0_clk_src.clkr.hw;
+	err = clk_rcg2_mux_closest_ops.set_parent(hw, index);
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
+	/* Only below variants of IPQ53xx support scaling */
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

