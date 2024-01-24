Return-Path: <linux-kernel+bounces-37644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8C583B2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0932827D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA9B133985;
	Wed, 24 Jan 2024 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmCEc++6"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B3C13340F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127819; cv=none; b=sdcGv2MaxSOuhtA1uF0MhVUUF2GircUZnP9ObotHce2C/TZZbfsoEZ6bXJSFID0H6qQ4q8pqpcGEICi5tROOasfIbShup0483Umw8v+muZHop9+bSyTUrBN+ADqWqcryPROb+TRpOwvAQtb2Zo8KYYSzGAgKjhOcXSThWvGzT/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127819; c=relaxed/simple;
	bh=TjAqpdsT083fhHAEKJvt5yNIUpYUwxwS06SACyk0hzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FoiFGKBNXlA5pUNMgWiNVEOjm4BSTok4Pja34uNXhb4N+qwT93Snv78J0yAZzCDpd3oFLdwXUKx6I4ivFaaiAouDvZBxtjsED2eEtaPjjaJ2c739O4aO73T9f68D7EvwzJh3XCAhLt/ufWcTSeTBrrA98eLQ+gyQla5LQcI844o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XmCEc++6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d76671e5a4so23192515ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706127816; x=1706732616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hmcP/QQeHaGkE3qc5AwUJsU9CmjS1G7i7dszRGZnLA=;
        b=XmCEc++6pzH0LZUhFDm+Z3Wq3gcOOLwwA8ZuvJVZpEgTlS3K/Q66RIPNMykAXAdU0F
         7u0fqoK28k5IMHS6wIbOcFVlNXyz59YQHiIbnNKUk+wanT78cGXKagKEg+57yOCtcFxF
         WIq3IofJcmkA8zx4qBVHVjRs7kr/XZnx68Jgi8Fh+gQBLqmD+qgLyNs7OafCLZsEA6w/
         N1LQCGQkU8XhJObjCo4FM+bnxkryTC70cLNXyKIciBxy+f+og21VWke0Ee+Wl0GYVRRB
         NdFQJh48JbA5dzDL9RNsigPUL4sXHn58kSDmnba7AOPop4RsVpttxn1/cZtszCzZdP2a
         0iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706127816; x=1706732616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hmcP/QQeHaGkE3qc5AwUJsU9CmjS1G7i7dszRGZnLA=;
        b=u8lEFqZxoXEq69QYliY6T8JlG91dfLVMuV+7g2h54mdZTKotNNKekkls6nLXmz/hU7
         exnerFNdQSJrT1nIgxG4S4m9u6jodsd9Vnhf9SLzSr8RwwLmxzaoQDjBOpasfMUVisE9
         oJH1BuWMFkHHUThPxRwfV7nwYYKcHz2uAjbD+WOpGQmLy+INnvpiKYIwD4Pak77RZSoI
         Y8E3Pu83MZN+U8Zk92waWIy5jB50RZ3oXZEaanxPIae4ARM6w2UzTY/RchnqYcXNLsYg
         6Q7jev+TR+y2dasCXMeWhDPeDyB2JWP/JxzMWYB83QJvha5AxCX8gAFCRsbgSPy2t/AO
         OS/A==
X-Gm-Message-State: AOJu0YySLa/baSjRJANuuRcWPQD3WQQh8oE2upakoZgv1oQzolFCwLjg
	zdBqhU9J/uSz7RLHkPp5K+8KCX7ik3dXqJcQ6nnH5YcymlAG9lOriR2g65AF9RR0wT7xEmqMnEK
	OneIKHtgFIsIMsQn2IH+wKaAahNQEKR0mJAhb1g==
X-Google-Smtp-Source: AGHT+IGjSUG97VtcSprWmDph87pKYkTflh1fXOYMFNCL6uA4yn/LTCIGlCNQsdB8V/Us8yTWcZd6qjpc5NSp9PW5580=
X-Received: by 2002:a17:90a:c685:b0:28b:6b90:3d69 with SMTP id
 n5-20020a17090ac68500b0028b6b903d69mr90245pjt.76.1706127816537; Wed, 24 Jan
 2024 12:23:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
 <20240122225710.1952066-3-peter.griffin@linaro.org> <CAPLW+4=G5YiTZaZ5k=H1YciUwOEjKSF0w9Hd8rwymA71UmJnRQ@mail.gmail.com>
 <CADrjBPqbToXYUBx=reE5_W4U4aUUJRFs+FC5AHsrQ6mRYB9iAA@mail.gmail.com>
