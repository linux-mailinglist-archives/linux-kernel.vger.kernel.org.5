Return-Path: <linux-kernel+bounces-135894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1EF89CCC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D802F1C213C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD8014659B;
	Mon,  8 Apr 2024 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiqYlKfN"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E71272C4;
	Mon,  8 Apr 2024 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606758; cv=none; b=PaJQqs14WDRHn3BHOXV/03lo/wyjRMfM+GwwiT6AQX8K/00uCY2o5NazP+4/7ba4HwCrAMU7mEBrNJlPx3VlCFCm1anTbLSlwFt+UXCFLDMvrWX27ipTOcV9K3Vsd6TzKysFLyYSHMyNNQ3hIuOyOyaYOyv5Fcqh39W8kRjfl5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606758; c=relaxed/simple;
	bh=pVXHma8GB5nPGZYYofUMQJ8v7dv/BJbF1EuZWYwNEPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPjxWrkr9W/TYJPdrtTmFnVmBttZ7m4FUHzjPTKkgaoYnNmuiFbpWCoHeki2qV9xxad5pKQJbATyQiPIbfVfFEU/2WW9/owzIZlzB8f36OOXa/1cEYApl+Yzk38MMysTcYOByivPejJq9qxS73cZssIWPDCPE1dTwlvxsQkGSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiqYlKfN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a5215314a4so872510a91.0;
        Mon, 08 Apr 2024 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712606756; x=1713211556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUqdZE6kzzC+YTBzuDMEGCl6gVl6Zy5qnlm5WmWCMEw=;
        b=YiqYlKfN5gKogfswbEB69LAS+nAfr3smmNRHSuwvcP1EAFDrzCEc218AsCXrAg4mgC
         y9JYfjHeEYRNNpFATqNZD61TrVQdEFMnGIKjrOI8QfDTYBVycxnO7haoYX64sZr3kLJR
         4mgb0h7mgDrsPdxXKp2ok18oWuT3flGrg7F1whnOhW+qRx406CnRdKc2+wTVW7WM4iiI
         U6v2N7pspF5EsCMy0z3l9EHWkYx0cIwLAKhiNb1CYwvvXuIwpBHANN1bUq02FY/JxW0g
         FuajHVGUWJ8GIgBH3aa2PCPiGrH1Lf6zQtB8AIUz5DW78u9ix8b4CD9o3OXVU/qCemWM
         lu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712606756; x=1713211556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUqdZE6kzzC+YTBzuDMEGCl6gVl6Zy5qnlm5WmWCMEw=;
        b=UgKDaF8TEKULg7wUExm+zTL8fScyeZNIZNeCaJ9HWgbfiWE3/dLSowafAlR4jgjCUR
         ekUlkgatIRma/ku5nldUFqf829bFiDpwDuc3ouhNl7HTLnLGVjMIlNvxxwech5gN5pMa
         KX52QqOrt80ahcQ5p+0AtvrbJbe4n2UKLHNwwjfEadYuy89X1fBO/23LCs2mhT3dLgWH
         8hktvj+2LUTnwC97AR9LGllCHz36d7rMAd8LFTN1Rcq+wde1wpRsj3XMbBBu44PJXSuk
         o7y0V5hGs3oN2Cg/h/J3ZO5DTwnnWikUYW3xGGSAxhTjlPfP70B7tXe4RIHTiOexiCLi
         CJjg==
X-Forwarded-Encrypted: i=1; AJvYcCWFEzrrIymN3+d3qgeN9fbl5vVMKcR+bUardhrj1YbJ3TN2HHJt4AvE4z5TnkTinsw98dLEb/RkJWMmVa6Da9gqd4OvN3/Q1fIAkyQ+U2vQLJgqDYXeca1tKLKARD3ktYJYs7dj0Z91yuz5UbXF
X-Gm-Message-State: AOJu0YxnJizXv9SNRcMbZIKIXfpC8dL8jYbb85i/eBKZk+ST6FunVtMK
	DcKEfRDonN02OKkGWyC8XMgyfERr6xGtLj0JO8PiOUKHXJ2JWn70yP//oHLCPDLj8lmqZ4xHHaz
	TnfYf3h+7enGwx8vp8A+VByRu6Gk=
X-Google-Smtp-Source: AGHT+IFAsAW5Q31/Vc72tX8MYJxjAXGXGJkMw6FDJT5agkQzF72ip3OaPkCp8oywDbR6fsOAlW6JqIPz8LjboQowH2U=
X-Received: by 2002:a17:90a:a38a:b0:2a2:7693:399e with SMTP id
 x10-20020a17090aa38a00b002a27693399emr7380737pjp.4.1712606755689; Mon, 08 Apr
 2024 13:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8PR02MB723799AFF24E7524364F66708B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <c2182ac1-368c-441b-b6ed-b5d15a8f9f38@amd.com>
