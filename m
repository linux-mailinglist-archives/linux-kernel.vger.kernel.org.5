Return-Path: <linux-kernel+bounces-143238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B508A3628
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02121F23B39
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB1414F9CF;
	Fri, 12 Apr 2024 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeLzcFkv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D410142E78
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948800; cv=none; b=nl4Hue2x4QecFMixiCVUBJq9mAzKBFwhS81PiUer95pKpyko8Ztw4Kj/ml4jkW4EcBt9BiZMwWub53OBZj2Vs+0p5Af6154cDuddwpNfhTfP1YHvsPh/TTUh86+HadMn80RDXtv1EzxPRncD4wWJmDLfVDoUa0KpjtRlQRnO1MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948800; c=relaxed/simple;
	bh=RC4qHCITV8KigBpe/x0hFdLe+IpXYedYIr9f1wun+Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msec5U0T+uWYU1G+SRtEq3ygf8VSTqBh4ayCFhdtFhyc4xtV9NjBs8/AwghnFo1rR0USYEpVVgX9TtFs/kzolDjkn5USqNpBwU76FJ4nAYvKW940HwlDWgbID96TyM+VV/WPO/T6wvlRmJ3A+z/wAMywDTD4lm400/yqP58e0uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeLzcFkv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712948797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lii1dHcdCvX1rrevsO20pdS/4SDcLTunWyNWJoT299c=;
	b=SeLzcFkvmFG4rTYGvpYvahA2c2qEe7vfAYy3iDNqGpeKviSzaPgwH+c/qIvFIWF2alF1eH
	dIHDOSB93buqlQiPkyuZe1G0rppLee96xD2sje0yt90i6dA+wpp1O7YLYAGxXLtcCSlaK0
	ZDgmKzAD1BenvVv13z+Y6x6fx2V9kcg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-tpgQFBUNONyxF3iUbf-U5g-1; Fri, 12 Apr 2024 15:06:35 -0400
X-MC-Unique: tpgQFBUNONyxF3iUbf-U5g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41641a8895dso6193385e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712948794; x=1713553594;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lii1dHcdCvX1rrevsO20pdS/4SDcLTunWyNWJoT299c=;
        b=FiIhKZ4SGu/JkjscL8syGfsr/ixNy7Bn7cExqjLyb0Zz8S8gvbDGIL3BqSeVtNXJns
         7HU/Au9e9LxfUYA3NYuKLZv3MDk5t4NuLG692XhtSH1aiMyfHVcJoPVjI56wEIYfX/5U
         C1oTAEARk/jkkB3IWGi8ElrtRdExEE59/WrQXGJraH8/6eYrLU6RPQaImfkEzxqWqu+0
         yz/3gELHA1gcimHS6cXLuzmh3+ol37uzAm05G4Ah3hEMivwsDlhHMDbX0ORq4UD71ZpU
         UGwh6nC2w42nUqN/2jPkODYbGTInnZlm98QSyyNuMhfotWUHqy2GgVwklIZpIwzCs/9G
         bdwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR0nLJWgM03cjFMWHOOCdJvb8NLLMNRmhdPWzqibtWoAQkVk8eMiYNBSvQHpci80gL8F5STzii74vIQD+7SoOxqehCzlSOG3fZtKH9
X-Gm-Message-State: AOJu0YxK1LTiY7ZhP4pbpRQEknBUNzq/OSqPHxRs+4OCCyXi0tC9HX+f
	uVCnu/h7/ZzSIdRHwBaaXFv4HmE5JpJ6kCfFwhrsohYQ2oqVEE+pfb9k693LAU/DefqmfsLPMXT
	wgKjCzRwcC7DYU0DFYK2l1wpbL8kghNXAs9F2MjgFZotva/tFdCFr2EpbXpkqPQ==
X-Received: by 2002:a05:600c:444d:b0:416:6a8a:d84c with SMTP id v13-20020a05600c444d00b004166a8ad84cmr2794385wmn.38.1712948794473;
        Fri, 12 Apr 2024 12:06:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqyldNljUNQkV2UhZdjV/1uuI2BJ0MMH0dzm/wjXHYpNz3UtqLTXe9gn/qaK9coonqThY0Nw==
