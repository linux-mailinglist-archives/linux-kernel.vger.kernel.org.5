Return-Path: <linux-kernel+bounces-57505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FC184D9EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B336428295C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97E67E61;
	Thu,  8 Feb 2024 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIr3HcQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74167E7B;
	Thu,  8 Feb 2024 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373160; cv=none; b=IFHmM4X+kLSW8XfOcS/ZsF3m1sMABzAbkhDef4i2yQAgHTMY96TRXeZ0sEpSyo5U3/5WRtFLYtPnDpLhTUBme+uIZ15GToOzqrMfylqVPhoDUI8bUVQXEcJomB7iRS31jslX45ljWYd/uPnMv9plq2OG1XJYfoXLCcYwAHaDrE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373160; c=relaxed/simple;
	bh=sykn19xSWWObW9qLEcBLaerZOcbUqhpMGC17aR+qXjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e02FKEkE/TU0Q/Yow4pde60lkq6r2YdBWvGx5Dc1V4+mwdrML08RemCkcAukewPWgWR+RVQTAU2waXLMAd2ELGv4qJ64ot5J9zl4HRY8EpyB6+QKOWjaEJaG6VxqpmLYq+bHusaaOuvRH4pKAY9XQRQYSAt5U58TipPNCPbJr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIr3HcQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E073C433C7;
	Thu,  8 Feb 2024 06:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707373160;
	bh=sykn19xSWWObW9qLEcBLaerZOcbUqhpMGC17aR+qXjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIr3HcQ5b0bG8W1uCJ8Xs3AwCdkv1B8MN9avDtnOskKLP0MGsSA5FdVe/qlbwHlcW
	 ij75Se4Sr0M/mlXPbTkg0ExM3s0WbaPDmBB2z0afJU/DgLRzJylJTpMBlkaFq6genb
	 UGrNOEd0VDk8McWIYbPInEhmtVwApod8E7+c/sGa2tGsu8eSLCSRKoYuzxYXt8WRCQ
	 9cQouplzvU1R7Agn51n6p8mDjqipAaZ8nccLsae0oyB1d4PDPTePnX+SGrmuqMGd6I
	 jV18g7gasEz+BfWfvdqPK2SfzN57x1dswOCBjsVrob3m65Q37nQIWq9pBNrosyAwa/
	 8XrfQqz5PFmrw==
Date: Thu, 8 Feb 2024 08:18:55 +0200
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
Subject: Re: [PATCH v3 07/15] sparc/pgtable: define PFN_PTE_SHIFT
Message-ID: <ZcRyT9qil3f-Jot5@kernel.org>
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-8-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129124649.189745-8-david@redhat.com>

On Mon, Jan 29, 2024 at 01:46:41PM +0100, David Hildenbrand wrote:
> We want to make use of pte_next_pfn() outside of set_ptes(). Let's
> simply define PFN_PTE_SHIFT, required by pte_next_pfn().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/sparc/include/asm/pgtable_64.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index a8c871b7d786..652af9d63fa2 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -929,6 +929,8 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>  	maybe_tlb_batch_add(mm, addr, ptep, orig, fullmm, PAGE_SHIFT);
>  }
>  
> +#define PFN_PTE_SHIFT		PAGE_SHIFT
> +
>  static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		pte_t *ptep, pte_t pte, unsigned int nr)
>  {
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

