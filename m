Return-Path: <linux-kernel+bounces-123646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037A9890C30
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5E4B21FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C683713A886;
	Thu, 28 Mar 2024 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="bkRoQ3cI"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFF135A4D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660039; cv=none; b=sy4ezXj4QNKmPG0fSBfqpAr8hrXr1U8Yg9yaU48qLp9tdEQwdEOYFwJkGfhJTrA/Fe5moQOYqvHAcxOcdaHKtr3g8NU+9PuVI+qJajf+pbP+GqA2i4GEd6n6NPMNmCd/EW21ZYHVLr9jeTRRXdTQAqXxqDSKivIxJD+lH56Ffg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660039; c=relaxed/simple;
	bh=/xdRPfeieNBm6oVzg82NeRy9z/GcQb72oWoivgRM9tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Id8zU7Dg6IQ3tyfFrR5x4Gn64MEGyUftdl8JlXvpCJ8MtWG+2Yr8Vu9U0VIHSxIZsr3Y5k1864WMp+4v0yckw5jTLOSSsSJYwDwPrUbOMf7xKHdlR7NEjuNddbiYX+AGx4yXz4vwtIvZWR3QCZ94iPiVtiaVRYoCQ2ialjPh2CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=bkRoQ3cI; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e67d42422aso894534a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711660034; x=1712264834; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NTdu8962ez2MuYbYiecoLe0sCBQ9yfxAKuPD29ObecM=;
        b=bkRoQ3cIfKK8+9oCR2OVAn6xBD6Bn+KrjUypcLMoQ54Jybquf/s7HzxaHVlPB0o4gz
         f0QhQT/ZpZFmswVfOh35h3PGvJGcypc77SD4kkWNUQzW55iG6HCu8jaRhXXOIaKPtKdi
         qXAjRz0vHl4xr+rqCigkc0gCDUNj5BtmNHmXACd+xr3MS8WzZMxbaJTFiEFcb30RxNtx
         gTmd1IBqEn5FT218FO+oJAyFv1faoQEJiPcRFwJ36VUa6R6YOrn9tINqXaN2IgFmp8yz
         NDHWfMzcDxEbagwZRCmr0F3GIW71hoheTrHwOwi9cbZAeF9DV5OegBH+d2ydYZPDz1jF
         xGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711660034; x=1712264834;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTdu8962ez2MuYbYiecoLe0sCBQ9yfxAKuPD29ObecM=;
        b=DKW73lOH4vjW6nY7HGiJER1SHvsmDyFeu2HQ+99z0b8gEJv6rUG3cSO23t9IH87UyE
         /ltDdWW9he8eg8TGHw9k4dCzXgg/Mt5vewKI+4HrmZGxJDUSXel931sOoQ7nfbrw0ziO
         JGEEOXUP1JO1VbrZDCmPh65hePNqZeIuvtiOeJ+BnJ3kwT5vbW+XKiH/GrT5gsA/77KB
         T/7IjcAjQ/cVaxnMHvIp3ycEd5bOxtyjGftUlhPM6VyXSFlpBxFAvBxG08YqyPXTQTDj
         7SMxRPxBwxoj76LX86/FSKp86OSvuTsg9+aUY0RNGsJPUrkOVezYQOp6L1QCAoJbhysW
         gjww==
X-Forwarded-Encrypted: i=1; AJvYcCXlFkjZlR2h0BYLlvtHUmDHmA1Z70F4pYQCUMhkOKzESLUxmxZIDD85gOVVRvQArjL53euRpehETQ0UnbGIrQbC5UcIJrt+jkdB1hCJ
X-Gm-Message-State: AOJu0Ywa3zjut0Z4ZRZV8meatZNuZ1Th4xmVMz/cOuGB1/TCJW0TH2+i
	SiKhum4dTr3Ilfyyy4ioQIHw+Jxk3LV+EIM8bj+beffkWUIrpN2JdETQ9bxPW9o=
X-Google-Smtp-Source: AGHT+IEQSp26Wg6PtHMz6UiGZCjFYEs7+PNWOYgOK358E0745xM0nwlQWFSRY1QWPvAcbrwqJJFe6w==
X-Received: by 2002:a05:6808:2f09:b0:3c3:7970:373a with SMTP id gu9-20020a0568082f0900b003c37970373amr657226oib.15.1711660034534;
        Thu, 28 Mar 2024 14:07:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:bb1f])
        by smtp.gmail.com with ESMTPSA id fz10-20020a05622a5a8a00b0042eef160b4dsm946299qtb.76.2024.03.28.14.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 14:07:14 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:07:09 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
