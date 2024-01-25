Return-Path: <linux-kernel+bounces-39269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 255B183CDE5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AAC91C25507
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1891386B9;
	Thu, 25 Jan 2024 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCWrzZ5i"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769C679C7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216288; cv=none; b=Egm9kpukhi8KRE1Ne0DIWF7LlsIv1kJNNQ0BLUPwWatwT638/rvmjXL5z6qqiRWD8EVAh1jbOPosPGjsHNkbZRnb2TpHcc9+hcO63ERxDT25dlSp9QcPEYdhwamHD2lwoV6V5x9QjLd4RiOq9gNkghI5+QIZ0dB5zn2RCqlNmK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216288; c=relaxed/simple;
	bh=kDRzTFggs6cpEz8kGuow5cKDQFKHz0ajgrly0YN7il4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNNZUN2OjwVDYuWIXV8KfWD2QuhcMtU1OsTVrXvh4MlZyg1aCDLeOBPeMtDezbYPhlr+hZ/tTz7ysQirv+geodHSlGlm5SRh4tpB6VvTxBcEckWPsispnTDxy4HPvIQ+1PeMpFNirFJkYpN1FGEYkDwplkkGUfwmVPbnvqqvC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PCWrzZ5i; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so5116296a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706216285; x=1706821085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31gbTt7/WQPF0Y4UOrqjm/WIqOgckaQgYjl+qIfnXoU=;
        b=PCWrzZ5ivP+6hV9DalI5FdMQxbjR6OpLQeXOHwv/bkUTY65e8SokJO3fJKeEFQJL8b
         loE8ENf8YcNNG844nS+gQcNCRxe7301d9VvM/6PUISlBpxQ1kL14a5oSt3x8H7KfvEVW
         LiGeRPqWFc0QbhLzip+okytqbMRBq5ZC8W3Gdg58KzAbhcd46g4ZUEPlRjIpiESkVM8N
         6yrijVRHIVqHnTtJeyMt/yDc2//UvjOF7FK3dv6sJAGIsxJXkHBIU3AKuVmrO5Zpy04J
         jXezDwrE3mVsy/Th36/W58j8i3tlfT/87PywWRkIQz7Dx+54jf82sOimDVNiyj7CuVeo
         APPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706216285; x=1706821085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31gbTt7/WQPF0Y4UOrqjm/WIqOgckaQgYjl+qIfnXoU=;
        b=LcgK+VTjTsqN5IEm8V/b2WJmy3qZmpG4s4/FZvJWZZ0O4Oq2YAx16xY6oNMMyomC/O
         cxeQ3g7tnx9ZPdJk3Vd/sZC/t0Ha/IUmit76rGaHPcHuUh6thprVvgEnRLfH35mgGGB1
         X5MUwGt1liSbi6rjkmg0lGpk7shhLJBH6g4zCi+bz+Z0IjRnbhLVCXvcCt3h1vLD60PF
         UnZiNqE3HbkxPD4Mu4ZPL0HhdJiM1Z/U53ru1tYX5IFDfaMYb9vIXCBpYVMqADvRBpxr
         oHNRKBbjN1UMBi4cqW10yRCLNKh4a5SPW+/e4cE4Nw7npc0lq4XS8nQqlmFA10wnN0G5
         FdQA==
X-Gm-Message-State: AOJu0YzjRFkbLmSQbQ8M3l2AhytPyjPQJGlVRNA6QD/+SZSdasy7RuZn
	eYmEjKrRoqv9QQM7pUBdYks8W9bWgMzgb/uhG4/PBfZOHyovKgo0un1KcnCXv9KQfLKLCI6vF2p
	txA8flyPALX4YZ8YhSmIoR2ewarQ2C02bpztP
X-Google-Smtp-Source: AGHT+IHpVSOH793RNZe3XgecTMwFbygbft2xOr5Cdbg2uidPsR+U3Oxde1K1MaMLI0s62xz0XNMg6Ht/Bnv2pkdkGYQ=
X-Received: by 2002:a17:906:7fd3:b0:a31:984:96a5 with SMTP id
 r19-20020a1709067fd300b00a31098496a5mr81342ejs.94.1706216284513; Thu, 25 Jan
 2024 12:58:04 -0800 (PST)
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
 <CAF8kJuNkwGNw=Nnu1MVOewKiqT0ahj5DkKV_Z4VDqSpu+v=vmw@mail.gmail.com>
 <CAJD7tkZViJot2+vFr_yAyRsRf7jTRPsb8wchqkf4R1tSsvLG+A@mail.gmail.com> <CAF8kJuPHrf_-xr8mz5r_TWOWw-Zv+1izFNU=1yKV9EAdC=bGDg@mail.gmail.com>
