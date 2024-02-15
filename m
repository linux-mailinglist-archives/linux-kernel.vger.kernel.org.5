Return-Path: <linux-kernel+bounces-66770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AB0856152
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657272826DE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8498612BEB9;
	Thu, 15 Feb 2024 11:18:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA1E129A75
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995893; cv=none; b=ubZS4xSP17zQZqSxy6CtiTAV7kvM/euf1/Yw5cnhx+cUzFA5YbIVXqwcJCk+H8T21Cakgp3yXku0vB76GcBrr+uV3ZWcEpYSDbPca2L8N/UTPsJagx5WRT2hida9hH2A4Zm6g9/C/jZ7XALizT1K/xEKh+xc6jwtcoxIDuH+nHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995893; c=relaxed/simple;
	bh=7s517DU1+XIeug053V9PEoRjF3zuZRpKTr3VpuJA2/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOKS/KbtHq5wNANJ+C+hiGCwfoJyGheDko+OqpriZa7uK22ErFNdNSeLYmH5+/dzT3bnbl9YR6V76Ke0xCw5Gfn1Tk6EJGOeTXUfv+8LS8kHdfbzxyi0M4zp+XNSGMrKN8rnuxH2SQz8COOILz1oWAyxyaLr4MbMonbKZHBH5G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5E321FB;
	Thu, 15 Feb 2024 03:18:50 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.68.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EFFD3F7B4;
	Thu, 15 Feb 2024 03:18:06 -0800 (PST)
Date: Thu, 15 Feb 2024 11:17:59 +0000
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
	Yang Shi <shy828301@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/18] arm64/mm: Convert pte_next_pfn() to
 pte_advance_pfn()
Message-ID: <Zc3y5xVnazx5jgwv@FVFF77S0Q05N>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-5-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-5-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 10:31:51AM +0000, Ryan Roberts wrote:
> Core-mm needs to be able to advance the pfn by an arbitrary amount, so
> override the new pte_advance_pfn() API to do so.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/pgtable.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 52d0b0a763f1..b6d3e9e0a946 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -351,10 +351,10 @@ static inline pgprot_t pte_pgprot(pte_t pte)
>  	return __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
>  }
>  
> -#define pte_next_pfn pte_next_pfn
> -static inline pte_t pte_next_pfn(pte_t pte)
> +#define pte_advance_pfn pte_advance_pfn
> +static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
>  {
> -	return pfn_pte(pte_pfn(pte) + 1, pte_pgprot(pte));
> +	return pfn_pte(pte_pfn(pte) + nr, pte_pgprot(pte));
>  }
>  
>  static inline void set_ptes(struct mm_struct *mm,
> @@ -370,7 +370,7 @@ static inline void set_ptes(struct mm_struct *mm,
>  		if (--nr == 0)
>  			break;
>  		ptep++;
> -		pte = pte_next_pfn(pte);
> +		pte = pte_advance_pfn(pte, 1);
>  	}
>  }
>  #define set_ptes set_ptes
> -- 
> 2.25.1
> 

