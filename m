Return-Path: <linux-kernel+bounces-105191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E32F87DA55
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A541F212B3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F7518E1F;
	Sat, 16 Mar 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZEZECkZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA68E17722;
	Sat, 16 Mar 2024 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710597105; cv=none; b=U8GBR4HSOBS5XvJfGGHkXZjSNAIz2DyM4GTD0dDnZsXE496N3FwKGbixB8XsIBlN933U7DulrT7eCA3RFjeOwN3958cxMpnE+dJ/rcOWTwPLot59JCv70gZ9eLbgWhEDEY6rc5SDQHkRJiaT2zy9pu2yQvMWOuu9gKmmDTr0UJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710597105; c=relaxed/simple;
	bh=EiGD5J7ZKHTJsgR/kDe51wSpieV5dEnYLmedjLy2Ww8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5ynpKj9dQB8Nay4N4pHv8yBbpEv6gouiiGNqocbwcOk6ekGTdVVu6yfHslA0p1IOuqcsvnZFEB2pakxzSJiKe78H5vhDWII/7CuNLS78BJfud8ppf8dG411IIBrr1jP7z1exEH6rvcvP5wo9sieYv6zq13cySivbtjuEW6Fw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZEZECkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABC5C433F1;
	Sat, 16 Mar 2024 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710597105;
	bh=EiGD5J7ZKHTJsgR/kDe51wSpieV5dEnYLmedjLy2Ww8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sZEZECkZ9bFYSMSLxxYxNwTiA644I/p5IcLLli8zLE/lErF231LAyz2lDWMclag8C
	 jY7oOls0EdlikDk/IIr+Y8yPEiYu6aNqWEvk/ap4nuv8dzmuAAsbFvCTDBLUaSLFfP
	 GyYmo02nZLF4xpZISi+xczz4DYScPl4wJImGb7E+36YIx0U1SklxwU1BDLw9GfOnqT
	 Ugbkp64g02epIJH5rav/VdGpNjcyQyQYNMlbxeJjd4iexpQnGMjT5bGoLZ11b7ms9h
	 lIhnWxcHOt3Ujjt1jSZa5NUnLFP9M0Wvgth0NZ2UfGfUjcnxIzvA5/pb0CjGLycchh
	 F9rPfp/NJIVqA==
Date: Sat, 16 Mar 2024 13:51:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lars@metafoo.de,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, linus.walleij@linaro.org,
 phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: pressure: add SCALE and RAW values for
 channels
Message-ID: <20240316135128.28f01ed6@jic23-huawei>
In-Reply-To: <ZfRI6oAxr6SXPLcf@vamoirid-EDL-PC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
	<20240313174007.1934983-4-vassilisamir@gmail.com>
	<ZfH4bET-HX0e3PO_@smile.fi.intel.com>
	<20240313195110.GB1938985@vamoiridPC>
	<ZfIGtUPZpyDBnWwz@smile.fi.intel.com>
	<20240313212812.GE1938985@vamoiridPC>
	<ZfLYGL/vXMHUGghz@vamoirid-EDL-PC>
	<20240314144647.291a1100@jic23-huawei>
	<ZfRI6oAxr6SXPLcf@vamoirid-EDL-PC>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Mar 2024 14:11:06 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Thu, Mar 14, 2024 at 02:46:47PM +0000, Jonathan Cameron wrote:
