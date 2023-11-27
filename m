Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8797FA5FB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjK0QPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjK0QPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:15:06 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7172D5A;
        Mon, 27 Nov 2023 08:15:05 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARD0jji021363;
        Mon, 27 Nov 2023 16:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=AO8cGpLBaeunKrPjmlXZd/sscUATqYVwofXtEfGFPQk=;
 b=dFzAnkUE5PYAAAcJ/hb37CkI2Uy1VDsFtmS4n33luSz3gB4z2CF16bbOjbccaUrDHQ6x
 XC/SIEaK+Vrap59t/UhpEfCDiWi+B5bQFTuqLbRRygB5gSG96r3d2gDr6zQUTxydi6Ma
 i2+aWq1m+xdKkVhgEqvnzbkUYeb4ZqgVfVIAk3biveES7Uax2Brz3Xg07AYYHqUafV7w
 0ILorvwoxfX+mWIdbweGaWqSr1S2zXPxBfpY2+MmTTBiwj5fx/I1wV/7AJSNVv+NYK6l
 3Xj5s1uqMrcvvDh48ZB9vkeckW7t/g9EDMJ7Llk+GKe/lxLFJhyvOOULGoEaTE14if4S Kg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umqxh148a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 16:14:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ARGEn6E010139
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 16:14:49 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 08:14:49 -0800
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Mon, 27 Nov 2023 08:14:48 -0800
Subject: [PATCH 2/4] wifi: ath10k: Use DECLARE_FLEX_ARRAY() for
 ath10k_htc_record
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231127-flexarray-htc_record-v1-2-6be1f36126fd@quicinc.com>
References: <20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com>
In-Reply-To: <20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        <ath10k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N3tgrD8x6g5r96BxFZlFOe_Bwz9pEJco
X-Proofpoint-ORIG-GUID: N3tgrD8x6g5r96BxFZlFOe_Bwz9pEJco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_14,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=453 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transform the zero-length arrays in ath10k_htc_record into proper
flexible arrays via the DECLARE_FLEX_ARRAY() macro. This helps with
ongoing efforts to globally enable -Warray-bounds.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/htc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
index 9cbb901d35e5..c6c392f8630c 100644
--- a/drivers/net/wireless/ath/ath10k/htc.h
+++ b/drivers/net/wireless/ath/ath10k/htc.h
@@ -246,9 +246,9 @@ struct ath10k_htc_lookahead_bundle {
 struct ath10k_htc_record {
 	struct ath10k_ath10k_htc_record_hdr hdr;
 	union {
-		struct ath10k_htc_credit_report credit_report[0];
-		struct ath10k_htc_lookahead_report lookahead_report[0];
-		struct ath10k_htc_lookahead_bundle lookahead_bundle[0];
+		DECLARE_FLEX_ARRAY(struct ath10k_htc_credit_report, credit_report);
+		DECLARE_FLEX_ARRAY(struct ath10k_htc_lookahead_report, lookahead_report);
+		DECLARE_FLEX_ARRAY(struct ath10k_htc_lookahead_bundle, lookahead_bundle);
 	};
 } __packed __aligned(4);
 

-- 
2.42.0

