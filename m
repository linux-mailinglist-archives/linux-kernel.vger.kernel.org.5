Return-Path: <linux-kernel+bounces-133407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817B489A350
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352D1281509
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C078C171E59;
	Fri,  5 Apr 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWhQyiBI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591916C854;
	Fri,  5 Apr 2024 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337099; cv=none; b=ccHCHWqPHvRwQM0ZkZ3bDUjfRDAf7OT8vLY6hQyPbpp6gdq/TE9vrabMau4zWITG8gM9GTz4NrmEGrvl8UW5cs0tyYTzVR/z+sx8BhGslpl7EIsdDZb4cGOrapxmQU7ygSvk5b33OG3ehx0gYGx7YnhvtXTUWUzbTLNw/zbxsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337099; c=relaxed/simple;
	bh=u8cXblyK/4P/wYRYqj8sdv2kkiFjbBCmb0PczkRJoww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWvLhk7vERp5qHLwWHeNKwYhEcDM6NuQy4kikh+HZ8vQvFlAOIGI9I/NAhAgMkxRunmQqJZ9JjNCQHLdPPJ7P6cT2IIRYpwP8/7XY0KFUk6KbSt2tru/OXF5/26u+zN2cFZ/YlL8THK4LNjMjzighCr4ZkaSidAkPinZMQVLfVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWhQyiBI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712337097; x=1743873097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u8cXblyK/4P/wYRYqj8sdv2kkiFjbBCmb0PczkRJoww=;
  b=PWhQyiBIaUuxjz5eCAdmBVV90azYILoU4uGSCquuZV1Q0MgqBuob0XM5
   JnyNrIxiLGLtvNhdp5vm+HmQQ9ldM12cBm6VZiuS+58E72KrVoC94fbNi
   Jt7Jtbr5BJVdobY9DuIaYGKmrJHIfKYQLN4PqNFnnbZiPTRt0F4XP6gJ5
   hHzXaLnnt+9GhUWJmOiBk4XVkYMvgiJ0iq8WA30C6FQMZQZysCvwFXApf
   xLwzGWUl3BwU8rg4dRh4nZk7G/sYfaS33EzgzU2TgjtWeVoaiTLd0fYn0
   trk/3t4wJg4iDwgF11DLY8+aXOpt8ULwCBtdRVrRS3+RhSkeRVFmZ49pR
   g==;
X-CSE-ConnectionGUID: 8lIt9+HyRGKLto/+APgYbQ==
X-CSE-MsgGUID: NvbrUNGPTW2gP1pjIMfOkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="19030943"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19030943"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:11:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915259734"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915259734"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:11:35 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsn6C-00000001oCc-2NcW;
	Fri, 05 Apr 2024 20:11:32 +0300
Date: Fri, 5 Apr 2024 20:11:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, peng.fan@oss.nxp.com
Subject: Re: [PATCH v1 1/1] gpio: wcove: Use -ENOTSUPP consistently
Message-ID: <ZhAwxOQ107rrnSHG@smile.fi.intel.com>
References: <20240405162521.3774111-1-andriy.shevchenko@linux.intel.com>
 <564688b7-7d21-414d-9878-5a736777660d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <564688b7-7d21-414d-9878-5a736777660d@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 09:46:40AM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> On 4/5/24 9:25 AM, Andy Shevchenko wrote:
> > The GPIO library expects the drivers to return -ENOTSUPP in some
> > cases and not using analogue POSIX code. Make the driver to follow
> > this.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> 
> Looks good to me.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