Message-ID: <20240328210709.GH7597@cmpxchg.org>
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-7-yosryahmed@google.com>
 <20240328193149.GF7597@cmpxchg.org>
 <CAJD7tkaFmbnt4YNWvgGZHo=-JRu-AsUWvCYCRXVZxOPvcSJRDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaFmbnt4YNWvgGZHo=-JRu-AsUWvCYCRXVZxOPvcSJRDw@mail.gmail.com>

On Thu, Mar 28, 2024 at 01:23:42PM -0700, Yosry Ahmed wrote:
> On Thu, Mar 28, 2024 at 12:31 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, Mar 25, 2024 at 11:50:14PM +0000, Yosry Ahmed wrote:
> > > The current same-filled pages handling supports pages filled with any
> > > repeated word-sized pattern. However, in practice, most of these should
> > > be zero pages anyway. Other patterns should be nearly as common.
> > >
> > > Drop the support for non-zero same-filled pages, but keep the names of
> > > knobs exposed to userspace as "same_filled", which isn't entirely
> > > inaccurate.
> > >
> > > This yields some nice code simplification and enables a following patch
> > > that eliminates the need to allocate struct zswap_entry for those pages
> > > completely.
> > >
> > > There is also a very small performance improvement observed over 50 runs
> > > of kernel build test (kernbench) comparing the mean build time on a
> > > skylake machine when building the kernel in a cgroup v1 container with a
> > > 3G limit:
> > >
> > >               base            patched         % diff
> > > real          70.167          69.915          -0.359%
> > > user          2953.068        2956.147        +0.104%
> > > sys           2612.811        2594.718        -0.692%
> > >
> > > This probably comes from more optimized operations like memchr_inv() and
> > > clear_highpage(). Note that the percentage of zero-filled pages during
> > > this test was only around 1.5% on average, and was not affected by this
> > > patch. Practical workloads could have a larger proportion of such pages
> > > (e.g. Johannes observed around 10% [1]), so the performance improvement
> > > should be larger.
> > >
> > > [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg.org/
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > This is an interesting direction to pursue, but I actually thinkg it
> > doesn't go far enough. Either way, I think it needs more data.
> >
> > 1) How frequent are non-zero-same-filled pages? Difficult to
> >    generalize, but if you could gather some from your fleet, that
> >    would be useful. If you can devise a portable strategy, I'd also be
> >    more than happy to gather this on ours (although I think you have
> >    more widespread zswap use, whereas we have more disk swap.)
> 
> I am trying to collect the data, but there are.. hurdles. It would
> take some time, so I was hoping the data could be collected elsewhere
> if possible.
> 
> The idea I had was to hook a BPF program to the entry of
> zswap_fill_page() and create a histogram of the "value" argument. We
> would get more coverage by hooking it to the return of
> zswap_is_page_same_filled() and only updating the histogram if the
> return value is true, as it includes pages in zswap that haven't been
> swapped in.
> 
> However, with zswap_is_page_same_filled() the BPF program will run in
> all zswap stores, whereas for zswap_fill_page() it will only run when
> needed. Not sure if this makes a practical difference tbh.
> 
> >
> > 2) The fact that we're doing any of this pattern analysis in zswap at
> >    all strikes me as a bit misguided. Being efficient about repetitive
> >    patterns is squarely in the domain of a compression algorithm. Do
> >    we not trust e.g. zstd to handle this properly?
> 
> I thought about this briefly, but I didn't follow through. I could try
> to collect some data by swapping out different patterns and observing
> how different compression algorithms react. That would be interesting
> for sure.
> 
> >
> >    I'm guessing this goes back to inefficient packing from something
> >    like zbud, which would waste half a page on one repeating byte.
> >
> >    But zsmalloc can do 32 byte objects. It's also a batching slab
> >    allocator, where storing a series of small, same-sized objects is
> >    quite fast.
> >
> >    Add to that the additional branches, the additional kmap, the extra
> >    scanning of every single page for patterns - all in the fast path
> >    of zswap, when we already know that the vast majority of incoming
> >    pages will need to be properly compressed anyway.
> >
> >    Maybe it's time to get rid of the special handling entirely?
> 
> We would still be wasting some memory (~96 bytes between zswap_entry
> and zsmalloc object), and wasting cycling allocating them. This could
> be made up for by cycles saved by removing the handling. We will be
> saving some branches for sure. I am not worried about kmap as I think
> it's a noop in most cases.

