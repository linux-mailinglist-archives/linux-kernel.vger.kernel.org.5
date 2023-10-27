Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A4E7D9821
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345689AbjJ0MaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0MaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:30:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CE861A1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:30:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 079071424;
        Fri, 27 Oct 2023 05:30:41 -0700 (PDT)
Received: from [10.57.70.251] (unknown [10.57.70.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0878D3F738;
        Fri, 27 Oct 2023 05:29:56 -0700 (PDT)
Message-ID: <2cf73366-b3bb-4737-a698-b52edd6086bd@arm.com>
Date:   Fri, 27 Oct 2023 13:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] mm: zswap: Store large folios without splitting
Content-Language: en-GB
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20231019110543.3284654-1-ryan.roberts@arm.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231019110543.3284654-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a polite nudge on this if anyone has any feedback?

Alternatively, happy to repost against -rc1 if that's preferred?


On 19/10/2023 12:05, Ryan Roberts wrote:
> Previously zswap would refuse to store any folio bigger than order-0,
> and therefore all of those folios would be sent directly to the swap
> file. This is a minor inconvenience since swap can currently only
> support order-0 and PMD-sized THP, but with the pending introduction of
> "small-sized THP", and corresponding changes to swapfile to support any
> order of folio, these large folios will become more prevalent and
> without this zswap change, zswap will become unusable. Independently of
> the "small-sized THP" feature, this change makes it possible to store
> existing PMD-sized THPs in zswap.
> 
> Modify zswap_store() to allow storing large folios. The function is
> split into 2 parts; zswap_store() does all the per-folio operations
> (i.e. checking there is enough space, etc). Then it calls a new helper,
> zswap_store_page(), for each page in the folio, which are stored as
> their own entries in the zswap pool. (These entries continue to be
> loaded back individually as single pages). If a store fails for any
> single page, then all previously successfully stored folio pages are
> invalidated.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> I've tested this on arm64 (m2) with zswap enabled, and running
> vm-scalability's `usemem` across multiple cores from within a
> memory-constrained memcg to force high volumes of swap. I've also run mm
> selftests and observe no regressions (although there is nothing [z]swap
> specific there) - does zswap have any specific tests I should run?
> 
> This is based on mm-stable, since mm-unstable contains a zswap patch
> known to be buggy [1]. I thought it would be best to get comments on the
> shape, then do the rebase after that patch has been fixed.
> 
> For context, small-sized THP is being discussed here [2], and I'm
> working on changes to swapfile to support non-PMD-sized large folios
> here [3].
> 
> [1] https://lore.kernel.org/linux-mm/21606fe5-fb9b-4d37-98ab-38c96819893b@arm.com/
> [2] https://lore.kernel.org/linux-mm/20230929114421.3761121-1-ryan.roberts@arm.com/
> [3] https://lore.kernel.org/linux-mm/20231017161302.2518826-1-ryan.roberts@arm.com/
> 
> Thanks,
> Ryan
> 
> 
>  mm/zswap.c | 155 +++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 98 insertions(+), 57 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 37d2b1cb2ecb..51cbfc4e1ef8 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1188,18 +1188,17 @@ static void zswap_fill_page(void *ptr, unsigned long value)
>  	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
>  }
> 
> -bool zswap_store(struct folio *folio)
> +static bool zswap_store_page(struct folio *folio, long index,
> +			     struct obj_cgroup *objcg, struct zswap_pool *pool)
>  {
>  	swp_entry_t swp = folio->swap;
>  	int type = swp_type(swp);
> -	pgoff_t offset = swp_offset(swp);
> -	struct page *page = &folio->page;
> +	pgoff_t offset = swp_offset(swp) + index;
> +	struct page *page = folio_page(folio, index);
>  	struct zswap_tree *tree = zswap_trees[type];
>  	struct zswap_entry *entry, *dupentry;
>  	struct scatterlist input, output;
>  	struct crypto_acomp_ctx *acomp_ctx;
> -	struct obj_cgroup *objcg = NULL;
> -	struct zswap_pool *pool;
>  	struct zpool *zpool;
>  	unsigned int dlen = PAGE_SIZE;
>  	unsigned long handle, value;
> @@ -1208,51 +1207,11 @@ bool zswap_store(struct folio *folio)
>  	gfp_t gfp;
>  	int ret;
> 
> -	VM_WARN_ON_ONCE(!folio_test_locked(folio));
> -	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> -
> -	/* Large folios aren't supported */
> -	if (folio_test_large(folio))
> -		return false;
> -
> -	if (!zswap_enabled || !tree)
> +	/* entry keeps the references if successfully stored. */
> +	if (!zswap_pool_get(pool))
>  		return false;
> -
> -	/*
> -	 * If this is a duplicate, it must be removed before attempting to store
> -	 * it, otherwise, if the store fails the old page won't be removed from
> -	 * the tree, and it might be written back overriding the new data.
> -	 */
> -	spin_lock(&tree->lock);
> -	dupentry = zswap_rb_search(&tree->rbroot, offset);
> -	if (dupentry) {
> -		zswap_duplicate_entry++;
> -		zswap_invalidate_entry(tree, dupentry);
> -	}
> -	spin_unlock(&tree->lock);
> -
> -	/*
> -	 * XXX: zswap reclaim does not work with cgroups yet. Without a
> -	 * cgroup-aware entry LRU, we will push out entries system-wide based on
> -	 * local cgroup limits.
> -	 */
> -	objcg = get_obj_cgroup_from_folio(folio);
> -	if (objcg && !obj_cgroup_may_zswap(objcg))
> -		goto reject;
> -
> -	/* reclaim space if needed */
> -	if (zswap_is_full()) {
> -		zswap_pool_limit_hit++;
> -		zswap_pool_reached_full = true;
> -		goto shrink;
> -	}
> -
> -	if (zswap_pool_reached_full) {
> -	       if (!zswap_can_accept())
> -			goto shrink;
> -		else
> -			zswap_pool_reached_full = false;
> -	}
> +	if (objcg)
> +		obj_cgroup_get(objcg);
> 
>  	/* allocate entry */
>  	entry = zswap_entry_cache_alloc(GFP_KERNEL);
> @@ -1260,6 +1219,8 @@ bool zswap_store(struct folio *folio)
>  		zswap_reject_kmemcache_fail++;
>  		goto reject;
>  	}
> +	entry->objcg = objcg;
> +	entry->pool = pool;
> 
>  	if (zswap_same_filled_pages_enabled) {
>  		src = kmap_atomic(page);
> @@ -1277,11 +1238,6 @@ bool zswap_store(struct folio *folio)
>  	if (!zswap_non_same_filled_pages_enabled)
>  		goto freepage;
> 
> -	/* if entry is successfully added, it keeps the reference */
> -	entry->pool = zswap_pool_current_get();
> -	if (!entry->pool)
> -		goto freepage;
> -
>  	/* compress */
>  	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
> 
> @@ -1337,7 +1293,6 @@ bool zswap_store(struct folio *folio)
>  	entry->length = dlen;
> 
>  insert_entry:
> -	entry->objcg = objcg;
>  	if (objcg) {
>  		obj_cgroup_charge_zswap(objcg, entry->length);
>  		/* Account before objcg ref is moved to tree */
> @@ -1373,19 +1328,105 @@ bool zswap_store(struct folio *folio)
> 
>  put_dstmem:
>  	mutex_unlock(acomp_ctx->mutex);
> -	zswap_pool_put(entry->pool);
>  freepage:
>  	zswap_entry_cache_free(entry);
>  reject:
>  	if (objcg)
>  		obj_cgroup_put(objcg);
> +	zswap_pool_put(pool);
>  	return false;
> +}
> 
> +bool zswap_store(struct folio *folio)
> +{
> +	long nr_pages = folio_nr_pages(folio);
> +	swp_entry_t swp = folio->swap;
> +	int type = swp_type(swp);
> +	pgoff_t offset = swp_offset(swp);
> +	struct zswap_tree *tree = zswap_trees[type];
> +	struct zswap_entry *entry;
> +	struct obj_cgroup *objcg = NULL;
> +	struct zswap_pool *pool;
> +	bool ret = false;
> +	long i;
> +
> +	VM_WARN_ON_ONCE(!folio_test_locked(folio));
> +	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> +
> +	if (!zswap_enabled || !tree)
> +		return false;
> +
> +	/*
> +	 * If this is a duplicate, it must be removed before attempting to store
> +	 * it, otherwise, if the store fails the old page won't be removed from
> +	 * the tree, and it might be written back overriding the new data.
> +	 */
> +	spin_lock(&tree->lock);
> +	for (i = 0; i < nr_pages; i++) {
> +		entry = zswap_rb_search(&tree->rbroot, offset + i);
> +		if (entry) {
> +			zswap_duplicate_entry++;
> +			zswap_invalidate_entry(tree, entry);
> +		}
> +	}
> +	spin_unlock(&tree->lock);
> +
> +	/*
> +	 * XXX: zswap reclaim does not work with cgroups yet. Without a
> +	 * cgroup-aware entry LRU, we will push out entries system-wide based on
> +	 * local cgroup limits.
> +	 */
> +	objcg = get_obj_cgroup_from_folio(folio);
> +	if (objcg && !obj_cgroup_may_zswap(objcg))
> +		goto put_objcg;
> +
> +	/* reclaim space if needed */
> +	if (zswap_is_full()) {
> +		zswap_pool_limit_hit++;
> +		zswap_pool_reached_full = true;
> +		goto shrink;
> +	}
> +
> +	if (zswap_pool_reached_full) {
> +		if (!zswap_can_accept())
> +			goto shrink;
> +		else
> +			zswap_pool_reached_full = false;
> +	}
> +
> +	pool = zswap_pool_current_get();
> +	if (!pool)
> +		goto put_objcg;
> +
> +	/*
> +	 * Store each page of the folio as a separate entry. If we fail to store
> +	 * a page, unwind by removing all the previous pages we stored.
> +	 */
> +	for (i = 0; i < nr_pages; i++) {
> +		if (!zswap_store_page(folio, i, objcg, pool)) {
> +			spin_lock(&tree->lock);
> +			for (i--; i >= 0; i--) {
> +				entry = zswap_rb_search(&tree->rbroot, offset + i);
> +				if (entry)
> +					zswap_invalidate_entry(tree, entry);
> +			}
> +			spin_unlock(&tree->lock);
> +			goto put_pool;
> +		}
> +	}
> +
> +	ret = true;
> +put_pool:
> +	zswap_pool_put(pool);
> +put_objcg:
> +	if (objcg)
> +		obj_cgroup_put(objcg);
> +	return ret;
>  shrink:
>  	pool = zswap_pool_last_get();
>  	if (pool && !queue_work(shrink_wq, &pool->shrink_work))
>  		zswap_pool_put(pool);
> -	goto reject;
> +	goto put_objcg;
>  }
> 
>  bool zswap_load(struct folio *folio)
> 
> base-commit: 158978945f3173b8c1a88f8c5684a629736a57ac
> --
> 2.25.1
> 

