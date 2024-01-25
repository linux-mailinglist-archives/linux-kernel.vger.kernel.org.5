Return-Path: <linux-kernel+bounces-39360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AE183CF66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20992B22EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D5710A21;
	Thu, 25 Jan 2024 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOGOwiRt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C47EC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221875; cv=none; b=T9ijStwwuFNCXFoAoNrD7/ghwjCYdFsKwfJSH/PNxZpjkpPUH3Wjj8xBvOLPz4q2CzSPsnmXMfBKQX8VNwdeFJi1+iHLC4wYaAVfUysVqWMQxW84I4I9ITijAk2zPeZzZlGoJeOBHfN4aKdm7/cG670X9Gd7ieBxBNJus1n9Qrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221875; c=relaxed/simple;
	bh=Dsb6QjJPJyDCnPS7/TQo3NloeOzerwr/4kiMIbbHy3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTBbJRnUeiWc4LXq0HmidOO8KB+1KWLFXuGGw4fMkyrqTtgPcHUrHCruOAWqTxBSx7dMiMEdCqcbfKEMeiHLayxhyE7gm2i6V6LEZLoaoZraylXZfyIQyVNhoM4hkVYDHxb3QOwWlEqZf3bTcY2KKp8MaHMpRdduUYQAEoYaosQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOGOwiRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F39C43399
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706221875;
	bh=Dsb6QjJPJyDCnPS7/TQo3NloeOzerwr/4kiMIbbHy3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OOGOwiRtOsxzjQ0/t75iPXqtiwGXO4fFebOFErfpOINQNaGjGVxU5S7daNWstIFYh
	 r7SpRqV6WBVs8esO2XVzCPws9UqCULpMro2x8Hq6SCsvjLZEKzDUdJuqso22ErL7y7
	 LByOWeOis4ILLqjrKnhSnXWesuvyM+Cl9f2OYZj0DrYITl2f+Q10Rn8eoFQYMWdirJ
	 HdtqjsgJSke2FBlDNCzo+q0HjMchH8DeQ5JOEyH4IJtpn5qV5U/ZY2ocxpcRTH+4Q0
	 vaDXmxfKkblHe69H/YHGS1uLBMswIaXFK5uhpbdtJBMy30ZZOlSqg0HgN2IKy+o6B5
	 rHcfiwu/R1jPA==
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6dddee3ba13so19935b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:31:15 -0800 (PST)
X-Gm-Message-State: AOJu0YzOlM4Pnu7BSVZtLj+UpZNXLtKXvASywEdiwRb57ulqv5qFvp5H
	L7Y0+xNMtvgoCd0iFjwLIgUMZPyPa2kRD7nSlx91T/lvyMohEuEorJaBV2c06cGXXGvS3VjCvvb
	gh722ASiB+5ZaU+hR0kwlfD5iedNYuR72rizT
X-Google-Smtp-Source: AGHT+IGgrhO7jBgXNW5dfREGGglvst+c7yQJbNiq8ihNUpCClJ+QfcT4iu+w9n/IBbihcovYfeB2E7ItCEgMZR7UluQ=
X-Received: by 2002:aa7:9d8a:0:b0:6db:e6b9:4cca with SMTP id
 f10-20020aa79d8a000000b006dbe6b94ccamr428366pfq.14.1706221874355; Thu, 25 Jan
 2024 14:31:14 -0800 (PST)
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
 <CAJD7tkZViJot2+vFr_yAyRsRf7jTRPsb8wchqkf4R1tSsvLG+A@mail.gmail.com>
 <CAF8kJuPHrf_-xr8mz5r_TWOWw-Zv+1izFNU=1yKV9EAdC=bGDg@mail.gmail.com> <CAJD7tkaG5epZkp4N4wOmbAp-mKV60rR63kppSfKtZPsu2vTDdg@mail.gmail.com>
In-Reply-To: <CAJD7tkaG5epZkp4N4wOmbAp-mKV60rR63kppSfKtZPsu2vTDdg@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 25 Jan 2024 14:31:02 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOFbRYZiFmtrAAqh7KBxWNaYtK10e7Ych4VxDKOocRKEQ@mail.gmail.com>
Message-ID: <CAF8kJuOFbRYZiFmtrAAqh7KBxWNaYtK10e7Ych4VxDKOocRKEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,

