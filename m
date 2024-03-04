Return-Path: <linux-kernel+bounces-90912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4488706B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33E21F220AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4D64AED8;
	Mon,  4 Mar 2024 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKK8aSvZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02A482DF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568874; cv=none; b=jbX7ZL/w1fw/jckxe5OrR1rV/nxZmeTzFcCYPl+hDgvh+psgUEQiXWh2/A1MV+T4LrsG79WwcMzwCUnoxQwaI2TJrFNcDcli1pZCPSPylnpvNHC2BGK/obzRRsXq8YLnckSypR56JQeOOhOSUEzIRpSOpdScCHAAS40ext9ehDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568874; c=relaxed/simple;
	bh=2/q6pfgCun5sb2pzMy+wUnTtObftINagmScizcXH4T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AE3alkJjRMuIcB8d8/PPgxN2b4h10y0+f+gTHe0RMuftMfuyhyQSL58zCXC90lBY9TEd1Z/f1IonM4idpBhk/wW2DYgoKQfo6LT4MGDYP0oaVp3xkHJqiklMy1DSq7OeCs6QB8D3WFqoB45csJcHQzSqL4GNIDdKiJBVTLlrqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKK8aSvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5519BC433B1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709568874;
	bh=2/q6pfgCun5sb2pzMy+wUnTtObftINagmScizcXH4T8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RKK8aSvZPUezV5N6i/ixsCBgD/4u5OI7S9PXaIuMTatPEKB76KFao28rEZ6EcIHi6
	 9icco6GDANDG98/+F+dFF7S2Neulf9skL6WGBVdfGxfah/DVIuUbu8icMoGCB7BeC9
	 S/ehg2bO8ipIgAOGq4cjPSvn270E7GJWv+AkFItdvQ97NPhnc8gTG8OjfjEEtxirF8
	 iJ9a2nf42SYH2cGyPHBC6DvtCBUn4Jr2uP1hSPSUgUF91eHJv/U18a8uEnIw7xMJJe
	 vMjGE6gutOZZnIaDK8/w7VbUbjPGgIHbnno+3i+S5SSzhEZvDsswf0RhRnXKYUafea
	 J9rmzQS85Zpaw==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-365f91e490cso545835ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 08:14:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLCHkMYKy8U+vH4DqHJY1DcKvZNfdbEGsA/fFAZxvavzpSoXpEWwG5gt0oNaufrpAx/wnq0F4kJa6ok/RvgEej+s1BIMkWx0UyrIpx
X-Gm-Message-State: AOJu0YwsdgzVFq5lakClsNOFAv+Y7cR4NcuqeXC8+VjVm7+qYypgh79a
	sb/VJ/HuiP9/ORJDyi+KNA03qHROlflNfx2j+ZTF6q2R54ubSZt5JNW9DM9OoRaEt2rW4f3J3tc
	DCy7QzQwFcLP2RvSQIUnRu0F+3tVEJO8ko1+v
X-Google-Smtp-Source: AGHT+IEI8YHgTogsISo3AW/qiOilID9exQxVMbgGwhEksRumkc4egCD6ietVTTklJ/jAptRv/XpgIx3x3d9ZUTdyP3E=
X-Received: by 2002:a05:6e02:2141:b0:365:4e45:543a with SMTP id
 d1-20020a056e02214100b003654e45543amr12255409ilv.23.1709568873438; Mon, 04
 Mar 2024 08:14:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302-zswap-xarray-v3-1-5900252f2302@kernel.org> <13feceec-30e6-4eb8-80f9-8ba5a134dadc@bytedance.com>
In-Reply-To: <13feceec-30e6-4eb8-80f9-8ba5a134dadc@bytedance.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 4 Mar 2024 08:14:20 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNcKbG=kUrSFj55zePa9H8JtkK0biiwEeMg_zYhFqN48w@mail.gmail.com>
Message-ID: <CAF8kJuNcKbG=kUrSFj55zePa9H8JtkK0biiwEeMg_zYhFqN48w@mail.gmail.com>
Subject: Re: [External] [PATCH v3] zswap: replace RB tree with xarray
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chengming,

