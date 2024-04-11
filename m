Return-Path: <linux-kernel+bounces-140753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D989F8A18BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592541F245B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C141917548;
	Thu, 11 Apr 2024 15:30:29 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F465134A6;
	Thu, 11 Apr 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849429; cv=none; b=KOLujgScWDZe5TmMmzBlHx0BYX1EedGm9i1uVxmKVZg9R2UXzZcaef/Rcaf1gkzaOTTvrhcG+eHQkAjWibw7o1teZyZ9BsNxWc5lF3CYj3fGEXB43IhVAIRoJCMkCbdyyRXuhIni5QVYBzl9FrF/T58dlZYO2/4EByGCS8G7ZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849429; c=relaxed/simple;
	bh=ps1xOL6ELTTcn7yAkxq7TG9H88LTPOId2QS1+tyr4qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LV9IBKNgS6fF1zrMV6JbZge/SVdu3kTJQOBzNDBb3IvfTAQIOzelWBKenaHfxDul10QKKEDLtO/7UPXzpKtVTcbU4fJKhxeU6jLuEHQrxleOCknOV6Mla6J4Hh0hDkHHZO1SCGetJmfK7FM9n4yo6zYSGb11ipHZOETRFAipwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-617d4797d9bso54830927b3.1;
        Thu, 11 Apr 2024 08:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849425; x=1713454225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzJvHUhbTKkwyCzYyYOpeKZow/fyzwMhCB4qWJj26+0=;
        b=gwPLh13knDJbQ68O+fjEeB8nZHRDSMmEX//G4/JTVqBn2AdOKjwJ4DEnI5Ce3G7JDD
         IAE6IViZigUwgrSvQkd0Dsqe9w776fBQxxSBYk/qLEP9nZjhFNsdJ3hoGkkIvttMO0Yr
         ENDnA6yStaf1Kr/9g/j6zgIOY5KPlKwDvT90Bn+87KLmTih7FfvzrwJAs/ZvFCcEj3oX
         DMyodt707YrCtRf3tDIP2VPT1h1RzB+eD2pPiG7d1hLtTmEfnf1cjsLB7fKxOG+CVQY8
         yoB6cHaG5SXoIlxxP49JTaFm7pB+SA4F9ji+TyZgpYvEuFznzQQvFzLe8WeRN1shh9Ib
         NyvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhHGg2UrebrDiWezV9PBIoQKnqhNOVU5bDZ40+PnF4rGOPngYT2NZIET7f7dKgM4dCEhSvX6yMxT4SObgexp6P2RpmeR1Pz34g5yNjvAvsPqvOZT9R3ZfEsSQRP5MaZddHPje6Mqhku6r18BcX1JtdhHy2JvZIeO0DY4SoGTZtvxz6BmjhYNIhcMCiLo067AxOuYAYJ6JNOSZGVJfv8y3ruvw2PqNLw/A2zOpYGUH5asDpW1+P4pOSjjJMXLJ77HU9V6i9hcjU9Tg/iIFWEYOQyW2kXSDfWOqUk+ZOZSxrKA==
X-Gm-Message-State: AOJu0Yw1z+u1lZIwuy2vN8yIs50jggW7eaK1lYA9BXNSUx0umMBniSIg
	K//N8TpQIutVAIyJEgfREH4rFGeTBDEF6jNoBwZiJL/j9ZEO8FMVxXPBMidg
X-Google-Smtp-Source: AGHT+IGjkmgb/PRW5qBpRmJQ7gE0JwsUYvjq4rYZimiiwRrHd1DVbnft+SOh6C/YW0BZp+x1Rr9ImA==
X-Received: by 2002:a0d:db46:0:b0:614:2dcf:b5d6 with SMTP id d67-20020a0ddb46000000b006142dcfb5d6mr6360482ywe.23.1712849424999;
        Thu, 11 Apr 2024 08:30:24 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id o5-20020a81c545000000b006186d990dbbsm185932ywj.105.2024.04.11.08.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 08:30:24 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso8350732276.2;
        Thu, 11 Apr 2024 08:30:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxIYv+pzCliukR/uxhL1I2Fm4f20JfZxOADKvM/nQDYRF8rPeyNeSGXwwkUGTbRXEOKHNWSinqRP1KTagOfHPcZB24HMkawdfeZ7t8f3/tLdBqWx/9KkZ/eAsU3kWoRMWEsGLMWTrhHXDaXnnosIqF1lH0G4qvZjgnEt57ynl8Lu7ToETuj5yFsvKTjQJLn02N4mY51ZBGZzlV7AkWzAzYweVi/LtG3kR13r5EllILUn8IaZi/DofCmht9coleWIEVcYHaOnmeVGsVkp4DigHjvehHQzwaIzw/8Eul1xGrXA==
X-Received: by 2002:a05:6902:2b86:b0:dcb:e82c:f7d with SMTP id
 fj6-20020a0569022b8600b00dcbe82c0f7dmr7239402ybb.41.1712849424313; Thu, 11
 Apr 2024 08:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Apr 2024 17:30:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUesJe0396MsH9PSUMEq=sWx3BYc=QrAFzR2EVcLhm03Q@mail.gmail.com>
Message-ID: <CAMuHMdUesJe0396MsH9PSUMEq=sWx3BYc=QrAFzR2EVcLhm03Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] clk: renesas: rzg2l: Add support for power domains
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linux PM list <linux-pm@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

