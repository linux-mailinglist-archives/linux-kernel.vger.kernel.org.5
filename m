Return-Path: <linux-kernel+bounces-132553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44025899688
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D911F23126
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3230374FB;
	Fri,  5 Apr 2024 07:28:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0593364DC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302120; cv=none; b=BWLMxcWkpK3C3jUh6pM5quQ0Rrl1ZPXxzoQDK4+U0N7mOKAqS9trkbqem6FV3x9GtftFczztpyyKQIEWUUd0Rtg0VETWY5XWaC21HD0Maxl8wKeCI+joaITx9lNQ8T2SMw4SbL+M/03ZYq1vqyC2UfZw34uIRUFiEsgjW8eMGEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302120; c=relaxed/simple;
	bh=zXc2i91m7R0P3k+hNS8YJnf23kPjKJkHxZGDn3whrac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMFV89+TLZYmhrHTnUhxqnzkiq4hYniKilc7BPdkSlc4VgqzAOF3nOSv9vFIEhWrKTgRjI01f33IUxqKsSt6Nj/b6BWwOtqYvqhlzB8aQTr1+3Z2ffwITmUP2tz78178Frldqo5nuo6jnxwKbM8q3v7t4rBINKnTn8+/8037fpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFAA6FEC;
	Fri,  5 Apr 2024 00:29:06 -0700 (PDT)
