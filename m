Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D84791A82
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353228AbjIDPWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350954AbjIDPWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:22:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D26F10D2;
        Mon,  4 Sep 2023 08:21:47 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384ELKad002752;
        Mon, 4 Sep 2023 15:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=yUPH/1UBUaZN9bbJwTz5ZzMaIwqc4zDOhDEB0WXktYg=;
 b=eiQKJUXt/6nwuMCGDvPbM+NqWp+KmnQik3j/vP12+MgPLYCgiMkLMI1dOCisb0R+djtJ
 8w+55dvlaKrwQ+NsjlCv2FoJrqL4xDkU7/+ov/+V+GMjwRaxHH+dwdkiaseQiSEkrE0r
 DaU5zxmYbvc0/UADih7nnZZWKjUylmja9z/SPCeNqwISAACAvAcjiUtFo22T+RlsO4sw
 v0xO9zuc63wGVSLr1JhTkcVJCN5+SZY86yS2HV1UdlmEU+1QAKlyNqmqnnWUZi0Ojary
 wFYoZeCa8xf8/qFnR9whoJscJ9lPNzcAw7u2nzIGDFlhawNxeAnvB7g8HfWdbznh5fCH Zw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suw99c6xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 15:21:14 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 384FL8bT023882;
        Mon, 4 Sep 2023 15:21:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4k8yr5-1;
        Mon, 04 Sep 2023 15:21:11 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 384FLA7F023951;
        Mon, 4 Sep 2023 15:21:10 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 384FLAlT023948;
        Mon, 04 Sep 2023 15:21:10 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id AC32D504920; Mon,  4 Sep 2023 20:51:09 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V7 5/5] scsi: ufs: qcom: Configure SYS1CLK_1US_REG for UFS V4 and above
Date:   Mon,  4 Sep 2023 20:51:00 +0530
Message-Id: <20230904152100.30404-6-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230904152100.30404-1-quic_nitirawa@quicinc.com>
References: <20230904152100.30404-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q0-BMvFHb0eRX4gjjvLUIaF2k6CzL0Om
X-Proofpoint-ORIG-GUID: Q0-BMvFHb0eRX4gjjvLUIaF2k6CzL0Om
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_08,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309040137
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SYS1CLK_1US represents the required number of system 1-clock cycles for
one microsecond. UFS Host Controller V4.0 and above mandates to write
SYS1CLK_1US_REG register and also these timer configuration needs to be
called from clk scaling pre ops as per HPG.

Refactor ufs_qcom_cfg_timers and add the below code support to align
with HPG.

a)Configure SYS1CLK_1US_REG for UFS V4 and above.
b)Introduce a new argument is_pre_scale_up for ufs_qcom_cfg_timers
to configure SYS1CLK_1US for max freq during prescale and link startup
condition.
c)Move ufs_qcom_cfg_timers from clk scaling post change ops
to clk scaling pre change ops.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 55 ++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index d437c75c8e14..19cbf0c5fbea 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -527,11 +527,19 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
 	return err;
 }

-/*
+/**
+ * ufs_qcom_cfg_timers - Configure ufs qcom cfg timers
+ *
+ * @hba: host controller instance
+ * @hs: current power mode
+ * @rate: current rate
+ * @update_link_startup_timer indicate if link_start in progress
+ * @is_pre_scale_up: flag to check if pre scale up condition.
  * Return: zero for success and non-zero in case of a failure.
  */
 static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
-			       u32 hs, u32 rate, bool update_link_startup_timer)
+			       u32 hs, u32 rate, bool update_link_startup_timer,
+			       bool is_pre_scale_up)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct ufs_clk_info *clki;
@@ -562,11 +570,14 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 	/*
 	 * The Qunipro controller does not use following registers:
 	 * SYS1CLK_1US_REG, TX_SYMBOL_CLK_1US_REG, CLK_NS_REG &
-	 * UFS_REG_PA_LINK_STARTUP_TIMER
-	 * But UTP controller uses SYS1CLK_1US_REG register for Interrupt
+	 * UFS_REG_PA_LINK_STARTUP_TIMER.
+	 * However UTP controller uses SYS1CLK_1US_REG register for Interrupt
 	 * Aggregation logic.
-	*/
-	if (ufs_qcom_cap_qunipro(host) && !ufshcd_is_intr_aggr_allowed(hba))
+	 * It is mandatory to write SYS1CLK_1US_REG register on UFS host
+	 * controller V4.0.0 onwards.
+	 */
+	if (host->hw_ver.major < 4 && ufs_qcom_cap_qunipro(host) &&
+	    !ufshcd_is_intr_aggr_allowed(hba))
 		return 0;

 	if (gear == 0) {
@@ -575,8 +586,14 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
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
@@ -678,7 +695,7 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 	switch (status) {
 	case PRE_CHANGE:
 		if (ufs_qcom_cfg_timers(hba, UFS_PWM_G1, SLOWAUTO_MODE,
-					0, true)) {
+					0, true, false)) {
 			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
 				__func__);
 			return -EINVAL;
@@ -922,7 +939,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 	case POST_CHANGE:
 		if (ufs_qcom_cfg_timers(hba, dev_req_params->gear_rx,
 					dev_req_params->pwr_rx,
-					dev_req_params->hs_rate, false)) {
+					dev_req_params->hs_rate, false, false)) {
 			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
 				__func__);
 			/*
@@ -1418,10 +1435,22 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up)
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
 	/* set unipro core clock attributes and clear clock divider */
 	return ufs_qcom_set_core_clk_ctrl(hba, true);
 }
@@ -1471,7 +1500,6 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 		bool scale_up, enum ufs_notify_change_status status)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	struct ufs_pa_layer_attr *dev_req_params = &host->dev_req_params;
 	int err = 0;

 	/* check the host controller state before sending hibern8 cmd */
@@ -1501,11 +1529,6 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
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

