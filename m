Return-Path: <linux-kernel+bounces-136695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F7C89D72F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C60284616
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEE280BFC;
	Tue,  9 Apr 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZqLh3XD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207064EB3D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659368; cv=none; b=Szj/lakBJb/sThgfEqiDyVrXxlmDR3Lb7KY7qv8oyo6YbNdA2JMXAle4lgO6G+gVzA4v0P8EjObZRIX827cVLzD14sZPOGJ00zyLGW5KnTZ2YhtHevgz/0JIMgGqVygGopEwMPq+6X8Qjndw+qjWAKN0GWXJtGhKWCeyTwysTUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659368; c=relaxed/simple;
	bh=XkrnvfWCw93qAtnkdR9F8cg1QJHqWuyKWijEnpCvLJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxIps1SzeAb53qxI6GRZ9o2hCTGejR9S6Mdx5ifHHaTkNBDJGNUztUs6njEK6DcQSqfgayrS9kS4IyT5JEiUZDNyWm0zB5WT6CObC0r0rVk83BLlI4lpEyBJctewykhKDdhB04Io2XGaJK7CFTbDki0FLv3uUV+JIYu3p73ov4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZqLh3XD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712659364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VXOzD6MLdAZeG2UL81ssnUgyrwyD9xxc8QB1oCbjdu4=;
	b=ZZqLh3XDhHJz1vXkUoXd0Z6VadaHa7qvVPPv+pCpInPPR3kENTwrWn+GsMqZWk+07DcR7B
	5yVBAajjhjJee1HPd8B/TqldE4FIy0KecS1RY3ruO6XPLlOsCcDJDHUouROYvGZ0uQAawn
	wnJwzaTBsV17foEXWOyPb8W2H6PQNxE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-Moi93XBZPEeuSNRdGj2xJw-1; Tue, 09 Apr 2024 06:42:42 -0400
X-MC-Unique: Moi93XBZPEeuSNRdGj2xJw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343e775c794so2076741f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712659361; x=1713264161;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VXOzD6MLdAZeG2UL81ssnUgyrwyD9xxc8QB1oCbjdu4=;
        b=UM/3hBqgcL642TXCSTDhUk4Zz9Ri9CoBXm+S+Hxs4jFDn2UVQ5uEGBcJBAurKM9F1e
         cN6S4XQLUQTnV+zOYZcSp1Cyax1YzOwvj6ySv936wc7pIE4ma293w5C+ouNTD32uebbt
         QueZDBzBN94arlfpm236uqOJ1x5oYUcH12CPMv2+AiqHArgyb8fFjpaFklemZXkTJoHz
         mFW874Go4r8Quo8ziLXPd1AfIIln3P6O10iPxdyeTSj2Ec6PAfnTQeFplPSJy0wgwQw/
         CHgWO8i0PJ9N3UjbgQVkcBbpWJC3ZkaTPDO4waU4bNw/fK5tYlZvsyS4Znqt5+jzM9of
         I2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXk8pakqf6ibSv20UyAdXb1lnX4bOFjksLtyofJpF2bmLqHcMPS1NScFt/tYR3Kt+vXLgtcay/BIbJ9c/7cWR3doFFxw4iZujaoeoGc
X-Gm-Message-State: AOJu0YzlsoH5qvsfEk7wcvn+O6q4kVOyNkqsG5Wg6jCYTOAB3V5docBk
	O4m+UBRN8VvsVOFfOGYo0TeIPNZSttX7hsPbSg0Dqux2qCTpn+6AwT5GDlGp/2aAYkgPxaWtLJT
	2wva9WGmwC4ddEJhIyMlrFhGWWyblIay9v4y5H1KJ+1XZbtV1g35oOSD07eBSSg==
X-Received: by 2002:adf:ea48:0:b0:33e:1e2b:3f76 with SMTP id j8-20020adfea48000000b0033e1e2b3f76mr8091051wrn.61.1712659361199;
        Tue, 09 Apr 2024 03:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSTaNSNoukylIDXb3TZzNp/UhY36WxWaitKpBqKVWjmdMvW4eRRoaTUFLZnmrOsUdaDPQ4fA==
