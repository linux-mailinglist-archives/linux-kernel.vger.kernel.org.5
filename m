Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578A37E35A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjKGHQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjKGHQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:16:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0A511D;
        Mon,  6 Nov 2023 23:16:42 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A770FUk029918;
        Tue, 7 Nov 2023 07:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=MW+pjJx+dmWrkSa5rLsX0OV6610yTNFNB2ply4qeBIA=;
 b=DqHT70hvY4EexM/RYRfdtWGOnMwi/RJjdsiqN5GNcGBPIq5hrAGYzWqhf2LYLSMAeibV
 qgF2EjbQc61YYA96XA/RX1GE/x9JH7Sk4rv2q94qArSuPsF13edT1f9EKXxQ9kbXynCm
 f5yywSW6IMOW6ar7wVGrUsGwWXWDT1QRkWtm6QWiJ9W32qLSS7Qdv7YkVbX81WgzEw0s
 A8wMzSORAqFJ6gBFXDu/an2U300La4z8cSttpnb44+i4Z+QZShhOf0HyEK9lQT/68Hj0
 ZJDautlyaZM7w1Lp5fgz8+8YJM4C7Hc2gq4itaZoOEd2aXHIcGJzZT9TUN9psuYqvbFo JA== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u72bthx5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 07:16:34 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A77GBOH008385;
        Tue, 7 Nov 2023 07:16:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3u5f1kdxk3-1;
        Tue, 07 Nov 2023 07:16:11 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A77GB67008380;
        Tue, 7 Nov 2023 07:16:11 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3A77GAH1008377;
        Tue, 07 Nov 2023 07:16:10 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 1B95B5441; Tue,  7 Nov 2023 15:16:10 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_jhugo@quicinc.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Hemant Kumar <quic_hemantk@quicinc.com>,
        Lazarus Motha <quic_lmotha@quicinc.com>,
        Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v3 4/4] bus: mhi: host: Take irqsave lock after TRE is generated
Date:   Tue,  7 Nov 2023 15:16:05 +0800
Message-Id: <1699341365-47737-5-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1699341365-47737-1-git-send-email-quic_qianyu@quicinc.com>
References: <1699341365-47737-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qSWrqvccYDix-QsJoEGPNQYQpt-AeHLT
X-Proofpoint-GUID: qSWrqvccYDix-QsJoEGPNQYQpt-AeHLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=668 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070059
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index b137d54..93b5110 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1129,17 +1129,15 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
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
@@ -1159,7 +1157,6 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 	if (dir == DMA_FROM_DEVICE)
 		mhi_cntrl->runtime_put(mhi_cntrl);
 
-exit_unlock:
 	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
 
 	return ret;
-- 
2.7.4

