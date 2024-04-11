Return-Path: <linux-kernel+bounces-141341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9448A1CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB531C22661
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A6A46B9F;
	Thu, 11 Apr 2024 16:43:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643DC46522
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853836; cv=none; b=GOLV1FHjy+qpK3quFaHFe7n+Cs9kc7W/ti3sX/yA+/ppU02/HxewdXgcEX2YfV78JRLoLKz6ea878q/m+jHeMvQQ6Vjydpr6/988eeGtPJG6gPg8EJ7hvi1AVHPMDSgWNzKys1oziTEHuxK4yETakzly4fiXHb987mZEvw4zjww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853836; c=relaxed/simple;
	bh=0SyqSdqS/KQm0XugWabY7DRVTWjg+dy5UbwBkao/aq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBzo9VL+Z1VKZ9hTulqZI7ApkH55m8w+cHAZmpL7gzecRhXFaF3U9AXqtMneJX7u1YPdTLX37PuU/xfrvvqrNw6OL2TNgRnb5oDBwrMD1iIGBHUP2lGlyazX1DJ7uPoxlihor7/su4tKL5JRtnAh2ylculiTkATzX90A/AsKhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51C8D113E;
	Thu, 11 Apr 2024 09:44:24 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D4A03F6C4;
	Thu, 11 Apr 2024 09:43:53 -0700 (PDT)
Message-ID: <f56d3f42-c7c9-4c0a-9e1a-b89e92a3cc97@arm.com>
Date: Thu, 11 Apr 2024 17:43:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mm: add per-order mTHP anon_swpout and
 anon_swpout_fallback counters
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, david@redhat.com,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com, chrisl@kernel.org, kasong@tencent.com,
 peterx@redhat.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, yosryahmed@google.com, yuzhao@google.com,
 linux-kernel@vger.kernel.org
References: <20240405102704.77559-1-21cnbao@gmail.com>
 <20240405102704.77559-3-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240405102704.77559-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 11:27, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> This helps to display the fragmentation situation of the swapfile,
> knowing the proportion of how much we haven't split large folios.
> So far, we only support non-split swapout for anon memory, with
> the possibility of expanding to shmem in the future.  So, we add
> the "anon" prefix to the counter names.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/huge_mm.h | 2 ++
>  mm/huge_memory.c        | 4 ++++
>  mm/page_io.c            | 6 +++++-
>  mm/vmscan.c             | 3 +++
>  4 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c5d33017a4dd..1d893a358df6 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -267,6 +267,8 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  enum mthp_stat_item {
>  	MTHP_STAT_ANON_ALLOC,
>  	MTHP_STAT_ANON_ALLOC_FALLBACK,
> +	MTHP_STAT_ANON_SWPOUT,
> +	MTHP_STAT_ANON_SWPOUT_FALLBACK,
>  	__MTHP_STAT_COUNT
>  };
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5b875f0fc923..28113f8fdf18 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -554,10 +554,14 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>  
>  DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON_ALLOC);
>  DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> +DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
>  
>  static struct attribute *stats_attrs[] = {
>  	&anon_alloc_attr.attr,
>  	&anon_alloc_fallback_attr.attr,
> +	&anon_swpout_attr.attr,
> +	&anon_swpout_fallback_attr.attr,
>  	NULL,
>  };
>  
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a9a7c236aecc..7669452e8b4d 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -212,13 +212,17 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>  
>  static inline void count_swpout_vm_event(struct folio *folio)
>  {
> +	long nr_pages = folio_nr_pages(folio);
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	if (unlikely(folio_test_pmd_mappable(folio))) {
>  		count_memcg_folio_events(folio, THP_SWPOUT, 1);
>  		count_vm_event(THP_SWPOUT);
>  	}
> +	if (nr_pages > 0)
> +		count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT);

I think you mean "nr_pages > 1"? Although as established in my comments against
patch 1, its safe to call for order-0, so could just unconditionally call this
(as you effectively are at the moment).

>  #endif
> -	count_vm_events(PSWPOUT, folio_nr_pages(folio));
> +	count_vm_events(PSWPOUT, nr_pages);
>  }
>  
>  #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ffc4553c8615..b30e6294f82a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1247,6 +1247,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  						count_vm_event(
>  							THP_SWPOUT_FALLBACK);
>  					}
> +					if (nr_pages > 0)
> +						count_mthp_stat(get_order(nr_pages * PAGE_SIZE),
> +							MTHP_STAT_ANON_SWPOUT_FALLBACK);

Same comment.

>  #endif
>  					if (!add_to_swap(folio))
>  						goto activate_locked_split;


