Return-Path: <linux-kernel+bounces-149523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AF48A9257
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E154BB2220A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF0054BED;
	Thu, 18 Apr 2024 05:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8dYrAZC"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BD53AC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713418083; cv=none; b=X1laVpfiVuMWj1c/nbzPXQIzPG2AeOHTY7A8TPDtcbhXEHrmit2g0128uHiKAF/VRYnykk3GH6inRwIV4A0RCkrlLLMeXZz/5gGEGY6YzanJvGpVnxHeDp8WQ2yTCZNBp5drxxmOvlPGatLhrEsTGrZKISBhg82cFcnzg1jdCeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713418083; c=relaxed/simple;
	bh=APng+6/18U2l+3h1sWmFE+/P96epan7Z/oz+qm+3Aj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhpZJy9UWC3+/Sg51vfB4U3HmeHo3vPdBwi8Nqld9fyEDUcO6odnDNgPZeKq+mXJbvvcJt/mC5ewj2Kqcubl2RH7ohFy49N8eOsC/BodvuUgUw77OOWfnyQmlkWBqqtgYZzEYPqnHi+ZP79UCMuUZNERKqM1+Iav9L6IehiJIhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8dYrAZC; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4affeacaff9so104622e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 22:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713418080; x=1714022880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX0ufkMOAM8JcqS9gSPzorUJQY8cingKOBt/6TgrvXg=;
        b=b8dYrAZCfuizq2i+4Jxb6wLdPLqPoTUv+lMjM5omZxzCWEGl8eFQtbM46L0x85LVH3
         jnwCwnQalhq24+OvbZW9bCXHNnihczXB4yQjK6SHojz1qpanNa3FgAYCmuHHmQ2y55jK
         ZOywvAYShrlNc9tB5DcNgWuCM52e84FHA42H/EwRz8jsxM6nXEytG4Cr+9nA7hHLZfFC
         8QIT+u+ITv0qW5BMK3xckoDNmIGXFqWZjbLMu90kLYpDAEsY6Fadf9GWEI3SNtFyEFZE
         U9ZxTwUe8kyq8jMAukxX94gL4kFGz7zNikKpMZRo/naiE5C/bPmf+8xDw3GMDyIs1Nj6
         XNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713418080; x=1714022880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX0ufkMOAM8JcqS9gSPzorUJQY8cingKOBt/6TgrvXg=;
        b=NWf+osaIXFnV1O1QJZmaOEAuRWlAkzxR/7SP85n0TpWn3HIErde3lLKvw5TOcCVFmP
         hSYT97BufLVuKQHSq1z+AuN6Ev5AVFIGKLWXiwzrNRi2eZVIso5bqXxquMAdcEL0HOd4
         jMsQbT62f2F8G+LvvK8R+ZyeQoSOj5tF7w1XQDjAUGERLk3j9ASwk8DA4sNxEwCo2cBh
         +K+oCnqrGUCH6x5djjGr1WUeu8dznfytLDdW8zYdU9QEao1fXDLNQ7i2l06oORK9jRht
         wHAOFNAuzk3We7X4Jj4wXkxx1iRBlxJuMdF7P+2UfHC0OizL2Di7Bi/MKhkBWmqCGRdV
         jwqg==
X-Forwarded-Encrypted: i=1; AJvYcCWpXpFluEo/eTB86+9HU9tvgSVCuD/Rzgt4kTQPHhCWDJde0b2E3iH57ooNlE9FuvfM9jj+5LjRBbK3Y4WTEnLf2SkEzlKSxZxXQxPD
X-Gm-Message-State: AOJu0YzqYzMJtQDeEyiduh/L1rGCFqiGkHz+kV1vRLlMnwgMiwHgPRer
	0heAa8O9s6IF/IG67mxTVWSkgwKQxDuTjqYhIkdAoctugUZrgTegNiL88tj0ZW6tCHEhMoAgVe0
	4H4K3sCEzyd0HjU2Ii/vFlO2v06s=
