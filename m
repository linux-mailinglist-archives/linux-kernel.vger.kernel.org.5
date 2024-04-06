Return-Path: <linux-kernel+bounces-133884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B07689AA46
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 12:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEEF1F21BEE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8E82561D;
	Sat,  6 Apr 2024 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0iqZJYj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23B17C8B;
	Sat,  6 Apr 2024 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712397794; cv=none; b=oM3IqqJtXg+6v64k8XG1WL9c0nQe3ho7tnrErZP9w7OpSPn8g8rneLxi1PGYwcn0K0MA7c0L0XWOxkon7CkeWoZW/yKEKTB6hVoKT1VHq8wrqrM7HdUF3tpSxGyuiKMuspQ7sletedWbk4tiO1PrdTJ/+H3iv93uXrhkUVcC+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712397794; c=relaxed/simple;
	bh=ywQNKTlj4Tfn6ae3V2PE/XSgjxl0I5vplDGWumg7GVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZ1rqv142dqlj/DhoW+AZ3xO9mI8EeZL6qhQZcog39anRSzIZjHgSGZ0UW5c1Q2n8sBxQOJq9VXIsRa61gMOef24IV8di/S47swHzcvAX/w3s0suo8Dgnpy3SEnlDdOzBG31vLKW25l2M9Ur2U1s1wpgM87orxT9NydyjF5EfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0iqZJYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B953AC433F1;
	Sat,  6 Apr 2024 10:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712397794;
	bh=ywQNKTlj4Tfn6ae3V2PE/XSgjxl0I5vplDGWumg7GVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l0iqZJYj5p+ms49TiP7VKThlu5niXY13bbkLBBPyqx1pNNsIGt2wrnu4/5xTIt1ro
	 DxR3utetNCAlwk3qKJp2yUyi29dYGdmuJ995oJ2nDbZfH0RVgPVw3II19ETnpV+btG
	 3COOakexyvX6QygYGu3eeV60evK8ueBDefXcjWI170G0jGfFHu57EHlxRQu4u+6FGD
	 3sOkYLxY7AcU84qvdTViJxuDQondfn8BabRNRT+o3uxQEHH7ct3hoB9Im3fyhIXtRR
	 kXmvafjiAd3QFPLlna9/qHwXkraDVyJ6wMRpJIszcXe8LelGkG9469DtJ6eJ511Eog
	 Emgvz9QeFj0fg==
Date: Sat, 6 Apr 2024 11:02:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <20240406110259.572a3f25@jic23-huawei>
In-Reply-To: <20240402180849.GB18068@vamoiridPC>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
	<20240319002925.2121016-7-vassilisamir@gmail.com>
	<20240324121418.570857a9@jic23-huawei>
	<20240402180849.GB18068@vamoiridPC>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > >  
> > > +static irqreturn_t bmp280_buffer_handler(int irq, void *p)
> > > +{
> > > +	struct iio_poll_func *pf = p;
> > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > +	struct bmp280_data *data = iio_priv(indio_dev);
> > > +	s32 adc_temp, adc_press, adc_humidity;
> > > +	u8 size_of_burst_read;
> > > +	int ret, chan_value;
> > > +
> > > +	guard(mutex)(&data->lock);
> > > +
> > > +	if (test_bit(BME280_HUMID, indio_dev->active_scan_mask))  
> > 
> > This confuses me a little. Is it allowing reuse of this function for
> > multiple devices or aiming to optimise the read in the case of
> > the humidity channel being disabled (in which case I don't think
> > it works because you aren't providing that combination in avail_scan_masks.)
> > 
> > Add a comment to explain.
> >   
> 
> Hi Jonathan,
> 
> It is aimed to reuse the function both for BMP280 and BME280 so that's why is
> there, it's not in case humidity channel is disabled. I can add a comment it
> is definitely not obvious. Thanks for pointing this out.
> 
> By applying the changes that you pointed out + by implementing the changes
> that you proposed in a previous patch to split the t_fine calculation this
> patch will become much cleaner, thanks a lot!

A comment would do the job nicely. Thanks,

J

