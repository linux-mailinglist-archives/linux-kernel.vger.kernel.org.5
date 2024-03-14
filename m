Return-Path: <linux-kernel+bounces-103291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BC087BD93
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11060286F46
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E6F5B5AB;
	Thu, 14 Mar 2024 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItMcJgnr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466415A11A;
	Thu, 14 Mar 2024 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422516; cv=none; b=qI+jU3o59Z1e2H4YiDxHelaF3nJqHCHiXzlCdsoTWrP9bEvjE83tq3/VKY5qCaZ9MQ5y3YijKVKQ8ql+NLltwiSHUkZgu+x7GlXkMrNZbFDaOEMnSvvH19CV16rBIFPE6qQncKYVbokIGIYLeXub3uFFy4PA7vYY5fthLQ0uLSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422516; c=relaxed/simple;
	bh=efNmoPB9xQTqqj1zcv7v1m8HPH9PXIJnJFCvFlBcJWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoXkyOpgdPQbyipl0i027WfSxImvhqlwqIaBs+b1WXUBfmgvu0e1zcmTRSBs57FLnKoCKx0lbUNtugS7JoV5X6TzKx0TRZ4C18Tatdw+1XIR1eB8RMkGtc0MQqeERdVR0vAqNwUGbZ0KcE1sL/E9nev694zLqFfPuKatAmZdsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItMcJgnr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710422515; x=1741958515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=efNmoPB9xQTqqj1zcv7v1m8HPH9PXIJnJFCvFlBcJWk=;
  b=ItMcJgnrQO7AOCeMJOV3eOtmjqhzUwj8JqQe5unxHuv4RoMTM0rXetHZ
   2WGeo3RQ7IBJQsMlmEH4oIQ2kamaN0juaMPz/H2Qu+ZeqzNXhG40lWFl4
   Kdv2+01T5OuVhakFg2cB7eV4QKAkYEILj6bgoRNPL5zqmTBC4HI2un1cS
   AqdyVeqqqIhIuZ4V0ViylBLihljz/9RUQm+ZC+Eodz9AvFJBz/kx8qcRL
   tgyrF84B6gGFhxjJLMj4DpnHjxGy0YwyHSrOJeVSXfKY1lO8shjxqpLHA
   6O/Jy35Rx9rvSd6YB5+CTAfLdYPpqLtMA0HqV5H1uz7JK29zKMtJbjmvI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5092509"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5092509"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 06:21:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="914460276"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="914460276"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 06:21:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkl1n-0000000CWQ3-1pAU;
	Thu, 14 Mar 2024 15:21:47 +0200
Date: Thu, 14 Mar 2024 15:21:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 0/3] gpiolib: Get rid of
 gpio_free_array()/gpio_request_array()
Message-ID: <ZfL562yGPEwA3ZM7@smile.fi.intel.com>
References: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
 <CACRpkda6bykOFY6gcZqRKLAnprUooZooQ_g7Rj_63da2akbwtA@mail.gmail.com>
 <ZfGKkjxIT9AEd8dy@smile.fi.intel.com>
 <CAMRc=McjYKCLGKk42SWdCy3Lc=B4B21WpS1kvx_d66itHKsQzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McjYKCLGKk42SWdCy3Lc=B4B21WpS1kvx_d66itHKsQzQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 13, 2024 at 12:47:58PM +0100, Bartosz Golaszewski wrote:
> On Wed, Mar 13, 2024 at 12:14 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Mar 07, 2024 at 03:36:18PM +0100, Linus Walleij wrote:
> > > On Thu, Mar 7, 2024 at 2:51 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > > There are only two users left of the gpio_free_array()/gpio_request_array().
> > > > Convert them to very basic legacy APIs (it requires much less work for
> > > > now) and drop no more used gpio_free_array()/gpio_request_array().
> > >
> > > That's reasonable and makes the kernel a better place.
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Thank you!
> >
> > Bart, do you want me to take it via my tree or you want to take directly?
> 
> We don't have Acks from the relevant arch maintainers yet.

True. But I haven't noticed much maintainer's activity WRT PXA code.
I dunno who can be the best to Ack these. Arnd?

> I can pick it up but I won't do it before the end of the merge window anyway.

Sure.

-- 
With Best Regards,
Andy Shevchenko



