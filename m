Return-Path: <linux-kernel+bounces-93376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF68872EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD2C1C225F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E181C294;
	Wed,  6 Mar 2024 06:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvZkxAzs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C431C287
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709705807; cv=none; b=tOgqa+v20fvOCFzLRIItOqOMDeIe8mb7nNzQkLRgoNI6O9FAkbjY7H4npMsKLr5+r59kZspHXGxmFWCyn6dlSZtbqFg+hEcrbiLyNwVagXHFaLepAmeI7kEOuLdHeue6LqUy92nkE92X7siyj5Sk5B2DHA6imP3yF4wwyOaRdvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709705807; c=relaxed/simple;
	bh=IB3GfOzNUfXIFpeJe83ampj3Bt5+cvL3ZIZkQ8chnV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4jk9dyCNno9yOp4JJWzu2O7w0khUAU/fHnm6eUyrwdT+bfTMf6L6XtgS6pdBCBnL2A+WFXSd+j1osahAQ3r1VrDtzfjROBQ3J1sOAI10pjNZQblQa8asgQAVKM+wpghppAmtFvRctKyJ0/ij4XQUbE/ZFCoeSTqaRBQqRA3ey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvZkxAzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F608C433C7;
	Wed,  6 Mar 2024 06:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709705806;
	bh=IB3GfOzNUfXIFpeJe83ampj3Bt5+cvL3ZIZkQ8chnV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MvZkxAzsCLc/0ZLBdD7AJr1R8IXx+NjawjJcePutExZPCOi0qLI0u6XEPirHngsWw
	 6jkkHtLd9ocCleDtOhmO+Usd8PQWEmDAsy7EpBC2MDFlT8iFzlvxnwCqFWtGW8sE11
	 PoGZMscM6T2m04L+rU3wgOg4vayMgd5e7LD9vkZhlhiO7IsQMzk854f9WmF6Ww0pgr
	 o6h9EbhB5nmpC6VW4bxaVLxbeCt8MMiwlEremthZOjx+gAbAgyIrFr/9rQyDX9ctor
	 POTbTZi/F+PwOinsAGphF0K50OMAjX+J00tS6AaCwPs+mPY/Uho2xKDcvIHthehBL2
	 Ywr6Rprr3pl2w==
Date: Wed, 6 Mar 2024 08:15:53 +0200
From: Mike Rapoport <rppt@kernel.org>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>, Yang Shi <shy828301@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Muchun Song <muchun.song@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH v3 01/10] mm/ppc: Define pXd_large() with pXd_leaf()
Message-ID: <ZegKGU4kTV-icKKC@kernel.org>
References: <20240305043750.93762-1-peterx@redhat.com>
 <20240305043750.93762-2-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305043750.93762-2-peterx@redhat.com>

On Tue, Mar 05, 2024 at 12:37:41PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> The two definitions are the same.  The only difference is that pXd_large()
> is only defined with THP selected, and only on book3s 64bits.
> 
> Instead of implementing it twice, make pXd_large() a macro to pXd_leaf().
> Define it unconditionally just like pXd_leaf().  This helps to prepare
> merging the two APIs.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 16 ++--------------
>  arch/powerpc/include/asm/pgtable.h           |  2 +-
>  2 files changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 927d585652bc..d1318e8582ac 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1157,20 +1157,6 @@ pud_hugepage_update(struct mm_struct *mm, unsigned long addr, pud_t *pudp,
>  	return pud_val(*pudp);
>  }
>  
> -/*
> - * returns true for pmd migration entries, THP, devmap, hugetlb
> - * But compile time dependent on THP config
> - */
> -static inline int pmd_large(pmd_t pmd)
> -{
> -	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
> -}
> -
> -static inline int pud_large(pud_t pud)
> -{
> -	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
> -}
> -
>  /*
>   * For radix we should always find H_PAGE_HASHPTE zero. Hence
>   * the below will work for radix too
> @@ -1455,6 +1441,7 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
>   */
>  #define pmd_is_leaf pmd_is_leaf
>  #define pmd_leaf pmd_is_leaf
> +#define pmd_large pmd_leaf
>  static inline bool pmd_is_leaf(pmd_t pmd)
>  {
>  	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
> @@ -1462,6 +1449,7 @@ static inline bool pmd_is_leaf(pmd_t pmd)
>  
>  #define pud_is_leaf pud_is_leaf
>  #define pud_leaf pud_is_leaf
> +#define pud_large pud_leaf
>  static inline bool pud_is_leaf(pud_t pud)
>  {
>  	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index 7a1ba8889aea..5928b3c1458d 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -101,7 +101,7 @@ void poking_init(void);
>  extern unsigned long ioremap_bot;
>  extern const pgprot_t protection_map[16];
>  
> -#ifndef CONFIG_TRANSPARENT_HUGEPAGE
> +#ifndef pmd_large
>  #define pmd_large(pmd)		0
>  #endif
>  
> -- 
> 2.44.0
> 
> 

-- 
Sincerely yours,
Mike.

