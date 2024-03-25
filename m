Return-Path: <linux-kernel+bounces-116741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8BB88A335
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C052E239E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18760158205;
	Mon, 25 Mar 2024 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iUaRKlNS"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A072D1581ED
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711358568; cv=none; b=Oo+EFK0wlwU9PVfnSDyLti0sokILRMrGYikYYbutWE4x/HExKP6atTIQa3R3d7AtZQm6J7wa41TmF6xoxOjRMB/rdSWfh507+5+tXUBFXuzUSiFm9Uwkx609JgkvBUKQblQFNik92noo4IB14MVvNVowFaacKAJLyhp7ObstMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711358568; c=relaxed/simple;
	bh=NUq6l92k3z6+MavqfTyLMHgevvGnDis+wYiPtoA46pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2Fk9QoBHSzdKPI6E3pPZTdtBW1wpDsBnzDuEXirSf34j89MY0KXRfIUXRGopQCGoi/eciHbe43nIcUWgkxc0v9hCNTbpSguhBUoUriq3fS7K9Tzkz99d0oFGVRY2Aw+SGGvUAftoqkDblYCkrfWZvMTq1uLDspjjgXoXQcXQdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iUaRKlNS; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d556ec84-da6a-4486-a68e-5982baf46879@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711358563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOlZm0+5XlJcPzDimS2ld8aXFCHL2fRhCLxa+S5e368=;
	b=iUaRKlNSkeZqVpQBNnWAM8JvB4mvcqL9WsD9sTLOx62VlXRPwbRfz0wOYGYQyTqbsBg6jG
	FhFVtjvuIJFv/Q3a2J6GxDPC79M19bffV9YEN8L54jK8O5kXK6O55bKVjmnHxZPvt8zzb3
	KYbBB6abu5qZhUZueEtLBSOgsxnzI3c=
Date: Mon, 25 Mar 2024 17:22:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Barry Song <21cnbao@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhongkun He <hezhongkun.hzk@bytedance.com>,
 Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
References: <20240324210447.956973-1-hannes@cmpxchg.org>
 <CAJD7tkaWQAV=X1pzYG=VkWe7Ue9ZFbjt9uQ5m1NJujtLspWJTA@mail.gmail.com>
 <CAGsJ_4yeBmNsMGXEWwC+1Hs5zJUP+becq4wG+6CpU7V1=EOvhg@mail.gmail.com>
 <CAJD7tka5K69q20bxTsBk38JC7mdPr3UsxXpsnggDO_iQA=qxug@mail.gmail.com>
 <1e7ce417-b9dd-4d62-9f54-0adf1ccdae35@linux.dev>
 <CAJD7tkYc3oFho5eEkS1zmr_+CC-Ag1HucUTyAy2RJbEb4SqRoQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAJD7tkYc3oFho5eEkS1zmr_+CC-Ag1HucUTyAy2RJbEb4SqRoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/25 16:38, Yosry Ahmed wrote:
> On Mon, Mar 25, 2024 at 12:33 AM Chengming Zhou
> <chengming.zhou@linux.dev> wrote:
>>
>> On 2024/3/25 15:06, Yosry Ahmed wrote:
>>> On Sun, Mar 24, 2024 at 9:54 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>
>>>> On Mon, Mar 25, 2024 at 10:23 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>>>>>
>>>>> On Sun, Mar 24, 2024 at 2:04 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>>>>
>>>>>> Zhongkun He reports data corruption when combining zswap with zram.
>>>>>>
>>>>>> The issue is the exclusive loads we're doing in zswap. They assume
>>>>>> that all reads are going into the swapcache, which can assume
>>>>>> authoritative ownership of the data and so the zswap copy can go.
>>>>>>
>>>>>> However, zram files are marked SWP_SYNCHRONOUS_IO, and faults will try
>>>>>> to bypass the swapcache. This results in an optimistic read of the
>>>>>> swap data into a page that will be dismissed if the fault fails due to
>>>>>> races. In this case, zswap mustn't drop its authoritative copy.
>>>>>>
>>>>>> Link: https://lore.kernel.org/all/CACSyD1N+dUvsu8=zV9P691B9bVq33erwOXNTmEaUbi9DrDeJzw@mail.gmail.com/
>>>>>> Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
>>>>>> Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
>>>>>> Cc: stable@vger.kernel.org      [6.5+]
>>>>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>>>>>> Tested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
>>>>
>>>> Acked-by: Barry Song <baohua@kernel.org>
>>>>
>>>>>
>>>>> Do we also want to mention somewhere (commit log or comment) that
>>>>> keeping the entry in the tree is fine because we are still protected
>>>>> from concurrent loads/invalidations/writeback by swapcache_prepare()
>>>>> setting SWAP_HAS_CACHE or so?
>>>>
>>>> It seems that Kairui's patch comprehensively addresses the issue at hand.
>>>> Johannes's solution, on the other hand, appears to align zswap behavior
>>>> more closely with that of a traditional swap device, only releasing an entry
>>>> when the corresponding swap slot is freed, particularly in the sync-io case.
>>>
>>> It actually worked out quite well that Kairui's fix landed shortly
>>> before this bug was reported, as this fix wouldn't have been possible
>>> without it as far as I can tell.
>>>
>>>>
>>>> Johannes' patch has inspired me to consider whether zRAM could achieve
>>>> a comparable outcome by immediately releasing objects in swap cache
>>>> scenarios.  When I have the opportunity, I plan to experiment with zRAM.
>>>
>>> That would be interesting. I am curious if it would be as
>>> straightforward in zram to just mark the folio as dirty in this case
>>> like zswap does, given its implementation as a block device.
>>>
>>
>> This makes me wonder who is responsible for marking folio dirty in this swapcache
>> bypass case? Should we call folio_mark_dirty() after the swap_read_folio()?
> 
> In shrink_folio_list(), we try to add anonymous folios to the
> swapcache if they are not there before checking if they are dirty.
> add_to_swap() calls folio_mark_dirty(), so this should take care of

Right, thanks for your clarification, so should be no problem here.
Although it was a fix just for MADV_FREE case.

> it. There is an interesting comment there though. It says that PTE
> should be dirty, so unmapping the folio should have already marked it
> as dirty by the time we are adding it to the swapcache, except for the
> MADV_FREE case.

It seems to say the folio will be dirtied when unmap later, supposing the
PTE is dirty.

> 
> However, I think we actually unmap the folio after we add it to the
> swapcache in shrink_folio_list(). Also, I don't immediately see why
> the PTE would be dirty. In do_swap_page(), making the PTE dirty seems

If all anon pages on LRU list are faulted by write, it should be true.
We could just use the zero page if faulted by read, right?

> to be conditional on the fault being a write fault, but I didn't look
> thoroughly, maybe I missed it. It is also possible that the comment is
> just outdated.

Yeah, dirty is only marked on write fault.

Thanks.

