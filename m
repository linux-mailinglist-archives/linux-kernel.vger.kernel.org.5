Return-Path: <linux-kernel+bounces-150365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392C68A9DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DC6286BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14C216C44E;
	Thu, 18 Apr 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="p6RTzvLK"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947E16ABFA;
	Thu, 18 Apr 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452809; cv=none; b=lF0vhN1uF/y15BC/Q0BAqUs45o9B4xnMT95jy7lU1x6TwMt9nuWDIlrvHF2bhLOq09FKBNULqKpitaX4+zeWq0OhaZdhlAQhEecOq9yPbn/GfjbnkC/DaQSto+CrBXzahFbnnLEAQblV/eQnMEF1cqZMBrljKJTGL4MzFH9yJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452809; c=relaxed/simple;
	bh=oGcY+BupHlocn3xxw4/g576DsNISjK2nsy9HQ+Z9ZzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bbq0bPi8qHN5Rokyzg9yawWN1O5mwHyfmcBT1nxIq1Bk+l01L7z+k5VvV4XlsZpoIv3uRMh+xx6lE0v+QdwSA1DVxvkg++8JAFxuehvPU+wMljkWacPBZNV8VEUjirqDZdHJZ0eHF9tunRozgIlkgiw4jI9MRpdJlLImNgSRK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=p6RTzvLK; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 732C7479B3;
	Thu, 18 Apr 2024 15:06:35 +0000 (UTC)
Date: Thu, 18 Apr 2024 11:06:32 -0400
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
Subject: Re: [PATCH 2/4] iio: light: stk3310: Implement vdd supply and power
 it off during suspend
Message-ID: <xxeg3as5m5vmmu6fbjujcnvchrerxs2rr42nloirwsktbv4r57@vpxtxblxmspl>
References: <20240414175300.956243-1-aren@peacevolution.org>
 <20240414175716.958831-1-aren@peacevolution.org>
 <20240414175716.958831-2-aren@peacevolution.org>
 <CAHp75VdZavToGYqLYnkKYt53HXoQxXnRER5Cn5b2==gWTvkAWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdZavToGYqLYnkKYt53HXoQxXnRER5Cn5b2==gWTvkAWQ@mail.gmail.com>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1713452796;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=VCd0NHg7beAhJoKEm/QgbRTnUak2JYtg99vMXKxsa0M=;
	b=p6RTzvLKnixYbPyShowQRtk19eTobmvfGZGGbbHynE1W98DtGm0Vh5jeKHhResC5i2ODzI
	QmnANwv6xJ5A5/etHiIwvwPYQc8XhSBcelf2FJGftSilB6sfgJ4ltbihnMVY+IUz+N9HFF
	voTKduELX/t3TDY4UpOiD+UwsPnkvag=

On Mon, Apr 15, 2024 at 05:04:53PM +0300, Andy Shevchenko wrote:
> On Sun, Apr 14, 2024 at 8:57 PM Aren Moynihan <aren@peacevolution.org> wrote:
> >
> > From: Ondrej Jirman <megi@xff.cz>
> >
> > VDD power input can be used to completely power off the chip during
> > system suspend. Do so if available.
> 
> ...
> 
> >  #include <linux/iio/events.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> 
> > +#include <linux/regulator/consumer.h>
> 
> Move it to be ordered and add a blank line to separate iio/*.h group.
> 
> ...
> 
> > +       data->vdd_reg = devm_regulator_get_optional(&client->dev, "vdd");
> > +       if (IS_ERR(data->vdd_reg)) {
> > +               ret = PTR_ERR(data->vdd_reg);
> > +               if (ret == -ENODEV)
> > +                       data->vdd_reg = NULL;
> 
> > +               else
> 
> Redundant 'else' when you follow the pattern "check for error condition first".
> 
> > +                       return dev_err_probe(&client->dev, ret,
> > +                                            "get regulator vdd failed\n");
> > +       }
> 
> ...
> 
> > +       if (data->vdd_reg) {
> > +               ret = regulator_enable(data->vdd_reg);
> > +               if (ret)
> > +                       return dev_err_probe(&client->dev, ret,
> > +                                            "regulator vdd enable failed\n");
> > +
> > +               usleep_range(1000, 2000);
> 
> fsleep()
> 
> > +       }
> 
> ...
> 
> >         stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
> > +       if (data->vdd_reg)
> > +               regulator_disable(data->vdd_reg);
> 
> I forgot to check the order of freeing resources, be sure you have no
> devm_*() releases happening before this call.

If I understand what you're saying, this should be fine. The driver just
uses devm to clean up acquired resources after remove is called. Or am I
missing something and resources could be freed before calling
stk3310_remove?

> ...
> 
> > +               usleep_range(1000, 2000);
> 
> fsleep()

Everything else makes sense, I'll include those in v2 along with a patch
to switch stk3310_init to dev_err_probe.

Thanks for taking the time to review
 - Aren

