Return-Path: <linux-kernel+bounces-62125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36CA851BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2913A1F2395B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05923F9F1;
	Mon, 12 Feb 2024 17:43:27 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A73EA78;
	Mon, 12 Feb 2024 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759807; cv=none; b=ohCoQC5bIz1LiUG7eLmWM2ZAXABVW6LwOli958aI5EfQ0CFPghQz5uIHHgLRUJbUTgqXU1iRCr9oysmXsoevqnz+hgBHPZMXpZSlTXnhcAAo0GraPOry2c9As8wKVs/EYlBgy9iQ1m0RYCiTYP2YklJJQs74yjOfeEmqY0YzGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759807; c=relaxed/simple;
	bh=SsGEe9jzRfD/Ga+oxJ1feO8SpHmF9DMqYvqEqooAhEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/11vDFCLETXTFJB3zE0n5viBh3YTaFHmecn4XOHaCuiIgeox4KZM8hEzPsHnANu7vMFqnOzUHfcc2WgQAISaB8f4dPZJgQOsocmnpEld2juS2qFHMv4UIjJhj2MF4/68Mj+RTStwLYJUj9Oe61j7zH4Cx4d+6nZZuS7BxQKQqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59a134e29d2so624464eaf.0;
        Mon, 12 Feb 2024 09:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759805; x=1708364605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xST44ys4SMLDhEF590NpWhBwD5goZj6F91RbZXqCTw=;
        b=i0CBSdjx+yrPesGIHHFP7o2AWrUwzpaK00RWwf7ARgMRZ38TC6/6a+XOD3XUABOlC5
         bnQi2/mILk4XdUDc0EiBI+P1xK+SkoxohoxDs0e2F37bSVbpVUvQD3jYCQ2uT3FnFRGT
         strhus/Sgv5zUzJdSrdu9evHbtptsFhnjFFRezWbYZ2qno8zPGR0Yji+RxR+PYL4RN7Q
         whkHnoRkM0UL++9WihASrCtVo0gdBALjsvsYsAhIQwUoRupgBlnKwrRgdzzzLEWKC1DY
         rZv0gtRbeO7rYrnsgFGHm2PS0Lhif+0qJ3eYTM/+Of27rNqttDZb7aL3S7lSmulFAwXp
         9eVw==
X-Forwarded-Encrypted: i=1; AJvYcCVtPOyPtdPV0cHJ/wgT8WTSJnRNrAx6DQDSY2LGCS0g4fzMUV5uNj2n/EB+F3Ub0TVCHtppI3I+0YEPjEjbiNyffxh9xLvWwOHdiezmVw+WzDdK/cRxH72F7YhgWiEeW+orHhtm5f4=
X-Gm-Message-State: AOJu0Yz2sfBhmVjyILlHWhkbDJQEeL8wGn7Jn0x8fXUBwinHhn7aKkAv
	uBclWy7hgs2Xdj5/EBZCRVrbDFATf8QeDQ/9jt59MhhLieZElPjGXFrEA3nrkdr6c7VCEclT4mA
	s17BoLyUjlffPo4Tbo18/swTjRiE=
X-Google-Smtp-Source: AGHT+IElTzgJTq2w9PS/VAnqZKj4HvV9vZrC+kfpxBmK2m4oSto1fsE3gX1lFULPHV6WP+XvNAwa1N/Sa5x27VmPWTI=
X-Received: by 2002:a05:6820:a8f:b0:59d:6ef2:7b01 with SMTP id
 de15-20020a0568200a8f00b0059d6ef27b01mr947314oob.1.1707759804897; Mon, 12 Feb
 2024 09:43:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206015409.619127-1-rui.zhang@intel.com> <ZcJV143vaglGGYnX@linux.intel.com>
