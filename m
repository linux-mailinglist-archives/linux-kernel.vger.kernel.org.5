Return-Path: <linux-kernel+bounces-135059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35B789BA87
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D6A1C21941
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6012C39AC1;
	Mon,  8 Apr 2024 08:43:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713FC2A8DA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565831; cv=none; b=rAtHDSwXMOQmQvQhfbpj7VihJvKWhZCBTqnTNGOC9YmZgamHGzJPXpzC1g+euPD4XkcVKLNjnxdzwo+a4MZ8wrui2Q0vcdvjtAYGuWyJbprBwVdzpPebZXLQWm0J0aQZgclUD6B7d7i3KYnAhvKntwG01PlNwCae89KVNtlJ9UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565831; c=relaxed/simple;
	bh=wjYKK2DUgmUMmbVGl6Cqe3/H4LMiRRRoPqZUt+qbJ/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pc4ky4+e0kNps5XgT02STzwKYQcIQll7rsPYJoDtQnxB219/2lmgSlho9F5K43uR+m5ZxYX5P9sNVM5xX5NDUxjKagZhJhP9MX8u0597dnwPxEHvjeo1bvvD080SLBYMkXxXjRmGqFX7APKjf0HCFAbV25vtf11sY0eaDW9o3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05A9C1007;
	Mon,  8 Apr 2024 01:44:19 -0700 (PDT)
Received: from [10.57.73.169] (unknown [10.57.73.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C0F03F766;
	Mon,  8 Apr 2024 01:43:46 -0700 (PDT)
Message-ID: <27718d41-32cb-4976-b50e-e9237da7aedf@arm.com>
Date: Mon, 8 Apr 2024 09:43:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: tlb: Allow range operation for
 MAX_TLBI_RANGE_PAGES
Content-Language: en-GB
To: Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 maz@kernel.org, oliver.upton@linux.dev, apopple@nvidia.com,
 rananta@google.com, mark.rutland@arm.com, v-songbaohua@oppo.com,
 yangyicong@hisilicon.com, shahuang@redhat.com, yihyu@redhat.com,
 shan.gavin@gmail.com
References: <20240405035852.1532010-1-gshan@redhat.com>
 <20240405035852.1532010-4-gshan@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240405035852.1532010-4-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 04:58, Gavin Shan wrote:
> MAX_TLBI_RANGE_PAGES pages is covered by SCALE#3 and NUM#31 and it's
> supported now. Allow TLBI RANGE operation when the number of pages is
> equal to MAX_TLBI_RANGE_PAGES in __flush_tlb_range_nosync().
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/include/asm/tlbflush.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 243d71f7bc1f..95fbc8c05607 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -446,11 +446,11 @@ static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
>  	 * When not uses TLB range ops, we can handle up to
>  	 * (MAX_DVM_OPS - 1) pages;
>  	 * When uses TLB range ops, we can handle up to
> -	 * (MAX_TLBI_RANGE_PAGES - 1) pages.
> +	 * MAX_TLBI_RANGE_PAGES pages.
>  	 */
>  	if ((!system_supports_tlb_range() &&
>  	     (end - start) >= (MAX_DVM_OPS * stride)) ||
> -	    pages >= MAX_TLBI_RANGE_PAGES) {
> +	    pages > MAX_TLBI_RANGE_PAGES) {

As a further enhancement, I wonder if it might be better to test:

	pages * 4 / MAX_TLBI_RANGE_PAGES > MAX_DVM_OPS

Then add an extra loop over __flush_tlb_range_op(), like KVM does.

The math is trying to express that there are a maximum of 4 tlbi range
instructions for MAX_TLBI_RANGE_PAGES pages (1 per scale) and we only need to
fall back to flushing the whole mm if it could generate more than MAX_DVM_OPS ops.

>  		flush_tlb_mm(vma->vm_mm);
>  		return;
>  	}


