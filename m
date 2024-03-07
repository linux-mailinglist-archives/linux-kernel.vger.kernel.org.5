Return-Path: <linux-kernel+bounces-96027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFC3875641
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6A31C20C99
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134E7131E25;
	Thu,  7 Mar 2024 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG9cnX7g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CB853804
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837124; cv=none; b=rDTBqDHEx2Nm+F8RtLOmfDnly/4Fhtbje3INgB/gxnv2c0nlBDAgm6TG0CmQO17M3nQ5l8NNMrOwhVPXSj/IMmc0eBl7cjG8niDa2LBsb7ougAXxOBdA85W2d5G+Y/DDGUqhMMabGPOHftlUrJXHFhICOQVMNB/D3HxYSP/dJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837124; c=relaxed/simple;
	bh=s5GdOzHE//uEnkMCcYz0ORml5ihxX9d3bq9ysI/X7CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkBwpOBYLwSvV+tFi2CZwbV/dkuAkvhUti39sJjxl8jIgqj0w+r9p7x43A/I+SWbz0gx/3Px0DWI1ryvwEpk3pma6ZHqFiSUY3pAbTqods98zEBB0DGmDCdumzARpvsQmnvRh7vhN+75vyIwulUS94Nho8EGUgIptZL3XN+cgeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG9cnX7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B79C433F1
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709837123;
	bh=s5GdOzHE//uEnkMCcYz0ORml5ihxX9d3bq9ysI/X7CM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mG9cnX7g0LpB1wKyQ7LpE8B90W/SJUIGqBHVFLDUg7G4hrRLQ2KdlHG5l9PZfrxlo
	 r1vLMHB5LmpQ3UhfRkFld+iq6bpluCfJ+k82JSOl6MR6lhA4ACjTYkNgJ2mlFgT0Kk
	 A/DW2gxPLfpz8GjsCQ63rpxabMzgyrmamt58LDgb6QNZPCMLEsDInGV9sIwKJgRgof
	 8xmCU38gWbp1G1yt/YpRYZHfz6bUsLjkuMTnZKlfSE1S+hTVZVjouTSUp06YDofrU4
	 iJdEM2BNvfmxylNligMx1TQgulkavvQzvp9l4nloA1EQhqXAMdymQFHX3Dnpy6JdS7
	 UXbXuYYCYP13A==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d288bac3caso16587241fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 10:45:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/3RxyTdI3FBAjalibduV6cd50XcQeEDxWjP1QZchNJC5zuawBD+XZfyI1WwW4j4aF3dOPXX603H8hEeDnFWjw5WCfNyZx8lBVArvW
X-Gm-Message-State: AOJu0YwJSJbB2TJo42Rf2CT336YAd/JGwuUET+FAhKYkIvlIr6tyqThV
	9xDrt+M/AeOn2FzSFmd84EQL7boDq9A9RLUWu8OA+hlPTdvUn+Xq8epbgdx78ohrv7wLAQgQEsS
	tu4cVvwyc0G/29QfO3RT8E5sSoA==
X-Google-Smtp-Source: AGHT+IHrRYoaJT2bSsvCQm0KgzHTC+9vou3Twrb27dGAnsPRq6p/smDpxqBOXVH2KQKixc6awU0RqmL5lR4dZ5spFTE=
X-Received: by 2002:a05:651c:2db:b0:2d3:1c52:7ae5 with SMTP id
 f27-20020a05651c02db00b002d31c527ae5mr1689653ljo.46.1709837121756; Thu, 07
 Mar 2024 10:45:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304-zswap-xarray-v4-1-c4b45670cc30@kernel.org>
 <05cbfe34-bac1-4c16-92fa-f38b09160458@bytedance.com> <CAF8kJuPaW51+K5JAT4CzQg7QFWXz5WCc_=MbYN5OYAAYrcRR1w@mail.gmail.com>
 <000b8cee-79cc-4f28-b180-105f2abe6b82@bytedance.com>