X-Google-Smtp-Source: AGHT+IHF5Y0XifpwirLOFfm6j9tBSKkWq4j7ioFuxvZDSjp/yqTVVRumj5QnEmcL3kTo/eA7Zzci8/E2Fz8GZNKaWLk=
X-Received: by 2002:a05:6122:983:b0:4d4:e92:1a71 with SMTP id
 g3-20020a056122098300b004d40e921a71mr1955472vkd.11.1713418080297; Wed, 17 Apr
 2024 22:28:00 -0700 (PDT)
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
 <87jzkw25hl.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wTsJe2yK3k+Tif6obgL9LUUuqXEBxhqMSZSFZpbvrzmA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wTsJe2yK3k+Tif6obgL9LUUuqXEBxhqMSZSFZpbvrzmA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 18 Apr 2024 17:27:48 +1200
Message-ID: <CAGsJ_4ymv-tmpmH0s1D5+GF13UOPv5UdRFrLOxVE5X+xNUHveg@mail.gmail.com>
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

On Wed, Apr 17, 2024 at 1:35=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Apr 17, 2024 at 12:34=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >
> > Barry Song <21cnbao@gmail.com> writes:
> >
> > > On Tue, Apr 16, 2024 at 3:13=E2=80=AFPM Huang, Ying <ying.huang@intel=
com> wrote:
> > >>
> > >> Barry Song <21cnbao@gmail.com> writes:
> > >>
> > >> > On Tue, Apr 16, 2024 at 1:42=E2=80=AFPM Huang, Ying <ying.huang@in=
tel.com> wrote:
> > >> >>
> > >> >> Barry Song <21cnbao@gmail.com> writes:
> > >> >>
> > >> >> > On Mon, Apr 15, 2024 at 8:53=E2=80=AFPM Huang, Ying <ying.huang=
@intel.com> wrote:
> > >> >> >>
> > >> >> >> Barry Song <21cnbao@gmail.com> writes:
> > >> >> >>
> > >> >> >> > On Mon, Apr 15, 2024 at 8:21=E2=80=AFPM Huang, Ying <ying.hu=
ang@intel.com> wrote:
> > >> >> >> >>
> > >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> > >> >> >> >>
> > >> >> >> >> > On Mon, Apr 15, 2024 at 6:19=E2=80=AFPM Huang, Ying <ying=
huang@intel.com> wrote:
> > >> >> >> >> >>
> > >> >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> > >> >> >> >> >>
> > >> >> >> >> >> > From: Chuanhua Han <hanchuanhua@oppo.com>
> > >> >> >> >> >> >
> > >> >> >> >> >> > While swapping in a large folio, we need to free swaps=
 related to the whole
> > >> >> >> >> >> > folio. To avoid frequently acquiring and releasing swa=
p locks, it is better
> > >> >> >> >> >> > to introduce an API for batched free.
> > >> >> >> >> >> >
> > >> >> >> >> >> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> > >> >> >> >> >> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > >> >> >> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > >> >> >> >> >> > ---
> > >> >> >> >> >> >  include/linux/swap.h |  5 +++++
> > >> >> >> >> >> >  mm/swapfile.c        | 51 +++++++++++++++++++++++++++=
+++++++++++++++++
> > >> >> >> >> >> >  2 files changed, 56 insertions(+)
> > >> >> >> >> >> >
> > >> >> >> >> >> > diff --git a/include/linux/swap.h b/include/linux/swap=
h
> > >> >> >> >> >> > index 11c53692f65f..b7a107e983b8 100644
> > >> >> >> >> >> > --- a/include/linux/swap.h
> > >> >> >> >> >> > +++ b/include/linux/swap.h
> > >> >> >> >> >> > @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_e=
ntry_t);
> > >> >> >> >> >> >  extern int swap_duplicate(swp_entry_t);
> > >> >> >> >> >> >  extern int swapcache_prepare(swp_entry_t);
> > >> >> >> >> >> >  extern void swap_free(swp_entry_t);
> > >> >> >> >> >> > +extern void swap_free_nr(swp_entry_t entry, int nr_pa=
ges);
> > >> >> >> >> >> >  extern void swapcache_free_entries(swp_entry_t *entri=
es, int n);
> > >> >> >> >> >> >  extern void free_swap_and_cache_nr(swp_entry_t entry,=
 int nr);
