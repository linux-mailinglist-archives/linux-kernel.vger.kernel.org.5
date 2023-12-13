Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590DB811E72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441877AbjLMTOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMTOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:14:52 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374A399
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:14:58 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id F372160195;
        Wed, 13 Dec 2023 20:14:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1702494895; bh=zdpSnHuazrM+GrDCv/1f+ipMFZ+HZ1PyA1Q/nTyAm+s=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=tlWSoPizLn/rDZRvdTQu4CyyudmsD3taiYmBdeBYKYRyLZNq9OnuDEtJ0zCYC7H4g
         CNhTlyVrO+c1cviIWhussi1YpvuYAcJmc5b1ygpoQ6p+FbtTJ2/SHHxAU9Y+PB2UEM
         kJfbW0AuuRORVUILyWybA79jtHtadXXs5PsUTi/RBHHx/GGf8Od9JNM9MKesiDT5Mi
         w/GX+2Uol1vRe6GqC9+3n54PiYGmoWewRb8lJ1HgS+NtEiBsNloqiG5eHqG8/4rKqI
         tD6dSSPA0j7JgcdaCHQVB7CJQlE3CSJpYh2XYbKNwS0awXhKZErGQoIJ+Rnwq9FUvZ
         Vh0RHGfTUtWHQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ds8SAOLwT7mZ; Wed, 13 Dec 2023 20:14:52 +0100 (CET)
Received: from [192.168.146.51] (unknown [212.15.178.47])
        by domac.alu.hr (Postfix) with ESMTPSA id ABA226017F;
        Wed, 13 Dec 2023 20:14:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1702494892; bh=zdpSnHuazrM+GrDCv/1f+ipMFZ+HZ1PyA1Q/nTyAm+s=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=afiVDDJihSfg1Q2U1ghCG5w17UXwFgdZTXD+iBjZmH9SsLUSfcHlcP6AljEj3+Ptp
         p1eFDO9sF9hPjgoN8FlUeI9Qs4F4yG/ExFPN3RHKFSNGrZbyxW9T0IZR5GE91MZjPj
         fZGOzSPJ6A8c74XNeFoaBsi/JAi3YuH510Zhqv20vj8bMMulm7lgE2ZsWpNCV/RQuX
         MnYd2cqKPrXfeGMwEZCgYlsJiQD5jGgm1XBPmtsO9HlOM8M8GQEaDvTPmWKl03vno2
         3z2O7efUVkNfGuXnwxLdVncMCkUt5eGg2w193xl0pp+a2a9DC9RHDRwyx8NtEd+sZT
         66D4e0Yc13Z2w==
Message-ID: <97639c1d-0f6c-4c70-983f-351d5dc200e3@alu.unizg.hr>
Date:   Wed, 13 Dec 2023 20:14:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCH RESEND] swiotlb: reduce area lock contention for
 non-primary IO TLB pools
To:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Wangkefeng <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        petr@tesarici.cz, Petr Tesarik <petr.tesarik1@huawei-partners.com>
References: <20231201121352.195-1-petrtesarik@huaweicloud.com>
Content-Language: en-US
Autocrypt: addr=mirsad.todorovac@alu.unizg.hr; keydata=
 xjMEYp0QmBYJKwYBBAHaRw8BAQdAI14D1/OE3jLBYycg8HaOJOYrvEaox0abFZtJf3vagyLN
 Nk1pcnNhZCBHb3JhbiBUb2Rvcm92YWMgPG1pcnNhZC50b2Rvcm92YWNAYWx1LnVuaXpnLmhy
 PsKPBBMWCAA3FiEEdCs8n09L2Xwp/ytk6p9/SWOJhIAFAmKdEJgFCQ0oaIACGwMECwkIBwUV
 CAkKCwUWAgMBAAAKCRDqn39JY4mEgIf/AP9hx09nve6VH6D/F3m5jRT5m1lzt5YzSMpxLGGU
 vGlI4QEAvOvGI6gPCQMhuQQrOfRr1CnnTXeaXHhlp9GaZEW45QzOOARinRCZEgorBgEEAZdV
 AQUBAQdAqJ1CxZGdTsiS0cqW3AvoufnWUIC/h3W2rpJ+HUxm61QDAQgHwn4EGBYIACYWIQR0
 KzyfT0vZfCn/K2Tqn39JY4mEgAUCYp0QmQUJDShogAIbDAAKCRDqn39JY4mEgIMnAQDPKMJJ
 fs8+QnWS2xx299NkVTRsZwfg54z9NIvH5L3HiAD9FT3zfHfvQxIViWEzcj0q+FLWoRkOh02P
 Ny0lWTyFlgc=
