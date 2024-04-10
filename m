Return-Path: <linux-kernel+bounces-138749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C6489F9F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC942B2988E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6853615CD4B;
	Wed, 10 Apr 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIDPfx1/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5D13E3F3;
	Wed, 10 Apr 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759292; cv=none; b=tcmlDS13Cu7JZilniXvz12X8DSOD9eNd0tImFlATFWmounDE86gVFnt3GJPsQqNtdAHclrXkIzvyvpQLRBkDueLp62HfOokbKib+cfOIqj+zldf6wm7QvttAj0HlVOxVWSbPj329E1sWvWsS0UO+U3v0nygCam5iMjCXWUv766s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759292; c=relaxed/simple;
	bh=Oy39Y7SZ5GfZQjwjySLPItcQE4diRQE11f8BLymwSJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOobxgmS0w2365LPLRbtoj4370Pd3AXoiyTOG9vUwkZvuMYiQ2gKUxFmqyaLSmmKlbaPhRc15cxAxYwBW8MRMfjPFQu8/rkt3m2J0Me8bsCjzN3lvNSVLCtfQf0jS/KvoGzzFYvCrSEyI+ttaYmYH3gPdB77IOY7k1h2yMlFtSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIDPfx1/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712759291; x=1744295291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oy39Y7SZ5GfZQjwjySLPItcQE4diRQE11f8BLymwSJc=;
  b=eIDPfx1/f56rmRInNv0ChLUtgA64Mbml7LqihqKgrrdlurEQVZme4uwC
   dD7RmnOpCDKupnnyYqfMWSFWv/qWpF2Y6clIPbR6LO2JOHQQ1j3xgrMxv
   l4sS+xhSmifv/UJ07FYM3pgJQBuSbWeN/pMeoiT64CyHtc7dKI/eSrkpH
   fAkRtLpJDJBHVPOh9LXuv6INUgPvL94oFOsJSrEDifivNkXo4LOb0RZnw
   MCCiyp7R6IP4ppwXncSYQbO1/C5Ds1OxR5Bbz15FnQ9EB30Mq7tv9lQpP
   Kq/9uiQTSk2llz5/DfCEU89oVSLUxE9Pi2qLTJSdnuNgfW/5etMnHLjG6
   Q==;
X-CSE-ConnectionGUID: 1B+2HRxfRYWFbkT5zEja9g==
X-CSE-MsgGUID: 6+Kr4NrFRw+jVTLZKRkrTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25632521"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25632521"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 07:22:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915434521"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="915434521"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 07:22:51 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruYqf-000000035Xs-2FLO;
	Wed, 10 Apr 2024 17:22:49 +0300
Date: Wed, 10 Apr 2024 17:22:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: max3100: Convert to_max3100_port() to be
 static inline
Message-ID: <ZhaguY64_XrTzl-p@smile.fi.intel.com>
References: <20240410141135.1378948-1-andriy.shevchenko@linux.intel.com>
 <2024041057-angles-flatware-b7ba@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041057-angles-flatware-b7ba@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 10, 2024 at 04:20:10PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 10, 2024 at 05:11:35PM +0300, Andy Shevchenko wrote:
> > As Jiri rightfully pointed out the current to_max3100_port() macro
> > implementation is fragile in a sense that it expects the variable
> > name to be port, otherwise it blow up the build.
> > 
> > Change this to be static inline to prevent bad compilation.
> 
> Is there a problem today? 

Nope. And if anyone tries to make it a problem it won't build, so
unlikely problematic code can ever be upstreamed.

> If not, this line isn't needed, as it sounds
> like you are fixing a problem here, when all you are doing is making it
> "nicer", right?

Correct.

..

> > -#define to_max3100_port(port)	container_of(port, struct max3100_port, port)
> > +static inline struct max3100_port *to_max3100_port(struct uart_port *port)
> > +{
> > +	return container_of(port, struct max3100_port, port);
> 
> Note, the one reason you might want to do this as a #define is if you
> use container_of_const() which has to be a #define.  So the fact that
> this was a define to start with is normal and not really a big deal.

Noted.

Thanks for review!

-- 
With Best Regards,
Andy Shevchenko