> > >> >> >> >> >> >  int swap_type_of(dev_t device, sector_t offset);
> > >> >> >> >> >> > @@ -564,6 +565,10 @@ static inline void swap_free(swp_=
entry_t swp)
> > >> >> >> >> >> >  {
> > >> >> >> >> >> >  }
> > >> >> >> >> >> >
> > >> >> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> > >> >> >> >> >> > +{
> > >> >> >> >> >> > +}
> > >> >> >> >> >> > +
> > >> >> >> >> >> >  static inline void put_swap_folio(struct folio *folio=
, swp_entry_t swp)
> > >> >> >> >> >> >  {
> > >> >> >> >> >> >  }
> > >> >> >> >> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > >> >> >> >> >> > index 28642c188c93..f4c65aeb088d 100644
> > >> >> >> >> >> > --- a/mm/swapfile.c
> > >> >> >> >> >> > +++ b/mm/swapfile.c
> > >> >> >> >> >> > @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entr=
y)
> > >> >> >> >> >> >               __swap_entry_free(p, entry);
> > >> >> >> >> >> >  }
> > >> >> >> >> >> >
> > >> >> >> >> >> > +/*
> > >> >> >> >> >> > + * Free up the maximum number of swap entries at once=
 to limit the
> > >> >> >> >> >> > + * maximum kernel stack usage.
> > >> >> >> >> >> > + */
> > >> >> >> >> >> > +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 :=
 SWAPFILE_CLUSTER)
> > >> >> >> >> >> > +
> > >> >> >> >> >> > +/*
> > >> >> >> >> >> > + * Called after swapping in a large folio,
> > >> >> >> >> >>
> > >> >> >> >> >> IMHO, it's not good to document the caller in the functi=
on definition.
> > >> >> >> >> >> Because this will discourage function reusing.
> > >> >> >> >> >
> > >> >> >> >> > ok. right now there is only one user that is why it is ad=
ded. but i agree
> > >> >> >> >> > we can actually remove this.
> > >> >> >> >> >
> > >> >> >> >> >>
> > >> >> >> >> >> > batched free swap entries
> > >> >> >> >> >> > + * for this large folio, entry should be for the firs=
t subpage and
> > >> >> >> >> >> > + * its offset is aligned with nr_pages
> > >> >> >> >> >>
> > >> >> >> >> >> Why do we need this?
> > >> >> >> >> >
> > >> >> >> >> > This is a fundamental requirement for the existing kernel=
, folio's
> > >> >> >> >> > swap offset is naturally aligned from the first moment ad=
d_to_swap
> > >> >> >> >> > to add swapcache's xa. so this comment is describing the =
existing
> > >> >> >> >> > fact. In the future, if we want to support swap-out folio=
 to discontiguous
> > >> >> >> >> > and not-aligned offsets, we can't pass entry as the param=
eter, we should
> > >> >> >> >> > instead pass ptep or another different data struct which =
can connect
> > >> >> >> >> > multiple discontiguous swap offsets.
> > >> >> >> >> >
> > >> >> >> >> > I feel like we only need "for this large folio, entry sho=
uld be for
> > >> >> >> >> > the first subpage" and drop "and its offset is aligned wi=
th nr_pages",
> > >> >> >> >> > the latter is not important to this context at all.
> > >> >> >> >>
> > >> >> >> >> IIUC, all these are requirements of the only caller now, no=
t the
> > >> >> >> >> function itself.  If only part of the all swap entries of a=
 mTHP are
> > >> >> >> >> called with swap_free_nr(), can swap_free_nr() still do its=
 work?  If
> > >> >> >> >> so, why not make swap_free_nr() as general as possible?
> > >> >> >> >
> > >> >> >> > right , i believe we can make swap_free_nr() as general as p=
ossible.
> > >> >> >> >
> > >> >> >> >>
> > >> >> >> >> >>
> > >> >> >> >> >> > + */
> > >> >> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> > >> >> >> >> >> > +{
> > >> >> >> >> >> > +     int i, j;
> > >> >> >> >> >> > +     struct swap_cluster_info *ci;
> > >> >> >> >> >> > +     struct swap_info_struct *p;
> > >> >> >> >> >> > +     unsigned int type =3D swp_type(entry);
> > >> >> >> >> >> > +     unsigned long offset =3D swp_offset(entry);
> > >> >> >> >> >> > +     int batch_nr, remain_nr;
> > >> >> >> >> >> > +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
> > >> >> >> >> >> > +
> > >> >> >> >> >> > +     /* all swap entries are within a cluster for mTH=
P */
> > >> >> >> >> >> > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages >=
 SWAPFILE_CLUSTER);
