Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DF77812BC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379405AbjHRSRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379374AbjHRSRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:17:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E94572D70;
        Fri, 18 Aug 2023 11:17:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00538D75;
        Fri, 18 Aug 2023 11:17:50 -0700 (PDT)
Received: from [10.57.91.158] (unknown [10.57.91.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D63BC3F762;
        Fri, 18 Aug 2023 11:17:00 -0700 (PDT)
Message-ID: <9a466109-01c5-96b0-bf03-304123f435ee@arm.com>
Date:   Fri, 18 Aug 2023 19:16:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v11 5/6] iommu/dma: Allow a single FQ in addition to
 per-CPU FQs
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
 <20230717-dma_iommu-v11-5-a7a0b83c355c@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230717-dma_iommu-v11-5-a7a0b83c355c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-17 12:00, Niklas Schnelle wrote:
> In some virtualized environments, including s390 paged memory guests,
> IOTLB flushes are used to update IOMMU shadow tables. Due to this, they
> are much more expensive than in typical bare metal environments or
> non-paged s390 guests. In addition they may parallelize poorly in
> virtualized environments. This changes the trade off for flushing IOVAs
> such that minimizing the number of IOTLB flushes trumps any benefit of
> cheaper queuing operations or increased paralellism.
> 
> In this scenario per-CPU flush queues pose several problems. Firstly
> per-CPU memory is often quite limited prohibiting larger queues.
> Secondly collecting IOVAs per-CPU but flushing via a global timeout
> reduces the number of IOVAs flushed for each timeout especially on s390
> where PCI interrupts may not be bound to a specific CPU.
> 
> Let's introduce a single flush queue mode that reuses the same queue
> logic but only allocates a single global queue. This mode is selected by
> dma-iommu if a newly introduced .shadow_on_flush flag is set in struct
> dev_iommu. As a first user the s390 IOMMU driver sets this flag during
> probe_device. With the unchanged small FQ size and timeouts this setting
> is worse than per-CPU queues but a follow up patch will make the FQ size
> and timeout variable. Together this allows the common IOVA flushing code
> to more closely resemble the global flush behavior used on s390's
> previous internal DMA API implementation.
> 
> Link: https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde006257b6f@arm.com/
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com> #s390
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/iommu/dma-iommu.c  | 178 +++++++++++++++++++++++++++++++++------------
>   drivers/iommu/iommu.c      |  20 +----

The hunks in iommu.c appear to be an inadvertent reversion of patch #1?

A few bonus nits below which you can take or leave, but otherwise, with 
the rebase-mishap fixed:

Acked-by: Robin Murphy <robin.murphy@arm.com>

>   drivers/iommu/s390-iommu.c |   3 +
>   include/linux/iommu.h      |   2 +
>   4 files changed, 142 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index e57724163835..4ada8b9749c9 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -43,14 +43,23 @@ enum iommu_dma_cookie_type {
>   	IOMMU_DMA_MSI_COOKIE,
>   };
>   
> +struct dma_iommu_options {
> +#define IOMMU_DMA_OPTS_PER_CPU_QUEUE	0L

Nit: if the intent is to add more flags then that will no longer make 
sense, and if not then we may as well just have a bool ;)

> +#define IOMMU_DMA_OPTS_SINGLE_QUEUE	BIT(0)
> +	u64	flags;
> +};
> +
>   struct iommu_dma_cookie {
>   	enum iommu_dma_cookie_type	type;
>   	union {
>   		/* Full allocator for IOMMU_DMA_IOVA_COOKIE */
>   		struct {
>   			struct iova_domain	iovad;
> -
> -			struct iova_fq __percpu *fq;	/* Flush queue */
> +			/* Flush queue */
> +			union {
> +				struct iova_fq	*single_fq;
> +				struct iova_fq	__percpu *percpu_fq;
> +			};
>   			/* Number of TLB flushes that have been started */
>   			atomic64_t		fq_flush_start_cnt;
>   			/* Number of TLB flushes that have been finished */
> @@ -67,6 +76,8 @@ struct iommu_dma_cookie {
>   
>   	/* Domain for flush queue callback; NULL if flush queue not in use */
>   	struct iommu_domain		*fq_domain;
> +	/* Options for dma-iommu use */
> +	struct dma_iommu_options	options;
>   	struct mutex			mutex;
>   };
>   
> @@ -124,7 +135,7 @@ static inline unsigned int fq_ring_add(struct iova_fq *fq)
>   	return idx;
>   }
>   
> -static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
> +static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
>   {
>   	u64 counter = atomic64_read(&cookie->fq_flush_finish_cnt);
>   	unsigned int idx;
> @@ -145,6 +156,15 @@ static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
>   	}
>   }
>   
> +static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fq->lock, flags);
> +	fq_ring_free_locked(cookie, fq);
> +	spin_unlock_irqrestore(&fq->lock, flags);
> +}
> +
>   static void fq_flush_iotlb(struct iommu_dma_cookie *cookie)
>   {
>   	atomic64_inc(&cookie->fq_flush_start_cnt);
> @@ -152,23 +172,29 @@ static void fq_flush_iotlb(struct iommu_dma_cookie *cookie)
>   	atomic64_inc(&cookie->fq_flush_finish_cnt);
>   }
>   
> +static void fq_flush_percpu(struct iommu_dma_cookie *cookie)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct iova_fq *fq;
> +
> +		fq = per_cpu_ptr(cookie->percpu_fq, cpu);
> +		fq_ring_free(cookie, fq);
> +	}
> +}
> +
>   static void fq_flush_timeout(struct timer_list *t)
>   {
>   	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
> -	int cpu;
>   
>   	atomic_set(&cookie->fq_timer_on, 0);
>   	fq_flush_iotlb(cookie);
>   
> -	for_each_possible_cpu(cpu) {
> -		unsigned long flags;
> -		struct iova_fq *fq;
> -
> -		fq = per_cpu_ptr(cookie->fq, cpu);
> -		spin_lock_irqsave(&fq->lock, flags);
> -		fq_ring_free(cookie, fq);
> -		spin_unlock_irqrestore(&fq->lock, flags);
> -	}
> +	if (cookie->options.flags & IOMMU_DMA_OPTS_SINGLE_QUEUE)
> +		fq_ring_free(cookie, cookie->single_fq);
> +	else
> +		fq_flush_percpu(cookie);

Nit: honestly I'd just inline that as:

	else for_each_possible_cpu(cpu)
		fq_ring_free(cookie, per_cpu_ptr(cookie->percpu_fq, cpu));

(possibly with extra braces if you don't feel brave enough to join the 
elite "else for" club...)

>   }
>   
>   static void queue_iova(struct iommu_dma_cookie *cookie,
> @@ -188,7 +214,11 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
>   	 */
>   	smp_mb();
>   
> -	fq = raw_cpu_ptr(cookie->fq);
> +	if (cookie->options.flags & IOMMU_DMA_OPTS_SINGLE_QUEUE)
> +		fq = cookie->single_fq;
> +	else
> +		fq = raw_cpu_ptr(cookie->percpu_fq);
> +
>   	spin_lock_irqsave(&fq->lock, flags);
>   
>   	/*
> @@ -196,11 +226,11 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
>   	 * flushed out on another CPU. This makes the fq_full() check below less
>   	 * likely to be true.
>   	 */
> -	fq_ring_free(cookie, fq);
> +	fq_ring_free_locked(cookie, fq);
>   
>   	if (fq_full(fq)) {
>   		fq_flush_iotlb(cookie);
> -		fq_ring_free(cookie, fq);
> +		fq_ring_free_locked(cookie, fq);
>   	}
>   
>   	idx = fq_ring_add(fq);
> @@ -219,31 +249,90 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
>   			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
>   }
>   
> -static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
> +static void iommu_dma_free_fq_single(struct iova_fq *fq)
> +{
> +	int idx;
> +
> +	if (!fq)
> +		return;

Nit: That should never be true if cookie->fq_domain was set

> +	fq_ring_for_each(idx, fq)
> +		put_pages_list(&fq->entries[idx].freelist);
> +	vfree(fq);
> +}
> +
> +static void iommu_dma_free_fq_percpu(struct iova_fq __percpu *percpu_fq)
>   {
>   	int cpu, idx;
>   
> -	if (!cookie->fq)
> -		return;
> -
> -	del_timer_sync(&cookie->fq_timer);
>   	/* The IOVAs will be torn down separately, so just free our queued pages */
>   	for_each_possible_cpu(cpu) {
> -		struct iova_fq *fq = per_cpu_ptr(cookie->fq, cpu);
> +		struct iova_fq *fq = per_cpu_ptr(percpu_fq, cpu);
>   
>   		fq_ring_for_each(idx, fq)
>   			put_pages_list(&fq->entries[idx].freelist);
>   	}
>   
> -	free_percpu(cookie->fq);
> +	free_percpu(percpu_fq);
> +}
> +
> +static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
> +{
> +	if (!cookie->fq_domain)
> +		return;
> +
> +	del_timer_sync(&cookie->fq_timer);
> +	if (cookie->options.flags & IOMMU_DMA_OPTS_SINGLE_QUEUE)
> +		iommu_dma_free_fq_single(cookie->single_fq);
> +	else
> +		iommu_dma_free_fq_percpu(cookie->percpu_fq);
> +}
> +
> +static void iommu_dma_init_one_fq(struct iova_fq *fq)
> +{
> +	int i;
> +
> +	fq->head = 0;
> +	fq->tail = 0;
> +
> +	spin_lock_init(&fq->lock);
> +
> +	for (i = 0; i < IOVA_FQ_SIZE; i++)
> +		INIT_LIST_HEAD(&fq->entries[i].freelist);
> +}
> +
> +static int iommu_dma_init_fq_single(struct iommu_dma_cookie *cookie)
> +{
> +	struct iova_fq *queue;
> +
> +	queue = vzalloc(sizeof(*queue));

Nit: vmalloc() - no need to zero the whole thing when the percpu path 
doesn't.

> +	if (!queue)
> +		return -ENOMEM;
> +	iommu_dma_init_one_fq(queue);
> +	cookie->single_fq = queue;
> +
> +	return 0;
> +}
> +
> +static int iommu_dma_init_fq_percpu(struct iommu_dma_cookie *cookie)
> +{
> +	struct iova_fq __percpu *queue;
> +	int cpu;
> +
> +	queue = alloc_percpu(struct iova_fq);
> +	if (!queue)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu)
> +		iommu_dma_init_one_fq(per_cpu_ptr(queue, cpu));
> +	cookie->percpu_fq = queue;
> +	return 0;
>   }
>   
>   /* sysfs updates are serialised by the mutex of the group owning @domain */
>   int iommu_dma_init_fq(struct iommu_domain *domain)
>   {
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -	struct iova_fq __percpu *queue;
> -	int i, cpu;
> +	int rc;
>   
>   	if (cookie->fq_domain)
>   		return 0;
> @@ -251,26 +340,16 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
>   	atomic64_set(&cookie->fq_flush_start_cnt,  0);
>   	atomic64_set(&cookie->fq_flush_finish_cnt, 0);
>   
> -	queue = alloc_percpu(struct iova_fq);
> -	if (!queue) {
> +	if (cookie->options.flags & IOMMU_DMA_OPTS_SINGLE_QUEUE)
> +		rc = iommu_dma_init_fq_single(cookie);
> +	else
> +		rc = iommu_dma_init_fq_percpu(cookie);
> +
> +	if (rc) {
>   		pr_warn("iova flush queue initialization failed\n");
>   		return -ENOMEM;
>   	}
>   
> -	for_each_possible_cpu(cpu) {
> -		struct iova_fq *fq = per_cpu_ptr(queue, cpu);
> -
> -		fq->head = 0;
> -		fq->tail = 0;
> -
> -		spin_lock_init(&fq->lock);
> -
> -		for (i = 0; i < IOVA_FQ_SIZE; i++)
> -			INIT_LIST_HEAD(&fq->entries[i].freelist);
> -	}
> -
> -	cookie->fq = queue;
> -
>   	timer_setup(&cookie->fq_timer, fq_flush_timeout, 0);
>   	atomic_set(&cookie->fq_timer_on, 0);
>   	/*
> @@ -297,6 +376,7 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
>   	if (cookie) {
>   		INIT_LIST_HEAD(&cookie->msi_page_list);
>   		cookie->type = type;
> +		cookie->options.flags = IOMMU_DMA_OPTS_PER_CPU_QUEUE;

You see, this confused me into thinking it does something and I had to 
go back and check ;)

>   	}
>   	return cookie;
>   }
> @@ -614,10 +694,18 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   	if (ret)
>   		goto done_unlock;
>   
> -	/* If the FQ fails we can simply fall back to strict mode */
> -	if (domain->type == IOMMU_DOMAIN_DMA_FQ &&
> -	    (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) || iommu_dma_init_fq(domain)))
> -		domain->type = IOMMU_DOMAIN_DMA;
> +	if (domain->type == IOMMU_DOMAIN_DMA_FQ) {
> +		/* Expensive shadowing IOTLB flushes require some tuning */
> +		if (dev->iommu->shadow_on_flush)
> +			cookie->options.flags |= IOMMU_DMA_OPTS_SINGLE_QUEUE;

It would probably be better to set this regardless of the domain type, 
in case the FQ is only brought up later via sysfs.

> +
> +		/* If the FQ fails we can simply fall back to strict mode */
> +		if (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) ||
> +		    iommu_dma_init_fq(domain)) {
> +			domain->type = IOMMU_DOMAIN_DMA;
> +			cookie->options.flags &= ~IOMMU_DMA_OPTS_SINGLE_QUEUE;

...and either way there should be no need to clear it again - if it was 
true once it will always be true.

Cheers,
Robin.

> +		}
> +	}
>   
>   	ret = iova_reserve_iommu_regions(dev, domain);
>   
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index fd9f79731d6a..caaf563d38ae 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2413,17 +2413,8 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
>   		return -EINVAL;
>   
>   	ret = __iommu_map(domain, iova, paddr, size, prot, gfp);
> -	if (ret == 0 && ops->iotlb_sync_map) {
> -		ret = ops->iotlb_sync_map(domain, iova, size);
> -		if (ret)
> -			goto out_err;
> -	}
> -
> -	return ret;
> -
> -out_err:
> -	/* undo mappings already done */
> -	iommu_unmap(domain, iova, size);
> +	if (ret == 0 && ops->iotlb_sync_map)
> +		ops->iotlb_sync_map(domain, iova, size);
>   
>   	return ret;
>   }
> @@ -2564,11 +2555,8 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>   			sg = sg_next(sg);
>   	}
>   
> -	if (ops->iotlb_sync_map) {
> -		ret = ops->iotlb_sync_map(domain, iova, mapped);
> -		if (ret)
> -			goto out_err;
> -	}
> +	if (ops->iotlb_sync_map)
> +		ops->iotlb_sync_map(domain, iova, mapped);
>   	return mapped;
>   
>   out_err:
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 020cc538e4c4..63c56a440c9d 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -468,6 +468,9 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
>   	if (zdev->end_dma > ZPCI_TABLE_SIZE_RT - 1)
>   		zdev->end_dma = ZPCI_TABLE_SIZE_RT - 1;
>   
> +	if (zdev->tlb_refresh)
> +		dev->iommu->shadow_on_flush = 1;
> +
>   	return &zdev->iommu_dev;
>   }
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 182cc4c71e62..c3687e066ed7 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -409,6 +409,7 @@ struct iommu_fault_param {
>    * @priv:	 IOMMU Driver private data
>    * @max_pasids:  number of PASIDs this device can consume
>    * @attach_deferred: the dma domain attachment is deferred
> + * @shadow_on_flush: IOTLB flushes are used to sync shadow tables
>    *
>    * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>    *	struct iommu_group	*iommu_group;
> @@ -422,6 +423,7 @@ struct dev_iommu {
>   	void				*priv;
>   	u32				max_pasids;
>   	u32				attach_deferred:1;
> +	u32				shadow_on_flush:1;
>   };
>   
>   int iommu_device_register(struct iommu_device *iommu,
> 
