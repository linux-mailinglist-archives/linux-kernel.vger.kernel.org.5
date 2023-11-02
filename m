Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5796A7DFB85
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbjKBU2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjKBU2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:28:08 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B06F186
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 13:28:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9c2a0725825so213644066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 13:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698956883; x=1699561683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2tG9+LYPAjXHoqgeXN+dTD/rVonlm13np1kfFquZ3k=;
        b=bkICOSDb4F3r1IdawU1vbqh3ShUXONlR244zHp8BFYBLeG1pJsQOcnMpQfB5YLyLGx
         T7NciSjfvdyGZbuZoYoUIAirrtivb8s0cvX/MbvXggkQIVP5PAqpAwIDp3IqgbgpDycz
         SUtXXHC6DMEEWrB30PYEx+3/9IDFsP/ZJsrVG0fcXNzGnzQnlea0CmiiEdicu+Y09LDL
         3mswKjHPLwUzfhHFQacmQOJjGpKe+28JjyNrM3DKMqqvG0OYmDInnv3pous76ApNiwHc
         KNyJNbib0iNHK42gWkP0OHwAju6Y8grux34N8sbfA9IXx1yxoTdF8grwj6hirqht4GIs
         kT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698956883; x=1699561683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2tG9+LYPAjXHoqgeXN+dTD/rVonlm13np1kfFquZ3k=;
        b=lUM+1+/4TNem3NujOIzyR+ZbBXvsRzfs+XOpgN/OqWhbPmDMksBAssVe55BwLBMHaf
         WUe9ysLpGtZV8l5KFo1J8GJG8hqdviV1YibJF2yk5gWdMGAmaZpNBFjGGQn5Ln7b5WOD
         JalTrWwjw/U0/51CgCw9GWZ3qpbbez2ood6gzcgq9VJ/dbZgYgzJ3gzKkeIAkXXV978P
         9C4B0ityJg0RdxLvspzkrFCTqRbjcvwH3JVacVRRea/2YId4DgNFvG8E/VDwpEZberWm
         Zq6InDYOxwIxvI/6Bv1Kni+fiDEE5EVGJC1jDTL++ZEtwN78KrOxuo83oT6ogexsZbES
         eDQQ==
X-Gm-Message-State: AOJu0YxIMv8nmAspG8NcPCoPvoqd6PN57Q+HG3wcmrdkcmQjBqGoSOCn
        vfFy6OoTUacY5A7pgyXvrSw5KW0Yi/BLbfudNuY0jw==
X-Google-Smtp-Source: AGHT+IGopUO2TFYjW2zMpI8RZLl67y2PbZV0MEimJN6sYLHh5XVKfwjFtdjxfx/e9iEddzJSgGQc6t30fNaR9NI4vvA=
X-Received: by 2002:a17:907:3c22:b0:9dc:2281:2f0a with SMTP id
 gh34-20020a1709073c2200b009dc22812f0amr1266432ejc.50.1698956882559; Thu, 02
 Nov 2023 13:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231102200202.920461-1-nphamcs@gmail.com>
