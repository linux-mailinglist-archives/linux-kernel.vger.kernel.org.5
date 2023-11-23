Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2597F5A46
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbjKWIlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKWIlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:41:05 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6BCD56;
        Thu, 23 Nov 2023 00:41:11 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN5uFG9020347;
        Thu, 23 Nov 2023 08:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=DFF6SBown3zJI3vv5koqMtjckFgbW+mpaijN5lmrUrY=;
 b=OpIA9zbxNYBAFNRyegAJN0ZYE0fVwHTkkoybSVka+t4dGPDLnQ1ANWKQPVmPJmSPFn/n
 EqtZYFYeTklHBP1CVRvugmHUlB3oecQ0UbbH7GIUscniuApWLZLvT09W9xkCr5Lha8f7
 CEtH+sc4UKqqZHk1LsFo7VL7n6wQlugVZVJ3Yw22t92/t6+aTlMBCIHG9pWYAsPUBP3j
 VNlAQh12t6iyfvfqkna78MkFe4JXhL5GOAgJoHI9UvkEz0AqSESlhapuFx2ZuOIwZ0me
 8krMNiFblYLtz4sRk1nuycYzpe6gW50lZQouQnyADcq+xvvU251hb4KXADL70zw7diAS Ag== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhf6ktt5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 08:36:40 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AN8Woqr021515;
        Thu, 23 Nov 2023 08:36:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3uhpmqphf1-1;
        Thu, 23 Nov 2023 08:36:39 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AN8YmAt023558;
        Thu, 23 Nov 2023 08:36:39 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3AN8adNT025579;
        Thu, 23 Nov 2023 08:36:39 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id 1F5CC20A68; Thu, 23 Nov 2023 00:36:39 -0800 (PST)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 10/10] scsi: ufs: ufs-qcom: Add support for UFS device version detection
Date:   Thu, 23 Nov 2023 00:36:16 -0800
Message-Id: <1700728577-14729-11-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700728577-14729-1-git-send-email-quic_cang@quicinc.com>
References: <1700728577-14729-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sarxo_8PsrxAcwn7jT4nyfLh0nNpcGjK
X-Proofpoint-ORIG-GUID: sarxo_8PsrxAcwn7jT4nyfLh0nNpcGjK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_06,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311230060
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>

A spare register in UFS host controller is used to indicate the UFS device
version. The spare register is populated by bootloader for now, but in
future it will be populated by HW automatically during link startup with
its best efforts in any boot stages prior to Linux.

During host driver init, read the spare register, if it is not populated
with a UFS device version, go ahead with the dual init mechanism. If a UFS
device version is in there, use the UFS device version together with host
controller's HW version to decide the proper PHY gear which should be used
to configure the UFS PHY without going through the second init.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 23 ++++++++++++++++++-----
 drivers/ufs/host/ufs-qcom.h |  2 ++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 7bbccf4..70bedd9 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1070,15 +1070,28 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
 static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
 {
 	struct ufs_host_params *host_params = &host->host_params;
+	u32 val, dev_major = 0;
 
 	host->phy_gear = host_params->hs_tx_gear;
 
-	/*
-	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
-	 * Switching to max gear will be performed during reinit if supported.
-	 */
-	if (host->hw_ver.major < 0x5)
+	if (host->hw_ver.major < 0x5) {
+		/*
+		 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
+		 * Switching to max gear will be performed during reinit if supported.
+		 */
 		host->phy_gear = UFS_HS_G2;
+	} else {
+		val = ufshcd_readl(host->hba, REG_UFS_DEBUG_SPARE_CFG);
+		dev_major = FIELD_GET(GENMASK(7, 4), val);
+
+		/* UFS device version populated, no need to do init twice */
+		if (dev_major != 0)
+			host->hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
+
+		/* For UFS 3.1 and older, apply HS-G4 PHY gear to save power */
+		if (dev_major < 0x4 && dev_major > 0)
+			host->phy_gear = UFS_HS_G4;
+	}
 }
 
 static void ufs_qcom_set_host_params(struct ufs_hba *hba)
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 11419eb..d12fc5a 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -54,6 +54,8 @@ enum {
 	UFS_AH8_CFG				= 0xFC,
 
 	REG_UFS_CFG3				= 0x271C,
+
+	REG_UFS_DEBUG_SPARE_CFG			= 0x284C,
 };
 
 /* QCOM UFS host controller vendor specific debug registers */
-- 
2.7.4

