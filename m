Return-Path: <linux-kernel+bounces-161522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3AB8B4D24
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7AF1F21309
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E08773199;
	Sun, 28 Apr 2024 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiRJdwxz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD87317F;
	Sun, 28 Apr 2024 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714324924; cv=none; b=iRZAiCpxwDf92JncjDezQRp7Vxf+VMGSMtzt9wV2HGPAYHA8IXK9J+FM56KKBGLRWGhnmTdbLqZxkfeO5UCyW6QBvFTAOTo6505D8KOLgApoyz92DJEekdpXXUOvE4QX1nd/9LfNXOy2FLopBeErsfMg5Lks4secPTRgv9L2e3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714324924; c=relaxed/simple;
	bh=+bsskYGfCWvxKP1+KcEgdEE4RVFr4Cuo7dOCEdkYM7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLE93N0305+91HeOYfeVtVb2rPKouLMywj6iVpLnwuZgyNp9qbtAGM2TcumRQlwwhfFXG/Q91h9bEXFz090C3ZQFnbDZoS8AyeRYE4qD5q3RTI2BLdOG0eeW82uZT1yBTZAAQ2Xhytz0eTktUX/0oQOAprY75ajZncgLu8PQXkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiRJdwxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D150C113CC;
	Sun, 28 Apr 2024 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714324924;
	bh=+bsskYGfCWvxKP1+KcEgdEE4RVFr4Cuo7dOCEdkYM7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KiRJdwxzQUUOaa1kmGXyfynLm45NLbxnR+bYVhI2GFCNNb16FaO2WWkFKvUKI+eMn
	 uubZVFnwnAlaPE575s8aS91WgJCh1uVg2qB/fKz/Xb2pBDZghvqm4LEFHrbSZ5pJhK
	 xZzWHXL5vSifuHiotbBfQy7xTnpY9K5sXpc/d7Pfx6tMdPj36uhpbaqrN0xy2zGMRH
	 je7PSZl7Nbr3kx3xMp3t7XjZy4Hq3giKBTcXLZC4ODY/tfj0imEXnhyunfBHzrukXl
	 BnL9n3U9M7NO2BcBXTmkR2C8GVxsaLnSUamwgOxsMq7XgwYhAMqBsYGAUNLsCFPEhm
	 h65jTCRyIclAg==
Date: Sun, 28 Apr 2024 18:21:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Geurts <paul_geurts@live.nl>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "Michael.Hennerich@analog.com"
 <Michael.Hennerich@analog.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: adxl345: Added buffered read support
Message-ID: <20240428182152.7349129c@jic23-huawei>
In-Reply-To: <a1d0f85d-2ea7-4966-b842-c6e0028b61b2@live.nl>
References: <AM0PR09MB26757E9F7575A2357E318C50950F2@AM0PR09MB2675.eurprd09.prod.outlook.com>
	<20240420135438.03f17072@jic23-huawei>
	<a1d0f85d-2ea7-4966-b842-c6e0028b61b2@live.nl>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 15:17:47 +0000
Paul Geurts <paul_geurts@live.nl> wrote:

> On 20-04-2024 14:54, Jonathan Cameron wrote:
> > On Wed, 17 Apr 2024 10:28:34 +0200
> > Paul Geurts <paul_geurts@live.nl> wrote:
> >
> > Hi Paul, various comments inline.
> >
> >  
> >> This implements buffered reads for the accelerometer data. A buffered
> >> IIO device is created containing 3 channels. The device FIFO is used for
> >> sample buffering to reduce the IRQ load on the host system.
> >>
> >> Reading of the device is triggered by a FIFO waterlevel interrupt. The
> >> waterlevel settings are dependent on the sampling frequency to leverage
> >> IRQ load against responsiveness.  
> > I'm unconvinced that trade off belongs in the driver. Until now we
> > have exposed all the relevant controls to userspace via bufferX/watermark.
> > Set that to 0 or 1 if you don't want a fifo and appropriate level for whatever
> > responsiveness is needed for a particular application.
> >
> > The need to manually disable / enable interrupts is also normally something
> > that needs a close look. Very very occasionally this is necessary but for most
> > devices IRQF_ONESHOT should provide suitable masking.
> >
> > It's also not clear that a trigger is appropriate here. For FIFO equipped devices
> > like this, the trigger abstraction often doesn't work as we don't have one interrupt
> > per 'scan' of data.  In these cases it is not necessary to use a trigger at all
> > and that can simplify things considerably.
> >
> > Jonathan  
> 
> This was my first interaction with the IIO subsystem, So these changes were somewhat of a
> learning experience. Your review comments indicate major refactoring of my patch is in
> order. I will see when I have time to get to it and resend it at some point.

Great that I didn't put you off too much and I should have said welcome!
As someone who has a v9 patch set to send out tomorrow (for another area of the kernel),
I'm well aware there can be quite a learning curve.


A few follow up comments below, but mostly guessing what might have made
things trickier rather than anything useful.

Jonathan