> > >> >> >> >> >> > +
> > >> >> >> >> >> > +     if (nr_pages =3D=3D 1) {
> > >> >> >> >> >> > +             swap_free(entry);
> > >> >> >> >> >> > +             return;
> > >> >> >> >> >> > +     }
> > >> >> >> >> >>
> > >> >> >> >> >> Is it possible to unify swap_free() and swap_free_nr() i=
nto one function
> > >> >> >> >> >> with acceptable performance?  IIUC, the general rule in =
mTHP effort is
> > >> >> >> >> >> to avoid duplicate functions between mTHP and normal sma=
ll folio.
> > >> >> >> >> >> Right?
> > >> >> >> >> >
> > >> >> >> >> > I don't see why.
> > >> >> >> >>
> > >> >> >> >> Because duplicated implementation are hard to maintain in t=
he long term.
> > >> >> >> >
> > >> >> >> > sorry, i actually meant "I don't see why not",  for some rea=
son, the "not"
> > >> >> >> > was missed. Obviously I meant "why not", there was a "but" a=
fter it :-)
> > >> >> >> >
> > >> >> >> >>
> > >> >> >> >> > but we have lots of places calling swap_free(), we may
> > >> >> >> >> > have to change them all to call swap_free_nr(entry, 1); t=
he other possible
> > >> >> >> >> > way is making swap_free() a wrapper of swap_free_nr() alw=
ays using
> > >> >> >> >> > 1 as the argument. In both cases, we are changing the sem=
antics of
> > >> >> >> >> > swap_free_nr() to partially freeing large folio cases and=
 have to drop
> > >> >> >> >> > "entry should be for the first subpage" then.
> > >> >> >> >> >
> > >> >> >> >> > Right now, the semantics is
> > >> >> >> >> > * swap_free_nr() for an entire large folio;
> > >> >> >> >> > * swap_free() for one entry of either a large folio or a =
small folio
> > >> >> >> >>
> > >> >> >> >> As above, I don't think the these semantics are important f=
or
> > >> >> >> >> swap_free_nr() implementation.
> > >> >> >> >
> > >> >> >> > right. I agree. If we are ready to change all those callers,=
 nothing
> > >> >> >> > can stop us from removing swap_free().
> > >> >> >> >
> > >> >> >> >>
> > >> >> >> >> >>
> > >> >> >> >> >> > +
> > >> >> >> >> >> > +     remain_nr =3D nr_pages;
> > >> >> >> >> >> > +     p =3D _swap_info_get(entry);
> > >> >> >> >> >> > +     if (p) {
> > >> >> >> >> >> > +             for (i =3D 0; i < nr_pages; i +=3D batch=
_nr) {
> > >> >> >> >> >> > +                     batch_nr =3D min_t(int, SWAP_BAT=
CH_NR, remain_nr);
> > >> >> >> >> >> > +
> > >> >> >> >> >> > +                     ci =3D lock_cluster_or_swap_info=
(p, offset);
> > >> >> >> >> >> > +                     for (j =3D 0; j < batch_nr; j++)=
 {
> > >> >> >> >> >> > +                             if (__swap_entry_free_lo=
cked(p, offset + i * SWAP_BATCH_NR + j, 1))
> > >> >> >> >> >> > +                                     __bitmap_set(usa=
ge, j, 1);
> > >> >> >> >> >> > +                     }
> > >> >> >> >> >> > +                     unlock_cluster_or_swap_info(p, c=
i);
> > >> >> >> >> >> > +
> > >> >> >> >> >> > +                     for_each_clear_bit(j, usage, bat=
ch_nr)
> > >> >> >> >> >> > +                             free_swap_slot(swp_entry=
(type, offset + i * SWAP_BATCH_NR + j));
> > >> >> >> >> >> > +
> > >> >> >> >> >> > +                     bitmap_clear(usage, 0, SWAP_BATC=
H_NR);
> > >> >> >> >> >> > +                     remain_nr -=3D batch_nr;
> > >> >> >> >> >> > +             }
> > >> >> >> >> >> > +     }
> > >> >> >> >> >> > +}
> > >> >> >> >> >> > +
> > >> >> >> >> >> >  /*
> > >> >> >> >> >> >   * Called after dropping swapcache to decrease refcnt=
 to swap entries.
> > >> >> >> >> >> >   */
> > >> >> >> >> >>
> > >> >> >> >> >> put_swap_folio() implements batching in another method. =
 Do you think
