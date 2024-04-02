Return-Path: <linux-kernel+bounces-128428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB566895AB3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD761C242C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D4515A4A7;
	Tue,  2 Apr 2024 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/eXTt6J"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E7133283;
	Tue,  2 Apr 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079117; cv=none; b=JLgn6lu/x6Kf7IO4/KgTn4AaORhtjmNLIz83o98DFxRCxzSi3YawZt1tSsUXGi7GBUnBequQ1rD/gMsmxOLDl+LLKlwjjazndLGE+x6rmsIeBSxbJMd4w2iN/p0wJJRlMsvHyhLHHorCKHg+p0jsu472pHf1M+3R57CstNQufQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079117; c=relaxed/simple;
	bh=C0ZSSNOpHyhEbPUaA9p+K32Yavs79+fcPRuoG/dwLIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9St2mOGbE51dIdigbFZZso8T6XY7FBbbMNKKcb9qwbhJQSkYetBRvxToO8pnAf9TFZD6ZoEVTe5dRelNY1NEZrbTaVqXQeilaQeHP5jrItp3b+Do61yEz8YA59r+lMOTqjmvuVAFAJSjVlqg91y0IZAfqiwoTYOR3g31OliVgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/eXTt6J; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712079115; x=1743615115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C0ZSSNOpHyhEbPUaA9p+K32Yavs79+fcPRuoG/dwLIE=;
  b=e/eXTt6Jlcyg15my781c1HMoY/wSiG3MoQWvtj7FA4vJoK9fOgHO0+tW
   Bc2poyFtVciP0CNUdXiRLUfXvu/l5ae0Y5d6whxLSW4CFXq/4hsLP7xJT
   Rs+US6Sc/r5KScnKz6qJ3cjvNMox+qxFuYTNNsAwK1EK6CWgSJQcAyoIs
   lTbbVOB0XHcp+N/FpNfZeHU7fJGVZb5ob+xNEBKE7kJnbt8vQW+JBlycJ
   EWOMdLBAQi1ufBStVR3vPP18rzixxp3Z+yjiWkuwFOfkm3iWeHmkziNRh
   a1cmDikFbr40gs3KT+blpFII7wmKpUA8AhbhksYf+FJnMaIe35mAypy0u
   A==;
X-CSE-ConnectionGUID: HYhK7PqBRlCmFrbUj+GWzA==
X-CSE-MsgGUID: hYV/3O7RSoWV9LYzNTga0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10234532"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="10234532"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 10:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915148030"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="915148030"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 10:31:53 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrhzC-00000000sgo-3iNh;
	Tue, 02 Apr 2024 20:31:50 +0300
Date: Tue, 2 Apr 2024 20:31:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 02/16] serial: max3100: Update uart_driver_registered
 on driver removal
Message-ID: <ZgxBBioFa1HIFth8@smile.fi.intel.com>
References: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
 <20240402154219.3583679-3-andriy.shevchenko@linux.intel.com>
 <20240402131827.fdc429dfb6f62db4d291688f@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402131827.fdc429dfb6f62db4d291688f@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 02, 2024 at 01:18:27PM -0400, Hugo Villeneuve wrote:
> On Tue,  2 Apr 2024 18:38:08 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

..

> >  	pr_debug("removing max3100 driver\n");
> >  	uart_unregister_driver(&max3100_uart_driver);
> > +	uart_driver_registered = 0;
> 
> At the beginning of the probe function, we have:
> 
> -----------------------
> if (!uart_driver_registered) {
> 		uart_driver_registered = 1;
> 		retval = uart_register_driver(&max3100_uart_driver);
> 		if (retval) {
> 			printk(KERN_ERR "Couldn't register max3100 uart
> driver\n"); mutex_unlock(&max3100s_lock);
> 			return retval;
> ...
> -----------------------
> 
> If uart_register_driver() fails, uart_driver_registered would still be
> true and would it prevent any other subsequent devices from being
> properly registered? If yes, then maybe "uart_driver_registered = 1"
> should be set only after a sucessfull call to uart_register_driver()?

Looks like yet another issue here (however I haven't hit it so far).
I guess I can combine both fixes.  What do you think?

-- 
With Best Regards,
Andy Shevchenko



