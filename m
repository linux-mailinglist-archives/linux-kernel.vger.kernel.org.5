Return-Path: <linux-kernel+bounces-147827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55A68A7A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E0F1F224FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C2E187F;
	Wed, 17 Apr 2024 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUtbjyId"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782D184F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713317731; cv=none; b=aRh2cit43VmEllkwt0kok8MAaIzGW5Ao98ITPrd0PI0KopSJMZklCkOemLvt688UrNElxaVJ38m2j/ClYbp25mRAOx7X3TI7ihRSdbn7dcfg8yxI53vPFDLD42KsLrjhhnXVaFxk6M4+01FsWR4kLLy0BAAwFp8GAd+BCFE9mpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713317731; c=relaxed/simple;
	bh=b+OlIW36uw2jPayPfQYYb99UNouKDQZiJnbhOiHwY5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jmaw4jlCxKxkKxV+P6QJV1k6pH4ENkG/3aw3ZTRVWgyKmTfoALXqM0MKSzPpd5J0rOfNnmxjSWYjEF57z6aZeSu0+osCnPV04ZLU79d68Z6Ocx+eUTXC8U8LmVT4XM4joKRCb09UKTq4erkrzfMDAwRvO/Y7RRIP2hqRfBb7IcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUtbjyId; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-47a21267aa8so1918508137.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713317728; x=1713922528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xkolTYzy6LpZVii81c7/pBCNzLJG9e3CEqA2qgqoeM=;
        b=LUtbjyIdBjJwSCavXambEL28rE2yGZi8OZDFYB7vM34zAS1REQSGGKXPremrJITJNr
         f2RUvMeeWj9Eq0Se2P6BLudbNA6W1MckOA0J3Q1sx8V7z1J8ZxNjxcC5inX0FSpw7Gxl
         SQATrIN8QqXaA1Wq87fVVVf/DRymysm64TwvjyuiBHH5CApaVUHVADSgXBdFBA2H2Zvi
         jjOzC99hNQbUX0VMINkG4RL7QMR9ucyYRobcw1JMiJGqOhZ87jfVrxJhxfeSKYipW7wo
         UEZUoo67GtIgRDCXZ/nQ0oEZhDWheyjBzPb9SkfGpuVVuIYytWXzN0gQq1Xehf+gDTMy
         62/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713317728; x=1713922528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xkolTYzy6LpZVii81c7/pBCNzLJG9e3CEqA2qgqoeM=;
        b=VcPwwKv5e/MVpZSR6WzHYQuO14UnT58mxSGXq15R8CeYjRlK6fwSC4CLol13uz78Dv
         j8nIm1Hl5bL30APqUB2KVT0ImO5s8fb4bUBZCiGqbIhw70N6BQQd9Yv4KbYIoD90NOLV
         JLgL/ZqvgQikqzty27fwgcJMGJ24NpnH7B48rBZ+Ny5m4H0q7bRmXPF2tOPtHhS8ZvfN
         xHk8/BDM1c7eNS1+eScJLQrxlJj4IiKgujxG59HjFMKWWLMfY3AKuY00eWQTEsyVoqcv
         fMl5meQVl7Tm90pXzXZvrrkLkkK1nfD9Fqb3awu+mJrj2eZ726gVQj/FEWoToo8lpEf7
         SrBg==
X-Forwarded-Encrypted: i=1; AJvYcCVIGDv/HaOXDUnamkmFlXLSwhy6IoUbuERqHu3aF10GMT7eZR0I1LzK3E4ybhdG7bCnJPTSNaTIZLzTjwjP6ijtnW8AHbk66g6m5soy
X-Gm-Message-State: AOJu0YwS1XK6MU0Nc/hsfnk5Pw+0EN87tIbioTwsTzM0PE8sp6kn+zUa
	EKbzSjDWOBftADOaZrb2HjOuxP2+CwAQH5vb+ijeJoWyBm2e+1Q3IdwAykHZPFec5y8Xq51/l53
	vKgu/S8PWUImq7ZGE5OuKmCKGnB4=
