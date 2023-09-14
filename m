Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DBE79FC81
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjINHAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjINHAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:00:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477DDE59;
        Thu, 14 Sep 2023 00:00:42 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E6kkY5020141;
        Thu, 14 Sep 2023 07:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=IYUUi4irMTzpChiOLnaWeP34/o4DxcOkgDEagseKg+4=;
 b=FLuw2MAOXTK1FRbScss1U7rmLd9fyFo1L/URfk8yIdkeej8wcAnARCMo0XJ3OiijW3bV
 yYHfmejIi5UqcRqFR28bqAHG19/BQEdXdZTLaQxmr+lj0cuA/wiW91fvRCObZQ/omWba
 2uLxq8Jn8fCK0KHSUPnEXndtlBA25+m9j4yRHec8hYiesIXxdvBlpUBRTQ2QdRty8QOi
 9JbfpZvYAoqoFq+jsr/HPfGxT3E+R5X0l6+fUJTDbsALZVDGHdaHurRe5k783GAt8txy
 uWuPRkzHoKvwxXSa0JIEbEBKAH0MJGK18kObbAxfBcqPCkc9R1r5XJcNr5AxWCNZTuHa QA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3ds427fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 07:00:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E70S2h024534
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 07:00:28 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 00:00:22 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Thu, 14 Sep 2023 12:29:52 +0530
Subject: [PATCH v2 02/11] clk: qcom: ipq6018: drop the CLK_SET_RATE_PARENT
 flag from PLL clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230913-gpll_cleanup-v2-2-c8ceb1a37680@quicinc.com>
References: <20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com>
In-Reply-To: <20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Sricharan Ramabadhran" <quic_srichara@quicinc.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "Kathiravan Thirumoorthy" <quic_kathirav@quicinc.com>,
        <stable@vger.kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694674810; l=2133;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=rsIYjMjr7l4hRP/TaRaz8xhUIe4rolVSZ1qvNyYYjEQ=;
 b=t/1AQcU7XZaufByt68IBdPr9TvzKEdidvZ2yTtqo4bdwmmYBU+2MRE81GEWdZGnCDwkgccbl/
 gHFtBwGUn/ZAjQeWm09BvG2KAxEtGtr0F5XcGpfAXx0g2o6H5j38j5n
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D-JTW6z4TJi9HkgY__X_DeTFlIsGMnVy
X-Proofpoint-GUID: D-JTW6z4TJi9HkgY__X_DeTFlIsGMnVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_03,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=889 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPLL, NSS crypto PLL clock rates are fixed and shouldn't be scaled based
on the request from dependent clocks. Doing so will result in the
unexpected behaviour. So drop the CLK_SET_RATE_PARENT flag from the PLL
clocks.

Cc: stable@vger.kernel.org
Fixes: d9db07f088af ("clk: qcom: Add ipq6018 Global Clock Controller support")
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Include the stable mailing list
	- Keep the CLK_SET_RATE_PARENT in UBI32 PLL, looks like these
	  PLL rates can be changed. So don't drop the flag.
---
 drivers/clk/qcom/gcc-ipq6018.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index 6120fbbc5de0..f9494fa1b871 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -72,7 +72,6 @@ static struct clk_fixed_factor gpll0_out_main_div2 = {
 				&gpll0_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -86,7 +85,6 @@ static struct clk_alpha_pll_postdiv gpll0 = {
 				&gpll0_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -161,7 +159,6 @@ static struct clk_alpha_pll_postdiv gpll6 = {
 				&gpll6_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -192,7 +189,6 @@ static struct clk_alpha_pll_postdiv gpll4 = {
 				&gpll4_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -243,7 +239,6 @@ static struct clk_alpha_pll_postdiv gpll2 = {
 				&gpll2_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -274,7 +269,6 @@ static struct clk_alpha_pll_postdiv nss_crypto_pll = {
 				&nss_crypto_pll_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 

-- 
2.34.1

