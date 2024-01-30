Return-Path: <linux-kernel+bounces-43668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B4584176B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8A91C22AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107E410942;
	Tue, 30 Jan 2024 00:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZXOuaPk"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC6EC9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706574139; cv=none; b=kUM91PM7iMwRZ9NZtaHh01OiiUDAJR5ZQt6jih+prQSJJXGfaphelRG5wLWm7HhkGu/dbUW7W27V4x1SKUjHiRA9n6stF7+Sna9Mbd3twgS+JU+/Wdd32bDLcAOqGI0ZGrLThLlP/eAE7P9YmEXjsX2tGWA9ht/LTuJ5ls4xw8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706574139; c=relaxed/simple;
	bh=orr20qR9DWC+mjzxsJ5nBFBDZfW2bQWMDde7WdjsJIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CiutIVpy6tBe+qp398fsEQgJkgmyqkG4K2hJCsYAdrEeTpvLntzXsIMGg/i4VPiphPMqq4Ql7TapiyrY+s2G/zR9+2rdrsGW9/SVan+3vHD8/jbQ5YWWCUGxuZ5JyiJsINp0W8lX++2wNupRXm798Dr7o0bzQNhrkKEoafIKkTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZXOuaPk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc236791689so5370780276.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706574136; x=1707178936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F78ItJHSnk6v7TJwnpc75w6j6ObmvfAFLcbwc8cbrb4=;
        b=GZXOuaPky6aTmFYEe/x7/rJDFvplF5TeN09/tVQnyA4nxM6r1ByBFWuiefqEZa3f+Y
         PLcIMwHj/Yrp5ePR2BMbk6gHmzlRp1qdmGBmvDpM0fut+ZctfpvOr3woYeFVszMguZf/
         KSSnNt4nv2QEjF5Am92loa6mdL0CvdwfxFt17L35aJMNSYzAFduVr0a3xJ25pWo7rfiB
         b5DoJg1SSxqiP1dYJGmIzmJPNC0tyxnbhOBbnBKvhsf047hXXFbWmeZh49mnbNpP2V7l
         GuD/xaZ/c4P4roL5Q8+deJSyCyX4FQbu67n2c/h2qIQnumrKMvQ1NppgrmzVNsDedMqD
         PVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706574136; x=1707178936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F78ItJHSnk6v7TJwnpc75w6j6ObmvfAFLcbwc8cbrb4=;
        b=NGNwvHSeSSNZKx/HcbLHehxDGX6fvgjsTE+eFj7PlqbJqJIjNVl6PtSs9PUcdjluiK
         wQh7bCWp+INvNirBV/k06KCzw3yllgwtsqlGi7jOOMF5QwjHxjbROFrgGb0ex7cd6OtM
         K+50Rd3vaJ30DkfZyj8/XEdWbKOj0d9e+J/fEip32AgWZJxwIYhMiR7wmRUdVzSnQyi+
         KUpKuXOFIME91HRftpu0FIPA3Qlr41fdibxFz80HOD41CJ7PKRsvoCZB6iocL4cMIJ8z
         IanDHCEknsXXsBt+FFlPeu1xKvxbymkf0UJFfS/rxe9CeQbZIoIUiRvFCkiljHkhjG9J
         Kpgw==
X-Gm-Message-State: AOJu0YzQajbDmbEBrd5WAOjAoKbjIl4dZRU86lYd35IR0n8+jQpIjBZk
	GrCUv6YmEMGy3WYSO+umDLofHdmRcT8c2S6psWngz9rJViCuBHrdpe2+622ctFcArChnYAryTqn
	2FrCld7+0tAPQkS1QZw==
X-Google-Smtp-Source: AGHT+IEUs9nJVgft0nruXb0OzaYuuf2VjEd1+twkYVsClIVgQe5soSOs21qguuxf8WouQ1emBpkUcVpbLRWvVfNh
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2205:b0:dc2:23f5:1791 with
 SMTP id dm5-20020a056902220500b00dc223f51791mr2687960ybb.6.1706574136468;
 Mon, 29 Jan 2024 16:22:16 -0800 (PST)
