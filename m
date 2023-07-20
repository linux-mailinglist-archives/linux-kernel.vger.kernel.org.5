Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6244775AA01
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjGTI5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjGTId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:33:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD11268C;
        Thu, 20 Jul 2023 01:33:25 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K5SqqW022420;
        Thu, 20 Jul 2023 08:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=MP1Bkyz5bjTyT8+WFtnsD0N1nt1uVmVkvyHsWOopleU=;
 b=lVYXiOyhqoks00qR0ZRhE9p2fL+ZqQgRfwPw6HrRDe0kHeU+tiQUMxAoCPgR3JL/EwKS
 u2fu/tYfYknaskP1+q8w7Jtotc2/cqO1JTdDwdMWxL888aoV0rb0itmWZf1hgiHDk4vV
 z2660tVT5Qd82Ods51nqUhOLrPFhdzuLfBz6h1F6tVuQysrd4de7s5pjq7dpYkX5gufS
 YMAdPkCjM0oHYEuq0qufHpxbwxI+MP7Z/dIdRj4F7zqIk4CMHjmLTINzF7Hv4kYXLyWZ
 19I+yvVe4VILLIPF8+bb93ZlsH/BEj72rsZ4UOsZe/9iXOdlrZIcmAiA/N55uVipe3gW 4g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rx728u853-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:33:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K8XKi7022628
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:33:20 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 01:33:17 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>
Subject: [PATCH] clk: qcom: clk-rcg2: Fix wrong RCG clock rate for high parent frequencies
Date:   Thu, 20 Jul 2023 14:03:04 +0530
Message-ID: <20230720083304.28881-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IdJx1srWEX_zfV2aQWymGAF7fjq-A4I6
X-Proofpoint-ORIG-GUID: IdJx1srWEX_zfV2aQWymGAF7fjq-A4I6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=876 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200070
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the parent clock rate is greater than unsigned long max/2 then
integer overflow happens when calculating the clock rate on 32-bit systems.
As RCG2 uses half integer dividers, the clock rate is first being
multiplied by 2 which will overflow the unsigned long max value. So, use
unsigned long long for rate computations to avoid overflow.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 drivers/clk/qcom/clk-rcg2.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index e22baf3a7112..42d00b134975 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -156,18 +156,18 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
  *            hid_div       n
  */
 static unsigned long
-calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
+calc_rate(unsigned long parent_rate, u32 m, u32 n, u32 mode, u32 hid_div)
 {
+	u64 rate = parent_rate;
+
 	if (hid_div) {
 		rate *= 2;
-		rate /= hid_div + 1;
+		do_div(rate, hid_div + 1);
 	}
 
 	if (mode) {
-		u64 tmp = rate;
-		tmp *= m;
-		do_div(tmp, n);
-		rate = tmp;
+		rate *= m;
+		do_div(rate, n);
 	}
 
 	return rate;
-- 
2.17.1