Organization: Academy of Fine Arts, University of Zagreb
In-Reply-To: <20231201121352.195-1-petrtesarik@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/2023 1:13 PM, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> 
> If multiple areas and multiple IO TLB pools exist, first iterate the
> current CPU specific area in all pools. Then move to the next area index.
> 
> This is best illustrated by a diagram:
> 
>          area 0 |  area 1 | ... | area M |
> pool 0    A         B              C
> pool 1    D         E
> ...
> pool N    F         G              H
> 
> Currently, each pool is searched before moving on to the next pool,
> i.e. the search order is A, B ... C, D, E ... F, G ... H. With this patch,
> each area is searched in all pools before moving on to the next area,
> i.e. the search order is A, D ... F, B, E ... G ... C ... H.
> 
> Note that preemption is not disabled, and raw_smp_processor_id() may not
> return a stable result, but it is called only once to determine the initial
> area index. The search will iterate over all areas eventually, even if the
> current task is preempted.
> 
> Next, some pools may have less (but not more) areas than default_nareas.
> Skip such pools if the distance from the initial area index is greater than
> pool->nareas. This logic ensures that for every pool the search starts in
> the initial CPU's own area and never tries any area twice.
> 
> To verify performance impact, I booted the kernel with a minimum pool
> size ("swiotlb=512,4,force"), so multiple pools get allocated, and I ran
> these benchmarks:
> 
> - small: single-threaded I/O of 4 KiB blocks,
> - big: single-threaded I/O of 64 KiB blocks,
> - 4way: 4-way parallel I/O of 4 KiB blocks.
> 
> The "var" column in the tables below is the coefficient of variance over 5
> runs of the test, the "diff" column is the relative difference against base
> in read-write I/O bandwidth (MiB/s).
> 
> Tested on an x86 VM against a QEMU virtio SATA driver backed by a RAM-based
> block device on the host:
> 
> 	base	   patched
> 	var	var	diff
> small	0.69%	0.62%	+25.4%
> big	2.14%	2.27%	+25.7%
> 4way	2.65%	1.70%	+23.6%
> 
> Tested on a Raspberry Pi against a class-10 A1 microSD card:
> 
> 	base	   patched
> 	var	var	diff
> small	0.53%	1.96%	-0.3%
> big	0.02%	0.57%	+0.8%
> 4way	6.17%	0.40%	+0.3%
> 
> These results confirm that there is significant performance boost in the
> software IO TLB slot allocation itself. Where performance is dominated by
> actual hardware, there is no measurable change.
> 
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>   kernel/dma/swiotlb.c | 90 +++++++++++++++++++++++++++-----------------
>   1 file changed, 55 insertions(+), 35 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 33d942615be5..e20b856255ef 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -957,7 +957,7 @@ static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
>   #endif /* CONFIG_DEBUG_FS */
>   
>   /**
> - * swiotlb_area_find_slots() - search for slots in one IO TLB memory area
> + * swiotlb_search_pool_area() - search one memory area in one pool
>    * @dev:	Device which maps the buffer.
>    * @pool:	Memory pool to be searched.
>    * @area_index:	Index of the IO TLB memory area to be searched.
> @@ -972,7 +972,7 @@ static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
>    *
>    * Return: Index of the first allocated slot, or -1 on error.
>    */
> -static int swiotlb_area_find_slots(struct device *dev, struct io_tlb_pool *pool,
> +static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool,
>   		int area_index, phys_addr_t orig_addr, size_t alloc_size,
>   		unsigned int alloc_align_mask)
>   {
> @@ -1066,41 +1066,50 @@ static int swiotlb_area_find_slots(struct device *dev, struct io_tlb_pool *pool,
>   	return slot_index;
>   }
>   
> +#ifdef CONFIG_SWIOTLB_DYNAMIC
> +
>   /**
> - * swiotlb_pool_find_slots() - search for slots in one memory pool
> + * swiotlb_search_area() - search one memory area in all pools
>    * @dev:	Device which maps the buffer.
> - * @pool:	Memory pool to be searched.
> + * @start_cpu:	Start CPU number.
> + * @cpu_offset:	Offset from @start_cpu.
>    * @orig_addr:	Original (non-bounced) IO buffer address.
>    * @alloc_size: Total requested size of the bounce buffer,
>    *		including initial alignment padding.
>    * @alloc_align_mask:	Required alignment of the allocated buffer.
> + * @retpool:	Used memory pool, updated on return.
>    *
> - * Search through one memory pool to find a sequence of slots that match the
> + * Search one memory area in all pools for a sequence of slots that match the
>    * allocation constraints.
>    *
>    * Return: Index of the first allocated slot, or -1 on error.
>    */
> -static int swiotlb_pool_find_slots(struct device *dev, struct io_tlb_pool *pool,
> -		phys_addr_t orig_addr, size_t alloc_size,
> -		unsigned int alloc_align_mask)
> +static int swiotlb_search_area(struct device *dev, int start_cpu,
> +		int cpu_offset, phys_addr_t orig_addr, size_t alloc_size,
> +		unsigned int alloc_align_mask, struct io_tlb_pool **retpool)
>   {
> -	int start = raw_smp_processor_id() & (pool->nareas - 1);
> -	int i = start, index;
> -
> -	do {
> -		index = swiotlb_area_find_slots(dev, pool, i, orig_addr,
> -						alloc_size, alloc_align_mask);
> -		if (index >= 0)
> -			return index;
> -		if (++i >= pool->nareas)
> -			i = 0;
> -	} while (i != start);
> +	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> +	struct io_tlb_pool *pool;
> +	int area_index;
> +	int index = -1;
>   
> -	return -1;
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(pool, &mem->pools, node) {
> +		if (cpu_offset >= pool->nareas)
> +			continue;
> +		area_index = (start_cpu + cpu_offset) & (pool->nareas - 1);
> +		index = swiotlb_search_pool_area(dev, pool, area_index,
> +						 orig_addr, alloc_size,
> +						 alloc_align_mask);
> +		if (index >= 0) {
> +			*retpool = pool;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return index;
>   }
>   
> -#ifdef CONFIG_SWIOTLB_DYNAMIC
> -
>   /**
>    * swiotlb_find_slots() - search for slots in the whole swiotlb
>    * @dev:	Device which maps the buffer.
> @@ -1124,18 +1133,17 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>   	unsigned long nslabs;
>   	unsigned long flags;
>   	u64 phys_limit;
> +	int cpu, i;
>   	int index;
>   
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(pool, &mem->pools, node) {
> -		index = swiotlb_pool_find_slots(dev, pool, orig_addr,
> -						alloc_size, alloc_align_mask);
> -		if (index >= 0) {
> -			rcu_read_unlock();
> +	cpu = raw_smp_processor_id();
> +	for (i = 0; i < default_nareas; ++i) {
> +		index = swiotlb_search_area(dev, cpu, i, orig_addr, alloc_size,
> +					    alloc_align_mask, &pool);
> +		if (index >= 0)
>   			goto found;
> -		}
>   	}
> -	rcu_read_unlock();
> +
>   	if (!mem->can_grow)
>   		return -1;
>   
> @@ -1148,8 +1156,8 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>   	if (!pool)
>   		return -1;
>   
> -	index = swiotlb_pool_find_slots(dev, pool, orig_addr,
> -					alloc_size, alloc_align_mask);
> +	index = swiotlb_search_pool_area(dev, pool, 0, orig_addr,
> +					 alloc_size, alloc_align_mask);
>   	if (index < 0) {
>   		swiotlb_dyn_free(&pool->rcu);
>   		return -1;
> @@ -1192,9 +1200,21 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>   		size_t alloc_size, unsigned int alloc_align_mask,
>   		struct io_tlb_pool **retpool)
>   {
> -	*retpool = &dev->dma_io_tlb_mem->defpool;
> -	return swiotlb_pool_find_slots(dev, *retpool,
> -				       orig_addr, alloc_size, alloc_align_mask);
> +	struct io_tlb_pool *pool;
> +	int start, i;
> +	int index;
> +
> +	*retpool = pool = &dev->dma_io_tlb_mem->defpool;
> +	i = start = raw_smp_processor_id() & (pool->nareas - 1);
> +	do {
> +		index = swiotlb_search_pool_area(dev, pool, i, orig_addr,
> +						 alloc_size, alloc_align_mask);
> +		if (index >= 0)
> +			return index;
> +		if (++i >= pool->nareas)
> +			i = 0;
> +	} while (i != start);
> +	return -1;
>   }
>   
>   #endif /* CONFIG_SWIOTLB_DYNAMIC */

Hi,

As Andrew recommended, though I am not authority in the area, I can
participate and send reviews.

This looks like you are converting one rcu_read_lock() ...
rcu_read_unlock() for the entire pool into rcu_read_lock() ...
rcu_read_unlock() per search area.

Additionally, the locality of search is improved by searching all areas
on the current cpu first and increases the chance of earlier exit finding
index.

That does seem to improve some benchmarks by 25%.

As this appears to be an improvement in granularity of RCU read locking,
this goal appears to be reached.

The swiotlb_dyn_free() which is the only place where RCU releases pool
should be reached more quickly, and rcu_grace_period_complete() magic should
work sooner, more promptly releasing resources.

Does this improve cache line misses handled by the hardware on x86?

Theoretically, the locality of reference while searching area in TLB pools
has the potential to reduce cache misses even when TLB misses are handled
transparently by the hw. But it would be interesting what the exact
measurements show.

Reviewed-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

Best regards,
Mirsad Todorovac
