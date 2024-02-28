Return-Path: <linux-kernel+bounces-84757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF14486AB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60EE282D37
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D133307B;
	Wed, 28 Feb 2024 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPWc2L+n"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760812D606;
	Wed, 28 Feb 2024 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112174; cv=none; b=WWa+57BUAjgItWWXAfoekbtoq1V8Rl9KWsNJg3VGVqsS3Nx+AuSmEiYZ/a387CGrB0bH3YaSt0DQiLnQeZO6nVI65QmrZGLM81fj0QUZd6l48M5lj1OgTjRM5nKWYqocBzna/Daurm0m6PvYFR3TjRAFrm8SKYjsmaJZ3iEE2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112174; c=relaxed/simple;
	bh=4vqI4Lzirs4MpAABLpUmRcXaZ02VtrcBc6dAJQkIU9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSxk9KuS/A9ojc1lBcuWpV9fbjhaKOOmej1lBwsC3e+SFhLsg7FqrH4Pf4xB7o/dH+XE1kgNVnovUl44YyODmYylaaSq7lkKZQtYLwD32g5S72OF3sPyOBnepHgt+ZygoWnPd/K3UCqXyZ5d/PIHcczkSjb2/X4dYAvUAdA8+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPWc2L+n; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3e85a76fa8so507276666b.1;
        Wed, 28 Feb 2024 01:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709112171; x=1709716971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w94IJo1kay0f/xc+3V75vT4mCcz7+PjX1XmawfCqo0k=;
        b=lPWc2L+nuvB+ysUj0HPGGOAU/qvgWg12MOgadWa8yJvR2t0onDq82cnCLm4+oJX1C3
         7xAD1K3e+IPvDweuBARJrCggyBOugF2S1sjfl/Vx3cb9mW3Qf9H2jsIG/n5yoDYnAcXt
         xBZZ04PLeHYnBqopovI0ZeEjKOc1Q0NcNlRpAtsbh5hd/4R9ADDQ3xsKmoRIq05dIqRt
         XtKg1Bmr3ZdOE5yPOZZEKV7PMOCRMyvqU3HKgXqDt+DGJhdxH+9Vi43aGlQDZfTCJSa6
         OTHWc+7hdUQw86SZKaOk0xHP6BIkF6rtJshFsYYrakuMZnm0exW3FA/iZ3qUFzHAYWlT
         iiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709112171; x=1709716971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w94IJo1kay0f/xc+3V75vT4mCcz7+PjX1XmawfCqo0k=;
        b=MfQXZFDUhHSX2lHPISXG7MxxBogjtLd0YwviP1s56b+1sxCKNcqZKwXk/Rk4uRoReD
         Q/Ed5OmmPuz9gZYSTxQyjQFhS8czwswvQGfiFROK64yMFK2iKyrFizs1IuXXWwHtAknk
         XUX5RT3XZSkuUfebsYyTjMVVjD0QVEwU+N+k4HkTwzQc9Dj/hfzgr3K2QTSVWj9gE8hh
         UAZXoKhdPodq8mcYoFIAjQuH5x1mmTzulWtP8Wz40bXKtXk3K9piJygtBOMMYe8w8CBt
         i8TKeWyA8NIGeJn0k1f1RTUTEuZ9tw14wQ2EDeVTtRl/CGp043paJRN5JPqjJtbNlU2n
         Jp+w==
X-Forwarded-Encrypted: i=1; AJvYcCXoqyCTIIww5i2aKkZuYF4inBN2Om3vYC1IzbZle+6gkXrVYYgRUUcYhh7tmb/1fuXq2vPiA2Ao1nSFr9kow8MyqBq8V79vksfTQjh4w8tgPTzm63yguLx8R9Xm8t7Bk4y4+isGHFyxbFDbwIAwpESM0XXWzM7gMWQAWAE6Rmfi0PDxIETj
X-Gm-Message-State: AOJu0YyaUlMuuTCaHRsq+vEKqy2TuJ7yI6QW4Ybi+FofxwoKeHAQ3B/Q
	W8cniJfKCSwpiwTkDtx83XnkkimtDFL/ISJPiOMFaTHw/tQ7luIQaFphJ2XcKIB6nWTlDMIpt4T
	L7HvKsVSTrrKqmFpEbFuF5VZmmgs=
