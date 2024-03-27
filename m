Return-Path: <linux-kernel+bounces-120749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A8A88DC7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556F11F24D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DED671B31;
	Wed, 27 Mar 2024 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u2KTNfo/"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177216EB50
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538730; cv=none; b=hGMJeAj0N1R7CNmBMds9hxDQzB5cgBl+5OpixpM7HNln1dXNUbagDtfpCu6Thy8yCx+mAZGE17LGlm2GUaDwbZ8ZFGzpbLgHj7qHzsle71koz3VbmJ2ciuH9wP/VNqHSyi/ZKel9huJtGF3GnyKE1UHFJGF3uaT9V86x3q0Qffw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538730; c=relaxed/simple;
	bh=R1s9D5+casQWyLdftLRPNv9zmghzeJwU+ZBy9CHn+DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wj+kLLlSpNOgQbxuuGZqXCVHMxEkBk+tJdtaxC21SB8nZHtv02KY5jMSw3slhEv47qiJ+6P7jk1yQMVJ/r9EeGcEn3ZvVzcz504nr27sAiwd20Bv9+B9lxM02Dl5aYsaBbgllTDaYUzUpHk7L0gxBwLvz3p5ykWfrFIZxjDURGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u2KTNfo/; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <69c6d3f2-d201-43f2-b8c0-3599fb20ac61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711538724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGhimz4I+pVhVYQfazvBz3KUFgUI5ZIiXgdUoL/VTWc=;
	b=u2KTNfo/yr5o6IFag1zRJkv6o8rDcKwPhMtE8VcPSpRKwsZof04hSXsIjPCaqyzGOE2RFM
	IOc0cvni6T86ZxzL6iQWfXdtu22ageBk80iiZp7MYV0erSmf2W7B0NM/y8IrkYNIwE4khR
	W3dEFT5XBfctkKI5QPMlDEbIsRFSof8=
