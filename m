Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDB9809710
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444138AbjLHATz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLHATw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:19:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65509C6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:19:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E968EC433C8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701994798;
        bh=mDwxbPBb1A5AYZHcCsx/GV3t7KzcIQ+T/wJuXDoRX4w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aQk3jSp5JkmAdvCUyKGsQUWCTdIgctWfiJ4IaebDZsIzvR+ev9P2cf+GUdV2RZiS6
         er1Klzcfn7xucBwwTFJiDamsloeCsuuLar4Ib+s+byvzKKwJS2gjR18uhPTkO7sj2n
         rWHuQx1yQLJfBbCl91qs8FCbW/V4vqlRAe+xWyvms7inpzp1IsDveoqqaisG/OOHPt
         IjPlTfwFccKQ/5TmvaZWt41eq1cS9oiE5Uf/8fptoBv8W3parkOqsJ4xyB9YWUXvQU
         +RRTKO+2nO+uGzJszYs72xAvftyL9NUyc8sYgUt3+Jq3iTHtNyhwm2UqW0etoUpwp2
         HTHLjreDo2vDQ==
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-679dd3055faso9103856d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:19:57 -0800 (PST)
X-Gm-Message-State: AOJu0YwjpzwuxiZm1K5y4yFTQlbQADrPD1cwoiW7Eb3bcUnkj5aKPfSn
        QYk3RiOMS2fuFM896gltVi68bqj0RO9LNqnhW+DwPA==
X-Google-Smtp-Source: AGHT+IHH8qUzAYmZPIqWzQmA5CT/QTGVkxl12ScCXZvPymESIzGdG+x2E7gfCbehuq7nxkvRQnm/B7h88Z2nEtK/96M=
X-Received: by 2002:a05:6a20:5603:b0:18c:4f:ce9e with SMTP id
 ir3-20020a056a20560300b0018c004fce9emr3737185pzc.43.1701994776637; Thu, 07
 Dec 2023 16:19:36 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com>
In-Reply-To: <20231207192406.3809579-1-nphamcs@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Thu, 7 Dec 2023 16:19:25 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
Message-ID: <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat,


On Thu, Dec 7, 2023 at 11:24=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
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
> the previous behavior. Initially, writeback is enabled for the root
> cgroup, and a newly created cgroup will inherit the current setting of
> its parent.
>
> Note that this is subtly different from setting memory.swap.max to 0, as
> it still allows for pages to be stored in the zswap pool (which itself
> consumes swap space in its current form).
>
> This patch should be applied on top of the zswap shrinker series:
>
> https://lore.kernel.org/linux-mm/20231130194023.4102148-1-nphamcs@gmail.c=
om/
>
> as it also disables the zswap shrinker, a major source of zswap
> writebacks.

I am wondering about the status of "memory.swap.tiers" proof of concept pat=
ch?
Are we still on board to have this two patch merge together somehow so
we can have
"memory.swap.tiers" =3D=3D "all" and "memory.swap.tiers" =3D=3D "zswap" cov=
er the
memory.zswap.writeback =3D=3D 1 and memory.zswap.writeback =3D=3D 0 case?

Thanks

Chris

>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 12 ++++++++
>  Documentation/admin-guide/mm/zswap.rst  |  6 ++++
>  include/linux/memcontrol.h              | 12 ++++++++
>  include/linux/zswap.h                   |  6 ++++
>  mm/memcontrol.c                         | 38 +++++++++++++++++++++++++
>  mm/page_io.c                            |  6 ++++
>  mm/shmem.c                              |  3 +-
>  mm/zswap.c                              | 13 +++++++--
>  8 files changed, 92 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 3f85254f3cef..2b4ac43efdc8 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1679,6 +1679,18 @@ PAGE_SIZE multiple when read back.
>         limit, it will refuse to take any more stores before existing
>         entries fault back in or are written out to disk.
>
> +  memory.zswap.writeback
> +       A read-write single value file. The default value is "1". The
> +       initial value of the root cgroup is 1, and when a new cgroup is
> +       created, it inherits the current value of its parent.
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
> index 62fc244ec702..cfa653130346 100644
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
> index 43b77363ab8e..5de775e6cdd9 100644
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
> @@ -1941,6 +1947,7 @@ static inline void count_objcg_event(struct obj_cgr=
oup *objcg,
>  bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
>  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
>  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
> +bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg);
>  #else
>  static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>  {
> @@ -1954,6 +1961,11 @@ static inline void obj_cgroup_uncharge_zswap(struc=
t obj_cgroup *objcg,
>                                              size_t size)
>  {
>  }
> +static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup =
*memcg)
> +{
> +       /* if zswap is disabled, do not block pages going to the swapping=
 device */
> +       return true;
> +}
>  #endif
>
>  #endif /* _LINUX_MEMCONTROL_H */
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 08c240e16a01..a78ceaf3a65e 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -35,6 +35,7 @@ void zswap_swapoff(int type);
>  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
>  void zswap_lruvec_state_init(struct lruvec *lruvec);
>  void zswap_page_swapin(struct page *page);
> +bool is_zswap_enabled(void);
>  #else
>
>  struct zswap_lruvec_state {};
> @@ -55,6 +56,11 @@ static inline void zswap_swapoff(int type) {}
>  static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)=
 {}
