Return-Path: <linux-kernel+bounces-109298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D90CA88175C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93002285215
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653FC8563D;
	Wed, 20 Mar 2024 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+VNGL0Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E3B6A03E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959687; cv=none; b=h3/Wx6p/hgxHzFHqifCezm9gB1OIYDvOCKU97YAGnDpBFFa33VPKvCnmnsTs555RlRoNgBlKlJWpC5tRFNdbx7BxfndkDRfocYlrJroULEmrDjAh2pfBRKKwbL4T5QkOTbLeN6f3bXs44tcFn+zNgqVE3yeF7GGUpqBlInHRfZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959687; c=relaxed/simple;
	bh=yROABpQhiEj/haGfBqdFlpMyY4R0CsHS6BSPalzpIq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MO5noEEfEOC8lW+ikO2lu8wVT9b4I5i/FopjgIoLeBMDeWwJ8v2dWYEHBmHIb6PVkm06QbE0Hx9fSzfhe9n48mX1UHgOdKzr3b3LjTkdWof78Km7fnqLKgs5o1eGqkQBjwqQy6kKbhXD5RP9lqVSiRIsoNAGTb+BOjQrf/osAIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+VNGL0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2004CC433F1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710959687;
	bh=yROABpQhiEj/haGfBqdFlpMyY4R0CsHS6BSPalzpIq8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N+VNGL0QrxV0tp2rFWogoY4tCujasKU6QXpwdsJWcqjBy9lYTIcrXllIStlAXRCy9
	 YoLZU3OSmXB/+bVtfAoc9Oakh0qoe2ufffKD+oFcXY360CLLS3cwV9/rinzodv00qK
	 sUwhF0EmBqPZbEV1iDnQNqY2fWLfuGY/jbof+sXrUjcUONdCQNDqHPVfpevbJOtHX5
	 Lb/Soj1NbS0JJuLxaYR7H5sxmnNDhhes1XoA6+LlqP0fkzHbeamp8q9GhRySIuT70B
	 pHTMGdJajHzQ5FnqAj0n0ejZWIsXKnfWbIi+WKeW7fkHid7C1PoCbD0BrMMtnThNri
	 +F1pj5HGunVnw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso2453051fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:34:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUX5Y9rcE7fQ1DymcOm6WRO+BCJuL21bvlYvZUeoD6tZUKFR0VoVfR/mjH6mAACJwEf1W+IvEivrKTLwt/NOzJwRSszEAjfQFb7E9u
X-Gm-Message-State: AOJu0Yz3ZDA5XU83hXx31t+kqEm6M+Z1d7X79kqlWBDQ+MElTPp9l1S2
	VHPP+RqVCXNcqEc6+0CcGZa00f+B7LeU54tscLoPU43+OFpVQ9FCMK8RoZ2w9iy5O6bEuJHfG44
	WgLr6tiwIfm+z7rKYYQrMRm74Tg==
X-Google-Smtp-Source: AGHT+IHkqi9pXNyzThnVJEGeMXXXOSr1eyWI1DbgoGjWraxm2MOHjnPHNvLIqJ0cmIil3lbeRoTlMDB99qQ55LHaKHE=
X-Received: by 2002:a05:651c:c6:b0:2d4:2b05:a671 with SMTP id
 6-20020a05651c00c600b002d42b05a671mr11089276ljr.32.1710959685792; Wed, 20 Mar
 2024 11:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org>
 <Zfp-iWaDfqeCOElt@google.com> <CANeU7Q=yxf0dnerTOZfe_ioeCbjnZd2Fpb-szvW7-Q1BzCUpOw@mail.gmail.com>
 <ZfqPK7AVunq2SC1l@google.com> <20240320100803.GB294822@cmpxchg.org>
In-Reply-To: <20240320100803.GB294822@cmpxchg.org>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 20 Mar 2024 11:34:32 -0700
X-Gmail-Original-Message-ID: <CANeU7Q=w-vgx3wD9xR6_A-cCe+FFOKfbaoKdYUccOG4B1ir1oA@mail.gmail.com>
Message-ID: <CANeU7Q=w-vgx3wD9xR6_A-cCe+FFOKfbaoKdYUccOG4B1ir1oA@mail.gmail.com>
Subject: Re: [PATCH v7] zswap: replace RB tree with xarray
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:08=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Mar 20, 2024 at 07:24:27AM +0000, Yosry Ahmed wrote:
> > [..]
> > > > > -     /* map */
> > > > > -     spin_lock(&tree->lock);
> > > > >       /*
> > > > > -      * The folio may have been dirtied again, invalidate the
> > > > > -      * possibly stale entry before inserting the new entry.
> > > > > +      * We finish initializing the entry while it's already in x=
array.
> > > > > +      * This is safe because:
> > > > > +      *
> > > > > +      * 1. Concurrent stores and invalidations are excluded by f=
olio lock.
> > > > > +      *
> > > > > +      * 2. Writeback is excluded by the entry not being on the L=
RU yet.
> > > > > +      *    The publishing order matters to prevent writeback fro=
m seeing
> > > > > +      *    an incoherent entry.
> > > >
> > > > As I mentioned before, writeback is also protected by the folio loc=
k.
> > > > Concurrent writeback will find the folio in the swapcache and abort=
 The
> > > > fact that the entry is not on the LRU yet is just additional protec=
tion,
> > > > so I don't think the publishing order actually matters here. Right?
> > >
> > > Right. This comment is explaining why this publishing order does not
> > > matter. I think we are talking about the same thing here?
> >
> > The comment literally says "the publishing order matters.." :)
> >
> > I believe Johannes meant that we should only publish the entry to the
> > LRU once it is fully initialized, to prevent writeback from using a
> > partially initialized entry.
> >
> > What I am saying is that, even if we add a partially initialized entry
> > to the zswap LRU, writeback will skip it anyway because the folio is
> > locked in the swapcache.
> >
> > So basically I think the comment should say:
> >
> >       /*
> >        * We finish initializing the entry while it's already in the
> >        * xarray. This is safe because the folio is locked in the swap
> >        * cache, which should protect against concurrent stores,
> >        * invalidations, and writeback.
> >        */
> >
> > Johannes, what do you think?
>
> I don't think that's quite right.
>
> Writeback will bail on swapcache insert, yes, but it will access the
> entry before attempting it. If LRU publishing happened before setting
> entry->swpentry e.g., we'd have a problem, while your comment suggets
> it would be safe to rearrange the code like this.
>
> So LRU publishing order does matter.

Yes, I agree with Johannes on this one. The publish order does matter,
it is not always safe recording the publish order. I will keep the V7
comments here.

Chris

