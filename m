Return-Path: <linux-kernel+bounces-103432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5171B87BF41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116492839F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031B371723;
	Thu, 14 Mar 2024 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsvGsT7o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B52970CD7;
	Thu, 14 Mar 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427623; cv=none; b=Zy3ZdHhKGrFLYLmAjCMlgS7v3YRrdkiTsYFNj94y/74k8VPvZFEK3qoFsuQhvHJg3NGeQWuwyAn0VYqRqBRYkVaMAFAJKkeVTO5X73x+wmbclC0iuwefGmvzjvi9iOLc5Ygg462l9d7ejBQLMtSsFvD+IMv1+aUc7CONPXrpgE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427623; c=relaxed/simple;
	bh=KIWfn4W4v4tAUOArg/XuKX2M+N5FZo3xkEGC4dNchJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSj2ti9LcX2H0vtJtRx6Yx2LqObz2Y9I8shIsWDkbOVFLl3yloBJzhsmEXcHXBgDIt2t+lLLrZKr7AsDsplZDKPyKOA6En1fYm/1+vUjKAN8LaD34drNpLLCxlhTZncoZiuMjA5BtZ9tePQikurBNk34FsLwssw7ABHzzuLzops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsvGsT7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B62C433F1;
	Thu, 14 Mar 2024 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427622;
	bh=KIWfn4W4v4tAUOArg/XuKX2M+N5FZo3xkEGC4dNchJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gsvGsT7o9VYTDCWasKc/M/ZE4q/eBDo7/S3qVpyope98JbQluvGU0KEbEgigEwBwn
	 m3ijK66ktd9vUdly1Y+OUXOHGCb9ac+hGjQyYOFUjy7Hrgpygi7xpjPXSpCs/Yh3Xt
	 ugGrKOQEHliTRRpMXJFF6kQG4CVFb2y7ivc2WMZCwcZ3pmkKcolHcPjjQgE1bAV19G
	 4bwW9eFhY+Ld1fKYgZI9xtEudm8NB/jegZIxtc5C24gtDnZnbloyk7JhCnH8JJR8Px
	 eJBw1y0Qoc7eqaQgBch7cfcoE+ELmJQPXlBoiIOVEz7iycX3LwBkOzLWKAmZB38xlR
	 ahWtwLstddh4w==
Date: Thu, 14 Mar 2024 14:46:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: vamoirid <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lars@metafoo.de,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, linus.walleij@linaro.org,
 phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: pressure: add SCALE and RAW values for
 channels
Message-ID: <20240314144647.291a1100@jic23-huawei>
In-Reply-To: <ZfLYGL/vXMHUGghz@vamoirid-EDL-PC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
	<20240313174007.1934983-4-vassilisamir@gmail.com>
	<ZfH4bET-HX0e3PO_@smile.fi.intel.com>
	<20240313195110.GB1938985@vamoiridPC>
	<ZfIGtUPZpyDBnWwz@smile.fi.intel.com>
	<20240313212812.GE1938985@vamoiridPC>
	<ZfLYGL/vXMHUGghz@vamoirid-EDL-PC>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 11:57:28 +0100
vamoirid <vassilisamir@gmail.com> wrote:

