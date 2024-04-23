Return-Path: <linux-kernel+bounces-155479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317008AEB25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636A31C22AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37A213C695;
	Tue, 23 Apr 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXM5pSNp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF413BC33;
	Tue, 23 Apr 2024 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886291; cv=none; b=LkY9ZO/DHaZbRs02IGPCzwWLmI6N2e1fM4uklq+gov91J6Ho+RvpmtU31jzttyH7sVM6HG7KjURiBzrBmc7PZ3PxitPw7GtE5th2ruEtPnwf5df2Fo8aKmij3c4hzfq3dGd6Mk4bRAo1vXuee1BlAQLi3v9nd0IQpUXJuqMeZFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886291; c=relaxed/simple;
	bh=BlpavYPezI9leAXjmHFPwGvnManzT7FMGBMAmW5A9bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkymYwu75BR9LmloWfp7Tl5gAcuiX4lUavR+SF6KBK+1Lyv552fQ6MSOc4atI36CXtUxb29w/jnMQ6udwgukEkt13lJHOCaqCuAwRfD99jkxqmLOOfxdjSnBk9IacWBpeUUT1VyZztgC9TpPivNtN3zWoGiSy4VF9oHhnZH9Slc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXM5pSNp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713886290; x=1745422290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BlpavYPezI9leAXjmHFPwGvnManzT7FMGBMAmW5A9bk=;
  b=PXM5pSNpP5WbLYA3ajOKC5ly27PNCToxlGqTkpgaXaCxR9umm/JR/AFm
   ci6Ll2dGmDOiv21Km/4vRFQVsOksmoBIuerho5O2My6zsiQq8JJePSNri
   2yvh86SC82RM677i/D5kxBrfjMSBFEbiksKzUdo4sXKYJcwTB7Nkry0Sh
   9u761a1NXh7G3moDaeVkGXNLKY6IlX/nstJcM9DcsZmypFM1tLewtVHuc
   j9PNHFzipd+ZnXm9L2EzpuqCLlx+aOcyGZL+fwF4k9HsP7ncsj1OsygFx
   SEPdl6NvgTjafL8/lPyqP/9JmJHd035hxuN9Q3z5fB28MTkJFtjC+Qwn0
   A==;
X-CSE-ConnectionGUID: SSc2HXT6ROCd7q3+65YTiA==
X-CSE-MsgGUID: mpRh+nh8SzSjWlM9mb7BFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9585993"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9585993"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:31:29 -0700
X-CSE-ConnectionGUID: 7Wl1e3GhTIiPTuRGr92bFA==
X-CSE-MsgGUID: Zz8/bys6SDqEXh8Z1+NeTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="55364540"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:31:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzI76-00000000NQF-21FL;
	Tue, 23 Apr 2024 18:31:20 +0300
Date: Tue, 23 Apr 2024 18:31:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: nuno.sa@analog.com
Cc: Petr Mladek <pmladek@suse.com>, Chris Down <chris@chrisdown.name>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jyoti Bhayana <jbhayana@google.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dev_printk: add new dev_err_probe() helpers
Message-ID: <ZifUSKFh2C4VG5QB@smile.fi.intel.com>
References: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
 <20240423-dev-add_dev_errp_probe-v2-1-12f43c5d8b0d@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423-dev-add_dev_errp_probe-v2-1-12f43c5d8b0d@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 05:20:30PM +0200, Nuno Sa via B4 Relay wrote:
> From: Nuno Sa <nuno.sa@analog.com>
> 
> This is similar to dev_err_probe() but for cases where an ERR_PTR() or
> ERR_CAST() is to be returned simplifying patterns like:
> 
> 	dev_err_probe(dev, ret, ...);
> 	return ERR_PTR(ret)
> or
> 	dev_err_probe(dev, PTR_ERR(ptr), ...);
> 	return ERR_CAST(ptr)

..

> +/* Simple helper for dev_err_probe() when ERR_PTR() is to be returned. */
> +#define dev_err_ptr_probe(dev, ___err, fmt, ...)	({		\
> +	ERR_PTR(dev_err_probe(dev, ___err, fmt, ##__VA_ARGS__));	\
> +})

Why ; and hence why ({}) ?

I even believe the compiler may warn if you have double ;; in some cases.

..

> +#define dev_err_cast_probe(dev, ___err_ptr, fmt, ...)	({			\
> +	ERR_PTR(dev_err_probe(dev, PTR_ERR(___err_ptr), fmt, ##__VA_ARGS__));	\
> +})

Ditto.

-- 
With Best Regards,
Andy Shevchenko



