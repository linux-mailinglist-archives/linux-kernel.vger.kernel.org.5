Return-Path: <linux-kernel+bounces-146226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C528A6268
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF021C21168
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E561EB48;
	Tue, 16 Apr 2024 04:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7YoMuuQ"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80211FA1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713241988; cv=none; b=gJF/9W5/glCAJ/BEW/jcyX5DMOCzc8oxDVg4JPeyt+9/p3GjH+sSrgzE3WToc+drIsciWp4lqf9KgJvZ1pldP22FDWPtWYL/YGjk66IXrzJPzAMBnhR/UARASLoks9CVdq0mwk3bBLZG8LEBUFf5LIu0xtLgeLH8COeiRVof6B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713241988; c=relaxed/simple;
	bh=H+BtBgaJs3xbeCocZVIkEUqRoc42xt0/lCy1P02UDb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iw6g+mPz/MhHqn35BefBg1HDCN/B5mHs/Ten6M/wKAqOrgzu3vGV+Yi0VTqRTABJ7m0TRo6/+sTw5CusCbmLQst3b8H5ZHbzPrStXsLPLL7pMimWPuCPDdDpQcKZ3HSIxNhXzQancT3AYpREImfgXIDyY/QdHhaze049VNA5Hms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7YoMuuQ; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7e618c51802so1265393241.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713241986; x=1713846786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj3HFtUgw5CkHV1Ev7HDKfYsJXa0bUsIcHJrQWKN1g8=;
        b=T7YoMuuQdKtOlWA4wQUpU2kmgvQogRCv6tKEa+8DsnpF+ZXZz8S8Uid/o0dokLb3tC
         63InBpEearQE9vMDpjkLI9ODhMZrpVjHScOnh+hHieMDlVkzYUOM10SOd+a0g11Pe5XL
         dlFazTESOTLX5EJzbX2tPpfL+S71CFLN4HQ7HfrU5Bnav2OisDy+iuoU054roVSReilJ
         qLqz6Hy1XjMJ1C4E0KSiFMbWHwl81Mkzd5yD1q3TmbFlnkcL1HL1uYFIxEuk3zAJo4QW
         qxj8Dx4bRuOc3UkmsAj2eY8JBY7ZD5mMSBSi1+SyC1zO/4pgft+pZGVVNFPW+AK31AtF
         B6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713241986; x=1713846786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zj3HFtUgw5CkHV1Ev7HDKfYsJXa0bUsIcHJrQWKN1g8=;
        b=kN8zahTL3CkUB+Z/xysCXLq7LalyX171KkQWSJ0lxk6vxUqUdKbZjxFsGxW4n6IfFF
         10rjfIxnxFIe4m/jwkfF972oLn6nY+CW98YHDLgF3O5GQc6W0clDvpl4SY1ZPttVfV+m
         sGxk/cwiO/y8PeMY58iS1Giz2J1QmnXYiGyZOo1hkd34pHfWkf6zznlpwXMnpmcLjybL
         0AwZUjwD/hOXP80oaGT6dq6V3D1gYZJBYeZ89T7imi4m+aHltaVSCyRId5SRMn8kttfX
         WqAHNj/HG7W5zhfpSCQB7feSrCWpJjLAXSt9NEKzwMP0pQPNRGarFknCxLvMb2BsvmmF
         0NRw==
X-Forwarded-Encrypted: i=1; AJvYcCV50hmkggleAUqM1IKdEmVd6mr0ege5noN6W3PN/2KrUiOOqWHI8+RnmvoxbSDWKbrHLgrSHgBAJ9jd6kFCJU+6qHh0m1oF3tRi1e3B
X-Gm-Message-State: AOJu0Ywlc0XCQQSUXRl7Ve36D7w5/0B7UaKK5v3wwx/oHiQXeiFLg9HY
	fkDE0iCgx2kDtCCEpa1VDsaYGaPgYs/Gy8cwnmP2+k6qt2sQjdK5u1xGIARupIeepPteARnKYeo
	960sA86hXmAOtwEtV/x2dWrJulbg=
