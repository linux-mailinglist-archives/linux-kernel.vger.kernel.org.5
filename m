Return-Path: <linux-kernel+bounces-84782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA69486AB7D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C07B25B85
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DADF364AC;
	Wed, 28 Feb 2024 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKKP0pJc"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20185364A0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113195; cv=none; b=foJVTRJ+edZcOC6SE2iXsAyQ4K0tu9ejeg8vR3y8gYtVu6OxpjC9t0NymaUIMUYDs1ex75VaBkd4u8hTaedj2Lm/sh15vQ45tui4b9jOx7NYiy+k2oXZNUhEZqgbHWuHiDSY6k7Zd+b836A2T8PSYYctV0H+zZE/rZqS98fNdFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113195; c=relaxed/simple;
	bh=ZlnM2qf1hi4l2sQqcASIngU26BOLKdrzoXUoZqeKEqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWpjV4THkA2hZNK3AdpGI0GzO2lAC4BiDr/ps5aPQtzryVpTi6ygazu9fpT7vmHeTJSe5bf0JtcQmNnJbokt9ubn5YjKNLnotsqeG/ix2ai7Bv11CBgukc8U/pT3K77cQCDv0eESTgXpAPKyHCRMpwqLb84FHdqFG842dFbBLEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKKP0pJc; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4d051349124so1002667e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709113193; x=1709717993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT+gCZjCYJ0eCqx/rUQ7NQHxfo7zFEEwzD3AarT1Iqw=;
        b=cKKP0pJc3ynRG2UmL7aZK+fuin84nRwyEWGy8Bdeej7h8nSkRPkey4iG1vQvCyKTNc
         x6CMXVVP4ivgIa145JxGjMTjM0CTGp3RZaECrdVW3xpgl6IvDkJm5bN3tZ4VHuFr1AqM
         8ls5cIqO4N9/+vJ8vNYi4sGhiVip7I6MC9GhGZJ3xmY9uDq4e/81LhwlQCNzILLR1yX+
         eHTGGckX6m/dN8O6Ziq4ju4Sr/d8MPcqUFpa9kt2OaLQnzEkS8KHaZevIqONuLdqkAUQ
         SdqgMAiXXnIfQJFLGQRQj7CYoSOzLmhhFP9mkKRWLFefKQgrxm7gYHr+/0MzTp5ufrOW
         QcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113193; x=1709717993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YT+gCZjCYJ0eCqx/rUQ7NQHxfo7zFEEwzD3AarT1Iqw=;
        b=dfZsdorUuHvzb0KfEzQSyQ6L6W7iRieYt3niNWn5wYHNoIBWR2km8yXugWkzKgGTvw
         pTl/JSmWNYwR2eo6n3n8t1Hy42vx5ilQro853L2QxN8QeOD+lYlwBiunJGxF+eV+K38P
         OmrKdFiBChmz2oHO5rUS0EGSp6q5DSOAK8Xkr3ngpycuJY7usCwJCTnpXVZuljwI2QWN
         xXhjgUE/PpO+iw11N/2KvN9qjbOvOMvf7qKszjGtLASmqlZKKmVCQVZLqFTvvuAdH7e2
         tlCepUbWb+mSv4oW0HwxXS2QvO4+6VJ2+8krtkoyMdcT6DsgbrbxiVfX+Kd4/W07vB9X
         UfXA==
X-Forwarded-Encrypted: i=1; AJvYcCUHnak/LItqFkoM4Nwuh+uq0s5ijiqxkt1YTVhmj1q67NDY/jvsjz8HZTUQoPPoJpnig/ZA9B4LiDMUrdn3h60bg/qiCemJUVrGeo5c
X-Gm-Message-State: AOJu0YwWn1Ag/v49lTaBtz1FoqkmMZMUtglweShqVBIHo0W/xd1ApH57
	46awJ04fOIThyCoUyn4suYJcVcV7HLK0bxWMmNSfbMu000YE6/t6f3NF7wFsPWSdNuqWjpoBdsJ
	CE/hGYANhcpekJENhAf6Wsb90rr4=
X-Google-Smtp-Source: AGHT+IG4ZInyB84wJIJElM/SMkz0qZ2Dt6f8YZr3AOZihAhv9lXBgJBFHfN0uJbaDOywvOHzBRHeb3G2gTruDfiZEJA=
X-Received: by 2002:a1f:cdc5:0:b0:4c7:98d3:db76 with SMTP id
 d188-20020a1fcdc5000000b004c798d3db76mr8993374vkg.4.1709113192929; Wed, 28
 Feb 2024 01:39:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <84d7cd03-1cf8-401a-8edf-2524db0bd6d5@oppo.com> <CAGsJ_4w_itxmZR7ytu7HnptQNZQzM-vAJhE_zSZrTAH1iqBV6g@mail.gmail.com>
In-Reply-To: <CAGsJ_4w_itxmZR7ytu7HnptQNZQzM-vAJhE_zSZrTAH1iqBV6g@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 28 Feb 2024 22:39:41 +1300
Message-ID: <CAGsJ_4w+L03rPcFbLm4E5sWixkKLizB4vxR-Z6LHbqwV56vB4w@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: Fix return value check for vb_alloc
To: =?UTF-8?B?5YiY5rW36b6ZKExhb0xpdSk=?= <liuhailong@oppo.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "urezki@gmail.com" <urezki@gmail.com>, 
	"hch@infradead.org" <hch@infradead.org>, "lstoakes@gmail.com" <lstoakes@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 10:34=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Wed, Feb 28, 2024 at 9:51=E2=80=AFPM =E5=88=98=E6=B5=B7=E9=BE=99(LaoLi=
u) <liuhailong@oppo.com> wrote:
> >
> > If vm_map_ram(page, 0, 0) would cause panic by vmap_pages_range_noflush=
, so
> > change IS_ERR to IS_ERR_OR_NULL to fix this.
> >
> > Signed-off-by: Hailong.Liu <liuhailong@oppo.com>
> > ---
> >  mm/vmalloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index d12a17fc0c17..109732006cf7 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2387,7 +2387,7 @@ void *vm_map_ram(struct page **pages, unsigned in=
t
> > count, int node)
> >
> >         if (likely(count <=3D VMAP_MAX_ALLOC)) {
> >                 mem =3D vb_alloc(size, GFP_KERNEL);
> > -               if (IS_ERR(mem))
> > +               if (IS_ERR_OR_NULL(mem))
>
> it seems the only case for vb_alloc to return NULL is size =3D 0, isn't
> it a bug of
> caller?

what about the below?

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 25a8df497255..640157221c95 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2834,6 +2834,9 @@ void *vm_map_ram(struct page **pages, unsigned
int count, int node)
        unsigned long addr;
        void *mem;

+       if (unlikely(count =3D=3D 0))
+               return NULL;
+
        if (likely(count <=3D VMAP_MAX_ALLOC)) {
                mem =3D vb_alloc(size, GFP_KERNEL);
                if (IS_ERR(mem))


>
> >                         return NULL;
> >                 addr =3D (unsigned long)mem;
> >         } else {
> > --
> > 2.34.1
Thanks
Barry

