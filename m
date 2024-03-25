Return-Path: <linux-kernel+bounces-117886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D726B88B0DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F562E4372
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0004F41231;
	Mon, 25 Mar 2024 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCq/30nk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABB43E468;
	Mon, 25 Mar 2024 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397203; cv=none; b=tPd1ZBkKWy+2bHebBbHJRRGwY0y3ADpk0xsbKGt2mRKnRthI8yn0yUZMW6sSyOci7HBKuQJlsiIMznBu7G14AGrxXz0Be2CiY5/0koPHtTUbUjehIfnwlmIP8CnBWBVmIWwizTj9SC2csnuwC3hW7x03v2e6ETlX3JcivN8X5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397203; c=relaxed/simple;
	bh=TFyc7t7zAjF14Ku+RI2u7lJnCT2d4Wt2C2Ahw/P8HW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZA503o6Sjtf+4PpQ5OY/uWXKtQj/9HynDDXksveRihUvlhSn3T9Z/WlJRMQdlTyMQ2+P/opCPkwVTqjh2eqh5hVXCvGrrxIk+lwL3wSx+7zp+38QecNGy7SEpPuqGxKg6r6WYeKdHbL+kI1CYxHlAnh05ifKCMJAs0uUPTpRPhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCq/30nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855F5C433F1;
	Mon, 25 Mar 2024 20:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711397202;
	bh=TFyc7t7zAjF14Ku+RI2u7lJnCT2d4Wt2C2Ahw/P8HW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oCq/30nkbitp5TaP/65h2LjOGxDs81MCvMY3Fqo3I76+1/BGnWdq1gGTuRLBUCZXi
	 X22nB5Re7Rh3xEiZjLVqGBglCDSW1TPVhHfIVXmOhIr47oiANLUt0gkHGJbCefGE0J
	 VckK+PFUZEWc4kxwZ6P+XYX9zPE/Pmc1Z857yQm4L8V//8XlRfoz0IK1mw5B/KsaJt
	 9Q5ZHatW8UI//Xcqvcole458xy8oeNpa5pkBnHOp97cD2WhxiyytGxj6rW75JTrQfh
	 BGXCoY+hZsdt1Xam8ElbM4GqJ0nYzISvggIcey4++RpLlU68TZttccJzIc4UAX2ckX
	 i0h+4XsZyaJJg==
Date: Mon, 25 Mar 2024 20:06:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 4/7] iio: adc: ad7380: add support for
 pseudo-differential parts
Message-ID: <20240325200625.5a07cec4@jic23-huawei>
In-Reply-To: <CAMknhBGmM7yt1JR1tW4SS5RLGpN9PtnMrf0WvZ-bhU-gSv3YUQ@mail.gmail.com>
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
	<20240319-adding-new-ad738x-driver-v5-4-ce7df004ceb3@baylibre.com>
	<20240324130135.35f4b0eb@jic23-huawei>
	<CAMknhBGmM7yt1JR1tW4SS5RLGpN9PtnMrf0WvZ-bhU-gSv3YUQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +     /*
> > > +      * pseudo-differential chips have common mode supplies for the negative
> > > +      * input pin.
> > > +      */
> > > +     for (i = 0; i < st->chip_info->num_vcm_supplies; i++) {
> > > +             struct regulator *vcm;
> > > +
> > > +             vcm = devm_regulator_get_optional(&spi->dev,  
> >
> > Why optional?
> >  
> > > +                                               st->chip_info->vcm_supplies[i]);
> > > +             if (IS_ERR(vcm))  
> >
> > This will fail if it's not there, so I'm guessing you are using this to avoid
> > getting to the regulator_get_voltage?  If it's not present I'd rely on that
> > failing rather than the confusing handling here.
> >
> > When the read of voltage wasn't in probe this would have resulted in a problem
> > much later than initial setup, now it is, we are just pushing it down a few lines.
> >
> > Arguably we could have a devm_regulator_get_not_dummy()
> > that had same implementation to as get_optional() but whilst it's called that
> > I think it's confusing to use like this.  
> 
> Despite the misleading naming, I guess I am used to
> devm_regulator_get_optional() by now having used it enough times.
> Since it fails either way though, technically both ways seem fine so I
> can't really argue for one over the other.
> 
> But given that this is a common pattern in many IIO drivers, maybe we
> make a devm_regulator_get_enable_get_voltage()? This would return the
> voltage on success or an error code. (If the regulator subsystem
> doesn't want this maybe we could have
> devm_iio_regulator_get_enable_get_voltage()).
> 
> If the dev_err_probe() calls were included in
> devm_regulator_get_enable_get_voltage(), then the 10+ lines of code
> here and in many other drivers to get the regulator, enable it, add
> the reset action and get the voltage could be reduced to 3 lines.

I like this proposal a lot. RFC, so it's visible outside the depths
of this thread?
Particularly good as it will keep the regulator opaque in the same
fashion as devm_regulator_get_enabled()

As you say, we have a 'lot' of instances of this (quick grep
suggests > 50 in IIO alone and smaller numbers elsewhere).

Jonathan


> 
> >  
> > > +                     return dev_err_probe(&spi->dev, PTR_ERR(vcm),
> > > +                                          "Failed to get %s regulator\n",
> > > +                                          st->chip_info->vcm_supplies[i]);
> > > +
> > > +             ret = regulator_enable(vcm);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             ret = devm_add_action_or_reset(&spi->dev,
> > > +                                            ad7380_regulator_disable, vcm);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             ret = regulator_get_voltage(vcm);  
> >
> > I'd let this fail if we have a dummy regulator.
> >  
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +
> > > +             st->vcm_mv[i] = ret / 1000;
> > > +     }
> > > +  
> 


