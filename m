Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700DB793487
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbjIFE47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjIFE45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:56:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D50ACF0;
        Tue,  5 Sep 2023 21:56:54 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3864hEZf020480;
        Wed, 6 Sep 2023 04:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=5n78TaTJXbkfJXLsE5b9vdcW/bufP7nkgOT8yyBSnHE=;
 b=iDJV2xWREZGeF7mY0qFJB9m4F1GJ+NsEnoGDXdar4Tc6Ee2mgKqwklm4n02OC4oLQeCh
 iMvY4E1H5q6eeqQAq/lJSY+cFaNoMLhPhrZaJLQDHqtrbxYn9ViwosJCL9D52FmUjOtN
 zyyF9dJ1zkwfeKpmPwpAcjasVR+J2r/eUt8LzijutXrGIkwgcr/G+gXBuYDBBaZtLJnB
 gStetUPR4N49NwG5K9zSuVHR9GYVX+yFU6zA5jXplyWPZNsOOxXc810uXh9GvefnsURh
 wk7mPnC0DJc2Ck7vyl31BLP+OzPmx7lwYPu0odWKDWVYML00HyzQtmqa4aSgUQvVW1cB ZQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxhbhg5bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 04:56:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3864uetC028344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 04:56:40 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 5 Sep 2023 21:56:35 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Wed, 6 Sep 2023 10:26:20 +0530
Subject: [PATCH RESEND 1/7] clk: qcom: ipq8074: drop the
 CLK_SET_RATE_PARENT flag from PLL clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230904-gpll_cleanup-v1-1-de2c448f1188@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693976190; l=2148;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=qvuYyxdgwV2e5dg+1E6zI3CEXOMdRXBeCrT9bL9F1Gc=;
 b=84wky6jD8MqptiQeo/8qh/nf4Kq0N16Hi/oHxVaqE/ttiRsw3naRab/DSdTDo3zM0Rzsda1Uq
 GHDjH0E6xAaDjbnCvffVLOsR6dTqQqvHTU4WRGkDiBb2iYAhSGZ8syR
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ytNHjedIAe3rZng8FuPvgr3CFh3_g3SG
X-Proofpoint-ORIG-GUID: ytNHjedIAe3rZng8FuPvgr3CFh3_g3SG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=938 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPLL, UBI32 PLL, NSS crypto PLL clock rates are fixed and shouldn't
be scaled based on the request from dependent clocks. Doing so will
result in the unexpected behaviour. So drop the CLK_SET_RATE_PARENT flag
from the PLL clocks.

Fixes: b8e7e519625f ("clk: qcom: ipq8074: add remaining PLL’s")
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 63ac2ced76bb..cfe2f2606cfe 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -75,7 +75,6 @@ static struct clk_fixed_factor gpll0_out_main_div2 = {
 				&gpll0_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -121,7 +120,6 @@ static struct clk_alpha_pll_postdiv gpll2 = {
 				&gpll2_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -154,7 +152,6 @@ static struct clk_alpha_pll_postdiv gpll4 = {
 				&gpll4_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -188,7 +185,6 @@ static struct clk_alpha_pll_postdiv gpll6 = {
 				&gpll6_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -201,7 +197,6 @@ static struct clk_fixed_factor gpll6_out_main_div2 = {
 				&gpll6_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -234,7 +229,6 @@ static struct clk_alpha_pll_postdiv ubi32_pll = {
 				&ubi32_pll_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -266,7 +260,6 @@ static struct clk_alpha_pll_postdiv nss_crypto_pll = {
 				&nss_crypto_pll_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 

-- 
2.34.1