X-Received: by 2002:adf:ea48:0:b0:33e:1e2b:3f76 with SMTP id j8-20020adfea48000000b0033e1e2b3f76mr8091029wrn.61.1712659360719;
        Tue, 09 Apr 2024 03:42:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:be00:a285:bc76:307d:4eaa? (p200300cbc70abe00a285bc76307d4eaa.dip0.t-ipconnect.de. [2003:cb:c70a:be00:a285:bc76:307d:4eaa])
        by smtp.gmail.com with ESMTPSA id p2-20020a056000018200b0034625392416sm1178261wrx.104.2024.04.09.03.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 03:42:40 -0700 (PDT)
Message-ID: <25d2a8ad-aad4-4bd5-bd3e-190b76175f61@redhat.com>
Date: Tue, 9 Apr 2024 12:42:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>,
 Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240408183946.2991168-1-ryan.roberts@arm.com>
 <20240408183946.2991168-3-ryan.roberts@arm.com>
 <CAGsJ_4xMaO8AWMGc4Od-FLWBhhT-u8f7QbR11VsqD0uqH3Kp6g@mail.gmail.com>
 <CAGsJ_4wpu2Nq0y3z7LYjPLJ1ZBi+BNRNKkyUPsXKDAg1POLjLA@mail.gmail.com>
 <44e23a4d-97e7-4d84-848a-f9325b7b76c0@redhat.com>
 <CAGsJ_4wvjVAK+HBDo86xs4zv18QcCNzVRctr1gYMWwtYGNHvDg@mail.gmail.com>
 <b18a5a7b-f787-4be8-a617-e86a56c140e6@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b18a5a7b-f787-4be8-a617-e86a56c140e6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.04.24 11:55, Ryan Roberts wrote:
> On 09/04/2024 10:41, Barry Song wrote:
>> On Tue, Apr 9, 2024 at 9:24 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 09.04.24 11:22, Barry Song wrote:
>>>> On Tue, Apr 9, 2024 at 8:51 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>>
>>>>> On Tue, Apr 9, 2024 at 6:40 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>
>>>>>> Now that we no longer have a convenient flag in the cluster to determine
>>>>>> if a folio is large, free_swap_and_cache() will take a reference and
>>>>>> lock a large folio much more often, which could lead to contention and
>>>>>> (e.g.) failure to split large folios, etc.
>>>>>>
>>>>>> Let's solve that problem by batch freeing swap and cache with a new
>>>>>> function, free_swap_and_cache_nr(), to free a contiguous range of swap
>>>>>> entries together. This allows us to first drop a reference to each swap
>>>>>> slot before we try to release the cache folio. This means we only try to
>>>>>> release the folio once, only taking the reference and lock once - much
>>>>>> better than the previous 512 times for the 2M THP case.
>>>>>>
>>>>>> Contiguous swap entries are gathered in zap_pte_range() and
>>>>>> madvise_free_pte_range() in a similar way to how present ptes are
>>>>>> already gathered in zap_pte_range().
>>>>>>
>>>>>> While we are at it, let's simplify by converting the return type of both
>>>>>> functions to void. The return value was used only by zap_pte_range() to
>>>>>> print a bad pte, and was ignored by everyone else, so the extra
>>>>>> reporting wasn't exactly guaranteed. We will still get the warning with
>>>>>> most of the information from get_swap_device(). With the batch version,
>>>>>> we wouldn't know which pte was bad anyway so could print the wrong one.
>>>>>>
>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>> ---
>>>>>>    include/linux/pgtable.h | 29 ++++++++++++
>>>>>>    include/linux/swap.h    | 12 +++--
>>>>>>    mm/internal.h           | 63 ++++++++++++++++++++++++++
>>>>>>    mm/madvise.c            | 12 +++--
>>>>>>    mm/memory.c             | 13 +++---
>>>>>>    mm/swapfile.c           | 97 +++++++++++++++++++++++++++++++++--------
>>>>>>    6 files changed, 195 insertions(+), 31 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>> index a3fc8150b047..75096025fe52 100644
>>>>>> --- a/include/linux/pgtable.h
>>>>>> +++ b/include/linux/pgtable.h
>>>>>> @@ -708,6 +708,35 @@ static inline void pte_clear_not_present_full(struct mm_struct *mm,
>>>>>>    }
>>>>>>    #endif
>>>>>>
>>>>>> +#ifndef clear_not_present_full_ptes
>>>>>> +/**
>>>>>> + * clear_not_present_full_ptes - Clear multiple not present PTEs which are
>>>>>> + *                              consecutive in the pgtable.
>>>>>> + * @mm: Address space the ptes represent.
>>>>>> + * @addr: Address of the first pte.
>>>>>> + * @ptep: Page table pointer for the first entry.
>>>>>> + * @nr: Number of entries to clear.
>>>>>> + * @full: Whether we are clearing a full mm.
>>>>>> + *
>>>>>> + * May be overridden by the architecture; otherwise, implemented as a simple
>>>>>> + * loop over pte_clear_not_present_full().
>>>>>> + *
>>>>>> + * Context: The caller holds the page table lock.  The PTEs are all not present.
>>>>>> + * The PTEs are all in the same PMD.
>>>>>> + */
>>>>>> +static inline void clear_not_present_full_ptes(struct mm_struct *mm,
>>>>>> +               unsigned long addr, pte_t *ptep, unsigned int nr, int full)
>>>>>> +{
>>>>>> +       for (;;) {
>>>>>> +               pte_clear_not_present_full(mm, addr, ptep, full);
>>>>>> +               if (--nr == 0)
>>>>>> +                       break;
>>>>>> +               ptep++;
>>>>>> +               addr += PAGE_SIZE;
>>>>>> +       }
>>>>>> +}
>>>>>> +#endif
>>>>>> +
>>>>>>    #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
>>>>>>    extern pte_t ptep_clear_flush(struct vm_area_struct *vma,
>>>>>>                                 unsigned long address,
>>>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>>>> index f6f78198f000..5737236dc3ce 100644
>>>>>> --- a/include/linux/swap.h
>>>>>> +++ b/include/linux/swap.h
>>>>>> @@ -471,7 +471,7 @@ extern int swap_duplicate(swp_entry_t);
>>>>>>    extern int swapcache_prepare(swp_entry_t);
>>>>>>    extern void swap_free(swp_entry_t);
>>>>>>    extern void swapcache_free_entries(swp_entry_t *entries, int n);
>>>>>> -extern int free_swap_and_cache(swp_entry_t);
>>>>>> +extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
>>>>>>    int swap_type_of(dev_t device, sector_t offset);
>>>>>>    int find_first_swap(dev_t *device);
>>>>>>    extern unsigned int count_swap_pages(int, int);
>>>>>> @@ -520,8 +520,9 @@ static inline void put_swap_device(struct swap_info_struct *si)
>>>>>>    #define free_pages_and_swap_cache(pages, nr) \
>>>>>>           release_pages((pages), (nr));
>>>>>>
>>>>>> -/* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=0 */
>>>>>> -#define free_swap_and_cache(e) is_pfn_swap_entry(e)
>>>>>> +static inline void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>>>>>> +{
>>>>>> +}
>>>>>>
>>>>>>    static inline void free_swap_cache(struct folio *folio)
>>>>>>    {
>>>>>> @@ -589,6 +590,11 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
>>>>>>    }
>>>>>>    #endif /* CONFIG_SWAP */
>>>>>>
>>>>>> +static inline void free_swap_and_cache(swp_entry_t entry)
>>>>>> +{
>>>>>> +       free_swap_and_cache_nr(entry, 1);
>>>>>> +}
>>>>>> +
>>>>>>    #ifdef CONFIG_MEMCG
>>>>>>    static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
>>>>>>    {
>>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>>> index 3bdc8693b54f..de68705624b0 100644
>>>>>> --- a/mm/internal.h
>>>>>> +++ b/mm/internal.h
>>>>>> @@ -11,6 +11,8 @@
>>>>>>    #include <linux/mm.h>
>>>>>>    #include <linux/pagemap.h>
>>>>>>    #include <linux/rmap.h>
>>>>>> +#include <linux/swap.h>
>>>>>> +#include <linux/swapops.h>
>>>>>>    #include <linux/tracepoint-defs.h>
>>>>>>
>>>>>>    struct folio_batch;
>>>>>> @@ -189,6 +191,67 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>>>>>>
>>>>>>           return min(ptep - start_ptep, max_nr);
>>>>>>    }
>>>>>> +
>>>>>> +/**
>>>>>> + * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
>>>>>> + * @pte: The initial pte state; is_swap_pte(pte) must be true.
>>>>>> + *
>>>>>> + * Increments the swap offset, while maintaining all other fields, including
>>>>>> + * swap type, and any swp pte bits. The resulting pte is returned.
>>>>>> + */
>>>>>> +static inline pte_t pte_next_swp_offset(pte_t pte)
>>>>>> +{
>>>>>> +       swp_entry_t entry = pte_to_swp_entry(pte);
>>>>>> +       pte_t new = __swp_entry_to_pte(__swp_entry(swp_type(entry),
>>>>>> +                                                  swp_offset(entry) + 1));
>>>>>> +
>>>>>> +       if (pte_swp_soft_dirty(pte))
>>>>>> +               new = pte_swp_mksoft_dirty(new);
>>>>>> +       if (pte_swp_exclusive(pte))
>>>>>> +               new = pte_swp_mkexclusive(new);
>>>>>> +       if (pte_swp_uffd_wp(pte))
>>>>>> +               new = pte_swp_mkuffd_wp(new);
>>>>>
>>>>> I don't quite understand this. If this page table entry is exclusive,
>>>>> will its subsequent page table entry also be exclusive without
>>>>> question?
>>>>> in try_to_unmap_one, exclusive is per-subpage but not per-folio:
>>>>>
>>>>>                   anon_exclusive = folio_test_anon(folio) &&
>>>>>                                    PageAnonExclusive(subpage);
>>>>>
>>>>> same questions also for diry, wp etc.
>>>>
>>>> Sorry for the noise. you are right. based on your new version, I think I should
>>>> entirely drop:
>>>>
>>>> [PATCH v2 3/5] mm: swap_pte_batch: add an output argument to reture if
>>>> all swap entries are exclusive
>>>
>>> Yes. If we ever want to ignore some bits, we should likely add flags to
>>> change the behavior, like for folio_pte_batch().
>>>
>>> For swapin, you really want the exclusive bits to match, though.
>>
>> I am not quite sure I definitely need exclusive bits to match. i can either
>> drop my 3/5 or ignore the exclusive bit as below (if anyone is not shared,
>> swpin won't reuse the large folio, but it can still entirely map it read-only):
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index cae39c372bfc..5726e729c9ee 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -253,10 +253,22 @@ static inline int swap_pte_batch(pte_t
>> *start_ptep, int max_nr, pte_t pte,
>>                  *any_shared |= !pte_swp_exclusive(pte);
>>
>>          while (ptep < end_ptep) {
>> +               pte_t ignore_exclusive_pte;
>> +               pte_t ignore_exclusive_expected_pte;
>>                  pte = ptep_get(ptep);
>>
>> -               if (!pte_same(pte, expected_pte))
>> -                       break;
>> +               if (any_shared) {
>> +                       ignore_exclusive_pte = pte;
>> +                       ignore_exclusive_expected_pte = expected_pte;
>> +                       ignore_exclusive_pte =
>> pte_swp_clear_exclusive(ignore_exclusive_pte);
>> +                       ignore_exclusive_expected_pte =
>> pte_swp_clear_exclusive(expected_pte);
>> +
>> +                       if (!pte_same(ignore_exclusive_pte,
>> ignore_exclusive_expected_pte))
>> +                               break;
>> +               } else {
>> +                       if (!pte_same(pte, expected_pte))
>> +                               break;
>> +               }
>>
>>                  if (any_shared)
>>                          *any_shared |= !pte_swp_exclusive(pte);
> 
> I'll leave David to comment on this proposal; I'm not sure I understand all the
> details. The code change does look a bit "busy" though - sometimes that can be
> an indicator :)

I'd prefer to keep it simple initially. Devil is in the detail for the 
refault case: in the past, dropping an exclusive flag could have been 
problematic with some O_DIRECT workloads that were not using FOLL_PIN. 
IIUC, some still remain.

More details can be had from 
https://lore.kernel.org/all/20230113171026.582290-1-david@redhat.com/


It might all change a bit if I manage to get folio_test_anon_exclusive() 
flying. The current plan is that all individual swp PTEs would still 
have pte_swp_exclusive() set, and we would *not* clear the 
folio_test_anon_exclusive() flag while the folio is still in the 
swapcache [which we do today to make fork() handling easier].

That will make refault significantly easier to handle regarding 
exclusivity handling with large folios.

-- 
Cheers,

David / dhildenb


