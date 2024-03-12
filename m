Return-Path: <linux-kernel+bounces-99831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D942878E06
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5C71C21517
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D04D26D;
	Tue, 12 Mar 2024 04:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B5n6mRNI"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5162EC154
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710219330; cv=none; b=JSQT3xTLso1MnMky3pYGGLzgAWj3gz/0+GrC1UfmWi88KCsD+roBXlkxIyQI022Wr2Vnp4vJiCXIVj49KDgNvlg639B1K7n4VUHAtA4zE0WCj1m/bsVwaljpslHKXfMNZnddVmJMmAhMruWW1cWFn4RA9bQkB9sBZaW9Q+3qgDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710219330; c=relaxed/simple;
	bh=7T9EDboEfa3cyXSLjv1LqU+XKMGW8NC8Gxmaxw6vvHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FH0JfT7+AqwjBqnAATLjSwWv1Nafax9y7+dXbXhT5GbCGodIotsvTTJai3a6eSVkWvJ4IVPVCFP7exa32Nqa9gMxhYmMLs2z4Ng5VzUcYXiox9T9jHWVOB60D1GooC3sHxMazEUACOV1ZFS4hg5Xz7ItQ47EG1vgAFl7ya8niAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B5n6mRNI; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <92170677-1195-4cbe-8302-85cbc198bf8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710219325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9p4UcOMDNuwZRMBAFm2BwtfV89LUzJZLz8qv3j0ea7I=;
	b=B5n6mRNIWt5qM7j7N/xdgqG/E48bUY1GqDlmWSbZJHCDIR/RI7VuVxUWSaPxVRWJKgvhHv
	1k3vN3q4UexRQ3QvUE9yK6/S5Gf8dreVt6RttyDw19FYqfGtSDPwxeOEzbgo3xNpnZu2Kn
	rxEl1axO6ICd4/aedtlLPQeYeEb9H4E=
Date: Tue, 12 Mar 2024 12:55:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm: zswap: optimize zswap pool size tracking
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240311161214.1145168-1-hannes@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240311161214.1145168-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/12 00:12, Johannes Weiner wrote:
> Profiling the munmap() of a zswapped memory region shows 50%(!) of the
> total cycles currently going into updating the zswap_pool_total_size.
> 
> There are three consumers of this counter:
> - store, to enforce the globally configured pool limit
> - meminfo & debugfs, to report the size to the user
> - shrink, to determine the batch size for each cycle
> 
> Instead of aggregating everytime an entry enters or exits the zswap
> pool, aggregate the value from the zpools on-demand:
> 
> - Stores aggregate the counter anyway upon success. Aggregating to
>   check the limit instead is the same amount of work.
> 
> - Meminfo & debugfs might benefit somewhat from a pre-aggregated
>   counter, but aren't exactly hotpaths.
> 
> - Shrinking can aggregate once for every cycle instead of doing it for
>   every freed entry. As the shrinker might work on tens or hundreds of
>   objects per scan cycle, this is a large reduction in aggregations.
> 
> The paths that benefit dramatically are swapin, swapoff, and
> unmaps. There could be millions of pages being processed until
> somebody asks for the pool size again. This eliminates the pool size
> updates from those paths entirely.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Great! This is a clever simplification and optimization.

