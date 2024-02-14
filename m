Return-Path: <linux-kernel+bounces-66063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709FE85561D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3D21F2B432
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E72B14600F;
	Wed, 14 Feb 2024 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2yMsy/4"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE95A1420CE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950182; cv=none; b=FU9BFK7ktg/k6fzYS8x2Vsia9BCDq+R2RW3dm63l/6ar9lUB6quuDQ4t2Ek2GYEvPKaDF/Tc8DnBqg5o1pASmzfrf9AMHZfjhTYBj0X/FGoOFiyvrUWsdOmkSQmUvDR253/TPK5tNT3Xvn2VS0MQXGfAz9s+V8eyvAg9dCGJeDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950182; c=relaxed/simple;
	bh=C0crMXEshWXmvClKWRf7fOFqj/1UG01MNn2e/g61qyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3g68uiV65RwVkRJg5fUqMR+IGN0N2yKyuuOk2SbZkDNCZFhAaSrXf1TdgnIeVCQPZpCPex1PSK2fL4HHgEgwZfw6laij9Bf2mQoLJe1Ywiq95NxbLFW/DJzs0odTbr1jCtIpP2zQypI3zFkDBXvdRayUL537nF6Na+aFS+UWxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2yMsy/4; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso223086276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707950178; x=1708554978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIZ+3Vimc+Fu9uNEqwRF3MpLhrYbsxAAnrlrt3WNttw=;
        b=O2yMsy/4oK8Y+fycjp+dTg7a95J3x8uffn5QQr/GODzExUn+5G+F1syIYtUOfWJzqr
         VWnifaveFBOThJy2sKyI/Uy6uSfYCaWQ8rs+vnJ6uTAaToe3OeN7Ck4g35cRmc7SULgW
         laJ2nuz+VS51bFFnqHVE7welFFlu4ndy4JVcGUEPx9hVfuSNHt7B6bMWePu/VzHNqW52
         CA42MpX0muLR6BbAaA7ZcJvUVwHp9ISH7RboIY2VBPjOK9ogFCKNPaPmrRsHKi8s4PUD
         Ih2VJvDYzSrud5HsdsKn4sU6PKEp9zXsfcrtDRXggHej6O7KHmSUtU8JvMr7ho9EnsKS
         a7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950179; x=1708554979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIZ+3Vimc+Fu9uNEqwRF3MpLhrYbsxAAnrlrt3WNttw=;
        b=mWHk310EOHLy0byjCNwylK/wzITdGVkBf4nzTQ2TPTQTypttsAdNTeaMmrx59+Mczd
         SWfhXUnYhFEk53wHjaQD5b+yF9va5LSE5nBgDiWdtvjnokCHTYctLA10a9VedC6Bdkw8
         Q3umWFm8BuWdNS0kJ58gfNpGOMv84NZGRxkAm03ZLH5eNUc1EHzXCevuHeTtlMPEZaLX
         uINj8ZGZE91U6KW/5xRYXf9JKGnGVGqHSxnK2VwqQNgv/frSpprn01dj07CPKvKp/Ooi
         ONAyJUW4oqXVuZ0VRYvRhMHFSxqU4zlyJmblsCS1JXHbeFP8A6oa3V5yUAfbP4zG/vK+
         D1ag==
X-Forwarded-Encrypted: i=1; AJvYcCXJ4/OfhXckiIw3y9iP8vL0byzD2JMF6CrEVzCabYGrybr82tmNXGMcqgEsbNuPbcFwhk/Z3zkS9JSonNdPWsQzV5jTKyEyrgHI57Ve
X-Gm-Message-State: AOJu0Ywkr1f3yXT+2mJ882B4RbYCmXnRRYLdolJ7Y0f/plMQXogXJ5r/
	i9f5xfX1yA42SctjlGc3g5D+KhlpcVJ59PkGDqwlfQZ+k9FOnRWpr5YcQggZsiUts53DFhy29nf
	HQMS46uC4qNQaa/ePJ+8Y6ei85mLfHTr++tND
