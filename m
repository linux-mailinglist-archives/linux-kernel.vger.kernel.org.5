Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFA57E34A1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 05:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjKGErH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 23:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjKGErD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 23:47:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A717B109;
        Mon,  6 Nov 2023 20:47:00 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A70dta6006795;
        Tue, 7 Nov 2023 04:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=ls7XUG+4mcdoSFOAOcUnheq/gfQ6edrpen1JlEWng30=;
 b=DfAxFPA+I8Udc4R7PgVA/rcURhMcADIL71SKYz43HjOfHhjYQ5SRV8hzX3D/+cKT1Aib
 HDm8mceDLtWRo1GKdpggWsTAiqxYv03PgSWqb5t3VW/iw7IurnVUGw6lilorkbqOYvku
 Z74i8COwo6qpKLuSRveOfYZHr6w2TZNNQDyc2wwz5CDffpgDgJSF15SUwEJu85JkqUJK
 N9risxMg76VC51fkv+JhRm1zqiY61FBO6mzwZ8eWpklPfeHH7BdBy94vlktaHYDzhBe7
 upBtbHlu5/UBGw5zyJRee+DSwXgEOf7PN39sK1TIIfddCfb6sadQrvk4T5qmxBxGr5NV kg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u72c01mtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 04:46:45 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A74JEVn003932;
        Tue, 7 Nov 2023 04:46:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3u73v7ndq1-1;
        Tue, 07 Nov 2023 04:46:44 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A74hUvt007207;
        Tue, 7 Nov 2023 04:46:43 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3A74khTx013006;
        Tue, 07 Nov 2023 04:46:43 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id 76EAC20A78; Mon,  6 Nov 2023 20:46:43 -0800 (PST)
From:   Can Guo <cang@qti.qualcomm.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/7] scsi: ufs: ufs-qcom: Setup host power mode during init
Date:   Mon,  6 Nov 2023 20:46:08 -0800
Message-Id: <1699332374-9324-3-git-send-email-cang@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eSfxC2Vl-TQbfp9qSDP0VN37bcoOSaIC
X-Proofpoint-GUID: eSfxC2Vl-TQbfp9qSDP0VN37bcoOSaIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2311070038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <quic_cang@quicinc.com>

Setup host power mode and its limitations during UFS host driver init to
avoid repetitive work during every power mode change.

Co-developed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 22 ++++++++++++++--------
 drivers/ufs/host/ufs-qcom.h |  1 +
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index aee66a3..cc0eb37 100644
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
@@ -908,13 +908,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 
 	switch (status) {
 	case PRE_CHANGE:
-		ufshcd_init_host_param(&host_params);
-		host_params.hs_rate = UFS_QCOM_LIMIT_HS_RATE;
-
-		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
-		host_params.hs_tx_gear = host_params.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
-
-		ret = ufshcd_negotiate_pwr_param(&host_params, dev_max_params, dev_req_params);
+		ret = ufshcd_negotiate_pwr_param(host_params, dev_max_params, dev_req_params);
 		if (ret) {
 			dev_err(hba->dev, "%s: failed to determine capabilities\n",
 					__func__);
@@ -1049,6 +1043,17 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
 		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
 }
 
+static void ufs_qcom_set_host_params(struct ufs_hba *hba)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct ufs_host_params *host_params = &host->host_params;
+
+	ufshcd_init_host_param(host_params);
+
+	/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
+	host_params->hs_tx_gear = host_params->hs_rx_gear = ufs_qcom_get_hs_gear(hba);
+}
+
 static void ufs_qcom_set_caps(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
@@ -1273,6 +1278,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 
 	ufs_qcom_set_caps(hba);
 	ufs_qcom_advertise_quirks(hba);
+	ufs_qcom_set_host_params(hba);
 
 	err = ufs_qcom_ice_init(host);
 	if (err)
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 9950a00..ab94c54 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -240,6 +240,7 @@ struct ufs_qcom_host {
 
 	struct gpio_desc *device_reset;
 
+	struct ufs_host_params host_params;
 	u32 phy_gear;
 
 	bool esi_enabled;
-- 
2.7.4

