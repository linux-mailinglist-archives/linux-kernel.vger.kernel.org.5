Return-Path: <linux-kernel+bounces-106310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0670F87EC43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738611F21941
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C3B524AD;
	Mon, 18 Mar 2024 15:35:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8640C51C47
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776151; cv=none; b=rVlrMRh5tnlNmV5Ag5j4ZGSO1lB9rof1L0OiStVtX2cNWzPRMRSN718MV+qQ50OY+C4ee+OxL5qEBxGIXP6aIGXwAOk31mfYbtjkELE1LpWi1Qa+BsTrR0wDpu03bbO4rlhEqeNpfZIPP902PYVJQI+vwsBHxvoSvO+nZBEeqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776151; c=relaxed/simple;
	bh=U3H71QwkPMiqIJ2+6FcCRf/gkK9CN5HhGOPJxNvqYX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzVhViUwYp2oxgSoZsPMq6zqZkVU/R1XhjnEvkaZ9sxcDQzfp6OPgYxWXMzbVW3/oafftNnN9OwNdcL9mPzqlOzvgpvnchcng2ilX2vHoR/HuvgnT8XkUUbpKdN0O7ZDCe9eUYeOp//6BHvsn2ckRYDeqCqM+QFK/vqXTUA0IKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDD97DA7;
	Mon, 18 Mar 2024 08:36:22 -0700 (PDT)
Received: from [10.57.68.51] (unknown [10.57.68.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 256453F67D;
	Mon, 18 Mar 2024 08:35:44 -0700 (PDT)
Message-ID: <a99bd601-7599-4bb5-811d-efcb94ce8938@arm.com>
Date: Mon, 18 Mar 2024 15:35:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] mm: vmscan: Avoid split during shrink_folio_list()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, "Yin, Fengwei"
 <fengwei.yin@intel.com>, "Huang, Ying" <ying.huang@intel.com>
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <b084270d-6c7a-400c-8f4b-0797d2ae5fa6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/03/2024 10:05, David Hildenbrand wrote:
> On 18.03.24 11:00, Yin, Fengwei wrote:
>>
>>
>> On 3/18/2024 10:16 AM, Huang, Ying wrote:
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>>> Hi Yin Fengwei,
>>>>
>>>> On 15/03/2024 11:12, David Hildenbrand wrote:
>>>>> On 15.03.24 11:49, Ryan Roberts wrote:
>>>>>> On 15/03/2024 10:43, David Hildenbrand wrote:
>>>>>>> On 11.03.24 16:00, Ryan Roberts wrote:
>>>>>>>> Now that swap supports storing all mTHP sizes, avoid splitting large
>>>>>>>> folios before swap-out. This benefits performance of the swap-out path
>>>>>>>> by eliding split_folio_to_list(), which is expensive, and also sets us
>>>>>>>> up for swapping in large folios in a future series.
>>>>>>>>
>>>>>>>> If the folio is partially mapped, we continue to split it since we want
>>>>>>>> to avoid the extra IO overhead and storage of writing out pages
>>>>>>>> uneccessarily.
>>>>>>>>
>>>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>> ---
>>>>>>>>      mm/vmscan.c | 9 +++++----
>>>>>>>>      1 file changed, 5 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>>>> index cf7d4cf47f1a..0ebec99e04c6 100644
>>>>>>>> --- a/mm/vmscan.c
>>>>>>>> +++ b/mm/vmscan.c
>>>>>>>> @@ -1222,11 +1222,12 @@ static unsigned int shrink_folio_list(struct
>>>>>>>> list_head
>>>>>>>> *folio_list,
>>>>>>>>                          if (!can_split_folio(folio, NULL))
>>>>>>>>                              goto activate_locked;
>>>>>>>>                          /*
>>>>>>>> -                     * Split folios without a PMD map right
>>>>>>>> -                     * away. Chances are some or all of the
>>>>>>>> -                     * tail pages can be freed without IO.
>>>>>>>> +                     * Split partially mapped folios map
>>>>>>>> +                     * right away. Chances are some or all
>>>>>>>> +                     * of the tail pages can be freed
>>>>>>>> +                     * without IO.
>>>>>>>>                           */
>>>>>>>> -                    if (!folio_entire_mapcount(folio) &&
>>>>>>>> +                    if (!list_empty(&folio->_deferred_list) &&
>>>>>>>>                              split_folio_to_list(folio,
>>>>>>>>                                      folio_list))
>>>>>>>>                              goto activate_locked;
>>>>>>>
>>>>>>> Not sure if we might have to annotate that with data_race().
>>>>>>
>>>>>> I asked that exact question to Matthew in another context bt didn't get a
>>>>>> response. There are examples of checking if the deferred list is empty
>>>>>> with and
>>>>>> without data_race() in the code base. But list_empty() is implemented like
>>>>>> this:
>>>>>>
>>>>>> static inline int list_empty(const struct list_head *head)
>>>>>> {
>>>>>>       return READ_ONCE(head->next) == head;
>>>>>> }
>>>>>>
>>>>>> So I assumed the READ_ONCE() makes everything safe without a lock? Perhaps
>>>>>> not
>>>>>> sufficient for KCSAN?
>> I don't think READ_ONCE() can replace the lock.

But it doesn't ensure we get a consistent value and that the compiler orders the
load correctly. There are lots of patterns in the kernel that use READ_ONCE()
without a lock and they don't use data_race() - e.g. ptep_get_lockless().

It sounds like none of us really understand what data_race() is for, so I guess
I'll just do a KCSAN build and invoke the code path to see if it complains.


>>
>>>>>
>>>>> Yeah, there is only one use of data_race with that list.
>>>>>
>>>>> It was added in f3ebdf042df4 ("THP: avoid lock when check whether THP is in
>>>>> deferred list").
>>>>>
>>>>> Looks like that was added right in v1 of that change [1], so my best guess is
>>>>> that it is not actually required.
>>>>>
>>>>> If not required, likely we should just cleanup the single user.
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/linux-mm/20230417075643.3287513-2-fengwei.yin@intel.com/
>>>>
>>>> Do you have any recollection of why you added the data_race() markup?
>>>
>>> Per my understanding, this is used to mark that the code accesses
>>> folio->_deferred_list without lock intentionally, while
>>> folio->_deferred_list may be changed in parallel.  IIUC, this is what
>>> data_race() is used for.  Or, my understanding is wrong?
>> Yes. This is my understanding also.
> 
> Why don't we have a data_race() in deferred_split_folio() then, before taking
> the lock?
> 
> It's used a bit inconsistently here.
> 


