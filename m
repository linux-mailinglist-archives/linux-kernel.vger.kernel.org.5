Return-Path: <linux-kernel+bounces-122618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467FE88FA75
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88A21F288D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDBF5917F;
	Thu, 28 Mar 2024 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNoneo1F"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B67381BD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616067; cv=none; b=aQLiVzAHqC0ksUcqlxk1l2LlcHV5g1khuGGVEpjxUqWJcxQsJJulImjwJCvOIJ0UR2XGCPWBOMP3PowwNIyb+D8T4bdxOWgcSkAZNsx7lmAZpapVsgeTjOr3hCxyD1uklL3Ff7OpVuRxiy8GxuPiOII3tVg1gXR5B+SdvMNwIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616067; c=relaxed/simple;
	bh=Dlwj5ZaYYOcJu8Ok+9hC2v+Yow7saE1lH0jHScZMQDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIbTVFvXX4AYI1PDfShLWU4iqDxNxOoL2ItdcoaysR91bnmM/JLdJ5h8v7lcJrR/v4TD1NYFGUe0Fk4SMNY9+W0GIj1TB6IQpyTx6sjspAbrwyXnsDBFv2rNL1Vy7l2o89TTBei2Wmq54kouok0XPMuXArY3iqqbqE0PjYcH5NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DNoneo1F; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-609f359b7b1so8502137b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711616064; x=1712220864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dlwj5ZaYYOcJu8Ok+9hC2v+Yow7saE1lH0jHScZMQDI=;
        b=DNoneo1Fj7zxFNbuc1qOPhyZp9+J7zHtQekpPFAJ3CeYrDzuNHbQgwA23vg0Kk9ooe
         yOAoTW8c4t2NXfP0nEgvJi+SZ18ir4Dgr9fe+DHXCAP3n7/AaGKV3AsBWMMquF8Zgghd
         o0AzPSDsf3NJWdl66zGG7IrJ+B08oWzdKVK9J2pld50CtKW89T3VhxfuU8ES6CPcPTZf
         z2JgCdioQM2GPJDc1xi7ttW1u99efaGaGR1D0DA4A3FkXJdlGhsDR37/hMXrV9vMfWj0
         YlzWlB80g3HATl7Bj1Op7N99uFka7E+uhpPKA9xJv3HCzJEAiOGPay7t4sULypRI1nMl
         st8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711616064; x=1712220864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dlwj5ZaYYOcJu8Ok+9hC2v+Yow7saE1lH0jHScZMQDI=;
        b=ZGjTpAElX/vPYYlz9PdZkn/XMSvP3Ww19DCZgaBFvLm78YtwxARULVhSfuFsizHUkc
         8BqyJUkiBQyJqU4mwzivTr4E1J9zD+UyOr7jn9tQvs0Qt5MKAHiaFT4eQCaXwDQowJ10
         PuRr1BObfFpeS1UmobBDG68px2OCQ4z7kfOe2KjJp2PGmDqbi7XXPv6trMlNQgpm8Zb5
         w7KTRFnfbbJy9IT7zEZcVDMUDAEjJbL5vG9XKZ/Z7Rr0jh22orJ9vXHMcc3/0i3oETjC
         KIib70C1L0KHMk5ADU7DAlTrBO9jAOGIWWiLXCXGt+Ml3b2GTh1l6HzDKliEweNh+B9z
         VH5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXi6RekEFnvDsRfX7bdzG/wGDzoNFyW7/jZBXJZMHgrat3cQYAeIST8e2QNI720u0CE2iOwmsslVlVmst3ddAPMPWi+x6ZARoKKejy2
X-Gm-Message-State: AOJu0YwwcmDUVf38cTMhmIlUBZFEVTMb5IqtLjua33JzxNm6+0OFZbzs
	ADbYSz0T1BnQ/rjRSUtt8gpu9wl/PKnzgmdXQjxlTVYBDdb8L0DYAQy2i6EkHZaeyumLXtRsj7i
	p+X64fFtTKTlt+b9akeCnkKCm4w2O1SY2jnp1cg==
X-Google-Smtp-Source: AGHT+IFnSUR451w83koEnu6t0GdD86PwzKI9rPf82IN5plnY7aRqaMs5krZhIPZHIsEN9OJjmvCgwSqZqXhh5e+ePjs=
X-Received: by 2002:a5b:748:0:b0:dcc:32cb:cb3b with SMTP id
 s8-20020a5b0748000000b00dcc32cbcb3bmr2632651ybq.44.1711616064245; Thu, 28 Mar
 2024 01:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325090242.14281-1-brgl@bgdev.pl>
In-Reply-To: <20240325090242.14281-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 09:54:13 +0100
Message-ID: <CACRpkdZf5-QR0aU+jhqpsCbNbD+57TN6Yq_Naq8JoLSWSsM8kw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: cdev: sanitize the label before requesting the interrupt
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, stable@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:02=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> When an interrupt is requested, a procfs directory is created under
> "/proc/irq/<irqnum>/<label>" where <label> is the string passed to one of
> the request_irq() variants.
>
> What follows is that the string must not contain the "/" character or
> the procfs mkdir operation will fail. We don't have such constraints for
> GPIO consumer labels which are used verbatim as interrupt labels for
> GPIO irqs. We must therefore sanitize the consumer string before
> requesting the interrupt.
>
> Let's replace all "/" with ":".
>
> Cc: stable@vger.kernel.org
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Closes: https://lore.kernel.org/linux-gpio/39fe95cb-aa83-4b8b-8cab-63947a=
726754@gmx.net/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Good work on this one!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

