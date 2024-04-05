Return-Path: <linux-kernel+bounces-133405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787DF89A34E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F9DB2728E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B844171645;
	Fri,  5 Apr 2024 17:10:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3340171659
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337020; cv=none; b=axBlChsHqYJMgFuDyhay1mFOmRsJG4EdOq9S/C8UWWk9HO9PKbqpMSTqlNQrvmf9rFiXmuAp7yWLrPKOHwuH8wHdaVO9zBcbSAKYVXqkl0ms4Zh5o++mEBtXcHUIM6Q3igljGdcn8giVlqGzXfFmTzncR3WCYkrGyjsJQT43g+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337020; c=relaxed/simple;
	bh=jQDmOyTJB0alQBCkCFlKeEX7jpc7AfVvf7G5KQUWVFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/0lniF63rglbOwNZbF8BVUCI0UMMKIvW4WqcmYvxBHTkzWR70ZZAOwgBRGDGRtAu4CHHZJbKZXwHMQLbzr5Uz6BifB6p02cd2TAnKv5pjf4hEYqBp+C2MOJVGESZtXgfPoTm8S7CfblPkeblEM24BIXBDytQbQ3JSGD4VRYAZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C64C433C7;
	Fri,  5 Apr 2024 17:10:16 +0000 (UTC)
Date: Fri, 5 Apr 2024 18:10:14 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Gavin Shan <gshan@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, akpm@linux-foundation.org, maz@kernel.org,
	oliver.upton@linux.dev, ryan.roberts@arm.com, apopple@nvidia.com,
	rananta@google.com, mark.rutland@arm.com, v-songbaohua@oppo.com,
	yangyicong@hisilicon.com, shahuang@redhat.com, yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH v3 1/3] arm64: tlb: Fix TLBI RANGE operand
Message-ID: <ZhAwdtGPuc2-sd7Q@arm.com>
References: <20240405035852.1532010-1-gshan@redhat.com>
 <20240405035852.1532010-2-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405035852.1532010-2-gshan@redhat.com>

On Fri, Apr 05, 2024 at 01:58:50PM +1000, Gavin Shan wrote:
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

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

This looks correct to me as well. I spent a bit of time to update an old
CBMC model I had around. With the original __TLBI_RANGE_NUM indeed shows
'scale' becoming negative on the kvm_tlb_flush_vmid_range() path. The
patch above fixes it and it also allows the non-KVM path to use the
range TLBI for MAX_TLBI_RANGE_PAGES (as per patch 3).

FWIW, here's the model:

-----------------------8<--------------------------------------
// SPDX-License-Identifier: GPL-2.0-only
/*
 * Check with:
 *   cbmc --unwind 6 tlbinval.c
 */

#define PAGE_SHIFT	(12)
#define PAGE_SIZE	(1 << PAGE_SHIFT)
#define VA_RANGE	(1UL << 48)
#define SZ_64K		0x00010000

#define __round_mask(x, y) ((__typeof__(x))((y)-1))
#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
#define round_down(x, y) ((x) & ~__round_mask(x, y))

#define min(x, y)	(x <= y ? x : y)

#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
#define ALIGN(x, a)			__ALIGN_KERNEL((x), (a))

/* only masking out irrelevant bits */
#define __TLBI_RANGE_VADDR(addr, shift)	((addr) & ~((1UL << shift) - 1))
#define __TLBI_VADDR(addr)		__TLBI_RANGE_VADDR(addr, PAGE_SHIFT)

#define __TLBI_RANGE_PAGES(num, scale)	((unsigned long)((num) + 1) << (5 * (scale) + 1))
#define MAX_TLBI_RANGE_PAGES		__TLBI_RANGE_PAGES(31, 3)

