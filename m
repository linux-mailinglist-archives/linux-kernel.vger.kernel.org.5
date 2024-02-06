Return-Path: <linux-kernel+bounces-54997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2266084B60B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC6C1F26446
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A673130E47;
	Tue,  6 Feb 2024 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AF0Fbq4+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D2130AE9;
	Tue,  6 Feb 2024 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225123; cv=none; b=tLK5Yrx5vEDeLRpfv/Lpc/dUpppmnSUYhAGZTgsr80XzS+IzjpoZLazAhLZXWmqyqcdnYHaWbKQPmVRIu25OkPNtuTCAfUD/acDxMlmtZTDu7BCBRXSFEqGiG76l2CZk1Qe66+Ce9Ckg9JSefVbdYy3tVDn8M9wQmlJneiCcLMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225123; c=relaxed/simple;
	bh=U9N6WUlsynHRlhNqn3yh71TdYBU6lE1dumlPlYdgcs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzKNSDabDMBukUo6R/zrgRhOj/xDnE8BzwZjJTuC4ckPJ++4IPoLcCllFeDhZM5G9uTRMvmS7WBwudbNqgQcwHlAQ8eTjA4MvQ2kUg57t0+KS4BcsMW7HYvoiNvqM/sl4C+/StOMopKq8gaURon7by33Y3ThPkorSy78xEFb+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AF0Fbq4+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707225121; x=1738761121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=U9N6WUlsynHRlhNqn3yh71TdYBU6lE1dumlPlYdgcs8=;
  b=AF0Fbq4+TqKsVnA/U/NHh6hRGtUxOXYD//fDiJpweKwxhv/GDRHCeV/9
   k1lyTXX9r6uCLXzqvPFt5vU2yTaZXh3np5/R9yXAFX9DGFJCovxiiiMiV
   2xbQWS1hYSJGQ/KjEH4T5lZmZFLHdPcy1Cq1mu2i2vxOVz0BNMNBOK3My
   nB2wD4F0o9qxXJxjH9FHHxyzD4UQOJBeoaURGcX5/c6SzTM7u697pMG/G
   PgOU8GS1M4iugxkaUYa9/ADiCksS1mBUwaDQD0J7PBUTo+N+aqTLmooma
   y3gRf6GzKqkCMcm/m4hXcWCLulX5zBsKeRJ/CIOOtiKI8OgglxoYZ/LI+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="26187819"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="26187819"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:12:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909633012"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909633012"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:11:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXLEw-00000002LXI-3xu0;
	Tue, 06 Feb 2024 15:11:54 +0200
Date: Tue, 6 Feb 2024 15:11:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, tony@atomide.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	john.ogness@linutronix.de, tglx@linutronix.de,
	yangyicong@hisilicon.com, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
	fanghao11@huawei.com
Subject: Re: [PATCH v2] serial: port: Don't suspend if the port is still busy
Message-ID: <ZcIwGm-W4A2rupOi@smile.fi.intel.com>
References: <20240206073322.5560-1-yangyicong@huawei.com>
 <ZcIvjC1qzD4atwlT@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcIvjC1qzD4atwlT@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 06, 2024 at 03:09:32PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 06, 2024 at 03:33:22PM +0800, Yicong Yang wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>
> > 
> > We accidently met the issue that the bash prompt is not shown after the
> > previous command done and until the next input if there's only one CPU
> > (In our issue other CPUs are isolated by isolcpus=). Further analysis
> > shows it's because the port entering runtime suspend even if there's
> > still pending chars in the buffer and the pending chars will only be
> > processed in next device resuming. We are using amba-pl011 and the
> > problematic flow is like below:
> > 
> > Bash                                         kworker
> > tty_write()
> >   file_tty_write()
> >     n_tty_write()
> >       uart_write()
> >         __uart_start()
> >           pm_runtime_get() // wakeup waker
> >             queue_work()
> >                                              pm_runtime_work()
> >                                                rpm_resume()
> >                                                 status = RPM_RESUMING
> >                                                 serial_port_runtime_resume()
> >                                                   port->ops->start_tx()
> >                                                     pl011_tx_chars()
> >                                                       uart_write_wakeup()
> >         […]
> >         __uart_start()
> >           pm_runtime_get() < 0 // because runtime status = RPM_RESUMING
> >                                // later data are not commit to the port driver
> >                                                 status = RPM_ACTIVE
> >                                                 rpm_idle() -> rpm_suspend()
> > 
> > This patch tries to fix this by checking the port busy before entering
> > runtime suspending. A runtime_suspend callback is added for the port
> > driver. When entering runtime suspend the callback is invoked, if there's
> > still pending chars in the buffer then flush the buffer.

..

> > +static int serial_port_runtime_suspend(struct device *dev)
> > +{
> > +	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
> > +	struct uart_port *port;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	port = port_dev->port;
> > +
> > +	if (port->flags & UPF_DEAD)
> > +		return ret;
> > +
> > +	uart_port_lock_irqsave(port, &flags);
> > +	if (__serial_port_busy(port)) {
> > +		port->ops->start_tx(port);
> 
> > +		pm_runtime_mark_last_busy(dev);
> 
> Do you think we need to call this under a lock?
> 
> > +		ret = -EBUSY;
> > +	}
> > +	uart_port_unlock_irqrestore(port, flags);
> > +
> > +	return ret;
> > +}
> 
> With the above I would rather write it as
> 
> static int __serial_port_busy(struct uart_port *port)
> {
> 	if (uart_tx_stopped(port))
> 		return 0;
> 
> 	if (uart_circ_chars_pending(&port->state->xmit)
> 		return -EBUSY;
> 
> 	return 0;
> }
> 
> static int serial_port_runtime_suspend(struct device *dev)
> {
> 	int ret;
> 	...
> 	uart_port_lock_irqsave(port, &flags);
> 	ret = __serial_port_busy(port);
> 	if (ret)
> 		port->ops->start_tx(port);
> 	uart_port_unlock_irqrestore(port, flags);

> 	if (ret)
> 		pm_runtime_mark_last_busy(dev);

And obvious question here: why in case of 0 we can't mark this as busy as well?
I.o.w. why do we need to mark it only when error is set?

> 	return ret;
> }
> 
> It also seems aligned with the resume implementation above.
> 
> ...
> 
> For the consistency's sake the resume can be refactored as
> 
> static int serial_port_runtime_resume(struct device *dev)
> {
> 	...
> 	int ret;
> 	...
> 	ret = __serial_port_busy(port);
> 	if (ret)
> 	...
> }
> 
> but this can be done later.

-- 
With Best Regards,
Andy Shevchenko



