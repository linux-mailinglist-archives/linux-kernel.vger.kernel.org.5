Return-Path: <linux-kernel+bounces-94610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBC9874219
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A351C219BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8501B80B;
	Wed,  6 Mar 2024 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Doqt7FD3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A00D1B286
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709761071; cv=none; b=K/5fJZqLzRtLcV34UeVHyoGxLV31QSfjGDQcoKqUUZbu7+oP2u4baQWDA9eD3FbETcVuEEUUphGlC2+YKHEG9ZLC3sxCPJejh6HhLodE7g6AHgkuP/qnN3vliWaIbaesO9/7Ny2OIRTrH5PPt+xBas0HSJ6bWDM5zRX+WrgzyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709761071; c=relaxed/simple;
	bh=r9mF5jjhZvdIk0HmA12mMF6wLQEmEjKlEpAHom0Z8W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfksidLAlwZQ+y13nUAzA/RCfa0/BndDLVmD8cGuTPSF1PeWP+/wDfRg8wtPdrJUBRMuj4nAEBqJrqQcBnmLlCDW2xSbIrgpYoS/DXEvqj9QhIJf4rybzWKxIHnmoajr29fkhAiYLfFDs9dsbgW3iAnU23x5/ERhpPneFtDBak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Doqt7FD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCACCC433F1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709761070;
	bh=r9mF5jjhZvdIk0HmA12mMF6wLQEmEjKlEpAHom0Z8W4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Doqt7FD3F3Wer/0Dh/rTxpdUwmXqR77865JRbCmmjGPnGwXVUS0T9XpLnpv+PZZlp
	 ML/PJe5Cs9aqsxJyLyDSPpHhw7KGYBHa6Y+y/LQLPUWxYVMy2bYs2DfTMuZFH3Q7we
	 PoE4vrryVkum/6ERwNin+CYsRIAn2BdcL95oeCvJovXOCha4sYbABGLywwj8d/Snmm
	 sEm+8KOZswcOz1D+W6Iq996A5HvvLQlaYOOLF+N5Av1774OBwXeHMkF9UPelAzr/+O
	 /Hgj6a62IkBT6gSzfdL4atPl6k99je8iVji+F37Hm4Cqcu6eVdZ2W4WsQ/bScy9TQq
	 SfY8MopVW14cQ==
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c7701f95b6so35968339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 13:37:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4IPY8Fcfx5m3lZNRwn9MdqAftqWHuZo6XqGk+roOGFooD+TARCJgLVnQz1lzSGIonyX0CWDP0pRliI2F6AzF860d6joPUT5+6SZzi
X-Gm-Message-State: AOJu0YxuSjU/H3M/0wfpY3xBLxqit4X2Bf97hMOSVGb3YyjwAdqCKkpQ
	PXy9jJn8JdxK3r68Cg9WkQnSMiyYB+lx8Pi+EARY5XTPKqTqotgdTTCyYCCTyNKH/P6SxxbCPF4
	/D90hYoeVlRiR7hwcs63lyyRUSBU190Y2D93p
X-Google-Smtp-Source: AGHT+IHlXyAMKb9rcZDLIQnN+daDQseDgLDFthhdLx+QZrZPLKFVa8xrlLLT/0+GpXoMgOuuBsTDHovjoNM08XHht/A=
X-Received: by 2002:a05:6e02:1c05:b0:365:6:b56b with SMTP id
 l5-20020a056e021c0500b003650006b56bmr1308338ilh.8.1709761070001; Wed, 06 Mar
 2024 13:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304-zswap-xarray-v4-1-c4b45670cc30@kernel.org> <ZeaotMlpMl88lSlc@google.com>
In-Reply-To: <ZeaotMlpMl88lSlc@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 6 Mar 2024 13:37:38 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPcPi22hWhJFGAf0RW2Q8PS_WHKXfUYrcwnpHY2VDVhYg@mail.gmail.com>
Message-ID: <CAF8kJuPcPi22hWhJFGAf0RW2Q8PS_WHKXfUYrcwnpHY2VDVhYg@mail.gmail.com>
Subject: Re: [PATCH v4] zswap: replace RB tree with xarray
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,

On Mon, Mar 4, 2024 at 9:08=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> Hi Chris,
>
> On Mon, Mar 04, 2024 at 01:32:20PM -0800, Chris Li wrote:
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
>
> Please add details about the number of threads and the number of CPUs as
> well.

Sure, I will update the commit message in V5. It is 24 HT core running
32 jobs for make.

>
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
>
> I think this is too complicated, and as Chengming pointed out, I believe
> we can use xa_store() directly in zswap_store().

Sure.

