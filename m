Return-Path: <linux-kernel+bounces-72352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6061885B256
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A3D281E83
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB1B56B91;
	Tue, 20 Feb 2024 05:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RnyhgoBD"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176DF54FA0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407487; cv=none; b=rN3UpPFIQn75RJXVjoJquVo6nO+cqSaSnIaQdaNkroWza2BGtimRxAOGqQRSUvGGZMfzRBlPSTXqtwMqjJkD0dPKaH+JSGLvsvT2b0ZnxQ2R8x6qOX8QZrYSLGuQHcReUcgQhOv/KzhTe6QOW+jRc4uKocIA3bNbILDjzdhOTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407487; c=relaxed/simple;
	bh=Ku/IAQSiD44IFUUn/73TCUKu2GkbqVlLZ2Be6BI+el0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7my10v0BNL8aufKrwo/dM88VbTLezjBrUmuR/Udd1K23PwL9Qw5gnecuNoYR2cJK6kauUJMKH5aNhPnu4ABNc296JXzhmQZZ47Yp8TIEaJJTHRgWfOD4l3Rvics4sv2upbm8jHSQBSZrPtgsjxWI2JsEDh+pBG760Cf9lF0LRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RnyhgoBD; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c15dd2a1fdso1029613b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708407484; x=1709012284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsUbBKxG+9/DSpuC0GbtFN56JUFXR38SfCxEBxcRQTc=;
        b=RnyhgoBDPoEDGlttEXzcZZGrsemWOk6q/i/aNvSUz47Y0od0TQ6gWdDEGYTxYhPn/B
         5SeUDEAivoL2daPYrdy0rL4v5A9leR9nIHPrkJfnXzx+dJe9Lj9+VKxFayEiPDq6j+b6
         oVYpIfMIFQkXuVhTdrZ5S0QTl5GtHQe/M2kKiIL4shL+hhx2eSrmS+6lKPQ4yJkjgcxe
         CRXFbEzdiJX7qyilVj2Ny1Xz+/EgYJQIQAKlFkbVXz7rYz5AuFueBx8BI7yvK65Q2G4k
         t9X5EN/mhCMK3fy+ucj+QovH2GN6mtAjev3xWrdwwZ90Abkh/bEoCLkmhLSrL7rK76fF
         qqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708407484; x=1709012284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsUbBKxG+9/DSpuC0GbtFN56JUFXR38SfCxEBxcRQTc=;
        b=lJE6DOmTfjVwhzkdGRmdD+3kVG1k9/8S7ry/RcT0WXEjHPB/WRmXRir/C4GHXox248
         Mceyk1E3jWRDDBGRwYTMvNlY/U54dVUb08ubv6ajSVLzaJce9fKM1+bqDUBqmSy940Az
         9JKlfbusTXgLWMqnYmXSf1kCf9SzqufnMJkztAgh4ZxywJgNSlm896Hyy9TS9zNA4xpi
         RFarX/dk9AmsrHZobwP7ksNKkPaYQL+3TYORPk/7zkEIUwqv98BIm/mHBhVIHaFI/Sj3
         t1Xo3o/UiPXtc9nzjhTO4vzZFK8Im8Ogvrl54o6SWjHyjiM7BEBoAESSJqljIOSq3GZ9
         hCRg==
X-Forwarded-Encrypted: i=1; AJvYcCUlZKFdL0ZkzRolrZevH8HdK0ThVVQuH9FJz43E8VwUwr5tryYVL7FmPZvQE8CtQRm3XuFXh3z+0U+CkW+WSVGOnR2A/xOUg8Q6Euz9
X-Gm-Message-State: AOJu0YxGMaYQadAcZkrizJ9gZ3GusIDXRLeE1B4PoFI02mFmugl9ItAc
	dNH6BgyIkaXXEW72SIYhyZsfSulTRtKN2bIjnbjZlxl3OW3Rghq2KcZmii87y0k=
X-Google-Smtp-Source: AGHT+IHW8CqKtgBQfHGmTQx8RqPz0IXldVfckF1KCEDOZ+r8iwRuYqBrJF3hw5h1Yuf2GeB0nZgK9Q==
X-Received: by 2002:a05:6358:5716:b0:17a:e876:1148 with SMTP id a22-20020a056358571600b0017ae8761148mr20647663rwf.12.1708407483888;
        Mon, 19 Feb 2024 21:38:03 -0800 (PST)
