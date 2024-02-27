Return-Path: <linux-kernel+bounces-82992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7AA868CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A86F283371
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED2E13699C;
	Tue, 27 Feb 2024 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmWVsXq9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9316F137C21
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027606; cv=none; b=fbOui3GNYtBZjtXlQbAhvO118BoaK3rEQ/bCjrQIYex89w8NF1OsUMS54FFpxrrjv3XiPyNM7jk/DbyZRFbMlmIPbdNMbc4jANHKpO1Or8hLsKeYoO1qS5fCs+Zo0TfhQrrbhE0ApKFmn3ZTwaqK9z7hTqCq5qWYHXV5E9nJoJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027606; c=relaxed/simple;
	bh=P3obRiXIMy2zLET5j2euoFbbZk4d5vkWA9yfNfsOaLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sr4jXU/GBZCnuZKGHVtqWonJc6RENUFlqqZTRjf1r1ozvythukWxdYpV1Mj3csn0Qn1ts8BDNKxa09j799C/kiCSuAA2Pacj0zM8qc1FFLEOrqSEh2fFgEGRdMp69b3olUpvj9rZEcJ0G8e1wGVbz9/GkDQB9jGBCKKilZWtXIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmWVsXq9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709027602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C4U206G991wButn18QTKU/VXchme3CjjGj/qsBUFTkk=;
	b=QmWVsXq99BEHdFmq4Z/zFUedtEE/Hbk1LR8/SMGLB3H2iAU5AzUeaX3nu3Xy8IFBGlzze3
	C5YPn++9E7g/yXBE7bd+UujcLLIzH3i8lk8ZrQDFOewycc2j/faetM7gOlHF/inoo285qQ
	3Ez1pjR94ST+0EPt0Ss/Uzf5TkDL67Q=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-WkCA3r2TP6S_zkx2-YCXPQ-1; Tue, 27 Feb 2024 04:53:20 -0500
X-MC-Unique: WkCA3r2TP6S_zkx2-YCXPQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d22ff0aad9so31761451fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709027599; x=1709632399;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4U206G991wButn18QTKU/VXchme3CjjGj/qsBUFTkk=;
        b=PJfnH7lq+UDXT7uqP0nLHSGKQhYDa9533uHVaAlmA8fNUwR8DeKT63ytBEPa9sUNRT
         +B9OBe6zTncNsyi+NwvDTB1XW8Fg1R2pKjTULkMKFSzi33WsL9aOnhF29OeWhkY0vChz
         h+51pblpLTvSCwfS204ozAWS9IIfij6GIcE/0Feq+DxcPZw293qsIeyBV+d+DqoAZQit
         /UbzQXgeTsP0Z5y3JlzoZFlnvPXaImaKW6u0FUB0Skkwcfy2xJGXu+5Q/GDI4Ft/F1g8
         LRtCdZA4cPBphfLtJLe17LkVxJkRD9/ZMVVxS8TDjnG7YufFsfMcB88RSA4D/Br3zjAw
         lw+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWeCpjXP+p1x+C/HXSMpgLYzwGJOxanpRr9eH39U89ZdP5DKq7f6T8xAI4Nb2RtLM+8NbIluSAduxc1F7VSvcSiLRKSV4QjQOZiNXB
X-Gm-Message-State: AOJu0YwcGISde/zhUkL+xv2wq9Pkh8+hSEXbHfQZd9uuAtjWYpGbVP09
	YpDczq3lBqWwNtcIQW4TXnttUZvIIKIdOra2R4S/Ha3cWyI13hEnkD6/y801D8PnUuYJRN5YiVq
	EWomXaa0w7U4RWio0MMQXwp0fnjqOdijz5NWD039V20JFTEL+24M6kUCxO9uvww==
X-Received: by 2002:a2e:a30a:0:b0:2d2:85d0:f65 with SMTP id l10-20020a2ea30a000000b002d285d00f65mr4605463lje.0.1709027599381;
        Tue, 27 Feb 2024 01:53:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhbuSngP6uAgMj5xZGYwfLLlM0IibKqb+IqO+I1JrqEm/UihVhyZR/MVQgey+3ecmOa0qxiw==
