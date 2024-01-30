Return-Path: <linux-kernel+bounces-44022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCE8841C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6871289F85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C32354670;
	Tue, 30 Jan 2024 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/j5l05B"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF40754659
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598226; cv=none; b=cf/Yepr5gQSbp26rQKoR25Aow8EhMJWe92Jv1/QF4YObca0NBQMT+rwBx3hIrH1eTjXRWeTeTPlmErSGqkLIIP6FwzK77f1SvyP9FGaTzHG9xxlKhBIfp4XRsti7h4S3bYwvfATHc6pP/yJxX8gf/kFu9jAQhmpyRL54Ih4QgOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598226; c=relaxed/simple;
	bh=WfnKhnqmEPtzSO6mpmiV3XrR9W+AtYlb1V2xqCderjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlvY58/Gr/C8EpXo6eGKSU5JHm+/T1IFd4r17Cd26vgIoX2w6bNMkixhxs84WqzvXGpQp8ram0i9VyxyTMpnXjH8EwoEzZ+sKxuQLl1E68lgJbPettEoMkMNiaYHU8ng/kC+9cgKyV0f0UcuEh/z4vsv++p1fW7vWABIFfVeM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/j5l05B; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf3a0b2355so43167551fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706598223; x=1707203023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIE4KQDb529O0G81Tw1SwOjqWduyvxr5+he0HDK9pg4=;
        b=K/j5l05Bd+/cJp5IEIVesAKwmkeKnjOpra99catfERvA/V7ok450AWG7zI7k3EaFXj
         FqFTRqZLYtrJWY6T7i12RgQ0hfjpJAONzEqy3Nm1t7xJB96cd6g+D9GDiQZMDymABxWw
         IbZRInNhzdSrZxpp8ReHwxLVEOLDB8OdMNXuaHXZjxwJwEco5OLeLaic7irOCTfFwbBd
         HC7m+9uAhlCQd5TjhINmNw16+LxEvLCB/5Mko7b394yFcfIHQF14e4ruE4bY4ZKf+Qej
         zouHizbnqE4gXlDO/nzl6NPuwkyh5q0S2I7n+74JI1rVFnwkx9xSvKUZiCW/y1OpxoRB
         ygcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706598223; x=1707203023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIE4KQDb529O0G81Tw1SwOjqWduyvxr5+he0HDK9pg4=;
        b=OrU3xDM7P/HBJhwnHVaE7QRDvR1d0ThfTpD2GU9w4Y4Q4ChuJjfx+dlG0c8sqijk4J
         Cs3oST/6/v05bMo/Dg3cD3XQ47rRq9TZ01/g9HQn6lZQvfImVZOTsPH2cCv2Y8eTx3aT
         cg0KxB4WAbpL+Dd6U2wPa1GiVMmE38oAe+h/A+j4B+t/zLwXWA6tmeJh/E9MTkJuZiEw
         CjkIkj3/jJDD8IWOrzGk9/3AbVEdvB9eiJgFJR2mgDDr5Yu6P3S9jpeOmfwQjUCgDvfu
         g3UBRwAgc8bHUdoS2HrtNimo/IU3mpmsU75rj5++afPWGWq7aR6L1f4N+z/z9YkJ/nhl
         2N7g==
X-Gm-Message-State: AOJu0YxxrERucl4ayj4oc2q16z/Qece68PuMI3z2E5s0fnrEGzbm6lEk
	FixJv4gblXhNlsRtSc0abXRDSp/DAss1AYzEPGKbAmdwuD4b8C7ddhwT/GZ4VrbmH5skHoFCt0a
	JsixBzqwR950AoK7NVnCKOxpoaCY=
X-Google-Smtp-Source: AGHT+IGEnMW99hRYngYXqneuOspacZBUb2liuGzMKm4/XbYrYOCoYbv5g+Q0nVkvgf+GorwlY/RT/i5T8wJ+MclxTG8=
X-Received: by 2002:a2e:b041:0:b0:2cf:2004:3614 with SMTP id
 d1-20020a2eb041000000b002cf20043614mr4785270ljl.15.1706598222755; Mon, 29 Jan
 2024 23:03:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129175423.1987-1-ryncsn@gmail.com> <20240129175423.1987-4-ryncsn@gmail.com>
 <87sf2fgxi5.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7D-YG406WeSGuDzaQ1=ZJ8DpO99JCcMdaptrhqLdtuRkg@mail.gmail.com>
