Return-Path: <linux-kernel+bounces-68871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6C9858128
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060F01F284D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BDD134CFE;
	Fri, 16 Feb 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4pz0WSa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF1D129A9B;
	Fri, 16 Feb 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097155; cv=none; b=eKUFJyrz6rpEIe0UbYi3sG9yFAbhocG16anYsFBmxQj+3/Lvc2cHKs/SPBHAiJPcQsUwW7IPxlQZ3PCpQOPmhSLcQ9lcuz1YsRDRWRrydOETf/2gAlIS2OqDy5uz1BJQxQr8Cpkg4h9KsP4xwJanm8QMkiBkigtwV04tI4aNMTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097155; c=relaxed/simple;
	bh=Y+2n3qxg8PIvD7ujhIkFkrGdvHdsig8qyJDwUq2d+Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtBRMyOJO7bSgubR4cdsMieve+EQnQVWpWGUlzUwj1Woqov1U8yaFuh2KWyLdggkVT3nb6BLh7Q+bBk3qN76MnMmXG1tbfzVX01rnLw/0OAbj3xp2NwHoHDRj04iRc9iphCWvB5zwY8dz610DQ9ZFiNcttSYzc/FYDkjrR9AkLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4pz0WSa; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708097154; x=1739633154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y+2n3qxg8PIvD7ujhIkFkrGdvHdsig8qyJDwUq2d+Ys=;
  b=H4pz0WSaA9nsffQMUHfospjtY7W6wCIxhlkAHxUK9/FZkMSGrAx735ik
   266xtsLT6RbgmWOfV81OtBsOIiEbOuyciAknQCotp08RyFMq5W0rN3V+L
   77RMfVUZkYhghdGoIXHytRkF3L/mjLbZwRlbscp7MkkOn+SewGSuBaWds
   6AFJBrCFSclmG2AXV99UNRxBO6+/JkzGjcMrXyUtHSwD80gdgDRC3mQvR
   Vl+EwU5HQxABA7u94UZaCTW4qQkVCokcNg7sYgX1IOMjiAq/V1HPaXzBp
   rh8gekZ1wBBcwX7sZt9X/uirYCk4q5dvgNH8dWAmll8RSC8HZiIDOTK1Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2094119"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2094119"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 07:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="912376076"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="912376076"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 07:25:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rb05x-0000000557b-3xwA;
	Fri, 16 Feb 2024 17:25:45 +0200
Date: Fri, 16 Feb 2024 17:25:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/8] of: automate of_node_put() - new approach to loops.
Message-ID: <Zc9-eSEH-D1n4dAv@smile.fi.intel.com>
References: <20240211174237.182947-1-jic23@kernel.org>
 <ZcoJEUTdMAKdMHd1@smile.fi.intel.com>
 <20240216144756.08e25894@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216144756.08e25894@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 16, 2024 at 02:47:56PM +0000, Jonathan Cameron wrote:
> On Mon, 12 Feb 2024 14:03:29 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Feb 11, 2024 at 05:42:28PM +0000, Jonathan Cameron wrote:

..

> > I'm a bit skeptical about need of this work. What I would prefer to see
> > is getting rid of OF-centric drivers in IIO. With that, we would need
> > only fwnode part to be properly implemented.
> 
> To be honest main reason for doing of first was that they have unit tests :)

fwnode also has KUnit test. Have you considered adding test cases there?

> The IIO drivers were more of a proving ground than cases I really cared
> out cleaning up.  However I'm always of the view that better to make
> some improvement now than wait for a perfect improvement later.

Yes, but in my opinion _in this particular case_ it brings more churn and
some maybe even not good from educational purposes, i.e. one can look at
the current series and think "oh, OF is still in use, let me provide my
driver OF-only (for whatever reasons behind)", while targeting conversion
first will tell people: "hey, there is an agnostic device property framework
that should be used in a new code and that's why we have been converting old
drivers too".

> However one or two are not going to be converted to fwnode handling
> any time soon because they make use of phandle based referencing for
> driver specific hook ups that isn't going to get generic handling any
> time soon.

Sure, exceptions happen.

> I'll probably focus on getting the fwnode version of this moving
> forwards first though and 'maybe' convert a few of the easier ones
> of these over to that framework to reduce how many users of this
> we end up with in IIO.

Thanks!

-- 
With Best Regards,
Andy Shevchenko



