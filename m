Return-Path: <linux-kernel+bounces-44845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F4E842815
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476351F2509B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA582823D6;
	Tue, 30 Jan 2024 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBD5wgfq"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B2F823D3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628710; cv=none; b=cwFvMjqtUtc8bJPhGci2N6r+wkW0DXQ9tUzuP61H7m5IUvOjPDhRZ79okR3yTsBJB75/ZGMS6m8oAkbc73X8A3vaOFkbWxGymMmvpgAc6UJl0PE1w6fyphUlyWh4SQ4bk4KS52NfwIuFVKJs8hBfOfL4AJZmyf2i+CbJgFkUlPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628710; c=relaxed/simple;
	bh=BiSnpof6s0wfNf9+A13iFmx1FmKZ23viaAe7Jyf69kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDtj7al5zOOnjr4ZP3Z0YdI3SHaJvGTG8aM7ZDNrxl1+U1XZLaSKgWmIqFR9IP5MNQmimEQR6OCRqoG9oT66qTaP74BDrlwxbI8RrCJxEQjWC6zyuIHLb0+Gs5QJlrOCNNXUtSLqWknxkm8S4BJlL7Bmsk5tJxOr5/zLtZmOtT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IBD5wgfq; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6818aa07d81so28313866d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706628707; x=1707233507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyFAq1Eg2RJvLWqRzFuQdXmR0HpMNogzZgkepdLa9/U=;
        b=IBD5wgfqKNqMaAgeh42HPplmoOZhKFJSddBoWdURM8oi6MZwhWi+Tyql1VcnolE4FK
         YUdM4cAitKRBJ533N+6uB+gaf7mql7JihSXliyJ44o6TSiHBi9YEa4CAZWS+uFVk/j3h
         /7dWWMrdUJnkQA0NiKGpzs0jtJq2cbVTTBliyRf/20qwAHDi42bB3tPS74AyO0F+/oAh
         FVNQHouDjxxEkffjf39d/pWeWxwdNzNdRvdnTxGeJrYTw5KRDyIOSVYLE6qWzm1QMt68
         JdEKzU1GYe6ZQoAiRz8aw4ouEzlDskfVdLIj84exdvWSecpWSU7hqhyiJqnfhh7KMX4x
         62fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706628707; x=1707233507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyFAq1Eg2RJvLWqRzFuQdXmR0HpMNogzZgkepdLa9/U=;
        b=jU0mWpk/wvoAXT1YDQ6sTmvJrZDmOdb7jPcgPD5yJhgO2UzBsRa6Lc25+hZt2ya2EZ
         X3J53UBrRoXmxF33JiCUiw/Jy/RbsgII7XRc8OaIplVNpi1s6296QpWAdHz7FFElFVpL
         j/u84DxSdArQKrWUraYSfSAZckG4edFejIojIigfJL0RPLk+VN5hQRGa9qg54w51GbD8
         kgHhXM0dpc2jRh1MgrPGqgR2TSBFPDZ9V0Wh1ycyVVnULCMkNQoGcGFS7pm1wDpuqVCd
         kh6DU6LElpnNrLq8NO2XoZAHXKkIMmwkJWntw+54RglWaV1qZijkqt8oLtRikvg0+7HD
         Du1A==
X-Gm-Message-State: AOJu0Yx4XdiJF6MwvqXK9qczc4A7IZwDBAaqeOxsZZJyaIbk7N0IqsmY
	1yl/XromrLZwfhYi7xq0fnxK3picVwGGuxhpjfKpum+37dgr3Rp+9InBbdJFXy/NVAHKnS6PX/m
	1akZ7BvOCNmnobB3IhKKwIqwZ8u3ZFW4VRuhRrg==
X-Google-Smtp-Source: AGHT+IE9wCsA8OMUwsAtj9eouk/XJiMtJxIGPk+xD0QUnQxHNQz4KNhObmSuHuPnZPemueo0vMoDgt9lN4w74OWnQkc=
X-Received: by 2002:a05:6214:248e:b0:68c:499f:f803 with SMTP id
 gi14-20020a056214248e00b0068c499ff803mr7669302qvb.30.1706628707108; Tue, 30
 Jan 2024 07:31:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129211912.3068411-1-peter.griffin@linaro.org>
 <20240129211912.3068411-3-peter.griffin@linaro.org> <CAGETcx8UsseQAHc76QaMxgMUe7cwajZVdYLA2uwpZxF90RLjJQ@mail.gmail.com>
 <CAPLW+4mG2RkUgDbBBzrgCAW3covbr9eCQEFje1pYxj2hzVykug@mail.gmail.com>
