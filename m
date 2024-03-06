Return-Path: <linux-kernel+bounces-93388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 119A3872EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0A5289F35
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602C55B662;
	Wed,  6 Mar 2024 06:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtmgAmPS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484764A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709707006; cv=none; b=pWAqRj3gWifQl8lc5jYEyiRVcWFt5A1XUtx5jGFJOicwem8H2Zt3/vzIa11f6i3cvZDpTmxJfo02DJmdy4E1KKhhc6Ev8MKLg9PuwDYG9Nbk1zKaGOrwJF/2jJWJz5QWPToR9198cLh8U8L73TGatNZlKkS+A0qFJotaQYsdOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709707006; c=relaxed/simple;
	bh=qejD/AKf5341J4gQp//ueMJAwnNH5bDWfrIRnrKMeZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZes1jMY6SNyhieH5Ye9txRfqtPMOpyreQyXETweJ1t95bjpw6TlahYbNvYCE8ov5qhe0G5eYDbdTpu4e5fgjyaUh95sRDW+oAQNrsMk0wT9Y+8Idk7OrSstHRaV7Bd8MQgMeiTZng8ll4tQCg54T5ucrB6eUHXbGDVvTfNwqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtmgAmPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E48C433F1;
	Wed,  6 Mar 2024 06:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709707005;
	bh=qejD/AKf5341J4gQp//ueMJAwnNH5bDWfrIRnrKMeZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtmgAmPSnnTGquSSBtgnnitKLjtBNKFm004CppR+tHqdKlhGJnP9/ad42nnQPeKDc
	 NoVzize21yUxJGdFmGVqXTh65b5ZkKHVUrJDRiRL6WLo7FtdPvZXo4XkWcPaaw/3Bb
	 Wj7H9Re4o72oKQbPbXEou01QYNdI272fCGsTS19gKvCvgy1qEdEqmImdgnLWkCd9fI
	 ggFsoKkPiGGvwUEkmNgZh59xOuqEE4cjzvGh5fSd9lTsx64nGQnG2T8a11gKyMv8lG
	 Y5QWo6Xw6Pv2zntlvr5/8DlAC4s9AeyV9SV8uENWWXhV2HDMGmdkjosElKIXt63OYB
	 v3+6//XOHBFNw==
Date: Wed, 6 Mar 2024 08:35:52 +0200
From: Mike Rapoport <rppt@kernel.org>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>, Yang Shi <shy828301@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v3 10/10] mm/treewide: Align up pXd_leaf() retval across
 archs
Message-ID: <ZegOyFS6aQC7StG_@kernel.org>
References: <20240305043750.93762-1-peterx@redhat.com>
 <20240305043750.93762-11-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305043750.93762-11-peterx@redhat.com>

