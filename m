Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860767B2D29
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjI2HnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjI2HnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:43:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F351B3;
        Fri, 29 Sep 2023 00:42:59 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T7FrGp025017;
        Fri, 29 Sep 2023 07:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=JnvGPfam0j++dYMYQFm6Fq6OnF+GhvPcHneOtNp3o/Q=;
 b=JlSyg4hXf7vy2PgbI0GhKucm6zvBiHeXWf1+ugmXkWEzDwqnaTV0ypxZoHfw7jtJLshi
 xgkCUBzgfyB/O8xZz0YI4mHulG7LfaJzfg0531BQnBRmICqjtXGThcv1TkTBzQy1llv7
 R/qPtrG7cl6/SFSJQ0rlyKafKDxDU9cpLCxu7DNvQ0Kb+wAp4QrTwmfCsKFYQb6sm6/Y
 xMbZKUfyiVrT546shTtFIy5n6VZaGrB3YuLTS11v0txa9/9f682fEdQR76oN6liC+jJz
 K8M+oewHhlRGLnXLq8ks584KK8nrISac0UuB3X44wMOwQsT+fB8pQxcQWPtmoV/4IzEv lA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td5se2bvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:42:55 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38T7gsk2021131
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:42:54 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 29 Sep 2023 00:42:50 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, stable <stable@kernel.org>
Subject: [PATCH v1 2/3] misc: fastrpc: Free DMA handles for RPC calls with no arguments
Date:   Fri, 29 Sep 2023 13:12:39 +0530
Message-ID: <1695973360-14369-3-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695973360-14369-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1695973360-14369-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5-oN3xOW69dh9HyhGz1AHXbsTnSK5KGY
X-Proofpoint-GUID: 5-oN3xOW69dh9HyhGz1AHXbsTnSK5KGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_05,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FDs for DMA handles to be freed is updated in fdlist by DSP over
a remote call. This holds true even for remote calls with no
arguments. To handle this, get_args and put_args are needed to
be called for remote calls with no arguments also as fdlist
is allocated in get_args and FDs updated in fdlist is freed
in put_args.

Fixes: 8f6c1d8c4f0c ("misc: fastrpc: Add fdlist implementation")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index fb92197..a52701c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1091,6 +1091,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 		}
 	}
 
+	/* Clean up fdlist which is updated by DSP */
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
 		if (!fdlist[i])
 			break;
@@ -1157,11 +1158,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	if (ctx->nscalars) {
-		err = fastrpc_get_args(kernel, ctx);
-		if (err)
-			goto bail;
-	}
+	err = fastrpc_get_args(kernel, ctx);
+	if (err)
+		goto bail;
 
 	/* make sure that all CPU memory writes are seen by DSP */
 	dma_wmb();
@@ -1185,14 +1184,12 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
-	if (ctx->nscalars) {
-		/* make sure that all memory writes by DSP are seen by CPU */
-		dma_rmb();
-		/* populate all the output buffers with results */
-		err = fastrpc_put_args(ctx, kernel);
-		if (err)
-			goto bail;
-	}
+	/* make sure that all memory writes by DSP are seen by CPU */
+	dma_rmb();
+	/* populate all the output buffers with results */
+	err = fastrpc_put_args(ctx, kernel);
+	if (err)
+		goto bail;
 
 bail:
 	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
-- 
2.7.4

