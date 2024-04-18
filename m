Return-Path: <linux-kernel+bounces-150558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AD68AA0E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98680281FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2C015FA72;
	Thu, 18 Apr 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="A5QCHLq0"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180C116191A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460569; cv=none; b=MGprnnEsr5opkp41V8bDsimcEVrYAGohvz4TcioYK1jdT54oEF9FqV1WynBZK+KmKfmJ4BGGVOd6CUqeevR6yXz3ngJYS628Rpvom2lAv2GPvZKWyKRq7GAdk8JFPHcPh6MbkW0zgjryTmdwwzWyyQb12s0rMNXzG+GLj9fYlUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460569; c=relaxed/simple;
	bh=F210ow5SuffL5Qd+LCc/09PARUdheMgc93VCoiUrgfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AD9l5DKCKNWsyEMOQ9XVmvc3u+bUWQi0VpnESzts3UwAn9DFdauL6ROMaOOv6w7O3uuENzXZpBdLnW+rS7Mxkv8lZ9c3gRP37WNXjLdeJTxopo4rxEOyO0n9BExoLEVAWKoq6aE/DUXCzGNzyt7kJmUzN6rUg2SiwkjeTtTZ+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A5QCHLq0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78f04924a96so77882385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713460567; x=1714065367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwgsV6Bgw8XAr7AlE0UkLUnQuWiMt0eg6v3cfIkpwUY=;
        b=A5QCHLq0bdLeERVvkntz3dazjkkeE+Vy65iygJHWT+NI6yuVWe/ldC9WlaCGZTpE5/
         Nnfez8f/r51akfOPTxBx1L5HTjxmY2hSGiWLTZUUQqL8Rbb4PBtgc5xKLXipwd7KN+X9
         MCbpKM0VMoqiybUnCQ/8bYe5QvlQ9lNlGu8jxpHd3YceGby25XRB2H1629HtiYJVANd2
         DLFj07SqpWzUduC2Y3PI4aaIPxOesP4hlaDf//b6bAyoLtJElwGbx6+xI8/VZv0C7Eli
         tDt1aGuwtVb/Kmb62sVtbkl645Q3B0RKStrBw9y5XToIkvnZWN0vbOWtgpKFRn7sGQVl
         NDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713460567; x=1714065367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwgsV6Bgw8XAr7AlE0UkLUnQuWiMt0eg6v3cfIkpwUY=;
        b=SzqW5WkoQCcrFJ/IjsIcFBRTc1JaKV1kxSaAPa5PofPQZmzxYLLvXDT9Pld6A4ulmM
         nlEOZjXMitMw4dN5QtZgr/+qvaAbGmuvtmKwysozv8UfPL0bmC10RzUnJ+rTj6SUIoML
         24dtCggBA86dzzQbSXIerduSDIWffRBVB8IqNoL+Ty44lX0LwWCioDXaVds9jHtGcL/U
         Nx9hwmnreaGAMKDPv1rryZ+mX0yZQXteFzKEVf1mkdECfX0FesBgJ5lVYSs9YQvgKY7z
         agb9/zzIpFIGUVQ735HYyolVgEWc0a/45644IVL/gvyf1U3mDN9HiKltkLXDx/D0MxGO
         9Ijw==
X-Forwarded-Encrypted: i=1; AJvYcCWPUlSFyMWS+sis7vVtaqmFp7T6j7Ul7G5pbIOXuOlEDqD3as9ZtBivM8kLSQrfhoqkcpqP+Z6WL4BXZ6IL4p7kZMNuNtCh7VF8h4bz
X-Gm-Message-State: AOJu0YwKwZoB9cuw8wLZVbg7g1zn1jSPwW17iiqqLv/FB561FrTkyT3d
	fjUEMzbBIxQGopPrGLxQ+nXmI0krlfINFpSUIyekBzarHvb6JmKgcEfFOuc8GVAe6CF77cPmPZx
	ZKtpoLCHaA9OzWgdE16SQfOA8nEbzvHmvGRf8
X-Google-Smtp-Source: AGHT+IF29U7JAW1A2P1WD0lV+Z3IXS9ks8l81DyVOnGCQURjJ73xRvDG0sjKCmBqRQqLZqLDVhqz85t0fRqjPEMQ5mE=
X-Received: by 2002:a0c:c245:0:b0:69b:5c5e:be39 with SMTP id
 w5-20020a0cc245000000b0069b5c5ebe39mr3525831qvh.63.1713460566856; Thu, 18 Apr
 2024 10:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417230637.2592473-1-dtokazaki@google.com>
 <CAMRc=Mcbi8BQ-tHNs+BVjbm3aDSVY0zzOM4QfND3d2y8ryT62g@mail.gmail.com>
 <CAMRc=McRiv6vtU5LySrkbfdbCaqZ2tXbHnazo4iahRS-SKAXxg@mail.gmail.com> <CAOC40965VyOQX_WHxA0a=Ke6knoeYYYjqTkFva9eNyG55_Yi-g@mail.gmail.com>
