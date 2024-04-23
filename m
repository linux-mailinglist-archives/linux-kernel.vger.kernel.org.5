Return-Path: <linux-kernel+bounces-155991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0855B8AFC79
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0001C283B75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C392B38DDD;
	Tue, 23 Apr 2024 23:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZYv0w8X"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7EB2E62F;
	Tue, 23 Apr 2024 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713913733; cv=none; b=BJge4SgdsVnEEJI3rnMbrdDLdbn5t3ZtbBiiLZogQHnH2LamTHLIKgf1g+UL3C04IU977CYG5bYCiZvC7YhRMmg82LmHa4mNpZwSLgAARcrDONZg652nw9t8GXmeteqjJuVulayBw4ooGnSOJc8s4zee9QMUTwX6/zirhh2yb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713913733; c=relaxed/simple;
	bh=mmRIkV2XMlCxj4R1CexxonFAsAeDGzYAWzEWtaDKnCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlqD3xW+CDbks0zu73CyQeoWGunbu6P35XhdIcEGk+nw71bxIRPSZ/yuEx9g6w+zOrtUOeApKykGPOrqhBCCC50xwTX9KSLViaucWHdKP9EZ2tq2To2Fqs0FClvFt+kwF5302BY22w5Ac5bMhzZ0/NWTB3IqsjcCdZ1IVzpbOQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZYv0w8X; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51a7d4466bso668791166b.2;
        Tue, 23 Apr 2024 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713913730; x=1714518530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOubRUxsYQ+p5re1HJn2aIjhIuCSgEkL2WgxwHltP6c=;
        b=OZYv0w8XtuZ6TJeD/K5yE29lji1bttgBU9DIC5TQ8kryzD3J7EFWV5iz4SRQ1iOMNO
         r0amrFFXAT1mKCbK7MLJ9TdNUJ/BDKOOkIssSa91QTAwRJjjj1x7IioF3BytkpzeYawO
         1eCiQ84rCJNa9VfDd9w5zKRxWpBTkMxB0f0gPB95sZfGrR33vT2NgJtxmwJITVLiZsCf
         rHqU3i6QSg/TI5RUNooxDIJOxFdHahtBUcXmMwE6NeaaYO55G3SzYvdCLuBgyoSQVVJk
         MzBLVG72vx47+JnGnGi0B4KHyS1BwR92iKrS59n1Wnreln21VGVxlU4Pdl16yHz00cL0
         MjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713913730; x=1714518530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOubRUxsYQ+p5re1HJn2aIjhIuCSgEkL2WgxwHltP6c=;
        b=r9ScyCLfgMnC23Cim+z5DgUVMUJcg4jum3NH6Jget83KUdNe+5UQ8Y6PEVm/sFoA3w
         gDfjNB/gy5C/LuoduolBwBV4LYcm5M33YR2t+rEjLN1FDn/BymA2MXgryYH8h49hSWVx
         EGjkAc6lWSruJTwEElz2DlkFfs1UYSW4I1bxUiDRANXTB9fVzBr4FGbqBm94XWvSt2h6
         dJglOl1Q8H1zabFrzn5/G9FUlnGJIzD96PVIwCYIJ9WjjrkT1/EL4QD5eLeuSJKD312s
         uvm/0wEAIUm7SugCR7SDGNRHGBa81uVKwAjiju1EEO77pvpDojbCRRIov7vJCUDFFz4c
         IQDw==
X-Forwarded-Encrypted: i=1; AJvYcCWxYK3xUgdPYcDJKw8gBE+851rWHWqKASMfqWtzUNHlDdSAJL9JS2RrbvwrQV/05YtFfnh0xL1iJL8X4Pbq3hpNmEPQ/P/2HUcQEiUtHbADF2WjbBif0mjpoyGv5RsUr/MyoI8XY8MaP6grB/hcYzTYaIviFfcQSnUjNzGExvS+gzHlvSuXrNByJzpCiDh6FGb4DT7j5IjzVxuw/Isl3Ps4
X-Gm-Message-State: AOJu0YwmfK0OnBve5ruObIdBdJBsDnsVe7MGM6MyGjoaQF7Jh9D5GX5V
	bj30LssmgwjkG2Bn2m+HK4uL/5PnY68YuZCLoRUIW7UJImZ9c1nrWdUh8iwzv6SR4/WQ0+AaAXV
	hyKP0z/Nr1XFESTLQxbRoatjEC7A=
X-Google-Smtp-Source: AGHT+IH0I+fz392Yc9QQdmMfH48abnh5L/ReLRRQ4WhXNmBB/5ukEAf+sHnLvLjG5foXtSu/lNY/gm9SoFxlBu7Gy2s=
X-Received: by 2002:a17:906:aace:b0:a55:552d:965e with SMTP id
 kt14-20020a170906aace00b00a55552d965emr467140ejb.6.1713913729829; Tue, 23 Apr
 2024 16:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423223309.1468198-2-aren@peacevolution.org> <20240423223309.1468198-5-aren@peacevolution.org>
In-Reply-To: <20240423223309.1468198-5-aren@peacevolution.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 02:08:13 +0300
Message-ID: <CAHp75Vcp=-T2135s3rVbpQzcG=iiieit+L0BgnmoZet_AsbgcA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] iio: light: stk3310: Manage LED power supply
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

On Wed, Apr 24, 2024 at 1:41=E2=80=AFAM Aren Moynihan <aren@peacevolution.o=
rg> wrote:
>
> The stk3310 and stk3310 chips have an input for power to the infrared
> LED. Add support for managing it's state.

its

..

>         if (IS_ERR(data->vdd_reg))
>                 return dev_err_probe(&client->dev, ret, "get regulator vd=
d failed\n");
>
> +       data->led_reg =3D devm_regulator_get(&client->dev, "leda");
> +       if (IS_ERR(data->led_reg))
> +               return dev_err_probe(&client->dev, ret, "get regulator le=
d failed\n");

Can't you use a bulk regulator API instead?

--=20
With Best Regards,
Andy Shevchenko

