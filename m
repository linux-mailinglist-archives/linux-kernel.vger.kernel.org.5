Return-Path: <linux-kernel+bounces-85987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5E786BE17
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D162C1C2303F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD20A22612;
	Thu, 29 Feb 2024 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRqQZRBz"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D874513D2F5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709169140; cv=none; b=tDnNjTzH6fg7oGDP+rzyGmKXhtYsEN+i8B+RUzx+EJN/n8A3gf4PioGFaOuQhaNP/0WoYX1+akTEFfnC+J+UL2Hzghy+2VmqhFpbegdfZHgK9FGAbojia9Du+hTm5dQ9NDvt5kNhyZcvg4aPIW1YcM+DEve0+iF4VPxhFmSnziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709169140; c=relaxed/simple;
	bh=9TjAjeZ8FgvYRLBC7y7eIEkwq/iH3VaG5Txt04L2TiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svQNwKTnSF4SueDQVW9bSfxQ2Y+94xTlDSAZHgphddTnvAWGw6bSTHt0RAv7cYzpGwo00EFgMzjCnzAq0koMUexqxHtdXaRphJUx0NRQfZxpJ+xKJg4BAVhdU86ZHHmjYI5umFxKBQ3pTe+ZQ9qIeKZUvNEW/Y8rQDqPd1Xia/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oRqQZRBz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4419683a6bso57511966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709169137; x=1709773937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za/f+FD8CJTPCMoqnLZV1TIT7CRykE1Lv1/KdXF4ElQ=;
        b=oRqQZRBzIUrAmacH7wrH2uqcKMhnrJcC9mfO7CQSGh+zo0qFy5xWsFuPxNxMJ883aE
         xEHsN2WDrzevdHlls3e0f+sRksZ35tNtozG0Kx8Qaw+NCAA6qYZheG7uFYzWz7erO+zy
         6Rg34XL9ebCvM4XhEBHiDuhk1RdLk6oyEIktHZhDZe69KNd7z5sAIPIWayKDtO6wIm6M
         iiOh6Xh+76gDYeamYPvRxny/hsqmlGltn1aiapSkugpOEnRQ+EfE0BZeVCbneLjt1Zo1
         Fy2m73t7KmL5UNsNkOCmF/0QHMF+fPY0EjM28XfhqwDIxf6a4L1DDha72Fysv1sOrxV+
         flFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709169137; x=1709773937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=za/f+FD8CJTPCMoqnLZV1TIT7CRykE1Lv1/KdXF4ElQ=;
        b=E7Ty2FLuRRCMuhxlr7A8V+Vc2x4vs76Q96uw5bBEy2u9uk8f8yJDS+OJxOg0g6qx3f
         HBIC4D16NJ/0CFwO/EP+bMogV65k6MYSxxvVK4Z02L11vK2oIbzWDv/NITLFnJsV+FbY
         01D59wBoaoUiJjpI+bmQK7xr77FPTL1SsJj59dhga3ahpLnqAToKahJgz/d6p5G8O2Q7
         lyA92Y3OMeCn1S3BMP/21VH17WdxxhJUkNiEUeerEcpDrsXFjvEIZgitZWjbSMCnhPZT
         0eWScx+f1TiDeLU1k1tlWJVQaqCKhJtVYfo5wNWVlPxe47vGmjbyPXAR+IrIh2jzpFOm
         FVyA==
X-Forwarded-Encrypted: i=1; AJvYcCUyfjavuaCWfK/Ht7PnMnzUl33+oSPnK5zNlSTURSsqyjxBhkUxtCa8dynU1GuSPowIaiYagdjjmUpNLVzCbaeD8kBGljC9QA/Bj1St
X-Gm-Message-State: AOJu0Yy07/00qGYSH2hI0z+TA407nf7x8ObT71ZeIfepc4JFed6HwtxH
	W5X/2VxlkfHx6L/PhHoN4nVwna5DHKZDL2dYKXCLlCN3P2G7/ZstFnsHgagPBBXrZHQctyCPOTI
	A2U7RuRTwYaB5zhm+d8JCCm0VMrC2mqEF/F54
X-Google-Smtp-Source: AGHT+IEAgL1Bww+5JuEgUxcDBnN9H9F8iZLjpAJi5GB+9ifzlx3C9P2jRNo47k/MGoURNxB9skuSrspX3DXCeGqK5HI=
X-Received: by 2002:a17:906:f9cc:b0:a43:adc:7220 with SMTP id
 lj12-20020a170906f9cc00b00a430adc7220mr349274ejb.8.1709169136943; Wed, 28 Feb
 2024 17:12:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229003753.134193-1-21cnbao@gmail.com> <20240229003753.134193-5-21cnbao@gmail.com>
 <CAJD7tkYWvxeCLmDO83tGyde7e4wPDPMnNbQfnB+pyTJAoSHqbg@mail.gmail.com> <CAGsJ_4wSDZM4s6v8KmjwjbpWcoeF95R3-AkhUt2SthZ49MNNcw@mail.gmail.com>