Received: from [10.57.74.169] (unknown [10.57.74.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4183D3F64C;
	Fri,  5 Apr 2024 00:28:34 -0700 (PDT)
Message-ID: <9ce0ee64-d3b1-4da2-bec9-36fb3a8191d1@arm.com>
Date: Fri, 5 Apr 2024 08:28:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] mm: vmscan: Avoid split during shrink_folio_list()
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>
References: <20240327144537.4165578-1-ryan.roberts@arm.com>
 <20240327144537.4165578-6-ryan.roberts@arm.com>
 <CAGsJ_4x40DxoukgRuEt3OKP7dESj3w+HXz=dHYR+PH8LjtCnEA@mail.gmail.com>
 <63c9caf4-3af4-4149-b3c2-e677788cb11f@arm.com>
 <CAGsJ_4xocWy7PyHbgWhaK1gQeHADMAng3cFtnPHFW4MGB7qkBA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4xocWy7PyHbgWhaK1gQeHADMAng3cFtnPHFW4MGB7qkBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/04/2024 05:06, Barry Song wrote:
> On Wed, Apr 3, 2024 at 2:10 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 28/03/2024 08:18, Barry Song wrote:
>>> On Thu, Mar 28, 2024 at 3:45 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> Now that swap supports storing all mTHP sizes, avoid splitting large
>>>> folios before swap-out. This benefits performance of the swap-out path
>>>> by eliding split_folio_to_list(), which is expensive, and also sets us
>>>> up for swapping in large folios in a future series.
>>>>
>>>> If the folio is partially mapped, we continue to split it since we want
>>>> to avoid the extra IO overhead and storage of writing out pages
>>>> uneccessarily.
>>>>
>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  mm/vmscan.c | 9 +++++----
>>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index 00adaf1cb2c3..293120fe54f3 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -1223,11 +1223,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>>>                                         if (!can_split_folio(folio, NULL))
>>>>                                                 goto activate_locked;
>>>>                                         /*
>>>> -                                        * Split folios without a PMD map right
>>>> -                                        * away. Chances are some or all of the
>>>> -                                        * tail pages can be freed without IO.
>>>> +                                        * Split partially mapped folios right
>>>> +                                        * away. We can free the unmapped pages
>>>> +                                        * without IO.
>>>>                                          */
>>>> -                                       if (!folio_entire_mapcount(folio) &&
>>>> +                                       if (data_race(!list_empty(
>>>> +                                               &folio->_deferred_list)) &&
>>>>                                             split_folio_to_list(folio,
>>>>                                                                 folio_list))
>>>>                                                 goto activate_locked;
>>>
>>> Hi Ryan,
>>>
>>> Sorry for bringing up another minor issue at this late stage.
>>
>> No problem - I'd rather take a bit longer and get it right, rather than rush it
>> and get it wrong!
>>
>>>
>>> During the debugging of thp counter patch v2, I noticed the discrepancy between
>>> THP_SWPOUT_FALLBACK and THP_SWPOUT.
>>>
>>> Should we make adjustments to the counter?
>>
>> Yes, agreed; we want to be consistent here with all the other existing THP
>> counters; they only refer to PMD-sized THP. I'll make the change for the next
>> version.
>>
>> I guess we will eventually want equivalent counters for per-size mTHP using the
>> framework you are adding.
> 
> Hi Ryan,
> 
> Today, I created counters for per-order SWPOUT and SWPOUT_FALLBACK.
> I'd appreciate any
> suggestions you might have before I submit this as patch 2/2 of my
> mTHP counters series.

Amazing - this is going to be very useful!

> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index cc13fa14aa32..762a6d8759b9 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -267,6 +267,8 @@ unsigned long thp_vma_allowable_orders(struct
> vm_area_struct *vma,
>  enum thp_stat_item {
>         THP_STAT_ANON_ALLOC,
>         THP_STAT_ANON_ALLOC_FALLBACK,
> +       THP_STAT_ANON_SWPOUT,
> +       THP_STAT_ANON_SWPOUT_FALLBACK,
>         __THP_STAT_COUNT
>  };
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e704b4408181..7f2b5d2852cc 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -554,10 +554,14 @@ static struct kobj_attribute _name##_attr =
> __ATTR_RO(_name)
> 
>  THP_STATE_ATTR(anon_alloc, THP_STAT_ANON_ALLOC);
>  THP_STATE_ATTR(anon_alloc_fallback, THP_STAT_ANON_ALLOC_FALLBACK);
> +THP_STATE_ATTR(anon_swpout, THP_STAT_ANON_SWPOUT);
> +THP_STATE_ATTR(anon_swpout_fallback, THP_STAT_ANON_SWPOUT_FALLBACK);
> 
>  static struct attribute *stats_attrs[] = {
>         &anon_alloc_attr.attr,
>         &anon_alloc_fallback_attr.attr,
> +       &anon_swpout_attr.attr,
> +       &anon_swpout_fallback_attr.attr,
>         NULL,
>  };
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a9a7c236aecc..be4f822b39f8 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -212,13 +212,16 @@ int swap_writepage(struct page *page, struct
> writeback_control *wbc)
> 
>  static inline void count_swpout_vm_event(struct folio *folio)
>  {
> +       long nr_pages = folio_nr_pages(folio);
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         if (unlikely(folio_test_pmd_mappable(folio))) {
>                 count_memcg_folio_events(folio, THP_SWPOUT, 1);
>                 count_vm_event(THP_SWPOUT);
>         }
> +       if (nr_pages > 0 && nr_pages <= HPAGE_PMD_NR)

The guard is a bit ugly; I wonder if we should at least check that order is in
bounds in count_thp_state(), since all callers could benefit? Then we only have
to care about the nr_pages > 0 condition here. Just a thought...

> +               count_thp_state(folio_order(folio), THP_STAT_ANON_SWPOUT);

So you're counting THPs, not pages; I agree with that approach.

>  #endif
> -       count_vm_events(PSWPOUT, folio_nr_pages(folio));
> +       count_vm_events(PSWPOUT, nr_pages);
>  }
> 
>  #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ffc4553c8615..b7c5fbd830b6 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1247,6 +1247,10 @@ static unsigned int shrink_folio_list(struct
> list_head *folio_list,
>                                                 count_vm_event(
>                                                         THP_SWPOUT_FALLBACK);
>                                         }
> +                                       if (nr_pages > 0 && nr_pages
> <= HPAGE_PMD_NR)
> +
> count_thp_state(folio_order(folio),
> +
> THP_STAT_ANON_SWPOUT_FALLBACK);
> +
>  #endif
>                                         if (!add_to_swap(folio))
>                                                 goto activate_locked_split;
> 
> 
> Thanks
> Barry


