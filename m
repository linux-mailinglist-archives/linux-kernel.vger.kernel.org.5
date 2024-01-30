Return-Path: <linux-kernel+bounces-43832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5338A841952
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8231B2813E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F9B364DB;
	Tue, 30 Jan 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="apwh97E/"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834634545
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581830; cv=none; b=Af9V0wpUnJe2LKF440OJx7GjLopVixrS3Wk2Y7+0ngrc/TxrkX3YoERyFztXTmDxUX/VUV0/3JvPieCq+45tImZ70JkV7OWWWSJ1igcgiccaFRwDcyK6zxbC/IBFiHV8FvereERDYpMsQZ83lfRBhmhMPzi2XpTuFDEPvcjyjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581830; c=relaxed/simple;
	bh=1tK65aq00w5a7+LD2l+YbH1nPbkudjM7sj+WjCAda40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfKeQKgqEjKjACHmxGyBWT5RlSdgYAQSsZuXH0mftPPgl1VHesc1YLt+ZNJ4Gc5xXqVQ/v7hglSvSEHazv6prTcFoQlBGb6qYXSAF58jAAcgrJAWky9T7UsHQ8lT79oufuqdk+dCH87yTfpIGAaQ3GWV3SYvKho9cvA9oezMsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=apwh97E/; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbc649c275so1306575b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706581827; x=1707186627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8iMbOMhcDQigHMHzkBs9cWL7KAKUIeL4mt5OHwh9D/M=;
        b=apwh97E/5RY68f3Gz4gnWHURSt+2PolBOSzxo7Usdr1ymaKsxzTKdHhVi1/spkRHe3
         LDS02K0sXX09HlTmQg0V6SOMb03Ta6sMrwvp6OFlcya7TOtDf1DMETBA8QNEg67Fv+Ie
         TY4QQzVKKoWkIFScUyw04pL1oIJcQ19CAwhQi2By5YTMUydCg9mobI3oSAKFaoAOfF9Y
         qofS8T93zFL+mxwkRMSKNrx5AZVjBT8G89wryYrSDFNWl+OHNr1YVttLDcagL2L5Jmeu
         t7lkT3aAo6wDfStcX4SD3naJoKZct1zSdUFy6iy3HBAiUY13eMTAH3fi3knjvllaH0lf
         kxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706581827; x=1707186627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iMbOMhcDQigHMHzkBs9cWL7KAKUIeL4mt5OHwh9D/M=;
        b=I+zrfMW90g6C7Iz/ATKqoMoX6dnzuyMxtxBGN9xamHfVxvNrbBtDjhWfA+r3oEJEKs
         scxn1UA5ESVlUacNA64lSjdJ2N95L65X4F4T95Xt/l+WJP3+5fXzWQT4q27A3eb0m7+G
         +lrFsTjqnzpKghx18H2BsxNQ0baK1odYFdVYJZIkl216e1PLmWZ4dvfjNFejs3qwMibF
         2TjEjMSFtnKsjOynKu8lP7xti9Gim4s3R+JKBgRTFaHcAbCqhBoYNbMoTBoB8v1lY7Aw
         ifZRw5b6jNl5sWcjwfl+3fLERFd3IkysgOHmWX8/8bF6OwBdcslvRVXcWGdOKjZYkccm
         aiXg==
X-Gm-Message-State: AOJu0YzoO/kBhHLXS7KI1oT25mrR6bK6l8wRfWvXbEMfkXK9lH22J/Wu
	tIe4PHL/9+BDFnNBfE9w+UrpMScTn38sAn1Ce2sdQzCdfCFRCDU8elEp6/agPu0=
X-Google-Smtp-Source: AGHT+IEvSdbiqmuh7AWgwFm2qdhPatu2kGGze+C55YwdpehzzqNdsBcjfaMKO33rjkjSvRL9wgNtFQ==
X-Received: by 2002:a05:6808:3009:b0:3bd:c26a:f803 with SMTP id ay9-20020a056808300900b003bdc26af803mr4394813oib.14.1706581826570;
        Mon, 29 Jan 2024 18:30:26 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id n28-20020a635c5c000000b005cfba3c84b7sm6054282pgm.81.2024.01.29.18.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 18:30:26 -0800 (PST)
Message-ID: <527bd543-97a5-4262-be73-6a5d21c2f896@bytedance.com>
Date: Tue, 30 Jan 2024 10:30:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm/zswap: fix race between lru writeback and
 swapoff
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chriscli@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com>
 <20240126-zswap-writeback-race-v2-2-b10479847099@bytedance.com>
 <ZbhBNkayw1hNlkpL@google.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <ZbhBNkayw1hNlkpL@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 08:22, Yosry Ahmed wrote:
