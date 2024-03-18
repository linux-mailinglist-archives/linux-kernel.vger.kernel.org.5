Return-Path: <linux-kernel+bounces-106754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A19A87F321
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502381C2162E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AF65A4C9;
	Mon, 18 Mar 2024 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgA/5SDp"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39831F959
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801354; cv=none; b=WUrCofKR/UBOzdcTiKsuvXjfK66WQpNQMAsFOaKCu29bPADvPrj52cfDZyuSXf5ZElolqSa9Rq5Jswy7Y9Xj5ZSfhQajfyIrUDkOmLSamXUi3SBzxtLe4O2mdEgCqvWmEaEERxtTQ85Q0hjV9G6o3dykE/lVV3+NMYvE5FM5ogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801354; c=relaxed/simple;
	bh=va2QDgiDQQHlrlGKc6jA0LX25RGg9kNusvpuCnt08ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dv5nid6a6WRcx7WSqtjNdRIAqUVIEJH+QEQ/FZWxH0ZywrApYq03zegj65/0DLFI+V5O8ZTCsooF9c+PpskfeCHiiZwXb/Mu/BEmsB0lMXil8/kK4wOVsm/GvaC8WqjsHZzQw+yjaPl3BSqse/Z9DQR+mVxV7g24HP2j5aw7kIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgA/5SDp; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-475fdb1a6a6so651575137.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710801352; x=1711406152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kc3DhF9+ScmocSNbzNV6tif7jI3+A9+U0NWPTcBs5Hg=;
        b=UgA/5SDpd5a9ef6QJXqdASqJKZ7iM0o/whL1azr73IZzLaiZ4dY3/N4WbaByL3nXD8
         HNHmBLJfgx3lB2RkV4eR8NOlzJkQHLXQGNrpeLX9hUA7nQefCNYwT65g0M3qrwRiGfgK
         HSOebfvPcQJDNkextDfz7WQhqvQvxJtxgWysi5O/09YLoLDXwZMDkt9XqMrfNhOl7ItN
         b7CGCFJNAa3yo/C+e1bGEYFmaejeYZQQvUJeuvTC8BiYXruP7cqemT6wAhXAWX+zLct4
         81Pwi9YXkqN4ok6xZ07Dyg71WQu5rcmYaLbuiq5V7BoBVkBkO9UDHZzYh1pfyFXl5Ekp
         p/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710801352; x=1711406152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kc3DhF9+ScmocSNbzNV6tif7jI3+A9+U0NWPTcBs5Hg=;
        b=um0RqU40CtKlAk3+/MXgGkNbeVq8HqPLPqL0DRzX5dNOVOXkrxJCQP/cd7h9n872TC
         L+TcMKGOu1v94BYE99Ub+ap+XQ3YCsECdgnEuSE83G6xKnZdR7Xjly6ngUzHvzSXFPGX
         LUctLV/mGHHrLaoh06qnM05gLd3y92bbLCG4+raMiOzjMqiFZKNFL5oe6yEEulRwT8mS
         FcnPseq9uA2PltXbGd6jjN31DExHivPZm8b/HF/YR9jY29dOgIPjQgh1+uGf+Is9uHLV
         HycXK9aflZ8oAYb3dEdXXS4WHKEWWtbM7JauwnBx5i7u7Nw2ThxgJgox1/QE5aNkVBTJ
         LsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS+Z73bmyhPX5b7uSm9/1TtCOX0iR20geKBameiHRevSe6BSXkH6PIN6dmN/X/6UVa7QT8gag6ph79ONu35CZyJXpS3MmOi0DUpOQd
X-Gm-Message-State: AOJu0YzPl9yzMW89WhLDMzqpt20Riw7rsHLvX2irl+UUpnHHgq54I23m
	l4w1LUAIwWQ+qHzUyjflGTZOWBHfesfE6OtUL+HigB16xMwWRcLX0qfbsBqtuSNSvHjYWh8ASsf
	VWV1QUWLIkO4sz0+9RfuUrCeu1ps=
X-Google-Smtp-Source: AGHT+IFAb1WYZJ7j/iOgjuuvdm/Qa1J6hKrNxdrY+P4V22z4ep46iaE22aIXCXtFVdYOVH6opUYp7MrZ5q1ymht/INU=
X-Received: by 2002:a67:fd0c:0:b0:472:a8e0:49fe with SMTP id
 f12-20020a67fd0c000000b00472a8e049femr495077vsr.35.1710801351690; Mon, 18 Mar
 2024 15:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-5-21cnbao@gmail.com>
 <cf172f8b-8dc4-4017-81eb-84a2438d3cc6@arm.com>
In-Reply-To: <cf172f8b-8dc4-4017-81eb-84a2438d3cc6@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 11:35:40 +1300
Message-ID: <CAGsJ_4zqFXr4DUHH9JAnx2qP8Y8OzAw+MzR1ERdiqNtBQzoY7Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/5] mm: swap: introduce swapcache_prepare_nr and
 swapcache_clear_nr for large folios swap-in
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chengming.zhou@linux.dev, 
	chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com, steven.price@arm.com, 
	surenb@google.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, Barry Song <v-songbaohua@oppo.com>, Hugh Dickins <hughd@google.com>, 
	Minchan Kim <minchan@kernel.org>, SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 4:35=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 04/03/2024 08:13, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache") suppo=
