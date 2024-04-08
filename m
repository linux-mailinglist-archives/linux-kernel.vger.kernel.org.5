Return-Path: <linux-kernel+bounces-135804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B38B789CB91
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7AAB264E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B170C1448C1;
	Mon,  8 Apr 2024 18:17:11 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B6E1442F7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712600231; cv=none; b=uoFm5/WT76vIpWxU79s3gMYfIgUkvlrtoeHXKk8j2VPoq1FjWpmoH05T6sv7/x6d1aKB/s0e7JZd+SAc2NLqNOdmRtvuv6JmPJHJ2KYb1xkllTWpJk5l07zBpC1M3oCwF6bf0BL73kr6uS3Ko0hW1chSu7mPl8lMPwtBNidv72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712600231; c=relaxed/simple;
	bh=fbdAcjzZo3kIrQh8S0gE9I3aQKCKF+z1gndJcfs9lqg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LdE++IPndB0URRK8L2I/kHzPP5MjwJd6L9t25JtA7ZeP+qpNEg8vh6Cy9nhPfNggGd6p9sroNH3cq34d+I3oOMYxkRzMZ6LSZjNn7eV33Dvh5mRt3u4DgzADO+h/v/YFFuNeGqmUqqupMS3tCJBT55/TOY94s27i3fjXDZqsymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 26D3640A8C; Mon,  8 Apr 2024 11:17:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 25F7E40787;
	Mon,  8 Apr 2024 11:17:02 -0700 (PDT)
Date: Mon, 8 Apr 2024 11:17:02 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, penberg@kernel.org, rientjes@google.com, 
    iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, 
    roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, xuqiang36@huawei.com, 
    wangkefeng.wang@huawei.com
Subject: Re: [PATCH v2] mm/slub: Reduce memory consumption in extreme
 scenarios
In-Reply-To: <a8b554c8-b71a-4f0f-a291-996c31674966@suse.cz>
Message-ID: <e3cb4e2d-c80c-71d4-8d86-8391c2780511@linux.com>
References: <20240330082335.29710-1-chenjun102@huawei.com> <0a59e5a1-1961-5eb2-2eb0-a930006e3f80@gentwo.org> <a8b554c8-b71a-4f0f-a291-996c31674966@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 8 Apr 2024, Vlastimil Babka wrote:

> On 4/5/24 6:50 PM, Christoph Lameter (Ampere) wrote:
>> On Sat, 30 Mar 2024, Chen Jun wrote:
>>
>>> When kmalloc_node() is called without __GFP_THISNODE and the target node
>>> lacks sufficient memory, SLUB allocates a folio from a different node
>>> other than the requested node, instead of taking a partial slab from it.
>>
>> Hmmm... This would mean that we do not consult the partial lists of the
>> other nodes. That is something to be fixed in the allocator.
>
> Which allocator? If you mean SLUB, this patch fixes it. If you mean page
> allocator, I don't see how.


The SLUB allocator of course. And the patch does not fix it. It tries to 
convince the page allocator to give us a folio from the right node.

That kind of activity can be controlled within the page allocator via the 
node reclaim setting. No point in doing multiple calls into the page 
allocator.


>>> However, since the allocated folio does not belong to the requested
>>> node, it is deactivated and added to the partial slab list of the node
>>> it belongs to.
>>
>> That should only occur if a request for an object for node X follows a
>> request for an object from node Y.
>
> Are you sure? I think it's a stream of requests for node X happening on a
> cpu of node Y, AFAICS the first attempt will allocate the slab page from
> node different than X (possibly node Y because it's local and has pages
> available unlike node X which is full). It does get installed as the cpu
> slab, but then the next request is also for node X, so the node matching
> checks make the slab deactivate and allocate a new one.

Then there is something broken in the cpuslab logic.

The first request of CPU C for memory from node X should lead to:

1. deactivation of current cpu slab if it is not from node X
2. retrieval of a slab from node X and activation of that slab as cpuslab
3. Return of an object from that slab and therefore from node X.

Further allocation should be caught by the hotpatch where we realize that 
there is a request from node X and the current cpuslab is from node X and 
therefore fastpath logic can be used to retrieve the next object.


>> get_any_partial() should do that. Maybe it is not called in the
>> kmalloc_node case.
>
> Yes, get_any_partial() is currently skipped for requests of numa node
> different from NUMA_NO_NODE.

Maybe we can use that function after checking that the page allocator is 
over the watermark on the node that we were wanting to allocate from. That 
check should be fast.

>> I think it's a useful tradeof to first try satisfy the node preference with
> a GFP_NOWAIT allocation. If it succeeds, the target node is not overloaded,
> we get the page from the desired node and further allocations will of the
> same node will not deactivate it. If it doesn't succeed then we indeed
> fallback to slabs on partial list from other nodes before wastefully
> allocating new pages from the other nodes, which addresses the scenario that
> motivated this patch.

There are also the memory policies etc to consider. F.e. for the 
interleave policy the pages must come from different nodes in sequence to 
properly balance the allocations over multiple NUMA nodes. There are cases 
in which the allocations are forced to specific sets of nodes or where a 
node is preferred but fallback to local should occur.

If you now do multiple page allocator calls then the NUMA interleave 
policy etc etc may no longer work. I have not looked to deep into those.


