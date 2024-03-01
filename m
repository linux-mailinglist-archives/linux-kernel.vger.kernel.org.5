Return-Path: <linux-kernel+bounces-87728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3525986D840
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6945286A04
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C84DED8;
	Fri,  1 Mar 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rb2xw5py"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0836637
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252040; cv=none; b=Q/F0MIqjuS5gppPGM0Kl0sl2spUWj10DuIValcKX5Q8J9XYfKq4HK457dQULlGt2GD1bVvb2V6ASgotq+INtTu+f3Yc0J40AV+6ZDM33wQmakwA/2T9cYIVLOXd4Hjvour5JFX9rkjqmDSUEFDEUFVc+AtOvSrT8QNqJ1nCUjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252040; c=relaxed/simple;
	bh=B77zXAY7NX+hLCgtlHoHQZKOlzjnqvlnrS5iyu5Gmzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTERW88DVRnrz3k2D28Fj+rxmuuLN5sQT4ir+u9J3DNhVFk1CU6U/S9AxnQoSS5cHOghBqNEeV+2EIiqFwysEZ9VxYx5tB/arrb/R+xeo54CbsHHsBDaNz+YGiRo53/xbRiRYmSxlInChJKUhx/vnxnm4zy+YYtOksMnDu9nokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rb2xw5py; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1480958276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709252038; x=1709856838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLlphw7nE1d10G8LoA31OXvx3bAVEuRzrK0UD0ow18Y=;
        b=Rb2xw5pyhleWT1kVIMdUvrKruRecKdZUMVewKkL4g37A+Zf3uPR8CEgGrilDeg+g2H
         brrpt7/UJPSKWAssHfZad7uP9DWXUO4zhPGXktWp1sm86QIGI7yVEnQNdIw2I+rvBy+J
         HxgnZKoCpFUg1g+hLYcG/ZZ+ljP9JqBMRM3i1qPkOmUjVJ8tFsrWqTilNR88a9m5rsis
         8vybPZyGrk52N8vhc2BPBjH27oH1cN7Z7TGYjC5u6iqLjIutDGBxrkWwpAdFnS1GrpUu
         hWOv++ZyF6MoCJAqPPR7ajkGL48576lkOaKv0ZgVtsNsxiooT9PXM4RcUjMAZr2osm6x
         5i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252038; x=1709856838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLlphw7nE1d10G8LoA31OXvx3bAVEuRzrK0UD0ow18Y=;
        b=rIXhYXJ+EvyR5M4xwDp1trcOUGI644VDaA25VxUkrtOopKoLhGtyRJZuQOA3w2k/pz
         +lxnHALzp2QTomm+zqpHFFHtQlzqNEBrEK302l3/cR9FIVSbIwLVaGHgzS3o6QB+NWbJ
         vGG2Ix08jgOtQpCqxw9avnGZ4nMkBaOkVZ+6JiRu+0yAdMAv7z9egbfYfSE0MKiQ2FOm
         ufk/XrfX35/rmzr62d0jdQWut/HIpk8GxooC0BDFmZKF5aS7mxDetxlC2NTkBkL0bKjn
         8TcN5j3pw/fzlPqneM8bGWNRZe5WympyjOvQk0PBMcrVZVh1tv3dXziQQ+Cf6TvlVYXW
         Mpbw==
X-Forwarded-Encrypted: i=1; AJvYcCXxuHyDTeIzJigfhvqk/nNJ2sf2Y+gyAkrKI4QFXJJQixQ53Q5UtydYlSdz35z78V6LwT0yKnViC8JFdRuwXTwVRodm/Qhoui5th4Y0
X-Gm-Message-State: AOJu0YzPJyOqYVmSewepz7hidsPTpx4nZfA2ithwG6xdhPt4wDHJd+a7
	4JEEnBYGJSQZlXwRFsY1TjjPOisBcPJhiY94FKUyWjWCKTezd/V08kdPOHos02QEuGgSJWjXYog
	jJRSC/ftifz9PK8ciURptQlGe1gOgTuysGZS3uA==
X-Google-Smtp-Source: AGHT+IH770lzA7jOGiVJV3Rk4QvcMP4AclSBKAf8hM1iddLpLpGemJ0dFBPptvXum0NpWEymHDWNu52zo/kwKvbgXZc=
X-Received: by 2002:a5b:4c4:0:b0:dc2:3279:fde5 with SMTP id
 u4-20020a5b04c4000000b00dc23279fde5mr36453ybp.22.1709252037815; Thu, 29 Feb
 2024 16:13:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229122021.1901785-1-tudor.ambarus@linaro.org> <20240229122021.1901785-5-tudor.ambarus@linaro.org>
In-Reply-To: <20240229122021.1901785-5-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 29 Feb 2024 18:13:46 -0600
Message-ID: <CAPLW+4=jSr6ZsB7XekXsiUBm0SmVpVFnqpgjViuF3=HpT4gRAg@mail.gmail.com>
Subject: Re: [PATCH 4/4] clk: samsung: exynos850: fix propagation of SPI IPCLK rate
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, s.nawrocki@samsung.com, 
	cw00.choi@samsung.com, alim.akhtar@samsung.com, mturquette@baylibre.com, 
	sboyd@kernel.org, peter.griffin@linaro.org, andre.draszik@linaro.org, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	willmcvicker@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:20=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> Fix propagation of SPI IPCLK rate by allowing MUX reparenting for the