In-Reply-To: <CAGsJ_4wSDZM4s6v8KmjwjbpWcoeF95R3-AkhUt2SthZ49MNNcw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 28 Feb 2024 17:11:40 -0800
Message-ID: <CAJD7tkZi2g8HjwtchE46SkKgOHSE02ZTNLKFi-t0c4+hihUjYQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/5] mm: swap: introduce swapcache_prepare_nr and
 swapcache_clear_nr for large folios swap-in
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	ryan.roberts@arm.com, chrisl@kernel.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, shy828301@gmail.com, steven.price@arm.com, surenb@google.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yuzhao@google.com, kasong@tencent.com, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-arm-kernel@lists.infradead.org, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>, SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:59=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Feb 29, 2024 at 1:52=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Wed, Feb 28, 2024 at 4:39=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache") sup=
ports
> > > one entry only, to support large folio swap-in, we need to handle mul=
tiple
> > > swap entries.
> > >
> > > Cc: Kairui Song <kasong@tencent.com>
> > > Cc: "Huang, Ying" <ying.huang@intel.com>
> > > Cc: Yu Zhao <yuzhao@google.com>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: Chris Li <chrisl@kernel.org>
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Minchan Kim <minchan@kernel.org>
> > > Cc: Yosry Ahmed <yosryahmed@google.com>
> > > Cc: Yu Zhao <yuzhao@google.com>
> > > Cc: SeongJae Park <sj@kernel.org>
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >  include/linux/swap.h |   1 +
> > >  mm/swap.h            |   1 +
> > >  mm/swapfile.c        | 117 ++++++++++++++++++++++++++---------------=
--
> > >  3 files changed, 72 insertions(+), 47 deletions(-)
> > >
> > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > index b3581c976e5f..2691c739d9a4 100644
> > > --- a/include/linux/swap.h
> > > +++ b/include/linux/swap.h
> > > @@ -480,6 +480,7 @@ extern int add_swap_count_continuation(swp_entry_=
t, gfp_t);
> > >  extern void swap_shmem_alloc(swp_entry_t);
> > >  extern int swap_duplicate(swp_entry_t);
> > >  extern int swapcache_prepare(swp_entry_t);
> > > +extern int swapcache_prepare_nr(swp_entry_t, int nr);
> > >  extern void swap_free(swp_entry_t);
> > >  extern void swap_nr_free(swp_entry_t entry, int nr_pages);
> > >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> > > diff --git a/mm/swap.h b/mm/swap.h
> > > index fc2f6ade7f80..1cec991efcda 100644
> > > --- a/mm/swap.h
> > > +++ b/mm/swap.h
> > > @@ -42,6 +42,7 @@ void delete_from_swap_cache(struct folio *folio);
> > >  void clear_shadow_from_swap_cache(int type, unsigned long begin,
> > >                                   unsigned long end);
> > >  void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)=
;
> > > +void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t ent=
ry, int nr);
> > >  struct folio *swap_cache_get_folio(swp_entry_t entry,
> > >                 struct vm_area_struct *vma, unsigned long addr);
> > >  struct folio *filemap_get_incore_folio(struct address_space *mapping=
,
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index c0c058ee7b69..c8c8b6dbaeda 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -3308,7 +3308,7 @@ void si_swapinfo(struct sysinfo *val)
> > >  }
> > >
> > >  /*
> > > - * Verify that a swap entry is valid and increment its swap map coun=
t.
> > > + * Verify that nr swap entries are valid and increment their swap ma=
p count.
> > >   *
> > >   * Returns error code in following case.
> > >   * - success -> 0
> > > @@ -3318,66 +3318,73 @@ void si_swapinfo(struct sysinfo *val)
> > >   * - swap-cache reference is requested but the entry is not used. ->=
 ENOENT
> > >   * - swap-mapped reference requested but needs continued swap count.=
 -> ENOMEM
> > >   */
> > > -static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
> > > +static int __swap_duplicate_nr(swp_entry_t entry, int nr, unsigned c=
har usage)
> > >  {
> > >         struct swap_info_struct *p;
> > >         struct swap_cluster_info *ci;
> > >         unsigned long offset;
> > > -       unsigned char count;
> > > -       unsigned char has_cache;
> > > -       int err;
> > > +       unsigned char count[SWAPFILE_CLUSTER];
> > > +       unsigned char has_cache[SWAPFILE_CLUSTER];
> >
>
> Hi Yosry,
>
> Thanks for reviewing!
>
> > I am not closely following this series, but a couple of things caught m=
y eyes.
> >
> > Is this reasonable for stack usage?
>
> SWAPFILE_CLUSTER is not huge. typically 512 or 256.

So that's 1K of stack usage out of 16K total on x86. I think this may
be a lot for a single function to use, but perhaps others will
disagree.

>
> #ifdef CONFIG_THP_SWAP
> #define SWAPFILE_CLUSTER        HPAGE_PMD_NR
>
> #define swap_entry_size(size)   (size)
> #else
> #define SWAPFILE_CLUSTER        256
>
> If this is still a concern, I can move it to a bitmap.
>
> >
> > > +       int err, i;
> > >
> > >         p =3D swp_swap_info(entry);
> > >
> > >         offset =3D swp_offset(entry);
> > >         ci =3D lock_cluster_or_swap_info(p, offset);
> > >
> > > -       count =3D p->swap_map[offset];
> > > -
> > > -       /*
> > > -        * swapin_readahead() doesn't check if a swap entry is valid,=
 so the
> > > -        * swap entry could be SWAP_MAP_BAD. Check here with lock hel=
d.
> > > -        */
> > > -       if (unlikely(swap_count(count) =3D=3D SWAP_MAP_BAD)) {
> > > -               err =3D -ENOENT;
> > > -               goto unlock_out;
> > > -       }
> > > +       for (i =3D 0; i < nr; i++) {
> > > +               count[i] =3D p->swap_map[offset + i];
> > >
> > > -       has_cache =3D count & SWAP_HAS_CACHE;
> > > -       count &=3D ~SWAP_HAS_CACHE;
> > > -       err =3D 0;
> > > -
> > > -       if (usage =3D=3D SWAP_HAS_CACHE) {
> > > -
> > > -               /* set SWAP_HAS_CACHE if there is no cache and entry =
is used */
> > > -               if (!has_cache && count)
> > > -                       has_cache =3D SWAP_HAS_CACHE;
> > > -               else if (has_cache)             /* someone else added=
 cache */
> > > -                       err =3D -EEXIST;
> > > -               else                            /* no users remaining=
 */
> > > +               /*
> > > +                * swapin_readahead() doesn't check if a swap entry i=
s valid, so the
> > > +                * swap entry could be SWAP_MAP_BAD. Check here with =
lock held.
> > > +                */
> > > +               if (unlikely(swap_count(count[i]) =3D=3D SWAP_MAP_BAD=
)) {
> > >                         err =3D -ENOENT;
> > > +                       goto unlock_out;
> > > +               }
> >
>
>
> > Here we immediately exit if there is an error, but we don't below, we
> > just keep overwriting the error every iteration as far as I can tell.
> > Also, it doesn't seem like we do any cleanups if we hit an error
> > halfway through. Should we undo previously updated swap entries, or am
> > I missing something here?
>
> we are safely immediately exiting because we don't change swap_map
> till we finish all checks. while all checks are done, we write  them by
> WRITE_ONCE(p->swap_map[offset + i], count[i] | has_cache[i]);
> at the end.

I see, but I think we may be overwriting the error from each iteration belo=
w?

>
> >
> > >
> > > -       } else if (count || has_cache) {
> > > -
> > > -               if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> > > -                       count +=3D usage;
> > > -               else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> > > -                       err =3D -EINVAL;
> > > -               else if (swap_count_continued(p, offset, count))
> > > -                       count =3D COUNT_CONTINUED;
> > > -               else
> > > -                       err =3D -ENOMEM;
> > > -       } else
> > > -               err =3D -ENOENT;                  /* unused swap entr=
y */
> > > -
> > > -       if (!err)
> > > -               WRITE_ONCE(p->swap_map[offset], count | has_cache);
> > > +               has_cache[i] =3D count[i] & SWAP_HAS_CACHE;
> > > +               count[i] &=3D ~SWAP_HAS_CACHE;
> > > +               err =3D 0;
> > > +
> > > +               if (usage =3D=3D SWAP_HAS_CACHE) {
> > > +
> > > +                       /* set SWAP_HAS_CACHE if there is no cache an=
d entry is used */
> > > +                       if (!has_cache[i] && count[i])
> > > +                               has_cache[i] =3D SWAP_HAS_CACHE;
> > > +                       else if (has_cache[i])          /* someone el=
se added cache */
> > > +                               err =3D -EEXIST;
> > > +                       else                            /* no users r=
emaining */
> > > +                               err =3D -ENOENT;
> > > +               } else if (count[i] || has_cache[i]) {
> > > +
> > > +                       if ((count[i] & ~COUNT_CONTINUED) < SWAP_MAP_=
MAX)
> > > +                               count[i] +=3D usage;
> > > +                       else if ((count[i] & ~COUNT_CONTINUED) > SWAP=
_MAP_MAX)
> > > +                               err =3D -EINVAL;
> > > +                       else if (swap_count_continued(p, offset + i, =
count[i]))
> > > +                               count[i] =3D COUNT_CONTINUED;
> > > +                       else
> > > +                               err =3D -ENOMEM;
> > > +               } else
> > > +                       err =3D -ENOENT;                  /* unused s=
wap entry */
> > > +       }
> > >
> > > +       if (!err) {
> > > +               for (i =3D 0; i < nr; i++)
> > > +                       WRITE_ONCE(p->swap_map[offset + i], count[i] =
| has_cache[i]);
>
> Here is the place where we really write data. Before that, we only
> touched temp variables.
>
> > > +       }
> > >  unlock_out:
> > >         unlock_cluster_or_swap_info(p, ci);
> > >         return err;
> > >  }
>
> thanks
> Barry

