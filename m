Return-Path: <linux-kernel+bounces-123434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C53E890890
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778891F25F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E892136E2D;
	Thu, 28 Mar 2024 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2ZLQbnB"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD545A783
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651785; cv=none; b=QM3832AAGWAvwUeFBmTSiOWzGbBHDDyCKzCMUXkP4CJWhplYUpvAs5Jq79FX59w6BvUJdalydbGxosKidfKzY4CYeYxvpamWeZRthhlAA1pi+0bcduZa5+A/6AG8H09dAEPJXe3SoQqmg9f9ZrH4qQNEtmG8HI1J0Sox1UsLjAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651785; c=relaxed/simple;
	bh=2PInyjZpRmisKFARoepyqgxGDaf7aVgfmRq5Cu4vjiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2WIBRbkkRBdCRRpY76s1GrBa08CTOcCo3VbNhklemCbptQdprWUU0cvXQxPICMPEK9S/Z6rQltSYiTaW+qjXJWEcfCdrOudr1ioh1zAZkB51ej/IWUwxLhdKtjpHcV4d1Yyebp3sHPcyLBn6gsfpVa/YMkDh5/RmmDTag7cSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T2ZLQbnB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46d0a8399aso400298866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711651782; x=1712256582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdHBlrZAB65x1VfSv8cps7MnEoo8Xx6SN37qBYrgmeg=;
        b=T2ZLQbnBcl7gjqlTxwJJgVIZYTGVTDXfPo3R7FVUKO1dZrXYv1nOLQTRvciId+5+e/
         1mxzt08fHuBxO7nzuopKwKbWWjL043FeLCRvFCSUKd2T7B6r3O3ygbdNWO40zfvj7uZz
         vqTTK/mc52jXq0BKXz5+dIMGKsh/WhbvI2hzBI4SyUmTZHggH6KszWjT/51N6NK+hxqQ
         rpAKaxuzRsvmmzDZEuzTnuL/hYECVnL90tP4pA6uUtjzbhiM/pzhqLLGx1RiITVudpUw
         KvHOB+finM2xjCr6p2pANHgcuc5CvgvLqwOPy5f2Ir0oaanS07EPShoPKQZyMVhBHZcr
         eFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711651782; x=1712256582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdHBlrZAB65x1VfSv8cps7MnEoo8Xx6SN37qBYrgmeg=;
        b=WHc4U/8JONtkFwa1mV9F5e/UA6ZodZaNWzcXhEwMy+8UOv1i+a7zvzsVGbxjm4NYD2
         JVTnXv04Bo9fD5fzr62zJjW3dawqhe4K56mH8QeUT6F7ln8u0Rn6u7Lcd5PscYvDGFXs
         HEqR3VuqO/XsnjRNeG3yzPvnzV690C9cDJdbZjpL7uXBWErEsacQE2J2DGj1WcadTLMj
         r3iZk95A7oz6tAYK/IyXLSheNtJthYubplgRAeXPNWBfDWGWEcdpMTOalH0b6rSx/lZw
         rrW6hUD0dfK6rT8EmBkLgjYNglVUBgDn5li63VaIKHjfJW8vFYyHcqaauDHHrZ0kV6rk
         PXCA==
X-Forwarded-Encrypted: i=1; AJvYcCUY23qSQEDGNRjim0eyM/Lq3t4ZRSbMeTXwmpFBS4kFZe7A0MKPIrXnxqZcZ1QbHPONph7zZh2gSOQ3omPl4Rv9OTH5OfmJQIjnz9Mu
X-Gm-Message-State: AOJu0YzWUCnZqIlGyo92ZvQS4pBjQfMiQGA18HC7XJVXhtbZl9W8A/Q9
	LLUQe1Jfh+nPI4nGBBcsyA97KIQz/1OUHyCZA973qCkDogJmV8RjW4PEYZLtpLIL/2rE+9alB0I
	luKPe5FuNYbE14+k68pU5Bm2jZH3oNXZLr1SQ
