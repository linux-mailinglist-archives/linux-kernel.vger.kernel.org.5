Return-Path: <linux-kernel+bounces-67200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC78A8567F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D059F1C23FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FD8133423;
	Thu, 15 Feb 2024 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCBYMmCV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE87A133415
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011384; cv=none; b=BUnvVUKE89qOBDOlDurl/OALFVqdVfXgwCL+9jHDw79HvvB+83ei74gVh0RxibLi7So6k4l3Lu8oJhAoyFsKxiC7wnG/lt5jyigLSs4MIyDxYDlXbs44PGhEczKVj7SUPktVqhVF8YpyPFlZq15co/DdtBCRiLa+Q8PLO25ToxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011384; c=relaxed/simple;
	bh=WKzVupGrYbIGToh+LZZ1GcwQsx+AHu/gJ3G5M6uXxGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtPBDD7q05Jt3mbHPAAv8N/zMPbgjwW20fV0X1t9ypybdQ40tF2TzZH/8lVG44QKxnSOB1SgqCdv8YmNLU2HNQBTX8/5PrMGg09x+MMY+nz88u0x4r/BUPbNWFfBS/OX5zWVsNyS1ZDULJwjj6rLV/BXBO/odQKSz+hNpGfVxkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCBYMmCV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708011381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WFEkYWn6lSjjWHSfbVJ3rNrxS0O1ao+linFJOgQDChU=;
	b=fCBYMmCVmOOkndzEhAsCjN9rIdcvDpPVyD2Ol2jU/Robf6ZfyQXgkXA5RDVauDx+6TOFRt
	oDhVLuu/TKAlwG3lOKFC1AbEVe61m6AE/yhFdhI4mHsXLkUk6S1ir4W9PhDqZmQbdSdsqA
	WqI8rvWyZOcUp6wJ1RsHbiA/6n4CH1g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-yPaK9SX_OOO-yxHO6F3xbg-1; Thu, 15 Feb 2024 10:36:19 -0500
X-MC-Unique: yPaK9SX_OOO-yxHO6F3xbg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-411dca63c56so5128615e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708011378; x=1708616178;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFEkYWn6lSjjWHSfbVJ3rNrxS0O1ao+linFJOgQDChU=;
        b=L73hj+nkj79ajthPJGQRUed64GnAO3B+/oAHWvuf0S1lDqOSc8zcKkmXBEcN3qY2tq
         UYzyijBCwP6oOgJywPxLPzUG2ZjcLxD09ZZQ8Cy2UfPwW0EKvCYWZjYkAwoBnFwAyv3g
         bHHQ/oNzJrOeiQAzUUNgdRRAe88eEMZfX7MoykJ6RkMHUJkJXY0wdwmwEKIvuRwKZUix
         E9PiqxsqH2eFl8a1lNw3mwcf2BfHVfl18KnYsuw0DvvY4MC09fdLeDoVHLqZ/dkDhf1O
         J+oC0TW7oMNTx2Lujm3ABFrF/DNoZPlcNjbwvGsrLmopfnxKKIspUgQIAPlUj1T0odj9
         Sw4A==
X-Forwarded-Encrypted: i=1; AJvYcCWwoxOfa/D0HZimpkdYP9S3YsLNK5JKxdyV9LapwEh5qzc4+R2Y1Aw1d7vSsJwjKJek/r07M1xDRihDOmOFAmZmwVVcPo1udTXFsb9J
X-Gm-Message-State: AOJu0YxZOgIG3jDGNI2DAo288AnHBKOxkQ5wY86dC0E9skkerCWLJcaE
	vcWEHsyuIYgkxDbKRSpK4ZdyNR/gHLe6AbwFchYlugx39ELoQ6Mlh9QdBGdZ/tNa/U9zwSsJxnB
	bUzAMCbqkrBQc+QUgHTfqmjWNvzxX8vMsjLCh+4S+yddX+bLJilVZyFTWeNZhKA==
X-Received: by 2002:a05:600c:1c1e:b0:412:1d7d:6c51 with SMTP id j30-20020a05600c1c1e00b004121d7d6c51mr1218232wms.6.1708011378648;
        Thu, 15 Feb 2024 07:36:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSCuPYyzJpc6ZXs+6hreWw9uNgc1CCMXCCg8Rm12s+EW6O2o96Q/vg6e+HHu2fnrrNf2Bgfw==
X-Received: by 2002:a05:600c:1c1e:b0:412:1d7d:6c51 with SMTP id j30-20020a05600c1c1e00b004121d7d6c51mr1218213wms.6.1708011378145;
        Thu, 15 Feb 2024 07:36:18 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c34c900b0040e4733aecbsm2467851wmq.15.2024.02.15.07.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 07:36:17 -0800 (PST)
Message-ID: <1d259a51-46e6-4d3b-9455-38dbcc17b168@redhat.com>
Date: Thu, 15 Feb 2024 16:36:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
Content-Language: en-US
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
 Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>,
 Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Yosry Ahmed <yosryahmed@google.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206182559.32264-1-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240206182559.32264-1-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.02.24 19:25, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
