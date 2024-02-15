Return-Path: <linux-kernel+bounces-67770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5152D85706A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE382850F9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1E0146904;
	Thu, 15 Feb 2024 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DWJbIM8e"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8C146013
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035213; cv=none; b=LvvagMW+y3c0cHBHkIs8Q1UUwJ4Hllm8Sik6eb8oPxWzhF4Ym6i0E+K6WS0mKYQ14Bkdaa41WbTYVlbOujwhG+XicphfZH/yb0Q+Jq2v7yER/bMkJ1qHw/3PrVb0uEOzYoTr1hzoy0U/zj+rJgl4s4MFkEtf33JersQ+I0r0Ggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035213; c=relaxed/simple;
	bh=BVWjDf4o/TkcyA5Y0ezqJIZKlfMABZXNy+d1zmxL6O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TumBcYyzlXW1FWG0PKt04dXU7VEGLq6c157vLkjhsVLhaP9D8I05k+PvLglm1XCbwmdwAVWaWjSLmSj1ybq+wbteEWd4B24gT2qFySxQBZOFzp9CNkB0vn+Gd+gdqGIV8r6wAG/YB9bkng8QUCuw7t+3mBb/QIea1Pbp+xngqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DWJbIM8e; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-607f8482b88so806447b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708035209; x=1708640009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVXTqIldo+bBUN2qGPMpdu4xA8ur5OmocrNHlsGX//8=;
        b=DWJbIM8eXUW5wl7hvwc8j6i2t54I6HpkWFDS870hjI0B7QWRFkEoivThQJnpaunmZX
         tF7XoNHnQuCSp75OmcaHKNhkPJyeEe18VSmiZ180F5X8zi9e7JDjGhlTCtuiLxXuJQ4x
         UiHjDBblfmSvDOP2rLUZGEuqtBEvVRg773tUHiUg9HRPiPTcCf4NLv8ruD0cDNox9CDR
         4c117wN33k4jkH6SrG3T8kRDubnPDGl2lLTqQCdd3KOqKCvvRDUXoKFQrWnR/VmvNiLm
         LgJcYRwMO1zmZ3b/0cJKlmVRaiOkt3pVhHmzsochxzAmx9ZTolQAyr38gWeC8T7qmx2l
         Ifeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708035209; x=1708640009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVXTqIldo+bBUN2qGPMpdu4xA8ur5OmocrNHlsGX//8=;
        b=SF+ED3IDkI9K5HkT6A5DLe/PJ/1iJF/4C/1pY/kwktKeYvuXZUfzQK5danGIwtVx5v
         +D+q7+MwXawEVk62PA1gtcNjroKTfN+sDUUtySFxwpu50KJoXuOLTP1F2TNrJR6YD0Kg
         o9fXp7fjUgkr2+oBzu6GRqkaU4eAemI5N1inCCiP1gF9ZecAfaw81H4iFMCYzJBA4WPW
         3HYCDffOlml5om7Qwa74BAvaSdPAcIsO+e73vWqSNonu+2AQ3XSbr512XTqGI49ROZYb
         hyhBLPgEHVQ7xXt0a3fr6iZZEo/OZ2vmGGvWYArgDC6IO1KBRol5rgcQP3Z7FVLtneHb
         v1Og==
X-Forwarded-Encrypted: i=1; AJvYcCXrzsYQDdNERpak6gXIohGt0thQ7qQJ1dZtGtSpe2bdKdUdaR1Ox4YHA3doFd3W9bTSJwWPSIYc00OmrmjrrYvhKZjG6xq1LMkXqG+C
X-Gm-Message-State: AOJu0YwolFviU6Uc+1eoQBECOuv4O5aTlGjiUWn++D9Z/W4EkJypqh0L
	eO9E9/vjlGI4faqhFByC2tZPlzwvpNjwOXw7nc9Tphbiqt0AqTtDtbmSlAx7yiJpP+PhX1GyAy0
	SKvo6zW7fbRIWelxEyhOdnJlRvyysTRJvMy+R
X-Google-Smtp-Source: AGHT+IFpfAHbdwwQWobmayk2rC70GIR5llMLqhN7V0gqU4ymPn9T6FJZX+4/04lZlSOrJu1fJl+ZwYg9qZBTYuElGSc=
X-Received: by 2002:a0d:cc4a:0:b0:607:cc6a:dcc5 with SMTP id
 o71-20020a0dcc4a000000b00607cc6adcc5mr3136666ywd.16.1708035208322; Thu, 15
 Feb 2024 14:13:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-9-surenb@google.com>
 <02cb04cd-0d8d-4948-b3ef-036160c52e64@suse.cz>
In-Reply-To: <02cb04cd-0d8d-4948-b3ef-036160c52e64@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 14:13:17 -0800
Message-ID: <CAJuCfpFj_vboiRZvpeuRpYK6ma-j-x2ry6dFbkaC=K51m8bQxA@mail.gmail.com>
Subject: Re: [PATCH v3 08/35] mm: prevent slabobj_ext allocations for
 slabobj_ext and kmem_cache objects
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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

On Thu, Feb 15, 2024 at 1:44=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/12/24 22:38, Suren Baghdasaryan wrote:
> > Use __GFP_NO_OBJ_EXT to prevent recursions when allocating slabobj_ext
> > objects. Also prevent slabobj_ext allocations for kmem_cache objects.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/slab.h        | 6 ++++++
> >  mm/slab_common.c | 2 ++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 436a126486b5..f4ff635091e4 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -589,6 +589,12 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, g=
fp_t flags, void *p)
> >       if (!need_slab_obj_ext())
> >               return NULL;
> >
> > +     if (s->flags & SLAB_NO_OBJ_EXT)
> > +             return NULL;
> > +
> > +     if (flags & __GFP_NO_OBJ_EXT)
> > +             return NULL;
>
> Since we agreed to postpone this function, when it appears later it can h=
ave
> those in.

Yes, I think that works. Will have this in the same patch.

>
> >       slab =3D virt_to_slab(p);
> >       if (!slab_obj_exts(slab) &&
> >           WARN(alloc_slab_obj_exts(slab, s, flags, false),
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 6bfa1810da5e..83fec2dd2e2d 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -218,6 +218,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct k=
mem_cache *s,
> >       void *vec;
> >
> >       gfp &=3D ~OBJCGS_CLEAR_MASK;
> > +     /* Prevent recursive extension vector allocation */
> > +     gfp |=3D __GFP_NO_OBJ_EXT;
>
> And this could become part of 6/35 mm: introduce __GFP_NO_OBJ_EXT ... ?

Yes, that will eliminate this patch. Thanks!

>
> >       vec =3D kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> >                          slab_nid(slab));
> >       if (!vec)
>

