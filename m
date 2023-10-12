Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF947C6BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378176AbjJLLM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347154AbjJLLM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:12:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980FFCA;
        Thu, 12 Oct 2023 04:12:24 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C9rPr8020129;
        Thu, 12 Oct 2023 11:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Wad0ld8fBaOFsRuaoa9MCZdNhz5XSOOmm/PwmyCiGok=;
 b=GsUF2keC0fgt/Y+fQ0yJ7y5A9dOw6cVUU1UW84tRhuQkcZ7SFMFQkArnA5ngnhRwMK2E
 YYk84bGzmzDb91MJdclvlvZ2j/pTujZOBNO820f9mOTLNVjiqLbGzr9h2BvAZOTjmstj
 H1uI/XB0khU4iaCf+z83RflhWUsbHL49cT/MncvhSBitVxKMFoKfjWGALtRz4+AVE0/S
 NyPv7PK7GsWzmITH7y9g65FtrOrYt0nT3cT2worciOYmSOHe6oRucvwhtjakBp97BkgR
 61SlXAx1nuTa6ZcRJf/2VQBTXamZB6TJFvDQwJkvdbS4p0xFNQ0iA1IWkfMC+myOJvLj uQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpd480965-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 11:12:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39CBC92H018941
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 11:12:10 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 12 Oct 2023 04:12:06 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Shilpa Suresh <quic_c_sbsure@quicinc.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
Subject: [PATCH] coresight: etr: Use noncontiguous api instead of noncoherent
Date:   Thu, 12 Oct 2023 19:11:52 +0800
Message-ID: <20231012111152.37849-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LleLBYSHs7md_mnIwcGwIyBq-B8CyXIV
X-Proofpoint-ORIG-GUID: LleLBYSHs7md_mnIwcGwIyBq-B8CyXIV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=807 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310120091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shilpa Suresh <quic_c_sbsure@quicinc.com>

The iommu support for noncoherent is removed by commit(dma-mapping:
remove the {alloc,free}_noncoherent methods
81d88ce55092edf1a1f928efb373f289c6b90efd). Use alloc_noncontiguous
function for etr flat buffer allocation.

Signed-off-by: Shilpa Suresh <quic_c_sbsure@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 47 ++++++++++++++-----
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 66dc5f97a009..80e5aa4a16c9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -24,6 +24,7 @@ struct etr_flat_buf {
 	dma_addr_t	daddr;
 	void		*vaddr;
 	size_t		size;
+	struct sg_table	*sgt;
 };
 
 /*
@@ -608,14 +609,24 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
 	if (!flat_buf)
 		return -ENOMEM;
 
-	flat_buf->vaddr = dma_alloc_noncoherent(real_dev, etr_buf->size,
-						&flat_buf->daddr,
-						DMA_FROM_DEVICE, GFP_KERNEL);
-	if (!flat_buf->vaddr) {
+	flat_buf->sgt = dma_alloc_noncontiguous(real_dev, etr_buf->size,
+						DMA_FROM_DEVICE, GFP_KERNEL, 0);
+	if (!flat_buf->sgt) {
 		kfree(flat_buf);
 		return -ENOMEM;
 	}
 
+	flat_buf->daddr = sg_dma_address(flat_buf->sgt->sgl);
+	flat_buf->vaddr = dma_vmap_noncontiguous(real_dev, etr_buf->size,
+						flat_buf->sgt);
+	if (!flat_buf->vaddr) {
+		dma_free_noncontiguous(real_dev, etr_buf->size,
+					flat_buf->sgt,
+					DMA_FROM_DEVICE);
+		flat_buf->sgt = NULL;
+		return -ENOMEM;
+	}
+
 	flat_buf->size = etr_buf->size;
 	flat_buf->dev = &drvdata->csdev->dev;
 	etr_buf->hwaddr = flat_buf->daddr;
@@ -631,9 +642,12 @@ static void tmc_etr_free_flat_buf(struct etr_buf *etr_buf)
 	if (flat_buf && flat_buf->daddr) {
 		struct device *real_dev = flat_buf->dev->parent;
 
-		dma_free_noncoherent(real_dev, etr_buf->size,
-				     flat_buf->vaddr, flat_buf->daddr,
+		dma_vunmap_noncontiguous(real_dev, flat_buf->vaddr);
+		dma_free_noncontiguous(real_dev, etr_buf->size,
+				     flat_buf->sgt,
 				     DMA_FROM_DEVICE);
+		flat_buf->vaddr = NULL;
+		flat_buf->sgt = NULL;
 	}
 	kfree(flat_buf);
 }
@@ -642,6 +656,9 @@ static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
 {
 	struct etr_flat_buf *flat_buf = etr_buf->private;
 	struct device *real_dev = flat_buf->dev->parent;
+	s64 buf_len;
+	int i;
+	struct scatterlist *sg;
 
 	/*
 	 * Adjust the buffer to point to the beginning of the trace data
@@ -658,13 +675,19 @@ static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
 	 * the only reason why we would get a wrap around is when the buffer
 	 * is full.  Sync the entire buffer in one go for this case.
 	 */
+
 	if (etr_buf->offset + etr_buf->len > etr_buf->size)
-		dma_sync_single_for_cpu(real_dev, flat_buf->daddr,
-					etr_buf->size, DMA_FROM_DEVICE);
-	else
-		dma_sync_single_for_cpu(real_dev,
-					flat_buf->daddr + etr_buf->offset,
-					etr_buf->len, DMA_FROM_DEVICE);
+		dma_sync_sgtable_for_cpu(real_dev, flat_buf->sgt,
+					DMA_FROM_DEVICE);
+	else {
+		buf_len = etr_buf->len;
+		for_each_sg(flat_buf->sgt->sgl, sg, flat_buf->sgt->orig_nents, i) {
+			dma_sync_sg_for_cpu(real_dev, sg, 1, DMA_FROM_DEVICE);
+			buf_len -= sg->length;
+			if (buf_len <= 0)
+				break;
+		}
+	}
 }
 
 static ssize_t tmc_etr_get_data_flat_buf(struct etr_buf *etr_buf,
-- 
2.17.1

