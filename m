Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A74B753F12
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbjGNPhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbjGNPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA2E4224
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689348951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4XubpuuxHa0Lt4jRayW4IHWNvBqhaB5kCijr8kSTTd0=;
        b=DZLFA3rP24LEtfgQNhLpEUtkHyokfdAS17f/c4gsHdvtHrGEyG2JyT0ZSMeg9XMhjhzKTX
        V0SE9ZJuIxf5qUwYz5o+T5VIRJgtVKWgV4Ck6Nn1nrZZXLpR1Cv4Rgqt7b+BGeQoCuJ/rn
        0uQfvBc8NIlsG9g7MkeVh8uDVBUEfDY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-WpCZ2-syMomOCeRYCq0LKQ-1; Fri, 14 Jul 2023 11:35:50 -0400
X-MC-Unique: WpCZ2-syMomOCeRYCq0LKQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2f2981b8364so1166933f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689348949; x=1691940949;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XubpuuxHa0Lt4jRayW4IHWNvBqhaB5kCijr8kSTTd0=;
        b=GeDNmoXe0mLc4aCi3gXqPsPxrcIgoz7mVvjcELeH/4NrGJnFeaTBJFztMGelUkNRoB
         OxGQYb7OB3kbITyK99BHXvw/zD3KAy43pUSSA19tHacxMpJx1f36tWE8sFDKyRSuRyH9
         sa0iHNmFSRSx1TVJ+XNZBa10sB+cnWtdPoqu0/e0C8Z90ygwnOAWRhX8H8HoUNDoFoLE
         15o2DGbhzuDaJFNWKTpwijYxIlndPw+h5pvpsWP40v2zOwqM0nJFVXB75jAGwJ8lLFpj
         Rq89nykPZDHFF/p0r+V3xRl3AgtOc9yNkCSoG/nyRzwA11CaRkdwCMdGj/eZSpDhO/hM
         oXGg==
X-Gm-Message-State: ABy/qLZYEODQ7Ms5rnNZBOg9miC7e4xtA+iT7TAHwxLl9weKx16nid+N
        gfLL1R6PKdcJIFeBKc7GyWRfcWMaJZvCL0s78SWRow81mFd1lDwW2Ig+j4N1jauzpv/ZeBSQnC5
        APOCIAueJjXcxVOo3bEROh9Yh
X-Received: by 2002:adf:f9c9:0:b0:313:f59c:95ec with SMTP id w9-20020adff9c9000000b00313f59c95ecmr4860822wrr.28.1689348949124;
        Fri, 14 Jul 2023 08:35:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFam3ZktFrXziKA7D/qjzWbbSlb1kQ0WfzOzDNq5cjQg26F0TiQV+yVsMTRBbl6luEeWln9zw==
X-Received: by 2002:adf:f9c9:0:b0:313:f59c:95ec with SMTP id w9-20020adff9c9000000b00313f59c95ecmr4860815wrr.28.1689348948712;
        Fri, 14 Jul 2023 08:35:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:4500:8a9e:a24a:133d:86bb? (p200300cbc70a45008a9ea24a133d86bb.dip0.t-ipconnect.de. [2003:cb:c70a:4500:8a9e:a24a:133d:86bb])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d66ca000000b00313f9085119sm11191454wrw.113.2023.07.14.08.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 08:35:48 -0700 (PDT)
Message-ID: <a61e73a7-87ef-4f1a-be5c-e9bf57dc1475@redhat.com>
Date:   Fri, 14 Jul 2023 17:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, ryan.roberts@arm.com, shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufb0zxKvmvEXfG4kySenxyPtagnr_cf4Ms-6si3bQTybGQ@mail.gmail.com>
 <8547495c-9051-faab-a47d-1962f2e0b1da@intel.com>
 <CAOUHufY-edD2j2Nfz3xrObF2ERAGKecjFr_1Qarh5aDwyDGS2A@mail.gmail.com>
 <d024fa03-ca51-632b-9a01-bbdc75543f5d@redhat.com>
 <6C3EFBC6-DC59-4167-B51A-7231A55FE1D5@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
