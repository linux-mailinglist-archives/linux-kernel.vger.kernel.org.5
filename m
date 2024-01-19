Return-Path: <linux-kernel+bounces-30715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8872832375
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABB52865C6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72915A7;
	Fri, 19 Jan 2024 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrLk9fQH"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52A1111
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705632457; cv=none; b=AHFIn/ooCagT8U1LZKjidSAKNqvlRZ4/8o6lV6sTbx4glcCQhU/xmoDricAZMvLUriN80AmKAgJAcoCldHkXZPOUCX3v6VsQPtfBUrcAfRPCcb7xoJFbjxHrwHUb6uHHqPG0gQtzwSuk5jfZY3H4Y7NzWkooRtVb1ShKSFEC9vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705632457; c=relaxed/simple;
	bh=LC2ojcyVvYY18DsgCFhzHooTLnRNiqsKr5V2HXzBzPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CARNOODyU2cpGlpyjy6rkIBn0qJrKXnCaYyO71+JtMVtm3JvldP/o3rjixZ9gQem/MrY6M5ztT8k2eyW0uTXjOOfUYrRsG14WI/rQPlWl464qNtQ2YE0AdbFhyIUHScjIxO4/IDN82prt6rpCcUL16bYn50lK5CnQRLttXKmIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrLk9fQH; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cdc1af60b2so3635931fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705632454; x=1706237254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sd3GlzgGgJSlvg/FmViDsptsjJQ9iDHdHhzYDbLHp3M=;
        b=PrLk9fQHCXcECjgwfGJUmOL17zKZrUhDN5Y4XE0Px14Y2zlsacIoFoQBb1ANItn8yA
         N3EbOgbesx4pABUFpaEMlFZ9k0PDazn/qCmsdZSbbxNAn1cVKckirAAc2bl2mql/V0y0
         EPz9qI6P4bOWcMpe6GPPudPzrPe49otXhHzsgtQMpjaBZfRmkFC+7xtjsY5Tc1zUv8x0
         nDHTtoeXZp6UU5h2b4W7EZnuaFbYIqOBwx6V3ubANYS/gtFEvDgsyrRFW0XPXbx/8s7C
         sQqo+4VfgbaREMwLMsa43vDfv+Vg8jJHFtFOAxYGc7drjCUsUXh5+u2YqW2Y8Ylj3tdO
         xgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705632454; x=1706237254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sd3GlzgGgJSlvg/FmViDsptsjJQ9iDHdHhzYDbLHp3M=;
        b=uqtEun+nHkGQWyrxeZQRcYhJRdklCQoX9F7xLwfQydiT1jT4KcF3zp2qS1Yh+bLIJV
         Fw0QZC/8my08skrhIQaLJQmvqiIw5BO5Ewv+W4BDpaOTCIqjC0t5mP+rOFnx0BkPVLc4
         maaf0qQWrKAtjqlFf4fdkQe9nbMKqU9LMPEM9gP806Yi+rKjptfB+cIRlcVHD5sFO1Ix
         TjlU2otUi2oDB7/Ng3K2T0trTL7AiCLqMB9q6PgT261KgXRQ1QuAw2uOwhogr/jZOKET
         gNN1JfcVbr2TgnWVPdR5tGarIcY4gxtE2We4LEvlh1EHkYUKjiAVrDOqaFQr4p3IsZmg
         Qojg==
X-Gm-Message-State: AOJu0YxIXdBDJaiG3O2Auv8MN8PKu+CghWNlSC/74C5PaVKOMazpLJR/
	5wT8FmO0TsOoMmsxA+JLeeeBGF0eMWeCeibm6A+CcETsfdWQZTWPE0Y8dfTfIPXlJylNiiIoNAt
	ZEFVKdoq0ihyEf48kTABL1EICyOVswxVn6DzFsg==
X-Google-Smtp-Source: AGHT+IHJ2OOWYTIM69OkT1dj/zddfEE8UHpCG3z5tUsKf6gifQfhdC/9L0iSNGBSst5hbB5PUyd8mANhzOFTyTGCFog=
X-Received: by 2002:a2e:bc11:0:b0:2cc:ce6d:5ade with SMTP id
 b17-20020a2ebc11000000b002ccce6d5ademr1319357ljf.84.1705632453818; Thu, 18
 Jan 2024 18:47:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117071328.3811480-1-alexious@zju.edu.cn> <CAKGbVbuEyKaeZbvU-SREQkto5AqdQo-wjx=cjf2Sx3eDCnah+Q@mail.gmail.com>
In-Reply-To: <CAKGbVbuEyKaeZbvU-SREQkto5AqdQo-wjx=cjf2Sx3eDCnah+Q@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Fri, 19 Jan 2024 10:47:21 +0800
Message-ID: <CAKGbVbsp0Bhk3h3D4bkmpLT7HF6KykTJCUcb_JDL=UtJNc-h5A@mail.gmail.com>
Subject: Re: [PATCH] [v2] drm/lima: fix a memleak in lima_heap_alloc
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Vasily Khoruzhick <anarsoul@gmail.com>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

applied to drm-misc-next

On Wed, Jan 17, 2024 at 8:14=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrote:
>
> Reviewed-by: Qiang Yu <yuq825@gmail.com>
>
> On Wed, Jan 17, 2024 at 3:14=E2=80=AFPM Zhipeng Lu <alexious@zju.edu.cn> =
wrote:
> >
> > When lima_vm_map_bo fails, the resources need to be deallocated, or
> > there will be memleaks.
> >
> > Fixes: 6aebc51d7aef ("drm/lima: support heap buffer creation")
> > Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> > ---
> > Changelog:
> >
> > v2: rearrange the error-handling to ladder tags.
> > ---
> >  drivers/gpu/drm/lima/lima_gem.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lim=
a_gem.c
> > index 4f9736e5f929..d3d82ee7fb4c 100644
> > --- a/drivers/gpu/drm/lima/lima_gem.c
> > +++ b/drivers/gpu/drm/lima/lima_gem.c
> > @@ -75,29 +75,36 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima=
_vm *vm)
> >         } else {
> >                 bo->base.sgt =3D kmalloc(sizeof(*bo->base.sgt), GFP_KER=
NEL);
> >                 if (!bo->base.sgt) {
> > -                       sg_free_table(&sgt);
> > -                       return -ENOMEM;
> > +                       ret =3D -ENOMEM;
> > +                       goto err_out0;
> >                 }
> >         }
> >
> >         ret =3D dma_map_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0);
> >         if (ret) {
> > -               sg_free_table(&sgt);
> > -               kfree(bo->base.sgt);
> > -               bo->base.sgt =3D NULL;
> > -               return ret;
> > +               goto err_out1;
> >         }
> >
> >         *bo->base.sgt =3D sgt;
> >
> >         if (vm) {
> >                 ret =3D lima_vm_map_bo(vm, bo, old_size >> PAGE_SHIFT);
> > -               if (ret)
> > -                       return ret;
> > +               if (ret) {
> > +                       goto err_out2;
> > +               }
> >         }
> >
> >         bo->heap_size =3D new_size;
> >         return 0;
> > +
> > +err_out2:
> > +       dma_unmap_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0);
> > +err_out1:
> > +       kfree(bo->base.sgt);
> > +       bo->base.sgt =3D NULL;
> > +err_out0:
> > +       sg_free_table(&sgt);
> > +       return ret;
> >  }
> >
> >  int lima_gem_create_handle(struct drm_device *dev, struct drm_file *fi=
le,
> > --
> > 2.34.1
> >