On Sun, Mar 3, 2024 at 11:34=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2024/3/3 04:16, Chris Li wrote:
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
> > followed by zswap_rb_erase. Fold the entry erase into
> > zswap_xa_search_and_erase and zswap_xa_insert. That saves
> > one tree lookup as well.
> >
> > Remove zswap_invalidate_entry due to no need to call
> > zswap_rb_erase any more. Use zswap_free_entry instead.
> >
> > The "struct zswap_tree" has been replaced by "struct xarray".
> > The tree spin lock has transferred to the xarray lock.
> >
> > ---
> >
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > ---
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
> >  mm/zswap.c | 174 +++++++++++++++++++++++------------------------------=
--------
> >  1 file changed, 64 insertions(+), 110 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 011e068eb355..9d0bfe077ff1 100644
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
> > @@ -253,10 +247,10 @@ static bool zswap_has_pool;
> >  * helpers and fwd declarations
> >  **********************************/
> >
> > -static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
> > +static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
> >  {
> > -     return &zswap_trees[swp_type(swp)][swp_offset(swp)
> > -             >> SWAP_ADDRESS_SPACE_SHIFT];
> > +     return zswap_trees[swp_type(swp)] + (swp_offset(swp)
> > +             >> SWAP_ADDRESS_SPACE_SHIFT);
> >  }
>
> This doesn't seem to need to be modified, right?

No. It is not needed.

> >
> >  #define zswap_pool_debug(msg, p)                             \
> > @@ -805,60 +799,37 @@ void zswap_memcg_offline_cleanup(struct mem_cgrou=
p *memcg)
> >  }
> >
> >  /*********************************
> > -* rbtree functions
> > +* xarray functions
> >  **********************************/
> > -static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff=
_t offset)
> > +static struct zswap_entry *zswap_xa_search_and_erase(struct xarray *tr=
ee, pgoff_t offset)
> >  {
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
> > +     return xa_erase(tree, offset);
> >  }
>
> I think we can use xa_* functions directly, which is more familiar actual=
ly.

Sure.

>
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
>
> The error path in zswap_store() already have the xa_erase() handling.

Yes, I want to make zswap_xa_insert() have the abstractions that
return and erase the old object consistently, even on the error case.

I notice the xa_erase() in the error handling case as well. I can
remove that duplicate erase after zswap_xa_insert() failed. I just
feel that from API point of view, removing the old entry inside
zswap_xa_insert() is better.

>
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
> > @@ -872,7 +843,6 @@ static struct zswap_entry *zswap_entry_cache_alloc(=
gfp_t gfp, int nid)
> >       entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
> >       if (!entry)
> >               return NULL;
> > -     RB_CLEAR_NODE(&entry->rbnode);
> >       return entry;
> >  }
> >
> > @@ -914,17 +884,6 @@ static void zswap_entry_free(struct zswap_entry *e=
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
> > @@ -1113,7 +1072,9 @@ static void zswap_decompress(struct zswap_entry *=
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
> > @@ -1150,19 +1111,14 @@ static int zswap_writeback_entry(struct zswap_e=
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
> > @@ -1471,10 +1427,11 @@ bool zswap_store(struct folio *folio)
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
> >
> >       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> > @@ -1526,6 +1483,7 @@ bool zswap_store(struct folio *folio)
> >                       kunmap_local(src);
> >                       entry->length =3D 0;
> >                       entry->value =3D value;
> > +                     entry->pool =3D NULL;
> >                       atomic_inc(&zswap_same_filled_pages);
> >                       goto insert_entry;
> >               }
> > @@ -1562,21 +1520,21 @@ bool zswap_store(struct folio *folio)
> >       }
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
> > -     }
> > +     err =3D zswap_xa_insert(tree, entry, &old);
> > +     if (old)
> > +             zswap_entry_free(old);
> > +     if (err)
> > +             goto insert_failed;
> > +
>
> We need to move this store part before objcg charging, since the error pa=
th
> won't uncharge it.

Agree, good point. I will move the charging after the insert successfully.

Chris

