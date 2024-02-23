Return-Path: <linux-kernel+bounces-78707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEB98617A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99801C21709
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC86F84FB9;
	Fri, 23 Feb 2024 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewgfyCCI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD02E41A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705191; cv=none; b=kYR0IPeTqg2fPaeApCw8oireaaC4qvqHONh/Nh6YkN8ts5HNyezPEHloqh3dfLJPUT4dXvhZYkUlz+X6blSxoVWMgQxBRPPKJSns7VQk45/OuGqTVQUfePAA72ZDc+8MqR0w+n5dwltzE63EiYLEM0Ihrzk/LXnWxLyiiSD7Wzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705191; c=relaxed/simple;
	bh=2jIGbrnkTFMbc7sLPfZtnESMOMkF6x2jJ+UzBpPr4jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eaitb1ue4IJxZ5WOYIGc8uYtD7RiScaENMMrEIHWXoU9x1zUoMZOTiUORx1VuAkwAY6KOzrEjpTD2FEqacyG+HoKH4LGCPpUjmzV9HGlA5+ArvOSWbLKian3NtmglxHunOqwxdyjoFsAk5IG+aL3b/MDzpNeH0hfc81rjJzptbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewgfyCCI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708705189; x=1740241189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2jIGbrnkTFMbc7sLPfZtnESMOMkF6x2jJ+UzBpPr4jE=;
  b=ewgfyCCIqIxKku7M43Wttu43F3FexCbczNHfH3SKyM76aQJTvmZ3T24j
   pFDlaBTXyG3YTfFpxI89lNx4Gtabd73bPhfuxRB8fTr+tOgH08z7lfNJH
   iRcBk04kFjlpEccA/5jxVo39UXx6V5jMLenCY6e+ugpgpbL9JQDH4kf29
   sikrtduMYoiT0VjCyM/0xKqluvRu6EdaJOF/Su19phiJxKoQ20fSkXe2g
   H0UhBGCE4eyMdw2zBiwfQzksmtri6MCMVjMgu9DKQ7IbWupO7y8Bewjzs
   hSaP9z2HdggUXaY5V084RhK+8pPl+GT0OABuhjjQV8mGfQyyY8yXfChvn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6844431"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6844431"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:19:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913750327"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913750327"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:19:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdYH2-00000006wgK-3hBc;
	Fri, 23 Feb 2024 18:19:44 +0200
Date: Fri, 23 Feb 2024 18:19:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clkdev: Update clkdev id usage to allow for longer names
Message-ID: <ZdjFoLP6uqi7JsYy@smile.fi.intel.com>
References: <20240223141857.3794855-1-michael.j.ruhl@intel.com>
 <Zdi-QnkPYUFWLJIe@smile.fi.intel.com>
 <DS0PR11MB64245B3F3AB02C32B53F3F64C1552@DS0PR11MB6424.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB64245B3F3AB02C32B53F3F64C1552@DS0PR11MB6424.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 04:09:03PM +0000, Ruhl, Michael J wrote:
> >From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >Sent: Friday, February 23, 2024 10:48 AM
> >On Fri, Feb 23, 2024 at 09:18:14AM -0500, Michael J. Ruhl wrote:
> >> clkdev ID information is limited to arrays of 20 and 16 bytes
> >> (MAX_DEV_ID/MAX_CON_ID).  It is possible that the IDs could be
> >> longer that.  If so, the lookup will fail because the "real ID"
> >> will not match the copied value.
> >
> >Perhaps you need to add a real example.
> 
> How about:
> 
> Generating a device name for the I2C Designware module using the PCI
> ID can result in a name of:
> 
> i2c_designware.39424
> 
> clkdev_create will store:

clkdev_create()

> i2c_designware.3942
> 
> The stored name is one off and will not match correctly during probe.
> 
> >> Increase the size of the IDs to allow for longer names.

..

> >> -#define MAX_DEV_ID	20
> >> -#define MAX_CON_ID	16
> >> +#define MAX_DEV_ID	32

So with the above example increasing by 4 is enough, right?
Maybe we can be modest for now as it will solve your issue?

#define MAX_DEV_ID	24

> >> +#define MAX_CON_ID	32
> >
> >Do we need to alter both?
> 
> It wasn't clear to why there was a difference in sizes.  At the moment the CON_ID isn't
> causing me an issue.  Shall I drop that part of the change?

I think so.

-- 
With Best Regards,
Andy Shevchenko