In-Reply-To: <CAPLW+4mG2RkUgDbBBzrgCAW3covbr9eCQEFje1pYxj2hzVykug@mail.gmail.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 30 Jan 2024 15:31:35 +0000
Message-ID: <CADrjBPr0HjympgaC+eiVdTJuFbNes26gPEMJfdiLYFDUAjpU3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle()
 for PMU regs
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, arnd@arndb.de, krzysztof.kozlowski@linaro.org, 
	linux@roeck-us.net, wim@linux-watchdog.org, alim.akhtar@samsung.com, 
	jaewon02.kim@samsung.com, kernel-team@android.com, tudor.ambarus@linaro.org, 
	andre.draszik@linaro.org, willmcvicker@google.com, linux-fsd@tesla.com, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam & Saravana,

On Tue, 30 Jan 2024 at 03:38, Sam Protsenko <semen.protsenko@linaro.org> wr=
ote:
>
> On Mon, Jan 29, 2024 at 4:25=E2=80=AFPM Saravana Kannan <saravanak@google=
com> wrote:
> >
> > On Mon, Jan 29, 2024 at 1:19=E2=80=AFPM Peter Griffin <peter.griffin@li=
naro.org> wrote:
> > >
> > > Obtain the PMU regmap using the new API added to exynos-pmu driver ra=
ther
> > > than syscon_regmap_lookup_by_phandle(). As this driver no longer depe=
nds
> > > on mfd syscon remove that header and Kconfig dependency.
> > >
> > > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > > ---
> > >  drivers/watchdog/Kconfig       | 1 -
> > >  drivers/watchdog/s3c2410_wdt.c | 9 +++++----
> > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > > index 7d22051b15a2..d78fe7137799 100644
> > > --- a/drivers/watchdog/Kconfig
> > > +++ b/drivers/watchdog/Kconfig
> > > @@ -512,7 +512,6 @@ config S3C2410_WATCHDOG
> > >         tristate "S3C6410/S5Pv210/Exynos Watchdog"
> > >         depends on ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || COM=
PILE_TEST
> > >         select WATCHDOG_CORE
> > > -       select MFD_SYSCON if ARCH_EXYNOS
>
> That reminds me: now that exynos-pmu driver uses regmap API, does it
> make sense to add something like "select REGMAP" to EXYNOS_PMU option?

Good point, I will add that in v3.

>
> > >         help
> > >           Watchdog timer block in the Samsung S3C64xx, S5Pv210 and Ex=
ynos
> > >           SoCs. This will reboot the system when the timer expires wi=
th
> > > diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c241=
0_wdt.c
> > > index 349d30462c8c..a1e2682c7e57 100644
> > > --- a/drivers/watchdog/s3c2410_wdt.c
> > > +++ b/drivers/watchdog/s3c2410_wdt.c
> > > @@ -24,9 +24,9 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/err.h>
> > >  #include <linux/of.h>
> > > -#include <linux/mfd/syscon.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/soc/samsung/exynos-pmu.h>
> > >
> > >  #define S3C2410_WTCON          0x00
> > >  #define S3C2410_WTDAT          0x04
> > > @@ -699,11 +699,12 @@ static int s3c2410wdt_probe(struct platform_dev=
ice *pdev)
> > >                 return ret;
> > >
> > >         if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
> > > -               wdt->pmureg =3D syscon_regmap_lookup_by_phandle(dev->=
of_node,
> > > -                                               "samsung,syscon-phand=
le");
> > > +
> > > +               wdt->pmureg =3D exynos_get_pmu_regmap_by_phandle(dev-=
>of_node,
> > > +                                                "samsung,syscon-phan=
dle");
> >
>
> This looks so much better than approach taken in v1, as for my taste.
> For this patch:
>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

Thanks!
>
> > IIUC, the exynos PMU driver is registering a regmap interface with
> > regmap framework. So, can't we get the remap from the framework
> > instead of directly talking to the PMU driver?
> >

I'm not aware of any existing regmap API that does that. A quick look
through regmap code I can't see any global state that is stored on a
regmap_init() for example of all the regmaps created in the system.

As Sam mentions below, prior to these patches the syscon device would
be creating the PMU mmio regmap and consumers drivers would be
obtaining the regmap by going through the syscon driver. After this
series we instead talk to the exynos-pmu driver to obtain the pmu
regmap which can either be one with overridden operations for issuing
SMC calls to do the register accesses or still a mmio regmap.

Folks tried in the past to add a SMC backend to regmap similar to
regmap_mmio and add support for it into syscon driver but this was
nacked (see here
https://lore.kernel.org/lkml/20210723163759.GI5221@sirena.org.uk/T/)

>
> Peter is basically re-implementing syscon driver with overridden
> operations, as a part of exynos-pmu driver, in previous patch. Which
> means syscon API can't be used anymore to obtain the regmap. Do you
> have particular API in mind that allows getting a random regmap
> registered with devm_regmap_init()?

Thanks,

Peter