In-Reply-To: <000b8cee-79cc-4f28-b180-105f2abe6b82@bytedance.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 7 Mar 2024 10:45:09 -0800
X-Gmail-Original-Message-ID: <CANeU7QmwGpFRQjqgswimuSxkRKNNL_T0jHmqS75RL10SfRDR1Q@mail.gmail.com>
Message-ID: <CANeU7QmwGpFRQjqgswimuSxkRKNNL_T0jHmqS75RL10SfRDR1Q@mail.gmail.com>
Subject: Re: [PATCH v4] zswap: replace RB tree with xarray
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:17=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2024/3/7 05:12, Chris Li wrote:
> > Hi Chengming,
> >
> > On Mon, Mar 4, 2024 at 6:52=E2=80=AFPM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> >> Hi Chris,
> >>
> >> On 2024/3/5 05:32, Chris Li wrote:
> >>> Very deep RB tree requires rebalance at times. That
> >>> contributes to the zswap fault latencies. Xarray does not
> >>> need to perform tree rebalance. Replacing RB tree to xarray
> >>> can have some small performance gain.
> >>>
> >>> One small difference is that xarray insert might fail with
> >>> ENOMEM, while RB tree insert does not allocate additional
> >>> memory.
> >>>
> >>> The zswap_entry size will reduce a bit due to removing the
> >>> RB node, which has two pointers and a color field. Xarray
> >>> store the pointer in the xarray tree rather than the
> >>> zswap_entry. Every entry has one pointer from the xarray
> >>> tree. Overall, switching to xarray should save some memory,
> >>> if the swap entries are densely packed.
> >>>
> >>> Notice the zswap_rb_search and zswap_rb_insert always
> >>> followed by zswap_rb_erase. Use xa_erase directly. The entry
> >>> erase into zswap_xa_insert as well. That saves one tree
> >>> lookup as well.
> >>>
> >>> Remove zswap_invalidate_entry due to no need to call
> >>> zswap_rb_erase any more. Use zswap_free_entry instead.
> >>>
> >>> The "struct zswap_tree" has been replaced by "struct xarray".
> >>> The tree spin lock has transferred to the xarray lock.
> >>>
> >>> Run the kernel build testing 10 times for each version, averages:
> >>> (memory.max=3D2GB, zswap shrinker and writeback enabled, one 50GB swa=
pfile.)
> >>>
> >>> mm-9a0181a3710eb                    xarray v4
> >>> user       3526.829                            3526.930
> >>> sys        532.754                             526.525
> >>> real       198.748                             198.850
> >>>
> >>> ---
> >>>
> >>>
> >>> Signed-off-by: Chris Li <chrisl@kernel.org>
> >>> ---
> >>> Changes in v4:
> >>> - Remove zswap_xa_search_and_earse, use xa_erase directly.
> >>> - Move charge of objcg after zswap_xa_insert.
> >>> - Avoid erase old entry on insert fail error path.
> >>> - Remove not needed swap_zswap_tree change
> >>> - Link to v3: https://lore.kernel.org/r/20240302-zswap-xarray-v3-1-59=
00252f2302@kernel.org
> >>>
> >>> Changes in v3:
> >>> - Use xa_cmpxchg instead of zswap_xa_search_and_delete in zswap_write=
back_entry.
> >>> - Use xa_store in zswap_xa_insert directly. Reduce the scope of spinl=
ock.
> >>> - Fix xa_store error handling for same page fill case.
> >>> - Link to v2: https://lore.kernel.org/r/20240229-zswap-xarray-v2-1-e5=
0284dfcdb1@kernel.org
> >>>
> >>> Changes in v2:
> >>> - Replace struct zswap_tree with struct xarray.
> >>> - Remove zswap_tree spinlock, use xarray lock instead.
> >>> - Fold zswap_rb_erase() into zswap_xa_search_and_delete() and zswap_x=
a_insert().
> >>> - Delete zswap_invalidate_entry(), use zswap_free_entry() instead.
> >>> - Link to v1: https://lore.kernel.org/r/20240117-zswap-xarray-v1-0-6d=
aa86c08fae@kernel.org
> >>> ---
> >>>  mm/zswap.c | 186 ++++++++++++++++++++++++---------------------------=
----------
> >>>  1 file changed, 72 insertions(+), 114 deletions(-)
> >>>
> >>> diff --git a/mm/zswap.c b/mm/zswap.c
> >>> index 011e068eb355..4f4a3f452b76 100644
> >>> --- a/mm/zswap.c
> >>> +++ b/mm/zswap.c
> >>> @@ -20,7 +20,6 @@
> >>>  #include <linux/spinlock.h>
> >>>  #include <linux/types.h>
> >>>  #include <linux/atomic.h>
> >>> -#include <linux/rbtree.h>
> >>>  #include <linux/swap.h>
> >>>  #include <linux/crypto.h>
> >>>  #include <linux/scatterlist.h>
> >>> @@ -71,6 +70,8 @@ static u64 zswap_reject_compress_poor;
> >>>  static u64 zswap_reject_alloc_fail;
> >>>  /* Store failed because the entry metadata could not be allocated (r=
are) */
> >>>  static u64 zswap_reject_kmemcache_fail;
> >>> +/* Store failed because xarray can't insert the entry*/
> >>> +static u64 zswap_reject_xarray_fail;
> >>>
> >>>  /* Shrinker work queue */
> >>>  static struct workqueue_struct *shrink_wq;
> >>> @@ -196,7 +197,6 @@ static struct {
> >>>   * This structure contains the metadata for tracking a single compre=
ssed
> >>>   * page within zswap.
> >>>   *
> >>> - * rbnode - links the entry into red-black tree for the appropriate =
swap type
> >>>   * swpentry - associated swap entry, the offset indexes into the red=
-black tree
> >>>   * length - the length in bytes of the compressed page data.  Needed=
 during
> >>>   *          decompression. For a same value filled page length is 0,=
 and both
> >>> @@ -208,7 +208,6 @@ static struct {
> >>>   * lru - handle to the pool's lru used to evict pages.
> >>>   */
> >>>  struct zswap_entry {
> >>> -     struct rb_node rbnode;
> >>>       swp_entry_t swpentry;
> >>>       unsigned int length;
> >>>       struct zswap_pool *pool;
> >>> @@ -220,12 +219,7 @@ struct zswap_entry {
> >>>       struct list_head lru;
> >>>  };
> >>>
> >>> -struct zswap_tree {
> >>> -     struct rb_root rbroot;
> >>> -     spinlock_t lock;
> >>> -};
> >>> -
> >>> -static struct zswap_tree *zswap_trees[MAX_SWAPFILES];
> >>> +static struct xarray *zswap_trees[MAX_SWAPFILES];
> >>>  static unsigned int nr_zswap_trees[MAX_SWAPFILES];
> >>>
> >>>  /* RCU-protected iteration */
> >>> @@ -253,7 +247,7 @@ static bool zswap_has_pool;
> >>>  * helpers and fwd declarations
> >>>  **********************************/
> >>>
> >>> -static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
> >>> +static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
> >>>  {
> >>>       return &zswap_trees[swp_type(swp)][swp_offset(swp)
> >>>               >> SWAP_ADDRESS_SPACE_SHIFT];
> >>> @@ -805,60 +799,33 @@ void zswap_memcg_offline_cleanup(struct mem_cgr=
oup *memcg)
> >>>  }
> >>>
> >>>  /*********************************
> >>> -* rbtree functions
> >>> +* xarray functions
> >>>  **********************************/
> >>> -static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgo=
ff_t offset)
> >>> -{
> >>> -     struct rb_node *node =3D root->rb_node;
> >>> -     struct zswap_entry *entry;
> >>> -     pgoff_t entry_offset;
> >>> -
> >>> -     while (node) {
> >>> -             entry =3D rb_entry(node, struct zswap_entry, rbnode);
> >>> -             entry_offset =3D swp_offset(entry->swpentry);
> >>> -             if (entry_offset > offset)
> >>> -                     node =3D node->rb_left;
> >>> -             else if (entry_offset < offset)
> >>> -                     node =3D node->rb_right;
> >>> -             else
> >>> -                     return entry;
> >>> -     }
> >>> -     return NULL;
> >>> -}
> >>>
> >>>  /*
> >>>   * In the case that a entry with the same offset is found, a pointer=
 to
> >>> - * the existing entry is stored in dupentry and the function returns=
 -EEXIST
> >>> + * the existing entry is stored in old and erased from the tree.
> >>> + * Function return error on insert.
> >>>   */
> >>> -static int zswap_rb_insert(struct rb_root *root, struct zswap_entry =
*entry,
> >>> -                     struct zswap_entry **dupentry)
> >>> +static int zswap_xa_insert(struct xarray *tree, struct zswap_entry *=
entry,
> >>> +                        struct zswap_entry **old)
> >>>  {
> >>> -     struct rb_node **link =3D &root->rb_node, *parent =3D NULL;
> >>> -     struct zswap_entry *myentry;
> >>> -     pgoff_t myentry_offset, entry_offset =3D swp_offset(entry->swpe=
ntry);
> >>> -
> >>> -     while (*link) {
> >>> -             parent =3D *link;
> >>> -             myentry =3D rb_entry(parent, struct zswap_entry, rbnode=
);
> >>> -             myentry_offset =3D swp_offset(myentry->swpentry);
> >>> -             if (myentry_offset > entry_offset)
> >>> -                     link =3D &(*link)->rb_left;
> >>> -             else if (myentry_offset < entry_offset)
> >>> -                     link =3D &(*link)->rb_right;
> >>> -             else {
> >>> -                     *dupentry =3D myentry;
> >>> -                     return -EEXIST;
> >>> -             }
> >>> -     }
> >>> -     rb_link_node(&entry->rbnode, parent, link);
> >>> -     rb_insert_color(&entry->rbnode, root);
> >>> -     return 0;
> >>> -}
> >>> +     int err;
> >>> +     struct zswap_entry *e;
> >>> +     pgoff_t offset =3D swp_offset(entry->swpentry);
> >>>
> >>> -static void zswap_rb_erase(struct rb_root *root, struct zswap_entry =
*entry)
> >>> -{
> >>> -     rb_erase(&entry->rbnode, root);
> >>> -     RB_CLEAR_NODE(&entry->rbnode);
> >>> +     e =3D xa_store(tree, offset, entry, GFP_KERNEL);
> >>> +     err =3D xa_err(e);
> >>> +
> >>> +     if (err) {
> >>> +             e =3D xa_erase(tree, offset);
> >>> +             if (err =3D=3D -ENOMEM)
> >>> +                     zswap_reject_alloc_fail++;
> >>> +             else
> >>> +                     zswap_reject_xarray_fail++;
> >>> +     }
> >>> +     *old =3D e;
> >>> +     return err;
> >>>  }
> >>>
> >>>  /*********************************
> >>> @@ -872,7 +839,6 @@ static struct zswap_entry *zswap_entry_cache_allo=
c(gfp_t gfp, int nid)
> >>>       entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
> >>>       if (!entry)
> >>>               return NULL;
> >>> -     RB_CLEAR_NODE(&entry->rbnode);
> >>>       return entry;
> >>>  }
> >>>
> >>> @@ -914,17 +880,6 @@ static void zswap_entry_free(struct zswap_entry =
*entry)
> >>>       zswap_update_total_size();
> >>>  }
> >>>
> >>> -/*
> >>> - * The caller hold the tree lock and search the entry from the tree,
> >>> - * so it must be on the tree, remove it from the tree and free it.
> >>> - */
> >>> -static void zswap_invalidate_entry(struct zswap_tree *tree,
> >>> -                                struct zswap_entry *entry)
> >>> -{
> >>> -     zswap_rb_erase(&tree->rbroot, entry);
> >>> -     zswap_entry_free(entry);
> >>> -}
> >>> -
> >>>  /*********************************
> >>>  * compressed storage functions
> >>>  **********************************/
> >>> @@ -1113,7 +1068,9 @@ static void zswap_decompress(struct zswap_entry=
 *entry, struct page *page)
> >>>  static int zswap_writeback_entry(struct zswap_entry *entry,
> >>>                                swp_entry_t swpentry)
> >>>  {
> >>> -     struct zswap_tree *tree;
> >>> +     struct xarray *tree;
> >>> +     pgoff_t offset =3D swp_offset(swpentry);
> >>> +     struct zswap_entry *e;
> >>>       struct folio *folio;
> >>>       struct mempolicy *mpol;
> >>>       bool folio_was_allocated;
> >>> @@ -1150,19 +1107,14 @@ static int zswap_writeback_entry(struct zswap=
_entry *entry,
> >>>        * be dereferenced.
> >>>        */
> >>>       tree =3D swap_zswap_tree(swpentry);
> >>> -     spin_lock(&tree->lock);
> >>> -     if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) !=3D e=
ntry) {
> >>> -             spin_unlock(&tree->lock);
> >>> +     e =3D xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL);
> >>> +     if (e !=3D entry) {
> >>
> >> Maybe "if (xa_cmpxchg() !=3D entry)" look better, so "e" variable can =
be removed,
> >> since we don't use it.
> >
> > I thought about that. The main reason "if (xa_cmpxchg(tree, offset,
> > entry, NULL, GFP_KERNEL) !=3D entry)" is a long expression. Having
> > !=3D entry at the end of the expression makes it harder to read. Have
> > the temporary variable IMHO help reading the comparison.
> >
> > Not sure I understand the motivation to save a temporary variable. The
> > compiler always generates temporary variables internally. Having one
> > here does not affect the compiling result at all. It is just there to
> > help reading. If you still think it has the reverse effect on reading
> > I can of course remove it. It generates the same code anyway.
> You are right, just a minor type suggestion, no much difference if you ke=
ep it.

Thanks for the understanding and flexibility. I agree this is more a
personal flavor kind of thing,
Doesn't have a big enough impact on readability which has to flip one
way or the other.

Chris

