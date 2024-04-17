Return-Path: <linux-kernel+bounces-147833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693C38A7A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AFF71C20F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB111C02;
	Wed, 17 Apr 2024 01:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrwyCY2+"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9E1860
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713318530; cv=none; b=KcQoYCVLAgvruGdh4bYoIjfTTr/yTihiTNJJ2BnWD8UGCz8UMQpslc8O9zdAqogqM7xkNioq7AJ5U7/BfeWwhcfIbamiwS7NMZx5DePhevmVSyJxNZSK20+rOpnwbllMl+d0M3S8Lha38VQaC/uyUo/oedNwQV3jr3jgVcuD8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713318530; c=relaxed/simple;
	bh=0ZffSvpRUYRcf27sb1xqpEwkJD3YlrttFbqK5v1rQBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeXyFD4vqrepjoIIrHRfagI9yvzkrRq5Y7AtRB9DnkTNhTwo7T5Fqlle1paRM1HqYy9nkIYQO1R9YulKZIig4q5H6bSZno5YTLdwYDZ6t+BaNOiIjy0S864a6loQBq4eNFgkzjdadoWgiByq1PYkoTy7jfFnAen3VBWuuQj/4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrwyCY2+; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7eb7f34f36dso444475241.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713318528; x=1713923328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SrHxFpWuBTItyVrePiXT24pFyRWs6NH9bSHsOAYtzE=;
        b=MrwyCY2+K8SNB0WCzz4/8e6pA6Vozd7aaTiApiNf0/wTdDetT4LuJXzHg0+goq2fhx
         bDGumFzlEVns8ZJfotpW4veGZQdW84wZJrpNEg5t1GJzN/3LbTnAlHaX1ZdMI15xsieZ
         Xf5SZArP7aFSoXAA43ta6NaGvocE58klL9ObIE/+hz5jXPAFXQ1L/RaOcXdZ3pvBDbNg
         jSDfWOXUgT0uyMl67XhAplxfMCs6PB+TmHSyz37qhx/9LBoHL9ZPJnlfINiDvoszg0b1
         5ro8p8Z7O/2McZLxv+qylvv0/OTNzHaw83WfoYBBMvNkUtVM0cgRapYp2ygzGOF60Cda
         Xd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713318528; x=1713923328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SrHxFpWuBTItyVrePiXT24pFyRWs6NH9bSHsOAYtzE=;
        b=Za3kZkqCDe+67hIrYno4gnjLQ2VJ3OAfjmGjlwDWETzGLFxAvExFETK7pbWt4KJSTT
         irziIn/OmUL9X0cuI/iRikdCqilYXKUEVKuocb82QRsZ3kiBYfz0j3l9yarvjDdiYWMC
         k5rW1SV4sxDcqXRYJi1pegi1Q6iXihAH8/eFkXyWx2PL5Q7psnrdv++N3BbNoszCxpQI
         ZpxEr9EfCt17I98V77z9FW1kCKcZGBFLN5UYVz+IkYiXDi1Xp2LzWGiMTHIUfwoIB93/
         xz8FyzjMgMOK1E5cPtFJQQb9NZl2yi8Tu4FuN6dBGncgBvOinJEySGxJs3mZeOSi0RKg
         92yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWodsSXu901qXC4VuF+HCFXafV76/BSbbXQJFH/MM4BzJtv2j/sl1k2SwFAqDmJizWkSUQww/xR0Trde+qjIK4NfX8xAN2vtHctWZqK
X-Gm-Message-State: AOJu0YzdklHihd9SgnYZiWr5cwekxhiwjsAJQRr7nFeOG6Mf97PEZyay
	q0T1HxhsF2a5vF5K/2YuLVXi/8TNAIUMCcLTN1KqX8/CL7zR1Mo/aII0ai2evwPlLcC6aD92HaW
	Y/BYg/wlaTMfrGT0yAobSb9Ng+94=
