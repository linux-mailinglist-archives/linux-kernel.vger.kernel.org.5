Return-Path: <linux-kernel+bounces-29477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F08830F09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 743CAB23047
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D852868D;
	Wed, 17 Jan 2024 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MjzhssxY"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C325630
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705529009; cv=none; b=XiAGyR7YM7oY8zDf080RcHvH5EnUsyZU1xsMukBrn3Xl8gSiu9atqek/5en2N9grfGdA08ZtS2o44dED+uni2zq83BqGLRcRDUMtgznO9RSyqE1FOUrKvvNWUZIiP2ilfxe60OYy+AtyEHzd2bwK44rdQj7aHj+zpuZjFppb/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705529009; c=relaxed/simple;
	bh=PBN9pShU3zJZmqNMeStewdxxNrSIe59k0AmnJyQviTQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=W9ko0K8/bUao18PCrn0AbqTEzWROJhguk+3FymlM0yYjfFas7VB2hscauMj0y+LElufPGlsUgEgOrWDSN+JDNsJ/kuHv4ModfC06WTKyYrAeu0+/h7/p+SNhrI/Xvb8BU8xZYpi8XjCGTyznaLhUU0zIWv16CRm/HJoISP6oPQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MjzhssxY; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so1393288276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1705529006; x=1706133806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0hQzkD2lll8u98rfbgNcSgwEggBLH7G8sSLxtHhjXs=;
        b=MjzhssxY3w6/AoyobA3dKUOVqGEP0FgD7CwbzJm+BzaCa3eBr5J7ZYJWNxwmMCJLtX
         BZ/uHQw/nW9P7Nb8BOpoA4U1ZBBB0KZpM80DcxB50RiAKF5zzxOyuxLkwd40SZ6ZPW0N
         IN5z8cIkzFf21FOb1ZvaDDP/cV9YCoM2KYw+WCFpiqn56lef8JTkXs1UogOW1x8PL0iA
         myi5ylvK0ssrDAwoOz/WiFQkmVTHbYb/XAvgw/fgBe1uh/VGOR8WabOkiIj+jgEem3aG
         9OxPWKow6NF3FVITBW71rtdqZ2xmIIpln6v5bCcKTsHv6UL/f3gjMq3pTuxtXQpve6hF
         XBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705529006; x=1706133806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0hQzkD2lll8u98rfbgNcSgwEggBLH7G8sSLxtHhjXs=;
        b=Q1OsRgt1Uz20Jj2a3gp2WxWDwM+eLy6TIKW1hceOGrF96RiI/m8e4x44UV5UN4D4Zq
         LCZY3JC2hR3o4AzkVkoQN1NkMn1cNnFP60yMPMtsUTPHSjEGpLfr679bouCArt0Bndnr
         uU0AH82YdCo5fLaK0gjvAtPWzmzfUqGnRfPnsayPOmanxWScnp41pFvNeBPSvPreSr3D
         uKoCa7P4BuJUShElZpPClmFhGQ2B63siuBe+JVWE7ZrHoLEcAQ/ifVZlLU5dsF4HVO7B
         sIuezj9efSX3C5A3swRnyoMrXS/yMtcYss1XSosMMOkm7AYr6P32pybHDxVe3IhD+6h6
         RB7Q==
X-Gm-Message-State: AOJu0YzCoPuhYT+0hd4+HAAtfklzQbWW63MG0IMvp7g6FcZaDIHux4Zw
	qOefq5u6TcYDmO4JUdnuaRvBHFe46pudP/7X5qVJ8l9KrJiJH1aiZKrCEhQ=
X-Google-Smtp-Source: AGHT+IHzhrY54HAom8TxcDBRSBAwDXqJzbxfS+G2gUXnllGB25H71yyUawiYc+qi2R6N99FR5nRNs8enpOHbgO0zsmQ=
X-Received: by 2002:a25:ce8e:0:b0:dc2:3c18:7ff1 with SMTP id
 x136-20020a25ce8e000000b00dc23c187ff1mr1524558ybe.112.1705529005268; Wed, 17
 Jan 2024 14:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117014541.8887-1-yaolu@kylinos.cn> <CAHC9VhSs6bxXFCAhw7i5cN=iZtuG3-E8xDBRjyGsop=BrhbmSw@mail.gmail.com>
 <202401171236.5175FA9FA9@keescook>
