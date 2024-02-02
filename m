Return-Path: <linux-kernel+bounces-50671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E288847C59
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6001F24BD3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB7A85937;
	Fri,  2 Feb 2024 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsZM/qmA"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BDA8592F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913231; cv=none; b=c+U6Ua4eypT5SKo7XIM0k+fw99Uzg7L2vbLFXj1Em+xxKXfRJn6cIjAlXs4KfYHi+pqxv6B6ho5flwj+9OUzH9aStzgtvHJbVjvLc7QAwNilwkjDNdyiUAQEjcLtm2oATDjyLorZZJfd4K4nPYx7xI4gkBNa0DCuLXbz8JyN+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913231; c=relaxed/simple;
	bh=Cob0rBzABNwLhCxk9USGBwwUPThucrjRE9og1HgiYVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4y7buIDM99lZRy90I3HZjiJ/jhvZmWr6hkaua79OTn7GTsf2Rzsa2LRXA0itqwGD2JDH/gOYB7G04SqV52C3kP7N16pRiTBMpowpkmGuv1kmt2Ylc+OfH58Fvh3Xrn+08ChbKDUDhqjIIDJBlx7rIuey/ghCz6OuBvKGT6H63A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsZM/qmA; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bed8faf6ebso103409639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 14:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706913228; x=1707518028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bGR4OmpODNoxu6BbozXZQv938jautOfwfQRasaHogc=;
        b=hsZM/qmACYj/waF939IezBnbZzy/hjIs7j+iJFTd5n0NjJzJhamkjIxdYOmtMzsAQv
         j9vHy1OgqzNQWgdv6j3Jqw7NCiDw2PSq8wOY/RO5ixxatf9w7BBks/6IofFAVgWjQVon
         SV7Tl7CYc65Yj0SenvwFdUc+VImXX+HCKogQlqxH+DZtP0/ddurP/VWrHmcOfzVj3wWM
         pDyyD977Er5Xrjll9C1nEoLFBe1ua+J/8CMJET0e0uncfimti5Ihh223QqNyUfjNCCQ1
         pv7mr0++G2gFOilL1GDGt7rzRhoVSG4uxKleF+moPY2WsSk6rJRVf7siwosAtzqNwA1x
         +U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706913228; x=1707518028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bGR4OmpODNoxu6BbozXZQv938jautOfwfQRasaHogc=;
        b=RXVqc40AbOvk51/b8dbl5oj5GR8yT6adVzaxbgtxw/2tExPmuuPlLMHWDR8Os7YzA0
         FOTg4a0U4614sC5ajX4ukgtkBqO1JE1RTwYnqmdseC/smLCadY2+VvGCZRLF0b/i8P7S
         3N4IDTG41sweLajPkCcl2qIpoU9227bj7utrEfoLATKRytC1x4oIFk2iCk52RBZ9hViz
         o9mUJz1DxYZcUdTyERmkDiqWfCutQcy7LpyJjQvUEHOD1sagmG2G8x2vgkeIuJi5kZgi
         nfTjKubMDu6rp/NqFIDNY46iQJtUF56lFO6tj7FYcTjw29AztZqJhnN2Itu3TVD5tkbC
         dFHw==
X-Gm-Message-State: AOJu0YxCG8ANGmhbZ1XOCgUN2shFgh5oAHi6lH5LPqktUNAeZYnidx74
	VKGSuj+HK0rOeiZWkYPrEU285WGaOv/hTB1kK4Pvpl+EmiMlLsWkyKwh4kdXLsCM3OOpYBay1qE
	RH3+8/JFVd3Dc6kIkNBFLxo/u+dY=
X-Google-Smtp-Source: AGHT+IE5HMQzIc+TArWe0msfKNUe5klDoyOrIKRejzpI4XPX5Qk1PrySY4hq5sY2kslVXNINfUOwZasIbFSwZ8mozlo=
X-Received: by 2002:a05:6602:583:b0:7c0:35ac:dab8 with SMTP id
 v3-20020a056602058300b007c035acdab8mr3484746iox.1.1706913228646; Fri, 02 Feb
 2024 14:33:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-6-56ed496b6e55@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-6-56ed496b6e55@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 2 Feb 2024 14:33:37 -0800
Message-ID: <CAKEwX=MOcmUjtrYOJCwh3unRT7OKdrvtR-FFdSevNf5i7z=Q=A@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm/zswap: zswap entry doesn't need refcount anymore
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:50=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Since we don't need to leave zswap entry on the zswap tree anymore,
> we should remove it from tree once we find it from the tree.
>
> Then after using it, we can directly free it, no concurrent path
> can find it from tree. Only the shrinker can see it from lru list,
> which will also double check under tree lock, so no race problem.
>
> So we don't need refcount in zswap entry anymore and don't need to
> take the spinlock for the second time to invalidate it.
>
> The side effect is that zswap_entry_free() maybe not happen in tree
> spinlock, but it's ok since nothing need to be protected by the lock.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Oh this is sweet! Fewer things to keep in mind.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

