Return-Path: <linux-kernel+bounces-30223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61059831BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939B01C20B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0218F1E538;
	Thu, 18 Jan 2024 14:49:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9711E504
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589354; cv=none; b=XTBk/bta2fp/Uy04ByEZuNG4N4ADNKnAKkDTK8IS54Hen0/g4GFDSvJ/HOzoKXF91ljWfTKt47lqf1oo32lHXHgm5YczNDu01otcMxMsYbPj4jSU4WOf+ZPkQJ2yCcERNxyN1Rav7viWb6CGiVmu9U9w6GRRK6CLW75gazFN86Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589354; c=relaxed/simple;
	bh=TdXRL+NaT4LRiYIQvlo//z8TpVtIo7MYuO7nUZ15/q0=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=oW/2qmIgFI+dY6WpR025Ki5RQjBNuXZkwUKNZrtahMpX31BcVfR+PRiKZ0ZQ7jZDn0cBHk83SEr1Zg37e378GA7GT+AWsXwP7ZWebjeBubROCnqzOKQ01EZBaJQ1wFo3p97PXi4aJfHlegu1YhJntEvqCochGD8jjFVH04P92KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C15731042;
	Thu, 18 Jan 2024 06:49:56 -0800 (PST)
Received: from [10.57.77.97] (unknown [10.57.77.97])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 247BF3F73F;
	Thu, 18 Jan 2024 06:49:10 -0800 (PST)
Message-ID: <31ca14fe-0dea-47e7-839b-ecd6170c111d@arm.com>
Date: Thu, 18 Jan 2024 14:49:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: memory: move mem_cgroup_charge() into
 alloc_anon_folio()
Content-Language: en-GB
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>
References: <20240117103954.2756050-1-wangkefeng.wang@huawei.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240117103954.2756050-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 10:39, Kefeng Wang wrote:
> mem_cgroup_charge() uses the GFP flags in a fairly sophisticated way.
> In addition to checking gfpflags_allow_blocking(), it pays attention
> to __GFP_NORETRY and __GFP_RETRY_MAYFAIL to ensure that processes within
> this memcg do not exceed their quotas. Using the same GFP flags ensures
> that we handle large anonymous folios correctly, including falling back
> to smaller orders when there is plenty of memory available in the system
> but this memcg is close to its limits.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
> v2:
> - fix built when !CONFIG_TRANSPARENT_HUGEPAGE
> - update changelog suggested by Matthew Wilcox
> 
>  mm/memory.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 5e88d5379127..551f0b21bc42 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4153,8 +4153,8 @@ static bool pte_range_none(pte_t *pte, int nr_pages)
>  
>  static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  {
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	struct vm_area_struct *vma = vmf->vma;
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	unsigned long orders;
>  	struct folio *folio;
>  	unsigned long addr;
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


