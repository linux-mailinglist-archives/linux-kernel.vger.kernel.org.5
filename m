Return-Path: <linux-kernel+bounces-36539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C783A2CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68099286091
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB2316423;
	Wed, 24 Jan 2024 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EZwxF7M+"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A317559
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706080897; cv=none; b=cRRnA/w4H31J33EAPRawIO1kQYL2hnWgr0lWr/OPwwFTCyyCbvLU9pTTvN3ffdoQBuB2k1yFHSq3ReC+HMZq27fF0feu9QOBQKIwlqpfJNa2mL12+iHd77PuzYgePLOU7sIHvv6go/ex1yWyfooCWL33czIEhz2GXMyYDnkbNfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706080897; c=relaxed/simple;
	bh=H4FPoZmhlXh+UBl1asCFne9JixAG+p+9IHwyhrhCo5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7mHuNvn/ppYYHY0CMaPuml8C+nqKRNllyCDPp0wVL/IUu/8d0fM6mJSdKKsbqlCI/tnxrkgaZLMloUFg816OH0X81BgCTjiDOi/aWTbiGxcvhONyP6dlse3oqWZ1ivnt/Dej2yZt/G5RStnP6iI6/hv4a56xjxpFXHRl82Nhg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EZwxF7M+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6dd6c3c8a0eso1276741b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706080894; x=1706685694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p6qgzXs3nbDCD4wLGTSejG/03+G+KZIJh31uHA04T3Q=;
        b=EZwxF7M+UzQZXoMSn1pEU1nYjXjTsoakHMRhoXxAGlEMwg1Q1PcMf6OeRALh2Pgo/c
         NqD3oJZs+kyWWnRkleoEO64gXRkkTvoQDtVT1Ziq0GvK7M//KMij5bbYQR5GWsPsHgAy
         TdRmwzBqC728PI+X/mYnuNNJgKAfXOVyjFqMBzEuunnWz47sjn3rAtOreZR9exn1AGkL
         zGeqEwtBqkplVHTXG6pFj8tJ/49/eCVR8at5p89m2mRj69IcaY7mYLc/rGY9WoGffMTX
         DQDa0ULXm6L5eBLPwNH6mWdmMEZZ1OfcxXLW04yAPVKPra/7NsfEuEhe4l+na/LbeHD2
         8Xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706080894; x=1706685694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6qgzXs3nbDCD4wLGTSejG/03+G+KZIJh31uHA04T3Q=;
        b=AJ0CY1S1n7B8Z0Ehq0HMOX3c6qpi0FPUyH5s2WK0RZwvYgaxgvP2hoqkVJjxQFUyIr
         pvxBeY/tg/o2pIjHcSZBJipO6XcgjELpfjd/nJFitdWt0bGsAGv0X/+z2x9rGIjKNPP9
         Z4bgZwJqA12OnFuaYLOnO4cdci6C5DbyjII2e40Eq+YC4E4AVkFPiZgjIOwLmT6bla2U
         dRNUmqeDqhEVWJSWxFA2/G0gjlaqo8pw8nTuZfsQaQfigKkoVIyjFlIeUcxhXX+q0+A+
         YcipuPlwlVdbzO3xuOPgY7MPL7YJ/FmLC1uIl0PgSQ4H+goTecS4kVbqJubwo7fbi7OV
         rcqg==
X-Gm-Message-State: AOJu0YxXyNCXPYYFoU/VMjHOsT6YWBOUHtIRoSDtEJMTaWmfs0911byy
	SzH+p9cCsOyGagrSANFPuyIUw/ueiJDn4QpgZ4XKunWd2XPWPxvkSQq9N0vAk48=
X-Google-Smtp-Source: AGHT+IGhTSDybLlJ8KNCkFczYV9Bwwg1uq8s3cZJ+hBG5T57FY1HS7XjRrxe2joN1a2M/D1GbPmpSQ==
X-Received: by 2002:a62:ce87:0:b0:6dd:a2ea:6626 with SMTP id y129-20020a62ce87000000b006dda2ea6626mr24143pfg.16.1706080894338;
        Tue, 23 Jan 2024 23:21:34 -0800 (PST)
