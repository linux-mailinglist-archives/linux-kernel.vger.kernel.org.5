Return-Path: <linux-kernel+bounces-133513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6643089A4B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A4B1C20D65
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672C7172BB0;
	Fri,  5 Apr 2024 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2UlCSDoz"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BFD17276C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344399; cv=none; b=sPVtJ02XJ6vCfJiNCn+J5boWHg8TgkIxwyTcSTtQsaUuvs+LXA8RlF32vd3D2TpkBrMPg6QYVwxdHELO6NGhs+kjYP/BHHJtzv8EOkUKxrz7xlZHvhHf4h0gzpKbtWDfDEz2h9PeuOf+hXIyMFpwyYb+uTC7eGkAHb8dnUpH07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344399; c=relaxed/simple;
	bh=tQzOvHwoLiw8NG9JFXA4dymZzAKwe0NEj/YFfCcxuXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtNera9A3K3aio2h4JcQHJ3G1YTatnuXlv6+7xjbkrHmq36lcg5ryD++iI9ZxihQKzm5+dGNjxmsiKWaUpfi0JlFGu+eD9IKVHBboC9qbUB5MqAlUDMKKXqVpHQkccnSPEIYZCUUv7y5vHye5cSGKKeyy1cs2NPgpNQV93eltTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2UlCSDoz; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-430d3fcc511so45381cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712344397; x=1712949197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OftswQMoXlzPzi1h0xRfVUEMp13ATiDevvRviGfB5Y=;
        b=2UlCSDoztHB5zMRJMZE07Q0vASMjO8bHjr5txXxQjmhTKTFaF4BCNqHad2edGsYA1i
         o1eGGXB9ybDAt9RsdpCuRnM9tg3QQoJik5tGxBES7Eeh1vAV1QUja/493Hff8xxcuOPD
         hCquTcoDRhGn9z6hOqMVu7T49nUHTz7fdB9H7baBd0znogANbQ46c2Y16jgKP0s9/G2U
         +zjdkyVZfPMA9cuX0Y2hVAbJsILHjt3Uphyig0p7vYp2VA0W1hbJKPGLgKJfNEBTGH6w
         BcXKeLMvpSWP7+4ioN9DydKDzq2e+hb+3/QN2zHIrNJwXwFEZs0XVieHVDncqps/MyAH
         9inQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712344397; x=1712949197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OftswQMoXlzPzi1h0xRfVUEMp13ATiDevvRviGfB5Y=;
        b=ZmJNcMAP2zrFRQyl8jCyAkAMfD6S1afVCI5dc3tcrobrOABHiTBZz90TJ8vZPKcIcD
         IIMjNNpCKlIG4aG7+BZoXyehzkC12/5Vvq0KF73r9QrQgfvMvSvpugQLi5xrP8PTiv2D
         Be/MKEt9cj7P4AbP1HKT9n5qEySFqyNOgpkOLpwkMKtfP3FiohHI96ELXcakeIwyocV4
         +4gPx3qyhYxKlKIWfU9WA9tplrR1wwJpbzFtXLs8uRSjZ7+b2+hIIGZz5Dw6Y3bfAQLH
         gGplY1VzjbnH2GFvkp9BJ+rOX1BaXZsBqA2CxED9UcwsmCQSvcC+RAvTDcC3uMIIngMA
         yajg==
X-Forwarded-Encrypted: i=1; AJvYcCWvoJY7rvoTl0FkaeWZVkoWAzvZzOzltEqbfOhK66ssDb2kgFy16t2veaNK/i6wIEzD1VNYcsoX0WRVSSZ2r3h4TpzkjTld39AivRDG
X-Gm-Message-State: AOJu0Ywi5aPliOtwhbBu1edqGRiN7u3AbWFA2BTch27N7nrVYVhauEY/
	XKH6IzyDUqy5Ky0gjq6m5cZMLyMOY8gCmxQ/3CyqUNGUrEefE9TWrepjMO94rFPBb+s7LObJcdB
	SHIHfih857rIL7soIgZnP5xfWaZToIXEoIsiM8KMTR4nZg5E1bw==
