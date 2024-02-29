Return-Path: <linux-kernel+bounces-86437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B3F86C558
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5741C22D17
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8600E5DF3C;
	Thu, 29 Feb 2024 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qPpMxIOF"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B85D90E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199229; cv=none; b=sKy8mQ9EpJ2N+BVx8k7Ti3CVk188+7uRhH3D0MDxwBFR0LmsIg7MjqM+S3q8VxEn3MM4HVI0CzwKHbirL6ZHLcKpjsBNHcyU0+CKjLeay/iSJwR/vYhPH6UUHzIhv0pEcXxaXaDcWyqSWvtYQd5KQG1zTFytZIZyMD51w8h2hqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199229; c=relaxed/simple;
	bh=BTKFqTkQ/Hdxy7pKbUgkWsXlYhvwEw9bt65k1KFPuDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPJQSg/kLSBIT1eOi8Awr2gcS02Qfa4joSfp6dwKocnl57onP5CRTVL/XJcEoc8gYlwreeBU2WqTlyPeD4lcickz5zdRhAkaec1GaRYWkHPq+c1fCnAc7jtP2LuBJFbwN6tgJOYnfViiMT9gP3jpoaiHSknLQ/VOjq3mD6mJLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qPpMxIOF; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6096ff3e4abso3036937b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709199226; x=1709804026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTKFqTkQ/Hdxy7pKbUgkWsXlYhvwEw9bt65k1KFPuDs=;
        b=qPpMxIOFBOREPhw9l3O7ylF7/oN7NkAvmbPK7SJgn3VjC0kayodnvodSMV/m3iMTst
         eiO1fndMDSZtAk9Ls7c3TpYK/ub97gV5edzDCG/RKTCmm9iKRKwzYDc6hxlsVagrC0QT
         TPQhsCH0YbAyU6/w3THRgtE5IhnpZTJLx49aB8q1nLUuRKsAggBK/gnTXs9st6Op4Y5A
         1b3AfAiuuEIYAc8Iw9/dcXSsTjuCUijINJJ0zanFGYRkQDGBxRg6gzknIHiaJKRwlxuP
         L5QiD2DlzdGlUySs/8iwwBgDtcZR6lJO/c73sBVr89nRYIw+b2wqp7qS1NLcjf3JZr4g
         5N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199226; x=1709804026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTKFqTkQ/Hdxy7pKbUgkWsXlYhvwEw9bt65k1KFPuDs=;
        b=j62LxVqSaqooAvUTQjxUrHGTLD+OqHiMZ9izVpbXYeCr117FWCkoWKPmjmyPGuedaU
         wfj6/TPV/1oNSnZa8bn8tAJW4vTAsar+YUXhkUQ6RdfUoPdbRXjUYxDD8CR7u/jpOIZU
         Vvfa9m/+fy3xfaUFf67ajrUFArDN6g6bjwsXB3RQQAD6fv0pyU6oYeS+1Hb57FbTijDp
         L9fYvIHVn5I7ZmFn+nILCcxieMaxX/VQA+6gqKXsGDb/bRNbCNSejNdzrsCOggTK2vUu
         oxDlp+aF4FH+FDr44px6J8h7/DSnICG2KIo0dqb9W848oPb7GcxRO2ZrD3mihruKy5xn
         iVNg==
X-Forwarded-Encrypted: i=1; AJvYcCWNc8+GJa17FThCn1RR6lKDPGRqASrvK5flzBcLn7FB+7pklArGpUMU4qmOpHxf8mKKqroz6B1CCMzi4UA48SwuPmJ2S2PNcP9WNtKR
X-Gm-Message-State: AOJu0YxVp75qjL3YkV6tC8v/sxcT1gb3b8F3cIpa4dSqj9335Q/U1tLu
	fJf1w4ZdFf3TsXW89uLtalCr3TY/nuBslzDCzUOSg8EOp1HN7t5Nkkwl54X0jJm9Ivfm2S2FO/t
	6AtpikliSeCIFwE3CqjoZ7LC1W8dBKpFaKNL6Lg==
X-Google-Smtp-Source: AGHT+IHV++gfJwyt5qvCWtgkDy4qf622OP2MAl4tAK2L2iTcZeC8PuyC0CiumnxO3QX4i3ji7VGSLW7yqUh576MqE2U=
X-Received: by 2002:a25:8548:0:b0:dc2:349d:10cf with SMTP id
 f8-20020a258548000000b00dc2349d10cfmr1676538ybn.53.1709199226350; Thu, 29 Feb
 2024 01:33:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-20-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-20-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:33:35 +0100
Message-ID: <CACRpkdaKi4qXG03fuPqCgdHmZ1RydMBxMFB3nutG6JLPGs+JkA@mail.gmail.com>
Subject: Re: [PATCH v2 20/30] gpio: nomadik: make clock optional
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

> Not all platforms using this platform driver expose a clock for this
> GPIO controller. Turn devm_clk_get() into devm_clk_get_optional() to
> avoid failing when no clocks are provided.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Patch applied!

Yours,
Linus Walleij

