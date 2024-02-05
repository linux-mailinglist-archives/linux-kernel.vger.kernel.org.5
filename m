Return-Path: <linux-kernel+bounces-52603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8D8849A51
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B3AB268AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9241C290;
	Mon,  5 Feb 2024 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqT8Xep8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF31C286;
	Mon,  5 Feb 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136320; cv=none; b=g1Ymuv4GxzwmojoNsYMX8GxuwRge3MBBeqvYsTSqS4Slke6LvJJxLtDVpWWTxcKJoBZSzhc9JxvUXXGU3Mw4HJhPN7+xlsPS3BciQh6lUBtdzUZHHML72uF7ZyMUuiFzC6ZTzdLiy/AMBEsucOEpZQwqObuB4G1hXYQ8r00mVag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136320; c=relaxed/simple;
	bh=2crsEkek5NKe6zZQsqKsTQtcHeyKPBSX29yxcRRHVMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPwNX30FauM8wSClRsRhwSkXV+dhK/dNx0I5gJS/sD83306nIU7Xko3GdnO73Dw8osObA0dDA519CmMQpSZLciQ16GUbd8yQHU9CyiEIh+Xx3zYIly1ElYaIADSmt93urjoXfIH+uSnak6D3Jmk7ZiDErfObNxp/49kQYkgM1A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqT8Xep8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707136318; x=1738672318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2crsEkek5NKe6zZQsqKsTQtcHeyKPBSX29yxcRRHVMw=;
  b=CqT8Xep89N15anMZJDRkRK07Up8zn7UfHb3pbkwic7RyJOcuW4lCm11a
   zrhtg90FAIcB4DW07b3wa6/zZpcaVeb7pD8UV1s5STtJo9n3zQXZQflLY
   4ObOXVIVUNQAHo2d4IrJYXRhlHzsPCffw9I9Y4Ev5v4MlK7yd1djNPCpJ
   zr+7EEvqU6+l2KGe4/VXNMJooHdK5vDB/Kn7Es5Ujjh6hfSBl24RCpchJ
   VIQxTgplPhGswW//8hsh4PQ63aOWCJ6QdjcpGpbN8LLCbKWcULOBc9Yjy
   Bbcj3OLZSk4xZ1+Kmzu+30hYWbI1GuhYIJeHA41OvOtVI8H9Go3O1/IC1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11882533"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11882533"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:31:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="823851387"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="823851387"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:31:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rWy8b-0000000244m-0Apm;
	Mon, 05 Feb 2024 14:31:49 +0200
Date: Mon, 5 Feb 2024 14:31:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 21/23] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
Message-ID: <ZcDVNA6Id7Bmckt0@smile.fi.intel.com>
References: <20240205093418.39755-1-brgl@bgdev.pl>
 <20240205093418.39755-22-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205093418.39755-22-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 10:34:16AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Ensure we cannot crash if the GPIO device gets unregistered (and the
> chip pointer set to NULL) during any of the API calls.
> 
> To that end: wait for all users of gdev->chip to exit their read-only
> SRCU critical sections in gpiochip_remove().

> For brevity: add a guard class which can be instantiated at the top of
> every function requiring read-only access to the chip pointer and use it
> in all API calls taking a GPIO descriptor as argument. In places where
> we only deal with the GPIO device - use regular guard() helpers and
> rcu_dereference() for chip access. Do the same in API calls taking a
> const pointer to gpio_desc.

..

>  static ssize_t base_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> -	const struct gpio_device *gdev = dev_get_drvdata(dev);
> +	struct gpio_device *gdev = dev_get_drvdata(dev);
> +	struct gpio_chip *gc;
>  
> -	return sysfs_emit(buf, "%d\n", gdev->chip->base);
> +	guard(srcu)(&gdev->srcu);
> +
> +	gc = rcu_dereference(gdev->chip);
> +	if (!gc)
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "%d\n", gc->base);

Similar Q as below.

>  }

..

>  static ssize_t label_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> -	const struct gpio_device *gdev = dev_get_drvdata(dev);
> +	struct gpio_device *gdev = dev_get_drvdata(dev);
> +	struct gpio_chip *gc;
>  
> -	return sysfs_emit(buf, "%s\n", gdev->chip->label ?: "");
> +	guard(srcu)(&gdev->srcu);
> +
> +	gc = rcu_dereference(gdev->chip);
> +	if (!gc)
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "%s\n", gc->label ?: "");

Why do you need gc label here and not gdev? In other code you switched over (in
a patch before this in the series).

>  }

>  static ssize_t ngpio_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> -	const struct gpio_device *gdev = dev_get_drvdata(dev);
> +	struct gpio_device *gdev = dev_get_drvdata(dev);
> +	struct gpio_chip *gc;
>  
> -	return sysfs_emit(buf, "%u\n", gdev->chip->ngpio);
> +	guard(srcu)(&gdev->srcu);
> +
> +	gc = rcu_dereference(gdev->chip);
> +	if (!gc)
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "%u\n", gc->ngpio);

Ditto.

>  }

..

>  int gpiod_get_direction(struct gpio_desc *desc)
>  {
> -	struct gpio_chip *gc;
>  	unsigned long flags;
>  	unsigned int offset;
>  	int ret;
>  
> -	gc = gpiod_to_chip(desc);
> +	if (!desc)
> +		/* Sane default is INPUT. */
> +		return 1;

Hmm... I can't imagine how this value may anyhow be used / useful.

> +	if (IS_ERR(desc))
> +		return -EINVAL;

With above said, can't we use one of VALIDATE_DESC*() macro here?

..

>  	list_for_each_entry_srcu(gdev, &gpio_devices, list,
>  				 srcu_read_lock_held(&gpio_devices_srcu)) {

> +	list_for_each_entry_srcu(gdev, &gpio_devices, list,
> +				 srcu_read_lock_held(&gpio_devices_srcu)) {

Seems like a candidate for

#define gpio_for_each_device(...) ...

..

>  	VALIDATE_DESC(desc);
>  
> -	gc = desc->gdev->chip;
> -	if (!gc->en_hw_timestamp) {
> +	CLASS(gpio_chip_guard, guard)(desc);
> +	if (!guard.gc)
> +		return -ENODEV;


Not sure if it would be good to have a respective VALIDATE_DESC_GUARDED()
or so. At least it may deduplicate a few cases.

..

> +	/* FIXME Cannot use gpio_chip_guard due to const desc. */

gpio_chip_guard()

-- 
With Best Regards,
Andy Shevchenko



