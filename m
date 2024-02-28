Return-Path: <linux-kernel+bounces-84795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB09586ABAA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59574289A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A26A36123;
	Wed, 28 Feb 2024 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s1R5wnrS"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90D33998
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113926; cv=none; b=t4P8bO8E6yFTchyPnyLZJHycFtTHnD2AYfovXhKFEl6IQitJ96/B0ja6JJDbC7sTuHh20wSS3FEOZ+fVwDaRMv+2zQ9TQmyVl5uw8qVxlVhK70smzh5fUz6sUSc6PlSKDxvwOM0BolxOUKLlAKYEIAXFSRuQh7XkoUL2w6fStF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113926; c=relaxed/simple;
	bh=oCzaGK1+0J1qudbZZr79LyrkGbc7znv+r5ghZv1CEqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJxU3hzWrRF/D/mIlCkJCNE1Baj8QUgG+CuXMi+AET3ibWwFkmYkq9YuN/mRkBdvDsZbiXfft/mu9L11mL36j231grX5gAyyJcPsh+xdCKi0wOdziMB+uN8hFrYDY5QiF/1DqQJ9IxMDa9cFQR4Is4hBNHSU6xMe/FshCF00VBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s1R5wnrS; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0aa3ce20-438f-49fb-8f04-4fc1dbf49728@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709113920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPOCbdIrdO1UY9mjYpsvt7O6Jg6uWqYy//PM9B5ScNY=;
	b=s1R5wnrSmub+m/GNUcmW5SoCAvWOPfUnpZJ3sNCiLvnAuJI90E2wPvTlzquACpDevJKO2o
	Re+UOalb7q3w7JKklWSSb+F9lC8jCBFYfKTor2tEnxYwYjqmsDRFk+FiwqZKmyq1O4k0ui
	+oFB6QRijQg9Ehlv+To4TlynrwhG1k4=
Date: Wed, 28 Feb 2024 17:51:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
Content-Language: en-US
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>,
 Jianfeng Wang <jianfeng.w.wang@oracle.com>, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
 <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
 <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz>
 <55ccc92a-79fa-42d2-97d8-b514cf00823b@linux.dev>
 <6daf88a2-84c2-5ba4-853c-c38cca4a03cb@linux.com>
 <e924c39b-7636-4c34-bfe9-603cf07c21d3@linux.dev>
 <b8f393fb-2b1d-213c-9301-35d4ffca1f50@linux.com>
 <347b870e-a7d5-45df-84ba-4eee37b74ff6@linux.dev>
 <1a952209-fa22-4439-af27-bf102c7d742b@suse.cz>
 <cce26aef-ab3e-447b-8b33-5ecd78bf747d@linux.dev>
 <2744dd57-e76e-4d80-851a-02898f87f9be@suse.cz>
 <036f2bb4-b086-2988-e46d-86d399405687@linux.com>
 <eec445a6-7024-40b6-9d4e-7fc2bc71cce7@linux.dev>
 <1eeb84d4-42b1-d204-ece1-b76bfbc548bf@linux.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <1eeb84d4-42b1-d204-ece1-b76bfbc548bf@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/28 06:55, Christoph Lameter (Ampere) wrote:
> On Tue, 27 Feb 2024, Chengming Zhou wrote:
> 
>>> We could mark the state change (list ownership) in the slab metadata and then abort the scan if the state mismatches the list.
>>
>> It seems feasible, maybe something like below?
>>
>> But this way needs all kmem_caches have SLAB_TYPESAFE_BY_RCU, right?
> 
> No.
> 
> If a slab is freed to the page allocator and the fields are reused in a different way then we would have to wait till the end of the RCU period. This could be done with a deferred free. Otherwise we have the type checking to ensure that nothing untoward happens in the RCU period.
> 
> The usually shuffle of the pages between freelists/cpulists/cpuslab and fully used slabs would not require that.

IIUC, your method doesn't need the slab struct (page) to be delay freed by RCU.

So that page struct maybe reused to anything by buddy, even maybe freed, right?

Not sure the RCU read lock protection is enough here, do we need to hold other
lock, like memory hotplug lock?

> 
>> Not sure if this is acceptable? Which may cause random delay of memory free.
>>
>> ```
>> retry:
>>     rcu_read_lock();
>>
>>     h = rcu_dereference(list_next_rcu(&n->partial));
>>
>>     while (h != &n->partial) {
> 
> Hmm... a linked list that forms a circle? Linked lists usually terminate in a NULL pointer.

I think the node partial list should be a double-linked list? Since we need to
add slab to its head or tail.

> 
> So this would be
> 
> 
> redo:
> 
>     <zap counters>
>     rcu_read_lock();
>     h = <first>;
> 
>     while (h && h->type == <our type>) {
>           <count h somethings>
> 
>           /* Maybe check h->type again */
>           if (h->type != <our_type>)
>             break;

Another problem of this lockless recheck is that we may get a very false value:
say a slab removed from the node list, then be added to our list in another position,
so passed our recheck conditions here. Which may cause our counting is very mistaken?

Thanks!

> 
>           h = <next>;
>     }
> 
>     rcu_read_unlock();
> 
> 
>     if (!h) /* Type of list changed under us */
>         goto redo;
> 
> 
> The check for type == <our_type> is racy. Maybe we can ignore that or we could do something additional.
> 
> Using RCU does not make sense if you add locking in the inner loop. Then it gets too complicated and causes delay. This must be a simple fast lockless loop in order to do what we need.
> 
> Presumably the type and list pointers are in the same cacheline and thus could made to be updated in a coherent way if properly sequenced with fences etc.

