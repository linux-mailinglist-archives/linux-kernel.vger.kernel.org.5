Return-Path: <linux-kernel+bounces-86396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E8886C4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E991F26C04
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A202A5A107;
	Thu, 29 Feb 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BgfHQuZf"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B31B5A0FC
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198416; cv=none; b=Jjxjo8krd3SqTMB2qogQ5utpBkd/dpPpWQPAyOOxVR+udNpzLdBZxykjkE5icaygaq4dNN9GAcf4zutHnicKtKICNMa8q1i8GaD/s7GgBgM9RCs/sUM+sv3ndpASaJhR3KEPePzWBb+Xq0QxRc/glbgDpr5tFSGPChFzRt+3wH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198416; c=relaxed/simple;
	bh=5xzfnn3F2GF2BfKe/mVyPJKPZNzVltzgAEBEx7mAnhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AkdIECoLk965Q2VCb3rXSJt3EZj5SgE3iSNUIQ0hpwCqC8lIQ47aIlJRG6N1TAXk90u+4UCEGFoWrDwCEADQwAkBsg0Jf4n4riOey/PqYYWJbyPwx53H1clMwfPptIazC9taEwOFnRhmLtUEsJSaveeh6bTHzraQVkIdLUZTK+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BgfHQuZf; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso736622276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709198413; x=1709803213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xzfnn3F2GF2BfKe/mVyPJKPZNzVltzgAEBEx7mAnhk=;
        b=BgfHQuZft3r4L/CZCnL4Qe8QX3b99EIcOrvScbe4ckSkfABseWzaJal8aDD4D8pqnx
         7hWlPF/XP71qOLqZAzN20mbge7gl6RYw5RGU67dwW09hnZVrB08GJ10ExletdYFGPeW/
         NGGdmd9dyIzUUg8T7dgiRPIAiegGoGfokjes+PjOHz2XUwvQjAT7P7HqcjBbBNKJS5aS
         dEU0JDghOEccNS7dsI3TSjUCVqEfetHzSjYGW3gwhROEgfkEHzD0Bv1cnD0ZLnjMh7dA
         B+V5m0mkXascWaz4pQdTJAis65wHPEUsSOxbJN9bjEqJis9nqIAtc1qt8SqFvKbbbTgO
         a2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198413; x=1709803213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xzfnn3F2GF2BfKe/mVyPJKPZNzVltzgAEBEx7mAnhk=;
        b=PT6gkOBj9eQPq66XFywA8rsa7Pdv7t+rLygg8xdfFsETyzlKe7vu/BOwzkxLdDzSQ5
         Hhs+toab64auOLQE/dRgDko68gm7ehhasRO+ydxOHmJn6uX8CAdp5tjwv8XNlVzgMzOC
         T8KC7s3Zk/eCdWRcuRfz6tYJLXoNf+Rs3Bo6XzAZFVGVHkXPUtK5GepIs8UiImHLC8Xc
         fsmjSoRTHYI2iFbLI/2ArHoXnpYSKZDXM5TK61Hdl0G2nKBmcTNhbtAudmEX9OzAIhkE
         K72ejMIU5avMtKuqUPq7nMFhBCBc8ZNRnkuUw6GmVPcOwER8J27QaVR+Mf2ToC8Gzgta
         Yv6w==
X-Forwarded-Encrypted: i=1; AJvYcCV9kjBJQeDxqO69F+LHfPqerj19W9Lb+GA8RIU1/9evzOn3oL1LePActTgslY6aNfOPp7SAtfIFhTJlJObDgxs+uvcnqGPAFKDBAmED
X-Gm-Message-State: AOJu0YxSpKfLiehJYX732pqkiuk6w+fRqU8WuR2fmlbTYkRHdb+/i6wP
	1o+kup3/ATt1GdWQr6+WTmb5YRuyloVTMBvAQco2RPAP3+5AI1NwuzOf2GWCHjK0/UcwvcrEk8e
	YpCtawdIuVqM7498ShPIQYoFYa9rKh5+/C+GmXQ==
X-Google-Smtp-Source: AGHT+IGt1MHfcsA4yW7IZbUF8nqXwJyHryvR5atqc+sje8VW2MJ+tKCW4a3qqqWQL8pBx8LXl1is3Fk6Gy4y4Etyzw0=
X-Received: by 2002:a25:ce14:0:b0:dcb:b072:82d5 with SMTP id
 x20-20020a25ce14000000b00dcbb07282d5mr1507386ybe.64.1709198413600; Thu, 29
 Feb 2024 01:20:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-4-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-4-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:20:02 +0100
Message-ID: <CACRpkdZ301u-iAGBVQS0VPW+2XX=onGViuaK7fZ8eeTOXJCFPw@mail.gmail.com>
Subject: Re: [PATCH v2 04/30] dt-bindings: gpio: nomadik: add optional reset property
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:28=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:

> Add optional reset device-tree property to the Nomadik GPIO controller.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Patch applied!

Yours,
Linus Walleij

