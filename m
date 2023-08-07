Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2AC771BF4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjHGIAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjHGIAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:00:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E05DD;
        Mon,  7 Aug 2023 01:00:15 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3777H2o8008651;
        Mon, 7 Aug 2023 07:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=gidHkrGNBS/Q/FTRhnksGL7NvZvTt0ub/F33zzXjTMw=;
 b=KudwzehPQFZL1fsyXkWh2fvqOWKZ4qikiaSjqiDvwiTX9yGWxCrOJkiaDDBFl+Wom2m+
 Sgccad3A+rRu1NYiCCkqqIRPSSM67lEcSNBn85RgVryF7UxanVBEv4T2izRVgiBq1LD6
 xSv1zjYHyk++GIkHprDzIO5xrLMMK9qMAR2FkrGxFw8X/KdYfOCtrg93GPkXYN+/KZJr
 w/1T+dAaoUK0ZQPnRYOB7eENbmP4rnjLkPmgZT04kkr3N7W8cD64iPK6lpYFBr2/pWPc
 zrFU2jLp45jBQIluCgGQrZ8K0qXJnI/bvwOxygpyDe4n37NzOqV6Cs8npIpJ5i4Mv/iW kA== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9f6pjtcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 07:59:57 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3777xtdc018677;
        Mon, 7 Aug 2023 07:59:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s9fgkhehf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 07 Aug 2023 07:59:55 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3777xt72018672;
        Mon, 7 Aug 2023 07:59:55 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3777xtIt018670;
        Mon, 07 Aug 2023 07:59:55 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 009994C57; Mon,  7 Aug 2023 15:59:53 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_jhugo@quicinc.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v2] mhi: host: Add standard ELF header image download functionality
Date:   Mon,  7 Aug 2023 15:59:52 +0800
Message-Id: <1691395192-16090-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YqjZznV0w4SQVLWQ__9FIGDB4WIk57Hg
X-Proofpoint-GUID: YqjZznV0w4SQVLWQ__9FIGDB4WIk57Hg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_06,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070074
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mayank Rana <quic_mrana@quicinc.com>

Some devices (e.g. WLAN chips) are unable to handle the non-standard ELF
format of the FBC image and thus need special handling of the FBC image.

Add standard_elf_image flag which makes decision in terms of how FBC image
based AMSS image is being downloaded with connected endpoint.
FBC image is having two image combine: SBL image + AMSS image.
1. FBC image download using legacy single ELF header image format:
- SBL image: 512KB of FBC image is downloaded using BHI.
- AMSS image: full FBC image is downloaded using BHIe.
2. FBC image download using separate ELF header image format:
- SBL image: 512 KB of FBC image is downloaded using BHI.
- AMSS image: 512 KB onward FBC image is downloaded using BHIe.
There is no change for SBL image download. Although AMSS image start
address is end address of SBL image while using separate ELF header format.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
[quic_qianyu@quicinc.com: Update commit message, minor updates]
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
v1->v2: modify commit message
	correct author
	rebase on latest mhi-next branch, resolve conflicts

 drivers/bus/mhi/host/boot.c | 7 +++++++
 include/linux/mhi.h         | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index edc0ec5..586d551 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -495,6 +495,13 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	 * device transitioning into MHI READY state
 	 */
 	if (mhi_cntrl->fbc_download) {
+		dev_dbg(dev, "standard_elf_image: %s\n",
+				(mhi_cntrl->standard_elf_image ? "True" : "False"));
+		if (mhi_cntrl->standard_elf_image) {
+			fw_data = firmware->data + mhi_cntrl->sbl_size;
+			fw_sz = fw_sz - mhi_cntrl->sbl_size;
+		}
+
 		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image, fw_sz);
 		if (ret) {
 			release_firmware(firmware);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 039943e..e065101 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -310,6 +310,7 @@ struct mhi_controller_config {
  * @reg_len: Length of the MHI MMIO region (required)
  * @fbc_image: Points to firmware image buffer
  * @rddm_image: Points to RAM dump buffer
+ * @standard_elf_image: Flag to make decision about firmware download start address (optional)
  * @mhi_chan: Points to the channel configuration table
  * @lpm_chans: List of channels that require LPM notifications
  * @irq: base irq # to request (required)
@@ -456,6 +457,7 @@ struct mhi_controller {
 	bool bounce_buf;
 	bool fbc_download;
 	bool wake_set;
+	bool standard_elf_image;
 	unsigned long irq_flags;
 	u32 mru;
 };
-- 
2.7.4

