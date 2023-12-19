Return-Path: <linux-kernel+bounces-5560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6252D818C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C342849D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0FA1F94D;
	Tue, 19 Dec 2023 16:30:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BEA1F61F;
	Tue, 19 Dec 2023 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-593f182f263so98879eaf.0;
        Tue, 19 Dec 2023 08:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703003412; x=1703608212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+nXGZ4WeIHnK2XE30unq/qDzfMFlqizs0CUMRrlF3c=;
        b=ZDJSDpJL0YQEbInPUXkoFVae1mGMxZfME1oQPE46GuLOrGZUQ8piadam0tn78yo3ND
         MYuKx/yz6aOM3YokJdbFgpwZ8eYE4FLwbWzQ6p5uEPr3+vEE+nmcwqJm4jgIwCObphbV
         wLGE0e7yee9tdftOpEflGNBv9gn1zZ+YpvddQsVL2cz0LXNctYBHGzhbEGZRMNHJi+2p
         Acpl13hv5U2JpsUL07CQM3NgvKOCjL4KSasqfX6UV4xx9EG6MuLUVQ8RAb+W0lIj/R85
         qyV850NcrxYddZP2END2ylB5tyPaCt3Lb0u9JxdHndMfCxYh3WqoXqKccZPqnamjidFT
         Wwew==
X-Gm-Message-State: AOJu0YxWHkr0q67BiGC3LLNOdIQMwiauTSNyKiBUlNLexsD/XbYECAi4
	F2EOVDgbxOMY/q3Mlvl70Dx7z1Ay0B2xd+DpAGU=
X-Google-Smtp-Source: AGHT+IGCcu1hyxmj8XnSccAScP5oqN5dUluYAX9W1tGMGB9589pmbO/sXkRTIM1WwxoBb7YqVBoVmBJ+Pid3j1wUZQ4=
X-Received: by 2002:a05:6820:2d44:b0:58d:be0d:6f7b with SMTP id
 dz4-20020a0568202d4400b0058dbe0d6f7bmr29168905oob.1.1703003412038; Tue, 19
 Dec 2023 08:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219031444.91752-1-bo.ye@mediatek.com> <e807b180b074419ba4f1d1ff8a4c1a80@AcuMS.aculab.com>
In-Reply-To: <e807b180b074419ba4f1d1ff8a4c1a80@AcuMS.aculab.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Dec 2023 17:30:00 +0100
Message-ID: <CAJZ5v0gLDZtfGhowxSM+nwBCM80y6sDR56fYZrHNGaRFK1oGyw@mail.gmail.com>
Subject: Re: [PATCH v2] fix overflow in idle exit_latency
To: David Laight <David.Laight@aculab.com>
Cc: Bo Ye <bo.ye@mediatek.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"yongdong.zhang@mediatek.com" <yongdong.zhang@mediatek.com>, C Cheng <C.Cheng@mediatek.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 5:24=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Bo Ye
> > Sent: 19 December 2023 03:15
> >
> > From: C Cheng <C.Cheng@mediatek.com>
> >
> > In detail:
> >
> > In C language, when you perform a multiplication operation, if
> > both operands are of int type, the multiplication operation is
> > performed on the int type, and then the result is converted to
> > the target type. This means that if the product of int type
> > multiplication exceeds the range that int type can represent,
> >  an overflow will occur even if you store the result in a
> > variable of int64_t type.
> >
> > For a multiplication of two int values, it is better to use
> > mul_u32_u32() rather than s->exit_latency_ns =3D s->exit_latency *
> > NSEC_PER_USEC to avoid potential overflow happenning.
> >
> > Signed-off-by: C Cheng <C.Cheng@mediatek.com>
> > Signed-off-by: Bo Ye <bo.ye@mediatek.com>
> > ---
> > Change in v2:
> > -remove Change-ID
> > -correct patch author name
> > -replace multiplication of two int values with mul_u32_u32
> > -refine commit message
> > ---
> >  drivers/cpuidle/driver.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> > index d9cda7f6ccb9..cf5873cc45dc 100644
> > --- a/drivers/cpuidle/driver.c
> > +++ b/drivers/cpuidle/driver.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/cpumask.h>
> >  #include <linux/tick.h>
> >  #include <linux/cpu.h>
> > +#include <linux/math64.h>
> >
> >  #include "cpuidle.h"
> >
> > @@ -187,7 +188,7 @@ static void __cpuidle_driver_init(struct cpuidle_dr=
iver *drv)
> >                       s->target_residency =3D div_u64(s->target_residen=
cy_ns, NSEC_PER_USEC);
> >
> >               if (s->exit_latency > 0)
> > -                     s->exit_latency_ns =3D s->exit_latency * NSEC_PER=
_USEC;
> > +                     s->exit_latency_ns =3D mul_u32_u32(s->exit_latenc=
y, NSEC_PER_USEC);
>
> Just force either side of the multiply to a 64bit unsigned type.
> The compiler will then DTRT which is likely to be better code than
> whatever mul_u32_u32() generates.

So why is it there?

The default implementation of mul_u32_u32() is to cast its first
argument to u64 before the multiplication AFAICS.

> In any case is the 'exit_latency' ever going to be greater than 4 seconds=
?
> In which case the 32bit multiply will never overflow.

So this is more of a theoretical thing found by some static analysis
tool or similar.

> >               else if (s->exit_latency_ns < 0)
> >                       s->exit_latency_ns =3D  0;
> >               else
> > --

