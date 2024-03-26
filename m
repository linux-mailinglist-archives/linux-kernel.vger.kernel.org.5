Return-Path: <linux-kernel+bounces-119695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BFF88CC27
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4894D2C813B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC81312AAC0;
	Tue, 26 Mar 2024 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHAcqQZV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0A1AAD3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478563; cv=none; b=Q6RurR8KPQYXIb+vedCxYRwF3ee3t7UQXd+kE/YhO0pg7ZS8lSpMM0rHsAzjRSkLpyOmFhnnwKN3wKBUrmvuIc9yw4HZ6aXeDVFK0fIA0qgS+1B8UKQRkDzG3Tsp2xgtH9NuWmDQX3CAupwBYNhPb2/+OgxFBrMWoIGaEvDcjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478563; c=relaxed/simple;
	bh=H0tEQFKJ5fl+Rene626DqJIxXsA1kB/Ksl/AoUYIIg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIUH0Mn9O2Znb9EUOfo3+TWMt6LEbFfoG6y5lvgCMJo1slqxzVANy3EDn4bA/hOO6RkOvOQz/Us8gQ+cKcWiSq81aJGafLAynm0bGTu1zJhjg6Bfs3zZopR5htMy+M74M0h3vt4E9KiQwo0uxtWovVyVbG6PUmJiV4NsJt8VUcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHAcqQZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21054C433C7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711478563;
	bh=H0tEQFKJ5fl+Rene626DqJIxXsA1kB/Ksl/AoUYIIg8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AHAcqQZVUHe4QXlySUMvVxxXKcuJD+V6Iob/FFEBdOFM3Yph+xAJHmCt5YiIwLur2
	 ggTWOA8Av7v5AILUUTh+yT+lD8nPTxlGwgLrJlFJviHWFeVEr5HzQZyfVgK1NixUtS
	 eUt+tD7QE7icjgo0Qjdrsdqg59bcmL8xuVFVab+3H7nAYY2m67gUTG0Kp6iiPo8yX+
	 b1HD9+xkcnkBI3YF78AzE+QwlwjyJ1bsr7kihur42id3T51M2x4vkyGt5NBe7qNfSG
	 MaTGMj7idzboRuj7SBNG54fH8QMBsKvH9CYVM49mgfbwHjxq+HKCTOpSGo5OicdlUK
	 CQzrd8edOCxUg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5159f9de7fbso4325451e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:42:43 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz8mt9xAbZSHoHS3Wgsdfv6guYLk/TMBPIcAId8ah+LIksAyX9W
	UwrhFZdpesQ180w/L7PMREOoR60Gml9vLjfukmKC0xJY05ZgVDRmAIWchUZtprj+4vr/91/QhzR
	EU7ohXV/QNOT7cL9PqK8nBhd7kQ==
X-Google-Smtp-Source: AGHT+IGxS8U1qBI6DJqFxP4oixOOR/dMUUEufe1ZXk6Nc5fXv3tJ1GndZcYgRLcwmKAcRl+Ai83BtAR5nhB96bB+/kI=
X-Received: by 2002:a05:6512:370e:b0:515:92ba:c280 with SMTP id
 z14-20020a056512370e00b0051592bac280mr256783lfr.35.1711478561708; Tue, 26 Mar
 2024 11:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-zswap-xarray-v9-1-d2891a65dfc7@kernel.org>
In-Reply-To: <20240326-zswap-xarray-v9-1-d2891a65dfc7@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 26 Mar 2024 11:42:29 -0700
X-Gmail-Original-Message-ID: <CANeU7Q=8p4whMu+H9GXqQc4Ehjt0_kCtNdg34TiW4bWFw03dbw@mail.gmail.com>
Message-ID: <CANeU7Q=8p4whMu+H9GXqQc4Ehjt0_kCtNdg34TiW4bWFw03dbw@mail.gmail.com>
Subject: Re: [PATCH v9] zswap: replace RB tree with xarray
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 11:35=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> Very deep RB tree requires rebalance at times.  That contributes to the
> zswap fault latencies.  Xarray does not need to perform tree rebalance.
> Replacing RB tree to xarray can have some small performance gain.
>
> One small difference is that xarray insert might fail with ENOMEM, while
> RB tree insert does not allocate additional memory.
>
> The zswap_entry size will reduce a bit due to removing the RB node, which
> has two pointers and a color field.  Xarray store the pointer in the
> xarray tree rather than the zswap_entry.  Every entry has one pointer fro=
m
> the xarray tree.  Overall, switching to xarray should save some memory, i=
f
> the swap entries are densely packed.
>
> Notice the zswap_rb_search and zswap_rb_insert often followed by
> zswap_rb_erase.  Use xa_erase and xa_store directly.  That saves one tree
> lookup as well.
>
> Remove zswap_invalidate_entry due to no need to call zswap_rb_erase any
> more.  Use zswap_free_entry instead.
>
> The "struct zswap_tree" has been replaced by "struct xarray".  The tree
> spin lock has transferred to the xarray lock.
>
> Run the kernel build testing 5 times for each version, averages:
> (memory.max=3D2GB, zswap shrinker and writeback enabled, one 50GB swapfil=
e,
> 24 HT core, 32 jobs)
>
>            mm-unstable-4aaccadb5c04     xarray v9
> user       3548.902                     3534.375
> sys        522.232                      520.976
> real       202.796                      200.864
>
> Signed-off-by: Chris Li <chrisl@kernel.org>

