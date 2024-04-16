Return-Path: <linux-kernel+bounces-146112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BD68A60D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B23B282C09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531C210A0A;
	Tue, 16 Apr 2024 02:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEHJIIIK"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9EBAD55;
	Tue, 16 Apr 2024 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233771; cv=none; b=JGfxD5MEpuOIOIDyEmb6xgxPulqUwsfbNW3HNi5LJkrZxnm8No/5H//Xy+KsCeQfcFsffr7I3tAuCa6Bmo5zwip0i+eTSUEZtSMev67thkd5Yo17xjNnoUFWGZj0vrZ+Cva/HKbyYUvXFU/nM9+0WLgKk8QBp6xIhjEStC+zII0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233771; c=relaxed/simple;
	bh=QrXgwbe0NdYDpBlQ3uOZu0s/fNclISOYfAUWixmFQ9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWQujZdxsn7ZcvW5ywQU+BLoUN7/MrKcqmaD11t8/uTuR5xzdCV3DXwZQGzSVcm8BJ2EgVS7cNNsDHB6PZhhz13MpiXfU9Qn/7L/R6lMJOXMvQBbK0cd1XcZbK5nuafX8mgg5B/dZQT0ia7wAFfjZIhe3Ai7Ecg2skGneV/peEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEHJIIIK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-417f5268b12so34102525e9.1;
        Mon, 15 Apr 2024 19:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713233767; x=1713838567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OsBMHLE1GlLux45lTQMk2XlrRux1EVi8/1F5HxUcNI=;
        b=KEHJIIIKiOVCFPqmMWQN9NxFLVXi/3T0hfp9jNkL5prj1uvVpUv5b4Pe2vlpO+NdIx
         BGytfaMmQjL1G06LTgmoRompgcjazYhtbS/02ySwf53IeCtX/H7OsBJyUsMkfdzpS4Ug
         KGSD8072OTjC7QQSNSGjQ7EwDndxyaQBAN/y9aPv7Ca2Xi51Wa4lut37ZpTbHIBz1/Rm
         LUDL/r9oy2c4XlqJNgreaatdKJeIilpmHL2a/KY/md/pZkNQl8+3tMTA9LvkZTBnn/Gk
         zH7pFevKB42GP6unoJBh7Ld2HAgErZoYcDAdi6tW5ZW2kK1PVBDWyJkrLIv9NF8Oauzg
         VFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713233767; x=1713838567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OsBMHLE1GlLux45lTQMk2XlrRux1EVi8/1F5HxUcNI=;
        b=BYoCQkHiRtiZ93PQARb23/JdOQtX7xiEgvWKHDIpbWNOO54sTsX8CiIbKBmqFm2mES
         XR3bL7D7268SD1zXSXCm7TanYMLGEz8WISduXpgiLRduZr7WeN3xNnmEA9n2Zd0colQR
         YpcqmkpscNkFr+nZZtzkumsjSYmCjPuJ08pdaDyx8JEEPqAlo5kD+W0rB2X72YKD9k1+
         oGoiOug8m5rZwnQWjapHmVz470PElTgBD/zPf/aAc0Y1Sqd+chJsh1WRzzzQ3l7Ckpji
         Eiveq6nESQlTrEiEkqxeJcyns5y8sgfvXK3X0tZ2EWFB8qG289gIWM9y+ci/OhJIrQpS
         su3w==
X-Forwarded-Encrypted: i=1; AJvYcCWrqA2i2KYnB1h7+PvP6XDGJ2bqLkmzVhyyzjxXf1Fj7WoUG02tLg2CFhE2+0BqzuJ41WmeqOoe0hDEhj1pD3/aVmhlRH/2NYu0lAOJTphjWWMoSMRZ/ecthFIzA6Lfo84dFyQhEYo+
X-Gm-Message-State: AOJu0YxBqOnqswLAsl9SaNWfEgE2fIF4mYWQp4jH2Ulr4W0U/7GBiPsj
	oDxtFRIxo0ooFzYtrsmnjKqEToZjDtUwAofMmEXNhh8TZWeQ/rYuH2qbWZ+iIoXRnrKlcKRU/9o
	EK+JbAXhbcTKwk3R3UXXSOvoSv/o=
X-Google-Smtp-Source: AGHT+IF9XuMWnWIt8S+ove2KmhsFIhFjD01Sjo3IWJRcFZe/vNtbUrsppZRB29xdom0zZ4Tivy1HRToWmbHCu/TwWdY=
X-Received: by 2002:a5d:4f84:0:b0:346:66d8:f7ac with SMTP id
 d4-20020a5d4f84000000b0034666d8f7acmr10382591wru.31.1713233767310; Mon, 15
 Apr 2024 19:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415070620.133143-1-richard.xnu.clark@gmail.com>
 <52c08a01-8357-44dd-b727-a06438ec6c30@intel.com> <ZhzVmmndefd5zDFh@shell.armlinux.org.uk>
 <CAJNi4rO16FDmRUCWyK=+DF5TbfryJLsX3VUN3j1mAeas7Rh84w@mail.gmail.com> <Zhzj7+nm8q03+p4g@shell.armlinux.org.uk>
In-Reply-To: <Zhzj7+nm8q03+p4g@shell.armlinux.org.uk>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Tue, 16 Apr 2024 10:15:55 +0800
Message-ID: <CAJNi4rNbhGZyap6pdk+aKojs7Nh-Qb0BtCFWSitxd4YiSp8xRg@mail.gmail.com>
Subject: Re: [PATCH] sdhci: Fix SD card detection issue
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:23=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Apr 15, 2024 at 04:17:14PM +0800, richard clark wrote:
> > On Mon, Apr 15, 2024 at 3:22=E2=80=AFPM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Mon, Apr 15, 2024 at 10:18:39AM +0300, Adrian Hunter wrote:
> > > > On 15/04/24 10:06, Richard Clark wrote:
> > > > > The mmc_gpio_get_cd(...) will return 0 called from sdhci_get_cd(.=
.), which means
> > > > > the card is not present. Actually, the card detection pin is acti=
ve low by default
> > > > > according to the SDHCI psec, thus the card detection result is no=
t correct, more
> > > >
> > > > SDHCI spec covers the SDHCI lines.  GPIO is separate.
> > >
> > > ... and the key bit of information that should be mentioned is in the
> > > case of a GPIO, the GPIO library can be told if a GPIO is active-high
> > > or active-low in either firmware or via the GPIO lookup data, and thi=
s
> > > should be used instead of drivers inventing their own "quirking".
> > >
> > Agree! But unfortunately, it seems I can't find the right place to
> > handle this from either firmware or via the GPIO lookup data. Will be
> > appreciated if any suggestion about that?!
>
> If you're using DT, then, for example:
>
>         cd-gpios =3D <&gpio1 4 GPIO_ACTIVE_LOW>;
>
> is all it takes. If you are using firmware then GPIO lookup data isn't
> what you should be using. I'm afraid I don't know the ACPI bindings for
> SDHCI.
>
Ah, this seems to be a bug of the Nvidia DT, its cd-gpios=3D<... 0x00>
meaning the GPIO_ACTIVE_HIGH, but the CD gpio value is 0 when the card
is inserted. In the kernel v5.10, the sdhci-tegra use below logic as
the card present indicator:

if (!host->mmc->cd_cap_invert)
        host->mmc->rem_card_present =3D (mmc_gpio_get_cd(host->mmc) =3D=3D =
0);

But the newer version kernel removes the 'rem_card_present', and the
CD gpio still value 0 will be interpreted as the card is not present,
thus the issue happens...

> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