X-Google-Smtp-Source: AGHT+IFGMo5QMzgB4haA8j4PHefAYH0QGMXhhajKI9bA2/lcKpgWtoNuuV25DDWG2rPEqNS3u8mi+lX2wk/W+0Ufusg=
X-Received: by 2002:a25:208:0:b0:dc6:9c4f:9e85 with SMTP id
 8-20020a250208000000b00dc69c4f9e85mr3483617ybc.49.1707950178324; Wed, 14 Feb
 2024 14:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-26-surenb@google.com>
 <Zc09KRo7nMlSGpG6@dread.disaster.area>
In-Reply-To: <Zc09KRo7nMlSGpG6@dread.disaster.area>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 14 Feb 2024 14:36:06 -0800
Message-ID: <CAJuCfpGPyf9VzohFi8HzvT0XsW4bd3EAnCAb6xxedfJGtzZbBA@mail.gmail.com>
Subject: Re: [PATCH v3 25/35] xfs: Memory allocation profiling fixups
To: Dave Chinner <david@fromorbit.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 2:22=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Mon, Feb 12, 2024 at 01:39:11PM -0800, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > This adds an alloc_hooks() wrapper around kmem_alloc(), so that we can
> > have allocations accounted to the proper callsite.
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/xfs/kmem.c |  4 ++--
> >  fs/xfs/kmem.h | 10 ++++------
> >  2 files changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
> > index c557a030acfe..9aa57a4e2478 100644
> > --- a/fs/xfs/kmem.c
> > +++ b/fs/xfs/kmem.c
> > @@ -8,7 +8,7 @@
> >  #include "xfs_trace.h"
> >
> >  void *
> > -kmem_alloc(size_t size, xfs_km_flags_t flags)
> > +kmem_alloc_noprof(size_t size, xfs_km_flags_t flags)
> >  {
> >       int     retries =3D 0;
> >       gfp_t   lflags =3D kmem_flags_convert(flags);
> > @@ -17,7 +17,7 @@ kmem_alloc(size_t size, xfs_km_flags_t flags)
> >       trace_kmem_alloc(size, flags, _RET_IP_);
> >
> >       do {
> > -             ptr =3D kmalloc(size, lflags);
> > +             ptr =3D kmalloc_noprof(size, lflags);
> >               if (ptr || (flags & KM_MAYFAIL))
> >                       return ptr;
> >               if (!(++retries % 100))
> > diff --git a/fs/xfs/kmem.h b/fs/xfs/kmem.h
> > index b987dc2c6851..c4cf1dc2a7af 100644
> > --- a/fs/xfs/kmem.h
> > +++ b/fs/xfs/kmem.h
> > @@ -6,6 +6,7 @@
> >  #ifndef __XFS_SUPPORT_KMEM_H__
> >  #define __XFS_SUPPORT_KMEM_H__
> >
> > +#include <linux/alloc_tag.h>
> >  #include <linux/slab.h>
> >  #include <linux/sched.h>
> >  #include <linux/mm.h>
> > @@ -56,18 +57,15 @@ kmem_flags_convert(xfs_km_flags_t flags)
> >       return lflags;
> >  }
> >
> > -extern void *kmem_alloc(size_t, xfs_km_flags_t);
> >  static inline void  kmem_free(const void *ptr)
> >  {
> >       kvfree(ptr);
> >  }
> >
> > +extern void *kmem_alloc_noprof(size_t, xfs_km_flags_t);
> > +#define kmem_alloc(...)                      alloc_hooks(kmem_alloc_no=
prof(__VA_ARGS__))
> >
> > -static inline void *
> > -kmem_zalloc(size_t size, xfs_km_flags_t flags)
> > -{
> > -     return kmem_alloc(size, flags | KM_ZERO);
> > -}
> > +#define kmem_zalloc(_size, _flags)   kmem_alloc((_size), (_flags) | KM=
_ZERO)
> >
> >  /*
> >   * Zone interfaces
> > --
> > 2.43.0.687.g38aa6559b0-goog
>
> These changes can be dropped - the fs/xfs/kmem.[ch] stuff is now
> gone in linux-xfs/for-next.

Thanks for the note. Will drop in the next submission.

>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com

