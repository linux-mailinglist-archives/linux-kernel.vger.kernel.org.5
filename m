Return-Path: <linux-kernel+bounces-111551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D965B886D96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169B11C233D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921075C5F4;
	Fri, 22 Mar 2024 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptLKrBtb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE97045BFF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114556; cv=none; b=biZ9daJDc0LBqCR5GoldGL8wiBdygLExsF1IhBcJs3iF9f7sCYOD2Esag51FI/cH0Z/6u3yOz3fbwOG/s89UWesbpiH34PSrpBLpNQINo2+3klasyVWkQ8byx176HEc4PtNuJrbOciRUfr2I+VqXheA2vfindHaSVwhYkAkVkeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114556; c=relaxed/simple;
	bh=u0PRJPH4zZcFF3xqQA9fGoW/XmvWMaMyEmDCCXX09wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgzrrTMR3v7g9Ky/JABZFpHKrOweaIM+OTY27YOnCt1A6CnDpWDrMVOS64BbVq8fwRSrYGJRYx3g2MWBvf6B/hpSZ9Z7B/MwJ2OLuRRWtyRbL6mix4fb0Ln/LN29lLFE8eDGAFfmgk8CODhh68q1v2RPVkGDTH4qx9j5wgLADPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptLKrBtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DDAC433C7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711114556;
	bh=u0PRJPH4zZcFF3xqQA9fGoW/XmvWMaMyEmDCCXX09wU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ptLKrBtbhchtawol//pqO8ctqLfceMYNRVf2k8KlxloAAyepmU2L5ys4vO73YQbth
	 WX6VqEXu4YaLfFdofK5Clz3eaiC3S59dYFD18zYRbY2YKxoepuxeHIDcfVN3jNrfxE
	 Ae6ibCWeE92J4cwYF/95AjR00uM5RNqyQ5+UehyZG42j3IRMfV1wKOKvF5WD9pP5Gu
	 q4qirbN834oFjj8uzQFJO3Yb+uwzYrtTGwKfNqPu3TxOJ+ea6aYOQXpGcBHqx7QyGA
	 KCWsFT4caDHVxwMtKPT5/pXCJlmw3wzuqIsYBgrRwlse1dbF17d8YIzFsOgsqYijcF
	 8/zqAkWiQS54g==
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-366bed3a440so9101115ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:35:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHOPuuFpdIMC6AhSdmL5iqDBKB7cF82K5GChhO89tw2pZoDRi68mZFJP2VeL8+TJZTwWrwoFgE2RF9heH9AfywiPbDWJKa35DAqyh7
X-Gm-Message-State: AOJu0YwADSAZyK6VTICnJeeWpnCfa3EysEeAfxX7P8J13Vnbnqkv1pho
	oqejwymf2l36j56666Z6D7t2oRpk7tJSGhkIiKDfhwLaoDUgngre6Zb1j0pEBFm+buKUYDhgEUc
	wi/EzdNnuN203O4BwdE1xMjvLSBNIaT65oG/K
X-Google-Smtp-Source: AGHT+IHqG3BNO/6Gg345YJ6k829I7v6On+D2mOXMOpo54HKOVzrfbcNkKWNSvPjTFGCJmCjixRNTr8OgiPkFHD85TJA=
X-Received: by 2002:a05:6e02:1252:b0:368:727e:ec71 with SMTP id
 j18-20020a056e02125200b00368727eec71mr1486400ilq.21.1711114555719; Fri, 22
 Mar 2024 06:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-zswap-fill-v1-1-b6180dbf7c27@kernel.org>
 <CAJD7tkY8os3yvYLiotaiRuYa1jdEGiPHQsZEU6E52zRBQ34kQQ@mail.gmail.com> <20240322031907.GA237176@cmpxchg.org>
In-Reply-To: <20240322031907.GA237176@cmpxchg.org>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 22 Mar 2024 06:35:43 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNe5xXVp00Ogk2AL_zXFK6pN0u7=0avjyPPkagB3FWy8Q@mail.gmail.com>
Message-ID: <CAF8kJuNe5xXVp00Ogk2AL_zXFK6pN0u7=0avjyPPkagB3FWy8Q@mail.gmail.com>
Subject: Re: [PATCH] zswap: initialize entry->pool on same filled entry
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 8:19=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Mar 21, 2024 at 04:56:05PM -0700, Yosry Ahmed wrote:
> > On Thu, Mar 21, 2024 at 4:53=E2=80=AFPM Chris Li <chrisl@kernel.org> wr=
ote:
> > >
> > > Current zswap will leave the entry->pool uninitialized if
> > > the page is same  filled. The entry->pool pointer can
> > > contain data written by previous usage.
> > >
> > > Initialize entry->pool to zero for the same filled zswap entry.
> > >
> > > Signed-off-by: Chris Li <chrisl@kernel.org>
> > > ---
> > > Per Yosry's suggestion to split out this clean up
> > > from the zxwap rb tree to xarray patch.
> > >
> > > https://lore.kernel.org/all/ZemDuW25YxjqAjm-@google.com/
> > > ---
> > >  mm/zswap.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index b31c977f53e9..f04a75a36236 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1527,6 +1527,7 @@ bool zswap_store(struct folio *folio)
> > >                         kunmap_local(src);
> > >                         entry->length =3D 0;
> > >                         entry->value =3D value;
> > > +                       entry->pool =3D 0;
> >
> > This should be NULL.
> >
> > That being said, I am working on a series that should make non-filled
> > entries not use a zswap_entry at all. So I think this cleanup is
> > unnecessary, especially that it is documented in the definition of
> > struct zswap_entry that entry->pool is invalid for same-filled
> > entries.
>
> Yeah I don't think it's necessary to initialize. The field isn't valid
> when it's a same-filled entry, just like `handle` would contain
> nonsense as it's unionized with value.
>
> What would actually be safer is to make the two subtypes explicit, and
> not have unused/ambiguous/overloaded members at all:
>
> struct zswap_entry {
>         unsigned int length;
>         struct obj_cgroup *objcg;
> };
>
> struct zswap_compressed_entry {
>         struct zswap_entry entry;
>         struct zswap_pool *pool;
>         unsigned long handle;
>         struct list_head lru;
>         swp_entry_t swpentry;
> };
>
> struct zswap_samefilled_entry {
>         struct zswap_entry entry;
>         unsigned long value;
> };

I think the 3 struct with embedded and container of is a bit complex,
because the state breaks into different struct members

How about:

struct zswap_entry {
        unsigned int length;
        struct obj_cgroup *objcg;
        union {
                struct /* compressed */ {
                         struct zswap_pool *pool;
                         unsigned long handle;
                         swp_entry_t swpentry;
                         struct list_head lru;
                };
               struct /* same filled */ {
                       unsigned long value;
                };
        };
};

That should have the same effect of the above three structures. Easier
to visualize the containing structure.

What do you say?

Chris

>
> Then put zswap_entry pointers in the tree and use the appropriate
> container_of() calls in just a handful of central places. This would
> limit the the points where mistakes can be made, and suggests how the
> code paths to handle them should split naturally.
>
> Might be useful even with your series, since it disambiguates things
> first, and separates the cleanup bits from any functional changes,
> instead of having to do kind of everything at once...
>

