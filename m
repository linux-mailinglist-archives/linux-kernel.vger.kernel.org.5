Return-Path: <linux-kernel+bounces-58423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2BE84E650
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE79A1F26B3B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3AF85C6C;
	Thu,  8 Feb 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRFGqLGg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36F4823CB;
	Thu,  8 Feb 2024 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411971; cv=none; b=omccHQCbb2yABU4PALQXUVPvLYfG7K7Deml6ztB/rbKg/T/uomfzwRZ+tJ6MS3vFuRF/XOTpDBsqgI/sTHJSoQDiETRrwZgt9xOLVV3PCOMA4IC3bAd2qYIDBYXJDlJtGraikm3YRbjnbNetGIhFiOqMxp1ccyhnlCRe5bksVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411971; c=relaxed/simple;
	bh=weiTssnYxbgtk/zrjEr7qX/kW/Pm4Vm4A9/P12deYlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Plqm7R3pg9lXU+7ZfzGAFdxrFIkrrTVjgHSs4eL6CdcProybYnxVkkgVq25gq5rZzOfx1D/3KLvyNZH4JvfMsY/SnDabIwTxw6qNcl9zgPzQlYdx6VOFzUmytLRfMBvbC6t3Iuh8jNTUwSUKIjRnsykOkTJ0bewk7VK7sFjcLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRFGqLGg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411971; x=1738947971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=weiTssnYxbgtk/zrjEr7qX/kW/Pm4Vm4A9/P12deYlI=;
  b=JRFGqLGgMli2QTapV/6EAJ3ZuCkIa7d88q+yWvdCpyfe7BmZpc1JHD52
   h2BAwAzUeoZz5kDNLGJLWzEKiEYc3yovBD+eN+A489Them1lTMESBoyd2
   8rilF6y2U5u6Ad9YAtGzvld515yg6pw4djuNBUj4ZlxYCBaISHQVBApH2
   vlL+jtGFofqg6n7mTSND3OEncbeZ/r/zPhi45O/rlmJtW0oL2YQprL5Ub
   L0aTS3T3/5EZDHhptJYjUY9a+dF7G7nfFbjtAaKiWsl1DBaixIAZSbCus
   WeOjxM7tRxf9ecKwPM6T4IzlzV7Ld8l5iC9Fs5tHr31tpsQKHSUfdufju
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="11837275"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="11837275"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:06:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910426307"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910426307"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:06:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY7qd-00000002vnH-0R8w;
	Thu, 08 Feb 2024 19:06:03 +0200
Date: Thu, 8 Feb 2024 19:06:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] pwm: dwc: drop redundant error check
Message-ID: <ZcUJ-ofy0OpXnYmT@smile.fi.intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-2-raag.jadav@intel.com>
 <qrwcje4t2pbbxilnlfz2q7njodcp6vl54uaypdbvjgvwhgvc5g@4eq5wvumpjjx>
 <ZcUJoSMhgC7lhY-H@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcUJoSMhgC7lhY-H@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 07:04:34PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 08, 2024 at 08:46:44AM +0100, Uwe Kleine-König wrote:
> > On Thu, Feb 08, 2024 at 12:35:25PM +0530, Raag Jadav wrote:

..

> > (Yes, I know https://lwn.net/Articles/627419/,

Btw, it has nothing to do with this case.

-- 
With Best Regards,
Andy Shevchenko