I remove the previous review tags because I like to get some review of
the conflict resolution as well.

> ---
> Changes in v9:
> - rebase to mm-unstable 4aaccadb5c04.
> - Resolve conflict with Johannes's "mm: zswap: fix data loss on SWP_SYNCH=
RONOUS_IO devices".
> - Link to v8: https://lore.kernel.org/r/20240320-zswap-xarray-v8-1-dc08ee=
9f8744@kernel.org
>
> Changes in v8:
> - Fix some white space damage discovered by Yosry. No actual code change.
> - Collect review tags.
> - Link to v7: https://lore.kernel.org/r/20240319-zswap-xarray-v7-1-e9a03a=
049e86@kernel.org
>
> Changes in v7:
> - update comment suggested by Johannes and Yosry
> - Simplify some error handling code, suggested by Johannes.
> - Link to v6: https://lore.kernel.org/r/20240312-zswap-xarray-v6-1-1b8202=
7d7082@kernel.org
>
> Changes in v6:
> - Add WARN_ONCE() for xa_store failed other than -ENOMEM.
> - Collect review tags.
> - Link to v5: https://lore.kernel.org/r/20240311-zswap-xarray-v5-1-a3031f=
eb9c85@kernel.org
>
> Changes in v5:
> - Remove zswap_xa_insert(), call xa_store and xa_erase directly.
> - Remove zswap_reject_xarray_fail.
> - Link to v4: https://lore.kernel.org/r/20240304-zswap-xarray-v4-1-c4b456=
70cc30@kernel.org
>
> Changes in v4:
> - Remove zswap_xa_search_and_earse, use xa_erase directly.
> - Move charge of objcg after zswap_xa_insert.
> - Avoid erase old entry on insert fail error path.
> - Remove not needed swap_zswap_tree change
> - Link to v3: https://lore.kernel.org/r/20240302-zswap-xarray-v3-1-590025=
2f2302@kernel.org
>
> Changes in v3:
> - Use xa_cmpxchg instead of zswap_xa_search_and_delete in zswap_writeback=
_entry.
> - Use xa_store in zswap_xa_insert directly. Reduce the scope of spinlock.
> - Fix xa_store error handling for same page fill case.
> - Link to v2: https://lore.kernel.org/r/20240229-zswap-xarray-v2-1-e50284=
dfcdb1@kernel.org
>
> Changes in v2:
> - Replace struct zswap_tree with struct xarray.
> - Remove zswap_tree spinlock, use xarray lock instead.
> - Fold zswap_rb_erase() into zswap_xa_search_and_delete() and zswap_xa_in=
sert().
> - Delete zswap_invalidate_entry(), use zswap_free_entry() instead.
> - Link to v1: https://lore.kernel.org/r/20240117-zswap-xarray-v1-0-6daa86=
c08fae@kernel.org
> ---
>  mm/zswap.c | 185 +++++++++++++++++++------------------------------------=
------
>  1 file changed, 58 insertions(+), 127 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 1e1224dbade3..bc821df62c62 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -20,7 +20,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  #include <linux/atomic.h>
> -#include <linux/rbtree.h>
>  #include <linux/swap.h>
>  #include <linux/crypto.h>
>  #include <linux/scatterlist.h>
> @@ -194,7 +193,6 @@ static struct shrinker *zswap_shrinker;
>   * This structure contains the metadata for tracking a single compressed
>   * page within zswap.
>   *
> - * rbnode - links the entry into red-black tree for the appropriate swap=
 type
>   * swpentry - associated swap entry, the offset indexes into the red-bla=
ck tree
>   * length - the length in bytes of the compressed page data.  Needed dur=
ing
>   *          decompression. For a same value filled page length is 0, and=
 both
