Return-Path: <linux-kernel+bounces-100533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F80879940
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DCA1C21755
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25237E76A;
	Tue, 12 Mar 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uspfvw/P"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072A37E0FC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261901; cv=none; b=PluMQUKqzd5VGbSOaucPGdVhfKF+E/yKERaAFZdzXkp8BBgPw7HyU0Eq299tZlMOPTB5/jzqS6r0tH6SUCyU4ljwc5m1rj6ERtXnAXaagyq/RCfl74xBJZqSVJiUIp5Fipm+hOYpwP47EMTBHr4jjdFOt+is5iKYruJjCZ++cD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261901; c=relaxed/simple;
	bh=+RJFbCOEI9uZfJ8gaIw/aj45C6EHZwRkNR3KgAfnwjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNPDbxS26mYv+6v0JSD57lQPwAct4W9BsNuVpErucQaScnObeZBR039yCAEQQv7sQfT8x8kMQnsbrNr4cLIyuh8ulH9cwL2aENmKxZjE1K6Z/qKL/yLcyiGIIGkXtXEM2h1rQZ3+XaP4274bWp4lxLwAm/jFimyvMW5i3cCyuN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uspfvw/P; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e9def4a6dso1505916f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710261898; x=1710866698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUYTRlfGzPdlx8mymTMY+S0XS9OSGuHPk7Hy7kZQcOo=;
        b=Uspfvw/PsUGPJLx35q9/OiySvm/Df+U90tMNwX83ai1ABekYIHH9++/5Js7kdlfxO4
         rG+5zf22066uqneM0zGkV0a5FNg8JedjXh1fWpVk975Gc6DJ7H0fSd107eftx3a4oNvt
         hkmaTg5ANfXxgJ3exY7zJXzEX/iSECh4km59HXL7fNbgG5bnoKpDCbFcDz8z27vSKwc7
         yXpZTVkLABdNM6MUaLPNfy3qhW4J1C0y4u6CiXZciGowwXMj5WKwP9lE9wfKyPWkOg+i
         uWFLfMlzHVST/SL0XeymiBx5amn2am9OSJZDVTgZ0C3JhtccczEXTq54oIdYyBR2iIUF
         15cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710261898; x=1710866698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUYTRlfGzPdlx8mymTMY+S0XS9OSGuHPk7Hy7kZQcOo=;
        b=ivaOuwL03fl1cZL0nG4TSLpokqExL0qDTR2NR4uiQJPQnqB+7PLgVQ75+3BxCD11PG
         vGxpJUk7PY+CJRwLrFfqzI9Wu0Uduc1byKwV6UPGlp55RfHLTcg1UQh7m0RBG9aAh4xy
         yrN4oY8mPQPOlGiDWda5BirC94ssQJaEyckAthYJwruyu3njlnhV1ewVIA11wEojEJMf
         oWcMuFNZfXqZTbMrohNJKKYB9sZQb+cSGwjGIFiIRWytO67rDn8gk94xuXEsGDc2JqYN
         2z/hCFBMaP5aSUeyJQtCHHcwvdYiiUZGwOYmsdwNgf1NoWxAuvNvNA9iaoe+6UfWwiPq
         zTrA==
X-Forwarded-Encrypted: i=1; AJvYcCXJanfBe/xasKSJuUE3vPbvEZhtCe+XsXOlpy0QlAOeteiTRDvz4RBu8bGWouvbDE3DP8m7fkM+DASacOM65fAepgbVWpn0vtvl40Cu
X-Gm-Message-State: AOJu0YwzbjBJSw8hsqvi2geOG90gHirRKl/v0UAfLkAd9ciBne6RUB4H
	oO+WuTQ0rODx2k7AD3k30boFgZpcY6C/wH7qGi7+yMfLyonqGWhOTc/qHWGgoTOps66m0LH6vnw
	b47QkJ9yC3TxvIwqQFZYlkcRNAKGOrogN2/In
