Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C51785C61
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbjHWPop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbjHWPod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:44:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A18E52;
        Wed, 23 Aug 2023 08:44:31 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NEHeJ6013972;
        Wed, 23 Aug 2023 15:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=mxLnWqg8kkjXmafled9O2djMlAf1ASq5PIxHzOV6VpI=;
 b=mRkfkGVQX7mXEYURLEg5LFMksxzQP9Ce3gWpLQoWYcVPA1FCPmZZ5F+Z/6f9Wgq2KumU
 NXyKZyXBbH1IkKoasCaCcAZO2n128ahrdcORMuna8B1PUxHUTZmQ0w1UGpVPcLTbx7a5
 Mv0AAWGBJ8Wo4oDSt0LVDJ3OuysLrzzB2bx/BPXFFcrLNbEiLxD1t5zYLioMlxCTFDM8
 xGK/WP171bA/OmP4dEz/rk54MaYWSS9dL5OwdrlPcVBB2B/ZgL55oRjDdDh07jMWGW5+
 08CvX7DdHPpALBf7Wwim7YKuekk8sXcXFH/9hjaZzPzR90TDnjtIsQXuNE7v5PYkO4cI Ag== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2ext9nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 15:44:24 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37NFiHdM029208;
        Wed, 23 Aug 2023 15:44:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sjptm3qef-1;
        Wed, 23 Aug 2023 15:44:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37NFiL3C029260;
        Wed, 23 Aug 2023 15:44:21 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37NFiL7t029258;
        Wed, 23 Aug 2023 15:44:21 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id D4C815000AB; Wed, 23 Aug 2023 21:14:20 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V5 6/6] scsi: ufs: qcom: Handle unipro clk HW division based on scaling conditions.
Date:   Wed, 23 Aug 2023 21:14:13 +0530
Message-Id: <20230823154413.23788-7-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kirj_zTWA4LwA0501zrxRg7O_SwvA2bC
X-Proofpoint-ORIG-GUID: Kirj_zTWA4LwA0501zrxRg7O_SwvA2bC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230142
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure internal HW division of unipro core_clk based on scale up and
scale down condition. This bit should be cleared before entering any
SVS mode as per hardware specification.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 49 ++++++++++++++++++++-----------------
 drivers/ufs/host/ufs-qcom.h |  2 +-
 2 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 82cf3ac4193a..d886e28b8a2a 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -95,7 +95,8 @@ static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
 static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
 static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
 					u32 clk_cycles,
-					u32 clk_40ns_cycles);
+					u32 clk_40ns_cycles,
+					bool scale_up);

 static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
 {
@@ -700,19 +701,19 @@ static int ufs_qcom_cfg_core_clk_ctrl(struct ufs_hba *hba)

 	switch (max_freq) {
 	case MHZ_403:
-		err = ufs_qcom_set_core_clk_ctrl(hba, 403, 16);
+		err = ufs_qcom_set_core_clk_ctrl(hba, 403, 16, true);
 		break;
 	case MHZ_300:
-		err = ufs_qcom_set_core_clk_ctrl(hba, 300, 12);
+		err = ufs_qcom_set_core_clk_ctrl(hba, 300, 12, true);
 		break;
 	case MHZ_201_5:
-		err = ufs_qcom_set_core_clk_ctrl(hba, 202, 8);
+		err = ufs_qcom_set_core_clk_ctrl(hba, 202, 8, true);
 		break;
 	case MHZ_150:
-		err = ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
+		err = ufs_qcom_set_core_clk_ctrl(hba, 150, 6, true);
 		break;
 	case MHZ_100:
-		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4);
+		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4, true);
 		break;
 	default:
 		dev_err(hba->dev, "unipro max_freq=%u entry missing\n", max_freq);
@@ -1352,7 +1353,8 @@ static void ufs_qcom_exit(struct ufs_hba *hba)

 static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
 					u32 clk_1us_cycles,
-					u32 clk_40ns_cycles)
+					u32 clk_40ns_cycles,
+					bool scale_up)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	u32 mask = DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
@@ -1378,18 +1380,20 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
 	core_clk_ctrl_reg &= ~(mask << offset);
 	core_clk_ctrl_reg |= clk_1us_cycles << offset;

-	/* Clear CORE_CLK_DIV_EN */
-	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
+	if (scale_up)
+		core_clk_ctrl_reg |= CORE_CLK_DIV_EN_BIT;

 	err = ufshcd_dme_set(hba,
-			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
-			    core_clk_ctrl_reg);
+			     UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
+			     core_clk_ctrl_reg);
+	if (err)
+		return err;
 	/*
 	 * UFS host controller V4.0.0 onwards needs to program
 	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
 	 * frequency of unipro core clk of UFS host controller.
 	 */
-	if (!err && (host->hw_ver.major >= 4)) {
+	if (host->hw_ver.major >= 4) {
 		if (clk_40ns_cycles > PA_VS_CORE_CLK_40NS_CYCLES_MASK)
 			return -EINVAL;

@@ -1442,22 +1446,21 @@ static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	int err;
-	u32 core_clk_ctrl_reg;
+	u32 reg;

 	if (!ufs_qcom_cap_qunipro(host))
 		return 0;

-	err = ufshcd_dme_get(hba,
-			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
-			    &core_clk_ctrl_reg);
+	err = ufshcd_dme_get(hba, UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL), &reg);
+	if (err)
+		return err;

 	/* make sure CORE_CLK_DIV_EN is cleared */
-	if (!err &&
-	    (core_clk_ctrl_reg & DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT)) {
-		core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
+	if (reg & CORE_CLK_DIV_EN_BIT) {
+		reg &= ~CORE_CLK_DIV_EN_BIT;
 		err = ufshcd_dme_set(hba,
 				    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
-				    core_clk_ctrl_reg);
+				    reg);
 	}

 	return err;
@@ -1488,13 +1491,13 @@ static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
 	}
 	switch (curr_freq) {
 	case MHZ_37_5:
-		err = ufs_qcom_set_core_clk_ctrl(hba, 38, 2);
+		err = ufs_qcom_set_core_clk_ctrl(hba, 38, 2, false);
 		break;
 	case MHZ_75:
-		err = ufs_qcom_set_core_clk_ctrl(hba, 75, 3);
+		err = ufs_qcom_set_core_clk_ctrl(hba, 75, 3, false);
 		break;
 	case MHZ_100:
-		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4);
+		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4, false);
 		break;
 	default:
 		err = -EINVAL;
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 56550fd36c4e..6e8eb4bb9247 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -140,7 +140,7 @@ enum {
 /* bit and mask definitions for DME_VS_CORE_CLK_CTRL attribute */
 #define MAX_CORE_CLK_1US_CYCLES_MASK_V4		0xFFF
 #define MAX_CORE_CLK_1US_CYCLES_OFFSET_V4	0x10
-#define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT		BIT(8)
+#define CORE_CLK_DIV_EN_BIT			BIT(8)
 #define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	0xFF
 #define PA_VS_CORE_CLK_40NS_CYCLES	0x9007
 #define PA_VS_CORE_CLK_40NS_CYCLES_MASK	0x3F
--
2.17.1