X-Google-Smtp-Source: AGHT+IEoAoIskq6Chu3QC6ck44AQtYIXDOPD1xXb1TxXQPQPri9nQaXDypfLOwmpFV2KauxJbS9D+nIP0FQVpjdLppY=
X-Received: by 2002:a05:6102:3a0e:b0:47a:42eb:54a3 with SMTP id
 b14-20020a0561023a0e00b0047a42eb54a3mr12851567vsu.4.1713241985626; Mon, 15
 Apr 2024 21:33:05 -0700 (PDT)
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
 <87ttk20zns.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ttk20zns.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 16 Apr 2024 16:32:54 +1200
Message-ID: <CAGsJ_4xigDba15o9K84z9nR_ZW1nXsUWa0LRNmUAfDdxcqsddw@mail.gmail.com>
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

On Tue, Apr 16, 2024 at 3:13=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Tue, Apr 16, 2024 at 1:42=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Mon, Apr 15, 2024 at 8:53=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > On Mon, Apr 15, 2024 at 8:21=E2=80=AFPM Huang, Ying <ying.huang@i=
ntel.com> wrote:
> >> >> >>
> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >>
> >> >> >> > On Mon, Apr 15, 2024 at 6:19=E2=80=AFPM Huang, Ying <ying.huan=
g@intel.com> wrote:
> >> >> >> >>
> >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >> >>
> >> >> >> >> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >> >> >> >> >
> >> >> >> >> > While swapping in a large folio, we need to free swaps rela=
ted to the whole
> >> >> >> >> > folio. To avoid frequently acquiring and releasing swap loc=
ks, it is better
> >> >> >> >> > to introduce an API for batched free.
> >> >> >> >> >
> >> >> >> >> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> >> >> >> >> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> >> >> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> >> >> >> > ---
> >> >> >> >> >  include/linux/swap.h |  5 +++++
> >> >> >> >> >  mm/swapfile.c        | 51 ++++++++++++++++++++++++++++++++=
++++++++++++
> >> >> >> >> >  2 files changed, 56 insertions(+)
> >> >> >> >> >
> >> >> >> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> >> >> >> > index 11c53692f65f..b7a107e983b8 100644
> >> >> >> >> > --- a/include/linux/swap.h
> >> >> >> >> > +++ b/include/linux/swap.h
> >> >> >> >> > @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_=
t);
> >> >> >> >> >  extern int swap_duplicate(swp_entry_t);
> >> >> >> >> >  extern int swapcache_prepare(swp_entry_t);
> >> >> >> >> >  extern void swap_free(swp_entry_t);
> >> >> >> >> > +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> >> >> >> >> >  extern void swapcache_free_entries(swp_entry_t *entries, i=
nt n);
> >> >> >> >> >  extern void free_swap_and_cache_nr(swp_entry_t entry, int =
nr);
> >> >> >> >> >  int swap_type_of(dev_t device, sector_t offset);
> >> >> >> >> > @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry=
_t swp)
> >> >> >> >> >  {
> >> >> >> >> >  }
> >> >> >> >> >
> >> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> >> >> >> >> > +{
> >> >> >> >> > +}
> >> >> >> >> > +
> >> >> >> >> >  static inline void put_swap_folio(struct folio *folio, swp=
_entry_t swp)
> >> >> >> >> >  {
> >> >> >> >> >  }
> >> >> >> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> >> >> >> > index 28642c188c93..f4c65aeb088d 100644
> >> >> >> >> > --- a/mm/swapfile.c
> >> >> >> >> > +++ b/mm/swapfile.c
> >> >> >> >> > @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
> >> >> >> >> >               __swap_entry_free(p, entry);
> >> >> >> >> >  }
> >> >> >> >> >
> >> >> >> >> > +/*
> >> >> >> >> > + * Free up the maximum number of swap entries at once to l=
imit the
> >> >> >> >> > + * maximum kernel stack usage.
> >> >> >> >> > + */
> >> >> >> >> > +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAP=
FILE_CLUSTER)
> >> >> >> >> > +
> >> >> >> >> > +/*
> >> >> >> >> > + * Called after swapping in a large folio,
> >> >> >> >>
> >> >> >> >> IMHO, it's not good to document the caller in the function de=
finition.
> >> >> >> >> Because this will discourage function reusing.
> >> >> >> >
> >> >> >> > ok. right now there is only one user that is why it is added. =
but i agree
> >> >> >> > we can actually remove this.
> >> >> >> >
> >> >> >> >>
> >> >> >> >> > batched free swap entries
> >> >> >> >> > + * for this large folio, entry should be for the first sub=
page and
> >> >> >> >> > + * its offset is aligned with nr_pages
> >> >> >> >>
> >> >> >> >> Why do we need this?
> >> >> >> >
> >> >> >> > This is a fundamental requirement for the existing kernel, fol=
io's
> >> >> >> > swap offset is naturally aligned from the first moment add_to_=
swap
> >> >> >> > to add swapcache's xa. so this comment is describing the exist=
ing
> >> >> >> > fact. In the future, if we want to support swap-out folio to d=
iscontiguous
> >> >> >> > and not-aligned offsets, we can't pass entry as the parameter,=
 we should
> >> >> >> > instead pass ptep or another different data struct which can c=
onnect
> >> >> >> > multiple discontiguous swap offsets.
> >> >> >> >
> >> >> >> > I feel like we only need "for this large folio, entry should b=
e for
> >> >> >> > the first subpage" and drop "and its offset is aligned with nr=
_pages",
> >> >> >> > the latter is not important to this context at all.
> >> >> >>
> >> >> >> IIUC, all these are requirements of the only caller now, not the
> >> >> >> function itself.  If only part of the all swap entries of a mTHP=
 are
> >> >> >> called with swap_free_nr(), can swap_free_nr() still do its work=
?  If
> >> >> >> so, why not make swap_free_nr() as general as possible?
> >> >> >
> >> >> > right , i believe we can make swap_free_nr() as general as possib=
le.
> >> >> >
> >> >> >>
> >> >> >> >>
> >> >> >> >> > + */
> >> >> >> >> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> >> >> >> >> > +{
> >> >> >> >> > +     int i, j;
> >> >> >> >> > +     struct swap_cluster_info *ci;
> >> >> >> >> > +     struct swap_info_struct *p;
> >> >> >> >> > +     unsigned int type =3D swp_type(entry);
> >> >> >> >> > +     unsigned long offset =3D swp_offset(entry);
> >> >> >> >> > +     int batch_nr, remain_nr;
> >> >> >> >> > +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
> >> >> >> >> > +
> >> >> >> >> > +     /* all swap entries are within a cluster for mTHP */
> >> >> >> >> > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAP=
FILE_CLUSTER);
> >> >> >> >> > +
> >> >> >> >> > +     if (nr_pages =3D=3D 1) {
> >> >> >> >> > +             swap_free(entry);
> >> >> >> >> > +             return;
> >> >> >> >> > +     }
> >> >> >> >>
> >> >> >> >> Is it possible to unify swap_free() and swap_free_nr() into o=
ne function
> >> >> >> >> with acceptable performance?  IIUC, the general rule in mTHP =
effort is
> >> >> >> >> to avoid duplicate functions between mTHP and normal small fo=
lio.
> >> >> >> >> Right?
> >> >> >> >
> >> >> >> > I don't see why.
> >> >> >>
> >> >> >> Because duplicated implementation are hard to maintain in the lo=
ng term.
> >> >> >
> >> >> > sorry, i actually meant "I don't see why not",  for some reason, =
the "not"
> >> >> > was missed. Obviously I meant "why not", there was a "but" after =
it :-)
> >> >> >
> >> >> >>
> >> >> >> > but we have lots of places calling swap_free(), we may
> >> >> >> > have to change them all to call swap_free_nr(entry, 1); the ot=
her possible
> >> >> >> > way is making swap_free() a wrapper of swap_free_nr() always u=
sing
> >> >> >> > 1 as the argument. In both cases, we are changing the semantic=
s of
> >> >> >> > swap_free_nr() to partially freeing large folio cases and have=
 to drop
