Return-Path: <linux-kernel+bounces-150552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4D58AA0DB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2DC1C20E48
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA19172BBC;
	Thu, 18 Apr 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d84UN9WB"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3090D16191A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460401; cv=none; b=brpwDvcIvhM1ldWXADHtZsmnH/l7DE26Qngw7vTeMonB1OhmjQzuaZa5LDzy0oRmN0QIo2hAu4H8nENi+95QCipFKH7NuMt7AyqvSJxyfmelYmuyAJZrrMDha3pxYEINjZFscG2bl/C0RX+KlUXGasAobRKm+0NQ2Q+2RRbYlHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460401; c=relaxed/simple;
	bh=Cm2yQz3sTP8y+8k+SubgT0T6Wb8C0SAcjIQ7KvabJ3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRcuGjSDNpiUzmXsw8EDxLyb4baqp2TDma6tZgSMoPbYwQKQZlmNUFuefTGImmQvZAiO/UfQD1moutyDFxGD72oM9+PQpNYnF1hlGXDrTGnhB62+ZXNfwkYF2BZw5GFsLYiyOtCywPJguwpAZT9xRYWs5QOP+pUUTGxcGq/JIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d84UN9WB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so3995386a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713460398; x=1714065198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQxRezvMNM7LktsHV9H8xbE8pqZN4hyXG+Nf7TxvGCw=;
        b=d84UN9WBveNIrRuDI3Ztdjean0eB8aDUdqysLXdfysBJOO+JavXrHBsEhwsr/+PbBn
         tbsmBAQnBKDQLwXNyChcPsjJ7nl1AWeh090wAM2uGAw4saAe6DgozlAeC9p8A+piAdg2
         VDQj8Q27kdvsTl3RGI+A4glrB573z9fxurNDSTbNMsWbp+5s11/A0is3w0cNpxTwP2bd
         MDaDgKEc6lYf6MRP4hZ5MQ7iAJV9O5JulEiEmUTjAjQT4l79Hw5nZHpF0NMSeLLWJ/KC
         pJopAGFTASpHSVDcFrd2XfAuEiyzQmldkiLwlfoWT9rdNYnObWTFjPHezbLkJx93MSpT
         2Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713460398; x=1714065198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQxRezvMNM7LktsHV9H8xbE8pqZN4hyXG+Nf7TxvGCw=;
        b=b0atc5rUJlBTBp5kcNgZSKJUqYMHT0ho/cG3JiCXonKsrZkJZce6p+vFUzduiLJuPX
         GD8wWSSwteMjIOs5noLoXim4nerkFg6248UsWuMx8VQbOhrQ8IObccnizk7DIgaD8nKh
         kVrAjR1wlQfecNwJ5ywsJyYWoWW0raNzEc5aMgw38wX1FW2EFk/2PrZjEpLxoggH3T6x
         MctvBDlJ36Dn7bG46d7VWVoELcHcDx5jXxNzqTZNZ+cTX/ApoGhCt95mE5v20jw+1Wv5
         gMWiyhJWCOUolekXKaEqDgM/lvoBVQOmqwYRXIhX+oJbs4ooU5O+SND40KpwypsezyK+
         hbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrAncfVataHyNecg3huYB41/1ePmPjdaadGYvHteiuCNr6gSQfn0qF9isYaVTBgsiWfzDs16ftqTGNR3JuiTuyplIlh3zpVNFVHlbH
X-Gm-Message-State: AOJu0YxwxcdMFH48fZEKD0mTbdeNlO6m2m941eCIH43/RD8lDNUXPT70
	yVGdQJnOw6QFyfLkpyAqv1/ce8lzftUSD9FvwWa0w0z0ULy79Dpfs868+MfrxNVQ7biFKYosLOw
	GY0tQMlpwvUJIbDDcFONxroiybuxWJRpLfW/p5Gdrk4QEZs4AghVH
X-Google-Smtp-Source: AGHT+IHDMFkIbyQ2SAQ+ksWkdggKr1EkvErLfi1bztfrf7XzZPKib+XDnV4tTasNiwOzq0hP3E8Ibf7GR5ZbzsZ+Bkc=
X-Received: by 2002:a17:907:2d10:b0:a51:d475:aca3 with SMTP id
 gs16-20020a1709072d1000b00a51d475aca3mr3205856ejc.16.1713460398114; Thu, 18
 Apr 2024 10:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417230637.2592473-1-dtokazaki@google.com>
 <CAMRc=Mcbi8BQ-tHNs+BVjbm3aDSVY0zzOM4QfND3d2y8ryT62g@mail.gmail.com> <CAMRc=McRiv6vtU5LySrkbfdbCaqZ2tXbHnazo4iahRS-SKAXxg@mail.gmail.com>
