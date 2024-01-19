Return-Path: <linux-kernel+bounces-31239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07175832AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD0F1C2175F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA0A5465D;
	Fri, 19 Jan 2024 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGdJjegj"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7E754656
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673341; cv=none; b=jCpv+0XdHZitbjjcQa92j3iYr0iDuEbyEdumQDX8KRLkIm4+fA/YcIQsxfn3PyunNd8STBxvxRSbW7PZlSF/RkkA85pIFd07Qhul7pfMdcOXelslBM8iQ0C1RAn28+r00MGv2q+55CLh7NjRzjPRzDga0XEd3zaS5jDHVL2TZ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673341; c=relaxed/simple;
	bh=dO1H1He8j3LLWC6d8RYibRBfsieHAb7pDs8qjCnjqxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6xqwsMKj/pfdm7pgcJLDMv21Y2gMlU/ul969ssxXcz5q1i4H8UhiliK6FWqS2coKuR06AeP+Kq16DWbei1/r8/xRtwGAILiOHMmeTi/+sAIiTDZGhuCsQPLY2NYiBCu/K8sKOhPdKzWaI3NWH29jzqPkRQHMwnY3uvqNgC6BKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGdJjegj; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso8551797b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 06:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705673339; x=1706278139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO1H1He8j3LLWC6d8RYibRBfsieHAb7pDs8qjCnjqxk=;
        b=fGdJjegjaYpmvoJuHFJgTFDOZL2i2YdzXG05Rnw1hZ6fhHBMlq1eMKW1fyTnaZTLGg
         TYrTZnz+2SLIR9SKrEbCeKE8LRjrjW1oG5MpAsyABG7jNAR/Qq4eKms+6rR4zR4j+DiC
         9HrxfKdaoZUYsyr+5tZYnb2HGdmbOg+QHGPQ7bpGSd0brGDh0Kj50cDB883haWF6bNmu
         WGlVsYAHpcBc7xngAWBFfVYWVpGuUwrWUpNPcFELB4S+ANIqPxs2+pCiaEVxgpuYLWaq
         Y+N1DXxl67bOI+A1uhawabKrFkAThf9gO+orNdq6RjodvvuuCJwtJ2vHJqfwQ2yUpyIu
         mZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705673339; x=1706278139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dO1H1He8j3LLWC6d8RYibRBfsieHAb7pDs8qjCnjqxk=;
        b=WzKzhJoLL2CwDALX6RYnrdVnE58AVm1tmP5r05VL95/U2epV7KYiG+kSrLZnVhFQ0H
         SLdXYfxbVU7oKqDwqxnf4jxIEQqmL9MCq6gCzRIdafmgYFui/uo4UVtvsQexpRhVhVea
         BN1ulSxPs5CxLlhxvAxRb2RAU/Dn6PoI+COlHtKsEuekLBkGRxh2WsZyptNCjTbt34G8
         MXqzqzb++X41IXqBYVstzc6iyOBn7AVkqUDj7FThSOVQKqqqG4LWykHF04RgVr3He7lz
         U+7X/uIjf4xz+jbY1dOxEcc+L2VwGdVDrYVp9PGNDEpwKOR1msBkHiRnfyHp6YvkI7km
         UQDA==
X-Gm-Message-State: AOJu0YxG0WcYhCQrxzwSRQXfvs0XKhkGabZ2eWLrAW657Um/MaR3QMzX
	Rk89wUBAWYnO6zUpWUpwtydRnr3y9t2tHHGuLh25NPksZZ4Vq0FphGqXaMofsOm/9WWaxZnhVnJ
	+rYFeL9nkL2obtROpAbjJC0kI3vk=
X-Google-Smtp-Source: AGHT+IF5I2Bg881/byoL0ER6lbTrXCYVs7pQ3k21Pk8jy/PB5y1JEKyTYzu7FhGJr7RIYerr/dH0tzrcumpzkRN6FQk=
X-Received: by 2002:a81:47d6:0:b0:5ff:420a:606 with SMTP id
 u205-20020a8147d6000000b005ff420a0606mr2575113ywa.75.1705673338698; Fri, 19
 Jan 2024 06:08:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <ZakqQyL9t2ffNUIf@tiehlicka>
 <CAK1f24k+=Sskotbct+yGxpDKNv=qyXPkww5i2kaqfzwaUVO_GQ@mail.gmail.com> <ZapwWuVTIDeI3W8A@tiehlicka>
