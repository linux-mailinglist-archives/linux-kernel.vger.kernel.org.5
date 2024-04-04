Return-Path: <linux-kernel+bounces-131824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED81898C39
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A2D1F235DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30D61BF40;
	Thu,  4 Apr 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URlUTCr3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3918039;
	Thu,  4 Apr 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248524; cv=none; b=aq1itb7kcPxejmU+U4U9qYLvCc942szYPZYKDmFNzZ8el72geSZRwjZQ/3E3TcOUnNgXClgTxa6FDjC+bPXLT4JwcSH1KmLEnVWLuUdQEq2RZnCex7N5nT6XTNwAle3wAu4iY4BSHHLBDj1kOt99UYOr4EqiyVJrlY9Ah1gcacE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248524; c=relaxed/simple;
	bh=MmhrXXb3uIRaUAMK673aSGEDDVFyLxQk/WLn0pC3LAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbZJ3/FmvI3EKRpARjeBidw9m3zOnVBpPoxdRml+slHKF+stlQD7h2+a/ZWHdZAy/p2G60WcWhPT/K9ml6uSMtyvWTvvl9VZMiHV7gYVit5ATWt7P5eJ1tyqKj42FrZYGVckUZwkyaPkahW3f8RtKAUxXIrtWLr7wQ5oDHeGGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URlUTCr3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712248523; x=1743784523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MmhrXXb3uIRaUAMK673aSGEDDVFyLxQk/WLn0pC3LAY=;
  b=URlUTCr3d0Z1gabu9MAcIyo+sggGcySAsL8I3PXDNm10IR3lMhXK7sO4
   xV4ExfwZhtmXn06BR9xrcm7VSPvJugElMiktOOVjou3P1WTAws48yndp9
   5gouXI36l6vcVGgA4JxMvlwmpoD9VGqW0NOl3R4mwpJTSZD7XDnNca0v8
   LBdvmTWssbn/Nsv9wEKY7tOMKeZPXb9aFQEJJ/G0joydDK6P+wl8zW75I
   5hyrx8ocX+bb9/J6i98GBsZSsr7RBQ1DpyN75zXPrYHE7KcnaPUUkpEC7
   1hQ0YkS/6fQwjQg3vXwW0sobZBZumH784PZdmhOVTgz6PUG0YNGK6LRR8
   w==;
X-CSE-ConnectionGUID: WduZlldlQFGWiJ/B3uvKbQ==
X-CSE-MsgGUID: ZsHRcRzWSwiKe4rLCHEjmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7783650"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7783650"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 09:35:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="915223151"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915223151"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 09:35:16 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsQ3U-00000001W57-3W2D;
	Thu, 04 Apr 2024 19:35:12 +0300
Date: Thu, 4 Apr 2024 19:35:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jianglei Nie <niejianglei2021@163.com>
Cc: gregkh@linuxfoundation.org, tzimmermann@suse.de, javierm@redhat.com,
	sam@ravnborg.org, steve@sk2.org, noralf@tronnes.org,
	u.kleine-koenig@pengutronix.de, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: core: fix potential memory leak in
 fbtft_probe_common()
Message-ID: <Zg7WwNEpZlYsvNwJ@smile.fi.intel.com>
References: <20220928062301.6399-1-niejianglei2021@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928062301.6399-1-niejianglei2021@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 28, 2022 at 02:23:01PM +0800, Jianglei Nie wrote:
> fbtft_probe_common() allocates a memory chunk for "info" with
> fbtft_framebuffer_alloc(). When "display->buswidth == 0" is true, the
> function returns without releasing the "info", which will lead to a
> memory leak.
> 
> Fix it by calling fbtft_framebuffer_release() when "display->buswidth
> == 0" is true.

Fixes tag?

..

>  	if (display->buswidth == 0) {
>  		dev_err(dev, "buswidth is not set\n");
> +		fbtft_framebuffer_release(info);
>  		return -EINVAL;

		ret = dev_err_probe(dev, -EINVAL, "buswidth is not set\n");
		goto out_release;

>  	}

-- 
With Best Regards,
Andy Shevchenko