Received: from [10.255.203.131] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id t40-20020aa78fa8000000b006daca8ecb85sm12932159pfs.139.2024.01.23.23.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 23:21:33 -0800 (PST)
Message-ID: <f3fa799f-1815-4cfe-abc8-3ba929fcd1ba@bytedance.com>
Date: Wed, 24 Jan 2024 15:20:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in
 zswap_swapoff()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, Huang Ying <ying.huang@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com>
 <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org>
 <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
 <20240123201234.GC1745986@cmpxchg.org>
 <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/1/24 05:02, Yosry Ahmed wrote:
> On Tue, Jan 23, 2024 at 12:12 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>
>> On Tue, Jan 23, 2024 at 07:54:49AM -0800, Yosry Ahmed wrote:
>>> On Tue, Jan 23, 2024 at 7:38 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>>
>>>> On Mon, Jan 22, 2024 at 12:39:16PM -0800, Yosry Ahmed wrote:
>>>>> On Mon, Jan 22, 2024 at 12:19 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>>>>
>>>>>> On Sat, Jan 20, 2024 at 02:40:07AM +0000, Yosry Ahmed wrote:
>>>>>>> During swapoff, try_to_unuse() makes sure that zswap_invalidate() is
>>>>>>> called for all swap entries before zswap_swapoff() is called. This means
>>>>>>> that all zswap entries should already be removed from the tree. Simplify
>>>>>>> zswap_swapoff() by removing the tree cleanup loop, and leaving an
>>>>>>> assertion in its place.
>>>>>>>
>>>>>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>>>>>>
>>>>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>>>>>
>>>>>> That's a great simplification.
>>>>>>
>>>>>> Removing the tree->lock made me double take, but at this point the
>>>>>> swapfile and its cache should be fully dead and I don't see how any of
>>>>>> the zswap operations that take tree->lock could race at this point.
>>>>>
>>>>> It took me a while staring at the code to realize this loop is pointless.
>>>>>
>>>>> However, while I have your attention on the swapoff path, there's a
>>>>> slightly irrelevant problem that I think might be there, but I am not
>>>>> sure.
>>>>>
>>>>> It looks to me like swapoff can race with writeback, and there may be
>>>>> a chance of UAF for the zswap tree. For example, if zswap_swapoff()
>>>>> races with shrink_memcg_cb(), I feel like we may free the tree as it
>>>>> is being used. For example if zswap_swapoff()->kfree(tree) happen
>>>>> right before shrink_memcg_cb()->list_lru_isolate(l, item).
>>>>>
>>>>> Please tell me that I am being paranoid and that there is some
>>>>> protection against zswap writeback racing with swapoff. It feels like
>>>>> we are very careful with zswap entries refcounting, but not with the
>>>>> zswap tree itself.
>>>>
>>>> Hm, I don't see how.
>>>>
>>>> Writeback operates on entries from the LRU. By the time
>>>> zswap_swapoff() is called, try_to_unuse() -> zswap_invalidate() should
>>>> will have emptied out the LRU and tree.
>>>>
>>>> Writeback could have gotten a refcount to the entry and dropped the
>>>> tree->lock. But then it does __read_swap_cache_async(), and while
>>>> holding the page lock checks the tree under lock once more; if that
>>>> finds the entry valid, it means try_to_unuse() hasn't started on this
>>>> page yet, and would be held up by the page lock/writeback state.
>>>
>>> Consider the following race:
>>>
>>> CPU 1                                 CPU 2
>>> # In shrink_memcg_cb()     # In swap_off
>>> list_lru_isolate()
>>>                                             zswap_invalidate()
>>>                                             ..
>>>                                             zswap_swapoff() -> kfree(tree)
>>> spin_lock(&tree->lock);
>>>
>>> Isn't this a UAF or am I missing something here?
>>
>> Oof. You're right, it looks like there is a bug. Digging through the
>> history, I think this is actually quite old: the original backend
>> shrinkers would pluck something off their LRU, drop all locks, then
>> try to acquire tree->lock. There is no protection against swapoff.
>>
>> The lock that is supposed to protect this is the LRU lock. That's
>> where reclaim and invalidation should synchronize. But it's not right:
>>
>> 1. We drop the LRU lock before acquiring the tree lock. We should
>>    instead trylock the tree while still holding the LRU lock to make
>>    sure the tree is safe against swapoff.
>>
>> 2. zswap_invalidate() acquires the LRU lock when refcount hits 0. But
>>    it must always cycle the LRU lock before freeing the tree for that
>>    synchronization to work.
>>
>> Once we're holding a refcount to the entry, it's safe to drop all
>> locks for the next step because we'll then work against the swapcache
>> and entry: __read_swap_cache_async() will try to pin and lock whatever
>> swap entry is at that type+offset. This also pins the type's current
>> tree. HOWEVER, if swapoff + swapon raced, this could be a different
>> tree than what we had in @tree, so
>>
>> 3. we shouldn't pass @tree to zswap_writeback_entry(). It needs to
>>    look up zswap_trees[] again after __read_swap_cache_async()
>>    succeeded to validate the entry.
>>
>> Once it succeeded, we can validate the entry. The entry is valid due
>> to our refcount. The zswap_trees[type] is valid due to the cache pin.
>>
>> However, if validation failed and we have a non-zero writeback_result,
>> there is one last bug:
>>
>> 4. the original entry's tree is no longer valid for the entry put.
>>
>> The current scheme handles invalidation fine (which is good because
>> that's quite common). But it's fundamentally unsynchronized against
>> swapoff (which has probably gone undetected because that's rare).
>>
>> I can't think of an immediate solution to this, but I wanted to put my
>> analysis out for comments.
> 
> 
> Thanks for the great analysis, I missed the swapoff/swapon race myself :)
> 
> The first solution that came to mind for me was refcounting the zswap
> tree with RCU with percpu-refcount, similar to how cgroup refs are
> handled (init in zswap_swapon() and kill in zswap_swapoff()). I think
> the percpu-refcount may be an overkill in terms of memory usage
> though. I think we can still do our own refcounting with RCU, but it
> may be more complicated.
Hello,

I also thought about this problem for some time, maybe something like below
can be changed to fix it? It's likely I missed something, just some thoughts.

IMHO, the problem is caused by the different way in which we use zswap entry
in the writeback, that should be much like zswap_load().

The zswap_load() comes in with the folio locked in swap cache, so it has
stable zswap tree to search and lock... But in writeback case, we don't,
shrink_memcg_cb() comes in with only a zswap entry with lru list lock held,
then release lru lock to get tree lock, which maybe freed already.

So we should change here, we read swpentry from entry with lru list lock held,
then release lru lock, to try to lock corresponding folio in swap cache,
if we success, the following things is much the same like zswap_load().
We can get tree lock, to recheck the invalidate race, if no race happened,
we can make sure the entry is still right and get refcount of it, then
release the tree lock.

The main differences between this writeback with zswap_load() is the handling
of lru entry and the tree lifetime. The whole zswap_load() function has the
stable reference of zswap tree, but it's not for shrink_memcg_cb() bottom half
after __swap_writepage() since we unlock the folio after that. So we can't
reference the tree after that.

This problem is easy to fix, we can zswap_invalidate_entry(tree, entry) early
in tree lock, since thereafter writeback can't fail. BTW, I think we should
also zswap_invalidate_entry() early in zswap_load() and only support the
zswap_exclusive_loads_enabled mode, but that's another topic.

The second difference is the handling of lru entry, which is easy that we
just zswap_lru_del() in tree lock.

So no any path can reference the entry from tree or lru after we release
the tree lock, so we can just zswap_free_entry() after writeback.

Thanks!

// lru list lock held
shrink_memcg_cb()
  swpentry = entry->swpentry
  // Don't isolate entry from lru list here, just use list_lru_putback()
  spin_unlock(lru list lock)

  folio = __read_swap_cache_async(swpentry)
  if (!folio)
    return

  if (!folio_was_allocated)
    folio_put(folio)
    return

  // folio is locked, swapcache is secured against swapoff
  tree = get tree from swpentry
  spin_lock(&tree->lock)

  // check invalidate race? No
  if (entry == zswap_rb_search())

  // so we can make sure this entry is still right
  // zswap_invalidate_entry() since the below writeback can't fail
  zswap_entry_get(entry)
  zswap_invalidate_entry(tree, entry)

  // remove from lru list
  zswap_lru_del()

  spin_unlock(&tree->lock)

  __zswap_load()

  __swap_writepage() // folio unlock
  folio_put(folio)

  // entry is safe to free, since it's removed from tree and lru above
  zswap_free_entry(entry)


