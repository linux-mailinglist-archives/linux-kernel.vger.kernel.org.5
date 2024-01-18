Return-Path: <linux-kernel+bounces-30514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5656831FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFDA288222
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E7034189;
	Thu, 18 Jan 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCyR5N6E"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0B33CFA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605860; cv=none; b=BpbfsWVgfo/EdboAEvfqQUJ0uMtU+nAF1KpRx81d1R1lm0lfOhcEcJEhSHct9feSG5O++Xs8jv0R2KT3+hwkPEPMa77rBdGA413PB998blezfkGHTEceburXsk0/f9Eh89+alJpLYLGhjLgOO96KRAAl38u7Ei/KJCmF+pO9YMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605860; c=relaxed/simple;
	bh=kGTcE/VD9F5fqDDyS/9I9OZH7+FGrq5w7NCctLFHJwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXKCpCZt7QdvLAJnpBygz0BFNIsHhOY531I94/hZh+UrMRi7wnbOydkUMSVhRijajuNrRs7ND1d/aqGfu95kjSyArEvQuT8Kc4K8bwbJQp3zkA1tCvbIvjhDs1NVCAOYr7asRwhH+wbHGJbZVAtGOJFYBLOOiEh+lWCpYuq5e+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCyR5N6E; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3606c7a4cb5so79922175ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705605858; x=1706210658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGnQuehifPHb2LKeOYCksa1eWT403+1V1IHhSeK8jRc=;
        b=WCyR5N6EPGFY94aPBT87w3JFnIgfV2XsqG+x3Q04Sk5w6BRkcskaF5kRnicQP54T5O
         D0cn3xsi04C78W4py5dve1Dki9s+ZwJmvPjqr1U8IV02ApaQqP26p5MCsFV5XoAnnctU
         WRjJoCp9NlXg6h0bCgMt9gFFNaL4iZXptaFKH4fOPAIgEPt5gVGFWPhlRATF+I2jj5Tz
         +1szf5anqosw+9zcLOmiCGPgaDr6dKzu5zSUWhw1jyOREdT9bb1tndMZ7VmmlvClYzIr
         AtGqZzbJu2vfhaVkwwuYgVK4HA2r3pZo4eVNk8CibQGF+av14sHWC7kghK/JYXOyHvks
         sdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705605858; x=1706210658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGnQuehifPHb2LKeOYCksa1eWT403+1V1IHhSeK8jRc=;
        b=dkB5C3OTdxs6H3a8ht1nDeAnKtNGVQxW/FFxFbnJ+gQPrBBKQOWkPC7UAqMEc12Whd
         DR7Fu7ki0TldeGHAMP4BcNVrnnaYHSMFc0wby9QAwzwZ5qwHvEAy6OTIUpaKj5WgO3Zz
         yr3qCGCo37jW4XtSmvWWLZ1M8N2xcYGZX/66Lr5Y8+40jzWOtp0xhSTshg4vnxrT9PGx
         /AlTw3dMzsRdKYQm29CKdx6i6838d4XqT8C1c3n2dU9wVuYQDj0fFJBmHkR+7P1IJhNd
         9GCqIlaiAyo5z5ixYCwqtDLq2IjoasRz5TVW7fldp8hDvEgzjTa+/SV7uHZM5+2C08dY
         +bFA==
X-Gm-Message-State: AOJu0YzGV1+c5MHZRUDZlCr7ziw7V4vFfLp3rrhiPxZ3fgrpVGLPzp/g
	zl8rPw3suqL/XC8AJnKfk7GYxOmSzkbumi0Hw53bfGLpQmcSyR3ap8H7WfDrPNkc2qWnhhMkvmE
	Se1BvbDZ7fruX3Gu/RDv878jKx9M=
X-Google-Smtp-Source: AGHT+IGU4y5prybpkx5WNPp8q91ym/jzy2NlQw2CMtbrrdJoLmdVJpfqwLb8p74VO9DCq4uhLYc9qFH03zzvSFR8sjM=
X-Received: by 2002:a92:d143:0:b0:35f:aba9:1031 with SMTP id
 t3-20020a92d143000000b0035faba91031mr1453854ilg.126.1705605857922; Thu, 18
 Jan 2024 11:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com> <20240117-b4-zswap-lock-optimize-v1-2-23f6effe5775@bytedance.com>
