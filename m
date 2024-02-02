Return-Path: <linux-kernel+bounces-50270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EF88476AD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FBC1C22169
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EAD14AD24;
	Fri,  2 Feb 2024 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="DVptwgIG"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2881474D1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896362; cv=none; b=IrFjPzCXv80usP4V65lihOmGVJ8LawL35TYUc7IuYplPGBoNahsAoDjlcj7nSgHKni5r/ZlSNDIlbC9H8kCJKOQ6uWA/VdCTc5DTivGcm9R5nT0sWdn99ZnKrNyMO+C3zQ3nq7Si7aoVAG7+JaizFYhTiykaFKiTXF8MbsKQP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896362; c=relaxed/simple;
	bh=thwc2BpCZUTvP4aysxwVHVYbONrwXJuuwnI5zKcv+uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B276uDBVxxldqSQGMJ6mZodnn3yGCE33YBJ9tLzUNJZ0xGkLcDV3LYdgDQSRcs8DVgsxCH3NatP6zdeB1i69Zv4/GRIrcMCUM6h7AGAzS1rKm5gJa+hIcbaL/h9NG0FM0aBZz49z9Ct9UaohyjmMjL+2eIdmHdFjemcWos8E0XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=DVptwgIG reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42ab4f89bdbso13814961cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1706896359; x=1707501159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tic9SFl6RtBy5A5jkwNrOONIWfXMn2Yn279S/dAQN4s=;
        b=DVptwgIGX60OTBCmWNn/WixvUOSoKHjmY7tr30itXhuKVXaGsyl9HRi/rZmGqwGA9e
         RRb6S/c5to1ZQ9Vzs329tut2g5p9951X57Nyz8nzHYYj6xVg9lvnKPu0aP0ZvcEOdVZg
         5yzUGGv9mkqDuGI8ZHivw3uSjmAcHD06e1QlG68cclXvNAKB+ba+kpFjoZIeIGSH4qpg
         Ccs9Ofh4wFZnwr6idQyklm1PFAW/6mqI72PZak3aN8F9b/13MmwWzC8WXn97kxblBVe5
         XVQxrW97u52p2L8Z4kzNjocQ404Tay6rMg9wc8cZekZ7jdPy2Z09Hnrp37KM0JOnc7ws
         w4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706896359; x=1707501159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tic9SFl6RtBy5A5jkwNrOONIWfXMn2Yn279S/dAQN4s=;
        b=rokI7hPQJkNR8kKgx1m6Y8qQo33jyYba7nYNZmSCfbQl1dJOXLZxMWObbhEVqfvjZs
         pfiZG/dXQqUxpEnVkch5NoXvTm+x4vW5sx4TR+bc5wlJEwDtE02rfdF/Rqtof61BvynT
         R3XMTyW7Sz46o8dtFkC7txV3Ct3Wpp+Wn9o/FmT2h1a3w1XsWN6y7leZz704pQ18G0Db
         Yqr5OxRjYZ5dePRM1V2xgUYqWkrcFmpQqbk4oemPPkXuQSIBG4l43k4SZPCNXxwnwhTh
         WRIEWbdCrV+/gfyk/3A3lh01bD7LkUIKMuOtU4DJaTlMaqXSTYTtN00+pvlozkmJdtCy
         5gZw==
X-Gm-Message-State: AOJu0YxcI76KmfIN/0lly88/TWXGblGXODTr/OQAzzNqGLrJvSxh4zIr
	MHQKrSvNzGljlcX+YJgU5Lztr0Gv8yCVjcd96xK2mqdqf+4dJpjIC2lCkZvWIXHnm/48KLxLOFi
	gP3zLvYg/DUSI6/oxt27gGGrwpFaazTZfgGGRwg==
X-Google-Smtp-Source: AGHT+IF/L/ZVnSmxYIpbF/6R4E3+3ofqDEXkLbosTV/HlVxwowatIOpcBf+LYIKvLNNieDl9Ov8+hl2pgPZa4GuPwtI=
X-Received: by 2002:ac8:5d11:0:b0:42a:6217:f87d with SMTP id
 f17-20020ac85d11000000b0042a6217f87dmr3127013qtx.17.1706896359491; Fri, 02
 Feb 2024 09:52:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201193014.2785570-1-tatashin@google.com> <CAJD7tkbDwwzTfm5h6v5f8XSN8KduBy6h7EVuQt0CAfX--Nb0gQ@mail.gmail.com>