> On Wed, Mar 13, 2024 at 10:28:12PM +0100, Vasileios Amoiridis wrote:
> > On Wed, Mar 13, 2024 at 10:04:05PM +0200, Andy Shevchenko wrote:  
> > > On Wed, Mar 13, 2024 at 08:51:10PM +0100, Vasileios Amoiridis wrote:  
> > > > On Wed, Mar 13, 2024 at 09:03:08PM +0200, Andy Shevchenko wrote:  
> > > > > On Wed, Mar 13, 2024 at 06:40:04PM +0100, Vasileios Amoiridis wrote:  
> > > > > > Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW in order to be
> > > > > > able to calculate the processed value with standard userspace IIO
> > > > > > tools. Can be used for triggered buffers as well.  
> > > 
> > > ...
> > >   
> > > > > > +	case IIO_CHAN_INFO_RAW:
> > > > > > +		switch (chan->type) {
> > > > > > +		case IIO_HUMIDITYRELATIVE:
> > > > > > +			*val = data->chip_info->read_humid(data);
> > > > > > +			ret = IIO_VAL_INT;
> > > > > > +			break;
> > > > > > +		case IIO_PRESSURE:
> > > > > > +			*val = data->chip_info->read_press(data);
> > > > > > +			ret = IIO_VAL_INT;
> > > > > > +			break;
> > > > > > +		case IIO_TEMP:
> > > > > > +			*val = data->chip_info->read_temp(data);
> > > > > > +			ret = IIO_VAL_INT;
> > > > > > +			break;
> > > > > > +		default:
> > > > > > +			ret = -EINVAL;
> > > > > > +			break;  
> > > > > 
> > > > > Is it mutex that prevents us from returning here?
> > > > > If so, perhaps switching to use cleanup.h first?  
> > > > 
> > > > I haven't seen cleanup.h used in any file and now that I searched,
> > > > only 5-6 are including it.  
> > > 
> > > Hmm... Which repository you are checking with?
> > > 
> > > $ git grep -lw cleanup.h -- drivers/ | wc -l
> > > 47
> > > 
> > > (Today's Linux Next)
> > >  
> > 
> > I am checking the drivers/iio of 6.8 (on sunday) and I can only find 7
> > drivers that use it.

Yes - but that's because it's new - most of the stuff in 6.8 was the proof
points for the patches originally introducing support for autocleanup (so typically
one or two cases for each type of handling) That doesn't mean we don't want it
in drivers that are being worked upon if it gives a significant advantage.
Some features we need will merge shortly, and a great deal more usage
of this autocleanup will occur.

> >   
> > > > I am currently thinking if the mutex
> > > > that already exists is really needed since most of the drivers
> > > > don't have it + I feel like this is something that should be done
> > > > by IIO, thus maybe it's not even needed here.  
> > >  
> 
> After some researching today, I realized that all the                           
> {read/write}_{raw/avail}_{multi/}() functions are in drivers/iio/inkern.c
> for channel mapping in the kernel and it looks like they are guarded by
> the mutex_{un}lock(&iio_dev_opaque->info_exist_lock).

Why is that relevant to this patch which isn't using that interface at all?
Those protections are to ensure that a consumer driver doesn't access a removed
IIO device, not accesses directly from userspace.

>so I feel that the
> mutexes in the aforementioned functions can be dropped. When you have the
> time please have a look, maybe the could be dropped.

Identify what your locks are protecting.  Those existence locks have
very specific purpose and should not be relied on for anything else.

If this driver is protecting state known only to itself, then it must
be responsible for appropriate locking.

> 
> In general, there is quite some cleaning that can be done in this driver
> but is it wise to include it in the triggered buffer support series??? 

Generally if working on a driver and you see cleanup that you think should
be done, it belongs before any series adding new features, precisely because
that code can typically end up simpler as a result.  This sounds like one
of those cases.  Normally that only includes things that are directly related
to resulting code for new features (or applying the same cleanup across a driver)
as we don't want to make people do a full scrub of a driver before adding
anything as it will just create too much noise.

So for this case, it does look like a quick use of guard(mutex) in
a precursor patch will simplify what you add here - hence that's a reasonable
request for Andy to make.

Jonathan


> I
> have noticed quite some things that could be improved but I am hesitating
> to do it now in order to not "pollute" this series with many cleanups and
> leave it for another cleanup series for example.
> 
> Best regards,
> Vasilis Amoiridis
> 
> > > > > > +		}
> > > > > > +		break;  
> > > 
> > > -- 
> > > With Best Regards,
> > > Andy Shevchenko
> > > 
> > >   


