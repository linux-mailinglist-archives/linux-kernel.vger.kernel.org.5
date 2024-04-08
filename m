Return-Path: <linux-kernel+bounces-135037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA1289BA42
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF96D1C2163A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F311802E;
	Mon,  8 Apr 2024 08:29:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70712D796
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564978; cv=none; b=t3oyeHoK/zRFRMHs10nSuzLdIna0WDJU/nF5qcbFIESoR+PoEbnxaBsMBgn/ZJFosgWSO5l49jWA9zygDKbqpj+lV3jtoDjg4ltSu0lf4s7m9EhbGlid7D8foOfhPstOB10ChYrL/9MkYquiZjYm6ujFkl25uSq6Fb4epqbZEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564978; c=relaxed/simple;
	bh=ineV7EMvDbW8sjvFmdM7CUKqGRZ+70tX7apATV5C0L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kcn/LVWv+t1KRCc49GomtRWyWQE00fsPzFu3VXsDMyn7gtMS39yH+Wr4nTqQE5qd+6kijdApDWJ4HkK/MlI8LIcEPLdhUwuU4ZEHWC38D4VqiqHEHtQ4BzXxHj/9opfW77m0M0ARQAT3KdqG+hbOo8Vcvdvir+q9/iv5q+5DViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9EC41007;
	Mon,  8 Apr 2024 01:30:05 -0700 (PDT)
