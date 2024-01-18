Return-Path: <linux-kernel+bounces-30274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA0831C79
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEC21C20B35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5022C6BE;
	Thu, 18 Jan 2024 15:25:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BD120B07
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591531; cv=none; b=UkRWtAjqs/Y/ktwMucYOWlYaErgV7Q8GZhNfnLMFQw6Sz+udKjGlvgqoSggHT9wP1svFhDMQE5/LakxRrpdSfFevB9Hleen5QZ/HHlZn4cc3Vsm6EKDjDo0mm/d8aVIqXRQD9kCXvdMpxz9HrjVLRLkZiXHEXFfoc2G9L+r/jeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591531; c=relaxed/simple;
	bh=IQ27c7j5H8MWbotffGRB2CO6VNyTTb6PZHLkudr7AxA=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=cBhfH0OylK5wcszvzMH2s4rx2WZEGuDsjDmVtcEOsf1AksMjoyJGARjGGh2E+24Nm8QCG1hAcsqZE+FjB7ynZEx41nHfNSMfq0AA7kjYCmI2M/G3qK6npL4y6ObBh9Yy4SQxrPUT3nQM3yyodhNYKDLFuumag1JphTzsPKbdtE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CD9A1042;
	Thu, 18 Jan 2024 07:26:14 -0800 (PST)
Received: from [10.57.77.97] (unknown [10.57.77.97])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 215073F73F;
	Thu, 18 Jan 2024 07:25:24 -0800 (PST)
Message-ID: <0450f151-143a-4ce8-8131-31180bbc13b8@arm.com>
Date: Thu, 18 Jan 2024 15:25:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/6] mm: support large folios swap-in
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, mhocko@suse.com, shy828301@gmail.com,
 wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yuzhao@google.com, surenb@google.com,
 steven.price@arm.com
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20240118111036.72641-1-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240118111036.72641-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/01/2024 11:10, Barry Song wrote:
> On an embedded system like Android, more than half of anon memory is actually
> in swap devices such as zRAM. For example, while an app is switched to back-
> ground, its most memory might be swapped-out.
> 
> Now we have mTHP features, unfortunately, if we don't support large folios
> swap-in, once those large folios are swapped-out, we immediately lose the 
> performance gain we can get through large folios and hardware optimization
> such as CONT-PTE.
> 
> In theory, we don't need to rely on Ryan's swap out patchset[1]. That is to say,
> before swap-out, if some memory were normal pages, but when swapping in, we
> can also swap-in them as large folios. 

I think this could also violate MADV_NOHUGEPAGE; if the application has
requested that we do not create a THP, then we had better not; it could cause a
correctness issue in some circumstances. You would need to pay attention to this
vma flag if taking this approach.

> But this might require I/O happen at
> some random places in swap devices. So we limit the large folios swap-in to
> those areas which were large folios before swapping-out, aka, swaps are also
> contiguous in hardware. 

In fact, even this may not be sufficient; it's possible that a contiguous set of
base pages (small folios) were allocated to a virtual mapping and all swapped
out together - they would likely end up contiguous in the swap file, but should
not be swapped back in as a single folio because of this (same reasoning applies
to cluster of smaller THPs that you mistake for a larger THP, etc).

So you will need to check what THP sizes are enabled and check the VMA
suitability regardless; Perhaps you are already doing this - I haven't looked at
the code yet.

I'll aim to review the code in the next couple of weeks.

Thanks,
Ryan

> On the other hand, in OPPO's product, we've deployed
> anon large folios on millions of phones[2]. we enhanced zsmalloc and zRAM to
> compress and decompress large folios as a whole, which help improve compression
> ratio and decrease CPU consumption significantly. In zsmalloc and zRAM we can
> save large objects whose original size are 64KiB for example. So it is also a
> better choice for us to only swap-in large folios for those compressed large
> objects as a large folio can be decompressed all together.
> 
> Note I am moving my previous "arm64: mm: swap: support THP_SWAP on hardware
> with MTE" to this series as it might help review.
> 
> [1] [PATCH v3 0/4] Swap-out small-sized THP without splitting
> https://lore.kernel.org/linux-mm/20231025144546.577640-1-ryan.roberts@arm.com/
> [2] OnePlusOSS / android_kernel_oneplus_sm8550 
> https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/oneplus/sm8550_u_14.0.0_oneplus11
> 
> Barry Song (2):
>   arm64: mm: swap: support THP_SWAP on hardware with MTE
>   mm: rmap: weaken the WARN_ON in __folio_add_anon_rmap()
> 
> Chuanhua Han (4):
>   mm: swap: introduce swap_nr_free() for batched swap_free()
>   mm: swap: make should_try_to_free_swap() support large-folio
>   mm: support large folios swapin as a whole
>   mm: madvise: don't split mTHP for MADV_PAGEOUT
> 
>  arch/arm64/include/asm/pgtable.h |  21 ++----
>  arch/arm64/mm/mteswap.c          |  42 ++++++++++++
>  include/asm-generic/tlb.h        |  10 +++
>  include/linux/huge_mm.h          |  12 ----
>  include/linux/pgtable.h          |  62 ++++++++++++++++-
>  include/linux/swap.h             |   6 ++
>  mm/madvise.c                     |  48 ++++++++++++++
>  mm/memory.c                      | 110 ++++++++++++++++++++++++++-----
>  mm/page_io.c                     |   2 +-
>  mm/rmap.c                        |   5 +-
>  mm/swap_slots.c                  |   2 +-
>  mm/swapfile.c                    |  29 ++++++++
>  12 files changed, 301 insertions(+), 48 deletions(-)
> 


