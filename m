Return-Path: <linux-kernel+bounces-37692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7500583B3E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B672866FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7FD1353F3;
	Wed, 24 Jan 2024 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U76+FhmA"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B73811E4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131661; cv=none; b=BkkJE1zptPMshNoDGyYN01vPHd+8ACym7nAB+j+GttB1mlqd34bvNAOBvlRxUdyO8QGmuHDG2yeqglbWSIWs78FDbXy1Ko9NVRt1UitGrHZ1m2bwPoDw+anZORjdHAc23YlMADVWutRJPjXdf5cF+vVe9ROvYN2ZXsIN8+C4G5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131661; c=relaxed/simple;
	bh=LWNwA7ukVrj+d7v6MIv5EzJo8y49TqMJStEePkkmQ/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZw8MOlu6gUbr6EAbza/ooOD4U3ag7JzSt/eafEBKDgS25VzaO/pEfe7+8kbOP99ZW97bNAtY+LxdCm7dU6Kn9LkAgi2douRRcbvQ8z6tb/BwXHO0Os2TRIZEAODwz77u5CsEzehzk+9gxynRDa8xySfJp6sTiyBJ9Lu8S/sP48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U76+FhmA; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-428405a0205so9991cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706131658; x=1706736458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5SzYBWThLP29YqBiKV1/oGuFwlfjpxBatfd0d5rA2w=;
        b=U76+FhmAASPMcI/XGIlJnnHiDExFE9LQD9Jv5/uUE9L0CSvuU3S9+jhWgTPvfnD9wu
         xCDOplcZxQ6KhXbQexJ3JvTpZBugujfaflg/K6aga2gEFG8oLoInRcCG5sz/C2c7NsdW
         x4k9k2Ajfi3GCWUMVsylWyc2ooUySsCciXJmku2fms5AVl52NKotRQAAtc1JXspfJVCC
         Wkjt5siDjbagraCGAEBNMuvWEbnqoLGTQ3SLGUCGeI72fydKQeXuf7MTL+Xi2LVtLjSp
         AMKIWJGxNgzjykv1M38pKeclZv7NnSvn6Pm2tsSKwbARnFppAy2hbHDtUArYkS0VYfHg
         IwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706131658; x=1706736458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5SzYBWThLP29YqBiKV1/oGuFwlfjpxBatfd0d5rA2w=;
        b=hB7MO6YwHdm5OwQLaPbbBrcHv5SfVfe/2dOTP/emV46Qdw29IGCsPslJ9ySfLocVNQ
         eIuzcqG/kTAUjhOLEHxW/OYvbBcbN6UsAsGllHBsoSgmEs8s7ibCMN/3VMj8Qm7AJYCe
         lbQCi1/1kTdCm42L/IN34+DyU6Jyj9qTx1lwBxIVTShvIaA+4h/C1PUycXPstzC56h/2
         id0LTagfqTXa9f7m3G5wTQF6igAi/87kQhUofFQtiILA3ffeNzon6NdF0fpx/TMYwc2X
         VXmTDve+B+T24egpuO+zqa+6zYH6BOnpQN2rXsix8U+PcZ+GsGfH2EghOU9foEQfoGIO
         VVpg==
X-Gm-Message-State: AOJu0YzzK7Y625exleWz7SaxBqshPqI4v/by5+l9Gr8wFFRkgaF54vyp
	LdRI+581Nh8/70rDBGVL0ixzXLjaFOJF5IwkXnyoWl/cNuW5klg1dabcBrBMVx6L7nxxXziWv81
	2zZqwuqpZot3CKhQJer6KLdq0YcQ1Z27givr9
X-Google-Smtp-Source: AGHT+IHLUxnD+S8k/LidOhPXZetpLg/bV14wMev6SS1Cx+xwnEmGuy2SmETlMwfJ9REVi3suaTskX1DPqrs38ZFhjKw=
X-Received: by 2002:a05:622a:229e:b0:42a:5fe1:e8d1 with SMTP id
 ay30-20020a05622a229e00b0042a5fe1e8d1mr67647qtb.4.1706131657624; Wed, 24 Jan
 2024 13:27:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
 <20240122225710.1952066-4-peter.griffin@linaro.org> <da30a68a-e29f-45c8-aa73-02955255a457@linaro.org>
 <CADrjBPor5tMY4r0jOy7GH36auCU7dWn6Qn4ct89bsSMW4vAQOA@mail.gmail.com>
 <6c72a521-1048-42eb-ac74-d8f718a90723@linaro.org> <CAGETcx-CCpaV7R0O0HpDpoX6KxQBuJiMmKdWA8nDE-5Qj2Sa7g@mail.gmail.com>
 <f4d3aa5a-e01d-4ef3-8004-b6eac4461184@linaro.org>
