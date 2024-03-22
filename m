Return-Path: <linux-kernel+bounces-111900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D264C887258
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614281F2357E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAD360DE7;
	Fri, 22 Mar 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKLQsoOf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338B060DDE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130236; cv=none; b=u263L0BQnlHthBloVuST5Erf8ECdq+X2F8qG2oGMtm2SmVbyU99SLGz37MXm6H5Mnq5Na8TSRhUWFgNNMBCGWaQH3pjDwFYhR+NJ89MBJBftazrVtNGuhZTN4Xg2uKSb+59ATbEZGkKLUEKg9rMi2qCmdGNV0boY4nbYZikH9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130236; c=relaxed/simple;
	bh=mM7NWhSY6z5TddPTSw8WVC1hSX82LYfXMQln00iystk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghEui9QXm6yNTGJB7XQL0+WgRORigBKzUzV9lnEbbVgNOpvQ0F91abfz5fWL2psJPpHBnvxmVJX4JMWPcWcUMEA53msUwVCOYXcNbBPjgL00t7egazRKp/Ee7raUxSw6Ee6SqsicL4RVzKu0TbSDrkt/GalTqd1qsyKkpbEuKaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKLQsoOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13560C43399
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711130236;
	bh=mM7NWhSY6z5TddPTSw8WVC1hSX82LYfXMQln00iystk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WKLQsoOfLM84nHZsCNIBwYx5ELFGnsaCFTZySFMjn7ya3HaXdINPhqWzPiPlhL1uu
	 cN7q28v7TRcPG3NUPGNK5W//Nnf85jIKTExiNeRvN4QZIZkmHUVh/ZSUVw1Fujv4Ca
	 hpCELeIybKK6TWXcpNjV3/vY8+VGzURkBXqbcgvuFZTN/xY8Nb8KNsMjIiCib3KCJi
	 ES+f/kcGGcFLly0khLRW/U5PaKq5E8PtJ9aFclh/HlKT/1HR8cSyOylp8aDOFz3uJl
	 ZaDkZllTlNzOHokcZ1sBsJW6OC07QfkyRAc9iiMdE+GnkORGdFIRwBgq2tpsQ0HMfP
	 HCsuQBPUnHzag==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d485886545so45361321fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:57:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUo/yz2WdYrajtMimE+/8n4St6cgKedUPPJ7fEON9XtQeJahbWXvdUiCGpyRiUxt2Yp8u1i/kwf7JbX+tCe0ZEVTrdxr2syUMxkz1bU
X-Gm-Message-State: AOJu0YxBBtkrotcU2tDpOahGIxu6JmMbHgu5emM36B/gcVWa6LqftXv1
	ozPfbrXfZJQwOt8lzURZnTYQjU7b+AtRpHrK/dqkSGi9g0Sjdf+zQGOYglLbVfgZYCwBc8p1CsF
	MXvkNznAMVSM2G2i7WAo91X9hIA==
X-Google-Smtp-Source: AGHT+IGg00Z3xXqEO5amjFulED6haeKRnEP8QENf7DK6uJX4i0kQc6vKh+x3JT0k3RCDKeGrNMBsNZv8I+/E2If8mFw=
X-Received: by 2002:a2e:80d9:0:b0:2d4:8bfe:69b7 with SMTP id
 r25-20020a2e80d9000000b002d48bfe69b7mr209193ljg.46.1711130234650; Fri, 22 Mar
 2024 10:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-zswap-fill-v1-1-b6180dbf7c27@kernel.org>
 <CAJD7tkY8os3yvYLiotaiRuYa1jdEGiPHQsZEU6E52zRBQ34kQQ@mail.gmail.com>
 <20240322031907.GA237176@cmpxchg.org> <CAF8kJuNe5xXVp00Ogk2AL_zXFK6pN0u7=0avjyPPkagB3FWy8Q@mail.gmail.com>
 <20240322171156.GC237176@cmpxchg.org>
