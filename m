Return-Path: <linux-kernel+bounces-57495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 258A384D9CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 736D4B22F64
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017FD67C7B;
	Thu,  8 Feb 2024 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJX01pqq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F38E67A13;
	Thu,  8 Feb 2024 06:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707372740; cv=none; b=MVW+iU7rap4cKIh8RDM3ZnOkRN/kcewSyMswH2YFfxaw5Ae3Ktzeg53tLpgNOgxga0FPENzMRMb+QZN2hozPiXHaIk8EIbX82KhJKFIWaIW4fJpoBG5t0dynZiB1nLIo0bQTBoDtQck8Zre66cmicFJQbQhKtpMYrdVARqqkhXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707372740; c=relaxed/simple;
	bh=L4FBQtW/eF2Uu1SqIrK2nRsbjsKSv4bUFB1aeX49JJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ4eTc5cdaQlUx3IKcui7fJSfAe7He8fJq8Zl3ACkKEgw+ldREWmjjUBu4u3/YManPZsa3SdoNLhugb+fXXv282fkUS+g3HGoZdeN+aRMsyTO2fo1WC20+z69c5d0wb/wtl/Ik99eNV8RFq/0td764Hn9ROuI9h/Jfc9jJERmgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJX01pqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96ADEC43390;
	Thu,  8 Feb 2024 06:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707372739;
	bh=L4FBQtW/eF2Uu1SqIrK2nRsbjsKSv4bUFB1aeX49JJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJX01pqqXnG+GEldJgYaVDhgObRa/4ZDUsQRXO0FxxpW+AgXzngnCGwKPtmlrSDNF
	 Cd0wch4ykXrr0mi1Egq91joKDYcLOSWO4CV5+NT+l0PKfU1ySJjGlhsCWGbNmfqv8r
	 W/rtdDJdoiXubGXIwaYbFfQafaBSv8zSGBXWrti3K34px06JngBKtot/k1I6J8kupf
	 7RkJg6zbfIo00oLX58qxCXkm64N8BM0iGfo103B+q498Q8cmvH2+glZIe263m+Hl6Z
	 B7vaV7wzv47KLyOCMCRswjVEGZqlxxnccg4wI4k9pxoaK10TbQYx++1EmVWsPo0kxO
	 3dRtTW0ogm2QA==
Date: Thu, 8 Feb 2024 08:11:54 +0200
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
Subject: Re: [PATCH v3 02/15] arm/pgtable: define PFN_PTE_SHIFT
Message-ID: <ZcRwqizngdTmd7G8@kernel.org>
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129124649.189745-3-david@redhat.com>

On Mon, Jan 29, 2024 at 01:46:36PM +0100, David Hildenbrand wrote:
> We want to make use of pte_next_pfn() outside of set_ptes(). Let's
> simply define PFN_PTE_SHIFT, required by pte_next_pfn().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/arm/include/asm/pgtable.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index d657b84b6bf7..be91e376df79 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -209,6 +209,8 @@ static inline void __sync_icache_dcache(pte_t pteval)
>  extern void __sync_icache_dcache(pte_t pteval);
>  #endif
>  
> +#define PFN_PTE_SHIFT		PAGE_SHIFT
> +
>  void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		      pte_t *ptep, pte_t pteval, unsigned int nr);
>  #define set_ptes set_ptes
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

