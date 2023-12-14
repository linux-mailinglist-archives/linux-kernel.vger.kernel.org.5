Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B627812F09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444148AbjLNLn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444064AbjLNLmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:42:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228C311D;
        Thu, 14 Dec 2023 03:42:59 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE8kKvM006105;
        Thu, 14 Dec 2023 11:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=qcppdkim1; bh=jeaEe5H
        nF2x0m61p1cqViCnzJTUQfXgbn7gCqVrYXWY=; b=Glx6lDfrbeil+0LMVc7HomY
        qegf2zDZF/pJZq6jboTQ8wAEmLrtvwtgWEir/E9fkEeBqVHeJ8yS6r/rP7DXdckt
        haKcP6bThAlIMb658tiMIIzBABzh1J2k61GGJTptnLVmOhKyhmmll1fb9eIwVZWj
        bGu4Id+HtJ9NVS0ciTtsu2wO8Z03mUCulONCzdaVQa192vu06qEk8l99Fn0olO9X
        O35PZiGbAUxy6ml2yXHrrn8EM+MOIbAdljyww0mCqKKENcvBRl62k5socGazF2zY
        kRAozF2yVlIDeUes8pB34b5aMAHbjIdXXf7aXNg12m7dol3jrteTG2C5YWOPxNQ=
        =
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uysrprxb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 11:42:48 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BEBexrC001132;
        Thu, 14 Dec 2023 11:42:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3uvhaktcha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 11:42:44 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEBex01001124;
        Thu, 14 Dec 2023 11:42:44 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3BEBgiLw003204
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 11:42:44 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
        id 9F3A841674; Thu, 14 Dec 2023 17:12:42 +0530 (+0530)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     thara.gopinath@gmail.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, vkoul@kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        quic_srichara@quicinc.com, quic_varada@quicinc.com
Cc:     quic_mdalam@quicinc.com
Subject: [PATCH 09/11] crypto: qce - Add support for lock/unlock in skcipher
Date:   Thu, 14 Dec 2023 17:12:37 +0530
Message-Id: <20231214114239.2635325-10-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
References: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IQo-KjvO-Z2zSMrrTFCRlCj_MGfHwWd5
X-Proofpoint-GUID: IQo-KjvO-Z2zSMrrTFCRlCj_MGfHwWd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140080
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for lock/unlock on bam pipe in skcipher.
If multiple EE's(Execution Environment) try to access
the same crypto engine then before accessing the crypto
engine EE's has to lock the bam pipe and then submit the
request to crypto engine. Once request done then EE's has
to unlock the bam pipe so that others EE's can access the
crypto engine.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/crypto/qce/skcipher.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index fa7ee5db9aa0..c74df30e8e31 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -42,6 +42,8 @@ static void qce_skcipher_done(void *data)
 	dir_src = diff_dst ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
 	dir_dst = diff_dst ? DMA_FROM_DEVICE : DMA_BIDIRECTIONAL;
 
+	qce_bam_release_lock(qce);
+
 	error = qce_dma_terminate_all(&qce->dma);
 	if (error)
 		dev_dbg(qce->dev, "skcipher dma termination error (%d)\n",
@@ -94,6 +96,8 @@ qce_skcipher_async_req_handle(struct crypto_async_request *async_req)
 	dir_src = diff_dst ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
 	dir_dst = diff_dst ? DMA_FROM_DEVICE : DMA_BIDIRECTIONAL;
 
+	qce_bam_acquire_lock(qce);
+
 	rctx->src_nents = sg_nents_for_len(req->src, req->cryptlen);
 	if (diff_dst)
 		rctx->dst_nents = sg_nents_for_len(req->dst, req->cryptlen);
-- 
2.34.1

