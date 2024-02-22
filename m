Return-Path: <linux-kernel+bounces-76903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1A985FE67
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC351F22869
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA9A153BEF;
	Thu, 22 Feb 2024 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjxHJISS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7218657;
	Thu, 22 Feb 2024 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620450; cv=none; b=Ev2lgifBO/PUvtd1qjIiZRT16gOj1jnGZ2SntgrsomhynB/uRC4bwHcjGnBCKu3WdixLVeiBkBFLDaWkSWVQqiA9+pCbKZ0+Wu8VQq8Gb4ILCj8z3p5bCkCLDgKvOhfOeKfIqCE76POBvDn1kmXPuFsL027y8IZlD4ritwf+U9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620450; c=relaxed/simple;
	bh=rZ8aZS6VSxj1TAeS8bays2vC+U6OkHH9YohfP+YSMeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5rGBOK6ThrkNW0OaQXPN9lKFoW4lHW1Kc0iCIkBKMuypNcErtAxyJJ/hkposH9ko1yO8YJTuOxgvqHuEaZqTpyx0vJd0fKj+4sbfTTayLAuAFQTHCHTDLTzW1ava2+QlzIOAZa74qr7V9K0S7d2zYkchQDp6kpeseU2mgBYAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjxHJISS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708620449; x=1740156449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rZ8aZS6VSxj1TAeS8bays2vC+U6OkHH9YohfP+YSMeA=;
  b=mjxHJISS6J/wlhPCBAefyrIiwmisu1R6+sSSCIOmdu//2KZ0lRxo4164
   Bn5aVcjrLXjWBPloQx3K7uDCcKY2oC9Iuro/PUzPIHb5ixj6SbG3dsHJw
   //jIxHE2UmFYFGdYDILzGYfRFYKtJyDoQZBEtDdSXP0Gkb9FySswenMFe
   axUWf+8wLOwMtI00llGeSQ8Uu7Pm8k+GxI2BHdnVcnSyldG4QgGHV7fN4
   tWmqUvks78UI9ekmm2C/VC1yhzTVYBhMnaf0xUqbnN84D63nMZYM2fLcN
   5+Ck6GVEJgIJNj1rX+iyIrd9DF1O8hVdUBmN6rwq/83eihjPs87bBo4YO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2732222"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2732222"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:47:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913553757"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913553757"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:47:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdCEB-00000006gCi-0sPe;
	Thu, 22 Feb 2024 18:47:19 +0200
Date: Thu, 22 Feb 2024 18:47:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v1 10/14] serial: 8250_of: Switch to use
 uart_read_port_properties()
Message-ID: <Zdd6lnXwvpPPUhRR@smile.fi.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-11-andriy.shevchenko@linux.intel.com>
 <0a828f2c50de712940fb9a881702ac1678a35b7c.camel@codeconstruct.com.au>
 <ZddKzHplwOX7naLv@smile.fi.intel.com>
 <Zdd5m2xIPlGI0_Qv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdd5m2xIPlGI0_Qv@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 06:43:08PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 22, 2024 at 03:23:24PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 22, 2024 at 11:07:05AM +1030, Andrew Jeffery wrote:
> > > On Wed, 2024-02-21 at 20:31 +0200, Andy Shevchenko wrote:
> > > > Since we have now a common helper to read port properties
> > > > use it instead of sparse home grown solution.
> > > 
> > > I did some brief testing of the series for the Aspeed machines under
> > > qemu, building them on top of v6.8-rc5:
> > > 
> > > export ARCH=arm
> > > export CROSS_COMPILE=arm-linux-gnueabihf-
> > > make aspeed_g5_defconfig
> > > make -j$(nproc)
> > > qemu-system-arm -M rainier-bmc -nographic -no-reboot -kernel arch/arm/boot/zImage -dtb arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb -initrd ...
> > > 
> > > I got an oops during boot, which bisected to this change:
> > 
> > Thank you for prompt testing! I will look at it.
> 
> I found the issue, will be fixed in next version.

Whoever is going to test this series, the

-		port->iotype = use_defaults ? UPIO_MEM : port->iotype;
+		port->iotype = UPIO_MEM;

should be applied to uart_read_port_properties() implementation.

-- 
With Best Regards,
Andy Shevchenko



