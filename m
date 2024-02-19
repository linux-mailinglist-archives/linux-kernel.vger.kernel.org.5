Return-Path: <linux-kernel+bounces-70985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04644859F07
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FBE1F22E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5018922619;
	Mon, 19 Feb 2024 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiJ8BaTw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED4225D6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333369; cv=none; b=gAqWhv5wsxreePb8GyT9C+hMlKAnrZb3LL3Tp0IUUhMD2fk60i1CoFk1XTn0j8auEjfZnAwdg5IWRx+EAqJOSgrt6sLYt9Ppy09teHH5eN6VvRWr/zuXlkUULdq6gdVJqpbsGWQygUGH20kyyhPbXhpGTwq9YFwnelCNXhh86tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333369; c=relaxed/simple;
	bh=VbLmksRa0KsjRo7eB5jtApYSVV6bdgwbQqCVKNpg5gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDoJAef7IfyeezLA4J4oldHzuUmcTtTvIw37ctBEtutFc1bpxJuu7uRXEaolFrtevCo4D3bNbc7+VHnaXQGpidtIEQnMj6oQdW+uuOcjdAoDOvotPKYBlJCPpoI2izWS7Ill3+B8ToD1kl9cbkTRWFbvmJmkH0Mecr5EKcXkQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MiJ8BaTw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708333366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TGO+zVL7fNCeXc9OWpknag0i1wXHMGjXUn6VjVgx0bQ=;
	b=MiJ8BaTwiBZ1LXoPuk51j7D6PGkOT+A6OE//NuL1yDzLtblg00dgxqI4qV721CHw5vv+IL
	d2x2MFBfb3tP9uaE4Mna9Eip9Xd4OgfFdW0Lql0aJe82B7y6ovvjTCotDtNLuz9cNP6QEA
	w3C9ZxCxIdFL3cR9/jRk20gNr4zd4Zw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-pcm11nVYMQGSoy-NjzMz2w-1; Mon, 19 Feb 2024 04:02:44 -0500
X-MC-Unique: pcm11nVYMQGSoy-NjzMz2w-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d0be4e5cf2so28990341fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708333363; x=1708938163;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGO+zVL7fNCeXc9OWpknag0i1wXHMGjXUn6VjVgx0bQ=;
        b=Hx4O+b+8L5wkUk6j+IaV+XcZ4nDWCWRTaCVwOrjVpeBXbsCz0b43AYl6m3S2hB5hmF
         YYqjo/233ftKjtzrutBJVyyuaFv+Siqt2h2JwZzFfuBlzXYvi1EJ4T6Diqi45AafVcFK
         184gIIgS+PRS1OxuEL3R5Qhkg7SCCZYtCUVFM01pIO5gOv4q52a/RoUJUrbZGM/xpiWv
         0hBzYzuJ/eGStjez8Knk/yka0rUsWKEAxtEnmn39pj0GfqNtjGcjcNv2ghur45yFyqEf
         WVbYoXAWuwh6x/K0n1yiiIz7MQQsDHCsKVdueBzv5uRc/JcmLMekR7li8XyX5stun4jU
         uhTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTPLnYCkYMp1of2M3A0/vpZK6iX5gANlzshzjp5Y2F17DFa3vzwNEfGGsULAbETzK0r1zZH2jC/YnWokDBlt/aHBVwnlcNyasAnL86
X-Gm-Message-State: AOJu0Yx5oM8c5Hxw9DQiqFeOVtVKOQY1jC8hD+nWyyd263Gb7bAm5SGE
	KmyqY1lfsm49qc9xm8er3KE4ljQZtANREkCPYb+6yeRI066vArSlk+4eSZXXiDo7B6UstsumgHl
	wfZ5q6xDOTKMoTQkORWVtgvxDOhb41zUcOKJnaowR9TG1HiqZY1P8rQMasScLWA==
X-Received: by 2002:a2e:b164:0:b0:2d2:349c:2d6b with SMTP id a4-20020a2eb164000000b002d2349c2d6bmr1934110ljm.11.1708333363371;
        Mon, 19 Feb 2024 01:02:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6Tdb3kfOnJKYvB+La23HON8vRrwNNg20hIXfaoBYb4/X2Z8Otc+rYkX6L5K1lZOSHZRSCQA==
X-Received: by 2002:a2e:b164:0:b0:2d2:349c:2d6b with SMTP id a4-20020a2eb164000000b002d2349c2d6bmr1934081ljm.11.1708333362825;
        Mon, 19 Feb 2024 01:02:42 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b00412590eee7csm7505288wmq.10.2024.02.19.01.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 01:02:42 -0800 (PST)
Message-ID: <0066a14b-0bc4-4043-bb74-96ebe9e77836@redhat.com>
Date: Mon, 19 Feb 2024 10:02:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/swap: fix race when skipping swapcache
Content-Language: en-US
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
 Minchan Kim <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
 Yu Zhao <yuzhao@google.com>, SeongJae Park <sj@kernel.org>,
 Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Yosry Ahmed <yosryahmed@google.com>, Aaron Lu <aaron.lu@intel.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240219082040.7495-1-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240219082040.7495-1-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.02.24 09:20, Kairui Song wrote:
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
> the cache flag, and allow only one thread to swap it in, also prevent
> any parallel code from putting the entry in the cache. Release the pin
> after PT unlocked.
> 
> Racers just loop and wait since it's a rare and very short event.
> A schedule_timeout_uninterruptible(1) call is added to avoid repeated
> page faults wasting too much CPU, causing livelock or adding too much
> noise to perf statistics. A similar livelock issue was described in
> commit 029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead")
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
> Cached:     13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> 
> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous device")
> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: stable@vger.kernel.org
> 
> ---
> V3: https://lore.kernel.org/all/20240216095105.14502-1-ryncsn@gmail.com/
> Update from V3:
> - Use schedule_timeout_uninterruptible(1) for now instead of schedule() to
>    prevent the busy faulting task holds CPU and livelocks [Huang, Ying]
> 
> V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com/
> Update from V2:
> - Add a schedule() if raced to prevent repeated page faults wasting CPU
>    and add noise to perf statistics.
> - Use a bool to state the special case instead of reusing existing
>    variables fixing error handling [Minchan Kim].
> 
> V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
> Update from V1:
> - Add some words on ZRAM case, it will discard swap content on swap_free
>    so the race window is a bit different but cure is the same. [Barry Song]
> - Update comments make it cleaner [Huang, Ying]
> - Add a function place holder to fix CONFIG_SWAP=n built [SeongJae Park]
> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO
>    instead of "direct swapin path" [Yu Zhao]
> - Update commit message.
> - Collect Review and Acks.
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


