Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF4812EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444107AbjLNLnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444033AbjLNLmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:42:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EDE11A;
        Thu, 14 Dec 2023 03:42:57 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BEAPLNN016003;
        Thu, 14 Dec 2023 11:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=qcppdkim1; bh=hfMKRVn
        pBaCu6d6aUwhdQLjOhhBXaGuNFVwN6cK+sqg=; b=SbW8yd0tTpQ566T+gzGVrah
        XiqsllHRAdb4CXBnjt0JN21aAZLXYgXl4KyQGl64WBb72jj7R0buELSHClnIoq8h
        /dDywnmwZnYEIYA6FNC3l2t1z/lkXuQ5IiATHrS2d0YqtU0TKJjHld/R82IgfBL6
        8R0J0zvfkIz41LfWOEqtS7WFMwtxglBbgbkNf48CYKF6kJ1GZWLhE5DQIsQqXxmf
        L7JR02t6ulxc6p9IlNpFD09n75zK8Mda0k0CblP0Go2/hPd+zCAu1ky8eeMLs52a
        7rptjm2maVni001slkNVVGGeTwI7QMdz23Rgynm1JVzdRPwBqBslO9gvELP06HQ=
        =
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyp0p9a3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 11:42:48 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BEBexrD001132;
        Thu, 14 Dec 2023 11:42:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3uvhaktch9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 11:42:45 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEBgijg003213;
        Thu, 14 Dec 2023 11:42:44 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3BEBgiLr003203
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 11:42:44 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
        id A2FC041675; Thu, 14 Dec 2023 17:12:42 +0530 (+0530)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     thara.gopinath@gmail.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, vkoul@kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        quic_srichara@quicinc.com, quic_varada@quicinc.com
Cc:     quic_mdalam@quicinc.com
Subject: [PATCH 10/11] crypto: qce - Add support for lock/unlock in sha
Date:   Thu, 14 Dec 2023 17:12:38 +0530
Message-Id: <20231214114239.2635325-11-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
References: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1A59z-BMlZOsEGQqFZMD1oqtBwMfspnP
X-Proofpoint-GUID: 1A59z-BMlZOsEGQqFZMD1oqtBwMfspnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add support for lock/unlock on bam pipe in sha.
If multiple EE's(Execution Environment) try to access
the same crypto engine then before accessing the crypto
engine EE's has to lock the bam pipe and then submit the
request to crypto engine. Once request done then EE's has
to unlock the bam pipe so that others EE's can access the
crypto engine.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/crypto/qce/sha.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index f850c6206a31..942aecbb0736 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -47,6 +47,8 @@ static void qce_ahash_done(void *data)
 	int error;
 	u32 status;
 
+	qce_bam_release_lock(qce);
+
 	error = qce_dma_terminate_all(&qce->dma);
 	if (error)
 		dev_dbg(qce->dev, "ahash dma termination error (%d)\n", error);
@@ -102,6 +104,8 @@ static int qce_ahash_async_req_handle(struct crypto_async_request *async_req)
 		rctx->authklen = AES_KEYSIZE_128;
 	}
 
+	qce_bam_acquire_lock(qce);
+
 	rctx->src_nents = sg_nents_for_len(req->src, req->nbytes);
 	if (rctx->src_nents < 0) {
 		dev_err(qce->dev, "Invalid numbers of src SG.\n");
-- 
2.34.1