CC pmdomain, watchdog

On Wed, Apr 10, 2024 at 2:27=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> Series adds support for power domains on rzg2l driver.
>
> RZ/G2L kind of devices support a functionality called MSTOP (module
> stop/standby). According to hardware manual the module could be switch
> to standby after its clocks are disabled. The reverse order of operation
> should be done when enabling a module (get the module out of standby,
> enable its clocks etc).
>
> In [1] the MSTOP settings were implemented by adding code in driver
> to attach the MSTOP state to the IP clocks. But it has been proposed
> to implement it as power domain. The result is this series.
>
> Along with MSTOP functionality there is also module power down
> functionality (which is currently available only on RZ/G3S). This has
> been also implemented through power domains.
>
> The DT bindings were updated with power domain IDs (plain integers
> that matches the DT with driver data structures). The current DT
> bindings were updated with module IDs for the modules listed in tables
> with name "Registers for Module Standby Mode" (see HW manual) exception
> being RZ/G3S where, due to the power down functionality, the DDR,
> TZCDDR, OTFDE_DDR were also added, to avoid system being blocked due
> to the following lines of code from patch 6/9.
>
> +       /* Prepare for power down the BUSes in power down mode. */
> +       if (info->pm_domain_pwrdn_mstop)
> +               writel(CPG_PWRDN_MSTOP_ENABLE, priv->base + CPG_PWRDN_MST=
OP);
>
> Domain IDs were added to all SoC specific bindings.
>
> Thank you,
> Claudiu Beznea
>
> Changes in v3:
> - collected tags
> - dinamically detect if a SCIF is serial console and populate
>   pd->suspend_check
> - dropped patch 09/10 from v2

Thanks for the update!

I have provided my R-b for all patches, and the usual path for these
patches would be for me to queue patches 1-8 in renesas-clk for v6.10,
and to queue 9 in renesas-devel.

However:
  1. I had missed before the pmdomain people weren't CCed before,
     they still might have some comments,
  2. Patch 9 has a hard dependency on the rest of the series, so
     it has to wait one more cycle,
  3. Adding the watchdog domain has a dependency on [1].

2 and 2 may be resolved using an immutable branch.
Are my assumptions correct?

Thanks!

[1] "[PATCH RESEND v8 09/10] watchdog: rzg2l_wdt: Power on the PM
    domain in rzg2l_wdt_restart()"
    https://lore.kernel.org/all/20240410134044.2138310-10-claudiu.beznea.uj=
@bp.renesas.com

> Changes in v2:
> - addressed review comments
> - dropped:
>     - dt-bindings: clock: r9a09g011-cpg: Add always-on power domain IDs
>     - clk: renesas: r9a07g043: Add initial support for power domains
>     - clk: renesas: r9a07g044: Add initial support for power domains
>     - clk: renesas: r9a09g011: Add initial support for power domains
>     - clk: renesas: r9a09g011: Add initial support for power domains
>     - arm64: dts: renesas: r9a07g043: Update #power-domain-cells =3D <1>
>     - arm64: dts: renesas: r9a07g044: Update #power-domain-cells =3D <1>
>     - arm64: dts: renesas: r9a07g054: Update #power-domain-cells =3D <1>
>     - arm64: dts: renesas: r9a09g011: Update #power-domain-cells =3D <1>
>   as suggested in the review process
> - dropped "arm64: dts: renesas: rzg3s-smarc-som: Guard the ethernet IRQ
>   GPIOs with proper flags" patch as it was integrated
> - added suspend to RAM support
> - collected tag
>
> [1] https://lore.kernel.org/all/20231120070024.4079344-4-claudiu.beznea.u=
j@bp.renesas.com/
>
>
> Claudiu Beznea (9):
>   dt-bindings: clock: r9a07g043-cpg: Add power domain IDs
>   dt-bindings: clock: r9a07g044-cpg: Add power domain IDs
>   dt-bindings: clock: r9a07g054-cpg: Add power domain IDs
>   dt-bindings: clock: r9a08g045-cpg: Add power domain IDs
>   dt-bindings: clock: renesas,rzg2l-cpg: Update #power-domain-cells =3D
>     <1> for RZ/G3S
>   clk: renesas: rzg2l: Extend power domain support
>   clk: renesas: r9a08g045: Add support for power domains
>   clk: renesas: rzg2l-cpg: Add suspend/resume support for power domains
>   arm64: dts: renesas: r9a08g045: Update #power-domain-cells =3D <1>
>
>  .../bindings/clock/renesas,rzg2l-cpg.yaml     |  18 +-
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  20 +-
>  drivers/clk/renesas/r9a08g045-cpg.c           |  61 ++++
>  drivers/clk/renesas/rzg2l-cpg.c               | 269 +++++++++++++++++-
>  drivers/clk/renesas/rzg2l-cpg.h               |  77 +++++
>  include/dt-bindings/clock/r9a07g043-cpg.h     |  52 ++++
>  include/dt-bindings/clock/r9a07g044-cpg.h     |  58 ++++
>  include/dt-bindings/clock/r9a07g054-cpg.h     |  58 ++++
>  include/dt-bindings/clock/r9a08g045-cpg.h     |  70 +++++
>  9 files changed, 659 insertions(+), 24 deletions(-)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

