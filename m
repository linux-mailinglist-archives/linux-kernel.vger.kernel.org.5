Return-Path: <linux-kernel+bounces-39361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489E383CF6B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E264BB21B47
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4927B10A39;
	Thu, 25 Jan 2024 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1cQihnCk"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD58F10A21
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222079; cv=none; b=VZYKw9Ijy6seo0ZFp6mCBgxQ618hvLUWMFIn899jOpJ1QPrp4lGMOMlQs+hSv6XIcfcLi/KNgeteu/xnnPCG/4qn+utIBJTsmvk/DOITTq1joHVI+MSp3W+vHUeJQoY8X8PtBgoN1GeWv2OPItjlJDQU4kFfcPvkjAbSDKmaG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222079; c=relaxed/simple;
	bh=gVzLJGDKvGhrU3J75QOG4g6tXbzBbEYInRPGGsXCH3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3+EhmvRwShFXCV+3hToOadAqrEKIHZk7N15u9JIwNjpNajVBAIf/7sVsVtio4tPz2ie1aZDKf4Hiz2ZTzmtky9Y1dY/1rPfKRSCkb3rm3iLbdu/FhMCtsNqkeZf7eoXbsafNByc3FVyfD1hZXl0CBR8VrudD0MYgztU2QyQsu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1cQihnCk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a312a8e6732so10511566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706222076; x=1706826876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7quTyiowyLH4rAwhkxhJ6Ex8ZBRUXT3RRycWcoogYY=;
        b=1cQihnCkJ0wu3j5GPG13j0oNGN0UBPd86CrHZNmS3Cn0doOheufCEBqN52rDLzy+nR
         SBhW7sBHn77lHQoxODSudvwwPfpth6iSUFeoVRO+bjn97Lns6aw14LWb1Jxt4+O6hROq
         qXMOfaWwPUQ9+oj8Rs7ZAf6ka5CD0K1mpRvLfLjMv5lx/BLuKOlh8ozZ/dAs63i+QelD
         wobYpSEueJEjjSULZe0NPYCc1SINM/EqKl961v/p4v59cerjJR/c4hmWAErEHjiOj0oq
         L6cZpq02goUCrTykYdZeQbq08jDgsNa++AojifIW7BI3xz3BSlqUrw1uMQALMHXo50h4
         dsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706222076; x=1706826876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7quTyiowyLH4rAwhkxhJ6Ex8ZBRUXT3RRycWcoogYY=;
        b=LrNE/ddVWBOZGt2vyKHxKBplHaeEyn4p90fpB86Sf7k9GKJakxZ/8LbVe96laNj4sB
         LC9otJZA9Mwq7Bsly7fasJv4glZ8QGwqBKBBmx1lg2iWg7fbU+h5U6Izg3SdLf2PHDeZ
         unVaC3z4n8Iz8HyNWk/EAt4kxRkZPJz8nvi/B2gMo9lOcqp+iJiXfuYLJjXQzs5OZKM+
         fpJtytkyKTnzcnKhwIhkyXA4MZHg5rsBG2v83b6u03TmArJGpAKo50eM9W1uIWBukBPZ
         9m6gcrLsdhupyCsEtOgazQHZ226jUHzPcYp+AvqH45q3laM4DjisVd4toPJgPKPOBUOr
         xwEg==
X-Gm-Message-State: AOJu0YztmMFmLyOjq7FabQcLlQGyYat+GhYeMd1KdsCvaJPds4H4WhLU
	A/LyiKx5zKnanKuHLGxYD4MlAQV5OTQIkl6ORa2yrl4b+NiWUA+X2wxLXCjh7zIr6OG7H7hqeRz
	eUV3HSHPSbSAoGjf/wJaRcpiQQBJkVguWTYh3
X-Google-Smtp-Source: AGHT+IHDx4eVmCszSnPI5vueY6lO8sQyfGQ5S10G/lvIfYfp6AaE15SXKvWQe2dBNI2bUaBxZkumtNp40MBBMOqI1go=
X-Received: by 2002:a17:906:6d4a:b0:a31:2028:8c6 with SMTP id
 a10-20020a1709066d4a00b00a31202808c6mr124453ejt.104.1706222075615; Thu, 25
 Jan 2024 14:34:35 -0800 (PST)
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
 <CAF8kJuPHrf_-xr8mz5r_TWOWw-Zv+1izFNU=1yKV9EAdC=bGDg@mail.gmail.com>
 <CAJD7tkaG5epZkp4N4wOmbAp-mKV60rR63kppSfKtZPsu2vTDdg@mail.gmail.com> <CAF8kJuOFbRYZiFmtrAAqh7KBxWNaYtK10e7Ych4VxDKOocRKEQ@mail.gmail.com>
