Return-Path: <linux-kernel+bounces-105939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535BB87E6A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085D71F2295E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939C02C69E;
	Mon, 18 Mar 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EriVXpbc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05222E40F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756323; cv=none; b=G4C6aoxL4oM8XrVIUi2xx9PDiH5eX2QGXGH5hMi+niU9QXgVoQ8nLPxqaYMwDlAhPWUQmTHZmiK8ef/Rd1izEqSxZ3XfGLiA0maPtql8dBLQ57CMzjzb5JJXJvaEEjEZlQ/MR74Ce3DS6TqOlJ3c5R72PiHishaxzYet96DMi6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756323; c=relaxed/simple;
	bh=MAHAxg1hXHTZ2wGHQZUUWaqOF1OELsLHYD5cpYs9PCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuSq+rySs5buF6u3zfTQTlz3tU3cuErfhaODdeKDye3C9HpGME3jm8yGwHomyHudSSfLuYLhwjeYL3Zx20aXw9l3kS4ic1DZNKw8OsXH1tJ7+F6wwpA4U2q5UaVmyxVoBZpXwgkmi+KlUd+FpezVmjJ57P2N1a2JylOn/Nl2x8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EriVXpbc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710756320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WrPfyjXv5vyy83J0RIf7OCISTzmwfuEOznmXmDyusc8=;
	b=EriVXpbcRJf2/F2fGBPJYMHEfirqhhOz2AN7a4A7CAqr8zVSBaO8nCPnwjocSjObZsxeXI
	ll8gdYTI2Pq3F+LFcLvD3wUQD2atBZ0qEq1o1W2WXR7wlHUdWQNqkKYjVB0v0sJfKcSDyY
	7MlN5fwUqwH5LVP/ruLg7W9yit3n5KI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-QfYsP2pHO9am9nnKw8bbqw-1; Mon, 18 Mar 2024 06:05:19 -0400
X-MC-Unique: QfYsP2pHO9am9nnKw8bbqw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ec308655eso1277796f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710756318; x=1711361118;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrPfyjXv5vyy83J0RIf7OCISTzmwfuEOznmXmDyusc8=;
        b=rGQSHU3lxtxIQeo/vUgaPZ7QVb8X60olzwt3xqo+7xvNQ3E4cskuTKnGON4w/hy1iP
         y7J06lJbkGFbmqPtkgHOmGwabkidzPvPv0c4P/pwa6wsHC3X6/+10iYtG84ZmI7SNqtr
         BWG4pikTgAUhi86RH9TGpYitep0ORTb/YSe7Pf6j+LWUfZeqcHsSWr9zs6UaTx1oHauS
         Fix/QW8dZrCoXATskA+MaSgRyXKQCtzKEG85Khxa8gqxSk6nS+fWAoM8JuevXVbccV1z
         4N6fSkwv6+toDgXs6dscCyZOdulx6zT1PnC1G/ICzrO4htu4SYta9PUnq9bFpTKL1qAd
         BLRg==
X-Forwarded-Encrypted: i=1; AJvYcCXullXm5+B+U2M3YzDYeAP+eicMn6uv6J7Qf7Roj9oRVPECYtp4ajWOgFO8Wuqn0zX9e78IXBT7khPwXQq/Vt1KD7WmyvpUTJ2LshZu
X-Gm-Message-State: AOJu0YxmlSwWWQfgATRN1XHcHypy72Br6FtAiYsj941fFzb0t6E1rIAm
	plO+EPgufwUT5NNsmiuZmDlxzOmCPQGDjuizLQUN1GhQCgf0Ca0OE5WbwX89udhY3zKoWVupcUG
	/gDYfOlTHrWfGPo4hnStL0/k9Sb5nBhVJagKSXSVQkUgXcyher0naFpBGanwRhg==
X-Received: by 2002:a05:6000:dc7:b0:33d:755c:30db with SMTP id dw7-20020a0560000dc700b0033d755c30dbmr7576661wrb.36.1710756318493;
        Mon, 18 Mar 2024 03:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxLLq3UtlNukzMVruSUfV8t39+9zodoprJATashixS9DJnxTEK78SLWTdqM4yJRCsnM8SOAA==
X-Received: by 2002:a05:6000:dc7:b0:33d:755c:30db with SMTP id dw7-20020a0560000dc700b0033d755c30dbmr7576636wrb.36.1710756318009;
        Mon, 18 Mar 2024 03:05:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:1f00:94ff:246b:30d0:686b? (p200300cbc7371f0094ff246b30d0686b.dip0.t-ipconnect.de. [2003:cb:c737:1f00:94ff:246b:30d0:686b])
        by smtp.gmail.com with ESMTPSA id q2-20020a05600000c200b0033dedd63382sm9362042wrx.101.2024.03.18.03.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 03:05:17 -0700 (PDT)