Date: Tue, 30 Jan 2024 00:22:14 +0000
In-Reply-To: <20240126-zswap-writeback-race-v2-2-b10479847099@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com> <20240126-zswap-writeback-race-v2-2-b10479847099@bytedance.com>
Message-ID: <ZbhBNkayw1hNlkpL@google.com>
Subject: Re: [PATCH v2 2/3] mm/zswap: fix race between lru writeback and swapoff
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chriscli@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Sun, Jan 28, 2024 at 01:28:50PM +0000, Chengming Zhou wrote:
> LRU writeback has race problem with swapoff, as spotted by Yosry [1]:
> 
> CPU1			CPU2
> shrink_memcg_cb		swap_off
>   list_lru_isolate	  zswap_invalidate
> 			  zswap_swapoff
> 			    kfree(tree)
>   // UAF
>   spin_lock(&tree->lock)
> 
> The problem is that the entry in lru list can't protect the tree from
> being swapoff and freed, and the entry also can be invalidated and freed
> concurrently after we unlock the lru lock.
> 
> We can fix it by moving the swap cache allocation ahead before
> referencing the tree, then check invalidate race with tree lock,
> only after that we can safely deref the entry. Note we couldn't
> deref entry or tree anymore after we unlock the folio, since we
> depend on this to hold on swapoff.
> 
> So this patch moves all tree and entry usage to zswap_writeback_entry(),
> we only use the copied swpentry on the stack to allocate swap cache
> and if returned with folio locked we can reference the tree safely.
> Then we can check invalidate race with tree lock, the following things
> is much the same like zswap_load().
> 
> Since we can't deref the entry after zswap_writeback_entry(), we
> can't use zswap_lru_putback() anymore, instead we rotate the entry
> in the beginning. And it will be unlinked and freed when invalidated
> if writeback success.

You are also removing one redundant lookup from the zswap writeback path
to check for the invalidation race, and simplifying the code. Give
yourself full credit :)

> 
> Another change is we don't update the memcg nr_zswap_protected in
> the -ENOMEM and -EEXIST cases anymore. -EEXIST case means we raced
> with swapin or concurrent shrinker action, since swapin already
> have memcg nr_zswap_protected updated, don't need double counts here.
> For concurrent shrinker, the folio will be writeback and freed anyway.
> -ENOMEM case is extremely rare and doesn't happen spuriously either,
> so don't bother distinguishing this case.
> 
> [1] https://lore.kernel.org/all/CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com/
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 114 ++++++++++++++++++++++++++-----------------------------------
>  1 file changed, 49 insertions(+), 65 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 81cb3790e0dd..f5cb5a46e4d7 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -277,7 +277,7 @@ static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
>  		 zpool_get_type((p)->zpools[0]))
>  
>  static int zswap_writeback_entry(struct zswap_entry *entry,
> -				 struct zswap_tree *tree);
> +				 swp_entry_t swpentry);
>  static int zswap_pool_get(struct zswap_pool *pool);
>  static void zswap_pool_put(struct zswap_pool *pool);
>  
> @@ -445,27 +445,6 @@ static void zswap_lru_del(struct list_lru *list_lru, struct zswap_entry *entry)
>  	rcu_read_unlock();
>  }
>  
> -static void zswap_lru_putback(struct list_lru *list_lru,
> -		struct zswap_entry *entry)
> -{
> -	int nid = entry_to_nid(entry);
> -	spinlock_t *lock = &list_lru->node[nid].lock;
> -	struct mem_cgroup *memcg;
> -	struct lruvec *lruvec;
> -
> -	rcu_read_lock();
> -	memcg = mem_cgroup_from_entry(entry);
> -	spin_lock(lock);
> -	/* we cannot use list_lru_add here, because it increments node's lru count */
> -	list_lru_putback(list_lru, &entry->lru, nid, memcg);
> -	spin_unlock(lock);
> -
> -	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(entry_to_nid(entry)));
> -	/* increment the protection area to account for the LRU rotation. */
> -	atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
> -	rcu_read_unlock();
> -}
> -
>  /*********************************
>  * rbtree functions
>  **********************************/
> @@ -860,40 +839,47 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>  {
>  	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
>  	bool *encountered_page_in_swapcache = (bool *)arg;
> -	struct zswap_tree *tree;
> -	pgoff_t swpoffset;
> +	swp_entry_t swpentry;
>  	enum lru_status ret = LRU_REMOVED_RETRY;
>  	int writeback_result;
>  
> +	/*
> +	 * Rotate the entry to the tail before unlocking the LRU,
> +	 * so that in case of an invalidation race concurrent
> +	 * reclaimers don't waste their time on it.
> +	 *
> +	 * If writeback succeeds, or failure is due to the entry
> +	 * being invalidated by the swap subsystem, the invalidation
> +	 * will unlink and free it.
> +	 *
> +	 * Temporary failures, where the same entry should be tried
> +	 * again immediately, almost never happen for this shrinker.
> +	 * We don't do any trylocking; -ENOMEM comes closest,
> +	 * but that's extremely rare and doesn't happen spuriously
> +	 * either. Don't bother distinguishing this case.
> +	 *
> +	 * But since they do exist in theory, the entry cannot just
> +	 * be unlinked, or we could leak it. Hence, rotate.

The entry cannot be unlinked because we cannot get a ref on it without
holding the tree lock, and we cannot deref the tree before we acquire a
swap cache ref in zswap_writeback_entry() -- or if
zswap_writeback_entry() fails. This should be called out explicitly
somewhere. Perhaps we can describe this whole deref dance with added
docs to shrink_memcg_cb().

We could also use a comment in zswap_writeback_entry() (or above it) to
state that we only deref the tree *after* we get the swapcache ref.

