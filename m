Return-Path: <linux-kernel+bounces-30701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7958832339
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1CEB21DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EDB4A12;
	Fri, 19 Jan 2024 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWr+2YqC"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4BF4A04
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705629799; cv=none; b=SFTzys/fMTlH4I5JKc5GPdgffC/pwwAT+XtnpWZVdJqgcZOc7WLupIGnB6QtigCrrdL6VwQmUVrWYsmLnwApDEBktidvqNivjYg5j18KHo+xii5qmlLrRskG0dNGejCLUUy71c950hnVmPpHQas/fV/vTUAZiPYy7rOUGlllKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705629799; c=relaxed/simple;
	bh=qRcgxHMJ8VpBBVLzbYNZYouTGZecFbrpSJHdtv6EjmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mz34eelUzLNIjUnYmK4u4Oyho8ueKtH8Uw4rKjCEe3DxHpmGxyzmxv0vb+bO5J3cKJRo3RNckmVp+Vc/9p9JdaJ68lv+zS59L4qSHIdQehQQANgbtf8BiwpEjFGLF9M+SUPqPn+bAZvjDwKi742oKG27AVj5LLTDzBIqnhqQJg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWr+2YqC; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd932a0cafso203277b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705629797; x=1706234597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRcgxHMJ8VpBBVLzbYNZYouTGZecFbrpSJHdtv6EjmE=;
        b=HWr+2YqClNxLolSyYCxb6CoB2HFjlh4MAV2uLh9UERvM7J8RgYKDfL5OZcwwcQav5y
         qhXsd34JT3naXqG2s/elDiTm9S9wzPOQDsgniSqHtK5tWp9DoeuKp7NUVsmpGBXVOxOd
         EIJMVtwzvcVSXpuz3yBRzGmrlLH97LIQ4vBoYldZff8THUd4twDoDLoUQvRxFexnuTrR
         Z1yCPE51VhFK4ubZFNA4hdcxF9JXXGSBARJqbKvXkAhbFNwhDqa8fJ5L7E0KDIl6XW66
         1vhn0VHPJ4xnRgmMZqgHdEx7sxO1U5DZNv2To2uo87vT8vm4Wp20//7zqGP8EbXNjEJz
         UBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705629797; x=1706234597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRcgxHMJ8VpBBVLzbYNZYouTGZecFbrpSJHdtv6EjmE=;
        b=iI1vHgcErUJmn4prdsrEwYK16mNJ09OSWOvgd1d+xsaSNZCe8A2mgSR6U/jUNjZ0WG
         ZGDzsxlNgr9WJU3TmAmfKluwPWKYSUHSasUVb2SAuLvkhLsYoePg3Kq6xmiO0hafe2wu
         h4bgSBo3Pnhfi9FMCyshoDQRi7yIHAwP0D11HUp47s6G7ErcoJvvzDfEFd8Oiwg7w7St
         BDhZrtclrPayHUauw8+KhfKccI6iyXR7kbVjg4M01yjoQcjaDaUo3ubjmXQ2RuQpBYLP
         WNc09g91HuwuNi27J8pFvQX66sKZdPYKUkIb/0KrahPS5Z8YzleoXuJnwudrnvMjZMZR
         PauQ==
X-Gm-Message-State: AOJu0YzI1A23YvoXA9beI9nGmDaQsSYy7AeA9h/QW7RXTm+fTyscZy7p
	JCTAy4laGJ5CzXBzPFhGEDBeqQhdvdpp0Av6T/KYihQknsle622zg/96M+oCBRR5zxv5S1KBwkf
	yX3mW95/AyhgfZuFVZ/Dns4ge3MU=
X-Google-Smtp-Source: AGHT+IHPRBtEkk0NJMOxUEU6XNvrEYnIieqra4NJuy8hIaLQ51bR4M0BaIjDY5tR8XSjcfiSsqyo/Xt6XOjLNHychL4=
X-Received: by 2002:a05:6808:2017:b0:3bd:9ff7:428b with SMTP id
 q23-20020a056808201700b003bd9ff7428bmr1244888oiw.51.1705629797154; Thu, 18
 Jan 2024 18:03:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <ZakqQyL9t2ffNUIf@tiehlicka>
In-Reply-To: <ZakqQyL9t2ffNUIf@tiehlicka>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 19 Jan 2024 10:03:05 +0800
Message-ID: <CAK1f24k+=Sskotbct+yGxpDKNv=qyXPkww5i2kaqfzwaUVO_GQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Michal,

Thanks for taking the time to review!

On Thu, Jan 18, 2024 at 9:40=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 18-01-24 20:03:46, Lance Yang wrote:
> [...]
>
> before we discuss the semantic, let's focus on the usecase.
>
> > Use Cases
> >
> > An immediate user of this new functionality is the Go runtime heap allo=
cator
> > that manages memory in hugepage-sized chunks. In the past, whether it w=
as a
> > newly allocated chunk through mmap() or a reused chunk released by
> > madvise(MADV_DONTNEED), the allocator attempted to eagerly back memory =
with
> > huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPSE)[3=
]
> > respectively. However, both approaches resulted in performance issues; =
for
> > both scenarios, there could be entries into direct reclaim and/or compa=
ction,
> > leading to unpredictable stalls[4]. Now, the allocator can confidently =
use
> > process_madvise(MADV_F_COLLAPSE_LIGHT) to attempt the allocation of hug=
e pages.
>
> IIUC the primary reason is the cost of the huge page allocation which
> can be really high if the memory is heavily fragmented and it is called
> synchronously from the process directly, correct? Can that be worked

Yes, that's correct.

> around by process_madvise and performing the operation from a different
> context? Are there any other reasons to have a different mode?

In latency-sensitive scenarios, some applications aim to enhance performanc=
e
by utilizing huge pages as much as possible. At the same time, in case of
allocation failure, they prefer a quick return without triggering direct me=
mory
reclamation and compaction.

>
> I mean I can think of a more relaxed (opportunistic) MADV_COLLAPSE -
> e.g. non blocking one to make sure that the caller doesn't really block
> on resource contention (be it locks or memory availability) because that
> matches our non-blocking interface in other areas but having a LIGHT
> operation sounds really vague and the exact semantic would be
> implementation specific and might change over time. Non-blocking has a
> clear semantic but it is not really clear whether that is what you
> really need/want.

Could you provide me with some suggestions regarding the naming of a
more relaxed (opportunistic) MADV_COLLAPSE?

Thanks again for your review and your suggestion!
Lance

>
> > [1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec56404f=
aca29a82689c77
> > [2] https://github.com/golang/go/commit/8fa9e3beee8b0e6baa7333740996181=
268b60a3a
> > [3] https://github.com/golang/go/commit/9f9bb26880388c5bead158e9eca3be4=
b3a9bd2af
> > [4] https://github.com/golang/go/issues/63334
> >
> > [v1] https://lore.kernel.org/lkml/20240117050217.43610-1-ioworker0@gmai=
l.com/
> --
> Michal Hocko
> SUSE Labs

