Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A797F3EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbjKVHQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjKVHQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:16:15 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D8790;
        Tue, 21 Nov 2023 23:16:11 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM5k8nD026875;
        Wed, 22 Nov 2023 07:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=zN12TslWlABlp9K+YRCFNUDSGb7EOJnrGrpMh/GCmsY=;
 b=Fd1LRf9lkkBjS/sazsPqq3FEigQ6QD2Rvzn/WMBrDXa8ZiTM9rKzCRtlpwiKKWfwDCvn
 Rzr7RS/rxqKDUjPjvwi4SdAv/G+msNQW7lTw26uMT6xaZETVZrLDgF1kaUBYvaeBafGO
 3nHK/B3n6jAWfR+egOBFZK6GfVtsZGWbBMFvBaE0gXXYLK/xuC22jcJhT1OWOsDZGF3x
 lN05shZNCkqL0fal1xBAI/kjcUe8qhA9M413EDMjRO0Wuah33Xu5f2U86S27lAutYVgI
 DopEIOK9pJa9LYu46D9TPhXXpD7I4cP6cpopn7z2o9tW/vh4+4BB0bRWQ8EcgBlidXNy YQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhbsp86pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 07:11:05 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AM72Y14020842;
        Wed, 22 Nov 2023 07:11:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3uepbmyg7y-1;
        Wed, 22 Nov 2023 07:11:03 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AM7B3fE002480;
        Wed, 22 Nov 2023 07:11:03 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3AM7B34G002475;
        Wed, 22 Nov 2023 07:11:03 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id B408720A68; Tue, 21 Nov 2023 23:11:02 -0800 (PST)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-scsi@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST
        CONTROLLER DRIVER...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 04/11] scsi: ufs: ufs-qcom: Limit negotiated gear to selected PHY gear
Date:   Tue, 21 Nov 2023 23:10:35 -0800
Message-Id: <1700637042-11104-5-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700637042-11104-1-git-send-email-quic_cang@quicinc.com>
References: <1700637042-11104-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PVg95SGpqZAOrBj-K17GVeoupE8iGtK-
X-Proofpoint-GUID: PVg95SGpqZAOrBj-K17GVeoupE8iGtK-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_04,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220050
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the dual init scenario, the initial PHY gear is set to HS-G2, and the
first Power Mode Change (PMC) is meant to find the best matching PHY gear
for the 2nd init. However, for the first PMC, if the negotiated gear (say
HS-G4) is higher than the initial PHY gear, we cannot go ahead let PMC to
the negotiated gear happen, because the programmed UFS PHY settings may not
support the negotiated gear. Fix it by overwriting the negotiated gear with
the PHY gear.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index cc0eb37..d4edf58 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -920,8 +920,13 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 		 * because, the PHY gear settings are backwards compatible and we only need to
 		 * change the PHY gear settings while scaling to higher gears.
 		 */
-		if (dev_req_params->gear_tx > host->phy_gear)
+		if (dev_req_params->gear_tx > host->phy_gear) {
+			u32 old_phy_gear = host->phy_gear;
+
 			host->phy_gear = dev_req_params->gear_tx;
+			dev_req_params->gear_tx = old_phy_gear;
+			dev_req_params->gear_rx = old_phy_gear;
+		}
 
 		/* enable the device ref clock before changing to HS mode */
 		if (!ufshcd_is_hs_mode(&hba->pwr_info) &&
-- 
2.7.4

