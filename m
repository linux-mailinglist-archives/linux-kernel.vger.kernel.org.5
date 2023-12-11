Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E8980C177
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 07:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjLKGna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 01:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjLKGnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 01:43:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C1710F;
        Sun, 10 Dec 2023 22:43:28 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB3U2Zx025349;
        Mon, 11 Dec 2023 06:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references; s=
        qcppdkim1; bh=RYnj6i8X3DA/tzosX99m5OYDnjepi+4YYvJGmfdTIn8=; b=PU
        8La6Y76Q7tpokiFPcfRkWeeDJnToCq4H4rMZP9J7e37vd1Pu0DDOmgQbqYWrctoo
        o1u4ZwXnDKDRBgO1HSrH52d9jEiufgB9Z/SyDNYyMo/KAYEzaeEdm9O7gCiQUu6z
        r/ETt0nosDsO9068Hy5PAHCIUQBhb7uYlYMM6grcs8PzbRP3KaU2W2wtoqBIkvlE
        bc7UOTfhhiXLRQwX1EFTLz6Jw3osNYnEbcmeC6TzRp6p5v2m8Kxz9wHlMDQDBAUg
        4ocR0pO+npoCA/qECe9jXIYxsr2aXgeDDCOF4VPIVgJ83w++T+kaLWWn4p0EiFlD
        Vd1Iux69RK7F2PLSYJXA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvp30aeqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 06:42:58 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BB6gt7r030880;
        Mon, 11 Dec 2023 06:42:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3uvhak95cr-1;
        Mon, 11 Dec 2023 06:42:55 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BB6gtSs030875;
        Mon, 11 Dec 2023 06:42:55 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3BB6gtLP030873;
        Mon, 11 Dec 2023 06:42:55 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 892B955E8; Mon, 11 Dec 2023 14:42:54 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_jhugo@quicinc.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Bhaumik Bhatt <bbhatt@codeaurora.org>,
        stable@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v5 1/2] bus: mhi: host: Add spinlock to protect WP access when queueing TREs
Date:   Mon, 11 Dec 2023 14:42:51 +0800
Message-Id: <1702276972-41296-2-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702276972-41296-1-git-send-email-quic_qianyu@quicinc.com>
References: <1702276972-41296-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CYvXI6dEOR8xWN_a4aN6Zm7O1UJxWgP1
X-Proofpoint-GUID: CYvXI6dEOR8xWN_a4aN6Zm7O1UJxWgP1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=504 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110054
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Protect WP accesses such that multiple threads queueing buffers for
incoming data do not race.

Meanwhile, if CONFIG_TRACE_IRQFLAGS is enabled, irq will be enabled once
__local_bh_enable_ip is called as part of write_unlock_bh. Hence, let's
take irqsave lock after TRE is generated to avoid running write_unlock_bh
when irqsave lock is held.

Cc: <stable@vger.kernel.org>
Fixes: 189ff97cca53 ("bus: mhi: core: Add support for data transfer")
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/bus/mhi/host/main.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index dcf627b..32021fe 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1122,17 +1122,15 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
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
@@ -1152,7 +1150,6 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 	if (dir == DMA_FROM_DEVICE)
 		mhi_cntrl->runtime_put(mhi_cntrl);
 
-exit_unlock:
 	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
 
 	return ret;
@@ -1204,6 +1201,9 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 	int eot, eob, chain, bei;
 	int ret;
 
+	/* Protect accesses for reading and incrementing WP */
+	write_lock_bh(&mhi_chan->lock);
+
 	buf_ring = &mhi_chan->buf_ring;
 	tre_ring = &mhi_chan->tre_ring;
 
@@ -1221,8 +1221,10 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 
 	if (!info->pre_mapped) {
 		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
-		if (ret)
+		if (ret) {
+			write_unlock_bh(&mhi_chan->lock);
 			return ret;
+		}
 	}
 
 	eob = !!(flags & MHI_EOB);
@@ -1239,6 +1241,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 	mhi_add_ring_element(mhi_cntrl, tre_ring);
 	mhi_add_ring_element(mhi_cntrl, buf_ring);
 
+	write_unlock_bh(&mhi_chan->lock);
+
 	return 0;
 }
 
-- 
2.7.4

