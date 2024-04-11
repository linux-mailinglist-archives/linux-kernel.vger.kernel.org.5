Return-Path: <linux-kernel+bounces-140934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 273908A19B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE7E1F2186D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0C01C8FCA;
	Thu, 11 Apr 2024 15:36:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C511E1C68B7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849782; cv=none; b=QLa+65EHFqFMHpE8cw1mQU2bWdRDLLiyF3eUTNjwsWGKBZGanLwHWJfpfkL3JMlCIIRTYqNWM705f7kEiPSTdN9OGeYdKcgAHncK0ApDUbiIzMb/INcfW/galEhP6GP6eY0Ev5m2yN93CX+IirK0CDtnrjfhffHOYtZau0oM9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849782; c=relaxed/simple;
	bh=lSpO5N3OlyIzN7lj7ATsayB4xRn97x2Y1rSLv/7Juc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGXOa9p0sC2afmas8EzB+MjZFkk0qpXBlx01PvuCmtMSP/BJkxe7aoJJSpIT6sdClH/L70ev+JYTCLrX2uMaLZ1aDHpbU5+nqr9OPH9rIBb8uPMXGrgKw32u4OAKOpv6vpDTj1Rug1eH2BFD0YTCnBmDtYvlFQ9QIydzPJRO4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6FEC113E;
	Thu, 11 Apr 2024 08:36:49 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04FD43F6C4;
	Thu, 11 Apr 2024 08:36:17 -0700 (PDT)
Message-ID: <ccbcbbb5-24eb-4503-ac7b-3171d39536e7@arm.com>
Date: Thu, 11 Apr 2024 16:36:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: swap_pte_batch: add an output argument to
 reture if all swap entries are exclusive
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com,
 hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com, linux-kernel@vger.kernel.org
References: <20240409082631.187483-1-21cnbao@gmail.com>
 <20240409082631.187483-4-21cnbao@gmail.com>
 <744f795b-7ce8-40ab-911b-60906aa4fed1@arm.com>
 <a5a55919-46bc-4107-a0fc-14dc404e8c90@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <a5a55919-46bc-4107-a0fc-14dc404e8c90@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/2024 16:00, David Hildenbrand wrote:
> On 11.04.24 16:54, Ryan Roberts wrote:
>> On 09/04/2024 09:26, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> Add a boolean argument named any_shared. If any of the swap entries are
>>> non-exclusive, set any_shared to true. The function do_swap_page() can
>>> then utilize this information to determine whether the entire large
>>> folio can be reused.
>>>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> ---
>>>   mm/internal.h | 9 ++++++++-
>>>   mm/madvise.c  | 2 +-
>>>   mm/memory.c   | 2 +-
>>>   3 files changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 9d3250b4a08a..cae39c372bfc 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -238,7 +238,8 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
>>>    *
>>>    * Return: the number of table entries in the batch.
>>>    */
>>> -static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
>>> +static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte,
>>> +                bool *any_shared)
>>
>> Please update the docs in the comment above this for the new param; follow
>> folio_pte_batch()'s docs as a template.
>>
>>>   {
>>>       pte_t expected_pte = pte_next_swp_offset(pte);
>>>       const pte_t *end_ptep = start_ptep + max_nr;
>>> @@ -248,12 +249,18 @@ static inline int swap_pte_batch(pte_t *start_ptep, int
>>> max_nr, pte_t pte)
>>>       VM_WARN_ON(!is_swap_pte(pte));
>>>       VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));
>>>   +    if (any_shared)
>>> +        *any_shared |= !pte_swp_exclusive(pte);
>>
>> This is different from the approach in folio_pte_batch(). It inits *any_shared
>> to false and does NOT include the value of the first pte. I think that's odd,
>> personally and I prefer your approach. I'm not sure if there was a good reason
>> that David chose the other approach?
> 
> Because in my case calling code does
> 
> nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr, flags,
>              &any_writable);
> 
> ...
> 
> if (any_writable)
>     pte = pte_mkwrite(pte, src_vma);
> 
> ...
> 
> and later checks in another function pte_write().
> 
> So if the common pattern is that the original PTE will be used for checks, then
> it doesn't make sense to unnecessary checks+setting for the first PTE.

Yep understood. And I think adopting your semantics for any_shared actually
simplifies the code in patch 4 too; I've just commented that.




