Return-Path: <linux-kernel+bounces-118416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E75DB88BA77
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C6D2E3407
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68670129E62;
	Tue, 26 Mar 2024 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSqitmzF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBA51E481
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434680; cv=none; b=S67RZFrFOiTbZpGweP318d6MWmu+r86bkwta4fVSpEok1a5QbYdXaMFOuaTSjMes3ayat9ckqj4ifJo9WQ+5HHeFOGxBqFPyrHqhZYKmc725B6910g6GlLy5jIM1RMMslL58xlSFg/YF9/RCcLVFILmJcMG9qeEsGbdErY8D+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434680; c=relaxed/simple;
	bh=Z0yWsONmAAgRCY638TgVLjVUTE7Gba29bNLs77UQsLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sysz/riHcn4lyu1ADwt2V0KseQYjwH5OkT/vDf71x4JD9LHyJMEMMPjeEhc5r5nDh35vJJbkzJ2r1PQbCvh57hsCusK8wxbZ1AKdUxnobTOT/O32KjI7JtR0ilfGn9foJEU4v66/LlOvr3Yb9hL4kKIQ1kgyIKzRKEU+4ryMUtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSqitmzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEEFC433F1;
	Tue, 26 Mar 2024 06:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711434680;
	bh=Z0yWsONmAAgRCY638TgVLjVUTE7Gba29bNLs77UQsLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSqitmzFslaeDwwoWIC4/MrvGLjqnpsa4F/DVJ5MT8KX1CBnP3vAz0rMTuPh4J/Ec
	 puqyiC/IudgRECfqNV97wT/8io829HobIHVG4IBKqTHop2+WkyDa2PKDeSKoPZy0cM
	 sZbb4fVc7Yiy/TeZ1JHD062pxa6YQsLVFZky7MNUF6hrl02QOLqEFJNN4+nxIDitza
	 HVHiDxJh1/1A9i+R0cX3j2tXscvxJSoFLoXHCv1R/vqN5m452ko2JMznd1sVEp1n2I
	 qZxYJsD8KIOm1xDqMXTP9WOhEld4Dd43589r8sfUh0ZZ4zWTDTl7UgLDp9fv7zX1ES
	 chtsrSOeMA+ag==
Date: Tue, 26 Mar 2024 08:30:37 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCH v1 3/3] mm: merge folio_is_secretmem() into
 folio_fast_pin_allowed()
Message-ID: <ZgJrjVvwWnWEZC-7@kernel.org>
References: <20240325134114.257544-1-david@redhat.com>
 <20240325134114.257544-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325134114.257544-4-david@redhat.com>

On Mon, Mar 25, 2024 at 02:41:14PM +0100, David Hildenbrand wrote:
> folio_is_secretmem() is currently only used during GUP-fast, and using
> it in wrong context where concurrent truncation might happen, could be
> problematic.
> 
> Nowadays, folio_fast_pin_allowed() performs similar checks during
> GUP-fast and contains a lot of careful handling -- READ_ONCE( -- ), sanity
> checks -- lockdep_assert_irqs_disabled() --  and helpful comments on how
> this handling is safe and correct.
> 
> So let's merge folio_is_secretmem() into folio_fast_pin_allowed(), still
> avoiding checking the actual mapping only if really required.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

A few comments below, no strong feelings about them.