In-Reply-To: <ZcJV143vaglGGYnX@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 18:43:13 +0100
Message-ID: <CAJZ5v0hjJtFPJv3ju_ZHgtb9NWuH0K4gtPRCQArncKctNX6WVQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/intel: Fix intel_tcc_get_temp() to support
 negative CPU temperature
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 4:53=E2=80=AFPM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Tue, Feb 06, 2024 at 09:54:09AM +0800, Zhang Rui wrote:
> > CPU temperature can be negative in some cases. Thus the negative CPU
> > temperature should not be considered as a failure.
> >
> > Fix intel_tcc_get_temp() and its users to support negative CPU
> > temperature.
> >
> > Fixes: a3c1f066e1c5 ("thermal/intel: Introduce Intel TCC library")
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
>
> > ---
> >  .../intel/int340x_thermal/processor_thermal_device.c |  8 ++++----
> >  drivers/thermal/intel/intel_tcc.c                    | 12 ++++++------
> >  drivers/thermal/intel/x86_pkg_temp_thermal.c         |  8 ++++----
> >  include/linux/intel_tcc.h                            |  2 +-
> >  4 files changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_de=
vice.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > index 649f67fdf345..d75fae7b7ed2 100644
> > --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > @@ -176,14 +176,14 @@ static int proc_thermal_get_zone_temp(struct ther=
mal_zone_device *zone,
> >                                        int *temp)
> >  {
> >       int cpu;
> > -     int curr_temp;
> > +     int curr_temp, ret;
> >
> >       *temp =3D 0;
> >
> >       for_each_online_cpu(cpu) {
> > -             curr_temp =3D intel_tcc_get_temp(cpu, false);
> > -             if (curr_temp < 0)
> > -                     return curr_temp;
> > +             ret =3D intel_tcc_get_temp(cpu, &curr_temp, false);
> > +             if (ret < 0)
> > +                     return ret;
> >               if (!*temp || curr_temp > *temp)
> >                       *temp =3D curr_temp;
> >       }
> > diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/=
intel_tcc.c
> > index 2e5c741c41ca..5e8b7f34b395 100644
> > --- a/drivers/thermal/intel/intel_tcc.c
> > +++ b/drivers/thermal/intel/intel_tcc.c
> > @@ -103,18 +103,19 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, INTEL_=
TCC);
> >  /**
> >   * intel_tcc_get_temp() - returns the current temperature
> >   * @cpu: cpu that the MSR should be run on, nagative value means any c=
pu.
> > + * @temp: pointer to the memory for saving cpu temperature.
> >   * @pkg: true: Package Thermal Sensor. false: Core Thermal Sensor.
> >   *
> >   * Get the current temperature returned by the CPU core/package level
> >   * thermal sensor, in degrees C.
> >   *
> > - * Return: Temperature in degrees C on success, negative error code ot=
herwise.
> > + * Return: 0 on success, negative error code otherwise.
> >   */
> > -int intel_tcc_get_temp(int cpu, bool pkg)
> > +int intel_tcc_get_temp(int cpu, int *temp, bool pkg)
> >  {
> >       u32 low, high;
> >       u32 msr =3D pkg ? MSR_IA32_PACKAGE_THERM_STATUS : MSR_IA32_THERM_=
STATUS;
> > -     int tjmax, temp, err;
> > +     int tjmax, err;
> >
> >       tjmax =3D intel_tcc_get_tjmax(cpu);
> >       if (tjmax < 0)
> > @@ -131,9 +132,8 @@ int intel_tcc_get_temp(int cpu, bool pkg)
> >       if (!(low & BIT(31)))
> >               return -ENODATA;
> >
> > -     temp =3D tjmax - ((low >> 16) & 0x7f);
> > +     *temp =3D tjmax - ((low >> 16) & 0x7f);
> >
> > -     /* Do not allow negative CPU temperature */
> > -     return temp >=3D 0 ? temp : -ENODATA;
> > +     return 0;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(intel_tcc_get_temp, INTEL_TCC);
> > diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/the=
rmal/intel/x86_pkg_temp_thermal.c
> > index 11a7f8108bbb..61c3d450ee60 100644
> > --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> > +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> > @@ -108,11 +108,11 @@ static struct zone_device *pkg_temp_thermal_get_d=
ev(unsigned int cpu)
> >  static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *tem=
p)
> >  {
> >       struct zone_device *zonedev =3D thermal_zone_device_priv(tzd);
> > -     int val;
> > +     int val, ret;
> >
> > -     val =3D intel_tcc_get_temp(zonedev->cpu, true);
> > -     if (val < 0)
> > -             return val;
> > +     ret =3D intel_tcc_get_temp(zonedev->cpu, &val, true);
> > +     if (ret < 0)
> > +             return ret;
> >
> >       *temp =3D val * 1000;
> >       pr_debug("sys_get_curr_temp %d\n", *temp);
> > diff --git a/include/linux/intel_tcc.h b/include/linux/intel_tcc.h
> > index f422612c28d6..8ff8eabb4a98 100644
> > --- a/include/linux/intel_tcc.h
> > +++ b/include/linux/intel_tcc.h
> > @@ -13,6 +13,6 @@
> >  int intel_tcc_get_tjmax(int cpu);
> >  int intel_tcc_get_offset(int cpu);
> >  int intel_tcc_set_offset(int cpu, int offset);
> > -int intel_tcc_get_temp(int cpu, bool pkg);
> > +int intel_tcc_get_temp(int cpu, int *temp, bool pkg);
> >
> >  #endif /* __INTEL_TCC_H__ */
> > --

Applied as 6.9 material, thanks!

