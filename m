Return-Path: <linux-kernel+bounces-155995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFB38AFC76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1311F22F57
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556DD3D3BD;
	Tue, 23 Apr 2024 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRKFOo6R"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E601E891;
	Tue, 23 Apr 2024 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914206; cv=none; b=GignofCtnNxO/xU/k73TqNdvmWVsYEeT3MUCnSq1cNFbsYUk1MjPs8nTEM765abv9ISDtdxtYUZQrUypqdou+IERGKoryWL2688XugGZShXzoHUk5MIL4AgbFsQIudh5GqW/ADmSV2+BSBXyWWheoboB0l6O/miIOzclInjwmWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914206; c=relaxed/simple;
	bh=7wftDFTjIIAwQlVxhCOtE1A7It3KWm3iQw5DK5y64pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzMnK2vxRjbCwlRoZqFrw33y02+pev6xcCRlz25Q5hFA6bT2SPCEbBGHfHFsrpgRYVrzelrUbDA3GGgqQ0ltkAtKQsNsbDZVcNTViNS0fp3hvWlQpmBu85cwSaW5Adv92fu/gOTJLxe5oUT7yiFSpS1zTxXpyrLv9tT56FE/Mak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRKFOo6R; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d2600569so7920849e87.0;
        Tue, 23 Apr 2024 16:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713914203; x=1714519003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aca9K8EpXVseGVnleC7T/tkn8XH23MGY+cAgNNEhNds=;
        b=SRKFOo6Rq75wf3SdtY1TmT0xgdfWawT0XgoV3sJqMb6vawI5BnjNs9BZ/qct93h3ZJ
         tI2OGk8kHP+v4iAIZK3ZhozQNf/LvuF5/2Cxda0JN9nNf+VBrEBkB7svM1fdpmcEd0hw
         toCrgRj2/2YfyzQNku8BNdAnM3iu3N8H38P5HXuM+fTSuB+WF9Wc0Yf3g2zd6QbWLtg5
         0m/7O8LRhrx3G6PoMhaA6D10HwBwphv9mXdUtBg6XoWHUlf+TTrmYbyNW6DtunLTAKPO
         uBs2OR9iBF/pck1mQch18b/ir18n4P1seipLMuHF060PhKlkml2ARLU2PNaUtMOBBfJ9
         P1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713914203; x=1714519003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aca9K8EpXVseGVnleC7T/tkn8XH23MGY+cAgNNEhNds=;
        b=stTDncCEfwu3enyge1dki9p+xd8Dp+tgtwmxa9/6iTvxa6t/xiXOMAXf7g/0GXXGfn
         mjaegSxg+bKG2Skm5NcgH05JPA2RrQRHDdi8QhCkpU16jSG7246BfaW9qP65n4kSPVQt
         Pigk6Fj4nh6JURstMDCrcWcMDB20KKYNEgWNgS+jm+fUbjcGmf88mmTzTck9EF5LVAJ3
         6zIYXWnX0w3xFRKLYmsKKVYfyy81w/bPnchug4o1m1fiaH1Blv/noC8e0bLZZ5DODuvm
         vXraLLFH5D7XbxWkYuUE9Q5fxlO6nUxdx0xGZC+O3khm67wwS/w2LulBUfkOZkhYsu35
         o1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+lCc+AA1QP810YMNouhbMCobsO+h053l6+Gyj0ybjLMmW/Yw5PYQP+N9KzEnsxn1xqqLvwT7Ih39Yh9YX3Uk1Bl/1JgSaNkKem4PP2j+MisoJVoKBO6ANDRcpeIaKdYrMJWSJkKtdbFzPM43qMOqmV4suyXpOi4vMd470KOXDWx8ymhtGgqA7Nq9dq3cE6pQGBhvKiMMoWurt44rOC8l/
X-Gm-Message-State: AOJu0YxUo85pdogf+Lv/LPX/TrZBYbKqW/7FdSEz71JYjLtoy8pgCulB
	DyiWifqmydE/PKIAB7Y1DQGk9kGl+yDVJZlhOnmKHaMD6wBpTeVk53cMaHGBRD5fO1q28cWFB/+
	8at3wHl3Hh07mhWs31ApdMMyDJoA=
X-Google-Smtp-Source: AGHT+IH10mlUfrVcAQ8LqIHHv7aiYPpNjEMy52tN6YA8d6VSedLkjWnBjwpaw//pCrnhLX3kZ6HsfrXhTzJKHNzrtK8=
X-Received: by 2002:a19:ca08:0:b0:51a:f3b9:f774 with SMTP id
 a8-20020a19ca08000000b0051af3b9f774mr637571lfg.21.1713914202904; Tue, 23 Apr
 2024 16:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423223309.1468198-2-aren@peacevolution.org> <20240423223309.1468198-4-aren@peacevolution.org>
In-Reply-To: <20240423223309.1468198-4-aren@peacevolution.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 02:16:06 +0300
Message-ID: <CAHp75VeRDSPvpmSbUyZPp0RMoTOE193U2ma18qxv_qZQKLCq8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and
 power it off during suspend
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
> From: Ondrej Jirman <megi@xff.cz>
>
> VDD power input can be used to completely power off the chip during
> system suspend. Do so if available.

..

>         ret =3D stk3310_init(indio_dev);
>         if (ret < 0)
> -               return ret;
> +               goto err_vdd_disable;

This is wrong. You will have the regulator being disabled _before_
IRQ. Note, that the original code likely has a bug which sets states
before disabling IRQ and removing a handler.

Side note, you may make the driver neater with help of

  struct device *dev =3D &client->dev;

defined in this patch.

..

>  static int stk3310_suspend(struct device *dev)
>  {
>         struct stk3310_data *data;

>         data =3D iio_priv(i2c_get_clientdata(to_i2c_client(dev)));

Side note: This may be updated (in a separate change) to use
dev_get_drvdata() directly.

Jonathan, do we have something like iio_priv_from_drvdata(struct
device *dev)? Seems many drivers may utilise it.

>  }

..

>  static int stk3310_resume(struct device *dev)

Ditto.

--
With Best Regards,
Andy Shevchenko

