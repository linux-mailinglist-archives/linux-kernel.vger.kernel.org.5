Return-Path: <linux-kernel+bounces-52764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9F2849C70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFAB1F212DD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612A622F0E;
	Mon,  5 Feb 2024 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qn7t9+5s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2953228E02;
	Mon,  5 Feb 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141547; cv=none; b=drAhZKNP/vdFyy+o/LozT80Rsrk7yyjfrn56d3nI37oJ9gatk49E5GxK7l0XXAlFcdwMuaTr/B4paGTEeYmaGcAy++yUBxTjRA3F29bGyIy83R7fRBlHM/d0FbxdSzOvHaf553zyCqqAlURea5t9NOJyOSmBw7rvoPpcmd0TaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141547; c=relaxed/simple;
	bh=llpern0uzcyBnrR5NzXwJ1ZpD/vnGIM8UsrKVex+JBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsjpR/qm63MiZ55HA8r3iy1ML1RgeNfbvb0pjN5GoH7liizau6/uc0050WGwCSqJ2t53rmgdWZqv0b+bIkgVLt7nCfL6vhzWiclVfV58+IxL0Ko7CzGwOvQlJMBxbeaVyaOwtN3p+1HOhn+KmS8m7J5eEY1ABW6H1rm2SZDDA84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qn7t9+5s; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707141546; x=1738677546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=llpern0uzcyBnrR5NzXwJ1ZpD/vnGIM8UsrKVex+JBs=;
  b=Qn7t9+5sPnHDRMjLwR7XZaHtrr9KyHekbnXmKAuvo8QylqQZ98xcv1kc
   aDbYqaHSLxWhHdKnGGTX7ot44JZk/bz43FNBd4LcQcDm9dKbgUadHLxnP
   6l6ShFDWuFbCbkdMg43WVLoTcL2ms8zXewXzlaY1A76I50iiU7rT8GQte
   lGNKdZXNLl+exn9EqKqw7iDzGRH7brH/tB6SyRxg7lOKZrytuWw6d5ylA
   rK5uf551Ha2wm1LiORdybOk1nN3etqj3gtHO3ofJyTjeekfuIkMA64Kfw
   L4inv12d4BSqNsm+aGJvGrxKp1hpZ+ZaDvdgQsfpNb4A5Zsf41n9x778i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="432413"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="432413"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:59:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909301590"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909301590"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:59:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rWzUy-000000025zL-0Les;
	Mon, 05 Feb 2024 15:59:00 +0200
Date: Mon, 5 Feb 2024 15:58:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 08/23] gpio: sysfs: use gpio_device_find() to iterate
 over existing devices
Message-ID: <ZcDpo__BIF2Bf8CC@smile.fi.intel.com>
References: <20240205093418.39755-1-brgl@bgdev.pl>
 <20240205093418.39755-9-brgl@bgdev.pl>
 <ZcDSKYqFHSUZb2Qx@smile.fi.intel.com>
 <CAMRc=Mfh5CcftXUStGOXvUF-s3aNxnaNM0sDt72LKrBfttqitQ@mail.gmail.com>
 <ZcDkvOrlSRkmYIk_@smile.fi.intel.com>
 <CAMRc=MeiXLZ4q8MH5h_wX1rBz9-YVK6UKUdCu2nTb6+uNHGXPQ@mail.gmail.com>
 <ZcDm3ZrW1dQQAroY@smile.fi.intel.com>
 <CAMRc=Me+ETGfgjgQV+SSZenLW5MeNLVSrFKBhs707FDEqEHFJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me+ETGfgjgQV+SSZenLW5MeNLVSrFKBhs707FDEqEHFJw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 02:50:18PM +0100, Bartosz Golaszewski wrote:
> On Mon, Feb 5, 2024 at 2:47 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 05, 2024 at 02:39:40PM +0100, Bartosz Golaszewski wrote:
> > > On Mon, Feb 5, 2024 at 2:38 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Feb 05, 2024 at 02:19:10PM +0100, Bartosz Golaszewski wrote:
> > > > > On Mon, Feb 5, 2024 at 1:36 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Mon, Feb 05, 2024 at 10:34:03AM +0100, Bartosz Golaszewski wrote:

..

> > > > > > > +static int gpiofind_sysfs_register(struct gpio_chip *gc, void *data)
> > > > > > > +{
> > > > > > > +     struct gpio_device *gdev = gc->gpiodev;
> > > > > > > +     int ret;
> > > > > > > +
> > > > > > > +     if (gdev->mockdev)
> > > > > > > +             return 0;
> > > > > > > +
> > > > > > > +     ret = gpiochip_sysfs_register(gdev);
> > > > > > > +     if (ret)
> > > > > > > +             chip_err(gc, "failed to register the sysfs entry: %d\n", ret);
> > > > > >
> > > > > > > +     return 0;
> > > > > >
> > > > > > ???
> > > >
> > > > What the point of function to be int if you effectively ignore this by always
> > > > returning 0?
> > >
> > > Because the signature of the callback expects an int to be returned?
> >
> > But why do you return 0 instead of ret?
> >
> 
> Because we don't want to *find* a device really. We just want to
> iterate over all of them and call a callback. Any value other than 0
> will be interpreted as a match. Besides: failure to register one GPIO
> sysfs entry shouldn't maybe cause a failure for all subsequent
> devices?

To me it's not obvious, hence I would like to see a comment before return 0.

> > > > > Not sure what the ... and ??? mean? The commit message should have
> > > > > read "... traverse it from gpiofind_sysfs_register()" I agree but the
> > > > > latter?
> > > >
> > > > I didn't realize this may not be obvious :-(.
> > > >
> > > > > > > +}

-- 
With Best Regards,
Andy Shevchenko



