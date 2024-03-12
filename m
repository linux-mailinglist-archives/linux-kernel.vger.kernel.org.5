Return-Path: <linux-kernel+bounces-99992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24208879069
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450101C21959
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BF177F2E;
	Tue, 12 Mar 2024 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoCtwkqW"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA077A03
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234766; cv=none; b=sZe2AuUZXpjpls1FPlyzV9BofREp/SZjBLHQux95uxdTBj1TEH3wux8EWszFu29OOlaEfC2tTB8NoW7uOVNcIt9t4O/DR6A5zxayHYn7im6BqpB+/KD7//gdzNVOyWv2vmLSxzH7LxM5bIWoeFDQUBtWXPlfvOZvKIqQwiVBDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234766; c=relaxed/simple;
	bh=KNJwx9Lu7mYLEyy4haaLnwu1dF3ZkAM9VzuRduJz5RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLrhSp6Qw8blYHifsNGRqYzaU+muDQLf2oOTgKIej1pWVGPA1yxAYRu8pnUvn4MXGmzxcT4cNKJ1EF1nZdweQ1ckiT1L26IjkG/mEfgQcKWtOLvdl4QlOwDrYFF0XpoVeQm1vXmpCufzn3KPgTtW3NAyqdehtf6xELJKE9TvNcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoCtwkqW; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68ee2c0a237so34229106d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710234764; x=1710839564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rUxrQEulPJ8fAsXx7rye46mclEZHswu8KUh45f0+5Y=;
        b=SoCtwkqWNNiA7a105c41dY7AOfov09xxzcOC9nL/u2JozUFpC7UsLA7dcP4zCGIiml
         AHCQRAZrUOIXby0Q+YkmHCGqOrRi6IMveqqcyAQF82xBjdwRO027e83FpaXfdAjXDN+U
         wdhh3cEWkESfYI/6NG6QMgnhXfhRiibMEMav7NzPl4MBhK7k3zyisE/mo1VGvzJHKKFB
         5Gn1sDO7iA+9cRVJrNkoVOhMpzUVpfswAoeWyauUbJz4QnrUM86z1lg2V9oyq1D1rCo7
         ShDdHKKl2+XtdtBPZeLtzZgKghDxJDnKKmkANQlPf1Y3j0AeZEtpxygOlKKdKb0osGdZ
         R7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710234764; x=1710839564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rUxrQEulPJ8fAsXx7rye46mclEZHswu8KUh45f0+5Y=;
        b=JA5bmTQLS5VUn/pcmIA9fUGg5TXpfrTVnyTxCiTutm6k9oCngKBEaTn9zzQUi/6jcz
         ye4E/v4wdTW+ESK2TPrn51Y6/9WC+kjx6IRJYgSnocNH2BtvR0hJFAXWdKTIMsrsCEP6
         pz2XZLiXQUcWpfwVlIj1jJ85dNT1RuKr6Ndn6BiYd257FRoW1Sgwa7P48jdNWuZHU6Dy
         LfuF9voBoUFVKT69zFDBOviX53O9Lf81DF6YtFLsTSsi5JtjA3FQNUzz5zna9WuJePnZ
         zLAM+oMMojI92xgZaB2buLrW+gUDp0Y5xMujpnr97fCT+w6uuLYno6PIjPIMSdUbMQEO
         6gWw==
X-Forwarded-Encrypted: i=1; AJvYcCUYpXKLW3ZQ+5Moyw+CGd/ZVwcGuOG9JHKugvkUER1B+pRxUGARF9/Km/i7xL3OutTVIPpoF+FhooOG3NxFPOrnCH0cbhD5121KnRzZ
X-Gm-Message-State: AOJu0Ywgk72pIz5ceMD6BbdtY4y/atPdqKuGZtdyRYhpsUbFitAkT3En
	AZIXtSDDPUe+l64uH19E8wr6A/J8pl8hY5ZEdl6c85vUva59Kh4nlqRvuSYlyz2V32q3fGfv5j1
	zRcyyflRhzncwSdwxgDxwSJoPJeQ=
X-Google-Smtp-Source: AGHT+IEQSpNWG3Ysi4W4TTQIV2JRY97VARQRzp2M6AJuOs54BFsyELyeTiX4468GHJpaEV3HOdJ5Vaoy5HzljZGr7kE=
X-Received: by 2002:a05:6214:5009:b0:68f:a813:f0d with SMTP id
 jo9-20020a056214500900b0068fa8130f0dmr16567830qvb.32.1710234763971; Tue, 12
 Mar 2024 02:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311161214.1145168-1-hannes@cmpxchg.org>
