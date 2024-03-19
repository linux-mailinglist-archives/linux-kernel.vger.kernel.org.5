Return-Path: <linux-kernel+bounces-107664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A979587FFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6FE1C229F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EB62837D;
	Tue, 19 Mar 2024 14:40:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD34D1CFB6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859220; cv=none; b=b+aO/8jyqztKXdrAash9Kx4NaNmFVD60LjuBR/l0BXdAxz6MLUGSfJQTfMPq/H538/ylBOiZ9PRhmWOo2atBDZbTvZDTpexi7C0oReCI+rUFqaJQa/x9KtMbQLS3Lvuo9/F6foZiZWWLeM4ZNc8EVfq7Wg0hnFMh4647E/7akFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859220; c=relaxed/simple;
	bh=tNidCgihxrAmMeR6MO/7wfMbUQmJkxFO4yjmVZHebCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9hX0RNXOOM5mBXnLUxor4RllYbPeT0sP5Qk+N1zICRboOWIravDkVBL97em9jB/zM8FbkSgfnLZJXDsCJznBGUJPRpMfgPIXqAA+MIhTMAJEbDfjCaG0M2B/R6TZ5fVZxtUjvonfElCG6LfCJpv/8uPYemFnxbQV/5VXC4mj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18955106F;
	Tue, 19 Mar 2024 07:40:52 -0700 (PDT)