> @@ -206,7 +204,6 @@ static struct shrinker *zswap_shrinker;
>   * lru - handle to the pool's lru used to evict pages.
>   */
>  struct zswap_entry {
> -       struct rb_node rbnode;
>         swp_entry_t swpentry;
>         unsigned int length;
>         struct zswap_pool *pool;
> @@ -218,12 +215,7 @@ struct zswap_entry {
>         struct list_head lru;
>  };
>
> -struct zswap_tree {
> -       struct rb_root rbroot;
> -       spinlock_t lock;
> -};
> -
> -static struct zswap_tree *zswap_trees[MAX_SWAPFILES];
> +static struct xarray *zswap_trees[MAX_SWAPFILES];
>  static unsigned int nr_zswap_trees[MAX_SWAPFILES];
>
>  /* RCU-protected iteration */
> @@ -251,7 +243,7 @@ static bool zswap_has_pool;
>  * helpers and fwd declarations
>  **********************************/
>
> -static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
> +static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
>  {
>         return &zswap_trees[swp_type(swp)][swp_offset(swp)
>                 >> SWAP_ADDRESS_SPACE_SHIFT];
> @@ -790,63 +782,6 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *=
memcg)
>         spin_unlock(&zswap_shrink_lock);
>  }
>
> -/*********************************
> -* rbtree functions
> -**********************************/
> -static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff_t=
 offset)
