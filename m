Return-Path: <linux-kernel+bounces-131406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6424898739
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C571D1C26D12
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD9D8613E;
	Thu,  4 Apr 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzHFPLi0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0E83CA2;
	Thu,  4 Apr 2024 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233405; cv=none; b=hp4OIPkC9gYU8kmcCbE7XQkQJdaF2PY+6p4shHt9Hlr3AdqTNga1nvyfXN1LbY62Os+b+smMd3H+nRdJZFO7Az57wNILhnJbpQUF4cbXMpN08DlSlq8+tl9n/97NlDNLTsHpnbDuCL2aBdfaLYMqGSdzOMy5EFMS0kIqTlBYwUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233405; c=relaxed/simple;
	bh=7FdMeEVDP45EBezLHqk2LWO1xjiO1Mq6YhsC9H1PFSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1J4VrShx1viicgLnfGtWcHh9+Wdry5TZqFTxSTL2smlD9ZoP7Tf+Z6eJLgaCLKg5llIJlrLWxNMsuhDp0depkewLWTCbKjwEK5S5b/HDjCJe9PcVoe047Z1CoD1wDKPdYPrCQmcOXNDPw/LqNyYx0Fz58o0r6j435c/UekEmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzHFPLi0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712233404; x=1743769404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7FdMeEVDP45EBezLHqk2LWO1xjiO1Mq6YhsC9H1PFSk=;
  b=CzHFPLi0h4hr8yeIWx3DOmRLz6gnGiEBoGE+G59+hI1Y0140tF0uOf1v
   I08djqExUIHT4qx9xt0wQLfHSSRA3lucV7nxE4Dv7Rx6IQ981Dv2SnrGD
   LOXGcJ04LXafByekH7BjIZheVO7FLSYaT/ocCHRjnimW+gp1q/000Jxyl
   ZXKOHA4zClAZh0guMcVOhMxPfkt19aau9tWMfY/bMLENyOymKrdDVH6ly
   3V9rzVCb/TfUhA7Ue6l0ZPCGBaQIB/ygZc4TDAbyt6g7pYKwDlkQPGIdU
   cclxZq10aLXLCJ4Um5dC76GDA14jJB4S8XofeVBbI1std5tJNJ7OuF5f9
   w==;
X-CSE-ConnectionGUID: VEv/MoXrT9mXGORA9UDs8w==
X-CSE-MsgGUID: 1Mn4UD+PSlW1nDewCPfIlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18663937"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18663937"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915216648"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915216648"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:23:16 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsM7d-00000001QLJ-2ON6;
	Thu, 04 Apr 2024 15:23:13 +0300
Date: Thu, 4 Apr 2024 15:23:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jyoti Bhayana <jbhayana@google.com>,
	Chris Down <chris@chrisdown.name>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: backend: make use of dev_errp_probe()
Message-ID: <Zg6bsS3WMvp-nY3S@smile.fi.intel.com>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
 <20240404-dev-add_dev_errp_probe-v1-3-d18e3eb7ec3f@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-dev-add_dev_errp_probe-v1-3-d18e3eb7ec3f@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 01:06:25PM +0200, Nuno Sa wrote:
> Using dev_errp_probe() to simplify the code.

..

> +	if (IS_ERR(fwnode))
> +		return dev_errp_probe(dev, PTR_ERR(fwnode),
> +				      "Cannot get Firmware reference\n");

ERR_CAST() seems quite good candidate to have here.

		return dev_errp_probe(dev, fwnode, "Cannot get Firmware reference\n");

(Assuming dev_errp_probe() magically understands that, note you may have it as
 a macro and distinguish parameter type with _Generic() or so and behave
 differently: ERR_PTR() vs. ERR_CAST(), see acpi_dev_hid_uid_match()
 implementation, but also keep in mind that it doesn't distinguish NULL/0, there
 is a patch available in the mailing list to fix that, though.)

-- 
With Best Regards,
Andy Shevchenko