With the incremental diff, feel free to add:

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>  fs/proc/meminfo.c     |  3 +-
>  include/linux/zswap.h |  2 +-
>  mm/zswap.c            | 98 +++++++++++++++++++++----------------------
>  3 files changed, 49 insertions(+), 54 deletions(-)
> 
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 45af9a989d40..245171d9164b 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -89,8 +89,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
>  	show_val_kb(m, "SwapFree:       ", i.freeswap);
>  #ifdef CONFIG_ZSWAP
> -	seq_printf(m,  "Zswap:          %8lu kB\n",
> -		   (unsigned long)(zswap_pool_total_size >> 10));
> +	show_val_kb(m, "Zswap:          ", zswap_total_pages());
>  	seq_printf(m,  "Zswapped:       %8lu kB\n",
>  		   (unsigned long)atomic_read(&zswap_stored_pages) <<
>  		   (PAGE_SHIFT - 10));
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 341aea490070..2a85b941db97 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -7,7 +7,6 @@
>  
>  struct lruvec;
>  
> -extern u64 zswap_pool_total_size;
>  extern atomic_t zswap_stored_pages;
>  
>  #ifdef CONFIG_ZSWAP
> @@ -27,6 +26,7 @@ struct zswap_lruvec_state {
>  	atomic_long_t nr_zswap_protected;
>  };
>  
> +unsigned long zswap_total_pages(void);
>  bool zswap_store(struct folio *folio);
>  bool zswap_load(struct folio *folio);
>  void zswap_invalidate(swp_entry_t swp);
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 9a3237752082..7c39327a7cc2 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -43,8 +43,6 @@
>  /*********************************
>  * statistics
>  **********************************/
> -/* Total bytes used by the compressed storage */
> -u64 zswap_pool_total_size;
>  /* The number of compressed pages currently stored in zswap */
>  atomic_t zswap_stored_pages = ATOMIC_INIT(0);
>  /* The number of same-value filled pages currently stored in zswap */
> @@ -264,45 +262,6 @@ static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
>  	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
>  		 zpool_get_type((p)->zpools[0]))
>  
> -static bool zswap_is_full(void)
> -{
> -	return totalram_pages() * zswap_max_pool_percent / 100 <
> -			DIV_ROUND_UP(zswap_pool_total_size, PAGE_SIZE);
> -}
> -
> -static bool zswap_can_accept(void)
> -{
> -	return totalram_pages() * zswap_accept_thr_percent / 100 *
> -				zswap_max_pool_percent / 100 >
> -			DIV_ROUND_UP(zswap_pool_total_size, PAGE_SIZE);
> -}
> -
> -static u64 get_zswap_pool_size(struct zswap_pool *pool)
> -{
> -	u64 pool_size = 0;
> -	int i;
> -
> -	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
> -		pool_size += zpool_get_total_size(pool->zpools[i]);
> -
> -	return pool_size;
> -}
> -
> -static void zswap_update_total_size(void)
> -{
> -	struct zswap_pool *pool;
> -	u64 total = 0;
> -
> -	rcu_read_lock();
> -
> -	list_for_each_entry_rcu(pool, &zswap_pools, list)
> -		total += get_zswap_pool_size(pool);
> -
> -	rcu_read_unlock();
> -
> -	zswap_pool_total_size = total;
> -}
> -
>  /*********************************
>  * pool functions
>  **********************************/
> @@ -540,6 +499,28 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
>  	return NULL;
>  }
>  
> +static unsigned long zswap_max_pages(void)
> +{
> +	return totalram_pages() * zswap_max_pool_percent / 100;
> +}
> +
> +unsigned long zswap_total_pages(void)
> +{
> +	struct zswap_pool *pool;
> +	u64 total = 0;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(pool, &zswap_pools, list) {
> +		int i;
> +
> +		for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
> +			total += zpool_get_total_size(pool->zpools[i]);
> +	}
> +	rcu_read_unlock();
> +
> +	return total >> PAGE_SHIFT;
> +}
> +
>  /*********************************
>  * param callbacks
>  **********************************/
> @@ -912,7 +893,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
>  	}
>  	zswap_entry_cache_free(entry);
>  	atomic_dec(&zswap_stored_pages);
> -	zswap_update_total_size();
>  }
>  
>  /*
> @@ -1317,7 +1297,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
>  	nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
>  #else
>  	/* use pool stats instead of memcg stats */
> -	nr_backing = zswap_pool_total_size >> PAGE_SHIFT;
> +	nr_backing = zswap_total_pages();
>  	nr_stored = atomic_read(&zswap_nr_stored);
>  #endif
>  
> @@ -1385,6 +1365,10 @@ static void shrink_worker(struct work_struct *w)
>  {
>  	struct mem_cgroup *memcg;
>  	int ret, failures = 0;
> +	unsigned long thr;
> +
> +	/* Reclaim down to the accept threshold */
> +	thr = zswap_max_pages() * zswap_accept_thr_percent / 100;
>  
>  	/* global reclaim will select cgroup in a round-robin fashion. */
>  	do {
> @@ -1432,10 +1416,9 @@ static void shrink_worker(struct work_struct *w)
>  			break;
>  		if (ret && ++failures == MAX_RECLAIM_RETRIES)
>  			break;
> -
>  resched:
>  		cond_resched();
> -	} while (!zswap_can_accept());
> +	} while (zswap_total_pages() > thr);
>  }
>  
>  static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
> @@ -1476,6 +1459,7 @@ bool zswap_store(struct folio *folio)
>  	struct zswap_entry *entry, *dupentry;
>  	struct obj_cgroup *objcg = NULL;
>  	struct mem_cgroup *memcg = NULL;
> +	unsigned long max_pages, cur_pages;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1487,6 +1471,7 @@ bool zswap_store(struct folio *folio)
>  	if (!zswap_enabled)
>  		goto check_old;
>  
> +	/* Check cgroup limits */
>  	objcg = get_obj_cgroup_from_folio(folio);
>  	if (objcg && !obj_cgroup_may_zswap(objcg)) {
>  		memcg = get_mem_cgroup_from_objcg(objcg);
> @@ -1497,15 +1482,20 @@ bool zswap_store(struct folio *folio)
>  		mem_cgroup_put(memcg);
>  	}
>  
> -	/* reclaim space if needed */
> -	if (zswap_is_full()) {
> +	/* Check global limits */
> +	cur_pages = zswap_total_pages();
> +	max_pages = zswap_max_pages();
> +
> +	if (cur_pages >= max_pages) {
>  		zswap_pool_limit_hit++;
>  		zswap_pool_reached_full = true;
>  		goto shrink;
>  	}
>  
>  	if (zswap_pool_reached_full) {
> -	       if (!zswap_can_accept())
> +		unsigned long thr = max_pages * zswap_accept_thr_percent / 100;
> +
> +		if (cur_pages > thr)
>  			goto shrink;
>  		else
>  			zswap_pool_reached_full = false;
> @@ -1581,7 +1571,6 @@ bool zswap_store(struct folio *folio)
>  
>  	/* update stats */
>  	atomic_inc(&zswap_stored_pages);
> -	zswap_update_total_size();
>  	count_vm_event(ZSWPOUT);
>  
>  	return true;
> @@ -1711,6 +1700,13 @@ void zswap_swapoff(int type)
>  
>  static struct dentry *zswap_debugfs_root;
>  
> +static int debugfs_get_total_size(void *data, u64 *val)
> +{
> +	*val = zswap_total_pages() * PAGE_SIZE;
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(total_size_fops, debugfs_get_total_size, NULL, "%llu");
> +
>  static int zswap_debugfs_init(void)
>  {
>  	if (!debugfs_initialized())
> @@ -1732,8 +1728,8 @@ static int zswap_debugfs_init(void)
>  			   zswap_debugfs_root, &zswap_reject_compress_poor);
>  	debugfs_create_u64("written_back_pages", 0444,
>  			   zswap_debugfs_root, &zswap_written_back_pages);
> -	debugfs_create_u64("pool_total_size", 0444,
> -			   zswap_debugfs_root, &zswap_pool_total_size);
> +	debugfs_create_file("pool_total_size", 0444,
> +			    zswap_debugfs_root, NULL, &total_size_fops);
>  	debugfs_create_atomic_t("stored_pages", 0444,
>  				zswap_debugfs_root, &zswap_stored_pages);
>  	debugfs_create_atomic_t("same_filled_pages", 0444,