X-Google-Smtp-Source: AGHT+IEOHrE4+eQswfnysO+rbIz/h2km4EqB2aEJrVjLYvrBrpadyUomXrcZEXQc05cIPMuPa95v4IS3geyGrAN/WsI=
X-Received: by 2002:a05:6000:1806:b0:33d:701f:d179 with SMTP id
 m6-20020a056000180600b0033d701fd179mr3754wrh.19.1710261898215; Tue, 12 Mar
 2024 09:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcWOh9u3uqZjNFMa@chrisdown.name> <20240229235134.2447718-1-axelrasmussen@google.com>
 <ZeEhvV15IWllPKvM@chrisdown.name> <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>
 <CALOAHbBupMYBMWEzMK2xdhnqwR1C1+mJSrrZC1L0CKE2BMSC+g@mail.gmail.com>
In-Reply-To: <CALOAHbBupMYBMWEzMK2xdhnqwR1C1+mJSrrZC1L0CKE2BMSC+g@mail.gmail.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Tue, 12 Mar 2024 09:44:19 -0700
Message-ID: <CAJHvVcjhUNx8UP9mao4TdvU6xK7isRzazoSU53a4NCcFiYuM-g@mail.gmail.com>
Subject: Re: MGLRU premature memcg OOM on slow writes
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	kernel-team@fb.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 2:11=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Sat, Mar 9, 2024 at 3:19=E2=80=AFAM Axel Rasmussen <axelrasmussen@goog=
le.com> wrote:
> >
> > On Thu, Feb 29, 2024 at 4:30=E2=80=AFPM Chris Down <chris@chrisdown.nam=
e> wrote:
> > >
> > > Axel Rasmussen writes:
> > > >A couple of dumb questions. In your test, do you have any of the fol=
lowing
> > > >configured / enabled?
> > > >
> > > >/proc/sys/vm/laptop_mode
> > > >memory.low
> > > >memory.min
> > >
> > > None of these are enabled. The issue is trivially reproducible by wri=
ting to
> > > any slow device with memory.max enabled, but from the code it looks l=
ike MGLRU
> > > is also susceptible to this on global reclaim (although it's less lik=
ely due to
> > > page diversity).
> > >
> > > >Besides that, it looks like the place non-MGLRU reclaim wakes up the
> > > >flushers is in shrink_inactive_list() (which calls wakeup_flusher_th=
reads()).
> > > >Since MGLRU calls shrink_folio_list() directly (from evict_folios())=
, I agree it
> > > >looks like it simply will not do this.
> > > >
> > > >Yosry pointed out [1], where MGLRU used to call this but stopped doi=
ng that. It
> > > >makes sense to me at least that doing writeback every time we age is=
 too
> > > >aggressive, but doing it in evict_folios() makes some sense to me, b=
asically to
> > > >copy the behavior the non-MGLRU path (shrink_inactive_list()) has.
> > >
> > > Thanks! We may also need reclaim_throttle(), depending on how you imp=
lement it.
> > > Current non-MGLRU behaviour on slow storage is also highly suspect in=
 terms of
> > > (lack of) throttling after moving away from VMSCAN_THROTTLE_WRITEBACK=
, but one
> > > thing at a time :-)
> >
> >
> > Hmm, so I have a patch which I think will help with this situation,
> > but I'm having some trouble reproducing the problem on 6.8-rc7 (so
> > then I can verify the patch fixes it).
>
> We encountered the same premature OOM issue caused by numerous dirty page=
s.
> The issue disappears after we revert the commit 14aa8b2d5c2e
> "mm/mglru: don't sync disk for each aging cycle"
>
> To aid in replicating the issue, we've developed a straightforward
> script, which consistently reproduces it, even on the latest kernel.
> You can find the script provided below:
>
> ```
> #!/bin/bash
>
> MEMCG=3D"/sys/fs/cgroup/memory/mglru"
> ENABLE=3D$1
>
> # Avoid waking up the flusher
> sysctl -w vm.dirty_background_bytes=3D$((1024 * 1024 * 1024 *4))
> sysctl -w vm.dirty_bytes=3D$((1024 * 1024 * 1024 *4))
>
> if [ ! -d ${MEMCG} ]; then
>         mkdir -p ${MEMCG}
> fi
>
> echo $$ > ${MEMCG}/cgroup.procs
> echo 1g > ${MEMCG}/memory.limit_in_bytes
>
> if [ $ENABLE -eq 0 ]; then
>         echo 0 > /sys/kernel/mm/lru_gen/enabled
> else
>         echo 0x7 > /sys/kernel/mm/lru_gen/enabled
> fi
>
> dd if=3D/dev/zero of=3D/data0/mglru.test bs=3D1M count=3D1023
> rm -rf /data0/mglru.test
> ```
>
> This issue disappears as well after we disable the mglru.
>
> We hope this script proves helpful in identifying and addressing the
> root cause. We eagerly await your insights and proposed fixes.

