Return-Path: <linux-kernel+bounces-72322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F29085B1FA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C2C1C21976
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2133B54FA0;
	Tue, 20 Feb 2024 04:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LDRDxjPW"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399D342A88
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708404563; cv=none; b=Zlpkm1kWJBZvQGmlQFNSryeiwQlT0+D9LYfPgbel9Tud2AnLixmRlGGxELI2e0lsnNxcmAx7NRk0YQyi1a/gsiv9yjNrKspkZeCOrVe5GzMKelmGMlh8+1qZHkWgX3iTEDFRssf1y+YkQ/y/TkJIJUw88SCjB19EoqyVtS1PEbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708404563; c=relaxed/simple;
	bh=gQrWWvnQdmrm0HzjN0yIwUM4omTX3PcmyaFcp3CFNm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dt+e+3nYHDDlwe12akELHT+arqgUyAFkUzNky3abIbTD5POgNXYZSiKc3eyE/tgmbjfjcR+Mm37kIaSgoagHk+v8a91V121PaZjoLrbNpwv7QV0RDb5L8Cq3ZtDiWQQz5VG2TgVgB4ZUi5WP1bn0k+Qft3P9ozWitmafvG+x3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LDRDxjPW; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59fdcf8ebbcso994774eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708404552; x=1709009352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qU6ALCal3T3tXLqvHnC6m2kKBtzmDNiK024cKt2pWc=;
        b=LDRDxjPWQ+F5EegvQER+jqNbDn1/Pd5bzRfs0eTanjbsi3pE3T2sc68zmeGoDekkjJ
         bKLTfFgjawsZYBKByrtwmeMqLHDOjCPkPcqYQkd0n+08q5wLBw9z0ahAGI022LH56qjX
         sy3sDt8CZrbF2fs1OvmVMucg8f3XVpSGiFuHKpqjS/fOFje9bcRYQ+EWiLuk0yI9xF5O
         GhSvCXQvlENsJDSboqplv0eV1YhRBpKXviN0Eit47kyTKeLSmemQGS13bP81SitU6kN6
         KP4cPcxUcTn8YMv1ZWf4BzDEJswTsbf58Gl+sF2Wia+eqhk4coQqVjM99LWDXlRxPtlW
         sQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708404552; x=1709009352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qU6ALCal3T3tXLqvHnC6m2kKBtzmDNiK024cKt2pWc=;
        b=QX5SWqIBHLZo9SpXDfC7f2Dbt2/7TPSpBorNQUNq6L5mBI9sX4P/NqEx9fY02rqirK
         A3ZTEmCL3//ktp6VaD7N4u4cHasytVWpuuZv2bx9VIVSpiXD7oZnaYh1ouDuIDdiogLm
         tonq/QuGXXEgKMrkcLehY8gupS66Hd0m+d8mop3tEHeeGQo7c/IXcXCAJd732eSldfi0
         9q4rgALUdV2yt8eSsBCgLIKUrBeJvx/9u8RuFzCKYwb7g8JAyENF0Yx7tcINeev3GfSr
         HN27NalH5F43N9/JjQ5RwlLynoj5nz9fj90GAmFFZVqFeJKykAS1iIY3Gu5GwbmzBGrN
         0Yyw==
X-Forwarded-Encrypted: i=1; AJvYcCVAD0h72KCfGtW0CzNvHpBeCuSVqnibxFXePgM5o+6jFEzJ1k3FUQnHEUiLnG4mJ2wq4Y3HWzgwhgEPOlnr5Ks+R38M9G05FdAswM6+
X-Gm-Message-State: AOJu0Yxj8AHIjy8KN5K/t9BDDo0uOeS16ubum9c3zeYCj26Ftoql7PE5
	xYU/Wvzfo1Omb9ztcAjF+rUG5o1p0u9tE6biieelTHm86KSn7PwEXuqq4o3zpDI=
X-Google-Smtp-Source: AGHT+IHt7x6S7oM9lXJxRtL3OD32wiFiQP+efiF87c1wSSdHAW37nm7vFZDKvG7PMynZAzwlSYmzWw==
X-Received: by 2002:a05:6358:571a:b0:178:b97c:f087 with SMTP id a26-20020a056358571a00b00178b97cf087mr15856122rwf.15.1708404552192;
        Mon, 19 Feb 2024 20:49:12 -0800 (PST)