rts
> > one entry only, to support large folio swap-in, we need to handle multi=
ple
> > swap entries.
> >
> > Cc: Kairui Song <kasong@tencent.com>
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Chris Li <chrisl@kernel.org>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > Cc: Yu Zhao <yuzhao@google.com>
> > Cc: SeongJae Park <sj@kernel.org>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/linux/swap.h |   1 +
> >  mm/swap.h            |   1 +
> >  mm/swapfile.c        | 118 ++++++++++++++++++++++++++-----------------
> >  3 files changed, 74 insertions(+), 46 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index d6ab27929458..22105f0fe2d4 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -480,6 +480,7 @@ extern int add_swap_count_continuation(swp_entry_t,=
 gfp_t);
> >  extern void swap_shmem_alloc(swp_entry_t);
> >  extern int swap_duplicate(swp_entry_t);
> >  extern int swapcache_prepare(swp_entry_t);
> > +extern int swapcache_prepare_nr(swp_entry_t entry, int nr);
> >  extern void swap_free(swp_entry_t);
> >  extern void swap_nr_free(swp_entry_t entry, int nr_pages);
> >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> > diff --git a/mm/swap.h b/mm/swap.h
> > index fc2f6ade7f80..1cec991efcda 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -42,6 +42,7 @@ void delete_from_swap_cache(struct folio *folio);
> >  void clear_shadow_from_swap_cache(int type, unsigned long begin,
> >                                 unsigned long end);
> >  void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
> > +void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry=
, int nr);
> >  struct folio *swap_cache_get_folio(swp_entry_t entry,
> >               struct vm_area_struct *vma, unsigned long addr);
> >  struct folio *filemap_get_incore_folio(struct address_space *mapping,
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 244106998a69..bae1b8165b11 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3309,7 +3309,7 @@ void si_swapinfo(struct sysinfo *val)
> >  }
> >
> >  /*
> > - * Verify that a swap entry is valid and increment its swap map count.
> > + * Verify that nr swap entries are valid and increment their swap map =
count.
> >   *
> >   * Returns error code in following case.
> >   * - success -> 0
> > @@ -3319,66 +3319,76 @@ void si_swapinfo(struct sysinfo *val)
> >   * - swap-cache reference is requested but the entry is not used. -> E=
NOENT
> >   * - swap-mapped reference requested but needs continued swap count. -=
> ENOMEM
> >   */
> > -static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
> > +static int __swap_duplicate_nr(swp_entry_t entry, int nr, unsigned cha=
r usage)
>
> perhaps its better to pass order instead of nr to all these functions to =
make it
> clearer that entry should be naturally aligned and be a power-of-2 number=
 of