X-Google-Smtp-Source: AGHT+IHJjODq1VsNvfrzm9ytWJM7dmnIy0B+0j31P5FxvcVxR8iMf8r56oiXY2gOUy0fbeosoKE9yzk8Daa4z6NCrTM=
X-Received: by 2002:a17:906:3c05:b0:a3f:db30:8999 with SMTP id
 h5-20020a1709063c0500b00a3fdb308999mr9409719ejg.4.1709112170579; Wed, 28 Feb
 2024 01:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227013221.21512-1-zhi.mao@mediatek.com> <20240227013221.21512-3-zhi.mao@mediatek.com>
 <CAHp75VciCJuoOwC8ozanWYqSCM=vWpiaqymJ2-gQfrSt5Ts6fQ@mail.gmail.com> <b4889fad324ec88eb3a22f51b0aa512cc93bd2cb.camel@mediatek.com>
In-Reply-To: <b4889fad324ec88eb3a22f51b0aa512cc93bd2cb.camel@mediatek.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2024 11:22:13 +0200
Message-ID: <CAHp75Vd=X9e4rOJabF4AbzGRZAF4BiNJa-C4ivOoQb7kAMy3vQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] media: i2c: Add GC08A3 image sensor driver
To: =?UTF-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
Cc: "heiko@sntech.de" <heiko@sntech.de>, 
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"yunkec@chromium.org" <yunkec@chromium.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>, 
	"gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>, 
	=?UTF-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?= <shengnan.wang@mediatek.com>, 
	"hdegoede@redhat.com" <hdegoede@redhat.com>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	=?UTF-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?= <Yaya.Chang@mediatek.com>, 
	"mchehab@kernel.org" <mchehab@kernel.org>, 
	"jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>, 
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>, 
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	"10572168@qq.com" <10572168@qq.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 5:19=E2=80=AFAM Zhi Mao (=E6=AF=9B=E6=99=BA) <zhi.m=
ao@mediatek.com> wrote:
> On Tue, 2024-02-27 at 14:46 +0200, Andy Shevchenko wrote:
> >  On Tue, Feb 27, 2024 at 3:33=E2=80=AFAM Zhi Mao <zhi.mao@mediatek.com>
> > wrote:

..

> > > +#include <linux/clk.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/regulator/consumer.h>
> > > +#include <linux/units.h>
> >
> > This is a semi-random list of inclusions. Please, follow the IWYU
> > (Include What You Use) principle. *At least* this list misses the
> > following:  array_size.h, bits.h, container_of.h, device.h, err.h,
> > i2c.h, math64.h, module.h, mod_devicetable.h, property.h, types.h.

> After checking these header files, we find:
> 1."container_of.h" is included by "media-entity.h", while "media-
> entity.h" is inculded by "v4l2-subdev.h"
> 2."device.h" is included by v4l2-dev.h, while "v4l2-dev.h" is inculded
> by "v4l2-subdev.h"
> 3."types.h" is inclded by "v4l2-cci.h"
> 4.remaining header files which mentioned above are also similar, they
> by some other header files
> I think we just need include those necessary header files(such as
> "v4l2-subdev.h"/"v4l2-cci.h"...) in sensor driver.

That's bad. You should read again what the IWYU principle means.

> If we add these header files which mentioned above, I am afraid it will
> cause "repeated inclusion header file" issue.

How would it be possible? Are some headers broken?

> As this driver code can be compiled pass, so there is not miss any
> header files.

There are _a lot_ of missing headers. Your compilation works by luck.

> Another, I also reviewed some other sensor driver code(such as
> gc0a08/gc2145 and imx/ov), they are all the same.

They are also problematic. So what?

> Can we keep this coding style and follow with most of those
> image sensor driver?

Why? We do NOT want to continue developers to avoid decreasing their
technical debts.

..

> > > +static const struct dev_pm_ops gc08a3_pm_ops =3D {
> > > +       RUNTIME_PM_OPS(gc08a3_power_off, gc08a3_power_on, NULL)
> > > +};
> >
> > There is a DEFINE_* PM macro, use it.
> >
> static DEFINE_SIMPLE_DEV_PM_OPS(gc08a3_pm_ops,
> gc08a3_power_off,
> gc08a3_power_on);
> Do you mean, we shoule use this Macro?

It depends on what type of sleep you want to provide. There are
different types of DEFINE_*() macros in the PM headers.

--=20
With Best Regards,
Andy Shevchenko

