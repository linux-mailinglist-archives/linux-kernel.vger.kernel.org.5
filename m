Return-Path: <linux-kernel+bounces-136551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4348A89D57A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBAC284C61
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D6D7FBDF;
	Tue,  9 Apr 2024 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUiWR0pM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E577FBB0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654701; cv=none; b=LfN7XVozvTJdiNZR5qNF3JARgvjFVelCpalrJOgv78SiOTMMDbKhEXvxrM5NdcTOnAI0YVJIVdH1MzEeROu8qs4CoTdeA7ppYN6gv0VdLoGn8aw1OkslRwg0PscBQ1WQoA8VTfioQdOCakOlHpcPS4iSbrD5deugbyrJdVOo8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654701; c=relaxed/simple;
	bh=M1QqA58M1M2M9eEzG3ltVZ6HKnwfesSaXf5W3wRZ5Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvQoLnBw/kIJBvPnrEQcmReZ7Xe8HEk/8BStHyV4qxHaAlbV5Aq33VCJ2zuHvo1oi6KEdAv/nyVahUCSq59SNDwJt9m0n0hFW9Mnv+/TW4TKs0I3xmvT9LiblxM2xnbm2BOAfQYFmsbmtU2+E/1bua3LNB+kAmK4SREhhL2m1XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUiWR0pM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712654698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/okR9rpbpzeXAqNCBO5VwYD3JhIXUF7Gq9tuXdmOn7g=;
	b=YUiWR0pMHJ6o+SaCc9OqlJCXQecW2pBmgq9JzXB+2qORUY2V5tb1KhKbBNJZWFZEnyz1Mb
	vMTZinSNERwGiSYCkcMT9X2LJAr7SsWowmrM/jeekaHoh2cp+jdseAfsKJttxvCOYC6bz5
	HKiarLBoYmC8d067+ESg+s+zfprKY74=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-0sN2hy3zMOGDG6fiTBpwQQ-1; Tue, 09 Apr 2024 05:24:56 -0400
X-MC-Unique: 0sN2hy3zMOGDG6fiTBpwQQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-416b3409164so861635e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712654696; x=1713259496;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/okR9rpbpzeXAqNCBO5VwYD3JhIXUF7Gq9tuXdmOn7g=;
        b=jRt4FtpsjiJHSWMM5SshqdmwutAlbk1vp6bEUMzk6GuDlviAhiSsNNfDe9hr5FM1Pm
         qAeIN5nAT/5WjOrr6V53iuVtkdicfD+iqvLGctrumFnqE+BU06oBffvdQ161KK++MvIi
         ZwYNjwrD0zwOdcHLrphlotUJaBCzbsX3F0vXf21XA37QeVCz2ymwXVhm7fkEpDXJaQ5C
         6mVjrpVLBviOJDl0AXOwmuO68IfdHJHjuYU0n1SxMP14SUEJoo4xoP2QxoPSF1VGyJok
         AOaXL7tyjG/ohFtWYj2MTy2L6SQDV39ENglHSWJXeRWAR1OIPhW2rEXkhsUKRZ4ujcyZ
         FmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOiJoRqZ++31nVkxmu7mEYlYJrbbE9za9RslC8+hltREkSYk8K3OBVie2IRWhWx0Xe2HkqKbVNh/eYD/fgNAh3cW9rJ2McTJSd/s5B
X-Gm-Message-State: AOJu0YxTL6T+zNa2huLImA1B/RqY08Uebn+QGpG/YrKWc1+LLJ9RnLiE
	EhLjqyBGo8d+lTBIqqhZX+iMt/h6oEIUmJTJ93r8W5C3M7WH95jaZs28csPHpwyNodRVRdvHYQh
	gMwANRN9ATCTxihu1pAY8DO5kOfJW6X/jisbwbLU28qxRvf88kOSHn99Lqs5wGQ==
X-Received: by 2002:a05:600c:4505:b0:414:22e:1761 with SMTP id t5-20020a05600c450500b00414022e1761mr8003618wmo.16.1712654695633;
        Tue, 09 Apr 2024 02:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUOslcXQbtIvT5Ov24AsfuqYxkkP3X08eqFbplh4Jw409YR6hjDmpWJiRssTpWkrZB8YvNpg==
