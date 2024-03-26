Return-Path: <linux-kernel+bounces-119717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC13488CC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977B9320995
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6551E13C696;
	Tue, 26 Mar 2024 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ava8appS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24F14265;
	Tue, 26 Mar 2024 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479011; cv=none; b=L1ISZeHGJei9RMkX+qPUc4g++3i5omCJOKxNVBY0hjAhXgrI2C7X2HIPkUfFs+f8QxLktWFj4Pit/yACAEDvCPLNj/Z74pw7yU4IgK1CqxyF9TjdAD6+WoqtHnk+FhxUBhQzrVt7yHOgoWFOZ6Uj8S1RC9tz/kJ3obnW2bs4CeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479011; c=relaxed/simple;
	bh=a1y1froYsk3QklXtDSfjEieKaCKHwIw1eSHeC1vU9wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bwo4URG6GTqOaWx88kNzrWtx7avsn7ON2PuC6DSyqq5TjvOmhPw3PK+kbOGyMwIFn3lRJlxNa1973IvTXdn4scATHcXtLpeFqTSZqXw5QV0h6KxPGP6Y0VN4LlxRLftbZjRNdpIMlpEuO1nZvGN6rDm81udkJBg4vU1QVY+tK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ava8appS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711479010; x=1743015010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a1y1froYsk3QklXtDSfjEieKaCKHwIw1eSHeC1vU9wM=;
  b=ava8appSS8EwarT3hemjXraQnHiHQrsiw3kTwyj7fr/jND3dTPg+GYY2
   BmOTZb1ahe/1Ve9NJJijpv00P5D7cyBHvS8G4DGvfHE0VgAwiK6N8E66+
   xka88Wks11FP/aHrBkQdnRX/OjLZSdxMkmKkHvM3S0619WL9ufSb4HJkO
   goJO8G7iVdWcnj0HeD0/+YtWuo6yovHkmMTusVTvPRLVd+brPHikM7OJL
   sZl6Sz717kM//TrCtfDlxjRHFeHoYWkPo4SHg+wYSVvegEKDUrYjomIbM
   Qau+Z12Djo5TUMUb2NdBCShPIOWAwhzkbXPjwWpu5wm+BGzz/N3EsHVt/
   A==;
X-CSE-ConnectionGUID: 1uxnIGgoSoui0EI18pF2zw==
X-CSE-MsgGUID: ljxv+9nBSwSwwH0uSb6Uhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="23993149"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="23993149"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914887860"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914887860"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:50:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpBs4-0000000GQSL-3HAk;
	Tue, 26 Mar 2024 20:50:04 +0200
Date: Tue, 26 Mar 2024 20:50:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 07/10] spi: pxa2xx: Provide num-cs for Sharp PDAs via
 device properties
Message-ID: <ZgMY3AeC1Jnh1Oru@smile.fi.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-8-andriy.shevchenko@linux.intel.com>
 <dcdf8c46-acdc-466d-afc6-caf0e0fa39e8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcdf8c46-acdc-466d-afc6-caf0e0fa39e8@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 06:21:48PM +0000, Mark Brown wrote:
> On Tue, Mar 26, 2024 at 08:07:57PM +0200, Andy Shevchenko wrote:
> 
> > Since driver can parse num-cs device property, replace platform data
> > with this new approach.
> 
> But why?

To be able to hide the header's contents from public.
Should I update the commit message?

..

> > +static const struct property_entry spitz_spi_properties[] = {
> > +	PROPERTY_ENTRY_U32("num-cs", 3),
> > +	{ }
> > +};
> 
> This is just platform data with less validation AFAICT.

I'm not sure what validation you are expecting here. It should be done via
DT schema ideally when the platform gets converted to DT. This change is
an interim to that (at least it makes kernel side better). After the platform
code may be gone completely or converted. If the latter happens, we got
the validation back.

In any case it's not worse than plain DT property handling in the kernel.
The validation in that case is done elsewhere. Since the property is defined
in board files the assumed validation is done during development/review
stages. But OTOH for the legacy code we need not to touch the property
provider more than once. We are _not_ expecting this to be spread.

-- 
With Best Regards,
Andy Shevchenko