X-Received: by 2002:a05:600c:444d:b0:416:6a8a:d84c with SMTP id v13-20020a05600c444d00b004166a8ad84cmr2794368wmn.38.1712948794030;
        Fri, 12 Apr 2024 12:06:34 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23ff1.dip0.t-ipconnect.de. [79.242.63.241])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c468a00b00416ba2db6b4sm6463514wmo.18.2024.04.12.12.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 12:06:33 -0700 (PDT)
Message-ID: <ee3be59c-4ffd-4fbf-a542-2d4cf45ed08e@redhat.com>
Date: Fri, 12 Apr 2024 21:06:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
References: <20240411153232.169560-1-zi.yan@sent.com>
 <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <CAHbLzkr99knWKZvE4WCWKKr=eezkg89idpE59oo_oBneAQynAA@mail.gmail.com>
 <86722546-1d54-4224-9f31-da4f368cd47e@redhat.com>
 <CAHbLzkrxR_cpVd_KF1rz9CTVmr4q0KX7T=SseOo8X5u23-5ZJQ@mail.gmail.com>
 <0A4D2CA1-E156-43E9-A1C9-E09E62E760A3@nvidia.com>
 <A06608B4-9187-42DD-B9A2-CBBC3D5C9312@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <A06608B4-9187-42DD-B9A2-CBBC3D5C9312@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.04.24 16:31, Zi Yan wrote:
> On 12 Apr 2024, at 10:21, Zi Yan wrote:
> 
>> On 11 Apr 2024, at 17:59, Yang Shi wrote:
>>
>>> On Thu, Apr 11, 2024 at 2:15 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 11.04.24 21:01, Yang Shi wrote:
>>>>> On Thu, Apr 11, 2024 at 8:46 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>> On 11.04.24 17:32, Zi Yan wrote:
>>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>>
>>>>>>> In __folio_remove_rmap(), a large folio is added to deferred split list
>>>>>>> if any page in a folio loses its final mapping. It is possible that
>>>>>>> the folio is unmapped fully, but it is unnecessary to add the folio
>>>>>>> to deferred split list at all. Fix it by checking folio mapcount before
>>>>>>> adding a folio to deferred split list.
>>>>>>>
>>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>>> ---
>>>>>>>     mm/rmap.c | 9 ++++++---
>>>>>>>     1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>>> index 2608c40dffad..d599a772e282 100644
>>>>>>> --- a/mm/rmap.c
>>>>>>> +++ b/mm/rmap.c
>>>>>>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>>>>>                 enum rmap_level level)
>>>>>>>     {
>>>>>>>         atomic_t *mapped = &folio->_nr_pages_mapped;
>>>>>>> -     int last, nr = 0, nr_pmdmapped = 0;
>>>>>>> +     int last, nr = 0, nr_pmdmapped = 0, mapcount = 0;
>>>>>>>         enum node_stat_item idx;
>>>>>>>
>>>>>>>         __folio_rmap_sanity_checks(folio, page, nr_pages, level);
>>>>>>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>>>>>                         break;
>>>>>>>                 }
>>>>>>>
>>>>>>> -             atomic_sub(nr_pages, &folio->_large_mapcount);
>>>>>>> +             mapcount = atomic_sub_return(nr_pages,
>>>>>>> +                                          &folio->_large_mapcount) + 1;
>>>>>>
>>>>>> That becomes a new memory barrier on some archs. Rather just re-read it
>>>>>> below. Re-reading should be fine here.
>>>>>>
>>>>>>>                 do {
>>>>>>>                         last = atomic_add_negative(-1, &page->_mapcount);
>>>>>>>                         if (last) {
>>>>>>> @@ -1554,7 +1555,9 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>>>>>                  * is still mapped.
>>>>>>>                  */
>>>>>>>                 if (folio_test_large(folio) && folio_test_anon(folio))
>>>>>>> -                     if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
>>>>>>> +                     if ((level == RMAP_LEVEL_PTE &&
>>>>>>> +                          mapcount != 0) ||
>>>>>>> +                         (level == RMAP_LEVEL_PMD && nr < nr_pmdmapped))
>>>>>>>                                 deferred_split_folio(folio);
>>>>>>>         }
>>>>>>
>>>>>> But I do wonder if we really care? Usually the folio will simply get
>>>>>> freed afterwards, where we simply remove it from the list.
>>>>>>
>>>>>> If it's pinned, we won't be able to free or reclaim, but it's rather a
>>>>>> corner case ...
>>>>>>
>>>>>> Is it really worth the added code? Not convinced.
>>>>>
>>>>> It is actually not only an optimization, but also fixed the broken
>>>>> thp_deferred_split_page counter in /proc/vmstat.
>>>>>
>>>>> The counter actually counted the partially unmapped huge pages (so
>>>>> they are on deferred split queue), but it counts the fully unmapped
>>>>> mTHP as well now. For example, when a 64K THP is fully unmapped, the
>>>>> thp_deferred_split_page is not supposed to get inc'ed, but it does
>>>>> now.
>>>>>
>>>>> The counter is also useful for performance analysis, for example,
>>>>> whether a workload did a lot of partial unmap or not. So fixing the
>>>>> counter seems worthy. Zi Yan should have mentioned this in the commit
>>>>> log.
>>>>
>>>> Yes, all that is information that is missing from the patch description.
>>>> If it's a fix, there should be a "Fixes:".
>>>>
>>>> Likely we want to have a folio_large_mapcount() check in the code below.
>>>> (I yet have to digest the condition where this happens -- can we have an
>>>> example where we'd use to do the wrong thing and now would do the right
>>>> thing as well?)
>>>
>>> For example, map 1G memory with 64K mTHP, then unmap the whole 1G or
>>> some full 64K areas, you will see thp_deferred_split_page increased,
>>> but it shouldn't.
>>>
>>> It looks __folio_remove_rmap() incorrectly detected whether the mTHP
>>> is fully unmapped or partially unmapped by comparing the number of
>>> still-mapped subpages to ENTIRELY_MAPPED, which should just work for
>>> PMD-mappable THP.
>>>
>>> However I just realized this problem was kind of workaround'ed by commit:
>>>
>>> commit 98046944a1597f3a02b792dbe9665e9943b77f28
>>> Author: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Date:   Fri Mar 29 14:59:33 2024 +0800
>>>
>>>      mm: huge_memory: add the missing folio_test_pmd_mappable() for THP
>>> split statistics
>>>
>>>      Now the mTHP can also be split or added into the deferred list, so add
>>>      folio_test_pmd_mappable() validation for PMD mapped THP, to avoid
>>>      confusion with PMD mapped THP related statistics.
>>>
>>>      Link: https://lkml.kernel.org/r/a5341defeef27c9ac7b85c97f030f93e4368bbc1.1711694852.git.baolin.wang@linux.alibaba.com
>>>      Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>      Acked-by: David Hildenbrand <david@redhat.com>
>>>      Cc: Muchun Song <muchun.song@linux.dev>
>>>      Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>>
>>> This commit made thp_deferred_split_page didn't count mTHP anymore, it
>>> also made thp_split_page didn't count mTHP anymore.
>>>
>>> However Zi Yan's patch does make the code more robust and we don't
>>> need to worry about the miscounting issue anymore if we will add
>>> deferred_split_page and split_page counters for mTHP in the future.
>>
>> Actually, the patch above does not fix everything. A fully unmapped
>> PTE-mapped order-9 THP is also added to deferred split list and
>> counted as THP_DEFERRED_SPLIT_PAGE without my patch, since nr is 512
>> (non zero), level is RMAP_LEVEL_PTE, and inside deferred_split_folio()
>> the order-9 folio is folio_test_pmd_mappable().
>>
>> I will add this information in the next version.
> 
> It might
> Fixes: b06dc281aa99 ("mm/rmap: introduce folio_remove_rmap_[pte|ptes|pmd]()"),
> but before this commit fully unmapping a PTE-mapped order-9 THP still increased
> THP_DEFERRED_SPLIT_PAGE, because PTEs are unmapped individually and first PTE
> unmapping adds the THP into the deferred split list. This means commit b06dc281aa99
> did not change anything and before that THP_DEFERRED_SPLIT_PAGE increase is
> due to implementation. I will add this to the commit log as well without Fixes
> tag.

Right, so it's always been a problem for PTE-mapped PMD-sized THP and 
only with batching we can now do "better". But not fix it completely.

I'll reply separately to your other mail.

-- 
Cheers,

David / dhildenb