X-Google-Smtp-Source: AGHT+IEhUTM6oI3+Rfq1ybG03zOsE2x5klLXRrIDyw8RVBJS1ZZi3l/2IZtGqmwAMh80+f/dxB4MtSbpfbZYlcdcyrw=
X-Received: by 2002:a05:6102:3708:b0:47a:41b5:ee72 with SMTP id
 s8-20020a056102370800b0047a41b5ee72mr14450495vst.20.1713317728435; Tue, 16
 Apr 2024 18:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-2-21cnbao@gmail.com>
 <87y19f2lq3.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yPQyQpWvB2KmuOh2vyUQA0A6hNHsypEC9Gptp9XtuDgg@mail.gmail.com>
 <87jzkz2g3t.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wm4SfkyTBHpU46EPTFvhq8e54F3KRkKj6gTBcnOjCw1g@mail.gmail.com>
 <87bk6b2elo.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4zH4RHhZembtXOqzBDL75MA5NiEjMHx7eCN-a1ifnKTBw@mail.gmail.com>
 <877cgy2ifu.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yim-PQW0JBjZD8dpGBG3FQm=xZb1V51+Nr37nJEwEPzA@mail.gmail.com>
 <87ttk20zns.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4xigDba15o9K84z9nR_ZW1nXsUWa0LRNmUAfDdxcqsddw@mail.gmail.com>
 <87jzkw25hl.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87jzkw25hl.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 17 Apr 2024 13:35:17 +1200
Message-ID: <CAGsJ_4wTsJe2yK3k+Tif6obgL9LUUuqXEBxhqMSZSFZpbvrzmA@mail.gmail.com>
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

