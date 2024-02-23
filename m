Return-Path: <linux-kernel+bounces-79081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7CD861D53
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB711C22AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67B9146915;
	Fri, 23 Feb 2024 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zr6mgTnD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53331170E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719289; cv=none; b=KKkJnbjFh1htQwyeiCiqckdzprYd2crHNXtVfb2/rYqWE0ODHo6SsDegvH9nJy026VB3VzktK/JWy/jA1WNsF8hDlEQIH+Zqdnr/rXXlRB1n2B6y5wr5nGtrF9Y+IwTiZe10pvdgmIMUVyEvialsI7EfgMeR/dVfuuUPMgEOfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719289; c=relaxed/simple;
	bh=GAV0YEZII1KXdP/l7x6m86oj5oYErslcGjKNsLJ+dIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2yjocAb5x1ekIm2kdMwy//liid7xcTGIlM+RlihQOt8O8x2yDIl2XKWvO2K1M8KbK5YkPhbs/7JfVPV58UjzJl81MVoiNRH4uRkrQXob8ZDlg6WVPYUX0W28TNkBW8NhmpuPtSyws3podnKfA2YV/stdi/xfUMwJrG+mp/jrpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zr6mgTnD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708719287; x=1740255287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GAV0YEZII1KXdP/l7x6m86oj5oYErslcGjKNsLJ+dIQ=;
  b=Zr6mgTnD9Oe9CuMIOKzrSCemutcX/7MzErDaTQ9fF975Xwqe9gVMZYCO
   evg76VIiv6mqgmjduGqOwJTlCDCcaLMIPvCgtvE5blkGYYX2bf+OYIpxC
   6fnyqQhOKm1VZ1x3dRbC6qOU7POxyKn5PXHpXgvh6N0aIvy62lR2gDNxZ
   BDoNjX6ugLZHJzOeFYUuwB+2DeJrVdZEZs/pFtNiQ0a1H08IbdIM2523Q
   b4osiMZnG1vHYtil6rmr+mHVDi2Dii/CXkQ2vFccjqPC46gXty5+ta3PS
   rA+eogRuwDCd/8xHaIa3qP+tiOTeOfSLLNrXr6Mmd5r13Z+61mQzu6XYi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="2929955"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="2929955"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 12:14:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913755316"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913755316"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 12:14:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdbwP-00000006zlr-3qby;
	Fri, 23 Feb 2024 22:14:41 +0200
Date: Fri, 23 Feb 2024 22:14:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clkdev: Update clkdev id usage to allow for longer
 names
Message-ID: <Zdj8sSKBG22msfYy@smile.fi.intel.com>
References: <20240223163516.796606-1-michael.j.ruhl@intel.com>
 <ZdjZCrpP52Hfbs6L@smile.fi.intel.com>
 <DS0PR11MB64248E0C15C0B86A1CCF945BC1552@DS0PR11MB6424.namprd11.prod.outlook.com>
 <Zdjku0kxCvMl2HcU@smile.fi.intel.com>
 <Zdj2zaicBvkTOZZe@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdj2zaicBvkTOZZe@shell.armlinux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 07:49:33PM +0000, Russell King (Oracle) wrote:
> On Fri, Feb 23, 2024 at 08:32:27PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 23, 2024 at 06:22:13PM +0000, Ruhl, Michael J wrote:
> > > >From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >Sent: Friday, February 23, 2024 12:43 PM
> > > >On Fri, Feb 23, 2024 at 11:35:16AM -0500, Michael J. Ruhl wrote:

..

> > > >[1]: https://github.com/andy-shev/home-bin-
> > > >tools/blob/master/ge2maintainer.sh
> > > 
> > > Using your script I got:
> > > 
> > > To: "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
> > >         linux-arm-kernel@lists.infradead.org,
> > >         linux-kernel@vger.kernel.org
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > 
> > > My list (using get_maintainers.pl) is:
> > > 
> > > linux@armlinux.org.uk
> > > linux-arm-kernel@lists.infradead.org
> > > linux-kernel@vger.kernel.org
> > > 
> > > They appear to be the same....
> > 
> > Ah, the Russel's email looked like a mailing list, that what confused me.
> 
> Joe, I think you know that I'll pick up on your mis-spelling of my
> name... and I take that as an implicit right to call you something
> other than your proper name. :D

Since, Javier, you told me that, I now remember some rumors... :D

> Secondly, because the Cc contained my name, I fail to see how you can
> confuse that with a mailing list. Maybe your script that you mentioned
> strips the names from the email addresses, thereby adding to your
> confusion - and maybe that isn't such a good idea after all?

It's other way around. My script uses full names.

> I'm not the only one who uses linux@... There are six people in total listed
> in MAINTAINERS who have a linux@... email address there.

Yes, but you are the only one which pops up WRT this file.

> > > I don't have the plain text part on Russel's email
> > > (linxu@armlinux.org.uk)... Is that what is missing?
> > 
> > Yes :-)
> > But my script also uses a heuristics (which is not visible here) to add active
> > developers of the code in question based on the git history.
> 
> The developers in question for this part of the code is me and not the
> CCF.

Yes, get_maintainer.pl seems to return that. It's me who naively considered you
as CCF maintainer.

> Therefore, what has been done by the patch author is reasonable
> and no special scripts are necessary.

The scripts makes life easier and robust against changes.

-- 
With Best Regards,
Andy Shevchenko



