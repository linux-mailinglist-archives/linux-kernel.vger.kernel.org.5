Return-Path: <linux-kernel+bounces-39158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223F183CBA9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485651C25315
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601BB1350D3;
	Thu, 25 Jan 2024 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9nZkK6L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E01350E6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208923; cv=none; b=DbGbpWxv8zE5Gk9mknVsydBwNywGxQaADH1dNFUeBIucMrnEB9ahuD9uGVVqL7GzZm2nfy3vrzAsKK1nYJ/cI8RhqPIsc52BrhDFlJDTAmVJDnckjaQsEmpOa5zCLSJrziCmySaYAVO3LAMRZb6rT1FLFniMCxJXlDWwS1qL1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208923; c=relaxed/simple;
	bh=aKjc5xlHunbTbIhI7wMZoLEn4lQlPZ6vSsme/FeanWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcLe/YRLlXW9StVErM3UU10f1WvXpSsag6Ddo66Fr60ysxsze3qkjErL3dUFGdRZ4L5KRYrGVhnCgyYO9dgBc5QGo5JlI2S0jcvFTe0w35OGq8Cij5oCdJ/iIcu7JKCv1IjIFZtzetIfwx2oFtns94/SfN3COcRfIO9y6eU5sXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9nZkK6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A06C43399
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706208923;
	bh=aKjc5xlHunbTbIhI7wMZoLEn4lQlPZ6vSsme/FeanWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l9nZkK6LBA2Tiem+Z9PSzUlwCoqoJ9/XV3UiVrEKEOlRacPMxULQTRKlk8Y1RK2eL
	 CkY1yNzQqn1HPUKoYW6+K38VzN5gpfbJC95wEres4QlTRphyUJCUdZyRKpTQy0K/zq
	 dbm2tOunZ6XbeXhaUsbl0EpoZSe5tYAzFGstKUYxfAEjedVlInUJi4ngaijhL+nYUL
	 /ajIooe+sBYGSIGLuEmBWhbULjGcwD8OO31EepFZ11XgXQoWD/6qsp4MYO+m3ax6xr
	 dROP5n6sx08z25xG4AXEsxK+K33tokWI2kKoOIdKlzUfZ+OfStooL/OVGv7BBjWT0g
	 3DuaUtaFL8PhA==
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2900c648b8bso5353006a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:55:23 -0800 (PST)
X-Gm-Message-State: AOJu0Yw+d+BHFPDY2VxXAXmlZKMoHTwFAZ33gbazaJFSqL+H1d4vurXt
	p5em+A9hNSgyOCwxyVlwkGZkyJNXbRcADoVIc9CFlQVbiTDhvS663w9ry8+O0u1pRukQUSG8iK5
	bulzlIIrukgC9G0dFRaYmLHiQa7oM65PguOEB
X-Google-Smtp-Source: AGHT+IFxsFCFuBhlbZMn2YDm/IK0CvAR5Gm440cRysqZ/rlnuWy027tdWqbvjDsDLK5kRLFv02SfyzHNRiXTvTqcrAA=
X-Received: by 2002:a17:90b:104f:b0:28f:f220:d4da with SMTP id
 gq15-20020a17090b104f00b0028ff220d4damr30720pjb.69.1706208922608; Thu, 25 Jan
 2024 10:55:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com> <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org> <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
 <20240123201234.GC1745986@cmpxchg.org> <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
 <CAJD7tkaVdJ9B_UDQs+o1nLdbs62CeKgbCyEXbMdezaBgOruEWw@mail.gmail.com>
 <CAF8kJuNkwGNw=Nnu1MVOewKiqT0ahj5DkKV_Z4VDqSpu+v=vmw@mail.gmail.com> <CAJD7tkZViJot2+vFr_yAyRsRf7jTRPsb8wchqkf4R1tSsvLG+A@mail.gmail.com>
In-Reply-To: <CAJD7tkZViJot2+vFr_yAyRsRf7jTRPsb8wchqkf4R1tSsvLG+A@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 25 Jan 2024 10:55:11 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPHrf_-xr8mz5r_TWOWw-Zv+1izFNU=1yKV9EAdC=bGDg@mail.gmail.com>
Message-ID: <CAF8kJuPHrf_-xr8mz5r_TWOWw-Zv+1izFNU=1yKV9EAdC=bGDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,

On Wed, Jan 24, 2024 at 11:59=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Wed, Jan 24, 2024 at 9:29=E2=80=AFPM Chris Li <chriscli@google.com> wr=
ote:
> >
> > Hi Yosry,
> >
> > On Tue, Jan 23, 2024 at 10:58=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
com> wrote:
> > >
> >
> > > >
> > > > Thanks for the great analysis, I missed the swapoff/swapon race mys=
elf :)
> > > >
> > > > The first solution that came to mind for me was refcounting the zsw=
ap
> > > > tree with RCU with percpu-refcount, similar to how cgroup refs are
> > > > handled (init in zswap_swapon() and kill in zswap_swapoff()). I thi=
nk
> > > > the percpu-refcount may be an overkill in terms of memory usage
> > > > though. I think we can still do our own refcounting with RCU, but i=
t
> > > > may be more complicated.
> > >
> > > FWIW, I was able to reproduce the problem in a vm with the following
> > > kernel diff:
> >
> > Thanks for the great find.
> >
> > I was worry about the usage after free situation in this email:
> >
> > https://lore.kernel.org/lkml/CAF8kJuOvOmn7wmKxoqpqSEk4gk63NtQG1Wc+Q0e9F=
Z9OFiUG6g@mail.gmail.com/
> >
> > Glad you are able to find a reproducible case. That is one of the
> > reasons I change the free to invalidate entries in my xarray patch.
> >
> > I think the swap_off code should remove the entry from the tree, just
> > wait for each zswap entry to drop to zero.  Then free it.
>
> This doesn't really help. The swapoff code is already removing all the
> entries from the trees before zswap_swapoff() is called through
> zswap_invalidate(). The race I described occurs because the writeback
> code is accessing the entries through the LRU, not the tree. The

Why?
Entry not in the tree is fine. What you describe is that, swap_off
code will not see the entry because it is already not in the tree.
The last one holding the reference count would free it.

> writeback code could have isolated a zswap entry from the LRU before
> swapoff, then tried to access it after swapoff. Although the zswap

The writeback should have a reference count to the zswap entry it
holds. The entry will not be free until the LRU is done and drop the
reference count to zero.

> entry itself is referenced and safe to use, accessing the tree to grab
> the tree lock and check if the entry is still in the tree is the
> problem.

The swap off should wait until all the LRU list from that tree has
been consumed before destroying the tree.
In swap off, it walks all the process MM anyway, walking all the memcg
and finding all the zswap entries in zswap LRU should solve that
problem.
Anyway, I think it is easier to reason about the behavior that way.
Swap off will take the extra hit, but not the normal access of the
tree.

>
> >
> > That way you shouldn't need to refcount the tree. The tree refcount is
> > effectively the combined refcount of all the zswap entries.
>
> The problem is that given a zswap entry, you have no way to stabilize
> the zswap tree before trying to deference it with the current code.
> Chengming's suggestion of moving the swap cache pin before accessing
> the tree seems like the right way to go.
>
> > Having refcount on the tree would be very high contention.
>
> A percpu refcount cannot be contended by definition :)

It still has overhead on the normal access path and memory
consumption. If we can avoid it, it would be a win.

Chris