Received: from [10.254.117.3] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id sy8-20020a17090b2d0800b002963cab9e2asm6175303pjb.2.2024.02.19.20.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 20:49:11 -0800 (PST)
Message-ID: <dfac93be-db4c-4e37-a750-93cb19d07a68@bytedance.com>
Date: Tue, 20 Feb 2024 12:49:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/swap: fix race when skipping swapcache
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, Kairui Song <kasong@tencent.com>,
 "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Chris Li <chrisl@kernel.org>, Minchan Kim <minchan@kernel.org>,
 Barry Song <v-songbaohua@oppo.com>, Yu Zhao <yuzhao@google.com>,
 SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Yosry Ahmed <yosryahmed@google.com>, Aaron Lu <aaron.lu@intel.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240219082040.7495-1-ryncsn@gmail.com>
 <CAGsJ_4xX+K=f_4g2c7NcpYqWH0_bvQshxgz_YoDscqeHwWpM0w@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAGsJ_4xX+K=f_4g2c7NcpYqWH0_bvQshxgz_YoDscqeHwWpM0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/2/20 06:10, Barry Song wrote:
> On Mon, Feb 19, 2024 at 9:21 PM Kairui Song <ryncsn@gmail.com> wrote:
>>
>> From: Kairui Song <kasong@tencent.com>
>>
>> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
>> swapin the same entry at the same time, they get different pages (A, B).
>> Before one thread (T0) finishes the swapin and installs page (A)
>> to the PTE, another thread (T1) could finish swapin of page (B),
>> swap_free the entry, then swap out the possibly modified page
>> reusing the same entry. It breaks the pte_same check in (T0) because
>> PTE value is unchanged, causing ABA problem. Thread (T0) will
>> install a stalled page (A) into the PTE and cause data corruption.
>>
>> One possible callstack is like this:
>>
>> CPU0                                 CPU1
>> ----                                 ----
>> do_swap_page()                       do_swap_page() with same entry
>> <direct swapin path>                 <direct swapin path>
>> <alloc page A>                       <alloc page B>
>> swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
>> <slow on later locks or interrupt>   <finished swapin first>
>> ..                                  set_pte_at()
>>                                      swap_free() <- entry is free
>>                                      <write to page B, now page A stalled>
>>                                      <swap out page B to same swap entry>
>> pte_same() <- Check pass, PTE seems
>>               unchanged, but page A
>>               is stalled!
>> swap_free() <- page B content lost!
>> set_pte_at() <- staled page A installed!
>>
>> And besides, for ZRAM, swap_free() allows the swap device to discard
>> the entry content, so even if page (B) is not modified, if
>> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
>> it may also cause data loss.
>>
>> To fix this, reuse swapcache_prepare which will pin the swap entry using
>> the cache flag, and allow only one thread to swap it in, also prevent
>> any parallel code from putting the entry in the cache. Release the pin
>> after PT unlocked.
>>
>> Racers just loop and wait since it's a rare and very short event.
>> A schedule_timeout_uninterruptible(1) call is added to avoid repeated
>> page faults wasting too much CPU, causing livelock or adding too much
>> noise to perf statistics. A similar livelock issue was described in
>> commit 029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead")
>>
>> Reproducer:
>>
>> This race issue can be triggered easily using a well constructed
>> reproducer and patched brd (with a delay in read path) [1]:
>>
>> With latest 6.8 mainline, race caused data loss can be observed easily:
>> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>>   Polulating 32MB of memory region...
>>   Keep swapping out...
>>   Starting round 0...
>>   Spawning 65536 workers...
>>   32746 workers spawned, wait for done...
>>   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
>>   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
>>   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
>>   Round 0 Failed, 15 data loss!
>>
>> This reproducer spawns multiple threads sharing the same memory region
>> using a small swap device. Every two threads updates mapped pages one by
>> one in opposite direction trying to create a race, with one dedicated
>> thread keep swapping out the data out using madvise.
>>
>> The reproducer created a reproduce rate of about once every 5 minutes,
>> so the race should be totally possible in production.
>>
>> After this patch, I ran the reproducer for over a few hundred rounds
>> and no data loss observed.
>>
>> Performance overhead is minimal, microbenchmark swapin 10G from 32G
>> zram:
>>
>> Before:     10934698 us
>> After:      11157121 us
>> Cached:     13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>>
>> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous device")
>> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
>> Reported-by: "Huang, Ying" <ying.huang@intel.com>
>> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
>> Signed-off-by: Kairui Song <kasong@tencent.com>
>> Cc: stable@vger.kernel.org
>>
>> ---
>> V3: https://lore.kernel.org/all/20240216095105.14502-1-ryncsn@gmail.com/
>> Update from V3:
>> - Use schedule_timeout_uninterruptible(1) for now instead of schedule() to
>>   prevent the busy faulting task holds CPU and livelocks [Huang, Ying]
>>
>> V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com/
>> Update from V2:
>> - Add a schedule() if raced to prevent repeated page faults wasting CPU
>>   and add noise to perf statistics.
>> - Use a bool to state the special case instead of reusing existing
>>   variables fixing error handling [Minchan Kim].
>>
>> V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
>> Update from V1:
>> - Add some words on ZRAM case, it will discard swap content on swap_free
>>   so the race window is a bit different but cure is the same. [Barry Song]
>> - Update comments make it cleaner [Huang, Ying]
>> - Add a function place holder to fix CONFIG_SWAP=n built [SeongJae Park]
>> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO
>>   instead of "direct swapin path" [Yu Zhao]
>> - Update commit message.
>> - Collect Review and Acks.
>>
>>  include/linux/swap.h |  5 +++++
>>  mm/memory.c          | 20 ++++++++++++++++++++
>>  mm/swap.h            |  5 +++++
>>  mm/swapfile.c        | 13 +++++++++++++
>>  4 files changed, 43 insertions(+)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 4db00ddad261..8d28f6091a32 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
>>         return 0;
>>  }
>>
>> +static inline int swapcache_prepare(swp_entry_t swp)
>> +{
>> +       return 0;
>> +}
>> +
>>  static inline void swap_free(swp_entry_t swp)
>>  {
>>  }
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 7e1f4849463a..a99f5e7be9a5 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>         struct page *page;
>>         struct swap_info_struct *si = NULL;
>>         rmap_t rmap_flags = RMAP_NONE;
>> +       bool need_clear_cache = false;
>>         bool exclusive = false;
>>         swp_entry_t entry;
>>         pte_t pte;
>> @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>         if (!folio) {
>>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>>                     __swap_count(entry) == 1) {
>> +                       /*
>> +                        * Prevent parallel swapin from proceeding with
>> +                        * the cache flag. Otherwise, another thread may
>> +                        * finish swapin first, free the entry, and swapout
>> +                        * reusing the same entry. It's undetectable as
>> +                        * pte_same() returns true due to entry reuse.
>> +                        */
>> +                       if (swapcache_prepare(entry)) {
>> +                               /* Relax a bit to prevent rapid repeated page faults */
>> +                               schedule_timeout_uninterruptible(1);
> 
> Not a ideal model, imaging two tasks,
> 
> task A  - low priority running on a LITTLE core
> task B - high priority and have real-time requirements such as audio,
>               graphics running on a big core.
> 
> The original code will make B win even if it is a bit later than A as its CPU is
> much faster to finish swap_read_folio for example from zRAM. task B's
> swap-in can finish very soon.
> 
> With the patch, B will wait a tick and its real-time performance will be
> negatively affected from time to time once low priority and high priority
> tasks fault in the same PTE and high priority tasks are a bit later than
> low priority tasks. This is a kind of priority inversion.
> 
> When we support large folio swap-in, things can get worse. For example,
> to swap-in 16 or even more pages in one do_swap_page, the chance for
> task A and task B located in the same range of 16 PTEs will increase
> though they are not located in the same PTE.
> 
> Please consider this is not a blocker for this patch. But I will put the problem
> in my list and run some real tests on Android phones later.

Good point. Late for the discussion, I'm wondering why not get an extra reference
on the swap entry, instead of swapcache_prepare()? Then the faster thread will
succeed, but can't free the swap entry. Later, the slower thread will find the
changed pte value and fail, and free the swap entry. Maybe I missed something?

Thanks.

