Return-Path: <linux-kernel+bounces-57494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F83284D9CA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04811C23145
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB43867C7B;
	Thu,  8 Feb 2024 06:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFaz8r46"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305C867C72;
	Thu,  8 Feb 2024 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707372685; cv=none; b=iheXGJ64L/iVsoY4EaADTpM4lcsoS7AgNyXSBFrj4yP8dfccLAlRd7yW3BGF71umjbWFL4b/Y7eLeOyuTE2VXb/Jy/foAkvOIB4DkuGtL4G7lmrYSWlhHK2MDhJq/0NgLBgW1JmXmA4kGMz1Ob0MfJLNP953cyKlU1zd9jVkEzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707372685; c=relaxed/simple;
	bh=P03Ra6tKJeIfMl5vzZANDer57SEANPUYFQQ4fYeImD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlGEShY2FkDan++b5GXFcG9/18W1DXg6I0pSTh3+ADrp83/ykO/arVSERawKNKk1cBgEB3F2AVyecpowPjYAtzs7NzI32vMVJnGQLuHQHAzkpQkWhDQmfxjfwblZwLf2PrBf9ffIUbS2K2PcYDgQVLtSZcmC8wg3muPaTcj+XwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFaz8r46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2565C43390;
	Thu,  8 Feb 2024 06:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707372684;
	bh=P03Ra6tKJeIfMl5vzZANDer57SEANPUYFQQ4fYeImD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HFaz8r46F2yMGhc4eChQ1bdDMIG2SJbZeO1JsISVjZZY5/QxNPEU574sO9dknngXq
	 YVgyAOL6RSp2qvuoFw3QAZnOLGr4cDN/wpbTmNQ58lmjGGeuChQIAye3TRo4TxFy79
	 V7xNv4sfFz+z0Vk0ON1uEn4vvWgR1e3+QhjIlA+1LT/Ifdm5+CkutQDtm79R+RIM1n
	 4OE0Gfs2UAKksR/gYZdixvQn5xW9+A4inVRJwU+VYyn9RWTX93+YzHhWEvbOkcDwIJ
	 h9Gt9Ms2CBz13jyRvnX4bzQn20gjiMAXZmHcQEZQTyBICBjNVu3/zFAWUGyA2x/MG4
	 oI4EjuUTX0bdA==
Date: Thu, 8 Feb 2024 08:10:59 +0200
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
Subject: Re: [PATCH v3 01/15] arm64/mm: Make set_ptes() robust when OAs cross
 48-bit boundary
Message-ID: <ZcRwc2mEDHIXxgGa@kernel.org>
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129124649.189745-2-david@redhat.com>

On Mon, Jan 29, 2024 at 01:46:35PM +0100, David Hildenbrand wrote:
> From: Ryan Roberts <ryan.roberts@arm.com>
> 
> Since the high bits [51:48] of an OA are not stored contiguously in the
> PTE, there is a theoretical bug in set_ptes(), which just adds PAGE_SIZE
> to the pte to get the pte with the next pfn. This works until the pfn
> crosses the 48-bit boundary, at which point we overflow into the upper
> attributes.
> 
> Of course one could argue (and Matthew Wilcox has :) that we will never
> see a folio cross this boundary because we only allow naturally aligned
> power-of-2 allocation, so this would require a half-petabyte folio. So
> its only a theoretical bug. But its better that the code is robust
> regardless.
> 
> I've implemented pte_next_pfn() as part of the fix, which is an opt-in
> core-mm interface. So that is now available to the core-mm, which will
> be needed shortly to support forthcoming fork()-batching optimizations.
> 
> Link: https://lkml.kernel.org/r/20240125173534.1659317-1-ryan.roberts@arm.com
> Fixes: 4a169d61c2ed ("arm64: implement the new page table range API")
> Closes: https://lore.kernel.org/linux-mm/fdaeb9a5-d890-499a-92c8-d171df43ad01@arm.com/
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/arm64/include/asm/pgtable.h | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index b50270107e2f..9428801c1040 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -341,6 +341,22 @@ static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
>  		mte_sync_tags(pte, nr_pages);
>  }
>  
> +/*
> + * Select all bits except the pfn
> + */
> +static inline pgprot_t pte_pgprot(pte_t pte)
> +{
> +	unsigned long pfn = pte_pfn(pte);
> +
> +	return __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
> +}
> +
> +#define pte_next_pfn pte_next_pfn
> +static inline pte_t pte_next_pfn(pte_t pte)
> +{
> +	return pfn_pte(pte_pfn(pte) + 1, pte_pgprot(pte));
> +}
> +
>  static inline void set_ptes(struct mm_struct *mm,
>  			    unsigned long __always_unused addr,
>  			    pte_t *ptep, pte_t pte, unsigned int nr)
> @@ -354,7 +370,7 @@ static inline void set_ptes(struct mm_struct *mm,
>  		if (--nr == 0)
>  			break;
>  		ptep++;
> -		pte_val(pte) += PAGE_SIZE;
> +		pte = pte_next_pfn(pte);
>  	}
>  }
>  #define set_ptes set_ptes
> @@ -433,16 +449,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  	return clear_pte_bit(pte, __pgprot(PTE_SWP_EXCLUSIVE));
>  }
>  
> -/*
> - * Select all bits except the pfn
> - */
> -static inline pgprot_t pte_pgprot(pte_t pte)
> -{
> -	unsigned long pfn = pte_pfn(pte);
> -
> -	return __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
> -}
> -
>  #ifdef CONFIG_NUMA_BALANCING
>  /*
>   * See the comment in include/linux/pgtable.h
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

