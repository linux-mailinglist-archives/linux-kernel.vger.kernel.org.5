Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671AA7F5A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344982AbjKWIgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344954AbjKWIgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:36:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F82E1BF;
        Thu, 23 Nov 2023 00:36:48 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN0nq9O030861;
        Thu, 23 Nov 2023 08:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=bOrJSSNFsLGbiSSB8YF589JZQLsAbNb5oTKc3fog6kw=;
 b=Uzxf7202hSQYatvU+tTDFf1DUzSmnGKuB2xYPa9oNHjoXBRT3CleDLn33hbvcKJMaHsr
 Mbyf0nBbvuwjWPvZIY5YMHkWe8FsfmrcZ6OrIjtFdb0equtLL+RpxP7ie35kbNSmASww
 +4Tx/oXLMHm02ARkT0DIc3zZMrlat3GsG4e3pa0b1AOThgni9xaXZvBpNiMyuN4Kf5fK
 7BbDsMgQqp91I7ge2Oo0J2vebrPSZpdIuIbyC1o8uRlmDZkyOI+DNbciwt1szPNlI4x6
 +x/1pFpW/uEctS85tO4l5DUWPijgQ2mI8SxHb6dvt9RUjhKMA+7aNFBex9Oh3S8brDUA Hg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhf66au4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 08:36:36 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AN8YNkp014146;
        Thu, 23 Nov 2023 08:36:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 3ughrmnvd9-1;
        Thu, 23 Nov 2023 08:36:35 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AN8aYUZ016859;
        Thu, 23 Nov 2023 08:36:34 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 3AN8aYsD016858;
        Thu, 23 Nov 2023 08:36:34 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id 6796220A68; Thu, 23 Nov 2023 00:36:34 -0800 (PST)
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
Subject: [PATCH v4 06/10] scsi: ufs: ufs-qcom: Limit HS-G5 Rate-A to hosts with HW version 5
Date:   Thu, 23 Nov 2023 00:36:12 -0800
Message-Id: <1700728577-14729-7-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700728577-14729-1-git-send-email-quic_cang@quicinc.com>
References: <1700728577-14729-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: C7syce5Qj9Wt339Wd1S4ailIKGMx3eVK
X-Proofpoint-GUID: C7syce5Qj9Wt339Wd1S4ailIKGMx3eVK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_06,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=747 lowpriorityscore=0
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

Qcom UFS hosts, with HW ver 5, can only support up to HS-G5 Rate-A due to
HW limitations. If the HS-G5 PHY gear is used, update host_params->hs_rate
to Rate-A, so that the subsequent power mode changes shall stick to Rate-A.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 9613ad9..6756f8d 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -442,9 +442,25 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
 static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct ufs_host_params *host_params = &host->host_params;
 	struct phy *phy = host->generic_phy;
+	enum phy_mode mode;
 	int ret;
 
+	/*
+	 * HW ver 5 can only support up to HS-G5 Rate-A due to HW limitations.
+	 * If the HS-G5 PHY gear is used, update host_params->hs_rate to Rate-A,
+	 * so that the subsequent power mode change shall stick to Rate-A.
+	 */
+	if (host->hw_ver.major == 0x5) {
+		if (host->phy_gear == UFS_HS_G5)
+			host_params->hs_rate = PA_HS_MODE_A;
+		else
+			host_params->hs_rate = PA_HS_MODE_B;
+	}
+
+	mode = host_params->hs_rate == PA_HS_MODE_B ? PHY_MODE_UFS_HS_B : PHY_MODE_UFS_HS_A;
+
 	/* Reset UFS Host Controller and PHY */
 	ret = ufs_qcom_host_reset(hba);
 	if (ret)
@@ -459,7 +475,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 		return ret;
 	}
 
-	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->phy_gear);
+	phy_set_mode_ext(phy, mode, host->phy_gear);
 
 	/* power on phy - start serdes and phy's power and clocks */
 	ret = phy_power_on(phy);
-- 
2.7.4