> dedicated USI MUX clocks. Since these muxes feed just the USI blocks,
> reparenting of the muxes do not affect other IPs.
>

It was actually done for a reason (at least in case of clk-exynos850
driver). Those top-level MUXes use CLK_SET_RATE_NO_REPARENT flag via
MUX() / MUX_F() macros to avoid re-parenting. See below for the
explanation on why.

> Do not propagate the rate change the from USI muxes to the common bus
> dividers (dout_apm_bus and dout_peri_ip). The leaf clocks (HSI2C, I3C)

The propagation to those dividers was implemented intentionally,
because AFAIU this is precisely their purpose. Not using those for the
derivation of HSI2C/SPI clock rates makes them effectively useless,
which as I understand wasn't the HW designer's intention. It's all
explained in details in the commit message of the patch which adds
this propagation.

> that are derived from the common bus dividers are no longer affected by
> the SPI clock rate change.
>
> This change involves the following clock path propagation:
>
> usi_spi_0:
>     Clock                  Div range    MUX Selection
>     ---------------------------------------------------------------------
>     gout_spi0_ipclk        -            -
>     dout_peri_spi0         /1..32       -
>     mout_peri_spi_user     -            { oscclk (26 MHz), dout_peri_ip }

AFAIK, the OSCCLK only purpose is to be used during suspend (PM
state). When implementing clk-exynos850.c I specifically avoided using
OSCCLK clock for the regular use-cases, and I believe other existing
Exynos clock drivers don't use OSCCLK during normal operation too.
It's easy to see from the clock diagrams in the TRM: all CMUs have
top-level MUXes that have two parents (normal clock and OSCCLK). In
fact, the TRM mentions it:

    "All CMUs have MUXs to change the OSCCLK during power-down mode"

Even if OSCCLK can be used in some cases for driving HW blocks, the
top-level MUXes are not related to those cases.

>
>     *Note that the clock rate is no longer propagated to dout_peri_ip.
>
> usi_cmgp0:
>
>     Clock                  Div range    MUX Selection
>     ---------------------------------------------------------------------
>     gout_cmgp_usi0_ipclk   -           -
>     dout_cmgp_usi0         /1..32      -
>     mout_cmgp_usi0         -           { clk_rco_cmgp (49.152 MHz)

I'm not sure the RCO should be used during normal operation either.
RCO purpose seems to be similar OSCCLK -- to serve as a substitute
clock during suspend, or maybe for calibration/debugging purposes. But
from the clock diagram it's clear they are not intended for the
regular operation. The only difference from OSSCLK is the frequency,
which is usually 49.152 MHz or 24.576 MHz for RCO (basically multiples
of 32,768 Hz), which hints those clocks are designed to drive some 1
Hz (1 sec) based timers.

>                                          gout_clkcmu_cmgp_bus }
>
>     *Note that the clock rate is no longer propagated to
>      gout_clkcmu_cmgp_bus and dout_apm_bus.
>
> usi_cmgp1:
>
>     Clock                  Div range   MUX Selection
>     ---------------------------------------------------------------------
>     gout_cmgp_usi1_ipclk   -           -
>     dout_cmgp_usi1         /1..32      -
>     mout_cmgp_usi1         -           { clk_rco_cmgp (49.152 MHz)
>                                          gout_clkcmu_cmgp_bus }
>
>     *Note that the clock rate is no longer propagated to
>      gout_clkcmu_cmgp_bus and dout_apm_bus.
>
> This comes with no significant clock range modification. Before this
> patch the claimed clock ranges are:
>
>     SPI0:   200 kHz ... 49.9 MHz
>     SPI1/2: 400 kHz ... 49.9 MHz
>
> After this patch the clock ranges are:
>     SPI0:   203.125 kHz ... 49.9 MHz
>     SPI1/2: 384 kHz     ... 49.9 MHz
>

So as I see it, instead of using dividers designed exactly for the
purpose of changing I2C/SPI clock rates this patch instead uses OSCCLK
clock, which is not intended for normal I2C/SPI operation.

> For SPI1/2 we get an even lower frequency than what was before. For SPI0
> the benefit of not modifying common bus clocks, thus other leaf IP nodes
> is greater than the change in frequency from 200 to ~203 KHz.
>
> Not tested, the patch was written solely by reading the code.
>
> Fixes: 67c15187d491 ("clk: samsung: exynos850: Propagate SPI IPCLK rate c=
hange")

I fail to see how this patch fixes anything. Instead it looks to me it
replaces the (already) correctly implemented logic with incorrect one.
The SPI clocks are already functional and work exactly as intended
without this patch. The motivation was explained in commit
67c15187d491 ("clk: samsung: exynos850: Propagate SPI IPCLK rate
change"), which was thoroughly tested on E850-96 for all 3 SPI
instances, for all possible DMA/IRQ/polling combinations, with all
possible clock frequencies, and it seems to cover all possible SPI
cases. This patch seems to just change the behavior to something else
without solid examples of how the already implemented scheme (where I
specifically avoided doing what's done in this patch) could be broken
or sub-optimal.

[snip]

