Return-Path: <linux-kernel+bounces-142585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1008A2D79
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F81B2283E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA0E56443;
	Fri, 12 Apr 2024 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sufxpuQj"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992754F87
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921482; cv=none; b=gVYqkxMch+vhHxda+zgph29FmLzzOo77+w8mEvMXA8h8Rav+XP8sNbm2tX3wJDQeHzL+6trmKddHj4DyB2Iz0KkkEeDXlHu8VPGlayB6JkxadDhPscnuc+mAB4mMGsBYRRqrT29DR/vbsxKROOAS9zDevmuyIuY4IdtPrV/RKU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921482; c=relaxed/simple;
	bh=ZoSyU+Qrcr9uh8qbOS2xd/lSpeAOebNenMFaShgPgOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvUboUBpzbN6tnxw7bAzMH9/s3i58ovKkjlj1FlV2sTJud8YvfuT8cQCbwWdWHcn2wuyBzMvNvbgp/Z4SyqqAAuSDbvTJEnci5mc21sDex42ZGkOv2KkFtYepViYFYVO56bf3vy4kBXFjQcdQzhhxR/VhPjsqV+1PS2rCQzJ5Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sufxpuQj; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ddda842c399so831315276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712921479; x=1713526279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qPNOn0GLuQk8KwNG0ziRn0Mun0YoWTdTe+51qrseWJo=;
        b=sufxpuQjwIwTinfC6VmHT9h7jX7ovJ+rsp4ScJr5FNhM9VaaN90WvFOI3lqG3h1krA
         c12vUkAlOM5vlGNeWGwEhbx1sxHNqvu/o2kPBvMz7J8nssIPSbitYQwnpQF9qGCE1yCM
         kXZOZM5ccVn3B/BYfpmak4eRTqCjZlBV7OPc7zac5m8Xlx9L4WQGW8ZfUa2ovJMGLn1Y
         UwolpslDcIMzy6R7fVMdTzwqdNIHhkfOlaFKXKaHStoUBPCiDF98MaOmMRx0sgMcFVQi
         QryzS8MOEQRHp4qmmH0fjXDjByBvUFS84yNukvnFLggbq14F8JUbnoFBPvQlnVrPJIPm
         oPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712921479; x=1713526279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPNOn0GLuQk8KwNG0ziRn0Mun0YoWTdTe+51qrseWJo=;
        b=k/qCMPw235eori1vXVzRha3Z8AtHHBqPYmFhzb/Pcn4RUVby9Z4+xU1AXWTAsXL4D1
         Mv0/kiTUvvsph01/o4AiOmaFn7TJdpH3BpNLoXUFXR0nF8AgJv9hA8vFIhCdatMFY1bV
         Kl0b3erlYMqxwWxs6biY9/j3MhwPG3pY1KX7oc06oDaQ7+mJsZFPB7cz3ApsKUGV67Vu
         9KJWrMyVqjtVaU+nkhI+Ps+SrcwRUM6tgZQbq3lREotP08RIWI3TF39Cc6jge/CJ5pVr
         jOtalE7qB2i4iS/DyofBtxbLCVUWRxhZL5TLQEVybwMhBJFVDjyr8lcLNG+kqja+yxXK
         EUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPItur2kbKIDZxqwhWJgD4xl/ouelHJ+yK40DkSIONLQbUVfz7rvaNSMouHqynnVSKnP+SYirZUZ+TIkw64QM74p2839h34xYWYBeL
X-Gm-Message-State: AOJu0Yxz9NcDH1hEleuogZc01X/NB9Dtu0j7aDGurE0RnwJO8xqq0znH
	wIzv3U37zFnZ1ra98h7NZdOtkwaLnXcvys6uwwICm/BBJGmJP9HEAl+Q34wFP+puKIjBxXhhn/i
	SttBS883+Hr2DnV16Fut6UIqxdkBIrVMb8SKuaw==
X-Google-Smtp-Source: AGHT+IEGrhRwJIjO4KiFsAW/ZNbIF+dkGaOgsaB02MvYBIzWfJNTMR4i8201QPvrr2Qs77dSB1uO3NhGLefzi1RtS4Y=
X-Received: by 2002:a25:810b:0:b0:dc6:9399:849e with SMTP id
 o11-20020a25810b000000b00dc69399849emr2180984ybk.11.1712921479121; Fri, 12
 Apr 2024 04:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Apr 2024 13:30:43 +0200
Message-ID: <CAPDyKFr405qt58wrqNdSn8bQPRqPKJ1omUZHS_VpQrX5zxUJug@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] clk: renesas: rzg2l: Add support for power domains
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 14:27, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Hi,
>
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
> +               writel(CPG_PWRDN_MSTOP_ENABLE, priv->base + CPG_PWRDN_MSTOP);
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
>
> Changes in v2:
> - addressed review comments
> - dropped:
>     - dt-bindings: clock: r9a09g011-cpg: Add always-on power domain IDs
>     - clk: renesas: r9a07g043: Add initial support for power domains
>     - clk: renesas: r9a07g044: Add initial support for power domains
>     - clk: renesas: r9a09g011: Add initial support for power domains
>     - clk: renesas: r9a09g011: Add initial support for power domains
>     - arm64: dts: renesas: r9a07g043: Update #power-domain-cells = <1>
>     - arm64: dts: renesas: r9a07g044: Update #power-domain-cells = <1>
>     - arm64: dts: renesas: r9a07g054: Update #power-domain-cells = <1>
>     - arm64: dts: renesas: r9a09g011: Update #power-domain-cells = <1>
>   as suggested in the review process
> - dropped "arm64: dts: renesas: rzg3s-smarc-som: Guard the ethernet IRQ
>   GPIOs with proper flags" patch as it was integrated
> - added suspend to RAM support
> - collected tag
>
> [1] https://lore.kernel.org/all/20231120070024.4079344-4-claudiu.beznea.uj@bp.renesas.com/
>
>
> Claudiu Beznea (9):
>   dt-bindings: clock: r9a07g043-cpg: Add power domain IDs
>   dt-bindings: clock: r9a07g044-cpg: Add power domain IDs
>   dt-bindings: clock: r9a07g054-cpg: Add power domain IDs
>   dt-bindings: clock: r9a08g045-cpg: Add power domain IDs
>   dt-bindings: clock: renesas,rzg2l-cpg: Update #power-domain-cells =
>     <1> for RZ/G3S
>   clk: renesas: rzg2l: Extend power domain support
>   clk: renesas: r9a08g045: Add support for power domains
>   clk: renesas: rzg2l-cpg: Add suspend/resume support for power domains

In particular patches like the above I would appreciate to be cced on
to help review, but I understand that it's easy to miss in cases like
this.

That said, maybe we should start separating and moving the
power-domain parts out from the clk directory into the pmdomain
directory instead, that should improve these situations!?

>   arm64: dts: renesas: r9a08g045: Update #power-domain-cells = <1>
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
>

Kind regards
Uffe

