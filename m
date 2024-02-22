Return-Path: <linux-kernel+bounces-76590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFFB85F9AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6F71C23DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878EB1474D3;
	Thu, 22 Feb 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhStrQ1g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC1313172C;
	Thu, 22 Feb 2024 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608216; cv=none; b=YT9vJbIHvvQ0ZoOWSyhqLkZ3ao4gpLeYKFFtsfu5gLgylk7/j/d14XVlL6SdQqH1cNpOFgf6qyIGJbGbZbK0yfHsfhQmNpw55JHFirjX6J5UcYUI/r2Y1Llm5UroWnKVK7W9/ShUeHSU/xVurAbrJp5AFDuA7wOzOXuOGQf6WG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608216; c=relaxed/simple;
	bh=I2mpqktQUMpUVIwK9ivMrxcCg4Ivx2ALtVlPcDb4C1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCeFI7XXre2vfXBvFX9zni/cZ2iBqmRGxMxCdNJWAiFRQHbjx7lYCcNMufzDE5y7qitU91kDaulFPAfuLWUT5mZBTol7ZYcZp90CYImu2v54TqcVzJDHota9DRHpQLT0+SGCx6wSoZck0CukHGd8evczv9L4IVGP5npaWThYF7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhStrQ1g; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708608215; x=1740144215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I2mpqktQUMpUVIwK9ivMrxcCg4Ivx2ALtVlPcDb4C1Y=;
  b=bhStrQ1gGb3GgSwAqMUYLyjwlfMMxucscGZpe3FxZfosx4SoK5e87Nqd
   HuEhNzOEvBardwbLDckYh3jBprFP/+t//RpanIaQG+w4VxpKDXueQbgMD
   OyBOmwBxDYU0nXiwngSYJifllu+E4F9k89fxuqCk1J0FInXc0JqMJiGMA
   nMbt8Lbcr5OZB/TTsu7FF3etvkmfqOD9dg0SjgSV2mSrczvJ6r4cIrhg8
   NzVbxDqd0q1usGOsUfiz4M3jCN7zeYqVdYtX0ozwll4UJOwmMSmK8wrK/
   m8rGbHD2krRZqWyosIRCxiM4IfvtDqoPj6KOObwkOkCOYlJERFvFJS0d9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25292086"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25292086"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:23:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913523658"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913523658"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:23:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rd92q-00000006dXM-30Tv;
	Thu, 22 Feb 2024 15:23:24 +0200
Date: Thu, 22 Feb 2024 15:23:24 +0200
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
Message-ID: <ZddKzHplwOX7naLv@smile.fi.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-11-andriy.shevchenko@linux.intel.com>
 <0a828f2c50de712940fb9a881702ac1678a35b7c.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a828f2c50de712940fb9a881702ac1678a35b7c.camel@codeconstruct.com.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 11:07:05AM +1030, Andrew Jeffery wrote:
> On Wed, 2024-02-21 at 20:31 +0200, Andy Shevchenko wrote:
> > Since we have now a common helper to read port properties
> > use it instead of sparse home grown solution.
> 
> I did some brief testing of the series for the Aspeed machines under
> qemu, building them on top of v6.8-rc5:
> 
> export ARCH=arm
> export CROSS_COMPILE=arm-linux-gnueabihf-
> make aspeed_g5_defconfig
> make -j$(nproc)
> qemu-system-arm -M rainier-bmc -nographic -no-reboot -kernel arch/arm/boot/zImage -dtb arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb -initrd ...
> 
> I got an oops during boot, which bisected to this change:

Thank you for prompt testing! I will look at it.

-- 
With Best Regards,
Andy Shevchenko