> >> >> >> > "entry should be for the first subpage" then.
> >> >> >> >
> >> >> >> > Right now, the semantics is
> >> >> >> > * swap_free_nr() for an entire large folio;
> >> >> >> > * swap_free() for one entry of either a large folio or a small=
 folio
> >> >> >>
> >> >> >> As above, I don't think the these semantics are important for
> >> >> >> swap_free_nr() implementation.
> >> >> >
> >> >> > right. I agree. If we are ready to change all those callers, noth=
ing
> >> >> > can stop us from removing swap_free().
> >> >> >
> >> >> >>
> >> >> >> >>
> >> >> >> >> > +
> >> >> >> >> > +     remain_nr =3D nr_pages;
> >> >> >> >> > +     p =3D _swap_info_get(entry);
> >> >> >> >> > +     if (p) {
> >> >> >> >> > +             for (i =3D 0; i < nr_pages; i +=3D batch_nr) =
{
> >> >> >> >> > +                     batch_nr =3D min_t(int, SWAP_BATCH_NR=
, remain_nr);
> >> >> >> >> > +
> >> >> >> >> > +                     ci =3D lock_cluster_or_swap_info(p, o=
ffset);
> >> >> >> >> > +                     for (j =3D 0; j < batch_nr; j++) {
> >> >> >> >> > +                             if (__swap_entry_free_locked(=
p, offset + i * SWAP_BATCH_NR + j, 1))
> >> >> >> >> > +                                     __bitmap_set(usage, j=
, 1);
> >> >> >> >> > +                     }
> >> >> >> >> > +                     unlock_cluster_or_swap_info(p, ci);
> >> >> >> >> > +
> >> >> >> >> > +                     for_each_clear_bit(j, usage, batch_nr=
)
> >> >> >> >> > +                             free_swap_slot(swp_entry(type=
, offset + i * SWAP_BATCH_NR + j));
> >> >> >> >> > +
> >> >> >> >> > +                     bitmap_clear(usage, 0, SWAP_BATCH_NR)=
;
> >> >> >> >> > +                     remain_nr -=3D batch_nr;
> >> >> >> >> > +             }
> >> >> >> >> > +     }
> >> >> >> >> > +}
> >> >> >> >> > +
> >> >> >> >> >  /*
> >> >> >> >> >   * Called after dropping swapcache to decrease refcnt to s=
wap entries.
> >> >> >> >> >   */
> >> >> >> >>
> >> >> >> >> put_swap_folio() implements batching in another method.  Do y=
ou think
> >> >> >> >> that it's good to use the batching method in that function he=
re?  It
> >> >> >> >> avoids to use bitmap operations and stack space.
> >> >> >> >
> >> >> >> > Chuanhua has strictly limited the maximum stack usage to sever=
al
> >> >> >> > unsigned long,
> >> >> >>
> >> >> >> 512 / 8 =3D 64 bytes.
> >> >> >>
> >> >> >> So, not trivial.
> >> >> >>
> >> >> >> > so this should be safe. on the other hand, i believe this
> >> >> >> > implementation is more efficient, as  put_swap_folio() might l=
ock/
> >> >> >> > unlock much more often whenever __swap_entry_free_locked retur=
ns
> >> >> >> > 0.
> >> >> >>
> >> >> >> There are 2 most common use cases,
> >> >> >>
> >> >> >> - all swap entries have usage count =3D=3D 0
> >> >> >> - all swap entries have usage count !=3D 0
> >> >> >>
> >> >> >> In both cases, we only need to lock/unlock once.  In fact, I did=
n't
> >> >> >> find possible use cases other than above.
> >> >> >
> >> >> > i guess the point is free_swap_slot() shouldn't be called within
> >> >> > lock_cluster_or_swap_info? so when we are freeing nr_pages slots,
> >> >> > we'll have to unlock and lock nr_pages times?  and this is the mo=
st
> >> >> > common scenario.
> >> >>
> >> >> No.  In put_swap_folio(), free_entries is either SWAPFILE_CLUSTER (=
that
> >> >> is, nr_pages) or 0.  These are the most common cases.
> >> >>
> >> >
> >> > i am actually talking about the below code path,
> >> >
> >> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
> >> > {
> >> >         ...
> >> >
> >> >         ci =3D lock_cluster_or_swap_info(si, offset);
> >> >         ...
> >> >         for (i =3D 0; i < size; i++, entry.val++) {
> >> >                 if (!__swap_entry_free_locked(si, offset + i, SWAP_H=
AS_CACHE)) {
> >> >                         unlock_cluster_or_swap_info(si, ci);
> >> >                         free_swap_slot(entry);
> >> >                         if (i =3D=3D size - 1)
> >> >                                 return;
> >> >                         lock_cluster_or_swap_info(si, offset);
> >> >                 }
> >> >         }
> >> >         unlock_cluster_or_swap_info(si, ci);
> >> > }
> >> >
> >> > but i guess you are talking about the below code path:
> >> >
> >> > void put_swap_folio(struct folio *folio, swp_entry_t entry)
> >> > {
> >> >         ...
> >> >
> >> >         ci =3D lock_cluster_or_swap_info(si, offset);
> >> >         if (size =3D=3D SWAPFILE_CLUSTER) {
> >> >                 map =3D si->swap_map + offset;
> >> >                 for (i =3D 0; i < SWAPFILE_CLUSTER; i++) {
> >> >                         val =3D map[i];
> >> >                         VM_BUG_ON(!(val & SWAP_HAS_CACHE));
> >> >                         if (val =3D=3D SWAP_HAS_CACHE)
> >> >                                 free_entries++;
> >> >                 }
> >> >                 if (free_entries =3D=3D SWAPFILE_CLUSTER) {
> >> >                         unlock_cluster_or_swap_info(si, ci);
> >> >                         spin_lock(&si->lock);
> >> >                         mem_cgroup_uncharge_swap(entry, SWAPFILE_CLU=
STER);
> >> >                         swap_free_cluster(si, idx);
> >> >                         spin_unlock(&si->lock);
> >> >                         return;
> >> >                 }
> >> >         }
> >> > }
> >>
> >> I am talking about both code paths.  In 2 most common cases,
> >> __swap_entry_free_locked() will return 0 or !0 for all entries in rang=
e.
> >
> > I grasp your point, but if conditions involving 0 or non-0 values fail,=
 we'll
