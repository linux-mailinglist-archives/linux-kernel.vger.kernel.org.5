Return-Path: <linux-kernel+bounces-44017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BCB841C43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478791C22F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94DF45006;
	Tue, 30 Jan 2024 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiyLNfU2"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF203D393
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598101; cv=none; b=PEuZilUfvDhQnzb0IcLeKmGdMxT+1m7ktNWl0ykFMXeWSMkG4Vte9zbj3KLfZR+y0lpoQsbG3DzceL41RorDIdjb4iWA1Old5VaL1/NJp19ompvM6nzmg69ExhyYiHSWJqvr2VEIjidAicdCsrW7S7Uf9Zn3kShP9kYdD0IETBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598101; c=relaxed/simple;
	bh=7eSCJY8cwbuk6cq40TPiIxJx23JeEYA5nQHbWt/ogAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ek5TaD2I3hOYfqWASFz4tnLcTnIsLf5quKCx6e7zqnJDKIWDnf6mhoFWLTUcP+aBDwHuNCtxIo1lGnYUwiCRaAaqfovcA1OxLOIPuG/StL7p1VpsOGqI945Sn7UwYAvtmyNeRlfIgoVIiyhRyZRv7vofheZrWYehcuoXHmskIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiyLNfU2; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cf45305403so34200281fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706598098; x=1707202898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOcr0/zytsqYYa9EmZhgnI5xTH3X0lz+GqOcsR1oGH0=;
        b=IiyLNfU2ufHBNaXc8ipQNr+ok94MqK8de48ULuhq5txRcWc0ntUjwOtSZ+VJopzHOh
         87a834nCWOcB5gBGHB6kGIuF0iYH9wViLbmnYCzsRAPBEev7kifrOXISgrn9Cz10zuDF
         caql7utpzj91QjKB8TI5bbOBw6loI85T3+syiZpyYLp/ye+qDP1sHzGri647GgPN6bCa
         YMaE+lZV8KfxotmJvIrwO7ET5XpSkRKL5aK5yvrd8d6jIuQki2+qP5vB4HP0nS2lLnqp
         rS/AMCzBkPQJ5VSeBWK2TqdPoKDt8UDzwRp+rxxB5j+2qzCRYaAykQZRtvbgXbhtfWJa
         8JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706598098; x=1707202898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOcr0/zytsqYYa9EmZhgnI5xTH3X0lz+GqOcsR1oGH0=;
        b=ULpdm26ZP7Z3/h/288ljwJhEWQwHH2DfHlFUvZ56iwLQU7x7Xv6d+FypNIkHS8q0as
         Ts5NjqeQYNADpV4Yfl/L2tT6VDM96O+bXJp2z3KlsVaOecIEUroC+v9HgLAfV6TBGcs1
         LL8sVD20Ivfw8I7TJUUPPbxMFUWRyp1ldCphSSqUZ8d9cveyxDD7puSz8Pm6MTpsoHwQ
         bKNYa5qh9mGhmvaUp5zC9wn2YNHhoOGqC5YoYndxYcT4aIs7jSs+bfFL8sFlNmnuWir0
         bjX6EfNQtqm5aKylEW+PFMxozjVHz9+s4HmwZM1BM+qpRmkX7axys38cD3uJB5Q3r5oE
         e/sg==
X-Gm-Message-State: AOJu0YyIA4/yiFzzuPnzWc7ipiefr91Z02FYnNo3WPQeJiN0+ubMBoe9
	EwpL5qMFWFbSVBqRFotfHCr4IT0qHZ3EjxHQVWRGnaBhgY8g688ifsSXux8HnyTazz/VYaQHUEO
	bsgMQU7/uZ0ANgJKu7/pBXk8juAI=
X-Google-Smtp-Source: AGHT+IFCMFLmoHrPCGUWiRvRoNh1CqYnql8wz3vSCot8F+nrDokESSEpzx5qasJqkWZKkJUy/zxKred38mjbt1wpfiQ=
X-Received: by 2002:a2e:7c08:0:b0:2cf:1be6:70f4 with SMTP id
 x8-20020a2e7c08000000b002cf1be670f4mr4723552ljc.44.1706598097823; Mon, 29 Jan
 2024 23:01:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129175423.1987-1-ryncsn@gmail.com> <20240129175423.1987-4-ryncsn@gmail.com>
 <87sf2fgxi5.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87sf2fgxi5.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 30 Jan 2024 15:01:20 +0800