On Tue, Mar 05, 2024 at 12:37:50PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Even if pXd_leaf() API is defined globally, it's not clear on the retval,
> and there are three types used (bool, int, unsigned log).
> 
> Always return a boolean for pXd_leaf() APIs.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/riscv/include/asm/pgtable-64.h | 2 +-
>  arch/riscv/include/asm/pgtable.h    | 2 +-
>  arch/s390/include/asm/pgtable.h     | 4 ++--
>  arch/sparc/include/asm/pgtable_64.h | 4 ++--
>  arch/x86/include/asm/pgtable.h      | 8 ++++----
>  include/linux/pgtable.h             | 8 ++++----
>  6 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index b42017d76924..2c7e1661db01 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -190,7 +190,7 @@ static inline int pud_bad(pud_t pud)
>  }
>  
>  #define pud_leaf	pud_leaf
> -static inline int pud_leaf(pud_t pud)
> +static inline bool pud_leaf(pud_t pud)
>  {
>  	return pud_present(pud) && (pud_val(pud) & _PAGE_LEAF);
>  }
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index add5cd30ab34..6839520dbcb1 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -241,7 +241,7 @@ static inline int pmd_bad(pmd_t pmd)
>  }
>  
>  #define pmd_leaf	pmd_leaf
> -static inline int pmd_leaf(pmd_t pmd)
> +static inline bool pmd_leaf(pmd_t pmd)
>  {
>  	return pmd_present(pmd) && (pmd_val(pmd) & _PAGE_LEAF);
>  }
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 9e08af5b9247..60950e7a25f5 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -706,7 +706,7 @@ static inline int pud_none(pud_t pud)
>  }
>  
>  #define pud_leaf pud_leaf
> -static inline int pud_leaf(pud_t pud)
> +static inline bool pud_leaf(pud_t pud)
>  {
>  	if ((pud_val(pud) & _REGION_ENTRY_TYPE_MASK) != _REGION_ENTRY_TYPE_R3)
>  		return 0;
> @@ -714,7 +714,7 @@ static inline int pud_leaf(pud_t pud)
>  }
>  
>  #define pmd_leaf pmd_leaf
> -static inline int pmd_leaf(pmd_t pmd)
> +static inline bool pmd_leaf(pmd_t pmd)
>  {
>  	return (pmd_val(pmd) & _SEGMENT_ENTRY_LARGE) != 0;
>  }
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 6ff0a28d5fd1..4d1bafaba942 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -681,7 +681,7 @@ static inline unsigned long pte_special(pte_t pte)
>  }
>  
>  #define pmd_leaf pmd_leaf
> -static inline unsigned long pmd_leaf(pmd_t pmd)
> +static inline bool pmd_leaf(pmd_t pmd)
>  {
>  	pte_t pte = __pte(pmd_val(pmd));
>  
> @@ -868,7 +868,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
>  #define p4d_page(p4d)			NULL
>  
>  #define pud_leaf pud_leaf
> -static inline unsigned long pud_leaf(pud_t pud)
> +static inline bool pud_leaf(pud_t pud)
>  {
>  	pte_t pte = __pte(pud_val(pud));
>  
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index cfc84c55d0e6..7621a5acb13e 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -252,7 +252,7 @@ static inline unsigned long pgd_pfn(pgd_t pgd)
>  }
>  
>  #define p4d_leaf p4d_leaf
> -static inline int p4d_leaf(p4d_t p4d)
> +static inline bool p4d_leaf(p4d_t p4d)
>  {
>  	/* No 512 GiB pages yet */
>  	return 0;
> @@ -261,7 +261,7 @@ static inline int p4d_leaf(p4d_t p4d)
>  #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
>  
>  #define pmd_leaf pmd_leaf
> -static inline int pmd_leaf(pmd_t pte)
> +static inline bool pmd_leaf(pmd_t pte)
>  {
>  	return pmd_flags(pte) & _PAGE_PSE;
>  }
> @@ -1086,7 +1086,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
>  #define pud_page(pud)	pfn_to_page(pud_pfn(pud))
>  
>  #define pud_leaf pud_leaf
> -static inline int pud_leaf(pud_t pud)
> +static inline bool pud_leaf(pud_t pud)
>  {
>  	return (pud_val(pud) & (_PAGE_PSE | _PAGE_PRESENT)) ==
>  		(_PAGE_PSE | _PAGE_PRESENT);
> @@ -1413,7 +1413,7 @@ static inline bool pgdp_maps_userspace(void *__ptr)
>  }
>  
>  #define pgd_leaf	pgd_leaf
> -static inline int pgd_leaf(pgd_t pgd) { return 0; }
> +static inline bool pgd_leaf(pgd_t pgd) { return false; }
>  
>  #ifdef CONFIG_PAGE_TABLE_ISOLATION
>  /*
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index a36cf4e124b0..85fc7554cd52 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1777,16 +1777,16 @@ typedef unsigned int pgtbl_mod_mask;
>   * Only meaningful when called on a valid entry.
>   */
>  #ifndef pgd_leaf
> -#define pgd_leaf(x)	0
> +#define pgd_leaf(x)	false
>  #endif
>  #ifndef p4d_leaf
> -#define p4d_leaf(x)	0
> +#define p4d_leaf(x)	false
>  #endif
>  #ifndef pud_leaf
> -#define pud_leaf(x)	0
> +#define pud_leaf(x)	false
>  #endif
>  #ifndef pmd_leaf
> -#define pmd_leaf(x)	0
> +#define pmd_leaf(x)	false
>  #endif
>  
>  #ifndef pgd_leaf_size
> -- 
> 2.44.0
> 
> 

-- 
Sincerely yours,
Mike.

