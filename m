Return-Path: <linux-kernel+bounces-42582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EDD840374
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B461F228A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474C25B202;
	Mon, 29 Jan 2024 11:05:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D72B5B5D2;
	Mon, 29 Jan 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526320; cv=none; b=tL8biV2NZc80blawDH8YFl8GBf/l712bMB/B8E6HuBHND92wHVwBkydHztSOCQ8uSQ9A5ozEHWQEh9H1fRoSiP8k9OpZc6E44wbpScrszVlkBzPFduhP7KdBxmOJa4LP2rE5UasQJET5lqTFqDFp9lkQK4WFKL22ReuyKxGPw6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526320; c=relaxed/simple;
	bh=z7vCLiWnpGh25FZ1AIsxRGIMMKUxxU4DDA304c/YCcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4m59RpFt+gvoZI79IXbxwXXc8wW9yAHoRpqnw+tEXI6lIcDJERCYPcedWy0PVTeIgvlxUYv2oaHOg3W+yY31Dh8Dyg/zvcpM/JEBZD65j86yXOPlS5VnpFaQLK44X+rn4gR7gdYt2xfozjKkq7D7f3RvGPsBUF8UeB1gusme6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34BDC1FB;
	Mon, 29 Jan 2024 03:06:00 -0800 (PST)
Received: from [10.57.65.9] (unknown [10.57.65.9])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2ECE3F5A1;
	Mon, 29 Jan 2024 03:05:12 -0800 (PST)
Message-ID: <7a34378c-3b1d-4ce1-80f8-938796ff3e6c@arm.com>
Date: Mon, 29 Jan 2024 11:05:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] mm/memory: ignore dirty/accessed/soft-dirty bits
 in folio_pte_batch()
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
References: <20240125193227.444072-1-david@redhat.com>
 <20240125193227.444072-15-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240125193227.444072-15-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/01/2024 19:32, David Hildenbrand wrote:
> Let's always ignore the accessed/young bit: we'll always mark the PTE
> as old in our child process during fork, and upcoming users will
> similarly not care.
> 
> Ignore the dirty bit only if we don't want to duplicate the dirty bit
> into the child process during fork. Maybe, we could just set all PTEs
> in the child dirty if any PTE is dirty. For now, let's keep the behavior
> unchanged, this can be optimized later if required.
> 
> Ignore the soft-dirty bit only if the bit doesn't have any meaning in
> the src vma, and similarly won't have any in the copied dst vma.
> 
> For now, we won't bother with the uffd-wp bit.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/memory.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 4d1be89a01ee0..b3f035fe54c8d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -953,24 +953,44 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
>  	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
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
> +static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
> +{
> +	if (flags & FPB_IGNORE_DIRTY)
> +		pte = pte_mkclean(pte);
> +	if (likely(flags & FPB_IGNORE_SOFT_DIRTY))
> +		pte = pte_clear_soft_dirty(pte);
> +	return pte_mkold(pte);
> +}
> +
>  /*
>   * Detect a PTE batch: consecutive (present) PTEs that map consecutive
>   * pages of the same folio.
>   *
> - * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN.
> + * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN,
> + * the accessed bit, dirty bit (with FPB_IGNORE_DIRTY) and soft-dirty bit
> + * (with FPB_IGNORE_SOFT_DIRTY).
>   */
>  static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
> -		pte_t *start_ptep, pte_t pte, int max_nr)
> +		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags)
>  {
>  	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
>  	const pte_t *end_ptep = start_ptep + max_nr;
> -	pte_t expected_pte = pte_next_pfn(pte);
> +	pte_t expected_pte = __pte_batch_clear_ignored(pte_next_pfn(pte), flags);
>  	pte_t *ptep = start_ptep + 1;
>  
>  	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>  
>  	while (ptep != end_ptep) {
> -		pte = ptep_get(ptep);
> +		pte = __pte_batch_clear_ignored(ptep_get(ptep), flags);
>  
>  		if (!pte_same(pte, expected_pte))
>  			break;
> @@ -1004,6 +1024,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>  {
>  	struct page *page;
>  	struct folio *folio;
> +	fpb_t flags = 0;
>  	int err, nr;
>  
>  	page = vm_normal_page(src_vma, addr, pte);
> @@ -1018,7 +1039,12 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>  	 * by keeping the batching logic separate.
>  	 */
>  	if (unlikely(!*prealloc && folio_test_large(folio) && max_nr != 1)) {
> -		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr);
> +		if (src_vma->vm_flags & VM_SHARED)
> +			flags |= FPB_IGNORE_DIRTY;
> +		if (!vma_soft_dirty_enabled(src_vma))
> +			flags |= FPB_IGNORE_SOFT_DIRTY;
> +
> +		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr, flags);
>  		folio_ref_add(folio, nr);
>  		if (folio_test_anon(folio)) {
>  			if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,


