Return-Path: <linux-kernel+bounces-63946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF4B8536A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACCA287A35
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7015FB97;
	Tue, 13 Feb 2024 16:55:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666B95F852
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843299; cv=none; b=sxZcc1YncEn2HsseYBedodAOpmyl2P++9di+KqD5UxbFl3FcUecm3KEzHtRj6K4S3dymAyhj7P8u8/2ZmARdkZ+rNJLjBYRXYnVAKEicAPYxT1LH22cBBqQZla/PI2bdOU9vq0x4HA1BAyZ7YOZA795Jsa8anKr2RRzOqH9rCQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843299; c=relaxed/simple;
	bh=6r2sJzbh/wD5ErlkQRvpbpFzmFT6Ly0IdbfwOHZ+bNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnsEdgLasftiXcvdn+NVkuPw5sgTQeNkKUmouN1Q92/N6U0TiaRT+UjOSvcfYmM2n9xzIMIn2GhNPv2zDbCtwxxpuyJ+aE5uFUWlSYSrkJAEtTDeUKCnPQxr3x84ZA7rlrDMLi1SJOg2INjWBrjNJFp4xCTEJwYPH4SpqhwrTX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5C0DDA7;
	Tue, 13 Feb 2024 08:55:38 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.36.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE5853F5A1;
	Tue, 13 Feb 2024 08:54:53 -0800 (PST)
Date: Tue, 13 Feb 2024 16:54:51 +0000
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
Subject: Re: [PATCH v5 23/25] arm64/mm: Implement pte_batch_hint()
Message-ID: <Zcue2_wPJe8lx4_u@FVFF77S0Q05N.cambridge.arm.com>
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
 <20240202080756.1453939-24-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202080756.1453939-24-ryan.roberts@arm.com>

On Fri, Feb 02, 2024 at 08:07:54AM +0000, Ryan Roberts wrote:
> When core code iterates over a range of ptes and calls ptep_get() for
> each of them, if the range happens to cover contpte mappings, the number
> of pte reads becomes amplified by a factor of the number of PTEs in a
> contpte block. This is because for each call to ptep_get(), the
> implementation must read all of the ptes in the contpte block to which
> it belongs to gather the access and dirty bits.
> 
> This causes a hotspot for fork(), as well as operations that unmap
> memory such as munmap(), exit and madvise(MADV_DONTNEED). Fortunately we
> can fix this by implementing pte_batch_hint() which allows their
> iterators to skip getting the contpte tail ptes when gathering the batch
> of ptes to operate on. This results in the number of PTE reads returning
> to 1 per pte.
> 
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/pgtable.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index ad04adb7b87f..353ea67b5d75 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1220,6 +1220,15 @@ static inline void contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
>  		__contpte_try_unfold(mm, addr, ptep, pte);
>  }
>  
> +#define pte_batch_hint pte_batch_hint
> +static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
> +{
> +	if (!pte_valid_cont(pte))
> +		return 1;
> +
> +	return CONT_PTES - (((unsigned long)ptep >> 3) & (CONT_PTES - 1));
> +}
> +
>  /*
>   * The below functions constitute the public API that arm64 presents to the
>   * core-mm to manipulate PTE entries within their page tables (or at least this
> -- 
> 2.25.1
> 

