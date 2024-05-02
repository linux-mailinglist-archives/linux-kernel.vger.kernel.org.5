Return-Path: <linux-kernel+bounces-166121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C08658B9683
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF6C7B20A17
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF66843AA4;
	Thu,  2 May 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEheLKjG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE84C1527A6
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638785; cv=none; b=qd1jeChU7QyckCOaMc8pIlwPpJDH2pPYOwb14kc9XX1ykaE10R0YT09Owqr8KPSqcwQfP7a7hlWpdZ+73cvZKUy9nkcwVA4HoRK63xX/dM4HTE9Sk352YZ9BcBhAZkNHepytpBcr3XeSpOVuFXaPtOWQYJ0XzExq2lHMYeFJzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638785; c=relaxed/simple;
	bh=b+TuzblpaPLNqK5y6jojd+QDA8Xbs2mf6a72pzvmDAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHmcEdpYaj3eAT3At17bf549bbKFzmnyb8kD8treJq4ZRa5Z16G/3B9fgMlQBtUm65/sFgMd6dPKC0FZ+x+uQ6R72zN9AOX3S9ty91GBP4N/c0oqr+ITvdvT4j2EQja1KVl8HjkyJnw1xy6fSXN2ihl52fUmT94dQYMTlzl4LJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEheLKjG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714638784; x=1746174784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b+TuzblpaPLNqK5y6jojd+QDA8Xbs2mf6a72pzvmDAE=;
  b=TEheLKjGLHU7o/iq0wrQYIfJ55KBaAtEk0YzBLUzYICaVC2FxQakfH70
   oY0+F0tElAzEKIe6i/rXNNKnGMuO/4QGad8eLKiu27WNSQW2KxKnUbst2
   szgoq2CvgCVQwsgyHFoVQrFv77FVCs+WzCOaLQ/TErnTeyuksnwVZmSaD
   wZuDeSaZiNNQVpwECCOShvZxI+62OL2c6IrIpnSxpWKkWp8fLfTi6PQRh
   BsF6fQpP6+u0rXuJ/IZqmFjO1556HXZv0hbj76oxjquveB6zhMjLMLDUV
   4VgEjXmerXCq69+jzWa3uQySAebwNkSAjYG74/CuqMSbT4o+WCS/Fg5A8
   A==;
X-CSE-ConnectionGUID: +XmGdUanRwmBZjyoE68+mA==
X-CSE-MsgGUID: Z8q0jZBsSoKvjR87fmyoMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10562682"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10562682"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 01:33:02 -0700
X-CSE-ConnectionGUID: JAgRKzqdSdq31tSxNlgi/g==
X-CSE-MsgGUID: WvDCmPXcTl6Tok3RT2k4rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27059626"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 01:32:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2RrM-00000003FFm-3aSR;
	Thu, 02 May 2024 11:32:08 +0300
Date: Thu, 2 May 2024 11:32:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [v1,1/3] drm/panel: ili9341: Correct use of device property APIs
Message-ID: <ZjNPiBvLF3WcBftn@smile.fi.intel.com>
References: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
 <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
 <ce6a480d-80b3-46b0-a32d-26bc6480d02f@linux.dev>
 <ZiqrLfezhns4UycR@smile.fi.intel.com>
 <b5ffd984-4031-4a8a-adbc-75a1e1dfe765@linux.dev>
 <ZjD8eoO3TmuCUj-a@smile.fi.intel.com>
 <9e69b129-7539-4403-a621-bf3775aab995@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e69b129-7539-4403-a621-bf3775aab995@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 01, 2024 at 12:27:14AM +0800, Sui Jingfeng wrote:
> On 2024/4/30 22:13, Andy Shevchenko wrote:
> > On Fri, Apr 26, 2024 at 05:13:43AM +0800, Sui Jingfeng wrote:

..

> > the former might be subdivided to "is it swnode backed or real fwnode one?"
> > 
> Yeah,
> On non-DT cases, it can be subdivided to swnode backed case and ACPI fwnode backed case.
> 
>  - For swnode backed case: the device_get_match_data() don't has a implemented backend.
>  - For ACPI fwnode backed case: the device_get_match_data() has a implemented backend.
> 
> But the driver has *neither* software node support

True.

> nor ACPI support,

Not true.

So, slow down and take your time to get into the code and understand how it works.

> so that the rotation property can not get and ili9341_dpi_probe() will fails.
> So in total, this is not a 100% correct use of device property APIs.
> 
> But I'm fine that if you want to leave(ignore) those less frequent use cases temporarily,
> there may have programmers want to post patches, to complete the missing in the future.
> 
> So, there do have some gains on non-DT cases.
> 
>  - As you make it be able to compiled on X86 with the drm-misc-defconfig.
>  - You cleanup the code up (at least patch 2 in this series is no obvious problem).
>  - You allow people to modprobe it, and maybe half right and half undefined.
> 
> But you do helps moving something forward, so congratulations for the wake up.

-- 
With Best Regards,
Andy Shevchenko