> ---
>  mm/zswap.c | 63 +++++++++++---------------------------------------------=
------
>  1 file changed, 11 insertions(+), 52 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index cbf379abb6c7..cd67f7f6b302 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -193,12 +193,6 @@ struct zswap_pool {
>   *
>   * rbnode - links the entry into red-black tree for the appropriate swap=
 type
>   * swpentry - associated swap entry, the offset indexes into the red-bla=
ck tree
> - * refcount - the number of outstanding reference to the entry. This is =
needed
> - *            to protect against premature freeing of the entry by code
> - *            concurrent calls to load, invalidate, and writeback.  The =
lock
> - *            for the zswap_tree structure that contains the entry must
> - *            be held while changing the refcount.  Since the lock must
> - *            be held, there is no reason to also make refcount atomic.
>   * length - the length in bytes of the compressed page data.  Needed dur=
ing
>   *          decompression. For a same value filled page length is 0, and=
 both
>   *          pool and lru are invalid and must be ignored.
> @@ -211,7 +205,6 @@ struct zswap_pool {
>  struct zswap_entry {
>         struct rb_node rbnode;
>         swp_entry_t swpentry;
> -       int refcount;

Hah this should even make zswap a bit more space-efficient. IIRC Yosry
has some analysis regarding how much less efficient zswap will be
every time we add a new field to zswap entry - this should go in the
opposite direction :)

>         unsigned int length;
>         struct zswap_pool *pool;
>         union {
> @@ -222,11 +215,6 @@ struct zswap_entry {
>         struct list_head lru;
>  };
>
> -/*
> - * The tree lock in the zswap_tree struct protects a few things:
> - * - the rbtree
> - * - the refcount field of each entry in the tree
> - */
>  struct zswap_tree {
>         struct rb_root rbroot;
>         spinlock_t lock;
> @@ -890,14 +878,10 @@ static int zswap_rb_insert(struct rb_root *root, st=
ruct zswap_entry *entry,
>         return 0;
>  }
>
> -static bool zswap_rb_erase(struct rb_root *root, struct zswap_entry *ent=
ry)
> +static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *ent=
ry)
>  {
> -       if (!RB_EMPTY_NODE(&entry->rbnode)) {
> -               rb_erase(&entry->rbnode, root);
> -               RB_CLEAR_NODE(&entry->rbnode);
> -               return true;
> -       }
> -       return false;
> +       rb_erase(&entry->rbnode, root);
> +       RB_CLEAR_NODE(&entry->rbnode);
>  }
>
>  /*********************************
> @@ -911,7 +895,6 @@ static struct zswap_entry *zswap_entry_cache_alloc(gf=
p_t gfp, int nid)
>         entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
>         if (!entry)
>                 return NULL;
> -       entry->refcount =3D 1;
>         RB_CLEAR_NODE(&entry->rbnode);
>         return entry;
>  }
> @@ -954,33 +937,15 @@ static void zswap_entry_free(struct zswap_entry *en=
try)
>         zswap_update_total_size();
>  }
>
> -/* caller must hold the tree lock */
> -static void zswap_entry_get(struct zswap_entry *entry)
> -{
> -       WARN_ON_ONCE(!entry->refcount);
> -       entry->refcount++;
> -}
> -
> -/* caller must hold the tree lock */
> -static void zswap_entry_put(struct zswap_entry *entry)
> -{
> -       WARN_ON_ONCE(!entry->refcount);
> -       if (--entry->refcount =3D=3D 0) {
> -               WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
> -               zswap_entry_free(entry);
> -       }
> -}
> -
>  /*
> - * If the entry is still valid in the tree, drop the initial ref and rem=
ove it
> - * from the tree. This function must be called with an additional ref he=
ld,
> - * otherwise it may race with another invalidation freeing the entry.
> + * The caller hold the tree lock and search the entry from the tree,
> + * so it must be on the tree, remove it from the tree and free it.
>   */
>  static void zswap_invalidate_entry(struct zswap_tree *tree,
>                                    struct zswap_entry *entry)
>  {
> -       if (zswap_rb_erase(&tree->rbroot, entry))
> -               zswap_entry_put(entry);
> +       zswap_rb_erase(&tree->rbroot, entry);
> +       zswap_entry_free(entry);
>  }
>
>  /*********************************
> @@ -1219,7 +1184,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         }
>
>         /* Safe to deref entry after the entry is verified above. */
> -       zswap_entry_get(entry);
> +       zswap_rb_erase(&tree->rbroot, entry);
>         spin_unlock(&tree->lock);
>
>         zswap_decompress(entry, &folio->page);
> @@ -1228,10 +1193,7 @@ static int zswap_writeback_entry(struct zswap_entr=
y *entry,
>         if (entry->objcg)
>                 count_objcg_event(entry->objcg, ZSWPWB);
>
> -       spin_lock(&tree->lock);
> -       zswap_invalidate_entry(tree, entry);
> -       zswap_entry_put(entry);
> -       spin_unlock(&tree->lock);
> +       zswap_entry_free(entry);
>
>         /* folio is up to date */
>         folio_mark_uptodate(folio);
> @@ -1702,7 +1664,7 @@ bool zswap_load(struct folio *folio)
>                 spin_unlock(&tree->lock);
>                 return false;
>         }
> -       zswap_entry_get(entry);
> +       zswap_rb_erase(&tree->rbroot, entry);
>         spin_unlock(&tree->lock);
>
>         if (entry->length)
> @@ -1717,10 +1679,7 @@ bool zswap_load(struct folio *folio)
>         if (entry->objcg)
>                 count_objcg_event(entry->objcg, ZSWPIN);
>
> -       spin_lock(&tree->lock);
> -       zswap_invalidate_entry(tree, entry);
> -       zswap_entry_put(entry);
> -       spin_unlock(&tree->lock);
> +       zswap_entry_free(entry);
>
>         folio_mark_dirty(folio);
>
>
> --
> b4 0.10.1

