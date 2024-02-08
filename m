Return-Path: <linux-kernel+bounces-57523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9448584DA2F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A03428AA64
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713CF67E79;
	Thu,  8 Feb 2024 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Phoix+90"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A954067E67;
	Thu,  8 Feb 2024 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373786; cv=none; b=XwxXYush4ctiQsT/Mzb0zEldr1DYYNkcLd1W8cVfvCDlNWsJq4THKh+JtWaAmEQYNi7g/ZllPdqKLcJUdvvAJFQKRbvUF+2eiFbmPVDcCLBO09ycwzwoRy9eGdqbuScjpfBK9tPF01gQI3iTbhgCIgG24/lfvK7u7BwVsYIZEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373786; c=relaxed/simple;
	bh=x4GCLa2xzNhu7jlHpC2LrDTqBpAccwVcIjWuUAdJzgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK6LUx6DTXCDoxGb8Yo0Q6e0fGFzSbyEgFGyloC7SZvX9phPLJ1GVp+GJIj1fg0SRnh0157QclJQpRM/SJv+cumnE3SgtkQJARYUJIY3RWP6KmytQkeOlruoPBwcODMjk4HCuDlVrMWa8XdszFjTyz4YKIUsABx3iP29CtCDP9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Phoix+90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E21FC433F1;
	Thu,  8 Feb 2024 06:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707373786;
	bh=x4GCLa2xzNhu7jlHpC2LrDTqBpAccwVcIjWuUAdJzgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Phoix+90khL4IEhQ6gpSoCEIa7eKrFuowZSgj42G9vOi8dSlpe1gQK0YyWgYKp+4r
	 sPLY9+CUFb9aZvZlJVuQqwKhWZ+pa+B4zWmW6ij44vrjGh7IL5UzkD3sKKzoxbKYee
	 QNwaU30tJ0UF6MuasMfjEGa+A4FY8V6otf3jfYDzeJPTIubtszyNvCkdBsoVBCTCKZ
	 +W8z7CCvQhm6qI593PxMf1LOB8FDsoWbQ3LesFfp+jH1tSwZzvF1v7s5703XCDTQvu
	 YYI3y/4CVWlLjbUJLn8zUCRy2xy0Roln1eAOTnw74B+sWgLw7OSbGWrqA5wjWVRClH
	 ouB/3F6aDobjA==
Date: Thu, 8 Feb 2024 08:29:21 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 11/15] mm/memory: factor out copying the actual PTE in
 copy_present_pte()
Message-ID: <ZcR0waPgUzfQgyGQ@kernel.org>
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-12-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129124649.189745-12-david@redhat.com>

On Mon, Jan 29, 2024 at 01:46:45PM +0100, David Hildenbrand wrote:
> Let's prepare for further changes.
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/memory.c | 63 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 8d14ba440929..a3bdb25f4c8d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -930,6 +930,29 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>  	return 0;
>  }
>  
> +static inline void __copy_present_pte(struct vm_area_struct *dst_vma,
> +		struct vm_area_struct *src_vma, pte_t *dst_pte, pte_t *src_pte,
> +		pte_t pte, unsigned long addr)
> +{
> +	struct mm_struct *src_mm = src_vma->vm_mm;
> +
> +	/* If it's a COW mapping, write protect it both processes. */
> +	if (is_cow_mapping(src_vma->vm_flags) && pte_write(pte)) {
> +		ptep_set_wrprotect(src_mm, addr, src_pte);
> +		pte = pte_wrprotect(pte);
> +	}
> +
> +	/* If it's a shared mapping, mark it clean in the child. */
> +	if (src_vma->vm_flags & VM_SHARED)
> +		pte = pte_mkclean(pte);
> +	pte = pte_mkold(pte);
> +
> +	if (!userfaultfd_wp(dst_vma))
> +		pte = pte_clear_uffd_wp(pte);
> +
> +	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
> +}
> +
>  /*
>   * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
>   * is required to copy this pte.
> @@ -939,23 +962,23 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
>  		 struct folio **prealloc)
>  {
> -	struct mm_struct *src_mm = src_vma->vm_mm;
> -	unsigned long vm_flags = src_vma->vm_flags;
>  	pte_t pte = ptep_get(src_pte);
>  	struct page *page;
>  	struct folio *folio;
>  
>  	page = vm_normal_page(src_vma, addr, pte);
> -	if (page)
> -		folio = page_folio(page);
> -	if (page && folio_test_anon(folio)) {
> +	if (unlikely(!page))
> +		goto copy_pte;
> +
> +	folio = page_folio(page);
> +	folio_get(folio);
> +	if (folio_test_anon(folio)) {
>  		/*
>  		 * If this page may have been pinned by the parent process,
>  		 * copy the page immediately for the child so that we'll always
>  		 * guarantee the pinned page won't be randomly replaced in the
>  		 * future.
>  		 */
> -		folio_get(folio);
>  		if (unlikely(folio_try_dup_anon_rmap_pte(folio, page, src_vma))) {
>  			/* Page may be pinned, we have to copy. */
>  			folio_put(folio);
> @@ -963,34 +986,14 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  						 addr, rss, prealloc, page);
>  		}
>  		rss[MM_ANONPAGES]++;
> -	} else if (page) {
> -		folio_get(folio);
> +		VM_WARN_ON_FOLIO(PageAnonExclusive(page), folio);
> +	} else {
>  		folio_dup_file_rmap_pte(folio, page);
>  		rss[mm_counter_file(folio)]++;
>  	}
>  
> -	/*
> -	 * If it's a COW mapping, write protect it both
> -	 * in the parent and the child
> -	 */
> -	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
> -		ptep_set_wrprotect(src_mm, addr, src_pte);
> -		pte = pte_wrprotect(pte);
> -	}
> -	VM_BUG_ON(page && folio_test_anon(folio) && PageAnonExclusive(page));
> -
> -	/*
> -	 * If it's a shared mapping, mark it clean in
> -	 * the child
> -	 */
> -	if (vm_flags & VM_SHARED)
> -		pte = pte_mkclean(pte);
> -	pte = pte_mkold(pte);
> -
> -	if (!userfaultfd_wp(dst_vma))
> -		pte = pte_clear_uffd_wp(pte);
> -
> -	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
> +copy_pte:
> +	__copy_present_pte(dst_vma, src_vma, dst_pte, src_pte, pte, addr);
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