In-Reply-To: <CAOC40965VyOQX_WHxA0a=Ke6knoeYYYjqTkFva9eNyG55_Yi-g@mail.gmail.com>
From: Daniel Okazaki <dtokazaki@google.com>
Date: Thu, 18 Apr 2024 10:15:51 -0700
Message-ID: <CAOC4094bymXuUV-WL7N-Pa3SmcAwJht6fN9Hxh2PN1V5DV_U5g@mail.gmail.com>
Subject: Re: [PATCH v1] at24: fix memory corruption race condition
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-team@android.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry forgot to include the key being that the probes happen in
parallel so there are race conditions to the registering of the
nvmem and other drivers using it after it starts getting torn down
and memory gets freed.

On Thu, Apr 18, 2024 at 10:13=E2=80=AFAM Daniel Okazaki <dtokazaki@google.c=
om> wrote:
>
> nvmem devices allow for linking by name in the DTS which doesn't
> create a dependency in the probe order.
>
> What happens is driver B probe starts shortly after the eeprom
> probe and calls of_nvmem_device_get. Since a device is
> registered it starts using it; however if the eeprom isn't there
> then the read will fail and it will start tearing down the resources.
> Driver B will now access invalid memory causing a kernel panic.
>
> Daniel
>
>
> On Wed, Apr 17, 2024 at 5:23=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > On Thu, Apr 18, 2024 at 1:59=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev=
pl> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 1:07=E2=80=AFAM Daniel Okazaki <dtokazaki@goo=
gle.com> wrote:
> > > >
> > > > If the eeprom is not accessible, an nvmem device will be registered=
, the
> > > > read will fail, and the device will be torn down. If another driver
> > > > accesses the nvmem device after the teardown, it will reference
> > > > invalid memory.
> > > >
> > > > Move the failure point before registering the nvmem device.
> > > >
> > > > Signed-off-by: Daniel Okazaki <dtokazaki@google.com>
> > > > ---
> > > >  drivers/misc/eeprom/at24.c | 18 +++++++++---------
> > > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.=
c
> > > > index 572333ead5fb..4bd4f32bcdab 100644
> > > > --- a/drivers/misc/eeprom/at24.c
> > > > +++ b/drivers/misc/eeprom/at24.c
> > > > @@ -758,15 +758,6 @@ static int at24_probe(struct i2c_client *clien=
t)
> > > >         }
> > > >         pm_runtime_enable(dev);
> > > >
> > > > -       at24->nvmem =3D devm_nvmem_register(dev, &nvmem_config);
> > > > -       if (IS_ERR(at24->nvmem)) {
> > > > -               pm_runtime_disable(dev);
> > > > -               if (!pm_runtime_status_suspended(dev))
> > > > -                       regulator_disable(at24->vcc_reg);
> > > > -               return dev_err_probe(dev, PTR_ERR(at24->nvmem),
> > > > -                                    "failed to register nvmem\n");
> > > > -       }
> > > > -
> > > >         /*
> > > >          * Perform a one-byte test read to verify that the chip is =
functional,
> > > >          * unless powering on the device is to be avoided during pr=
obe (i.e.
> > > > @@ -782,6 +773,15 @@ static int at24_probe(struct i2c_client *clien=
t)
> > > >                 }
> > > >         }
> > > >
> > > > +       at24->nvmem =3D devm_nvmem_register(dev, &nvmem_config);
> > > > +       if (IS_ERR(at24->nvmem)) {
> > > > +               pm_runtime_disable(dev);
> > > > +               if (!pm_runtime_status_suspended(dev))
> > > > +                       regulator_disable(at24->vcc_reg);
> > > > +               return dev_err_probe(dev, PTR_ERR(at24->nvmem),
> > > > +                                    "failed to register nvmem\n");
> > > > +       }
> > > > +
> > > >         /* If this a SPD EEPROM, probe for DDR3 thermal sensor */
> > > >         if (cdata =3D=3D &at24_data_spd)
> > > >                 at24_probe_temp_sensor(client);
> > > > --
> > > > 2.44.0.683.g7961c838ac-goog
> > > >
> > >
> > > Looks good, can you add a Fixes tag?
> > >
> > > Thanks,
> > > Bartosz
> >
> > Wait... While the patch is still correct - we shouldn't needlessly
> > create the nvmem device - why would anything crash? Looks like a
> > problem with nvmem then? How did you trigger this issue?
> >
> > Bart

