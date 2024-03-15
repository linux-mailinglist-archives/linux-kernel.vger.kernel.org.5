Return-Path: <linux-kernel+bounces-104219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4F787CAD9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C94C8B210FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317E517C6E;
	Fri, 15 Mar 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tCtIRsDC"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D108817C66
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496038; cv=none; b=Q9AxfxgLf/azkWQZFsKHjcPpUygolA7U/Vga4gOqdLHu6NfWaOBrOujEJ9SoEJv863yh41b03Y3zx/9ueqiHVyW+xJU0rUG5PhVotp0j6QBznr3G6GQzBb6WCLm9yJF3wEsHOby2jinjiux2PfY45M7IKQ5auk31coXYH785oxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496038; c=relaxed/simple;
	bh=XL7fCL1X51bdK2UTGtEnjvAnQ8MtXmWuq6XUAu1YFqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvMbIl/Ay+BmE1UXJfLpyKePq+PZUhNcVVFxpg2HthDnPscXkUHnqOfSLZhnBXp3wAN66ouhpVxESG7atd3TecY3uA1CilaX5vJaSqTXI6327QAKtl4BVCvRg6lrFLSQvCVBbYVcXAnOrXb4dU1Guwqn/Xegh7Fq/08Yu89lE0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tCtIRsDC; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae197190-6a15-49c5-ab3c-3eaac6dd4c5c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710496031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/vakx78+sEV9QsMCP2nwlQKJ4QPOe67TJg3tqtM1qw=;
	b=tCtIRsDCZRb4O6oyZYK3Bw2EaLfVQFGMRIIGH21Q/6Zih8cwZbzAlwfYDFoWs3iyqaTKec
	jh+WBpVE3XdAwx6l99gVghldWylYZnbVB/sTf2jilmnfLqB9qsN+0/VXPoiwvqX5+pZwmz
	7yB7W1qUzQ/BkX/S8ceJmRXGpN+kep8=
Date: Fri, 15 Mar 2024 17:47:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: cachestat: avoid bogus workingset test during
 swapping & invalidation races
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Jann Horn <jannh@google.com>
References: <20240314164941.580454-1-hannes@cmpxchg.org>
 <1551fa14-2a95-49fd-ab1a-11c38ae29486@linux.dev>
 <20240315093010.GB581298@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240315093010.GB581298@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/15 17:30, Johannes Weiner wrote:
> On Fri, Mar 15, 2024 at 11:16:35AM +0800, Chengming Zhou wrote:
>> On 2024/3/15 00:49, Johannes Weiner wrote:
>>> When cachestat against shmem races with swapping and invalidation, the
>>> shadow entry might not exist: swapout IO is still in progress and
>>> we're before __remove_mapping; or swapin/invalidation/swapoff has
>>> removed the shadow from swapcache after we saw a shmem swap entry.
>>>
>>> This will send a NULL to workingset_test_recent(). The latter purely
>>> operates on pointer bits, so it won't crash - node 0, memcg ID 0,
>>> eviction timestamp 0, etc. are all valid inputs - but it's a bogus
>>> test. In theory that could result in a false "recently evicted" count.
>>
>> Good catch!
>>
>>>
>>> Such a false positive wouldn't be the end of the world. But for code
>>> clarity and (future) robustness, be explicit about this case.
>>>
>>> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
>>> Reported-by: Jann Horn <jannh@google.com>
>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>>> ---
>>>  mm/filemap.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>> index 222adac7c9c5..a07c27df7eab 100644
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -4199,6 +4199,9 @@ static void filemap_cachestat(struct address_space *mapping,
>>>  				swp_entry_t swp = radix_to_swp_entry(folio);
>>>  
>>
>> IIUC, we should first check if it's a real swap entry using non_swap_entry(), right?
>> Since there maybe other types of entries in shmem.
> 
> Good point, it could be a poisoned entry. I'll add the
> non_swap_entry() check on swp.
> 
>> And need to get_swap_device() to prevent concurrent swapoff here,
>> get_shadow_from_swap_cache() won't do it for us.
> 
> We're holding rcu_read_lock() for the xarray iteration, so if we see
> the swap entry in the shmem mapping, it means we beat shmem_unuse()
> and swapoff hasn't run synchronize_rcu() yet.

Ah, you are right, so it's safe.

> 
> So it's safe. But I think it could use a comment. Maybe the
> documentation of get_swap_device() should mention this option too?