> > end up repeatedly unlocking and locking. Picture a scenario with a larg=
e
> > folio shared by multiple processes. One process might unmap a portion
> > while another still holds an entire mapping to it. This could lead to s=
ituations
> > where free_entries doesn't equal 0 and free_entries doesn't equal
> > nr_pages, resulting in multiple unlock and lock operations.
>
> This is impossible in current caller, because the folio is in the swap
> cache.  But if we move the change to __swap_entry_free_nr(), we may run
> into this situation.

I don't understand why it is impossible, after try_to_unmap_one() has done
on one process, mprotect and munmap called on a part of the large folio
pte entries which now have been swap entries, we are removing the PTE
for this part. Another process can entirely hit the swapcache and have
all swap entries mapped there, and we call swap_free_nr(entry, nr_pages) in
do_swap_page. Within those swap entries, some have swapcount=3D1 and others
have swapcount > 1. Am I missing something?

>
> > Chuanhua has invested significant effort in following Ryan's suggestion
> > for the current approach, which generally handles all cases, especially
> > partial unmapping. Additionally, the widespread use of swap_free_nr()
> > as you suggested across various scenarios is noteworthy.
> >
> > Unless there's evidence indicating performance issues or bugs, I believ=
e
> > the current approach remains preferable.
>
> TBH, I don't like the large stack space usage (64 bytes).  How about use
> a "unsigned long" as bitmap?  Then, we use much less stack space, use
> bitmap =3D=3D 0 and bitmap =3D=3D (unsigned long)(-1) to check the most c=
ommon
> use cases.  And, we have enough batching.

