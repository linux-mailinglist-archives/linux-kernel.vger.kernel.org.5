Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B21812EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444157AbjLNLnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444034AbjLNLmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:42:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D48E118;
        Thu, 14 Dec 2023 03:42:57 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE4rfVc031223;
        Thu, 14 Dec 2023 11:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=qcppdkim1; bh=lipEObU
        Ox4tPGntPWF5hSv0Uav0/QkbOaL27SH4oLR8=; b=pnLE4QvJVHy83MvYBK35hSL
        v4w8RUHBOhjasoMX6d1cuIjhAlvFxhY/d6jRX33Rq9I6hPwPbQCZ6iuTBrnuSaHj
        v48aEYGdpTCqKX5RxJE4q9yv9gQclOnED4ZyqOfalgvbAek77ZppXDoNXfoy/+Wd
        DCkKuD2dsSh0wZO0wFxNiD8kXMCDjXFyxA+bW7cvS+GYRoxeYjp/Vz0DB0ektXL+
        fx+c0XK9Vl3uTs5iwpqzc+vsrMSZT+fftBYeRLZul7vQ+YMQGMP07/7qYgu9va12
        7xxpRxvccX+V+vt2N8fEMZPQXSjWw7d7A5YXJdq1ybwpCSS39DRqF+bFwQsV5sQ=
        =
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uytn68t8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 11:42:48 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BEBgio2003267;
        Thu, 14 Dec 2023 11:42:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3uvhaktchp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 11:42:44 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEBgiaN003237;
        Thu, 14 Dec 2023 11:42:44 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3BEBgiuM003209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 11:42:44 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
        id 9831D41662; Thu, 14 Dec 2023 17:12:42 +0530 (+0530)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     thara.gopinath@gmail.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, vkoul@kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        quic_srichara@quicinc.com, quic_varada@quicinc.com
Cc:     quic_mdalam@quicinc.com
Subject: [PATCH 07/11] crypto: qce - Add LOCK and UNLOCK flag support
Date:   Thu, 14 Dec 2023 17:12:35 +0530
Message-Id: <20231214114239.2635325-8-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
References: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yin6i0nG52r_6oC9o7j0QICGo5KOt61L
X-Proofpoint-ORIG-GUID: yin6i0nG52r_6oC9o7j0QICGo5KOt61L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140079
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LOCK and UNLOCK flag support while preapring
command descriptor for writing crypto register.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/crypto/qce/dma.c | 7 ++++++-
 drivers/crypto/qce/dma.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 85c8d4107afa..bda60e6bc4b3 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -71,7 +71,12 @@ int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags)
 	unsigned long desc_flags;
 	int ret = 0;
 
-	desc_flags = DMA_PREP_CMD;
+	if (flags & QCE_DMA_DESC_FLAG_LOCK)
+		desc_flags = DMA_PREP_CMD | DMA_PREP_LOCK;
+	else if (flags & QCE_DMA_DESC_FLAG_UNLOCK)
+		desc_flags = DMA_PREP_CMD | DMA_PREP_UNLOCK;
+	else
+		desc_flags = DMA_PREP_CMD;
 
 	/* For command descriptor always use consumer pipe
 	 * it recomended as per HPG
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index f10991590b3f..ad8a18a720b1 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -19,6 +19,8 @@
 #define QCE_BAM_CMD_ELEMENT_SIZE       64
 #define QCE_DMA_DESC_FLAG_BAM_NWD      (0x0004)
 #define QCE_MAX_REG_READ               8
+#define QCE_DMA_DESC_FLAG_LOCK          (0x0002)
+#define QCE_DMA_DESC_FLAG_UNLOCK        (0x0001)
 
 struct qce_result_dump {
 	u32 auth_iv[QCE_AUTHIV_REGS_CNT];
-- 
2.34.1

