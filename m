Return-Path: <linux-kernel+bounces-89549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE0D86F1DC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12281B238C4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C662C695;
	Sat,  2 Mar 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCRaLnrS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973CC1E86F
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709404407; cv=none; b=FFoEG2XU+2w5ywnsEKiDxis8MR+PzsgUK/Wsd/+JHInMShOSRJ5P//lThq+zaWVTTnTZxzb1bX0k8DJNat5g+qLVGYjjHDgx0v36elcuLmPEJ7syMSlDcjgON9zQCHJdnZkHXWGoIlL/0Mcw/lNx44RotX3IOEdWeVMKBZRSjpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709404407; c=relaxed/simple;
	bh=RTTjHmiboWXLQDiyXg9A2O5yKL5Ymun77agihIVZJms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUj0+1liFYex2TKB3uYo4alAiNfwXqCTWERYCmGU8TavvzyOrxWzaYbJGKnLHclWusPDcTBx+SoLoY+UZ43sunPhSYWxvTmF2Q+GMTQnq3POKtgKOZHMmTzWq1+rof1gXdqTGU6dHDv9fz0vmwwWCfZDEJVahamoaU1+jHnnJgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCRaLnrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E821C43601
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709404407;
	bh=RTTjHmiboWXLQDiyXg9A2O5yKL5Ymun77agihIVZJms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BCRaLnrSX2IdQ88eggOfOTNU1SMHh+WRzKGwb+waCXOAFZiJwpfFLW+Ufp9cGAmmk
	 03cHDO6tHwjlBnBOry7rF70lJPLJn52bc1dphI3gEjDTsa/p0az20E8i/wvw3ABCey
	 MPJIKpvRBTE9s3v0QnIG8bD2kuiyhERSptNeoOqXUfe4nvhGiEZE3VlLMOCu6L+nRp
	 kyn21kNgJGMjmmxJBfRJ0rqwXLO2CHsIvLF4Q97t74k/S6fslQDOp9xIBWJLLJUf9M
	 Qi3k1nH7Ed55R+SOJNpSI3/wKoImeCRObuPOEaMekQMSdCxqKQ+xMocZvaIbM81pUI
	 q/RxTBbuk78ow==
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-365c96e2605so13512675ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 10:33:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdlI9bBoPve4ppHvZftDpiZkfjxJQ2sXoktMV68DU897odwKPRKadZFp/xhtcQAhubSnN1JNljLcJ8zTCX35OMBoyDnO2pN0vhY7yr
X-Gm-Message-State: AOJu0Yye9Qfj6K1W2UybHPnZhlt7HyBStKtnxZ+VVfiig1osAVf9skkg
	T4dreY0vR+AvuTQq7CgyhoGu7MH0PuGrhWsRrFQLi/FcitrgsuvPUjX6kkDW8G5jt4TxgoWhJNP
	ky7WzK1Sn0XDAIfVznHIHWLV/7DGU2VA7bmmx
X-Google-Smtp-Source: AGHT+IEL93zfajRRBL76nsxI3/u5MZ3Z/Svvi3cxBLy2AOHdkYIWiFxKbGwZQ5aykquJIbVmhmclfDCYi1lB0FxTmI0=
X-Received: by 2002:a05:6e02:1b08:b0:365:1dbc:a4f0 with SMTP id
 i8-20020a056e021b0800b003651dbca4f0mr4887316ilv.31.1709404406181; Sat, 02 Mar
 2024 10:33:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-zswap-xarray-v2-1-e50284dfcdb1@kernel.org>
 <66a86e12-e567-4705-b683-0485276007d2@bytedance.com> <CAF8kJuPeVQNK2bLiKmjVH-qAdLCwtZfO53HeqgBDcv_i=-QGxg@mail.gmail.com>
 <72d6388f-119d-421e-a326-3fdc2bbc373e@bytedance.com> <CAF8kJuPxg1uviaJhkGkoag-x-ZLdYUmnN=NBz92sA+5Bjn8DGg@mail.gmail.com>
In-Reply-To: <CAF8kJuPxg1uviaJhkGkoag-x-ZLdYUmnN=NBz92sA+5Bjn8DGg@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 2 Mar 2024 10:33:13 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNKSAf1-srZxu0Fb36J=MVDpivUdjQ26JOdWNroeYiDow@mail.gmail.com>
Message-ID: <CAF8kJuNKSAf1-srZxu0Fb36J=MVDpivUdjQ26JOdWNroeYiDow@mail.gmail.com>
Subject: Re: [PATCH v2] zswap: replace RB tree with xarray
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chengming,