Date: Wed, 27 Mar 2024 19:25:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-7-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240325235018.2028408-7-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/26 07:50, Yosry Ahmed wrote:
> The current same-filled pages handling supports pages filled with any
> repeated word-sized pattern. However, in practice, most of these should
> be zero pages anyway. Other patterns should be nearly as common.
> 
> Drop the support for non-zero same-filled pages, but keep the names of
> knobs exposed to userspace as "same_filled", which isn't entirely
> inaccurate.
> 
> This yields some nice code simplification and enables a following patch
> that eliminates the need to allocate struct zswap_entry for those pages
> completely.
> 
> There is also a very small performance improvement observed over 50 runs
> of kernel build test (kernbench) comparing the mean build time on a
> skylake machine when building the kernel in a cgroup v1 container with a
> 3G limit:
> 
> 		base		patched		% diff
> real		70.167		69.915		-0.359%
> user		2953.068	2956.147	+0.104%
> sys		2612.811	2594.718	-0.692%
> 
> This probably comes from more optimized operations like memchr_inv() and
> clear_highpage(). Note that the percentage of zero-filled pages during
> this test was only around 1.5% on average, and was not affected by this
> patch. Practical workloads could have a larger proportion of such pages
> (e.g. Johannes observed around 10% [1]), so the performance improvement
> should be larger.
> 
> [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg.org/
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

The code looks good!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>  mm/zswap.c | 76 ++++++++++++++----------------------------------------
>  1 file changed, 20 insertions(+), 56 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0fc27ae950c74..413d9242cf500 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -44,8 +44,8 @@
>  **********************************/
>  /* The number of compressed pages currently stored in zswap */
>  atomic_t zswap_stored_pages = ATOMIC_INIT(0);
> -/* The number of same-value filled pages currently stored in zswap */
> -static atomic_t zswap_same_filled_pages = ATOMIC_INIT(0);
> +/* The number of zero-filled pages currently stored in zswap */
> +static atomic_t zswap_zero_filled_pages = ATOMIC_INIT(0);
>  
>  /*
>   * The statistics below are not protected from concurrent access for
> @@ -123,9 +123,9 @@ static unsigned int zswap_accept_thr_percent = 90; /* of max pool size */
>  module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
>  		   uint, 0644);
>  
> -/* Enable/disable handling non-same-value filled pages (enabled by default) */
> -static bool zswap_non_same_filled_pages_enabled = true;
> -module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_pages_enabled,
> +/* Enable/disable handling non-zero-filled pages (enabled by default) */
> +static bool zswap_non_zero_filled_pages_enabled = true;
> +module_param_named(non_same_filled_pages_enabled, zswap_non_zero_filled_pages_enabled,
>  		   bool, 0644);
>  
>  /* Number of zpools in zswap_pool (empirically determined for scalability) */
> @@ -187,11 +187,10 @@ static struct shrinker *zswap_shrinker;
>   *
>   * swpentry - associated swap entry, the offset indexes into the red-black tree
>   * length - the length in bytes of the compressed page data.  Needed during
> - *          decompression. For a same value filled page length is 0, and both
> + *          decompression. For a zero-filled page length is 0, and both
>   *          pool and lru are invalid and must be ignored.
>   * pool - the zswap_pool the entry's data is in
>   * handle - zpool allocation handle that stores the compressed page data
> - * value - value of the same-value filled pages which have same content
>   * objcg - the obj_cgroup that the compressed memory is charged to
>   * lru - handle to the pool's lru used to evict pages.
>   */
> @@ -199,10 +198,7 @@ struct zswap_entry {
>  	swp_entry_t swpentry;
>  	unsigned int length;
>  	struct zswap_pool *pool;
> -	union {
> -		unsigned long handle;
> -		unsigned long value;
> -	};
> +	unsigned long handle;
>  	struct obj_cgroup *objcg;
>  	struct list_head lru;
>  };
> @@ -805,7 +801,7 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
>  static void zswap_entry_free(struct zswap_entry *entry)
>  {
>  	if (!entry->length)
> -		atomic_dec(&zswap_same_filled_pages);
> +		atomic_dec(&zswap_zero_filled_pages);
>  	else {
>  		zswap_lru_del(&zswap_list_lru, entry);
>  		zpool_free(zswap_find_zpool(entry), entry->handle);
> @@ -1377,43 +1373,17 @@ static void shrink_worker(struct work_struct *w)
>  	} while (zswap_total_pages() > thr);
>  }
>  
> -static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value)
> +static bool zswap_is_folio_zero_filled(struct folio *folio)
>  {
> -	unsigned long *page;
> -	unsigned long val;
> -	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
> +	unsigned long *kaddr;
>  	bool ret;
>  
> -	page = kmap_local_folio(folio, 0);
> -	val = page[0];
> -
> -	if (val != page[last_pos]) {
> -		ret = false;
> -		goto out;
> -	}
> -
> -	for (pos = 1; pos < last_pos; pos++) {
> -		if (val != page[pos]) {
> -			ret = false;
> -			goto out;
> -		}
> -	}
> -
> -	*value = val;
> -	ret = true;
> -out:
> -	kunmap_local(page);
> +	kaddr = kmap_local_folio(folio, 0);
> +	ret = !memchr_inv(kaddr, 0, PAGE_SIZE);
> +	kunmap_local(kaddr);
>  	return ret;
>  }
>  
> -static void zswap_fill_page(void *ptr, unsigned long value)
> -{
> -	unsigned long *page;
> -
> -	page = (unsigned long *)ptr;
> -	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
> -}
> -
>  static bool zswap_check_limit(void)
>  {
>  	unsigned long cur_pages = zswap_total_pages();
> @@ -1437,7 +1407,6 @@ bool zswap_store(struct folio *folio)
>  	struct obj_cgroup *objcg = NULL;
>  	struct mem_cgroup *memcg = NULL;
>  	struct zswap_entry *entry;
> -	unsigned long value;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1470,14 +1439,13 @@ bool zswap_store(struct folio *folio)
>  		goto reject;
>  	}
>  
> -	if (zswap_is_folio_same_filled(folio, &value)) {
> +	if (zswap_is_folio_zero_filled(folio)) {
>  		entry->length = 0;
> -		entry->value = value;
> -		atomic_inc(&zswap_same_filled_pages);
> +		atomic_inc(&zswap_zero_filled_pages);
>  		goto insert_entry;
>  	}
>  
> -	if (!zswap_non_same_filled_pages_enabled)
> +	if (!zswap_non_zero_filled_pages_enabled)
>  		goto freepage;
>  
>  	/* if entry is successfully added, it keeps the reference */
> @@ -1532,7 +1500,7 @@ bool zswap_store(struct folio *folio)
>  
>  store_failed:
>  	if (!entry->length)
> -		atomic_dec(&zswap_same_filled_pages);
> +		atomic_dec(&zswap_zero_filled_pages);
>  	else {
>  		zpool_free(zswap_find_zpool(entry), entry->handle);
>  put_pool:
> @@ -1563,7 +1531,6 @@ bool zswap_load(struct folio *folio)
>  	struct page *page = &folio->page;
>  	struct xarray *tree = swap_zswap_tree(swp);
>  	struct zswap_entry *entry;
> -	u8 *dst;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  
> @@ -1573,11 +1540,8 @@ bool zswap_load(struct folio *folio)
>  
>  	if (entry->length)
>  		zswap_decompress(entry, page);
> -	else {
> -		dst = kmap_local_page(page);
> -		zswap_fill_page(dst, entry->value);
> -		kunmap_local(dst);
> -	}
> +	else
> +		clear_highpage(page);
>  
>  	count_vm_event(ZSWPIN);
>  	if (entry->objcg)
> @@ -1679,7 +1643,7 @@ static int zswap_debugfs_init(void)
>  	debugfs_create_atomic_t("stored_pages", 0444,
>  				zswap_debugfs_root, &zswap_stored_pages);
>  	debugfs_create_atomic_t("same_filled_pages", 0444,
> -				zswap_debugfs_root, &zswap_same_filled_pages);
> +				zswap_debugfs_root, &zswap_zero_filled_pages);
>  
>  	return 0;
>  }