> > >> >> >> >> >> that it's good to use the batching method in that functi=
on here?  It
> > >> >> >> >> >> avoids to use bitmap operations and stack space.
> > >> >> >> >> >
> > >> >> >> >> > Chuanhua has strictly limited the maximum stack usage to =
several
> > >> >> >> >> > unsigned long,
> > >> >> >> >>
> > >> >> >> >> 512 / 8 =3D 64 bytes.
> > >> >> >> >>
> > >> >> >> >> So, not trivial.
> > >> >> >> >>
> > >> >> >> >> > so this should be safe. on the other hand, i believe this
> > >> >> >> >> > implementation is more efficient, as  put_swap_folio() mi=
ght lock/
> > >> >> >> >> > unlock much more often whenever __swap_entry_free_locked =
returns
> > >> >> >> >> > 0.
> > >> >> >> >>
> > >> >> >> >> There are 2 most common use cases,
> > >> >> >> >>
> > >> >> >> >> - all swap entries have usage count =3D=3D 0
> > >> >> >> >> - all swap entries have usage count !=3D 0
> > >> >> >> >>
> > >> >> >> >> In both cases, we only need to lock/unlock once.  In fact, =
I didn't
> > >> >> >> >> find possible use cases other than above.
> > >> >> >> >
> > >> >> >> > i guess the point is free_swap_slot() shouldn't be called wi=
thin
> > >> >> >> > lock_cluster_or_swap_info? so when we are freeing nr_pages s=
lots,
> > >> >> >> > we'll have to unlock and lock nr_pages times?  and this is t=
he most
> > >> >> >> > common scenario.
> > >> >> >>
> > >> >> >> No.  In put_swap_folio(), free_entries is either SWAPFILE_CLUS=
TER (that
> > >> >> >> is, nr_pages) or 0.  These are the most common cases.
> > >> >> >>
> > >> >> >
> > >> >> > i am actually talking about the below code path,
> > >> >> >
> > >> >> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
> > >> >> > {
> > >> >> >         ...
> > >> >> >
> > >> >> >         ci =3D lock_cluster_or_swap_info(si, offset);
> > >> >> >         ...
> > >> >> >         for (i =3D 0; i < size; i++, entry.val++) {
> > >> >> >                 if (!__swap_entry_free_locked(si, offset + i, S=
WAP_HAS_CACHE)) {
> > >> >> >                         unlock_cluster_or_swap_info(si, ci);
> > >> >> >                         free_swap_slot(entry);
> > >> >> >                         if (i =3D=3D size - 1)
> > >> >> >                                 return;
> > >> >> >                         lock_cluster_or_swap_info(si, offset);
> > >> >> >                 }
> > >> >> >         }
> > >> >> >         unlock_cluster_or_swap_info(si, ci);
> > >> >> > }
> > >> >> >
> > >> >> > but i guess you are talking about the below code path:
> > >> >> >
> > >> >> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
> > >> >> > {
> > >> >> >         ...
> > >> >> >
> > >> >> >         ci =3D lock_cluster_or_swap_info(si, offset);
> > >> >> >         if (size =3D=3D SWAPFILE_CLUSTER) {
> > >> >> >                 map =3D si->swap_map + offset;
> > >> >> >                 for (i =3D 0; i < SWAPFILE_CLUSTER; i++) {
> > >> >> >                         val =3D map[i];
> > >> >> >                         VM_BUG_ON(!(val & SWAP_HAS_CACHE));
> > >> >> >                         if (val =3D=3D SWAP_HAS_CACHE)
> > >> >> >                                 free_entries++;
> > >> >> >                 }
> > >> >> >                 if (free_entries =3D=3D SWAPFILE_CLUSTER) {
> > >> >> >                         unlock_cluster_or_swap_info(si, ci);
> > >> >> >                         spin_lock(&si->lock);
> > >> >> >                         mem_cgroup_uncharge_swap(entry, SWAPFIL=
E_CLUSTER);
> > >> >> >                         swap_free_cluster(si, idx);
> > >> >> >                         spin_unlock(&si->lock);
> > >> >> >                         return;
> > >> >> >                 }
> > >> >> >         }
> > >> >> > }
> > >> >>
> > >> >> I am talking about both code paths.  In 2 most common cases,
> > >> >> __swap_entry_free_locked() will return 0 or !0 for all entries in=
 range.
