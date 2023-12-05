Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE0F806180
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346425AbjLEWOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEWOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:14:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C254B137;
        Tue,  5 Dec 2023 14:14:15 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5Lp4sT018700;
        Tue, 5 Dec 2023 22:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=qHf8U2nrlOqnmtlM/j+8/wfCbRl6t44vzQQ63+6e53Q=;
 b=ZBf3v6nhsdgTawJHYhiGf3LoAQ8cxSf8jrz0H0fyR6+vxjQyRr3r/fBvYGxspU446qTh
 hCYh1ddCbfddPX6BeDFogPSzgiMZZ10z0nH6KsKUXL7urnrUycm7uwS3wycnLadcDPhr
 y6dzoiqW2UlBUkMILZJ8vyzTjH0Ag1SF+vfVYDFXXydCiLfVIE8v1GLf+yl9nek45d88
 XeDBfPCDL/pS7MIFv36107NharPwFy09HG8s97fdg2V6Jrkb5YUzam9VWFvjW6/GcwV5
 iiHKyDv/sPxDhUulYeI/nDlNdauDFZFNh3t3+InJ+nVUcVLwMTnKo9SthR5pNWgMQ4vl Qw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utaq6r7gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 22:14:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B5MEALE029675
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Dec 2023 22:14:10 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Dec
 2023 14:14:10 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Tue, 5 Dec 2023 14:14:00 -0800
Subject: [PATCH RFT] interconnect: qcom: icc-rpm: Fix peak rate calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231205-qcom_icc_calc_rate-typo-v1-1-9d4378dcf53e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKegb2UC/x2NQQrCMBAAv1L2bKBZ24sP8AHiTSRstxu7EJM2q
 aKU/t3gcQaG2aBIVilwajbI8taiKVawhwZ4ovgQo2NlwBaPFtveLJyeTpkdU2CXaRWzfudkyPY
 djr7ziAi1HqiIGTJFnmofXyFUOWfx+vnvbnA5X+G+7z8MoLTvgwAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701814450; l=1406;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=IOiUqa5MIxZI2ZQuYicHMxdfvzg1T0CI18L5cTZyuSs=;
 b=TFtFYGhlEV2KqgcMa0undO9RfnVIsMY9h4Wm2eEncSDVe9bj0eGuLsRmbp/O8Kt7NN7gn4PrN39E
 zEcHcZnqAeaiZaWR+vm2ruP7fyDlQ6KOFK8SarfcvzjgLnLSnpSa
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5HaCI60Er8S7KpgSfKcEGcesPQx7zYLk
X-Proofpoint-ORIG-GUID: 5HaCI60Er8S7KpgSfKcEGcesPQx7zYLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_18,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=906 bulkscore=0 adultscore=0 priorityscore=1501
 spamscore=0 clxscore=1011 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312050172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the commit message of commit 'dd014803f260 ("interconnect: qcom:
icc-rpm: Add AB/IB calculations coefficients")', the peak rate should be
100/ib_percent. But, in what looks like a typical typo, the numerator
value is discarded in the calculation.

Update the implementation to match the described intention.

Fixes: dd014803f260 ("interconnect: qcom: icc-rpm: Add AB/IB calculations coefficients")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Spotted while reading the code, patch is untested.
---
 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index fb54e78f8fd7..a8ed435f696c 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -307,7 +307,7 @@ static u64 qcom_icc_calc_rate(struct qcom_icc_provider *qp, struct qcom_icc_node
 
 	if (qn->ib_coeff) {
 		agg_peak_rate = qn->max_peak[ctx] * 100;
-		agg_peak_rate = div_u64(qn->max_peak[ctx], qn->ib_coeff);
+		agg_peak_rate = div_u64(agg_peak_rate, qn->ib_coeff);
 	} else {
 		agg_peak_rate = qn->max_peak[ctx];
 	}

---
base-commit: 0f5f12ac05f36f117e793656c3f560625e927f1b
change-id: 20231205-qcom_icc_calc_rate-typo-a1542df4f222

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>

