Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD407B1F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjI1OeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjI1OeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:34:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1781B4;
        Thu, 28 Sep 2023 07:34:00 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SEGNIg022118;
        Thu, 28 Sep 2023 14:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 mime-version : content-type : content-transfer-encoding : message-id :
 references : in-reply-to : to : cc; s=pp1;
 bh=I5AWqN4OSuucaaUZyzTWZgZxubpRK5rOOUlzsWX4m34=;
 b=lW2pEAvqIq2U56CAuyZZ30EgGbNtgIhCsbT4wckhR5eoOxCriFetzpYmN+5THgrGvqkh
 U3Qgfx3JNP4TuuqCwiyVa00oKRcMrQ6a2H6PdqvhjHVIX2XQ0c7aOCxGyC2zQ5oS/xOl
 qPgbo4QHMO+pywnqKIHVLnfDYYCWi6L1cebFU/au43s1hjrSvg4CLC7f//r5MKjMkXFR
 O2/UMdNLKYsJbPOyZAYEbo9ul3DWDz7gqFmQLMKKG/edWTiWDZku8qt3WWPiJF+mqCtZ
 NfrwrDfVX7i3o15nCZQ5nuud0ULl+m7BRgTb7ZccVK3Jqp6WBnCfhRr+T0FCM54WlM1t Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td9we2u7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 14:33:15 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38SEHbB1025175;
        Thu, 28 Sep 2023 14:32:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td9we2tmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 14:32:59 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38SDcYOg008192;
        Thu, 28 Sep 2023 14:32:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabbnn36r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 14:32:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38SEWbxU721478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 14:32:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9C2820043;
        Thu, 28 Sep 2023 14:32:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E52E02004B;
        Thu, 28 Sep 2023 14:32:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 28 Sep 2023 14:32:36 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Thu, 28 Sep 2023 16:31:40 +0200
Subject: [PATCH v13 6/6] iommu/dma: Use a large flush queue and timeout for
 shadow_on_flush
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230928-dma_iommu-v13-6-9e5fc4dacc36@linux.ibm.com>
References: <20230928-dma_iommu-v13-0-9e5fc4dacc36@linux.ibm.com>
In-Reply-To: <20230928-dma_iommu-v13-0-9e5fc4dacc36@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6202;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=4PLrVGKVmJm/qlVAFXas/tczy6T+AoG75pq6YPmRiXM=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFJF+yrTnOT3fb5+OOLqTQYjh8w1zXebDx1tLDwiG9A1/
 d+O245POkpZGMQ4GGTFFFkWdTn7rSuYYronqL8DZg4rE8gQBi5OAZjI815GhoXH/j3ykn8YvOav
 Q9W0FQHTJFvXFRY1dx/lPy8hVNK9eSPD/3ShAruymbZtpy/Oep1qEvZM96Xd3P8PNTfvcjnM/WN
 hPSMA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zp6JyqZqz9xJHxZ8VS_yVSiOeikaWzND
X-Proofpoint-ORIG-GUID: OziLHK563MojiA2BYbPn4z6EVzkRyrWM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_13,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flush queues currently use a fixed compile time size of 256 entries.
This being a power of 2 allows the compiler to use shift and mask
instead of more expensive modulo operations. With per-CPU flush queues
larger queue sizes would hit per-CPU allocation limits, with a single
flush queue these limits do not apply however. Also with single queues
being particularly suitable for virtualized environments with expensive
IOTLB flushes these benefit especially from larger queues and thus fewer
flushes.

To this end re-order struct iova_fq so we can use a dynamic array and
introduce the flush queue size and timeouts as new options in the
iommu_dma_options struct. So as not to lose the shift and mask
optimization, use a power of 2 for the length and use explicit shift and
mask instead of letting the compiler optimize this.

A large queue size and 1 second timeout is then set for the shadow on
flush case set by s390 paged memory guests. This then brings performance
on par with the previous s390 specific DMA API implementation.

