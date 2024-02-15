Return-Path: <linux-kernel+bounces-66981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D27ED85646D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9571C21B59
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26828130AEC;
	Thu, 15 Feb 2024 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BqGCzj/G"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A04130AC4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003911; cv=none; b=P79RdVzBa/7Dm+lit5THwmRD+YMM39lj3Q4sbtNo+5JMmFZN1o133DD+T+TtcEYcJkesdR8wWcKwL6TW66OD9hFjKGpu42mrTr054c2NGbKZhg/Bo06QOSb8mKgsPN24RDaKGPG7ZGJIjme1aQH0xYMF8Yc/xGDumsp/Y86AkJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003911; c=relaxed/simple;
	bh=lUl0Pib7si2dQHCXFrZb+InEVOkZVwOiAw43kh+jhak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhCB6t2bezkuT8Rs3vHAWhw6Or8wJzqwqi9utx5sKDexguU9N92WXCzpP7geD8OGiQPc5+Xp/quRGOzscDmT4jBH62IPiLXccJGA2cWQkdNvwEv6Cj5BnpQDykQLOrrXtmMOC004ptvc6oFwpvGzubX3PNdeSB4lV9wrBgt3CJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BqGCzj/G; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso806110276.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708003909; x=1708608709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGh//nbX6ksAbjoH86pu+1OoxjeTYU/3tdUOfH2WwY4=;
        b=BqGCzj/G9jhFSsh2Za755/LzU6uyT+nqeNHXOXWrVvZpkLqcH6kmzgf4tPtVkwkEU0
         wyf4WLzEQMX1M5SRb9clyi+Wdlay+Rj3eHfkjDTKRJCeBQ5oJAaHdR739mCMQ0siELsY
         pMJ4k9VWaGRJ5KWxpNJKYgc2ezLDBvP27pFM9/oAuXmwlEVFp9qUZnpYcCWRIHkcj3AB
         vZ2lGqYF2zsUly9WRW5AgoT6GXIqqR4cK0IiLdb30LSDU5k9ul21dtva44MEhEtMEhsa
         4JFzDwH3I9iI/ebxA/XSbuogUGtrJJo0jsA7Qcel1rqwY+WfQASMKFs9+z71WRRioqem
         0bXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003909; x=1708608709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGh//nbX6ksAbjoH86pu+1OoxjeTYU/3tdUOfH2WwY4=;
        b=ayKbVLcFHHcRS9bYpKcrnv+bVDM2bccnz18rcELQ1+1hI6uKkrTbez+ECkI9XGdCzP
         J5SdVDrhtBsBIH+KX2lNoJnE+GX005IwJEkK04Ma8vX8c63VZ84HbxDb6TzeybEHkwsD
         qNfQx1dm0tghye4cUREV6gbq0PAzgnGjDVGq5Ja9fLXXL/oR1Ahfc3DequCXVNRph4Nf
         /8ckjaANqvDiTFRbuA2q/ecrK+OHMnHkbvCK3IWg0zyDdswtokc+Bl89fV1M1Jl4KSOK
         hFU0W47vHbgjbT09uMncG+U1/gM5Mw21e+yDk2rBCUH+pZQN0zgjsp0EYv94CXB1KtCH
         D7KA==
X-Forwarded-Encrypted: i=1; AJvYcCXNwOKW80rD0ZdY7ySxawnySv4p2WVLXFKUUy+MomlL2COEZWonzpy3VeFPOvUPl/nWorB2L0Ks8H0vBB0vwhKObABMsTLGOI5t7W7s
X-Gm-Message-State: AOJu0YyJOh/DSFJGk6qfIJi7Xx8BITV199PWFgIM8L0DVm/m7v8ModPb
	lQsMExqz2+x/N/ii8d2soNTrX0oCGCMMVWOgZZM04c0wDhSKi/zGXLYh9tVTdZz5Zmbwg0As6OP
	qf3/rOgFVruAZTa6vIu4zn9mF/E/7vTc9GdAQbA==
X-Google-Smtp-Source: AGHT+IHl3qgWvQCqRJMe39KHtu2wuTpCX4Lckf3lqFQQ+kVziMGrJ7Juv/tfm7isqbWZN8sE5IWX6zuYqEnZ+zYcRZE=
X-Received: by 2002:a25:b949:0:b0:dcb:b41c:77ef with SMTP id
 s9-20020a25b949000000b00dcbb41c77efmr1387473ybm.24.1708003908799; Thu, 15 Feb
 2024 05:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-ktd2801-deps-v1-1-7feb5385eb9a@skole.hr>
In-Reply-To: <20240213-ktd2801-deps-v1-1-7feb5385eb9a@skole.hr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 15 Feb 2024 14:31:37 +0100
Message-ID: <CACRpkdYm0dNZZvzAZ-VQ+MaHeL7NmGCmCVw42WMx6BFf4Lw0Pw@mail.gmail.com>
Subject: Re: [PATCH] backlight: ktd2801: depend on GPIOLIB
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@kernel.org>, 
	Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 7:13=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic=
@skole.hr> wrote:

> LEDS_EXPRESSWIRE depends on GPIOLIB, and so must anything selecting it:
>
> WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
>   Depends on [n]: NEW_LEDS [=3Dy] && GPIOLIB [=3Dn]
>   Selected by [m]:
>   - BACKLIGHT_KTD2801 [=3Dm] && HAS_IOMEM [=3Dy] && BACKLIGHT_CLASS_DEVIC=
E [=3Dm]
>
> Fixes: 66c76c1cd984 ("backlight: Add Kinetic KTD2801 backlight support")
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Technically you can also select GPIOLIB, because it is available on
all platforms, so it may be easier for users, but then you never know
which GPIOs you get in practice.

Yours,
Linus Walleij