> > On Thu, 14 Mar 2024 11:57:28 +0100
> > vamoirid <vassilisamir@gmail.com> wrote:
> >   
> > > On Wed, Mar 13, 2024 at 10:28:12PM +0100, Vasileios Amoiridis wrote:  
> > > > On Wed, Mar 13, 2024 at 10:04:05PM +0200, Andy Shevchenko wrote:    
> > > > > On Wed, Mar 13, 2024 at 08:51:10PM +0100, Vasileios Amoiridis wrote:    
> > > > > > On Wed, Mar 13, 2024 at 09:03:08PM +0200, Andy Shevchenko wrote:    
> > > > > > > On Wed, Mar 13, 2024 at 06:40:04PM +0100, Vasileios Amoiridis wrote:    
> > > > > > > > Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW in order to be
> > > > > > > > able to calculate the processed value with standard userspace IIO
> > > > > > > > tools. Can be used for triggered buffers as well.    
> > > > > 
> > > > > ...
> > > > >     
> > > > > > > > +	case IIO_CHAN_INFO_RAW:
> > > > > > > > +		switch (chan->type) {
> > > > > > > > +		case IIO_HUMIDITYRELATIVE:
> > > > > > > > +			*val = data->chip_info->read_humid(data);
> > > > > > > > +			ret = IIO_VAL_INT;
> > > > > > > > +			break;
> > > > > > > > +		case IIO_PRESSURE:
> > > > > > > > +			*val = data->chip_info->read_press(data);
> > > > > > > > +			ret = IIO_VAL_INT;
> > > > > > > > +			break;
> > > > > > > > +		case IIO_TEMP:
> > > > > > > > +			*val = data->chip_info->read_temp(data);
> > > > > > > > +			ret = IIO_VAL_INT;
> > > > > > > > +			break;
> > > > > > > > +		default:
> > > > > > > > +			ret = -EINVAL;
> > > > > > > > +			break;    
> > > > > > > 
> > > > > > > Is it mutex that prevents us from returning here?
> > > > > > > If so, perhaps switching to use cleanup.h first?    
> > > > > > 
> > > > > > I haven't seen cleanup.h used in any file and now that I searched,
> > > > > > only 5-6 are including it.    
> > > > > 
> > > > > Hmm... Which repository you are checking with?
> > > > > 
> > > > > $ git grep -lw cleanup.h -- drivers/ | wc -l
> > > > > 47
> > > > > 
> > > > > (Today's Linux Next)
> > > > >    
> > > > 
> > > > I am checking the drivers/iio of 6.8 (on sunday) and I can only find 7
> > > > drivers that use it.  
> > 
> > Yes - but that's because it's new - most of the stuff in 6.8 was the proof
> > points for the patches originally introducing support for autocleanup (so typically
> > one or two cases for each type of handling) That doesn't mean we don't want it
> > in drivers that are being worked upon if it gives a significant advantage.
> > Some features we need will merge shortly, and a great deal more usage
> > of this autocleanup will occur.
> >   
> > > >     
> > > > > > I am currently thinking if the mutex
> > > > > > that already exists is really needed since most of the drivers
> > > > > > don't have it + I feel like this is something that should be done
> > > > > > by IIO, thus maybe it's not even needed here.    
> > > > >    
> > > 
> > > After some researching today, I realized that all the                           
> > > {read/write}_{raw/avail}_{multi/}() functions are in drivers/iio/inkern.c
> > > for channel mapping in the kernel and it looks like they are guarded by
> > > the mutex_{un}lock(&iio_dev_opaque->info_exist_lock).  
> > 
> > Why is that relevant to this patch which isn't using that interface at all?
> > Those protections are to ensure that a consumer driver doesn't access a removed
> > IIO device, not accesses directly from userspace.
> >   
> > >so I feel that the
> > > mutexes in the aforementioned functions can be dropped. When you have the
> > > time please have a look, maybe the could be dropped.  
> > 
> > Identify what your locks are protecting.  Those existence locks have
> > very specific purpose and should not be relied on for anything else.
> > 
> > If this driver is protecting state known only to itself, then it must
> > be responsible for appropriate locking.
> >   
> > > 
> > > In general, there is quite some cleaning that can be done in this driver
> > > but is it wise to include it in the triggered buffer support series???   
> > 
> > Generally if working on a driver and you see cleanup that you think should
> > be done, it belongs before any series adding new features, precisely because
> > that code can typically end up simpler as a result.  This sounds like one
> > of those cases.  Normally that only includes things that are directly related
> > to resulting code for new features (or applying the same cleanup across a driver)
> > as we don't want to make people do a full scrub of a driver before adding
> > anything as it will just create too much noise.
> > 
> > So for this case, it does look like a quick use of guard(mutex) in
> > a precursor patch will simplify what you add here - hence that's a reasonable
> > request for Andy to make.
> > 
> > Jonathan
> >   
> 
> After looking into how to change the code to introduce the new guard(mutex)
> I encountered the following situation

No problem. We are all getting used to how to use this stuff. There
have been a few 'comments' from Linus Torvalds on people doing it wrong.
One of those (it was about cond_guard() proposal if you want to find it)
is applicable here (note that Linus was rather abrupt in that thread and
got called out for it, not in my view a good example of kernel process).

Make more use of helper functions to avoid gotos.

>
> In general, with the new guard(mutex) functinality you can remove most of the
> goto statements and return immediately without doing the cleanup yourself. 
> In the case of this driver, in the read_raw() call, apart from the mutex, 
> the power management functions are also used. This means that in each case, 
> before returning, the pm functions will need to be called, which I don't
> know if it will actually make the code cleaner. Have a look below with
> an example.
> 
> ----- Current Implementation -----
> 
> static int bmp280_read_raw( ... )
> {
> 	...
> 
> 	pm_runtime_get_sync_data(data->dev);

Pull from here...
> 	mutex_lock(&data->lock);
> 
> 	switch (mask) {
> 	case 1:
> 		switch (channel) {
> 		case TEMP:
> 			ret = read_temp();
> 			break;
> 		case PRESS:
> 			ret = read_press();
> 			break;
> 		...
> 	case 2:
> 		switch (channel) {
> 		...
> 
> 	case 3:
> 		...
> 	default:
> 		ret = -EINVAL;
> 		break;
> 	}
> 
> 	mutex_unlock(&data->lock);

.. to here out as a separate little function - somethimg like
bmp280_read_raw_impl() which can use guard() and direct returns
internally.

Then this block will be

	pm_runtime_get_sync_data(data->dev);
	ret = bmp280_read_raw_impl(...);
	pm_runtime_mark_last_busy(data->dev);
	pm_runtime_put_autosuspend(data->dev);

	return ret;

> 	pm_runtime_mark_last_busy(data->dev);
> 	pm_runtime_put_autosuspend(data->dev);
> 
> 	return ret;
> }
> 
> ----- End of Current Implementation -----
> 
> With the use of the guard(mutex)(&data->lock) you could immediately
> return without all the break statements. But we still need to call
> the pm functions. So the code, as far as I can understand will look
> like this:
> 
> ----- Guard Mutex Implementation -----
> 
> static int bmp280_read_raw( ... )
> {
> 	...
> 
> 	pm_runtime_get_sync_data(data->dev);
> 	guard(mutex)(&data->lock);
> 
> 	switch (mask) {
> 	case 1:
> 		switch (channel {
> 		case TEMP:
> 			ret = read_temp();

This inverts ordering of pm and the guard mutex, so not a good idea.

> 			pm_runtime_mark_last_busy(data->dev);
> 			pm_runtime_put_autosuspend(data->dev);
> 			return ret;
> 		case PRESS:
> 			ret = read_press();
> 			pm_runtime_mark_last_busy(data->dev);
> 			pm_runtime_put_autosuspend(data->dev);
> 			return ret;
> 		...
> 	case 2:
> 		switch (channel) {
> 		...
> 	case 3:
> 		...
> 	default:
> 		return -EINVAL;
> 	}
> 
> 	return 0;
> }
> 
> ----- End of Guard Mutex Implementation -----
> 
> Have I completely misunderstood something? If what I explain
> above is correct, you think that this is a better implementation
> and I should move forward becasue we want to use the guard(mutex)
> functionality? 
> 
> Maybe it is necessary to create some new type of guard to call
> also the pm functions before exiting?

Don't try that approach - it's complexity that will get a response
you don't want from Linus.  Helper functions solve this one
for us nicely.

At somepoint maybe generic infrastructure for runtime pm handling
will be added, but that stuff is complex enough already so I suspect
not or not until people are in general much more confident with the
cleanup.h infrastructure and where it is appropriate.

What you are doing here should all be standard usage at the simpler
end of the scale, so not a risky as a few things I'm trying to get in :)

Jonathan

> 
> Cheers,
> Vasilis
> 
> >   
> > > I
> > > have noticed quite some things that could be improved but I am hesitating
> > > to do it now in order to not "pollute" this series with many cleanups and
> > > leave it for another cleanup series for example.
> > > 
> > > Best regards,
> > > Vasilis Amoiridis
> > >   
> > > > > > > > +		}
> > > > > > > > +		break;    
> > > > > 
> > > > > -- 
> > > > > With Best Regards,
> > > > > Andy Shevchenko
> > > > > 
> > > > >     
> >   
> 


