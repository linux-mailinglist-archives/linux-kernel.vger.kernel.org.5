Return-Path: <linux-kernel+bounces-91689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E7B871526
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9216D1F234DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF0A45977;
	Tue,  5 Mar 2024 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZQJzO8D"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EFA43ACF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 05:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709615289; cv=none; b=Z9zCbpS8QCgO3x7fDj35dMR8vtbKgz1zRq+PGLGop+45ic65oMGLnWdVQKw+7aWNUljorRO6UTkNyPqMF4U7g3HKIVffaorX9DKKyCEMgVuhi0XnBHZYSazU/iRveNJkQG5ezxhnMlIUZw6EvfF2HOg5K4Vt9p3Ny0JNGzBrQ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709615289; c=relaxed/simple;
	bh=aWzJVHoMY8IcZv6Nv3eWlKKDsu6FJmNiUIZktD43DQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FsJmWK6hYrelrvY0IIlwkFfgJ4ynnsu8wy3Jf9I14egHoff3g1jmFZ0dReLeRmclePoRuNC56QAaNNNR5tzeqSKUIJ4FyBCPqZUmDVCFlCEJcP2Onkr7veiOR2lWsVqq9ZnE9sOSz2iS+D8YQhtSud/biBf/uXp1cINGB8YS1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZQJzO8D; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-299727c3e8bso4289523a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 21:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709615287; x=1710220087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HWU7wBm3j7C8IfxBOdhPsu6PdJWJN1Ia/lUiXC6HF3Y=;
        b=BZQJzO8DSd6US/XT4UlEuluhKc+s6QWf1PjOc95Ui2GaC4qiejrtp9HoOiqLvxpSYg
         WVleGs9NK8gKgox0al6/qMD9nPJ2hNTtbiRZwk/p2dsF03HQhDi/LERDF1MNlUF7Xc1W
         l7jIC/q5PwlhHvGq6JmUs0pC85xdPzB2WwcbS9fyZhMQ0apm6yKD05MNp5V42eCFOFui
         8sS+scVM2mtyRpirPjG6DtaJqXQ6fLKH4sXORvX44dd0oFFv3+Z5p0LgMp0gqrlj3q0X
         8bOA3CVG/HwkMDBFH5XqBovpxfNsG4C+KUtxbstpCwZoEhMz+KWYN1NqLpEyNPiZ2QPw
         //ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709615287; x=1710220087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWU7wBm3j7C8IfxBOdhPsu6PdJWJN1Ia/lUiXC6HF3Y=;
        b=Lk+ABqfGDUF35By6swH1FQv1e/EBcSc+C4rkDiD/2RC+aDVbWC2b+sJ2RElfSRvVec
         NK+QWdoFqgrgHtotVIYfQ764isYDWmDIAyIYWj91txfj5D69ThiKxqSMcq593P39WzqW
         wRYsw1NJs7cjyFsQMNM4NkUOg7OX4GW7N1/K+gRCmwhYMWPuxSKOdHTCtEPV4OV68kci
         KtfPmAkIh8Eok/DtDty0DSrie3Qx4AakUM/Ww3+h1VQU7i+ZGX2zDhbCwHD9CGzkdPad
         VaLmr2IdkXGDK1hoHXE3tKd36FMQEf7mCMwtqx2NhfKAfqZFP63jKyOHv9TsuW9lrlNQ
         7djg==
X-Forwarded-Encrypted: i=1; AJvYcCUn3X0WSgLzd0A7MTz7iIXCcVV/HkYwhFq+Q2OQJXvwHHbshXI0iF/ISsOXeMpAGetdJLGPOESNnRs7cJa9kbvfkrs3lltwyIcZxn2r
X-Gm-Message-State: AOJu0YxBEIJiS+1n8D3YsR2gn41g72Bd/+8D2aXj+IEN5WW7/TUmF74Y
	tZM9ZFWJF9x+KmMw6dg4C7krFnklosCA/ywoBZMN+PQj4Wa+Ec0C5z2UslYQkptIwKAIrZKhl7k
	crp9TsA8bNcjAje4CEw==
