Return-Path: <linux-kernel+bounces-84868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7446886ACD6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EB5283986
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80D212CD89;
	Wed, 28 Feb 2024 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjOLh3Oo"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038112FF98
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119218; cv=none; b=UNkzihs/OxvMP8Z6EJjN2mCzxIZzZBBK3PRpxQFHY27KiG9ef5Xb43JMooRWfj2PALdA/mA6vUGuz2aux/lhuOtI0joIEiTmyd/XiAU3SVYzyNf0pziJvdyVinUATOJU5/3efAT4lfvupr70piNpCsWXCzQI1lOFuaH06MG8yZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119218; c=relaxed/simple;
	bh=+nPljukr79/k+aBoFw1zKq3c7bPlfzNhe25zdAfdkf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ow/6SvVqD/VRG3jzd0ZIsJ798EctJE+++wJ0BRLnByWLdGCnE9n7xWSU4tJoJus+83k9C20P2WgNfuP/xCYFTD/aLd3TatXW7BHVVcC3aA+dMZRQ3yDI1clVwUgqYE5iHDxJrcGFUVjyZdfc1oOdmIVtQA4huNFPA0+viwRGNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sjOLh3Oo; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-472751180f6so27488137.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709119215; x=1709724015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cz56F1rJBplYFoLx/g3BveNwqzw9wyCIbG8M8QMxDrI=;
        b=sjOLh3OoTvyE5A/QuR+/am1mG2gY9wsoDZUGmuC3YxyMOcYzndCorjrItiBXrFC++H
         D7LRGdeOANvM1SbfQEQYTbBc8hhHvflg60OaBc6nkQpFr8g6I7eQ4aUSzYPGAhUkd0Mo
         a3JeBkZLCXed9p0vOiQ1I4Vb/ChyEUarCMp9dRZ7pm1KrQpr8juq5fyXxi8K0lSq0wd2
         EN6w5yK2dZ09+hljkY5iPfpSQ9zob6VCvFlF0R6rEqz5GxmWLH8xIN6lXB9m9ZMc4Et+
         rtDb5V0gc4r/cTme6sKXrgNEOnj11rmjTUo60KOjvt6YmZ7q638sgpBZPn0amXIZfVoq
         4CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709119215; x=1709724015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cz56F1rJBplYFoLx/g3BveNwqzw9wyCIbG8M8QMxDrI=;
        b=v0PbeSag5hCq4nRjXupqd12g/2OzcU1EQ1w6d8Qk/VRkAnZZajlaP0IJt2/HAKBydB
         hxTfJZL6eo4L11zO0tF2EkWSCmOSJj1VB7DV+DJNmywggNVh2uUlPTU71MvWzfPJKq5q
         xPJT5NDJoSXgbyfxgysOqeGmcf3mBIr8xNAkhXu9aIqG4LpxZrhgT2GAPNnDA5+jQPr2
         f2ewk6ESnMt//g0m4zM88LqEa/844u0Lm4VxyPCSOSLS2dEZRF1A0vuDn45MbcpfcHak
         Cbm43G26DQqVMwfQmwZuhmGgkfB0nf4tN1gZqcIGKb6FnJeMY1+q9inKH985QEXdUwA4
         hybg==
X-Forwarded-Encrypted: i=1; AJvYcCXY0L5kcr3DsGYc+DGXERO7z3y0mAcwlWmLEajyuaa7bXQ+cXkcuffA9rxh4rvIr8qWzzMcAQPdOeGlxkKjPmQ6lVWairRC1U8YwEpX
X-Gm-Message-State: AOJu0Yxq1qB3Y0Wn2bzqB81Wnbu11YB2CzL2rOk7dRAjmgyVxLnXrKzh
	Sl7d4bnGKNCB2QgVsAhIpdYAjOfwSd20m3GifJ0zhblJZiSd1LzyxkfCTf/pSMtQUwio+vBWEvJ
	8wyDUKX39yPCsF0II2ZkIPSIX9YnHCJ1C6UuIjw==
