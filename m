Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A62C7E34A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 05:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjKGErV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 23:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjKGErR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 23:47:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EC0125;
        Mon,  6 Nov 2023 20:47:02 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A74cTje012075;
        Tue, 7 Nov 2023 04:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=q1YP6As28/DNiZ1rMHfpQ7Na6pvhlHyYJ8AyVuP5HQ4=;
 b=n6fSabKHv+iP57iuiGPIQbouTujVwEA3hTJ4YC/9Ghp1VeuvDLCJZlEMeJmDOobWQB0A
 5Io4VG2rn/tShxbzo4TZJRihE4D6NK63E3a/OTSQPJkqLHYUkHZ9LuOldss6tyCQy6lS
 7N3zkQpUfWjuKBuQKbatMIb0CrP3gUs3J+Rk6C/i5zrAvMPjiN8VOD/BnrqgwkGiDctJ
 mIc9/zZMwAODIfJrPY2YuN3SlVyxMgy91NMmNXiALp/Pmu9uXGOOPrm27k+i7Zy3e0ZM
 METcCR5p1U+6x/YDvl/bQVF5rIn2JPVCb0EPBt2j8yoI7RVkmY+r+b3Cm70HEfytjgDz gA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u72r29gct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 04:46:48 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A74gL0l006772;
        Tue, 7 Nov 2023 04:46:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 3u6x85hsga-1;
        Tue, 07 Nov 2023 04:46:47 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A74klJX013433;
        Tue, 7 Nov 2023 04:46:47 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 3A74klqG013432;
        Tue, 07 Nov 2023 04:46:47 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id 4AB9820A78; Mon,  6 Nov 2023 20:46:47 -0800 (PST)
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
Subject: [PATCH v2 4/7] scsi: ufs: ufs-qcom: Limit HS-G5 Rate-A to hosts with HW version 5
Date:   Mon,  6 Nov 2023 20:46:10 -0800
Message-Id: <1699332374-9324-5-git-send-email-cang@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OOpA6zgtHp0qpBYNer8Ivyd4sfuqI5B3
X-Proofpoint-ORIG-GUID: OOpA6zgtHp0qpBYNer8Ivyd4sfuqI5B3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 mlxlogscore=719 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <quic_cang@quicinc.com>

Qcom UFS hosts, with HW ver 5, can only support up to HS-G5 Rate-A due to
HW limitations. If the HS-G5 PHY gear is used, update host_params->hs_rate
to Rate-A, so that the subsequent power mode changes shall stick to Rate-A.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 60b35ca..55ee31d 100644
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

