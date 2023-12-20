Return-Path: <linux-kernel+bounces-7027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC4981A0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD801F2A1D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3A038DE5;
	Wed, 20 Dec 2023 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKG469aN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140B381B2;
	Wed, 20 Dec 2023 14:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3419BC433C9;
	Wed, 20 Dec 2023 14:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703081069;
	bh=rgiDGvgZVGtqWKKiBe9tiDZOroTq3u2y1PmyOEn9Hyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jKG469aNJKPh+zRF40g1uu1kxbQuLz+u0L/Ow08hvtl5RxvgW/fZEIIr+M9wqL7hH
	 z2ui/DfwaAcu6IpWuDbw20jQqBkA2V2Q5uORzPikgTlvrUcfbaPvzoYbEHG6yqs0WZ
	 R4LgPerYwLRMcPBwTI4jbY5u1IP0qC8J48E8ouTa+du7T4mFTj4d//DgxJGBuoPkGl
	 wNJ3Y3JmHooODmoikIEzaXV+vF8YEf4F1IgsKfB//nJDuupmdSgtH7BIK9RJJcZWtz
	 irGzQvOe/VwWrl1H2MoYn5JIAtsi/rf2VECzYspJGPozV/lFD4H6La8awOFJQojBKH
	 oz8S9yOUTnOcg==
Date: Wed, 20 Dec 2023 14:04:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
 joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
 paul.cercueil@analog.com, Michael.Hennerich@analog.com, lars@metafoo.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dan.carpenter@linaro.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/15] iio: adc: ad7091r: Enable internal vref if
 external vref is not supplied
Message-ID: <20231220140415.0143e8ca@jic23-huawei>
In-Reply-To: <ZYCC3z44hMzgQTa6@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
	<ce92ae93b1c2e36b20a9881b145c8c2c85acb1dd.1702746240.git.marcelo.schmitt1@gmail.com>
	<20231217154142.191ba69b@jic23-huawei>
	<ZYCC3z44hMzgQTa6@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 14:35:27 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 12/17, Jonathan Cameron wrote:
> > On Sat, 16 Dec 2023 14:49:07 -0300
> > Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> >   
> > > The ADC needs a voltage reference to work correctly.
> > > Enable AD7091R internal voltage reference if no external vref is supplied.
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>  
> > This one sounds to me like it should have a fixes tag and be
> > much earlier in the set to perhaps simplify backports.  
> 
> Could be. If we stick to the fact that the dt-binding does not require a voltage
> regulator then this can be seen as a fix.
> Though, if users can provide an external reference this patch makes no
> difference them.
> I am using the internal reference for testing so having this one makes a
> difference for me.
The binding has it as optional, though usually when not having an
external reference leads to use of an internal one, we call it out
in the description.  

Meh, can backport it as a fix if anyone asks for it.

Jonathan

> 
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/adc/ad7091r-base.c | 7 +++++++
> > >  drivers/iio/adc/ad7091r-base.h | 1 +
> > >  2 files changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> > > index aead72ef55b6..9d0b489966f5 100644
> > > --- a/drivers/iio/adc/ad7091r-base.c
> > > +++ b/drivers/iio/adc/ad7091r-base.c
> > > @@ -217,7 +217,14 @@ int ad7091r_probe(struct device *dev, const struct ad7091r_init_info *init_info,
> > >  	if (IS_ERR(st->vref)) {
> > >  		if (PTR_ERR(st->vref) == -EPROBE_DEFER)
> > >  			return -EPROBE_DEFER;
> > > +
> > >  		st->vref = NULL;
> > > +		/* Enable internal vref */
> > > +		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> > > +					 AD7091R_REG_CONF_INT_VREF, BIT(0));
> > > +		if (ret)
> > > +			return dev_err_probe(st->dev, ret,
> > > +					     "Error on enable internal reference\n");
> > >  	} else {
> > >  		ret = regulator_enable(st->vref);
> > >  		if (ret)
> > > diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> > > index 81b8a4bbb929..9cfb362a00a4 100644
> > > --- a/drivers/iio/adc/ad7091r-base.h
> > > +++ b/drivers/iio/adc/ad7091r-base.h
> > > @@ -20,6 +20,7 @@
> > >  #define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
> > >  
> > >  /* AD7091R_REG_CONF */
> > > +#define AD7091R_REG_CONF_INT_VREF	BIT(0)
> > >  #define AD7091R_REG_CONF_ALERT_EN	BIT(4)
> > >  #define AD7091R_REG_CONF_AUTO		BIT(8)
> > >  #define AD7091R_REG_CONF_CMD		BIT(10)  
> > 
> >   


