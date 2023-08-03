Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E54F76E614
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbjHCK7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjHCK7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:59:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810E43A95;
        Thu,  3 Aug 2023 03:58:56 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373AcbIs001342;
        Thu, 3 Aug 2023 10:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=dKoLAN6T9eXidautHVrIhL8exaoziZw7nYxsqDqzca4=;
 b=LCzbRr9ajKJeS2UkmeeerN9WjcSKIQ9x+d1xoLQc0hO8dpVFGj1fVoQ7Fz7eaFCnqY55
 7y5uoKKEoq9pHAw7QVnlMM0ysQy4CzX7JJOLASjIhTGvbw/Ft1J94JcXHrl96F7IC9mm
 mDIhA7yDjdFS5bZO2aONXrs6E4IDUTRxFNusnxWjd21BI0RyWo3np+ExRuo/el6Eu6w5
 aBfZnK3BTAm9oNEZJiO57mlcRDgmBP0i53uMeUPQJU74OY3WBfHJ6aRiUfD5wedrn9h0
 zIEyEMf8HEGE6rz0tk6w8rE/Mx3T30QqM2OY5AW5YicjwktvYVzyEQrnl0c9V16Hszwn AA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s83nwrtb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 10:58:53 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 373Awqbr010107
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 10:58:52 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 03:58:47 -0700
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: [PATCH V5 7/8] clk: qcom: gcc-qdu1000: Update the SDCC clock RCG ops
Date:   Thu, 3 Aug 2023 16:27:40 +0530
Message-ID: <20230803105741.2292309-8-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230803105741.2292309-1-quic_imrashai@quicinc.com>
References: <20230803105741.2292309-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d5Pqnaae04j4FHcRfUTQ0RmW911Tx0SK
X-Proofpoint-ORIG-GUID: d5Pqnaae04j4FHcRfUTQ0RmW911Tx0SK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_09,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the GCC SDCC clock RCG ops to clk_rcg2_floor_ops to avoid
the overclocking issues on QDU1000 and QRU1000 SoCs.

Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes since v4:
 - Updated the commit text
Changes since v3:
 - Split the patch as per the review comments
 - Newly added

 drivers/clk/qcom/gcc-qdu1000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
index fe1d0e8946a7..82391918c93e 100644
--- a/drivers/clk/qcom/gcc-qdu1000.c
+++ b/drivers/clk/qcom/gcc-qdu1000.c
@@ -904,7 +904,7 @@ static struct clk_rcg2 gcc_sdcc5_apps_clk_src = {
 		.name = "gcc_sdcc5_apps_clk_src",
 		.parent_data = gcc_parent_data_8,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -923,7 +923,7 @@ static struct clk_rcg2 gcc_sdcc5_ice_core_clk_src = {
 		.name = "gcc_sdcc5_ice_core_clk_src",
 		.parent_data = gcc_parent_data_2,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
-- 
2.25.1

