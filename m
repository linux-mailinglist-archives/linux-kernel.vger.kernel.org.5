Return-Path: <linux-kernel+bounces-135171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4006B89BC24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CBF1C21946
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E110E4A9B0;
	Mon,  8 Apr 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbNXq6J0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3896482E6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569395; cv=none; b=IKY7tD4rtO0RZYVsA9W5wcm8iEHMtTJ51XBPwWZ1wXPzHhlVW1BYjK4NwcfGFmGIGG/8W038QkGchx8BpD63dCDjsqpmwy4dBQJ7S/SxM8/VGq0Jjd7JzKRA9RvHGobXbBE9naDXhQjqHUnFGIF7hKZrgX7ZfbPlm4QgWqcJXSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569395; c=relaxed/simple;
	bh=udf6g1jEAfrNsPoOI1GPqWvk2brHOLEviiHyA7ph0PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eapnw+fHRJl00vQqLKsZ4JEtuEXBV9Tt96N8Oknju2QrsTsoQv4/xmnTIlLNphorblTitK6bTC/hJznFDLT1BBQc6GBGdlfV9HyZRVohdH2qZb4uSJJL1beFA/kL4sCSeEYxtvwOIdvK+Z1Bmp5oHU1IgeOIgcjed99fII12H/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbNXq6J0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712569392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oDKVP4tSy5mA1Zy7wlGp9bJFSTqUjr7hFSZJjvoIP7E=;
	b=VbNXq6J05lAAq/QNr8gZfpKU7pInCYYLK7MnHzBqEvqUWrrGwcd0/0Lsrs9a7b7YLZ8x8+
	p/EK5VajcGpJQMEdk4VbkhXUeql+YHtBfbnigSVi/SMvDixzdmYdQlJ1orc/Wsgpcczaip
	YS9dOiA7nGJtsIElifzTZ6FidJ1c8vM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-1vIVd1KPNW2rogyJI9i53Q-1; Mon, 08 Apr 2024 05:43:10 -0400
X-MC-Unique: 1vIVd1KPNW2rogyJI9i53Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4166b96002dso3377575e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712569389; x=1713174189;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oDKVP4tSy5mA1Zy7wlGp9bJFSTqUjr7hFSZJjvoIP7E=;
        b=R2htlSgxNp8kuJOPOwW4kY5bb6qXddvE69T5DwDNVlZhVzYfYbpfSEHAYMXQElgVd/
         o+jpQuv3yutTgygjdf6tYYDGqj6qiSb2+LNnt5jd4DfNuWp4OT4qKNBUfqYBc73qf3wb
         YKqb26cO8fSHepM2Yo/bam+MG4dMJLVD2T4vHkX4BuuakippHU03Fm01TyadrL1Evs3I
         XvwGCLB0jFngc+pT/fpt1VCAjoh601n72FhyCvI7yNbjc0yWFQ+MVNGS8S6aIZY4VrEM
         dICS8ZZmqAk6osTFzAo8BadfufD2xQpNJBuHrPLISWNq6B04Rfy7SxzvS3MdkKXNs4RH
         wriA==
X-Forwarded-Encrypted: i=1; AJvYcCWkmDz3p0k62tSzpffXhlU93tfnTIDcikguBqHbESjk9Iz+Rfz6FcXvyDCNpy8o2vHzTO5tGwbYQ8wX8USEujGmD71MKnX0fW6I/3Au
X-Gm-Message-State: AOJu0YzT/A/bNm7kp/NHTI88wFy0nDp3JsG2Rf5osJNU7H+Y7aSJsKkg
	Df7dZL5X3RsQf0YnEc+G0HXlqCK+eTM7KQZqxl9JvXQr4VXzvTWns521+nV2LJCw29Gg/U/tRZo
	QSRNTg9nKVFKC/F9zRX61gbJEb1Tj3gUCKv/gvZtVob0iES5/XBlKKSr6dQNVNg==
X-Received: by 2002:a05:600c:4f4d:b0:416:6c39:5a9d with SMTP id m13-20020a05600c4f4d00b004166c395a9dmr1866986wmq.39.1712569389597;
        Mon, 08 Apr 2024 02:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfRwQ0XRB019oNyTQm1aZBBOCEBpP9yFi4ws4kW+mjxRQGoz3WHgi76X4dCSvtCg2EvkZqbg==
X-Received: by 2002:a05:600c:4f4d:b0:416:6c39:5a9d with SMTP id m13-20020a05600c4f4d00b004166c395a9dmr1866962wmq.39.1712569389129;
        Mon, 08 Apr 2024 02:43:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:1300:9860:66a2:fe4d:c379? (p200300cbc7181300986066a2fe4dc379.dip0.t-ipconnect.de. [2003:cb:c718:1300:9860:66a2:fe4d:c379])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b004162a9f03a6sm15928122wmb.7.2024.04.08.02.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 02:43:08 -0700 (PDT)
