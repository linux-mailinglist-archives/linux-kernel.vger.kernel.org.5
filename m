Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA82791A7F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjIDPWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjIDPWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:22:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC101993;
        Mon,  4 Sep 2023 08:21:39 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384ELLWt008554;
        Mon, 4 Sep 2023 15:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=aTn9E5GgcFMM6Ytd+TxIz5tcKKpOGiM3fyZwhZgomAs=;
 b=btb4YjWGwrSytMok9s+BrRkafzVW0a+Ms42CTV3ckITP5jgwJol0B9eBQR0qOAThVVgV
 haa+xUlsm3gl9bwkYix22uQaaAkYk93+F3xGE5lrsHqcrZOxsfzeM+D9oB0Fp4Nsr8z4
 82H0Ci8k4pZTXCnfzZtjy+o5GfdVXHde2hNYs0oWMK6/nYym7gvfMsG9YQryU5MEvS47
 DlppwJGmmeRRlJS0sJQfVijw+CPkqfDUuJYqOLuHuc41FFGX/y2inpwGk03206JX3PiP
 cu82q+wd++4yu28T8LtibaMXU8PQYBMtE8Rj/k4GrFzhuYC8lZqiXNkbrRxFkvOhMXb8 Ww== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swfae0d6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 15:21:09 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 384FL6ds023859;
        Mon, 4 Sep 2023 15:21:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4k8yqh-1;
        Mon, 04 Sep 2023 15:21:06 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 384FL6VC023852;
        Mon, 4 Sep 2023 15:21:06 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 384FL6q8023851;
        Mon, 04 Sep 2023 15:21:06 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 2704D504920; Mon,  4 Sep 2023 20:51:05 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V7 2/5] scsi: ufs: qcom: Add multiple frequency support for MAX_CORE_CLK_1US_CYCLES
Date:   Mon,  4 Sep 2023 20:50:57 +0530
Message-Id: <20230904152100.30404-3-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230904152100.30404-1-quic_nitirawa@quicinc.com>
References: <20230904152100.30404-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cW3HtVmyQYjPBBJWjr9K28pFN0a9hc_-
X-Proofpoint-ORIG-GUID: cW3HtVmyQYjPBBJWjr9K28pFN0a9hc_-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_08,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040137
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm UFS Controller V4 and above supports multiple unipro frequencies
like 403MHz, 300MHz, 202MHz, 150 MHz, 75Mhz, 37.5 MHz. Current code
supports only 150MHz and 75MHz which have performance impact due to low
UFS controller frequencies.

For targets which supports frequencies other than 150 MHz and 75 Mhz,
needs an update of MAX_CORE_CLK_1US_CYCLES to match the configured
frequency to avoid functionality issues. Add multiple frequency support
for MAX_CORE_CLK_1US_CYCLES based on the frequency configured.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 51 ++++++++++++++++++++++---------------
 drivers/ufs/host/ufs-qcom.h |  1 +
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index d846e68a5734..b2be9ff272a4 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -93,8 +93,7 @@ static const struct __ufs_qcom_bw_table {
 static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];

 static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
-static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
-						       u32 clk_cycles);
+static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up);

 static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
 {
@@ -685,14 +684,11 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 			return -EINVAL;
 		}

-		if (ufs_qcom_cap_qunipro(host))
-			/*
-			 * set unipro core clock cycles to 150 & clear clock
-			 * divider
-			 */
-			err = ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba,
-									  150);
-
+		if (ufs_qcom_cap_qunipro(host)) {
+			err = ufs_qcom_set_core_clk_ctrl(hba, true);
+			if (err)
+				dev_err(hba->dev, "cfg core clk ctrl failed\n");
+		}
 		/*
 		 * Some UFS devices (and may be host) have issues if LCC is
 		 * enabled. So we are setting PA_Local_TX_LCC_Enable to 0
@@ -1296,12 +1292,25 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
 	phy_exit(host->generic_phy);
 }

-static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
-						       u32 clk_cycles)
+static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	int err;
+	struct list_head *head = &hba->clk_list_head;
+	struct ufs_clk_info *clki;
+	u32 cycles_in_1us;
 	u32 core_clk_ctrl_reg;
+	int err;
+
+	list_for_each_entry(clki, head, list) {
+		if (!IS_ERR_OR_NULL(clki->clk) &&
+			!strcmp(clki->name, "core_clk_unipro")) {
+			if (is_scale_up)
+				cycles_in_1us = ceil(clki->max_freq, (1000 * 1000));
+			else
+				cycles_in_1us = ceil(clk_get_rate(clki->clk), (1000 * 1000));
+			break;
+		}
+	}

 	err = ufshcd_dme_get(hba,
 			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
@@ -1311,15 +1320,15 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,

 	/* Bit mask is different for UFS host controller V4.0.0 onwards */
 	if (host->hw_ver.major >= 4) {
-		if (!FIELD_FIT(CLK_1US_CYCLES_MASK_V4, clk_cycles))
+		if (!FIELD_FIT(CLK_1US_CYCLES_MASK_V4, cycles_in_1us))
 			return -ERANGE;
 		core_clk_ctrl_reg &= ~CLK_1US_CYCLES_MASK_V4;
-		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK_V4, clk_cycles);
+		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK_V4, cycles_in_1us);
 	} else {
-		if (!FIELD_FIT(CLK_1US_CYCLES_MASK, clk_cycles))
+		if (!FIELD_FIT(CLK_1US_CYCLES_MASK, cycles_in_1us))
 			return -ERANGE;
 		core_clk_ctrl_reg &= ~CLK_1US_CYCLES_MASK;
-		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK, clk_cycles);
+		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK, cycles_in_1us);
 	}

 	/* Clear CORE_CLK_DIV_EN */
@@ -1343,8 +1352,8 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
 	if (!ufs_qcom_cap_qunipro(host))
 		return 0;

-	/* set unipro core clock cycles to 150 and clear clock divider */
-	return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 150);
+	/* set unipro core clock attributes and clear clock divider */
+	return ufs_qcom_set_core_clk_ctrl(hba, true);
 }

 static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
@@ -1379,8 +1388,8 @@ static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
 	if (!ufs_qcom_cap_qunipro(host))
 		return 0;

-	/* set unipro core clock cycles to 75 and clear clock divider */
-	return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 75);
+	/* set unipro core clock attributes and clear clock divider */
+	return ufs_qcom_set_core_clk_ctrl(hba, false);
 }

 static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 8a9d3dbec297..3c6ef1259af3 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -245,6 +245,7 @@ ufs_qcom_get_debug_reg_offset(struct ufs_qcom_host *host, u32 reg)
 #define ufs_qcom_is_link_off(hba) ufshcd_is_link_off(hba)
 #define ufs_qcom_is_link_active(hba) ufshcd_is_link_active(hba)
 #define ufs_qcom_is_link_hibern8(hba) ufshcd_is_link_hibern8(hba)
+#define ceil(freq, div) ((freq) % (div) == 0 ? ((freq)/(div)) : ((freq)/(div) + 1))

 int ufs_qcom_testbus_config(struct ufs_qcom_host *host);

--
2.17.1

