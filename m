Return-Path: <linux-kernel+bounces-7242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBF481A3AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B509D1F267A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5152D481BA;
	Wed, 20 Dec 2023 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwgtyHG2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF44653F;
	Wed, 20 Dec 2023 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703088224; x=1734624224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQj8luOfgwemBks3bxIO9yysVkYQT4TKDMg0qFGRAFI=;
  b=mwgtyHG2p1sHvmTOin3zuqdS2NQrnFy3QYv749nYuXPJLK9W+XR18AJ0
   prmhp3IpY9bipLAuaIbd4hKHujD1ZcU+GofQ+uo8R82SR+FHY1uZ+KWZq
   7h2crQVDSwBtqaprT/f5tfa3XE+hSVw1sRUSN392NbAZvoKUHyLWoeOL1
   dkvwXy/fiT6GwJ06XPcJWitBIYa69KOCwUqxxFm1qK58+vTCKr0Dg+1T7
   Fwtkj+PHItRdc5uamzWtPeaoWZ5WLJ1uPcNvrHcIHXWD3MYIjfBr0Rk9i
   byoSsjZHQTLxpu3s+XX9K8YvV8dLkLyRTplChl9iWu590els71nNBp2Lo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="395560553"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="395560553"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 08:03:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="842321276"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="842321276"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 08:03:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFz2U-00000007axk-3Ads;
	Wed, 20 Dec 2023 18:03:18 +0200
Date: Wed, 20 Dec 2023 18:03:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 17/18] serial: sc16is7xx: refactor EFR lock
Message-ID: <ZYMQRv1Td7FjH5Mh@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-18-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219171903.3530985-18-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 12:19:01PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Move common code for EFR lock/unlock of mutex into functions for code reuse
> and clarity.

...

> @@ -333,6 +333,7 @@ struct sc16is7xx_one {
>  	struct sc16is7xx_one_config	config;
>  	bool				irda_mode;
>  	unsigned int			old_mctrl;
> +	u8				old_lcr; /* Value before EFR access. */
>  };

Have you run `pahole`?
I believe with

	unsigned int			old_mctrl;
	u8				old_lcr; /* Value before EFR access. */
	bool				irda_mode;

layout it will take less memory.

...

> +/* In an amazing feat of design, the Enhanced Features Register (EFR)

/*
 * This is NOT the style we use for multi-line
 * comments in the serial subsystem. On contrary
 * this comment can be used as a proper example.
 * (Yes, I noticed it's an old comment, but take
 *  a chance to fix it.)
 */

> + * shares the address of the Interrupt Identification Register (IIR).
> + * Access to EFR is switched on by writing a magic value (0xbf) to the
> + * Line Control Register (LCR). Any interrupt firing during this time will
> + * see the EFR where it expects the IIR to be, leading to
> + * "Unexpected interrupt" messages.
> + *
> + * Prevent this possibility by claiming a mutex while accessing the EFR,
> + * and claiming the same mutex from within the interrupt handler. This is
> + * similar to disabling the interrupt, but that doesn't work because the
> + * bulk of the interrupt processing is run as a workqueue job in thread
> + * context.
> + */

...

> +	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
> +			     SC16IS7XX_LCR_CONF_MODE_B);

One line. (Yes, 81 character, but readability is as good as before.

-- 
With Best Regards,
Andy Shevchenko