Received: from [10.57.73.169] (unknown [10.57.73.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E7E43F766;
	Mon,  8 Apr 2024 01:29:33 -0700 (PDT)
Message-ID: <7a929104-5f09-4ff6-8792-4a9e93bc0894@arm.com>
Date: Mon, 8 Apr 2024 09:29:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: tlb: Fix TLBI RANGE operand
Content-Language: en-GB
To: Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 maz@kernel.org, oliver.upton@linux.dev, apopple@nvidia.com,
 rananta@google.com, mark.rutland@arm.com, v-songbaohua@oppo.com,
 yangyicong@hisilicon.com, shahuang@redhat.com, yihyu@redhat.com,
 shan.gavin@gmail.com
References: <20240405035852.1532010-1-gshan@redhat.com>
 <20240405035852.1532010-2-gshan@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240405035852.1532010-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 04:58, Gavin Shan wrote:
> KVM/arm64 relies on TLBI RANGE feature to flush TLBs when the dirty
> pages are collected by VMM and the page table entries become write
> protected during live migration. Unfortunately, the operand passed
> to the TLBI RANGE instruction isn't correctly sorted out due to the
> commit 117940aa6e5f ("KVM: arm64: Define kvm_tlb_flush_vmid_range()").
> It leads to crash on the destination VM after live migration because
> TLBs aren't flushed completely and some of the dirty pages are missed.
> 
> For example, I have a VM where 8GB memory is assigned, starting from
> 0x40000000 (1GB). Note that the host has 4KB as the base page size.
> In the middile of migration, kvm_tlb_flush_vmid_range() is executed
> to flush TLBs. It passes MAX_TLBI_RANGE_PAGES as the argument to
> __kvm_tlb_flush_vmid_range() and __flush_s2_tlb_range_op(). SCALE#3
> and NUM#31, corresponding to MAX_TLBI_RANGE_PAGES, isn't supported
> by __TLBI_RANGE_NUM(). In this specific case, -1 has been returned
> from __TLBI_RANGE_NUM() for SCALE#3/2/1/0 and rejected by the loop
> in the __flush_tlb_range_op() until the variable @scale underflows
> and becomes -9, 0xffff708000040000 is set as the operand. The operand
> is wrong since it's sorted out by __TLBI_VADDR_RANGE() according to
> invalid @scale and @num.
> 
> Fix it by extending __TLBI_RANGE_NUM() to support the combination of
> SCALE#3 and NUM#31. With the changes, [-1 31] instead of [-1 30] can
> be returned from the macro, meaning the TLBs for 0x200000 pages in the
> above example can be flushed in one shoot with SCALE#3 and NUM#31. The
> macro TLBI_RANGE_MASK is dropped since no one uses it any more. The
> comments are also adjusted accordingly.

Perhaps I'm being overly pedantic, but I don't think the bug is
__TLBI_RANGE_NUM() not being able to return 31; It is clearly documented that it
can only return in the range [-1, 30] and a maximum of (MAX_TLBI_RANGE_PAGES -
1) pages are supported.

The bug is in the kvm caller, which tries to call __flush_tlb_range_op() with
MAX_TLBI_RANGE_PAGES; clearly out-of-bounds.

So personally, I would prefer to fix the bug first. Then separately enhance the
infrastructure to support NUM=31.

> 
> Fixes: 117940aa6e5f ("KVM: arm64: Define kvm_tlb_flush_vmid_range()")

I would argue that the bug was actually introduced by commit 360839027a6e
("arm64: tlb: Refactor the core flush algorithm of __flush_tlb_range"), which
separated the tlbi loop from the range size validation in __flush_tlb_range().
Before this, all calls would have to go through __flush_tlb_range() and
therefore anything bigger than (MAX_TLBI_RANGE_PAGES - 1) pages would cause the
whole mm to be flushed. Although I get that bisect will lead to this one, so
that's probably the right one to highlight.

I get why it was split, but perhaps it should have been split at a higher level;
If tlbi range is not supported, then KVM will flush the whole vmid. Would it be
better for KVM to follow the same pattern as __flush_tlb_range_nosync() and
issue per-block tlbis upto a max of MAX_DVM_OPS before falling back to the whole
vmid? And if tlbi range is supported, KVM uses it regardless of the size of the
range, whereas __flush_tlb_range_nosync() falls back to flush_tlb_mm() at a
certain size. It's not clear why this divergence is useful?



> Cc: stable@kernel.org # v6.6+
> Reported-by: Yihuang Yu <yihyu@redhat.com>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Anyway, the implementation looks correct, so:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>


> ---
>  arch/arm64/include/asm/tlbflush.h | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 3b0e8248e1a4..a75de2665d84 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -161,12 +161,18 @@ static inline unsigned long get_trans_granule(void)
>  #define MAX_TLBI_RANGE_PAGES		__TLBI_RANGE_PAGES(31, 3)
>  
>  /*
> - * Generate 'num' values from -1 to 30 with -1 rejected by the
> - * __flush_tlb_range() loop below.
> + * Generate 'num' values from -1 to 31 with -1 rejected by the
> + * __flush_tlb_range() loop below. Its return value is only
> + * significant for a maximum of MAX_TLBI_RANGE_PAGES pages. If
> + * 'pages' is more than that, you must iterate over the overall
> + * range.
>   */
> -#define TLBI_RANGE_MASK			GENMASK_ULL(4, 0)
> -#define __TLBI_RANGE_NUM(pages, scale)	\
> -	((((pages) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK) - 1)
> +#define __TLBI_RANGE_NUM(pages, scale)					\
> +	({								\
> +		int __pages = min((pages),				\
> +				  __TLBI_RANGE_PAGES(31, (scale)));	\
> +		(__pages >> (5 * (scale) + 1)) - 1;			\
> +	})
>  
>  /*
>   *	TLB Invalidation
> @@ -379,10 +385,6 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>   * 3. If there is 1 page remaining, flush it through non-range operations. Range
>   *    operations can only span an even number of pages. We save this for last to
>   *    ensure 64KB start alignment is maintained for the LPA2 case.
> - *
> - * Note that certain ranges can be represented by either num = 31 and
> - * scale or num = 0 and scale + 1. The loop below favours the latter
> - * since num is limited to 30 by the __TLBI_RANGE_NUM() macro.
>   */
>  #define __flush_tlb_range_op(op, start, pages, stride,			\
>  				asid, tlb_level, tlbi_user, lpa2)	\


