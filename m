Return-Path: <linux-kernel+bounces-157638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A008B13E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D53287916
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC1F13DB8C;
	Wed, 24 Apr 2024 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="ymkNnORv"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0EF13B59F;
	Wed, 24 Apr 2024 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988851; cv=none; b=VmB3PbAbobBdzb/DcOMgHlLY9lrqNYuwZSvVtQ7bgKUNhbmlypIse1JSQgzOrY3jOFoivJsxjEyDb8bErcE7YyXRMTF7PTY+E3WPr14nh8qU7vBC9yGqSNhsi3aAzHb1aMR6RXXYyu5D9x/BmbYz1DVz06JYnShhSsbxeGPxRJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988851; c=relaxed/simple;
	bh=PDAVfIibszca/yt5F0VeGPq35/5g0qR5+vGvPxJ0lMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXXZsoc2mT9KwVvAb8Y4akihtsbSljFBfIRR0sayJmlYCUVdOlp1pg8mfW/hyO6SUCv9Fb8p6OKF4OgFz7ShfG0fn0Gkj38MAfDs0JoSiiSiBTpwf/I5Lb7VM52+QjSHY1lC1Pgti0+jwVqLJADDiGu+HE7kFKIhWL9ywdrdBbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=ymkNnORv; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1713988846; bh=PDAVfIibszca/yt5F0VeGPq35/5g0qR5+vGvPxJ0lMo=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=ymkNnORv5kDLrd8/rlrBZZrrDJyZnYn+T8AGN7ULKjl1Wmvh8aueVYmyyBN7p7ewp
	 HN8PsOhzxULWUwjATSjr+cm8JwHSo8EQafnc1o53AkS2UWHDY9SwfzMdMzByio7hwl
	 xN6e7C6J0BM25jsAMs6NjvdDcsMzFpn/R1ivHTdQ=
Date: Wed, 24 Apr 2024 22:00:46 +0200
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
Message-ID: <yl4b23gclij2jqyxlqkmfmct4vlz6gotwfgbpkisgz2fuuh7uv@rbynxmitzjog>
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
 <5qqil7ltqhdeabml6toqpcy773uhjxgwaz3txpy4kv4sz55o2y@hmar674eey7s>
 <CAHp75VdR9HtWbSif+j8QHX5zG9xPF1GzUFY2s-0OjD3RAWD9-Q@mail.gmail.com>
 <xxbwdl6ebvut3u7qhzfy65e4eheixghqe7yn4qemyuowxyxj5a@r2wa2b7bhw2x>
 <CAHp75VejwJ7h5jaNL+VL7FE4UMbTEP3QA1E=_y-1PSrz99zBKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VejwJ7h5jaNL+VL7FE4UMbTEP3QA1E=_y-1PSrz99zBKQ@mail.gmail.com>

On Wed, Apr 24, 2024 at 08:31:27PM GMT, Andy Shevchenko wrote:
> On Wed, Apr 24, 2024 at 7:14 PM Ondřej Jirman <megi@xff.cz> wrote:
> > On Wed, Apr 24, 2024 at 06:20:41PM GMT, Andy Shevchenko wrote:
> > > On Wed, Apr 24, 2024 at 3:59 PM Ondřej Jirman <megi@xff.cz> wrote:
> > > > On Wed, Apr 24, 2024 at 02:16:06AM GMT, Andy Shevchenko wrote:
> > > > > On Wed, Apr 24, 2024 at 1:41 AM Aren Moynihan <aren@peacevolution.org> wrote:
> 
> ...
> 
> > > > > >         ret = stk3310_init(indio_dev);
> > > > > >         if (ret < 0)
> > > > > > -               return ret;
> > > > > > +               goto err_vdd_disable;
> > > > >
> > > > > This is wrong. You will have the regulator being disabled _before_
> > > > > IRQ. Note, that the original code likely has a bug which sets states
> > > > > before disabling IRQ and removing a handler.
> > > >
> > > > How so? stk3310_init is called before enabling the interrupt.
> > >
> > > Exactly, IRQ is registered with devm and hence the error path and
> > > remove stages will got it in a wrong order.
> >
> > Makes no sense.
> 
> Huh?!
> 
> > IRQ is not enabled here, yet. So in error path, the code will
> > just disable the regulator and devm will unref it later on. IRQ doesn't enter
> > the picture here at all in the error path.
> 
> Error path _after_ IRQ handler has been _successfully_ installed.
> And complete ->remove() stage.

Allright. So fixing the other issue I mentioned will fix this one too, because
there will be no error path after IRQ enable, then.

kind regards,
	o.

> > > > Original code has a bug that IRQ is enabled before registering the
> > > > IIO device,
> > >
> > > Indeed, but this is another bug.
> > >
> > > > so if IRQ is triggered before registration, iio_push_event
> > > > from IRQ handler may be called on a not yet registered IIO device.
> > > >
> > > > Never saw it happen, though. :)
> > >
> > > Because nobody cares enough to enable DEBUG_SHIRQ.
> >
> > Nice debug tool. I bet it makes quite a mess when enabled. :)
> 
> FWIW, I have had it enabled for ages, but I have only a few devices,
> so I fixed a few cases in the past WRT shared IRQ issues.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

