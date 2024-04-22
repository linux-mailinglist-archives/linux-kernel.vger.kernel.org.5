Return-Path: <linux-kernel+bounces-153287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA18ACBFE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9913287BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91901465BB;
	Mon, 22 Apr 2024 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8VlGU2X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6449146595;
	Mon, 22 Apr 2024 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785125; cv=none; b=H+gmmA+KHe01Ed5D5OUayMeiFOnC2HrNS3Q43naksrVQpDxWan5AnzevXubOxWcDyXEQQSGTScad9yCaHHaau8gUCxswTJdUMVXWEqsLHmjEPZwCh2hz1kt/K6kzftPy9/u3k4pT72PI2YTtujpzLweEXwWswaXfbHPO6fdkBbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785125; c=relaxed/simple;
	bh=pvYpGRqfQzmXAQ7YW/DJ+a/zXvR9xu2PRQNWpbm/XbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efJHvk3XIGZBxTLXf0WYTWBcgcOm6XEbIH5236o9c1CcXyPGvuqT3FZoYOcPKAHkwNp5uTDYaRXb5MS+eTqR+qKqLq1eme8kE5XjAu2VIzQWWQqZTN7Nyde9J3P9YTZSN1nZP2CS/qqDRzKraRpZVfgIX/eeq3P05dR3lt+N0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8VlGU2X; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713785124; x=1745321124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pvYpGRqfQzmXAQ7YW/DJ+a/zXvR9xu2PRQNWpbm/XbU=;
  b=j8VlGU2XSuwCKuo8ea5DpKGBh8vntNw85h16xOqDXZwY3ojfFcCTVtU5
   Ef9B4+BKISr+PRCa5Xfio7ZQNQkB9pap8t+7tcFTTSuHpFvj9+B1e6rwy
   qnIMLvC8gnrhtdPueMzsClBA3i95CWnAkhDTuqE5tFF3FT1J0F9KfIBiv
   0JBLkHBQOtDthsfKZDdSgUy0MDWjceeNmfOZH0fU0wbRCWasVYFrkPVyX
   CSqOi0PNWBbbKBJjj541BeruK6TmJRr8WcqwSZUEuNxFjIvBeJCREGSCn
   uf5Jlxw5vCbslf/Tj+CsLaXEHseP7s84wJP300/llhSlW57JY6zzXgOHV
   w==;
X-CSE-ConnectionGUID: JrYWWxn4QRiVajmDkQcyTw==
X-CSE-MsgGUID: GWsEvB+uQiWy/C39raHoTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="13091854"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="13091854"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:25:23 -0700
X-CSE-ConnectionGUID: bLZUpIrkRSm28KMeRdyLZw==
X-CSE-MsgGUID: Uxe70PzpS9aDSXtcEzLwZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28662284"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:25:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ryrnM-00000001dHV-3v8H;
	Mon, 22 Apr 2024 14:25:12 +0300
Date: Mon, 22 Apr 2024 14:25:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: krzk@kernel.org, conor@kernel.org, lkp@intel.com, vz@mleia.com,
	robh@kernel.org, jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl,
	Konstantin Pugin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 3/3] serial: sc16is7xx: add support for EXAR XR20M1172
 UART
Message-ID: <ZiZJGCEYlM7Jhs5k@smile.fi.intel.com>
References: <20240420182223.1153195-1-rilian.la.te@ya.ru>
 <20240420182223.1153195-4-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420182223.1153195-4-rilian.la.te@ya.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Apr 20, 2024 at 09:22:06PM +0300, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> XR20M1172 register set is mostly compatible with SC16IS762, but it has
> a support for additional division rates of UART with special DLD register.
> So, add handling this register by appropriate devicetree bindings.

..

>  	help
> -	  Core driver for NXP SC16IS7xx UARTs.
> +	  Core driver for NXP SC16IS7xx-compatible UARTs.

'-compatible' --> ' and compatible'

>  	  Supported ICs are:
> -
> -	    SC16IS740
> -	    SC16IS741
> -	    SC16IS750
> -	    SC16IS752
> -	    SC16IS760
> -	    SC16IS762
> +		NXP:
> +	    	SC16IS740
> +	    	SC16IS741
> +	    	SC16IS750
> +	    	SC16IS752
> +	    	SC16IS760
> +	    	SC16IS762

You broke the indentation (as it has mixed TABs and spaces).

> +		EXAR:
> +			XR20M1172

No need to rewrite all of them, just add your line as

	    XR20M1172 (Exar)

>  	  The driver supports both I2C and SPI interfaces.

(Note, this needs to be fixed, hence it justifies a new version of the patch.)

..

> +/*
> + * Divisor Fractional Register bits (EXAR extension)

Missing period at the end of the line.

> + * EXAR hardware is mostly compatible with SC16IS7XX, but supports additional feature:
> + * 4x and 8x divisor, instead of default 16x. It has a special register to program it.
> + * Bits 0 to 3 is fractional divisor, it used to set value of last 16 bits of
> + * uartclk * (16 / divisor) / baud, in case of default it will be uartclk / baud.
> + * Bits 4 and 5 used as switches, and should not be set to 1 simultaneously.
> + */

..

> +static bool sc16is7xx_has_dld(struct device *dev)
> +{
> +		struct sc16is7xx_port *s = dev_get_drvdata(dev);
> +
> +		if (s->devtype == &xr20m1172_devtype)
> +			return true;
> +		return false;

Besides what Jiri noticed, this has been indented one TAB too much.

> +}

-- 
With Best Regards,
Andy Shevchenko