X-Received: by 2002:a2e:a30a:0:b0:2d2:85d0:f65 with SMTP id l10-20020a2ea30a000000b002d285d00f65mr4605444lje.0.1709027598938;
        Tue, 27 Feb 2024 01:53:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9? (p200300cbc70776005c185a7dc5b7e7a9.dip0.t-ipconnect.de. [2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c458900b004122b7a680dsm10892489wmo.21.2024.02.27.01.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 01:53:18 -0800 (PST)
Message-ID: <fc8cdf6f-b400-4228-b8dc-3fb47df0b402@redhat.com>
Date: Tue, 27 Feb 2024 10:53:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
Content-Language: en-US
To: Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>, Yin Fengwei <fengwei.yin@intel.com>
References: <20240227024050.244567-1-21cnbao@gmail.com>
 <61b9dfc9-5522-44fd-89a4-140833ede8af@arm.com>
 <c95215b2-6ec5-4efb-a73b-7be92cda1c83@redhat.com>
 <CAK1f24nwfyaF3Ly_-mMtf2fMvMgZ5sDVC1t0XsfF41ii6vvL5Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24nwfyaF3Ly_-mMtf2fMvMgZ5sDVC1t0XsfF41ii6vvL5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.02.24 10:51, Lance Yang wrote:
> On Tue, Feb 27, 2024 at 5:14 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 27.02.24 10:07, Ryan Roberts wrote:
>>> On 27/02/2024 02:40, Barry Song wrote:
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> madvise and some others might need folio_pte_batch to check if a range
>>>> of PTEs are completely mapped to a large folio with contiguous physcial
>>>> addresses. Let's export it for others to use.
>>>>
>>>> Cc: Lance Yang <ioworker0@gmail.com>
>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Yin Fengwei <fengwei.yin@intel.com>
>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>> ---
>>>>    -v1:
>>>>    at least two jobs madv_free and madv_pageout depend on it. To avoid
>>>>    conflicts and dependencies, after discussing with Lance, we prefer
>>>>    this one can land earlier.
>>>
>>> I think this will also ultimately be useful for mprotect too, though I haven't
>>> looked at it properly yet.
>>>
>>
>> Yes, I think we briefly discussed that.
>>
>>>>
>>>>    mm/internal.h | 13 +++++++++++++
>>>>    mm/memory.c   | 11 +----------
>>>>    2 files changed, 14 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>> index 13b59d384845..8e2bc304f671 100644
>>>> --- a/mm/internal.h
>>>> +++ b/mm/internal.h
>>>> @@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct folio *folio)
>>>>       return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
>>>>    }
>>>>
>>>> +/* Flags for folio_pte_batch(). */
>>>> +typedef int __bitwise fpb_t;
>>>> +
>>>> +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
>>>> +#define FPB_IGNORE_DIRTY            ((__force fpb_t)BIT(0))
>>>> +
>>>> +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
>>>> +#define FPB_IGNORE_SOFT_DIRTY               ((__force fpb_t)BIT(1))
>>>> +
>>>> +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
>>>> +            pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
>>>> +            bool *any_writable);
>>>> +
>>>>    void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
>>>>                                               int nr_throttled);
>>>>    static inline void acct_reclaim_writeback(struct folio *folio)
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 1c45b6a42a1b..319b3be05e75 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -953,15 +953,6 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
>>>>       set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>>>>    }
>>>>
>>>> -/* Flags for folio_pte_batch(). */
>>>> -typedef int __bitwise fpb_t;
>>>> -
>>>> -/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
>>>> -#define FPB_IGNORE_DIRTY            ((__force fpb_t)BIT(0))
>>>> -
>>>> -/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
>>>> -#define FPB_IGNORE_SOFT_DIRTY               ((__force fpb_t)BIT(1))
>>>> -
>>>>    static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>>>>    {
>>>>       if (flags & FPB_IGNORE_DIRTY)
>>>> @@ -982,7 +973,7 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>>>>     * If "any_writable" is set, it will indicate if any other PTE besides the
>>>>     * first (given) PTE is writable.
>>>>     */
>>>
>>> David was talking in Lance's patch thread, about improving the docs for this
>>> function now that its exported. Might be worth syncing on that.
>>
>> Here is my take:
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    mm/memory.c | 22 ++++++++++++++++++----
>>    1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index d0b855a1837a8..098356b8805ae 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -971,16 +971,28 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>>          return pte_wrprotect(pte_mkold(pte));
>>    }
>>
>> -/*
>> +/**
>> + * folio_pte_batch - detect a PTE batch for a large folio
>> + * @folio: The large folio to detect a PTE batch for.
>> + * @addr: The user virtual address the first page is mapped at.
>> + * @start_ptep: Page table pointer for the first entry.
>> + * @pte: Page table entry for the first page.
>> + * @max_nr: The maximum number of table entries to consider.
>> + * @flags: Flags to modify the PTE batch semantics.
>> + * @any_writable: Optional pointer to indicate whether any entry except the
>> + *               first one is writable.
>> + *
>>     * Detect a PTE batch: consecutive (present) PTEs that map consecutive
>> - * pages of the same folio.
>> + * pages of the same large folio.
>>     *
>>     * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN,
>>     * the accessed bit, writable bit, dirty bit (with FPB_IGNORE_DIRTY) and
>>     * soft-dirty bit (with FPB_IGNORE_SOFT_DIRTY).
>>     *
>> - * If "any_writable" is set, it will indicate if any other PTE besides the
>> - * first (given) PTE is writable.
>> + * start_ptep must map any page of the folio. max_nr must be at least one and
>> + * must be limited by the caller so scanning cannot exceed a single page table.
>> + *
>> + * Return: the number of table entries in the batch.
>>     */
>>    static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>>                  pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
>> @@ -996,6 +1008,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>>                  *any_writable = false;
>>
>>          VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>> +       VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
>> +       VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) != folio, folio);
> 
> Nit:
> IIUC, the pte that maps to the first page.
>   -       VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) !=
> folio, folio);
>   +       VM_WARN_ON_FOLIO(pte_pfn(pte) != folio_pfn(folio), folio);

That would only work if the PTE would map the very first subpage of the 
folio, not any subpage?

-- 
Cheers,

David / dhildenb


