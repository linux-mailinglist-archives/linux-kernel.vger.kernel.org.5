Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0187798CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjHKUtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbjHKUs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:48:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8245330DF;
        Fri, 11 Aug 2023 13:48:58 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BKbeCK024125;
        Fri, 11 Aug 2023 20:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=cflUzEaWx29nL/vxxURuqfdfo+2qrB5uMsLChz0yjS0=;
 b=JZ0UYZ1FpdXf436ZjtQUohAeIR/YZ7jhUJJYhvmPuBEOKkb+BusuS9m8/ygZlRRW5isw
 aYRlI2edO5Q9yMwa5hHXmzdaIjr9qt9jkPJiqN2XmuyOC3f5RbuKDypqZjXPZx2oQmnA
 yAEu0vTzjLaUHONpA6gXtnFUQwmzQcaqGHzNqH+BobxZHrLH6N4vNrvyb7vbgXWiAy2y
 4rdGi4rrA+Qo9H0t7ThRwRd/r71SdtwdpAqFmS4yfcxpgSeFPJTHueAbAG2M1GRYRQKY
 X5Kt/hphl468HtazZHEtliWO15hzQKxzOpWjauTzSPRlBBcNEnTNdZF3LR/hZRJuHApS Gw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd9062qyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 20:48:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BKmm5Y007231
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 20:48:48 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 11 Aug 2023 13:48:45 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <lukasz.luba@arm.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_rjendra@quicinc.com>,
        <srinivas.kandagatla@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Chandra Sekhar Lingutla <quic_lingutla@quicinc.com>
Subject: [PATCH] firmware: arm_scmi: Fixup perf microwatt support
Date:   Sat, 12 Aug 2023 02:18:18 +0530
Message-ID: <20230811204818.30928-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fUGMSjhW--y1csfsf7jrO3m2f6kGQiPf
X-Proofpoint-ORIG-GUID: fUGMSjhW--y1csfsf7jrO3m2f6kGQiPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1011 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf power scale value would currently be reported as bogowatts if the
platform firmware supports microwatt power scale and meets the perf major
version requirements. Fix this by populating version information in the
driver private data before the call to protocol attributes is made.

CC: Chandra Sekhar Lingutla <quic_lingutla@quicinc.com>
Fixes: 3630cd8130ce ("firmware: arm_scmi: Add SCMI v3.1 perf power-cost in microwatts")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/firmware/arm_scmi/perf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index c0cd556fbaae..30dedd6ebfde 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -1080,6 +1080,8 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 	if (!pinfo)
 		return -ENOMEM;
 
+	pinfo->version = version;
+
 	ret = scmi_perf_attributes_get(ph, pinfo);
 	if (ret)
 		return ret;
@@ -1104,8 +1106,6 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 	if (ret)
 		return ret;
 
-	pinfo->version = version;
-
 	return ph->set_priv(ph, pinfo);
 }
 
-- 
2.17.1