> I am also not sure what the need for zswap_reject_xarray_fail is. Are
> there any reasons why the store here can fail other than -ENOMEM? The
> docs say the only other option is -EINVAL, and looking at __xa_store(),
> it seems like this is only possible if xa_is_internal() is true (which
> means we are not passing in a properly aligned pointer IIUC).

Because the xa_store document said it can return two error codes. I
see zswap try to classify the error count it hit, that is why I add
the zswap_reject_xarray_fail.

>
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
> I think we can avoid adding 'e' and 'offset' local variables here and
> just do everything in the if condition. If you want to avoid the line
> break, then introducing 'offset' is fine, but I don't see any value from
> 'e'.

As I said in my other email. I don't think having this type of local
variable affects the compiler negatively. The compiler generally uses
their own local variable to track the expression anyway. So I am not
sure about the motivation to remove local variables alone, if it helps
the reading. I feel the line  "if (xa_cmpxchg(tree, offset, entry,
NULL, GFP_KERNEL) !=3D entry)" is too long and complicated inside the if
condition. That is just me. Not a big deal.

>
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
>
> Why do we need to initialize the pool here? Is this is a bug fix for an
> existing problem or just keeping things clean? Either way I think it
> should be done separately, unless it is related to a change in this
> patch.

I notice the entry->pool will leave uninitialized. I think it should
be cleaned up. It is a clean up, it does not need to happen in this
patch. I can do that as a separate patch.

>
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
>
> Let's remove this comment while we are here, it's pointless AFAICT.

Sure.

>
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
>
> I think this can be made simpler if we open code xa_store() here,
> especially that we already have cleanup code below under 'check_old'
> that removes the exisitng old entry. So zswap_xa_insert() replicates
> this cleanup, then we add this 'old_erased' boolean to avoid doing the
> cleanup below. It seems like it would much more straightforward with
> open-coding xa_store() here and relying on the existing cleanup for the
> old entry.  Also, if we initialize 'old' to NULL, we can use its value
> to figure out whether any cleanup is needed under 'check_old' or not.

I think that is very similar to what Chengming was suggesting.

>
> Taking a step back, I think we can further simplify this. What if we
> move the tree insertion to right after we allocate the zswap entry? In
> this case, if the tree insertion fails, we don't need to decrement the
> same filled counter. If the tree insertion succeeds and then something
> else fails, the existing cleanup code under 'check_old' will already
> clean up the tree insertion for us.

That will create complications that, if the zswap compression fails
the compression ratio, you will have to remove the entry from the tree
as clean up. You have both xa_store() and xa_erase() where the current
code just does one xa_erase() on compression failure.

>
> If this works, we don't need to add extra cleanup code or move any code
> around. Something like:

Due to the extra xa_insert() on compression failure, I think
Chengming's or your earlier suggestion is better.

BTW, while you are here, can you confirm this race discussed in
earlier email can't happen? Chengming convinced me this shouldn't
happen. Like to hear your thoughts.

 CPU1                         CPU2

xa_store()
                                   entry =3D xa_erase()
                                   zswap_free_entry(entry)

if (entry->length)
     ...
CPU1 is using entry after free.

Chris


>
>         entry =3D zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
>         if (!entry) {
>                 zswap_reject_kmemcache_fail++;
>                 goto reject;
>         }
>
>         old =3D xa_store(tree, offset, entry, GFP_KERNEL);
>         if (xa_is_err(old)) {
>                 old =3D NULL;
>                 goto freepage;
>         }
>         if (old)
>                 zswap_free_entry(old);
>
>         ...
> check_old:
>         if (!old) {
>                 old =3D xa_erase(tree, offset);
>                 if (old)
>                         zswap_entry_free(old);
>         }
>
>
> WDYT?
>
> > +             goto insert_failed;
> >       }
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
> >  put_pool:
> >       zswap_pool_put(entry->pool);
> >  freepage:
> > @@ -1592,17 +1556,19 @@ bool zswap_store(struct folio *folio)
> >  reject:
> >       if (objcg)
> >               obj_cgroup_put(objcg);
> > +
> > +     if (old_erased)
> > +             goto failed;
> >  check_old:
> >       /*
> >        * If the zswap store fails or zswap is disabled, we must invalid=
ate the
> >        * possibly stale entry which was previously stored at this offse=
t.
> >        * Otherwise, writeback could overwrite the new data in the swapf=
ile.
> >        */
> > -     spin_lock(&tree->lock);
> > -     entry =3D zswap_rb_search(&tree->rbroot, offset);
> > +     entry =3D xa_erase(tree, offset);
> >       if (entry)
> > -             zswap_invalidate_entry(tree, entry);
> > -     spin_unlock(&tree->lock);
> > +             zswap_entry_free(entry);
> > +failed:
> >       return false;
> >
> >  shrink:
> [..]
>

