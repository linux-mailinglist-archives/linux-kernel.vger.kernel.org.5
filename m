Return-Path: <linux-kernel+bounces-91948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C458718DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46951F2302B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9FF52F68;
	Tue,  5 Mar 2024 09:01:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0844F890
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629260; cv=none; b=A5Y2Tv0hT2TSRPakyQWluGRxgHCK72WL915Yhok5il2cwXO01cr6DWLCMZ9p3rHeelu1YUkmXDR6b4+d8IXoeDu6ZlCuu5aDDlQwpLXxtnS+h2xbQMw+HpuRI9unNbp7Mg6rXYmab7j34S0NvdPb2h4n+KUIr7q5IYAekRyrFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629260; c=relaxed/simple;
	bh=fDEJlWEglnqvvSd0pGxsfGxm1zICSLOBshiHfoVcZIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/Tuxw0/a46VwtVV4g8kpxIswL4GbBWGe9+NHPN/49quMKv9kojJZa06eO106tR406aQevBBdpe6BICZiD8AQpzvdHLFXAee/A4vm87j81oCXtqhyw0Y+PtfL+cJSjhw06OoTWPMVaKJc+4ubIX0qPXCQpoTYCju8zXUKaXckUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0521E1FB;
	Tue,  5 Mar 2024 01:01:35 -0800 (PST)
Received: from [10.57.68.162] (unknown [10.57.68.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 269AC3F762;
	Tue,  5 Mar 2024 01:00:56 -0800 (PST)
Message-ID: <7061b9f4-b7aa-4dad-858c-53ee186c2d8f@arm.com>
Date: Tue, 5 Mar 2024 09:00:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without
 splitting
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org,
 xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com,
 chrisl@kernel.org, surenb@google.com, hanchuanhua@oppo.com
References: <20231025144546.577640-5-ryan.roberts@arm.com>
 <20240205095155.7151-1-v-songbaohua@oppo.com>
 <d4f602db-403b-4b1f-a3de-affeb40bc499@arm.com>
 <CAGsJ_4wo7BiJWSKb1K_WyAai30KmfckMQ3-mCJPXZ892CtXpyQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wo7BiJWSKb1K_WyAai30KmfckMQ3-mCJPXZ892CtXpyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Barry,

On 18/02/2024 23:40, Barry Song wrote:
> On Tue, Feb 6, 2024 at 1:14 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 05/02/2024 09:51, Barry Song wrote:
>>> +Chris, Suren and Chuanhua
>>>
>>> Hi Ryan,
[...]
>>
> 
> Hi Ryan,
> I am running into some races especially while enabling large folio swap-out and
> swap-in both. some of them, i am still struggling with the detailed
> timing how they
> are happening.
> but the below change can help remove those bugs which cause corrupted data.

I'm getting quite confused with all the emails flying around on this topic. Here
you were reporting a data corruption bug and your suggested fix below is the one
you have now posted at [1]. But in the thread at [1] we concluded that it is not
fixing a functional correctness issue, but is just an optimization in some
corner cases. So does the corruption issue still manifest? Did you manage to
root cause it? Is it a problem with my swap-out series or your swap-in series,
or pre-existing?

[1] https://lore.kernel.org/linux-mm/20240304103757.235352-1-21cnbao@gmail.com/

Thanks,
Ryan

> 
> index da2aab219c40..ef9cfbc84760 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1953,6 +1953,16 @@ static unsigned int shrink_folio_list(struct
> list_head *folio_list,
> 
>                         if (folio_test_pmd_mappable(folio))
>                                 flags |= TTU_SPLIT_HUGE_PMD;
> +                       /*
> +                        * make try_to_unmap_one hold ptl from the very first
> +                        * beginning if we are reclaiming a folio with multi-
> +                        * ptes. otherwise, we may only reclaim a part of the
> +                        * folio from the middle.
> +                        * for example, a parallel thread might temporarily
> +                        * set pte to none for various purposes.
> +                        */
> +                       else if (folio_test_large(folio))
> +                               flags |= TTU_SYNC;
> 
>                         try_to_unmap(folio, flags);
>                         if (folio_mapped(folio)) {
> 
> 
> While we are swapping-out a large folio, it has many ptes, we change those ptes
> to swap entries in try_to_unmap_one(). "while (page_vma_mapped_walk(&pvmw))"
> will iterate all ptes within the large folio. but it will only begin
> to acquire ptl when
> it meets a valid pte as below /* xxxxxxx */
> 
> static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
> {
>         pte_t ptent;
> 
>         if (pvmw->flags & PVMW_SYNC) {
>                 /* Use the stricter lookup */
>                 pvmw->pte = pte_offset_map_lock(pvmw->vma->vm_mm, pvmw->pmd,
>                                                 pvmw->address, &pvmw->ptl);
>                 *ptlp = pvmw->ptl;
>                 return !!pvmw->pte;
>         }
> 
>        ...
>         pvmw->pte = pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
>                                           pvmw->address, ptlp);
>         if (!pvmw->pte)
>                 return false;
> 
>         ptent = ptep_get(pvmw->pte);
> 
>         if (pvmw->flags & PVMW_MIGRATION) {
>                 if (!is_swap_pte(ptent))
>                         return false;
>         } else if (is_swap_pte(ptent)) {
>                 swp_entry_t entry;
>                 ...
>                 entry = pte_to_swp_entry(ptent);
>                 if (!is_device_private_entry(entry) &&
>                     !is_device_exclusive_entry(entry))
>                         return false;
>         } else if (!pte_present(ptent)) {
>                 return false;
>         }
>         pvmw->ptl = *ptlp;
>         spin_lock(pvmw->ptl);   /* xxxxxxx */
>         return true;
> }
> 
> 
> for various reasons,  for example, break-before-make for clearing access flags
> etc. pte can be set to none. since page_vma_mapped_walk() doesn't hold ptl
> from the beginning,  it might only begin to set swap entries from the middle of
> a large folio.
> 
> For example, in case a large folio has 16 ptes, and 0,1,2 are somehow zero
> in the intermediate stage of a break-before-make, ptl will be held
> from the 3rd pte,
> and swap entries will be set from 3rd pte as well. it seems not good as we are
> trying to swap out a large folio, but we are swapping out a part of them.
> 
> I am still struggling with all the timing of races, but using PVMW_SYNC to
> explicitly ask for ptl from the first pte seems a good thing for large folio
> regardless of those races. it can avoid try_to_unmap_one reading intermediate
> pte and further make the wrong decision since reclaiming pte-mapped large
> folios is atomic with just one pte.
> 
>> Sorry I haven't progressed this series as I had hoped. I've been concentrating
>> on getting the contpte series upstream. I'm hoping I will find some time to move
>> this series along by the tail end of Feb (hoping to get it in shape for v6.10).
>> Hopefully that doesn't cause you any big problems?
> 
> no worries. Anyway, we are already using your code to run various tests.
> 
>>
>> Thanks,
>> Ryan
> 
> Thanks
> Barry