> > >> >
> > >> > I grasp your point, but if conditions involving 0 or non-0 values =
fail, we'll
> > >> > end up repeatedly unlocking and locking. Picture a scenario with a=
 large
> > >> > folio shared by multiple processes. One process might unmap a port=
ion
> > >> > while another still holds an entire mapping to it. This could lead=
 to situations
> > >> > where free_entries doesn't equal 0 and free_entries doesn't equal
> > >> > nr_pages, resulting in multiple unlock and lock operations.
> > >>
> > >> This is impossible in current caller, because the folio is in the sw=
ap
> > >> cache.  But if we move the change to __swap_entry_free_nr(), we may =
run
> > >> into this situation.
> > >
> > > I don't understand why it is impossible, after try_to_unmap_one() has=
 done
> > > on one process, mprotect and munmap called on a part of the large fol=
io
> > > pte entries which now have been swap entries, we are removing the PTE
> > > for this part. Another process can entirely hit the swapcache and hav=
e
> > > all swap entries mapped there, and we call swap_free_nr(entry, nr_pag=
es) in
> > > do_swap_page. Within those swap entries, some have swapcount=3D1 and =
others
> > > have swapcount > 1. Am I missing something?
> >
> > For swap entries with swapcount=3D1, its sis->swap_map[] will be
> >
> > 1 | SWAP_HAS_CACHE
> >
> > so, __swap_entry_free_locked() will return SWAP_HAS_CACHE instead of 0.
> >
> > The swap entries will be free in
> >
> > folio_free_swap
> >   delete_from_swap_cache
> >     put_swap_folio
> >
>
> Yes. I realized this after replying to you yesterday.
>
> > >> > Chuanhua has invested significant effort in following Ryan's sugge=
stion
> > >> > for the current approach, which generally handles all cases, espec=
ially
> > >> > partial unmapping. Additionally, the widespread use of swap_free_n=
r()
> > >> > as you suggested across various scenarios is noteworthy.
> > >> >
> > >> > Unless there's evidence indicating performance issues or bugs, I b=
elieve
> > >> > the current approach remains preferable.
> > >>
> > >> TBH, I don't like the large stack space usage (64 bytes).  How about=
 use
> > >> a "unsigned long" as bitmap?  Then, we use much less stack space, us=
e
> > >> bitmap =3D=3D 0 and bitmap =3D=3D (unsigned long)(-1) to check the m=
ost common
> > >> use cases.  And, we have enough batching.
> > >
> > > that is quite a straightforward modification like,
> > >
> > > - #define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLUS=
TER)
> > > + #define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 64 ? 64 : SWAPFILE_CLUSTE=
R)
> > >
> > > there is no necessity to remove the bitmap API and move to raw
> > > unsigned long operations.
> > > as bitmap is exactly some unsigned long. on 64bit CPU, we are now one
> > > unsigned long,
> > > on 32bit CPU, it is now two unsigned long.
> >
> > Yes.  We can still use most bitmap APIs if we use "unsigned long" as
> > bitmap.  The advantage of "unsigned long" is to guarantee that
> > bitmap_empty() and bitmap_full() is trivial.  We can use that for
> > optimization.  For example, we can skip unlock/lock if bitmap_empty().
>
> anyway we have avoided lock_cluster_or_swap_info and unlock_cluster_or_sw=
ap_info
> for each individual swap entry.
>
> if bitma_empty(), we won't call free_swap_slot() so no chance to
> further take any lock,
> right?
>
> the optimization of bitmap_full() seems to be more useful only after we h=
ave
> void free_swap_slot(swp_entry_t entry, int nr)
>
> in which we can avoid many spin_lock_irq(&cache->free_lock);
>
> On the other hand, it seems we can directly call
> swapcache_free_entries() to skip cache if
> nr_pages >=3D SWAP_BATCH(64) this might be an optimization as we are now
> having a bitmap exactly equals 64.