>  static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
>  static inline void zswap_page_swapin(struct page *page) {}
> +
> +static inline bool is_zswap_enabled(void)
> +{
> +       return false;
> +}
>  #endif
>
>  #endif /* _LINUX_ZSWAP_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d7bc47316acb..ae8c62c7aa53 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5538,6 +5538,8 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *pa=
rent_css)
>         WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>         memcg->zswap_max =3D PAGE_COUNTER_MAX;
> +       WRITE_ONCE(memcg->zswap_writeback,
> +               !parent || READ_ONCE(parent->zswap_writeback));
>  #endif
>         page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
>         if (parent) {
> @@ -8174,6 +8176,12 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *=
objcg, size_t size)
>         rcu_read_unlock();
>  }
>
> +bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
> +{
> +       /* if zswap is disabled, do not block pages going to the swapping=
 device */
> +       return !is_zswap_enabled() || !memcg || READ_ONCE(memcg->zswap_wr=
iteback);
> +}
> +
>  static u64 zswap_current_read(struct cgroup_subsys_state *css,
>                               struct cftype *cft)
>  {
> @@ -8206,6 +8214,31 @@ static ssize_t zswap_max_write(struct kernfs_open_=
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
> @@ -8218,6 +8251,11 @@ static struct cftype zswap_files[] =3D {
>                 .seq_show =3D zswap_max_show,
>                 .write =3D zswap_max_write,
>         },
> +       {
> +               .name =3D "zswap.writeback",
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
>         __swap_writepage(&folio->page, wbc);
>         return 0;
>  }
> diff --git a/mm/shmem.c b/mm/shmem.c
> index c62f904ba1ca..dd084fbafcf1 100644
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
> index daaa949837f2..7ee54a3d8281 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -153,6 +153,11 @@ static bool zswap_shrinker_enabled =3D IS_ENABLED(
>                 CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
>  module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644)=
;
>
> +bool is_zswap_enabled(void)
> +{
> +       return zswap_enabled;
> +}
> +
>  /*********************************
>  * data structures
>  **********************************/
> @@ -596,7 +601,8 @@ static unsigned long zswap_shrinker_scan(struct shrin=
ker *shrinker,
>         struct zswap_pool *pool =3D shrinker->private_data;
>         bool encountered_page_in_swapcache =3D false;
>
> -       if (!zswap_shrinker_enabled) {
> +       if (!zswap_shrinker_enabled ||
> +                       !mem_cgroup_zswap_writeback_enabled(sc->memcg)) {
>                 sc->nr_scanned =3D 0;
>                 return SHRINK_STOP;
>         }
> @@ -637,7 +643,7 @@ static unsigned long zswap_shrinker_count(struct shri=
nker *shrinker,
>         struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(sc->=
nid));
>         unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
>
> -       if (!zswap_shrinker_enabled)
> +       if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enable=
d(memcg))
>                 return 0;
>
>  #ifdef CONFIG_MEMCG_KMEM
> @@ -956,6 +962,9 @@ static int shrink_memcg(struct mem_cgroup *memcg)
>         struct zswap_pool *pool;
>         int nid, shrunk =3D 0;
>
> +       if (!mem_cgroup_zswap_writeback_enabled(memcg))
> +               return -EINVAL;
> +
>         /*
>          * Skip zombies because their LRUs are reparented and we would be
>          * reclaiming from the parent instead of the dead memcg.
>
> base-commit: cdcab2d34f129f593c0afbb2493bcaf41f4acd61
> --
> 2.34.1
>
