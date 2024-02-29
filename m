Return-Path: <linux-kernel+bounces-86903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C4C86CC96
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4B6B25A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7731419A9;
	Thu, 29 Feb 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZXIH8o6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911861386C9;
	Thu, 29 Feb 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219643; cv=none; b=TfAVyzn5lTTUbQG9Ffpz5PrPoucyHOBNNqBz7TkaOHjBAXw3YuaYbWvl0GRfWX4v6pZmwmzPHLrHBQUhA6HNXjD++bU4NM3ueoyR1LSkxV/PGEp2X7ylibF+S5Nn+tfRSFvg22jUrS2uhDnTso03X2O1Z8W+3AlAcSX2uERdo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219643; c=relaxed/simple;
	bh=QsL+ZAdDVYizAYNGrUGef+IMlP9BDK8a2fH3vRdP9FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=red5BsR63fOH1zmmPcCvtoKTGtuPRRvimITGnvaptte/eVaqy5/EZ73YV6hefci00dwXaYGqvD7wYr1uGNy2PyCrO3yrao6uHZkgnE8YbHeOmawVtOPjA5OjGMSVKkTFv6srlFzFhCsnWmcV3On7Q2qfh3OyYCxdmnk1ZHM2f6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZXIH8o6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709219642; x=1740755642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QsL+ZAdDVYizAYNGrUGef+IMlP9BDK8a2fH3vRdP9FU=;
  b=WZXIH8o6yoJLXG7S+PvHLiAFg6DaNUXkHMeylQbtsOMb6FecYIHICpRK
   RzR/5z2r8zX49s80HB35ZaNZeK5PQU4hg3Ewf+D8RQks4uxrwdH15JtCC
   nxbZZcwbm2vI2bz0fydreX6jKyCYvtC/j0yHPHRM/yfh8a7EFPO3gyzaS
   ZzGUeqtwPHWp1UQ3ehpGwssDiH7EIfhUSurRq8NWA9/lp96lCIHagQWYH
   wiaJV1U3VZ+UEpKOqJPonXVHVDqmIKsSa9iF6klbjceVZKsJh8PTsklhJ
   dsriOH2JURzvBpXXnQWPoxEqVLZemUOJMQyZbl2FvSOGQoAcu6MQa3b3m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3573481"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3573481"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:14:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913984248"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913984248"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:13:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfi6b-00000008hap-2Rgi;
	Thu, 29 Feb 2024 17:13:53 +0200
Date: Thu, 29 Feb 2024 17:13:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 1/5] net: wan: Add support for QMC HDLC
Message-ID: <ZeCfMfuMI4hJ54Bb@smile.fi.intel.com>
References: <20240229141554.836867-1-herve.codina@bootlin.com>
 <20240229141554.836867-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229141554.836867-2-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 03:15:49PM +0100, Herve Codina wrote:
> The QMC HDLC driver provides support for HDLC using the QMC (QUICC
> Multichannel Controller) to transfer the HDLC data.

..

+ array_size.h
+ bug.h

> +#include <linux/cleanup.h>
> +#include <linux/dma-mapping.h>

+ device.h
+ err.h

> +#include <linux/hdlc.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>

+ spinlock.h
+ types.h

With this fixed (below is up to you),
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

..

> +free_desc:
> +	qmc_chan_reset(qmc_hdlc->qmc_chan, QMC_CHAN_ALL);
> +	for (i = 0; i < ARRAY_SIZE(qmc_hdlc->rx_descs); i++) {

I'm wondering what prevents you from doing

	while (i--) {

> +		desc = &qmc_hdlc->rx_descs[i];

> +		if (!desc->skb)
> +			continue;

..and probably get rid of this check?

> +		dma_unmap_single(qmc_hdlc->dev, desc->dma_addr, desc->dma_size,
> +				 DMA_FROM_DEVICE);
> +		kfree_skb(desc->skb);
> +		desc->skb = NULL;
> +	}

-- 
With Best Regards,
Andy Shevchenko