Received: from [10.254.117.3] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id q18-20020a056a00085200b006e47d62150fsm347952pfk.211.2024.02.19.21.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 21:38:03 -0800 (PST)
Message-ID: <c156d1c4-a5f2-4207-8b5f-10f38e0ce6fe@bytedance.com>
Date: Tue, 20 Feb 2024 13:37:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/swap: fix race when skipping swapcache
Content-Language: en-US
To: Kairui Song <ryncsn@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, "Huang, Ying" <ying.huang@intel.com>,
 linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Chris Li <chrisl@kernel.org>, Minchan Kim <minchan@kernel.org>,
 Barry Song <v-songbaohua@oppo.com>, Yu Zhao <yuzhao@google.com>,
 SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Yosry Ahmed <yosryahmed@google.com>, Aaron Lu <aaron.lu@intel.com>,
 stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20240219082040.7495-1-ryncsn@gmail.com>
 <CAGsJ_4xX+K=f_4g2c7NcpYqWH0_bvQshxgz_YoDscqeHwWpM0w@mail.gmail.com>
 <dfac93be-db4c-4e37-a750-93cb19d07a68@bytedance.com>
 <CAMgjq7A9Gy0QK1f379wR6gp=dJM9DLSqMDq8OH5nMF_XxiOggQ@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAMgjq7A9Gy0QK1f379wR6gp=dJM9DLSqMDq8OH5nMF_XxiOggQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/2/20 13:32, Kairui Song wrote:
