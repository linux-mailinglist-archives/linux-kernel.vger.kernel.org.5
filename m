Return-Path: <linux-kernel+bounces-144763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9978A4A67
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2461A281809
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EEF3A1B0;
	Mon, 15 Apr 2024 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzqsnmMB"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD9339FCF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170092; cv=none; b=R+4PRY1J9ZnCnlq2veDA3Ns/DuNj5xWY6XyiwFWdQ3f6rCeXVG3DwZcfR7gXMvOEZ9yZ0Og2uviJVgaIz9ZitduB9Rrhq87Vwfhf6vy3BU8hkCM4NUYHvLFvq4DtZDBbJWNtux86caVHpf4n1svSVF4lQqY3mGa3HtQqs3wnQCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170092; c=relaxed/simple;
	bh=H97db8m8RgOk4f6D1dbz9LQhSz/eB4DWg4KJekWxG7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZs8v4WBS+PxtdEeKUzDuTyMiuIUDBfCaCUqI3xZHUeEJRoWMMwMq9WirQbDe0fIHS35Z4WG2+FXBcm5p7yfrMXRUMKm/QTPmbcqRrWgdl8l/V94fyjU9gC5JMvTSmLYpXLsM63/eVj7jD0gLyVgZpSxsf7oRCe3ENl1xBaH6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzqsnmMB; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4db24342894so941825e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713170088; x=1713774888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LedHTnwclYNQRJsLLwFB8cr7QNb/neRpprUgOBBR5V4=;
        b=HzqsnmMB525x6dpLDN4Q8qymFlmgdAWc/408TmROp1G9+knFJ1Tkd5foUBieNDbDW+
         3uEtsTlOUAp6WJVrIN9coq9zIMWo8Uzr9InG7omhyFZUxU4keCdDvLwcdrIVvmnOeJPB
         4ZAfjqhSzXsDqDa40j0fQG3ttbWb7d5QyzN2WMnkGK7QRekhB33fxyv1OJhTf1sW5hx5
         8Z1FaWRoEZ/KW2PZRTsLanjynU4GVIzKRi4rSdW0PkEh+8POmZnsohO3wZq5xCMImryC
         2Vew1TcmHvuIED8bJbXvGUmN6XReZdHKa6sfBEHIZeASce01SGgixitOwJDxsjSp7Vp/
         2zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713170088; x=1713774888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LedHTnwclYNQRJsLLwFB8cr7QNb/neRpprUgOBBR5V4=;
        b=c2UY7iy1Z33yFGvJbLmqj/4MEIBZe2jWjRMHKCch6yywR8cvsbqPOVVkOnSdLktU8D
         LSsOxDYQHV0mw2t+ap0jCSSIJD9CLzHspA7ZbzKl+K27MeB9oO6ZTGf/5oCR6g94br8i
         hjCaxwgcJBgH7QgRoUifaMPDfVNCjG/I/naA0eeftHKi+w7RT1Evqe/gFANiz+R0/DEU
         EfaEeiqC2UKmgUNyRAyR3tGcK5s+xxjQDN0u/+rIU8KKbPsOmdX5BorrUd7RfHofUBw4
         aF7yQpFi0xAXpfg2EvojRWDLn+Btbnt5GagQ73o/xcdeE2cXepl9MCm0ygwLwE5tPnWA
         7BIw==
X-Forwarded-Encrypted: i=1; AJvYcCXKMlWEpo8RpqkDAxRdZj1VK6GDQYFLx8EcYAGIPvbpIN5jHYYU9pfr9lXUpBmgj11BlkKWSsh67oSoFbIfzWaO7fVQgaYbTw6Ag+7s
X-Gm-Message-State: AOJu0YxFjuDspyDhkegcsm1zrbZW6Z+MiKTzTBn0iJ93Cx0i9MsZ+qW/
	0O6kI1hpd7Lx8bsD+rGhBXwPvVAUgY4NKJj1tBTq7yzEcX9bJe5eEEhm7aokPpPAC1VKgcaOvKY
	GR7Us/dpWbEr2CNo/gMVQPz20iGw=
