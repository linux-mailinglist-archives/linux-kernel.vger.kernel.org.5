Return-Path: <linux-kernel+bounces-74745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB89A85D891
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F91B235F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D6369972;
	Wed, 21 Feb 2024 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzfQHP+W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8545D69954;
	Wed, 21 Feb 2024 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520397; cv=none; b=F+AGQOI76+6VoaHeP16V5sd7qdGY/pMx75jTTW7oeR5Kq+d4UHsf122bRxeBfpvmxm4plyLByh+5qqFgl0C803prUJ9by0rnXiQN8ugNDpcrW446+8YuysynvnkhZmrEWdHN64nO6Z5xUmlGm/mXcN/qwjHwi0VU04SB9qF6H7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520397; c=relaxed/simple;
	bh=UBb18O7g9AQlT2JjRa2K4NJFLtvBpq0fe/ACOZCx/2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXLMme61xpXAYmyKTPDyYEMJ6TFXfVo1uLDnx1KgSZXkGNWrg7Cxf8WMvLjYe2fSkpVTmd2jMhia4aUCvQmKv+bus/J1tTmVV1cRNAPwVCVia0ARqpIqIBNLx6h4/PIIZnmPgRJMHR1i2rlBvuzNHWuircE4qMHWufV1MlcSnhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzfQHP+W; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708520397; x=1740056397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UBb18O7g9AQlT2JjRa2K4NJFLtvBpq0fe/ACOZCx/2k=;
  b=SzfQHP+WfDcBfv2ow97y3qPsbUN5rqkveCixI0Pz3qFqjvygXc44Gwhq
   y93+tCesj8crnwGmYmF0egOQgjMlkYNd5v9YMpRphhAsJy3ayOxQSy/js
   N0qjKgoAR2trQ0zJbkFc0RkVaIPLiulYun+zXUsWKdVSXI1IgX17p7KMC
   OZhqqc/+c78VzX/LwHTxJvwr2mMgXbooMWImS9NMQqBpS7XGc4qsI6CfF
   0fZFY7WS764fNv61RzE9PQ8qSVWT8DLh21wqF+rktObE+Wzr4PWrI5lTM
   n8/mnq84IVkJ05evbwGKLMGITj1Z7FQgB2PX8ZVRxRlCCqKJBz1F619cp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="25141149"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="25141149"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 04:59:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="936643205"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="936643205"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 04:59:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcmCT-00000006LtU-2IrW;
	Wed, 21 Feb 2024 14:59:49 +0200
Date: Wed, 21 Feb 2024 14:59:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH] gpio: sim: don't fiddle with GPIOLIB private members
Message-ID: <ZdXzxY3-g7oY00Mq@smile.fi.intel.com>
References: <ZPJTT/l9fX1lhu6O@smile.fi.intel.com>
 <CAMRc=Mekf9Rek3_G2ttQY+yBvWM3+P4RAWVOQH99eajn38F+og@mail.gmail.com>
 <ZPWcTMPiu4MSq+F7@smile.fi.intel.com>
 <CAMRc=MfZv70FXHyNw4yK90NL5-jjAJa6qbKc6SV2ZwbaJkKQqg@mail.gmail.com>
 <ZPWmDL6QJJMNi2qa@smile.fi.intel.com>
 <CAMRc=Mc0JgPUEpaes7WcbkMu5JyrpLW8N1+bM-+OJaB+pPX4ew@mail.gmail.com>
 <ZPWr3dRP5C1GSY9F@smile.fi.intel.com>
 <CAMRc=Mfae+=HPPWzsG8bgK2CGOGY9GPkS5VZcwLyr_yY8A_y2g@mail.gmail.com>
 <ZPWxbfHNOqAnkR09@smile.fi.intel.com>
 <CAGETcx9wERf-R4=r_jBYpYgGHSxS=-xx_ydeVWZdGUvEWTQwzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx9wERf-R4=r_jBYpYgGHSxS=-xx_ydeVWZdGUvEWTQwzg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 20, 2024 at 05:46:27PM -0800, Saravana Kannan wrote:
> On Mon, Sep 4, 2023 at 3:29 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Sep 04, 2023 at 12:12:44PM +0200, Bartosz Golaszewski wrote:
> > > On Mon, Sep 4, 2023 at 12:05 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Sep 04, 2023 at 11:47:54AM +0200, Bartosz Golaszewski wrote:
> > > > > On Mon, Sep 4, 2023 at 11:40 AM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Mon, Sep 04, 2023 at 11:22:32AM +0200, Bartosz Golaszewski wrote:
> > > > > > > On Mon, Sep 4, 2023 at 10:59 AM Andy Shevchenko
> > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > On Sat, Sep 02, 2023 at 04:40:05PM +0200, Bartosz Golaszewski wrote:
> > > > > > > > > On Fri, Sep 1, 2023 at 11:10 PM Andy Shevchenko
> > > > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > > > On Fri, Sep 01, 2023 at 08:32:40PM +0200, Bartosz Golaszewski wrote:

