Return-Path: <linux-kernel+bounces-82089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD87867F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215611F243A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D9212F38E;
	Mon, 26 Feb 2024 17:38:27 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7061292FF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969106; cv=none; b=YtVDdvdIH4Mu2ZR0yeGBziE58riAFeJg29I3UQ+mYm93DW1f1sM6ohieyy/uOwyykMycVBwC+K/q2DRN3GlkbT9vQScYdPPjHbzy31yRsiqUanUKK7297wRRv3vx1Ml4/tczmmOt7Lfou6gG92y+zrs9FIkDEiimE2EZZsmhgwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969106; c=relaxed/simple;
	bh=J/LBNtXIlqt0FzDrb5ORYkpI5rbJcfJeWW54jVJkWgY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eblHDuwrQ/QdOv51NZzstsW4u0+Bv6IIolMawwJ9f25xPZEFDqLk1kfLFwL22R2n+t9GHea0yeQq2FfMn0hMd697Dy4mr7oLFDQ5PrQDVOO4dYJ4huekPZarS0y41QkmhqpauvoKWAgsoKl8EkgNKp+mn2EbWU++GK5Sugztmqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id E16F640A97; Mon, 26 Feb 2024 09:38:17 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id E0A684093E;
	Mon, 26 Feb 2024 09:38:17 -0800 (PST)
Date: Mon, 26 Feb 2024 09:38:17 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Chengming Zhou <chengming.zhou@linux.dev>, 
    David Rientjes <rientjes@google.com>, 
    Jianfeng Wang <jianfeng.w.wang@oracle.com>, penberg@kernel.org, 
    iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, 
    roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in
 get_slabinfo()
In-Reply-To: <2744dd57-e76e-4d80-851a-02898f87f9be@suse.cz>
Message-ID: <036f2bb4-b086-2988-e46d-86d399405687@linux.com>
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com> <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com> <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz> <55ccc92a-79fa-42d2-97d8-b514cf00823b@linux.dev> <6daf88a2-84c2-5ba4-853c-c38cca4a03cb@linux.com>
 <e924c39b-7636-4c34-bfe9-603cf07c21d3@linux.dev> <b8f393fb-2b1d-213c-9301-35d4ffca1f50@linux.com> <347b870e-a7d5-45df-84ba-4eee37b74ff6@linux.dev> <1a952209-fa22-4439-af27-bf102c7d742b@suse.cz> <cce26aef-ab3e-447b-8b33-5ecd78bf747d@linux.dev>
 <2744dd57-e76e-4d80-851a-02898f87f9be@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 23 Feb 2024, Vlastimil Babka wrote:

> On 2/23/24 10:37, Chengming Zhou wrote:
>> On 2024/2/23 17:24, Vlastimil Babka wrote:
>>>
>>>>>
>>>>
>>>> I think this is a better direction! We can use RCU list if slab can be freed by RCU.
>>>
>>> Often we remove slab from the partial list for other purposes than freeing -
>>> i.e. to become a cpu (partial) slab, and that can't be handled by a rcu
>>> callback nor can we wait a grace period in such situations.
>>
>> IMHO, only free_slab() need to use call_rcu() to delay free the slab,
>> other paths like taking partial slabs from node partial list don't need
>> to wait for RCU grace period.
>>
>> All we want is safely lockless iterate over the node partial list, right?
>
> Yes, and for that there's the "list_head slab_list", which is in union with
> "struct slab *next" and "int slabs" for the cpu partial list. So if we
> remove a slab from the partial list and rewrite the list_head for the
> partial list purposes, it will break the lockless iterators, right? We would
> have to wait a grace period between unlinking the slab from partial list (so
> no new iterators can reach it), and reusing the list_head (so we are sure
> the existing iterators stopped looking at our slab).

We could mark the state change (list ownership) in the slab metadata and 
then abort the scan if the state mismatches the list.

> Maybe there's more advanced rcu tricks but this is my basic understanding
> how this works.

This could get tricky but we already do similar things with RCU slabs 
objects/metadata where we allow the resuse of the object before the RCU 
period expires and there is an understanding that the user of those 
objects need to verify the type of object matching expectations when 
looking for objects.