X-Google-Smtp-Source: AGHT+IGjLYsLmcXmODaXN692Ax33B+2DO8wWUZO+yRjb3+yUlIx33TwTXTshNhd1Z1IG7aczIPXUNgyD6o94ZePaL0k=
X-Received: by 2002:a05:6102:30b6:b0:472:6e23:1f3d with SMTP id
 y22-20020a05610230b600b004726e231f3dmr1143660vsd.1.1709119213982; Wed, 28 Feb
 2024 03:20:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223095133.109046-1-balint.dobszay@arm.com>
 <20240223095133.109046-2-balint.dobszay@arm.com> <CAFA6WYNW9-7gCZQSEaV=Gcr+GLdu25rQ8MpTg9yNpX7OwyZ0Tg@mail.gmail.com>
 <CAHUa44G70L9CnQD6V3ivWf1hYfK0iWFt-cfg98-JGB-s8TVd-A@mail.gmail.com>
 <CAFA6WYOq3tHq5n7=XYpsSgBghCF0RtAxs-sLxvLYMWwnQuFSeQ@mail.gmail.com> <CAHUa44F=0juXyyhA7Bu0SzCK+1igRYEWCn1XRL1sDG1ZWNhr3g@mail.gmail.com>
In-Reply-To: <CAHUa44F=0juXyyhA7Bu0SzCK+1igRYEWCn1XRL1sDG1ZWNhr3g@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 28 Feb 2024 16:50:02 +0530
Message-ID: <CAFA6WYOWQZqtAcdCKcBa7qnCY1ueBzU1_1HSbfHPaLeyPdtxbw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tee: optee: Move pool_op helper functions
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Balint Dobszay <balint.dobszay@arm.com>, op-tee@lists.trustedfirmware.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, corbet@lwn.net, sudeep.holla@arm.com, 
	rdunlap@infradead.org, krzk@kernel.org, gyorgy.szing@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Feb 2024 at 14:11, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Wed, Feb 28, 2024 at 6:58=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Tue, 27 Feb 2024 at 21:20, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > On Tue, Feb 27, 2024 at 7:06=E2=80=AFAM Sumit Garg <sumit.garg@linaro=
org> wrote:
> [snip]
> > > > > --- a/include/linux/tee_drv.h
> > > > > +++ b/include/linux/tee_drv.h
> > > > > @@ -275,6 +275,17 @@ void *tee_get_drvdata(struct tee_device *tee=
dev);
> > > > >  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, =
size_t size);
> > > > >  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx=
, size_t size);
> > > > >
> > > > > +int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, stru=
ct tee_shm *shm,
> > > > > +                                size_t size, size_t align,
> > > > > +                                int (*shm_register)(struct tee_c=
ontext *ctx,
> > > > > +                                                    struct tee_s=
hm *shm,
> > > > > +                                                    struct page =
**pages,
> > > > > +                                                    size_t num_p=
ages,
> > > > > +                                                    unsigned lon=
g start));
> > > > > +void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, stru=
ct tee_shm *shm,
> > > > > +                                int (*shm_unregister)(struct tee=
_context *ctx,
> > > > > +                                                      struct tee=
_shm *shm));
> > > > > +
> > > >
> > > > These rather belong to drivers/tee/tee_private.h as we shouldn't
> > > > expose them to other kernel client drivers.
> > >
> > > This is the right place, this .h file is for TEE drivers too.
> > >
> >
> > But this is shared with other kernel TEE client drivers and we
> > shouldn't expose internal APIs which aren't meant for them with a side
> > effect of API abuse too. Any particular reason to not use
> > drivers/tee/tee_private.h?
>
> drivers/tee/tee_private.h is supposed to be used internally by only
> the files in drivers/tee.

How about "struct tee_device" being in drivers/tee/tee_private.h?

> If you look in include/linux/tee_drv.h
> you'll find a few functions and other definitions that a kernel TEE
> client driver should not use, for instance, tee_device_register() and
> tee_device_unregister(). This kernel TEE client interface was
> introduced with commit 25559c22cef8 ("tee: add kernel internal client
> interface"). include/linux/tee_drv.h existed before we even had any
> kernel TEE client interface.

Anyhow, it looks like there is a chance for refactoring here. How
about splitting this header further in something like
include/linux/tee_core.h which will contain all the pieces relevant to
TEE drivers?

BTW, this patch series can keep using include/linux/tee_drv.h for the
time being.

-Sumit

>
> Cheers,
> Jens