> swapin the same entry at the same time, they get different pages (A, B).
> Before one thread (T0) finishes the swapin and installs page (A)
> to the PTE, another thread (T1) could finish swapin of page (B),
> swap_free the entry, then swap out the possibly modified page
> reusing the same entry. It breaks the pte_same check in (T0) because
> PTE value is unchanged, causing ABA problem. Thread (T0) will
> install a stalled page (A) into the PTE and cause data corruption.
> 
> One possible callstack is like this:
> 
> CPU0                                 CPU1
> ----                                 ----
> do_swap_page()                       do_swap_page() with same entry
> <direct swapin path>                 <direct swapin path>
> <alloc page A>                       <alloc page B>
> swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
> <slow on later locks or interrupt>   <finished swapin first>
> ...                                  set_pte_at()
>                                       swap_free() <- entry is free
>                                       <write to page B, now page A stalled>
>                                       <swap out page B to same swap entry>
> pte_same() <- Check pass, PTE seems
>                unchanged, but page A
>                is stalled!
> swap_free() <- page B content lost!
> set_pte_at() <- staled page A installed!
> 
> And besides, for ZRAM, swap_free() allows the swap device to discard
> the entry content, so even if page (B) is not modified, if
> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> it may also cause data loss.
> 
> To fix this, reuse swapcache_prepare which will pin the swap entry using
> the cache flag, and allow only one thread to pin it. Release the pin
> after PT unlocked. Racers will simply busy wait since it's a rare
> and very short event.
> 
> Other methods like increasing the swap count don't seem to be a good
> idea after some tests, that will cause racers to fall back to use the
> swap cache again. Parallel swapin using different methods leads to
> a much more complex scenario.
> 
> Reproducer:
> 
> This race issue can be triggered easily using a well constructed
> reproducer and patched brd (with a delay in read path) [1]:
> 
> With latest 6.8 mainline, race caused data loss can be observed easily:
> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>    Polulating 32MB of memory region...
>    Keep swapping out...
>    Starting round 0...
>    Spawning 65536 workers...
>    32746 workers spawned, wait for done...
>    Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
>    Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
>    Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
>    Round 0 Failed, 15 data loss!
> 
> This reproducer spawns multiple threads sharing the same memory region
> using a small swap device. Every two threads updates mapped pages one by
> one in opposite direction trying to create a race, with one dedicated
> thread keep swapping out the data out using madvise.
> 
> The reproducer created a reproduce rate of about once every 5 minutes,
> so the race should be totally possible in production.
> 
> After this patch, I ran the reproducer for over a few hundred rounds
> and no data loss observed.
> 
> Performance overhead is minimal, microbenchmark swapin 10G from 32G
> zram:
> 
> Before:     10934698 us
> After:      11157121 us
> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> 
> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous device")
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Acked-by: Yu Zhao <yuzhao@google.com>
> 
> ---
> Update from V1:
> - Add some words on ZRAM case, it will discard swap content on swap_free so the race window is a bit different but cure is the same. [Barry Song]
> - Update comments make it cleaner [Huang, Ying]
> - Add a function place holder to fix CONFIG_SWAP=n built [SeongJae Park]
> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO instead of "direct swapin path" [Yu Zhao]
> - Update commit message.
> - Collect Review and Acks.
> 
>   include/linux/swap.h |  5 +++++
>   mm/memory.c          | 15 +++++++++++++++
>   mm/swap.h            |  5 +++++
>   mm/swapfile.c        | 13 +++++++++++++
>   4 files changed, 38 insertions(+)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4db00ddad261..8d28f6091a32 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
>   	return 0;
>   }
>   
> +static inline int swapcache_prepare(swp_entry_t swp)
> +{
> +	return 0;
> +}
> +
>   static inline void swap_free(swp_entry_t swp)
>   {
>   }
> diff --git a/mm/memory.c b/mm/memory.c
> index 7e1f4849463a..1749c700823d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	if (!folio) {
>   		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>   		    __swap_count(entry) == 1) {
> +			/*
> +			 * Prevent parallel swapin from proceeding with
> +			 * the cache flag. Otherwise, another thread may
> +			 * finish swapin first, free the entry, and swapout
> +			 * reusing the same entry. It's undetectable as
> +			 * pte_same() returns true due to entry reuse.
> +			 */
> +			if (swapcache_prepare(entry))
> +				goto out;
> +

Is there anything that guarantees that the following won't
happen concurrently, and if it would happen, could it be a problem?

Other thread MADV_DONTNEED's the swap entry, swap slot is freed.
Some other page gets swapped out, reuses that swap slot.

We call swapcache_prepare() on that slot that is being reused
elsewhere. (possibly some other thread in the context of the reuses
swap slot might do the same!)

We would detect later, that the PTE changed, but we would temporarily
mess with that swap slot that we might no longer "own".


I was thinking about alternatives, it's tricky because of the concurrent
MADV_DONTNEED possibility. Something with another fake-swap entry type
(similar to migration entries) might work, but would require more changes.

-- 
Cheers,

David / dhildenb


