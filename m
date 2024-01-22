Return-Path: <linux-kernel+bounces-32407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9B0835B64
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F4B1F23311
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4ACF500;
	Mon, 22 Jan 2024 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HjAY91BB"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3D7F4F5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907420; cv=none; b=laso1Lm587vYA4y0/3wJB6j4ayasgMie46CR8WdNWwcFZF7SK7c24KFyVhfZa1GZgIUrRXWne+dMclUSc69xiMEgemxnmcq3R5S0A7Ncn03VzsBRfZ1MF248oFyyqRHYRY1D0wP28jgY/5iyfxo1j3Q1/qgTZ1ZpHBH7UKYaszs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907420; c=relaxed/simple;
	bh=fdQqLeJ2/ZlSkyF9jseU0abA/T96mvJg06JE3DRUvPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSFh4v3U5/31An3V6lax7Vb12L+eNZxdEziITf4heBltSX/qxSiENYNT05mON/EPNU2l94PMjh5YaSsSfa+CJPBgwh0YfqLgfBPqlYv3W93JanwYRKzHQB890I/X4DnppV/NPAhdx5T/reRBq0pgd5JtQhPQv3L3MkDQPCAdghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HjAY91BB; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ddf37da4-4cbc-478a-be9b-3060b0aebc90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705907415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4i/R4tEjyXJlQ2GdaUYgCeui42zB/Fr0UkVlcgTOFHE=;
	b=HjAY91BBvrJ8KqkPbIbfCAZDXZfnDDPokY4TMh1OS31WpmCnLpzr3dY+HF4f2coKPIFJoA
	KzbFppeJRF7xI14GMDmXPFcGabiXukFr1wuLOraPcYyzre2zkAgrAax68+TZiuAJVH2DSK
	ZVG0EoWMp+YmEKV1L3OUuV4df+IygQI=
Date: Mon, 22 Jan 2024 15:10:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 6/7] hugetlb: parallelize 2M hugetlb allocation and
 initialization
To: Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-7-gang.li@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240118123911.88833-7-gang.li@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/1/18 20:39, Gang Li wrote:
> By distributing both the allocation and the initialization tasks across
> multiple threads, the initialization of 2M hugetlb will be faster,
> thereby improving the boot speed.
>
> Here are some test results:
>          test          no patch(ms)   patched(ms)   saved
>   ------------------- -------------- ------------- --------
>    256c2t(4 node) 2M           3336          1051   68.52%
>    128c1t(2 node) 2M           1943           716   63.15%
>
> Signed-off-by: Gang Li <gang.li@linux.dev>
> Tested-by: David Rientjes <rientjes@google.com>
> ---
>   mm/hugetlb.c | 70 ++++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 52 insertions(+), 18 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index effe5539e545..9b348ba418f5 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -35,6 +35,7 @@
>   #include <linux/delayacct.h>
>   #include <linux/memory.h>
>   #include <linux/mm_inline.h>
> +#include <linux/padata.h>
>   
>   #include <asm/page.h>
>   #include <asm/pgalloc.h>
> @@ -3510,43 +3511,76 @@ static void __init hugetlb_hstate_alloc_pages_errcheck(unsigned long allocated,
>   	}
>   }
>   
> -static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
> +static void __init hugetlb_alloc_node(unsigned long start, unsigned long end, void *arg)
>   {
> -	unsigned long i;
> +	struct hstate *h = (struct hstate *)arg;
> +	int i, num = end - start;
> +	nodemask_t node_alloc_noretry;
> +	unsigned long flags;
> +	int next_node = 0;

This should be first_online_node which may be not zero.

>   
> -	for (i = 0; i < h->max_huge_pages; ++i) {
> -		if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
> +	/* Bit mask controlling how hard we retry per-node allocations.*/
> +	nodes_clear(node_alloc_noretry);
> +
> +	for (i = 0; i < num; ++i) {
> +		struct folio *folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
> +						&node_alloc_noretry, &next_node);
> +		if (!folio)
>   			break;
> +		spin_lock_irqsave(&hugetlb_lock, flags);

I suspect there will more contention on this lock when parallelizing.
I want to know why you chose to drop prep_and_add_allocated_folios()
call in the original hugetlb_pages_alloc_boot()?

> +		__prep_account_new_huge_page(h, folio_nid(folio));
> +		enqueue_hugetlb_folio(h, folio);
> +		spin_unlock_irqrestore(&hugetlb_lock, flags);
>   		cond_resched();
>   	}
> +}
>   
> -	return i;
> +static void __init hugetlb_vmemmap_optimize_node(unsigned long start, unsigned long end, void *arg)
> +{
> +	struct hstate *h = (struct hstate *)arg;
> +	int nid = start;
> +
> +	hugetlb_vmemmap_optimize_folios(h, &h->hugepage_freelists[nid]);
>   }
>   
> -static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
> +static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
>   {
>   	unsigned long i;
> -	struct folio *folio;
> -	LIST_HEAD(folio_list);
> -	nodemask_t node_alloc_noretry;
> -
> -	/* Bit mask controlling how hard we retry per-node allocations.*/
> -	nodes_clear(node_alloc_noretry);
>   
>   	for (i = 0; i < h->max_huge_pages; ++i) {
> -		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
> -						&node_alloc_noretry);
> -		if (!folio)
> +		if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
>   			break;
> -		list_add(&folio->lru, &folio_list);
>   		cond_resched();
>   	}
>   
> -	prep_and_add_allocated_folios(h, &folio_list);
> -
>   	return i;
>   }
>   
> +static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
> +{
> +	struct padata_mt_job job = {
> +		.fn_arg		= h,
> +		.align		= 1,
> +		.numa_aware	= true
> +	};
> +
> +	job.thread_fn	= hugetlb_alloc_node;
> +	job.start	= 0;
> +	job.size	= h->max_huge_pages;
> +	job.min_chunk	= h->max_huge_pages / num_node_state(N_MEMORY) / 2;
> +	job.max_threads	= num_node_state(N_MEMORY) * 2;

I am curious the magic number of 2 used in assignments of ->min_chunk
and ->max_threads, does it from your experiment? I thinke it should
be a comment here.

And I am also sceptical about the optimization for a small amount of
allocation of hugepages. Given 4 hugepags needed to be allocated on UMA
system, job.min_chunk will be 2, job.max_threads will be 2. Then, 2
workers will be scheduled, however each worker will just allocate 2 pages,
how much the cost of scheduling? What if allocate 4 pages in single
worker? Do you have any numbers on parallelism vs non-parallelism in
a small allocation case? If we cannot gain from this case, I think we shold
assign a reasonable value to ->min_chunk based on experiment.

Thanks.

> +	padata_do_multithreaded(&job);
> +
> +	job.thread_fn	= hugetlb_vmemmap_optimize_node;
> +	job.start	= 0;
> +	job.size	= num_node_state(N_MEMORY);
> +	job.min_chunk	= 1;
> +	job.max_threads	= num_node_state(N_MEMORY);
> +	padata_do_multithreaded(&job);
> +
> +	return h->nr_huge_pages;
> +}
> +
>   /*
>    * NOTE: this routine is called in different contexts for gigantic and
>    * non-gigantic pages.


