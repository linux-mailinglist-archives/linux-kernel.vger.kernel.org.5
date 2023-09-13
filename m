Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862AB79E289
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbjIMIsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbjIMIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:48:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67950199E;
        Wed, 13 Sep 2023 01:48:00 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D8amli025056;
        Wed, 13 Sep 2023 08:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=xusWZUomRiXPwqA1MTyigAKtR02LdB8vIjAksisn+So=;
 b=VbXvxtY3+HuJ3X4WWFFqsbNMyF1NeIrdoKN/Z+uJW4mUq8lG5/eq2Ddd7ZwwtVvnT14i
 EnTZKteI4izgvjyQaeoqupOFbmbUNqIRfF95K5cQBaLQLcOYM75lxw9ByUYN6ZwIKsHH
 dtAaKd2elk+XNiXQ9vxYaoadgn5R9fUz4686yVxluNRYQkjdS6ApfcoEUjT6djyXS1tr
 R16v/WhlUdEPLCqZ9qf3HmcreiVzE/tGVcYjpgbSwXNdqGgjOuMDdIVp+JrAwN5Cks+0
 EBAugOAH61EVImeOWqZhhQcX/EJ55kaSoIFusVDPGR8vFJtJi+qjuRvsatPCP4PdRRF8 pA== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2yp3h2c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 08:47:48 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38D8lj2t017801;
        Wed, 13 Sep 2023 08:47:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3t0hskhgyy-1;
        Wed, 13 Sep 2023 08:47:45 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38D8ljXY017793;
        Wed, 13 Sep 2023 08:47:45 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 38D8ljLY017790;
        Wed, 13 Sep 2023 08:47:45 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 9B5684E07; Wed, 13 Sep 2023 16:47:44 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_jhugo@quicinc.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Hemant Kumar <quic_hemantk@quicinc.com>,
        Lazarus Motha <quic_lmotha@quicinc.com>,
        Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v2 2/2] bus: mhi: host: Take irqsave lock after TRE is generated
Date:   Wed, 13 Sep 2023 16:47:41 +0800
Message-Id: <1694594861-12691-3-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694594861-12691-1-git-send-email-quic_qianyu@quicinc.com>
References: <1694594861-12691-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: foD5ypGQJQOX_2_oxBjt4bU3xFXsoARr
X-Proofpoint-ORIG-GUID: foD5ypGQJQOX_2_oxBjt4bU3xFXsoARr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_02,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxlogscore=689 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309130070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <quic_hemantk@quicinc.com>

Take irqsave lock after TRE is generated to avoid deadlock due to core
getting interrupts enabled as local_bh_enable must not be called with
irqs disabled based on upstream patch.

Signed-off-by: Hemant Kumar <quic_hemantk@quicinc.com>
Signed-off-by: Lazarus Motha <quic_lmotha@quicinc.com>
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/bus/mhi/host/main.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 13c4b89..8accdfd 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1124,17 +1124,15 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)))
 		return -EIO;
 
-	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
-
 	ret = mhi_is_ring_full(mhi_cntrl, tre_ring);
-	if (unlikely(ret)) {
-		ret = -EAGAIN;
-		goto exit_unlock;
-	}
+	if (unlikely(ret))
+		return -EAGAIN;
 
 	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, buf_info, mflags);
 	if (unlikely(ret))
-		goto exit_unlock;
+		return ret;
+
+	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
 
 	/* Packet is queued, take a usage ref to exit M3 if necessary
 	 * for host->device buffer, balanced put is done on buffer completion
@@ -1154,7 +1152,6 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 	if (dir == DMA_FROM_DEVICE)
 		mhi_cntrl->runtime_put(mhi_cntrl);
 
-exit_unlock:
 	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
 
 	return ret;
-- 
2.7.4

