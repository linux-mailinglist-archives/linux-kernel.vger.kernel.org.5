Return-Path: <linux-kernel+bounces-86428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0860D86C539
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A41B1C242DB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71E85D75B;
	Thu, 29 Feb 2024 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9/LAApI"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1855D731
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199049; cv=none; b=lPnzZ056E4l9q9ugTCtcvzBADQOjaf6KmRC6Gnu9Vmb35wDqH1aP0iMmucGJ+l4VEmpmNIHhRXlpvugfTbsBnXa/IKtb7hT+pYbv4OWlzMoM25hB67VVc9xYXyngUtJyMzSRwN6oQGtLDAjYVtwDPVRT0AzArzYFR443Tl+3ClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199049; c=relaxed/simple;
	bh=31chdHlOIqy4WCMDjv7GZKxMkfPu9JZLtk09++EW130=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3GkXR2YTHw+xtst9K6uJ/PahRiAu++HxkmgzSfEkNc94QANP1UJWQ8rdxD0grUD+p4VK90GxWfSZbFoezilaP2AvVWIFmBxhafDA0CswEDrFqVCHDdkpPdsKpySOGQCNwl9DNEzX5F9iAYlClnUBFWcLHj6ttFdwmmdn7KLNwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F9/LAApI; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc74435c428so790452276.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709199046; x=1709803846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31chdHlOIqy4WCMDjv7GZKxMkfPu9JZLtk09++EW130=;
        b=F9/LAApIsHY429+cdXGQchpL4KoOf5QrS8Yb+dXjyclik0vicnut+U+NP2c3iRyPBR
         t6yFM3DaOtkQsi5qcgFOzp+9bX1MUbXPyAddqSjeOmAOwaZhe2hyWQIAin/wn74LDPwq
         I0e2c6lrHx2IzDf6jmUphVrte5OWNmQtNg/KjvvGGpYAY3T4TPKTtCYrx3eFNudnI6AV
         Yi7opuP3nXvlLv8OwE9K3PKRyBRHqG8t7H7HGLqXfjhrruod7caV8Kn2whRjSrV/l++8
         +0kXdoYujbLWvQXZGCy/4p53bY8Ro+RUUEqXhYh+28qSMLionK28a7qKbEXWpTisGVEd
         i/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199046; x=1709803846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31chdHlOIqy4WCMDjv7GZKxMkfPu9JZLtk09++EW130=;
        b=Kr//fERe5GLsLvl3vEimGhzRg8fZAZxIPt659Abc6AmyhoJ5wmCx301SfKquPcQ6mV
         brqaUZD/BY9IiHmzbTWxQrFix6KqSDW890GZO+LbaY4rF6tNPccs6PIqWYWvB4ZaCHCY
         OH1chRuxmdWvcDwVkT5pvazssXtqhCTfmRz32DSNSd3U/5t27O1IxX602ywYw+/W1hJC
         SfIB7tS9lC98c4v7M9sgI+Ryn2PAeYz9n5vc5y5TVv4lm0w+l33LRb5LjjoSwJVnukrm
         8EtD3+KVu5HQ8dGTc+u94yVQgVmVgTZ5EOFcdHujnZNtSHUSO95IaDE6gN+o0KahT3ZO
         jgXA==
X-Forwarded-Encrypted: i=1; AJvYcCUZUPpGvNOkvmB+X6b+6mfajmI05ussTsb8rcsiiReRZxZXGL70GWaxO7f9uTh2TvMr8HKsll/joqqHzq4VNKDov9BLHSRDtvZPPG03
X-Gm-Message-State: AOJu0Yzd5XHmzbpTq46ShdjsIkzPc5Erhl1/ASfQ9ngX4GoKPGg/twsY
	7Rt+Q42T+Fs7GtUVWzL5qnZhkWEzPgGMZOzXmOi2dr8rBbUUm50y7PkjsjyXeJ2Ge+XlcgfebBs
	IhRoA+Pbd9v94RRZLDGmQZZTS47nXSjJFmj9ogA==
X-Google-Smtp-Source: AGHT+IEmhOIkoqQABgOgh2spi9fO0NuLliWyGBbtbQP2Y3j61zegZ8lSPYJAXlb0pVJPAWRTtqtOPDmNbSb0YROYMtQ=
X-Received: by 2002:a25:d30d:0:b0:dc6:da83:88e6 with SMTP id
 e13-20020a25d30d000000b00dc6da8388e6mr1480292ybf.32.1709199046701; Thu, 29
 Feb 2024 01:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-16-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-16-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:30:35 +0100
Message-ID: <CACRpkdaR4fLef24SMFj=_C=o=dqWvKemVJPKcx1jjwjrvVnRPg@mail.gmail.com>
Subject: Re: [PATCH v2 16/30] gpio: nomadik: replace of_property_read_*() by device_property_read_*()
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

> Avoid OF APIs in the GPIO subsystem. Here, replace
> of_property_read_{u32,bool}() call by device_property_read_{u32,bool}().
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Patch applied!

Yours,
Linus Walleij