In-Reply-To: <20240117-b4-zswap-lock-optimize-v1-2-23f6effe5775@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 18 Jan 2024 11:24:06 -0800
Message-ID: <CAKEwX=Op6XTawUZg-4pDM70z4kB4-5Wo6Ss+ptyzkd+Ub3PDEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/zswap: split zswap rb-tree
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	Chris Li <chriscli@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 1:23=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Each swapfile has one rb-tree to search the mapping of swp_entry_t to
> zswap_entry, that use a spinlock to protect, which can cause heavy lock
> contention if multiple tasks zswap_store/load concurrently.
>
> Optimize the scalability problem by splitting the zswap rb-tree into
> multiple rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M),
> just like we did in the swap cache address_space splitting.
>
> Although this method can't solve the spinlock contention completely, it
> can mitigate much of that contention. Below is the results of kernel buil=
d
> in tmpfs with zswap shrinker enabled:
>
>      linux-next  zswap-lock-optimize
> real 1m9.181s    1m3.820s
> user 17m44.036s  17m40.100s
> sys  7m37.297s   4m54.622s

That's really impressive, especially the sys time reduction :) Well done.

>
> So there are clearly improvements.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Code looks solid too. I haven't read the xarray patch series too
closely yet, but this patch series is clearly already an improvement.
It is simple, with existing precedent (from swap cache), and
experiments show that it works quite well to improve zswap's
performance.

If the xarray patch proves to be even better, we can always combine it
with this approach (a per-range xarray?), or replace it with the
xarray. But for now:

Acked-by: Nhat Pham <nphamcs@gmail.com>

