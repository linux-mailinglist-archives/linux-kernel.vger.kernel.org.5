Return-Path: <linux-kernel+bounces-27468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B231382F098
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669D71F23B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C881BF2F;
	Tue, 16 Jan 2024 14:36:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B611BF27
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4000B2F4;
	Tue, 16 Jan 2024 06:36:45 -0800 (PST)
Received: from [10.1.38.190] (XHFQ2J9959.cambridge.arm.com [10.1.38.190])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B2A23F5A1;
	Tue, 16 Jan 2024 06:35:57 -0800 (PST)
Message-ID: <2c24afdf-5103-4c1b-a649-2eeed185f3fb@arm.com>
Date: Tue, 16 Jan 2024 14:35:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memory: move mem_cgroup_charge() into
 alloc_anon_folio()
Content-Language: en-GB
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>
References: <20240116071302.2282230-1-wangkefeng.wang@huawei.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240116071302.2282230-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 07:13, Kefeng Wang wrote:
> In order to allocate as much as possible of large folio, move
> the mem charge into alloc_anon_folio() and try the next order
> if mem_cgroup_charge() fails, also we change the GFP_KERNEL
> to gfp to be consistent with PMD THP.

I agree that changing gfp gives you consistency. But it's not entirely clear to
me why THP should use one set of flags for this case, and since pages another.
Why does this difference exist?

Otherwise, LGTM!

> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/memory.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 5e88d5379127..2e31a407e6f9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4206,15 +4206,21 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>  		folio = vma_alloc_folio(gfp, order, vma, addr, true);
>  		if (folio) {
> +			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
> +				folio_put(folio);
> +				goto next;
> +			}
> +			folio_throttle_swaprate(folio, gfp);
>  			clear_huge_page(&folio->page, vmf->address, 1 << order);
>  			return folio;
>  		}
> +next:
>  		order = next_order(&orders, order);
>  	}
>  
>  fallback:
>  #endif
> -	return vma_alloc_zeroed_movable_folio(vmf->vma, vmf->address);
> +	return folio_prealloc(vma->vm_mm, vma, vmf->address, true);
>  }
>  
>  /*
> @@ -4281,10 +4287,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	nr_pages = folio_nr_pages(folio);
>  	addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
>  
> -	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
> -		goto oom_free_page;
> -	folio_throttle_swaprate(folio, GFP_KERNEL);
> -
>  	/*
>  	 * The memory barrier inside __folio_mark_uptodate makes sure that
>  	 * preceding stores to the page contents become visible before
> @@ -4338,8 +4340,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  release:
>  	folio_put(folio);
>  	goto unlock;
> -oom_free_page:
> -	folio_put(folio);
>  oom:
>  	return VM_FAULT_OOM;
>  }