In-Reply-To: <CAF8kJuOFbRYZiFmtrAAqh7KBxWNaYtK10e7Ych4VxDKOocRKEQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 25 Jan 2024 14:33:59 -0800
Message-ID: <CAJD7tkYFX98TZGiiBwXRtiJM_zEphzLq-vNXNyrzun8gTRLuGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Chris Li <chrisl@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 2:31=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Yosry,
>
> On Thu, Jan 25, 2024 at 12:58=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > On Thu, Jan 25, 2024 at 10:55=E2=80=AFAM Chris Li <chrisl@kernel.org> w=
rote:
> > >
> > > Hi Yosry,
> > >
> > > On Wed, Jan 24, 2024 at 11:59=E2=80=AFPM Yosry Ahmed <yosryahmed@goog=
le.com> wrote:
> > > >
> > > > On Wed, Jan 24, 2024 at 9:29=E2=80=AFPM Chris Li <chriscli@google.c=
om> wrote:
> > > > >
> > > > > Hi Yosry,
> > > > >
> > > > > On Tue, Jan 23, 2024 at 10:58=E2=80=AFPM Yosry Ahmed <yosryahmed@=
google.com> wrote:
> > > > > >
> > > > >
> > > > > > >
> > > > > > > Thanks for the great analysis, I missed the swapoff/swapon ra=
ce myself :)
> > > > > > >
> > > > > > > The first solution that came to mind for me was refcounting t=
he zswap
> > > > > > > tree with RCU with percpu-refcount, similar to how cgroup ref=
s are
> > > > > > > handled (init in zswap_swapon() and kill in zswap_swapoff()).=
 I think
> > > > > > > the percpu-refcount may be an overkill in terms of memory usa=
ge
> > > > > > > though. I think we can still do our own refcounting with RCU,=
 but it
> > > > > > > may be more complicated.
> > > > > >
> > > > > > FWIW, I was able to reproduce the problem in a vm with the foll=
owing
> > > > > > kernel diff:
> > > > >
> > > > > Thanks for the great find.
> > > > >
> > > > > I was worry about the usage after free situation in this email:
> > > > >
> > > > > https://lore.kernel.org/lkml/CAF8kJuOvOmn7wmKxoqpqSEk4gk63NtQG1Wc=
+Q0e9FZ9OFiUG6g@mail.gmail.com/
> > > > >
> > > > > Glad you are able to find a reproducible case. That is one of the
> > > > > reasons I change the free to invalidate entries in my xarray patc=
h.
> > > > >
> > > > > I think the swap_off code should remove the entry from the tree, =
just
> > > > > wait for each zswap entry to drop to zero.  Then free it.
> > > >
> > > > This doesn't really help. The swapoff code is already removing all =
the
> > > > entries from the trees before zswap_swapoff() is called through
> > > > zswap_invalidate(). The race I described occurs because the writeba=
ck
> > > > code is accessing the entries through the LRU, not the tree. The
> > >
> > > Why?
> > > Entry not in the tree is fine. What you describe is that, swap_off
> > > code will not see the entry because it is already not in the tree.
> > > The last one holding the reference count would free it.
> > >
> > > > writeback code could have isolated a zswap entry from the LRU befor=
e
> > > > swapoff, then tried to access it after swapoff. Although the zswap
> > >
> > > The writeback should have a reference count to the zswap entry it
> > > holds. The entry will not be free until the LRU is done and drop the
> > > reference count to zero.
> > >
> > > > entry itself is referenced and safe to use, accessing the tree to g=
rab
> > > > the tree lock and check if the entry is still in the tree is the
> > > > problem.
> > >
> > > The swap off should wait until all the LRU list from that tree has
> > > been consumed before destroying the tree.
> > > In swap off, it walks all the process MM anyway, walking all the memc=
g
> > > and finding all the zswap entries in zswap LRU should solve that
> > > problem.
> >
> > At that point, the entry is isolated from the zswap LRU list as well.
> > So even if swap off iterates the zswap LRUs, it cannot find it to wait
>
> It just means that we need to defer removing the entry from LRU, only
> remove it after most of the write back is complete to some critical
> steps.
>
> > for it. Take a closer look at the race condition I described. The
>
> I take a closer look at the sequence Chengming describe, it has the
> element of delay removing entry from the LRU as well.
>
> > problem is that after the entry is isolated from the zswap LRU, we
> > need to grab the tree lock to make sure it's still there and get a
> > ref, and just trying to lock the tree may be a UAF if we race with
> > swapoff.
>
> I feel it is very wrong to have the tree freed while having
> outstanding entry allocationed from the tree pending.
> I would want to avoid that situation if possible.

This should be the case with Chengming's solution.

>
> >
> > > Anyway, I think it is easier to reason about the behavior that way.
> > > Swap off will take the extra hit, but not the normal access of the
> > > tree.
> >
> > I think this adds a lot of unnecessary complexity tbh. I think the
> > operations reordering that Chengming described may be the way to go
> > here. It does not include adding more logic or synchronization
>
> Does not require adding the tree reference count right?

No, just reordering of operations in the writeback path.

>
> > primitives, just reordering operations to be closer to what we do in
> > zswap_load() and leverage existing synchronization.
>
> The complexity is mostly for avoiding the tree reference count. If we
> don't add the tree refcount and we don't need the extra complexity in
> the tree waiting for LRU, that sounds great to me.

I think that's what Chengming's proposal provides.

