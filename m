Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2CE7E34A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 05:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjKGErE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 23:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjKGErC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 23:47:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A5114;
        Mon,  6 Nov 2023 20:47:00 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A73xnER029768;
        Tue, 7 Nov 2023 04:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=BJOPFUlO8fR2yike4h6l0Q1+3cHf0Kj1rIEKZZHnmeo=;
 b=ZaRX4HhJn7jNqVLL79CafjQT1vvsn8l7x1dVoOMz7sVMIqrY7UZDqs/9THcBA2wWGfD5
 pDhadHTIA0c1s7Gi7LMADAEcCOBnRz2w7GELAotDLGwKbyXlzOmGT1NmElPHVV3KWCpJ
 VEkiSo9+m48nlHsvZXEsZxzLBxCx+WbR9YEH/LFvibqqxGoxb/XbpAJUjNurCfLGXaEC
 TTSxGu6TcktfOS9Y0FKRFSiDrTIixbJSeyuxttMhzw2FEg17nJSAHnHrwg3xJUafBYiu
 7FGH/kQFBfm+qqpuXnPY01rRgjv+ePQKbaAVKUkNkvhxLP8X/XObKkpCsz+FgEFrKp7g Nw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u74v3159k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 04:46:46 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A74eK3f001989;
        Tue, 7 Nov 2023 04:46:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3u73v7ndqn-1;
        Tue, 07 Nov 2023 04:46:46 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A74ewV0003254;
        Tue, 7 Nov 2023 04:46:45 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3A74kjKg013071;
        Tue, 07 Nov 2023 04:46:45 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id 93B4720A78; Mon,  6 Nov 2023 20:46:45 -0800 (PST)
From:   Can Guo <cang@qti.qualcomm.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/7] scsi: ufs: ufs-qcom: Allow the first init start with the maximum supported gear
Date:   Mon,  6 Nov 2023 20:46:09 -0800
Message-Id: <1699332374-9324-4-git-send-email-cang@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gHKYI1cw92_-pC9pMV9p3u_lriUKjZV-
X-Proofpoint-ORIG-GUID: gHKYI1cw92_-pC9pMV9p3u_lriUKjZV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <quic_cang@quicinc.com>

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

This change is a preparation patch for the next patches in the same series.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index cc0eb37..60b35ca 100644
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

