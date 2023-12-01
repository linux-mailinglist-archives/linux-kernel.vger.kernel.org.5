Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C99E8002BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjLAFEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377396AbjLAFEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:04:39 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0E7173C;
        Thu, 30 Nov 2023 21:04:45 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUNa9Sg024413;
        Fri, 1 Dec 2023 05:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=sNcI5ZbIaHCIB1BdqUiWhE2+Gn3LovkfZzI3XB4KwMk=;
 b=IvqebNhEP/HmirX0OL4VYhrk51OBgksV6E41z6ZX8tHS3QLYk/VkepiSxEA3G/y9YXeR
 +VTdBJVByQHeNd0dfLi1kWgEeUoIDwih/HdTZaV47INED448tunsdDghr+pPPhHk7fg8
 JNVBZ5RPXHw7zN+4B+lizeCRxKeHOCXbP3lTxoxy3pHN3Vl2+w2GGz/LSXl2usCtYDjK
 6+Xhieg0UQ/2Hvkd33Uyze4qvFZbRgvCy+zMtwih2XQc40KDijnp3YlnNE7836Go605e
 9hbtOmUcpW/WnBpHWDgfynlN9BmiQs9Gh74jtWZr85V0TRnl7Dd+FPVrWPhIskkV9uQY RA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uprhdteup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 05:04:07 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3B14vj4T024231;
        Fri, 1 Dec 2023 05:04:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 3unmewn2fs-1;
        Fri, 01 Dec 2023 05:04:06 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B14wlND026965;
        Fri, 1 Dec 2023 05:04:06 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 3B15462t002738;
        Fri, 01 Dec 2023 05:04:06 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id B133420A69; Thu, 30 Nov 2023 21:04:05 -0800 (PST)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        adrian.hunter@intel.com, vkoul@kernel.org, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 08/10] scsi: ufs: ufs-qcom: Add support for UFS device version detection
Date:   Thu, 30 Nov 2023 21:03:18 -0800
Message-Id: <1701407001-471-9-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701407001-471-1-git-send-email-quic_cang@quicinc.com>
References: <1701407001-471-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N2VIvOJYh0bbWLbe_nW5z1VqJKOykTvs
X-Proofpoint-GUID: N2VIvOJYh0bbWLbe_nW5z1VqJKOykTvs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_02,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010028
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>

A spare register in UFS host controller is used to indicate the UFS device
version. The spare register is populated by bootloader for now, but in
future it will be populated by HW automatically during link startup with
its best efforts in any boot stages prior to Linux.

During host driver init, read the spare register, if it is not populated
with a UFS device version, go ahead with the dual init mechanism. If a UFS
device version is in there, use the UFS device version together with host
controller's HW version to decide the proper PHY gear which should be used
to configure the UFS PHY without going through the second init.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 35 ++++++++++++++++++++++++++++-------
 drivers/ufs/host/ufs-qcom.h |  4 ++++
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index ee3f07a..99a0a53 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1065,17 +1065,38 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
 static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
 {
 	struct ufs_host_params *host_params = &host->host_params;
+	u32 val, dev_major;
 
 	host->phy_gear = host_params->hs_tx_gear;
 
-	/*
-	 * For controllers whose major HW version is < 4, power up the PHY using
-	 * minimum supported gear (UFS_HS_G2). Switching to max gear will be
-	 * performed during reinit if supported. For newer controllers, whose
-	 * major HW version is >= 4, power up the PHY using max supported gear.
-	 */
-	if (host->hw_ver.major < 0x4)
+	if (host->hw_ver.major < 0x4) {
+		/*
+		 * For controllers whose major HW version is < 4, power up the
+		 * PHY using minimum supported gear (UFS_HS_G2). Switching to
+		 * max gear will be performed during reinit if supported.
+		 * For newer controllers, whose major HW version is >= 4, power
+		 * up the PHY using max supported gear.
+		 */
 		host->phy_gear = UFS_HS_G2;
+	} else {
+		val = ufshcd_readl(host->hba, REG_UFS_DEBUG_SPARE_CFG);
+		dev_major = FIELD_GET(UFS_DEV_VER_MAJOR_MASK, val);
+
+		/*
+		 * Since the UFS device version is populated, let's remove the
+		 * REINIT quirk as the negotiated gear won't change during boot.
+		 * So there is no need to do reinit.
+		 */
+		if (dev_major != 0x0)
+			host->hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
+
+		/*
+		 * For UFS 3.1 device and older, power up the PHY using HS-G4
+		 * PHY gear to save power.
+		 */
+		if (dev_major > 0x0 && dev_major < 0x4)
+			host->phy_gear = UFS_HS_G4;
+	}
 }
 
 static void ufs_qcom_set_host_params(struct ufs_hba *hba)
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 11419eb..32e51d9 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -23,6 +23,8 @@
 #define UFS_HW_VER_MINOR_MASK	GENMASK(27, 16)
 #define UFS_HW_VER_STEP_MASK	GENMASK(15, 0)
 
+#define UFS_DEV_VER_MAJOR_MASK	GENMASK(7, 4)
+
 /* vendor specific pre-defined parameters */
 #define SLOW 1
 #define FAST 2
@@ -54,6 +56,8 @@ enum {
 	UFS_AH8_CFG				= 0xFC,
 
 	REG_UFS_CFG3				= 0x271C,
+
+	REG_UFS_DEBUG_SPARE_CFG			= 0x284C,
 };
 
 /* QCOM UFS host controller vendor specific debug registers */
-- 
2.7.4

