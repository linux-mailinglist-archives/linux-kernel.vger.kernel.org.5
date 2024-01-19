Return-Path: <linux-kernel+bounces-31196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4B6832A64
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF708B22E52
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF4554676;
	Fri, 19 Jan 2024 13:25:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73FC524BE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670742; cv=none; b=ngG/PMErIVK4GUfljroSGl/u/I5SiPWu2EOGQ5aBoxEH0d3i83zobVwX9yhRGPEbWTqlI7im25SExA0c4XPAsp5Y0XkBj0dUUZoHcMrXX8LTbh7kZtvD6xVHlPi5OTFzSt3rLyaBtST8Oi8FeJ5wExQfeQcDaduUWepmyEV7big=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670742; c=relaxed/simple;
	bh=XTJ+9wKUeHxFBGZCSjaJFzAFmGcbalV48BRz8Qy7cUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJltc/xsM2Ki3DqdkS7QvBL9LZ3HaJmPxcchBDwDTB0ypZQw3h4hSVjZ1h9LFmzWSxTZES6KtJM8/ATR/Rm7HFGxN2u4eXE8Z3Abm41ARTXClpwgWE8PAPQNtrXSAM6sOXSfYtKEBfEaiN9tKM3LFEKWHUTbtY8xCv/UAcjDZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E713C1042;
	Fri, 19 Jan 2024 05:26:22 -0800 (PST)
Received: from [10.57.77.97] (unknown [10.57.77.97])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0C2A3F5A1;
	Fri, 19 Jan 2024 05:25:33 -0800 (PST)
Message-ID: <caf72da8-1f32-4eb4-9935-b49c1efed4c5@arm.com>
Date: Fri, 19 Jan 2024 13:25:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/6] mm: support large folios swap-in
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, mhocko@suse.com, shy828301@gmail.com,
 wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yuzhao@google.com, surenb@google.com,
 steven.price@arm.com
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20240118111036.72641-1-21cnbao@gmail.com>
 <0450f151-143a-4ce8-8131-31180bbc13b8@arm.com>
 <CAGsJ_4xHaAzOMphFt-0GwtS4f+Vj4cbR+WdX68TSQVo+-WR6rA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4xHaAzOMphFt-0GwtS4f+Vj4cbR+WdX68TSQVo+-WR6rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/01/2024 23:54, Barry Song wrote:
> On Thu, Jan 18, 2024 at 11:25 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 18/01/2024 11:10, Barry Song wrote:
>>> On an embedded system like Android, more than half of anon memory is actually
>>> in swap devices such as zRAM. For example, while an app is switched to back-
>>> ground, its most memory might be swapped-out.
>>>
>>> Now we have mTHP features, unfortunately, if we don't support large folios
>>> swap-in, once those large folios are swapped-out, we immediately lose the
>>> performance gain we can get through large folios and hardware optimization
>>> such as CONT-PTE.
>>>
>>> In theory, we don't need to rely on Ryan's swap out patchset[1]. That is to say,
>>> before swap-out, if some memory were normal pages, but when swapping in, we
>>> can also swap-in them as large folios.
>>
>> I think this could also violate MADV_NOHUGEPAGE; if the application has
>> requested that we do not create a THP, then we had better not; it could cause a
>> correctness issue in some circumstances. You would need to pay attention to this
>> vma flag if taking this approach.
>>
>>> But this might require I/O happen at
>>> some random places in swap devices. So we limit the large folios swap-in to
>>> those areas which were large folios before swapping-out, aka, swaps are also
>>> contiguous in hardware.
>>
>> In fact, even this may not be sufficient; it's possible that a contiguous set of
>> base pages (small folios) were allocated to a virtual mapping and all swapped
>> out together - they would likely end up contiguous in the swap file, but should
>> not be swapped back in as a single folio because of this (same reasoning applies
>> to cluster of smaller THPs that you mistake for a larger THP, etc).
>>
>> So you will need to check what THP sizes are enabled and check the VMA
>> suitability regardless; Perhaps you are already doing this - I haven't looked at
>> the code yet.
> 
> we are actually re-using your alloc_anon_folio() by adding a parameter
> to make it
> support both do_anon_page and do_swap_page,
> 
> -static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> +static struct folio *alloc_anon_folio(struct vm_fault *vmf,
> +      bool (*pte_range_check)(pte_t *, int))
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   struct vm_area_struct *vma = vmf->vma;
> @@ -4190,7 +4270,7 @@ static struct folio *alloc_anon_folio(struct
> vm_fault *vmf)
>   order = highest_order(orders);
>   while (orders) {
>   addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> - if (pte_range_none(pte + pte_index(addr), 1 << order))
> + if (pte_range_check(pte + pte_index(addr), 1 << order))
>   break;
>   order = next_order(&orders, order);
>   }
> @@ -4269,7 +4349,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>   if (unlikely(anon_vma_prepare(vma)))
>   goto oom;
>   /* Returns NULL on OOM or ERR_PTR(-EAGAIN) if we must retry the fault */
> - folio = alloc_anon_folio(vmf);
> + folio = alloc_anon_folio(vmf, pte_range_none);
>   if (IS_ERR(folio))
>   return 0;
>   if (!folio)
> --
> 
> I assume this has checked everything?