>
> Thanks.
>
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
> >  put_pool:
> >       zswap_pool_put(entry->pool);
> >  freepage:
> > @@ -1598,11 +1562,9 @@ bool zswap_store(struct folio *folio)
> >        * possibly stale entry which was previously stored at this offse=
t.
> >        * Otherwise, writeback could overwrite the new data in the swapf=
ile.
> >        */
> > -     spin_lock(&tree->lock);
> > -     entry =3D zswap_rb_search(&tree->rbroot, offset);
> > +     entry =3D zswap_xa_search_and_erase(tree, offset);
> >       if (entry)
> > -             zswap_invalidate_entry(tree, entry);
> > -     spin_unlock(&tree->lock);
> > +             zswap_entry_free(entry);
> >       return false;
> >
> >  shrink:
> > @@ -1615,20 +1577,15 @@ bool zswap_load(struct folio *folio)
> >       swp_entry_t swp =3D folio->swap;
> >       pgoff_t offset =3D swp_offset(swp);
> >       struct page *page =3D &folio->page;
> > -     struct zswap_tree *tree =3D swap_zswap_tree(swp);
> > +     struct xarray *tree =3D swap_zswap_tree(swp);
> >       struct zswap_entry *entry;
> >       u8 *dst;
> >
> >       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >
> > -     spin_lock(&tree->lock);
> > -     entry =3D zswap_rb_search(&tree->rbroot, offset);
> > -     if (!entry) {
> > -             spin_unlock(&tree->lock);
> > +     entry =3D zswap_xa_search_and_erase(tree, offset);
> > +     if (!entry)
> >               return false;
> > -     }
> > -     zswap_rb_erase(&tree->rbroot, entry);
> > -     spin_unlock(&tree->lock);
> >
> >       if (entry->length)
> >               zswap_decompress(entry, page);
> > @@ -1652,19 +1609,17 @@ bool zswap_load(struct folio *folio)
> >  void zswap_invalidate(swp_entry_t swp)
> >  {
> >       pgoff_t offset =3D swp_offset(swp);
> > -     struct zswap_tree *tree =3D swap_zswap_tree(swp);
> > +     struct xarray *tree =3D swap_zswap_tree(swp);
> >       struct zswap_entry *entry;
> >
> > -     spin_lock(&tree->lock);
> > -     entry =3D zswap_rb_search(&tree->rbroot, offset);
> > +     entry =3D zswap_xa_search_and_erase(tree, offset);
> >       if (entry)
> > -             zswap_invalidate_entry(tree, entry);
> > -     spin_unlock(&tree->lock);
> > +             zswap_entry_free(entry);
> >  }
> >
> >  int zswap_swapon(int type, unsigned long nr_pages)
> >  {
> > -     struct zswap_tree *trees, *tree;
> > +     struct xarray *trees, *tree;
> >       unsigned int nr, i;
> >
> >       nr =3D DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
> > @@ -1674,11 +1629,8 @@ int zswap_swapon(int type, unsigned long nr_page=
s)
> >               return -ENOMEM;
> >       }
> >
> > -     for (i =3D 0; i < nr; i++) {
> > -             tree =3D trees + i;
> > -             tree->rbroot =3D RB_ROOT;
> > -             spin_lock_init(&tree->lock);
> > -     }
> > +     for (i =3D 0; i < nr; i++)
> > +             xa_init(trees + i);
> >
> >       nr_zswap_trees[type] =3D nr;
> >       zswap_trees[type] =3D trees;
> > @@ -1687,7 +1639,7 @@ int zswap_swapon(int type, unsigned long nr_pages=
)
> >
> >  void zswap_swapoff(int type)
> >  {
> > -     struct zswap_tree *trees =3D zswap_trees[type];
> > +     struct xarray *trees =3D zswap_trees[type];
> >       unsigned int i;
> >
> >       if (!trees)
> > @@ -1695,7 +1647,7 @@ void zswap_swapoff(int type)
> >
> >       /* try_to_unuse() invalidated all the entries already */
> >       for (i =3D 0; i < nr_zswap_trees[type]; i++)
> > -             WARN_ON_ONCE(!RB_EMPTY_ROOT(&trees[i].rbroot));
> > +             WARN_ON_ONCE(!xa_empty(trees + i));
> >
> >       kvfree(trees);
> >       nr_zswap_trees[type] =3D 0;
> > @@ -1727,6 +1679,8 @@ static int zswap_debugfs_init(void)
> >                          zswap_debugfs_root, &zswap_reject_kmemcache_fa=
il);
> >       debugfs_create_u64("reject_compress_fail", 0444,
> >                          zswap_debugfs_root, &zswap_reject_compress_fai=
l);
> > +     debugfs_create_u64("reject_xarray_fail", 0444,
> > +                        zswap_debugfs_root, &zswap_reject_xarray_fail)=
;
> >       debugfs_create_u64("reject_compress_poor", 0444,
> >                          zswap_debugfs_root, &zswap_reject_compress_poo=
r);
> >       debugfs_create_u64("written_back_pages", 0444,
> >
> > ---
> > base-commit: 9a0181a3710eba1f5c6d19eadcca888be3d54e4f
> > change-id: 20240104-zswap-xarray-716260e541e3
> >
> > Best regards,
>