In-Reply-To: <6C3EFBC6-DC59-4167-B51A-7231A55FE1D5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.23 16:41, Zi Yan wrote:
> On 14 Jul 2023, at 3:31, David Hildenbrand wrote:
> 
>> On 14.07.23 05:23, Yu Zhao wrote:
>>> On Thu, Jul 13, 2023 at 9:10 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/14/2023 10:08 AM, Yu Zhao wrote:
>>>>> On Thu, Jul 13, 2023 at 9:06 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>
>>>>>> Current madvise_cold_or_pageout_pte_range() has two problems for
>>>>>> large folio support:
>>>>>>     - Using folio_mapcount() with large folio prevent large folio from
>>>>>>       picking up.
>>>>>>     - If large folio is in the range requested, shouldn't split it
>>>>>>       in madvise_cold_or_pageout_pte_range().
>>>>>>
>>>>>> Fix them by:
>>>>>>     - Use folio_estimated_sharers() with large folio
>>>>>>     - If large folio is in the range requested, don't split it. Leave
>>>>>>       to page reclaim phase.
>>>>>>
>>>>>> For large folio cross boundaries of requested range, skip it if it's
>>>>>> page cache. Try to split it if it's anonymous folio. If splitting
>>>>>> fails, skip it.
>>>>>
>>>>> For now, we may not want to change the existing semantic (heuristic).
>>>>> IOW, we may want to stick to the "only owner" condition:
>>>>>
>>>>>     - if (folio_mapcount(folio) != 1)
>>>>>     + if (folio_entire_mapcount(folio) ||
>>>>>     +     (any_page_within_range_has_mapcount > 1))
>>>>>
>>>>> +Minchan Kim
>>>> The folio_estimated_sharers() was discussed here:
>>>> https://lore.kernel.org/linux-mm/20230118232219.27038-6-vishal.moola@gmail.com/
>>>> https://lore.kernel.org/linux-mm/20230124012210.13963-2-vishal.moola@gmail.com/
>>>>
>>>> Yes. It's accurate to check each page of large folio. But it may be over killed in
>>>> some cases (And I think madvise is one of the cases not necessary to be accurate.
>>>> So folio_estimated_sharers() is enough. Correct me if I am wrong).
>>>
>>> I see. Then it's possible this is also what the original commit wants
>>> to do -- Minchan, could you clarify?
>>>
>>> Regardless, I think we can have the following fix, potentially cc'ing stable:
>>>
>>> -  if (folio_mapcount(folio) != 1)
>>> +  if (folio_estimated_sharers(folio) != 1)
>>>
>>> Sounds good?
>>
>> Adding to the discussion, currently the COW selftest always skips a PTE-mapped THP.
>>
>>
>> For example:
>>
>> # [INFO] Anonymous memory tests in private mappings
>> # [RUN] Basic COW after fork() ... with base page
>> ok 1 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with swapped out base page
>> ok 2 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with THP
>> ok 3 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with swapped-out THP
>> ok 4 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with PTE-mapped THP
>> ok 5 No leak from parent into child
>> # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
>> ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
>> ...
>>
>>
>> The commit that introduced that change is:
>>
>> commit 07e8c82b5eff8ef34b74210eacb8d9c4a2886b82
>> Author: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>> Date:   Wed Dec 21 10:08:46 2022 -0800
>>
>>      madvise: convert madvise_cold_or_pageout_pte_range() to use folios
>>
>>      This change removes a number of calls to compound_head(), and saves
>>      1729 bytes of kernel text.
>>
>>
>>
>> folio_mapcount(folio) is wrong, because that never works on a PTE-mapped THP (well, unless only a single subpage is still mapped ...).
>>
>> page_mapcount(folio) was wrong, because it ignored all other subpages, but at least it worked in some cases.
>>
>> folio_estimated_sharers(folio) is similarly wrong like page_mapcount(), as it's essentially a page_mapcount() of the first subpage.
>>
>> (ignoring that a lockless mapcount-based check is always kind-of unreliable, but that's msotly acceptable for these kind of things)
>>
>>
>> So, unfortunately, page_mapcount() / folio_estimated_sharers() is best we can do for now, but they miss to detect some cases of sharing of the folio -- false negatives to detect sharing.
>>
>>
>> Ideally we want something like folio_maybe_mapped_shared(), and get rid of folio_estimated_sharers(), we better to guess the exact number, simply works towards an answer that tells us "yep, this may be mapped by multiple sharers" vs. "no, this is definitely not mapped by multiple sharers".
>>
>> The "mapped" part of it indicates that this does not catch all cases of sharing. But it should handle most of the cases we care about.
>>
>>
>> There, we can then implement something better than what folio_estimated_sharers() currently does:
>>
>> static inline bool folio_maybe_mapped_shared(folio)
>> {
>> 	if (likely(!folio_test_large(folio)))
>> 		return atomic_read(&folio->_mapcount) > 0;
>>
>> 	/* Mapped multiple times via PMD? */
>> 	if (folio_test_pmd_mappable(folio)
>> 		return folio_entire_mapcount() > 1;
>>
>> 	/*
>> 	 * First subpage is mapped multiple times (especially also via
>> 	 * PMDs)?
>>           */
>> 	if (page_mapcount(folio_page(folio, 0) > 1)
>> 		return true;
>>
>> 	/* TODO: also test last subpage? */
>> 	
>> 	/* Definitely shared if we're mapping a page multiple times. */
>> 	return folio_total_mapcount(folio) > folio_nr_pages(folio);
>> }
>>
>> There are some more things we could optimize for.
> 
> Before jumping into the mapcount, I would like to get some clarification
> on "sharer". Does it mean a page is mapped/shared by more than one page
> table entry or is mapped/shared by more than one process? Your function

:) I think it depends. For a order-0 page it is "more than one page 
table entry", which is is what the order-0 mapcount expresses.


So let's focus on order > 0 (and keep KSM out of the picture). There, it 
is different.

We're talking about "logical mapping" of the page. So a single logical 
mapping == one sharer.


1) Anon pages

For the time being, it really is "mapped by one process" -> exclusively 
mapped, "mapped by more than one process" -> mapped shared.

It's not "mapped into multiple page tables" or "mapped into multiple VMAs".

[That doesn't necessarily have to be that way for ever -- imagine we'd 
ever support a mremap(KEEP) with COW semantics -- but think there would 
be ways to handle that].


2) Pagecache pages

