Return-Path: <linux-kernel+bounces-96358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AE3875AF7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52DEDB219D4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7E53FE31;
	Thu,  7 Mar 2024 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWb2LE5u"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3B2E648;
	Thu,  7 Mar 2024 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853234; cv=none; b=govzpLHfPCQXBAxEZ5DLaKqJXfuG1cD0Vwxijjr06lSvhwXBwKKHH6aEx08zTKMoyYS1xr+qQoX1vxQl8T7f1zgw7UCTKq4ullg25/CiycEIvnob2u8fojSDYmv01cLIc+6IfI1J3xWMssZ+3pxEyVwA2A4cQ0KaSxT+cihP9aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853234; c=relaxed/simple;
	bh=RDcVTsd7UxuaEDmhDjPxRBk8J4OY8BEPNTID2PaJcd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOTiUGDRiYsWh1p/BObYgHYrpLJaMO0tU1NM9GlUthYYeinmDxeFXj5RDYdwDMO4beuzT0nxnsh6MW1rqCqmdzM562XsiN5TYV1lmUg59CbYIYlYOFoSyRvQ7B7QyYJ8Vn8BY/wXS5zFfMpQkwIds+mcYjq4wrgU8iHnGbyMSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWb2LE5u; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso235695a12.2;
        Thu, 07 Mar 2024 15:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709853230; x=1710458030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S3ACSLwbjngi5u/9n8VUnWe6dy0YuTFMy4TZsOux9E=;
        b=aWb2LE5uswycoV40gb/dH9apMVkx4Fe3LZDur/Ooa08pWPSoDCUoirSjKXuQbBd9Cg
         yEqh0kZuExbdJG8cRUl5ftG7W8hzWNCKr/bQuCNg65MV9aoV7j+P3OyxWQ+wu4uyr3dE
         A0QNPhGTWYJLlvk5CMdZrlapq9HDEFmVgASayKSJcMcJ/w7yhhKmAgDzoWM0SezA7nZ4
         VScqKqjpzROqH6/reWywwxCk0FqKayAVxwAr6/4j967Rh39mC/Lz3+lLvnf2mZJkC7/n
         5ZME2z5BMQt+ZnpRYlJ7KILltdLwEia49vfg4R1h72nq5tw9VwSdHQJTfdwtk7nKlN84
         TR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709853230; x=1710458030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3S3ACSLwbjngi5u/9n8VUnWe6dy0YuTFMy4TZsOux9E=;
        b=qBarTzRIEFGokLrR+ZaT9989utoK2QusDQsZlWHTHKnyhbqGhbDj5WToOmLBSb4Pi9
         BBpYSjpZ7hI2gFpHmE2QQoPqBpIp08Fj00sB8WnQeISP95vocNsERd3uMmpZw+V2FPLq
         Z+7nljyzCwQN/PJSlOMAH+Ja7lB4sgKRIx0oqGp8zapFRqEXh3Ef4xPvImihkJMDSVFc
         QAbwwlBsy8vKxRBJcOTd2erDKoGtbG/jwOfq2beC4tmi37de/Od/IL8TSaQVfFdkmVqZ
         wufqhBjynYWFXXptFZk1WPisowQHAdzFjvjT34KD11rSc6VEzlf1C9YE/Z3Cxmlj//rg
         RDZA==
X-Forwarded-Encrypted: i=1; AJvYcCU8W+d3vNsPLwcEKmS1+ly4GbVurzMPwRdHN68AicKWlODErB/tsPeXpQAT3kBCHOpsWSsvbN1J20AJ62/lU9thC2yS9IFxb7n4IE3i
X-Gm-Message-State: AOJu0YzihkjlGKsCgALO86Zft+pM6/12Sbku90HzgNTT5GVOBC8u4Zxu
	Prjr3wy4sy6PIFuXcrI9VFh6kjZXsZGZ2YFXGCmGSOcgiSysLO9R20jlF/p9/SWrHiZ4kdMYGpI
	IVrxmgs7IoyMtQhr3KdwnjkBCz1yCXNqLivQ=
X-Google-Smtp-Source: AGHT+IGVDRkRxniL7ZJXFPXALCWyRYjYkqZ/nm6Sm2Slu6x7OaJ1eZCBlqpKaN86hakZ5Aud8ccHDku8Q+wxB0wcnek=
X-Received: by 2002:a17:906:b154:b0:a45:da1:9364 with SMTP id
 bt20-20020a170906b15400b00a450da19364mr10181601ejb.19.1709853230332; Thu, 07
 Mar 2024 15:13:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307214048.858318-1-umang.jain@ideasonboard.com>
 <20240307214048.858318-3-umang.jain@ideasonboard.com> <CAHp75Vcvvadd6EeTWk2ZDrmtCQzWBV8rOoxNCotzYRRPwecaEA@mail.gmail.com>
In-Reply-To: <CAHp75Vcvvadd6EeTWk2ZDrmtCQzWBV8rOoxNCotzYRRPwecaEA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Mar 2024 01:13:14 +0200
Message-ID: <CAHp75Veu=ZVwEzXZSbQyqrW2Q9FMYjpm5+Simgkuhyea=jtoPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] media: i2c: Add imx283 camera sensor driver
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, willl will <will@willwhang.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Hans de Goede <hdegoede@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Paul Elder <paul.elder@ideasonboard.com>, 
	Mehdi Djait <mehdi.djait@bootlin.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	Sebastian Reichel <sre@kernel.org>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 1:11=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Mar 7, 2024 at 11:41=E2=80=AFPM Umang Jain <umang.jain@ideasonboa=
rd.com> wrote:
> >
> > From: Kieran Bingham <kieran.bingham@ideasonboard.com>
> >
> > Add a v4l2 subdevice driver for the Sony IMX283 image sensor.
> >
> > The IMX283 is a 20MP Diagonal 15.86 mm (Type 1) CMOS Image Sensor with
> > Square Pixel for Color Cameras.
> >
> > The following features are supported:
> > - Manual exposure an gain control support

and

> > - vblank/hblank/link freq control support
> > - Test pattern support control
> > - Arbitrary horizontal and vertical cropping
> > - Supported resolution:
> >   - 5472x3648 @ 20fps (SRGGB12)
> >   - 5472x3648 @ 25fps (SRGGB10)
> >   - 2736x1824 @ 50fps (SRGGB12)

..

> + array_size.h
> + bitops.h
> + container_of.h
>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
>
> + errno.h

Actually err.h.

> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>

And
+ minmax.h

> > +#include <linux/module.h>
>
> + mutex.h
>
> > +#include <linux/of.h>
>
> How is this being used, please?
>
> > +#include <linux/pm_runtime.h>
>
> + property.h
>
> > +#include <linux/regulator/consumer.h>
>
> + types.h
>
> > +#include <linux/units.h>


--=20
With Best Regards,
Andy Shevchenko