> ---
>  include/linux/zswap.h |  4 +--
>  mm/swapfile.c         |  2 +-
>  mm/zswap.c            | 69 ++++++++++++++++++++++++++++++++-------------=
------
>  3 files changed, 47 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index eca388229d9a..91895ce1fdbc 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -30,7 +30,7 @@ struct zswap_lruvec_state {
>  bool zswap_store(struct folio *folio);
>  bool zswap_load(struct folio *folio);
>  void zswap_invalidate(int type, pgoff_t offset);
> -int zswap_swapon(int type);
> +int zswap_swapon(int type, unsigned long nr_pages);
>  void zswap_swapoff(int type);
>  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
>  void zswap_lruvec_state_init(struct lruvec *lruvec);
> @@ -51,7 +51,7 @@ static inline bool zswap_load(struct folio *folio)
>  }
>
>  static inline void zswap_invalidate(int type, pgoff_t offset) {}
> -static inline int zswap_swapon(int type)
> +static inline int zswap_swapon(int type, unsigned long nr_pages)
>  {
>         return 0;
>  }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 6c53ea06626b..35aa17b2a2fa 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3164,7 +3164,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specia=
lfile, int, swap_flags)
>         if (error)
>                 goto bad_swap_unlock_inode;
>
> -       error =3D zswap_swapon(p->type);
> +       error =3D zswap_swapon(p->type, maxpages);
>         if (error)
>                 goto free_swap_address_space;
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index d88faea85978..4a6dbc620c7c 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -239,6 +239,7 @@ struct zswap_tree {
>  };
>
>  static struct zswap_tree *zswap_trees[MAX_SWAPFILES];
> +static unsigned int nr_zswap_trees[MAX_SWAPFILES];
>
>  /* RCU-protected iteration */
>  static LIST_HEAD(zswap_pools);
> @@ -265,6 +266,10 @@ static bool zswap_has_pool;
>  * helpers and fwd declarations
>  **********************************/
>
> +#define swap_zswap_tree(entry)                                 \
> +       (&zswap_trees[swp_type(entry)][swp_offset(entry)        \
> +               >> SWAP_ADDRESS_SPACE_SHIFT])
> +
>  #define zswap_pool_debug(msg, p)                               \
>         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
>                  zpool_get_type((p)->zpools[0]))
> @@ -865,7 +870,7 @@ static enum lru_status shrink_memcg_cb(struct list_he=
ad *item, struct list_lru_o
>          * until the entry is verified to still be alive in the tree.
>          */
>         swpoffset =3D swp_offset(entry->swpentry);
> -       tree =3D zswap_trees[swp_type(entry->swpentry)];
> +       tree =3D swap_zswap_tree(entry->swpentry);
>         list_lru_isolate(l, item);
>         /*
>          * It's safe to drop the lock here because we return either
> @@ -1494,10 +1499,9 @@ static void zswap_fill_page(void *ptr, unsigned lo=
ng value)
>  bool zswap_store(struct folio *folio)
>  {
>         swp_entry_t swp =3D folio->swap;
> -       int type =3D swp_type(swp);
>         pgoff_t offset =3D swp_offset(swp);
>         struct page *page =3D &folio->page;
> -       struct zswap_tree *tree =3D zswap_trees[type];
> +       struct zswap_tree *tree =3D swap_zswap_tree(swp);
>         struct zswap_entry *entry, *dupentry;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
> @@ -1569,7 +1573,7 @@ bool zswap_store(struct folio *folio)
>                 src =3D kmap_local_page(page);
>                 if (zswap_is_page_same_filled(src, &value)) {
>                         kunmap_local(src);
> -                       entry->swpentry =3D swp_entry(type, offset);
> +                       entry->swpentry =3D swp;
>                         entry->length =3D 0;
>                         entry->value =3D value;
>                         atomic_inc(&zswap_same_filled_pages);
> @@ -1651,7 +1655,7 @@ bool zswap_store(struct folio *folio)
>         mutex_unlock(&acomp_ctx->mutex);
>
>         /* populate entry */
> -       entry->swpentry =3D swp_entry(type, offset);
> +       entry->swpentry =3D swp;
>         entry->handle =3D handle;
>         entry->length =3D dlen;
>
> @@ -1711,10 +1715,9 @@ bool zswap_store(struct folio *folio)
>  bool zswap_load(struct folio *folio)
>  {
>         swp_entry_t swp =3D folio->swap;
> -       int type =3D swp_type(swp);
>         pgoff_t offset =3D swp_offset(swp);
>         struct page *page =3D &folio->page;
> -       struct zswap_tree *tree =3D zswap_trees[type];
> +       struct zswap_tree *tree =3D swap_zswap_tree(swp);
>         struct zswap_entry *entry;
>         u8 *dst;
>
> @@ -1757,7 +1760,7 @@ bool zswap_load(struct folio *folio)
>
>  void zswap_invalidate(int type, pgoff_t offset)
>  {
> -       struct zswap_tree *tree =3D zswap_trees[type];
> +       struct zswap_tree *tree =3D swap_zswap_tree(swp_entry(type, offse=
t));
>         struct zswap_entry *entry;
>
>         /* find */
> @@ -1772,37 +1775,53 @@ void zswap_invalidate(int type, pgoff_t offset)
>         spin_unlock(&tree->lock);
>  }
>
> -int zswap_swapon(int type)
> +int zswap_swapon(int type, unsigned long nr_pages)
>  {
> -       struct zswap_tree *tree;
> +       struct zswap_tree *trees, *tree;
> +       unsigned int nr, i;
>
> -       tree =3D kzalloc(sizeof(*tree), GFP_KERNEL);
> -       if (!tree) {
> +       nr =3D DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
> +       trees =3D kvcalloc(nr, sizeof(*tree), GFP_KERNEL);
> +       if (!trees) {
>                 pr_err("alloc failed, zswap disabled for swap type %d\n",=
 type);
>                 return -ENOMEM;
>         }
>
> -       tree->rbroot =3D RB_ROOT;
> -       spin_lock_init(&tree->lock);
> -       zswap_trees[type] =3D tree;
> +       for (i =3D 0; i < nr; i++) {
> +               tree =3D trees + i;
> +               tree->rbroot =3D RB_ROOT;
> +               spin_lock_init(&tree->lock);
> +       }
> +
> +       nr_zswap_trees[type] =3D nr;
> +       zswap_trees[type] =3D trees;
>         return 0;
>  }
>
>  void zswap_swapoff(int type)
>  {
> -       struct zswap_tree *tree =3D zswap_trees[type];
> -       struct zswap_entry *entry, *n;
> +       struct zswap_tree *trees =3D zswap_trees[type];
> +       unsigned int i;
>
> -       if (!tree)
> +       if (!trees)
>                 return;
>
> -       /* walk the tree and free everything */
> -       spin_lock(&tree->lock);
> -       rbtree_postorder_for_each_entry_safe(entry, n, &tree->rbroot, rbn=
ode)
> -               zswap_free_entry(entry);
> -       tree->rbroot =3D RB_ROOT;
> -       spin_unlock(&tree->lock);
> -       kfree(tree);
> +       for (i =3D 0; i < nr_zswap_trees[type]; i++) {
> +               struct zswap_tree *tree =3D trees + i;
> +               struct zswap_entry *entry, *n;
> +
> +               /* walk the tree and free everything */
> +               spin_lock(&tree->lock);
> +               rbtree_postorder_for_each_entry_safe(entry, n,
> +                                                    &tree->rbroot,
> +                                                    rbnode)
> +                       zswap_free_entry(entry);
> +               tree->rbroot =3D RB_ROOT;
> +               spin_unlock(&tree->lock);
> +       }
> +
> +       kvfree(trees);
> +       nr_zswap_trees[type] =3D 0;
>         zswap_trees[type] =3D NULL;
>  }
>
>
> --
> b4 0.10.1

