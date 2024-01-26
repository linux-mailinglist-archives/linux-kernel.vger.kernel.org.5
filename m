Return-Path: <linux-kernel+bounces-40593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA75483E2F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213DA284A07
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494AD225D7;
	Fri, 26 Jan 2024 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM5MMvQY"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD4224C9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298620; cv=none; b=U9qoZCKG7EjqvK3hQgub9gknBXv/SQOFMWXoZRjEPNZ+gb7cRsI4ujnXEgsC1FPMmWgvDaYGAmNM/r/GIdecJ401KDCkcGpHBk55AjRZf1Prn9BGrfs/ZL6n5te4oExkpYtZfmulw+sndBrtMRPG4GyKB+JBiwh29SNxQE3dUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298620; c=relaxed/simple;
	bh=pB6m66zMvuy+NXCYVL+ejDonREN2qypx0cDHi92/60I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvTnl3VLRKTYAohd6375UMY1ICdnx52tubLgyXVy29FUlnvpkC6TwUuRbrFbyFhfsI2T2ue3eKCiCE/p/vj2wAs3+Mv0F5AatDMP9ZeUp3hr6OdSv5mt0XkCMqv/M/mQO1e8PfhpeXplrGyoR5CKepZJx6RUA70QO03/+FRmARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LM5MMvQY; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bc332d49f6so25550639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706298618; x=1706903418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/RZai6HUgjRWXyUmKvzkgT8r0BpBtfIv052I66rM20=;
        b=LM5MMvQYCe5bcsVPQvi/JVezOQ8+KxL2wRqfLmMB364b0kBXhvmCAmqOqLaG9oVTEC
         UP2gAelaO7fOaKGwPXxP5Qz5pSDv32ONse86FO9hDvh0W33DtuQMD0MwiK5UjgMEoKGq
         ChYbUQyLnpecDeVb02VXBTXbemKtnqSAkkFw3FVUcYwvKorr5tL7/mWr6R1/gtWQ95QD
         KOZbJB7lE22YR4mjkSdcx84adhDvjE4cil835D5RM55LTtQmUDXMDNnIIN95jvgyiBEs
         BNJ3JgRqOUZNIMIIhbS7goTt1dD3p7IFTxTF/Q4oHhCDpspn63smEMeWW3GFezpYjOmG
         oJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706298618; x=1706903418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/RZai6HUgjRWXyUmKvzkgT8r0BpBtfIv052I66rM20=;
        b=QF1St2T5oM3JQ7PXpsdzHbhgXhsjeYs9NUNUsJtONA5ybavRKC0DqHnL+Y2l1Bd++a
         oulLSuHpvKTBddu/ZP/n5w7a28YL8K+J0m+uD64Yzn0l6E9Jj1EA5pUmaV256yqS0V43
         btAzt68ntdmDcB6DEh7/f0oiYhGC6VYii+x0vG5mwfYd3Pc8wW3MRwpxtI46gKalw0HP
         cOO+4tbzzgR24xES/9jDCtkh32DhwG312KlAzGmsAbvxchH7/UU1Nr6mRkemoul2uKAk
         eTWZM01AbDHRTdHEuM7twIIbIy0/pisNUqTOzCpWHIYdT3b/ODFQbOmbwxyCnUSfRWyF
         cGiQ==
X-Gm-Message-State: AOJu0Yy4cCjx0yEoJC5301kDLrJ+GlYNlL7wXgcuz2wOB6PdB0y81+iw
	uqMKD/IQpxDX4+eJT/5Y3TpglJamIoQX0/t/dsBe8O1++aPvW8reaCWg0zaGbupKVi8PTohkIAw
	0xwAFXUg5x0vP43bRPG43B7TEFXo=
X-Google-Smtp-Source: AGHT+IEa2kBPvyEOiAmw17/hr9ej+Kvvst2P1HMnsXDFWJhU5/rWNuB+ygtHZQCtdeo7VrnwnFFxxTJdeM+jUDp5a6c=
X-Received: by 2002:a92:d34c:0:b0:362:8558:f603 with SMTP id
 a12-20020a92d34c000000b003628558f603mr279260ilh.22.1706298617799; Fri, 26 Jan
 2024 11:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126083015.3557006-1-chengming.zhou@linux.dev> <20240126083015.3557006-2-chengming.zhou@linux.dev>