..

> > > > > > > > > > > -     /* Used by sysfs and configfs callbacks. */
> > > > > > > > > > > -     dev_set_drvdata(&gc->gpiodev->dev, chip);
> > > > > > > > > > > +     /* Used by sysfs callbacks. */
> > > > > > > > > > > +     dev_set_drvdata(swnode->dev, chip);
> > > > > > > > > >
> > > > > > > > > > dev pointer of firmware node is solely for dev links. Is it the case here?
> > > > > > > > > > Seems to me you luckily abuse it.
> > > > > > > > >
> > > > > > > > > I don't think so. If anything we have a helper in the form of
> > > > > > > > > get_dev_from_fwnode() but it takes reference to the device while we
> > > > > > > > > don't need it - we know it'll be there because we created it.
> > > > > > > > >
> > > > > > > > > This information (struct device of the GPIO device) can also be
> > > > > > > > > retrieved by iterating over the device children of the top platform
> > > > > > > > > device and comparing their fwnodes against the one we got passed down
> > > > > > > > > from probe() but it's just so many extra steps.
> > > > > > > > >
> > > > > > > > > Or we can have a getter in gpio/driver.h for that but I don't want to
> > > > > > > > > expose another interface is we can simply use the fwnode.
> > > > > > > >
> 
> Sorry for being late to the party.

You decided to make a blast from the past due to the last patches from me? :-)

> > > > > > > > dev pointer in the fwnode strictly speaking is optional. No-one, except
> > > > > > > > its solely user, should rely on it (its presence and lifetime).
> > > > > > >
> > > > > > > Where is this documented? Because just by a quick glance into
> > > > > > > drivers/base/core.c I can tell that if a device has an fwnode then
> > > > > > > fwnode->dev gets assigned when the device is created and cleared when
> > > > > > > it's removed (note: note even attached to driver, just
> > > > > > > created/removed). Seems like pretty reliable behavior to me.
> > > > > >
> > > > > > Yes, and even that member in fwnode is a hack in my opinion. We should not mix
> > > > > > layers and the idea in the future to get rid of the fwnode_handle to be
> > > > > > _embedded_ into struct device. It should be separate entity, and device
> > > > > > instance may use it as a linked list. Currently we have a few problems because
> > > > > > of the this design mistake.
> > > > >
> > > > > I don't see how this would work if fwnodes can exist before struct
> > > > > device is even created.
> > > >
> > > > That's whole idea behind swnodes. They (ideally) should be created _before_
> > > > any other object they are being used with. This is how it works today.
> > >
> > > Yes, this is what I meant: if fwnodes can be created before struct
> > > device (as it is now) and their life-time is separated then how could
> > > you possibly make the fwnode part of struct device?
> > >
> > > > And doing swnode->dev = ... contradicts a lot: layering, lifetime objects, etc.
> 
> I understand what you are trying to say about layering, but there are
> no lifetime violations here.

There is. Software node is not firmware node, their lifetime is the same or
wider than the respective device (often, they are statically defined without
any device in mind).

> > > No it doesn't. We have the software node - the template for the
> > > device. It can only be populated with a single device entry.
> >
> > Which is wrong assumption. Software nodes (and firmware nodes) in general
> > can be shared. Which device pointer you want to add there?
> 
> I don't think this is any harder to handle than how a device's
> secondary fwnode is handled in set_primary_fwnode(). For secondary
> fwnodes, you just WARN and overwrite it and move on.

The whole concept of a single linked list with limitation to up to two
nodes and being the part of the struct fwnode_handle itself appears to
be problematic. We have a lot of tricks here and there instead of properly
having a list head in the struct device without any limitations in number
of nodes with a priority based on the appearance in the list.

For the details you may ask USB DWC3 developers and related to that.

> > Which one should be next when one of the devices is gone?
> 
> Similar to how set_primary_fwnode() handles deletion (NULL), you can
> handle the same for when a device is removed. You can check the parent
> or the bus for another device with the same fwnode and set it.

> > No, simply no. Do not use it!
> 
> Using fwnode_handle->dev is no different than searching a bus for a
> device which has dev->fwnode match the fwnode you are looking for.
> 
> In both cases, you are just going to get the first device that was
> added. It's completely pointless to force searching a bus to find the
> device with a specific fwnode.
> 
> In the special cases where one fwnode has multiple devices, no generic
> code is going to always handle the device search correctly. The
> framework adding those devices probably knows what's the right thing
> to do based on which of the N devices with the same fwnode they are
> trying to find.
> 
> I understand it's not great, but blindly saying "search the bus" isn't
> really improving anything here and just makes things unnecessarily
> inefficient.

Is there any _good_ documentation for devlinks and all that fields in the
struct fwnode? Why should we use that without any understanding of the
purposes of that field. We, as device property developers, hadn't introduced
that field and never required it. It's an alien to device properties APIs.

-- 
With Best Regards,
Andy Shevchenko



