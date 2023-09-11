Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD679A32D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjIKGBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbjIKGBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:01:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1137D130;
        Sun, 10 Sep 2023 23:01:07 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B5OEG4013821;
        Mon, 11 Sep 2023 06:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Ah43MEabq/hUKf+KL/W0qumc8leAu8QH6ZICxktxlgU=;
 b=PllLgMvy5TOniNo9/8RRvNBLnFbp++wAXh6D5T7zSt9SU2b7SjayBZwpU7vL44hYNrVT
 SIAHPrPJO9dAqhCKww+pbK/FvzeljC+taHEem7+Khs9LTfPC13L2fPVCTqIpD5NIIK6U
 FjsujP7UW1KnNokT9gbAStkdDinDEcfcTXO33t2mcl8VKY7p+2IANOQtSvnTgT9C8Dfa
 xPvyYNVU9APhVYq5yt/2u4l8FtPXkq1u3faFAdwBwnfQd8Sx11kzHP9fEr0nsEGCFRZQ
 wI9vigC3o1DVa27tLmP7cW8cbsS2GZb1skveQzcRSmYwDmmuqu+OHT2XGW4YYO9ZpGSm gQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0ga6jksw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 06:00:36 +0000
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38B5f8BG015159;
        Mon, 11 Sep 2023 06:00:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTP id 3t0hsm75wx-1;
        Mon, 11 Sep 2023 06:00:35 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38B60ZHe011675;
        Mon, 11 Sep 2023 06:00:35 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTP id 38B60Z2k011672;
        Mon, 11 Sep 2023 06:00:35 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id 169CA20DEF; Sun, 10 Sep 2023 23:00:35 -0700 (PDT)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, mani@kernel.org, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST
        CONTROLLER DRIVER...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/6] scsi: ufs: ufs-qcom: Setup host power mode during init
Date:   Sun, 10 Sep 2023 22:59:22 -0700
Message-Id: <1694411968-14413-2-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u48voceZxTbZV7oh5rne9_2qDGNJfYW6
X-Proofpoint-ORIG-GUID: u48voceZxTbZV7oh5rne9_2qDGNJfYW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110054
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup host power mode and its limitations during UFS host driver init to
avoid repetitive work during every power mode change.

Co-developed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 27 ++++++++++++++++++---------
 drivers/ufs/host/ufs-qcom.h |  1 +
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index c3215d3..710f079 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -443,7 +443,11 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
 static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct ufs_dev_params *host_pwr_cap = &host->host_pwr_cap;
 	struct phy *phy = host->generic_phy;
+	enum phy_mode mode = host_pwr_cap->hs_rate == PA_HS_MODE_B ?
+							PHY_MODE_UFS_HS_B :
+							PHY_MODE_UFS_HS_A;
 	int ret;
 
 	/* Reset UFS Host Controller and PHY */
@@ -460,7 +464,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 		return ret;
 	}
 
-	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->phy_gear);
+	phy_set_mode_ext(phy, mode, host->phy_gear);
 
 	/* power on phy - start serdes and phy's power and clocks */
 	ret = phy_power_on(phy);
@@ -884,7 +888,6 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 				struct ufs_pa_layer_attr *dev_req_params)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	struct ufs_dev_params ufs_qcom_cap;
 	int ret = 0;
 
 	if (!dev_req_params) {
@@ -894,13 +897,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 
 	switch (status) {
 	case PRE_CHANGE:
-		ufshcd_init_pwr_dev_param(&ufs_qcom_cap);
-		ufs_qcom_cap.hs_rate = UFS_QCOM_LIMIT_HS_RATE;
-
-		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
-		ufs_qcom_cap.hs_tx_gear = ufs_qcom_cap.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
-
-		ret = ufshcd_get_pwr_dev_param(&ufs_qcom_cap,
+		ret = ufshcd_get_pwr_dev_param(&host->host_pwr_cap,
 					       dev_max_params,
 					       dev_req_params);
 		if (ret) {
@@ -1037,6 +1034,17 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
 		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
 }
 
+static void ufs_qcom_set_pwr_mode_limits(struct ufs_hba *hba)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct ufs_dev_params *host_pwr_cap = &host->host_pwr_cap;
+
+	ufshcd_init_pwr_dev_param(host_pwr_cap);
+
+	/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
+	host_pwr_cap->hs_tx_gear = host_pwr_cap->hs_rx_gear = ufs_qcom_get_hs_gear(hba);
+}
+
 static void ufs_qcom_set_caps(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
@@ -1259,6 +1267,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	if (err)
 		goto out_variant_clear;
 
+	ufs_qcom_set_pwr_mode_limits(hba);
 	ufs_qcom_set_caps(hba);
 	ufs_qcom_advertise_quirks(hba);
 
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index fa54248..4db64d9 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -227,6 +227,7 @@ struct ufs_qcom_host {
 
 	struct gpio_desc *device_reset;
 
+	struct ufs_dev_params host_pwr_cap;
 	u32 phy_gear;
 
 	bool esi_enabled;
-- 
2.7.4