In-Reply-To: <20240126083015.3557006-2-chengming.zhou@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 26 Jan 2024 11:50:06 -0800
Message-ID: <CAKEwX=OP_32757xb6ogZ5OaDk_6bhkm--F4akhQ-tj_WTzA4CA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/zswap: fix race between lru writeback and swapoff
To: chengming.zhou@linux.dev
Cc: hannes@cmpxchg.org, yosryahmed@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 12:32=E2=80=AFAM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> LRU writeback has race problem with swapoff, as spotted by Yosry[1]:
>
> CPU1                    CPU2
> shrink_memcg_cb         swap_off
>   list_lru_isolate        zswap_invalidate
>                           zswap_swapoff
>                             kfree(tree)
>   // UAF
>   spin_lock(&tree->lock)
>
> The problem is that the entry in lru list can't protect the tree from
> being swapoff and freed, and the entry also can be invalidated and freed
> concurrently after we unlock the lru lock.
>
> We can fix it by moving the swap cache allocation ahead before
> referencing the tree, then check invalidate race with tree lock,
> only after that we can safely deref the entry. Note we couldn't
> deref entry or tree anymore after we unlock the folio, since we
> depend on this to hold on swapoff.
>
> So this patch moves all tree and entry usage to zswap_writeback_entry(),
> we only use the copied swpentry on the stack to allocate swap cache
> and return with folio locked, after which we can reference the tree.
> Then check invalidate race with tree lock, the following things is
> much the same like zswap_load().
>
> Since we can't deref the entry after zswap_writeback_entry(), we
> can't use zswap_lru_putback() anymore, instead we rotate the entry

I added list_lru_putback to the list_lru API specifically for this use
case (zswap_lru_putback()). Now that we no longer need it, maybe we
can also remove this as well (assuming no-one else is using this?).

This can be done in a separate patch though.

> in the LRU list so concurrent reclaimers have little chance to see it.
> Or it will be deleted from LRU list if writeback success.
>
> Another confusing part to me is the update of memcg nr_zswap_protected
> in zswap_lru_putback(). I'm not sure why it's needed here since
> if we raced with swapin, memcg nr_zswap_protected has already been
> updated in zswap_folio_swapin(). So not include this part for now.
>
> [1] https://lore.kernel.org/all/CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kms=
vz8CKRG_EA@mail.gmail.com/
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

LGTM! This is quite elegant.
Acked-by: Nhat Pham <nphamcs@gmail.com>

> ---
>  mm/zswap.c | 93 ++++++++++++++++++------------------------------------
>  1 file changed, 31 insertions(+), 62 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 81cb3790e0dd..fa2bdb7ec1d8 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -277,7 +277,7 @@ static inline struct zswap_tree *swap_zswap_tree(swp_=
entry_t swp)
>                  zpool_get_type((p)->zpools[0]))
>
>  static int zswap_writeback_entry(struct zswap_entry *entry,
> -                                struct zswap_tree *tree);
> +                                swp_entry_t swpentry);
>  static int zswap_pool_get(struct zswap_pool *pool);
>  static void zswap_pool_put(struct zswap_pool *pool);
>
> @@ -445,27 +445,6 @@ static void zswap_lru_del(struct list_lru *list_lru,=
 struct zswap_entry *entry)
>         rcu_read_unlock();
>  }
>
> -static void zswap_lru_putback(struct list_lru *list_lru,
> -               struct zswap_entry *entry)
> -{
> -       int nid =3D entry_to_nid(entry);
> -       spinlock_t *lock =3D &list_lru->node[nid].lock;
> -       struct mem_cgroup *memcg;
> -       struct lruvec *lruvec;
> -
> -       rcu_read_lock();
> -       memcg =3D mem_cgroup_from_entry(entry);
> -       spin_lock(lock);
> -       /* we cannot use list_lru_add here, because it increments node's =
lru count */
> -       list_lru_putback(list_lru, &entry->lru, nid, memcg);
> -       spin_unlock(lock);
> -
> -       lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(entry_to_nid(entry)=
));
> -       /* increment the protection area to account for the LRU rotation.=
 */
