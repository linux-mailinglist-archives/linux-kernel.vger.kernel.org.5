Return-Path: <linux-kernel+bounces-142429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2228A2B72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BEF8B21DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D5453399;
	Fri, 12 Apr 2024 09:43:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDCA52F70
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915009; cv=none; b=k+Bpyrsc6lWGa6QfCJ/+KWgJHWHrtn84HW61YfCfZ5eAlKPdU5JGVv5ts5XOOfzDkV9cYt4AqpuEs/MsSfTXKKgceZlAmLI59RvPxUBlGVTRqv7aWWMd2TywBM+M5UqF5Ir3YQ9EJhz7fKFbz9Z7u7iCtGuqlalv47twGPgzw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915009; c=relaxed/simple;
	bh=T9YP0TyPMmcvKYezZlrB1rXp1pu+wMoefLOe9CEdEHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNL6maSe99rsOWbzCsvIOu5TRlRyoOuWSWW6ZRtRERgezblAIF9j1c8c8KHx4En2lgOmhyYydCMpQnph5JBDfRDlfU0YcS4E21z+9iAVLC5bIktwZ36Q/0sCFg2ahzWaY2B6qdNvFaNGiULQkvfVqOhpyo1zNGGhFi4tfAkNLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CF1B339;
	Fri, 12 Apr 2024 02:43:56 -0700 (PDT)
Received: from [10.57.73.208] (unknown [10.57.73.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B7D13F64C;
	Fri, 12 Apr 2024 02:43:24 -0700 (PDT)
Message-ID: <ebcd40f1-9bc6-4ae4-8b12-deedf9b8b450@arm.com>
Date: Fri, 12 Apr 2024 10:43:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] mm: add per-order mTHP anon_swpout and
 anon_swpout_fallback counters
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com, chrisl@kernel.org, david@redhat.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, peterx@redhat.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 yosryahmed@google.com, yuzhao@google.com, corbet@lwn.net
References: <20240412073740.294272-1-21cnbao@gmail.com>
 <20240412073740.294272-3-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240412073740.294272-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/04/2024 08:37, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> This helps to display the fragmentation situation of the swapfile, knowing
> the proportion of how much we haven't split large folios.  So far, we only
> support non-split swapout for anon memory, with the possibility of
> expanding to shmem in the future.  So, we add the "anon" prefix to the
> counter names.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Yu Zhao <yuzhao@google.com>


LGTM!

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>


> ---
>  include/linux/huge_mm.h | 2 ++
>  mm/huge_memory.c        | 4 ++++
>  mm/page_io.c            | 1 +
>  mm/vmscan.c             | 3 +++
>  4 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c5beb54b97cb..b69c3b3e1436 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -268,6 +268,8 @@ enum mthp_stat_item {
>  	MTHP_STAT_ANON_FAULT_ALLOC,
>  	MTHP_STAT_ANON_FAULT_FALLBACK,
>  	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> +	MTHP_STAT_ANON_SWPOUT,
> +	MTHP_STAT_ANON_SWPOUT_FALLBACK,
>  	__MTHP_STAT_COUNT
>  };
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 21c4ac74b484..13e74724d0c3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -557,11 +557,15 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>  DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> +DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
>  
>  static struct attribute *stats_attrs[] = {
>  	&anon_fault_alloc_attr.attr,
>  	&anon_fault_fallback_attr.attr,
>  	&anon_fault_fallback_charge_attr.attr,
> +	&anon_swpout_attr.attr,
> +	&anon_swpout_fallback_attr.attr,
>  	NULL,
>  };
>  
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a9a7c236aecc..46c603dddf04 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -217,6 +217,7 @@ static inline void count_swpout_vm_event(struct folio *folio)
>  		count_memcg_folio_events(folio, THP_SWPOUT, 1);
>  		count_vm_event(THP_SWPOUT);
>  	}
> +	count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT);
>  #endif
>  	count_vm_events(PSWPOUT, folio_nr_pages(folio));
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bca2d9981c95..49bd94423961 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1231,6 +1231,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  						goto activate_locked;
>  				}
>  				if (!add_to_swap(folio)) {
> +					int __maybe_unused order = folio_order(folio);
> +
>  					if (!folio_test_large(folio))
>  						goto activate_locked_split;
>  					/* Fallback to swap normal pages */
> @@ -1242,6 +1244,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  							THP_SWPOUT_FALLBACK, 1);
>  						count_vm_event(THP_SWPOUT_FALLBACK);
>  					}
> +					count_mthp_stat(order, MTHP_STAT_ANON_SWPOUT_FALLBACK);
>  #endif
>  					if (!add_to_swap(folio))
>  						goto activate_locked_split;