Message-ID: <7d3d3c58-1bb1-4d70-9ae3-fa96f6d624d8@redhat.com>
Date: Mon, 8 Apr 2024 11:43:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-3-ryan.roberts@arm.com>
 <051052af-3b56-4290-98d3-fd5a1eb11ce1@redhat.com>
 <73adae65-4429-41d7-bbb6-4c58156060d3@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <73adae65-4429-41d7-bbb6-4c58156060d3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>>> +
>>> +/**
>>> + * swap_pte_batch - detect a PTE batch for a set of contiguous swap entries
>>> + * @start_ptep: Page table pointer for the first entry.
>>> + * @max_nr: The maximum number of table entries to consider.
>>> + * @entry: Swap entry recovered from the first table entry.
>>> + *
>>> + * Detect a batch of contiguous swap entries: consecutive (non-present) PTEs
>>> + * containing swap entries all with consecutive offsets and targeting the same
>>> + * swap type.
>>> + *
>>
>> Likely you should document that any swp pte bits are ignored? ()
> 
> Sorry I don't understand this comment. I thought any non-none, non-present PTE
> was always considered to contain only a "swap entry" and a swap entry consists
> of a "type" and an "offset" only. (and its a special "non-swap" swap entry if
> type > SOME_CONSTANT) Are you saying there are additional fields in the PTE that
> are not part of the swap entry?


pte_swp_soft_dirty()
pte_swp_clear_exclusive()
pte_swp_uffd_wp()

Are PTE bits used for swp PTE.

There is also dirty/young for migration entries, but that's not of a 
concern here, because we stop for non_swap_entry().

> 
> 
>>
>>> + * max_nr must be at least one and must be limited by the caller so scanning
>>> + * cannot exceed a single page table.
>>> + *
>>> + * Return: the number of table entries in the batch.
>>> + */
>>> +static inline int swap_pte_batch(pte_t *start_ptep, int max_nr,
>>> +                 swp_entry_t entry)
>>> +{
>>> +    const pte_t *end_ptep = start_ptep + max_nr;
>>> +    unsigned long expected_offset = swp_offset(entry) + 1;
>>> +    unsigned int expected_type = swp_type(entry);
>>> +    pte_t *ptep = start_ptep + 1;
>>> +
>>> +    VM_WARN_ON(max_nr < 1);
>>> +    VM_WARN_ON(non_swap_entry(entry));
>>> +
>>> +    while (ptep < end_ptep) {
>>> +        pte_t pte = ptep_get(ptep);
>>> +
>>> +        if (pte_none(pte) || pte_present(pte))
>>> +            break;
>>> +
>>> +        entry = pte_to_swp_entry(pte);
>>> +
>>> +        if (non_swap_entry(entry) ||
>>> +            swp_type(entry) != expected_type ||
>>> +            swp_offset(entry) != expected_offset)
>>> +            break;
>>> +
>>> +        expected_offset++;
>>> +        ptep++;
>>> +    }
>>> +
>>> +    return ptep - start_ptep;
>>> +}
>>
>> Looks very clean :)
>>
>> I was wondering whether we could similarly construct the expected swp PTE and
>> only check pte_same.
>>
>> expected_pte = __swp_entry_to_pte(__swp_entry(expected_type, expected_offset));
>>
>> ... or have a variant to increase only the swp offset for an existing pte. But
>> non-trivial due to the arch-dependent format.
>>
>> But then, we'd fail on mismatch of other swp pte bits.
> 
> Hmm, perhaps I have a misunderstanding regarding "swp pte bits"...
> 
>>
>>
>> On swapin, when reusing this function (likely!), we'll might to make sure that
>> the PTE bits match as well.
>>
>> See below regarding uffd-wp.
>>
>>
>>>    #endif /* CONFIG_MMU */
>>>      void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>> index 1f77a51baaac..070bedb4996e 100644
>>> --- a/mm/madvise.c
>>> +++ b/mm/madvise.c
>>> @@ -628,6 +628,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned
>>> long addr,
>>>        struct folio *folio;
>>>        int nr_swap = 0;
>>>        unsigned long next;
>>> +    int nr, max_nr;
>>>          next = pmd_addr_end(addr, end);
>>>        if (pmd_trans_huge(*pmd))
>>> @@ -640,7 +641,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned
>>> long addr,
>>>            return 0;
>>>        flush_tlb_batched_pending(mm);
>>>        arch_enter_lazy_mmu_mode();
>>> -    for (; addr != end; pte++, addr += PAGE_SIZE) {
>>> +    for (; addr != end; pte += nr, addr += PAGE_SIZE * nr) {
>>> +        nr = 1;
>>>            ptent = ptep_get(pte);
>>>              if (pte_none(ptent))
>>> @@ -655,9 +657,11 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned
>>> long addr,
>>>                  entry = pte_to_swp_entry(ptent);
>>>                if (!non_swap_entry(entry)) {
>>> -                nr_swap--;
>>> -                free_swap_and_cache(entry);
>>> -                pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>>> +                max_nr = (end - addr) / PAGE_SIZE;
>>> +                nr = swap_pte_batch(pte, max_nr, entry);
>>> +                nr_swap -= nr;
>>> +                free_swap_and_cache_nr(entry, nr);
>>> +                clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
>>>                } else if (is_hwpoison_entry(entry) ||
>>>                       is_poisoned_swp_entry(entry)) {
>>>                    pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 7dc6c3d9fa83..ef2968894718 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -1637,12 +1637,13 @@ static unsigned long zap_pte_range(struct mmu_gather
>>> *tlb,
>>>                    folio_remove_rmap_pte(folio, page, vma);
>>>                folio_put(folio);
>>>            } else if (!non_swap_entry(entry)) {
>>> -            /* Genuine swap entry, hence a private anon page */
>>> +            max_nr = (end - addr) / PAGE_SIZE;
>>> +            nr = swap_pte_batch(pte, max_nr, entry);
>>> +            /* Genuine swap entries, hence a private anon pages */
>>>                if (!should_zap_cows(details))
>>>                    continue;
>>> -            rss[MM_SWAPENTS]--;
>>> -            if (unlikely(!free_swap_and_cache(entry)))
>>> -                print_bad_pte(vma, addr, ptent, NULL);
>>> +            rss[MM_SWAPENTS] -= nr;
>>> +            free_swap_and_cache_nr(entry, nr);
>>>            } else if (is_migration_entry(entry)) {
>>>                folio = pfn_swap_entry_folio(entry);
>>>                if (!should_zap_folio(details, folio))
>>> @@ -1665,8 +1666,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>>                pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
>>>                WARN_ON_ONCE(1);
>>>            }
>>> -        pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>>> -        zap_install_uffd_wp_if_needed(vma, addr, pte, 1, details, ptent);
>>> +        clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
>>
>> For zap_install_uffd_wp_if_needed(), the uffd-wp bit has to match.
>>
>> zap_install_uffd_wp_if_needed() will use the uffd-wp information in
>> ptent->pteval to make a decision whether to place PTE_MARKER_UFFD_WP markers.
>>
>> On mixture, you either lose some or place too many markers.
> 
> What path are you concerned about here? I don't get how what you describe can
> happen? swap_pte_batch() will only give me a batch of actual swap entries and
> actual swap entries don't contain uffd-wp info, IIUC. If the function gets to a
> "non-swap" swap entry, it bails. I thought the uffd-wp info was populated based
> on the VMA state at swap-in? I think you are telling me that it's persisted
> across the swap per-pte?

Please see zap_install_uffd_wp_if_needed():

if (unlikely(pte_swp_uffd_wp_any(pteval)))
	arm_uffd_pte = true;

The PTEs (swp PTEs to be precise) contain uffd-wp informtation.

[...]

>>> +    /*
>>> +     * Short-circuit the below loop if none of the entries had their
>>> +     * reference drop to zero.
>>> +     */
>>> +    if (!any_only_cache)
>>> +        goto out;
>>>    -        count = __swap_entry_free(p, entry);
>>> -        if (count == SWAP_HAS_CACHE)
>>> -            __try_to_reclaim_swap(p, swp_offset(entry),
>>> +    /*
>>> +     * Now go back over the range trying to reclaim the swap cache. This is
>>> +     * more efficient for large folios because we will only try to reclaim
>>> +     * the swap once per folio in the common case. If we do
>>> +     * __swap_entry_free() and __try_to_reclaim_swap() in the same loop, the
>>> +     * latter will get a reference and lock the folio for every individual
>>> +     * page but will only succeed once the swap slot for every subpage is
>>> +     * zero.
>>> +     */
>>> +    for (offset = swp_offset(entry); offset < end; offset += nr) {
>>> +        nr = 1;
>>> +        if (READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
>>
>> Here we use READ_ONCE() only, above data_race(). Hmmm.
> 
> Yes. I think this is correct.
> 
> READ_ONCE() is a "marked access" which KCSAN understands, so it won't complain
> about it. So data_race() isn't required when READ_ONCE() (or WRITE_ONCE()) is
> used. I believe READ_ONCE() is required here because we don't have a lock and we
> want to make sure we read it in a non-tearing manner.
> 
> We don't need the READ_ONCE() above since we don't care about the exact value -
> only that it's not 0 (because we should be holding a ref). So do a plain access
> to give the compiler a bit more freedom. But we need to mark that with
> data_race() to stop KCSAN from complaining.

Okay.

-- 
Cheers,

David / dhildenb