On Thu, Jan 25, 2024 at 12:58=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Thu, Jan 25, 2024 at 10:55=E2=80=AFAM Chris Li <chrisl@kernel.org> wro=
te:
> >
> > Hi Yosry,
> >
> > On Wed, Jan 24, 2024 at 11:59=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
com> wrote:
> > >
> > > On Wed, Jan 24, 2024 at 9:29=E2=80=AFPM Chris Li <chriscli@google.com=
> wrote:
> > > >
> > > > Hi Yosry,
> > > >
> > > > On Tue, Jan 23, 2024 at 10:58=E2=80=AFPM Yosry Ahmed <yosryahmed@go=
ogle.com> wrote:
> > > > >
> > > >
> > > > > >
> > > > > > Thanks for the great analysis, I missed the swapoff/swapon race=
 myself :)
> > > > > >
> > > > > > The first solution that came to mind for me was refcounting the=
 zswap
> > > > > > tree with RCU with percpu-refcount, similar to how cgroup refs =
are
> > > > > > handled (init in zswap_swapon() and kill in zswap_swapoff()). I=
 think
> > > > > > the percpu-refcount may be an overkill in terms of memory usage
> > > > > > though. I think we can still do our own refcounting with RCU, b=
ut it
> > > > > > may be more complicated.
> > > > >
> > > > > FWIW, I was able to reproduce the problem in a vm with the follow=
ing
> > > > > kernel diff:
> > > >
> > > > Thanks for the great find.
> > > >
> > > > I was worry about the usage after free situation in this email:
> > > >
> > > > https://lore.kernel.org/lkml/CAF8kJuOvOmn7wmKxoqpqSEk4gk63NtQG1Wc+Q=
0e9FZ9OFiUG6g@mail.gmail.com/
> > > >
> > > > Glad you are able to find a reproducible case. That is one of the
> > > > reasons I change the free to invalidate entries in my xarray patch.
> > > >
> > > > I think the swap_off code should remove the entry from the tree, ju=
st
> > > > wait for each zswap entry to drop to zero.  Then free it.
> > >
> > > This doesn't really help. The swapoff code is already removing all th=
e
> > > entries from the trees before zswap_swapoff() is called through
> > > zswap_invalidate(). The race I described occurs because the writeback
> > > code is accessing the entries through the LRU, not the tree. The
> >
> > Why?
> > Entry not in the tree is fine. What you describe is that, swap_off
> > code will not see the entry because it is already not in the tree.
> > The last one holding the reference count would free it.
> >
> > > writeback code could have isolated a zswap entry from the LRU before
> > > swapoff, then tried to access it after swapoff. Although the zswap
> >
> > The writeback should have a reference count to the zswap entry it
> > holds. The entry will not be free until the LRU is done and drop the
> > reference count to zero.
> >
> > > entry itself is referenced and safe to use, accessing the tree to gra=
b
> > > the tree lock and check if the entry is still in the tree is the
> > > problem.
> >
> > The swap off should wait until all the LRU list from that tree has
> > been consumed before destroying the tree.
> > In swap off, it walks all the process MM anyway, walking all the memcg
> > and finding all the zswap entries in zswap LRU should solve that
> > problem.
>
> At that point, the entry is isolated from the zswap LRU list as well.
> So even if swap off iterates the zswap LRUs, it cannot find it to wait

It just means that we need to defer removing the entry from LRU, only
remove it after most of the write back is complete to some critical
steps.

> for it. Take a closer look at the race condition I described. The

I take a closer look at the sequence Chengming describe, it has the
element of delay removing entry from the LRU as well.

> problem is that after the entry is isolated from the zswap LRU, we
> need to grab the tree lock to make sure it's still there and get a
> ref, and just trying to lock the tree may be a UAF if we race with
> swapoff.

I feel it is very wrong to have the tree freed while having
outstanding entry allocationed from the tree pending.
I would want to avoid that situation if possible.

>
> > Anyway, I think it is easier to reason about the behavior that way.
> > Swap off will take the extra hit, but not the normal access of the
> > tree.
>
> I think this adds a lot of unnecessary complexity tbh. I think the
> operations reordering that Chengming described may be the way to go
> here. It does not include adding more logic or synchronization

Does not require adding the tree reference count right?

> primitives, just reordering operations to be closer to what we do in
> zswap_load() and leverage existing synchronization.

The complexity is mostly for avoiding the tree reference count. If we
don't add the tree refcount and we don't need the extra complexity in
the tree waiting for LRU, that sounds great to me.

Chris

