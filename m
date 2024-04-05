Return-Path: <linux-kernel+bounces-133514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AF189A4BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA417282894
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F21172BB1;
	Fri,  5 Apr 2024 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTC75qgJ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A55172BA8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344417; cv=none; b=rt+24CtkZo6Z6PYBMxkRzcJyZrSlEQ6rcWhnuOOT7Zr6SzgPxeH84bL8ZsNlqf+sEu5z1C+JzN/z4h20w7GCYZDHjXDSNLLlwNXepDO6R1Pac3KfZ6Xt1A6xJ7m97PfoCA/Pv44o5YywdR9t2JFHU8emlvfbAQQxYSQLh+Atty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344417; c=relaxed/simple;
	bh=N/GAxuyN0ICdsHgMXMPjrgO9dzc6KsGePIb1Dg//fJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqNUYN7X9NiIFdJ4CJDdYqzMvUL+Xakia1CrGnPVIGDQhyK+XU6XWxttsiYj88fJ81Nmelijmlbtz7dTI/6E+7HgjMlDFRrnxeJ1uDMDVL5NaUx7JR9HhBpepJHdQTb6azMTTIbdtt+P6TdmGGjEESs5zufiLec07HH5XBdrPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTC75qgJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e0430f714so2612a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712344413; x=1712949213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hBIVq/WYOp/vh9o7XH8iSSkLDklnPxJ1/J1gPC0JEs=;
        b=dTC75qgJKrmkM3ZRqh9MOLBmOxezMQztovpdSDOewHaEnLe7xUoDSFKjx2991XLUSY
         Y2udz+W9oH386JdQ71axoszs/NLp1GuR9OqF2pJ70nFNcRkfGgAzO2b6RLYY2sx/CTb9
         Hg8Ox526n+qvN26RItAVCBRsTcltEiMODgfxnZ/Yl5v0ij9t6wNuLlRmRYQEpv6ShNL1
         phL08GaQRb+JIPrhrNf2DoqOPg/kljySWyN/ssTZLsCJDeAr9hQidDB9OdhmlukFe36h
         ZXe5+dZ9dY3cbUZxCJI/6ZpiHEY97LugKQZGYTRxyYi30HQ6S09rHFCederOYHWu+xij
         qLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712344413; x=1712949213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hBIVq/WYOp/vh9o7XH8iSSkLDklnPxJ1/J1gPC0JEs=;
        b=WRs7G0Dfxpt1sEB4q0qMGzYCIgBHoV35lQju5ceP1Y6RJbaysoh5USC1Tx++z0lPng
         QFDif5UWibskJqz1cVTFleNwtYBbL1NLiJk/l3VBSSsnxKgCBQLzBA9xrCp9N6cnit8i
         2dGXHKmG0bUfXiHywbP35KZjUkydwW2ZgPKKZKoCbDgKTqoZBctFF6vuMewzR8pYUbdi
         z0aoWI1ivZz00mVIK/w190f5MGqknvb/vEMJEr3QsuMUX8HQ+3pnVKch6Mtuls4+2u7/
         8bUpJeRGdH1DO80SDU+nxs89Oof6GwKQvnc10TwcNPeNHpfUn0Mf184YyzF9wxcrDi1X
         sq/A==
X-Forwarded-Encrypted: i=1; AJvYcCUfecd8dfobXSxSVZPdBjg2FJs2cTt2wV7iyekq+C3j++dEjQfYy0mi0/hsWALPFz90GpArA0oCFUY0mOuVS/IVH4ZL8c9lOzplCkIq
X-Gm-Message-State: AOJu0YzIjeMjWwfTEmXMLu3UJeiLCIeGDKkuo0S1XpAiBHekAKaYmio+
	x6xyQwRQMRA4ojiJuQec4COjtJZnHVl8S8q+FDGbK+VnCG+luoL5LE92qVxcdyfU/9Rqans1dIR
	56MpHyzgN+Q+2o8RRaAvD2nwsYiKp0q0Vz47Pd1i+XHfI1FGGTv4O
X-Google-Smtp-Source: AGHT+IGSQw26K/1KMIaFNQXM+sHti7zzjBcsRbseAmGwF4GSHo884X/HYRIJUDWW3bHToyWwP9Q9PhkGYOaYXmEvYB4=
X-Received: by 2002:a05:6402:3d8:b0:56e:2b00:fcc7 with SMTP id
 t24-20020a05640203d800b0056e2b00fcc7mr27220edw.0.1712344413313; Fri, 05 Apr
 2024 12:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org>
 <20240404-dt-cleanup-free-v1-3-c60e6cba8da9@kernel.org> <CAGETcx8Wd5OsHWiGSASWkQQtof0D-ScwYsvq9hWizV3DFC27gA@mail.gmail.com>
 <CAL_JsqK4QpFmLi0WVG0Vpxv82Y1eWxbGS7ESWBhPoKg+WFV5Tw@mail.gmail.com>
In-Reply-To: <CAL_JsqK4QpFmLi0WVG0Vpxv82Y1eWxbGS7ESWBhPoKg+WFV5Tw@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 5 Apr 2024 12:12:53 -0700
Message-ID: <CAGETcx-26nAPGybBZq_bnQ4YWdosj_bBWnwPtF8sZ_vvoiSMUA@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: Use scope based of_node_put() cleanups
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 6:01=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Apr 4, 2024 at 6:22=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
> >
> > On Thu, Apr 4, 2024 at 7:15=E2=80=AFAM Rob Herring <robh@kernel.org> wr=
ote:
> > >
> > > Use the relatively new scope based of_node_put() cleanup to simplify
> > > function exit handling. Doing so reduces the chances of forgetting an
> > > of_node_put() and simplifies error paths by avoiding the need for got=
o
> > > statements.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/of/address.c  | 60 ++++++++++++++++-------------------------=
----------
> > >  drivers/of/property.c | 22 ++++++-------------
> > >  2 files changed, 26 insertions(+), 56 deletions(-)
> > >
> > > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > > index ae46a3605904..f7b2d535a6d1 100644
> > > --- a/drivers/of/address.c
> > > +++ b/drivers/of/address.c
> > > @@ -491,7 +491,6 @@ static u64 __of_translate_address(struct device_n=
ode *dev,
> > >                                   const __be32 *in_addr, const char *=
rprop,
> > >                                   struct device_node **host)
> > >  {
> > > -       struct device_node *parent =3D NULL;
> > >         struct of_bus *bus, *pbus;
> > >         __be32 addr[OF_MAX_ADDR_CELLS];
> > >         int na, ns, pna, pns;
> > > @@ -504,7 +503,7 @@ static u64 __of_translate_address(struct device_n=
ode *dev,
> > >
> > >         *host =3D NULL;
> > >         /* Get parent & match bus type */
> > > -       parent =3D get_parent(dev);
> > > +       struct device_node *parent __free(device_node) =3D get_parent=
(dev);
> >
> > Can we leave the variable definition where it was? We generally define
> > all the variables up top. So, defining the one variable in the middle
> > feels weird. I at least get when we do this inside for/if blocks. But
> > randomly in the middle feels weird.
>
> There's an 'of_node_get(dev);' before this. Ordering wise, we need to
> hold the ref on the child before we get its parent. I suppose I can
> also convert that to use the cleanups. I'll have to add another local
> ptr to do that though.
>
> >
> > Similar comments in other places. Since both kfree() and of_put() can
> > both handle NULL pointers, I'd be surprised if we HAVE to combine
> > these lines.
>
> https://lore.kernel.org/all/CAHk-=3DwgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPt=
uESs1JyA@mail.gmail.com/

Review-by without reservations.

-Saravana