> pages, no bigger than SWAPFILE_CLUSTER?
>
> >  {
> >       struct swap_info_struct *p;
> >       struct swap_cluster_info *ci;
> >       unsigned long offset;
> > -     unsigned char count;
> > -     unsigned char has_cache;
> > -     int err;
> > +     unsigned char count[SWAPFILE_CLUSTER];
> > +     unsigned char has_cache[SWAPFILE_CLUSTER];
>
> I'm not sure this 1K stack buffer is a good idea?
>
> Could you split it slightly differently so that loop 1 just does error ch=
ecking
> and bails out if an error is found, and loop 2 does the new value calcula=
tion
> and writeback? Then you don't need these arrays.

right. we can totally remove thoe arrays by re-reading swap_map.

>
> > +     int err, i;
> >
> >       p =3D swp_swap_info(entry);
> >
> >       offset =3D swp_offset(entry);
> >       ci =3D lock_cluster_or_swap_info(p, offset);
> >
> > -     count =3D p->swap_map[offset];
> > -
> > -     /*
> > -      * swapin_readahead() doesn't check if a swap entry is valid, so =
the
> > -      * swap entry could be SWAP_MAP_BAD. Check here with lock held.
> > -      */
> > -     if (unlikely(swap_count(count) =3D=3D SWAP_MAP_BAD)) {
> > -             err =3D -ENOENT;
> > -             goto unlock_out;
> > -     }
> > -
> > -     has_cache =3D count & SWAP_HAS_CACHE;
> > -     count &=3D ~SWAP_HAS_CACHE;
> > -     err =3D 0;
> > -
> > -     if (usage =3D=3D SWAP_HAS_CACHE) {
> > +     for (i =3D 0; i < nr; i++) {
> > +             count[i] =3D p->swap_map[offset + i];
> >
> > -             /* set SWAP_HAS_CACHE if there is no cache and entry is u=
sed */
> > -             if (!has_cache && count)
> > -                     has_cache =3D SWAP_HAS_CACHE;
> > -             else if (has_cache)             /* someone else added cac=
he */
> > -                     err =3D -EEXIST;
> > -             else                            /* no users remaining */
> > +             /*
> > +              * swapin_readahead() doesn't check if a swap entry is va=
lid, so the
> > +              * swap entry could be SWAP_MAP_BAD. Check here with lock=
 held.
> > +              */
> > +             if (unlikely(swap_count(count[i]) =3D=3D SWAP_MAP_BAD)) {
> >                       err =3D -ENOENT;
> > +                     goto unlock_out;
> > +             }
> >
> > -     } else if (count || has_cache) {
> > -
> > -             if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> > -                     count +=3D usage;
> > -             else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> > -                     err =3D -EINVAL;
> > -             else if (swap_count_continued(p, offset, count))
> > -                     count =3D COUNT_CONTINUED;
> > -             else
> > -                     err =3D -ENOMEM;
> > -     } else
> > -             err =3D -ENOENT;                  /* unused swap entry */
> > +             has_cache[i] =3D count[i] & SWAP_HAS_CACHE;
> > +             count[i] &=3D ~SWAP_HAS_CACHE;
> > +             err =3D 0;
> > +
> > +             if (usage =3D=3D SWAP_HAS_CACHE) {
> > +
> > +                     /* set SWAP_HAS_CACHE if there is no cache and en=
try is used */
> > +                     if (!has_cache[i] && count[i])
> > +                             has_cache[i] =3D SWAP_HAS_CACHE;
> > +                     else if (has_cache[i])          /* someone else a=
dded cache */
> > +                             err =3D -EEXIST;
> > +                     else                            /* no users remai=
ning */
> > +                             err =3D -ENOENT;
> > +             } else if (count[i] || has_cache[i]) {
> > +
> > +                     if ((count[i] & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> > +                             count[i] +=3D usage;
> > +                     else if ((count[i] & ~COUNT_CONTINUED) > SWAP_MAP=
_MAX)
> > +                             err =3D -EINVAL;
> > +                     else if (swap_count_continued(p, offset + i, coun=
t[i]))
> > +                             count[i] =3D COUNT_CONTINUED;
> > +                     else
> > +                             err =3D -ENOMEM;
> > +             } else
> > +                     err =3D -ENOENT;                  /* unused swap =
entry */
> >
> > -     if (!err)
> > -             WRITE_ONCE(p->swap_map[offset], count | has_cache);
> > +             if (err)
> > +                     break;
> > +     }
> >
> > +     if (!err) {
> > +             for (i =3D 0; i < nr; i++)
> > +                     WRITE_ONCE(p->swap_map[offset + i], count[i] | ha=
s_cache[i]);
> > +     }
> >  unlock_out:
> >       unlock_cluster_or_swap_info(p, ci);
> >       return err;
> >  }
> >
> > +static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
> > +{
> > +     return __swap_duplicate_nr(entry, 1, usage);
> > +}
> > +
> >  /*
> >   * Help swapoff by noting that swap entry belongs to shmem/tmpfs
> >   * (in which case its reference count is never incremented).
> > @@ -3417,17 +3427,33 @@ int swapcache_prepare(swp_entry_t entry)
> >       return __swap_duplicate(entry, SWAP_HAS_CACHE);
> >  }
> >
> > -void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
> > +int swapcache_prepare_nr(swp_entry_t entry, int nr)
> > +{
> > +     return __swap_duplicate_nr(entry, nr, SWAP_HAS_CACHE);
> > +}
> > +
> > +void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry=
, int nr)
> >  {
> >       struct swap_cluster_info *ci;
> >       unsigned long offset =3D swp_offset(entry);
> > -     unsigned char usage;
> > +     unsigned char usage[SWAPFILE_CLUSTER];
> > +     int i;
> >
> >       ci =3D lock_cluster_or_swap_info(si, offset);
> > -     usage =3D __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
> > +     for (i =3D 0; i < nr; i++)
> > +             usage[i] =3D __swap_entry_free_locked(si, offset + i, SWA=
P_HAS_CACHE);
> >       unlock_cluster_or_swap_info(si, ci);
> > -     if (!usage)
> > -             free_swap_slot(entry);
> > +     for (i =3D 0; i < nr; i++) {
> > +             if (!usage[i]) {
> > +                     free_swap_slot(entry);
> > +                     entry.val++;
> > +             }
> > +     }
> > +}
>
> This is pretty similar to swap_nr_free() which you added in patch 2. Exce=
pt
> swap_nr_free() passes 1 as last param to __swap_entry_free_locked() and t=
his
> passes SWAP_HAS_CACHE. Perhaps their should be a common helper? I think
> swap_nr_free()'s usage bitmap is preferable to this version's char array =
too.

right.

>
> Thanks,
> Ryan
>
> > +
> > +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
> > +{
> > +     swapcache_clear_nr(si, entry, 1);
> >  }
> >
> >  struct swap_info_struct *swp_swap_info(swp_entry_t entry)

Thanks
Barry