Message-ID: <b084270d-6c7a-400c-8f4b-0797d2ae5fa6@redhat.com>
Date: Mon, 18 Mar 2024 11:05:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] mm: vmscan: Avoid split during shrink_folio_list()
Content-Language: en-US
To: "Yin, Fengwei" <fengwei.yin@intel.com>, "Huang, Ying"
 <ying.huang@intel.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-6-ryan.roberts@arm.com>
 <d8086108-05e7-4765-a6f5-dfb85fb44b90@redhat.com>
 <1db242d3-5ff1-4ef5-b20a-578a317fa859@arm.com>
 <caafeabd-fb94-45de-9dcc-2451ddc0ef50@redhat.com>
 <5cc147fa-492e-46c3-963d-2f6e6680dce9@arm.com>
 <878r2gwahg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <a75ea34a-7512-4169-b987-95f11a7f3dd0@intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a75ea34a-7512-4169-b987-95f11a7f3dd0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.03.24 11:00, Yin, Fengwei wrote:
> 
> 
> On 3/18/2024 10:16 AM, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>
>>> Hi Yin Fengwei,
>>>
>>> On 15/03/2024 11:12, David Hildenbrand wrote:
>>>> On 15.03.24 11:49, Ryan Roberts wrote:
>>>>> On 15/03/2024 10:43, David Hildenbrand wrote:
>>>>>> On 11.03.24 16:00, Ryan Roberts wrote:
>>>>>>> Now that swap supports storing all mTHP sizes, avoid splitting large
>>>>>>> folios before swap-out. This benefits performance of the swap-out path
>>>>>>> by eliding split_folio_to_list(), which is expensive, and also sets us
>>>>>>> up for swapping in large folios in a future series.
>>>>>>>
>>>>>>> If the folio is partially mapped, we continue to split it since we want
>>>>>>> to avoid the extra IO overhead and storage of writing out pages
>>>>>>> uneccessarily.
>>>>>>>
>>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>> ---
>>>>>>>      mm/vmscan.c | 9 +++++----
>>>>>>>      1 file changed, 5 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>>> index cf7d4cf47f1a..0ebec99e04c6 100644
>>>>>>> --- a/mm/vmscan.c
>>>>>>> +++ b/mm/vmscan.c
>>>>>>> @@ -1222,11 +1222,12 @@ static unsigned int shrink_folio_list(struct list_head
>>>>>>> *folio_list,
>>>>>>>                          if (!can_split_folio(folio, NULL))
>>>>>>>                              goto activate_locked;
>>>>>>>                          /*
>>>>>>> -                     * Split folios without a PMD map right
>>>>>>> -                     * away. Chances are some or all of the
>>>>>>> -                     * tail pages can be freed without IO.
>>>>>>> +                     * Split partially mapped folios map
>>>>>>> +                     * right away. Chances are some or all
>>>>>>> +                     * of the tail pages can be freed
>>>>>>> +                     * without IO.
>>>>>>>                           */
>>>>>>> -                    if (!folio_entire_mapcount(folio) &&
>>>>>>> +                    if (!list_empty(&folio->_deferred_list) &&
>>>>>>>                              split_folio_to_list(folio,
>>>>>>>                                      folio_list))
>>>>>>>                              goto activate_locked;
>>>>>>
>>>>>> Not sure if we might have to annotate that with data_race().
>>>>>
>>>>> I asked that exact question to Matthew in another context bt didn't get a
>>>>> response. There are examples of checking if the deferred list is empty with and
>>>>> without data_race() in the code base. But list_empty() is implemented like this:
>>>>>
>>>>> static inline int list_empty(const struct list_head *head)
>>>>> {
>>>>>       return READ_ONCE(head->next) == head;
>>>>> }
>>>>>
>>>>> So I assumed the READ_ONCE() makes everything safe without a lock? Perhaps not
>>>>> sufficient for KCSAN?
> I don't think READ_ONCE() can replace the lock.
> 
>>>>
>>>> Yeah, there is only one use of data_race with that list.
>>>>
>>>> It was added in f3ebdf042df4 ("THP: avoid lock when check whether THP is in
>>>> deferred list").
>>>>
>>>> Looks like that was added right in v1 of that change [1], so my best guess is
>>>> that it is not actually required.
>>>>
>>>> If not required, likely we should just cleanup the single user.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/linux-mm/20230417075643.3287513-2-fengwei.yin@intel.com/
>>>
>>> Do you have any recollection of why you added the data_race() markup?
>>
>> Per my understanding, this is used to mark that the code accesses
>> folio->_deferred_list without lock intentionally, while
>> folio->_deferred_list may be changed in parallel.  IIUC, this is what
>> data_race() is used for.  Or, my understanding is wrong?
> Yes. This is my understanding also.

Why don't we have a data_race() in deferred_split_folio() then, before 
taking the lock?

It's used a bit inconsistently here.

-- 
Cheers,

David / dhildenb


