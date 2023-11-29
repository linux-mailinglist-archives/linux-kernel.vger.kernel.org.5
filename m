Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B327FCF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjK2G6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjK2G6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:58:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B7319AB;
        Tue, 28 Nov 2023 22:58:22 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT4DS6n009415;
        Wed, 29 Nov 2023 06:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qGDZyLkSoHtcMnsZPlA3sOSXl2/82Oeo64ZLTh+FD5o=;
 b=EmjoSRZG3kb8A6fRCw1WqHZ0g/Dt9pmOJx1O3jZXfQQNdQuTqwCua0D5qOlFYRhMUhY8
 j0mGvzZt+gJbnfZiAvedTy1y0NaMrSv70+fHR/8+9WikaWlA3wXhMBP09N0IqXaaL7vy
 Vq1GvEeOqNtKGRdID7yfq9dYHzOuxnwYlfBFFKKwIzJx/DKyZGpwp1WwuRIGQAKA7TZG
 PihhZENtuLhVWHySJ+RYr6FRmQe5n/vsgOwtv2vouLOF2H6siHR56NBPmRs6fRIwiJyI
 8XGFt5oqOfQLRZN1TV+beY016u/IuEYmWGp9GgPyrU6NxyfXScycibBgJx+Uy+1weG0G aw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unjdtj37b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 06:58:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AT6wG1T027258
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 06:58:16 GMT
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 28 Nov 2023 22:58:13 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <sudeep.holla@arm.com>, <cristian.marussi@arm.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mdtipton@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>, <quic_asartor@quicinc.com>,
        <quic_lingutla@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 2/3] firmware: arm_scmi: Fix freq/power truncation in the perf protocol
Date:   Wed, 29 Nov 2023 12:27:47 +0530
Message-ID: <20231129065748.19871-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231129065748.19871-1-quic_sibis@quicinc.com>
References: <20231129065748.19871-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ai59dcvVBLIw8QsbmAkP_tBPyjQWr3r4
X-Proofpoint-ORIG-GUID: Ai59dcvVBLIw8QsbmAkP_tBPyjQWr3r4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_03,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix frequency and power truncation seen in the performance protocol by
casting it with the correct type.

Fixes: a9e3fbfaa0ff ("firmware: arm_scmi: add initial support for performance protocol")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/firmware/arm_scmi/perf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index a648521e04a3..3344ce3a2026 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -804,9 +804,9 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 
 	for (idx = 0; idx < dom->opp_count; idx++) {
 		if (!dom->level_indexing_mode)
-			freq = dom->opp[idx].perf * dom->mult_factor;
+			freq = (unsigned long)dom->opp[idx].perf * dom->mult_factor;
 		else
-			freq = dom->opp[idx].indicative_freq * 1000;
+			freq = (unsigned long)dom->opp[idx].indicative_freq * 1000;
 
 		data.level = dom->opp[idx].perf;
 		data.freq = freq;
@@ -879,7 +879,7 @@ static int scmi_dvfs_freq_get(const struct scmi_protocol_handle *ph, u32 domain,
 		return ret;
 
 	if (!dom->level_indexing_mode) {
-		*freq = level * dom->mult_factor;
+		*freq = (unsigned long)level * dom->mult_factor;
 	} else {
 		struct scmi_opp *opp;
 
@@ -887,7 +887,7 @@ static int scmi_dvfs_freq_get(const struct scmi_protocol_handle *ph, u32 domain,
 		if (!opp)
 			return -EIO;
 
-		*freq = opp->indicative_freq * 1000;
+		*freq = (unsigned long)opp->indicative_freq * 1000;
 	}
 
 	return ret;
@@ -908,9 +908,9 @@ static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
 
 	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
 		if (!dom->level_indexing_mode)
-			opp_freq = opp->perf * dom->mult_factor;
+			opp_freq = (unsigned long)opp->perf * dom->mult_factor;
 		else
-			opp_freq = opp->indicative_freq * 1000;
+			opp_freq = (unsigned long)opp->indicative_freq * 1000;
 
 		if (opp_freq < *freq)
 			continue;
-- 
2.17.1

