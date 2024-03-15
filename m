Return-Path: <linux-kernel+bounces-104293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F2887CBB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7491C21F69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2042619478;
	Fri, 15 Mar 2024 10:57:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0332118E02
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500273; cv=none; b=W/dCYPGyGBUfLypoJEvzLibopwMieAOAsskG405EhE6cZZKN07/xrS6mTFmS4fnkJKvT4N949b1vqBss8gmLo5EPi5QwPRuDaxA50fJTYTO93Sj48Apa51hfrD6RLTMj/9jYT+t7z4q8BOJFZFvQ7jKT+hop+BlhO6p/Rk14mMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500273; c=relaxed/simple;
	bh=1aiyF0/x+T+SS07nzEDYgrQV2Q7jpEGhZTYThVJZ8Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhucnYZlrsnm23XTYjn4kONwTvn/NaKP3v56mHGUqVvINarAfTB7j2vm89d3FLTf2s02OIEv66nmTx1ScwJ9jWEZKDbN7g5QabEb0n7BTpK7nQNr7uvi3zIjEQjjU/gMCxwADOLICfKgEPXh7cupknqYGH1HOHSyOneRcvddy8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80A23C15;
	Fri, 15 Mar 2024 03:58:25 -0700 (PDT)
Received: from [10.57.69.160] (unknown [10.57.69.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C71683F762;
	Fri, 15 Mar 2024 03:57:45 -0700 (PDT)
Message-ID: <76c16222-78fd-4d96-b9f7-13264bb37747@arm.com>
Date: Fri, 15 Mar 2024 10:57:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/5] mm: swap: introduce swap_nr_free() for batched
 swap_free()
Content-Language: en-GB
To: Chuanhua Han <chuanhuahan@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, chengming.zhou@linux.dev, chrisl@kernel.org,
 david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com,
 steven.price@arm.com, surenb@google.com, wangkefeng.wang@huawei.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, Chuanhua Han
 <hanchuanhua@oppo.com>, Barry Song <v-songbaohua@oppo.com>
References: <20240304081348.197341-1-21cnbao@gmail.com>
 <20240304081348.197341-3-21cnbao@gmail.com>
 <499a60c6-eeb8-4bbd-8563-9717c0d2e43d@arm.com>
 <CANzGp4+kSxc_JbOsOcvm6vXfu2KORaqqGyuKK_eJwCLTK5X__Q@mail.gmail.com>
 <716bb29c-d2a2-4eef-b300-b037f08f458f@arm.com>
 <CANzGp4KC4ucxJv_h2CZCgLUZ=x8J5sp4i46C02Gx9ddvF3sKrg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CANzGp4KC4ucxJv_h2CZCgLUZ=x8J5sp4i46C02Gx9ddvF3sKrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/03/2024 08:34, Chuanhua Han wrote:
> Ryan Roberts <ryan.roberts@arm.com> 于2024年3月14日周四 21:43写道：
>>
>> On 14/03/2024 13:12, Chuanhua Han wrote:
>>> Ryan Roberts <ryan.roberts@arm.com> 于2024年3月12日周二 02:51写道：
>>>>
>>>> On 04/03/2024 08:13, Barry Song wrote:
>>>>> From: Chuanhua Han <hanchuanhua@oppo.com>
>>>>>
>>>>> While swapping in a large folio, we need to free swaps related to the whole
>>>>> folio. To avoid frequently acquiring and releasing swap locks, it is better
>>>>> to introduce an API for batched free.
>>>>>
>>>>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
>>>>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>>> ---
>>>>>  include/linux/swap.h |  6 ++++++
>>>>>  mm/swapfile.c        | 35 +++++++++++++++++++++++++++++++++++
>>>>>  2 files changed, 41 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>>> index 2955f7a78d8d..d6ab27929458 100644
>>>>> --- a/include/linux/swap.h
>>>>> +++ b/include/linux/swap.h
>>>>> @@ -481,6 +481,7 @@ extern void swap_shmem_alloc(swp_entry_t);
>>>>>  extern int swap_duplicate(swp_entry_t);
>>>>>  extern int swapcache_prepare(swp_entry_t);
>>>>>  extern void swap_free(swp_entry_t);
>>>>> +extern void swap_nr_free(swp_entry_t entry, int nr_pages);
>>>>
>>>> nit: In my swap-out v4 series, I've created a batched version of
>>>> free_swap_and_cache() and called it free_swap_and_cache_nr(). Perhaps it is
>>>> preferable to align the naming schemes - i.e. call this swap_free_nr(). Your
>>>> scheme doesn't really work when applied to free_swap_and_cache().
>>> Thanks for your suggestions, and for the next version, we'll see which
>>> package is more appropriate!
>>>>
>>>>>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>>>>>  extern int free_swap_and_cache(swp_entry_t);
>>>>>  int swap_type_of(dev_t device, sector_t offset);
>>>>> @@ -561,6 +562,11 @@ static inline void swap_free(swp_entry_t swp)
>>>>>  {
>>>>>  }
>>>>>
>>>>> +void swap_nr_free(swp_entry_t entry, int nr_pages)
>>>>> +{
>>>>> +
>>>>> +}
>>>>> +
>>>>>  static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
>>>>>  {
>>>>>  }
>>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>>>> index 3f594be83b58..244106998a69 100644
>>>>> --- a/mm/swapfile.c
>>>>> +++ b/mm/swapfile.c
>>>>> @@ -1341,6 +1341,41 @@ void swap_free(swp_entry_t entry)
>>>>>               __swap_entry_free(p, entry);
>>>>>  }
>>>>>
>>>>> +/*
>>>>> + * Called after swapping in a large folio, batched free swap entries
>>>>> + * for this large folio, entry should be for the first subpage and
>>>>> + * its offset is aligned with nr_pages
>>>>> + */
>>>>> +void swap_nr_free(swp_entry_t entry, int nr_pages)
>>>>> +{
>>>>> +     int i;
>>>>> +     struct swap_cluster_info *ci;
>>>>> +     struct swap_info_struct *p;
>>>>> +     unsigned type = swp_type(entry);
>>>>
>>>> nit: checkpatch.py will complain about bare "unsigned", preferring "unsigned
>>>> int" or at least it did for me when I did something similar in my swap-out patch
>>>> set.
>>> Gee, thanks for pointing that out!
>>>>
>>>>> +     unsigned long offset = swp_offset(entry);
>>>>> +     DECLARE_BITMAP(usage, SWAPFILE_CLUSTER) = { 0 };
>>>>
>>>> I don't love this, as it could blow the stack if SWAPFILE_CLUSTER ever
>>>> increases. But the only other way I can think of is to explicitly loop over
>>>> fixed size chunks, and that's not much better.
>>> Is it possible to save kernel stack better by using bit_map here?  If
>>> SWAPFILE_CLUSTER=512, we consume only (512/64)*8= 64 bytes.
>>
>> I'm not sure I've understood what you are saying? You're already using
>> DECLARE_BITMAP(), so its already consuming 64 bytes if SWAPFILE_CLUSTER=512, no?
>>
>> I actually did a bad job of trying to express a couple of different points:
>>
>> - Are there any configurations today where SWAPFILE_CLUSTER > 512? I'm not sure.
>> Certainly not for arm64, but not sure about other architectures. For example if
>> an arch had 64K pages with 8192 entries per THP and supports SWAP_THP, that's 1K
>> for the bitmap, which is now looking pretty big for the stack.
> I agree with you.The current bit_map grows linearly with the
> SWAPFILE_CLUSTER, which may cause the kernel stack to swell.
> I need to think of a way to save more memory .
>>
>> - Would it be better to decouple stack usage from SWAPFILE_CLUSTER and instead
>> define a fixed stack size (e.g. 64 bytes -> 512 entries). Then free the range of
>> entries in batches no bigger than this size. This approach could also allow
>> removing the constraint that the range has to be aligned and fit in a single
>> cluster. Personally I think an approach like this would be much more robust, in
>> return for a tiny bit more complexity.
> Because we cannot determine how many swap entries a cluster has in an
> architecture or a configuration, we do not know how large the variable
> needs to be defined？

My point is that we could define a fixed size, then loop through the passed in
range, operating on batches of that fixed size. You could even take into
consideration the cluster boundaries so that you take the correct lock for every
batch and can drop the "must be naturally aligned, must be no bigger than
cluster size" constraint.


>>
>>>>
>>>>> +
>>>>> +     /* all swap entries are within a cluster for mTHP */
>>>>> +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUSTER);
>>>>> +
>>>>> +     if (nr_pages == 1) {
>>>>> +             swap_free(entry);
>>>>> +             return;
>>>>> +     }
>>>>> +
>>>>> +     p = _swap_info_get(entry);
>>>>
>>>> You need to handle this returning NULL, like swap_free() does.
>>> Yes, you're right! We did forget to judge NULL here.
>>>>
>>>>> +
>>>>> +     ci = lock_cluster(p, offset);
>>>>
>>>> The existing swap_free() calls lock_cluster_or_swap_info(). So if swap is backed
>>>> by rotating media, and clusters are not in use, it will lock the whole swap
>>>> info. But your new version only calls lock_cluster() which won't lock anything
>>>> if clusters are not in use. So I think this is a locking bug.
>>> Again, you're right, it's bug!
>>>>
>>>>> +     for (i = 0; i < nr_pages; i++) {
>>>>> +             if (__swap_entry_free_locked(p, offset + i, 1))
>>>>> +                     __bitmap_set(usage, i, 1);
>>>>> +     }
>>>>> +     unlock_cluster(ci);
>>>>> +
>>>>> +     for_each_clear_bit(i, usage, nr_pages)
>>>>> +             free_swap_slot(swp_entry(type, offset + i));
>>>>> +}
>>>>> +
>>>>>  /*
>>>>>   * Called after dropping swapcache to decrease refcnt to swap entries.
>>>>>   */
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>
>>>
>>>
>>
> 
> 