On Fri, Mar 1, 2024 at 1:38=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Feb 29, 2024 at 11:24=E2=80=AFPM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> >
> > On 2024/3/1 02:58, Chris Li wrote:
> > > Hi Chengming,
> > >
> > > Thanks for the review and feedback.
> > >
> > > On Thu, Feb 29, 2024 at 1:44=E2=80=AFAM Chengming Zhou
> > > <zhouchengming@bytedance.com> wrote:
> > >>
> > >> Hi Chris,
> > >>
> > >> On 2024/2/29 16:46, Chris Li wrote:
> > >>> Very deep RB tree requires rebalance at times. That
> > >>> contributes to the zswap fault latencies. Xarray does not
> > >>> need to perform tree rebalance. Replacing RB tree to xarray
> > >>> can have some small performance gain.
> > >>>
> > >>> One small difference is that xarray insert might fail with
> > >>> ENOMEM, while RB tree insert does not allocate additional
> > >>> memory.
> > >>>
> > >>> The zswap_entry size will reduce a bit due to removing the
> > >>> RB node, which has two pointers and a color field. Xarray
> > >>> store the pointer in the xarray tree rather than the
> > >>> zswap_entry. Every entry has one pointer from the xarray
> > >>> tree. Overall, switching to xarray should save some memory,
> > >>> if the swap entries are densely packed.
> > >>>
> > >>> Notice the zswap_rb_search and zswap_rb_insert always
> > >>> followed by zswap_rb_erase. Fold the entry erase into
> > >>> zswap_xa_search_and_erase and zswap_xa_insert. That saves
> > >>> one tree lookup as well.
> > >>>
> > >>> Remove zswap_invalidate_entry due to no need to call
> > >>> zswap_rb_erase any more. Use zswap_free_entry instead.
> > >>>
> > >>> The "struct zswap_tree" has been replaced by "struct xarray".
> > >>> The tree spin lock has transferred to the xarray lock.
> > >>>
> > >>> Thanks to Chengming for providing the kernel build test number.
> > >>>
> > >>> Run the kernel build testing 5 times for each version, averages:
> > >>> (memory.max=3D2GB, zswap shrinker and writeback enabled, one 50GB s=
wapfile.)
> > >>>
> > >>>                               mm-266f922c0b5e       zswap-xarray-te=
st
> > >>> real                          63.43                 63.12
> > >>> user                          1063.78               1062.59
> > >>> sys                           272.49                265.66
> > >>>
> > >>> The sys time is about 2.5% faster.
> > >>>
> > >>> Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> > >>> ---
> > >>>
> > >>>
> > >>> Signed-off-by: Chris Li <chrisl@kernel.org>
> > >>> ---
> > >>> Changes in v2:
> > >>> - Replace struct zswap_tree with struct xarray.
> > >>> - Remove zswap_tree spinlock, use xarray lock instead.
> > >>> - Fold zswap_rb_erase() into zswap_xa_search_and_delete() and zswap=
_xa_insert().
> > >>> - Delete zswap_invalidate_entry(), use zswap_free_entry() instead.
> > >>> - Link to v1: https://lore.kernel.org/r/20240117-zswap-xarray-v1-0-=
6daa86c08fae@kernel.org
> > >>> ---
> > >>>  mm/zswap.c | 173 +++++++++++++++++++++++--------------------------=
------------
> > >>>  1 file changed, 64 insertions(+), 109 deletions(-)
> > >>>
> > >>> diff --git a/mm/zswap.c b/mm/zswap.c
> > >>> index 011e068eb355..ac9ef14d88be 100644
> > >>> --- a/mm/zswap.c
> > >>> +++ b/mm/zswap.c
> > >>> @@ -20,7 +20,6 @@
> > >>>  #include <linux/spinlock.h>
> > >>>  #include <linux/types.h>
> > >>>  #include <linux/atomic.h>
> > >>> -#include <linux/rbtree.h>
> > >>>  #include <linux/swap.h>
> > >>>  #include <linux/crypto.h>
> > >>>  #include <linux/scatterlist.h>
> > >>> @@ -71,6 +70,8 @@ static u64 zswap_reject_compress_poor;
> > >>>  static u64 zswap_reject_alloc_fail;
> > >>>  /* Store failed because the entry metadata could not be allocated =
(rare) */
> > >>>  static u64 zswap_reject_kmemcache_fail;
> > >>> +/* Store failed because xarray can't insert the entry*/
> > >>> +static u64 zswap_reject_xarray_fail;
> > >>>
> > >>>  /* Shrinker work queue */
> > >>>  static struct workqueue_struct *shrink_wq;
> > >>> @@ -196,7 +197,6 @@ static struct {
> > >>>   * This structure contains the metadata for tracking a single comp=
ressed
> > >>>   * page within zswap.
> > >>>   *
> > >>> - * rbnode - links the entry into red-black tree for the appropriat=
e swap type
> > >>>   * swpentry - associated swap entry, the offset indexes into the r=
ed-black tree
> > >>>   * length - the length in bytes of the compressed page data.  Need=
ed during
> > >>>   *          decompression. For a same value filled page length is =
0, and both
> > >>> @@ -208,7 +208,6 @@ static struct {
> > >>>   * lru - handle to the pool's lru used to evict pages.
> > >>>   */
> > >>>  struct zswap_entry {
> > >>> -     struct rb_node rbnode;
> > >>>       swp_entry_t swpentry;
> > >>>       unsigned int length;
> > >>>       struct zswap_pool *pool;
> > >>> @@ -220,12 +219,7 @@ struct zswap_entry {
> > >>>       struct list_head lru;
> > >>>  };
> > >>>
> > >>> -struct zswap_tree {
> > >>> -     struct rb_root rbroot;
> > >>> -     spinlock_t lock;
> > >>> -};
> > >>> -
> > >>> -static struct zswap_tree *zswap_trees[MAX_SWAPFILES];
> > >>> +static struct xarray *zswap_trees[MAX_SWAPFILES];
> > >>>  static unsigned int nr_zswap_trees[MAX_SWAPFILES];
> > >>>
> > >>>  /* RCU-protected iteration */
> > >>> @@ -253,10 +247,10 @@ static bool zswap_has_pool;
> > >>>  * helpers and fwd declarations
> > >>>  **********************************/
> > >>>
> > >>> -static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
> > >>> +static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
> > >>>  {
> > >>> -     return &zswap_trees[swp_type(swp)][swp_offset(swp)
> > >>> -             >> SWAP_ADDRESS_SPACE_SHIFT];
> > >>> +     return zswap_trees[swp_type(swp)] + (swp_offset(swp)
> > >>> +             >> SWAP_ADDRESS_SPACE_SHIFT);
> > >>>  }
> > >>>
> > >>>  #define zswap_pool_debug(msg, p)                             \
> > >>> @@ -805,60 +799,38 @@ void zswap_memcg_offline_cleanup(struct mem_c=
group *memcg)
> > >>>  }
> > >>>
> > >>>  /*********************************
> > >>> -* rbtree functions
> > >>> +* xarray functions
> > >>>  **********************************/
> > >>> -static struct zswap_entry *zswap_rb_search(struct rb_root *root, p=
goff_t offset)
> > >>> +static struct zswap_entry *zswap_xa_search_and_erase(struct xarray=
 *tree, pgoff_t offset)
> > >>>  {
> > >>> -     struct rb_node *node =3D root->rb_node;
> > >>> -     struct zswap_entry *entry;
> > >>> -     pgoff_t entry_offset;
> > >>> -
> > >>> -     while (node) {
> > >>> -             entry =3D rb_entry(node, struct zswap_entry, rbnode);
> > >>> -             entry_offset =3D swp_offset(entry->swpentry);
> > >>> -             if (entry_offset > offset)
> > >>> -                     node =3D node->rb_left;
> > >>> -             else if (entry_offset < offset)
> > >>> -                     node =3D node->rb_right;
> > >>> -             else
> > >>> -                     return entry;
> > >>> -     }
> > >>> -     return NULL;
> > >>> +     return xa_erase(tree, offset);
> > >>>  }
> > >>>
> > >>>  /*
> > >>> + * Expects xa_lock to be held on entry.
> > >>>   * In the case that a entry with the same offset is found, a point=
er to
> > >>> - * the existing entry is stored in dupentry and the function retur=
ns -EEXIST
> > >>> + * the existing entry is stored in old and erased from the tree.
> > >>> + * Function return error on insert.
> > >>>   */
> > >>> -static int zswap_rb_insert(struct rb_root *root, struct zswap_entr=
y *entry,
> > >>> -                     struct zswap_entry **dupentry)
> > >>> +static int zswap_xa_insert(struct xarray *tree, struct zswap_entry=
 *entry,
> > >>> +                        struct zswap_entry **old)
> > >>>  {
> > >>> -     struct rb_node **link =3D &root->rb_node, *parent =3D NULL;
> > >>> -     struct zswap_entry *myentry;
> > >>> -     pgoff_t myentry_offset, entry_offset =3D swp_offset(entry->sw=
pentry);
> > >>> -
> > >>> -     while (*link) {
> > >>> -             parent =3D *link;
> > >>> -             myentry =3D rb_entry(parent, struct zswap_entry, rbno=
de);
> > >>> -             myentry_offset =3D swp_offset(myentry->swpentry);
> > >>> -             if (myentry_offset > entry_offset)
> > >>> -                     link =3D &(*link)->rb_left;
> > >>> -             else if (myentry_offset < entry_offset)
> > >>> -                     link =3D &(*link)->rb_right;
> > >>> -             else {
> > >>> -                     *dupentry =3D myentry;
> > >>> -                     return -EEXIST;
> > >>> -             }
> > >>> -     }
> > >>> -     rb_link_node(&entry->rbnode, parent, link);
> > >>> -     rb_insert_color(&entry->rbnode, root);
> > >>> -     return 0;
> > >>> -}
> > >>> +     int err;
> > >>> +     struct zswap_entry *e;
> > >>> +     pgoff_t offset =3D swp_offset(entry->swpentry);
> > >>>
> > >>> -static void zswap_rb_erase(struct rb_root *root, struct zswap_entr=
y *entry)
> > >>> -{
> > >>> -     rb_erase(&entry->rbnode, root);
> > >>> -     RB_CLEAR_NODE(&entry->rbnode);
> > >>> +     e =3D __xa_store(tree, offset, entry, GFP_KERNEL);
> > >>> +     err =3D xa_err(e);
> > >>> +
> > >>> +     if (err) {
> > >>> +             e =3D __xa_erase(tree, offset);
> > >
> > > zswap_xa_insert will always erase the old entry, even when __xa_store=
 fails.
> > >
> > >>> +             if (err =3D=3D -ENOMEM)
> > >>> +                     zswap_reject_alloc_fail++;
> > >>> +             else
> > >>> +                     zswap_reject_xarray_fail++;
> > >>> +     }
> > >>> +     *old =3D e;
> > >
> > > Old pointer is set regardless of the error.
> >
> > Ok, I get it. The "old" pointer is always set on return.
> >
> > >
> > >>> +     return err;
> > >>>  }
> > >>>
> > >>>  /*********************************
> > >>> @@ -872,7 +844,6 @@ static struct zswap_entry *zswap_entry_cache_al=
loc(gfp_t gfp, int nid)
> > >>>       entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
> > >>>       if (!entry)
> > >>>               return NULL;
> > >>> -     RB_CLEAR_NODE(&entry->rbnode);
> > >>>       return entry;
> > >>>  }
> > >>>
> > >>> @@ -914,17 +885,6 @@ static void zswap_entry_free(struct zswap_entr=
y *entry)
> > >>>       zswap_update_total_size();
> > >>>  }
> > >>>
> > >>> -/*
> > >>> - * The caller hold the tree lock and search the entry from the tre=
e,
> > >>> - * so it must be on the tree, remove it from the tree and free it.
> > >>> - */
> > >>> -static void zswap_invalidate_entry(struct zswap_tree *tree,
> > >>> -                                struct zswap_entry *entry)
> > >>> -{
> > >>> -     zswap_rb_erase(&tree->rbroot, entry);
> > >>> -     zswap_entry_free(entry);
> > >>> -}
> > >>> -
> > >>>  /*********************************
> > >>>  * compressed storage functions
> > >>>  **********************************/
> > >>> @@ -1113,7 +1073,9 @@ static void zswap_decompress(struct zswap_ent=
ry *entry, struct page *page)
> > >>>  static int zswap_writeback_entry(struct zswap_entry *entry,
> > >>>                                swp_entry_t swpentry)
> > >>>  {
> > >>> -     struct zswap_tree *tree;
> > >>> +     struct xarray *tree;
> > >>> +     pgoff_t offset =3D swp_offset(swpentry);
> > >>> +     struct zswap_entry *e;
> > >>>       struct folio *folio;
> > >>>       struct mempolicy *mpol;
> > >>>       bool folio_was_allocated;
> > >>> @@ -1150,19 +1112,14 @@ static int zswap_writeback_entry(struct zsw=
ap_entry *entry,
> > >>>        * be dereferenced.
> > >>>        */
> > >>>       tree =3D swap_zswap_tree(swpentry);
> > >>> -     spin_lock(&tree->lock);
> > >>> -     if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) !=3D=
 entry) {
> > >>> -             spin_unlock(&tree->lock);
> > >>> +     e =3D zswap_xa_search_and_erase(tree, offset);
> > >>> +     if (e !=3D entry) {
> > >>
> > >> IIUC, here we should use xa_cmpxchg() instead of erasing it uncondit=
ionally.
> > >
> > > Good catch, I agree with your suggestion. I will spin a V3 to correct=
 that.
> > >
> > >>
> > >>>               delete_from_swap_cache(folio);
> > >>>               folio_unlock(folio);
> > >>>               folio_put(folio);
> > >>>               return -ENOMEM;
> > >>>       }
> > >>>
> > >>> -     /* Safe to deref entry after the entry is verified above. */
> > >>> -     zswap_rb_erase(&tree->rbroot, entry);
> > >>> -     spin_unlock(&tree->lock);
> > >>> -
> > >>>       zswap_decompress(entry, &folio->page);
> > >>>
> > >>>       count_vm_event(ZSWPWB);
> > >>> @@ -1471,10 +1428,11 @@ bool zswap_store(struct folio *folio)
> > >>>  {
> > >>>       swp_entry_t swp =3D folio->swap;
> > >>>       pgoff_t offset =3D swp_offset(swp);
> > >>> -     struct zswap_tree *tree =3D swap_zswap_tree(swp);
> > >>> -     struct zswap_entry *entry, *dupentry;
> > >>> +     struct xarray *tree =3D swap_zswap_tree(swp);
> > >>> +     struct zswap_entry *entry, *old;
> > >>>       struct obj_cgroup *objcg =3D NULL;
> > >>>       struct mem_cgroup *memcg =3D NULL;
> > >>> +     int err;
> > >>>
> > >>>       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > >>>       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> > >>> @@ -1562,21 +1520,25 @@ bool zswap_store(struct folio *folio)
> > >>>       }
> > >>>
> > >>>       /* map */
> > >>> -     spin_lock(&tree->lock);
> > >>> +     xa_lock(tree);
> > >>>       /*
> > >>>        * The folio may have been dirtied again, invalidate the
> > >>>        * possibly stale entry before inserting the new entry.
> > >>>        */
> > >>> -     if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -=
EEXIST) {
> > >>> -             zswap_invalidate_entry(tree, dupentry);
> > >>> -             WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupent=
ry));
> > >>> +     err =3D zswap_xa_insert(tree, entry, &old);
> > >>> +     if (old)
> > >>> +             zswap_entry_free(old);
> > >>
> > >> Maybe it's safer to check old after !err, since "old" variable is no=
t initialized
> > >> to NULL, and zswap_xa_insert() maybe won't overwrite "old" to NULL w=
hen err return?
> > >
> > > That is the intended behavior.
> > >
> > > See the above in zswap_xa_insert(). It will always erase and return
> > > "old" even when the __xa_store() has an error.
> > > That is because by the time zswap needs to store a new entry at this
> > > swap entry. The old data is already outdated. We should just remove
> > > the old data. If __xa_store failed due to out of memory. That is the
> > > same as allocating an entry out of memory. It is fine to fail
> > > swap_store. Then the folio will just stay in the swap cache for the
> > > next time.
> > >
> > > Do you see any ill effects can be caused by deleting the old entry on
> > > xa_insert error?
> >
> > No, you're right, we should always delete/free old zswap entry no matte=
r
> > store success or fail.
> >
> > >
> > >>> +     if (err) {
> > >>> +             xa_unlock(tree);
> > >>> +             goto free_zpool;
> > >>>       }
> > >>> +
> > >>>       if (entry->length) {
> > >>>               INIT_LIST_HEAD(&entry->lru);
> > >>>               zswap_lru_add(&zswap.list_lru, entry);
> > >>>               atomic_inc(&zswap.nr_stored);
> > >>>       }
> > >>
> > >> It seems that we can put this part out of the xarray lock section, t=
hen it's enough to
> > >> just use xa_insert().
> >
> > I wanted to mean xa_store() here.
> >
> > >
> > > It is not enough protection. Consider this race:
> > >
> > >  CPU1                         CPU2
> > >
> > > xa_insert()
> > >                                    entry =3D swap_xa_search_and_erase=
()
> > >                                    zswap_free_entry(entry)
> > >
> > > if (entry->length)
> > >      ...
> > > CPU1 is using entry after free.
> >
> > Hmm, right, but I don't know how could this race happen? Since the foli=
o we store is
> > the owner of swap entry, which couldn't be deleted meanwhile, right?
>
> I will need to think about it more. Agree the current folio can't
> delete itself. It is possible the folio lock was enough to prevent the
> race.

After sleeping on it a bit, I think it should be safe to reduce the
unlock range and use xa_store directly.

Does anyone have any other objects? If not, I will use xa_store directly fo=
r V3.

Chris

