Return-Path: <linux-kernel+bounces-30642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC62832266
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0C91F22CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B39028E10;
	Thu, 18 Jan 2024 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eM+E/SHk"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240728E0F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705621964; cv=none; b=THgsxjdPAWG+uPHLuLtbdf2BeZ+D0LPIJQYzpKnupq2W0yXbYdNfsXj4F/JmqLGfZ4FurQN7Ee9LntVL8yBYc9IolS5jvIR/QrA67L5AfWSgf1eYdamuRepgyV5zhwwY4Rlq1VJmX3ek3Le8NFVaSd/B3IwIusyzDy9WO8Y37jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705621964; c=relaxed/simple;
	bh=VITzRXv6Xhk+5ALeOUMfCMRojcMs9MeJX9N0fVB0C7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COnL/kgfsbUhOnu42iEsZCwMbkMjbOu7IS46kzZFWMoXu8oEyTx+atyTQbaJ3eyXsjEldTkCI/qV1qRuVAi1pi7JiME3HoweZA0BuQYkAgYgl+GD9jTgHye/qDYAaFqPXMmqpUqC+mvWbbzW/CXZui0RLaZKb0sXtfeHWLDcKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eM+E/SHk; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e734251f48so2272457b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705621962; x=1706226762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VITzRXv6Xhk+5ALeOUMfCMRojcMs9MeJX9N0fVB0C7M=;
        b=eM+E/SHk3djIPFIkaT6z5dUc+fo3SIXpkwM5scZuGmlggFkGerBcYeKyXWze8hXV3y
         6YEcvfOKut8sG+YMQ4N4Ahkpx+8X5j4Z+/IaXP2KpeiiorGWM9FEhSSOvHNB+tBk0ztB
         HzmajT3OLslmMiinW7+XvTl+1gIRAwIsYKfeLUYvqZOyG/0FQ97jP6dKVBPPV/9+gMpe
         6ipzT6jrmyWdsaZrvvpg4WhtfzezZZjmAMGgfj0Z4tTg1tgbiI5sv04oHkBoGxUv90oG
         A9W0YSvvjJ47A3NXM+vPb8EQwZGbdRKa632hR5XJhZNnTBgOPyvTwOftvkr4YXuUTKHe
         /4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705621962; x=1706226762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VITzRXv6Xhk+5ALeOUMfCMRojcMs9MeJX9N0fVB0C7M=;
        b=XcCMHxLb9PRRh02f5Yl7T10qNclI3aEyNGIIgTpe8ZcLKtnulUzPj7ztJbJ9+H2GPe
         Y+rW4+zEOgdHA3pihvCZAHxGxjAQyzXiltn7T7HmpIva/OIBufr09FgGuJPxbC+uY9r8
         Nq5KEnq9vtH/+iKf59rVApf3ftzsoAO7GSGOqjco0QmeRGdGINMzpBbzpE0/qqxMcQVb
         WNAWSQJNpjS8gDXFHgYxpm+5k+9ctSZG8VUYtRRTo74HrCuWNkSeiCsUWqTf0+hEauHg
         9Jt7mbyApdbBY5zMEWSzsWbIBjcvuNZZlSaZj3/xvpvlfZLRjbMDTF7Kc9QOyBDbdjmG
         OcVw==
X-Gm-Message-State: AOJu0YwVFzQ1sqoZK1b2q2y/8Ryd/VpzAUUoETxxQmlIv5ZNP5JMxmDe
	l01lbvkOLR5/bvs/BOL7iIKdxxhgDWoIjC1Jdk0xipYOB4uDuYIvkNWAvwzX3Oz3E8T8qiLkc1Q
	NbCovgqNfS2gW0hKThdIeLUqj2rYJG6Ogc3gd7w==
X-Google-Smtp-Source: AGHT+IG1Vax1ERtyeuiuKplGCaWkjbo9+LIyma6qKfX6cqqKyxq1BP+WhqUQR6LOuKYHzbXtL5ghSXtqeuuE6kBUZF4=
X-Received: by 2002:a0d:f947:0:b0:5ff:9175:b102 with SMTP id
 j68-20020a0df947000000b005ff9175b102mr92813ywf.25.1705621962046; Thu, 18 Jan
 2024 15:52:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me> <20240118-ep93xx-v7-1-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-1-d953846ae771@maquefel.me>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 19 Jan 2024 00:52:30 +0100
Message-ID: <CACRpkdYDmx9qrkCo5mad_w1e0MKNYrVirg=qi+R4Q907SLdRwg@mail.gmail.com>
Subject: Re: [PATCH v7 01/39] ARM: ep93xx: Add terminator to gpiod_lookup_table
To: nikita.shubin@maquefel.me
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"Wu, Aaron" <Aaron.Wu@analog.com>, Olof Johansson <olof@lixom.net>, Lee Jones <lee@kernel.org>, 
	Ralf Baechle <ralf@linux-mips.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 9:22=E2=80=AFAM Nikita Shubin via B4 Relay
<devnull+nikita.shubin.maquefel.me@kernel.org> wrote:

> From: Nikita Shubin <nikita.shubin@maquefel.me>
>
> Without the terminator, if a con_id is passed to gpio_find() that
> does not exist in the lookup table the function will not stop looping
> correctly, and eventually cause an oops.
>
> Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
> Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Sorry, my bug...
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

