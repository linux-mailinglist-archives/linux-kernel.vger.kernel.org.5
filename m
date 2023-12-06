Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAFC806399
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376330AbjLFAof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376296AbjLFAoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:44:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34B3C6;
        Tue,  5 Dec 2023 16:44:40 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B60PoEr010483;
        Wed, 6 Dec 2023 00:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=87jbUFzThwGJXWiffU7Oty1HvYyVTLcQP7Ibmo8JnIg=;
 b=SY4tnd7RM/4LsrYMhvNVPlFrRNFQOPJDjMXX144qKDF7knknvGxg4OHHvZftjR+xriBD
 M2gMt6jfFA0F0wZWCLLmYgRg7XLn60CJwogIm1tCx3rm5l5LDynmOLIDvLlWJ2mI09H0
 hmYXJVsbQD6DND5SqUjMLQXs5+IOpeGB6sNeq7mBP6+qnYAcQanEelACVoBfkS20JDs3
 iP+jdf10rVsvxT9xSCUSS+5hglOzH0bWgYRTPpDyqUUW4kw7ooG3gkrv9zNUjBs0P3Fv
 BLLnPNYkE+IIyaIj4tNIq+K5zBRDHupb4aoBOn7NOoleXAsa487M8TQiDiDEfyQPX5Oj JA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utd1n05ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 00:44:30 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B60iTrp005074
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Dec 2023 00:44:29 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Dec
 2023 16:44:28 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Tue, 5 Dec 2023 16:44:10 -0800
Subject: [PATCH] soc: qcom: stats: Fix division issue on 32-bit platforms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231205-qcom_stats-aeabi_uldivmod-fix-v1-1-f94ecec5e894@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANnDb2UC/x2NSwrDMAwFrxK8rsCO+4FepZQg20ojcOzWSkIh5
 O4VXc7wmLcbocYk5t7tptHGwrUouFNn4oTlRcBJ2fS29663F/jEOg+y4CKAhIGHNSfe5ppg5C+
 c8erjjaJ1fjTaCCgEoWGJk1bKmrPKdyPd/k8fz+P4ATdGgimEAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701823468; l=1322;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=UdUckErCZF5X1TrIpq2q7COv//JN2FUDfefIC2xiIQ0=;
 b=cjrS0PFKoNOIG6fmYxUb/5233qkj0TkItCxzEQ/HFZGGUqrL3X4hiTkn9p3dX0e6HYCZ2S0EgHDy
 YphlV5xgBBsvyvWaP1UV8VKUWBHoB0mfeKmd4PBgZNbYbg7D7b2b
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xVwfdZAQcMN8EW07y9od54m-11ORxq5P
X-Proofpoint-GUID: xVwfdZAQcMN8EW07y9od54m-11ORxq5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_20,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312060002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 'e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")' made it
in with a mult_frac() which causes link errors on Arm and PowerPC
builds:

  ERROR: modpost: "__aeabi_uldivmod" [drivers/soc/qcom/qcom_stats.ko] undefined!

Expand the mult_frac() to avoid this problem.

Fixes: e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/qcom_stats.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index 4763d62a8cb0..5ba61232313e 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -221,7 +221,8 @@ static int qcom_ddr_stats_show(struct seq_file *s, void *unused)
 
 	for (i = 0; i < ddr.entry_count; i++) {
 		/* Convert the period to ms */
-		entry[i].dur = mult_frac(MSEC_PER_SEC, entry[i].dur, ARCH_TIMER_FREQ);
+		entry[i].dur *= MSEC_PER_SEC;
+		entry[i].dur = div_u64(entry[i].dur, ARCH_TIMER_FREQ);
 	}
 
 	for (i = 0; i < ddr.entry_count; i++)

---
base-commit: adcad44bd1c73a5264bff525e334e2f6fc01bb9b
change-id: 20231205-qcom_stats-aeabi_uldivmod-fix-4a63c7ec013f

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>