Acked-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com> #s390
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/dma-iommu.c | 50 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a85ff75ad531..85163a83df2f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -50,6 +50,8 @@ enum iommu_dma_queue_type {
 
 struct iommu_dma_options {
 	enum iommu_dma_queue_type qt;
+	size_t		fq_size;
+	unsigned int	fq_timeout;
 };
 
 struct iommu_dma_cookie {
@@ -98,10 +100,12 @@ static int __init iommu_dma_forcedac_setup(char *str)
 early_param("iommu.forcedac", iommu_dma_forcedac_setup);
 
 /* Number of entries per flush queue */
-#define IOVA_FQ_SIZE	256
+#define IOVA_DEFAULT_FQ_SIZE	256
+#define IOVA_SINGLE_FQ_SIZE	32768
 
 /* Timeout (in ms) after which entries are flushed from the queue */
-#define IOVA_FQ_TIMEOUT	10
+#define IOVA_DEFAULT_FQ_TIMEOUT	10
+#define IOVA_SINGLE_FQ_TIMEOUT	1000
 
 /* Flush queue entry for deferred flushing */
 struct iova_fq_entry {
@@ -113,18 +117,19 @@ struct iova_fq_entry {
 
 /* Per-CPU flush queue structure */
 struct iova_fq {
-	struct iova_fq_entry entries[IOVA_FQ_SIZE];
-	unsigned int head, tail;
 	spinlock_t lock;
+	unsigned int head, tail;
+	unsigned int mod_mask;
+	struct iova_fq_entry entries[];
 };
 
 #define fq_ring_for_each(i, fq) \
-	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
+	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) & (fq)->mod_mask)
 
 static inline bool fq_full(struct iova_fq *fq)
 {
 	assert_spin_locked(&fq->lock);
-	return (((fq->tail + 1) % IOVA_FQ_SIZE) == fq->head);
+	return (((fq->tail + 1) & fq->mod_mask) == fq->head);
 }
 
 static inline unsigned int fq_ring_add(struct iova_fq *fq)
@@ -133,7 +138,7 @@ static inline unsigned int fq_ring_add(struct iova_fq *fq)
 
 	assert_spin_locked(&fq->lock);
 
-	fq->tail = (idx + 1) % IOVA_FQ_SIZE;
+	fq->tail = (idx + 1) & fq->mod_mask;
 
 	return idx;
 }
@@ -155,7 +160,7 @@ static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
 
-		fq->head = (fq->head + 1) % IOVA_FQ_SIZE;
+		fq->head = (fq->head + 1) & fq->mod_mask;
 	}
 }
 
@@ -240,7 +245,7 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
 	if (!atomic_read(&cookie->fq_timer_on) &&
 	    !atomic_xchg(&cookie->fq_timer_on, 1))
 		mod_timer(&cookie->fq_timer,
-			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
+			  jiffies + msecs_to_jiffies(cookie->options.fq_timeout));
 }
 
 static void iommu_dma_free_fq_single(struct iova_fq *fq)
@@ -279,27 +284,29 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
 		iommu_dma_free_fq_percpu(cookie->percpu_fq);
 }
 
-static void iommu_dma_init_one_fq(struct iova_fq *fq)
+static void iommu_dma_init_one_fq(struct iova_fq *fq, size_t fq_size)
 {
 	int i;
 
 	fq->head = 0;
 	fq->tail = 0;
+	fq->mod_mask = fq_size - 1;
 
 	spin_lock_init(&fq->lock);
 
-	for (i = 0; i < IOVA_FQ_SIZE; i++)
+	for (i = 0; i < fq_size; i++)
 		INIT_LIST_HEAD(&fq->entries[i].freelist);
 }
 
 static int iommu_dma_init_fq_single(struct iommu_dma_cookie *cookie)
 {
+	size_t fq_size = cookie->options.fq_size;
 	struct iova_fq *queue;
 
-	queue = vmalloc(sizeof(*queue));
+	queue = vmalloc(struct_size(queue, entries, fq_size));
 	if (!queue)
 		return -ENOMEM;
-	iommu_dma_init_one_fq(queue);
+	iommu_dma_init_one_fq(queue, fq_size);
 	cookie->single_fq = queue;
 
 	return 0;
@@ -307,15 +314,17 @@ static int iommu_dma_init_fq_single(struct iommu_dma_cookie *cookie)
 
 static int iommu_dma_init_fq_percpu(struct iommu_dma_cookie *cookie)
 {
+	size_t fq_size = cookie->options.fq_size;
 	struct iova_fq __percpu *queue;
 	int cpu;
 
-	queue = alloc_percpu(struct iova_fq);
+	queue = __alloc_percpu(struct_size(queue, entries, fq_size),
+			       __alignof__(*queue));
 	if (!queue)
 		return -ENOMEM;
 
 	for_each_possible_cpu(cpu)
-		iommu_dma_init_one_fq(per_cpu_ptr(queue, cpu));
+		iommu_dma_init_one_fq(per_cpu_ptr(queue, cpu), fq_size);
 	cookie->percpu_fq = queue;
 	return 0;
 }
@@ -635,11 +644,16 @@ static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 static void iommu_dma_init_options(struct iommu_dma_options *options,
 				   struct device *dev)
 {
-	/* Shadowing IOTLB flushes do better with a single queue */
-	if (dev->iommu->shadow_on_flush)
+	/* Shadowing IOTLB flushes do better with a single large queue */
+	if (dev->iommu->shadow_on_flush) {
 		options->qt = IOMMU_DMA_OPTS_SINGLE_QUEUE;
-	else
+		options->fq_timeout = IOVA_SINGLE_FQ_TIMEOUT;
+		options->fq_size = IOVA_SINGLE_FQ_SIZE;
+	} else {
 		options->qt = IOMMU_DMA_OPTS_PER_CPU_QUEUE;
+		options->fq_size = IOVA_DEFAULT_FQ_SIZE;
+		options->fq_timeout = IOVA_DEFAULT_FQ_TIMEOUT;
+	}
 }
 
 /**

-- 
2.39.2

