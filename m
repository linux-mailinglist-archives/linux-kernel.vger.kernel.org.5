Return-Path: <linux-kernel+bounces-76614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75BB85FA08
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63205B2606F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C8A134CF7;
	Thu, 22 Feb 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mC93pHeV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162136AE9;
	Thu, 22 Feb 2024 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609229; cv=none; b=stEV3qdUA4GbjVEdVrK+dSa2YCIA8ZRRy7bRnlWRcs8EkcKd3M/o6yqJPD0Uv0yGRNeSSexIfW3kVr1v+qFPuelxlwctOkgFIMT/jp8UMlPU+b8xddeWMRTVXqnAZDBV2BpWa6WhVUhLFFxC5il7sy9CkG2X2DWWIRYNKb5HyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609229; c=relaxed/simple;
	bh=fnEOeglpT4EQ+0f9qaoZpPrCDD+FKG2ThNnpRREPMx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qxyzu59ezVwuNXiB04WuJQISGLCyzSZdOOAxZbXduqRCtCdDszl5/fEoFdN1JSXdK+3RN5LT9rSMX+IFEp89C2G6iAWr4/M2HpPJ2/ybiYQhYrkcYZ2I7AHyBzk6nGVoX9Z+AWZzAhmMp1t1oIQJDwtxAwY66dOcn5y/BKOw+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mC93pHeV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708609228; x=1740145228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fnEOeglpT4EQ+0f9qaoZpPrCDD+FKG2ThNnpRREPMx4=;
  b=mC93pHeV+XxYnDBIRZE5ufrNQQhMRD2ShW6YceYkporDLhdIJnVW1RSt
   s+g+ApUzwETlxyxMM87QLSJVvZkxrX1Bmwc+UtRcmLaTqEGp14ZJ63xgz
   ijebvyzEYtbymMUdcVH0KxY6WTIZvu2Ar6azzW6/s/eswdHNahEKr8vkF
   5LiAjEGJhUxMOoZIJc0SR4Acw8ptq96EHq+OF5JYrJhGMK9SDN+cVz1F4
   dgBjCEAjCchugcJMkV9GizF5sJRlLXsGzqSyfaZ3VXxch60uEbzcR5J0a
   76ZyTgK7kYXyNIXIGUNFDq5c1Tz0tUnzXyl302bSG8LlgZod18F5a8nzT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25295216"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25295216"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:40:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913528071"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913528071"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:40:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rd9JH-00000006dk6-0xbi;
	Thu, 22 Feb 2024 15:40:23 +0200
Date: Thu, 22 Feb 2024 15:40:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpiolib: Deduplicate cleanup for-loop in
 gpiochip_add_data_with_key()
Message-ID: <ZddOxiq_28v9995p@smile.fi.intel.com>
References: <20240221193647.13777-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=McECxKW+uS7fQyGtYVfcSZQaAJZFi+s+wNMoRiHxef0zw@mail.gmail.com>
 <ZddL7L24RXoqR7sN@smile.fi.intel.com>
 <CAMRc=Md6d19hhySFti+vSLV9pfyzuHNUDmHN_XYV73uCWDAY7w@mail.gmail.com>
 <ZddOcJrYEANc2B2Y@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZddOcJrYEANc2B2Y@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 03:38:56PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 22, 2024 at 02:30:03PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Feb 22, 2024 at 2:28 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Feb 22, 2024 at 10:48:00AM +0100, Bartosz Golaszewski wrote:
> > > > On Wed, Feb 21, 2024 at 8:36 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:

..

> > > > > +       while (desc_index--)
> > > >
> > > > What about gdev->descs[0]?
> > >
> > > What about it? :-)
> > >
> > > for (i = i - 1; i >= 0; i--)
> > > while (--i >= 0)
> > > while (i--)
> > >
> > > are all equivalents.
> > >
> > > The difference is what the value will i get _after_ the loop.
> > 
> > Ugh of course. But the first one is more readable given I got tricked
> > by variant #3 at a quick glance but the for loop says out loud what it
> > does.
> 
> I disagree. `while (i--)` is very well known cleanup pattern.
> Less letters to parse, easier to understand.

$ git grep -n 'while (i--)' | wc -l
298
$ git grep -n 'while (--i >= 0)' | wc -l
246
$ git grep -n 'for (--i; i >= 0; i--)' | wc -l
29
$ git grep -n 'for (i = i - 1; i >= 0; i--)' | wc -l
17

-- 
With Best Regards,
Andy Shevchenko