X-Google-Smtp-Source: AGHT+IEvrsnjDzsyKbsA/GkLHx2NFevUokJOwMuRYSZAsiVS2Je7OYDgw40PupjWK3lc2vpd87Ie3vfFdN7Bx056Yso=
X-Received: by 2002:a05:6122:ca4:b0:4d4:16ed:3ae4 with SMTP id
 ba36-20020a0561220ca400b004d416ed3ae4mr5790342vkb.14.1713170088139; Mon, 15
 Apr 2024 01:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-2-21cnbao@gmail.com>
 <87y19f2lq3.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yPQyQpWvB2KmuOh2vyUQA0A6hNHsypEC9Gptp9XtuDgg@mail.gmail.com>
 <87jzkz2g3t.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87jzkz2g3t.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 15 Apr 2024 20:34:36 +1200
Message-ID: <CAGsJ_4wm4SfkyTBHpU46EPTFvhq8e54F3KRkKj6gTBcnOjCw1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm: swap: introduce swap_free_nr() for batched swap_free()
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 8:21=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Mon, Apr 15, 2024 at 6:19=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >> >
> >> > While swapping in a large folio, we need to free swaps related to th=
e whole
> >> > folio. To avoid frequently acquiring and releasing swap locks, it is=
 better
> >> > to introduce an API for batched free.
> >> >
> >> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> >> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> > ---
> >> >  include/linux/swap.h |  5 +++++
> >> >  mm/swapfile.c        | 51 +++++++++++++++++++++++++++++++++++++++++=
+++
> >> >  2 files changed, 56 insertions(+)
> >> >
> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> > index 11c53692f65f..b7a107e983b8 100644
> >> > --- a/include/linux/swap.h
> >> > +++ b/include/linux/swap.h
> >> > @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
> >> >  extern int swap_duplicate(swp_entry_t);
> >> >  extern int swapcache_prepare(swp_entry_t);
> >> >  extern void swap_free(swp_entry_t);
> >> > +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> >> >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> >> >  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> >> >  int swap_type_of(dev_t device, sector_t offset);
> >> > @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t swp)
> >> >  {
> >> >  }
> >> >
> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> >> > +{
> >> > +}
> >> > +
> >> >  static inline void put_swap_folio(struct folio *folio, swp_entry_t =
swp)
> >> >  {
> >> >  }
> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> > index 28642c188c93..f4c65aeb088d 100644
> >> > --- a/mm/swapfile.c
> >> > +++ b/mm/swapfile.c
> >> > @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
> >> >               __swap_entry_free(p, entry);
> >> >  }
> >> >
> >> > +/*
> >> > + * Free up the maximum number of swap entries at once to limit the
> >> > + * maximum kernel stack usage.
> >> > + */
> >> > +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLUS=
TER)
> >> > +
> >> > +/*
> >> > + * Called after swapping in a large folio,
> >>
> >> IMHO, it's not good to document the caller in the function definition.
> >> Because this will discourage function reusing.
> >
> > ok. right now there is only one user that is why it is added. but i agr=
ee
> > we can actually remove this.
> >
> >>
> >> > batched free swap entries
> >> > + * for this large folio, entry should be for the first subpage and
> >> > + * its offset is aligned with nr_pages
> >>
> >> Why do we need this?
> >
> > This is a fundamental requirement for the existing kernel, folio's
> > swap offset is naturally aligned from the first moment add_to_swap
> > to add swapcache's xa. so this comment is describing the existing
> > fact. In the future, if we want to support swap-out folio to discontigu=
ous
> > and not-aligned offsets, we can't pass entry as the parameter, we shoul=
d
> > instead pass ptep or another different data struct which can connect
> > multiple discontiguous swap offsets.
> >
> > I feel like we only need "for this large folio, entry should be for
> > the first subpage" and drop "and its offset is aligned with nr_pages",
> > the latter is not important to this context at all.
>
> IIUC, all these are requirements of the only caller now, not the
> function itself.  If only part of the all swap entries of a mTHP are
> called with swap_free_nr(), can swap_free_nr() still do its work?  If
> so, why not make swap_free_nr() as general as possible?

right , i believe we can make swap_free_nr() as general as possible.

>
> >>
> >> > + */
> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> >> > +{
> >> > +     int i, j;
> >> > +     struct swap_cluster_info *ci;
> >> > +     struct swap_info_struct *p;
> >> > +     unsigned int type =3D swp_type(entry);
> >> > +     unsigned long offset =3D swp_offset(entry);
> >> > +     int batch_nr, remain_nr;
> >> > +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
> >> > +
> >> > +     /* all swap entries are within a cluster for mTHP */
> >> > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUS=
TER);
> >> > +
> >> > +     if (nr_pages =3D=3D 1) {
> >> > +             swap_free(entry);
> >> > +             return;
> >> > +     }
> >>
> >> Is it possible to unify swap_free() and swap_free_nr() into one functi=
on
> >> with acceptable performance?  IIUC, the general rule in mTHP effort is
> >> to avoid duplicate functions between mTHP and normal small folio.
> >> Right?
> >
> > I don't see why.
>
> Because duplicated implementation are hard to maintain in the long term.

