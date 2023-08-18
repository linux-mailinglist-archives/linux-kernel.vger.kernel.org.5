Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD281781339
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379564AbjHRTHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379563AbjHRTHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:07:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1426130FE;
        Fri, 18 Aug 2023 12:06:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CC70D75;
        Fri, 18 Aug 2023 12:07:38 -0700 (PDT)
Received: from [10.57.91.158] (unknown [10.57.91.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14C993F762;
        Fri, 18 Aug 2023 12:06:49 -0700 (PDT)
Message-ID: <7b01f4ae-05d9-e7b8-7a44-31c9d8adae80@arm.com>
Date:   Fri, 18 Aug 2023 20:06:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v11 6/6] iommu/dma: Use a large flush queue and timeout
 for shadow_on_flush
Content-Language: en-GB
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
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
        Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
 <20230717-dma_iommu-v11-6-a7a0b83c355c@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230717-dma_iommu-v11-6-a7a0b83c355c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-17 12:00, Niklas Schnelle wrote:
> Flush queues currently use a fixed compile time size of 256 entries.
> This being a power of 2 allows the compiler to use shift and mask
> instead of more expensive modulo operations. With per-CPU flush queues
> larger queue sizes would hit per-CPU allocation limits, with a single
> flush queue these limits do not apply however. Also with single queues
> being particularly suitable for virtualized environments with expensive
> IOTLB flushes these benefit especially from larger queues and thus fewer
> flushes.
> 
> To this end re-order struct iova_fq so we can use a dynamic array and
> introduce the flush queue size and timeouts as new options in the
> dma_iommu_options struct. So as not to lose the shift and mask
> optimization, use a power of 2 for the length and use explicit shift and
> mask instead of letting the compiler optimize this.
> 
> A large queue size and 1 second timeout is then set for the shadow on
> flush case set by s390 paged memory guests. This then brings performance
> on par with the previous s390 specific DMA API implementation.
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com> #s390
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/iommu/dma-iommu.c | 50 +++++++++++++++++++++++++++++++----------------
>   1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 4ada8b9749c9..bebc0804ff53 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -46,7 +46,9 @@ enum iommu_dma_cookie_type {
>   struct dma_iommu_options {
>   #define IOMMU_DMA_OPTS_PER_CPU_QUEUE	0L
>   #define IOMMU_DMA_OPTS_SINGLE_QUEUE	BIT(0)
> -	u64	flags;
> +	u64		flags;
> +	size_t		fq_size;
> +	unsigned int	fq_timeout;
>   };
>   
>   struct iommu_dma_cookie {
> @@ -95,10 +97,12 @@ static int __init iommu_dma_forcedac_setup(char *str)
>   early_param("iommu.forcedac", iommu_dma_forcedac_setup);
>   
>   /* Number of entries per flush queue */
> -#define IOVA_FQ_SIZE	256
> +#define IOVA_DEFAULT_FQ_SIZE	256
> +#define IOVA_SINGLE_FQ_SIZE	32768
>   
>   /* Timeout (in ms) after which entries are flushed from the queue */
> -#define IOVA_FQ_TIMEOUT	10
> +#define IOVA_DEFAULT_FQ_TIMEOUT	10
> +#define IOVA_SINGLE_FQ_TIMEOUT	1000
>   
>   /* Flush queue entry for deferred flushing */
>   struct iova_fq_entry {
> @@ -110,18 +114,19 @@ struct iova_fq_entry {
>   
>   /* Per-CPU flush queue structure */
>   struct iova_fq {
> -	struct iova_fq_entry entries[IOVA_FQ_SIZE];
> -	unsigned int head, tail;
>   	spinlock_t lock;
> +	unsigned int head, tail;
> +	unsigned int mod_mask;
> +	struct iova_fq_entry entries[];
>   };
>   
>   #define fq_ring_for_each(i, fq) \
> -	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
> +	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) & (fq)->mod_mask)
>   
>   static inline bool fq_full(struct iova_fq *fq)
>   {
>   	assert_spin_locked(&fq->lock);
> -	return (((fq->tail + 1) % IOVA_FQ_SIZE) == fq->head);
> +	return (((fq->tail + 1) & fq->mod_mask) == fq->head);
>   }
>   
>   static inline unsigned int fq_ring_add(struct iova_fq *fq)
> @@ -130,7 +135,7 @@ static inline unsigned int fq_ring_add(struct iova_fq *fq)
>   
>   	assert_spin_locked(&fq->lock);
>   
> -	fq->tail = (idx + 1) % IOVA_FQ_SIZE;
> +	fq->tail = (idx + 1) & fq->mod_mask;
>   
>   	return idx;
>   }
> @@ -152,7 +157,7 @@ static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq
>   			       fq->entries[idx].iova_pfn,
>   			       fq->entries[idx].pages);
>   
> -		fq->head = (fq->head + 1) % IOVA_FQ_SIZE;
> +		fq->head = (fq->head + 1) & fq->mod_mask;
>   	}
>   }
>   
> @@ -246,7 +251,7 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
>   	if (!atomic_read(&cookie->fq_timer_on) &&
>   	    !atomic_xchg(&cookie->fq_timer_on, 1))
>   		mod_timer(&cookie->fq_timer,
> -			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
> +			  jiffies + msecs_to_jiffies(cookie->options.fq_timeout));
>   }
>   
>   static void iommu_dma_free_fq_single(struct iova_fq *fq)
> @@ -287,27 +292,29 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
>   		iommu_dma_free_fq_percpu(cookie->percpu_fq);
>   }
>   
> -static void iommu_dma_init_one_fq(struct iova_fq *fq)
> +static void iommu_dma_init_one_fq(struct iova_fq *fq, size_t fq_size)
>   {
>   	int i;
>   
>   	fq->head = 0;
>   	fq->tail = 0;
> +	fq->mod_mask = fq_size - 1;
>   
>   	spin_lock_init(&fq->lock);
>   
> -	for (i = 0; i < IOVA_FQ_SIZE; i++)
> +	for (i = 0; i < fq_size; i++)
>   		INIT_LIST_HEAD(&fq->entries[i].freelist);
>   }
>   
>   static int iommu_dma_init_fq_single(struct iommu_dma_cookie *cookie)
>   {
> +	size_t fq_size = cookie->options.fq_size;
>   	struct iova_fq *queue;
>   
> -	queue = vzalloc(sizeof(*queue));
> +	queue = vzalloc(struct_size(queue, entries, fq_size));
>   	if (!queue)
>   		return -ENOMEM;
> -	iommu_dma_init_one_fq(queue);
> +	iommu_dma_init_one_fq(queue, fq_size);
>   	cookie->single_fq = queue;
>   
>   	return 0;
> @@ -315,15 +322,17 @@ static int iommu_dma_init_fq_single(struct iommu_dma_cookie *cookie)
>   
>   static int iommu_dma_init_fq_percpu(struct iommu_dma_cookie *cookie)
>   {
> +	size_t fq_size = cookie->options.fq_size;
>   	struct iova_fq __percpu *queue;
>   	int cpu;
>   
> -	queue = alloc_percpu(struct iova_fq);
> +	queue = __alloc_percpu(struct_size(queue, entries, fq_size),
> +			       __alignof__(*queue));
>   	if (!queue)
>   		return -ENOMEM;
>   
>   	for_each_possible_cpu(cpu)
> -		iommu_dma_init_one_fq(per_cpu_ptr(queue, cpu));
> +		iommu_dma_init_one_fq(per_cpu_ptr(queue, cpu), fq_size);
>   	cookie->percpu_fq = queue;
>   	return 0;
>   }
> @@ -377,6 +386,8 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
>   		INIT_LIST_HEAD(&cookie->msi_page_list);
>   		cookie->type = type;
>   		cookie->options.flags = IOMMU_DMA_OPTS_PER_CPU_QUEUE;
> +		cookie->options.fq_size = IOVA_DEFAULT_FQ_SIZE;
> +		cookie->options.fq_timeout = IOVA_DEFAULT_FQ_TIMEOUT;

Similar comment as on the previous patch - it would be clearer and more 
robust to set fq_size and fq_timeout all in one place in the main path 
of iommu_dma_init_domain(). Otherwise,

Acked-by: Robin Murphy <robin.murphy@arm.com>

>   	}
>   	return cookie;
>   }
> @@ -696,14 +707,19 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   
>   	if (domain->type == IOMMU_DOMAIN_DMA_FQ) {
>   		/* Expensive shadowing IOTLB flushes require some tuning */
> -		if (dev->iommu->shadow_on_flush)
> +		if (dev->iommu->shadow_on_flush) {
>   			cookie->options.flags |= IOMMU_DMA_OPTS_SINGLE_QUEUE;
> +			cookie->options.fq_timeout = IOVA_SINGLE_FQ_TIMEOUT;
> +			cookie->options.fq_size = IOVA_SINGLE_FQ_SIZE;
> +		}
>   
>   		/* If the FQ fails we can simply fall back to strict mode */
>   		if (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) ||
>   		    iommu_dma_init_fq(domain)) {
>   			domain->type = IOMMU_DOMAIN_DMA;
>   			cookie->options.flags &= ~IOMMU_DMA_OPTS_SINGLE_QUEUE;
> +			cookie->options.fq_timeout = IOVA_DEFAULT_FQ_TIMEOUT;
> +			cookie->options.fq_size = IOVA_DEFAULT_FQ_SIZE;
>   		}
>   	}
>   
> 
