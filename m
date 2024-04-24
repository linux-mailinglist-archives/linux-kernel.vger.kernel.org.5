Return-Path: <linux-kernel+bounces-156915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245178B0A47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E88B2849A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F4415B99C;
	Wed, 24 Apr 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="m2Opc8GE"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CA115B576;
	Wed, 24 Apr 2024 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963599; cv=none; b=A5jDNZ44oONk38aZ5CMlWTCvRjVT2NRl+8N39KGMdVYVpBVCxwyIGSC9u7+cKF9wM6iIMhsN/9KPsCs18VhZCyn1jjBazEf5vYlde9z5fit18mIOzZfKWArsR/XdW6UJ13tFf9C5+cqnWS/LlxIytthZYRrun/gCohT1FH0NMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963599; c=relaxed/simple;
	bh=kamfKpDUAuUVYKc3JD6fhJN/bs5aaqGFBEBTvufzKSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciHFUfx0mWhSGKhwwTSETTe8YoV+1zgR/0krI7gdcBhm85O5LjbILd9JJnFtaKFqYTCR8YvMhQcerRlVSKVd8x7OdIMIg4u5OVDi5c7tZEZR/Jx5Xn4hSiNCopLsTE+tOe8b3vaHliEP7W1jeACDo91YPMc9Bh1YQVB8OxU9kb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=m2Opc8GE; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1713963589; bh=kamfKpDUAuUVYKc3JD6fhJN/bs5aaqGFBEBTvufzKSA=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=m2Opc8GEH5y1OCPgcUHTFE55CkaXhDFNC4qU5zJuox4opmWh69YhB6n2wMWjbLBew
	 iA9GtdDPXTHD7fXEV5ewxEJen0QK5Byy+ZQrWJWDnxEvXD2onLoNfnFu1kqiijSerA
	 m/BxquIGSzeUxD7Eitsp/l5Uuxbg6yxVAETYL/EE=
Date: Wed, 24 Apr 2024 14:59:48 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Aren Moynihan <aren@peacevolution.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org, phone-devel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Willow Barraco <contact@willowbarraco.fr>
Subject: Re: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and
 power it off during suspend
Message-ID: <5qqil7ltqhdeabml6toqpcy773uhjxgwaz3txpy4kv4sz55o2y@hmar674eey7s>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Aren Moynihan <aren@peacevolution.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org, phone-devel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Willow Barraco <contact@willowbarraco.fr>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240423223309.1468198-2-aren@peacevolution.org>
 <20240423223309.1468198-4-aren@peacevolution.org>
 <CAHp75VeRDSPvpmSbUyZPp0RMoTOE193U2ma18qxv_qZQKLCq8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeRDSPvpmSbUyZPp0RMoTOE193U2ma18qxv_qZQKLCq8g@mail.gmail.com>

On Wed, Apr 24, 2024 at 02:16:06AM GMT, Andy Shevchenko wrote:
> On Wed, Apr 24, 2024 at 1:41 AM Aren Moynihan <aren@peacevolution.org> wrote:
> >
> > From: Ondrej Jirman <megi@xff.cz>
> >
> > VDD power input can be used to completely power off the chip during
> > system suspend. Do so if available.
> 
> ...
> 
> >         ret = stk3310_init(indio_dev);
> >         if (ret < 0)
> > -               return ret;
> > +               goto err_vdd_disable;
> 
> This is wrong. You will have the regulator being disabled _before_
> IRQ. Note, that the original code likely has a bug which sets states
> before disabling IRQ and removing a handler.

How so? stk3310_init is called before enabling the interrupt.

Original code has a bug that IRQ is enabled before registering the
IIO device, so if IRQ is triggered before registration, iio_push_event
from IRQ handler may be called on a not yet registered IIO device.

Never saw it happen, though. :)

kind regards,
	o.

> Side note, you may make the driver neater with help of
> 
>   struct device *dev = &client->dev;
> 
> defined in this patch.
> 
> ...
> 
> >  static int stk3310_suspend(struct device *dev)
> >  {
> >         struct stk3310_data *data;
> 
> >         data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
> 
> Side note: This may be updated (in a separate change) to use
> dev_get_drvdata() directly.
> 
> Jonathan, do we have something like iio_priv_from_drvdata(struct
> device *dev)? Seems many drivers may utilise it.
> 
> >  }
> 
> ...
> 
> >  static int stk3310_resume(struct device *dev)
> 
> Ditto.
> 
> --
> With Best Regards,
> Andy Shevchenko

