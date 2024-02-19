Return-Path: <linux-kernel+bounces-71610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9742785A7BB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38609B2130A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B473A1DE;
	Mon, 19 Feb 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X4tEdKw3"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED5339840
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357475; cv=none; b=bG33yY0V1k/Hpyk/QiK0H2F7RsGg96zYMxYsZFBmG2mc37Uowfbksw0SodgVxIVwJAbx956N+RsdpW8Etlu/4lFDeYYamHpFlfOh1VH9EuxyML8MbQAloUedvGs3JWy4UZ4IIT43DndO+CtEEmMRHjW7AczUbq6rmUbsZ4eokgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357475; c=relaxed/simple;
	bh=scapKyQRwA19QJoXyDPy0Su1Y5BbkWzjljaaLXpiXXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFQIEtGGLGlqQ0ss/8MybjDFzT47hqpzs8eIYQoYvvof6BYoKir2Ik8MkwMUp0iBmpgblvjdnG447dGXNWM+N73u2Uo3BKULwnI4M8mkM1K8HK9gReWYs8K8eRBlJbMTarnEPIVJy1I8Z7B7gURRUgziz8Pn5YQ2phHv+BF3w6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X4tEdKw3; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d5c890c67fso2139357241.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708357473; x=1708962273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZD/EM3SyhaILUHJgKgYH13JzV9F9I9A7ZoCf0KZhH9M=;
        b=X4tEdKw3zgChjbs7FYEQhueR+CG+alJQ1fBTOjk7mS5PnSc+sA4tk/6oKch+YhDd1h
         Rt5wHZw4mcrSS13qQU7UyWvvYBPCQ7qcxmxVObviCiSmIpDdtMouH6WiV9Un1vCSliDo
         O3s4s3J7cjjnO5kTJeJJBqHFrx6viUFAl+BMiGuvt5bqz+hmvA85tT9IlNNeGE7b1mmn
         aKTvcfVYPxOdhWl6EaYZW1QZ73IQjQQ5sXOAZrdMgZu9a+58vPPbPSFIBW++RTT4LErl
         gZopxM7B33iunfoleUO+fzFKWCImrGHbQurfvznCQhD4Vpi9KQrgiLPl23vStx7syPL/
         ABLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708357473; x=1708962273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZD/EM3SyhaILUHJgKgYH13JzV9F9I9A7ZoCf0KZhH9M=;
        b=q4gwvGtFdnLcuKgHXDPerf5r/c+TrWtBqWE4/8MK/tGkQ9P03h4s+sSl00hRnn0xob
         5GbXvTLCVxxY5W7Trp9lzSmeaytnx5MmWRoUiYl5kK3rI+WPgIEsG8n10pX5jAyFUmxA
         2XJXh0xk7RbtYHJVEeb4+DwkM/MNW6FPZalD3eC/IHedDVClDLwOqmkYrBjwGPfpYMX2
         /51B6+dMyAGde8aLaCL4l5JnHDiVVh9syvNBFkTqDdWeV6/fszgWX+t9vhWahaLEXO+q
         j27HEtGiBqFHkutuTkfGuNzGL3QCDLyOVUj5S7X+6A1KNpekwkSf3QcWaFhEXbEAi35s
         tI/g==
X-Forwarded-Encrypted: i=1; AJvYcCXOlAlfm5sW/v00E6/Rhd8t6J9LXqb4Dd1NzR+edq4Pkm6G32SDl+fyaflZ4sF6Z/9mFMZ7WD81F/CZrimTzYy0W84DFw4xBd+9XCaL
X-Gm-Message-State: AOJu0YxrJV/SkoDdl3aP6Qso0IkRlRCmJM59WzwRXCm6hehQLhDgjd8a
	Kz0VbfmIkm/iDj/zOtyJo1VWU12/TgK9Zaj+UO8pWnugXAymo4Cor8ig+kOhM18AfyLrEPob7Dl
	KsEBCMb1LPqufZbl2ryFL3aBg6N2zXV/KIlK5bw==
X-Google-Smtp-Source: AGHT+IHcxeUZmxVYxUCGPtgB71dVPhAzF5DX1jSu8thYPPJY2f3JUx8PESy61uq6Kvu9hlkEpogZD227xE24GoTJoBg=
X-Received: by 2002:a05:6102:3679:b0:470:574e:9766 with SMTP id
 bg25-20020a056102367900b00470574e9766mr2196509vsb.12.1708357471314; Mon, 19
 Feb 2024 07:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 16:44:20 +0100
Message-ID: <CAMRc=MfLXCDXBiKKuEPZRjNoNiFN+gvhu+GjZkZ1SQuF1s4=UQ@mail.gmail.com>
Subject: Re: [PATCH 00/23] Rework Nomadik GPIO to add Mobileye EyeQ5 support
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:
>
> Hi,
>
> This patch series reworks the Nomadik GPIO driver to bring it up to date
> to current kernel standards. We then add Mobileye EyeQ5 support that
> uses the same IP block but with limited functionality. We also add
> features required by our newly supported platform:
>
>  - Dynamic GPIO ID allocation;
>  - Make clock optional;
>  - Shared IRQ (usecase: EyeQ5 has two banks using the same IRQ);
>  - Handle variadic GPIO counts (usecase: EyeQ5 has <32 GPIOs per bank);
>  - Grab optional reset at probe (usecase: EyeQ5 has a reset available).
>
> This GPIO platform driver was previously declared & registered inside
> drivers/pinctrl/nomadik/pinctrl-nomadik.c, side-by-side with the
> pinctrl driver. Both are tightly integrated, mostly for muxing reasons.
> Now that gpio-nomadik is used for another platform, we loosen the
> relationship. The behavior should not change on already supported
> hardware but I do not have Nomadik hardware to test for that.
>

I hope Linus can leave his Tested-by under this series then.

> We have some dependencies, kept neatly to the end. Those are:
> - The base platform support series from Gr=C3=A9gory [1]. This relates to=
 the
>   last four patches (20 thru 23), ie defconfig and devicetree.
> - The OLB syscon support series [0]. It provides reset and pinctrl nodes
>   inside the devicetree. This relates to the last two patches (22 and
>   23), ie resets and gpio-ranges DT props. GPIO works fine without it
>   if patches 22 and 23 are dropped.
>
> This has been tested on the EyeQ5 hardware, with the two parent series
> applied. It also works fine without the OLB syscon series when our last
> two patches are removed. It has been built on both Arm defconfigs that
> rely on pinctrl-nomadik: nhk8815_defconfig and u8500_defconfig. I don't
> have any Nomadik hardware to test though.
>
> Have a nice day,
> Th=C3=A9o
>

Are you targeting the GPIO branch with this or pinctrl? I guess GPIO
so I'll need Linus' Acks under the pinctrl patches.

> [0]: https://lore.kernel.org/lkml/20240212-mbly-clk-v6-0-c46fa1f93839@boo=
tlin.com/
> [1]: https://lore.kernel.org/lkml/20240205153503.574468-1-gregory.clement=
@bootlin.com/

Please advise the relevant maintainers that they should provide an
immutable branch for these series once they're queued in their
respective trees.

Bart

[snip]

