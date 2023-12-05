Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B9805FF0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345871AbjLEVA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEVAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:00:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B90188;
        Tue,  5 Dec 2023 13:00:29 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5KCpa8027610;
        Tue, 5 Dec 2023 21:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=PlydpWRjHtHic2XxvMv/KvRCxL0wDGS/TfYuHMvLVH8=;
 b=VmL83gv5+Ea2Ms9hTUP4+lpmFijdLhl7kcMHqRi68oOHq38SgHdn1z0CUmXzVzg+fwmx
 I2ffILlns32I8SHWCh/TgVqqDp/gYRitTfWYJtuBzF8llo+MtgEyY2lMrMrdDLgGkbRN
 av32i9rmddVtEV0Q75gEgiTeztLMS6M0otnLXWAZTfoFRUIbiprZfIA9SABn3SvDuCZN
 meSeiDflbrG3STs/G+zui0LFATcPuLOqTUlT7R3prpypX3fidDCOqGQBiAd8KO2pkSwR
 aCcJWldD+F+UXsDlLugr1EWT4kBCvAQRFFw3o6JM8AZyhoif+frsnZxusrLBvvUoWlNv oA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utapgr30x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 21:00:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B5L0IQj017032
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Dec 2023 21:00:18 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Dec
 2023 13:00:17 -0800
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Tue, 5 Dec 2023 13:00:17 -0800
Subject: [PATCH v2] wifi: ath11k: Fix ath11k_htc_record flexible record
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231205-flexarray-htc_record-v2-1-fbb56d436951@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGCPb2UC/4WNyw6CMBBFf4V0bU1bSH2s/A9DTB8zMolSbZFAC
 P9uwZUbXZ6bnHMnliASJHYsJhahp0ShzaA2BXONaa/AyWdmSqhSSqk53mAwMZqRN527RHAhem6
 g0ijKg68ssqw+IiANa/ZcZ24odSGO60svl/VPsJdccAVeCWtxDx5Pzxc5at3Whfvy8NHV7oeuL
 UgstVQa/Zdez/P8BloMeTD5AAAA
To:     Kalle Valo <kvalo@kernel.org>
CC:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Jeff Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jTLfMYYRSr1i-mXPq7trv5a3bVfsyhQu
X-Proofpoint-GUID: jTLfMYYRSr1i-mXPq7trv5a3bVfsyhQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_16,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=500 bulkscore=0 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312050163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transform the zero-length ath11k_htc_record::credit_report array into
a proper flexible array. Since this is the only array in
ath11k_htc_record, remove the unnecessary union.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Original patches 1/4 2/4 3/4 already accepted
- This is original patch 4/4, updated to incorporate Gustavo's review
  comment, removing the `union` and just do a direct transformation
  [0] -> [ ]
- Link to v1: https://lore.kernel.org/r/20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com
---
 drivers/net/wireless/ath/ath11k/htc.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/htc.h b/drivers/net/wireless/ath/ath11k/htc.h
index d5864a35e75b..86f77eacaea7 100644
--- a/drivers/net/wireless/ath/ath11k/htc.h
+++ b/drivers/net/wireless/ath/ath11k/htc.h
@@ -151,9 +151,7 @@ struct ath11k_htc_credit_report {
 
 struct ath11k_htc_record {
 	struct ath11k_htc_record_hdr hdr;
-	union {
-		struct ath11k_htc_credit_report credit_report[0];
-	};
+	struct ath11k_htc_credit_report credit_report[];
 } __packed __aligned(4);
 
 enum ath11k_htc_svc_gid {

---
base-commit: c8a5f34ad811743d1b3aeb5c54198eebd413bc6d
change-id: 20231116-flexarray-htc_record-ae46f039d4bf

