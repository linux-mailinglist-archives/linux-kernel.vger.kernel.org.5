Return-Path: <linux-kernel+bounces-94744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6868744A6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DFD1F29D2B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11801CA82;
	Wed,  6 Mar 2024 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUitR6c8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6311C686
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768652; cv=none; b=cwCF19gUGdnetKs5pKPO7iii2WEx5wcYX2OQtWpxzrVCmJxToJDHKCTfOn3z2XJRyAf6AkJO5yAQWzwg5G57649v3HC2xQaSt5iK63ieF5GWQUdSgrgLXuCQIauNBTcz0t4CqzE4YMTGNp7yscM1ix7m7ispb3fMvhakdRwDycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768652; c=relaxed/simple;
	bh=g3JrrOGME9ixBFZ3T66+drvrkkMr/ZV3A/YEH6nQZxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqA8g4K9/MT2b0Veh124xQjHmNLgdpCZFWxtUB/wVSxHzovv0UdzNksv+3breEpMIEYJQuGTEwwqjOYUtTjgFQUC37Mp5843Se/eZa0oI1A47blnglfl8s29+7UPN3C1/ekWQ1C6aWBbgAVXjaO27sp238UygBSpC/pU63FhfLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUitR6c8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5B1C433B2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709768652;
	bh=g3JrrOGME9ixBFZ3T66+drvrkkMr/ZV3A/YEH6nQZxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SUitR6c81q2OKvdZWC8zR/M79buNSQT5DEaiZ2fXAI1Kc9XVNEPoHXHe92T3VJoCu
	 K/EaT4vMKZkHMGh8phbP8Df5RzFaBRbt3XSAkl/VDLSTDhWiOz5DNcKhb/s1HOhQsX
	 hPbuocFZPr7WEtsZIBXNl3/P0FD82H1J9fa5GWXfm1Py9/+SOrhuTcOU43KYldg5qL
	 t1U07vpPf2gYm7BlBdQgNAI1IBdONCaLDF8hyZoSKrzuRyCiS/c+9n/QgDNR1L1OVj
	 PqmYIWKIQsO7rGQ1SctTxBMe3FzWNk1Otre8E8QDZCe3TmPvsC6u3b9AiW3MH5Lo0q
	 KXzZ6rJKcxVAw==
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7beda6a274bso13608239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:44:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoB/YAgnwmJ66Cc/qaiQg/w2YX0azz29QLXDbOUNUppzYjP+Y9KFugZ9fJfP1W7JoOSl8NhhPuTfXyFw6UthjJfWPAX+PQcTlrGcWd
X-Gm-Message-State: AOJu0YxsVz7BHAwz7ObZRsHYGgRgSjLjwUR3hPxYLpD3MjJvvoCkJSNP
	5srVzjK6d4+6wpX6GeEW9q9m76L6pafqEVFlSLILNb8nYwduLYLrErnP1GIHB52H9zCwUGlgSu4
	FnTNcPSrpzE/CU95JvGV7ZfvAPUiyaQ6Cmg62
X-Google-Smtp-Source: AGHT+IGX3BoR0iSNT+XCrFsIgRG5CR9Myi64Y7/o12kDwF6T1packA58IKA/2/2ZuT33Z1nnsNHihqpLgEPkFPbboDg=
X-Received: by 2002:a05:6e02:2167:b0:365:fe19:6978 with SMTP id
 s7-20020a056e02216700b00365fe196978mr6792320ilv.16.1709768651071; Wed, 06 Mar
 2024 15:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304-zswap-xarray-v4-1-c4b45670cc30@kernel.org> <05cbfe34-bac1-4c16-92fa-f38b09160458@bytedance.com>