On Wed, Apr 17, 2024 at 12:34=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Tue, Apr 16, 2024 at 3:13=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Tue, Apr 16, 2024 at 1:42=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > On Mon, Apr 15, 2024 at 8:53=E2=80=AFPM Huang, Ying <ying.huang@i=
ntel.com> wrote:
> >> >> >>
> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >>
> >> >> >> > On Mon, Apr 15, 2024 at 8:21=E2=80=AFPM Huang, Ying <ying.huan=
g@intel.com> wrote:
> >> >> >> >>
> >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >> >>
> >> >> >> >> > On Mon, Apr 15, 2024 at 6:19=E2=80=AFPM Huang, Ying <ying.h=
uang@intel.com> wrote:
> >> >> >> >> >>
> >> >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >> >> >>
> >> >> >> >> >> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >> >> >> >> >> >
> >> >> >> >> >> > While swapping in a large folio, we need to free swaps r=
elated to the whole
> >> >> >> >> >> > folio. To avoid frequently acquiring and releasing swap =
locks, it is better
> >> >> >> >> >> > to introduce an API for batched free.
> >> >> >> >> >> >
> >> >> >> >> >> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> >> >> >> >> >> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> >> >> >> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> >> >> >> >> > ---
> >> >> >> >> >> >  include/linux/swap.h |  5 +++++
> >> >> >> >> >> >  mm/swapfile.c        | 51 +++++++++++++++++++++++++++++=
+++++++++++++++
> >> >> >> >> >> >  2 files changed, 56 insertions(+)
> >> >> >> >> >> >
> >> >> >> >> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> >> >> >> >> > index 11c53692f65f..b7a107e983b8 100644
> >> >> >> >> >> > --- a/include/linux/swap.h
> >> >> >> >> >> > +++ b/include/linux/swap.h
> >> >> >> >> >> > @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_ent=
ry_t);
> >> >> >> >> >> >  extern int swap_duplicate(swp_entry_t);
> >> >> >> >> >> >  extern int swapcache_prepare(swp_entry_t);
> >> >> >> >> >> >  extern void swap_free(swp_entry_t);
> >> >> >> >> >> > +extern void swap_free_nr(swp_entry_t entry, int nr_page=
s);
> >> >> >> >> >> >  extern void swapcache_free_entries(swp_entry_t *entries=
, int n);
> >> >> >> >> >> >  extern void free_swap_and_cache_nr(swp_entry_t entry, i=
nt nr);
> >> >> >> >> >> >  int swap_type_of(dev_t device, sector_t offset);
> >> >> >> >> >> > @@ -564,6 +565,10 @@ static inline void swap_free(swp_en=
try_t swp)
> >> >> >> >> >> >  {
> >> >> >> >> >> >  }
> >> >> >> >> >> >
> >> >> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> >> >> >> >> >> > +{
> >> >> >> >> >> > +}
> >> >> >> >> >> > +
> >> >> >> >> >> >  static inline void put_swap_folio(struct folio *folio, =
swp_entry_t swp)
> >> >> >> >> >> >  {
> >> >> >> >> >> >  }
> >> >> >> >> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> >> >> >> >> > index 28642c188c93..f4c65aeb088d 100644
> >> >> >> >> >> > --- a/mm/swapfile.c
> >> >> >> >> >> > +++ b/mm/swapfile.c
> >> >> >> >> >> > @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
> >> >> >> >> >> >               __swap_entry_free(p, entry);
> >> >> >> >> >> >  }
> >> >> >> >> >> >
> >> >> >> >> >> > +/*
> >> >> >> >> >> > + * Free up the maximum number of swap entries at once t=
o limit the
> >> >> >> >> >> > + * maximum kernel stack usage.
> >> >> >> >> >> > + */
> >> >> >> >> >> > +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : S=
WAPFILE_CLUSTER)
> >> >> >> >> >> > +
> >> >> >> >> >> > +/*
> >> >> >> >> >> > + * Called after swapping in a large folio,
> >> >> >> >> >>
> >> >> >> >> >> IMHO, it's not good to document the caller in the function=
 definition.
> >> >> >> >> >> Because this will discourage function reusing.
> >> >> >> >> >
> >> >> >> >> > ok. right now there is only one user that is why it is adde=
d. but i agree
> >> >> >> >> > we can actually remove this.
> >> >> >> >> >
> >> >> >> >> >>
> >> >> >> >> >> > batched free swap entries
> >> >> >> >> >> > + * for this large folio, entry should be for the first =
subpage and
> >> >> >> >> >> > + * its offset is aligned with nr_pages
> >> >> >> >> >>
> >> >> >> >> >> Why do we need this?
> >> >> >> >> >
> >> >> >> >> > This is a fundamental requirement for the existing kernel, =
folio's
> >> >> >> >> > swap offset is naturally aligned from the first moment add_=
to_swap
> >> >> >> >> > to add swapcache's xa. so this comment is describing the ex=
isting
> >> >> >> >> > fact. In the future, if we want to support swap-out folio t=
o discontiguous
> >> >> >> >> > and not-aligned offsets, we can't pass entry as the paramet=
er, we should
> >> >> >> >> > instead pass ptep or another different data struct which ca=
n connect
> >> >> >> >> > multiple discontiguous swap offsets.
> >> >> >> >> >
> >> >> >> >> > I feel like we only need "for this large folio, entry shoul=
d be for
> >> >> >> >> > the first subpage" and drop "and its offset is aligned with=
 nr_pages",
> >> >> >> >> > the latter is not important to this context at all.
> >> >> >> >>
> >> >> >> >> IIUC, all these are requirements of the only caller now, not =
the
> >> >> >> >> function itself.  If only part of the all swap entries of a m=
THP are
> >> >> >> >> called with swap_free_nr(), can swap_free_nr() still do its w=
ork?  If
> >> >> >> >> so, why not make swap_free_nr() as general as possible?
> >> >> >> >
> >> >> >> > right , i believe we can make swap_free_nr() as general as pos=
sible.
> >> >> >> >
> >> >> >> >>
> >> >> >> >> >>
> >> >> >> >> >> > + */
> >> >> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> >> >> >> >> >> > +{
> >> >> >> >> >> > +     int i, j;
> >> >> >> >> >> > +     struct swap_cluster_info *ci;
> >> >> >> >> >> > +     struct swap_info_struct *p;
> >> >> >> >> >> > +     unsigned int type =3D swp_type(entry);
> >> >> >> >> >> > +     unsigned long offset =3D swp_offset(entry);
> >> >> >> >> >> > +     int batch_nr, remain_nr;
> >> >> >> >> >> > +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
> >> >> >> >> >> > +
> >> >> >> >> >> > +     /* all swap entries are within a cluster for mTHP =
*/
> >> >> >> >> >> > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > S=
WAPFILE_CLUSTER);
> >> >> >> >> >> > +
> >> >> >> >> >> > +     if (nr_pages =3D=3D 1) {
> >> >> >> >> >> > +             swap_free(entry);
> >> >> >> >> >> > +             return;
> >> >> >> >> >> > +     }
> >> >> >> >> >>
> >> >> >> >> >> Is it possible to unify swap_free() and swap_free_nr() int=
o one function
> >> >> >> >> >> with acceptable performance?  IIUC, the general rule in mT=
HP effort is
> >> >> >> >> >> to avoid duplicate functions between mTHP and normal small=
 folio.