In-Reply-To: <c2182ac1-368c-441b-b6ed-b5d15a8f9f38@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Apr 2024 16:05:43 -0400
Message-ID: <CADnq5_OsJ+VxY9z_iqOscvWAoRqK2hZ0thUOHtBzhfo3De4EoA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon/radeon_display: Decrease the size of
 allocated memory
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Erick Archer <erick.archer@outlook.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <keescook@chromium.org>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 8:35=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Am 30.03.24 um 17:34 schrieb Erick Archer:
> > This is an effort to get rid of all multiplications from allocation
> > functions in order to prevent integer overflows [1] [2].
> >
> > In this case, the memory allocated to store RADEONFB_CONN_LIMIT pointer=
s
> > to "drm_connector" structures can be avoided. This is because this
> > memory area is never accessed.
> >
> > Also, in the kzalloc function, it is preferred to use sizeof(*pointer)
> > instead of sizeof(type) due to the type of the variable can change and
> > one needs not change the former (unlike the latter).
> >
> > At the same time take advantage to remove the "#if 0" block, the code
> > where the removed memory area was accessed, and the RADEONFB_CONN_LIMIT
> > constant due to now is never used.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#op=
en-coded-arithmetic-in-allocator-arguments [1]
> > Link: https://github.com/KSPP/linux/issues/160 [2]
> > Signed-off-by: Erick Archer <erick.archer@outlook.com>
>
> Well in general we don't do any new feature development any more for the
> radeon driver.
>
> But this cleanup looks so straight forward that the risk of breaking
> something is probably very low.
>
> Acked-by from my side, but Alex should probably take a look as well.

I can't remember why that was done that way.  Maybe some leftover from
the early KMS days before we finalized the fbdev interactions?
Anyway, patch applied.  Thanks.

Alex

>
> Regards,
> Christian.
>
> > ---
> > Changes in v2:
> > - Rebase against linux-next.
> >
> > Previous versions:
> > v1 -> https://lore.kernel.org/linux-hardening/20240222180431.7451-1-eri=
ck.archer@gmx.com/
> >
> > Hi everyone,
> >
> > Any comments would be greatly appreciated. The first version was
> > not commented.
> >
> > Thanks,
> > Erick
> > ---
> >   drivers/gpu/drm/radeon/radeon.h         | 1 -
> >   drivers/gpu/drm/radeon/radeon_display.c | 8 +-------
> >   2 files changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/r=
adeon.h
> > index 3e5ff17e3caf..0999c8eaae94 100644
> > --- a/drivers/gpu/drm/radeon/radeon.h
> > +++ b/drivers/gpu/drm/radeon/radeon.h
> > @@ -132,7 +132,6 @@ extern int radeon_cik_support;
> >   /* RADEON_IB_POOL_SIZE must be a power of 2 */
> >   #define RADEON_IB_POOL_SIZE                 16
> >   #define RADEON_DEBUGFS_MAX_COMPONENTS               32
> > -#define RADEONFB_CONN_LIMIT                  4
> >   #define RADEON_BIOS_NUM_SCRATCH                     8
> >
> >   /* internal ring indices */
> > diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/=
radeon/radeon_display.c
> > index efd18c8d84c8..5f1d24d3120c 100644
> > --- a/drivers/gpu/drm/radeon/radeon_display.c
> > +++ b/drivers/gpu/drm/radeon/radeon_display.c
> > @@ -683,7 +683,7 @@ static void radeon_crtc_init(struct drm_device *dev=
, int index)
> >       struct radeon_device *rdev =3D dev->dev_private;
> >       struct radeon_crtc *radeon_crtc;
> >
> > -     radeon_crtc =3D kzalloc(sizeof(struct radeon_crtc) + (RADEONFB_CO=
NN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
> > +     radeon_crtc =3D kzalloc(sizeof(*radeon_crtc), GFP_KERNEL);
> >       if (radeon_crtc =3D=3D NULL)
> >               return;
> >
> > @@ -709,12 +709,6 @@ static void radeon_crtc_init(struct drm_device *de=
v, int index)
> >       dev->mode_config.cursor_width =3D radeon_crtc->max_cursor_width;
> >       dev->mode_config.cursor_height =3D radeon_crtc->max_cursor_height=
;
> >
> > -#if 0
> > -     radeon_crtc->mode_set.crtc =3D &radeon_crtc->base;
> > -     radeon_crtc->mode_set.connectors =3D (struct drm_connector **)(ra=
deon_crtc + 1);
> > -     radeon_crtc->mode_set.num_connectors =3D 0;
> > -#endif
> > -
> >       if (rdev->is_atom_bios && (ASIC_IS_AVIVO(rdev) || radeon_r4xx_ato=
m))
> >               radeon_atombios_init_crtc(dev, radeon_crtc);
> >       else
>