#if 0
/* original code */
#define TLBI_RANGE_MASK			0x1fUL
#define __TLBI_RANGE_NUM(pages, scale)	\
	((((int)(pages) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK) - 1)
#else
#define __TLBI_RANGE_NUM(pages, scale)					\
	({								\
		int __pages = min((pages),				\
				  __TLBI_RANGE_PAGES(31, (scale)));	\
		(__pages >> (5 * (scale) + 1)) - 1;			\
	})
#endif

const static _Bool lpa2 = 1;
const static _Bool kvm = 1;

static unsigned long inval_start;
static unsigned long inval_end;

static void tlbi(unsigned long start, unsigned long size)
{
	unsigned long end = start + size;

	if (inval_end == 0) {
		inval_start = start;
		inval_end = end;
		return;
	}

	/* optimal invalidation */
	__CPROVER_assert(start >= inval_end || end <= inval_start, "No overlapping TLBI range");

	if (start < inval_start) {
		__CPROVER_assert(end >= inval_start, "No TLBI range gaps");
		inval_start = start;
	}
	if (end > inval_end) {
		__CPROVER_assert(start <= inval_end, "No TLBI range gaps");
		inval_end = end;
	}
}

static void tlbi_range(unsigned long start, int num, int scale)
{
	unsigned long size = __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT;

	tlbi(start, size);
}

static void __flush_tlb_range_op(unsigned long start, unsigned long pages,
				 unsigned long stride)
{
	int num = 0;
	int scale = 3;
	int shift = lpa2 ? 16 : PAGE_SHIFT;
	unsigned long addr;

	while (pages > 0) {
		if (pages == 1 ||
		    (lpa2 && start != ALIGN(start, SZ_64K))) {
			addr = __TLBI_VADDR(start);
			tlbi(addr, stride);
			start += stride;
			pages -= stride >> PAGE_SHIFT;
			continue;
		}

		__CPROVER_assert(scale >= 0 && scale <= 3, "Scale in range");
		num = __TLBI_RANGE_NUM(pages, scale);
		__CPROVER_assert(num <= 31, "Num in range");
		if (num >= 0) {
			addr = __TLBI_RANGE_VADDR(start, shift);
			tlbi_range(addr, num, scale);
			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT;
			pages -= __TLBI_RANGE_PAGES(num, scale);
		}
		scale--;
	}
}

static void __flush_tlb_range(unsigned long start, unsigned long pages,
			      unsigned long stride)
{
	if (pages > MAX_TLBI_RANGE_PAGES) {
		tlbi(0, VA_RANGE);
		return;
	}

	__flush_tlb_range_op(start, pages, stride);
}

void __kvm_tlb_flush_vmid_range(unsigned long start, unsigned long pages)
{
	unsigned long stride;

	stride = PAGE_SIZE;
	start = round_down(start, stride);

	__flush_tlb_range_op(start, pages, stride);
}

static void kvm_tlb_flush_vmid_range(unsigned long addr, unsigned long size)
{
	unsigned long pages, inval_pages;

	pages = size >> PAGE_SHIFT;
	while (pages > 0) {
		inval_pages = min(pages, MAX_TLBI_RANGE_PAGES);
		__kvm_tlb_flush_vmid_range(addr, inval_pages);

		addr += inval_pages << PAGE_SHIFT;
		pages -= inval_pages;
	}
}

static unsigned long nondet_ulong(void);

int main(void)
{
	unsigned long stride = nondet_ulong();
	unsigned long start = round_down(nondet_ulong(), stride);
	unsigned long end = round_up(nondet_ulong(), stride);
	unsigned long pages = (end - start) >> PAGE_SHIFT;

	__CPROVER_assume(stride == PAGE_SIZE ||
			 stride == PAGE_SIZE << (PAGE_SHIFT - 3) ||
			 stride == PAGE_SIZE << (2 * (PAGE_SHIFT - 3)));
	__CPROVER_assume(start < end);
	__CPROVER_assume(end <= VA_RANGE);

	if (kvm)
		kvm_tlb_flush_vmid_range(start, pages << PAGE_SHIFT);
	else
		__flush_tlb_range(start, pages, stride);

	__CPROVER_assert((inval_start == 0 && inval_end == VA_RANGE) ||
			 (inval_start == start && inval_end == end),
			 "Correct invalidation");

	return 0;
}

