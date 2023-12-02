Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6271F801C97
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 13:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjLBMhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 07:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjLBMg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 07:36:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BCE12E;
        Sat,  2 Dec 2023 04:37:04 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B2CaKJt011426;
        Sat, 2 Dec 2023 12:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=F774Y4Y23EcVWPLBnqfuc9pSgJl+CqV1EpBPBNmV9o8=;
 b=QFr8If8x2zuqekvVeaW5I4OzVuNrZGCrfKB1bpLe9maAOO2G54Pq7bo2VN9dUrixJuq5
 rWgMropfvva80vgEgk6w1HaUV4QPzMRg+fu6Q2AqVOLI+LgKibe0rseySDnBF0tQpQ+C
 8IFCDykPbUvIOi8s8RZooFvlgzqFtjdoqwnYiExH7DRtjuAA29O0eOCzkON4OOsw/zX9
 vbF9rZeg/CrSh9oQrmFJxs7RUtKPyPwd8us8sjru/69zyro7dpJXno/ZeeIcfqSclRR9
 r8SiGIQQ1NWE1kc+coEN2yEYhw9knTU41i+0pxjBMhxwpFzigHK5aADgIMrkZEfAPSz9 8w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqv670kq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Dec 2023 12:36:50 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3B2Ca9aD017632;
        Sat, 2 Dec 2023 12:36:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3uqwnkb9r4-1;
        Sat, 02 Dec 2023 12:36:48 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B2CaOWr017893;
        Sat, 2 Dec 2023 12:36:48 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3B2CamRj018473;
        Sat, 02 Dec 2023 12:36:48 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id BD53220A90; Sat,  2 Dec 2023 04:36:47 -0800 (PST)
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
Subject: [PATCH v8 08/10] scsi: ufs: ufs-qcom: Add support for UFS device version detection
Date:   Sat,  2 Dec 2023 04:36:14 -0800
Message-Id: <1701520577-31163-9-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
References: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: o2OiUqPnmYrkKGxj3-NcqAA5c8YVm_YY
X-Proofpoint-GUID: o2OiUqPnmYrkKGxj3-NcqAA5c8YVm_YY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_09,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312020094
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>

Start from HW ver 5, a spare register in UFS host controller is added and
used to indicate the UFS device version. The spare register is populated by
bootloader for now, but in future it will be populated by HW automatically
during link startup with its best efforts in any boot stage prior to Linux.

During host driver init, read the spare register, if it is not populated
with a UFS device version, go ahead with the dual init mechanism. If a UFS
device version is in there, use the UFS device version together with host
controller's HW version to decide the proper PHY gear which should be used
to configure the UFS PHY without going through the second init.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---

v7 -> v8:
Fixed a BUG introduced from v6 -> v7. The spare register is added since HW ver 5, hence exclude HW ver == 4.

---
 drivers/ufs/host/ufs-qcom.c | 35 ++++++++++++++++++++++++++++-------
 drivers/ufs/host/ufs-qcom.h |  4 ++++
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index ee3f07a..968a4c0 100644
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
+	} else if (host->hw_ver.major >= 0x5) {
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

