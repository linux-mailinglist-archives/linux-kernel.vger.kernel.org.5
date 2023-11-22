Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6DB7F4818
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344247AbjKVNsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343843AbjKVNsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:48:33 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7A3BC;
        Wed, 22 Nov 2023 05:48:29 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM9MZl1016892;
        Wed, 22 Nov 2023 13:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=S4cI9vJXYr7sLH3ZEI3DdEwpZEQgnHH0HYsAhljLNE0=;
 b=b3AxD/xYkelorsqQW1/P0j9rGRJujQfMBYywztP/VXOTeYkVPHYtStRCEOSFHgXQJ1Iw
 uqRgF6PjiAhzTBWb693F3ilxrLJn0M/36qp6xFFK/mI+OJLPodYtP7fpu9Iha1Q9KqIJ
 1XZjg6JRrbNaQAS7zStF8OApt7VnnGfXLcDml9fjPAlWyXvHdEt/UL61pe9al2HBXVI3
 OwX6HtZTeQj/G0N2tVgugNPWz9oI4i1q97YXTOWN7nQTwVpUnr8OlxMoc8ehziG8qrn6
 9UtBJYjcf9Y4qceiQmQHw5X5UsjA3LvypGDA3wRXxOPaO6WcXNQoMm8Zl1sUnUUjh9Ap iA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhey58kut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 13:48:18 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AMDmHna006808
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 13:48:17 GMT
Received: from hu-pbrahma-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 05:48:13 -0800
From:   Pratyush Brahma <quic_pbrahma@quicinc.com>
To:     <sumit.semwal@linaro.org>, <benjamin.gaignard@collabora.com>,
        <Brian.Starkey@arm.com>, <jstultz@google.com>,
        <tjmercier@google.com>, <christian.koenig@amd.com>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <quic_guptap@quicinc.com>
CC:     Vijayanand Jitta <quic_vjitta@quicinc.com>
Subject: [PATCH 1/2] dma-buf: heaps: secure_heap: Add secure ops for CMA heap
Date:   Wed, 22 Nov 2023 19:17:46 +0530
Message-ID: <50efb85e259020cf011ba33cffc092e1115b1442.1700544802.git.quic_vjitta@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1700544802.git.quic_vjitta@quicinc.com>
References: <cover.1700544802.git.quic_vjitta@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vseFvjOoKkok0GZGKOSGYWUoQEY1XO2B
X-Proofpoint-GUID: vseFvjOoKkok0GZGKOSGYWUoQEY1XO2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220097
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayanand Jitta <quic_vjitta@quicinc.com>

Add secure ops for CMA heap which would use qcom_scm_assign_mem
to assign the memory to VMID.

Change-Id: I05aff9cb9b7b9668c4352a24bec163b52e38835a
Signed-off-by: Vijayanand Jitta <quic_vjitta@quicinc.com>
---
 drivers/dma-buf/heaps/secure_heap.c | 50 +++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/heaps/secure_heap.c b/drivers/dma-buf/heaps/secure_heap.c
index 8989ad5d03e9..04e2ee000e19 100644
--- a/drivers/dma-buf/heaps/secure_heap.c
+++ b/drivers/dma-buf/heaps/secure_heap.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include <linux/uuid.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 
 #define TZ_TA_MEM_UUID_MTK		"4477588a-8476-11e2-ad15-e41f1390d676"
 
@@ -83,6 +84,12 @@ struct secure_heap_prv_data {
 	 */
 	const int			tee_command_id_base;
 
+	/*
+	 * VMID and permissions which will be used by QCOM secure system heap to assign mem.
+	 */
+	int	vmid;
+	int 	perm;
+
 	int	(*heap_init)(struct secure_heap *sec_heap);
 	int	(*memory_alloc)(struct secure_heap *sec_heap, struct secure_buffer *sec_buf);
 	void	(*memory_free)(struct secure_heap *sec_heap, struct secure_buffer *sec_buf);
@@ -311,10 +318,47 @@ static void cma_secure_memory_free(struct secure_heap *sec_heap,
 	cma_release(sec_heap->cma, sec_buf->cma_page, sec_buf->size >> PAGE_SHIFT);
 }
 
-const struct secure_heap_prv_data cma_sec_mem_data = {
+static int secure_heap_qcom_secure_memory(struct secure_heap *sec_heap,
+					 struct secure_buffer *sec_buf)
+{
+	struct qcom_scm_vmperm next[1];
+	u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+	const struct secure_heap_prv_data *data = sec_heap->data;
+	int ret = 0;
+
+	next[0].vmid = data->vmid;
+	next[0].perm = data->perm;
+
+
+	ret = qcom_scm_assign_mem(page_to_phys(sec_buf->cma_page),
+				sec_buf->size, &src_perms,
+				next, 1);
+
+	return ret;
+}
+
+static void secure_heap_qcom_unsecure_memory(struct secure_heap *sec_heap,
+					    struct secure_buffer *sec_buf)
+{
+	struct qcom_scm_vmperm next[1];
+	const struct secure_heap_prv_data *data = sec_heap->data;
+	u64 src_perms = BIT(data->vmid);
+
+	next[0].vmid = QCOM_SCM_VMID_HLOS;
+	next[0].perm = QCOM_SCM_PERM_RWX;
+
+	qcom_scm_assign_mem(page_to_phys(sec_buf->cma_page),
+				sec_buf->size, &src_perms,
+				next, 1);
+}
+
+const struct secure_heap_prv_data qcom_cma_sec_mem_data = {
+	.vmid           = QCOM_SCM_VMID_CP_BITSTREAM,
+	.perm		= QCOM_SCM_PERM_RW,
 	.memory_alloc	= cma_secure_memory_allocate,
 	.memory_free	= cma_secure_memory_free,
-	/* TODO : secure the buffer. */
+	.secure_the_memory      = secure_heap_qcom_secure_memory,
+	.unsecure_the_memory    = secure_heap_qcom_unsecure_memory,
 };
 
 static int secure_heap_secure_memory_allocate(struct secure_heap *sec_heap,
@@ -529,7 +573,7 @@ static struct secure_heap secure_heaps[] = {
 	{
 		.name		= "secure_cma",
 		.mem_type	= SECURE_MEMORY_TYPE_CMA,
-		.data		= &cma_sec_mem_data,
+		.data		= &qcom_cma_sec_mem_data,
 	},
 	{
 		.name		= "secure_mtk_cm",
-- 
2.34.1