In-Reply-To: <CAJD7tkbDwwzTfm5h6v5f8XSN8KduBy6h7EVuQt0CAfX--Nb0gQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 2 Feb 2024 12:52:03 -0500
Message-ID: <CA+CK2bCCGXuB9QfAc+BZ_JWf872xy3uGE=-pUbhYJwZSkSdrew@mail.gmail.com>
Subject: Re: [PATCH] iommu/iova: use named kmem_cache for iova magazines
To: Yosry Ahmed <yosryahmed@google.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rientjes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +static int iova_magazine_cache_init(void)
> > +{
> > +       int ret =3D 0;
> > +
> > +       mutex_lock(&iova_magazine_cache_mutex);
> > +
> > +       iova_magazine_cache_users++;
> > +       if (iova_magazine_cache_users > 1)
> > +               goto out_unlock;
> > +
> > +       iova_magazine_cache =3D kmem_cache_create("iommu_iova_magazine"=
,
> > +                                               sizeof(struct iova_maga=
zine),
> > +                                               0, SLAB_HWCACHE_ALIGN, =
NULL);
>
> Could this slab cache be merged with a compatible one in the slab
> code? If this happens, do we still get a separate entry in
> /proc/slabinfo?

Hi Yosry,

Good suggestion to check for merges. I have checked,
iommu_iova_magazine is not merged.

> It may be useful to use SLAB_NO_MERGE if the purpose is to
> specifically have observability into this slab cache, but the comments
> above the flag make me think I may be misunderstanding it.

SLAB_NO_MERGE may reduce performance, and fragmentation efficiency, it
is better to keep it as-is.

Pasha

On Thu, Feb 1, 2024 at 5:29=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Thu, Feb 1, 2024 at 11:30=E2=80=AFAM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > From: Pasha Tatashin <pasha.tatashin@soleen.com>
> >
> > The magazine buffers can take gigabytes of kmem memory, dominating all
> > other allocations. For observability prurpose create named slab cache s=
o
> > the iova magazine memory overhead can be clearly observed.
> >
> > With this change:
> >
> > > slabtop -o | head
> >  Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
> >  Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
> >  Active / Total Caches (% used)     : 135 / 211 (64.0%)
> >  Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
> >  Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K
> >
> > OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> > 244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazin=
e
> >  91636  88343 96%    0.03K    739     124      2956K kmalloc-32
> >  75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache
> >
> > On this machine it is now clear that magazine use 242M of kmem memory.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  drivers/iommu/iova.c | 57 +++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 54 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index d30e453d0fb4..617bbc2b79f5 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -630,6 +630,10 @@ EXPORT_SYMBOL_GPL(reserve_iova);
> >
> >  #define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
> >
> > +static struct kmem_cache *iova_magazine_cache;
> > +static unsigned int iova_magazine_cache_users;
> > +static DEFINE_MUTEX(iova_magazine_cache_mutex);
> > +
> >  struct iova_magazine {
> >         union {
> >                 unsigned long size;
> > @@ -654,11 +658,51 @@ struct iova_rcache {
> >         struct delayed_work work;
> >  };
> >
> > +static int iova_magazine_cache_init(void)
> > +{
> > +       int ret =3D 0;
> > +
> > +       mutex_lock(&iova_magazine_cache_mutex);
> > +
> > +       iova_magazine_cache_users++;
> > +       if (iova_magazine_cache_users > 1)
> > +               goto out_unlock;
> > +
> > +       iova_magazine_cache =3D kmem_cache_create("iommu_iova_magazine"=
,
> > +                                               sizeof(struct iova_maga=
zine),
> > +                                               0, SLAB_HWCACHE_ALIGN, =
NULL);
>
> Could this slab cache be merged with a compatible one in the slab
> code? If this happens, do we still get a separate entry in
> /proc/slabinfo?
>
> It may be useful to use SLAB_NO_MERGE if the purpose is to
> specifically have observability into this slab cache, but the comments
> above the flag make me think I may be misunderstanding it.