Message-ID: <CAMgjq7D-YG406WeSGuDzaQ1=ZJ8DpO99JCcMdaptrhqLdtuRkg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mm/swap: always account swapped in page into
 current memcg
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 2:14=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Currently, mem_cgroup_swapin_charge_folio is always called with
> > mm =3D=3D NULL, except in swapin_direct.
> >
> > swapin_direct is only used when swapin should skip readahead
> > and swapcache (SWP_SYNCHRONOUS_IO). All other callers of
> > mem_cgroup_swapin_charge_folio are for swapin that should
> > not skip readahead and cache.
> >
> > This could cause swapin charging to behave differently depending
> > on swap device, which is unexpected.
> >
> > This is currently not happening because the only caller of
> > swapin_direct is the direct anon page fault path, where mm always
> > equals to current->mm, but will no longer be true if swapin_direct
> > is shared and have other callers (eg, swapoff) to share the
> > readahead skipping logic.
> >
> > So make swapin_direct also pass NULL for mm, so swpain charge
> > will behave consistently and not effected by type of swapin device
> > or readahead policy.
> >
> > After this, the second param of mem_cgroup_swapin_charge_folio is
> > never used now, so it can be safely dropped.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  include/linux/memcontrol.h | 4 ++--
> >  mm/memcontrol.c            | 5 ++---
> >  mm/swap_state.c            | 7 +++----
> >  3 files changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 20ff87f8e001..540590d80958 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -693,7 +693,7 @@ static inline int mem_cgroup_charge(struct folio *f=
olio, struct mm_struct *mm,
> >  int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
> >               long nr_pages);
> >
> > -int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_stru=
ct *mm,
> > +int mem_cgroup_swapin_charge_folio(struct folio *folio,
> >                                 gfp_t gfp, swp_entry_t entry);
> >  void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
> >
> > @@ -1281,7 +1281,7 @@ static inline int mem_cgroup_hugetlb_try_charge(s=
truct mem_cgroup *memcg,
> >  }
> >
> >  static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
> > -                     struct mm_struct *mm, gfp_t gfp, swp_entry_t entr=
y)
> > +             gfp_t gfp, swp_entry_t entry)
> >  {
> >       return 0;
> >  }
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e4c8735e7c85..5852742df958 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -7306,8 +7306,7 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgro=
up *memcg, gfp_t gfp,
> >   *
> >   * Returns 0 on success. Otherwise, an error code is returned.
> >   */
> > -int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_stru=
ct *mm,
> > -                               gfp_t gfp, swp_entry_t entry)
> > +int mem_cgroup_swapin_charge_folio(struct folio *folio, gfp_t gfp, swp=
_entry_t entry)
> >  {
> >       struct mem_cgroup *memcg;
> >       unsigned short id;
> > @@ -7320,7 +7319,7 @@ int mem_cgroup_swapin_charge_folio(struct folio *=
folio, struct mm_struct *mm,
> >       rcu_read_lock();
> >       memcg =3D mem_cgroup_from_id(id);
> >       if (!memcg || !css_tryget_online(&memcg->css))
> > -             memcg =3D get_mem_cgroup_from_mm(mm);
> > +             memcg =3D get_mem_cgroup_from_current();
>
> The behavior of get_mem_cgroup_from_mm(NULL) and
> get_mem_cgroup_from_current() isn't same exactly.  Are you sure that
> this is OK?

Hi Ying, thank you very much for the careful review.

IIUC, usually get_mem_cgroup_from_mm(NULL) is for allocations without
mm context (after set_active_memcg), so remote charging cgroup is used
first.

But for swap cases it's a bit special, all swapin are issued from
userspace, so remote charging isn't useful. Not sure if it even may
potentially lead to charging into the wrong cgroup.

And for this callsite, it's called only when `if (!memcg ||
!css_tryget_online(&memcg->css))` is true, only case I know is swapoff
(and the memcg is dead) case, or there are some leaks. The behaviour
of swapoff case has been discussed previously, so currently we just
charge it into the current task's memcg.

This is indeed a potential behaviour change though, I can change it
back to get_mem_cgroup_from_mm(NULL), and post another patch later for
this and discuss in more details.

>
> --
> Best Regards,
> Huang, Ying