In-Reply-To: <202401171236.5175FA9FA9@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 17 Jan 2024 17:03:14 -0500
Message-ID: <CAHC9VhR+d70b6QfAdtoch-M5cttM63KpMcKG-tfv5PZB9=bnSg@mail.gmail.com>
Subject: Re: [PATCH] lsm: Resolve compiling 'security.c' error
To: Kees Cook <keescook@chromium.org>
Cc: Lu Yao <yaolu@kylinos.cn>, linux-hardening@vger.kernel.org, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 3:51=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Wed, Jan 17, 2024 at 09:32:33AM -0500, Paul Moore wrote:
> > On Tue, Jan 16, 2024 at 8:46=E2=80=AFPM Lu Yao <yaolu@kylinos.cn> wrote=
:
> > >
> > > The following error log is displayed during the current compilation
> > >   > 'security/security.c:810:2: error: =E2=80=98memcpy=E2=80=99 offse=
t 32 is
> > >   > out of the bounds [0, 0] [-Werror=3Darray-bounds]'
> > >
> > > GCC version is '10.3.0 (Ubuntu 10.3.0-1ubuntu1~18.04~1)'
>
> As an aside, Ubuntu 18.04 went out of support back in June 2023, and
> never officially supported gcc 10:
> https://launchpad.net/ubuntu/+source/gcc-10
>
> That said, I still see this error with gcc 10.5 on supported Ubuntu
> releases. I'm surprised this is the first time I've seen this error!
>
> > >
> > > Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> > > ---
> > >  security/security.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > I'm adding the linux-hardening folks to the to To: line as this has
> > now come up multiple times and my best guess is that this is an issue
> > with the struct_size() macro, compiler annotations, or something
> > similar and I suspect they are the experts in that area.  My
> > understanding is that using the struct_size() macro is preferable to
> > open coding the math, as this patch does, but if we have to do
> > something like this to silence the warnings, that's okay with me.
> >
> > So linux-hardening folks, what do you say?
>
> This is a GCC bug -- it thinks nctx_len could be 0, so it gets mad about
> the array bounds.

Ah ha, thanks for that.

> > > diff --git a/security/security.c b/security/security.c
> > > index 0144a98d3712..37168f6bee25 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -792,7 +792,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx=
, size_t *uctx_len,
> > >         size_t nctx_len;
> > >         int rc =3D 0;
> > >
> > > -       nctx_len =3D ALIGN(struct_size(nctx, ctx, val_len), sizeof(vo=
id *));
> > > +       nctx_len =3D ALIGN(sizeof(struct lsm_ctx) + val_len, sizeof(v=
oid *));
> > >         if (nctx_len > *uctx_len) {
> > >                 rc =3D -E2BIG;
> > >                 goto out;
>
> Please don't do this -- it regresses the efforts to make sure we can
> never wrap the math on here.

I didn't want to apply that change, hence my To/CC to you guys.  If
there was no other option to silence the warning then we would
probably have to do it, but it looks like we have options.

> We need to pick one of these two diffs
> instead. The first disables -Warray-bounds for GCC 10.* also (since we
> keep having false positives). The latter silences this 1 particular
> case by explicitly checking nctx_len for 0:
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 8d4e836e1b6b..af4833430aca 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -874,7 +874,7 @@ config GCC11_NO_ARRAY_BOUNDS
>
>  config CC_NO_ARRAY_BOUNDS
>         bool
> -       default y if CC_IS_GCC && GCC_VERSION >=3D 110000 && GCC11_NO_ARR=
AY_BOUNDS
> +       default y if CC_IS_GCC && GCC_VERSION >=3D 100000 && GCC11_NO_ARR=
AY_BOUNDS
>
>  # Currently, disable -Wstringop-overflow for GCC 11, globally.
>  config GCC11_NO_STRINGOP_OVERFLOW

It sounds like lsm_fill_user_ctx() is not the only one having problems
with GCC v10 so I'm guessing you're going to submit a patch like the
above up to Linus?  I think that's preferable to adding extra checks
we don't really need just to silence a buggy compiler.

> diff --git a/security/security.c b/security/security.c
> index 0144a98d3712..ab403136958f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -793,7 +793,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, si=
ze_t *uctx_len,
>         int rc =3D 0;
>
>         nctx_len =3D ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *=
));
> -       if (nctx_len > *uctx_len) {
> +       if (nctx_len =3D=3D 0 || nctx_len > *uctx_len) {
>                 rc =3D -E2BIG;
>                 goto out;
>         }
>
> --
> Kees Cook

--=20
paul-moore.com

