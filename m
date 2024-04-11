Return-Path: <linux-kernel+bounces-141332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 551848A1CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEE92876A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA82317D14A;
	Thu, 11 Apr 2024 16:38:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E61717D148
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853494; cv=none; b=eOTeMUjfSIKjRzMz6qylBVGXCXI80uhWkHPpByXb/7DpT5EWK+KPYLXiz5rVT7dz19iGKbylw5Ii3NstXVyhKOKlPJQHXyn2jQGp4dHm8jblMcjAsx4X0JC34bXM03GZsaqkJhMuHDdID4LtXF6IUC4I537AoIYGX/ta64+Jgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853494; c=relaxed/simple;
	bh=8i4fmnC1IdzhIg9mdpwR5VZE+4QVHE0H8clj3gC7Y3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kb9dCNZTg3LGM8sdmTwJvhzywxo13jH3sGhFRvxU15/r/txeX9p/0cXKGt6qAe0yOU1ENuu4QZOMX4tqiwZify9BIoCZA8JzEnh4NI3LEaIOlOfObsOWjWj7xqUGmrYLXkGBG/71k8GTW9yqBknnzcHykyZQMPMdOVYhgwaOQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD105113E;
	Thu, 11 Apr 2024 09:38:40 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FB743F6C4;
	Thu, 11 Apr 2024 09:38:09 -0700 (PDT)
Message-ID: <7cf0a47b-0347-4e81-956f-34bef4ef794a@arm.com>
Date: Thu, 11 Apr 2024 17:38:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mm: add per-order mTHP anon_alloc and
 anon_alloc_fallback counters
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, david@redhat.com,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com, chrisl@kernel.org, kasong@tencent.com,
 peterx@redhat.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, yosryahmed@google.com, yuzhao@google.com,
 linux-kernel@vger.kernel.org
References: <20240405102704.77559-1-21cnbao@gmail.com>
 <20240405102704.77559-2-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240405102704.77559-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 11:27, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Profiling a system blindly with mTHP has become challenging due to the
> lack of visibility into its operations. Presenting the success rate of
> mTHP allocations appears to be pressing need.
> 
> Recently, I've been experiencing significant difficulty debugging
> performance improvements and regressions without these figures.
> It's crucial for us to understand the true effectiveness of mTHP in
> real-world scenarios, especially in systems with fragmented memory.
> 
> This patch sets up the framework for per-order mTHP counters, starting
> with the introduction of anon_alloc and anon_alloc_fallback counters.
> Incorporating additional counters should now be straightforward as well.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/huge_mm.h | 19 ++++++++++++++++
>  mm/huge_memory.c        | 48 +++++++++++++++++++++++++++++++++++++++++
>  mm/memory.c             |  2 ++
>  3 files changed, 69 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index e896ca4760f6..c5d33017a4dd 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -264,6 +264,25 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					  enforce_sysfs, orders);
>  }
>  
> +enum mthp_stat_item {
> +	MTHP_STAT_ANON_ALLOC,
> +	MTHP_STAT_ANON_ALLOC_FALLBACK,
> +	__MTHP_STAT_COUNT
> +};
> +
> +struct mthp_stat {
> +	unsigned long stats[PMD_ORDER + 1][__MTHP_STAT_COUNT];

I saw a fix for this allocation dynamically due to powerpc PMD_ORDER not being
constant. I wonder if ilog2(MAX_PTRS_PER_PTE) would help here?

> +};
> +
> +DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
> +
> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)

I thought we were going to call this always counting up type of stat and event?
"count_mthp_event"? But I'm happy with it as is, personally.

> +{
> +	if (unlikely(order > PMD_ORDER))
> +		return;

I'm wondering if it also makes sense to ignore order == 0? Although I guess if
called for order-0 its safe since the storage exists and sum_mthp_stat() is
never be called for 0. Ignore this comment :)

> +	this_cpu_inc(mthp_stats.stats[order][item]);
> +}
> +
>  #define transparent_hugepage_use_zero_page()				\
>  	(transparent_hugepage_flags &					\
>  	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9d4b2fbf6872..5b875f0fc923 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -526,6 +526,46 @@ static const struct kobj_type thpsize_ktype = {
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
> +	for_each_online_cpu(cpu) {

What happens if a cpu that was online and collected a bunch of stats gets
offlined? The user will see stats get smaller?

Perhaps this should be for_each_possible_cpu()? Although I'm not sure what
happens to percpu data when a cpu goes offline? Is the data preserved? Or wiped,
or unmapped? dunno. Might we need to rescue stats into a global counter at
offline-time?

> +		struct mthp_stat *this = &per_cpu(mthp_stats, cpu);
> +
> +		sum += this->stats[order][item];
> +	}
> +
> +	return sum;
> +}
> +
> +#define DEFINE_MTHP_STAT_ATTR(_name, _index)					\
> +static ssize_t _name##_show(struct kobject *kobj,			\
> +			struct kobj_attribute *attr, char *buf)		\
> +{									\
> +	int order = to_thpsize(kobj)->order;				\
> +									\
> +	return sysfs_emit(buf, "%lu\n", sum_mthp_stat(order, _index));	\
> +}									\
> +static struct kobj_attribute _name##_attr = __ATTR_RO(_name)

Very nice!

> +
> +DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBACK);
> +
> +static struct attribute *stats_attrs[] = {
> +	&anon_alloc_attr.attr,
> +	&anon_alloc_fallback_attr.attr,
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
> @@ -549,6 +589,12 @@ static struct thpsize *thpsize_create(int order, struct kobject *parent)
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
> @@ -1050,8 +1096,10 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>  	folio = vma_alloc_folio(gfp, HPAGE_PMD_ORDER, vma, haddr, true);
>  	if (unlikely(!folio)) {
>  		count_vm_event(THP_FAULT_FALLBACK);
> +		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_ALLOC_FALLBACK);

I think we should aim for the PMD-oder MTHP_STAT_ANON_ALLOC and
MTHP_STAT_ANON_ALLOC_FALLBACK to match THP_FAULT_ALLOC and THP_FAULT_FALLBACK.
Its not currently setup this way...


>  		return VM_FAULT_FALLBACK;
>  	}
> +	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_ALLOC);
>  	return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
>  }
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index 649e3ed94487..1723c8ddf9cb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4374,8 +4374,10 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  			}
>  			folio_throttle_swaprate(folio, gfp);
>  			clear_huge_page(&folio->page, vmf->address, 1 << order);
> +			count_mthp_stat(order, MTHP_STAT_ANON_ALLOC);
>  			return folio;
>  		}
> +		count_mthp_stat(order, MTHP_STAT_ANON_ALLOC_FALLBACK);

..And we should follow the usage same pattern for the smaller mTHP here too.
Which means MTHP_STAT_ANON_ALLOC_FALLBACK should be after the next: label. We
could introduce a MTHP_STAT_ANON_ALLOC_FALLBACK_CHARGE which would only trigger
on a fallback due to charge failure, just like THP_FAULT_FALLBACK_CHARGE?

>  next:
>  		order = next_order(&orders, order);
>  	}


