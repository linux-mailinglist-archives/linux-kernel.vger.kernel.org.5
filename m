Return-Path: <linux-kernel+bounces-167498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 281CF8BAA73
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09D21F22DAF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8929814F9DA;
	Fri,  3 May 2024 10:02:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D7C53372
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730534; cv=none; b=hpE6Xe2X7EGxxBBq6itYNJ72t+Edbzuk7aLvJoLJ5N9V5HxJJSe5mxJswCY+nHXJ5nPMrMg7ghQIqI3E5+3FgNY3+3cWRGjmASmxBY/lVFRtTSopt7ZTmjxukxzNF2KpIhEVV/Po5Oa34bkJ/dTp+irIiJY03mSbiR4n/gI57AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730534; c=relaxed/simple;
	bh=KCwLPlV25d9uHuUcf5x3zYTtdNA1BuArmrXCavdiUyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwmXdWRoPT6rSHoXoHI2mKqoXTtZ9bUJsVwYjqEql+1uKA8UGYfRlcfFpzVinzAc7bd3x/xNsxUum9+1NLh71egSi2tz3gfBqx1U3jCqhBFakg9R6CzUNrLO5JokBVAcZwUYX1phJA3jwumQuFAWhuQKZPI0KfAhHJCmXmf/qEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0D3D2F4;
	Fri,  3 May 2024 03:02:36 -0700 (PDT)
Received: from [10.57.67.51] (unknown [10.57.67.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B99C3F793;
	Fri,  3 May 2024 03:02:08 -0700 (PDT)
Message-ID: <df07855c-5f7f-4bac-bc46-461323e0f98c@arm.com>
Date: Fri, 3 May 2024 11:02:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm: introduce arch_do_swap_page_nr() which allows
 restore metadata for nr pages
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com, Khalid Aziz <khalid.aziz@oracle.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-5-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240503005023.174597-5-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/05/2024 01:50, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Should do_swap_page() have the capability to directly map a large folio,
> metadata restoration becomes necessary for a specified number of pages
> denoted as nr. It's important to highlight that metadata restoration is
> solely required by the SPARC platform, which, however, does not enable
> THP_SWAP. Consequently, in the present kernel configuration, there
> exists no practical scenario where users necessitate the restoration of
> nr metadata. Platforms implementing THP_SWAP might invoke this function
> with nr values exceeding 1, subsequent to do_swap_page() successfully
> mapping an entire large folio. Nonetheless, their arch_do_swap_page_nr()
> functions remain empty.
> 
> Cc: Khalid Aziz <khalid.aziz@oracle.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/pgtable.h | 26 ++++++++++++++++++++------
>  mm/memory.c             |  3 ++-
>  2 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 18019f037bae..463e84c3de26 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1084,6 +1084,15 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
>  })
>  
>  #ifndef __HAVE_ARCH_DO_SWAP_PAGE
> +static inline void arch_do_swap_page_nr(struct mm_struct *mm,
> +				     struct vm_area_struct *vma,
> +				     unsigned long addr,
> +				     pte_t pte, pte_t oldpte,
> +				     int nr)
> +{
> +
> +}
> +#else
>  /*
>   * Some architectures support metadata associated with a page. When a
>   * page is being swapped out, this metadata must be saved so it can be
> @@ -1092,12 +1101,17 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
>   * page as metadata for the page. arch_do_swap_page() can restore this
>   * metadata when a page is swapped back in.
>   */
> -static inline void arch_do_swap_page(struct mm_struct *mm,
> -				     struct vm_area_struct *vma,
> -				     unsigned long addr,
> -				     pte_t pte, pte_t oldpte)

This hook seems to be very similar to arch_swap_restore(), I wonder if it makes
sense to merge them. Out of scope for this patch series though.


> -{
> -
> +static inline void arch_do_swap_page_nr(struct mm_struct *mm,
> +					struct vm_area_struct *vma,
> +					unsigned long addr,
> +					pte_t pte, pte_t oldpte,
> +					int nr)
> +{
> +	for (int i = 0; i < nr; i++) {
> +		arch_do_swap_page(vma->vm_mm, vma, addr + i * PAGE_SIZE,
> +				pte_advance_pfn(pte, i),
> +				pte_advance_pfn(oldpte, i));

It seems a bit odd to create a batched version of this, but not allow arches to
take advantage. Although I guess your point is that only SPARC implements it and
on that platform nr will always be 1? So no point right now? So this is just a
convenience for do_swap_page()? Makes sense.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> +	}
>  }
>  #endif
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index f033eb3528ba..74cdefd58f5f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4266,7 +4266,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	VM_BUG_ON(!folio_test_anon(folio) ||
>  			(pte_write(pte) && !PageAnonExclusive(page)));
>  	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> -	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
> +	arch_do_swap_page_nr(vma->vm_mm, vma, vmf->address,
> +			pte, vmf->orig_pte, 1);
>  
>  	folio_unlock(folio);
>  	if (folio != swapcache && swapcache) {


