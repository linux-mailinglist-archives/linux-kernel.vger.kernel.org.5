Return-Path: <linux-kernel+bounces-41665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9627B83F619
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424551F22395
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113DF23773;
	Sun, 28 Jan 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lq3QWhlK"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C4523763;
	Sun, 28 Jan 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706455654; cv=none; b=eFctLMt3O93k5Cp1nWX3hoE6N1H3xPqiAy+zRo3TPmeTTN1Ay7VskId6OnfNJI27vwiPx9n/KmjA5YbfmCizlKltkSecTFw9LZMfckuIVkgfr51Q4680BfjHe+8bzvyfGFRNLgs2G4EOBIrbiMUR+uiKuhFW6Z/PQYBVQu/DgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706455654; c=relaxed/simple;
	bh=CEGuxF1NdpPqW1o9TcGgfkb3fmRafzutY9yxEGbzMnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFdjHp09YOBl2mG5eCTK3RQLzD+Q1SC/uLNJ7Fp2jW7qO+iRJZvZHz0h5axd0SOI7ZuHnz5yw+k+LotHeDqxt3K6xwuvp3bZtX/70DyrjR5pB26HrHQd+xgkLwApARuBLm0Be1XV6Wr78y3K+lqFrvLlF1T/aksX/ZNqFLwdqzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lq3QWhlK; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706455652; x=1737991652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CEGuxF1NdpPqW1o9TcGgfkb3fmRafzutY9yxEGbzMnQ=;
  b=Lq3QWhlKbCtgjOqlvuDPao8FfA0FYn32X7CNSqqqIJnMubV2qJnI8IWk
   j6393/YnmWwcZjb2gwDA+qMrF5RGdIIoqjkxt+2qOvDL4PzXPjKETFhdu
   tGRS+8/3BzDIHGGlNMI5BCsWCHMPlIeV2dk0ARCPOHQ6nmvGMKDzSXErr
   S0vXpyMXLmaXQ98GpIFQIriyu9hE7MrNpCurH8JdGg2UUCxB31qWe87gn
   u16nmKLGi9706EeW+FvH88J3rt1jwmj5mNtRRwmY4SU+WB1ZGsiSidc9B
   mytpiO68M7XdU0Zy/av8qpqNzSjO7pGLZ5RnwfV6m46TkIsSE6JwtF2mo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="433945023"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="433945023"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 07:27:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="737145667"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="737145667"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 07:27:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rU748-0000000HUQX-14t5;
	Sun, 28 Jan 2024 17:27:24 +0200
Date: Sun, 28 Jan 2024 17:27:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: kumaravel.thiagarajan@microchip.com,
	tharunkumar.pasumarthi@microchip.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
	f.fainelli@gmail.com, john.ogness@linutronix.de, tony@atomide.com,
	tglx@linutronix.de, jiaqing.zhao@linux.intel.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 tty] 8250: microchip: Add 4 Mbps support in PCI1XXXX
 UART
Message-ID: <ZbZyW_g4OOkCqIxf@smile.fi.intel.com>
References: <20240125100619.154873-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125100619.154873-1-rengarajan.s@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 25, 2024 at 03:36:19PM +0530, Rengarajan S wrote:
> The current clock input is set to 62.5 MHz for supporting fractional
> divider, which enables generation of an acceptable baud rate from any
> frequency. With the current clock input the baud rate range is limited
> to 3.9 Mbps. Hence, the current range is extended to support 4 Mbps
> with Burst mode operation. Divisor calculation for a given baud rate is
> updated as the sampling rate is reduced from 16 to 8 for 4 Mbps.

..

> +#define UART_BAUD_4MBPS				4000000

(4 * MEGA) ? (will need to include units.h, if not yet)

..

> +	frac_div = readl(port->membase + FRAC_DIV_CFG_REG);

> +

Unneeded blank line.

> +	if (frac_div == UART_BIT_DIVISOR_16)
> +		sample_cnt = UART_BIT_SAMPLE_CNT_16;
> +	else
> +		sample_cnt = UART_BIT_SAMPLE_CNT_8;

..

> +	/*
> +	 * Microchip PCI1XXXX UART supports maximum baud rate up to 4 Mbps
> +	 */
> +	if (up->port.type == PORT_MCHP16550A)
> +		max = 4000000;

No. Please refactor the way the 8250_port won't be modified.

Also you have a define for this constant, use it.

-- 
With Best Regards,
Andy Shevchenko