Thanks Yafang, I was able to reproduce the issue using this script.

Perhaps interestingly, I was not able to reproduce it with cgroupv2
memcgs. I know writeback semantics are quite a bit different there, so
perhaps that explains why.

Unfortunately, it also reproduces even with the commit I had in mind
(basically stealing the "if (all isolated pages are unqueued dirty) {
wakeup_flusher_threads(); reclaim_throttle(); }" from
shrink_inactive_list, and adding it to MGLRU's evict_folios()). So
I'll need to spend some more time on this; I'm planning to send
something out for testing next week.

>
> >
> > If I understand the issue right, all we should need to do is get a
> > slow filesystem, and then generate a bunch of dirty file pages on it,
> > while running in a tightly constrained memcg. To that end, I tried the
> > following script. But, in reality I seem to get little or no
> > accumulation of dirty file pages.
> >
> > I thought maybe fio does something different than rsync which you said
> > you originally tried, so I also tried rsync (copying /usr/bin into
> > this loop mount) and didn't run into an OOM situation either.
> >
> > Maybe some dirty ratio settings need tweaking or something to get the
> > behavior you see? Or maybe my test has a dumb mistake in it. :)
> >
> >
> >
> > #!/usr/bin/env bash
> >
> > echo 0 > /proc/sys/vm/laptop_mode || exit 1
> > echo y > /sys/kernel/mm/lru_gen/enabled || exit 1
> >
> > echo "Allocate disk image"
> > IMAGE_SIZE_MIB=3D1024
> > IMAGE_PATH=3D/tmp/slow.img
> > dd if=3D/dev/zero of=3D$IMAGE_PATH bs=3D1024k count=3D$IMAGE_SIZE_MIB |=
| exit 1
> >
> > echo "Setup loop device"
> > LOOP_DEV=3D$(losetup --show --find $IMAGE_PATH) || exit 1
> > LOOP_BLOCKS=3D$(blockdev --getsize $LOOP_DEV) || exit 1
> >
> > echo "Create dm-slow"
> > DM_NAME=3Ddm-slow
> > DM_DEV=3D/dev/mapper/$DM_NAME
> > echo "0 $LOOP_BLOCKS delay $LOOP_DEV 0 100" | dmsetup create $DM_NAME |=
| exit 1
> >
> > echo "Create fs"
> > mkfs.ext4 "$DM_DEV" || exit 1
> >
> > echo "Mount fs"
> > MOUNT_PATH=3D"/tmp/$DM_NAME"
> > mkdir -p "$MOUNT_PATH" || exit 1
> > mount -t ext4 "$DM_DEV" "$MOUNT_PATH" || exit 1
> >
> > echo "Generate dirty file pages"
> > systemd-run --wait --pipe --collect -p MemoryMax=3D32M \
> >         fio -name=3Dwrites -directory=3D$MOUNT_PATH -readwrite=3Drandwr=
ite \
> >         -numjobs=3D10 -nrfiles=3D90 -filesize=3D1048576 \
> >         -fallocate=3Dposix \
> >         -blocksize=3D4k -ioengine=3Dmmap \
> >         -direct=3D0 -buffered=3D1 -fsync=3D0 -fdatasync=3D0 -sync=3D0 \
> >         -runtime=3D300 -time_based
> >
>
>
> --
> Regards
> Yafang