that is quite a straightforward modification like,

- #define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLUSTER)
+ #define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 64 ? 64 : SWAPFILE_CLUSTER)

there is no necessity to remove the bitmap API and move to raw
unsigned long operations.
as bitmap is exactly some unsigned long. on 64bit CPU, we are now one
unsigned long,
on 32bit CPU, it is now two unsigned long.

>
> >>
> >> > we are mTHP, so we can't assume our size is SWAPFILE_CLUSTER?
> >> > or you want to check free_entries =3D=3D "1 << swap_entry_order(foli=
o_order(folio))"
> >> > instead of SWAPFILE_CLUSTER for the "for (i =3D 0; i < size; i++, en=
try.val++)"
> >> > path?
> >>
> >> Just replace SWAPFILE_CLUSTER with "nr_pages" in your code.
> >>
> >> >
> >> >> >>
> >> >> >> And, we should add batching in __swap_entry_free().  That will h=
elp
> >> >> >> free_swap_and_cache_nr() too.
> >> >
> >> > Chris Li and I actually discussed it before, while I completely
> >> > agree this can be batched. but i'd like to defer this as an incremen=
tal
> >> > patchset later to keep this swapcache-refault small.
> >>
> >> OK.
> >>
> >> >>
> >> >> Please consider this too.
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

