Return-Path: <linux-kernel+bounces-41231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C68DA83EDB5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6114928442B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7077728DB3;
	Sat, 27 Jan 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p/0ZOj6c"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F0D25779
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706367225; cv=none; b=CIrLiMJ15jKirWKisCirmXh2P6faul2GFJQzPsdsIzi/YRVP4nbNYYF0x7eufb5vKUgnaZSi6cNaN2Au/MoOTCN3xCZL2RHB1JdvutfYudKoebh2cbwhIDosJhoqCpsICHVQlbZ3VT4OyNHRmFfU23VYGWF3EI6R2s2Q0KP5XRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706367225; c=relaxed/simple;
	bh=8OnnEkB+dOkZO7tqPPJOZLI09GPeHhIA0biKrjuXtpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv57LXFzO07T3Q73pF3VOHV9r5GiYqkHBTb+R7qwjP2lpjgW1lfP3hC6mseojU95C222x7zshhZwWm9LBJogXQGlvB2FF/Eiwz2gMLbruWewicxucuEvzq4vsmzXGL+emVIhV6+hnQsJVi/BBrSDHjqIeCcApE0g/xqLvJNxjLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p/0ZOj6c; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4be8962-845a-4f50-b1b5-8c44800758e8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706367220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6yUsk0RLN7Y1NXhRh/1sdnkOngC6GXf4J/3HF7OaPD0=;
	b=p/0ZOj6c/5m8euun3FNWgCzdyFGII6Mmrx2INrB5KlU78Yw0ue91Rgef7N6ZOwCEFJzCih
	gmZqGPFQiQwGuZiBLseX32GCW/JcTVx3OBRshK/1PoWfhCwwDrE2v3lll1QbzzCMfaDcRb
	fsqneWYXBx0kuJ/Ow9lJtZKQKgl9dEw=
Date: Sat, 27 Jan 2024 22:53:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] mm/zswap: fix race between lru writeback and swapoff
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: yosryahmed@google.com, nphamcs@gmail.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240126083015.3557006-1-chengming.zhou@linux.dev>
 <20240126083015.3557006-2-chengming.zhou@linux.dev>
 <20240126153126.GG1567330@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240126153126.GG1567330@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/26 23:31, Johannes Weiner wrote:
> On Fri, Jan 26, 2024 at 08:30:15AM +0000, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> LRU writeback has race problem with swapoff, as spotted by Yosry[1]:
>>
>> CPU1			CPU2
>> shrink_memcg_cb		swap_off
>>   list_lru_isolate	  zswap_invalidate
>> 			  zswap_swapoff
>> 			    kfree(tree)
>>   // UAF
>>   spin_lock(&tree->lock)
>>
>> The problem is that the entry in lru list can't protect the tree from
>> being swapoff and freed, and the entry also can be invalidated and freed
>> concurrently after we unlock the lru lock.
>>
>> We can fix it by moving the swap cache allocation ahead before
>> referencing the tree, then check invalidate race with tree lock,
>> only after that we can safely deref the entry. Note we couldn't
>> deref entry or tree anymore after we unlock the folio, since we
>> depend on this to hold on swapoff.
> 
> This is a great simplification on top of being a bug fix.
> 
>> So this patch moves all tree and entry usage to zswap_writeback_entry(),
>> we only use the copied swpentry on the stack to allocate swap cache
>> and return with folio locked, after which we can reference the tree.
>> Then check invalidate race with tree lock, the following things is
>> much the same like zswap_load().
>>
>> Since we can't deref the entry after zswap_writeback_entry(), we
>> can't use zswap_lru_putback() anymore, instead we rotate the entry
>> in the LRU list so concurrent reclaimers have little chance to see it.
>> Or it will be deleted from LRU list if writeback success.
>>
>> Another confusing part to me is the update of memcg nr_zswap_protected
>> in zswap_lru_putback(). I'm not sure why it's needed here since
>> if we raced with swapin, memcg nr_zswap_protected has already been
>> updated in zswap_folio_swapin(). So not include this part for now.
> 
> Good observation.
> 
> Technically, it could also fail on -ENOMEM, but in practice these size
> allocations don't fail, especially since the shrinker runs in
> PF_MEMALLOC context. The shrink_worker might be affected, since it
> doesn't But the common case is -EEXIST, which indeed double counts.

Ah right, the rotation of the more unlikely case that allocation fail
indeed need to update the memcg nr_zswap_protected, only the case of
-EEXIST has double counts problem.

> 
> To make it "correct", you'd have to grab an objcg reference with the
> LRU lock, and also re-order the objcg put on entry freeing after the
> LRU del. This is probably not worth doing. But it could use a comment.

Agree, will add your comments below.

> 
> I was going to ask if you could reorder objcg uncharging after LRU
> deletion to make it more robust for future changes in that direction.
> However, staring at this, I notice this is a second UAF bug:
> 
> 	if (entry->objcg) {
> 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
> 		obj_cgroup_put(entry->objcg);
> 	}
> 	if (!entry->length)
> 		atomic_dec(&zswap_same_filled_pages);
> 	else {
> 		zswap_lru_del(&entry->pool->list_lru, entry);
> 
> zswap_lru_del() uses entry->objcg to determine the list_lru memcg, but
> the put may have killed it. I'll send a separate patch on top.

Good observation.

> 
>> @@ -860,40 +839,34 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>>  {
>>  	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
>>  	bool *encountered_page_in_swapcache = (bool *)arg;
>> -	struct zswap_tree *tree;
>> -	pgoff_t swpoffset;
>> +	swp_entry_t swpentry;
>>  	enum lru_status ret = LRU_REMOVED_RETRY;
>>  	int writeback_result;
>>  
>> +	/*
>> +	 * First rotate to the tail of lru list before unlocking lru lock,
>> +	 * so the concurrent reclaimers have little chance to see it.
>> +	 * It will be deleted from the lru list if writeback success.
>> +	 */
>> +	list_move_tail(item, &l->list);
> 
> We don't hold a reference to the object, so there could also be an
> invalidation waiting on the LRU lock, which will free the entry even
> when writeback fails.
> 
> It would also be good to expand on the motivation, because it's not
> clear WHY you'd want to hide it from other reclaimers.

Right, my comments are not clear enough.

> 
> Lastly, maybe mention the story around temporary failures? Most
> shrinkers have a lock inversion pattern (object lock -> LRU lock for
> linking versus LRU lock -> object trylock during reclaim) that can
> fail and require the same object be tried again before advancing.

Your comments are great, will add in the next version.

Thanks.

> 
> How about this?
> 
> 	/*
> 	 * Rotate the entry to the tail before unlocking the LRU,
> 	 * so that in case of an invalidation race concurrent
> 	 * reclaimers don't waste their time on it.
> 	 *
> 	 * If writeback succeeds, or failure is due to the entry
> 	 * being invalidated by the swap subsystem, the invalidation
> 	 * will unlink and free it.
> 	 *
> 	 * Temporary failures, where the same entry should be tried
> 	 * again immediately, almost never happen for this shrinker.
> 	 * We don't do any trylocking; -ENOMEM comes closest,
> 	 * but that's extremely rare and doesn't happen spuriously
> 	 * either. Don't bother distinguishing this case.
> 	 *
> 	 * But since they do exist in theory, the entry cannot just
> 	 * be unlinked, or we could leak it. Hence, rotate.
> 	 */
> 
> Otherwise, looks great to me.
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

