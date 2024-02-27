Return-Path: <linux-kernel+bounces-82911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B2F868BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347F5B28B91
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8109E134CD5;
	Tue, 27 Feb 2024 09:07:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B137F3D68
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024864; cv=none; b=qXkt/O0n3SP1BgzIuKOunwyiF+xfqzuNK/302Sq0kv20IVQHW1A1BNkjDYAY1hJWIcLRO5BO7vPYDn2FTEnNI4ACMMlmJS4TOScUEnMvXaCZw7eW4LXV76g5drkx6i6REcYNXZvmGgFpQ9uccLATtk9RgwCOjWQjwwljQ5oqzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024864; c=relaxed/simple;
	bh=G7nU835C8hqM4pUSadWDOwpvcy6eOR8/qsKRX3qfWYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FELdAFE4/M8OIpdA5C9j3KLc69/W0woa8/ec1yFowcNVt7PkDtlxx2rFmTu8hG0wU3RSTufKfg6F7MT8QbzsRwHl0u4COYwYVuVvArgC3s3rxU0rhb7L0ZHuQ0i9y5inxI3k15aaCPHgVmO6UfIYhBoanf2F90QVJsATUYyf1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF50DDA7;
	Tue, 27 Feb 2024 01:08:18 -0800 (PST)
Received: from [10.57.67.4] (unknown [10.57.67.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDF053F762;
	Tue, 27 Feb 2024 01:07:38 -0800 (PST)
Message-ID: <61b9dfc9-5522-44fd-89a4-140833ede8af@arm.com>
Date: Tue, 27 Feb 2024 09:07:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Lance Yang <ioworker0@gmail.com>, David Hildenbrand <david@redhat.com>,
 Yin Fengwei <fengwei.yin@intel.com>
References: <20240227024050.244567-1-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240227024050.244567-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/02/2024 02:40, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> madvise and some others might need folio_pte_batch to check if a range
> of PTEs are completely mapped to a large folio with contiguous physcial
> addresses. Let's export it for others to use.
> 
> Cc: Lance Yang <ioworker0@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  -v1:
>  at least two jobs madv_free and madv_pageout depend on it. To avoid
>  conflicts and dependencies, after discussing with Lance, we prefer
>  this one can land earlier.

I think this will also ultimately be useful for mprotect too, though I haven't
looked at it properly yet.

> 
>  mm/internal.h | 13 +++++++++++++
>  mm/memory.c   | 11 +----------
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 13b59d384845..8e2bc304f671 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct folio *folio)
>  	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
>  }
>  
> +/* Flags for folio_pte_batch(). */
> +typedef int __bitwise fpb_t;
> +
> +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> +#define FPB_IGNORE_DIRTY		((__force fpb_t)BIT(0))
> +
> +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
> +#define FPB_IGNORE_SOFT_DIRTY		((__force fpb_t)BIT(1))
> +
> +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
> +		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> +		bool *any_writable);
> +
>  void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
>  						int nr_throttled);
>  static inline void acct_reclaim_writeback(struct folio *folio)
> diff --git a/mm/memory.c b/mm/memory.c
> index 1c45b6a42a1b..319b3be05e75 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -953,15 +953,6 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
>  	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>  }
>  
> -/* Flags for folio_pte_batch(). */
> -typedef int __bitwise fpb_t;
> -
> -/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> -#define FPB_IGNORE_DIRTY		((__force fpb_t)BIT(0))
> -
> -/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
> -#define FPB_IGNORE_SOFT_DIRTY		((__force fpb_t)BIT(1))
> -
>  static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>  {
>  	if (flags & FPB_IGNORE_DIRTY)
> @@ -982,7 +973,7 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>   * If "any_writable" is set, it will indicate if any other PTE besides the
>   * first (given) PTE is writable.
>   */

David was talking in Lance's patch thread, about improving the docs for this
function now that its exported. Might be worth syncing on that.

> -static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
> +int folio_pte_batch(struct folio *folio, unsigned long addr,

fork() is very performance sensitive. Is there a risk we are regressing
performance by making this out-of-line? Although its in the same compilation
unit so the compiler may well inline it anyway?

Either way, perhaps we are better off making it inline in the header? That would
avoid needing to rerun David's micro-benchmarks for fork() and munmap().

Thanks,
Ryan

>  		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
>  		bool *any_writable)
>  {


