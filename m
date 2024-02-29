Return-Path: <linux-kernel+bounces-86467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24AA86C5E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A9D1C23D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276B362154;
	Thu, 29 Feb 2024 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LLnLp7wx"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC486168D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199893; cv=none; b=O86aIH7vXqIoOGgOyXJULqZhtYFmzkAs7YAJHV0PrHEXbFiGVhv4DWJQYkM0UErjhohgZlVpvdrsM2JN0ELkUjDShvdOn0ipEmM2WQN1t+Yd1rU8IrQKWpVqRUaO32hXHncmiKCSRbyFdptdBpAR7tfSW+lwwOcO4QcxN6tyTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199893; c=relaxed/simple;
	bh=B0s/+vZ5tPLSPvJZFDxl46YRLpC9f6hd0hW+XhqXihY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHmxh5HZ81ZUye8sTOgUTKvmiUfEas2AQAG+s5QSPhh+rerJFhgiZQMWFV1dD2etUh9eAbdH0jWjzFXXfmfV1aHGtdTHYmwhhIhKhrFOukNfT0wd57Z7/oooSSZBdQrgbz4HfN9OcgbtuJT2Cv28+rk70+D/cuWhrLIHnAlEM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LLnLp7wx; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso549565a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709199890; x=1709804690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2lgerrRDuurOntxm1Wz2/qKEXHXbDoC8TaXBKHl7Y4=;
        b=LLnLp7wxSc4ovsPH9vOulBLUQ0/KS4+y+tCd+ED82H1SsMkdlQT3rtDxNNtk7xathU
         HJhi8ZTxLwsAW8KIolq1FhMNOeOuAYgMQdkVI4+071Fu8WPk1fkOJ62XtHSGpzqWRq30
         9+v33G8ms/d0IIFsh2I8wP7YoKl+olDhW6eOG9WfBTSpZu0r69D+RS8hr10O/bmycgI5
         DUJcu0m4EHmu7SohMaETg3cKP/Tf7/2x12q/m4wVGvcj3b2QvldviSL11lb2bl4ZpRWw
         oGzqANuDdOLA30SyGln1L2PMhtWClUhlLr1+ceGfpelbYboYxd/iJqvRgenBNASY9hAn
         0r1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199890; x=1709804690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2lgerrRDuurOntxm1Wz2/qKEXHXbDoC8TaXBKHl7Y4=;
        b=MTjEOY1I29xGFDQdXa9M/Smvyy4SrFZz9HfT28nw4wXzZopOst+H7IDiFzgZHV8iZ5
         AZnHvk9OtbJY+vGkEcTtqgMBSKN02EiiyK9MalFDct9JVAu2Oj1442UKb/fWWzCyyPqt
         LG6AfORjU/CPbYhsCmRUEGQBUW7MtNLxV9yzO7M10TDTR9Avgrx5vwJi4/sg83PlTy6j
         PMtbeHg4R40yyz+AHpN/JPnA8p4mLpzssoWQ6q3c3Ybo0saWjaFI/YqAbq2wtznP45+t
         LEDClTVvS8wFW3sJDdfhaCIzDHPFcZGAYyDn8E9ibG1qHLeega6gCek78q73PG4CTLOQ
         xmdA==
X-Gm-Message-State: AOJu0YxkWLXHRn+WlYI3CPssYXEeOxSdnTZfYGUou3LSs+10jaRvnVrs
	9fb//CE8er2b91ipVMmP9OiJOrJR0LPFaQWGQkjrtKpcV/N0MEYGk/KIjKCh+c4=
X-Google-Smtp-Source: AGHT+IEwKo/jfXv8I/E4n9oBnHTsHHAErBceB8QnBJg0xkIIkFx9tgClF5Wjf0oWz2Tt150ulzHewQ==
X-Received: by 2002:a17:90a:e385:b0:299:48ec:1e83 with SMTP id b5-20020a17090ae38500b0029948ec1e83mr1655456pjz.49.1709199890403;
        Thu, 29 Feb 2024 01:44:50 -0800 (PST)
Received: from [10.254.19.63] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id w8-20020a17090ad60800b00296a23e407csm3187711pju.7.2024.02.29.01.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 01:44:50 -0800 (PST)
Message-ID: <66a86e12-e567-4705-b683-0485276007d2@bytedance.com>
Date: Thu, 29 Feb 2024 17:44:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zswap: replace RB tree with xarray
Content-Language: en-US
To: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Barry Song <v-songbaohua@oppo.com>
References: <20240229-zswap-xarray-v2-1-e50284dfcdb1@kernel.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240229-zswap-xarray-v2-1-e50284dfcdb1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Chris,

