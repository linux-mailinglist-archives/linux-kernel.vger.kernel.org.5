Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459EA810EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377729AbjLMKnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377846AbjLMKnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:43:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B8D184;
        Wed, 13 Dec 2023 02:43:15 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BD5EeZP029544;
        Wed, 13 Dec 2023 10:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=qcppdkim1; bh=+TN0ljMfLRth44+5DTi1
        eFCdNhb6JxQCcPbTaVwnhr4=; b=dLVx7YlGl5QVo7rtlgOHYaMHxinE7gNwAMtw
        6AY1hGby5M+EKJCDbaQDi3HbdNFheq66dzbsOxIsGu4QdzziHBIZZ8ho3ncKXxyE
        INFwGtingQjVM3QUKkQvUmAsE2m+sUtoe1ZOWsV5jYLOBw3IRXfCWDapRXvVfT0E
        Rbi8e2q04FXsfJ+zuQD0xVWtW1rESMt9MWq7YTb6gwkVWUkln2ukDN+bV9cGQh18
        BFs7RFeLJiP+FxafZhaRq9uOvpsv7+oAVjBXBf3mlUwxElVAaDsp1AyB/G51Po8N
        YZMLVVc/hlr4X7+hjHVe9cVQUNDH9mzUGLidooVnCSJqkAFVCg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uy5x4rsmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 10:37:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BDAbsVB032597
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 10:37:54 GMT
Received: from hu-mnaresh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 02:37:49 -0800
From:   Maramaina Naresh <quic_mnaresh@quicinc.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <stanley.chu@mediatek.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Jhu <chu.stanley@gmail.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>
Subject: [PATCH V4 2/2] ufs: ufs-mediatek: Enable CPU latency PM QoS support for MEDIATEK SoC
Date:   Wed, 13 Dec 2023 16:06:42 +0530
Message-ID: <20231213103642.15320-3-quic_mnaresh@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213103642.15320-1-quic_mnaresh@quicinc.com>
References: <20231213103642.15320-1-quic_mnaresh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kjb55LPIzQs-e-AU51JEIa3-ITgm4r2f
X-Proofpoint-ORIG-GUID: Kjb55LPIzQs-e-AU51JEIa3-ITgm4r2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312130077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert the existing PM QoS feature from MEDIATEK UFS driver as similar
PM QoS feature implementation is moved to core ufshcd.

Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
---
 drivers/ufs/host/ufs-mediatek.c | 17 -----------------
 drivers/ufs/host/ufs-mediatek.h |  3 ---
 2 files changed, 20 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index fc61790d289b..1e7dadcb644f 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -17,7 +17,6 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
-#include <linux/pm_qos.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/soc/mediatek/mtk_sip_svc.h>
@@ -626,21 +625,9 @@ static void ufs_mtk_init_host_caps(struct ufs_hba *hba)
 	dev_info(hba->dev, "caps: 0x%x", host->caps);
 }
 
-static void ufs_mtk_boost_pm_qos(struct ufs_hba *hba, bool boost)
-{
-	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
-
-	if (!host || !host->pm_qos_init)
-		return;
-
-	cpu_latency_qos_update_request(&host->pm_qos_req,
-				       boost ? 0 : PM_QOS_DEFAULT_VALUE);
-}
-
 static void ufs_mtk_scale_perf(struct ufs_hba *hba, bool scale_up)
 {
 	ufs_mtk_boost_crypt(hba, scale_up);
-	ufs_mtk_boost_pm_qos(hba, scale_up);
 }
 
 static void ufs_mtk_pwr_ctrl(struct ufs_hba *hba, bool on)
@@ -959,10 +946,6 @@ static int ufs_mtk_init(struct ufs_hba *hba)
 
 	host->ip_ver = ufshcd_readl(hba, REG_UFS_MTK_IP_VER);
 
-	/* Initialize pm-qos request */
-	cpu_latency_qos_add_request(&host->pm_qos_req, PM_QOS_DEFAULT_VALUE);
-	host->pm_qos_init = true;
-
 	goto out;
 
 out_variant_clear:
diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-mediatek.h
index f76e80d91729..38eab95b0f79 100644
--- a/drivers/ufs/host/ufs-mediatek.h
+++ b/drivers/ufs/host/ufs-mediatek.h
@@ -7,7 +7,6 @@
 #define _UFS_MEDIATEK_H
 
 #include <linux/bitops.h>
-#include <linux/pm_qos.h>
 #include <linux/soc/mediatek/mtk_sip_svc.h>
 
 /*
@@ -167,7 +166,6 @@ struct ufs_mtk_mcq_intr_info {
 
 struct ufs_mtk_host {
 	struct phy *mphy;
-	struct pm_qos_request pm_qos_req;
 	struct regulator *reg_va09;
 	struct reset_control *hci_reset;
 	struct reset_control *unipro_reset;
@@ -178,7 +176,6 @@ struct ufs_mtk_host {
 	struct ufs_mtk_hw_ver hw_ver;
 	enum ufs_mtk_host_caps caps;
 	bool mphy_powered_on;
-	bool pm_qos_init;
 	bool unipro_lpm;
 	bool ref_clk_enabled;
 	u16 ref_clk_ungating_wait_us;
-- 
2.17.1