In-Reply-To: <f4d3aa5a-e01d-4ef3-8004-b6eac4461184@linaro.org>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 24 Jan 2024 13:27:01 -0800
Message-ID: <CAGETcx_HGcuGQTO11tzX0EvnuLEaKYc4vBse1CRP0JwPqMJdQQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] watchdog: s3c2410_wdt: update to use new
 exynos_pmu_*() apis
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, arnd@arndb.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net, wim@linux-watchdog.org, 
	conor+dt@kernel.org, alim.akhtar@samsung.com, jaewon02.kim@samsung.com, 
	chanho61.park@samsung.com, semen.protsenko@linaro.org, 
	kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
	willmcvicker@google.com, linux-fsd@tesla.com, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 10:27=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/01/2024 04:37, Saravana Kannan wrote:
> > On Tue, Jan 23, 2024 at 10:12=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 23/01/2024 18:30, Peter Griffin wrote:
> >>>>>               dev_warn(wdt->dev, "Couldn't get RST_STAT register\n"=
);
> >>>>>       else if (rst_stat & BIT(wdt->drv_data->rst_stat_bit))
> >>>>> @@ -698,14 +699,6 @@ static int s3c2410wdt_probe(struct platform_de=
vice *pdev)
> >>>>>       if (ret)
> >>>>>               return ret;
> >>>>>
> >>>>> -     if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
> >>>>> -             wdt->pmureg =3D syscon_regmap_lookup_by_phandle(dev->=
of_node,
> >>>>> -                                             "samsung,syscon-phand=
le");
> >>>>> -             if (IS_ERR(wdt->pmureg))
> >>>>> -                     return dev_err_probe(dev, PTR_ERR(wdt->pmureg=
),
> >>>>> -                                          "syscon regmap lookup fa=
iled.\n");
> >>>>
> >>>>
> >>>> Continuing topic from the binding: I don't see how you handle probe
> >>>> deferral, suspend ordering.
> >>>
> >>> The current implementation is simply relying on exynos-pmu being
> >>> postcore_initcall level.
> >>>
> >>> I was just looking around for any existing Linux APIs that could be a
> >>> more robust solution. It looks like
> >>>
> >>> of_parse_phandle()
> >>> and
> >>> of_find_device_by_node();
> >>>
> >>> Are often used to solve this type of probe deferral issue between
> >>> devices. Is that what you would recommend using? Or is there somethin=
g
> >>> even better?
> >>
> >> I think you should keep the phandle and then set device link based on
> >> of_find_device_by_node(). This would actually improve the code, becaus=
e
> >> syscon_regmap_lookup_by_phandle() does not create device links.
> >
> > I kinda agree with this. Just because we no longer use a syscon API to
> > find the PMU register address doesn't mean the WDT doesn't depend on
> > the PMU.
> >
> > However, I think we should move to a generic "syscon" property. Then I
> > can add support for "syscon" property to fw_devlink and then things
> > will just work in terms of probe ordering, suspend/resume and also
> > showing the dependency in DT even if you don't use the syscon APIs.
> >
> > Side note 1:
> >
> > I think we really should officially document a generic syscon DT
> > property similar to how we have a generic "clocks" or "dmas" property.
> > Then we can have a syscon_get_regmap() that's like so:
> >
> > struct regmap *syscon_get_regmap(struct device *dev)
> > {
> >         return syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
> > }
> >
> > Instead of every device defining its own bespoke DT property to do the
> > exact same thing. I did a quick "back of the envelope" grep on this
> > and I get about 143 unique properties just to get the syscon regmap.
> > $ git grep -A1 syscon_regmap_lookup_by_phandle | grep '"' | sed -e
> > 's/^[^"]*//' -e 's/"[^"]*$/"/' | sort | uniq | wc -l
> > 143
>
> Sorry, generic "syscon" property won't fly with DT maintainers, because
> there is no such thing as syscon in any of hardware.

Then why do we allow a "syscon" compatible string and nodes? If the
"syscon" property isn't clear enough, we can make it something like
gpios and have it be <whatever>-syscon or have syscon-names property
if you want to give it a name.
143 bespoke properties all to say "here are some registers I need to
twiddle that's outside my regmap" doesn't seem great.

> >
> > Side note 2:
> >
> > How are we making sure that it's the exynos-pmu driver that ends up
> > probing the PMU and not the generic syscon driver? Both of these are
> > platform drivers. And the exynos PMU device lists both the exynos
> > compatible string and the syscon property. Is it purely a link order
> > coincidence?
>
> initcall ordering

Both these drivers usr postcore_initcall(). So it's purely because
soc/ is listed earlier in drivers/Makefile than mfd/. And as soon as
drivers are made into modules this is going to break. This is
terrible. If you want to have a modular system, this is going to throw
in a wrench.

-Saravana

