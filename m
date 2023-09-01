Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB1078F92F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348508AbjIAHhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjIAHhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:37:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5181410D2;
        Fri,  1 Sep 2023 00:37:08 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3815wRc6013405;
        Fri, 1 Sep 2023 07:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=CKvBT38tHSqEYMIsnstJQ+NMjLwRjhLHwqunnq7Hwrw=;
 b=dJUHyCbL4uqlEbAl2+uwzaAdjO42eSiS+jEErBee1wphUy98hagXMCHV3T1qegvYWuC/
 Oeoe4VyGnPS9NVsTt32HmKVzOQDonTqyN5eiK7rt8vP9lq8dkPxeyEZ4/pWLiKLP3it5
 4f4W6tQHNNDcrHAcFQFVvbRHFuxVFXBP4ppfdBeWeSTBgDW3r38dsq5hrQOlPzk93gXL
 kdQgw3+oEaAwdxx2P1rVoSStn8/o6eFH/nP/kFNr80T4lsQ7AnwoFyVilrHfiSGyWziT
 j9gtn0aeDJys5svA5/0JPBnYkjhRRZTG0pig7XkZ0JINuK7mAsCMP/KsvPGLm8HwbB+w NQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3su89e8edb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 07:36:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3817awft032413
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 07:36:58 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 1 Sep 2023 00:36:54 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mturquette@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_devipriy@quicinc.com>, <quic_saahtoma@quicinc.com>
Subject: [PATCH V2] clk: qcom: clk-rcg2: Fix clock rate overflow for high parent frequencies
Date:   Fri, 1 Sep 2023 13:06:40 +0530
Message-ID: <20230901073640.4973-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4Z3cnFO4cjXB8yxRsPz1NXuYH4RTN16n
X-Proofpoint-GUID: 4Z3cnFO4cjXB8yxRsPz1NXuYH4RTN16n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_04,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1011 suspectscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=953 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the parent clock rate is greater than unsigned long max/2 then
integer overflow happens when calculating the clock rate on 32-bit systems.
As RCG2 uses half integer dividers, the clock rate is first being
multiplied by 2 which will overflow the unsigned long max value.
Hence, replace the common pattern of doing 64-bit multiplication
and then a do_div() call with simpler mult_frac call.

Fixes: bcd61c0f535a ("clk: qcom: Add support for root clock generators (RCGs)")
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V2:
	- Replaced 64-bit multiplication & a do_div call with mult_frac
	  call as suggested by Marijn Suijten.
	- Updated the subject title
	- Added Fixes tag
	- Did not pick up the R-b tag due to the above changes.

 drivers/clk/qcom/clk-rcg2.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index a42f661550ca..f64d69164547 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -159,15 +159,11 @@ static unsigned long
 calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
 {
 	if (hid_div) {
-		rate *= 2;
-		rate /= hid_div + 1;
+		rate = mult_frac(rate, 2, hid_div + 1);
 	}
 
 	if (mode) {
-		u64 tmp = rate;
-		tmp *= m;
-		do_div(tmp, n);
-		rate = tmp;
+		rate = mult_frac(rate, m, n);
 	}
 
 	return rate;
-- 
2.34.1

