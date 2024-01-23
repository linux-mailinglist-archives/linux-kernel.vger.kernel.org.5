Return-Path: <linux-kernel+bounces-35245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C027838E72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12482B234C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73E95DF31;
	Tue, 23 Jan 2024 12:25:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D4F5DF2D;
	Tue, 23 Jan 2024 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012714; cv=none; b=c/EqlYFPO55eLPYoq5Mot0m/uTa4XS2a2qk/1o99YZ4kPCZP1296RmsS3Kq/ZozekIQ4F6SwaVsx9fiomtgsBicRy++2/jVVtoOKbk+5PaI5ZjiG3K1IpA2DY7D95NNv4Z0BU61lgd1VssvNSDejRFrztJGhSJXU91OfPn7+eX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012714; c=relaxed/simple;
	bh=gDuBiOjwlxA//+QgJwW0i0xvy0XhKfsDkSnLAVR8E8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOVxxfPLCEnDqfiYJj+1PbC3xDQGgFyEg+BI9zCU6RwBkiVmnFuYNaZZ5j2wIa7uWoOdlATtPSCPY4eedHC19o8FUkocbzAI+D1AGROaEEzz6rw/0OjN0JIDSY+yg/3UL+45iNsMWGD0DIdAMYs6KY532tWQnObAosiJ7jfVBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69D231FB;
	Tue, 23 Jan 2024 04:25:56 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6A213F762;
	Tue, 23 Jan 2024 04:25:05 -0800 (PST)
Message-ID: <59592b50-fe89-4b32-8490-2e6c296f972f@arm.com>
Date: Tue, 23 Jan 2024 12:25:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/11] mm/memory: ignore dirty/accessed/soft-dirty bits
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
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-11-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240122194200.381241-11-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 19:41, David Hildenbrand wrote:
> Let's ignore these bits: they are irrelevant for fork, and will likely
> be irrelevant for upcoming users such as page unmapping.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index f563aec85b2a8..341b2be845b6e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -953,24 +953,30 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
>  	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>  }
>  
> +static inline pte_t __pte_batch_clear_ignored(pte_t pte)
> +{
> +	return pte_clear_soft_dirty(pte_mkclean(pte_mkold(pte)));
> +}
> +
>  /*
>   * Detect a PTE batch: consecutive (present) PTEs that map consecutive
>   * pages of the same folio.
>   *
>   * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN.

nit: last char should be a comma (,) not a full stop (.)

> + * the accessed bit, dirty bit and soft-dirty bit.
>   */
>  static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>  		pte_t *start_ptep, pte_t pte, int max_nr)
>  {
>  	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
>  	const pte_t *end_ptep = start_ptep + max_nr;
> -	pte_t expected_pte = pte_next_pfn(pte);
> +	pte_t expected_pte = __pte_batch_clear_ignored(pte_next_pfn(pte));
>  	pte_t *ptep = start_ptep + 1;
>  
>  	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>  
>  	while (ptep != end_ptep) {
> -		pte = ptep_get(ptep);
> +		pte = __pte_batch_clear_ignored(ptep_get(ptep));
>  
>  		if (!pte_same(pte, expected_pte))
>  			break;

I think you'll lose dirty information in the child for private mappings? If the
first pte in a batch is clean, but a subsequent page is dirty, you will end up
setting all the pages in the batch as clean in the child. Previous behavior
would preserve dirty bit for private mappings.

In my version (v3) that did arbitrary batching, I had some fun and games
tracking dirty, write and uffd_wp:
https://lore.kernel.org/linux-arm-kernel/20231204105440.61448-2-ryan.roberts@arm.com/

Also, I think you will currently either set soft dirty on all or none of the
pages in the batch, depending on the value of the first. I previously convinced
myself that the state was unimportant so always cleared it in the child to
provide consistency.