> >  
> >> +	if (ret < 0)
> >> +		goto out;  
> > return ret;  
> >> +	while (regval & ADXL345_INT_DATA_READY) {
> >> +		ret = regmap_bulk_read(map, ADXL345_REG_DATA_AXIS(0), &axis_data,
> >> +				       sizeof(axis_data));
> >> +		if (ret < 0)
> >> +			goto out;  
> > The datasheet puts a timing requirement on repeat reads that you need to enforce..
> > 5 usec.
> >
> > return ret;  
> 
> I didn't find this requirement in the datasheet. I did however write this for ADXL343, which seems
> to be compatible with ADXL345. But maybe I missed something here?

It's a slow bus, maybe the delay is above that anyway.

> 
> >> +		ret = regmap_read(map, ADXL345_REG_INT_SOURCE, &regval);
> >> +		if (ret < 0)
> >> +			goto out;  
> > return directly - going to a label that does nothing makes a reviewer
> > following code paths have to go see that nothing happens.
> >
> > 			return ret;
> >  
> >> +	}
> >> +
> >> +out:
> >> +	return ret;
> >> +}
> >> +
> >> +static int adxl345_buffer_preenable(struct iio_dev *indio_dev)
> >> +{
> >> +	struct adxl345_data *data = iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	mutex_lock(&data->lock);
> >> +	/* Disable measurement mode to setup everything */
> >> +	ret = regmap_clear_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
> >> +	if (ret < 0)
> >> +		goto out;
> >> +
> >> +	ret = adxl345_flush_fifo(data->regmap);
> >> +	if (ret < 0)
> >> +		goto out_enable;
> >> +
> >> +	/*
> >> +	 * Set the FIFO up in streaming mode so the chip keeps sampling.
> >> +	 * Waterlevel is set by the sample frequency functions as it is dynamic  
> > This I don't follow.  Why is it dynamic?  It's fixed for a given run at a given
> > frequency. I can sort of see a true dynamic adjustment might make sense, but that
> > would be complex and isn't obviously a problem for the kernel.
> >
> > I'd prefer to see this done like the majority of other fifo handling drivers:
> > Make setting the watermark vs frequency a userspace problem.  
> 
> So having an interrupt coming in for every sample on 3200Hz sampling rate completely overloaded my
> i.MX8M Mini CPU (1600MHz) I was testing this on. This was the main reason to be using the internal
> FIFO in the accelerometer. But when doing that, the device becomes somewhat unresponsive on the
> lower frequencies, as it first needs to fill the FIFO before actually firing an interrupt towards
> the CPU. Therefore I created this, which only uses the water level interrupt on highter frequencies
> to try to have best of both worlds. But I agree that this should be a userspace choice.

It's a neat bit of code and maybe one day worth considering if we should try to auto
tune, but definitely not something to do in a driver alongside the initial
enablement.

> 
> >  
> >> +	 */
> >> +	ret = regmap_update_bits(data->regmap, ADXL345_REG_FIFO_CTL,
> >> +				 (int)~(ADXL345_FIFO_CTL_SAMPLES_MASK),
> >> +				 ADXL345_FIFO_CTL_MODE_STREAM);
> >> +	if (ret < 0)
> >> +		goto out_enable;
> >> +
> >> +	/* Enable the Watermark and Overrun interrupt */
> >> +	ret = regmap_write(data->regmap, ADXL345_REG_INT_ENABLE, (ADXL345_INT_WATERMARK |
> >> +			   ADXL345_INT_OVERRUN));
> >> +	if (ret < 0)
> >> +		goto out_enable;
> >> +
> >> +	/* Re-enable measurement mode */
> >> +	ret = regmap_set_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
> >> +	goto out;  
> > Don't do this as it makes for messy control flow to review
> >
> > 	if (ret)
> > 		goto out_enabled;
> >
> > 	mutex_unlock(&data->lock)
> > 	return 0;
> >
> > out_enable:
> > ...
> > Can use guard(mutex)(&data->lock) to avoid need to unlock manually and allow at least
> > some paths to return directly.  
> 
> I am very pleased to find out scoped locking is finally possible in the Linux kernel :-). I didn't know this.
> 

Pretty new + the more complex corners of what can be done are still
controversial.  Thankfully mutexes are a simple case.

> >> +	int ret, data_available;
> >> +
> >> +	mutex_lock(&data->lock);
> >> +
> >> +	/* Disable the IRQ before reading the FIFO */  
> > This needs a lot more explanation.  Disabling interrupts like
> > this can be very expensive and can be hard to reason about
> > + it's not necessary most of the time because of IRQF_ONESHOT.  
> 
> I did experience some issues with the interrupts, hence the disabling. But I might have just
> implemented it badly. I will take a look into why things go bad and try to make it so that
> disabling IRQs is not needed anymore.
> 

Often it's a type issue for interrupts - particularly level vs edge.
Thankfully it's fairly rare to get interrupt controllers that only
do one or the other these days - that used to be really painful to
try and handle in a driver.

> >> +
> >> +	mutex_init(&data->lock);
> >> +
> >>  	indio_dev->name = data->info->name;
> >>  	indio_dev->info = &adxl345_info;
> >> -	indio_dev->modes = INDIO_DIRECT_MODE;
> >> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;  
> > No need as INDIO_BUFFER_TRIGGERED is set when you register the buffer.  
> 
> Didn't know that!
> 

It's relatively recent (few years ago) so if you are on an older tree
it might not have been true.

Jonathan


