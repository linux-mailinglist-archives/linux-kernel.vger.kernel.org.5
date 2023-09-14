Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1916C79FC84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjINHAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbjINHAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:00:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE8BE58;
        Thu, 14 Sep 2023 00:00:44 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E70YLh021904;
        Thu, 14 Sep 2023 07:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=y6/zxeXA4c631iq+xtpWYv7DUWz2uyw6degn7T5QEog=;
 b=kJrOd83ma2wtWT3GG8Gh7gE0aXzOwIRh58AAwRIgPCuJ/rPaIYHf85eWk4ehAmrnqV9q
 Af6VQY3FRCwsQk+S+kq8Ao3QpC3vpYWv+mhkkfpq+mYJ1DB65A3nPgIYp9kLxzHtxmv0
 IzF6cbMl1Uv99ZFkjKS17Uq/gEpP93B3CVWzr1un2iLlvlUM1FBYsrwUxdLZxZRrLjlz
 XvOWSFuE3TbmbRvIJiW8vPyUzWur/1mmZz4oaMc3t9tsDRK3NYOvtGMV5zpz3J4vUEle
 EQSO5Zaq6H/Wn6FO2I6UvkpWjf+vzuaOhZL2HKg3h19CSh/BuCnlOW3JDLBEQmGMYSgL yQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3dj8a6b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 07:00:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E70ds4019675
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 07:00:39 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 00:00:33 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Thu, 14 Sep 2023 12:29:54 +0530
Subject: [PATCH v2 04/11] clk: qcom: ipq9574: drop the CLK_SET_RATE_PARENT
 flag from GPLL clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230913-gpll_cleanup-v2-4-c8ceb1a37680@quicinc.com>
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
        "Kathiravan Thirumoorthy" <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694674810; l=1520;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=6e7dI8EN15wlFS8923wD0L0oZyOi2kC43QP046NEGA4=;
 b=FBcN7Mm2wo0vh7j1S9/DjuUlDJQFeMSEFy7HIFzemmbnIPe0hccikCYK3Wn75cxyPLbBqzfVy
 tmGKJPjn7WcCAIXjIDpr56XrFFFfBAh+kt8BLWhxuRpIgGwBi0sfz3J
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xMBZWW-0babscUNbuaKDL8mmNnJ-wVnI
X-Proofpoint-ORIG-GUID: xMBZWW-0babscUNbuaKDL8mmNnJ-wVnI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_04,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxlogscore=778 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPLL clock rates are fixed and shouldn't be scaled based on the request
from dependent clocks. Doing so will result in the unexpected behaviour.
So drop the CLK_SET_RATE_PARENT flag from the GPLL clocks.

Fixes: d75b82cff488 ("clk: qcom: Add Global Clock Controller driver for IPQ9574")
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
----
Changes in V2:
	- No changes
---
 drivers/clk/qcom/gcc-ipq9574.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 8f430367299e..e8190108e1ae 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -87,7 +87,6 @@ static struct clk_fixed_factor gpll0_out_main_div2 = {
 			&gpll0_main.clkr.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_fixed_factor_ops,
 	},
 };
@@ -102,7 +101,6 @@ static struct clk_alpha_pll_postdiv gpll0 = {
 			&gpll0_main.clkr.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
 	},
 };
@@ -132,7 +130,6 @@ static struct clk_alpha_pll_postdiv gpll4 = {
 			&gpll4_main.clkr.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
 	},
 };
@@ -162,7 +159,6 @@ static struct clk_alpha_pll_postdiv gpll2 = {
 			&gpll2_main.clkr.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
 	},
 };

-- 
2.34.1