> -{
> -       struct rb_node *node =3D root->rb_node;
> -       struct zswap_entry *entry;
> -       pgoff_t entry_offset;
> -
> -       while (node) {
> -               entry =3D rb_entry(node, struct zswap_entry, rbnode);
> -               entry_offset =3D swp_offset(entry->swpentry);
> -               if (entry_offset > offset)
> -                       node =3D node->rb_left;
> -               else if (entry_offset < offset)
> -                       node =3D node->rb_right;
> -               else
> -                       return entry;
> -       }
> -       return NULL;
> -}
> -
> -/*
> - * In the case that a entry with the same offset is found, a pointer to
> - * the existing entry is stored in dupentry and the function returns -EE=
XIST
> - */
> -static int zswap_rb_insert(struct rb_root *root, struct zswap_entry *ent=
ry,
> -                       struct zswap_entry **dupentry)
> -{
> -       struct rb_node **link =3D &root->rb_node, *parent =3D NULL;
> -       struct zswap_entry *myentry;
> -       pgoff_t myentry_offset, entry_offset =3D swp_offset(entry->swpent=
ry);
> -
> -       while (*link) {
> -               parent =3D *link;
> -               myentry =3D rb_entry(parent, struct zswap_entry, rbnode);
> -               myentry_offset =3D swp_offset(myentry->swpentry);
> -               if (myentry_offset > entry_offset)
> -                       link =3D &(*link)->rb_left;
> -               else if (myentry_offset < entry_offset)
> -                       link =3D &(*link)->rb_right;
> -               else {
> -                       *dupentry =3D myentry;
> -                       return -EEXIST;
> -               }
> -       }
> -       rb_link_node(&entry->rbnode, parent, link);
> -       rb_insert_color(&entry->rbnode, root);
> -       return 0;
> -}
> -
> -static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *ent=
ry)
> -{
> -       rb_erase(&entry->rbnode, root);
> -       RB_CLEAR_NODE(&entry->rbnode);
> -}
> -
>  /*********************************
>  * zswap entry functions
>  **********************************/
> @@ -858,7 +793,6 @@ static struct zswap_entry *zswap_entry_cache_alloc(gf=
p_t gfp, int nid)
>         entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
>         if (!entry)
>                 return NULL;
> -       RB_CLEAR_NODE(&entry->rbnode);
>         return entry;
>  }
>
> @@ -893,17 +827,6 @@ static void zswap_entry_free(struct zswap_entry *ent=
ry)
>         atomic_dec(&zswap_stored_pages);
>  }
>
> -/*
> - * The caller hold the tree lock and search the entry from the tree,
> - * so it must be on the tree, remove it from the tree and free it.
> - */
> -static void zswap_invalidate_entry(struct zswap_tree *tree,
> -                                  struct zswap_entry *entry)
> -{
> -       zswap_rb_erase(&tree->rbroot, entry);
> -       zswap_entry_free(entry);
> -}
> -
>  /*********************************
>  * compressed storage functions
>  **********************************/
> @@ -1103,7 +1026,8 @@ static void zswap_decompress(struct zswap_entry *en=
try, struct page *page)
>  static int zswap_writeback_entry(struct zswap_entry *entry,
>                                  swp_entry_t swpentry)
>  {
> -       struct zswap_tree *tree;
> +       struct xarray *tree;
> +       pgoff_t offset =3D swp_offset(swpentry);
>         struct folio *folio;
>         struct mempolicy *mpol;
>         bool folio_was_allocated;
> @@ -1140,19 +1064,13 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>          * be dereferenced.
>          */
>         tree =3D swap_zswap_tree(swpentry);
> -       spin_lock(&tree->lock);
> -       if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) !=3D ent=
ry) {
> -               spin_unlock(&tree->lock);
> +       if (entry !=3D xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL))=
 {
>                 delete_from_swap_cache(folio);
>                 folio_unlock(folio);
>                 folio_put(folio);
>                 return -ENOMEM;
>         }
>
> -       /* Safe to deref entry after the entry is verified above. */
> -       zswap_rb_erase(&tree->rbroot, entry);
> -       spin_unlock(&tree->lock);
> -
>         zswap_decompress(entry, &folio->page);
>
>         count_vm_event(ZSWPWB);
> @@ -1477,8 +1395,8 @@ bool zswap_store(struct folio *folio)
>  {
>         swp_entry_t swp =3D folio->swap;
>         pgoff_t offset =3D swp_offset(swp);
> -       struct zswap_tree *tree =3D swap_zswap_tree(swp);
> -       struct zswap_entry *entry, *dupentry;
> +       struct xarray *tree =3D swap_zswap_tree(swp);
> +       struct zswap_entry *entry, *old;
>         struct obj_cgroup *objcg =3D NULL;
>         struct mem_cgroup *memcg =3D NULL;
>         unsigned long max_pages, cur_pages;
> @@ -1566,27 +1484,43 @@ bool zswap_store(struct folio *folio)
>  insert_entry:
>         entry->swpentry =3D swp;
>         entry->objcg =3D objcg;
> +
> +       old =3D xa_store(tree, offset, entry, GFP_KERNEL);
> +       if (xa_is_err(old)) {
> +               int err =3D xa_err(old);
> +
> +               WARN_ONCE(err !=3D -ENOMEM, "unexpected xarray error: %d\=
n", err);
> +               zswap_reject_alloc_fail++;
> +               goto store_failed;
> +       }
> +
> +       /*
> +        * We may have had an existing entry that became stale when
> +        * the folio was redirtied and now the new version is being
> +        * swapped out. Get rid of the old.
> +        */
> +       if (old)
> +               zswap_entry_free(old);
> +
>         if (objcg) {
>                 obj_cgroup_charge_zswap(objcg, entry->length);
> -               /* Account before objcg ref is moved to tree */
>                 count_objcg_event(objcg, ZSWPOUT);
>         }
>
> -       /* map */
> -       spin_lock(&tree->lock);
>         /*
> -        * The folio may have been dirtied again, invalidate the
> -        * possibly stale entry before inserting the new entry.
> +        * We finish initializing the entry while it's already in xarray.
> +        * This is safe because:
> +        *
> +        * 1. Concurrent stores and invalidations are excluded by folio l=
ock.
> +        *
> +        * 2. Writeback is excluded by the entry not being on the LRU yet=
.
> +        *    The publishing order matters to prevent writeback from seei=
ng
> +        *    an incoherent entry.
>          */
> -       if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -EEXI=
ST) {
> -               zswap_invalidate_entry(tree, dupentry);
> -               WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry))=
;
> -       }
>         if (entry->length) {
>                 INIT_LIST_HEAD(&entry->lru);
>                 zswap_lru_add(&zswap_list_lru, entry);
>         }
> -       spin_unlock(&tree->lock);
>
>         /* update stats */
>         atomic_inc(&zswap_stored_pages);
> @@ -1594,8 +1528,14 @@ bool zswap_store(struct folio *folio)
>
>         return true;
>
> +store_failed:
> +       if (!entry->length)
> +               atomic_dec(&zswap_same_filled_pages);
> +       else {
> +               zpool_free(zswap_find_zpool(entry), entry->handle);
>  put_pool:
> -       zswap_pool_put(entry->pool);
> +               zswap_pool_put(entry->pool);
> +       }
>  freepage:
>         zswap_entry_cache_free(entry);
>  reject:
> @@ -1606,11 +1546,9 @@ bool zswap_store(struct folio *folio)
>          * possibly stale entry which was previously stored at this offse=
t.
>          * Otherwise, writeback could overwrite the new data in the swapf=
ile.
>          */
> -       spin_lock(&tree->lock);
> -       entry =3D zswap_rb_search(&tree->rbroot, offset);
> +       entry =3D xa_erase(tree, offset);
>         if (entry)
> -               zswap_invalidate_entry(tree, entry);
> -       spin_unlock(&tree->lock);
> +               zswap_entry_free(entry);
>         return false;
>
>  shrink:
> @@ -1624,20 +1562,14 @@ bool zswap_load(struct folio *folio)
>         pgoff_t offset =3D swp_offset(swp);
>         struct page *page =3D &folio->page;
>         bool swapcache =3D folio_test_swapcache(folio);
> -       struct zswap_tree *tree =3D swap_zswap_tree(swp);
> +       struct xarray *tree =3D swap_zswap_tree(swp);
>         struct zswap_entry *entry;
>         u8 *dst;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>
> -       spin_lock(&tree->lock);
> -       entry =3D zswap_rb_search(&tree->rbroot, offset);
> -       if (!entry) {
> -               spin_unlock(&tree->lock);
> -               return false;
> -       }
>         /*
> -        * When reading into the swapcache, invalidate our entry. The
> +        * When reading into the swapcache, erase our entry. The
>          * swapcache can be the authoritative owner of the page and
>          * its mappings, and the pressure that results from having two
>          * in-memory copies outweighs any benefits of caching the
> @@ -1649,8 +1581,12 @@ bool zswap_load(struct folio *folio)
>          * the fault fails. We remain the primary owner of the entry.)
>          */
>         if (swapcache)
> -               zswap_rb_erase(&tree->rbroot, entry);
> -       spin_unlock(&tree->lock);
> +               entry =3D xa_erase(tree, offset);
> +       else
> +               entry =3D xa_load(tree, offset);