In-Reply-To: <05cbfe34-bac1-4c16-92fa-f38b09160458@bytedance.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 6 Mar 2024 15:43:58 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMAwLcGb_RvPFPhhmidF+qO=5JSyzFXTB7tKFFBHPFbtQ@mail.gmail.com>
Message-ID: <CAF8kJuMAwLcGb_RvPFPhhmidF+qO=5JSyzFXTB7tKFFBHPFbtQ@mail.gmail.com>
Subject: Re: [PATCH v4] zswap: replace RB tree with xarray
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 6:52=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Hi Chris,
>
> On 2024/3/5 05:32, Chris Li wrote:
> > Very deep RB tree requires rebalance at times. That
> > contributes to the zswap fault latencies. Xarray does not
> > need to perform tree rebalance. Replacing RB tree to xarray
> > can have some small performance gain.
> >
> > One small difference is that xarray insert might fail with
> > ENOMEM, while RB tree insert does not allocate additional
> > memory.
> >
> > The zswap_entry size will reduce a bit due to removing the
> > RB node, which has two pointers and a color field. Xarray
> > store the pointer in the xarray tree rather than the
> > zswap_entry. Every entry has one pointer from the xarray
> > tree. Overall, switching to xarray should save some memory,
> > if the swap entries are densely packed.
> >
> > Notice the zswap_rb_search and zswap_rb_insert always
> > followed by zswap_rb_erase. Use xa_erase directly. The entry
> > erase into zswap_xa_insert as well. That saves one tree
> > lookup as well.
> >
> > Remove zswap_invalidate_entry due to no need to call
> > zswap_rb_erase any more. Use zswap_free_entry instead.
> >
> > The "struct zswap_tree" has been replaced by "struct xarray".
> > The tree spin lock has transferred to the xarray lock.
> >
> > Run the kernel build testing 10 times for each version, averages:
> > (memory.max=3D2GB, zswap shrinker and writeback enabled, one 50GB swapf=
ile.)
> >
> > mm-9a0181a3710eb                    xarray v4
> > user       3526.829                            3526.930
> > sys        532.754                             526.525
> > real       198.748                             198.850
> >
> > ---
> >
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > ---
> > Changes in v4:
> > - Remove zswap_xa_search_and_earse, use xa_erase directly.
> > - Move charge of objcg after zswap_xa_insert.
> > - Avoid erase old entry on insert fail error path.
> > - Remove not needed swap_zswap_tree change
> > - Link to v3: https://lore.kernel.org/r/20240302-zswap-xarray-v3-1-5900=
252f2302@kernel.org
> >
> > Changes in v3:
> > - Use xa_cmpxchg instead of zswap_xa_search_and_delete in zswap_writeba=
ck_entry.
> > - Use xa_store in zswap_xa_insert directly. Reduce the scope of spinloc=
k.
> > - Fix xa_store error handling for same page fill case.
> > - Link to v2: https://lore.kernel.org/r/20240229-zswap-xarray-v2-1-e502=
84dfcdb1@kernel.org
> >
> > Changes in v2:
> > - Replace struct zswap_tree with struct xarray.
> > - Remove zswap_tree spinlock, use xarray lock instead.
> > - Fold zswap_rb_erase() into zswap_xa_search_and_delete() and zswap_xa_=
insert().
> > - Delete zswap_invalidate_entry(), use zswap_free_entry() instead.
> > - Link to v1: https://lore.kernel.org/r/20240117-zswap-xarray-v1-0-6daa=
86c08fae@kernel.org
> > ---
> >  mm/zswap.c | 186 ++++++++++++++++++++++++-----------------------------=
--------
> >  1 file changed, 72 insertions(+), 114 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 011e068eb355..4f4a3f452b76 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -20,7 +20,6 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/types.h>
> >  #include <linux/atomic.h>
> > -#include <linux/rbtree.h>
> >  #include <linux/swap.h>
> >  #include <linux/crypto.h>
> >  #include <linux/scatterlist.h>
> > @@ -71,6 +70,8 @@ static u64 zswap_reject_compress_poor;
> >  static u64 zswap_reject_alloc_fail;
> >  /* Store failed because the entry metadata could not be allocated (rar=
e) */
> >  static u64 zswap_reject_kmemcache_fail;
> > +/* Store failed because xarray can't insert the entry*/
> > +static u64 zswap_reject_xarray_fail;
> >
> >  /* Shrinker work queue */
> >  static struct workqueue_struct *shrink_wq;
> > @@ -196,7 +197,6 @@ static struct {
> >   * This structure contains the metadata for tracking a single compress=
ed
> >   * page within zswap.
> >   *
> > - * rbnode - links the entry into red-black tree for the appropriate sw=
ap type
> >   * swpentry - associated swap entry, the offset indexes into the red-b=
lack tree
> >   * length - the length in bytes of the compressed page data.  Needed d=
uring
> >   *          decompression. For a same value filled page length is 0, a=
nd both
> > @@ -208,7 +208,6 @@ static struct {
> >   * lru - handle to the pool's lru used to evict pages.
> >   */
> >  struct zswap_entry {
> > -     struct rb_node rbnode;
> >       swp_entry_t swpentry;
> >       unsigned int length;
> >       struct zswap_pool *pool;
> > @@ -220,12 +219,7 @@ struct zswap_entry {
> >       struct list_head lru;
> >  };
> >
> > -struct zswap_tree {
> > -     struct rb_root rbroot;
> > -     spinlock_t lock;
> > -};
> > -
> > -static struct zswap_tree *zswap_trees[MAX_SWAPFILES];
> > +static struct xarray *zswap_trees[MAX_SWAPFILES];
> >  static unsigned int nr_zswap_trees[MAX_SWAPFILES];
> >
> >  /* RCU-protected iteration */
> > @@ -253,7 +247,7 @@ static bool zswap_has_pool;
> >  * helpers and fwd declarations
> >  **********************************/
> >
> > -static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
> > +static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
> >  {
> >       return &zswap_trees[swp_type(swp)][swp_offset(swp)
> >               >> SWAP_ADDRESS_SPACE_SHIFT];
> > @@ -805,60 +799,33 @@ void zswap_memcg_offline_cleanup(struct mem_cgrou=
p *memcg)
> >  }
> >
> >  /*********************************
> > -* rbtree functions
> > +* xarray functions
> >  **********************************/
> > -static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff=
_t offset)
> > -{
> > -     struct rb_node *node =3D root->rb_node;
> > -     struct zswap_entry *entry;
> > -     pgoff_t entry_offset;
> > -
> > -     while (node) {
> > -             entry =3D rb_entry(node, struct zswap_entry, rbnode);
> > -             entry_offset =3D swp_offset(entry->swpentry);
> > -             if (entry_offset > offset)
> > -                     node =3D node->rb_left;
> > -             else if (entry_offset < offset)
> > -                     node =3D node->rb_right;
> > -             else
> > -                     return entry;
> > -     }
> > -     return NULL;
> > -}
> >
> >  /*
> >   * In the case that a entry with the same offset is found, a pointer t=
o
> > - * the existing entry is stored in dupentry and the function returns -=
EEXIST
> > + * the existing entry is stored in old and erased from the tree.
> > + * Function return error on insert.
> >   */
> > -static int zswap_rb_insert(struct rb_root *root, struct zswap_entry *e=
ntry,
> > -                     struct zswap_entry **dupentry)
> > +static int zswap_xa_insert(struct xarray *tree, struct zswap_entry *en=
try,
> > +                        struct zswap_entry **old)
> >  {
> > -     struct rb_node **link =3D &root->rb_node, *parent =3D NULL;
> > -     struct zswap_entry *myentry;
> > -     pgoff_t myentry_offset, entry_offset =3D swp_offset(entry->swpent=
ry);
> > -
> > -     while (*link) {
> > -             parent =3D *link;
> > -             myentry =3D rb_entry(parent, struct zswap_entry, rbnode);
> > -             myentry_offset =3D swp_offset(myentry->swpentry);
> > -             if (myentry_offset > entry_offset)
> > -                     link =3D &(*link)->rb_left;
> > -             else if (myentry_offset < entry_offset)
> > -                     link =3D &(*link)->rb_right;
> > -             else {
> > -                     *dupentry =3D myentry;
> > -                     return -EEXIST;
> > -             }
> > -     }
> > -     rb_link_node(&entry->rbnode, parent, link);
> > -     rb_insert_color(&entry->rbnode, root);
> > -     return 0;
> > -}
> > +     int err;
> > +     struct zswap_entry *e;
> > +     pgoff_t offset =3D swp_offset(entry->swpentry);
> >
> > -static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *e=
ntry)
> > -{
> > -     rb_erase(&entry->rbnode, root);
> > -     RB_CLEAR_NODE(&entry->rbnode);
> > +     e =3D xa_store(tree, offset, entry, GFP_KERNEL);
> > +     err =3D xa_err(e);
> > +
> > +     if (err) {
> > +             e =3D xa_erase(tree, offset);
> > +             if (err =3D=3D -ENOMEM)
> > +                     zswap_reject_alloc_fail++;
> > +             else
> > +                     zswap_reject_xarray_fail++;
> > +     }
> > +     *old =3D e;
> > +     return err;
> >  }
> >
> >  /*********************************
> > @@ -872,7 +839,6 @@ static struct zswap_entry *zswap_entry_cache_alloc(=
gfp_t gfp, int nid)
> >       entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
> >       if (!entry)
> >               return NULL;
> > -     RB_CLEAR_NODE(&entry->rbnode);
> >       return entry;
> >  }
> >
> > @@ -914,17 +880,6 @@ static void zswap_entry_free(struct zswap_entry *e=
ntry)
> >       zswap_update_total_size();
> >  }
> >
> > -/*
> > - * The caller hold the tree lock and search the entry from the tree,
> > - * so it must be on the tree, remove it from the tree and free it.
> > - */
> > -static void zswap_invalidate_entry(struct zswap_tree *tree,
> > -                                struct zswap_entry *entry)
> > -{
> > -     zswap_rb_erase(&tree->rbroot, entry);
> > -     zswap_entry_free(entry);
> > -}
> > -
> >  /*********************************
> >  * compressed storage functions
> >  **********************************/
> > @@ -1113,7 +1068,9 @@ static void zswap_decompress(struct zswap_entry *=
entry, struct page *page)
> >  static int zswap_writeback_entry(struct zswap_entry *entry,
> >                                swp_entry_t swpentry)
> >  {
> > -     struct zswap_tree *tree;
> > +     struct xarray *tree;
> > +     pgoff_t offset =3D swp_offset(swpentry);
> > +     struct zswap_entry *e;
> >       struct folio *folio;
> >       struct mempolicy *mpol;
> >       bool folio_was_allocated;
> > @@ -1150,19 +1107,14 @@ static int zswap_writeback_entry(struct zswap_e=
ntry *entry,
> >        * be dereferenced.
> >        */
> >       tree =3D swap_zswap_tree(swpentry);
> > -     spin_lock(&tree->lock);
> > -     if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) !=3D ent=
ry) {
> > -             spin_unlock(&tree->lock);
> > +     e =3D xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL);
> > +     if (e !=3D entry) {
>
> Maybe "if (xa_cmpxchg() !=3D entry)" look better, so "e" variable can be =
removed,
> since we don't use it.
>
> >               delete_from_swap_cache(folio);
> >               folio_unlock(folio);
> >               folio_put(folio);
> >               return -ENOMEM;
> >       }
> >
> > -     /* Safe to deref entry after the entry is verified above. */
> > -     zswap_rb_erase(&tree->rbroot, entry);
> > -     spin_unlock(&tree->lock);
> > -
> >       zswap_decompress(entry, &folio->page);
> >
> >       count_vm_event(ZSWPWB);
> > @@ -1471,10 +1423,12 @@ bool zswap_store(struct folio *folio)
> >  {
> >       swp_entry_t swp =3D folio->swap;
> >       pgoff_t offset =3D swp_offset(swp);
> > -     struct zswap_tree *tree =3D swap_zswap_tree(swp);
> > -     struct zswap_entry *entry, *dupentry;
> > +     struct xarray *tree =3D swap_zswap_tree(swp);
> > +     struct zswap_entry *entry, *old;
> >       struct obj_cgroup *objcg =3D NULL;
> >       struct mem_cgroup *memcg =3D NULL;
> > +     int err;
> > +     bool old_erased =3D false;
> >
> >       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> > @@ -1526,6 +1480,7 @@ bool zswap_store(struct folio *folio)
> >                       kunmap_local(src);
> >                       entry->length =3D 0;
> >                       entry->value =3D value;
> > +                     entry->pool =3D NULL;
> >                       atomic_inc(&zswap_same_filled_pages);
> >                       goto insert_entry;
> >               }
> > @@ -1555,28 +1510,31 @@ bool zswap_store(struct folio *folio)
> >  insert_entry:
> >       entry->swpentry =3D swp;
> >       entry->objcg =3D objcg;
> > -     if (objcg) {
> > -             obj_cgroup_charge_zswap(objcg, entry->length);
> > -             /* Account before objcg ref is moved to tree */
> > -             count_objcg_event(objcg, ZSWPOUT);
> > -     }
> >
> >       /* map */
> > -     spin_lock(&tree->lock);
> >       /*
> >        * The folio may have been dirtied again, invalidate the
> >        * possibly stale entry before inserting the new entry.
> >        */
> > -     if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -EEXI=
ST) {
> > -             zswap_invalidate_entry(tree, dupentry);
> > -             WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry))=
;
> > +     err =3D zswap_xa_insert(tree, entry, &old);
> > +     if (old)
> > +             zswap_entry_free(old);
> > +     if (err) {
> > +             old_erased =3D true;
> > +             goto insert_failed;
> >       }
>
> It looks a little complicated for me :( How do you think this like below?
>
> old =3D xa_store(tree, offset, entry, GFP_KERNEL);
> if (xa_is_err(old))
>         goto store_failed;
>
> if (old)
>         zswap_entry_free(old);
>
> Then zswap_xa_insert() wrapper can be removed since no use elsewhere.
> So the error handling path is kept much the same as before and simpler.
>
> > +
> > +     if (objcg) {
> > +             obj_cgroup_charge_zswap(objcg, entry->length);
> > +             /* Account before objcg ref is moved to tree */
> > +             count_objcg_event(objcg, ZSWPOUT);
> > +     }
> > +
> >       if (entry->length) {
> >               INIT_LIST_HEAD(&entry->lru);
> >               zswap_lru_add(&zswap.list_lru, entry);
> >               atomic_inc(&zswap.nr_stored);
> >       }
> > -     spin_unlock(&tree->lock);
> >
> >       /* update stats */
> >       atomic_inc(&zswap_stored_pages);
> > @@ -1585,6 +1543,12 @@ bool zswap_store(struct folio *folio)
> >
> >       return true;
> >
> > +insert_failed:
> > +     if (!entry->length) {
> > +             atomic_dec(&zswap_same_filled_pages);
> > +             goto freepage;
> > +     }
> > +     zpool_free(zswap_find_zpool(entry), entry->handle);
>
> entry->pool can be used here instead of zswap_find_zpool().

Actually you can't use the entry->pool there. I get a compile error.

static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
{
        int i =3D 0;

        if (ZSWAP_NR_ZPOOLS > 1)
                i =3D hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS));

        return entry->pool->zpools[i];
}

Find zpool will return one of the entry->pool->zpools[i]. It is not
the same as entry->pool.

Chris

