Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56FC756115
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjGQLD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjGQLDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:03:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CB81B9;
        Mon, 17 Jul 2023 04:03:51 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HAmqLh011829;
        Mon, 17 Jul 2023 11:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 mime-version : content-type : content-transfer-encoding : message-id :
 references : in-reply-to : to : cc; s=pp1;
 bh=QfC7DpEZwICZV9UBYgnbi/++ZFK6DVmVl7p0Ucfk0Fk=;
 b=Q0EIlGhfYHPud9WRJbdDOHrFiTE/i/2HekziaS/w3DCVB2ylt5A8D+8mFWPsK1pASbCW
 t2Te6ecmWjuCE/5Ad1LBupwn1bfdURtXsNFn/79RCXsIBa4hW8pnKB0Fqd15eLyr+t52
 j6Joa6JG/DKsgPOCAx/ZKKNhOBfxj/5kz64fENsROlhQBaxog9xxIAlqEe9RDbZ5FCut
 sBXObbf2qkvC+Rey1WKnhHQUtxyDu7nEv4plKHgDDEgE5oK7qRaX+fp5JpHeXpiGsQGl
 MI97hnB+HB1b4KfZAtjngOZWU6ec6iWUlOe1KOzizI1QE3/qPThvhdypj1oQOmjodE2U FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw47cra4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 11:02:06 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36HAnqxO014230;
        Mon, 17 Jul 2023 11:02:05 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw47cra42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 11:02:05 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36H8s7bS005651;
        Mon, 17 Jul 2023 11:02:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rujqe148f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 11:02:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36HB1w3516450168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 11:01:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D277E20040;
        Mon, 17 Jul 2023 11:01:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 502762004B;
        Mon, 17 Jul 2023 11:01:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jul 2023 11:01:57 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Mon, 17 Jul 2023 13:00:06 +0200
Subject: [PATCH v11 6/6] iommu/dma: Use a large flush queue and timeout for
 shadow_on_flush
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-dma_iommu-v11-6-a7a0b83c355c@linux.ibm.com>
References: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
In-Reply-To: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6725;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=hMEGQADFlKz/+dWnWnhcMKyntVQEqF5IqIj7yvUb6Nc=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFK2yk/Z7u21YMrlG4zLk9JnvZ7/T1z4aNL51Fn1e88LL
 1kxJ/7V5o5SFgYxDgZZMUWWRV3OfusKppjuCervgJnDygQyhIGLUwAm4hPMyLBNbKIOl6rflsCP
 J74a83TuuBtmJz81wCfRLi0ks13r5x1Ghu9um92VxXmdeDh93abutD73atPHbOcZVTfv13eVfPp
 wgh8A
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ECeJRw806_zvpwQSyh4hcjMvvBtQhpYk
X-Proofpoint-ORIG-GUID: 3vwgh8YSMhNi-_G1hUFZ_rpvWw3yEpI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307170096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
dma_iommu_options struct. So as not to lose the shift and mask
optimization, use a power of 2 for the length and use explicit shift and
mask instead of letting the compiler optimize this.

A large queue size and 1 second timeout is then set for the shadow on
flush case set by s390 paged memory guests. This then brings performance
on par with the previous s390 specific DMA API implementation.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com> #s390
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/dma-iommu.c | 50 +++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4ada8b9749c9..bebc0804ff53 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -46,7 +46,9 @@ enum iommu_dma_cookie_type {
 struct dma_iommu_options {
 #define IOMMU_DMA_OPTS_PER_CPU_QUEUE	0L
 #define IOMMU_DMA_OPTS_SINGLE_QUEUE	BIT(0)
-	u64	flags;
+	u64		flags;
+	size_t		fq_size;
+	unsigned int	fq_timeout;
 };
 
 struct iommu_dma_cookie {
@@ -95,10 +97,12 @@ static int __init iommu_dma_forcedac_setup(char *str)
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
@@ -110,18 +114,19 @@ struct iova_fq_entry {
 
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
@@ -130,7 +135,7 @@ static inline unsigned int fq_ring_add(struct iova_fq *fq)
 
 	assert_spin_locked(&fq->lock);
 
-	fq->tail = (idx + 1) % IOVA_FQ_SIZE;
+	fq->tail = (idx + 1) & fq->mod_mask;
 
 	return idx;
 }
@@ -152,7 +157,7 @@ static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
 
-		fq->head = (fq->head + 1) % IOVA_FQ_SIZE;
+		fq->head = (fq->head + 1) & fq->mod_mask;
 	}
 }
 
@@ -246,7 +251,7 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
 	if (!atomic_read(&cookie->fq_timer_on) &&
 	    !atomic_xchg(&cookie->fq_timer_on, 1))
 		mod_timer(&cookie->fq_timer,
-			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
+			  jiffies + msecs_to_jiffies(cookie->options.fq_timeout));
 }
 
 static void iommu_dma_free_fq_single(struct iova_fq *fq)
@@ -287,27 +292,29 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
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
 
-	queue = vzalloc(sizeof(*queue));
+	queue = vzalloc(struct_size(queue, entries, fq_size));
 	if (!queue)
 		return -ENOMEM;
-	iommu_dma_init_one_fq(queue);
+	iommu_dma_init_one_fq(queue, fq_size);
 	cookie->single_fq = queue;
 
 	return 0;
@@ -315,15 +322,17 @@ static int iommu_dma_init_fq_single(struct iommu_dma_cookie *cookie)
 
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
@@ -377,6 +386,8 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
 		INIT_LIST_HEAD(&cookie->msi_page_list);
 		cookie->type = type;
 		cookie->options.flags = IOMMU_DMA_OPTS_PER_CPU_QUEUE;
+		cookie->options.fq_size = IOVA_DEFAULT_FQ_SIZE;
+		cookie->options.fq_timeout = IOVA_DEFAULT_FQ_TIMEOUT;
 	}
 	return cookie;
 }
@@ -696,14 +707,19 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	if (domain->type == IOMMU_DOMAIN_DMA_FQ) {
 		/* Expensive shadowing IOTLB flushes require some tuning */
-		if (dev->iommu->shadow_on_flush)
+		if (dev->iommu->shadow_on_flush) {
 			cookie->options.flags |= IOMMU_DMA_OPTS_SINGLE_QUEUE;
+			cookie->options.fq_timeout = IOVA_SINGLE_FQ_TIMEOUT;
+			cookie->options.fq_size = IOVA_SINGLE_FQ_SIZE;
+		}
 
 		/* If the FQ fails we can simply fall back to strict mode */
 		if (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) ||
 		    iommu_dma_init_fq(domain)) {
 			domain->type = IOMMU_DOMAIN_DMA;
 			cookie->options.flags &= ~IOMMU_DMA_OPTS_SINGLE_QUEUE;
+			cookie->options.fq_timeout = IOVA_DEFAULT_FQ_TIMEOUT;
+			cookie->options.fq_size = IOVA_DEFAULT_FQ_SIZE;
 		}
 	}
 

-- 
2.39.2