Hi ying,
considering the below code which has changed bitmap to 64 and generally sup=
port
different nr_pages(1 and ever cross cluster),

#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 64 ? 64 : SWAPFILE_CLUSTER)

void swap_free_nr(swp_entry_t entry, int nr_pages)
{
        int i =3D 0, j;
        struct swap_cluster_info *ci;
        struct swap_info_struct *p;
        unsigned int type =3D swp_type(entry);
        unsigned long offset =3D swp_offset(entry);
        int batch_nr, remain_nr;
        DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };

        remain_nr =3D nr_pages;
        p =3D _swap_info_get(entry);
        if (!p)
                return;

        for ( ; ; ) {
                batch_nr =3D min3(SWAP_BATCH_NR, remain_nr,
                                (int)(SWAPFILE_CLUSTER - (offset %
SWAPFILE_CLUSTER)));

                ci =3D lock_cluster_or_swap_info(p, offset);
                for (j =3D 0; j < batch_nr; j++) {
                        if (__swap_entry_free_locked(p, offset + i *
SWAP_BATCH_NR + j, 1))
                                __bitmap_set(usage, j, 1);
                }
                unlock_cluster_or_swap_info(p, ci);

                for_each_clear_bit(j, usage, batch_nr)
                        free_swap_slot(swp_entry(type, offset + i *
SWAP_BATCH_NR + j));

                i +=3D batch_nr;
                if (i >=3D nr_pages)
                        break;

                bitmap_clear(usage, 0, SWAP_BATCH_NR);
                remain_nr -=3D batch_nr;
        }
}

I still don't see the benefits of using bitmap_full and bitmap_empty over s=
imple
for_each_clear_bit() unless we begin to support free_swap_slot_nr(), which,
I believe, needs a separate incremental patchset.

using bitmap_empty and full, if we want to free all slots, we need
if (bitmap_empty(usage))
{
    for (i=3D0;i<batch_nr;i++)
              free_swap_slot(swp_entry(type, offset + i * SWAP_BATCH_NR + j=
));
}
This seems just a game replacing for_each_clear_bit by
bitmap_empty()+another for loop.

if we don't want to free any one, we need
if(bitmap_full(usage)
       do_nothing.

in the for_each_clear_bit() case, the loop just simply ends.

What's your proposal code to use bitmap_empty and bitmap_full here?
Am I missing something?

>
> >
> > >>
> > >> >>
> > >> >> > we are mTHP, so we can't assume our size is SWAPFILE_CLUSTER?
> > >> >> > or you want to check free_entries =3D=3D "1 << swap_entry_order=
(folio_order(folio))"
> > >> >> > instead of SWAPFILE_CLUSTER for the "for (i =3D 0; i < size; i+=
+, entry.val++)"
> > >> >> > path?
> > >> >>
> > >> >> Just replace SWAPFILE_CLUSTER with "nr_pages" in your code.
> > >> >>
> > >> >> >
> > >> >> >> >>
> > >> >> >> >> And, we should add batching in __swap_entry_free().  That w=
ill help
> > >> >> >> >> free_swap_and_cache_nr() too.
> > >> >> >
> > >> >> > Chris Li and I actually discussed it before, while I completely
> > >> >> > agree this can be batched. but i'd like to defer this as an inc=
remental
> > >> >> > patchset later to keep this swapcache-refault small.
> > >> >>
> > >> >> OK.
> > >> >>
> > >> >> >>
> > >> >> >> Please consider this too.
> >
> > --
> > Best Regards,
> > Huang, Ying

Thanks
Barry