In-Reply-To: <CAF8kJuPHrf_-xr8mz5r_TWOWw-Zv+1izFNU=1yKV9EAdC=bGDg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 25 Jan 2024 12:57:26 -0800
Message-ID: <CAJD7tkaG5epZkp4N4wOmbAp-mKV60rR63kppSfKtZPsu2vTDdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Chris Li <chrisl@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:55=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> Hi Yosry,
>
> On Wed, Jan 24, 2024 at 11:59=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > On Wed, Jan 24, 2024 at 9:29=E2=80=AFPM Chris Li <chriscli@google.com> =
wrote:
> > >
> > > Hi Yosry,
> > >
> > > On Tue, Jan 23, 2024 at 10:58=E2=80=AFPM Yosry Ahmed <yosryahmed@goog=
le.com> wrote:
> > > >
> > >
> > > > >
> > > > > Thanks for the great analysis, I missed the swapoff/swapon race m=
yself :)
> > > > >
> > > > > The first solution that came to mind for me was refcounting the z=
swap
> > > > > tree with RCU with percpu-refcount, similar to how cgroup refs ar=
e
> > > > > handled (init in zswap_swapon() and kill in zswap_swapoff()). I t=
hink
> > > > > the percpu-refcount may be an overkill in terms of memory usage
> > > > > though. I think we can still do our own refcounting with RCU, but=
 it
> > > > > may be more complicated.
> > > >
> > > > FWIW, I was able to reproduce the problem in a vm with the followin=
g
> > > > kernel diff:
> > >
> > > Thanks for the great find.
> > >
> > > I was worry about the usage after free situation in this email:
> > >
> > > https://lore.kernel.org/lkml/CAF8kJuOvOmn7wmKxoqpqSEk4gk63NtQG1Wc+Q0e=
9FZ9OFiUG6g@mail.gmail.com/
> > >
> > > Glad you are able to find a reproducible case. That is one of the
> > > reasons I change the free to invalidate entries in my xarray patch.
> > >
> > > I think the swap_off code should remove the entry from the tree, just
> > > wait for each zswap entry to drop to zero.  Then free it.
> >
> > This doesn't really help. The swapoff code is already removing all the
> > entries from the trees before zswap_swapoff() is called through
> > zswap_invalidate(). The race I described occurs because the writeback
> > code is accessing the entries through the LRU, not the tree. The
>
> Why?
> Entry not in the tree is fine. What you describe is that, swap_off
> code will not see the entry because it is already not in the tree.
> The last one holding the reference count would free it.
>
> > writeback code could have isolated a zswap entry from the LRU before
> > swapoff, then tried to access it after swapoff. Although the zswap
>
> The writeback should have a reference count to the zswap entry it
> holds. The entry will not be free until the LRU is done and drop the
> reference count to zero.
>
> > entry itself is referenced and safe to use, accessing the tree to grab
> > the tree lock and check if the entry is still in the tree is the
> > problem.
>
> The swap off should wait until all the LRU list from that tree has
> been consumed before destroying the tree.
> In swap off, it walks all the process MM anyway, walking all the memcg
> and finding all the zswap entries in zswap LRU should solve that
> problem.

At that point, the entry is isolated from the zswap LRU list as well.
So even if swap off iterates the zswap LRUs, it cannot find it to wait
for it. Take a closer look at the race condition I described. The
problem is that after the entry is isolated from the zswap LRU, we
need to grab the tree lock to make sure it's still there and get a
ref, and just trying to lock the tree may be a UAF if we race with
swapoff.

> Anyway, I think it is easier to reason about the behavior that way.
> Swap off will take the extra hit, but not the normal access of the
> tree.

I think this adds a lot of unnecessary complexity tbh. I think the
operations reordering that Chengming described may be the way to go
here. It does not include adding more logic or synchronization
primitives, just reordering operations to be closer to what we do in
zswap_load() and leverage existing synchronization.

