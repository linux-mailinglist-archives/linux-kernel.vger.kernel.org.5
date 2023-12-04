Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69588036F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345479AbjLDOgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjLDOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:36:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C71106;
        Mon,  4 Dec 2023 06:36:09 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4AnLQp030548;
        Mon, 4 Dec 2023 14:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Cjni/hlpt/X+AaOx2fHWVROji8DsyjSHHQQ+GVNzNUg=;
 b=LWP6pyjYUsT4/MFb4+r5u/WMrk/e+YoMOspl5Knu1uifXtlJzri3CeufIuVeaW0vKt3w
 YWif8nqfTjaLSbFpm+Kp5VXpayZwSJarHWqoqUDY3nGE3DO/wNsLnB35kXTTE6fKr2Qc
 ireka6/OCU3gBIh5PWeBzh+w/aFNY0l1HIccUchsT6738cHsWJheCd9HxvLON2CfbVGl
 s4jt//NRZvDnYXDp/BWtUTv4Qe101UP3+WPtPBBGssMkB/fSM/VK+WweBW/O95+uLK8X
 niADSbBVo9Dop2veTP1JPzJXWuA5FQ/V9Nm2kV1c2IT6/8I4vNG7AttdP8LNkGfeJ5HX hA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3usdbn8m82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 14:31:43 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B4EVfPl019600
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 14:31:41 GMT
Received: from hu-mnaresh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 06:31:35 -0800
From:   Maramaina Naresh <quic_mnaresh@quicinc.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <chu.stanley@gmail.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>
Subject: [PATCH V2 2/3] ufs: ufs-mediatek: Enable CPU latency PM QoS support for MEDIATEK SoC
Date:   Mon, 4 Dec 2023 20:01:00 +0530
Message-ID: <20231204143101.64163-3-quic_mnaresh@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204143101.64163-1-quic_mnaresh@quicinc.com>
References: <20231204143101.64163-1-quic_mnaresh@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ygjjDnGUt9ZU1vBNg46PmO1f0ZZXD18j
X-Proofpoint-GUID: ygjjDnGUt9ZU1vBNg46PmO1f0ZZXD18j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_13,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1015 spamscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312040106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert the existing PM QoS feature from MEDIATEK UFS driver as similar
PM QoS feature implementation is moved to core ufshcd and also enable
CPU latency PM QoS capability for MEDIATEK SoC.

Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
---
 drivers/ufs/host/ufs-mediatek.c | 20 +++-----------------
 drivers/ufs/host/ufs-mediatek.h |  3 ---
 2 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index fc61790d289b..d8ece88103b9 100644
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
@@ -937,6 +924,9 @@ static int ufs_mtk_init(struct ufs_hba *hba)
 	/* Enable clk scaling*/
 	hba->caps |= UFSHCD_CAP_CLK_SCALING;
 
+	/* Enable PM QoS */
+	hba->caps |= UFSHCD_CAP_PM_QOS;
+
 	hba->quirks |= UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL;
 	hba->quirks |= UFSHCD_QUIRK_MCQ_BROKEN_INTR;
 	hba->quirks |= UFSHCD_QUIRK_MCQ_BROKEN_RTC;
@@ -959,10 +949,6 @@ static int ufs_mtk_init(struct ufs_hba *hba)
 
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
2.34.1