> On Sun, Jan 28, 2024 at 01:28:50PM +0000, Chengming Zhou wrote:
>> LRU writeback has race problem with swapoff, as spotted by Yosry [1]:
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
>>
>> So this patch moves all tree and entry usage to zswap_writeback_entry(),
>> we only use the copied swpentry on the stack to allocate swap cache
>> and if returned with folio locked we can reference the tree safely.
>> Then we can check invalidate race with tree lock, the following things
>> is much the same like zswap_load().
>>
>> Since we can't deref the entry after zswap_writeback_entry(), we
>> can't use zswap_lru_putback() anymore, instead we rotate the entry
>> in the beginning. And it will be unlinked and freed when invalidated
>> if writeback success.
> 
> You are also removing one redundant lookup from the zswap writeback path
> to check for the invalidation race, and simplifying the code. Give
> yourself full credit :)

Ah right, forgot to mention it, I will add this part in the commit message.
Thanks for your reminder!

> 
>>
>> Another change is we don't update the memcg nr_zswap_protected in
>> the -ENOMEM and -EEXIST cases anymore. -EEXIST case means we raced
>> with swapin or concurrent shrinker action, since swapin already
>> have memcg nr_zswap_protected updated, don't need double counts here.
>> For concurrent shrinker, the folio will be writeback and freed anyway.
>> -ENOMEM case is extremely rare and doesn't happen spuriously either,
>> so don't bother distinguishing this case.
>>
>> [1] https://lore.kernel.org/all/CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com/
>>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Acked-by: Nhat Pham <nphamcs@gmail.com>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/zswap.c | 114 ++++++++++++++++++++++++++-----------------------------------
>>  1 file changed, 49 insertions(+), 65 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 81cb3790e0dd..f5cb5a46e4d7 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -277,7 +277,7 @@ static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
>>  		 zpool_get_type((p)->zpools[0]))
>>  
>>  static int zswap_writeback_entry(struct zswap_entry *entry,
>> -				 struct zswap_tree *tree);
>> +				 swp_entry_t swpentry);
>>  static int zswap_pool_get(struct zswap_pool *pool);
>>  static void zswap_pool_put(struct zswap_pool *pool);
>>  
>> @@ -445,27 +445,6 @@ static void zswap_lru_del(struct list_lru *list_lru, struct zswap_entry *entry)
>>  	rcu_read_unlock();
>>  }
>>  
>> -static void zswap_lru_putback(struct list_lru *list_lru,
>> -		struct zswap_entry *entry)
>> -{
>> -	int nid = entry_to_nid(entry);
>> -	spinlock_t *lock = &list_lru->node[nid].lock;
>> -	struct mem_cgroup *memcg;
>> -	struct lruvec *lruvec;
>> -
>> -	rcu_read_lock();
>> -	memcg = mem_cgroup_from_entry(entry);
>> -	spin_lock(lock);
>> -	/* we cannot use list_lru_add here, because it increments node's lru count */
>> -	list_lru_putback(list_lru, &entry->lru, nid, memcg);
>> -	spin_unlock(lock);
>> -
>> -	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(entry_to_nid(entry)));
>> -	/* increment the protection area to account for the LRU rotation. */
>> -	atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
>> -	rcu_read_unlock();
>> -}
>> -
>>  /*********************************
>>  * rbtree functions
>>  **********************************/
>> @@ -860,40 +839,47 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
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
>> +	 * Rotate the entry to the tail before unlocking the LRU,
>> +	 * so that in case of an invalidation race concurrent
>> +	 * reclaimers don't waste their time on it.
>> +	 *
>> +	 * If writeback succeeds, or failure is due to the entry
>> +	 * being invalidated by the swap subsystem, the invalidation
>> +	 * will unlink and free it.
>> +	 *
>> +	 * Temporary failures, where the same entry should be tried
>> +	 * again immediately, almost never happen for this shrinker.
>> +	 * We don't do any trylocking; -ENOMEM comes closest,
>> +	 * but that's extremely rare and doesn't happen spuriously
>> +	 * either. Don't bother distinguishing this case.
>> +	 *
>> +	 * But since they do exist in theory, the entry cannot just
>> +	 * be unlinked, or we could leak it. Hence, rotate.
> 
> The entry cannot be unlinked because we cannot get a ref on it without
> holding the tree lock, and we cannot deref the tree before we acquire a
> swap cache ref in zswap_writeback_entry() -- or if
> zswap_writeback_entry() fails. This should be called out explicitly
> somewhere. Perhaps we can describe this whole deref dance with added
> docs to shrink_memcg_cb().

Maybe we should add some comments before or after zswap_writeback_entry()?
Or do you have some suggestions? I'm not good at this. :)

> 
> We could also use a comment in zswap_writeback_entry() (or above it) to
> state that we only deref the tree *after* we get the swapcache ref.

I just notice there are some comments in zswap_writeback_entry(), should
we add more comments here?

	/*
	 * folio is locked, and the swapcache is now secured against
	 * concurrent swapping to and from the slot. Verify that the
	 * swap entry hasn't been invalidated and recycled behind our
	 * backs (our zswap_entry reference doesn't prevent that), to
	 * avoid overwriting a new swap folio with old compressed data.
	 */