In-Reply-To: <20240311161214.1145168-1-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 12 Mar 2024 16:12:32 +0700
Message-ID: <CAKEwX=OYs6WAJvPoiLArvO+HGf-ZF6USoJ+QUuaVXzhoXcexHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap: optimize zswap pool size tracking
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:12=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
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

Nice!

>
> The paths that benefit dramatically are swapin, swapoff, and
> unmaps. There could be millions of pages being processed until
> somebody asks for the pool size again. This eliminates the pool size
> updates from those paths entirely.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

With your fixlet applied:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

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
> @@ -89,8 +89,7 @@ static int meminfo_proc_show(struct seq_file *m, void *=
v)
>         show_val_kb(m, "SwapTotal:      ", i.totalswap);
>         show_val_kb(m, "SwapFree:       ", i.freeswap);
>  #ifdef CONFIG_ZSWAP
> -       seq_printf(m,  "Zswap:          %8lu kB\n",
> -                  (unsigned long)(zswap_pool_total_size >> 10));
> +       show_val_kb(m, "Zswap:          ", zswap_total_pages());
>         seq_printf(m,  "Zswapped:       %8lu kB\n",
>                    (unsigned long)atomic_read(&zswap_stored_pages) <<
>                    (PAGE_SHIFT - 10));
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
>         atomic_long_t nr_zswap_protected;
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
>  atomic_t zswap_stored_pages =3D ATOMIC_INIT(0);
>  /* The number of same-value filled pages currently stored in zswap */
> @@ -264,45 +262,6 @@ static inline struct zswap_tree *swap_zswap_tree(swp=
_entry_t swp)
>         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
>                  zpool_get_type((p)->zpools[0]))
>
> -static bool zswap_is_full(void)
> -{
> -       return totalram_pages() * zswap_max_pool_percent / 100 <
> -                       DIV_ROUND_UP(zswap_pool_total_size, PAGE_SIZE);
> -}
> -
> -static bool zswap_can_accept(void)
> -{
> -       return totalram_pages() * zswap_accept_thr_percent / 100 *
> -                               zswap_max_pool_percent / 100 >
> -                       DIV_ROUND_UP(zswap_pool_total_size, PAGE_SIZE);
> -}
> -
> -static u64 get_zswap_pool_size(struct zswap_pool *pool)
> -{
> -       u64 pool_size =3D 0;
> -       int i;
> -
> -       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> -               pool_size +=3D zpool_get_total_size(pool->zpools[i]);
> -
> -       return pool_size;
> -}
> -
> -static void zswap_update_total_size(void)
> -{
> -       struct zswap_pool *pool;
> -       u64 total =3D 0;
> -
> -       rcu_read_lock();
> -
> -       list_for_each_entry_rcu(pool, &zswap_pools, list)
> -               total +=3D get_zswap_pool_size(pool);
> -
> -       rcu_read_unlock();
> -
> -       zswap_pool_total_size =3D total;
> -}
> -
>  /*********************************
>  * pool functions
>  **********************************/
> @@ -540,6 +499,28 @@ static struct zswap_pool *zswap_pool_find_get(char *=
type, char *compressor)
>         return NULL;
>  }
>
> +static unsigned long zswap_max_pages(void)
> +{
> +       return totalram_pages() * zswap_max_pool_percent / 100;
> +}
> +
> +unsigned long zswap_total_pages(void)
> +{
> +       struct zswap_pool *pool;
> +       u64 total =3D 0;
> +
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(pool, &zswap_pools, list) {
> +               int i;
> +
> +               for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> +                       total +=3D zpool_get_total_size(pool->zpools[i]);
> +       }
> +       rcu_read_unlock();
> +
> +       return total >> PAGE_SHIFT;
> +}
> +
>  /*********************************
>  * param callbacks
>  **********************************/
> @@ -912,7 +893,6 @@ static void zswap_entry_free(struct zswap_entry *entr=
y)
>         }
>         zswap_entry_cache_free(entry);
>         atomic_dec(&zswap_stored_pages);
> -       zswap_update_total_size();
>  }
>
>  /*
> @@ -1317,7 +1297,7 @@ static unsigned long zswap_shrinker_count(struct sh=
rinker *shrinker,
>         nr_stored =3D memcg_page_state(memcg, MEMCG_ZSWAPPED);
>  #else
>         /* use pool stats instead of memcg stats */
> -       nr_backing =3D zswap_pool_total_size >> PAGE_SHIFT;
> +       nr_backing =3D zswap_total_pages();
>         nr_stored =3D atomic_read(&zswap_nr_stored);
>  #endif
>
> @@ -1385,6 +1365,10 @@ static void shrink_worker(struct work_struct *w)
>  {
>         struct mem_cgroup *memcg;
>         int ret, failures =3D 0;
> +       unsigned long thr;
> +
> +       /* Reclaim down to the accept threshold */
> +       thr =3D zswap_max_pages() * zswap_accept_thr_percent / 100;
>
>         /* global reclaim will select cgroup in a round-robin fashion. */
>         do {
> @@ -1432,10 +1416,9 @@ static void shrink_worker(struct work_struct *w)
>                         break;
>                 if (ret && ++failures =3D=3D MAX_RECLAIM_RETRIES)
>                         break;
> -
>  resched:
>                 cond_resched();
> -       } while (!zswap_can_accept());
> +       } while (zswap_total_pages() > thr);
>  }
>
>  static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
> @@ -1476,6 +1459,7 @@ bool zswap_store(struct folio *folio)
>         struct zswap_entry *entry, *dupentry;
>         struct obj_cgroup *objcg =3D NULL;
>         struct mem_cgroup *memcg =3D NULL;
> +       unsigned long max_pages, cur_pages;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1487,6 +1471,7 @@ bool zswap_store(struct folio *folio)
>         if (!zswap_enabled)
>                 goto check_old;
>
> +       /* Check cgroup limits */
>         objcg =3D get_obj_cgroup_from_folio(folio);
>         if (objcg && !obj_cgroup_may_zswap(objcg)) {
>                 memcg =3D get_mem_cgroup_from_objcg(objcg);
> @@ -1497,15 +1482,20 @@ bool zswap_store(struct folio *folio)
>                 mem_cgroup_put(memcg);
>         }
>
> -       /* reclaim space if needed */
> -       if (zswap_is_full()) {
> +       /* Check global limits */
> +       cur_pages =3D zswap_total_pages();
> +       max_pages =3D zswap_max_pages();
> +
> +       if (cur_pages >=3D max_pages) {
>                 zswap_pool_limit_hit++;
>                 zswap_pool_reached_full =3D true;
>                 goto shrink;
>         }
>
>         if (zswap_pool_reached_full) {
> -              if (!zswap_can_accept())
> +               unsigned long thr =3D max_pages * zswap_accept_thr_percen=
t / 100;
> +
> +               if (cur_pages > thr)
>                         goto shrink;
>                 else
>                         zswap_pool_reached_full =3D false;
> @@ -1581,7 +1571,6 @@ bool zswap_store(struct folio *folio)
>
>         /* update stats */
>         atomic_inc(&zswap_stored_pages);
> -       zswap_update_total_size();
>         count_vm_event(ZSWPOUT);
>
>         return true;
> @@ -1711,6 +1700,13 @@ void zswap_swapoff(int type)
>
>  static struct dentry *zswap_debugfs_root;
>
> +static int debugfs_get_total_size(void *data, u64 *val)
> +{
> +       *val =3D zswap_total_pages() * PAGE_SIZE;
> +       return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(total_size_fops, debugfs_get_total_size, NULL, =
"%llu");
> +
>  static int zswap_debugfs_init(void)
>  {
>         if (!debugfs_initialized())
> @@ -1732,8 +1728,8 @@ static int zswap_debugfs_init(void)
>                            zswap_debugfs_root, &zswap_reject_compress_poo=
r);
>         debugfs_create_u64("written_back_pages", 0444,
>                            zswap_debugfs_root, &zswap_written_back_pages)=
;
> -       debugfs_create_u64("pool_total_size", 0444,
> -                          zswap_debugfs_root, &zswap_pool_total_size);
> +       debugfs_create_file("pool_total_size", 0444,
> +                           zswap_debugfs_root, NULL, &total_size_fops);
>         debugfs_create_atomic_t("stored_pages", 0444,
>                                 zswap_debugfs_root, &zswap_stored_pages);
>         debugfs_create_atomic_t("same_filled_pages", 0444,
> --
> 2.44.0
>

