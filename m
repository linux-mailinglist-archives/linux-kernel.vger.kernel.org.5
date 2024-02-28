Return-Path: <linux-kernel+bounces-85678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8066486B927
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29DF1C239C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9193B14534C;
	Wed, 28 Feb 2024 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDjVDa3o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F0E5E060;
	Wed, 28 Feb 2024 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709152683; cv=none; b=MPuWMwtUsxr2keWsx/pXMADS9QpkHVlfkcJSmSdUfDb7qWf70oOZgcQRd9sI2sne9LyxW08zCywQlngBTAMa4/3DyALqNgpoYcI1nYh9X6G5WxlPOTnBbdNYurOXwXPANQRvxM2l/EndhK48ThMVPE3AWQ79V4Q0WTtfUYDG6bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709152683; c=relaxed/simple;
	bh=0Q6xuzCclX2DBnM/iyNF85skbnZtBTaulITRAdjHuS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGeCVCiqcFRYX4sw2G+cZZegCUKWXjjpgFoa53q8cSx68itNRJO8JpIW2/GYWrCGe5VTMklURhP1IM6cIodbYicx6M+hsgmEQP+QvSCwnRMRrffEoEYf2CZCBlcPsCEY25y+54qUq+w+5CEi13g4/cZ/3XNJkcOGXdz1EV8uI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDjVDa3o; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709152682; x=1740688682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Q6xuzCclX2DBnM/iyNF85skbnZtBTaulITRAdjHuS4=;
  b=oDjVDa3o87NNazkGw1l6QFIpFZ5E5GjPJdIMzpKNBwSlMkb6UfMjenAP
   bdin3Gr3G2flz3SGaGsbXvFb2X0egEKcDwsmD9Y+X6XQpgoYvMLJ0zq2l
   +n0dbqnPYzm/kh3iE+MjylmlMmHnu0yguP6UMtWBBZBuTfPNJnZ3JaXw6
   OXufnEWHJvtT//PxnGdM0qkM/oA5/L9dJvFgFXwnEPopLWA2aVKYBbBGH
   cw7cmdFkFOZnPRg46pd6OImkft5O4L9oywKyjHA+bEZCzn5ZOOdKWQIWr
   GzgNEcIJWXATzQIcLwIGl3k3Z/1h72HmIRw0vNzvyEICNyIEIIt+nWzLZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3447063"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3447063"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913960802"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="913960802"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:37:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfQge-00000008Ubr-1H5C;
	Wed, 28 Feb 2024 22:37:56 +0200
Date: Wed, 28 Feb 2024 22:37:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/2] gpiolib-of: Make of_gpio_get_count() take
 firmware node as a parameter
Message-ID: <Zd-ZpNNpUOgMBf78@smile.fi.intel.com>
References: <20240228184412.3591847-1-andriy.shevchenko@linux.intel.com>
 <20240228184412.3591847-2-andriy.shevchenko@linux.intel.com>
 <8862c6a9-529c-4c52-a84b-176e6d61351a@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8862c6a9-529c-4c52-a84b-176e6d61351a@alliedtelesis.co.nz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 08:23:10PM +0000, Chris Packham wrote:
> 
> On 29/02/24 07:40, Andy Shevchenko wrote:
> > Make of_gpio_get_count() take firmware node as a parameter in order
> > to be aligned with other functions and decouple form unused device
> typo: form -> from

Thanks, I will fix it if new version will be needed.
Otherwise I hope Bart can do that.

> > pointer. The latter helps to create a common fwnode_gpio_count()
> > in the future.
> >
> > While at it, rename to be of_gpio_count() to be aligned with the others.

P.S> Please, remove unneeded context in the replies.

-- 
With Best Regards,
Andy Shevchenko



