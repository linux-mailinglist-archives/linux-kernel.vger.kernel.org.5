Return-Path: <linux-kernel+bounces-5178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EED68187A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CBF1F24141
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455A218EC1;
	Tue, 19 Dec 2023 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iog+1JW+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A618E3E;
	Tue, 19 Dec 2023 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJBriY8025630;
	Tue, 19 Dec 2023 12:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=LZx8uLBDEnuZ9FSMUG42
	V3XMmk2L95CFWxXVx8IS7+U=; b=iog+1JW+mLoWC/orYTVlV7kpWiWEj47Cq6jt
	MYlgkXud+IYN76p1Glt8T6i39Jp52Mm0UTgI3mnyP2ka1tddLHhGWeChverfJb7L
	Hc5ip7kw63L55tCWaRctqTgFta7qikaphlft4yCFnnCOGcwBz5sXLhM5F/aQuSHn
	I7q+K5N/4Lwi2OpeoH5TxwSORN8RCj9Y1Nro+pFdsGszwePFrBa4yEwSLjDW0GWM
	4I9X9iEWc/8zAl4Lh8LeJrUqA1vW2JiNc3ADmbdKiukfsSMnOQcFCIyqDf8f4cOx
	B3SMFTY1DfU5hWFO8kKGstnMm4cPsgOEKA4tg52VUoFFWuDbkA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2yyxhje3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 12:37:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJCbtsc013404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 12:37:55 GMT
Received: from hu-mnaresh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 04:37:50 -0800
From: Maramaina Naresh <quic_mnaresh@quicinc.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        "Matthias
 Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Jhu <chu.stanley@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>
Subject: [PATCH V6 2/2] ufs: ufs-mediatek: Migrate to UFSHCD generic CPU latency PM QoS support
Date: Tue, 19 Dec 2023 18:07:06 +0530
Message-ID: <20231219123706.6463-3-quic_mnaresh@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231219123706.6463-1-quic_mnaresh@quicinc.com>
References: <20231219123706.6463-1-quic_mnaresh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vgDwjcyfZ20GeiThkAikKdWfy6WmiljT
X-Proofpoint-GUID: vgDwjcyfZ20GeiThkAikKdWfy6WmiljT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190094

The PM QoS feature found in the MediaTek UFS driver was moved to the UFSHCD
core. Hence remove it from MediaTek UFS driver as it is redundant now.

Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
---
 drivers/ufs/host/ufs-mediatek.c | 17 -----------------
 drivers/ufs/host/ufs-mediatek.h |  3 ---
 2 files changed, 20 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 776bca4f70c8..f43eb945e011 100644
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


