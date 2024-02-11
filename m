Return-Path: <linux-kernel+bounces-60959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B00850B9B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 22:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB4BB214BF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D955C5EE92;
	Sun, 11 Feb 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMh+uTlR"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F925B691
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707685502; cv=none; b=eYjBAGsu1FblMagBjoGPREQUJnsRLfsRY+xx+yAxp2FWoXY/iD3Nm2HQOJ/bdmA8qydcGcwBYfQlWdpdIGRkgxJ+3rpEPK2yeK4HiQtycy7zVauXXj8ZzGc54co9I35ODk7DJuOLNOkIzZ4j19GvHvjUdOA/1Y5kLEsZjS0ubNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707685502; c=relaxed/simple;
	bh=sujA2zNoiwYTW/GA/3ylHHfFEz7DVabIuCjOYJOm1eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kecIbcyt19xy4Z4tKkTuZG+4h0ZkvDU8cQPIoU36BlShIBKKTBr/nsQzKTxXJQf+12lDm1RR6mhswNZD0qk1WO8x3ztTAT5VTwOhUyYaMaz5ZzWE5VRwasIBwVsGThJS2u8a+cueJ8f7jL7krrOYY0iB9JhnVwKuLnsw3uxO0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMh+uTlR; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c457b8ef7cso21089039f.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 13:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707685500; x=1708290300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnufYSnNU85HPPQIhsbLJzZ5m2bbdl971gPFOAuQfsk=;
        b=cMh+uTlRUfZAIK9lkgoI1GLXnpKvCHVnjWnV7n1Qzk/BZMYxQ4Kg3ZwFPt7K6s01Ch
         3SJ3NyyyQuilTGjwRe6lKt5foWekmus/IhZI6KeI5HYmWaQTTigbgdXXKCMPdUEHJq7S
         eryERbLGn/sTS56vHXLYtuP8fvHwVR0XH5xDSP9cVOM+2p5ctVqsLi99yX+BxlhZWczn
         7BGebfraONsIgpHnPGP5D2bWNjTVtItIMVHPGOwHtJ3l2+Hyi3ciFcDXsNYbIQnn0AeD
         9URxQtxGE8opOeJ2vJr+Yc/TYU6GkE7sl5U1cYc65nLmpt7nJa+C16f1ghzbGdXnvRgu
         WKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707685500; x=1708290300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnufYSnNU85HPPQIhsbLJzZ5m2bbdl971gPFOAuQfsk=;
        b=wxaAaAkMslsrV5C81FRKUmgOOGb4tcao5j/WM/qn0ZzGun+Fqp6TPGyDsNQXyoBd8R
         8RYy60hZFwWUEouK3lSttVl2I6gqM0sTi1KcKZl/awV5/rWkWnv+JKHVTpIiivhG87OU
         4gqx6qNxuwTf65xKWFqpC4S6rmlywrzUTg0tRlGOYdqO8FwTpvRmPq6fDF1Ld/o/WPpz
         lM0wR5j/OV95dLSCKDMPTed8rm8gVPd7yzgFGOOwLx37mwhLoBGfBKgvcOMfp6gYwW9I
         f0KRAYEMnmZFmJApMLIQyi5L+P/QaZJSAT8Bnl2k+bv30fy/P5caSCM6cecTgktrmUR6
         XOXw==
X-Forwarded-Encrypted: i=1; AJvYcCVw3d/TT9301hYnQFaxDo9ZV/LfhRiZ/eHr0HyfFJQFlhiYIi+V7P0/k/341ExJC0nq4PaxerQ6cSzk+BvPoH5VENg3hybgYoFBEsPT
X-Gm-Message-State: AOJu0YwHV6yAc+Nm2LI8pM/nKkKHSt0A8qjUNHbIJ6bgDNMhlzZmoHwd
	krJufi5LhQKN8fbxQ5wx3jpdpiZaPL//Q2pBqLWQJ7rhWWSH/4usnNeuqoeWXaKZRsfccqw2HUx
	wNO+V/d6ksoMtEqFIBuPEejvyRUJVoMQ7Iuc=
