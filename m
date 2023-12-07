Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7108380808E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377386AbjLGGNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGGNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:13:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50C4D59
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:13:26 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B750H5t016959;
        Thu, 7 Dec 2023 06:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Be9AaPHiwgw7dqeDBcxJMS8N3AdgUhsl7NDlIBaX1GQ=;
 b=nzGhbbbXQt5y9rFTCY+FoFxRki6j9hlGX3VVtx16e0IUmHNGQigsP8DUmSjY/Z29fS6J
 mE7qr/R2tCg2Np5sVxTxznvAyIbp6CfnbJ5MfsnoWZ3uLBFydGuI5fyKT32dgNcDcwdW
 86T+NMFomDAgURux58JJfwPCCqS7thcdH2m/JfprTUqLn2yddfYoXHrMW69TJXOI1BUb
 wk3hdX1D9XByS7wcuNG0uA+Hr1ki7/prj32W2ZuCb0t6o7G+wDPt2wNk0UkQXRPNJRFd
 xoVh5dvELh8K7Blj8bWVHK9Sl1fm2kt1qo8ky1QbbDKgNsKqI3d4LoVB1FABdVdu0nzM Iw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu6qr06xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 06:13:03 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B76D3mX019860
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 06:13:03 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 22:13:01 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <maz@kernel.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] irqchip/gic-v3-its: BUG_ON if stall bit is set
Date:   Thu, 7 Dec 2023 11:42:39 +0530
Message-ID: <1701929559-18252-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mHe2797qgUJBhuFjqGU3m_Wf5mtznhYB
X-Proofpoint-ORIG-GUID: mHe2797qgUJBhuFjqGU3m_Wf5mtznhYB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_03,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=949
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070047
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be various reason that stall bit could
be set due to software errors while processing
commands in command queue is being processed and
waiting for 1s is not going to help in debugging
as command processing anyways going to be timed
out and system will continue to run and may crash
after some time due to this.

So, to debug such issues what command caused the
stall bit to set, BUG_ON right away.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9a7a74239eab..8983e0a3318c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1078,6 +1078,11 @@ static int its_wait_for_range_completion(struct its_node *its,
 		s64 delta;
 
 		rd_idx = readl_relaxed(its->base + GITS_CREADR);
+		/*
+		 * Check for stall bit as there is no point in waiting
+		 * for 1s if the stall bit is already set.
+		 */
+		BUG_ON(rd_idx & 1);
 
 		/*
 		 * Compute the read pointer progress, taking the
-- 
2.7.4

