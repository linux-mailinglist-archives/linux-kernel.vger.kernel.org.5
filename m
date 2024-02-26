Return-Path: <linux-kernel+bounces-81726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E806A86796D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70AB828E911
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB24E130E30;
	Mon, 26 Feb 2024 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kg7bI7tw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F1130AFE;
	Mon, 26 Feb 2024 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958562; cv=none; b=FvVH//cWQL1bYLeUUR8+LRd2DQ/ssvgS5kz0rBzhxyXXBkV+8dPPbBzPr5fy3rPOAokpx+zs0sTNX9ehWhxpq+cuxaalEtSPTLt13oq5cH5TB3JC48tdXMtiVL5D0uLL801gLrx8LucgI0t2S9pxKDrNfeEmZh+e03PN/vI1/Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958562; c=relaxed/simple;
	bh=EUJ5esbYjUapXTYbha5kyIY8tScY0s/JJFha6imEgQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP5jL/Ocdyg2XHLHbOPIYr4tOm0YOptpd9wJi+Lyv/BH7hCKZBdbIE5HKJNDL9oq4rmx4EpYzB4mN7YgvjF8KQSoROXk2t6QJOqwBdvjM87bkHHMZI5HK4DpD7gYFNDFaSKsT78ZMGCOrxK1RnwlVPIVA1R9gpmsB8NZJbADSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kg7bI7tw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708958560; x=1740494560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EUJ5esbYjUapXTYbha5kyIY8tScY0s/JJFha6imEgQw=;
  b=kg7bI7twSo5akob+eL+2IaLeV0Hp/4T6NYaBS2vnzYKYKnC4hyi6egRT
   ag92cAWy76a2BjePoXWCe/DUq/4RTnJXHbylSnDZTXb5CJRhVvEM8e18i
   KyNC9u7WqffSe9Bh37GKWLw/1r4FuQPD+l5USj38y8QqXxSMgATsZ0+gN
   uK9Uje15xhJI1rcNmxc4GzwcWDDO4KX2GsxrfhbvEfqYW5VfFp4XsTd7M
   OHl++vADp02Wa8dOPPsZr0AgZZl+4eeoMMEIt/CruQK1SQeT+QaQ/AtWq
   umhQa4w85pNw74d5Kk7UHAmIB3J5iSz78L2Od0phyFom+8v6emx5NxBnH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14681144"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14681144"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:42:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="913873886"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913873886"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:42:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1recBd-00000007hqk-1zwX;
	Mon, 26 Feb 2024 16:42:33 +0200
Date: Mon, 26 Feb 2024 16:42:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: nikita.shubin@maquefel.me
Cc: Hartley Sweeten <hsweeten@visionengravers.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 23/38] input: keypad: ep93xx: add DT support for
 Cirrus EP93xx
Message-ID: <ZdyjWVwYRfASc38I@smile.fi.intel.com>
References: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
 <20240226-ep93xx-v8-23-3136dca7238f@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-ep93xx-v8-23-3136dca7238f@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 26, 2024 at 10:30:19AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> - drop flags, they were not used anyway
> - add OF ID match table
> - process "autorepeat", "debounce-delay-ms", prescale from device tree
> - drop platform data usage and it's header
> - keymap goes from device tree now on

..

>  struct ep93xx_keypad {
> -	struct ep93xx_keypad_platform_data *pdata;
>  	struct input_dev *input_dev;
>  	struct clk *clk;
> +	unsigned int	debounce;
> +	uint16_t	prescale;

In case you need to send a new version note that the indentation of the fields
is different here. Also uint16_t is not the type we expect to see usually
(does the file use it already?). In kernel we have u16.

>  	void __iomem *mmio_base;

-- 
With Best Regards,
Andy Shevchenko