X-Google-Smtp-Source: AGHT+IHYmFh/INcEoVPMr6ixtdwubF7uOfhWzJkkfI4MhRm+6XvnlLhUU23rZ/elxyWop/TyT/OotjlPE2jyvPgEYE0=
X-Received: by 2002:a17:906:484:b0:a47:2011:11c1 with SMTP id
 f4-20020a170906048400b00a47201111c1mr248066eja.8.1711651781809; Thu, 28 Mar
 2024 11:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-10-yosryahmed@google.com> <6352794b-f5a2-4525-8185-c910739683e6@linux.dev>
In-Reply-To: <6352794b-f5a2-4525-8185-c910739683e6@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 28 Mar 2024 11:49:05 -0700
Message-ID: <CAJD7tkYVSn44-+S=HT_U8166gYVWdLET4KQY50JgNmNidfB6Zg@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] mm: zswap: use zswap_entry_free() for partially
 initialized entries
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 1:31=E2=80=AFAM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> On 2024/3/26 07:50, Yosry Ahmed wrote:
> > zswap_entry_free() performs four types of cleanups before freeing a
> > zswap_entry:
> > - Deletes the entry from the LRU.
> > - Frees compressed memory.
> > - Puts the pool reference.
> > - Uncharges the compressed memory and puts the objcg.
> >
> > zswap_entry_free() always expects a fully initialized entry. Allow
> > zswap_entry_free() to handle partially initialized entries by making it
> > possible to identify what cleanups are needed as follows:
> > - Allocate entries with __GFP_ZERO and initialize zswap_entry.lru when
> >   the entry is allocated. Points are NULL and length is zero upon
> >   initialization.
> > - Use zswap_entry.length to identify if there is compressed memory to
> >   free. This is possible now that zero-filled pages are handled
> >   separately, so a length of zero means we did not successfully compres=
s
> >   the page.
> > - Only initialize entry->objcg after the memory is charged in
> >   zswap_store().
> >
> > With this in place, use zswap_entry_free() in the failure path of
> > zswap_store() to cleanup partially initialized entries. This simplifies
> > the cleanup code in zswap_store(). While we are at it, rename the
> > remaining cleanup labels to more meaningful names.
>
> Not sure if it's worthwhile to clean up the fail path with the normal pat=
h
> gets a little verbose.

I was on the fence about this, so I  thought I would just send it and
see what others think.

On one hand it makes the initialization more robust because the
zswap_entry is always in a clean identifiable state, but on the other
hand it adds churn to the normal path as you noticed. Also after
removing handling zero-length entries from the failure path it isn't
that bad without this patch anyway.

So if no one else thinks this is useful, I will drop the patch in the
next version.

Thanks!

