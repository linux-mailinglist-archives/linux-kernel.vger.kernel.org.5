Return-Path: <linux-kernel+bounces-140700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB88A17F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2461F229DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7DCE55F;
	Thu, 11 Apr 2024 14:54:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B68C4A0F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847265; cv=none; b=KjFW7kirJOdc/u7RGvCO5ITP/742nEKm+iDq/K+y2UdZuHknBLJ4fdeia3Ad+nt8oj77FjIAlZb8bAcCK+9ZDDB7p7gy16IsfX2lwzKaCsQliPdMgxgHSSgbxHpBrWuJm/jZuUx89w33PUOL+GbbjByF1LOC5rwc8IOuv7VpPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847265; c=relaxed/simple;
	bh=p2VWx9wX7pfCoV8KYD5Fn4zeoCayR9uXClpB4Y7jwt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEXhv2QQ+vwARk+4UG2+bGfLqsab8DQ/f8o80Dtny1zU/U5AErZzQHl0T5UT/yGwC2AbthtMpKPJYhXhFmqwzorPmXjUXDqRkKmiRG+qMZsYCNSSzzFthERljKFNncV8xJPnk9XYDjToYRYAQUJqd+LwIrJKmpsGvYwoYV7nHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A66F113E;
	Thu, 11 Apr 2024 07:54:52 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7634A3F6C4;
	Thu, 11 Apr 2024 07:54:20 -0700 (PDT)
Message-ID: <744f795b-7ce8-40ab-911b-60906aa4fed1@arm.com>
Date: Thu, 11 Apr 2024 15:54:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: swap_pte_batch: add an output argument to
 reture if all swap entries are exclusive
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org
References: <20240409082631.187483-1-21cnbao@gmail.com>
 <20240409082631.187483-4-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240409082631.187483-4-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 09:26, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Add a boolean argument named any_shared. If any of the swap entries are
> non-exclusive, set any_shared to true. The function do_swap_page() can
> then utilize this information to determine whether the entire large
> folio can be reused.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/internal.h | 9 ++++++++-
>  mm/madvise.c  | 2 +-
>  mm/memory.c   | 2 +-
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 9d3250b4a08a..cae39c372bfc 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -238,7 +238,8 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
>   *
>   * Return: the number of table entries in the batch.
>   */
> -static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
> +static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte,
> +				bool *any_shared)

Please update the docs in the comment above this for the new param; follow
folio_pte_batch()'s docs as a template.

>  {
>  	pte_t expected_pte = pte_next_swp_offset(pte);
>  	const pte_t *end_ptep = start_ptep + max_nr;
> @@ -248,12 +249,18 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
>  	VM_WARN_ON(!is_swap_pte(pte));
>  	VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));
>  
> +	if (any_shared)
> +		*any_shared |= !pte_swp_exclusive(pte);

This is different from the approach in folio_pte_batch(). It inits *any_shared
to false and does NOT include the value of the first pte. I think that's odd,
personally and I prefer your approach. I'm not sure if there was a good reason
that David chose the other approach? Regardless, I think both functions should
follow the same pattern here.

If sticking with your approach, why is this initial flag being ORed? Surely it
should just be initialized to get rid of any previous guff?

Thanks,
Ryan


> +
>  	while (ptep < end_ptep) {
>  		pte = ptep_get(ptep);
>  
>  		if (!pte_same(pte, expected_pte))
>  			break;
>  
> +		if (any_shared)
> +			*any_shared |= !pte_swp_exclusive(pte);
> +
>  		expected_pte = pte_next_swp_offset(expected_pte);
>  		ptep++;
>  	}
> diff --git a/mm/madvise.c b/mm/madvise.c
> index f59169888b8e..d34ca6983227 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -671,7 +671,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  			entry = pte_to_swp_entry(ptent);
>  			if (!non_swap_entry(entry)) {
>  				max_nr = (end - addr) / PAGE_SIZE;
> -				nr = swap_pte_batch(pte, max_nr, ptent);
> +				nr = swap_pte_batch(pte, max_nr, ptent, NULL);
>  				nr_swap -= nr;
>  				free_swap_and_cache_nr(entry, nr);
>  				clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
> diff --git a/mm/memory.c b/mm/memory.c
> index 2702d449880e..c4a52e8d740a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1638,7 +1638,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			folio_put(folio);
>  		} else if (!non_swap_entry(entry)) {
>  			max_nr = (end - addr) / PAGE_SIZE;
> -			nr = swap_pte_batch(pte, max_nr, ptent);
> +			nr = swap_pte_batch(pte, max_nr, ptent, NULL);
>  			/* Genuine swap entries, hence a private anon pages */
>  			if (!should_zap_cows(details))
>  				continue;