Received: from [10.1.30.191] (XHFQ2J9959.cambridge.arm.com [10.1.30.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F155D3F762;
	Tue, 19 Mar 2024 07:40:14 -0700 (PDT)
Message-ID: <7df7fdcb-2c3e-43da-824e-586a348ae840@arm.com>
Date: Tue, 19 Mar 2024 14:40:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] mm: vmscan: Avoid split during shrink_folio_list()
Content-Language: en-GB
To: Yin Fengwei <fengwei.yin@intel.com>, David Hildenbrand
 <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>
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
 <b084270d-6c7a-400c-8f4b-0797d2ae5fa6@redhat.com>
 <a99bd601-7599-4bb5-811d-efcb94ce8938@arm.com>
 <29f06352-d234-4f4d-b804-9560816ed055@intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <29f06352-d234-4f4d-b804-9560816ed055@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/03/2024 02:20, Yin Fengwei wrote:
> 
> 
> On 3/18/24 23:35, Ryan Roberts wrote:
>> On 18/03/2024 10:05, David Hildenbrand wrote:
>>> On 18.03.24 11:00, Yin, Fengwei wrote:
>>>>
>>>>
>>>> On 3/18/2024 10:16 AM, Huang, Ying wrote:
>>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>>
>>>>>> Hi Yin Fengwei,
>>>>>>
>>>>>> On 15/03/2024 11:12, David Hildenbrand wrote:
>>>>>>> On 15.03.24 11:49, Ryan Roberts wrote:
>>>>>>>> On 15/03/2024 10:43, David Hildenbrand wrote:
>>>>>>>>> On 11.03.24 16:00, Ryan Roberts wrote:
>>>>>>>>>> Now that swap supports storing all mTHP sizes, avoid splitting large
>>>>>>>>>> folios before swap-out. This benefits performance of the swap-out path
>>>>>>>>>> by eliding split_folio_to_list(), which is expensive, and also sets us
>>>>>>>>>> up for swapping in large folios in a future series.
>>>>>>>>>>
>>>>>>>>>> If the folio is partially mapped, we continue to split it since we want
>>>>>>>>>> to avoid the extra IO overhead and storage of writing out pages
>>>>>>>>>> uneccessarily.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>>>> ---
>>>>>>>>>>      mm/vmscan.c | 9 +++++----
>>>>>>>>>>      1 file changed, 5 insertions(+), 4 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>>>>>> index cf7d4cf47f1a..0ebec99e04c6 100644
>>>>>>>>>> --- a/mm/vmscan.c
>>>>>>>>>> +++ b/mm/vmscan.c
>>>>>>>>>> @@ -1222,11 +1222,12 @@ static unsigned int shrink_folio_list(struct
>>>>>>>>>> list_head
>>>>>>>>>> *folio_list,
>>>>>>>>>>                          if (!can_split_folio(folio, NULL))
>>>>>>>>>>                              goto activate_locked;
>>>>>>>>>>                          /*
>>>>>>>>>> -                     * Split folios without a PMD map right
>>>>>>>>>> -                     * away. Chances are some or all of the
>>>>>>>>>> -                     * tail pages can be freed without IO.
>>>>>>>>>> +                     * Split partially mapped folios map
>>>>>>>>>> +                     * right away. Chances are some or all
>>>>>>>>>> +                     * of the tail pages can be freed
>>>>>>>>>> +                     * without IO.
>>>>>>>>>>                           */
>>>>>>>>>> -                    if (!folio_entire_mapcount(folio) &&
>>>>>>>>>> +                    if (!list_empty(&folio->_deferred_list) &&
>>>>>>>>>>                              split_folio_to_list(folio,
>>>>>>>>>>                                      folio_list))
>>>>>>>>>>                              goto activate_locked;
>>>>>>>>>
>>>>>>>>> Not sure if we might have to annotate that with data_race().
>>>>>>>>
>>>>>>>> I asked that exact question to Matthew in another context bt didn't get a
>>>>>>>> response. There are examples of checking if the deferred list is empty
>>>>>>>> with and
>>>>>>>> without data_race() in the code base. But list_empty() is implemented like
>>>>>>>> this:
>>>>>>>>
>>>>>>>> static inline int list_empty(const struct list_head *head)
>>>>>>>> {
>>>>>>>>       return READ_ONCE(head->next) == head;
>>>>>>>> }
>>>>>>>>
>>>>>>>> So I assumed the READ_ONCE() makes everything safe without a lock? Perhaps
>>>>>>>> not
>>>>>>>> sufficient for KCSAN?
>>>> I don't think READ_ONCE() can replace the lock.
>>
>> But it doesn't ensure we get a consistent value and that the compiler orders the
>> load correctly. There are lots of patterns in the kernel that use READ_ONCE()
>> without a lock and they don't use data_race() - e.g. ptep_get_lockless().
> They (ptep_get_lockless() and deferred_list) have different access pattern
> (or race pattern) here. I don't think they are comparable.
> 
>>
>> It sounds like none of us really understand what data_race() is for, so I guess
>> I'll just do a KCSAN build and invoke the code path to see if it complains.
> READ_ONCE() in list_empty will shutdown the KCSAN also.

OK, I found some time to run the test with KCSAN; nothing fires.

But then I read the docs and looked at the code a bit.
Documentation/dev-tools/kcsan.rst states:

    In an execution, two memory accesses form a *data race* if they *conflict*,
    they happen concurrently in different threads, and at least one of them is a
    *plain access*; they *conflict* if both access the same memory location, and
    at least one is a write.

It also clarifies the READ_ONCE() is a "marked access". So we would have a data
race if there was a concurrent, *plain* write to folio->_deferred_list.next.
This can occur in a couple of places I believe, for example:

deferred_split_folio()
  list_add_tail()
    __list_add()
      new->next = next;

deferred_split_scan()
  list_move()
    list_add()
      __list_add()
        new->next = next;

So if either partially deferred_split_folio() or deferred_split_scan() can run
concurrently with shrink_folio_list(), for the same folio (I beleive both can
can), then we have a race, and this list_empty() check needs to be protected
with data_race(). The race is safe/by design, but it does need to be marked.

I'll fix this in my next version.

Thanks,
Ryan


> 
>>
>>
>>>>
>>>>>>>
>>>>>>> Yeah, there is only one use of data_race with that list.
>>>>>>>
>>>>>>> It was added in f3ebdf042df4 ("THP: avoid lock when check whether THP is in
>>>>>>> deferred list").
>>>>>>>
>>>>>>> Looks like that was added right in v1 of that change [1], so my best guess is
>>>>>>> that it is not actually required.
>>>>>>>
>>>>>>> If not required, likely we should just cleanup the single user.
>>>>>>>
>>>>>>> [1]
>>>>>>> https://lore.kernel.org/linux-mm/20230417075643.3287513-2-fengwei.yin@intel.com/
>>>>>>
>>>>>> Do you have any recollection of why you added the data_race() markup?
>>>>>
>>>>> Per my understanding, this is used to mark that the code accesses
>>>>> folio->_deferred_list without lock intentionally, while
>>>>> folio->_deferred_list may be changed in parallel.  IIUC, this is what
>>>>> data_race() is used for.  Or, my understanding is wrong?
>>>> Yes. This is my understanding also.
>>>
>>> Why don't we have a data_race() in deferred_split_folio() then, before taking
>>> the lock?
>>>
>>> It's used a bit inconsistently here.
>>>
>>


