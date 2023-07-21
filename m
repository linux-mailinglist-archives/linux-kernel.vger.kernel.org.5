Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D928F75BC5D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjGUCkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGUCkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:40:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D10268E;
        Thu, 20 Jul 2023 19:40:10 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L2cKc7028702;
        Fri, 21 Jul 2023 02:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=ht63O+EthvOxuZcSBRA2onZLxniurDbtrAaHlJl/2m0=;
 b=Zdy5cmT8SsvGBVuHKP2ygcUDHAwRNZSg+yt4/Fl6KfcrKmfvM0iQu04WmZNMNbQuwee1
 QIytibHGofkTdJzyosap0v7pI5FJS21bqNu5XrxZmrZuWLzkwaDH9qcRRkHHtz70ZL19
 6Tcz7pyJFp2d27Bg1IzLLwatAvPJ8UH7NQGzay4g/yux3w+UfiHfpm5dcm+gk4huKAtf
 Qrc8SCxVfVf6nK3mfrgdqDZCqyEtZe5yX3iPE8cqcG5WGDNf0hqpwdIXgNwgv95ipzmD
 7wY4eeI6WcL9PjtfYpZmVnGy6kWz61zEadaw6QVnJgPX7S/mTeC94Dq1fSivYBq8q9pE PQ== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxxxvajas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:39:58 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36L2dtju010054;
        Fri, 21 Jul 2023 02:39:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rumhm29hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 Jul 2023 02:39:55 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36L2dsx9010049;
        Fri, 21 Jul 2023 02:39:55 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 36L2dspc010048;
        Fri, 21 Jul 2023 02:39:54 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 6DE124B22; Fri, 21 Jul 2023 10:39:53 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_jhugo@quicinc.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH] mhi: host: Add tme supported image download functionality
Date:   Fri, 21 Jul 2023 10:39:49 +0800
Message-Id: <1689907189-21844-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h5Gm5bcDyDMnoOeWwn3Z4zAhNyFuJsJe
X-Proofpoint-ORIG-GUID: h5Gm5bcDyDMnoOeWwn3Z4zAhNyFuJsJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1011 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210022
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tme supported image related flag which makes decision in terms of how
FBC image based AMSS image is being downloaded with connected endpoint.
FBC image is having 2 image combine: SBL image + AMSS image.
1. FBC image download using legacy image format:
- SBL image: 512KB of FBC image is downloaded using BHI.
- AMSS image: full FBC image is downloaded using BHIe.
2. FBC image download using TME supported image format:
- SBL image: 512 KB of FBC image is downloaded using BHI.
- AMSS image: 512 KB onward FBC image is downloaded using BHIe.
There is no change for SBL image download. Although AMSS image start
address is end address of SBL image while using TME supported image format.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/bus/mhi/host/boot.c | 24 +++++++++++++++++-------
 include/linux/mhi.h         |  2 ++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index d2a19b07..563b011 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -365,12 +365,13 @@ int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
 }
 
 static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
-			      const struct firmware *firmware,
+			      const u8 *image_buf,
+			      size_t img_size,
 			      struct image_info *img_info)
 {
-	size_t remainder = firmware->size;
+	size_t remainder = img_size;
 	size_t to_cpy;
-	const u8 *buf = firmware->data;
+	const u8 *buf = image_buf;
 	struct mhi_buf *mhi_buf = img_info->mhi_buf;
 	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
 
@@ -395,8 +396,9 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	const char *fw_name;
 	void *buf;
 	dma_addr_t dma_addr;
-	size_t size;
+	size_t size, img_size;
 	int i, ret;
+	const u8 *img_buf;
 
 	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
 		dev_err(dev, "Device MHI is not in valid state\n");
@@ -478,15 +480,23 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	 * device transitioning into MHI READY state
 	 */
 	if (mhi_cntrl->fbc_download) {
-		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
-					   firmware->size);
+		img_size = firmware->size;
+		img_buf = firmware->data;
+		dev_dbg(dev, "tme_supported_image:%s\n",
+				(mhi_cntrl->tme_supported_image ? "True" : "False"));
+		if (mhi_cntrl->tme_supported_image) {
+			img_buf = firmware->data + mhi_cntrl->sbl_size;
+			img_size = img_size - mhi_cntrl->sbl_size;
+		}
+
+		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image, img_size);
 		if (ret) {
 			release_firmware(firmware);
 			goto error_fw_load;
 		}
 
 		/* Load the firmware into BHIE vec table */
-		mhi_firmware_copy(mhi_cntrl, firmware, mhi_cntrl->fbc_image);
+		mhi_firmware_copy(mhi_cntrl, img_buf, img_size, mhi_cntrl->fbc_image);
 	}
 
 	release_firmware(firmware);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index f6de4b6..5f46dc9 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -306,6 +306,7 @@ struct mhi_controller_config {
  * @reg_len: Length of the MHI MMIO region (required)
  * @fbc_image: Points to firmware image buffer
  * @rddm_image: Points to RAM dump buffer
+ * @tme_supported_image: Flag to make decision about firmware download start address (optional)
  * @mhi_chan: Points to the channel configuration table
  * @lpm_chans: List of channels that require LPM notifications
  * @irq: base irq # to request (required)
@@ -391,6 +392,7 @@ struct mhi_controller {
 	size_t reg_len;
 	struct image_info *fbc_image;
 	struct image_info *rddm_image;
+	bool tme_supported_image;
 	struct mhi_chan *mhi_chan;
 	struct list_head lpm_chans;
 	int *irq;
-- 
2.7.4