X-Google-Smtp-Source: AGHT+IHcufTjzce2l/HOlP7S/qzPSAs8Hfz18YugVirkcv+kRqlB7j0g6WY9l/kN6M/5UCpXZdaGgxZTsqpFBzVd
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:194d:b0:29b:4f15:5fd7 with SMTP
 id nk13-20020a17090b194d00b0029b4f155fd7mr18499pjb.2.1709615286936; Mon, 04
 Mar 2024 21:08:06 -0800 (PST)
Date: Tue, 5 Mar 2024 05:08:04 +0000
In-Reply-To: <20240304-zswap-xarray-v4-1-c4b45670cc30@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304-zswap-xarray-v4-1-c4b45670cc30@kernel.org>
Message-ID: <ZeaotMlpMl88lSlc@google.com>
Subject: Re: [PATCH v4] zswap: replace RB tree with xarray
From: Yosry Ahmed <yosryahmed@google.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="us-ascii"

Hi Chris,

On Mon, Mar 04, 2024 at 01:32:20PM -0800, Chris Li wrote:
> Very deep RB tree requires rebalance at times. That
> contributes to the zswap fault latencies. Xarray does not
> need to perform tree rebalance. Replacing RB tree to xarray
> can have some small performance gain.
> 
> One small difference is that xarray insert might fail with
> ENOMEM, while RB tree insert does not allocate additional
> memory.
> 
> The zswap_entry size will reduce a bit due to removing the
> RB node, which has two pointers and a color field. Xarray
> store the pointer in the xarray tree rather than the
> zswap_entry. Every entry has one pointer from the xarray
> tree. Overall, switching to xarray should save some memory,
> if the swap entries are densely packed.
> 
> Notice the zswap_rb_search and zswap_rb_insert always
> followed by zswap_rb_erase. Use xa_erase directly. The entry
> erase into zswap_xa_insert as well. That saves one tree
> lookup as well.
> 
> Remove zswap_invalidate_entry due to no need to call
> zswap_rb_erase any more. Use zswap_free_entry instead.
> 
> The "struct zswap_tree" has been replaced by "struct xarray".
> The tree spin lock has transferred to the xarray lock.
> 
> Run the kernel build testing 10 times for each version, averages:
> (memory.max=2GB, zswap shrinker and writeback enabled, one 50GB swapfile.)

Please add details about the number of threads and the number of CPUs as
well.