>
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  mm/zswap.c | 62 ++++++++++++++++++++++++++----------------------------
> >  1 file changed, 30 insertions(+), 32 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 9357328d940af..c50f9df230ca3 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -774,12 +774,13 @@ void zswap_memcg_offline_cleanup(struct mem_cgrou=
p *memcg)
> >  **********************************/
> >  static struct kmem_cache *zswap_entry_cache;
> >
> > -static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
> > +static struct zswap_entry *zswap_entry_cache_alloc(int nid)
> >  {
> >       struct zswap_entry *entry;
> > -     entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
> > -     if (!entry)
> > -             return NULL;
> > +     entry =3D kmem_cache_alloc_node(zswap_entry_cache,
> > +                                   GFP_KERNEL | __GFP_ZERO, nid);
> > +     if (entry)
> > +             INIT_LIST_HEAD(&entry->lru);
> >       return entry;
> >  }
> >
> > @@ -795,9 +796,12 @@ static struct zpool *zswap_find_zpool(struct zswap=
_entry *entry)
> >
> >  static void zswap_entry_free(struct zswap_entry *entry)
> >  {
> > -     zswap_lru_del(&zswap_list_lru, entry);
> > -     zpool_free(zswap_find_zpool(entry), entry->handle);
> > -     zswap_pool_put(entry->pool);
> > +     if (!list_empty(&entry->lru))
> > +             zswap_lru_del(&zswap_list_lru, entry);
> > +     if (entry->length)
> > +             zpool_free(zswap_find_zpool(entry), entry->handle);
> > +     if (entry->pool)
> > +             zswap_pool_put(entry->pool);
> >       if (entry->objcg) {
> >               obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
> >               obj_cgroup_put(entry->objcg);
> > @@ -1447,7 +1451,7 @@ bool zswap_store(struct folio *folio)
> >               return false;
> >
> >       if (!zswap_enabled)
> > -             goto check_old;
> > +             goto erase_old;
> >
> >       /* Check cgroup limits */
> >       objcg =3D get_obj_cgroup_from_folio(folio);
> > @@ -1455,54 +1459,52 @@ bool zswap_store(struct folio *folio)
> >               memcg =3D get_mem_cgroup_from_objcg(objcg);
> >               if (shrink_memcg(memcg)) {
> >                       mem_cgroup_put(memcg);
> > -                     goto reject;
> > +                     goto put_objcg;
> >               }
> >               mem_cgroup_put(memcg);
> >       }
> >
> >       if (zswap_is_folio_zero_filled(folio)) {
> >               if (zswap_store_zero_filled(tree, offset, objcg))
> > -                     goto reject;
> > +                     goto put_objcg;
> >               goto stored;
> >       }
> >
> >       if (!zswap_non_zero_filled_pages_enabled)
> > -             goto reject;
> > +             goto put_objcg;
> >
> >       if (!zswap_check_limit())
> > -             goto reject;
> > +             goto put_objcg;
> >
> > -     entry =3D zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
> > +     entry =3D zswap_entry_cache_alloc(folio_nid(folio));
> >       if (!entry) {
> >               zswap_reject_kmemcache_fail++;
> > -             goto reject;
> > +             goto put_objcg;
> >       }
> >
> > -     /* if entry is successfully added, it keeps the reference */
> >       entry->pool =3D zswap_pool_current_get();
> >       if (!entry->pool)
> > -             goto freepage;
> > +             goto free_entry;
> >
> >       if (objcg) {
> >               memcg =3D get_mem_cgroup_from_objcg(objcg);
> >               if (memcg_list_lru_alloc(memcg, &zswap_list_lru, GFP_KERN=
EL)) {
> >                       mem_cgroup_put(memcg);
> > -                     goto put_pool;
> > +                     goto free_entry;
> >               }
> >               mem_cgroup_put(memcg);
> >       }
> >
> >       if (!zswap_compress(folio, entry))
> > -             goto put_pool;
> > -
> > -     entry->swpentry =3D swp;
> > -     entry->objcg =3D objcg;
> > +             goto free_entry;
> >
> >       if (zswap_tree_store(tree, offset, entry))
> > -             goto store_failed;
> > +             goto free_entry;
> >
> > -     if (objcg)
> > +     if (objcg) {
> >               obj_cgroup_charge_zswap(objcg, entry->length);
> > +             entry->objcg =3D objcg;
> > +     }
> >
> >       /*
> >        * We finish initializing the entry while it's already in xarray.
> > @@ -1514,7 +1516,7 @@ bool zswap_store(struct folio *folio)
> >        *    The publishing order matters to prevent writeback from seei=
ng
> >        *    an incoherent entry.
> >        */
> > -     INIT_LIST_HEAD(&entry->lru);
> > +     entry->swpentry =3D swp;
> >       zswap_lru_add(&zswap_list_lru, entry);
> >
> >  stored:
> > @@ -1525,17 +1527,13 @@ bool zswap_store(struct folio *folio)
> >
> >       return true;
> >
> > -store_failed:
> > -     zpool_free(zswap_find_zpool(entry), entry->handle);
> > -put_pool:
> > -     zswap_pool_put(entry->pool);
> > -freepage:
> > -     zswap_entry_cache_free(entry);
> > -reject:
> > +free_entry:
> > +     zswap_entry_free(entry);
> > +put_objcg:
> >       obj_cgroup_put(objcg);
> >       if (zswap_pool_reached_full)
> >               queue_work(shrink_wq, &zswap_shrink_work);
> > -check_old:
> > +erase_old:
> >       /*
> >        * If the zswap store fails or zswap is disabled, we must invalid=
ate the
> >        * possibly stale entry which was previously stored at this offse=
t.

