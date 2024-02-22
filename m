Return-Path: <linux-kernel+bounces-76670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C617785FABE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037FC1C25DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89231482FB;
	Thu, 22 Feb 2024 14:05:32 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2860145FF6;
	Thu, 22 Feb 2024 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610732; cv=none; b=K2fVCYquFpZ+nUmNrNOyrU57XZMKxzbmV6k7CBYI3LMsIQlS9nd4rMNxqKvec08CmjQxDycNlkeajn/MPNXuTKXcrRj6+4uoKsBygw2NY6pxSrh8+F5usmwSyYF0aWleweBjv2LFuZuGYIbI83o/DJb7WvWH8HRVwvqwUt30pp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610732; c=relaxed/simple;
	bh=x+mYmnKRAmVbqPnh7GeoP7TfYOz5wxcG8FEocgdSbnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZVY7t7BP5xEo8Yvj1KtOlTwO/PAD59WI7x04HH2lY0fLw+6TtTrOYSrQ1P6swCfBXF8Lw2lMSiBRBC19RxJ4vMsqWsW7Lg8ECee/nKnXSeKbjX8g7BYP1gTMCXCVQ8VLzOs4rrda26N9z7zATM1K4V/f9Y1Vgx0cNs80qNqojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59d29103089so274261eaf.0;
        Thu, 22 Feb 2024 06:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708610730; x=1709215530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mO2nclL9U8dwMBtj05knQsK6PwiKnaTN1YsWrMMD8vI=;
        b=FosOGLrKRqK3dYislDlbGkzRHuOq1fL59UceHoVDcHXSAeLbVdAwUn/L6eW/h6v1EZ
         jwRcYlTok6x+dWcI004aV6m/g0wCINr59mkHx220bv3P6UEX58Ytx7dR90c+lR+aqckL
         UEbyWT5EPCZa4BsTSxCNC4EVByM3sYSixVGodUxlAQ0OuOZP7M5hM17m7YCA25PrPE9o
         x13CVygDZ43Wv7pbCt2+R8eLm9M5pCkqjZ/XyGs9cCIRw8uil7241BZAaiWcLuxuzeZe
         hI2XG7KeWrBfOd3L07Gg1oGcjgWLLLpfNhXKeepL/pcv5AkbfE4wbGRlCOCWcvTnSdGj
         z5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSRV3RPmDsllF2xVeXIu4SzhsOCH4/IxrD+8+spQ44bp/Lwsk6+TIJY5q6bp4THlsBUh7RAr8xXuSvM6k6A/Oh4Q+E40cuPYAeewxk6cItSGl1Z1ZTP2SQqXENNrBsKv0tT6TFCfcVpDXfA4BGUTT5lhc4JvGOisAuH/3UFsbdEnR0
X-Gm-Message-State: AOJu0YzdmpdP1xrrry+STA7G6jj06/Uy550z5E25bqXhXts03cvn4iug
	7kr8qqdooF3pqABknD4+2yy1l18DIliSTUlgqGPOVAIRc7B7VKsnUVlO35ukS5+BHZr2mOnxTOn
	aMo98LVOMIryDh1nPs7inyoHASWzReHbB
X-Google-Smtp-Source: AGHT+IF/MxrG60R8TID8ybyMR9spvMRfMWAcGgt8A1vNx5pFyyYEl/Lj51iJ6p6EGf74m4x6FQXnD+26iZOWIo9qM78=
X-Received: by 2002:a4a:a886:0:b0:5a0:396d:2489 with SMTP id
 q6-20020a4aa886000000b005a0396d2489mr474588oom.1.1708610729714; Thu, 22 Feb
 2024 06:05:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4551531.LvFx2qVVIh@kreacher> <2262393.iZASKD2KPV@kreacher>
 <ffa37950-d850-44e2-a33e-837466238d6d@linaro.org> <CAJZ5v0hqCbxChYmvADZJAFiuS1yPnRmj6ZZJfD032tnLB7ZZAA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hqCbxChYmvADZJAFiuS1yPnRmj6ZZJfD032tnLB7ZZAA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 15:05:18 +0100
Message-ID: <CAJZ5v0jLCh7NioDs2-ibCZ1UUAvCL=hH-5WgAk9SPJE_DoynEg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] thermal: core: Store zone ops in struct thermal_zone_device
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:52=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Thu, Feb 22, 2024 at 11:47=E2=80=AFAM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 14/02/2024 13:45, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The current code requires thermal zone creators to pass pointers to
> > > writable ops structures to thermal_zone_device_register_with_trips()
> > > which needs to modify the target struct thermal_zone_device_ops objec=
t
> > > if the "critical" operation in it is NULL.
> > >
> > > Moreover, the callers of thermal_zone_device_register_with_trips() ar=
e
> > > required to hold on to the struct thermal_zone_device_ops object pass=
ed
> > > to it until the given thermal zone is unregistered.
> > >
> > > Both of these requirements are quite inconvenient, so modify struct
> > > thermal_zone_device to contain struct thermal_zone_device_ops as fiel=
d and
> > > make thermal_zone_device_register_with_trips() copy the contents of t=
he
> > > struct thermal_zone_device_ops passed to it via a pointer (which can =
be
> > > const now) to that field.
> > >
> > > Also adjust the code using thermal zone ops accordingly and modify
> > > thermal_of_zone_register() to use a local ops variable during
> > > thermal zone registration so ops do not need to be freed in
> > > thermal_of_zone_unregister() any more.
> >
> > [ ... ]
> >
> > >   static void thermal_of_zone_unregister(struct thermal_zone_device *=
tz)
> > >   {
> > >       struct thermal_trip *trips =3D tz->trips;
> > > -     struct thermal_zone_device_ops *ops =3D tz->ops;
> > >
> > >       thermal_zone_device_disable(tz);
> > >       thermal_zone_device_unregister(tz);
> > >       kfree(trips);
> >
> > Not related to the current patch but with patch 1/6. Freeing the trip
> > points here will lead to a double free given it is already freed from
> > thermal_zone_device_unregister() after the changes introduces in patch
> > 1, right ?
>
> No, patch [1/6] doesn't free the caller-supplied ops, just copies them
> into the local instance.  Attempting to free a static ops would not be
> a good idea, for example.
>
> BTW, thanks for all of the reviews, but this series is not applicable
> without the one at
>
> https://lore.kernel.org/linux-pm/6017196.lOV4Wx5bFT@kreacher/

As it turns out, this really is not a big deal, because the rebase is
trivial for everything except for the Intel patches, but for those two
I have the v1 versions that apply just fine without the other series
and have been reviewed.

So I can apply this series before the above one and rebase the latter
(I'd rather not send a new version of it though, so it can be reviewed
as is).

So never mind.