Ahh yes, very good. In that case you can disregard what I said; its already covered.

I notice that this series appears as a reply to my series. I'm not sure what the
normal convention is, but I expect more people would see it if you posted it as
its own thread?


> 
>>
>> I'll aim to review the code in the next couple of weeks.
> 
> nice, thanks!
> 
>>
>> Thanks,
>> Ryan
>>
>>> On the other hand, in OPPO's product, we've deployed
>>> anon large folios on millions of phones[2]. we enhanced zsmalloc and zRAM to
>>> compress and decompress large folios as a whole, which help improve compression
>>> ratio and decrease CPU consumption significantly. In zsmalloc and zRAM we can
>>> save large objects whose original size are 64KiB for example. So it is also a
>>> better choice for us to only swap-in large folios for those compressed large
>>> objects as a large folio can be decompressed all together.
>>>
>>> Note I am moving my previous "arm64: mm: swap: support THP_SWAP on hardware
>>> with MTE" to this series as it might help review.
>>>
>>> [1] [PATCH v3 0/4] Swap-out small-sized THP without splitting
>>> https://lore.kernel.org/linux-mm/20231025144546.577640-1-ryan.roberts@arm.com/
>>> [2] OnePlusOSS / android_kernel_oneplus_sm8550
>>> https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/oneplus/sm8550_u_14.0.0_oneplus11
>>>
>>> Barry Song (2):
>>>   arm64: mm: swap: support THP_SWAP on hardware with MTE
>>>   mm: rmap: weaken the WARN_ON in __folio_add_anon_rmap()
>>>
>>> Chuanhua Han (4):
>>>   mm: swap: introduce swap_nr_free() for batched swap_free()
>>>   mm: swap: make should_try_to_free_swap() support large-folio
>>>   mm: support large folios swapin as a whole
>>>   mm: madvise: don't split mTHP for MADV_PAGEOUT
>>>
>>>  arch/arm64/include/asm/pgtable.h |  21 ++----
>>>  arch/arm64/mm/mteswap.c          |  42 ++++++++++++
>>>  include/asm-generic/tlb.h        |  10 +++
>>>  include/linux/huge_mm.h          |  12 ----
>>>  include/linux/pgtable.h          |  62 ++++++++++++++++-
>>>  include/linux/swap.h             |   6 ++
>>>  mm/madvise.c                     |  48 ++++++++++++++
>>>  mm/memory.c                      | 110 ++++++++++++++++++++++++++-----
>>>  mm/page_io.c                     |   2 +-
>>>  mm/rmap.c                        |   5 +-
>>>  mm/swap_slots.c                  |   2 +-
>>>  mm/swapfile.c                    |  29 ++++++++
>>>  12 files changed, 301 insertions(+), 48 deletions(-)
>>>
>>
> 
> Thanks
> Barry