X-Google-Smtp-Source: AGHT+IF+HGrtnDBJeRdffX+TCRoMssvaC7rXsedvbfQDOjkzHlWhtS/2m+moJxZ3Z79tK/zboCp+hWYPIYsFNx5VLSE=
X-Received: by 2002:a6b:700a:0:b0:7c4:65c1:c442 with SMTP id
 l10-20020a6b700a000000b007c465c1c442mr578296ioc.11.1707685499700; Sun, 11 Feb
 2024 13:04:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com> <20240210-zswap-global-lru-v1-1-853473d7b0da@bytedance.com>
In-Reply-To: <20240210-zswap-global-lru-v1-1-853473d7b0da@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 11 Feb 2024 13:04:48 -0800
Message-ID: <CAKEwX=Nbbm=BZ8Rp7Knfk3P=jXK2SJnhgR_vOK9w1ovPUdF9UA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/zswap: global lru and shrinker shared by all zswap_pools
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 5:57=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Dynamic zswap_pool creation may create/reuse to have multiple
> zswap_pools in a list, only the first will be current used.
>
> Each zswap_pool has its own lru and shrinker, which is not
> necessary and has its problem:
>
> 1. When memory has pressure, all shrinker of zswap_pools will
>    try to shrink its own lru, there is no order between them.
>
> 2. When zswap limit hit, only the last zswap_pool's shrink_work
>    will try to shrink its lru, which is inefficient.
>
> Anyway, having a global lru and shrinker shared by all zswap_pools
> is better and efficient.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

I'll do a careful review later, but IMO this is a good idea :)

Chris pointed out when he reviewed the zswap shrinker patch series
that the reclaim algorithm has to decide which pool to reclaim from,
and I have always thought that it was a bit weird that we have to do
it at all. We should reclaim stored objects by access ordering,
irregardless of which pool it belongs to. Having a shared LRU and
other associated reclaim structures is sound, and saves a bit of space
too while we're at it.