In-Reply-To: <20231102200202.920461-1-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 2 Nov 2023 13:27:24 -0700
Message-ID: <CAJD7tkY8iPBo99+1gdsSRMNDu4jkVKz8rb=W+xk9=GE0y=kSuw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] zswap: memcontrol: implement zswap writeback disabling
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 1:02=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> During our experiment with zswap, we sometimes observe swap IOs due to
> occasional zswap store failures and writebacks-to-swap. These swapping
> IOs prevent many users who cannot tolerate swapping from adopting zswap
> to save memory and improve performance where possible.
>
> This patch adds the option to disable this behavior entirely: do not
> writeback to backing swapping device when a zswap store attempt fail,
> and do not write pages in the zswap pool back to the backing swap
> device (both when the pool is full, and when the new zswap shrinker is
> called).
>
> This new behavior can be opted-in/out on a per-cgroup basis via a new
> cgroup file. By default, writebacks to swap device is enabled, which is
> the previous behavior.
>
> Note that this is subtly different from setting memory.swap.max to 0, as
> it still allows for pages to be stored in the zswap pool (which itself
> consumes swap space in its current form).
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 11 +++++++
>  Documentation/admin-guide/mm/zswap.rst  |  6 ++++
>  include/linux/memcontrol.h              | 17 +++++++++++
>  mm/memcontrol.c                         | 38 +++++++++++++++++++++++++
>  mm/page_io.c                            |  6 ++++
>  mm/shmem.c                              |  3 +-
>  mm/zswap.c                              |  9 ++++++
>  7 files changed, 88 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 606b2e0eac4b..18c4171392ea 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1672,6 +1672,17 @@ PAGE_SIZE multiple when read back.
>         limit, it will refuse to take any more stores before existing
>         entries fault back in or are written out to disk.
>
> +  memory.zswap.writeback
> +       A read-write single value file which exists on non-root
> +       cgroups.  The default value is "1".
> +
> +       When this is set to 0, all swapping attempts to swapping devices
> +       are disabled. This included both zswap writebacks, and swapping d=
ue
> +       to zswap store failure.
> +
> +       Note that this is subtly different from setting memory.swap.max t=
o
> +       0, as it still allows for pages to be written to the zswap pool.
> +
>    memory.pressure
>         A read-only nested-keyed file.
>
> diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin=
-guide/mm/zswap.rst
> index 522ae22ccb84..b987e58edb70 100644
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -153,6 +153,12 @@ attribute, e. g.::
>
>  Setting this parameter to 100 will disable the hysteresis.
>
> +Some users cannot tolerate the swapping that comes with zswap store fail=
ures
> +and zswap writebacks. Swapping can be disabled entirely (without disabli=
ng
> +zswap itself) on a cgroup-basis as follows:
> +
> +       echo 0 > /sys/fs/cgroup/<cgroup-name>/memory.zswap.writeback
> +
>  When there is a sizable amount of cold memory residing in the zswap pool=
, it
>  can be advantageous to proactively write these cold pages to swap and re=
claim
>  the memory for other use cases. By default, the zswap shrinker is disabl=
ed.
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 95f6c9e60ed1..e3a3a06727dc 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -219,6 +219,12 @@ struct mem_cgroup {
>
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>         unsigned long zswap_max;
> +
> +       /*
> +        * Prevent pages from this memcg from being written back from zsw=
ap to
> +        * swap, and from being swapped out on zswap store failures.
> +        */
> +       bool zswap_writeback;
>  #endif
>
>         unsigned long soft_limit;
> @@ -1615,6 +1621,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_dat=
a_t *pgdat, int order,
>  {
>         return 0;
>  }
> +
> +static inline bool mem_cgroup_swap_disk_enabled(struct mem_cgroup *memcg=
)
> +{
> +       return false;
> +}
> +

This seems to be a leftover from a prior version.

>  #endif /* CONFIG_MEMCG */
>
>  static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item =
idx)
> @@ -1931,6 +1943,7 @@ static inline void count_objcg_event(struct obj_cgr=
oup *objcg,
>  bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
>  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
>  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
> +bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg);
>  #else
>  static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>  {
> @@ -1944,6 +1957,10 @@ static inline void obj_cgroup_uncharge_zswap(struc=
t obj_cgroup *objcg,
>                                              size_t size)
>  {
>  }
> +static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup =
*memcg)
> +{
> +       return false;
> +}
>  #endif
>
>  #endif /* _LINUX_MEMCONTROL_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e43b5aba8efc..b68c613c23a9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5545,6 +5545,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *pa=
rent_css)
>         WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>         memcg->zswap_max =3D PAGE_COUNTER_MAX;
> +       WRITE_ONCE(memcg->zswap_writeback, true);
>  #endif
>         page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
>         if (parent) {
> @@ -8177,6 +8178,12 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *=
objcg, size_t size)
>         rcu_read_unlock();
>  }
>
> +bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
> +{
> +       return cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg
> +                       && READ_ONCE(memcg->zswap_writeback);
> +}
> +
>  static u64 zswap_current_read(struct cgroup_subsys_state *css,
>                               struct cftype *cft)
>  {
> @@ -8209,6 +8216,31 @@ static ssize_t zswap_max_write(struct kernfs_open_=
file *of,
>         return nbytes;
>  }
>
> +static int zswap_writeback_show(struct seq_file *m, void *v)
> +{
> +       struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> +
> +       seq_printf(m, "%d\n", READ_ONCE(memcg->zswap_writeback));
> +       return 0;
> +}
> +
> +static ssize_t zswap_writeback_write(struct kernfs_open_file *of,
> +                               char *buf, size_t nbytes, loff_t off)
> +{
> +       struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
> +       int zswap_writeback;
> +       ssize_t parse_ret =3D kstrtoint(strstrip(buf), 0, &zswap_writebac=
k);
> +
> +       if (parse_ret)
> +               return parse_ret;
> +
> +       if (zswap_writeback !=3D 0 && zswap_writeback !=3D 1)
> +               return -EINVAL;
> +
> +       WRITE_ONCE(memcg->zswap_writeback, zswap_writeback);
> +       return nbytes;
> +}
> +
>  static struct cftype zswap_files[] =3D {
>         {
>                 .name =3D "zswap.current",
> @@ -8221,6 +8253,12 @@ static struct cftype zswap_files[] =3D {
>                 .seq_show =3D zswap_max_show,
>                 .write =3D zswap_max_write,
>         },
> +       {
> +               .name =3D "zswap.writeback",
> +               .flags =3D CFTYPE_NOT_ON_ROOT,
> +               .seq_show =3D zswap_writeback_show,
> +               .write =3D zswap_writeback_write,
> +       },
>         { }     /* terminate */
>  };
>  #endif /* CONFIG_MEMCG_KMEM && CONFIG_ZSWAP */
> diff --git a/mm/page_io.c b/mm/page_io.c
> index cb559ae324c6..5e606f1aa2f6 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -201,6 +201,12 @@ int swap_writepage(struct page *page, struct writeba=
ck_control *wbc)
>                 folio_end_writeback(folio);
>                 return 0;
>         }
> +
> +       if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio))) {
> +               folio_mark_dirty(folio);
> +               return AOP_WRITEPAGE_ACTIVATE;
> +       }
> +

