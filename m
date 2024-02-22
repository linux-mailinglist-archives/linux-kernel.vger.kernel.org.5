Return-Path: <linux-kernel+bounces-76365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1191085F633
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D43B27250
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FC13FE4F;
	Thu, 22 Feb 2024 10:52:58 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1023FB2D;
	Thu, 22 Feb 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599177; cv=none; b=OH9KFvLv4BmCRxUITy4POXjvAxCX+GtxcUWGP3KYj4/Z3fyCHK0M0tpzw9pFFUDmO/V4P/3YYD7dMKDatMsMn8FCORo5dw78JRULd9FZ3uMHSNFfR31Zd9S/s92lRbtSwE83Exa1thauhL7ZfjgEDsmYgceERPheY9zGzHIlKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599177; c=relaxed/simple;
	bh=mvKZwxbf/e4KF9+fRM4X3wplM/O7yu2E+CvOcToAuEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjY8XoXslJNGliA1EZ1M8zljGMwmqEjnl6uZ12SItx09JS3vYpa10ryS7cE+Mnmgy8tK6Hp1Y968arRmBiUJVmaeWjUAQ1ya+lEOOiwDq0tf7dPQqrkCllQKr6dhFAnTG2Pl/xm0T46WZbjNFmWmrQ0WGkjpXLMFYtcxbKTkd1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bc21303a35so2863221b6e.0;
        Thu, 22 Feb 2024 02:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599175; x=1709203975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=If0nc9cpG0C+2T1xh8+4TleRWChMsk96hA+uEtXVAuA=;
        b=Jbbu7rhAtgszkFooPYgpfNAdfIghiCS4janxYyP49nhz0/2VeJJVvK9N/J5mgHNTed
         4ZqSsWPCxDRBZhd0g6dFiCJjbsR4tn7TdxvRW2vnUXi4V8ncGUERezfoXHEC/NLeoY9O
         nJzizbWCKp5l3m1u84VHxskA8JaREd49kNORdVepn8YSY954guqx6DRXp8E4aMJk6pXK
         zumHqhbKHnafY17bgsGOuqKqeeEezOtiDYInAkx55erBNDEb6TtRz2Em6V6sdM466vFG
         KS6wBNnNwWhbiZmWR4lrge41fWATuAPR5hAW+3xDCGi3OHcgCVEOJjqluHvzKUUCN0it
         3MuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSKZGzMYxcL4JabY61WIdrkzCONnATvtAji62AYzSEsS9ze6NfeIqnPU30rxTUPPwCUK7vX5vu9JftgiOJTnJS9YHFmxYmskE8tNzOSSJN+GKB4wGsGSvLm3auq27pAagK1wdLFkCK5ty6geraLq7mAAK2UZ/o8dc+5CwUEunvbwa8
X-Gm-Message-State: AOJu0Yyzul8XDiLKMKy2p1OXMGct44HsQFjpSr4fA8IZ9f2NeWKWOihe
	ozXn4eIvSPnyjLI80Fb6WoC1o+2+tQqgHDdd1sxidMZXcCdRg7tvxa+HNG5gxck6lB4otZN8lJ/
	l63gMqUDLxO7lbhoGTsxyr54XStA=
X-Google-Smtp-Source: AGHT+IHqsc+vabOS1Zt0KKodBLknVgJXlppgLgPIySA5IzdBgwvKA6+n7hQNngnZt6jo743Sp9KtYpzlONTi/s0ZFhA=
X-Received: by 2002:a4a:a886:0:b0:5a0:396d:2489 with SMTP id
 q6-20020a4aa886000000b005a0396d2489mr20650oom.1.1708599175400; Thu, 22 Feb
 2024 02:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4551531.LvFx2qVVIh@kreacher> <2262393.iZASKD2KPV@kreacher> <ffa37950-d850-44e2-a33e-837466238d6d@linaro.org>
In-Reply-To: <ffa37950-d850-44e2-a33e-837466238d6d@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 11:52:44 +0100
Message-ID: <CAJZ5v0hqCbxChYmvADZJAFiuS1yPnRmj6ZZJfD032tnLB7ZZAA@mail.gmail.com>
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

On Thu, Feb 22, 2024 at 11:47=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 14/02/2024 13:45, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The current code requires thermal zone creators to pass pointers to
> > writable ops structures to thermal_zone_device_register_with_trips()
> > which needs to modify the target struct thermal_zone_device_ops object
> > if the "critical" operation in it is NULL.
> >
> > Moreover, the callers of thermal_zone_device_register_with_trips() are
> > required to hold on to the struct thermal_zone_device_ops object passed
> > to it until the given thermal zone is unregistered.
> >
> > Both of these requirements are quite inconvenient, so modify struct
> > thermal_zone_device to contain struct thermal_zone_device_ops as field =
and
> > make thermal_zone_device_register_with_trips() copy the contents of the
> > struct thermal_zone_device_ops passed to it via a pointer (which can be
> > const now) to that field.
> >
> > Also adjust the code using thermal zone ops accordingly and modify
> > thermal_of_zone_register() to use a local ops variable during
> > thermal zone registration so ops do not need to be freed in
> > thermal_of_zone_unregister() any more.
>
> [ ... ]
>
> >   static void thermal_of_zone_unregister(struct thermal_zone_device *tz=
)
> >   {
> >       struct thermal_trip *trips =3D tz->trips;
> > -     struct thermal_zone_device_ops *ops =3D tz->ops;
> >
> >       thermal_zone_device_disable(tz);
> >       thermal_zone_device_unregister(tz);
> >       kfree(trips);
>
> Not related to the current patch but with patch 1/6. Freeing the trip
> points here will lead to a double free given it is already freed from
> thermal_zone_device_unregister() after the changes introduces in patch
> 1, right ?

No, patch [1/6] doesn't free the caller-supplied ops, just copies them
into the local instance.  Attempting to free a static ops would not be
a good idea, for example.

BTW, thanks for all of the reviews, but this series is not applicable
without the one at

https://lore.kernel.org/linux-pm/6017196.lOV4Wx5bFT@kreacher/