> ---
>  mm/zswap.c | 153 ++++++++++++++++++++++---------------------------------=
------
>  1 file changed, 55 insertions(+), 98 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 62fe307521c9..7668db8c10e3 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -176,14 +176,17 @@ struct zswap_pool {
>         struct kref kref;
>         struct list_head list;
>         struct work_struct release_work;
> -       struct work_struct shrink_work;
>         struct hlist_node node;
>         char tfm_name[CRYPTO_MAX_ALG_NAME];
> +};
> +
> +struct {
>         struct list_lru list_lru;
> -       struct mem_cgroup *next_shrink;
> -       struct shrinker *shrinker;
>         atomic_t nr_stored;
> -};
> +       struct shrinker *shrinker;
> +       struct work_struct shrink_work;
> +       struct mem_cgroup *next_shrink;
> +} zswap;
>
>  /*
>   * struct zswap_entry
> @@ -301,9 +304,6 @@ static void zswap_update_total_size(void)
>  * pool functions
>  **********************************/
>
> -static void zswap_alloc_shrinker(struct zswap_pool *pool);
> -static void shrink_worker(struct work_struct *w);
> -
>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor=
)
>  {
>         int i;
> @@ -353,30 +353,16 @@ static struct zswap_pool *zswap_pool_create(char *t=
ype, char *compressor)
>         if (ret)
>                 goto error;
>
> -       zswap_alloc_shrinker(pool);
> -       if (!pool->shrinker)
> -               goto error;
> -
> -       pr_debug("using %s compressor\n", pool->tfm_name);
> -
>         /* being the current pool takes 1 ref; this func expects the
>          * caller to always add the new pool as the current pool
>          */
>         kref_init(&pool->kref);
>         INIT_LIST_HEAD(&pool->list);
> -       if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
> -               goto lru_fail;
> -       shrinker_register(pool->shrinker);
> -       INIT_WORK(&pool->shrink_work, shrink_worker);
> -       atomic_set(&pool->nr_stored, 0);
>
>         zswap_pool_debug("created", pool);
>
>         return pool;
>
> -lru_fail:
> -       list_lru_destroy(&pool->list_lru);
> -       shrinker_free(pool->shrinker);
>  error:
>         if (pool->acomp_ctx)
>                 free_percpu(pool->acomp_ctx);
> @@ -434,15 +420,8 @@ static void zswap_pool_destroy(struct zswap_pool *po=
ol)
>
>         zswap_pool_debug("destroying", pool);
>
> -       shrinker_free(pool->shrinker);
>         cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->no=
de);
>         free_percpu(pool->acomp_ctx);
> -       list_lru_destroy(&pool->list_lru);
> -
> -       spin_lock(&zswap_pools_lock);
> -       mem_cgroup_iter_break(NULL, pool->next_shrink);
> -       pool->next_shrink =3D NULL;
> -       spin_unlock(&zswap_pools_lock);
>
>         for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
>                 zpool_destroy_pool(pool->zpools[i]);
> @@ -529,24 +508,6 @@ static struct zswap_pool *zswap_pool_current_get(voi=
d)
>         return pool;
>  }
>
> -static struct zswap_pool *zswap_pool_last_get(void)
> -{
> -       struct zswap_pool *pool, *last =3D NULL;
> -
> -       rcu_read_lock();
> -
> -       list_for_each_entry_rcu(pool, &zswap_pools, list)
> -               last =3D pool;
> -       WARN_ONCE(!last && zswap_has_pool,
> -                 "%s: no page storage pool!\n", __func__);
> -       if (!zswap_pool_get(last))
> -               last =3D NULL;
> -
> -       rcu_read_unlock();
> -
> -       return last;
> -}
> -
>  /* type and compressor must be null-terminated */
>  static struct zswap_pool *zswap_pool_find_get(char *type, char *compress=
or)
>  {
> @@ -816,14 +777,10 @@ void zswap_folio_swapin(struct folio *folio)
>
>  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
>  {
> -       struct zswap_pool *pool;
> -
> -       /* lock out zswap pools list modification */
> +       /* lock out zswap shrinker walking memcg tree */
>         spin_lock(&zswap_pools_lock);
> -       list_for_each_entry(pool, &zswap_pools, list) {
> -               if (pool->next_shrink =3D=3D memcg)
> -                       pool->next_shrink =3D mem_cgroup_iter(NULL, pool-=
>next_shrink, NULL);
> -       }
> +       if (zswap.next_shrink =3D=3D memcg)
> +               zswap.next_shrink =3D mem_cgroup_iter(NULL, zswap.next_sh=
rink, NULL);
>         spin_unlock(&zswap_pools_lock);
>  }
>
> @@ -923,9 +880,9 @@ static void zswap_entry_free(struct zswap_entry *entr=
y)
>         if (!entry->length)
>                 atomic_dec(&zswap_same_filled_pages);
>         else {
> -               zswap_lru_del(&entry->pool->list_lru, entry);
> +               zswap_lru_del(&zswap.list_lru, entry);
>                 zpool_free(zswap_find_zpool(entry), entry->handle);
> -               atomic_dec(&entry->pool->nr_stored);
> +               atomic_dec(&zswap.nr_stored);
>                 zswap_pool_put(entry->pool);
>         }
>         if (entry->objcg) {
> @@ -1288,7 +1245,6 @@ static unsigned long zswap_shrinker_scan(struct shr=
inker *shrinker,
>  {
>         struct lruvec *lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE_DATA(=
sc->nid));
>         unsigned long shrink_ret, nr_protected, lru_size;
> -       struct zswap_pool *pool =3D shrinker->private_data;
>         bool encountered_page_in_swapcache =3D false;
>
>         if (!zswap_shrinker_enabled ||
> @@ -1299,7 +1255,7 @@ static unsigned long zswap_shrinker_scan(struct shr=
inker *shrinker,
>
>         nr_protected =3D
>                 atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_pro=
tected);
> -       lru_size =3D list_lru_shrink_count(&pool->list_lru, sc);
> +       lru_size =3D list_lru_shrink_count(&zswap.list_lru, sc);
>
>         /*
>          * Abort if we are shrinking into the protected region.
> @@ -1316,7 +1272,7 @@ static unsigned long zswap_shrinker_scan(struct shr=
inker *shrinker,
>                 return SHRINK_STOP;
>         }
>
> -       shrink_ret =3D list_lru_shrink_walk(&pool->list_lru, sc, &shrink_=
memcg_cb,
> +       shrink_ret =3D list_lru_shrink_walk(&zswap.list_lru, sc, &shrink_=
memcg_cb,
>                 &encountered_page_in_swapcache);
>
>         if (encountered_page_in_swapcache)
> @@ -1328,7 +1284,6 @@ static unsigned long zswap_shrinker_scan(struct shr=
inker *shrinker,
>  static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
>                 struct shrink_control *sc)
>  {
> -       struct zswap_pool *pool =3D shrinker->private_data;
>         struct mem_cgroup *memcg =3D sc->memcg;
>         struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(sc->=
nid));
>         unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
> @@ -1343,7 +1298,7 @@ static unsigned long zswap_shrinker_count(struct sh=
rinker *shrinker,
>  #else
>         /* use pool stats instead of memcg stats */
>         nr_backing =3D get_zswap_pool_size(pool) >> PAGE_SHIFT;
> -       nr_stored =3D atomic_read(&pool->nr_stored);
> +       nr_stored =3D atomic_read(&zswap.nr_stored);
>  #endif
>
>         if (!nr_stored)
> @@ -1351,7 +1306,7 @@ static unsigned long zswap_shrinker_count(struct sh=
rinker *shrinker,
>
>         nr_protected =3D
>                 atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_pro=
tected);
> -       nr_freeable =3D list_lru_shrink_count(&pool->list_lru, sc);
> +       nr_freeable =3D list_lru_shrink_count(&zswap.list_lru, sc);
>         /*
>          * Subtract the lru size by an estimate of the number of pages
>          * that should be protected.
> @@ -1367,23 +1322,24 @@ static unsigned long zswap_shrinker_count(struct =
shrinker *shrinker,
>         return mult_frac(nr_freeable, nr_backing, nr_stored);
>  }
>
> -static void zswap_alloc_shrinker(struct zswap_pool *pool)
> +static struct shrinker *zswap_alloc_shrinker(void)
>  {
> -       pool->shrinker =3D
> +       struct shrinker *shrinker;
> +
> +       shrinker =3D
>                 shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE=
, "mm-zswap");
> -       if (!pool->shrinker)
> -               return;
> +       if (!shrinker)
> +               return NULL;
>
> -       pool->shrinker->private_data =3D pool;
> -       pool->shrinker->scan_objects =3D zswap_shrinker_scan;
> -       pool->shrinker->count_objects =3D zswap_shrinker_count;
> -       pool->shrinker->batch =3D 0;
> -       pool->shrinker->seeks =3D DEFAULT_SEEKS;
> +       shrinker->scan_objects =3D zswap_shrinker_scan;
> +       shrinker->count_objects =3D zswap_shrinker_count;
> +       shrinker->batch =3D 0;
> +       shrinker->seeks =3D DEFAULT_SEEKS;
> +       return shrinker;
>  }
>
>  static int shrink_memcg(struct mem_cgroup *memcg)
>  {
> -       struct zswap_pool *pool;
>         int nid, shrunk =3D 0;
>
>         if (!mem_cgroup_zswap_writeback_enabled(memcg))
> @@ -1396,32 +1352,25 @@ static int shrink_memcg(struct mem_cgroup *memcg)
>         if (memcg && !mem_cgroup_online(memcg))
>                 return -ENOENT;
>
> -       pool =3D zswap_pool_current_get();
> -       if (!pool)
> -               return -EINVAL;
> -
>         for_each_node_state(nid, N_NORMAL_MEMORY) {
>                 unsigned long nr_to_walk =3D 1;
>
> -               shrunk +=3D list_lru_walk_one(&pool->list_lru, nid, memcg=
,
> +               shrunk +=3D list_lru_walk_one(&zswap.list_lru, nid, memcg=
,
>                                             &shrink_memcg_cb, NULL, &nr_t=
o_walk);
>         }
> -       zswap_pool_put(pool);
>         return shrunk ? 0 : -EAGAIN;
>  }
>
>  static void shrink_worker(struct work_struct *w)
>  {
> -       struct zswap_pool *pool =3D container_of(w, typeof(*pool),
> -                                               shrink_work);
>         struct mem_cgroup *memcg;
>         int ret, failures =3D 0;
>
>         /* global reclaim will select cgroup in a round-robin fashion. */
>         do {
>                 spin_lock(&zswap_pools_lock);
> -               pool->next_shrink =3D mem_cgroup_iter(NULL, pool->next_sh=
rink, NULL);
> -               memcg =3D pool->next_shrink;
> +               zswap.next_shrink =3D mem_cgroup_iter(NULL, zswap.next_sh=
rink, NULL);
> +               memcg =3D zswap.next_shrink;
>
>                 /*
>                  * We need to retry if we have gone through a full round =
trip, or if we
> @@ -1445,7 +1394,7 @@ static void shrink_worker(struct work_struct *w)
>                 if (!mem_cgroup_tryget_online(memcg)) {
>                         /* drop the reference from mem_cgroup_iter() */
>                         mem_cgroup_iter_break(NULL, memcg);
> -                       pool->next_shrink =3D NULL;
> +                       zswap.next_shrink =3D NULL;
>                         spin_unlock(&zswap_pools_lock);
>
>                         if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> @@ -1467,7 +1416,6 @@ static void shrink_worker(struct work_struct *w)
>  resched:
>                 cond_resched();
>         } while (!zswap_can_accept());
> -       zswap_pool_put(pool);
>  }
>
>  static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
> @@ -1508,7 +1456,6 @@ bool zswap_store(struct folio *folio)
>         struct zswap_entry *entry, *dupentry;
>         struct obj_cgroup *objcg =3D NULL;
>         struct mem_cgroup *memcg =3D NULL;
> -       struct zswap_pool *shrink_pool;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1576,7 +1523,7 @@ bool zswap_store(struct folio *folio)
>
>         if (objcg) {
>                 memcg =3D get_mem_cgroup_from_objcg(objcg);
> -               if (memcg_list_lru_alloc(memcg, &entry->pool->list_lru, G=
FP_KERNEL)) {
> +               if (memcg_list_lru_alloc(memcg, &zswap.list_lru, GFP_KERN=
EL)) {
>                         mem_cgroup_put(memcg);
>                         goto put_pool;
>                 }
> @@ -1607,8 +1554,8 @@ bool zswap_store(struct folio *folio)
>         }
>         if (entry->length) {
>                 INIT_LIST_HEAD(&entry->lru);
> -               zswap_lru_add(&entry->pool->list_lru, entry);
> -               atomic_inc(&entry->pool->nr_stored);
> +               zswap_lru_add(&zswap.list_lru, entry);
> +               atomic_inc(&zswap.nr_stored);
>         }
>         spin_unlock(&tree->lock);
>
> @@ -1640,9 +1587,7 @@ bool zswap_store(struct folio *folio)
>         return false;
>
>  shrink:
> -       shrink_pool =3D zswap_pool_last_get();
> -       if (shrink_pool && !queue_work(shrink_wq, &shrink_pool->shrink_wo=
rk))
> -               zswap_pool_put(shrink_pool);
> +       queue_work(shrink_wq, &zswap.shrink_work);
>         goto reject;
>  }
>
> @@ -1804,6 +1749,21 @@ static int zswap_setup(void)
>         if (ret)
>                 goto hp_fail;
>
> +       shrink_wq =3D alloc_workqueue("zswap-shrink",
> +                       WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
> +       if (!shrink_wq)
> +               goto hp_fail;
> +
> +       zswap.shrinker =3D zswap_alloc_shrinker();
> +       if (!zswap.shrinker)
> +               goto shrinker_fail;
> +       if (list_lru_init_memcg(&zswap.list_lru, zswap.shrinker))
> +               goto lru_fail;
> +       shrinker_register(zswap.shrinker);
> +
> +       INIT_WORK(&zswap.shrink_work, shrink_worker);
> +       atomic_set(&zswap.nr_stored, 0);
> +
>         pool =3D __zswap_pool_create_fallback();
>         if (pool) {
>                 pr_info("loaded using pool %s/%s\n", pool->tfm_name,
> @@ -1815,19 +1775,16 @@ static int zswap_setup(void)
>                 zswap_enabled =3D false;
>         }
>
> -       shrink_wq =3D alloc_workqueue("zswap-shrink",
> -                       WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
> -       if (!shrink_wq)
> -               goto fallback_fail;
> -
>         if (zswap_debugfs_init())
>                 pr_warn("debugfs initialization failed\n");
>         zswap_init_state =3D ZSWAP_INIT_SUCCEED;
>         return 0;
>
> -fallback_fail:
> -       if (pool)
> -               zswap_pool_destroy(pool);
> +lru_fail:
> +       list_lru_destroy(&zswap.list_lru);
> +       shrinker_free(zswap.shrinker);
> +shrinker_fail:
> +       destroy_workqueue(shrink_wq);
>  hp_fail:
>         kmem_cache_destroy(zswap_entry_cache);
>  cache_fail:
>
> --
> b4 0.10.1