I am not a fan of this, because it will disable using disk swap if
"zswap_writeback" is disabled, even if zswap is disabled or the page
was never in zswap. The term zswap_writeback makes no sense here tbh.

I am still hoping someone else will suggest better semantics, because
honestly I can't think of anything. Perhaps something like
memory.swap.zswap_only or memory.swap.types which accepts a string
(e.g. "zswap"/"all",..).

Don't take my suggestions strongly because I am not very fond of them.

Can anyone else come back with better naming/semantics for "use zswap
but nothing else when swapping"?

>         __swap_writepage(&folio->page, wbc);
>         return 0;
>  }
> diff --git a/mm/shmem.c b/mm/shmem.c
> index cab053831fea..e5044678de8b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1514,8 +1514,7 @@ static int shmem_writepage(struct page *page, struc=
t writeback_control *wbc)
>
>                 mutex_unlock(&shmem_swaplist_mutex);
>                 BUG_ON(folio_mapped(folio));
> -               swap_writepage(&folio->page, wbc);
> -               return 0;
> +               return swap_writepage(&folio->page, wbc);
>         }
>
>         mutex_unlock(&shmem_swaplist_mutex);
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 260e01180ee0..42a478d1a21f 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -590,6 +590,9 @@ static unsigned long zswap_shrinker_scan(struct shrin=
ker *shrinker,
>         struct zswap_pool *pool =3D shrinker->private_data;
>         bool encountered_page_in_swapcache =3D false;
>
> +       if (!mem_cgroup_zswap_writeback_enabled(sc->memcg))
> +               return SHRINK_STOP;
> +
>         nr_protected =3D
>                 atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_pro=
tected);
>         lru_size =3D list_lru_shrink_count(&pool->list_lru, sc);
> @@ -620,6 +623,9 @@ static unsigned long zswap_shrinker_count(struct shri=
nker *shrinker,
>         struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(sc->=
nid));
>         unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
>
> +       if (!mem_cgroup_zswap_writeback_enabled(memcg))
> +               return 0;
> +
>  #ifdef CONFIG_MEMCG_KMEM
>         cgroup_rstat_flush(memcg->css.cgroup);
>         nr_backing =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHI=
FT;
> @@ -935,6 +941,9 @@ static int shrink_memcg(struct mem_cgroup *memcg)
>         struct zswap_pool *pool;
>         int nid, shrunk =3D 0;
>
> +       if (!mem_cgroup_zswap_writeback_enabled(memcg))
> +               return -EINVAL;
> +
>         /*
>          * Skip zombies because their LRUs are reparented and we would be
>          * reclaiming from the parent instead of the dead memcg.
> --
> 2.34.1
