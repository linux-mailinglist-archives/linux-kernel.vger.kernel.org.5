Return-Path: <linux-kernel+bounces-56669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A284E84CD5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58AC1C25747
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E387F80055;
	Wed,  7 Feb 2024 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGkD3MzW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782BF81AA0;
	Wed,  7 Feb 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317617; cv=none; b=n4unTbD4FBoFueLxXxc41M86VXrrD9BfxfE2k5UJX8ao4eSZ/5ClmbZ58vfCPxZFFt74Gq2fYyXpB9d7w/NK4Iv74WX/q9eS7pGpVuN2win22170eWyc89Ok2/C1Yk5Jeoerj142LnRCJL/3m5pm3435MMqs4ngFESEZkHphNSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317617; c=relaxed/simple;
	bh=5FT+mEDT+UV9P5Ky0v+/HcqKWwUwpUswuOOSWRvdDZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqwI9dCJvKw4dGeScxX4167n+MwPXwHgVJjLxU26s0TLD0YsDN4JumyCHCRpe8aUKxxKvI0AhTUdQvhI7POsQIZiy0S5Flhhgcx4TZymjWcknBRMs7zPyh9RKLZkLnnlUyqoaZKpEkkHtNh/95F/3o8vuFSJBtl91EuGI+cqcxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGkD3MzW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707317615; x=1738853615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5FT+mEDT+UV9P5Ky0v+/HcqKWwUwpUswuOOSWRvdDZk=;
  b=kGkD3MzWua9BIZ30+h5k6H16IB6WbJr+BjlpBPnLPOhxW+2VeMl4//3j
   p4WoFsFYmXHz3I4rqVxU8lwHc6nTJ/OascmgUMcSAna6IiEU+xw8OHaN+
   siJvLoFisQq8IPeyJ3DYdP3z3j7mLAoOA1Dp3CZ3Hmhi9k8Ukco64FduV
   XFz2WpeiAq1p+50m3F1yBSfN8GHp5/CkGearG8fES48AdEFCOUd2B0voJ
   +gRWYhFiYAc3Ufy1ThJtmrVu7jGQTPD5PCxyJkzarONFzs6pqZtZ4IXNR
   hoiWb4fk+Sns4ugfCwV6mlHe7EsPjoeJvOBV51GV+YiXnl7snlT0Ep3JD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="4867466"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="4867466"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 06:53:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="910011504"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="910011504"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 06:53:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXjIe-00000002dKF-0ptp;
	Wed, 07 Feb 2024 16:53:20 +0200
Date: Wed, 7 Feb 2024 16:53:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <ZcOZX8mWTozC2EAc@smile.fi.intel.com>
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
 <20240206130017.7839-6-subhajit.ghosh@tweaklogic.com>
 <ZcI3Pz6Z5V4qqpHO@smile.fi.intel.com>
 <43e01493-1f26-414b-b2eb-7fb959b9b542@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e01493-1f26-414b-b2eb-7fb959b9b542@tweaklogic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 07, 2024 at 09:37:37PM +1030, Subhajit Ghosh wrote:

..

> > > +static_assert(ARRAY_SIZE(apds9306_repeat_rate_freq) ==
> > > +		APDS9306_NUM_REPEAT_RATES);
> > 
> > Just make that define to be inside [] in the respective array and drop this
> > static assert. The assertion might make sense to have different arrays to be
> > synchronized and when their maximums are different due to semantics (not your
> > case AFAICS).

..

> > > +static_assert(ARRAY_SIZE(apds9306_repeat_rate_period) ==
> > > +		APDS9306_NUM_REPEAT_RATES);
> > 
> > Ditto.

> I apologize for this. You pointed me out in an earlier review, I misunderstood
> it and used the macro in two static asserts! It will be fixed.

It might be used, but not must be, use your common sense!
In this case it's easier to have all defined properly from the beginning.

..

> > > +static int apds9306_runtime_power_on(struct device *dev)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = pm_runtime_resume_and_get(dev);
> > > +	if (ret < 0)
> > > +		dev_err_ratelimited(dev, "runtime resume failed: %d\n", ret);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int apds9306_runtime_power_off(struct device *dev)
> > > +{
> > > +	pm_runtime_mark_last_busy(dev);
> > > +	pm_runtime_put_autosuspend(dev);
> > > +
> > > +	return 0;
> > > +}
> > 
> > Seems to me like useless wrappers. Why do you need that message?
> No specific need for that message, however the wrapper was suggested in a previous review:
> https://lore.kernel.org/all/ZTuuUl0PBklbVjb9@smile.fi.intel.com/

I see, what I meant in previous review is to split to separate helpers.
Now, when we see how it looks like and how many actual users, we may
go further and drop them.

> Do you still want me to use the pm functions directly from the calling functions?

It seems a good move forward.

> > Btw, it's used only twice, open coding saves the LoCs!
> Yes, it makes sense.

-- 
With Best Regards,
Andy Shevchenko



