Return-Path: <linux-kernel+bounces-78072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D682F860E99
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BD91C225C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1155DF35;
	Fri, 23 Feb 2024 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J4HpwTYM"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631B65DF26
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681593; cv=none; b=CD/jnuebEXf/dFuY/wTyPNfOsAY7FA2aW1UGolYNH/oM001mqB5iB0KvUGHZK+CDHFwh4k02MTu8BiBIMIJTBs6v4bOnQEkJoB4ai9yTC3IaAAgY/TNjFAvQfx+w4JXpM2VupL4FPnnlA1kprmz918xThP1F9JuUwBwiZAx09Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681593; c=relaxed/simple;
	bh=01nQ2INiur/d81dixqIGZASE4fhqoRl6nVtTuECzPUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFrAB2NcEwfCn12Ykg6G3EekjbvlFFLeGGuGzEod5lRZnd52an/tvwFbcRS5MdNTEc8i6nmX1L3Hp4Bxizq2iDuVF+joa+frafldeXLlBtlqmGIoAgP43L52uVoPOEM1zOXchWJSMwpLO/iSDiri+pFfAQ0gFMXt+V3XG6IXDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J4HpwTYM; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f33680e3-9593-4b81-84a5-810fa8b69c97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708681589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zUiVr8FrIAV4I+cbYerjVXtjBCfQ4VEZa/T8yi40/2g=;
	b=J4HpwTYMVOZ8VP7bU1cV1rYmzDonWG/A1zW8q70YrEx0MGtGx9hC/oWrgvqOVCWIPNEqUP
	g7z9j3eDRshD4UGUyxvxtKfTh8fzCdgMa4sNpcf3H0dteo4DDroTQC3bghf73+zbVR37ly
	ahRhXlHe5qVS/9GnHQ6jLViigwpBuno=
Date: Fri, 23 Feb 2024 17:46:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>,
 "Christoph Lameter (Ampere)" <cl@linux.com>
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <cce26aef-ab3e-447b-8b33-5ecd78bf747d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/23 17:37, Chengming Zhou wrote:
> On 2024/2/23 17:24, Vlastimil Babka wrote:
>> On 2/23/24 06:00, Chengming Zhou wrote:
>>> On 2024/2/23 11:50, Christoph Lameter (Ampere) wrote:
>>>> On Fri, 23 Feb 2024, Chengming Zhou wrote:
>>>>
>>>>>> Can we guestimate the free objects based on the number of partial slabs. That number is available.
>>>>>
>>>>> Yeah, the number of partial slabs is easy to know, but I can't think of a way to
>>>>> estimate the free objects, since __slab_free() is just double cmpxchg in most cases.
>>>>
>>>> Well a starting point may be half the objects possible in a slab page?
>>>
>>> Yeah, also a choice.
>>>
>>>>
>>>>
>>>>>> How accurate need the accounting be? We also have fuzzy accounting in the VM counters.
>>>>>
>>>>> Maybe not need to be very accurate, some delay/fuzzy should be acceptable.
>>>>>
>>>>> Another direction I think is that we don't distinguish slabs on cpu partial list or
>>>>> slabs on node partial list anymore (different with current behavior).
>>>>>
>>>>> Now we have three scopes:
>>>>> 1. SL_ALL: include all slabs
>>>>> 2. SL_PARTIAL: only include partial slabs on node
>>>>> 3. SL_CPU: only include partail slabs on cpu and the using cpu slab
>>>>>
>>>>> If we change SL_PARTIAL to mean all partial slabs, it maybe simpler.
>>>>
>>>> Thats not going to work since you would have to scan multiple lists instead of a single list.
>>>
>>> We have to use percpu counters if we go this way.
>>>
>>>>
>>>> Another approach may be to come up with some way to scan the partial lists without taking locks. That actually would improve the performance of the allocator. It may work with a single linked lists and RCU.
>>
>> We often remove a slab from the middle of a partial list due to object
>> freeing, and this means it has to be double linked, no?
> 
> Right, double linked list.
> 
>>
>>>>
>>>
>>> I think this is a better direction! We can use RCU list if slab can be freed by RCU.
>>
>> Often we remove slab from the partial list for other purposes than freeing -
>> i.e. to become a cpu (partial) slab, and that can't be handled by a rcu
>> callback nor can we wait a grace period in such situations.
> 
> IMHO, only free_slab() need to use call_rcu() to delay free the slab,
> other paths like taking partial slabs from node partial list don't need
> to wait for RCU grace period.
> 
> All we want is safely lockless iterate over the node partial list, right?
Ah, I'm wrong, these paths also need to wait for RCU grace period...