It really depends what we want. Either

(a) "mapped via a single logical mmap() operation"
      mapped.

(b) "mapped from a single open() operation"

(c) mapped by a single process.

Of course, mremap() is weird.


Currently, with the order-0 mapcount (and we cannot really change these 
semantics easily because we don't have any space to store additional 
information), it would be (a).

For example, mremap(KEEP) or a second mmap() creates a new logical mapping.

But the pagecache is kind-of weird: anybody could immediately map a page 
after we detected it as "exclusive" -- and eventually even concurrently. 
So this detection of "shared" is inherently problematic.


My primary focus is anon pages for now (as so often :) ). Anon is hard 
but eventually a bit easier to handle -- famous last words.

> indicates it is the former, but for madvise_cold_or_pageout_pte_range(),
> I am not sure that is what we want. What if user wants to page out a
> page that is mapped by the same process twice? With current method
> or any existing proposals, it will fail undesirably. It will only work
> as expect with your creator proposal[1].

For anon pages it's fairly easy IMHO. For pagecache pages, I guess we 
should keep it the way it was for order-0 pages: individual logical 
mmap() operations -- (a). It's sub-optimal, but the way it used to be 
for order-0.


> 
> Other places like auto NUMA migration also use mapcount to check if
> a page is mapped by multiple process with the assumption that a page will
> only be mapped by one process once.

Right, most of these cases might be able to use 
folio_maybe_mapped_shared() to detect "currently the whole folio is 
mapped exclusively by a single logical mapping". That makes a lot of 
sense in most cases that want to mess with a folio (e.g., migration, 
pageout, NUMA).

-- 
Cheers,

David / dhildenb

