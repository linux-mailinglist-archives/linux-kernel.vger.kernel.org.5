Return-Path: <linux-kernel+bounces-81435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F498675E7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8354828E1ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CB280042;
	Mon, 26 Feb 2024 13:01:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C74F1CFA9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952461; cv=none; b=C/0M6OrxYsdRgH8PaXp71Hb6O6eerIiV/CoU6tA/ikzQTq8mESfKn+pX2d5l0Y0bx/4yUVO0Q+6dLc2d+ffVx0p2CK5A+CJ+uvJyfyUGVaFSVq7ka/Zp5ZX4zzY6EoqnysJQX+hjuimILuiCvS3TzlQ1a7P2e/KMp9DmJZ2PZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952461; c=relaxed/simple;
	bh=gU02AqookQ/IsCX5PRVEZ+njILfZLiVpjGq7vt3Hgjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ub4WtayR0PumMz7jBY5qjzXO+MtVuSwgXxih80kNU3VRNN+aSnqzAq+/AqFH0gcFGumtfGjyivu8hK6X9duf4sZ/Xou/aToOImXGiM/T6n/5hnbGwtJjWV/Izaxtey3wOWBXDmhMmzsZ4/BM5ICqG/ZngVnEtyKMkp5DFZkVwpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A033DA7;
	Mon, 26 Feb 2024 05:01:37 -0800 (PST)
Received: from [10.57.67.4] (unknown [10.57.67.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8574B3F762;
	Mon, 26 Feb 2024 05:00:56 -0800 (PST)
Message-ID: <c9d4fc77-0121-4415-a3f8-9fd7159992e2@arm.com>
Date: Mon, 26 Feb 2024 13:00:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: zokeefe@google.com, shy828301@gmail.com, david@redhat.com,
 mhocko@suse.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240225123215.86503-1-ioworker0@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240225123215.86503-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Lance,

Thanks for working on this!


On 25/02/2024 12:32, Lance Yang wrote:
> This patch improves madvise_free_pte_range() to correctly
> handle large folio that is smaller than PMD-size

When you say "correctly handle" are you implying there is a bug with the current
implementation or are you just saying you can optimize this to improve
performance? I'm not convinced there is a bug, but I agree there is certainly
room for performance improvement.

Thanks,
Ryan

> (for example, 16KiB to 1024KiB[1]). It’s probably part of
> the preparation to support anonymous multi-size THP.
> 
> Additionally, when the consecutive PTEs are mapped to
> consecutive pages of the same large folio (mTHP), if the
> folio is locked before madvise(MADV_FREE) or cannot be
> split, then all subsequent PTEs within the same PMD will
> be skipped. However, they should have been MADV_FREEed.
> 
> Moreover, this patch also optimizes lazyfreeing with
> PTE-mapped mTHP (Inspired by David Hildenbrand[2]). We
> aim to avoid unnecessary folio splitting if the large
> folio is entirely within the given range.
> 
> On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by
> PTE-mapped folios of the same size results in the following
> runtimes for madvise(MADV_FREE) in seconds (shorter is better):
> 
> Folio Size  |    Old     |    New     |  Change
> ----------------------------------------------
>       4KiB  |  0.590251  |  0.590264  |     0%
>      16KiB  |  2.990447  |  0.182167  |   -94%
>      32KiB  |  2.547831  |  0.101622  |   -96%
>      64KiB  |  2.457796  |  0.049726  |   -98%
>     128KiB  |  2.281034  |  0.030109  |   -99%
>     256KiB  |  2.230387  |  0.015838  |   -99%
>     512KiB  |  2.189106  |  0.009149  |   -99%
>    1024KiB  |  2.183949  |  0.006620  |   -99%
>    2048KiB  |  0.002799  |  0.002795  |     0%
> 
> [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm.com
> [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redhat.com/
> 
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  mm/madvise.c | 69 +++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 58 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index cfa5e7288261..bcbf56595a2e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -676,11 +676,43 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  		 */
>  		if (folio_test_large(folio)) {
>  			int err;
> +			unsigned long next_addr, align;
>  
> -			if (folio_estimated_sharers(folio) != 1)
> -				break;
> -			if (!folio_trylock(folio))
> -				break;
> +			if (folio_estimated_sharers(folio) != 1 ||
> +			    !folio_trylock(folio))
> +				goto skip_large_folio;
> +
> +			align = folio_nr_pages(folio) * PAGE_SIZE;
> +			next_addr = ALIGN_DOWN(addr + align, align);
> +
> +			/*
> +			 * If we mark only the subpages as lazyfree,
> +			 * split the large folio.
> +			 */
> +			if (next_addr > end || next_addr - addr != align)
> +				goto split_large_folio;
> +
> +			/*
> +			 * Avoid unnecessary folio splitting if the large
> +			 * folio is entirely within the given range.
> +			 */
> +			folio_test_clear_dirty(folio);
> +			folio_unlock(folio);
> +			for (; addr != next_addr; pte++, addr += PAGE_SIZE) {
> +				ptent = ptep_get(pte);
> +				if (pte_young(ptent) || pte_dirty(ptent)) {
> +					ptent = ptep_get_and_clear_full(
> +						mm, addr, pte, tlb->fullmm);
> +					ptent = pte_mkold(ptent);
> +					ptent = pte_mkclean(ptent);
> +					set_pte_at(mm, addr, pte, ptent);
> +					tlb_remove_tlb_entry(tlb, pte, addr);
> +				}
> +			}
> +			folio_mark_lazyfree(folio);
> +			goto next_folio;
> +
> +split_large_folio:
>  			folio_get(folio);
>  			arch_leave_lazy_mmu_mode();
>  			pte_unmap_unlock(start_pte, ptl);
> @@ -688,13 +720,28 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  			err = split_folio(folio);
>  			folio_unlock(folio);
>  			folio_put(folio);
> -			if (err)
> -				break;
> -			start_pte = pte =
> -				pte_offset_map_lock(mm, pmd, addr, &ptl);
> -			if (!start_pte)
> -				break;
> -			arch_enter_lazy_mmu_mode();
> +
> +			/*
> +			 * If the large folio is locked before madvise(MADV_FREE)
> +			 * or cannot be split, we just skip it.
> +			 */
> +			if (err) {
> +skip_large_folio:
> +				if (next_addr >= end)
> +					break;
> +				pte += (next_addr - addr) / PAGE_SIZE;
> +				addr = next_addr;
> +			}
> +
> +			if (!start_pte) {
> +				start_pte = pte = pte_offset_map_lock(
> +					mm, pmd, addr, &ptl);
> +				if (!start_pte)
> +					break;
> +				arch_enter_lazy_mmu_mode();
> +			}
> +
> +next_folio:
>  			pte--;
>  			addr -= PAGE_SIZE;
>  			continue;