This is the place I make the modification for the conflict resolution.
It depends on the swapcache to execute xa_erase() or xa_load().
Obviously, the xa_load() will not delete the entry from the tree.

Chris

> +
> +       if (!entry)
> +               return false;
>
>         if (entry->length)
>                 zswap_decompress(entry, page);
> @@ -1675,19 +1611,17 @@ bool zswap_load(struct folio *folio)
>  void zswap_invalidate(swp_entry_t swp)
>  {
>         pgoff_t offset =3D swp_offset(swp);
> -       struct zswap_tree *tree =3D swap_zswap_tree(swp);
> +       struct xarray *tree =3D swap_zswap_tree(swp);
>         struct zswap_entry *entry;
>
> -       spin_lock(&tree->lock);
> -       entry =3D zswap_rb_search(&tree->rbroot, offset);
> +       entry =3D xa_erase(tree, offset);
>         if (entry)
> -               zswap_invalidate_entry(tree, entry);
> -       spin_unlock(&tree->lock);
> +               zswap_entry_free(entry);
>  }
>
>  int zswap_swapon(int type, unsigned long nr_pages)
>  {
> -       struct zswap_tree *trees, *tree;
> +       struct xarray *trees, *tree;
>         unsigned int nr, i;
>
>         nr =3D DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
> @@ -1697,11 +1631,8 @@ int zswap_swapon(int type, unsigned long nr_pages)
>                 return -ENOMEM;
>         }
>
> -       for (i =3D 0; i < nr; i++) {
> -               tree =3D trees + i;
> -               tree->rbroot =3D RB_ROOT;
> -               spin_lock_init(&tree->lock);
> -       }
> +       for (i =3D 0; i < nr; i++)
> +               xa_init(trees + i);
>
>         nr_zswap_trees[type] =3D nr;
>         zswap_trees[type] =3D trees;
> @@ -1710,7 +1641,7 @@ int zswap_swapon(int type, unsigned long nr_pages)
>
>  void zswap_swapoff(int type)
>  {
> -       struct zswap_tree *trees =3D zswap_trees[type];
> +       struct xarray *trees =3D zswap_trees[type];
>         unsigned int i;
>
>         if (!trees)
> @@ -1718,7 +1649,7 @@ void zswap_swapoff(int type)
>
>         /* try_to_unuse() invalidated all the entries already */
>         for (i =3D 0; i < nr_zswap_trees[type]; i++)
> -               WARN_ON_ONCE(!RB_EMPTY_ROOT(&trees[i].rbroot));
> +               WARN_ON_ONCE(!xa_empty(trees + i));
>
>         kvfree(trees);
>         nr_zswap_trees[type] =3D 0;
>
> ---
> base-commit: 4aaccadb5c04dd4d4519c8762a38010a32d904a3
> change-id: 20240104-zswap-xarray-716260e541e3
>
> Best regards,
> --
> Chris Li <chrisl@kernel.org>
>