X-Google-Smtp-Source: AGHT+IF9lpDTjWQIcigPB+h4sbtTvxRRF8oiDCuU6wuf/PRbZk+mTw2Vqu1AkZMGTqLugUpj6sHE/ok2j7k6siFqACI=
X-Received: by 2002:a05:6102:e0b:b0:47a:516d:69df with SMTP id
 o11-20020a0561020e0b00b0047a516d69dfmr10048709vst.6.1713318527827; Tue, 16
 Apr 2024 18:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-6-21cnbao@gmail.com>
 <87frvk24x8.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yoz=UH+=Z+ZmRy_9=vu_JWuOXnNO0gFtkBZ-rKJppMPA@mail.gmail.com>
 <87bk6822gh.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87bk6822gh.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 17 Apr 2024 13:48:36 +1200
Message-ID: <CAGsJ_4wOtkGhJL-daZfYyPacqypKHjK16_AqC+Y-1KrwXMNmHA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mm: add per-order mTHP swpin_refault counter
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:40=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Apr 17, 2024 at 8:47=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >
> >> > Currently, we are handling the scenario where we've hit a
> >> > large folio in the swapcache, and the reclaiming process
> >> > for this large folio is still ongoing.
> >> >
> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> > ---
> >> >  include/linux/huge_mm.h | 1 +
> >> >  mm/huge_memory.c        | 2 ++
> >> >  mm/memory.c             | 1 +
> >> >  3 files changed, 4 insertions(+)
> >> >
> >> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> > index c8256af83e33..b67294d5814f 100644
> >> > --- a/include/linux/huge_mm.h
> >> > +++ b/include/linux/huge_mm.h
> >> > @@ -269,6 +269,7 @@ enum mthp_stat_item {
> >> >       MTHP_STAT_ANON_ALLOC_FALLBACK,
> >> >       MTHP_STAT_ANON_SWPOUT,
> >> >       MTHP_STAT_ANON_SWPOUT_FALLBACK,
> >> > +     MTHP_STAT_ANON_SWPIN_REFAULT,
> >>
> >> This is different from the refault concept used in other place in mm
> >> subystem.  Please check the following code
> >>
> >>         if (shadow)
> >>                 workingset_refault(folio, shadow);
> >>
> >> in __read_swap_cache_async().
> >
> > right. it is slightly different as refault can also cover the case foli=
os
> > have been entirely released and a new page fault happens soon
> > after it.
> > Do you have a better name for this?
> > MTHP_STAT_ANON_SWPIN_UNDER_RECLAIM
> > or
> > MTHP_STAT_ANON_SWPIN_RECLAIMING ?
>
> TBH, I don't think we need this counter.  It's important for you during
> implementation.  But I don't think it's important for end users.

Okay. If we can't find a shared interest between the
implementer and user, I'm perfectly fine with keeping it
local only for debugging purposes.

>
> --
> Best Regards,
> Huang, Ying
>
> >>
> >> >       __MTHP_STAT_COUNT
> >> >  };
> >>
> >> --
> >> Best Regards,
> >> Huang, Ying
> >>
> >> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> > index d8d2ed80b0bf..fb95345b0bde 100644
> >> > --- a/mm/huge_memory.c
> >> > +++ b/mm/huge_memory.c
> >> > @@ -556,12 +556,14 @@ DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_AN=
ON_ALLOC);
> >> >  DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FAL=
LBACK);
> >> >  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> >> >  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_F=
ALLBACK);
> >> > +DEFINE_MTHP_STAT_ATTR(anon_swpin_refault, MTHP_STAT_ANON_SWPIN_REFA=
ULT);
> >> >
> >> >  static struct attribute *stats_attrs[] =3D {
> >> >       &anon_alloc_attr.attr,
> >> >       &anon_alloc_fallback_attr.attr,
> >> >       &anon_swpout_attr.attr,
> >> >       &anon_swpout_fallback_attr.attr,
> >> > +     &anon_swpin_refault_attr.attr,
> >> >       NULL,
> >> >  };
> >> >
> >> > diff --git a/mm/memory.c b/mm/memory.c
> >> > index 9818dc1893c8..acc023795a4d 100644
> >> > --- a/mm/memory.c
> >> > +++ b/mm/memory.c
> >> > @@ -4167,6 +4167,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >> >               nr_pages =3D nr;
> >> >               entry =3D folio->swap;
> >> >               page =3D &folio->page;
> >> > +             count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWP=
IN_REFAULT);
> >> >       }
> >> >
> >> >  check_pte:

