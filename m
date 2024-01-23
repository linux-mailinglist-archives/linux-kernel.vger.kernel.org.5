Return-Path: <linux-kernel+bounces-35119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA73C838C65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416EEB257D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101635D8F1;
	Tue, 23 Jan 2024 10:45:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6075D725;
	Tue, 23 Jan 2024 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006726; cv=none; b=OOEhna3Th67aKTWyX++KE9gE26W8wdUNjEGVzf178DOASYRsDCSS4KAeNzQ6eBdyKmzXrKGvS+GbKvenRZgo9RSEpPqokfzWG3GDpAkBAfcVndYKUMZn6OFN4tF9WhYnE/oPR/boHXEaGTFXqt3E+qaLY6K+rIkCAW99RNuq/gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006726; c=relaxed/simple;
	bh=Bv9tpEfskUzoIjJvF99P42BdqqUjJxhrXzxON1qU9Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZK2JyGIIpnRmfrwT66PCzyCUb60d2s8X3gbMFQueN9FvC89Kldl3nnyEvBwdESPZmmLBy4BIBZb/qy7SMIm1bAz0IZEMU66Ds1dvel/vDD1/I0eXuPhjnvB+ZxnRfjQ6U1Bi/MKCMX7zlxOYf+hzUNsKCG6vV+jt3QE3o9wjuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 689251FB;
	Tue, 23 Jan 2024 02:46:08 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FFE73F5A1;
	Tue, 23 Jan 2024 02:45:19 -0800 (PST)
Message-ID: <3d6a5076-48d3-4790-a507-d3b1584e8587@arm.com>
Date: Tue, 23 Jan 2024 10:45:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] mm/memory: factor out copying the actual PTE in
 copy_present_pte()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-8-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240122194200.381241-8-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 19:41, David Hildenbrand wrote:
> Let's prepare for further changes.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/memory.c | 60 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 32 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 7e1f4849463aa..2aa2051ee51d3 100644
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
> @@ -939,16 +962,16 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
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
> +	if (folio_test_anon(folio)) {
>  		/*
>  		 * If this page may have been pinned by the parent process,
>  		 * copy the page immediately for the child so that we'll always
> @@ -963,34 +986,15 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  						 addr, rss, prealloc, page);
>  		}
>  		rss[MM_ANONPAGES]++;
> -	} else if (page) {
> +		VM_WARN_ON_FOLIO(PageAnonExclusive(page), folio);
> +	} else {
>  		folio_get(folio);
>  		folio_dup_file_rmap_pte(folio, page);
>  		rss[mm_counter_file(page)]++;
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


