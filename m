Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF8978FC91
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349297AbjIALpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245244AbjIALor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:44:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7687C10FD;
        Fri,  1 Sep 2023 04:44:07 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381AqrUq022666;
        Fri, 1 Sep 2023 11:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=zOm8nndxYACZ2nRUgyy3rFPtQ/tGgW11wwbgkBluXvc=;
 b=LnPnl/mo7m/QXmC2wgW9T5ztOgV3CtkhhxBGI+iGcVyayjcTjzW5QJjGwlb9UOfP4vzL
 gW7o/h0YHNXcFw/MdP3mrv/g+JwbmdLX1Zrj/bNS7yy5NlcqSfm3YMOk9EyqeoZSmcBN
 LATBHCgQoob3A23FB0q1JfKNYLZ4xGrpvzyGDzShUc8YEjVSNwonoOHwd+TLcorglRy1
 Xccw+S9mw3lg6sy95xl/FsYHoaUTiScbs5rvsO7cYLKVc4PqmNGM9NfNUEeUu9mD8bPW
 capQyP2wWRF9Cz89ALju/M/SraB7BpykOPdUN8i0HV8xvLRt4E1qYlqzU7mkZzuHARLn 4g== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stxru25fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 11:43:46 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 381BhglN014728;
        Fri, 1 Sep 2023 11:43:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sqafmj08k-1;
        Fri, 01 Sep 2023 11:43:42 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381Bhgfq014721;
        Fri, 1 Sep 2023 11:43:42 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 381BhgJT014709;
        Fri, 01 Sep 2023 11:43:42 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id E3E045006A6; Fri,  1 Sep 2023 17:13:41 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V6 5/6] scsi: ufs: qcom: Refactor ufs_qcom_cfg_timers function.
Date:   Fri,  1 Sep 2023 17:13:35 +0530
Message-Id: <20230901114336.31339-6-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
References: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ckI4dNDPUJs8nWskPTaISYN_o8hjBdPd
X-Proofpoint-ORIG-GUID: ckI4dNDPUJs8nWskPTaISYN_o8hjBdPd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_09,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010109
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a)Configure SYS1CLK_1US_REG for clock scaleup pre ops.
b)Move ufs_qcom_cfg_timers from clk scaling post change ops
to clk scaling pre change ops to align with the HPG.
c)Introduce a new argument is_pre_scale_up for ufs_qcom_cfg_timers
to configure sys_1us timer for max freq as per HPG.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 63 +++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index d670fcc27ffb..c251c98a74f0 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -532,7 +532,8 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
  * Return: zero for success and non-zero in case of a failure.
  */
 static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
-			       u32 hs, u32 rate, bool update_link_startup_timer)
+				 u32 hs, u32 rate, bool link_startup,
+				 bool is_pre_scale_up)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct ufs_clk_info *clki;
@@ -563,11 +564,16 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 	/*
 	 * The Qunipro controller does not use following registers:
 	 * SYS1CLK_1US_REG, TX_SYMBOL_CLK_1US_REG, CLK_NS_REG &
-	 * UFS_REG_PA_LINK_STARTUP_TIMER
-	 * But UTP controller uses SYS1CLK_1US_REG register for Interrupt
-	 * Aggregation logic.
-	*/
-	if (ufs_qcom_cap_qunipro(host) && !ufshcd_is_intr_aggr_allowed(hba))
+	 * UFS_REG_PA_LINK_STARTUP_TIMER.
+	 * However UTP controller uses SYS1CLK_1US_REG register for Interrupt
+	 * Aggregation logic and Auto hibern8 logic.
+	 * It is mandatory to write SYS1CLK_1US_REG register on UFS host
+	 * controller V4.0.0 onwards.
+	 */
+	if (ufs_qcom_cap_qunipro(host) &&
+	    !(ufshcd_is_intr_aggr_allowed(hba) ||
+	    ufshcd_is_auto_hibern8_supported(hba) ||
+	    host->hw_ver.major >= 4))
 		return 0;

 	if (gear == 0) {
@@ -576,8 +582,14 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 	}

 	list_for_each_entry(clki, &hba->clk_list_head, list) {
-		if (!strcmp(clki->name, "core_clk"))
-			core_clk_rate = clk_get_rate(clki->clk);
+		if (!strcmp(clki->name, "core_clk")) {
+			if (is_pre_scale_up)
+				core_clk_rate = clki->max_freq;
+			else
+				core_clk_rate = clk_get_rate(clki->clk);
+			break;
+		}
+
 	}

 	/* If frequency is smaller than 1MHz, set to 1MHz */
@@ -657,7 +669,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 		mb();
 	}

-	if (update_link_startup_timer && host->hw_ver.major != 0x5) {
+	if (link_startup && host->hw_ver.major != 0x5) {
 		ufshcd_writel(hba, ((core_clk_rate / MSEC_PER_SEC) * 100),
 			      REG_UFS_CFG0);
 		/*
@@ -679,7 +691,7 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 	switch (status) {
 	case PRE_CHANGE:
 		if (ufs_qcom_cfg_timers(hba, UFS_PWM_G1, SLOWAUTO_MODE,
-					0, true)) {
+					0, true, false)) {
 			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
 				__func__);
 			return -EINVAL;
@@ -927,7 +939,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 	case POST_CHANGE:
 		if (ufs_qcom_cfg_timers(hba, dev_req_params->gear_rx,
 					dev_req_params->pwr_rx,
-					dev_req_params->hs_rate, false)) {
+					dev_req_params->hs_rate, false, false)) {
 			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
 				__func__);
 			/*
@@ -1412,10 +1424,22 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
 static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct ufs_pa_layer_attr *attr = &host->dev_req_params;
+	int ret;

 	if (!ufs_qcom_cap_qunipro(host))
 		return 0;

+	if (attr) {
+		ret = ufs_qcom_cfg_timers(hba, attr->gear_rx,
+					attr->pwr_rx, attr->hs_rate,
+					false, true);
+		if (ret) {
+			dev_err(hba->dev, "%s ufs cfg timer failed\n",
+						__func__);
+			return ret;
+		}
+	}
 	return ufs_qcom_set_core_clk_ctrl(hba, true);
 }

@@ -1452,10 +1476,21 @@ static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
 static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct ufs_pa_layer_attr *attr = &host->dev_req_params;
+	int ret;

 	if (!ufs_qcom_cap_qunipro(host))
 		return 0;

+	if (attr) {
+		ret = ufs_qcom_cfg_timers(hba, attr->gear_rx, attr->pwr_rx,
+					attr->hs_rate, false, false);
+		if (ret) {
+			dev_err(hba->dev, "%s ufs cfg timer failed\n",
+					__func__);
+			return ret;
+		}
+	}
 	return ufs_qcom_set_core_clk_ctrl(hba, false);
 }

@@ -1463,7 +1498,6 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 		bool scale_up, enum ufs_notify_change_status status)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	struct ufs_pa_layer_attr *dev_req_params = &host->dev_req_params;
 	int err = 0;

 	/* check the host controller state before sending hibern8 cmd */
@@ -1493,11 +1527,6 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 			return err;
 		}

-		ufs_qcom_cfg_timers(hba,
-				    dev_req_params->gear_rx,
-				    dev_req_params->pwr_rx,
-				    dev_req_params->hs_rate,
-				    false);
 		ufs_qcom_icc_update_bw(host);
 		ufshcd_uic_hibern8_exit(hba);
 	}
--
2.17.1