In-Reply-To: <CAMRc=McRiv6vtU5LySrkbfdbCaqZ2tXbHnazo4iahRS-SKAXxg@mail.gmail.com>
From: Daniel Okazaki <dtokazaki@google.com>
Date: Thu, 18 Apr 2024 10:13:03 -0700
Message-ID: <CAOC40965VyOQX_WHxA0a=Ke6knoeYYYjqTkFva9eNyG55_Yi-g@mail.gmail.com>
Subject: Re: [PATCH v1] at24: fix memory corruption race condition
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-team@android.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

nvmem devices allow for linking by name in the DTS which doesn't
create a dependency in the probe order.

What happens is driver B probe starts shortly after the eeprom
probe and calls of_nvmem_device_get. Since a device is
registered it starts using it; however if the eeprom isn't there
then the read will fail and it will start tearing down the resources.
Driver B will now access invalid memory causing a kernel panic.

Daniel


On Wed, Apr 17, 2024 at 5:23=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Thu, Apr 18, 2024 at 1:59=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > On Thu, Apr 18, 2024 at 1:07=E2=80=AFAM Daniel Okazaki <dtokazaki@googl=
e.com> wrote:
> > >
> > > If the eeprom is not accessible, an nvmem device will be registered, =
the
> > > read will fail, and the device will be torn down. If another driver
> > > accesses the nvmem device after the teardown, it will reference
> > > invalid memory.
> > >
> > > Move the failure point before registering the nvmem device.
> > >
> > > Signed-off-by: Daniel Okazaki <dtokazaki@google.com>
> > > ---
> > >  drivers/misc/eeprom/at24.c | 18 +++++++++---------
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> > > index 572333ead5fb..4bd4f32bcdab 100644
> > > --- a/drivers/misc/eeprom/at24.c
> > > +++ b/drivers/misc/eeprom/at24.c
> > > @@ -758,15 +758,6 @@ static int at24_probe(struct i2c_client *client)
> > >         }
> > >         pm_runtime_enable(dev);
> > >
> > > -       at24->nvmem =3D devm_nvmem_register(dev, &nvmem_config);
> > > -       if (IS_ERR(at24->nvmem)) {
> > > -               pm_runtime_disable(dev);
> > > -               if (!pm_runtime_status_suspended(dev))
> > > -                       regulator_disable(at24->vcc_reg);
> > > -               return dev_err_probe(dev, PTR_ERR(at24->nvmem),
> > > -                                    "failed to register nvmem\n");
> > > -       }
> > > -
> > >         /*
> > >          * Perform a one-byte test read to verify that the chip is fu=
nctional,
> > >          * unless powering on the device is to be avoided during prob=
e (i.e.
> > > @@ -782,6 +773,15 @@ static int at24_probe(struct i2c_client *client)
> > >                 }
> > >         }
> > >
> > > +       at24->nvmem =3D devm_nvmem_register(dev, &nvmem_config);
> > > +       if (IS_ERR(at24->nvmem)) {
> > > +               pm_runtime_disable(dev);
> > > +               if (!pm_runtime_status_suspended(dev))
> > > +                       regulator_disable(at24->vcc_reg);
> > > +               return dev_err_probe(dev, PTR_ERR(at24->nvmem),
> > > +                                    "failed to register nvmem\n");
> > > +       }
> > > +
> > >         /* If this a SPD EEPROM, probe for DDR3 thermal sensor */
> > >         if (cdata =3D=3D &at24_data_spd)
> > >                 at24_probe_temp_sensor(client);
> > > --
> > > 2.44.0.683.g7961c838ac-goog
> > >
> >
> > Looks good, can you add a Fixes tag?
> >
> > Thanks,
> > Bartosz
>
> Wait... While the patch is still correct - we shouldn't needlessly
> create the nvmem device - why would anything crash? Looks like a
> problem with nvmem then? How did you trigger this issue?
>
> Bart

