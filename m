Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D5379A348
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjIKGGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjIKGGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:06:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E436CCD1;
        Sun, 10 Sep 2023 23:05:46 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B5bFLX011277;
        Mon, 11 Sep 2023 06:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=2sVTtfHQyoPSBsPZGshT/pHcneEVu4iOjNd4wVdto10=;
 b=H5Cggt6zuLjIPl+aPBve3YV7z0Y+Ig4AhQU7qUS8lA+fWcxL+rt5uLFprq5sW3aQ8gEY
 ztvZSG0hsFLmB8XBxcHui+IGAV6Unh6TjloAMSNM5ae/hhVFlghAA4cZOou+gf9x3oIU
 b4sJsW8HS0+8x4lSI8i21LsD+KQ5HSSsWm05V3v2IWRuYmk2/tNUpiCV38KvaYGzTx0h
 Dq6G0qj1x5EodBKJz6Pn64fJAPUcLeXy2H9H4cVSfvle+REixzxrTFWcE5eIqYvwSFL1
 4/E9kWPwRPZtens5cNgY8PnufocvYcfipGc2Yi3ZRN5wT09+iagWDoDyZN3o0SUkzx9J xQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0hvyjr9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 06:00:37 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38B5ic2M015870;
        Mon, 11 Sep 2023 06:00:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3t0hskq2fw-1;
        Mon, 11 Sep 2023 06:00:37 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38B60E7S007369;
        Mon, 11 Sep 2023 06:00:36 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 38B60a0P007883;
        Mon, 11 Sep 2023 06:00:36 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id 7A83E20DEF; Sun, 10 Sep 2023 23:00:36 -0700 (PDT)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, mani@kernel.org, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST
        CONTROLLER DRIVER...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/6] scsi: ufs: ufs-qcom: Add support for UFS device version detection
Date:   Sun, 10 Sep 2023 22:59:23 -0700
Message-Id: <1694411968-14413-3-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hvxIvFIcC1mjgiBPhKG4ZWV5fS_b81mT
X-Proofpoint-GUID: hvxIvFIcC1mjgiBPhKG4ZWV5fS_b81mT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110054
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>

Retrieve UFS device version from UFS host controller's spare register
which is populated by bootloader, and use the UFS device version together
with host controller's HW version to decide the proper power modes which
should be used to configure the UFS PHY.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 30 +++++++++++++++++++++++-------
 drivers/ufs/host/ufs-qcom.h |  2 ++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 710f079..8a9d54f 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1030,7 +1030,7 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
 				| UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP);
 	}
 
-	if (host->hw_ver.major > 0x3)
+	if (host->hw_ver.major > 0x3 && host->hw_ver.major < 0x5)
 		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
 }
 
@@ -1038,11 +1038,33 @@ static void ufs_qcom_set_pwr_mode_limits(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct ufs_dev_params *host_pwr_cap = &host->host_pwr_cap;
+	u32 val, dev_major = 0;
 
 	ufshcd_init_pwr_dev_param(host_pwr_cap);
 
 	/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
 	host_pwr_cap->hs_tx_gear = host_pwr_cap->hs_rx_gear = ufs_qcom_get_hs_gear(hba);
+	host->phy_gear = host_pwr_cap->hs_rx_gear;
+
+	if (host->hw_ver.major < 0x5) {
+		/*
+		 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
+		 * Switching to max gear will be performed during reinit if supported.
+		 */
+		host->phy_gear = UFS_HS_G2;
+	} else {
+		val = ufshcd_readl(host->hba, REG_UFS_DEBUG_SPARE_CFG);
+		dev_major = FIELD_GET(GENMASK(7, 4), val);
+
+		if (host->hw_ver.major == 0x5 && (dev_major >= 0x4 ||
+						  dev_major == 0)) {
+			/* For UFS 4.0 and newer, or dev version is not populated */
+			host_pwr_cap->hs_rate = PA_HS_MODE_A;
+		} else if (dev_major < 0x4 && dev_major > 0) {
+			/* For UFS 3.1 and older, apply HS-G4 PHY settings to save power */
+			host->phy_gear = UFS_HS_G4;
+		}
+	}
 }
 
 static void ufs_qcom_set_caps(struct ufs_hba *hba)
@@ -1287,12 +1309,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
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
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 4db64d9..e10889f 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -56,6 +56,8 @@ enum {
 	UFS_AH8_CFG				= 0xFC,
 
 	REG_UFS_CFG3				= 0x271C,
+
+	REG_UFS_DEBUG_SPARE_CFG			= 0x284C,
 };
 
 /* QCOM UFS host controller vendor specific debug registers */
-- 
2.7.4

