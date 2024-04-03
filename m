Return-Path: <linux-kernel+bounces-129978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C20008972CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B18A287249
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A91456B70;
	Wed,  3 Apr 2024 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PVk7GYRn"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC752F99
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155135; cv=none; b=Y+FJkPDdINjKZ0HoOrtQ3N46VKGH6ZtK+xUlKtNhr/VNgnfw/676l8ANBZaNLmyznMV21A6nUpopixsC13V4BmOeNfmqouutmYgZ7+co03MnYTJY62Gf8WodanhIfvtaJYdNPnsAsWs5wRphzkURmtO6n48U84kBup8nXFqgpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155135; c=relaxed/simple;
	bh=XYcOgAxXGHkhdpIHXAt+v3lV5PqFxI4zDcRmVyPX0BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUEoXEsLSKJ3dUH5nXfok/mCVSY3H2yXftI2IK+CDjyjOao8gXUSTE28fzSCESQepqS+rHB9QeaHMH9FcM01z29h/7bxprqc3attJ5nsgDltdVOWRVXJYidbeq20/48aB0ytoPZ9JDeScb18WsPWdjwi6zwW7gnnAk3i4FSHJ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PVk7GYRn; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d485886545so107022931fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712155132; x=1712759932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+F+lR6B8bWc6SG6ZnyFSW9uZxcK09xY01XuwqgaSMg=;
        b=PVk7GYRnfKz6yz53eg/cJXGpKTtvQEW/3g2GqQPguDKZwttK3x+bDoTwGRKA0KN6Ob
         0tCtIZsCn21E/36H/k/mAYjBh3OstYKHU2t4riPHOpp4kSdsKNlgaHbks48vBwkf9Rg/
         gN+/ZN4zlu6hwEJw/mDGAFo0dUPeVShg9FPHAyUN/AtaL3ezz9MIfn8CerDuVT8zFImC
         D0aXKpGazKa1aKiOiixE1oZthylArBwj+kzVpaN9YEcUgNN9916boOBloC4BAlEY5O05
         pm1+0N2YEe4pZmfV67GbnjfvYn9+Gx2UIbn11LeV07bisU6J/Zzwu2aOYW205JWu9v/5
         KKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712155132; x=1712759932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+F+lR6B8bWc6SG6ZnyFSW9uZxcK09xY01XuwqgaSMg=;
        b=ONJuBbXZMkz94HudT6LQoD2PI4t50pc/tU5mawN0F1IlAEKB2ndvHpCkrUpspXyXdI
         QfgExf93kC6B9gWB7N8PLqswKOTd/Bmr+lfikoNkGRZZ1AO7fGC6dR2OckRQBE5B+fi3
         +FQF/fWJtAa1VYZrd6DcObqVEW7Qa4niiBfaHV80aWMyiD0f0OX6pzI0ycPbJhwCdboH
         DSt9gWo1lHNTmOZ9TvN+Rf+5EwXqqLTfA/G53HFXOM8rAf+pkbcQyEwIGRyFIKRsygTx
         OzjK02J1SEjzhCcOp7Dwz6YyP0H+1jznCoKavDQYjQrlvM7A/Ji912khCN24ti0/sf8C
         2a6g==
X-Forwarded-Encrypted: i=1; AJvYcCVALsaa4PU5VSqBm9606xYH0c0hhER5oVr0HXqqYkIPoYyWuKh6Hxoc6vzGExJwJ43yECLBuTUcEyVZn2FlBPrrs5kPsy9o0A76UmtN
X-Gm-Message-State: AOJu0Yzz0SRXuEcZmKSK+tAD4F4Rt97Hj/tu0nJ96OTVHAY6DiegGkLL
	dYwPM2FYgafF7Q2/8Q6brJE3wO5divr/swR5P+kUavrwl3R0oJR/YlHXbJYLeyehC33f28lST3s
	MBWkPnPbq5Fi1YmHK59ws8VN6OJB2Wx6tW8Hmiw==
X-Google-Smtp-Source: AGHT+IF1Albu6Nu5656ydaWZAfWTTjTKyHecYttGRSLH5VhQZv6FHYuZRgl2PbIf0IkYHQVJX9L0Pn5q/EpMAZjZ/CE=
X-Received: by 2002:a05:651c:2320:b0:2d8:36f9:67af with SMTP id
 bi32-20020a05651c232000b002d836f967afmr2199291ljb.44.1712155131493; Wed, 03
 Apr 2024 07:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325085756.13843-1-brgl@bgdev.pl>
In-Reply-To: <20240325085756.13843-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Apr 2024 16:38:40 +0200
Message-ID: <CAMRc=MfOWpwsRODOS4FO=b4CU4zsM0LVnb94FmAU_6QOSXCKcA@mail.gmail.com>
Subject: Re: [RESEND PATCH] arm64: defconfig: build ath12k as a module
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Udit Kumar <u-kumar1@ti.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 9:58=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Qualcomm sm8550-qrd and sm8650-qrd boards have ath12k modules as part of
> their on-board WCN7850 WLAN/BT packages. Enable the relevant driver in
> defconfig.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6c45a465a071..937edf09f0aa 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -411,6 +411,7 @@ CONFIG_WCN36XX=3Dm
>  CONFIG_ATH11K=3Dm
>  CONFIG_ATH11K_AHB=3Dm
>  CONFIG_ATH11K_PCI=3Dm
> +CONFIG_ATH12K=3Dm
>  CONFIG_BRCMFMAC=3Dm
>  CONFIG_MWIFIEX=3Dm
>  CONFIG_MWIFIEX_SDIO=3Dm
> --
> 2.40.1
>

Ping.

Bartosz