In-Reply-To: <ZapwWuVTIDeI3W8A@tiehlicka>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 19 Jan 2024 22:08:44 +0800
Message-ID: <CAK1f24=eVDNRN3k4Oz62VZ4M=1igVQ9E-0vxDe=5M8HWrAb-8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 8:51=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Fri 19-01-24 10:03:05, Lance Yang wrote:
> > Hey Michal,
> >
> > Thanks for taking the time to review!
> >
> > On Thu, Jan 18, 2024 at 9:40=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Thu 18-01-24 20:03:46, Lance Yang wrote:
> > > [...]
> > >
> > > before we discuss the semantic, let's focus on the usecase.
> > >
> > > > Use Cases
> > > >
> > > > An immediate user of this new functionality is the Go runtime heap =
allocator
> > > > that manages memory in hugepage-sized chunks. In the past, whether =
it was a
> > > > newly allocated chunk through mmap() or a reused chunk released by
> > > > madvise(MADV_DONTNEED), the allocator attempted to eagerly back mem=
ory with
> > > > huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPS=
E)[3]
> > > > respectively. However, both approaches resulted in performance issu=
es; for
> > > > both scenarios, there could be entries into direct reclaim and/or c=
ompaction,
> > > > leading to unpredictable stalls[4]. Now, the allocator can confiden=
tly use
> > > > process_madvise(MADV_F_COLLAPSE_LIGHT) to attempt the allocation of=
 huge pages.
> > >
> > > IIUC the primary reason is the cost of the huge page allocation which
> > > can be really high if the memory is heavily fragmented and it is call=
ed
> > > synchronously from the process directly, correct? Can that be worked
> >
> > Yes, that's correct.
> >
> > > around by process_madvise and performing the operation from a differe=
nt
> > > context? Are there any other reasons to have a different mode?
> >
> > In latency-sensitive scenarios, some applications aim to enhance perfor=
mance
> > by utilizing huge pages as much as possible. At the same time, in case =
of
> > allocation failure, they prefer a quick return without triggering direc=
t memory
> > reclamation and compaction.
>
> Could you elaborate some more on why?

Previously, the Go runtime attempted to marks all new memory as MADV_HUGEPA=
GE
on Linux and manages its hugepage eligibility status. Unfortunately,
the default THP
behavior on most Linux distros is that MADV_HUGEPAGE blocks while the kerne=
l
eagerly reclaims and compacts memory to allocate a hugepage.
This direct reclaim and compaction is unbounded, and may result in signific=
ant
application thread stalls. In really bad cases, this can exceed 100s
of ms or even
seconds.
The overall strategy of trying to keep hugepages for the heap unbroken
however is
sound. So, the Go runtime uses MADV_COLLAPSE as an alternative.
See https://github.com/golang/go/commit/9f9bb26880388c5bead158e9eca3be4b3a9=
bd2af

Later, a Google production service experienced a performance
regression with the Go
runtime's use of MADV_COLLAPSE. For now, the Go runtime has rolled
back the usage of MADV_COLLAPSE.
See https://github.com/golang/go/issues/63334

If there were a more relaxed (opportunistic) MADV_COLLAPSE, it would
avoid direct reclaim
and/or compaction and quickly fail on allocation errors. This could be
beneficial for similar
use cases.

BR,
Lance

>
> > > I mean I can think of a more relaxed (opportunistic) MADV_COLLAPSE -
> > > e.g. non blocking one to make sure that the caller doesn't really blo=
ck
> > > on resource contention (be it locks or memory availability) because t=
hat
> > > matches our non-blocking interface in other areas but having a LIGHT
> > > operation sounds really vague and the exact semantic would be
> > > implementation specific and might change over time. Non-blocking has =
a
> > > clear semantic but it is not really clear whether that is what you
> > > really need/want.
> >
> > Could you provide me with some suggestions regarding the naming of a
> > more relaxed (opportunistic) MADV_COLLAPSE?
>
> Naming is not all that important at this stage (it could be
> MADV_COLLAPSE_NOBLOCK for example). The primary question is whether
> non-blocking in general is the desired behavior or the implementation
> should try but not too hard.
>
> --
> Michal Hocko
> SUSE Labs

