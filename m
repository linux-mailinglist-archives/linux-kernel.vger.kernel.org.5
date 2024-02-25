Return-Path: <linux-kernel+bounces-80045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF0862A1B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192B3281A80
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775901095A;
	Sun, 25 Feb 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osUyFlyJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CCFFC0B;
	Sun, 25 Feb 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708861229; cv=none; b=Oa9+4hJl6c4DUY93/oAt97vFqpeHI/FFiqv7Xy89Dwl1QTh0P0uzudEQAEmFiIWyBarHxDRRPUijfDZxCe/SM6l9a18MMV1GTUV/INEjbgt5eQ4BsftCu2jhY47f08wxq8+KrOiWrBtgJp/w3chpzuFhWKCRLh+9c9xO2plxuDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708861229; c=relaxed/simple;
	bh=P8+9rvC4e3Cz1f2sRgvgazowIHQMzZ4yFaqZrMvpO9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myzZrlHwNqmukJC4Njb6cwjWom+pVCeX2wH1KXffXYYdm+N2EKqAJEdg2gRYUv7lh5+YIkqCbJvZfP4I1hisqpiJNDINI4v/w4RltJxQff+h1YXIgkOy4M65OIuowvReOJcAhZCs3qdliVRmXaV5OVWubGKASPR7QovbPnS0So8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osUyFlyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0816BC433C7;
	Sun, 25 Feb 2024 11:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708861229;
	bh=P8+9rvC4e3Cz1f2sRgvgazowIHQMzZ4yFaqZrMvpO9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=osUyFlyJkuiX6k2IVh48nh3CUYrZ280S8OpF4tTlq+Xno+NSlAmJZsKqABOiGFNaV
	 4OsTYFcYmS8917tEmmbSFL3gqxQsj78OwP7gYUh/c/IubvkdRgnC9sJ9yAHVBIQFFL
	 +K1OI5fHE26C5aqoyCcdhNyJCw9wD1rckBH7evhFrm8LbOHKGlmCKz+aYEVGCnTfMP
	 6UYZjv0JGQx9bQcnxMj6Guixe1W0pFVsa/Vlz2l4pVbYqN49kkZ1wrF9ovJOqUZ+XO
	 yeF6Ur40yYvx77HXUe4bLr73ZMztlf/Z07odw4cOWf83AHlWze+0AwAE2C9Cp5ZP24
	 viApYQHYR3k8w==
Date: Sun, 25 Feb 2024 11:40:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Marek Vasut
 <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matt Ranostay <matt@ranostay.sg>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20240225114013.7a5e11be@jic23-huawei>
In-Reply-To: <15a46491-d126-4998-88f0-1720316f0a6c@tweaklogic.com>
References: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
	<20240218054826.2881-6-subhajit.ghosh@tweaklogic.com>
	<20240224151340.3f2f51e8@jic23-huawei>
	<15a46491-d126-4998-88f0-1720316f0a6c@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >   
> >> +
> >> +	/*
> >> +	 * If a one-shot read through sysfs is underway at the same time
> >> +	 * as this interrupt handler is executing and a read data available
> >> +	 * flag was set, this flag is set to inform read_poll_timeout()
> >> +	 * to exit.
> >> +	 */
> >> +	if ((status & APDS9306_ALS_DATA_STAT_MASK))
> >> +		data->read_data_available = 1;
> >> +
> >> +	return IRQ_HANDLED;
> >> +}  
> > 
> > ...
> >   
> >> +static int apds9306_read_event_config(struct iio_dev *indio_dev,
> >> +				      const struct iio_chan_spec *chan,
> >> +				      enum iio_event_type type,
> >> +				      enum iio_event_direction dir)
> >> +{
> >> +	struct apds9306_data *data = iio_priv(indio_dev);
> >> +	struct apds9306_regfields *rf = &data->rf;
> >> +	int int_en, event_ch_is_light, ret;
> >> +
> >> +	switch (type) {
> >> +	case IIO_EV_TYPE_THRESH:
> >> +		guard(mutex)(&data->mutex);
> >> +
> >> +		ret = regmap_field_read(rf->int_src, &event_ch_is_light);  
> > 
> > Call the local value int_src - it's not obvious to a reviewer what
> > relationship between that and int_src is. I had to go read the datasheet
> > to find out.  
> This unique name was suggested in a previous review:
> https://lore.kernel.org/all/20240121152332.6b15666a@jic23-huawei/
> I will change it next version. int_src is logical.

Ah, I failed to register that it was a multi bit field (which it isn't
really but we should track what the datasheet says).  If it had
been a single bit then it would have made sense to name it as a boolean
flag.  Not so when in theory it could take 4 values (even if only 2 are
defined).

> >   
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		ret = regmap_field_read(rf->int_en, &int_en);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		if (chan->type == IIO_LIGHT)
> >> +			return int_en & event_ch_is_light;
> >> +
> >> +		if (chan->type == IIO_INTENSITY)
> >> +			return int_en & !event_ch_is_light;  
> > This is the specific line the compiler doesn't like
> > drivers/iio/light/apds9306.c:1036:39: warning: dubious: x & !y  
> I am using gcc 12.2.0 for cross compiling. I definitely do not want to send
> patches with warnings in them. Can you please let me know the gcc version
> or flags using which you got the above warning? Should I always use the
> latest released version?
Version shouldn't matter that much but this was x86 build with gcc 13.2.1
W=1 is maybe what is showing this up as it enables a bunch more warnings.

IIO is almost clean with W=1 though a few minor things have gotten in recently
that I need to tidy up.

> > 
> > I would match int_src against specific values rather than using tricks
> > based on what those values happen to be.
> > 
> > 			return int_en && (int_src == APDS9306_INT_SRC_CLEAR);  
> I will implement this.
> 
> 
> Thank you for taking time to review the code in detail and also appreciate
> your suggestions.
> 
> Regards,
> Subhajit Ghosh


