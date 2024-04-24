Return-Path: <linux-kernel+bounces-157233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F208B0EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED9B1F2A1B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F3916C423;
	Wed, 24 Apr 2024 15:41:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D43716ABC7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973298; cv=none; b=sZ7Vki9tsDL1rMeYyLqia2ixvRq6hHxgnonP316ij2/HraQqCwdy6EGlkw5UQCPpEdg1Ikro8gAkFgU3Qd5eP5T32NbFR3hJjYFx0SVCAhLDf5nM5oyzowZUY1sOL3Um24Re3JREAVbNnCmaTn6cxHYCfu9ETvO6nbQnodd3BlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973298; c=relaxed/simple;
	bh=YDOT+Scl4Ftcid46ZrKpdxOL3JYX1bQJU/XlxKOLZyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmjw+OlhfCZWblRlYaSbrq+Qvhe5AdC/k4vr9O2bzfdmuKk4u8IAaIi/1TG9Fr03QgOS8JJEpsyGKnfRcJ9jJq9uCLGObL1dPkUTMTEOgzAMKod2gc8je/Tvanqpis8M6+020KM9tHuZlT+zKBLc+9msCyJXR7hlRf5UegQN+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 344EB1063;
	Wed, 24 Apr 2024 08:42:04 -0700 (PDT)
Received: from [10.1.25.156] (XHFQ2J9959.cambridge.arm.com [10.1.25.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 865833F73F;
	Wed, 24 Apr 2024 08:41:35 -0700 (PDT)
Message-ID: <a0f57d90-a556-4b19-a925-a82a81fbb067@arm.com>
Date: Wed, 24 Apr 2024 16:41:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: add per-order mTHP split counters
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org,
 Barry Song <21cnbao@gmail.com>
Cc: 21cnbao@gmail.com, david@redhat.com, baolin.wang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240424135148.30422-1-ioworker0@gmail.com>
 <20240424135148.30422-2-ioworker0@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240424135148.30422-2-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Barry

On 24/04/2024 14:51, Lance Yang wrote:
> At present, the split counters in THP statistics no longer include
> PTE-mapped mTHP. Therefore, this commit introduces per-order mTHP split
> counters to monitor the frequency of mTHP splits. This will assist
> developers in better analyzing and optimizing system performance.
> 
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>         split_page
>         split_page_failed
>         deferred_split_page
> 
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  include/linux/huge_mm.h |  3 +++
>  mm/huge_memory.c        | 14 ++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 56c7ea73090b..7b9c6590e1f7 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -272,6 +272,9 @@ enum mthp_stat_item {
>  	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>  	MTHP_STAT_ANON_SWPOUT,
>  	MTHP_STAT_ANON_SWPOUT_FALLBACK,
> +	MTHP_STAT_SPLIT_PAGE,
> +	MTHP_STAT_SPLIT_PAGE_FAILED,
> +	MTHP_STAT_DEFERRED_SPLIT_PAGE,
>  	__MTHP_STAT_COUNT
>  };
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 055df5aac7c3..52db888e47a6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -557,6 +557,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
>  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(split_page, MTHP_STAT_SPLIT_PAGE);
> +DEFINE_MTHP_STAT_ATTR(split_page_failed, MTHP_STAT_SPLIT_PAGE_FAILED);
> +DEFINE_MTHP_STAT_ATTR(deferred_split_page, MTHP_STAT_DEFERRED_SPLIT_PAGE);
>  
>  static struct attribute *stats_attrs[] = {
>  	&anon_fault_alloc_attr.attr,
> @@ -564,6 +567,9 @@ static struct attribute *stats_attrs[] = {
>  	&anon_fault_fallback_charge_attr.attr,
>  	&anon_swpout_attr.attr,
>  	&anon_swpout_fallback_attr.attr,
> +	&split_page_attr.attr,
> +	&split_page_failed_attr.attr,
> +	&deferred_split_page_attr.attr,
>  	NULL,
>  };
>  
> @@ -3083,7 +3089,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
>  	struct anon_vma *anon_vma = NULL;
>  	struct address_space *mapping = NULL;
> -	bool is_thp = folio_test_pmd_mappable(folio);
> +	int order = folio_order(folio);
>  	int extra_pins, ret;
>  	pgoff_t end;
>  	bool is_hzp;
> @@ -3262,8 +3268,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  		i_mmap_unlock_read(mapping);
>  out:
>  	xas_destroy(&xas);
> -	if (is_thp)
> +	if (order >= HPAGE_PMD_ORDER)
>  		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
> +	count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT_PAGE :
> +				      MTHP_STAT_SPLIT_PAGE_FAILED);
>  	return ret;
>  }
>  
> @@ -3327,6 +3335,8 @@ void deferred_split_folio(struct folio *folio)
>  	if (list_empty(&folio->_deferred_list)) {
>  		if (folio_test_pmd_mappable(folio))
>  			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> +		count_mthp_stat(folio_order(folio),
> +				MTHP_STAT_DEFERRED_SPLIT_PAGE);

There is a very long conversation with Barry about adding a 'global "mTHP became
partially mapped 1 or more processes" counter (inc only)', which terminates at
[1]. There is a lot of discussion about the required semantics around the need
for partial map to cover alignment and contiguity as well as whether all pages
are mapped, and to trigger once it becomes partial in at least 1 process.

MTHP_STAT_DEFERRED_SPLIT_PAGE is giving much simpler semantics, but less
information as a result. Barry, what's your view here? I'm guessing this doesn't
quite solve what you are looking for?

[1] https://lore.kernel.org/linux-mm/6cc7d781-884f-4d8f-a175-8609732b87eb@arm.com/

Thanks,
Ryan

>  		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
>  		ds_queue->split_queue_len++;
>  #ifdef CONFIG_MEMCG


