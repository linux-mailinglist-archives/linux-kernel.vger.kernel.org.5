Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9282F7A79A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbjITKsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjITKrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:47:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47A9183;
        Wed, 20 Sep 2023 03:47:29 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K5KbDO021321;
        Wed, 20 Sep 2023 10:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=4OOKpaSJ3Dpz1DZLKu96Rsw4X62hET4XC+R0SjKTIXk=;
 b=ULlMzPHIRYfPYCbLk2uTN32mDulIhirZGo1O0SKE29S8PYnCEciSxz5E03Aw2qyiKK8H
 iJG2HJNuKExlK4w6bDXKMHjwl5GNtmTHzyP/BOz20R9IehmijfwWq2gTFUBxBDZeMctp
 zUOUdCDOFvR0r2SebiN4KFZOJF6eys1YXapMTmaGTxj1V0i1jzWgyg4mMWE5wj3vbKh0
 TdMBivSPBI+ZnlVT6qXpyLMVVRQdR+btiJWU39c7u9nfHa9uJnDtYknLEy/QrgpNilKD
 jmS/RUUYfEFI4WIB27jY+6Z+REWSOF9r3dw97qR8cziTpHlN/Q2tD+fi/1ozicvNUX0z Tw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7qj90yvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 10:47:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38KAlOk3003619
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 10:47:24 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 20 Sep 2023 03:47:21 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v3 2/5] misc: fastrpc: Add CRC support for remote buffers
Date:   Wed, 20 Sep 2023 16:17:04 +0530
Message-ID: <1695206827-29446-3-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695206827-29446-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1695206827-29446-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4XftUyOf2wVyoTtHwBg4ihpO1nXmqKBU
X-Proofpoint-ORIG-GUID: 4XftUyOf2wVyoTtHwBg4ihpO1nXmqKBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CRC check for input and output argument helps in ensuring data
consistency over a remote call. If user intends to enable CRC check,
first local user CRC is calculated at user end and a CRC buffer is
passed to DSP to capture remote CRC values. DSP is expected to
write to the remote CRC buffer which is then compared at user level
with the local CRC values.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 04eaf6c..337ec1f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -610,6 +610,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	/* Released in fastrpc_context_put() */
 	fastrpc_channel_ctx_get(cctx);
 
+	ctx->crc = (u32 *)(uintptr_t)invoke->crc;
 	ctx->sc = sc;
 	ctx->retval = -1;
 	ctx->pid = current->pid;
@@ -1063,6 +1064,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	struct fastrpc_invoke_buf *list;
 	struct fastrpc_phy_page *pages;
 	u64 *fdlist;
+	u32 *crclist;
 	int i, inbufs, outbufs, handles;
 
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
@@ -1070,7 +1072,8 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	handles = REMOTE_SCALARS_INHANDLES(ctx->sc) + REMOTE_SCALARS_OUTHANDLES(ctx->sc);
 	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
-	fdlist = (uint64_t *)(pages + inbufs + outbufs + handles);
+	fdlist = (u64 *)(pages + inbufs + outbufs + handles);
+	crclist = (u32 *)(fdlist + FASTRPC_MAX_FDLIST);
 
 	for (i = inbufs; i < ctx->nbufs; ++i) {
 		if (!ctx->maps[i]) {
@@ -1094,6 +1097,10 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 			fastrpc_map_put(mmap);
 	}
 
+	if (ctx->crc && crclist && rpra) {
+		if (copy_to_user((void __user *)ctx->crc, crclist, FASTRPC_MAX_CRCLIST * sizeof(u32)))
+			return -EFAULT;
+	}
 	return 0;
 }
 
@@ -1706,6 +1713,7 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 
 	switch (invoke.req) {
 	case FASTRPC_INVOKE:
+	case FASTRPC_INVOKE_ENHANCED:
 		/* nscalars is truncated here to max supported value */
 		if (copy_from_user(&einv, (void __user *)(uintptr_t)invoke.invparam,
 				   invoke.size))
-- 
2.7.4