> ---
>  include/linux/secretmem.h | 21 ++-------------------
>  mm/gup.c                  | 33 +++++++++++++++++++++------------
>  2 files changed, 23 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> index 6996f1f53f14..e918f96881f5 100644
> --- a/include/linux/secretmem.h
> +++ b/include/linux/secretmem.h
> @@ -6,25 +6,8 @@
>  
>  extern const struct address_space_operations secretmem_aops;
>  
> -static inline bool folio_is_secretmem(struct folio *folio)
> +static inline bool secretmem_mapping(struct address_space *mapping)
>  {
> -	struct address_space *mapping;
> -
> -	/*
> -	 * Using folio_mapping() is quite slow because of the actual call
> -	 * instruction.
> -	 * We know that secretmem pages are not compound and LRU so we can
> -	 * save a couple of cycles here.
> -	 */
> -	if (folio_test_large(folio) || folio_test_lru(folio))
> -		return false;
> -
> -	mapping = (struct address_space *)
> -		((unsigned long)folio->mapping & ~PAGE_MAPPING_FLAGS);
> -
> -	if (!mapping || mapping != folio->mapping)
> -		return false;
> -
>  	return mapping->a_ops == &secretmem_aops;
>  }
>  
> @@ -38,7 +21,7 @@ static inline bool vma_is_secretmem(struct vm_area_struct *vma)
>  	return false;
>  }
>  
> -static inline bool folio_is_secretmem(struct folio *folio)
> +static inline bool secretmem_mapping(struct address_space *mapping)
>  {
>  	return false;
>  }
> diff --git a/mm/gup.c b/mm/gup.c
> index e7510b6ce765..69d8bc8e4451 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2472,6 +2472,8 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>   * This call assumes the caller has pinned the folio, that the lowest page table
>   * level still points to this folio, and that interrupts have been disabled.
>   *
> + * GUP-fast must reject all secretmem folios.
> + *
>   * Writing to pinned file-backed dirty tracked folios is inherently problematic
>   * (see comment describing the writable_file_mapping_allowed() function). We
>   * therefore try to avoid the most egregious case of a long-term mapping doing
> @@ -2484,22 +2486,32 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>  static bool folio_fast_pin_allowed(struct folio *folio, unsigned int flags)

Now when this function checks for gup in general, maybe it's worth to
rename it to, say, folio_fast_gup_allowed.

>  {
>  	struct address_space *mapping;
> +	bool check_secretmem = false;
> +	bool reject_file_backed = false;
>  	unsigned long mapping_flags;
>  
>  	/*
>  	 * If we aren't pinning then no problematic write can occur. A long term
>  	 * pin is the most egregious case so this is the one we disallow.
>  	 */
> -	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) !=
> +	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) ==
>  	    (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))
> -		return true;
> +		reject_file_backed = true;
> +
> +	/* We hold a folio reference, so we can safely access folio fields. */
>  
> -	/* The folio is pinned, so we can safely access folio fields. */
> +	/* secretmem folios are only order-0 folios and never LRU folios. */

Nit:                           ^ always

> +	if (IS_ENABLED(CONFIG_SECRETMEM) && !folio_test_large(folio) &&
> +	    !folio_test_lru(folio))
> +		check_secretmem = true;
> +
> +	if (!reject_file_backed && !check_secretmem)
> +		return true;
>  
>  	if (WARN_ON_ONCE(folio_test_slab(folio)))
>  		return false;
>  
> -	/* hugetlb mappings do not require dirty-tracking. */
> +	/* hugetlb neither requires dirty-tracking nor can be secretmem. */
>  	if (folio_test_hugetlb(folio))
>  		return true;
>  
> @@ -2535,10 +2547,12 @@ static bool folio_fast_pin_allowed(struct folio *folio, unsigned int flags)
>  
>  	/*
>  	 * At this point, we know the mapping is non-null and points to an
> -	 * address_space object. The only remaining whitelisted file system is
> -	 * shmem.
> +	 * address_space object.
>  	 */
> -	return shmem_mapping(mapping);
> +	if (check_secretmem && secretmem_mapping(mapping))
> +		return false;
> +	/* The only remaining allowed file system is shmem. */
> +	return !reject_file_backed || shmem_mapping(mapping);
>  }
>  
>  static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
> @@ -2624,11 +2638,6 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
>  		if (!folio)
>  			goto pte_unmap;
>  
> -		if (unlikely(folio_is_secretmem(folio))) {
> -			gup_put_folio(folio, 1, flags);
> -			goto pte_unmap;
> -		}
> -
>  		if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
>  		    unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
>  			gup_put_folio(folio, 1, flags);
> -- 
> 2.43.2
> 

-- 
Sincerely yours,
Mike.

