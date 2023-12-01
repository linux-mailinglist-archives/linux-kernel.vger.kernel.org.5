Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80878002C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377515AbjLAFFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377413AbjLAFEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:04:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6071A1730;
        Thu, 30 Nov 2023 21:04:46 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B14oQQL025033;
        Fri, 1 Dec 2023 05:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=VaoifbxNcCu6nJVvBrW+8U/ODJZuudYc8IT5Yil3US8=;
 b=IjRd+cBjqAMB+CyAesZNJZ9rbUQYI1/AezDcJ/HE8XyJkpvbwKSfWL5smCQpzOWbwHZx
 fG9Kho/TxlttJfs3/gqkxJ3tk9FRsb5TtUoAQhQaTIkDkLyZ+4WJ3BrplLSNSiL4p5U6
 IYvm6ZqQnXA0Kp/2MdaZDFZCv7CvYYDHvEbSaTIehqxjOeZcXuABqI4+6fGThxEoKPlS
 HRdy/CE6YkrnLha8ODpUjhEy1nKPu0Gps88nffJW8gQcdEb158sl/xnoVmp+jKmVK9FO
 oMulTj7UXXEs0vnfZFM2HqSWCZXZNrfvuxIJum9+gCHQVC5Fm2V668FTC7MUXvzQcI6R yQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3upw12sryw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 05:04:06 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3B14v6V8025713;
        Fri, 1 Dec 2023 05:04:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3unmewu5hm-1;
        Fri, 01 Dec 2023 05:04:05 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B152Ehv002633;
        Fri, 1 Dec 2023 05:04:04 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3B1544SX004581;
        Fri, 01 Dec 2023 05:04:04 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id 0B5A020A69; Thu, 30 Nov 2023 21:04:01 -0800 (PST)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        adrian.hunter@intel.com, vkoul@kernel.org, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 04/10] scsi: ufs: ufs-qcom: Allow the first init start with the maximum supported gear
Date:   Thu, 30 Nov 2023 21:03:14 -0800
Message-Id: <1701407001-471-5-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701407001-471-1-git-send-email-quic_cang@quicinc.com>
References: <1701407001-471-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: foHvakcEYP59TyVN1-D3N33u1nFEtcIF
X-Proofpoint-ORIG-GUID: foHvakcEYP59TyVN1-D3N33u1nFEtcIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_02,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312010028
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During host driver init, the phy_gear is set to the minimum supported gear
(HS_G2). Then, during the first power mode change, the negotiated gear, say
HS-G4, is updated to the phy_gear variable so that in the second init the
updated phy_gear can be used to program the PHY.

But the current code only allows update the phy_gear to a higher value. If
one wants to start the first init with the maximum support gear, say HS-G4,
the phy_gear is not updated to HS-G3 if the device only supports HS-G3.

The original check added there is intend to make sure the phy_gear won't be
updated when gear is scaled down (during clock scaling). Update the check
so that one can start the first init with the maximum support gear without
breaking the original fix by checking the ufshcd_state, that is, allow
update to phy_gear only if power mode change is invoked from
ufshcd_probe_hba().

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 9a90019..81056b9 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -916,11 +916,12 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 		}
 
 		/*
-		 * Update phy_gear only when the gears are scaled to a higher value. This is
-		 * because, the PHY gear settings are backwards compatible and we only need to
-		 * change the PHY gear settings while scaling to higher gears.
+		 * During UFS driver probe, always update the PHY gear to match the negotiated
+		 * gear, so that, if quirk UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH is enabled,
+		 * the second init can program the optimal PHY settings. This allows one to start
+		 * the first init with either the minimum or the maximum support gear.
 		 */
-		if (dev_req_params->gear_tx > host->phy_gear)
+		if (hba->ufshcd_state == UFSHCD_STATE_RESET)
 			host->phy_gear = dev_req_params->gear_tx;
 
 		/* enable the device ref clock before changing to HS mode */
-- 
2.7.4

