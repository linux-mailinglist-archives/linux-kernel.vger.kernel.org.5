Return-Path: <linux-kernel+bounces-138113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9E089ECC7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E39282C12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEF713D2A3;
	Wed, 10 Apr 2024 07:55:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A009713D620
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735734; cv=none; b=ai8cjO4zpMjiDVxKLNaYrVi2yJ2aMpmY71TWpkhqBQgpOwaAm1qhu19zguf5f1h44Pxfct/zXKrya9VoIc5tsW/ABmMilwFVJcAkxLmcEbhp/tLS/LvtFjXipxszTNafvrXuh+lY+QT7yngXC6c7iHUnGD7kKwkmCviwATPzGGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735734; c=relaxed/simple;
	bh=WU50FrX5DOOKxac3YXsUftaGdVTpKXhDtWyRM2Q0i3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCKJBfwQdPaYLgU2/J60pERUPShFgUEN/PR8ktlTeVDoSj9UGkA+hnh2IsxokOPzvXijSuNZew3nZglPzwRqg3PqY60ab9K0WqLgxwxV7W/TqAYx3mbj50WiMzmy9rCRTBBVfUlegOeYjBDj4dTPRQbweJBahOBxVM5QfLBrZRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6BB0139F;
	Wed, 10 Apr 2024 00:55:55 -0700 (PDT)
Received: from [10.162.43.6] (a077893.blr.arm.com [10.162.43.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 619903F64C;
	Wed, 10 Apr 2024 00:55:20 -0700 (PDT)
Message-ID: <410c7fe2-5790-49d6-9732-d2f3c5e351e6@arm.com>
Date: Wed, 10 Apr 2024 13:25:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: tlb: Fix TLBI RANGE operand
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 maz@kernel.org, oliver.upton@linux.dev, ryan.roberts@arm.com,
 apopple@nvidia.com, rananta@google.com, mark.rutland@arm.com,
 v-songbaohua@oppo.com, yangyicong@hisilicon.com, shahuang@redhat.com,
 yihyu@redhat.com, shan.gavin@gmail.com
References: <20240405035852.1532010-1-gshan@redhat.com>
 <20240405035852.1532010-2-gshan@redhat.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240405035852.1532010-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/5/24 09:28, Gavin Shan wrote:
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
> 
> Fixes: 117940aa6e5f ("KVM: arm64: Define kvm_tlb_flush_vmid_range()")
> Cc: stable@kernel.org # v6.6+
> Reported-by: Yihuang Yu <yihyu@redhat.com>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

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

