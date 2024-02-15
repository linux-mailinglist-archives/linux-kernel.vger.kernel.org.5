Return-Path: <linux-kernel+bounces-66781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3796E8561B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB2AB2B278
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2F512B15B;
	Thu, 15 Feb 2024 11:24:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8FC129A91
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996264; cv=none; b=IFehDqo2QCcSjOI5FAbNB7h0gQIV+w3r5vmPYFP8mmsDFxPEMYvueGcFftLm7Ohlw2c9JaciHKavr4e8eg1c8qAACSWjApEH2TEH0NXfN+4xpRaTH6wFqJcasdypaSFqJY83wj2GC3Jiy2tyXmmHPiURlK8ZlidChYQXlx0gXpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996264; c=relaxed/simple;
	bh=UKTmkMeT0BFC91Dpy0Xwa2YC5BAd2vCEeDM7XZy4Sl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDamQHx/ne3hwQTsz5k1g5kl97KiPDiQ4KhYhu//4YGhCc4cMgGPUmvdAdrsKTl5Vo1wiZPJIZoS1kyoLlgdbkmEC6HVZv6ov0ITIS5STU9imI8jpmMDthhO0BkRf8ga73Xi6Pyh2MwYu8RT2WJc/NZMpBmGZmV3oja/pIqIRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E6AEDA7;
	Thu, 15 Feb 2024 03:25:03 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.68.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7DF33F7B4;
	Thu, 15 Feb 2024 03:24:18 -0800 (PST)
Date: Thu, 15 Feb 2024 11:24:16 +0000
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
Subject: Re: [PATCH v6 11/18] arm64/mm: Split __flush_tlb_range() to elide
 trailing DSB
Message-ID: <Zc30YGd3yBVpLNqn@FVFF77S0Q05N>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-12-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-12-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 10:31:58AM +0000, Ryan Roberts wrote:
> Split __flush_tlb_range() into __flush_tlb_range_nosync() +
> __flush_tlb_range(), in the same way as the existing flush_tlb_page()
> arrangement. This allows calling __flush_tlb_range_nosync() to elide the
> trailing DSB. Forthcoming "contpte" code will take advantage of this
> when clearing the young bit from a contiguous range of ptes.
> 
> Ordering between dsb and mmu_notifier_arch_invalidate_secondary_tlbs()
> has changed, but now aligns with the ordering of __flush_tlb_page(). It
> has been discussed that __flush_tlb_page() may be wrong though.
> Regardless, both will be resolved separately if needed.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/tlbflush.h | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 1deb5d789c2e..3b0e8248e1a4 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -422,7 +422,7 @@ do {									\
>  #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
>  	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, false, kvm_lpa2_is_enabled());
>  
> -static inline void __flush_tlb_range(struct vm_area_struct *vma,
> +static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
>  				     unsigned long start, unsigned long end,
>  				     unsigned long stride, bool last_level,
>  				     int tlb_level)
> @@ -456,10 +456,19 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>  		__flush_tlb_range_op(vae1is, start, pages, stride, asid,
>  				     tlb_level, true, lpa2_is_enabled());
>  
> -	dsb(ish);
>  	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, start, end);
>  }
>  
> +static inline void __flush_tlb_range(struct vm_area_struct *vma,
> +				     unsigned long start, unsigned long end,
> +				     unsigned long stride, bool last_level,
> +				     int tlb_level)
> +{
> +	__flush_tlb_range_nosync(vma, start, end, stride,
> +				 last_level, tlb_level);
> +	dsb(ish);
> +}
> +
>  static inline void flush_tlb_range(struct vm_area_struct *vma,
>  				   unsigned long start, unsigned long end)
>  {
> -- 
> 2.25.1
> 