On 2024/2/29 16:46, Chris Li wrote:
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
> followed by zswap_rb_erase. Fold the entry erase into
> zswap_xa_search_and_erase and zswap_xa_insert. That saves
> one tree lookup as well.
> 
> Remove zswap_invalidate_entry due to no need to call
> zswap_rb_erase any more. Use zswap_free_entry instead.
> 
> The "struct zswap_tree" has been replaced by "struct xarray".
> The tree spin lock has transferred to the xarray lock.
> 
> Thanks to Chengming for providing the kernel build test number.
> 
> Run the kernel build testing 5 times for each version, averages:
> (memory.max=2GB, zswap shrinker and writeback enabled, one 50GB swapfile.)
> 
>                               mm-266f922c0b5e       zswap-xarray-test            
> real                          63.43                 63.12                        
> user                          1063.78               1062.59                      
> sys                           272.49                265.66
> 
> The sys time is about 2.5% faster.
> 
> Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> 
> 
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
> Changes in v2:
> - Replace struct zswap_tree with struct xarray.
> - Remove zswap_tree spinlock, use xarray lock instead.
> - Fold zswap_rb_erase() into zswap_xa_search_and_delete() and zswap_xa_insert().
> - Delete zswap_invalidate_entry(), use zswap_free_entry() instead.
> - Link to v1: https://lore.kernel.org/r/20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org
> ---
>  mm/zswap.c | 173 +++++++++++++++++++++++--------------------------------------
>  1 file changed, 64 insertions(+), 109 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 011e068eb355..ac9ef14d88be 100644
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
> @@ -253,10 +247,10 @@ static bool zswap_has_pool;
>  * helpers and fwd declarations
>  **********************************/
>  
> -static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
> +static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
>  {
> -	return &zswap_trees[swp_type(swp)][swp_offset(swp)
> -		>> SWAP_ADDRESS_SPACE_SHIFT];
> +	return zswap_trees[swp_type(swp)] + (swp_offset(swp)
> +		>> SWAP_ADDRESS_SPACE_SHIFT);
>  }
>  
>  #define zswap_pool_debug(msg, p)				\
> @@ -805,60 +799,38 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
>  }
>  
>  /*********************************
> -* rbtree functions
> +* xarray functions
>  **********************************/
> -static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff_t offset)
> +static struct zswap_entry *zswap_xa_search_and_erase(struct xarray *tree, pgoff_t offset)
>  {
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
> +	return xa_erase(tree, offset);
>  }
>  
>  /*
> + * Expects xa_lock to be held on entry.
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
> +	e = __xa_store(tree, offset, entry, GFP_KERNEL);
> +	err = xa_err(e);
> +
> +	if (err) {
> +		e = __xa_erase(tree, offset);
> +		if (err == -ENOMEM)
> +			zswap_reject_alloc_fail++;
> +		else
> +			zswap_reject_xarray_fail++;
> +	}
> +	*old = e;
> +	return err;
>  }
>  
>  /*********************************
> @@ -872,7 +844,6 @@ static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
>  	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
>  	if (!entry)
>  		return NULL;
> -	RB_CLEAR_NODE(&entry->rbnode);
>  	return entry;
>  }
>  
> @@ -914,17 +885,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
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
> @@ -1113,7 +1073,9 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
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
> @@ -1150,19 +1112,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	 * be dereferenced.
>  	 */
>  	tree = swap_zswap_tree(swpentry);
> -	spin_lock(&tree->lock);
> -	if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) != entry) {
> -		spin_unlock(&tree->lock);
> +	e = zswap_xa_search_and_erase(tree, offset);
> +	if (e != entry) {

IIUC, here we should use xa_cmpxchg() instead of erasing it unconditionally.

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
> @@ -1471,10 +1428,11 @@ bool zswap_store(struct folio *folio)
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
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1562,21 +1520,25 @@ bool zswap_store(struct folio *folio)
>  	}
>  
>  	/* map */
> -	spin_lock(&tree->lock);
> +	xa_lock(tree);
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

Maybe it's safer to check old after !err, since "old" variable is not initialized
to NULL, and zswap_xa_insert() maybe won't overwrite "old" to NULL when err return?

> +	if (err) {
> +		xa_unlock(tree);
> +		goto free_zpool;
>  	}
> +
>  	if (entry->length) {
>  		INIT_LIST_HEAD(&entry->lru);
>  		zswap_lru_add(&zswap.list_lru, entry);
>  		atomic_inc(&zswap.nr_stored);
>  	}

It seems that we can put this part out of xarray lock section, then it's enough to
just use xa_insert().

Thanks.