Yes, true.

> I am interested to see how much we could save by removing scanning for
> patterns. We may not save much if we abort after reading a few words
> in most cases, but I guess we could also be scanning a considerable
> amount before aborting. On the other hand, we would be reading the
> page contents into cache anyway for compression, so maybe it doesn't
> really matter?
> 
> I will try to collect some data about this. I will start by trying to
> find out how the compression algorithms handle same-filled pages. If
> they can compress it efficiently, then I will try to get more data on
> the tradeoff from removing the handling.

I do wonder if this could be overthinking it, too.

Double checking the numbers on our fleet, a 96 additional bytes for
each same-filled entry would result in a

1) p50 waste of 0.008% of total memory, and a

2) p99 waste of 0.06% of total memory.

And this is without us having even thought about trying to make
zsmalloc more efficient for this particular usecase - which might be
the better point of attack, if we think it's actually worth it.

So my take is that unless removing it would be outright horrible from
a %sys POV (which seems pretty unlikely), IMO it would be fine to just
delete it entirely with a "not worth the maintenance cost" argument.

If you turn the argument around, and somebody would submit the code as
it is today, with the numbers being what they are above, I'm not sure
we would even accept it!

E.g.

 mm/zswap.c | 114 ++++++-----------------------------------------------------
 1 file changed, 10 insertions(+), 104 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 741957f36f38..fc447f8a5c24 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -44,8 +44,6 @@
 **********************************/
 /* The number of compressed pages currently stored in zswap */
 atomic_t zswap_stored_pages = ATOMIC_INIT(0);
-/* The number of same-value filled pages currently stored in zswap */
-static atomic_t zswap_same_filled_pages = ATOMIC_INIT(0);
 
 /*
  * The statistics below are not protected from concurrent access for
@@ -123,19 +121,6 @@ static unsigned int zswap_accept_thr_percent = 90; /* of max pool size */
 module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
 		   uint, 0644);
 
-/*
- * Enable/disable handling same-value filled pages (enabled by default).
- * If disabled every page is considered non-same-value filled.
- */
-static bool zswap_same_filled_pages_enabled = true;
-module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
-		   bool, 0644);
-
-/* Enable/disable handling non-same-value filled pages (enabled by default) */
-static bool zswap_non_same_filled_pages_enabled = true;
-module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_pages_enabled,
-		   bool, 0644);
-
 /* Number of zpools in zswap_pool (empirically determined for scalability) */
 #define ZSWAP_NR_ZPOOLS 32
 
@@ -194,12 +179,9 @@ static struct shrinker *zswap_shrinker;
  * page within zswap.
  *
  * swpentry - associated swap entry, the offset indexes into the red-black tree
- * length - the length in bytes of the compressed page data.  Needed during
- *          decompression. For a same value filled page length is 0, and both
- *          pool and lru are invalid and must be ignored.
+ * length - the length in bytes of the compressed page data
  * pool - the zswap_pool the entry's data is in
  * handle - zpool allocation handle that stores the compressed page data
- * value - value of the same-value filled pages which have same content
  * objcg - the obj_cgroup that the compressed memory is charged to
  * lru - handle to the pool's lru used to evict pages.
  */
@@ -207,10 +189,7 @@ struct zswap_entry {
 	swp_entry_t swpentry;
 	unsigned int length;
 	struct zswap_pool *pool;
-	union {
-		unsigned long handle;
-		unsigned long value;
-	};
+	unsigned long handle;
 	struct obj_cgroup *objcg;
 	struct list_head lru;
 };
