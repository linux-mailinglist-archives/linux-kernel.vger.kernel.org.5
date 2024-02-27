Return-Path: <linux-kernel+bounces-84149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C1886A2E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A46CDB2784B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F9755C28;
	Tue, 27 Feb 2024 22:55:25 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7753E07
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074524; cv=none; b=rL39KgtitGlfYXJJZ33paz9NLiXV1MWi/5yYRNACXEdGq0IBQJy4AwvqEKu9N560v2PGYXbACtGyQQXVH6Ni5mq+Y+gPPJPYCv5FP3KGM1sYTed363aQOjttiiUxQsl+f1elY8+OfjR8qkv4Rn/USEpurySFDEmiLWyyzHeMUis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074524; c=relaxed/simple;
	bh=q5QxgcX7+T+9PWSY+6fPy/pMpMaEHQGVkTrDcbx2WCY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HsL4s8a6JLhp/OtzZlkhKM0YACb4CFL/5ANlNe5xUsy66Y31UUCbcQs1gFXgj2lla2Zy3JjBTYB1RUclRKSAAnZ85H9LzQK1BtsDD25txRc7VlWhXHj3UNu00KcQpTE4bRa5WChh6ABHaPXli6pMzSOw6niJJVRzuEDrHTF0DQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 7110540AB1; Tue, 27 Feb 2024 14:55:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 7052F40941;
	Tue, 27 Feb 2024 14:55:15 -0800 (PST)
Date: Tue, 27 Feb 2024 14:55:15 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Chengming Zhou <chengming.zhou@linux.dev>
cc: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
    Jianfeng Wang <jianfeng.w.wang@oracle.com>, penberg@kernel.org, 
    iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, 
    roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in
 get_slabinfo()
In-Reply-To: <eec445a6-7024-40b6-9d4e-7fc2bc71cce7@linux.dev>
Message-ID: <1eeb84d4-42b1-d204-ece1-b76bfbc548bf@linux.com>
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com> <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com> <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz> <55ccc92a-79fa-42d2-97d8-b514cf00823b@linux.dev> <6daf88a2-84c2-5ba4-853c-c38cca4a03cb@linux.com>
 <e924c39b-7636-4c34-bfe9-603cf07c21d3@linux.dev> <b8f393fb-2b1d-213c-9301-35d4ffca1f50@linux.com> <347b870e-a7d5-45df-84ba-4eee37b74ff6@linux.dev> <1a952209-fa22-4439-af27-bf102c7d742b@suse.cz> <cce26aef-ab3e-447b-8b33-5ecd78bf747d@linux.dev>
 <2744dd57-e76e-4d80-851a-02898f87f9be@suse.cz> <036f2bb4-b086-2988-e46d-86d399405687@linux.com> <eec445a6-7024-40b6-9d4e-7fc2bc71cce7@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-782571119-1709074515=:1258276"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-782571119-1709074515=:1258276
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 27 Feb 2024, Chengming Zhou wrote:

>> We could mark the state change (list ownership) in the slab metadata and then abort the scan if the state mismatches the list.
>
> It seems feasible, maybe something like below?
>
> But this way needs all kmem_caches have SLAB_TYPESAFE_BY_RCU, right?

No.

If a slab is freed to the page allocator and the fields are reused in a 
different way then we would have to wait till the end of the RCU period. 
This could be done with a deferred free. Otherwise we have the type 
checking to ensure that nothing untoward happens in the RCU period.

The usually shuffle of the pages between freelists/cpulists/cpuslab and 
fully used slabs would not require that.

> Not sure if this is acceptable? Which may cause random delay of memory free.
>
> ```
> retry:
> 	rcu_read_lock();
>
> 	h = rcu_dereference(list_next_rcu(&n->partial));
>
> 	while (h != &n->partial) {

Hmm... a linked list that forms a circle? Linked lists usually terminate 
in a NULL pointer.

So this would be


redo:

 	<zap counters>
 	rcu_read_lock();
 	h = <first>;

 	while (h && h->type == <our type>) {
 		  <count h somethings>

 		  /* Maybe check h->type again */
 		  if (h->type != <our_type>)
 			break;

 		  h = <next>;
 	}

 	rcu_read_unlock();


 	if (!h) /* Type of list changed under us */
 		goto redo;


The check for type == <our_type> is racy. Maybe we can ignore that or 
we could do something additional.

Using RCU does not make sense if you add locking in the inner loop. Then 
it gets too complicated and causes delay. This must be a simple fast 
lockless loop in order to do what we need.

Presumably the type and list pointers are in the same cacheline and thus 
could made to be updated in a coherent way if properly sequenced with 
fences etc.

--8323329-782571119-1709074515=:1258276--

