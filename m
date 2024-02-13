Return-Path: <linux-kernel+bounces-63948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C218536A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED26628D29A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDAA5F856;
	Tue, 13 Feb 2024 16:55:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14D3BA57
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843357; cv=none; b=Av1rJ5afkFUtQeQsCyCdqohcB36+ioiQsccHkFk8b3+fZ07CJ3lw5ctLDnVfCfxiErQm+9XURXbEksaHqDvBPFBlcL6zzqouZkMqD1nvDkemv/aHleh+BLLcKwOFetjuwolkwwOmQEYF9r5/Xki+FIOQKCI3G68IwbHkrcllG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843357; c=relaxed/simple;
	bh=OlqJ2fXyLvszO74uYT8l1d7byfWBYIMFbndu+5mdxmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZIt3W1cboX1OlqYsezSfeUTH4/jKHjLnbVNR4oOONKrmwxF4vgCIlLYYGWOGzgyfohjed5eopL0wXihmQAPOBldnRoE+y6kSv6wxFGgjoxHufTFn00DZl62W0Lo7qscacwBJ+emBMcVLI9nslW3b7aLFSnDt4xi3tGxPrVrwQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FC74DA7;
	Tue, 13 Feb 2024 08:56:36 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.36.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CD3D3F5A1;
	Tue, 13 Feb 2024 08:55:51 -0800 (PST)
Date: Tue, 13 Feb 2024 16:55:49 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 24/25] arm64/mm: __always_inline to improve fork() perf
Message-ID: <ZcufFVa7FJRgrEI1@FVFF77S0Q05N.cambridge.arm.com>
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
 <20240202080756.1453939-25-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202080756.1453939-25-ryan.roberts@arm.com>

On Fri, Feb 02, 2024 at 08:07:55AM +0000, Ryan Roberts wrote:
> As set_ptes() and wrprotect_ptes() become a bit more complex, the
> compiler may choose not to inline them. But this is critical for fork()
> performance. So mark the functions, along with contpte_try_unfold()
> which is called by them, as __always_inline. This is worth ~1% on the
> fork() microbenchmark with order-0 folios (the common case).
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

I have no strong feelings either way on this, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/pgtable.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 353ea67b5d75..cdc310880a3b 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1213,8 +1213,8 @@ extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep,
>  				pte_t entry, int dirty);
>  
> -static inline void contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
> -					pte_t *ptep, pte_t pte)
> +static __always_inline void contpte_try_unfold(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep, pte_t pte)
>  {
>  	if (unlikely(pte_valid_cont(pte)))
>  		__contpte_try_unfold(mm, addr, ptep, pte);
> @@ -1279,7 +1279,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
>  }
>  
>  #define set_ptes set_ptes
> -static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +static __always_inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  				pte_t *ptep, pte_t pte, unsigned int nr)
>  {
>  	pte = pte_mknoncont(pte);
> @@ -1361,8 +1361,8 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>  }
>  
>  #define wrprotect_ptes wrprotect_ptes
> -static inline void wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
> -				pte_t *ptep, unsigned int nr)
> +static __always_inline void wrprotect_ptes(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep, unsigned int nr)
>  {
>  	if (likely(nr == 1)) {
>  		/*
> -- 
> 2.25.1
> 