> On Tue, Feb 20, 2024 at 12:49 PM Chengming Zhou <zhouchengming@bytedance.com>
> wrote:
>>
>> On 2024/2/20 06:10, Barry Song wrote:
>>> On Mon, Feb 19, 2024 at 9:21 PM Kairui Song <ryncsn@gmail.com> wrote:
>>>>
>>>> From: Kairui Song <kasong@tencent.com>
>>>>
>>>> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
>>>> swapin the same entry at the same time, they get different pages (A,
> B).
>>>> Before one thread (T0) finishes the swapin and installs page (A)
>>>> to the PTE, another thread (T1) could finish swapin of page (B),
>>>> swap_free the entry, then swap out the possibly modified page
>>>> reusing the same entry. It breaks the pte_same check in (T0) because
>>>> PTE value is unchanged, causing ABA problem. Thread (T0) will
>>>> install a stalled page (A) into the PTE and cause data corruption.
>>>>
>>>> One possible callstack is like this:
>>>>
>>>> CPU0                                 CPU1
>>>> ----                                 ----
>>>> do_swap_page()                       do_swap_page() with same entry
>>>> <direct swapin path>                 <direct swapin path>
>>>> <alloc page A>                       <alloc page B>
>>>> swap_read_folio() <- read to page A  swap_read_folio() <- read to page
> B
>>>> <slow on later locks or interrupt>   <finished swapin first>
>>>> ..                                  set_pte_at()
>>>>                                      swap_free() <- entry is free
>>>>                                      <write to page B, now page A
> stalled>
>>>>                                      <swap out page B to same swap
> entry>
>>>> pte_same() <- Check pass, PTE seems
>>>>               unchanged, but page A
>>>>               is stalled!
>>>> swap_free() <- page B content lost!
>>>> set_pte_at() <- staled page A installed!
>>>>
>>>> And besides, for ZRAM, swap_free() allows the swap device to discard
>>>> the entry content, so even if page (B) is not modified, if
>>>> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
>>>> it may also cause data loss.
>>>>
>>>> To fix this, reuse swapcache_prepare which will pin the swap entry
> using
>>>> the cache flag, and allow only one thread to swap it in, also prevent
>>>> any parallel code from putting the entry in the cache. Release the pin
>>>> after PT unlocked.
>>>>
>>>> Racers just loop and wait since it's a rare and very short event.
>>>> A schedule_timeout_uninterruptible(1) call is added to avoid repeated
>>>> page faults wasting too much CPU, causing livelock or adding too much
>>>> noise to perf statistics. A similar livelock issue was described in
>>>> commit 029c4628b2eb ("mm: swap: get rid of livelock in swapin
> readahead")
>>>>
>>>> Reproducer:
>>>>
>>>> This race issue can be triggered easily using a well constructed
>>>> reproducer and patched brd (with a delay in read path) [1]:
>>>>
>>>> With latest 6.8 mainline, race caused data loss can be observed easily:
>>>> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>>>>   Polulating 32MB of memory region...
>>>>   Keep swapping out...
>>>>   Starting round 0...
>>>>   Spawning 65536 workers...
>>>>   32746 workers spawned, wait for done...
>>>>   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
>>>>   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
>>>>   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
>>>>   Round 0 Failed, 15 data loss!
>>>>
>>>> This reproducer spawns multiple threads sharing the same memory region
>>>> using a small swap device. Every two threads updates mapped pages one
> by
>>>> one in opposite direction trying to create a race, with one dedicated
>>>> thread keep swapping out the data out using madvise.
>>>>
>>>> The reproducer created a reproduce rate of about once every 5 minutes,
>>>> so the race should be totally possible in production.
>>>>
>>>> After this patch, I ran the reproducer for over a few hundred rounds
>>>> and no data loss observed.
>>>>
>>>> Performance overhead is minimal, microbenchmark swapin 10G from 32G
>>>> zram:
>>>>
>>>> Before:     10934698 us
>>>> After:      11157121 us
>>>> Cached:     13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>>>>
>>>> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of
> synchronous device")
>>>> Link:
> https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
>>>> Reported-by: "Huang, Ying" <ying.huang@intel.com>
>>>> Closes:
> https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
>>>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>>> Cc: stable@vger.kernel.org
>>>>
>>>> ---
>>>> V3:
> https://lore.kernel.org/all/20240216095105.14502-1-ryncsn@gmail.com/
>>>> Update from V3:
>>>> - Use schedule_timeout_uninterruptible(1) for now instead of
> schedule() to
>>>>   prevent the busy faulting task holds CPU and livelocks [Huang, Ying]
>>>>
>>>> V2:
> https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com/
>>>> Update from V2:
>>>> - Add a schedule() if raced to prevent repeated page faults wasting CPU
>>>>   and add noise to perf statistics.
>>>> - Use a bool to state the special case instead of reusing existing
>>>>   variables fixing error handling [Minchan Kim].
>>>>
>>>> V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
>>>> Update from V1:
>>>> - Add some words on ZRAM case, it will discard swap content on
> swap_free
>>>>   so the race window is a bit different but cure is the same. [Barry
> Song]
>>>> - Update comments make it cleaner [Huang, Ying]
>>>> - Add a function place holder to fix CONFIG_SWAP=n built [SeongJae
> Park]
>>>> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO
>>>>   instead of "direct swapin path" [Yu Zhao]
>>>> - Update commit message.
>>>> - Collect Review and Acks.
>>>>
>>>>  include/linux/swap.h |  5 +++++
>>>>  mm/memory.c          | 20 ++++++++++++++++++++
>>>>  mm/swap.h            |  5 +++++
>>>>  mm/swapfile.c        | 13 +++++++++++++
>>>>  4 files changed, 43 insertions(+)
>>>>
>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>> index 4db00ddad261..8d28f6091a32 100644
>>>> --- a/include/linux/swap.h
>>>> +++ b/include/linux/swap.h
>>>> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
>>>>         return 0;
>>>>  }
>>>>
>>>> +static inline int swapcache_prepare(swp_entry_t swp)
>>>> +{
>>>> +       return 0;
>>>> +}
>>>> +
>>>>  static inline void swap_free(swp_entry_t swp)
>>>>  {
>>>>  }
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 7e1f4849463a..a99f5e7be9a5 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>         struct page *page;
>>>>         struct swap_info_struct *si = NULL;
>>>>         rmap_t rmap_flags = RMAP_NONE;
>>>> +       bool need_clear_cache = false;
>>>>         bool exclusive = false;
>>>>         swp_entry_t entry;
>>>>         pte_t pte;
>>>> @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>         if (!folio) {
>>>>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>>>>                     __swap_count(entry) == 1) {
>>>> +                       /*
>>>> +                        * Prevent parallel swapin from proceeding with
>>>> +                        * the cache flag. Otherwise, another thread
> may
>>>> +                        * finish swapin first, free the entry, and
> swapout
>>>> +                        * reusing the same entry. It's undetectable as
>>>> +                        * pte_same() returns true due to entry reuse.
>>>> +                        */
>>>> +                       if (swapcache_prepare(entry)) {
>>>> +                               /* Relax a bit to prevent rapid
> repeated page faults */
>>>> +                               schedule_timeout_uninterruptible(1);
>>>
>>> Not a ideal model, imaging two tasks,
>>>
>>> task A  - low priority running on a LITTLE core
>>> task B - high priority and have real-time requirements such as audio,
>>>               graphics running on a big core.
>>>
>>> The original code will make B win even if it is a bit later than A as
> its CPU is
>>> much faster to finish swap_read_folio for example from zRAM. task B's
>>> swap-in can finish very soon.
>>>
>>> With the patch, B will wait a tick and its real-time performance will be
>>> negatively affected from time to time once low priority and high
> priority
>>> tasks fault in the same PTE and high priority tasks are a bit later than
>>> low priority tasks. This is a kind of priority inversion.
>>>
>>> When we support large folio swap-in, things can get worse. For example,
>>> to swap-in 16 or even more pages in one do_swap_page, the chance for
>>> task A and task B located in the same range of 16 PTEs will increase
>>> though they are not located in the same PTE.
>>>
>>> Please consider this is not a blocker for this patch. But I will put
> the problem
>>> in my list and run some real tests on Android phones later.
>>
>> Good point. Late for the discussion, I'm wondering why not get an extra
> reference
>> on the swap entry, instead of swapcache_prepare()? Then the faster thread
> will
>> succeed, but can't free the swap entry. Later, the slower thread will
> find the
>> changed pte value and fail, and free the swap entry. Maybe I missed
> something?
> 
> Hi, Chengming
> 
> That was my initial purpose. Then found a lot of problems with it. Increase
> swap count here, it may race with another swap free and end up increasing
> the swap count of a freed entry.
> 
> That can be fixed with audits and new helpers, but there are many other
> potential issues too. One major problem is that after count bump, raced
> swap threads will fallback to cached swap in. Pages in swapcache can be
> swaped out without allocating an entry, making the problem we were trying
> to resolve more serious.

Thanks for your clarification! Right, there are many issues I just ignored...


