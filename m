Return-Path: <linux-kernel+bounces-116651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2B888A1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16321C3869E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8396126F0F;
	Mon, 25 Mar 2024 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nYOZ5tgY"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60747F7DC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352017; cv=none; b=XQ5VU2Co32+J/ai3BlNZBc7TAVqgn33/7lkEmrziBtcF2QO7yYfeWHWy5bx/mKe2AtcsX/wkZ0Qp8VN2cG6NZ05opBwRxkVizUQcFzd4cEKJruJ77ZkzoPtUOcR91Rj+g7BTO/4jzbqxIDhg1l0qO0JxwsxCLnjlfijKC+1Qng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352017; c=relaxed/simple;
	bh=3xEpE8MPeOQczZWC9N9uOK22QwblH0Uvs1dXkOkKnks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGOqCRWN39i/BA6BXEAlKzPr+9z1N/pouq4CjfkTzwS7ap68ktf8CF9nF316HgXbdNPKgAXJyqbdFlkb80FN41tQ0ttdf3DGi9Bas795x3qI/KowAscNGxiRpX1ux+kdxAdQEy6TwBSJno1wykS8LyhJTrkjbIOu7pIIe9edfZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nYOZ5tgY; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1e7ce417-b9dd-4d62-9f54-0adf1ccdae35@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711352010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctgFRMUCJ0CDMrWzPuN/mME5EPeVQIp5wNjYO6KRDeE=;
	b=nYOZ5tgY1AgWEnnHbQVvCpy/Q56YwMgJljrZf4BVb9/vSI51TuLIp6kJUckO2S4IeTtqzW
	0KIZqjXqZxZ4tX4M4k3cENv0IlY6jsymonu/px0/Gfx63utX6LmoxTKZ/HzpSOlC4ilThN
	YPGJOr2LXaZJQCfDWI6kNSeJFRSbe8s=
Date: Mon, 25 Mar 2024 15:33:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>, Barry Song <21cnbao@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhongkun He <hezhongkun.hzk@bytedance.com>,
 Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
References: <20240324210447.956973-1-hannes@cmpxchg.org>
 <CAJD7tkaWQAV=X1pzYG=VkWe7Ue9ZFbjt9uQ5m1NJujtLspWJTA@mail.gmail.com>
 <CAGsJ_4yeBmNsMGXEWwC+1Hs5zJUP+becq4wG+6CpU7V1=EOvhg@mail.gmail.com>
 <CAJD7tka5K69q20bxTsBk38JC7mdPr3UsxXpsnggDO_iQA=qxug@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAJD7tka5K69q20bxTsBk38JC7mdPr3UsxXpsnggDO_iQA=qxug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/25 15:06, Yosry Ahmed wrote:
> On Sun, Mar 24, 2024 at 9:54 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Mon, Mar 25, 2024 at 10:23 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>>>
>>> On Sun, Mar 24, 2024 at 2:04 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>>
>>>> Zhongkun He reports data corruption when combining zswap with zram.
>>>>
>>>> The issue is the exclusive loads we're doing in zswap. They assume
>>>> that all reads are going into the swapcache, which can assume
>>>> authoritative ownership of the data and so the zswap copy can go.
>>>>
>>>> However, zram files are marked SWP_SYNCHRONOUS_IO, and faults will try
>>>> to bypass the swapcache. This results in an optimistic read of the
>>>> swap data into a page that will be dismissed if the fault fails due to
>>>> races. In this case, zswap mustn't drop its authoritative copy.
>>>>
>>>> Link: https://lore.kernel.org/all/CACSyD1N+dUvsu8=zV9P691B9bVq33erwOXNTmEaUbi9DrDeJzw@mail.gmail.com/
>>>> Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
>>>> Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
>>>> Cc: stable@vger.kernel.org      [6.5+]
>>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>>>> Tested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
>>
>> Acked-by: Barry Song <baohua@kernel.org>
>>
>>>
>>> Do we also want to mention somewhere (commit log or comment) that
>>> keeping the entry in the tree is fine because we are still protected
>>> from concurrent loads/invalidations/writeback by swapcache_prepare()
>>> setting SWAP_HAS_CACHE or so?
>>
>> It seems that Kairui's patch comprehensively addresses the issue at hand.
>> Johannes's solution, on the other hand, appears to align zswap behavior
>> more closely with that of a traditional swap device, only releasing an entry
>> when the corresponding swap slot is freed, particularly in the sync-io case.
> 
> It actually worked out quite well that Kairui's fix landed shortly
> before this bug was reported, as this fix wouldn't have been possible
> without it as far as I can tell.
> 
>>
>> Johannes' patch has inspired me to consider whether zRAM could achieve
>> a comparable outcome by immediately releasing objects in swap cache
>> scenarios.  When I have the opportunity, I plan to experiment with zRAM.
> 
> That would be interesting. I am curious if it would be as
> straightforward in zram to just mark the folio as dirty in this case
> like zswap does, given its implementation as a block device.
> 

This makes me wonder who is responsible for marking folio dirty in this swapcache
bypass case? Should we call folio_mark_dirty() after the swap_read_folio()?