In-Reply-To: <20240322171156.GC237176@cmpxchg.org>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 22 Mar 2024 10:57:01 -0700
X-Gmail-Original-Message-ID: <CANeU7QnMP3bMU42nz6nWS-g9AcaNTzDfK+VxL0p4oCVW0kwpzQ@mail.gmail.com>
Message-ID: <CANeU7QnMP3bMU42nz6nWS-g9AcaNTzDfK+VxL0p4oCVW0kwpzQ@mail.gmail.com>
Subject: Re: [PATCH] zswap: initialize entry->pool on same filled entry
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 10:12=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Fri, Mar 22, 2024 at 06:35:43AM -0700, Chris Li wrote:
> > On Thu, Mar 21, 2024 at 8:19=E2=80=AFPM Johannes Weiner <hannes@cmpxchg=
org> wrote:
> > >
> > > On Thu, Mar 21, 2024 at 04:56:05PM -0700, Yosry Ahmed wrote:
> > > > On Thu, Mar 21, 2024 at 4:53=E2=80=AFPM Chris Li <chrisl@kernel.org=
> wrote:
> > > > >
> > > > > Current zswap will leave the entry->pool uninitialized if
> > > > > the page is same  filled. The entry->pool pointer can
> > > > > contain data written by previous usage.
> > > > >
> > > > > Initialize entry->pool to zero for the same filled zswap entry.
> > > > >
> > > > > Signed-off-by: Chris Li <chrisl@kernel.org>
> > > > > ---
> > > > > Per Yosry's suggestion to split out this clean up
> > > > > from the zxwap rb tree to xarray patch.
> > > > >
> > > > > https://lore.kernel.org/all/ZemDuW25YxjqAjm-@google.com/
> > > > > ---
> > > > >  mm/zswap.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > index b31c977f53e9..f04a75a36236 100644
> > > > > --- a/mm/zswap.c
> > > > > +++ b/mm/zswap.c
> > > > > @@ -1527,6 +1527,7 @@ bool zswap_store(struct folio *folio)
> > > > >                         kunmap_local(src);
> > > > >                         entry->length =3D 0;
> > > > >                         entry->value =3D value;
> > > > > +                       entry->pool =3D 0;
> > > >
> > > > This should be NULL.
> > > >
> > > > That being said, I am working on a series that should make non-fill=
ed
> > > > entries not use a zswap_entry at all. So I think this cleanup is
> > > > unnecessary, especially that it is documented in the definition of
> > > > struct zswap_entry that entry->pool is invalid for same-filled
> > > > entries.
> > >
> > > Yeah I don't think it's necessary to initialize. The field isn't vali=
d
> > > when it's a same-filled entry, just like `handle` would contain
> > > nonsense as it's unionized with value.
> > >
> > > What would actually be safer is to make the two subtypes explicit, an=
d
> > > not have unused/ambiguous/overloaded members at all:
> > >
> > > struct zswap_entry {
> > >         unsigned int length;
> > >         struct obj_cgroup *objcg;
> > > };
> > >
> > > struct zswap_compressed_entry {
> > >         struct zswap_entry entry;
> > >         struct zswap_pool *pool;
> > >         unsigned long handle;
> > >         struct list_head lru;
> > >         swp_entry_t swpentry;
> > > };
> > >
> > > struct zswap_samefilled_entry {
> > >         struct zswap_entry entry;
> > >         unsigned long value;
> > > };
> >
> > I think the 3 struct with embedded and container of is a bit complex,
> > because the state breaks into different struct members
>
> That's kind of the point. They're different types that have their own
> rules and code paths. The code as it is right now makes it seem like
> they're almost the same. From the above you can see that they have
> actually almost nothing in common (the bits in struct zswap_entry).

Not sure about how you envision the different code paths look like.

> This would force the code to show the difference as well.
>
> Depending on how Yosry's patches work out, this may or may not be
> worth doing. It's just an idea that could help make it easier.

Agree, would need to see the actual code to reason about the minor differen=
ce.

>
> > How about:
> >
> > struct zswap_entry {
> >         unsigned int length;
> >         struct obj_cgroup *objcg;
> >         union {
> >                 struct /* compressed */ {
> >                          struct zswap_pool *pool;
> >                          unsigned long handle;
> >                          swp_entry_t swpentry;
> >                          struct list_head lru;
> >                 };
> >                struct /* same filled */ {
> >                        unsigned long value;
> >                 };
> >         };
> > };
> >
> > That should have the same effect of the above three structures. Easier
> > to visualize the containing structure.
>
> I suppose it makes the struct a bit clearer when you directly look at
> it, but I don't see how it would help with code clarity.

Just curious, would changing the anonymous struct to the named struct
helps to address code clarity you have in mind?
It would go through entry->compressed.pool for example.

Chris

