Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6F67F5A45
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbjKWIkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKWIkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:40:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F698A3;
        Thu, 23 Nov 2023 00:40:53 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN6DB8f001009;
        Thu, 23 Nov 2023 08:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=IwN62VLEShy+VSKK0jRx0klroKj4fpZ9T+/MVP2hILs=;
 b=ZIj1khat/JPKmX9rCPVVOHmSpN7SPvjNn/2s721LNcrqv82J/kb/sqcHkdv07t4JC8Tg
 RQYD6Cz/WGYKhH0wKaH3nfPKlfWzQ/4/D9jkRTSzl8VU+ifCWqdaC5QlFU0sjTnpFK0J
 Br6wvt85fmcv8gIbUEHMYDg86m5uZ1b9bNocw7+32twSxTRt3m3G6+7ptFW+JUYYrwX9
 +BHAfsBJYjKJaZ/mf4uc29uIAkfs2UeN9Jk+lpT6akcfHf6UUGRAPslYTxI/lPWnnKyq
 rzYwlX1oCfd685gtj7yQLI7Yj4NkudEsK1PYnyGjqCNJPbSMbGEQ5O8SUY1eSnNTG/bZ yQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhf66au4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 08:36:36 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AN8aZGX025548;
        Thu, 23 Nov 2023 08:36:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3uhpmqphef-1;
        Thu, 23 Nov 2023 08:36:35 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AN8YmAr023558;
        Thu, 23 Nov 2023 08:36:35 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3AN8aZ7u025534;
        Thu, 23 Nov 2023 08:36:35 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id 452C120A68; Thu, 23 Nov 2023 00:36:35 -0800 (PST)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST
        CONTROLLER DRIVER...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 07/10] scsi: ufs: ufs-qcom: Set initial PHY gear to max HS gear for HW ver 5 and newer
Date:   Thu, 23 Nov 2023 00:36:13 -0800
Message-Id: <1700728577-14729-8-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700728577-14729-1-git-send-email-quic_cang@quicinc.com>
References: <1700728577-14729-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X2WBRtBmHRMnqfs2V28XRdC830qnZElC
X-Proofpoint-GUID: X2WBRtBmHRMnqfs2V28XRdC830qnZElC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_06,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311230060
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the initial PHY gear to max HS gear for hosts with HW ver 5 and newer.

This patch is not changing any functionalities or logic but only a
preparation patch for the next patch in this series.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 6756f8d..7bbccf4 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1067,6 +1067,20 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
 		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
 }
 
+static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
+{
+	struct ufs_host_params *host_params = &host->host_params;
+
+	host->phy_gear = host_params->hs_tx_gear;
+
+	/*
+	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
+	 * Switching to max gear will be performed during reinit if supported.
+	 */
+	if (host->hw_ver.major < 0x5)
+		host->phy_gear = UFS_HS_G2;
+}
+
 static void ufs_qcom_set_host_params(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
@@ -1303,6 +1317,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	ufs_qcom_set_caps(hba);
 	ufs_qcom_advertise_quirks(hba);
 	ufs_qcom_set_host_params(hba);
+	ufs_qcom_set_phy_gear(host);
 
 	err = ufs_qcom_ice_init(host);
 	if (err)
@@ -1320,12 +1335,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 		dev_warn(dev, "%s: failed to configure the testbus %d\n",
 				__func__, err);
 
-	/*
-	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
-	 * Switching to max gear will be performed during reinit if supported.
-	 */
-	host->phy_gear = UFS_HS_G2;
-
 	return 0;
 
 out_variant_clear:
-- 
2.7.4