> >> >> >> >> >> Right?
> >> >> >> >> >
> >> >> >> >> > I don't see why.
> >> >> >> >>
> >> >> >> >> Because duplicated implementation are hard to maintain in the=
 long term.
> >> >> >> >
> >> >> >> > sorry, i actually meant "I don't see why not",  for some reaso=
n, the "not"
> >> >> >> > was missed. Obviously I meant "why not", there was a "but" aft=
er it :-)
> >> >> >> >
> >> >> >> >>
> >> >> >> >> > but we have lots of places calling swap_free(), we may
> >> >> >> >> > have to change them all to call swap_free_nr(entry, 1); the=
 other possible
> >> >> >> >> > way is making swap_free() a wrapper of swap_free_nr() alway=
s using
> >> >> >> >> > 1 as the argument. In both cases, we are changing the seman=
tics of
> >> >> >> >> > swap_free_nr() to partially freeing large folio cases and h=
ave to drop
> >> >> >> >> > "entry should be for the first subpage" then.
> >> >> >> >> >
> >> >> >> >> > Right now, the semantics is
> >> >> >> >> > * swap_free_nr() for an entire large folio;
> >> >> >> >> > * swap_free() for one entry of either a large folio or a sm=
all folio
> >> >> >> >>
> >> >> >> >> As above, I don't think the these semantics are important for
> >> >> >> >> swap_free_nr() implementation.
> >> >> >> >
> >> >> >> > right. I agree. If we are ready to change all those callers, n=
othing
> >> >> >> > can stop us from removing swap_free().
> >> >> >> >
> >> >> >> >>
> >> >> >> >> >>
> >> >> >> >> >> > +
> >> >> >> >> >> > +     remain_nr =3D nr_pages;
> >> >> >> >> >> > +     p =3D _swap_info_get(entry);
> >> >> >> >> >> > +     if (p) {
> >> >> >> >> >> > +             for (i =3D 0; i < nr_pages; i +=3D batch_n=
r) {
> >> >> >> >> >> > +                     batch_nr =3D min_t(int, SWAP_BATCH=
_NR, remain_nr);
> >> >> >> >> >> > +
> >> >> >> >> >> > +                     ci =3D lock_cluster_or_swap_info(p=
, offset);
> >> >> >> >> >> > +                     for (j =3D 0; j < batch_nr; j++) {
> >> >> >> >> >> > +                             if (__swap_entry_free_lock=
ed(p, offset + i * SWAP_BATCH_NR + j, 1))
> >> >> >> >> >> > +                                     __bitmap_set(usage=
, j, 1);
> >> >> >> >> >> > +                     }
> >> >> >> >> >> > +                     unlock_cluster_or_swap_info(p, ci)=
;
> >> >> >> >> >> > +
> >> >> >> >> >> > +                     for_each_clear_bit(j, usage, batch=
_nr)
> >> >> >> >> >> > +                             free_swap_slot(swp_entry(t=
ype, offset + i * SWAP_BATCH_NR + j));
> >> >> >> >> >> > +
> >> >> >> >> >> > +                     bitmap_clear(usage, 0, SWAP_BATCH_=
NR);
> >> >> >> >> >> > +                     remain_nr -=3D batch_nr;
> >> >> >> >> >> > +             }
> >> >> >> >> >> > +     }
> >> >> >> >> >> > +}
> >> >> >> >> >> > +
> >> >> >> >> >> >  /*
> >> >> >> >> >> >   * Called after dropping swapcache to decrease refcnt t=
o swap entries.
> >> >> >> >> >> >   */
> >> >> >> >> >>
> >> >> >> >> >> put_swap_folio() implements batching in another method.  D=
o you think
> >> >> >> >> >> that it's good to use the batching method in that function=
 here?  It
