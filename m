Return-Path: <linux-kernel+bounces-56645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A6284CD29
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB0A1F21A6C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E81F7E77D;
	Wed,  7 Feb 2024 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQgYnpnK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F301E7C09D;
	Wed,  7 Feb 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317237; cv=none; b=e22ti5fRkasDD1DzPHKqPzRK4kaagVrwXDbbPQBNzNxf9UoeX/9iEHFfQKY4JEKA0re+TvM9qTgEOqQOjNJb+QL9wpU7EpDEL5+uBwoueEDwnpyac14A/7qc5B2Ze3Z593X2d80jWjyRTgpkvLEDaVuP7jtEgrSsl6gpqCC85U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317237; c=relaxed/simple;
	bh=xjOZdcyS1ieJ1WHIh+k+fjd7wcu4iF6GD+F5MUqFzP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptEe57+ickNKTSXd/hM7a7nnY+mqDGcOC/Vj6mV8JVKs4HIEvE4parxziNjpQwPXkLe5QG2f180/7pg44idlZVcflDdDFS5GHqZNv3lGRgLQeFRI0nX4VZFXtOuKQUYDU7awwz9lA5cK0hc2fHiGOX2AWLMxnlW+7HUBvGg2PH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQgYnpnK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707317236; x=1738853236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xjOZdcyS1ieJ1WHIh+k+fjd7wcu4iF6GD+F5MUqFzP0=;
  b=AQgYnpnKXFaWf3ZsC9waoWOCYll9/1Bjy9i7QNb2o11nsP+8zXUV98tX
   9XHQsk8IdvU/CBABhczp27sktC6jPy+OTYss/lLOlX6hguUaET5te/QMo
   /qQgnjVJ35RoUzH10dPGud3+PenFvMjx46UvE+eLWBjaHeR6nfn6oEJBi
   yLfJivqP88pwvGPWR76Oq+IbwETl6ISH57cnNOu/4tU+slOWwbNdjGwnO
   eIr+xVl079+Y5YriEzN/CkPp9NkW5MbrGJAHtPb79sWaxTZzwdDmucb3y
   +HwMP/NuaGvrQg6rydQ+ev/wMmpWMymOKVxrGQPQXf1LNWhGpX5Ei4MSC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="4866458"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="4866458"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 06:47:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="910010065"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="910010065"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 06:47:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXjCf-00000002dEL-0rBY;
	Wed, 07 Feb 2024 16:47:09 +0200
Date: Wed, 7 Feb 2024 16:47:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: yangyicong@hisilicon.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, tony@atomide.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	john.ogness@linutronix.de, tglx@linutronix.de, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
	fanghao11@huawei.com
Subject: Re: [PATCH v2] serial: port: Don't suspend if the port is still busy
Message-ID: <ZcOX7CXecf6pXvEW@smile.fi.intel.com>
References: <20240206073322.5560-1-yangyicong@huawei.com>
 <ZcIvjC1qzD4atwlT@smile.fi.intel.com>
 <9e3d8daf-6715-bb37-125a-4141a9460417@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e3d8daf-6715-bb37-125a-4141a9460417@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 07, 2024 at 03:22:17PM +0800, Yicong Yang wrote:
> On 2024/2/6 21:09, Andy Shevchenko wrote:
> > On Tue, Feb 06, 2024 at 03:33:22PM +0800, Yicong Yang wrote:

..

> >> +		pm_runtime_mark_last_busy(dev);
> > 
> > Do you think we need to call this under a lock?
> 
> I just put this close to the ops->start_tx() where I used the device. Yes I have no
> strong reason to put it in/with the lock region, but pm_runtime_mark_last_busy()
> should be no costy and safe enough to put it in the spinlock region.
> 
> Any thoughts?

As I mentioned before, moving it out makes it similar to the resume
counterpart implementation.

..

> > With the above I would rather write it as
> > 
> > static int __serial_port_busy(struct uart_port *port)
> > {
> > 	if (uart_tx_stopped(port))
> > 		return 0;
> > 
> > 	if (uart_circ_chars_pending(&port->state->xmit)
> > 		return -EBUSY;
> 
> I'm not sure but EBUSY seems not quite match here. EBUSY for
> "Device or resource busy" so the device probably cannot be used
> but we're testing whether the port is busy here. Hope I understand it
> correctly.

Port is also "device" in the broader meaning. I don't see how this is
problematic. Prototype is originally int (while returning boolean).
I assume it was an idea behind similar (if not the same) as mine at
some point, but then vanished. Yet, the function itself can be renamed
to reflect these changes, like
__serial_port_get_status() // 0 - idling, -EBUSY - busy

> > 	return 0;
> > }
> > 
> > static int serial_port_runtime_suspend(struct device *dev)
> > {
> > 	int ret;
> > 	...
> > 	uart_port_lock_irqsave(port, &flags);
> > 	ret = __serial_port_busy(port);
> > 	if (ret)
> > 		port->ops->start_tx(port);
> > 	uart_port_unlock_irqrestore(port, flags);
> > 
> > 	if (ret)
> > 		pm_runtime_mark_last_busy(dev);
> > 
> > 	return ret;
> > }
> > 
> > It also seems aligned with the resume implementation above.
> > 
> > ...
> > 
> > For the consistency's sake the resume can be refactored as
> > 
> > static int serial_port_runtime_resume(struct device *dev)
> > {
> > 	...
> > 	int ret;
> > 	...
> > 	ret = __serial_port_busy(port);
> > 	if (ret)
> > 	...
> > }
> > 
> > but this can be done later.
> > 
> 
> I agree the refactoring should go to a separate patch. But it doesn't seem
> to be more simpler or readable comparing to the current implementation? Just
> want to narrowing the spinlock region?

Yes, at bare minimum I would expect the PM call be moved out of a lock.

As this seems a fix (and hence subject to backport) I would also minimize
invasion.

-- 
With Best Regards,
Andy Shevchenko