In-Reply-To: <CADrjBPqbToXYUBx=reE5_W4U4aUUJRFs+FC5AHsrQ6mRYB9iAA@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 24 Jan 2024 14:23:25 -0600
Message-ID: <CAPLW+4=2dx3T=Snn-WstAQXhrDNE3as1Qgjr+LK+xwscHivBBQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] soc: samsung: exynos-pmu: Add exynos_pmu_update/read/write
 APIs and SoC quirks
To: Peter Griffin <peter.griffin@linaro.org>
Cc: arnd@arndb.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	linux@roeck-us.net, wim@linux-watchdog.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, jaewon02.kim@samsung.com, chanho61.park@samsung.com, 
	kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
	saravanak@google.com, willmcvicker@google.com, linux-fsd@tesla.com, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 4:02=E2=80=AFAM Peter Griffin <peter.griffin@linaro=
org> wrote:
>
> Hi Sam,
>
> Thanks for the review feedback.
>
> On Tue, 23 Jan 2024 at 18:56, Sam Protsenko <semen.protsenko@linaro.org> =
wrote:
> >
> > On Mon, Jan 22, 2024 at 4:57=E2=80=AFPM Peter Griffin <peter.griffin@li=
naro.org> wrote:
> > >
> > > Newer Exynos SoCs have atomic set/clear bit hardware for PMU register=
s as
> > > these registers can be accessed by multiple masters. Some platforms a=
lso
> > > protect the PMU registers for security hardening reasons so they can'=
t be
> > > written by normal world and are only write acessible in el3 via a SMC=
 call.
> > >
> > > Add support for both of these usecases using SoC specific quirks that=
 are
> > > determined from the DT compatible string.
> > >
> > > Drivers which need to read and write PMU registers should now use the=
se
> > > new exynos_pmu_*() APIs instead of obtaining a regmap using
> > > syscon_regmap_lookup_by_phandle()
> > >
> > > Depending on the SoC specific quirks, the exynos_pmu_*() APIs will ac=
cess
> > > the PMU register in the appropriate way.
> > >
> > > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > > ---
> > >  drivers/soc/samsung/exynos-pmu.c       | 209 +++++++++++++++++++++++=
+-
> > >  drivers/soc/samsung/exynos-pmu.h       |   4 +
> > >  include/linux/soc/samsung/exynos-pmu.h |  28 ++++
> > >  3 files changed, 234 insertions(+), 7 deletions(-)
> > >
> >
> > [snip]
> >
> > > +
> > > +int exynos_pmu_update_bits(unsigned int offset, unsigned int mask,
> > > +                          unsigned int val)
> > > +{
> > > +       if (pmu_context->pmu_data &&
> > > +           pmu_context->pmu_data->quirks & QUIRK_PMU_ALIVE_WRITE_SEC=
)
> > > +               return rmw_priv_reg(pmu_context->pmu_base_pa + offset=
,
> > > +                                   mask, val);
> > > +
> > > +       return regmap_update_bits(pmu_context->pmureg, offset, mask, =
val);
> > > +}
> > > +EXPORT_SYMBOL(exynos_pmu_update_bits);
> > > +
> >
> > This seems a bit hacky, from the design perspective. This way the user
> > will have to worry about things like driver dependencies, making sure
> > everything is instantiated in a correct order, etc. It also hides the
> > details otherwise visible through "syscon-phandle" property in the
> > device tree.
>
> In v2 I will keep the phandle to pmu_system_controller in DT, and add
> some -EPROBE_DEFER logic (See my email with Krzysztof).
>
> > Can we instead rework it by overriding regmap
> > implementation for Exynos specifics, and then continue to use it in
> > the leaf drivers via "syscon-phandle" property?
>
> I did look at that possibility first, as like you say it would avoid
> updating the leaf drivers to use the new API. Unfortunately a SMC
> backend to regmap was already tried and nacked upstream pretty hard.
> See here https://lore.kernel.org/lkml/20210723163759.GI5221@sirena.org.uk=
/T/
>

Oh, I didn't mean creating a new regmap implementation :) To
illustrate what I meant, please look at these:

  - drivers/mfd/altera-sysmgr.c
  - altr_sysmgr_regmap_lookup_by_phandle()
  - arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
  - drivers/mmc/host/dw_mmc-pltfm.c

They basically implement their own regmap operations (with smcc too)
in their syscon implementation. So they can actually reference that
syscon as phandle in device tree and avoid exporting and calling
read/write operations (which I think looks hacky). Instead they use
altr_sysmgr_regmap_lookup_by_phandle() to get their regmap (which
performs smcc), and then they just use regular regmap_read() /
regmap_write or whatever functions to operate on their regmap object.
That's what I meant by "overriding" the regmap.

Do you think this approach would be clearer and more "productizable"
so to speak? Just a thought.

> regards,
>
> Peter.