> >> >> >> >> >> avoids to use bitmap operations and stack space.
> >> >> >> >> >
> >> >> >> >> > Chuanhua has strictly limited the maximum stack usage to se=
veral
> >> >> >> >> > unsigned long,
> >> >> >> >>
> >> >> >> >> 512 / 8 =3D 64 bytes.
> >> >> >> >>
> >> >> >> >> So, not trivial.
> >> >> >> >>
> >> >> >> >> > so this should be safe. on the other hand, i believe this
> >> >> >> >> > implementation is more efficient, as  put_swap_folio() migh=
t lock/
> >> >> >> >> > unlock much more often whenever __swap_entry_free_locked re=
turns
> >> >> >> >> > 0.
> >> >> >> >>
> >> >> >> >> There are 2 most common use cases,
> >> >> >> >>
> >> >> >> >> - all swap entries have usage count =3D=3D 0
> >> >> >> >> - all swap entries have usage count !=3D 0
> >> >> >> >>
> >> >> >> >> In both cases, we only need to lock/unlock once.  In fact, I =
didn't
> >> >> >> >> find possible use cases other than above.
> >> >> >> >
> >> >> >> > i guess the point is free_swap_slot() shouldn't be called with=
in
> >> >> >> > lock_cluster_or_swap_info? so when we are freeing nr_pages slo=
ts,
> >> >> >> > we'll have to unlock and lock nr_pages times?  and this is the=
 most
> >> >> >> > common scenario.
> >> >> >>
> >> >> >> No.  In put_swap_folio(), free_entries is either SWAPFILE_CLUSTE=
R (that
> >> >> >> is, nr_pages) or 0.  These are the most common cases.
> >> >> >>
> >> >> >
> >> >> > i am actually talking about the below code path,
> >> >> >
> >> >> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
> >> >> > {
> >> >> >         ...
> >> >> >
> >> >> >         ci =3D lock_cluster_or_swap_info(si, offset);
> >> >> >         ...
> >> >> >         for (i =3D 0; i < size; i++, entry.val++) {
> >> >> >                 if (!__swap_entry_free_locked(si, offset + i, SWA=
P_HAS_CACHE)) {
> >> >> >                         unlock_cluster_or_swap_info(si, ci);
> >> >> >                         free_swap_slot(entry);
> >> >> >                         if (i =3D=3D size - 1)
> >> >> >                                 return;
> >> >> >                         lock_cluster_or_swap_info(si, offset);
> >> >> >                 }
> >> >> >         }
> >> >> >         unlock_cluster_or_swap_info(si, ci);
> >> >> > }
> >> >> >
> >> >> > but i guess you are talking about the below code path:
> >> >> >
> >> >> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
> >> >> > {
> >> >> >         ...
> >> >> >
> >> >> >         ci =3D lock_cluster_or_swap_info(si, offset);
> >> >> >         if (size =3D=3D SWAPFILE_CLUSTER) {
> >> >> >                 map =3D si->swap_map + offset;
> >> >> >                 for (i =3D 0; i < SWAPFILE_CLUSTER; i++) {
> >> >> >                         val =3D map[i];
> >> >> >                         VM_BUG_ON(!(val & SWAP_HAS_CACHE));
> >> >> >                         if (val =3D=3D SWAP_HAS_CACHE)
> >> >> >                                 free_entries++;
> >> >> >                 }
> >> >> >                 if (free_entries =3D=3D SWAPFILE_CLUSTER) {
> >> >> >                         unlock_cluster_or_swap_info(si, ci);
> >> >> >                         spin_lock(&si->lock);
> >> >> >                         mem_cgroup_uncharge_swap(entry, SWAPFILE_=
CLUSTER);
> >> >> >                         swap_free_cluster(si, idx);
> >> >> >                         spin_unlock(&si->lock);
> >> >> >                         return;
> >> >> >                 }
> >> >> >         }
> >> >> > }
> >> >>
> >> >> I am talking about both code paths.  In 2 most common cases,
> >> >> __swap_entry_free_locked() will return 0 or !0 for all entries in r=
ange.
> >> >
> >> > I grasp your point, but if conditions involving 0 or non-0 values fa=
il, we'll
> >> > end up repeatedly unlocking and locking. Picture a scenario with a l=
arge
> >> > folio shared by multiple processes. One process might unmap a portio=
n
> >> > while another still holds an entire mapping to it. This could lead t=
o situations
> >> > where free_entries doesn't equal 0 and free_entries doesn't equal
> >> > nr_pages, resulting in multiple unlock and lock operations.
> >>
> >> This is impossible in current caller, because the folio is in the swap
> >> cache.  But if we move the change to __swap_entry_free_nr(), we may ru=
n
> >> into this situation.
> >
> > I don't understand why it is impossible, after try_to_unmap_one() has d=
one
> > on one process, mprotect and munmap called on a part of the large folio
> > pte entries which now have been swap entries, we are removing the PTE
> > for this part. Another process can entirely hit the swapcache and have
> > all swap entries mapped there, and we call swap_free_nr(entry, nr_pages=
) in
> > do_swap_page. Within those swap entries, some have swapcount=3D1 and ot=
hers
> > have swapcount > 1. Am I missing something?
>
> For swap entries with swapcount=3D1, its sis->swap_map[] will be
>
> 1 | SWAP_HAS_CACHE
>
> so, __swap_entry_free_locked() will return SWAP_HAS_CACHE instead of 0.
>
> The swap entries will be free in
>
> folio_free_swap
>   delete_from_swap_cache
>     put_swap_folio
>

