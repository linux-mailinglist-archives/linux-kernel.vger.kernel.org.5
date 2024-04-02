Return-Path: <linux-kernel+bounces-128006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE478954D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDE328A2B9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0740823DD;
	Tue,  2 Apr 2024 13:10:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC9B60DE9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063417; cv=none; b=IOGITJuCxLhKp5I6NpqpPyZ/nnY1wtWqaGSrAHSmJAaIwOPP3mNRO3lR0oxFnjJKJ45oz3i+VUFR5/ht4dedYYdeIG6T3RLCWdzcu6MOs1vnVn4FuelSv6TX6/CKNr/vws3szGvSbnBmlXir7b+cxZlRekkiA3cNfJYOS3R4pf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063417; c=relaxed/simple;
	bh=qtEQ3MiIWlNA/svBFqI/OqRqEvqh/7xngg+Uzjxi2vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuMXU7hRKdsIIGpgIgVk5rpslmpIMfQwbZSFzhqpVk1f8rUFooPCCKZTumADconhopg4U4m112t0Whm1t8qD0ladjGmtJQKaXpfn5LXN+hyCEqCc+C5766HV6L8K3JFI9BYFD8uLV1jjCAEz3FY526cgMbwtD25ssJK/6zjfVH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DCF21007;
	Tue,  2 Apr 2024 06:10:45 -0700 (PDT)
Received: from [10.1.38.163] (XHFQ2J9959.cambridge.arm.com [10.1.38.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3A383F766;
	Tue,  2 Apr 2024 06:10:10 -0700 (PDT)
Message-ID: <63c9caf4-3af4-4149-b3c2-e677788cb11f@arm.com>
Date: Tue, 2 Apr 2024 14:10:09 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4x40DxoukgRuEt3OKP7dESj3w+HXz=dHYR+PH8LjtCnEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/03/2024 08:18, Barry Song wrote:
> On Thu, Mar 28, 2024 at 3:45 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Now that swap supports storing all mTHP sizes, avoid splitting large
>> folios before swap-out. This benefits performance of the swap-out path
>> by eliding split_folio_to_list(), which is expensive, and also sets us
>> up for swapping in large folios in a future series.
>>
>> If the folio is partially mapped, we continue to split it since we want
>> to avoid the extra IO overhead and storage of writing out pages
>> uneccessarily.
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  mm/vmscan.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 00adaf1cb2c3..293120fe54f3 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1223,11 +1223,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>                                         if (!can_split_folio(folio, NULL))
>>                                                 goto activate_locked;
>>                                         /*
>> -                                        * Split folios without a PMD map right
>> -                                        * away. Chances are some or all of the
>> -                                        * tail pages can be freed without IO.
>> +                                        * Split partially mapped folios right
>> +                                        * away. We can free the unmapped pages
>> +                                        * without IO.
>>                                          */
>> -                                       if (!folio_entire_mapcount(folio) &&
>> +                                       if (data_race(!list_empty(
>> +                                               &folio->_deferred_list)) &&
>>                                             split_folio_to_list(folio,
>>                                                                 folio_list))
>>                                                 goto activate_locked;
> 
> Hi Ryan,
> 
> Sorry for bringing up another minor issue at this late stage.

No problem - I'd rather take a bit longer and get it right, rather than rush it
and get it wrong!

> 
> During the debugging of thp counter patch v2, I noticed the discrepancy between
> THP_SWPOUT_FALLBACK and THP_SWPOUT.
> 
> Should we make adjustments to the counter?

Yes, agreed; we want to be consistent here with all the other existing THP
counters; they only refer to PMD-sized THP. I'll make the change for the next
version.

I guess we will eventually want equivalent counters for per-size mTHP using the
framework you are adding.

> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 293120fe54f3..d7856603f689 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1241,8 +1241,10 @@ static unsigned int shrink_folio_list(struct
> list_head *folio_list,
>                                                                 folio_list))
>                                                 goto activate_locked;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -
> count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
> -                                       count_vm_event(THP_SWPOUT_FALLBACK);
> +                                       if (folio_test_pmd_mappable(folio)) {
> +
> count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
> +
> count_vm_event(THP_SWPOUT_FALLBACK);
> +                                       }
>  #endif
>                                         if (!add_to_swap(folio))
>                                                 goto activate_locked_split;
> 
> 
> Because THP_SWPOUT is only for pmd:
> 
> static inline void count_swpout_vm_event(struct folio *folio)
> {
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         if (unlikely(folio_test_pmd_mappable(folio))) {
>                 count_memcg_folio_events(folio, THP_SWPOUT, 1);
>                 count_vm_event(THP_SWPOUT);
>         }
> #endif
>         count_vm_events(PSWPOUT, folio_nr_pages(folio));
> }
> 
> I can provide per-order counters for this in my THP counter patch.
> 
>> --
>> 2.25.1
>>
> 
> Thanks
> Barry


