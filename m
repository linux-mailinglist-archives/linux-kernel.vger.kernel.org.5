Return-Path: <linux-kernel+bounces-74908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE95285DFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CEDB24405
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA5E7F7EA;
	Wed, 21 Feb 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XU0P1dH4"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE421E4B2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526249; cv=none; b=McN0XXGBm9103mARVUkKU3CBiKUolpMyMB7Gk8lcCOEFUxaPw4uEU9KGm7Dyp/BsGz9bgSGXBdZNJjUhSxmus6MPBBFsBEWrlVLYbmlGjjZJZNsm/GI6l21Mxqvo0obCpblUztsBiIpzC/Xc3K/rj5JuDVPblFx05v0eO4bMMfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526249; c=relaxed/simple;
	bh=J8q0JlB/CSmcraPRz+OroMVJcRYOKeq7wFX81mHHwC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEWoXcljQtwuzS3Bgm3Kskz5W6ko7N87qNV7pGMyP4zRxOlvdC5V8qXu+KJiVYXc4JBMCZT1YmAEPrDqBLMCXUdGacf4Oec+cJgatUgS2DN1HjVKpxUCD6J9f7LaRFlDv22J8waMt5CHsETtM+z0kLDaD4pTdONi/CCB8PXpg7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XU0P1dH4; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607bfa4c913so6550137b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708526247; x=1709131047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96dYgcSw1uzHwk35CUcYsL8G15ZF0LlfphttW1dNAO8=;
        b=XU0P1dH47EmAdAw554gnxahswlY2N7CeXgUBjqVbkF2itptU1PLUl42y5XyjO0vZWT
         pRm3JuvaAayAr1GDHyHoBkndoN5hkWSUvvygxeibgytIm46/TNFPG/464m9CnYKKH1xE
         E3xOy3lPOp5Uhv/2I7Sk0CppJSj4N+8fhuR+waXkBOZUAnTU8JK8QrpSLbFqi9y4nq2E
         LgY01q9KHjnEd7ZqVhrCgneVdgXRRXJLMc+sDXL0OuUgKX2r+zkc7sMILzIUvyzY0fE/
         qfJYEgjFiEO1T5mAhfeDH3+ACHt+NjlC3j3QjPw0h9UVEh6bPCHUBIJMU4R4ijBTDFwu
         riSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526247; x=1709131047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96dYgcSw1uzHwk35CUcYsL8G15ZF0LlfphttW1dNAO8=;
        b=FEz55f52umQxioiBvp+CNhk/3DGcH06NGGPJK7KVoH2JNp9mmKs8BOqOAQC01S3Q6k
         IDIbkQ2kNM464WWh+jpE4FFuPQo6sdCbrIVUgqbZOJRTcj0OlJFZZsE6lqCmQT2XLgam
         85Op0h8Lf8jwf/AOiAEntZO4X78ITk3uwZSriL0uFAEfRSSg6BWOsp3s/P+I8d4+eXuv
         22rW7I7bTxup3QMW52EytjifFT9eo+4VkFSV3AAY5TbXlpLmUMN/POprMctcm8oLydXu
         Rw+8LbiY/TyiJVcGolSKEMvSWvZy7L4demae2uRHpkykWXCrvrzJd09orpdtbl8lxoH0
         UHLA==
X-Forwarded-Encrypted: i=1; AJvYcCW9jHEjL0oagCowgQRz2enm8MJNyTsYn1YGJqO2cpYtneUgyhsmLRrApa7D12iBOMXFKEx3H8c1XvQm3G/+dAmocL7ZFxU07JddF5XV
X-Gm-Message-State: AOJu0YykKLSTZw2DMBBw/vCJeZ2Scw1TEgITOuqPSbFbNvzDGvViN2Hn
	k8Pf3zlQ2GJyyfHyRKjeINHwIa/Ll2CzcOZoFfJzvlz2RJdXYor4B7x2bQn6rbU2sv26K8uIBst
	E1NbNVdUMlonYV9r08sGO8s2rnj2ykuM4i7pfUw==
X-Google-Smtp-Source: AGHT+IF7pOoDUqDYgFCWHrS/yspiLu24Q9Cz2m39Sye6lsyfXxK+C51y7B3RynHaRvKVKc9Ic8TVoo8lot4no3c5fF8=
X-Received: by 2002:a81:6f0b:0:b0:607:ca2e:f23e with SMTP id
 k11-20020a816f0b000000b00607ca2ef23emr17929112ywc.30.1708526247225; Wed, 21
 Feb 2024 06:37:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com> <20240214-mbly-gpio-v1-5-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-5-f88c0ccf372b@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 15:37:15 +0100
Message-ID: <CACRpkdaSMJBFrmbTu+C1Ls8HkLH4FZsAQ6t7dC76+sVTXXHEyw@mail.gmail.com>
Subject: Re: [PATCH 05/23] gpio: nomadik: extract GPIO platform driver from drivers/pinctrl/nomadik/
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Theo,

just a quick note here:

On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> +config GPIO_NOMADIK
> +       bool "Nomadik GPIO driver"
> +       depends on ARCH_U8500 || ARCH_NOMADIK || COMPILE_TEST
> +       select OF_GPIO
> +       select GPIOLIB_IRQCHIP

Could you add:

default PINCTRL_NOMADIK

so it is turned on by default when we have that, since they are jitted toge=
ther
so closely.

Yours,
Linus Walleij