@@ -812,13 +791,9 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
  */
 static void zswap_entry_free(struct zswap_entry *entry)
 {
-	if (!entry->length)
-		atomic_dec(&zswap_same_filled_pages);
-	else {
-		zswap_lru_del(&zswap_list_lru, entry);
-		zpool_free(zswap_find_zpool(entry), entry->handle);
-		zswap_pool_put(entry->pool);
-	}
+	zswap_lru_del(&zswap_list_lru, entry);
+	zpool_free(zswap_find_zpool(entry), entry->handle);
+	zswap_pool_put(entry->pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
 		obj_cgroup_put(entry->objcg);
@@ -1253,11 +1228,6 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	 * This ensures that the better zswap compresses memory, the fewer
 	 * pages we will evict to swap (as it will otherwise incur IO for
 	 * relatively small memory saving).
-	 *
-	 * The memory saving factor calculated here takes same-filled pages into
-	 * account, but those are not freeable since they almost occupy no
-	 * space. Hence, we may scale nr_freeable down a little bit more than we
-	 * should if we have a lot of same-filled pages.
 	 */
 	return mult_frac(nr_freeable, nr_backing, nr_stored);
 }
@@ -1361,36 +1331,6 @@ static void shrink_worker(struct work_struct *w)
 	} while (zswap_total_pages() > thr);
 }
 
-static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
-{
-	unsigned long *page;
-	unsigned long val;
-	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
-
-	page = (unsigned long *)ptr;
-	val = page[0];
-
-	if (val != page[last_pos])
-		return 0;
-
-	for (pos = 1; pos < last_pos; pos++) {
-		if (val != page[pos])
-			return 0;
-	}
-
-	*value = val;
-
-	return 1;
-}
-
-static void zswap_fill_page(void *ptr, unsigned long value)
-{
-	unsigned long *page;
-
-	page = (unsigned long *)ptr;
-	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
-}
-
 bool zswap_store(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
@@ -1446,24 +1386,6 @@ bool zswap_store(struct folio *folio)
 		goto reject;
 	}
 
-	if (zswap_same_filled_pages_enabled) {
-		unsigned long value;
-		u8 *src;
-
-		src = kmap_local_folio(folio, 0);
-		if (zswap_is_page_same_filled(src, &value)) {
-			kunmap_local(src);
-			entry->length = 0;
-			entry->value = value;
-			atomic_inc(&zswap_same_filled_pages);
-			goto insert_entry;
-		}
-		kunmap_local(src);
-	}
-
-	if (!zswap_non_same_filled_pages_enabled)
-		goto freepage;
-
 	/* if entry is successfully added, it keeps the reference */
 	entry->pool = zswap_pool_current_get();
 	if (!entry->pool)
@@ -1481,7 +1403,6 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_compress(folio, entry))
 		goto put_pool;
 
-insert_entry:
 	entry->swpentry = swp;
 	entry->objcg = objcg;
 
@@ -1517,10 +1438,8 @@ bool zswap_store(struct folio *folio)
 	 *    The publishing order matters to prevent writeback from seeing
 	 *    an incoherent entry.
 	 */
-	if (entry->length) {
-		INIT_LIST_HEAD(&entry->lru);
-		zswap_lru_add(&zswap_list_lru, entry);
-	}
+	INIT_LIST_HEAD(&entry->lru);
+	zswap_lru_add(&zswap_list_lru, entry);
 
 	/* update stats */
 	atomic_inc(&zswap_stored_pages);
@@ -1529,13 +1448,9 @@ bool zswap_store(struct folio *folio)
 	return true;
 
 store_failed:
-	if (!entry->length)
-		atomic_dec(&zswap_same_filled_pages);
-	else {
-		zpool_free(zswap_find_zpool(entry), entry->handle);
+	zpool_free(zswap_find_zpool(entry), entry->handle);
 put_pool:
-		zswap_pool_put(entry->pool);
-	}
+	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
 reject:
@@ -1564,7 +1479,6 @@ bool zswap_load(struct folio *folio)
 	bool swapcache = folio_test_swapcache(folio);
 	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
-	u8 *dst;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 
@@ -1588,13 +1502,7 @@ bool zswap_load(struct folio *folio)
 	if (!entry)
 		return false;
 
-	if (entry->length)
-		zswap_decompress(entry, page);
-	else {
-		dst = kmap_local_page(page);
-		zswap_fill_page(dst, entry->value);
-		kunmap_local(dst);
-	}
+	zswap_decompress(entry, page);
 
 	count_vm_event(ZSWPIN);
 	if (entry->objcg)
@@ -1696,8 +1604,6 @@ static int zswap_debugfs_init(void)
 			    zswap_debugfs_root, NULL, &total_size_fops);
 	debugfs_create_atomic_t("stored_pages", 0444,
 				zswap_debugfs_root, &zswap_stored_pages);
-	debugfs_create_atomic_t("same_filled_pages", 0444,
-				zswap_debugfs_root, &zswap_same_filled_pages);
 
 	return 0;
 }