> -       atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
> -       rcu_read_unlock();
> -}
> -
>  /*********************************
>  * rbtree functions
>  **********************************/
> @@ -860,40 +839,34 @@ static enum lru_status shrink_memcg_cb(struct list_=
head *item, struct list_lru_o
>  {
>         struct zswap_entry *entry =3D container_of(item, struct zswap_ent=
ry, lru);
>         bool *encountered_page_in_swapcache =3D (bool *)arg;
> -       struct zswap_tree *tree;
> -       pgoff_t swpoffset;
> +       swp_entry_t swpentry;
>         enum lru_status ret =3D LRU_REMOVED_RETRY;
>         int writeback_result;
>
> +       /*
> +        * First rotate to the tail of lru list before unlocking lru lock=
,
> +        * so the concurrent reclaimers have little chance to see it.
> +        * It will be deleted from the lru list if writeback success.
> +        */
> +       list_move_tail(item, &l->list);
> +
>         /*
>          * Once the lru lock is dropped, the entry might get freed. The
> -        * swpoffset is copied to the stack, and entry isn't deref'd agai=
n
> +        * swpentry is copied to the stack, and entry isn't deref'd again
>          * until the entry is verified to still be alive in the tree.
>          */
> -       swpoffset =3D swp_offset(entry->swpentry);
> -       tree =3D swap_zswap_tree(entry->swpentry);
> -       list_lru_isolate(l, item);

nit: IIUC, now that we're no longer removing the entry from the
list_lru, we protect against concurrent shrinking action via this
check inside zswap_writeback_entry() too right:

if (!folio_was_allocated) {
   folio_put(folio);
   return -EEXIST;
}

Maybe update the comment above it too?

> +       swpentry =3D entry->swpentry;
> +
>         /*
>          * It's safe to drop the lock here because we return either
>          * LRU_REMOVED_RETRY or LRU_RETRY.
>          */
>         spin_unlock(lock);
>
> -       /* Check for invalidate() race */
> -       spin_lock(&tree->lock);
> -       if (entry !=3D zswap_rb_search(&tree->rbroot, swpoffset))
> -               goto unlock;
> -
> -       /* Hold a reference to prevent a free during writeback */
> -       zswap_entry_get(entry);
> -       spin_unlock(&tree->lock);
> -
> -       writeback_result =3D zswap_writeback_entry(entry, tree);
> +       writeback_result =3D zswap_writeback_entry(entry, swpentry);
>
> -       spin_lock(&tree->lock);
>         if (writeback_result) {
>                 zswap_reject_reclaim_fail++;
> -               zswap_lru_putback(&entry->pool->list_lru, entry);
>                 ret =3D LRU_RETRY;
>
>                 /*
> @@ -903,27 +876,10 @@ static enum lru_status shrink_memcg_cb(struct list_=
head *item, struct list_lru_o
>                  */
>                 if (writeback_result =3D=3D -EEXIST && encountered_page_i=
n_swapcache)
>                         *encountered_page_in_swapcache =3D true;
> -
> -               goto put_unlock;
> +       } else {
> +               zswap_written_back_pages++;
>         }
> -       zswap_written_back_pages++;
> -
> -       if (entry->objcg)
> -               count_objcg_event(entry->objcg, ZSWPWB);
> -
> -       count_vm_event(ZSWPWB);
> -       /*
> -        * Writeback started successfully, the page now belongs to the
> -        * swapcache. Drop the entry from zswap - unless invalidate alrea=
dy
> -        * took it out while we had the tree->lock released for IO.
> -        */
> -       zswap_invalidate_entry(tree, entry);
>
> -put_unlock:
> -       /* Drop local reference */
> -       zswap_entry_put(entry);
> -unlock:
> -       spin_unlock(&tree->lock);
>         spin_lock(lock);
>         return ret;
>  }
> @@ -1408,9 +1364,9 @@ static void __zswap_load(struct zswap_entry *entry,=
 struct page *page)
>   * freed.
>   */
>  static int zswap_writeback_entry(struct zswap_entry *entry,
> -                                struct zswap_tree *tree)
> +                                swp_entry_t swpentry)
>  {
> -       swp_entry_t swpentry =3D entry->swpentry;
> +       struct zswap_tree *tree;
>         struct folio *folio;
>         struct mempolicy *mpol;
>         bool folio_was_allocated;
> @@ -1442,18 +1398,31 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>          * backs (our zswap_entry reference doesn't prevent that), to
>          * avoid overwriting a new swap folio with old compressed data.
>          */
> +       tree =3D swap_zswap_tree(swpentry);
>         spin_lock(&tree->lock);
> -       if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) !=
=3D entry) {
> +       if (zswap_rb_search(&tree->rbroot, swp_offset(swpentry)) !=3D ent=
ry) {
>                 spin_unlock(&tree->lock);
>                 delete_from_swap_cache(folio);
>                 folio_unlock(folio);
>                 folio_put(folio);
>                 return -ENOMEM;
>         }
> +
> +       /* Safe to deref entry after the entry is verified above. */
> +       zswap_entry_get(entry);
>         spin_unlock(&tree->lock);
>
>         __zswap_load(entry, &folio->page);
>
> +       count_vm_event(ZSWPWB);
> +       if (entry->objcg)
> +               count_objcg_event(entry->objcg, ZSWPWB);
> +
> +       spin_lock(&tree->lock);
> +       zswap_invalidate_entry(tree, entry);
> +       zswap_entry_put(entry);
> +       spin_unlock(&tree->lock);
> +
>         /* folio is up to date */
>         folio_mark_uptodate(folio);
>
> --
> 2.40.1
>

