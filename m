Return-Path: <linux-kernel+bounces-127580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2670A894DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04F31F2250D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C679847A53;
	Tue,  2 Apr 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zaicong3"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630934C601
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047649; cv=none; b=OrsD87MOoN31bGqxDBO9aSwnpsh99rofc+2/Eh2XZ2ZxkUb3jhIhf/70JMPxR9hjCUhjAscXYo5DjDQux9NiPRtFy3L4+mqBAkCxab7ra04sPBB5dk2gRSNwo1Bk920E7nHXScC+wUZePshOeqk/svB4Yea10k4il1vSYNOmR1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047649; c=relaxed/simple;
	bh=+AK51JrCGWuO08CfOOYPWGt0hQBmi3PXvUdv4wEQ8RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IptimWi3v8pOXp+ajkRJtAW7env7XOYLaBL5ETIoMZtnMhrpp7mu/uu637z8fyzTogJALoZnm21AZx2cDlzBiil2xiH3o9mKLtv5N5vJWYAZvYjjMhFzHv6y4fiZ7uWLQvu4U4e+Vi0JQygvpJxShvljnK/Stxbb8qPAu7jj4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zaicong3; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d71765d3e1so49569971fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712047645; x=1712652445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tl54XsFsvBlKI4m/HT6I/Yf3GgpXgDuhAYJ/cKm2Ytg=;
        b=zaicong3Mnz7XM+5Bq222FbiRDsT4NaBttLJdd4XvYV7r3LqSRUobMXzxu5JJlTx9h
         bFSGXu7DOP7vr67lUZsT9LlyWzj8QumXM4byX+GqmkQuZzMzBbrDgWbWY9jO8evvaRUI
         8Ad3L+dXvXwVOYbWgmPA2WBai8N2KXnuWQDZJ+vg+Bz9roCmCsh0o20eX786SiwhE8nu
         7heuSD1CZhnswPOw9Fi2Oo/NrMbN+7vD6vUpChvh35alOBCVUU59rjHSyMA0awaqceZy
         UDattSNWcQp2X5j49WMqnc1O8k3Aoc0Xz1DroIuMOwhi3h7sk5DyIBuFvv5f/hOHi7HF
         A5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712047645; x=1712652445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tl54XsFsvBlKI4m/HT6I/Yf3GgpXgDuhAYJ/cKm2Ytg=;
        b=H1Bc6LB1PDiqJm85ZMI9o9ey2N60ieZPX+7MstMnd9YtwEGLMcMHChbmdgBomus01W
         Ai3w70qDB2/fnTW/eFX/POtvtFVvJQ5lnky+yeLQYJA56X/tREXQC0hOLDzjUpbuubNi
         7gP648S1qRwWLskibCDu+RYJr28RPkDE4UoG0g8j3VJXFZHSGR9RZooupvalyEo8IUhk
         YcbnIcTHs2OF7N9+Mrfjm6/0c8wVz6wQyVQWjqLAieYRRsEHSebU/GlKmQArolTkGaV5
         b7+40ioY8AmXTH1aoX1To8Q2TAD2oFfgttaB6mMlWuQrGWW6PxGvPAOVtsle5PMHpN9E
         tRlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoiwTa/jg6AYMNwJB+TBgMR2YuAgsjORKZH5Toz9T5wbI5ipcstyZ6QfxZ2ZBNMu3wIULwle5qzDsqKrW5FQA6EYZViCsFdrCuCNjr
X-Gm-Message-State: AOJu0Yxevhig9SMjWnvgPqW8cipyKiipDgE5SW5z838MsWla5/n+GBmf
	M4omyYIDfb3tdc8nex/KSoVSCq2BiRAr/ZpW4m+Sz0LiFJ9tPITOMCy7ysfUUi0AK9YMn7abkr8
	9yXRAbgrGNByP1BhixuO+UNbdD8MKtyBpaHzczg==
X-Google-Smtp-Source: AGHT+IHAZs4Typ+jO49ey1X9weepwe0pDEXjBijDAH+3CEfRUx81BthQUjAekQqgoa5GDOHcryGNIQ/dEq8HA+SVDj4=
X-Received: by 2002:a2e:bb91:0:b0:2d8:116d:3b2d with SMTP id
 y17-20020a2ebb91000000b002d8116d3b2dmr4055608lje.2.1712047645539; Tue, 02 Apr
 2024 01:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-da850-fix-select-da8xx-v1-1-a348ab91448f@baylibre.com>
In-Reply-To: <20240401-da850-fix-select-da8xx-v1-1-a348ab91448f@baylibre.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 2 Apr 2024 10:47:14 +0200
Message-ID: <CAMRc=Mc7Xa58J55_kenkr2OA=ho6YH_gENOFEvAiA+q+p54dDQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: davinci: da850: fix selecting ARCH_DAVINCI_DA8XX
To: David Lechner <dlechner@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 5:10=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> Chips in the DA850 family need to have ARCH_DAVINCI_DA8XX to be selected
> in order to enable some peripheral drivers.
>
> This was accidentally removed in a previous commit.
>
> Fixes: dec85a95167a ("ARM: davinci: clean up platform support")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  arch/arm/mach-davinci/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfi=
g
> index 2a8a9fe46586..3fa15f342240 100644
> --- a/arch/arm/mach-davinci/Kconfig
> +++ b/arch/arm/mach-davinci/Kconfig
> @@ -27,6 +27,7 @@ config ARCH_DAVINCI_DA830
>
>  config ARCH_DAVINCI_DA850
>         bool "DA850/OMAP-L138/AM18x based system"
> +       select ARCH_DAVINCI_DA8XX
>         select DAVINCI_CP_INTC
>
>  config ARCH_DAVINCI_DA8XX
>
> ---
> base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
> change-id: 20240401-da850-fix-select-da8xx-989725eec11f

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

