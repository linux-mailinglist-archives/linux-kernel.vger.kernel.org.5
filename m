Return-Path: <linux-kernel+bounces-27052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC47782E9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B5F2850F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF17F1118B;
	Tue, 16 Jan 2024 07:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CY3v5oPX"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6A11185
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ae5ec3f-4a96-4819-af65-5f04df0c2ebd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705388567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txIZXYF3ib8b3sMorV8i+HMWWhDk4zrdCMBjUrUSGcU=;
	b=CY3v5oPX0xoBC0az5ZLVLoe+HAbLsHFWvZK6etFK3WuzZWACmH4rJeBjk1R0x3Gmn6cbpw
	P9ctl84hv78h26yCYSMbAFvYHcIFLanU3X6e0fLa+liJoGBXoxSXRKMp1+sNDpAM2pk14R
	RQP+Iku3P5k+7HgWpokP3qotXilO5Kc=
Date: Tue, 16 Jan 2024 15:02:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/7] hugetlb: split hugetlb_hstate_alloc_pages
To: ligang.bdlg@bytedance.com, Gang Li <gang.li@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
References: <20240102131249.76622-1-gang.li@linux.dev>
 <20240102131249.76622-3-gang.li@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240102131249.76622-3-gang.li@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2024/1/2 21:12, Gang Li wrote:
> 1G and 2M huge pages have different allocation and initialization logic,
> which leads to subtle differences in parallelization. Therefore, it is
> appropriate to split hugetlb_hstate_alloc_pages into gigantic and
> non-gigantic.
>
> This patch has no functional changes.
>
> Signed-off-by: Gang Li <gang.li@linux.dev>
> ---
>   mm/hugetlb.c | 86 +++++++++++++++++++++++++++-------------------------
>   1 file changed, 45 insertions(+), 41 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 2606135ec55e6..92448e747991d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3509,6 +3509,47 @@ static void __init hugetlb_hstate_alloc_pages_report(unsigned long allocated, st
>   	}
>   }
>   
> +static unsigned long __init hugetlb_hstate_alloc_pages_gigantic(struct hstate *h)

The name is so long, how about hugetlb_gigantic_pages_alloc_boot?

> +{
> +	unsigned long i;
> +
> +	for (i = 0; i < h->max_huge_pages; ++i) {
> +		/*
> +		 * gigantic pages not added to list as they are not
> +		 * added to pools now.
> +		 */
> +		if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
> +			break;
> +		cond_resched();
> +	}
> +
> +	return i;
> +}
> +
> +static unsigned long __init hugetlb_hstate_alloc_pages_non_gigantic(struct hstate *h)

hugetlb_pages_alloc_boot?

> +{
> +	unsigned long i;
> +	struct folio *folio;
> +	LIST_HEAD(folio_list);
> +	nodemask_t node_alloc_noretry;
> +
> +	/* Bit mask controlling how hard we retry per-node allocations.*/
> +	nodes_clear(node_alloc_noretry);
> +
> +	for (i = 0; i < h->max_huge_pages; ++i) {
> +		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
> +						&node_alloc_noretry);
> +		if (!folio)
> +			break;
> +		list_add(&folio->lru, &folio_list);
> +		cond_resched();
> +	}
> +
> +	prep_and_add_allocated_folios(h, &folio_list);
> +
> +	return i;
> +}
> +
>   /*
>    * NOTE: this routine is called in different contexts for gigantic and
>    * non-gigantic pages.
> @@ -3522,10 +3563,7 @@ static void __init hugetlb_hstate_alloc_pages_report(unsigned long allocated, st
>    */
>   static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>   {
> -	unsigned long i;
> -	struct folio *folio;
> -	LIST_HEAD(folio_list);
> -	nodemask_t *node_alloc_noretry;
> +	unsigned long allocated;
>   
>   	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
>   	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
> @@ -3539,46 +3577,12 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>   
>   	/* below will do all node balanced alloc */
>   	if (!hstate_is_gigantic(h)) {

It it unnecessary to reverse the condition. A little sime like following:

if (hstate_is_gigantic(h))
     /* gigantic pages */
else
     /* normal pages */

> -		/*
> -		 * Bit mask controlling how hard we retry per-node allocations.
> -		 * Ignore errors as lower level routines can deal with
> -		 * node_alloc_noretry == NULL.  If this kmalloc fails at boot
> -		 * time, we are likely in bigger trouble.
> -		 */
> -		node_alloc_noretry = kmalloc(sizeof(*node_alloc_noretry),
> -						GFP_KERNEL);
> +		allocated = hugetlb_hstate_alloc_pages_non_gigantic(h);
>   	} else {
> -		/* allocations done at boot time */
> -		node_alloc_noretry = NULL;
> -	}
> -
> -	/* bit mask controlling how hard we retry per-node allocations */
> -	if (node_alloc_noretry)
> -		nodes_clear(*node_alloc_noretry);
> -
> -	for (i = 0; i < h->max_huge_pages; ++i) {
> -		if (hstate_is_gigantic(h)) {
> -			/*
> -			 * gigantic pages not added to list as they are not
> -			 * added to pools now.
> -			 */
> -			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
> -				break;
> -		} else {
> -			folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
> -							node_alloc_noretry);
> -			if (!folio)
> -				break;
> -			list_add(&folio->lru, &folio_list);
> -		}
> -		cond_resched();
> +		allocated = hugetlb_hstate_alloc_pages_gigantic(h);
>   	}
>   
> -	/* list will be empty if hstate_is_gigantic */
> -	prep_and_add_allocated_folios(h, &folio_list);
> -
> -	hugetlb_hstate_alloc_pages_report(i, h);
> -	kfree(node_alloc_noretry);
> +	hugetlb_hstate_alloc_pages_report(allocated, h);
>   }
>   
>   static void __init hugetlb_init_hstates(void)


