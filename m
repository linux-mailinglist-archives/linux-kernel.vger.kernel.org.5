Return-Path: <linux-kernel+bounces-145425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CC58A55FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5AB11C226C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4809E78C8F;
	Mon, 15 Apr 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM0BZX19"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859647868B;
	Mon, 15 Apr 2024 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193595; cv=none; b=smx8QKElwYy5/Ydymw5iwp9NqW5AFR9ZHzygl1OyeLOVDqTq2tj/5UpKAZOedK3qIjzc66/S0ha2e3C53xOOIqG7BGrdN/vkLDUIjdlCriEGXZiJdTGHt5PwTwrCtYT8suYcND+4iQnPR6og3Cb+uijiE7h1zZ2bFwkbyU79ihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193595; c=relaxed/simple;
	bh=mOsRfd5qxASFakmIqOXVcTvu3CyoQSRnAIxxp1fG+4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDr0mPcaMr+zxVk+MhpptPOwTmCzssUF7wSa0ALqksHI0wGkPyoAHO7Jh4L5BF6bNE2eJT5Wmpqql/TAzZWKA9srOuM/DSKTlmFGaY5eI+zt03oSjDNGTI7ctVMP38YszsyArDN6KJIccnYKO+0UB3cN2V+ShKyVmGj9lkeS7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KM0BZX19; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57030fa7381so909037a12.2;
        Mon, 15 Apr 2024 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713193591; x=1713798391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7/TBRaaPIPtSJDv4IMqFEGZB5oTZKPTNBkY3AEKti8=;
        b=KM0BZX19UxPfb4hlyvh/+Af4ZaDBBqk/VAOe8/s95nEk8NnQ76cfVv54IaY8Z+FEdV
         RX2nPssJELFeQffCg3sUbkeNIKbEnIOdJvA3OTtpIcSbZBEA0F4bwHUd4sU7m0DPCV60
         YPOGzI06wBjWtyQqpJ+xptXMMvj443kUwZNgwZtwjxcIO7yXlxfw/BCTyLSsPi/AelMw
         aupciKDdAJf0XuysYlJbzI9tUIRsfa9DGjELCG96+pvoBJTjRRrpfd59aSP2iH1B3vrz
         L2/Pbf4vXffPD9dDRCUB2QWnX+7L7ZcxJ4s422t77tPKM2Q1VZKhWq1sJ3jcTOuZmvLa
         t4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193591; x=1713798391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7/TBRaaPIPtSJDv4IMqFEGZB5oTZKPTNBkY3AEKti8=;
        b=iWOrGgo2DGPPc+sOZs3eLY+8Y4GMxl0rh9KU57HOlzX5Ma/EiJrxq4RdJezmr6DE5t
         WYPa85upKK/HRHXR8FXZJ3jR9AyG8JQCsCKtrPp8cewXOnXbVDepVFYNuer/Jmes1uVi
         f7pVFyckCqnaYOlQnf/X3pumoaKFm8IyWt1bObU67YRnvD9VW8kQTTCxcLz5yqTJdT1d
         MHWQSNLk2p7vY9SVc5JuwriIOHzD3m1o/10vEJu0ts97r+gzrzlwYqLJF+KsT6mqCnAT
         PIWcMq4/alMAb3G4nxH2FRovMqtHTxuHkIDeXeXiOnlKXZVCaqJaFmg7AjJ3VPK9iUzZ
         qELQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK5d9dywDQtGdZiO1uB4QsqnzeP/tvdfYLPtF5xKMHB2t4o7CISRFrInL+P1QZzM0tfZUbdmnp5YTU9saGwKcX3Q4GNVtdOrNwpCZm8GaMS+qD2bfKOKBrLcDge2CxszTlVWJoH1AVLuSo4VCaG16XCm9GnJdmMZ6fAsirNbrqJeoNqNTh8DkChsCXbmZk6uv1lufMVa4mYarQivPuiAQ3
X-Gm-Message-State: AOJu0Ywuz7zv2xgMUkTWdH4yyJkDbNOgk3Oj1dla8U+vKicCvuaLlM+5
	h5e9YPdu84VL7Q8J2KwMhW9KATrwXtJDKYc5rg4EmAoNqaFZ9zrOG1oQ6mLeA5rou5UECCwu4bS
	y2JenBUjY4oawZUvIYfNuzjE1HI0=
X-Google-Smtp-Source: AGHT+IEZOaeQQWk/r3eJ/DbVb/nwCv9r/tKA3MdsC0SedQqpmw8jPxhTIbiLf3bZtwJnwgsZOK4XztHqpSaPZiAKWVk=
X-Received: by 2002:a17:906:3fc9:b0:a51:f915:bf5a with SMTP id
 k9-20020a1709063fc900b00a51f915bf5amr5280873ejj.75.1713193590873; Mon, 15 Apr
 2024 08:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414175300.956243-1-aren@peacevolution.org>
 <20240414175716.958831-1-aren@peacevolution.org> <20240414175716.958831-3-aren@peacevolution.org>
In-Reply-To: <20240414175716.958831-3-aren@peacevolution.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Apr 2024 18:05:54 +0300
Message-ID: <CAHp75Vf_JX1Uv=_cvoiukzSaTVWbmQSW0P_nneP8C-kxX4fBXQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: light: stk3310: log error if reading the chip id fails
To: Aren Moynihan <aren@peacevolution.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Ondrej Jirman <megi@xff.cz>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-iio@vger.kernel.org, phone-devel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Willow Barraco <contact@willowbarraco.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 8:57=E2=80=AFPM Aren Moynihan <aren@peacevolution.o=
rg> wrote:
>
> If the chip isn't powered, this call is likely to return an error.
> Without a log here the driver will silently fail to probe. Common errors
> are ENXIO (when the chip isn't powered) and ETIMEDOUT (when the i2c bus
> isn't powered).

>         ret =3D regmap_read(data->regmap, STK3310_REG_ID, &chipid);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dev_err(&client->dev, "failed to read chip id: %d", ret);
>                 return ret;
> +       }

Briefly looking at the code it seems that this one is strictly part of
the probe phase, which means we may use

  return dev_err_probe(...);

pattern. Yet, you may add another patch to clean up all of them:
_probe(), _init(), _regmap_init() to use the same pattern everywhere.

--=20
With Best Regards,
Andy Shevchenko

