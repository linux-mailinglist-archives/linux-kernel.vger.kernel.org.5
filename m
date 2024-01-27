Return-Path: <linux-kernel+bounces-41236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8953083EDCF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2EE1C213EF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03E028DC7;
	Sat, 27 Jan 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G5pJk6QN"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8016208B2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706368406; cv=none; b=Ns4bQHwx8lOJ2f5jDJwVjrpu9evuhiAF9FDPny6zODBc2ejixOS6C/e5eIEyy5hb30imj0owtkedbR4SfVchxjTu12mScEjDhC5aHhrr5PjSvMxkfe1N+KoVTrK+WTEvkX2JRgtRAFV5JoH1ewLR0xiD9gKpff0jN1yOjPSVvGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706368406; c=relaxed/simple;
	bh=VcqJutMH2vfLdwgtbmSIenLmTf2UZvFCgkmD3X4Qz5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkYD7SqDFeFfEtROr3nQFdTX0W0w02bYIdqui/+Jaaah+hkgzJbh5nu/j3U/tK1MWB0g3/sTobWZb2/adNqQLkOPrx18UBe6G33dKVTu1nLnRX6O5s1rlt2hj5ooS4xAZtinzneWFxxf4NG8UIO3vhXEVVA8sY7Z0otnraNX8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G5pJk6QN; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ec428b7f-7aa4-4da5-885f-9c6de0263a55@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706368401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKz7fE6jNiu3MF1YuBwnJMx1tp8fPNdH12PFAc7i/zo=;
	b=G5pJk6QNLQ++IfvQn/17IJTWwTK25IkGEQ8MJOpuswukBjv7WIiCMIWTMoUAm3q7XDEUb2
	pkV2q7CEXQ6Leq41Y091gB9r8wAf7Acumj2Fy2YsheLHVjMz3W6scjm+Z2PDhJ6W9qZ7RB
	dM2Abep11hK1mTUZPKLwNjEULa+7Hj0=
Date: Sat, 27 Jan 2024 23:12:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] mm/zswap: fix race between lru writeback and swapoff
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240126083015.3557006-1-chengming.zhou@linux.dev>
 <20240126083015.3557006-2-chengming.zhou@linux.dev>
 <CAKEwX=OP_32757xb6ogZ5OaDk_6bhkm--F4akhQ-tj_WTzA4CA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAKEwX=OP_32757xb6ogZ5OaDk_6bhkm--F4akhQ-tj_WTzA4CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/27 03:50, Nhat Pham wrote:
> On Fri, Jan 26, 2024 at 12:32 AM <chengming.zhou@linux.dev> wrote:
>>
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> LRU writeback has race problem with swapoff, as spotted by Yosry[1]:
>>
>> CPU1                    CPU2
>> shrink_memcg_cb         swap_off
>>   list_lru_isolate        zswap_invalidate
>>                           zswap_swapoff
>>                             kfree(tree)
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
>>
>> So this patch moves all tree and entry usage to zswap_writeback_entry(),
>> we only use the copied swpentry on the stack to allocate swap cache
>> and return with folio locked, after which we can reference the tree.
>> Then check invalidate race with tree lock, the following things is
>> much the same like zswap_load().
>>
>> Since we can't deref the entry after zswap_writeback_entry(), we
>> can't use zswap_lru_putback() anymore, instead we rotate the entry
> 
> I added list_lru_putback to the list_lru API specifically for this use
> case (zswap_lru_putback()). Now that we no longer need it, maybe we
> can also remove this as well (assuming no-one else is using this?).
> 
> This can be done in a separate patch though.

Right, I can append a patch to remove it since no other users.

> 
>> in the LRU list so concurrent reclaimers have little chance to see it.
>> Or it will be deleted from LRU list if writeback success.
>>
>> Another confusing part to me is the update of memcg nr_zswap_protected
>> in zswap_lru_putback(). I'm not sure why it's needed here since
>> if we raced with swapin, memcg nr_zswap_protected has already been
>> updated in zswap_folio_swapin(). So not include this part for now.
>>
>> [1] https://lore.kernel.org/all/CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com/
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> LGTM! This is quite elegant.
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> 
>> ---
>>  mm/zswap.c | 93 ++++++++++++++++++------------------------------------
>>  1 file changed, 31 insertions(+), 62 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 81cb3790e0dd..fa2bdb7ec1d8 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -277,7 +277,7 @@ static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
>>                  zpool_get_type((p)->zpools[0]))
>>
>>  static int zswap_writeback_entry(struct zswap_entry *entry,
>> -                                struct zswap_tree *tree);
>> +                                swp_entry_t swpentry);
>>  static int zswap_pool_get(struct zswap_pool *pool);
>>  static void zswap_pool_put(struct zswap_pool *pool);
>>
>> @@ -445,27 +445,6 @@ static void zswap_lru_del(struct list_lru *list_lru, struct zswap_entry *entry)
>>         rcu_read_unlock();
>>  }
>>
>> -static void zswap_lru_putback(struct list_lru *list_lru,
>> -               struct zswap_entry *entry)
>> -{
>> -       int nid = entry_to_nid(entry);
>> -       spinlock_t *lock = &list_lru->node[nid].lock;
>> -       struct mem_cgroup *memcg;
>> -       struct lruvec *lruvec;
>> -
>> -       rcu_read_lock();
>> -       memcg = mem_cgroup_from_entry(entry);
>> -       spin_lock(lock);
>> -       /* we cannot use list_lru_add here, because it increments node's lru count */
>> -       list_lru_putback(list_lru, &entry->lru, nid, memcg);
>> -       spin_unlock(lock);
>> -
>> -       lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(entry_to_nid(entry)));
>> -       /* increment the protection area to account for the LRU rotation. */
>> -       atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
>> -       rcu_read_unlock();
>> -}
>> -
>>  /*********************************
>>  * rbtree functions
>>  **********************************/
>> @@ -860,40 +839,34 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>>  {
>>         struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
>>         bool *encountered_page_in_swapcache = (bool *)arg;
>> -       struct zswap_tree *tree;
>> -       pgoff_t swpoffset;
>> +       swp_entry_t swpentry;
>>         enum lru_status ret = LRU_REMOVED_RETRY;
>>         int writeback_result;
>>
>> +       /*
>> +        * First rotate to the tail of lru list before unlocking lru lock,
>> +        * so the concurrent reclaimers have little chance to see it.
>> +        * It will be deleted from the lru list if writeback success.
>> +        */
>> +       list_move_tail(item, &l->list);
>> +
>>         /*
>>          * Once the lru lock is dropped, the entry might get freed. The
>> -        * swpoffset is copied to the stack, and entry isn't deref'd again
>> +        * swpentry is copied to the stack, and entry isn't deref'd again
>>          * until the entry is verified to still be alive in the tree.
>>          */
>> -       swpoffset = swp_offset(entry->swpentry);
>> -       tree = swap_zswap_tree(entry->swpentry);
>> -       list_lru_isolate(l, item);
> 
> nit: IIUC, now that we're no longer removing the entry from the
> list_lru, we protect against concurrent shrinking action via this
> check inside zswap_writeback_entry() too right:
> 
> if (!folio_was_allocated) {
>    folio_put(folio);
>    return -EEXIST;
> }
> 
> Maybe update the comment above it too?

	 * Found an existing folio, we raced with load/swapin. We generally
	 * writeback cold folios from zswap, and swapin means the folio just
	 * became hot. Skip this folio and let the caller find another one.

So now found an existing folio not only means load/swapin, and also concurrent
shrinking action. Yes, this comment needs to be changed a little.

Thanks.