X-Received: by 2002:a05:600c:4505:b0:414:22e:1761 with SMTP id t5-20020a05600c450500b00414022e1761mr8003600wmo.16.1712654695190;
        Tue, 09 Apr 2024 02:24:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:be00:a285:bc76:307d:4eaa? (p200300cbc70abe00a285bc76307d4eaa.dip0.t-ipconnect.de. [2003:cb:c70a:be00:a285:bc76:307d:4eaa])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b00416b035c2d8sm969514wmo.3.2024.04.09.02.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 02:24:54 -0700 (PDT)
Message-ID: <44e23a4d-97e7-4d84-848a-f9325b7b76c0@redhat.com>
Date: Tue, 9 Apr 2024 11:24:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
To: Barry Song <21cnbao@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4wpu2Nq0y3z7LYjPLJ1ZBi+BNRNKkyUPsXKDAg1POLjLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.04.24 11:22, Barry Song wrote:
> On Tue, Apr 9, 2024 at 8:51 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Tue, Apr 9, 2024 at 6:40 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> Now that we no longer have a convenient flag in the cluster to determine
>>> if a folio is large, free_swap_and_cache() will take a reference and
>>> lock a large folio much more often, which could lead to contention and
>>> (e.g.) failure to split large folios, etc.
>>>
>>> Let's solve that problem by batch freeing swap and cache with a new
>>> function, free_swap_and_cache_nr(), to free a contiguous range of swap
>>> entries together. This allows us to first drop a reference to each swap
>>> slot before we try to release the cache folio. This means we only try to
>>> release the folio once, only taking the reference and lock once - much
>>> better than the previous 512 times for the 2M THP case.
>>>
>>> Contiguous swap entries are gathered in zap_pte_range() and
>>> madvise_free_pte_range() in a similar way to how present ptes are
>>> already gathered in zap_pte_range().
>>>
>>> While we are at it, let's simplify by converting the return type of both
>>> functions to void. The return value was used only by zap_pte_range() to
>>> print a bad pte, and was ignored by everyone else, so the extra
>>> reporting wasn't exactly guaranteed. We will still get the warning with
>>> most of the information from get_swap_device(). With the batch version,
>>> we wouldn't know which pte was bad anyway so could print the wrong one.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>   include/linux/pgtable.h | 29 ++++++++++++
>>>   include/linux/swap.h    | 12 +++--
>>>   mm/internal.h           | 63 ++++++++++++++++++++++++++
>>>   mm/madvise.c            | 12 +++--
>>>   mm/memory.c             | 13 +++---
>>>   mm/swapfile.c           | 97 +++++++++++++++++++++++++++++++++--------
>>>   6 files changed, 195 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index a3fc8150b047..75096025fe52 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -708,6 +708,35 @@ static inline void pte_clear_not_present_full(struct mm_struct *mm,
>>>   }
>>>   #endif
>>>
>>> +#ifndef clear_not_present_full_ptes
>>> +/**
>>> + * clear_not_present_full_ptes - Clear multiple not present PTEs which are
>>> + *                              consecutive in the pgtable.
>>> + * @mm: Address space the ptes represent.
>>> + * @addr: Address of the first pte.
>>> + * @ptep: Page table pointer for the first entry.
>>> + * @nr: Number of entries to clear.
>>> + * @full: Whether we are clearing a full mm.
>>> + *
>>> + * May be overridden by the architecture; otherwise, implemented as a simple
>>> + * loop over pte_clear_not_present_full().
>>> + *
>>> + * Context: The caller holds the page table lock.  The PTEs are all not present.
>>> + * The PTEs are all in the same PMD.
>>> + */
>>> +static inline void clear_not_present_full_ptes(struct mm_struct *mm,
>>> +               unsigned long addr, pte_t *ptep, unsigned int nr, int full)
>>> +{
>>> +       for (;;) {
>>> +               pte_clear_not_present_full(mm, addr, ptep, full);
>>> +               if (--nr == 0)
>>> +                       break;
>>> +               ptep++;
>>> +               addr += PAGE_SIZE;
>>> +       }
>>> +}
>>> +#endif
>>> +
>>>   #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
>>>   extern pte_t ptep_clear_flush(struct vm_area_struct *vma,
>>>                                unsigned long address,
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index f6f78198f000..5737236dc3ce 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -471,7 +471,7 @@ extern int swap_duplicate(swp_entry_t);
>>>   extern int swapcache_prepare(swp_entry_t);
>>>   extern void swap_free(swp_entry_t);
>>>   extern void swapcache_free_entries(swp_entry_t *entries, int n);
>>> -extern int free_swap_and_cache(swp_entry_t);
>>> +extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
>>>   int swap_type_of(dev_t device, sector_t offset);
>>>   int find_first_swap(dev_t *device);
>>>   extern unsigned int count_swap_pages(int, int);
>>> @@ -520,8 +520,9 @@ static inline void put_swap_device(struct swap_info_struct *si)
>>>   #define free_pages_and_swap_cache(pages, nr) \
>>>          release_pages((pages), (nr));
>>>
>>> -/* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=0 */
>>> -#define free_swap_and_cache(e) is_pfn_swap_entry(e)
>>> +static inline void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>>> +{
>>> +}
>>>
>>>   static inline void free_swap_cache(struct folio *folio)
>>>   {
>>> @@ -589,6 +590,11 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
>>>   }
>>>   #endif /* CONFIG_SWAP */
>>>
>>> +static inline void free_swap_and_cache(swp_entry_t entry)
>>> +{
>>> +       free_swap_and_cache_nr(entry, 1);
>>> +}
>>> +
>>>   #ifdef CONFIG_MEMCG
>>>   static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
>>>   {
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 3bdc8693b54f..de68705624b0 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -11,6 +11,8 @@
>>>   #include <linux/mm.h>
>>>   #include <linux/pagemap.h>
>>>   #include <linux/rmap.h>
>>> +#include <linux/swap.h>
>>> +#include <linux/swapops.h>
>>>   #include <linux/tracepoint-defs.h>
>>>
>>>   struct folio_batch;
>>> @@ -189,6 +191,67 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>>>
>>>          return min(ptep - start_ptep, max_nr);
>>>   }
>>> +
>>> +/**
>>> + * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
>>> + * @pte: The initial pte state; is_swap_pte(pte) must be true.
>>> + *
>>> + * Increments the swap offset, while maintaining all other fields, including
>>> + * swap type, and any swp pte bits. The resulting pte is returned.
>>> + */
>>> +static inline pte_t pte_next_swp_offset(pte_t pte)
>>> +{
>>> +       swp_entry_t entry = pte_to_swp_entry(pte);
>>> +       pte_t new = __swp_entry_to_pte(__swp_entry(swp_type(entry),
>>> +                                                  swp_offset(entry) + 1));
>>> +
>>> +       if (pte_swp_soft_dirty(pte))
>>> +               new = pte_swp_mksoft_dirty(new);
>>> +       if (pte_swp_exclusive(pte))
>>> +               new = pte_swp_mkexclusive(new);
>>> +       if (pte_swp_uffd_wp(pte))
>>> +               new = pte_swp_mkuffd_wp(new);
>>
>> I don't quite understand this. If this page table entry is exclusive,
>> will its subsequent page table entry also be exclusive without
>> question?
>> in try_to_unmap_one, exclusive is per-subpage but not per-folio:
>>
>>                  anon_exclusive = folio_test_anon(folio) &&
>>                                   PageAnonExclusive(subpage);
>>
>> same questions also for diry, wp etc.
> 
> Sorry for the noise. you are right. based on your new version, I think I should
> entirely drop:
> 
> [PATCH v2 3/5] mm: swap_pte_batch: add an output argument to reture if
> all swap entries are exclusive

Yes. If we ever want to ignore some bits, we should likely add flags to 
change the behavior, like for folio_pte_batch().

For swapin, you really want the exclusive bits to match, though. 
softdirty and uffd-wp as well at least initially for simplicity.

-- 
Cheers,

David / dhildenb


