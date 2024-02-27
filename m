Return-Path: <linux-kernel+bounces-82961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B07868C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA32B28A51
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FAE13667A;
	Tue, 27 Feb 2024 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bKXLj5hL"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA49136670
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026243; cv=none; b=QxhMECVgCzBhMbJCJGski3YObBh1WPdY8Qwlm3z6CN3swkCO8cnf74BImxVX0S+P/Fhop2/ZKW0WKiebOLts/wdLaueVrdvsVP55+XdauxQQWGvfvPQtMs2RkSBvClvq/OT4nQRAwJU7N9b1XbbFxb8a3o9xleuiAO6nrBJ7bq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026243; c=relaxed/simple;
	bh=mRwf3yUhQ+xB3p8wBeDY+bHdCvZPGSe6I0Ta1aPezlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsNjY3Ivrj7W9EBug+wY46LUja/yL+ZTB6w3vw71/9HVGoFzR1aInBnld5Ue/JpWmZBRE8HquYgLnxWNrxUsJZIr3g83cYodlQQuJztjUQehiQv/AZb38e8D2hyJxeJ81ih2z8gdtyaBbaGGlQRPiFtGbtq4WHu9/xgR1IX4Jtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bKXLj5hL; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eec445a6-7024-40b6-9d4e-7fc2bc71cce7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709026239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NHq+KgqSjtKqYa5MxxZSSs2Nj7Yc813r6gQt4rO1/Q=;
	b=bKXLj5hLSJUsNyeI/gMIBNFFhBRmsfvMo8OQ4DToqA/j8a4vYcW3pLL+jSyweVPYuLlVwt
	wH14mGlA+eBwhXAH30k3y0ms5/A4Zx+QlQAUbeM0PURwjzlmkjHSqjn8dSPHXotfsByzZB
	hXsYhKpe8xrWy5M4rTZt441EoFHTpiM=
Date: Tue, 27 Feb 2024 17:30:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
Content-Language: en-US
To: "Christoph Lameter (Ampere)" <cl@linux.com>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>,
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <036f2bb4-b086-2988-e46d-86d399405687@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/27 01:38, Christoph Lameter (Ampere) wrote:
> On Fri, 23 Feb 2024, Vlastimil Babka wrote:
> 
>> On 2/23/24 10:37, Chengming Zhou wrote:
>>> On 2024/2/23 17:24, Vlastimil Babka wrote:
>>>>
>>>>>>
>>>>>
>>>>> I think this is a better direction! We can use RCU list if slab can be freed by RCU.
>>>>
>>>> Often we remove slab from the partial list for other purposes than freeing -
>>>> i.e. to become a cpu (partial) slab, and that can't be handled by a rcu
>>>> callback nor can we wait a grace period in such situations.
>>>
>>> IMHO, only free_slab() need to use call_rcu() to delay free the slab,
>>> other paths like taking partial slabs from node partial list don't need
>>> to wait for RCU grace period.
>>>
>>> All we want is safely lockless iterate over the node partial list, right?
>>
>> Yes, and for that there's the "list_head slab_list", which is in union with
>> "struct slab *next" and "int slabs" for the cpu partial list. So if we
>> remove a slab from the partial list and rewrite the list_head for the
>> partial list purposes, it will break the lockless iterators, right? We would
>> have to wait a grace period between unlinking the slab from partial list (so
>> no new iterators can reach it), and reusing the list_head (so we are sure
>> the existing iterators stopped looking at our slab).
> 
> We could mark the state change (list ownership) in the slab metadata and then abort the scan if the state mismatches the list.

It seems feasible, maybe something like below?

But this way needs all kmem_caches have SLAB_TYPESAFE_BY_RCU, right?
Not sure if this is acceptable? Which may cause random delay of memory free.

```
retry:
	rcu_read_lock();

	h = rcu_dereference(list_next_rcu(&n->partial));

	while (h != &n->partial) {
		slab = list_entry(h, struct slab, slab_list);

		/* Recheck slab with node list lock. */
		spin_lock_irqsave(&n->list_lock, flags);
		if (!slab_test_node_partial(slab)) {
			spin_unlock_irqrestore(&n->list_lock, flags);
			rcu_read_unlock();
			goto retry;
		}

		/* Count this slab's inuse. */

		/* Get the next pointer with node list lock. */
		h = rcu_dereference(list_next_rcu(h));
		spin_unlock_irqrestore(&n->list_lock, flags);
	}

	rcu_read_unlock();
```

> 
>> Maybe there's more advanced rcu tricks but this is my basic understanding
>> how this works.
> 
> This could get tricky but we already do similar things with RCU slabs objects/metadata where we allow the resuse of the object before the RCU period expires and there is an understanding that the user of those objects need to verify the type of object matching expectations when looking for objects.
> 