In-Reply-To: <CAMgjq7D-YG406WeSGuDzaQ1=ZJ8DpO99JCcMdaptrhqLdtuRkg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 30 Jan 2024 15:03:25 +0800
Message-ID: <CAMgjq7CT4hpbza=VKm=01bLinQyoGsco0yXvTLRpQvLGdc=G2A@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mm/swap: always account swapped in page into
 current memcg
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 3:01=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Jan 30, 2024 at 2:14=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
> >
> > Kairui Song <ryncsn@gmail.com> writes:
> >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Currently, mem_cgroup_swapin_charge_folio is always called with
> > > mm =3D=3D NULL, except in swapin_direct.
> > >
> > > swapin_direct is only used when swapin should skip readahead
> > > and swapcache (SWP_SYNCHRONOUS_IO). All other callers of
> > > mem_cgroup_swapin_charge_folio are for swapin that should
> > > not skip readahead and cache.
> > >
> > > This could cause swapin charging to behave differently depending
> > > on swap device, which is unexpected.
> > >
> > > This is currently not happening because the only caller of
> > > swapin_direct is the direct anon page fault path, where mm always
> > > equals to current->mm, but will no longer be true if swapin_direct
> > > is shared and have other callers (eg, swapoff) to share the
> > > readahead skipping logic.
> > >
> > > So make swapin_direct also pass NULL for mm, so swpain charge
> > > will behave consistently and not effected by type of swapin device
> > > or readahead policy.
> > >
> > > After this, the second param of mem_cgroup_swapin_charge_folio is
> > > never used now, so it can be safely dropped.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  include/linux/memcontrol.h | 4 ++--
> > >  mm/memcontrol.c            | 5 ++---
> > >  mm/swap_state.c            | 7 +++----
> > >  3 files changed, 7 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 20ff87f8e001..540590d80958 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -693,7 +693,7 @@ static inline int mem_cgroup_charge(struct folio =
*folio, struct mm_struct *mm,
> > >  int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gf=
p,
> > >               long nr_pages);
> > >
> > > -int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_st=
ruct *mm,
> > > +int mem_cgroup_swapin_charge_folio(struct folio *folio,
> > >                                 gfp_t gfp, swp_entry_t entry);
> > >  void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
> > >
> > > @@ -1281,7 +1281,7 @@ static inline int mem_cgroup_hugetlb_try_charge=
(struct mem_cgroup *memcg,
> > >  }
> > >
> > >  static inline int mem_cgroup_swapin_charge_folio(struct folio *folio=
,
> > > -                     struct mm_struct *mm, gfp_t gfp, swp_entry_t en=
try)
> > > +             gfp_t gfp, swp_entry_t entry)
> > >  {
> > >       return 0;
> > >  }
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index e4c8735e7c85..5852742df958 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -7306,8 +7306,7 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cg=
roup *memcg, gfp_t gfp,
> > >   *
> > >   * Returns 0 on success. Otherwise, an error code is returned.
> > >   */
> > > -int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_st=
ruct *mm,
> > > -                               gfp_t gfp, swp_entry_t entry)
> > > +int mem_cgroup_swapin_charge_folio(struct folio *folio, gfp_t gfp, s=
wp_entry_t entry)
> > >  {
> > >       struct mem_cgroup *memcg;
> > >       unsigned short id;
> > > @@ -7320,7 +7319,7 @@ int mem_cgroup_swapin_charge_folio(struct folio=
 *folio, struct mm_struct *mm,
> > >       rcu_read_lock();
> > >       memcg =3D mem_cgroup_from_id(id);
> > >       if (!memcg || !css_tryget_online(&memcg->css))
> > > -             memcg =3D get_mem_cgroup_from_mm(mm);
> > > +             memcg =3D get_mem_cgroup_from_current();
> >
> > The behavior of get_mem_cgroup_from_mm(NULL) and
> > get_mem_cgroup_from_current() isn't same exactly.  Are you sure that
> > this is OK?
>
> Hi Ying, thank you very much for the careful review.
>
> IIUC, usually get_mem_cgroup_from_mm(NULL) is for allocations without
> mm context (after set_active_memcg), so remote charging cgroup is used
> first.
>
> But for swap cases it's a bit special, all swapin are issued from
> userspace, so remote charging isn't useful. Not sure if it even may
> potentially lead to charging into the wrong cgroup.
>
> And for this callsite, it's called only when `if (!memcg ||
> !css_tryget_online(&memcg->css))` is true, only case I know is swapoff
> (and the memcg is dead) case, or there are some leaks. The behaviour

Oh, actually shmem may also have the zombie cgroup issue, the
conclusion is still the same though, the task accessed the shmem owns
the charge.

> of swapoff case has been discussed previously, so currently we just
> charge it into the current task's memcg.
>
> This is indeed a potential behaviour change though, I can change it
> back to get_mem_cgroup_from_mm(NULL), and post another patch later for
> this and discuss in more details.
>
> >
> > --
> > Best Regards,
> > Huang, Ying

