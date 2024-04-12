Return-Path: <linux-kernel+bounces-142617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962B28A2DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9F0B227AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E24B56473;
	Fri, 12 Apr 2024 11:59:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEBF55E48
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923158; cv=none; b=Q8RH5bWafVejJ3r3hk+4yab0xGk8g8N9pAWWQZ8GUqaRJ9Rj6Kpmuxc+kF1gj9xHcGxb4JxmMS2X4zhNs0ea7EW95WrLu0BUq4TnxWqtyJyXigF0/iwtl+PYk5cDFPBGiEwFcO+Li7r6tmmziDSxNMwg/IsYxDi+YCP9xqZ2jbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923158; c=relaxed/simple;
	bh=/sb+A9lK7Yo/5fBZfRv2ZdrJCofGb/FZmlFC/z/g59o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSmIDYGsbGsH3R+2B/i7pd3eDGFso6F0/zsyrJuElsUixnbANK194+ejdE75mU3e7ylEXnpxVC+l5HJtanQx/kmakySKn4A0h7l+j0wF6feD2OOk5LuMGXhOqreg5Yhs3eWJPdVgZ92gtcPD1amNBztw9TlKoSE/cFesJuRowQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECFEE339;
	Fri, 12 Apr 2024 04:59:44 -0700 (PDT)
Received: from [10.57.73.208] (unknown [10.57.73.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80C613F766;
	Fri, 12 Apr 2024 04:59:13 -0700 (PDT)
Message-ID: <a9934cfa-3c11-4c7c-b8aa-effaf015acbc@arm.com>
Date: Fri, 12 Apr 2024 12:59:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] mm: add per-order mTHP anon_fault_alloc and
 anon_fault_fallback counters
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com, chrisl@kernel.org, david@redhat.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, peterx@redhat.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 yosryahmed@google.com, yuzhao@google.com, corbet@lwn.net
References: <20240412114858.407208-1-21cnbao@gmail.com>
 <20240412114858.407208-2-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240412114858.407208-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/04/2024 12:48, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Profiling a system blindly with mTHP has become challenging due to the
> lack of visibility into its operations.  Presenting the success rate of
> mTHP allocations appears to be pressing need.
> 
> Recently, I've been experiencing significant difficulty debugging
> performance improvements and regressions without these figures.  It's
> crucial for us to understand the true effectiveness of mTHP in real-world
> scenarios, especially in systems with fragmented memory.
> 
> This patch establishes the framework for per-order mTHP
> counters. It begins by introducing the anon_fault_alloc and
> anon_fault_fallback counters. Additionally, to maintain consistency
> with thp_fault_fallback_charge in /proc/vmstat, this patch also tracks
> anon_fault_fallback_charge when mem_cgroup_charge fails for mTHP.
> Incorporating additional counters should now be straightforward as well.
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
>  include/linux/huge_mm.h | 21 +++++++++++++++++
>  mm/huge_memory.c        | 52 +++++++++++++++++++++++++++++++++++++++++
>  mm/memory.c             |  5 ++++
>  3 files changed, 78 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index e896ca4760f6..d4fdb2641070 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -264,6 +264,27 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					  enforce_sysfs, orders);
>  }
>  
> +enum mthp_stat_item {
> +	MTHP_STAT_ANON_FAULT_ALLOC,
> +	MTHP_STAT_ANON_FAULT_FALLBACK,
> +	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> +	__MTHP_STAT_COUNT
> +};
> +
> +struct mthp_stat {
> +	unsigned long stats[ilog2(MAX_PTRS_PER_PTE) + 1][__MTHP_STAT_COUNT];
> +};
> +
> +DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
> +
> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> +{
> +	if (order <= 0 || order > PMD_ORDER)
> +		return;
> +
> +	this_cpu_inc(mthp_stats.stats[order][item]);
> +}
> +
>  #define transparent_hugepage_use_zero_page()				\
>  	(transparent_hugepage_flags &					\
>  	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index dc30139590e6..dfc38cc83a04 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -526,6 +526,48 @@ static const struct kobj_type thpsize_ktype = {
>  	.sysfs_ops = &kobj_sysfs_ops,
>  };
>  
> +DEFINE_PER_CPU(struct mthp_stat, mthp_stats) = {{{0}}};
> +
> +static unsigned long sum_mthp_stat(int order, enum mthp_stat_item item)
> +{
> +	unsigned long sum = 0;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct mthp_stat *this = &per_cpu(mthp_stats, cpu);
> +
> +		sum += this->stats[order][item];
> +	}
> +
> +	return sum;
> +}
> +
> +#define DEFINE_MTHP_STAT_ATTR(_name, _index)				\
> +static ssize_t _name##_show(struct kobject *kobj,			\
> +			struct kobj_attribute *attr, char *buf)		\
> +{									\
> +	int order = to_thpsize(kobj)->order;				\
> +									\
> +	return sysfs_emit(buf, "%lu\n", sum_mthp_stat(order, _index));	\
> +}									\
> +static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
> +
> +DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +
> +static struct attribute *stats_attrs[] = {
> +	&anon_fault_alloc_attr.attr,
> +	&anon_fault_fallback_attr.attr,
> +	&anon_fault_fallback_charge_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group stats_attr_group = {
> +	.name = "stats",
> +	.attrs = stats_attrs,
> +};
> +
>  static struct thpsize *thpsize_create(int order, struct kobject *parent)
>  {
>  	unsigned long size = (PAGE_SIZE << order) / SZ_1K;
> @@ -549,6 +591,12 @@ static struct thpsize *thpsize_create(int order, struct kobject *parent)
>  		return ERR_PTR(ret);
>  	}
>  
> +	ret = sysfs_create_group(&thpsize->kobj, &stats_attr_group);
> +	if (ret) {
> +		kobject_put(&thpsize->kobj);
> +		return ERR_PTR(ret);
> +	}
> +
>  	thpsize->order = order;
>  	return thpsize;
>  }
> @@ -880,6 +928,8 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>  		folio_put(folio);
>  		count_vm_event(THP_FAULT_FALLBACK);
>  		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
> +		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
> +		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>  		return VM_FAULT_FALLBACK;
>  	}
>  	folio_throttle_swaprate(folio, gfp);
> @@ -929,6 +979,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>  		mm_inc_nr_ptes(vma->vm_mm);
>  		spin_unlock(vmf->ptl);
>  		count_vm_event(THP_FAULT_ALLOC);
> +		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>  		count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>  	}
>  
> @@ -1050,6 +1101,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>  	folio = vma_alloc_folio(gfp, HPAGE_PMD_ORDER, vma, haddr, true);
>  	if (unlikely(!folio)) {
>  		count_vm_event(THP_FAULT_FALLBACK);
> +		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
>  		return VM_FAULT_FALLBACK;
>  	}
>  	return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
> diff --git a/mm/memory.c b/mm/memory.c
> index 649a547fe8e3..f31da2de19c6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4368,6 +4368,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  		folio = vma_alloc_folio(gfp, order, vma, addr, true);
>  		if (folio) {
>  			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
> +				count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>  				folio_put(folio);
>  				goto next;
>  			}
> @@ -4376,6 +4377,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  			return folio;
>  		}
>  next:
> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
>  		order = next_order(&orders, order);
>  	}
>  
> @@ -4485,6 +4487,9 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  
>  	folio_ref_add(folio, nr_pages - 1);
>  	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_FAULT_ALLOC);
> +#endif
>  	folio_add_new_anon_rmap(folio, vma, addr);
>  	folio_add_lru_vma(folio, vma);
>  setpte:


