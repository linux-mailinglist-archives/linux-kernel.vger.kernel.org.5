Return-Path: <linux-kernel+bounces-142580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E138A2D63
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCE028250D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B69B54FBE;
	Fri, 12 Apr 2024 11:28:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42EE5490A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921310; cv=none; b=NB3JWBgXrUcO0IM5bRSeglyMwVEXUBRK4VtiYr9VZOLs1HoIwsj72uyJ/ZdDrZnDGYdG5EI898ydlQvEIKLqPteB30M28AlGBio0yROO3uVOXHn+1kNuLEqm4htfVreHE2jyDxCUsh+spB1BJlIyrPqL/+4f+kYgAxZo0b81Z6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921310; c=relaxed/simple;
	bh=iFkkJ4gu5lFXEXw2w7qqEFUR/9XtHssnEUIom6DrWVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNEyKu02Jr/L1/rcG5Z/SmTp3iNVT9qFDDVw32jeS5i+gLKWmhXTZTbBRTMh3hMxxsZosUu7jo8Jn/D48cwl4Jbaqk16o0dPRZkmT31dIIAdFX/suCLxu7EauYt1OM8W/pSbmnIq7poFjjBaFPlIwhnykAo+Wvg7k53iyzqyYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C208D339;
	Fri, 12 Apr 2024 04:28:56 -0700 (PDT)
Received: from [10.57.73.208] (unknown [10.57.73.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA6D73F766;
	Fri, 12 Apr 2024 04:28:24 -0700 (PDT)
Message-ID: <66afc978-0221-488b-9fc6-7d5213d385ed@arm.com>
Date: Fri, 12 Apr 2024 12:28:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mm: swap: introduce swap_free_nr() for batched
 swap_free()
Content-Language: en-GB
To: Chuanhua Han <chuanhuahan@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 david@redhat.com, hanchuanhua@oppo.com, hannes@cmpxchg.org,
 hughd@google.com, kasong@tencent.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com, linux-kernel@vger.kernel.org
References: <20240409082631.187483-1-21cnbao@gmail.com>
 <20240409082631.187483-2-21cnbao@gmail.com>
 <95bc0ebb-49f4-4331-8809-3e4625f1d91a@arm.com>
 <CANzGp4Jzw9bUnQw1zVdw7V6=pARx7x5s8QTyXJGfdEzrXVkZTA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CANzGp4Jzw9bUnQw1zVdw7V6=pARx7x5s8QTyXJGfdEzrXVkZTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/04/2024 03:07, Chuanhua Han wrote:
> Ryan Roberts <ryan.roberts@arm.com> 于2024年4月11日周四 22:30写道：
>>
>> On 09/04/2024 09:26, Barry Song wrote:
>>> From: Chuanhua Han <hanchuanhua@oppo.com>
>>>
>>> While swapping in a large folio, we need to free swaps related to the whole
>>> folio. To avoid frequently acquiring and releasing swap locks, it is better
>>> to introduce an API for batched free.
>>>
>>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
>>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>
>> Couple of nits; feel free to ignore.
>>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>>
>>> ---
>>>  include/linux/swap.h |  5 +++++
>>>  mm/swapfile.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 56 insertions(+)
>>>
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index 11c53692f65f..b7a107e983b8 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
>>>  extern int swap_duplicate(swp_entry_t);
>>>  extern int swapcache_prepare(swp_entry_t);
>>>  extern void swap_free(swp_entry_t);
>>> +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>>>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>>>  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
>>>  int swap_type_of(dev_t device, sector_t offset);
>>> @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t swp)
>>>  {
>>>  }
>>>
>>> +void swap_free_nr(swp_entry_t entry, int nr_pages)
>>> +{
>>> +}
>>> +
>>>  static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
>>>  {
>>>  }
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index 28642c188c93..f4c65aeb088d 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
>>>               __swap_entry_free(p, entry);
>>>  }
>>>
>>> +/*
>>> + * Free up the maximum number of swap entries at once to limit the
>>> + * maximum kernel stack usage.
>>> + */
>>> +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLUSTER)
>>> +
>>> +/*
>>> + * Called after swapping in a large folio, batched free swap entries
>>> + * for this large folio, entry should be for the first subpage and
>>> + * its offset is aligned with nr_pages
>>> + */
>>> +void swap_free_nr(swp_entry_t entry, int nr_pages)
>>> +{
>>> +     int i, j;
>>> +     struct swap_cluster_info *ci;
>>> +     struct swap_info_struct *p;
>>> +     unsigned int type = swp_type(entry);
>>> +     unsigned long offset = swp_offset(entry);
>>> +     int batch_nr, remain_nr;
>>> +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) = { 0 };
>>> +
>>> +     /* all swap entries are within a cluster for mTHP */
>>> +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUSTER);
>>> +
>>> +     if (nr_pages == 1) {
>>> +             swap_free(entry);
>>> +             return;
>>> +     }
>>> +
>>> +     remain_nr = nr_pages;
>>> +     p = _swap_info_get(entry);
>>> +     if (p) {
>>
>> nit: perhaps return early if (!p) ? Then you dedent the for() block.
> 
> Agreed!
> 
>>
>>> +             for (i = 0; i < nr_pages; i += batch_nr) {
>>> +                     batch_nr = min_t(int, SWAP_BATCH_NR, remain_nr);
>>> +
>>> +                     ci = lock_cluster_or_swap_info(p, offset);
>>> +                     for (j = 0; j < batch_nr; j++) {
>>> +                             if (__swap_entry_free_locked(p, offset + i * SWAP_BATCH_NR + j, 1))
>>> +                                     __bitmap_set(usage, j, 1);
>>> +                     }
>>> +                     unlock_cluster_or_swap_info(p, ci);
>>> +
>>> +                     for_each_clear_bit(j, usage, batch_nr)
>>> +                             free_swap_slot(swp_entry(type, offset + i * SWAP_BATCH_NR + j));
>>> +
>>
>> nit: perhaps change to for (;;), and do the checks here to avoid clearing the
>> bitmap on the last run:
>>
>>                         i += batch_nr;
>>                         if (i < nr_pages)
>>                                 break;
> Great, thank you for your advice!

Or maybe leave the for() as is, but don't explicitly init the bitmap at the
start of the function and instead call:

	bitmap_clear(usage, 0, SWAP_BATCH_NR);

At the start of each loop?

>>
>>> +                     bitmap_clear(usage, 0, SWAP_BATCH_NR);
>>> +                     remain_nr -= batch_nr;
>>> +             }
>>> +     }
>>> +}
>>> +
>>>  /*
>>>   * Called after dropping swapcache to decrease refcnt to swap entries.
>>>   */
>>
>>
> 
> 