X-Google-Smtp-Source: AGHT+IH8WeFQmIBnqF3kk7HSdzipYkzVWr6W6eJGep2NRZrPGtdySGG5hiVW20qol2huoFXfd13SPpBYkBqOwCtftyg=
X-Received: by 2002:a05:622a:1e87:b0:431:30e4:f2f0 with SMTP id
 bz7-20020a05622a1e8700b0043130e4f2f0mr25017qtb.7.1712344396942; Fri, 05 Apr
 2024 12:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org>
 <20240404-dt-cleanup-free-v1-2-c60e6cba8da9@kernel.org> <CAGETcx_H_vvK9y-51JTcz8F7GDThBwC+t=k2i6r4Nst3H6-TUg@mail.gmail.com>
 <CAL_Jsq+eS3uS1rEPSErMnfJhPBoQjh7UyRLa9NZ59WBVcD+JWw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+eS3uS1rEPSErMnfJhPBoQjh7UyRLa9NZ59WBVcD+JWw@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 5 Apr 2024 12:12:38 -0700
Message-ID: <CAGETcx9-6KCLJh0gYQwxV5cAJLvgo1fpwzuxH51AHVLkDS0w_g@mail.gmail.com>
Subject: Re: [PATCH 2/3] of: Use scope based kfree() cleanups
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 5:44=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Apr 4, 2024 at 6:16=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
> >
> > On Thu, Apr 4, 2024 at 7:15=E2=80=AFAM Rob Herring <robh@kernel.org> wr=
ote:
> > >
> > > Use the relatively new scope based kfree() cleanup to simplify error
> > > handling. Doing so reduces the chances of memory leaks and simplifies
> > > error paths by avoiding the need for goto statements.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/of/base.c     | 34 ++++++++--------------------------
> > >  drivers/of/dynamic.c  | 11 ++++-------
> > >  drivers/of/resolver.c | 35 +++++++++++++----------------------
> > >  3 files changed, 25 insertions(+), 55 deletions(-)
> > >
> > > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > > index 8856c67c466a..20603d3c9931 100644
> > > --- a/drivers/of/base.c
> > > +++ b/drivers/of/base.c
> > > @@ -16,6 +16,7 @@
> > >
> > >  #define pr_fmt(fmt)    "OF: " fmt
> > >
> > > +#include <linux/cleanup.h>
> > >  #include <linux/console.h>
> > >  #include <linux/ctype.h>
> > >  #include <linux/cpu.h>
> > > @@ -1393,8 +1394,10 @@ int of_parse_phandle_with_args_map(const struc=
t device_node *np,
> > >                                    const char *stem_name,
> > >                                    int index, struct of_phandle_args =
*out_args)
> > >  {
> > > -       char *cells_name, *map_name =3D NULL, *mask_name =3D NULL;
> > > -       char *pass_name =3D NULL;
> > > +       char *cells_name __free(kfree) =3D kasprintf(GFP_KERNEL, "#%s=
-cells", stem_name);
> > > +       char *map_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-ma=
p", stem_name);
> > > +       char *mask_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-m=
ap-mask", stem_name);
> > > +       char *pass_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-m=
ap-pass-thru", stem_name);
> >
> > With the scoped stuff, do these function calls need to be in the same
> > line we are defining these variables? If not, I'd rather that the
> > calls remain where they were. It feels like a lote to visually parse
> > and take in from a readability perspective.
>
> They don't have to be, but if you don't want to get yelled at by the
> chief penguin, then yes, they should be together. See the discussions
> on adding the scoped iterators. But with the C99 adoption, we can move
> the declaration to where the assignment was original.

Thanks for the context and the link in the other email.

Review-by without reservations.

-Saravana

