Return-Path: <linux-kernel+bounces-63839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE3A85354E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FF81F222F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B45F850;
	Tue, 13 Feb 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7EM3Q2q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2195F491;
	Tue, 13 Feb 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839617; cv=none; b=k/WJm4+cvFvKbR9g6AcWwWpqEQ/IYhlCSonhosf8O6k+L7YJOLzXMXLqFo39CCX0LfxPznqb70P4N61M4Z4KojcJlqF+CtBlmPNfDEUxFqGCfecHOT/q3KXz2YaY3+/oXAcbsMIR3BQs3RzQVDk+EYwA3eqE6OSlQ+6ZXw/pmu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839617; c=relaxed/simple;
	bh=FyA7j/DjLwdZDicaxICSIs/E+LoyuZykZwZXBepmzwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUyAF+XAXP8H59FNY6n76MYzXdvJzJBqMOcmaK/VXYuoAypQ5t7SHVjgtiBJ5lzET95T2g/CjhnPRqmF1P/disYoGRMymeyTgNkMhZkgvhczdbsyQnsmabDg0TFOIVEkIAdgbipSooT4wDoaFgxNRbwUDFLWKKezoXtLUtQPnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7EM3Q2q; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707839615; x=1739375615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FyA7j/DjLwdZDicaxICSIs/E+LoyuZykZwZXBepmzwc=;
  b=j7EM3Q2qNzXJOvdZay5q6uqBDFMjvNPO7qDMoRfRK185zZKN3esNsDy7
   j5nLLxmJ+4fcwGt12gevDwSkLzYc0PhoCFdB2zoPDVgjY4PbqlCwWnIq+
   XuzUn3BxitKGjf+8mg6yIDisDYQRvyhztXre8z2Ze+qqstfhSPoyTnpGH
   aGqFVylfhhR+4juyRPhlbO2GTZxnP0DPzZsiudPEZfgnN9+qW2GkiQQWy
   jBy5X+kO8g9Q7wtIaZaFzbu/GnHttnH7gWjCgShK4OwDywQun8RRubDhS
   x+RFJD4zzx/VQw4B+3w+rTNmAzIEpbzMGHjG7DU39ECrLS+jMh9dK8CYk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12942894"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="12942894"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 07:53:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911814661"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="911814661"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 07:53:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZv63-00000004G36-2bFB;
	Tue, 13 Feb 2024 17:53:23 +0200
Date: Tue, 13 Feb 2024 17:53:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 4/6] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
Message-ID: <ZcuQc3frV99SKkXd@smile.fi.intel.com>
References: <20240213084545.40617-1-tony@atomide.com>
 <20240213084545.40617-5-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213084545.40617-5-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 13, 2024 at 10:45:11AM +0200, Tony Lindgren wrote:
> We can now add hardware based addressing for serial ports. Starting with
> commit 84a9582fd203 ("serial: core: Start managing serial controllers to
> enable runtime PM"), and all the related fixes to this commit, the serial
> core now knows to which serial port controller the ports are connected.
> 
> The serial ports can be addressed with DEVNAME:0.0 style naming. The names
> are something like 00:04:0.0 for a serial port on qemu, and something like
> 2800000.serial:0.0 on platform device using systems like ARM64 for example.
> 
> The DEVNAME is the unique serial port hardware controller device name, AKA
> the name for port->dev. The 0.0 are the serial core controller id and port
> id.
> 
> Typically 0.0 are used for each controller and port instance unless the
> serial port hardware controller has multiple controllers or ports.
> 
> Using DEVNAME:0.0 style naming actually solves two long term issues for
> addressing the serial ports:
> 
> 1. According to Andy Shevchenko, using DEVNAME:0.0 style naming fixes an
>    issue where depending on the BIOS settings, the kernel serial port ttyS
>    instance number may change if HSUART is enabled
> 
> 2. Device tree using architectures no longer necessarily need to specify
>    aliases to find a specific serial port, and we can just allocate the
>    ttyS instance numbers dynamically in whatever probe order
> 
> To do this, let's match the hardware addressing style console name to
> the character device name used, and add a preferred console using the
> character device name.
> 
> Note that when using console=DEVNAME:0.0 style kernel command line, the
> 8250 serial console gets enabled later compared to using console=ttyS
> naming for ISA ports. This is because the serial port DEVNAME to character
> device mapping is not known until the serial driver probe time. If used
> together with earlycon, this issue is avoided.

..

> +int serial_base_add_preferred_console(struct uart_driver *drv,
> +				      struct uart_port *port)
> +{
> +	const char *port_match __free(kfree);

= NULL

> +	int ret;
> +
> +	ret = serial_base_add_prefcon(drv->dev_name, port->line);
> +	if (ret)

Otherwise here might be a problem.

> +		return ret;

> +	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
> +			       port->ctrl_id, port->port_id);
> +	if (!port_match)
> +		return -ENOMEM;
> +
> +	/* Translate a hardware addressing style console=DEVNAME:0.0 */
> +	return serial_base_add_one_prefcon(port_match, drv->dev_name, port->line);
> +}

-- 
With Best Regards,
Andy Shevchenko