sorry, i actually meant "I don't see why not",  for some reason, the "not"
was missed. Obviously I meant "why not", there was a "but" after it :-)

>
> > but we have lots of places calling swap_free(), we may
> > have to change them all to call swap_free_nr(entry, 1); the other possi=
ble
> > way is making swap_free() a wrapper of swap_free_nr() always using
> > 1 as the argument. In both cases, we are changing the semantics of
> > swap_free_nr() to partially freeing large folio cases and have to drop
> > "entry should be for the first subpage" then.
> >
> > Right now, the semantics is
> > * swap_free_nr() for an entire large folio;
> > * swap_free() for one entry of either a large folio or a small folio
>
> As above, I don't think the these semantics are important for
> swap_free_nr() implementation.

right. I agree. If we are ready to change all those callers, nothing
can stop us from removing swap_free().

>
> >>
> >> > +
> >> > +     remain_nr =3D nr_pages;
> >> > +     p =3D _swap_info_get(entry);
> >> > +     if (p) {
> >> > +             for (i =3D 0; i < nr_pages; i +=3D batch_nr) {
> >> > +                     batch_nr =3D min_t(int, SWAP_BATCH_NR, remain_=
nr);
> >> > +
> >> > +                     ci =3D lock_cluster_or_swap_info(p, offset);
> >> > +                     for (j =3D 0; j < batch_nr; j++) {
> >> > +                             if (__swap_entry_free_locked(p, offset=
 + i * SWAP_BATCH_NR + j, 1))
> >> > +                                     __bitmap_set(usage, j, 1);
> >> > +                     }
> >> > +                     unlock_cluster_or_swap_info(p, ci);
> >> > +
> >> > +                     for_each_clear_bit(j, usage, batch_nr)
> >> > +                             free_swap_slot(swp_entry(type, offset =
+ i * SWAP_BATCH_NR + j));
> >> > +
> >> > +                     bitmap_clear(usage, 0, SWAP_BATCH_NR);
> >> > +                     remain_nr -=3D batch_nr;
> >> > +             }
> >> > +     }
> >> > +}
> >> > +
> >> >  /*
> >> >   * Called after dropping swapcache to decrease refcnt to swap entri=
es.
> >> >   */
> >>
> >> put_swap_folio() implements batching in another method.  Do you think
> >> that it's good to use the batching method in that function here?  It
> >> avoids to use bitmap operations and stack space.
> >
> > Chuanhua has strictly limited the maximum stack usage to several
> > unsigned long,
>
> 512 / 8 =3D 64 bytes.
>
> So, not trivial.
>
> > so this should be safe. on the other hand, i believe this
> > implementation is more efficient, as  put_swap_folio() might lock/
> > unlock much more often whenever __swap_entry_free_locked returns
> > 0.
>
> There are 2 most common use cases,
>
> - all swap entries have usage count =3D=3D 0
> - all swap entries have usage count !=3D 0
>
> In both cases, we only need to lock/unlock once.  In fact, I didn't
> find possible use cases other than above.

i guess the point is free_swap_slot() shouldn't be called within
lock_cluster_or_swap_info? so when we are freeing nr_pages slots,
we'll have to unlock and lock nr_pages times?  and this is the most
common scenario.

void put_swap_folio(struct folio *folio, swp_entry_t entry)
{
        ...

        ci =3D lock_cluster_or_swap_info(si, offset);
        ...
        for (i =3D 0; i < size; i++, entry.val++) {
                if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS_CACH=
E)) {
                        unlock_cluster_or_swap_info(si, ci);
                        free_swap_slot(entry);
                        if (i =3D=3D size - 1)
                                return;
                        lock_cluster_or_swap_info(si, offset);
                }
        }
        unlock_cluster_or_swap_info(si, ci);
}

>
> And, we should add batching in __swap_entry_free().  That will help
> free_swap_and_cache_nr() too.
>
> --
> Best Regards,
> Huang, Ying

