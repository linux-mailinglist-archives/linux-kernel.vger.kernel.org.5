Return-Path: <linux-kernel+bounces-167476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1328BAA0D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC98FB2319C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6889115098C;
	Fri,  3 May 2024 09:41:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FF2150989
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729294; cv=none; b=m4/JZodSOKr8zzBQ9m7gTOR+os6hBvqaCDQUSOKDUtJvppwNFthhaMLrY8BWhXgn4XCHdlWy7U6oxTArlRnjXtslNnc6hsLb+h9hnPdNO/HIVL+AwrfNuiE7lqsA0YsmAWMfGlJkCLXdBnWGMJMeslWx42lurfTAo63WaQGZrX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729294; c=relaxed/simple;
	bh=f4HrUcLa0BuyAQ1Q2lacGUJMKE4Z8QjwrumYFT5mAA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUQhgX5jsTWsUMSjeGqk00wmzfXOb/cT9A2wZ9zIj03rHcfOSVa7VQiuuSM8I6cKZZoS0m4lGeD6NrlZ4ZlWXHXupfggmL5O48pijfEVmwYK3t8S8NmhprqKdvRldCgZL1rbuAwDDwa8C/oM5kw1JTv4HC5cXsBPzL5R7KLM+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AB31339;
	Fri,  3 May 2024 02:41:56 -0700 (PDT)
Received: from [10.57.67.51] (unknown [10.57.67.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 490343F73F;
	Fri,  3 May 2024 02:41:28 -0700 (PDT)
Message-ID: <7548e30c-d56a-4a57-ab87-86c9c8e523b1@arm.com>
Date: Fri, 3 May 2024 10:41:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] mm: introduce pte_move_swp_offset() helper which
 can move offset bidirectionally
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-4-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240503005023.174597-4-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/05/2024 01:50, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> There could arise a necessity to obtain the first pte_t from a swap
> pte_t located in the middle. For instance, this may occur within the
> context of do_swap_page(), where a page fault can potentially occur in
> any PTE of a large folio. To address this, the following patch introduces
> pte_move_swp_offset(), a function capable of bidirectional movement by
> a specified delta argument. Consequently, pte_increment_swp_offset()

You mean pte_next_swp_offset()?

> will directly invoke it with delta = 1.
> 
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/internal.h | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index c5552d35d995..cfe4aed66a5c 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -211,18 +211,21 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>  }
>  
>  /**
> - * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
> + * pte_move_swp_offset - Move the swap entry offset field of a swap pte
> + *	 forward or backward by delta
>   * @pte: The initial pte state; is_swap_pte(pte) must be true and
>   *	 non_swap_entry() must be false.
> + * @delta: The direction and the offset we are moving; forward if delta
> + *	 is positive; backward if delta is negative
>   *
> - * Increments the swap offset, while maintaining all other fields, including
> + * Moves the swap offset, while maintaining all other fields, including
>   * swap type, and any swp pte bits. The resulting pte is returned.
>   */
> -static inline pte_t pte_next_swp_offset(pte_t pte)
> +static inline pte_t pte_move_swp_offset(pte_t pte, long delta)

We have equivalent functions for pfn:

  pte_next_pfn()
  pte_advance_pfn()

Although the latter takes an unsigned long and only moves forward currently. I
wonder if it makes sense to have their naming and semantics match? i.e. change
pte_advance_pfn() to pte_move_pfn() and let it move backwards too.

I guess we don't have a need for that and it adds more churn.

Anyway:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>


>  {
>  	swp_entry_t entry = pte_to_swp_entry(pte);
>  	pte_t new = __swp_entry_to_pte(__swp_entry(swp_type(entry),
> -						   (swp_offset(entry) + 1)));
> +						   (swp_offset(entry) + delta)));
>  
>  	if (pte_swp_soft_dirty(pte))
>  		new = pte_swp_mksoft_dirty(new);
> @@ -234,6 +237,20 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
>  	return new;
>  }
>  
> +
> +/**
> + * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
> + * @pte: The initial pte state; is_swap_pte(pte) must be true and
> + *	 non_swap_entry() must be false.
> + *
> + * Increments the swap offset, while maintaining all other fields, including
> + * swap type, and any swp pte bits. The resulting pte is returned.
> + */
> +static inline pte_t pte_next_swp_offset(pte_t pte)
> +{
> +	return pte_move_swp_offset(pte, 1);
> +}
> +
>  /**
>   * swap_pte_batch - detect a PTE batch for a set of contiguous swap entries
>   * @start_ptep: Page table pointer for the first entry.