Yes. I realized this after replying to you yesterday.

> >> > Chuanhua has invested significant effort in following Ryan's suggest=
ion
> >> > for the current approach, which generally handles all cases, especia=
lly
> >> > partial unmapping. Additionally, the widespread use of swap_free_nr(=
)
> >> > as you suggested across various scenarios is noteworthy.
> >> >
> >> > Unless there's evidence indicating performance issues or bugs, I bel=
ieve
> >> > the current approach remains preferable.
> >>
> >> TBH, I don't like the large stack space usage (64 bytes).  How about u=
se
> >> a "unsigned long" as bitmap?  Then, we use much less stack space, use
> >> bitmap =3D=3D 0 and bitmap =3D=3D (unsigned long)(-1) to check the mos=
t common
> >> use cases.  And, we have enough batching.
> >
> > that is quite a straightforward modification like,
> >
> > - #define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLUSTE=
R)
> > + #define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 64 ? 64 : SWAPFILE_CLUSTER)
> >
> > there is no necessity to remove the bitmap API and move to raw
> > unsigned long operations.
> > as bitmap is exactly some unsigned long. on 64bit CPU, we are now one
> > unsigned long,
> > on 32bit CPU, it is now two unsigned long.
>
> Yes.  We can still use most bitmap APIs if we use "unsigned long" as
> bitmap.  The advantage of "unsigned long" is to guarantee that
> bitmap_empty() and bitmap_full() is trivial.  We can use that for
> optimization.  For example, we can skip unlock/lock if bitmap_empty().

anyway we have avoided lock_cluster_or_swap_info and unlock_cluster_or_swap=
_info
for each individual swap entry.

if bitma_empty(), we won't call free_swap_slot() so no chance to
further take any lock,
right?

the optimization of bitmap_full() seems to be more useful only after we hav=
e
void free_swap_slot(swp_entry_t entry, int nr)

in which we can avoid many spin_lock_irq(&cache->free_lock);

On the other hand, it seems we can directly call
swapcache_free_entries() to skip cache if
nr_pages >=3D SWAP_BATCH(64) this might be an optimization as we are now
having a bitmap exactly equals 64.

>
> >>
> >> >>
> >> >> > we are mTHP, so we can't assume our size is SWAPFILE_CLUSTER?
> >> >> > or you want to check free_entries =3D=3D "1 << swap_entry_order(f=
olio_order(folio))"
> >> >> > instead of SWAPFILE_CLUSTER for the "for (i =3D 0; i < size; i++,=
 entry.val++)"
> >> >> > path?
> >> >>
> >> >> Just replace SWAPFILE_CLUSTER with "nr_pages" in your code.
> >> >>
> >> >> >
> >> >> >> >>
> >> >> >> >> And, we should add batching in __swap_entry_free().  That wil=
l help
> >> >> >> >> free_swap_and_cache_nr() too.
> >> >> >
> >> >> > Chris Li and I actually discussed it before, while I completely
> >> >> > agree this can be batched. but i'd like to defer this as an incre=
mental
> >> >> > patchset later to keep this swapcache-refault small.
> >> >>
> >> >> OK.
> >> >>
> >> >> >>
> >> >> >> Please consider this too.
>
> --
> Best Regards,
> Huang, Ying

