Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C747785C60
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbjHWPof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjHWPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:44:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BF5E52;
        Wed, 23 Aug 2023 08:44:27 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NEOjse016761;
        Wed, 23 Aug 2023 15:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=bRIiq0n5rhbezgTWe8eISoJxz7rHZaxNROqS2Sq7myo=;
 b=LPuVgQj8HOq1JTGRsy6d3RB6ilfz2L07aPnii8kGLUELI6LClotZfJRQg18SZ8jxfr2y
 2Bfy6htrQwwXVwlnBCuFnDcIXFekpFK1QSda+vXsSL1snqSOY0ynD2Y7e+J4hom2+AmX
 1wwHZXULDdeay8CW9y3w7cC0brv2JHNmgAXfv7xQPhZnFdNNvBsxHwidsuCaUGzHKWNB
 3NX+IcFDbChzSwv+Z6Cvzbs17x9aP8bUSoyMQQLKOGw9/CdO1lqcU9UBOY7ioSkQzALe
 W8rpiDKngHzbl2IPKT8Cr7xDTdwjiLZXWk+rAtS2PIIF70HYVBvP8o6unXOsBr2OPFMA XQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snkumr7q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 15:44:20 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37NFiGgW029192;
        Wed, 23 Aug 2023 15:44:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sjptm3qdx-1;
        Wed, 23 Aug 2023 15:44:17 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37NFiHTr029212;
        Wed, 23 Aug 2023 15:44:17 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37NFiHDZ029207;
        Wed, 23 Aug 2023 15:44:17 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id B1D395000AA; Wed, 23 Aug 2023 21:14:16 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V5 3/6] scsi: ufs: qcom: Add multiple frequency support for unipro clk attributes
Date:   Wed, 23 Aug 2023 21:14:10 +0530
Message-Id: <20230823154413.23788-4-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 31zQ8KvvHaMF-48sso1a5lxFw0GbqHdH
X-Proofpoint-ORIG-GUID: 31zQ8KvvHaMF-48sso1a5lxFw0GbqHdH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230142
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Support to configure CORE_CLK_1US_CYCLES, PA_VS_CORE_CLK_40NS_CYCLES
for multiple unipro clock frequencies. Currently this is handled only for
only 150Mhz and 75MHz.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 88 ++++++++++++++++++++++++++++++++-----
 drivers/ufs/host/ufs-qcom.h |  9 ++++
 2 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index abc0e7f7d1b0..8162b19191a9 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -671,6 +671,45 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 	return 0;
 }

+static int ufs_qcom_cfg_core_clk_ctrl(struct ufs_hba *hba)
+{
+	struct list_head *head = &hba->clk_list_head;
+	struct ufs_clk_info *clki;
+	u32 max_freq = 0;
+	int err;
+
+	list_for_each_entry(clki, head, list) {
+		if (!IS_ERR_OR_NULL(clki->clk) &&
+			!strcmp(clki->name, "core_clk_unipro")) {
+			max_freq = clki->max_freq;
+			break;
+		}
+	}
+
+	switch (max_freq) {
+	case MHZ_403:
+		err = ufs_qcom_set_core_clk_ctrl(hba, 403, 16);
+		break;
+	case MHZ_300:
+		err = ufs_qcom_set_core_clk_ctrl(hba, 300, 12);
+		break;
+	case MHZ_201_5:
+		err = ufs_qcom_set_core_clk_ctrl(hba, 202, 8);
+		break;
+	case MHZ_150:
+		err = ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
+		break;
+	case MHZ_100:
+		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4);
+		break;
+	default:
+		dev_err(hba->dev, "unipro max_freq=%u entry missing\n", max_freq);
+		err = -EINVAL;
+		break;
+	}
+
+	return err;
+}
 static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 					enum ufs_notify_change_status status)
 {
@@ -686,12 +725,15 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 			return -EINVAL;
 		}

-		if (ufs_qcom_cap_qunipro(host))
-			/*
-			 * set unipro core clock cycles to 150 & clear clock
-			 * divider
-			 */
-			err = ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
+		if (ufs_qcom_cap_qunipro(host)) {
+			err = ufs_qcom_cfg_core_clk_ctrl(hba);
+			if (err) {
+				dev_err(hba->dev,
+					"%s cfg core clk ctrl failed\n",
+					__func__);
+				return err;
+			}
+		}

 		/*
 		 * Some UFS devices (and may be host) have issues if LCC is
@@ -1369,8 +1411,7 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
 	if (!ufs_qcom_cap_qunipro(host))
 		return 0;

-	/* set unipro core clock cycles to 150 and clear clock divider */
-	return ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
+	return ufs_qcom_cfg_core_clk_ctrl(hba);
 }

 static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
@@ -1401,12 +1442,39 @@ static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
 static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct list_head *head = &hba->clk_list_head;
+	struct ufs_clk_info *clki;
+	u32 curr_freq = 0;
+	int err;

 	if (!ufs_qcom_cap_qunipro(host))
 		return 0;

-	/* set unipro core clock cycles to 75 and clear clock divider */
-	return ufs_qcom_set_core_clk_ctrl(hba, 75, 3);
+
+	list_for_each_entry(clki, head, list) {
+		if (!IS_ERR_OR_NULL(clki->clk) &&
+			!strcmp(clki->name, "core_clk_unipro")) {
+			curr_freq = clk_get_rate(clki->clk);
+			break;
+		}
+	}
+	switch (curr_freq) {
+	case MHZ_37_5:
+		err = ufs_qcom_set_core_clk_ctrl(hba, 38, 2);
+		break;
+	case MHZ_75:
+		err = ufs_qcom_set_core_clk_ctrl(hba, 75, 3);
+		break;
+	case MHZ_100:
+		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4);
+		break;
+	default:
+		err = -EINVAL;
+		dev_err(hba->dev, "unipro curr_freq=%u entry missing\n", curr_freq);
+		break;
+	}
+
+	return err;
 }

 static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 325f08aca260..56550fd36c4e 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -79,6 +79,15 @@ enum {
 	UFS_MEM_CQIS_VS		= 0x8,
 };

+/* QCOM UFS host controller core clk frequencies */
+#define MHZ_37_5	37500000
+#define MHZ_50		50000000
+#define MHZ_75		75000000
+#define MHZ_100		100000000
+#define MHZ_150		150000000
+#define MHZ_300		300000000
+#define MHZ_201_5	201500000
+#define MHZ_403		403000000
 #define UFS_CNTLR_2_x_x_VEN_REGS_OFFSET(x)	(0x000 + x)
 #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)

--
2.17.1

