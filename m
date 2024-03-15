Return-Path: <linux-kernel+bounces-104014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B4587C7E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D34282CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E04D2F0;
	Fri, 15 Mar 2024 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D44IXHoT"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D01A38C0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710472605; cv=none; b=dmItzt7qLKsN2WgOXRa0WouSw4vdaNSBYy+tq6GrfqLqfQ3ojLRaUXk+MoorD0hygUxWDgxBrqhJCtAqk1TsQprxeAYc1eVjgw2NbhnDaltFFP0SyFoDVllCtNICf+Z6+pwg+gNcjYzTFvym7gXSLIpmliaWyH6jiiyA+a8dMvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710472605; c=relaxed/simple;
	bh=9J74TWp4ZL7V/ShFNM548o9+74dTJFNiKrR4UDIYubA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpMBi8nBWDl3MEPgEhE1M3HlUqjo3iGNI8SMRsXfKjGx4pw8Ee8ipKqg8r5K6Ph2FE8BlNkTDGDLWk0279apxx99PjgPe1YRRhitxVzuVst+zSfRkmIedCaMI4T/xM5TiU22qjksEJwcrRa8l1BhL/VNTgRBgBwj+oT1PPBtt7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D44IXHoT; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1551fa14-2a95-49fd-ab1a-11c38ae29486@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710472601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyEL18pDr4erpjHvr/3KnVfdunFpQIKYbIldKFsO9XY=;
	b=D44IXHoTyhOzwSEOAv/7Hd/uphgNUDLPhOrjeb4H4R0BohEDTT7XqzppX1W6ysNcsr4mZO
	oyUosanoiip0tgtpdFrVZ/CmltRoqkZGRbONp6cqCQp9DArP4sI5/x6xgzLepVvHQGH7r2
	lE3+OXxh1BBCMjwbE6/gywufGTmT3Ao=
Date: Fri, 15 Mar 2024 11:16:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: cachestat: avoid bogus workingset test during
 swapping & invalidation races
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
References: <20240314164941.580454-1-hannes@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240314164941.580454-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/15 00:49, Johannes Weiner wrote:
> When cachestat against shmem races with swapping and invalidation, the
> shadow entry might not exist: swapout IO is still in progress and
> we're before __remove_mapping; or swapin/invalidation/swapoff has
> removed the shadow from swapcache after we saw a shmem swap entry.
> 
> This will send a NULL to workingset_test_recent(). The latter purely
> operates on pointer bits, so it won't crash - node 0, memcg ID 0,
> eviction timestamp 0, etc. are all valid inputs - but it's a bogus
> test. In theory that could result in a false "recently evicted" count.

Good catch!

> 
> Such a false positive wouldn't be the end of the world. But for code
> clarity and (future) robustness, be explicit about this case.
> 
> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/filemap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 222adac7c9c5..a07c27df7eab 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4199,6 +4199,9 @@ static void filemap_cachestat(struct address_space *mapping,
>  				swp_entry_t swp = radix_to_swp_entry(folio);
>  

IIUC, we should first check if it's a real swap entry using non_swap_entry(), right?
Since there maybe other types of entries in shmem. And need to get_swap_device() to
prevent concurrent swapoff here, get_shadow_from_swap_cache() won't do it for us.

Thanks.

>  				shadow = get_shadow_from_swap_cache(swp);
> +				/* can race with swapping & invalidation */
> +				if (!shadow)
> +					goto resched;
>  			}
>  #endif
>  			if (workingset_test_recent(shadow, true, &workingset))


