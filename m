Return-Path: <linux-kernel+bounces-157869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845A98B17A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6EE51C22416
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E636433FE;
	Thu, 25 Apr 2024 00:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="LiPBsvRd"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93918D;
	Thu, 25 Apr 2024 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003267; cv=none; b=m/JZKHfDQFKZuhavB+SBOYcYoEJGkJ9/jQEDtE5wPHR3b4LpkC0m8U3UVYZ8Xp0PmD0inhxVWLz4qVYzqIZmsAJTwDM92yr/HAcoTmnliX4AGjHdyHr0FpBJNIl1rd1GdV2W/LeIRqSLusVndEzH+rKm4PVuY6W4uf6BqffIh1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003267; c=relaxed/simple;
	bh=YK8ZVJPPSgK6IuSHNRED/Qsya04fG5N0aal1ljRlwDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qL0tdAwaOcHGk2GrOPdpmx89YZlqIEPK19V/Zowb1pD7dFOkmIrjUDT02KPlLNWOMKo7NrNos6vB0oOIUwCuW6x2iN3jHt68PyuhGXw5ktxnBrf6+Osw/mzvbBx6f+DuvKU0Qd+QxWGoM9arwIEZinuJx5L583p0H2kCiqB+4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=LiPBsvRd; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 7A2A247A38;
	Thu, 25 Apr 2024 00:00:56 +0000 (UTC)
Date: Wed, 24 Apr 2024 20:00:53 -0400
From: Aren <aren@peacevolution.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Ondrej Jirman <megi@xff.cz>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org, phone-devel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Willow Barraco <contact@willowbarraco.fr>
Subject: Re: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and
 power it off during suspend
Message-ID: <djxnxb6zcg7r4pl6gicjkcmqp6zodm24tq5cwejlwidzmtvf5x@3fqdvbc7whul>
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
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1714003257;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=hsQaSgt/dWJwaX3rAci/jyhFbRrZYWXtUE6c6yp+e0s=;
	b=LiPBsvRdEn3iltMiuPVD2b/4acdmis9HqCbFJnqStx+wTdODZwAd4Lc8uC1s/Sp2tXGvKv
	7wqZf2bJET+q0VlHXBhd5fjgMm5rkaFCHTklFy8jpT968iftpUi7eM+9wKWaWirwDrKoPY
	PT/UTF3sLvpEDML5Xhf39GimEbIT5qs=

On Wed, Apr 24, 2024 at 02:16:06AM +0300, Andy Shevchenko wrote:
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

Oh! now I see the issue you were talking about last time around. I
expect that means the irq shouldn't be managed with devres, so it can be
the first thing freed in the remove function (I haven't checked the docs
to see if there's an easier way yet).

I'll add a patch to fix the order of the handling of the irq (both this and
the issue Ondřej brought up).

> Side note, you may make the driver neater with help of
> 
>   struct device *dev = &client->dev;
> 
> defined in this patch.

Good point, it's minor, but it should be a net improvement.

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

At this rate I'm going to need to split off a separate style / code
cleanup series so I don't keep introducing dumb bugs while rebasing this
one.

Thank you for your time
 - Aren

