Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAD5801CA7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 13:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjLBMkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 07:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjLBMk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 07:40:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E41612D;
        Sat,  2 Dec 2023 04:40:35 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B2CaaIH026043;
        Sat, 2 Dec 2023 12:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=B1stBXweFHGLo0FZ562PYkOASJIgvjARx2einm+rVNQ=;
 b=SDa1fCyFzo+BusDl8U1oLOFlNYy7QCB2aefq4GIO5sL/IBSgXYZNqx7AaoTVfcnIrb/e
 syHEiCz+1MRJT/GQ66l4dFjviJ4wVo6AFM+i5jyLxXW+s01oBqsAyjmICoLmhBh0YxI4
 ySZXJNGjZDahEG/SWap5phhIQ7YOnLE/eFG6xpfhXFyXlH6B2bD8aGUWRsjEHygCvD03
 mfO7BrhPt7NuTzs9TM+6OSik1xYl3r2Vf5XhvlaCHERgptyT5UWQvRuArZ/y8u/PuKLW
 FNyrjrhzsRuzc2YZTOR7yX7lZ1I+NrNSOxDX03z+0KZXI9a3OjTHdlPDANnbbzp9g1sw kg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqvyerhqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Dec 2023 12:36:42 +0000
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3B2CZ2Rl009437;
        Sat, 2 Dec 2023 12:36:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 3uqwnkbday-1;
        Sat, 02 Dec 2023 12:36:41 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B2CYMF1008672;
        Sat, 2 Dec 2023 12:36:41 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 3B2CaevB011393;
        Sat, 02 Dec 2023 12:36:41 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id 3894A20A90; Sat,  2 Dec 2023 04:36:40 -0800 (PST)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        adrian.hunter@intel.com, vkoul@kernel.org, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 03/10] scsi: ufs: ufs-qcom: Setup host power mode during init
Date:   Sat,  2 Dec 2023 04:36:09 -0800
Message-Id: <1701520577-31163-4-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
References: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YQZt9hEqzivYMlf3Wfo_3125r59Q23pj
X-Proofpoint-GUID: YQZt9hEqzivYMlf3Wfo_3125r59Q23pj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_10,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312020094
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup host power mode and its limitations during UFS host driver init to
avoid repetitive work during every power mode change.

Acked-by: Andrew Halaney <ahalaney@redhat.com>
Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Co-developed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 21 ++++++++++++++-------
 drivers/ufs/host/ufs-qcom.h |  1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index c21ff2c..9a90019 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -898,7 +898,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 				struct ufs_pa_layer_attr *dev_req_params)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	struct ufs_host_params host_params;
+	struct ufs_host_params *host_params = &host->host_params;
 	int ret = 0;
 
 	if (!dev_req_params) {
@@ -908,12 +908,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 
 	switch (status) {
 	case PRE_CHANGE:
-		ufshcd_init_host_params(&host_params);
-
-		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
-		host_params.hs_tx_gear = host_params.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
-
-		ret = ufshcd_negotiate_pwr_params(&host_params, dev_max_params, dev_req_params);
+		ret = ufshcd_negotiate_pwr_params(host_params, dev_max_params, dev_req_params);
 		if (ret) {
 			dev_err(hba->dev, "%s: failed to determine capabilities\n",
 					__func__);
@@ -1048,6 +1043,17 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
 		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
 }
 
+static void ufs_qcom_set_host_params(struct ufs_hba *hba)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct ufs_host_params *host_params = &host->host_params;
+
+	ufshcd_init_host_params(host_params);
+
+	/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
+	host_params->hs_tx_gear = host_params->hs_rx_gear = ufs_qcom_get_hs_gear(hba);
+}
+
 static void ufs_qcom_set_caps(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
@@ -1272,6 +1278,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 
 	ufs_qcom_set_caps(hba);
 	ufs_qcom_advertise_quirks(hba);
+	ufs_qcom_set_host_params(hba);
 
 	err = ufs_qcom_ice_init(host);
 	if (err)
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 82cd143..11419eb 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -238,6 +238,7 @@ struct ufs_qcom_host {
 
 	struct gpio_desc *device_reset;
 
+	struct ufs_host_params host_params;
 	u32 phy_gear;
 
 	bool esi_enabled;
-- 
2.7.4

