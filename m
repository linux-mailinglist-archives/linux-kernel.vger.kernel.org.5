Return-Path: <linux-kernel+bounces-86410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A282186C504
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5925C1F26F30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59155B694;
	Thu, 29 Feb 2024 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkLFfWfm"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C75B5C1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198728; cv=none; b=tjDO9w9wYFBGCfytbqdEfKxm6sZX2Zb0LAUPWbnNhwxttYWZkkHSDAT7fS1dnwp68qeCtXwDpcQBO+EriKMI+T8YcYNNqjB+7oxutPuEMVkuetxVKFVaOzQAQc3y68a4pGXq0BCN7NWTGuGjVczyN6pi3czKriYnzQ+VbN6Ygk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198728; c=relaxed/simple;
	bh=K93TGNrKb0GkgHOKTSz+x/4+8Z36bEWaT4XskVS6+L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYe7JC1YcWifQfoqappcUW0mhBKETqgcd01NHAf109XMlMN7tGMYX0jQZ2OMiViw6khyKVgyJftoV/+U8lt40VgTUXON1ubZygm0UvmbAj5Y4f9x072Ktv6QpiIniNXcpShxv3EnvXIghynismKq6hMEoFfm3vdcnppoFYqyd0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dkLFfWfm; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc742543119so766282276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709198725; x=1709803525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K93TGNrKb0GkgHOKTSz+x/4+8Z36bEWaT4XskVS6+L4=;
        b=dkLFfWfm1XP9AJ4myW3/MMQysFEi7tW47i3ElfsC9w/QWwarIsDxpbINGpie+1D1Xe
         q82oFXBFf+8I3wCWcn5bzFqeNUlU+G9EiZjrBuVqNJju0C1BQo4q/MfIKZtgeVPXenpY
         D/2HE3TA83Ucncq5eYAE5ynlJNFMUeosoBFfY4MdFB6yshZZx2RKmsj9usLmAjNoMG4f
         EACfg35TeHAbMEdHJ3lX2sh8DrnveSto4ddaePkI222wVXw61ZoQCr8vP9oydpVFeT2B
         BhEN7XCkV6ud96+1fx+FRKmnVXDJXEFJJaQDFOmoY3O2Jl2h7zlWLd+6vlphFg53P9u0
         7r0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198725; x=1709803525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K93TGNrKb0GkgHOKTSz+x/4+8Z36bEWaT4XskVS6+L4=;
        b=IIyY6BaYZatpIu+xePLLHo3hsGCvrEZHXbbUpdnQTpdCX2A+3+0YcBfEV+3Yll2/C6
         qAIjIKpqhv3k/59WzwHSuiYHuut5gUnrKNgDDLaMrS69BjPu7K/yYkd8AcLpeTz2UdbZ
         C/+vqIBVFTfIRG4fnlhl2qV8TYFbymlZ3kGZgb3x96YJHN2uj7hwxSATDaOZSYbV7YfD
         yL/Bf7dr99vpHQMo2vWO1tbpy5bpf4iVq3mR/ODyYv2JjSAk0bDLEDDak0OOXHQYnfJi
         jM6VcP60YShX2+LxSNVo5uDuRAsvTEQQwgToO9d8U7YAA3k+5tonI/2vXGRfjXxB/Nzq
         /8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXc3GivquHJ2qTBOMMTEAk2oosScydX+ZVPbI08iKoR7shSbHk4Sj3wxLiUja8wWoPwrJYzMwl9oKQ8vOkYJI2I4Xneo2ZmmtYq8A+0
X-Gm-Message-State: AOJu0Yyw4RhiupEe+FNOn5DfPmt5JTSKPgBlJlt1LfXFIWp9FOIgOLeT
	+yTM/q/F9UCUEMvNZKm5ZAkbACGfQWjzHJ+UmGi7qD3q2h7/Kqwt0B1LuI5XlsD4BlwRpIu4qcB
	xtbhXlBfXmXxyW/23rFtC/Wgb5qVkQgEGNkZNgQ==
X-Google-Smtp-Source: AGHT+IEm2eq7h4OqpB9ZsuKpVyUbJqGCJ4nnMCzBfRnKHAXqac/WmT+lH3KUOMad2Qwl2YwaWx4J9gXGrOYlqlEqOis=
X-Received: by 2002:a25:3387:0:b0:dc6:b812:8ab3 with SMTP id
 z129-20020a253387000000b00dc6b8128ab3mr1619363ybz.26.1709198724817; Thu, 29
 Feb 2024 01:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-8-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-8-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:25:14 +0100
Message-ID: <CACRpkdbi_DUACLTbYLc06y1qepjL8XtEvWgFsXbJwTeXTcMupQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/30] pinctrl: nomadik: fix build warning (-Wformat)
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

On Wed, Feb 28, 2024 at 12:28=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:

> Fix compiler warning found in the pinctrl-nomadik platform driver. GCC
> message is as such:
>
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:855:21: warning:
> format =E2=80=98%u=E2=80=99 expects argument of type =E2=80=98unsigned in=
t=E2=80=99, but argument 5
> has type =E2=80=98size_t {aka const long unsigned int}=E2=80=99 [-Wformat=
=3D]
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Patch applied!

Yours,
Linus Walleij

