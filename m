Return-Path: <linux-kernel+bounces-61458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA48512A9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463A61C22083
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A2A39FE7;
	Mon, 12 Feb 2024 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ai43QcZW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2E439FC0;
	Mon, 12 Feb 2024 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738736; cv=none; b=M7XOTWt0nxFJm1FaEXAcX8eOzEqEvFhiJqU0HQuOFpgybLM3s22JxKdVSpEbr5j1JJ6aJuIuM4TaSNx7829hmp8olvDxVkbmZi1oin8fpkUuSla8beipGt7iE7Ge3Gk16KYtze/jP5GOQ07zErt/G62dFz8Z0aIB19mGHB7Zo9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738736; c=relaxed/simple;
	bh=PV2lBZbbqCKXVMgJIwrV7NXS33dE9Xu1xgpMJAFRNHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n56lhxK+nS8tnrK7mg7HIUdCig1moO2lpu39eSbfqpPqtPrwpe63Z5nz0bSi7CkerkL29FaGdnGNfc7DiNgDrJdFPfa30TjL0w+gTbLaV4+X0rI2LicVHYmxuEcGhjU3JjUS60N+vRDpUMPEuApD8lBSe2CI2klf0W/RUSEXHDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ai43QcZW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707738735; x=1739274735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PV2lBZbbqCKXVMgJIwrV7NXS33dE9Xu1xgpMJAFRNHk=;
  b=Ai43QcZWmdkNVWfWgjlEgre95b5H99LHtK77e+DSJrBAj/3NF35++aUj
   Gqb72gdy2kdlmex/2rKC2EUlRhkd/0NLSBeP8kdeX9O13cYDX7+3dSjxs
   fXCkn/a0QYrhESWYPwfuXjw1I3C2pg+g9V1is3lygoisFhYORDX9kGQnR
   gOhuE4gEI7veuRBLhhvh6WVlZL1AhRjVXjFj6xzg+61VYmaWQGYPAic8U
   ZFyOortGEei8mHNjM8irRUbhCXKMPwfDLKs+BmF5UlBB/srYjM92bePOR
   SgCxsNIuZzZNUKR90LrOixEEmh96a/g/vGKbaGcoAhr5ey+IEWrnykNh0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="2055195"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2055195"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 03:52:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911460587"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911460587"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 03:52:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZUr3-00000003svU-3miA;
	Mon, 12 Feb 2024 13:52:09 +0200
Date: Mon, 12 Feb 2024 13:52:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] pwm: dwc: simplify error handling
Message-ID: <ZcoGaWyvDTk_jWXy@smile.fi.intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-4-raag.jadav@intel.com>
 <ZcUNxT4lxFYhZNBB@smile.fi.intel.com>
 <ZcaL_VH2l5t9cx6m@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcaL_VH2l5t9cx6m@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 09, 2024 at 10:33:01PM +0200, Raag Jadav wrote:
> On Thu, Feb 08, 2024 at 07:22:13PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 08, 2024 at 12:35:27PM +0530, Raag Jadav wrote:

..

> > > +		return dev_err_probe(dev, ret, "Failed to enable device (%pe)\n", ERR_PTR(ret));
> > 
> > Have you checked the output?
> > Note, it will duplicate error codes which we don't want.
> 
> True. Does it make sense to remove it?

"...which we don't want." had been stated above :-)

-- 
With Best Regards,
Andy Shevchenko