> 
> mm-9a0181a3710eb                    xarray v4
> user       3526.829                            3526.930
> sys        532.754                             526.525
> real       198.748                             198.850
> 
> ---
> 
> 
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
> Changes in v4:
> - Remove zswap_xa_search_and_earse, use xa_erase directly.
> - Move charge of objcg after zswap_xa_insert.
> - Avoid erase old entry on insert fail error path.
> - Remove not needed swap_zswap_tree change
> - Link to v3: https://lore.kernel.org/r/20240302-zswap-xarray-v3-1-5900252f2302@kernel.org
> 
> Changes in v3:
> - Use xa_cmpxchg instead of zswap_xa_search_and_delete in zswap_writeback_entry.
> - Use xa_store in zswap_xa_insert directly. Reduce the scope of spinlock.
> - Fix xa_store error handling for same page fill case.
> - Link to v2: https://lore.kernel.org/r/20240229-zswap-xarray-v2-1-e50284dfcdb1@kernel.org
> 
> Changes in v2:
> - Replace struct zswap_tree with struct xarray.
> - Remove zswap_tree spinlock, use xarray lock instead.
> - Fold zswap_rb_erase() into zswap_xa_search_and_delete() and zswap_xa_insert().
> - Delete zswap_invalidate_entry(), use zswap_free_entry() instead.
> - Link to v1: https://lore.kernel.org/r/20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org
> ---
>  mm/zswap.c | 186 ++++++++++++++++++++++++-------------------------------------
>  1 file changed, 72 insertions(+), 114 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 011e068eb355..4f4a3f452b76 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -20,7 +20,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  #include <linux/atomic.h>
> -#include <linux/rbtree.h>
>  #include <linux/swap.h>
>  #include <linux/crypto.h>
>  #include <linux/scatterlist.h>
> @@ -71,6 +70,8 @@ static u64 zswap_reject_compress_poor;
>  static u64 zswap_reject_alloc_fail;
>  /* Store failed because the entry metadata could not be allocated (rare) */
>  static u64 zswap_reject_kmemcache_fail;
> +/* Store failed because xarray can't insert the entry*/
> +static u64 zswap_reject_xarray_fail;
>  
>  /* Shrinker work queue */
>  static struct workqueue_struct *shrink_wq;
> @@ -196,7 +197,6 @@ static struct {
>   * This structure contains the metadata for tracking a single compressed
>   * page within zswap.
>   *
> - * rbnode - links the entry into red-black tree for the appropriate swap type
>   * swpentry - associated swap entry, the offset indexes into the red-black tree
>   * length - the length in bytes of the compressed page data.  Needed during
>   *          decompression. For a same value filled page length is 0, and both
> @@ -208,7 +208,6 @@ static struct {
>   * lru - handle to the pool's lru used to evict pages.
>   */
>  struct zswap_entry {
> -	struct rb_node rbnode;
>  	swp_entry_t swpentry;
>  	unsigned int length;
>  	struct zswap_pool *pool;
> @@ -220,12 +219,7 @@ struct zswap_entry {
>  	struct list_head lru;
>  };
>  
> -struct zswap_tree {
> -	struct rb_root rbroot;
> -	spinlock_t lock;
> -};
> -
> -static struct zswap_tree *zswap_trees[MAX_SWAPFILES];
> +static struct xarray *zswap_trees[MAX_SWAPFILES];
>  static unsigned int nr_zswap_trees[MAX_SWAPFILES];
>  
>  /* RCU-protected iteration */
> @@ -253,7 +247,7 @@ static bool zswap_has_pool;
>  * helpers and fwd declarations
>  **********************************/
>  
> -static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
> +static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
>  {
>  	return &zswap_trees[swp_type(swp)][swp_offset(swp)
>  		>> SWAP_ADDRESS_SPACE_SHIFT];
> @@ -805,60 +799,33 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
>  }
>  
>  /*********************************
> -* rbtree functions
> +* xarray functions
>  **********************************/
> -static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff_t offset)
> -{
> -	struct rb_node *node = root->rb_node;
> -	struct zswap_entry *entry;
> -	pgoff_t entry_offset;
> -
> -	while (node) {
> -		entry = rb_entry(node, struct zswap_entry, rbnode);
> -		entry_offset = swp_offset(entry->swpentry);
> -		if (entry_offset > offset)
> -			node = node->rb_left;
> -		else if (entry_offset < offset)
> -			node = node->rb_right;
> -		else
> -			return entry;
> -	}
> -	return NULL;
> -}
>  
>  /*
>   * In the case that a entry with the same offset is found, a pointer to
> - * the existing entry is stored in dupentry and the function returns -EEXIST
> + * the existing entry is stored in old and erased from the tree.
> + * Function return error on insert.
>   */
> -static int zswap_rb_insert(struct rb_root *root, struct zswap_entry *entry,
> -			struct zswap_entry **dupentry)
> +static int zswap_xa_insert(struct xarray *tree, struct zswap_entry *entry,
> +			   struct zswap_entry **old)
>  {
> -	struct rb_node **link = &root->rb_node, *parent = NULL;
> -	struct zswap_entry *myentry;
> -	pgoff_t myentry_offset, entry_offset = swp_offset(entry->swpentry);
> -
> -	while (*link) {
> -		parent = *link;
> -		myentry = rb_entry(parent, struct zswap_entry, rbnode);
> -		myentry_offset = swp_offset(myentry->swpentry);
> -		if (myentry_offset > entry_offset)
> -			link = &(*link)->rb_left;
> -		else if (myentry_offset < entry_offset)
> -			link = &(*link)->rb_right;
> -		else {
> -			*dupentry = myentry;
> -			return -EEXIST;
> -		}
> -	}
> -	rb_link_node(&entry->rbnode, parent, link);
> -	rb_insert_color(&entry->rbnode, root);
> -	return 0;
> -}
> +	int err;
> +	struct zswap_entry *e;
> +	pgoff_t offset = swp_offset(entry->swpentry);
>  
> -static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
> -{
> -	rb_erase(&entry->rbnode, root);
> -	RB_CLEAR_NODE(&entry->rbnode);
> +	e = xa_store(tree, offset, entry, GFP_KERNEL);
> +	err = xa_err(e);
> +
> +	if (err) {
> +		e = xa_erase(tree, offset);
> +		if (err == -ENOMEM)
> +			zswap_reject_alloc_fail++;
> +		else
> +			zswap_reject_xarray_fail++;

I think this is too complicated, and as Chengming pointed out, I believe
we can use xa_store() directly in zswap_store().

I am also not sure what the need for zswap_reject_xarray_fail is. Are
there any reasons why the store here can fail other than -ENOMEM? The
docs say the only other option is -EINVAL, and looking at __xa_store(),
it seems like this is only possible if xa_is_internal() is true (which
means we are not passing in a properly aligned pointer IIUC).

> +	}
> +	*old = e;
> +	return err;
>  }
>  
>  /*********************************
> @@ -872,7 +839,6 @@ static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
>  	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
>  	if (!entry)
>  		return NULL;
> -	RB_CLEAR_NODE(&entry->rbnode);
>  	return entry;
>  }
>  
> @@ -914,17 +880,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
>  	zswap_update_total_size();
>  }
>  
> -/*
> - * The caller hold the tree lock and search the entry from the tree,
> - * so it must be on the tree, remove it from the tree and free it.
> - */
> -static void zswap_invalidate_entry(struct zswap_tree *tree,
> -				   struct zswap_entry *entry)
> -{
> -	zswap_rb_erase(&tree->rbroot, entry);
> -	zswap_entry_free(entry);
> -}
> -
>  /*********************************
>  * compressed storage functions
>  **********************************/
> @@ -1113,7 +1068,9 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
>  static int zswap_writeback_entry(struct zswap_entry *entry,
>  				 swp_entry_t swpentry)
>  {
> -	struct zswap_tree *tree;
> +	struct xarray *tree;
> +	pgoff_t offset = swp_offset(swpentry);
> +	struct zswap_entry *e;
>  	struct folio *folio;
>  	struct mempolicy *mpol;
>  	bool folio_was_allocated;
> @@ -1150,19 +1107,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	 * be dereferenced.
>  	 */
>  	tree = swap_zswap_tree(swpentry);
> -	spin_lock(&tree->lock);
> -	if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) != entry) {
> -		spin_unlock(&tree->lock);
> +	e = xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL);
> +	if (e != entry) {

I think we can avoid adding 'e' and 'offset' local variables here and
just do everything in the if condition. If you want to avoid the line
break, then introducing 'offset' is fine, but I don't see any value from
'e'.


>  		delete_from_swap_cache(folio);
>  		folio_unlock(folio);
>  		folio_put(folio);
>  		return -ENOMEM;
>  	}
>  
> -	/* Safe to deref entry after the entry is verified above. */
> -	zswap_rb_erase(&tree->rbroot, entry);
> -	spin_unlock(&tree->lock);
> -
>  	zswap_decompress(entry, &folio->page);
>  
>  	count_vm_event(ZSWPWB);
> @@ -1471,10 +1423,12 @@ bool zswap_store(struct folio *folio)
>  {
>  	swp_entry_t swp = folio->swap;
>  	pgoff_t offset = swp_offset(swp);
> -	struct zswap_tree *tree = swap_zswap_tree(swp);
> -	struct zswap_entry *entry, *dupentry;
> +	struct xarray *tree = swap_zswap_tree(swp);
> +	struct zswap_entry *entry, *old;
>  	struct obj_cgroup *objcg = NULL;
>  	struct mem_cgroup *memcg = NULL;
> +	int err;
> +	bool old_erased = false;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1526,6 +1480,7 @@ bool zswap_store(struct folio *folio)
>  			kunmap_local(src);
>  			entry->length = 0;
>  			entry->value = value;
> +			entry->pool = NULL;

Why do we need to initialize the pool here? Is this is a bug fix for an
existing problem or just keeping things clean? Either way I think it
should be done separately, unless it is related to a change in this
patch.

>  			atomic_inc(&zswap_same_filled_pages);
>  			goto insert_entry;
>  		}
> @@ -1555,28 +1510,31 @@ bool zswap_store(struct folio *folio)
>  insert_entry:
>  	entry->swpentry = swp;
>  	entry->objcg = objcg;
> -	if (objcg) {
> -		obj_cgroup_charge_zswap(objcg, entry->length);
> -		/* Account before objcg ref is moved to tree */
> -		count_objcg_event(objcg, ZSWPOUT);
> -	}
>  
>  	/* map */

Let's remove this comment while we are here, it's pointless AFAICT.

> -	spin_lock(&tree->lock);
>  	/*
>  	 * The folio may have been dirtied again, invalidate the
>  	 * possibly stale entry before inserting the new entry.
>  	 */
> -	if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> -		zswap_invalidate_entry(tree, dupentry);
> -		WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
> +	err = zswap_xa_insert(tree, entry, &old);
> +	if (old)
> +		zswap_entry_free(old);
> +	if (err) {
> +		old_erased = true;

I think this can be made simpler if we open code xa_store() here,
especially that we already have cleanup code below under 'check_old'
that removes the exisitng old entry. So zswap_xa_insert() replicates
this cleanup, then we add this 'old_erased' boolean to avoid doing the
cleanup below. It seems like it would much more straightforward with
open-coding xa_store() here and relying on the existing cleanup for the
old entry.  Also, if we initialize 'old' to NULL, we can use its value
to figure out whether any cleanup is needed under 'check_old' or not.

Taking a step back, I think we can further simplify this. What if we
move the tree insertion to right after we allocate the zswap entry? In
this case, if the tree insertion fails, we don't need to decrement the
same filled counter. If the tree insertion succeeds and then something
else fails, the existing cleanup code under 'check_old' will already
clean up the tree insertion for us.

If this works, we don't need to add extra cleanup code or move any code
around. Something like:

	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
	if (!entry) {
		zswap_reject_kmemcache_fail++;
		goto reject;
	}

	old = xa_store(tree, offset, entry, GFP_KERNEL);
	if (xa_is_err(old)) {
		old = NULL;
		goto freepage;
	}
	if (old)
		zswap_free_entry(old);

	...
check_old:
	if (!old) {
		old = xa_erase(tree, offset);
		if (old)
			zswap_entry_free(old);
	}


WDYT?

> +		goto insert_failed;
>  	}
> +
> +	if (objcg) {
> +		obj_cgroup_charge_zswap(objcg, entry->length);
> +		/* Account before objcg ref is moved to tree */
> +		count_objcg_event(objcg, ZSWPOUT);
> +	}
> +
>  	if (entry->length) {
>  		INIT_LIST_HEAD(&entry->lru);
>  		zswap_lru_add(&zswap.list_lru, entry);
>  		atomic_inc(&zswap.nr_stored);
>  	}
> -	spin_unlock(&tree->lock);
>  
>  	/* update stats */
>  	atomic_inc(&zswap_stored_pages);
> @@ -1585,6 +1543,12 @@ bool zswap_store(struct folio *folio)
>  
>  	return true;
>  
> +insert_failed:
> +	if (!entry->length) {
> +		atomic_dec(&zswap_same_filled_pages);
> +		goto freepage;
> +	}
> +	zpool_free(zswap_find_zpool(entry), entry->handle);
>  put_pool:
>  	zswap_pool_put(entry->pool);
>  freepage:
> @@ -1592,17 +1556,19 @@ bool zswap_store(struct folio *folio)
>  reject:
>  	if (objcg)
>  		obj_cgroup_put(objcg);
> +
> +	if (old_erased)
> +		goto failed;
>  check_old:
>  	/*
>  	 * If the zswap store fails or zswap is disabled, we must invalidate the
>  	 * possibly stale entry which was previously stored at this offset.
>  	 * Otherwise, writeback could overwrite the new data in the swapfile.
>  	 */
> -	spin_lock(&tree->lock);
> -	entry = zswap_rb_search(&tree->rbroot, offset);
> +	entry = xa_erase(tree, offset);
>  	if (entry)
> -		zswap_invalidate_entry(tree, entry);
> -	spin_unlock(&tree->lock);
> +		zswap_entry_free(entry);
> +failed:
>  	return false;
>  
>  shrink:
[..]

