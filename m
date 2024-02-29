Return-Path: <linux-kernel+bounces-86572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E8B86C73A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA6F1F25CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6186B79DDE;
	Thu, 29 Feb 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrTPi1If"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3879DB0;
	Thu, 29 Feb 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203554; cv=none; b=HgbSry6TedQAJbA1Yz5NWbaviaQEzDoNdm0H2LVnfNkCnFOgsk64570FjtdoyJqTwfCqd8/GBWJpKy82e122VP0LqNN5Hgau5zPme91FeZ/C6ABXLmZQ342ojl2hb062FJFbcHmRyjUvVh0uXb/w0nLgqb4eOeO6dFQZzBk6pDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203554; c=relaxed/simple;
	bh=zNCU8bPfdsgAvaLe1ye6Hs5Kt2LyfDsod6rjLc8GSj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VogarKUWhJ5CT5IBZZ7gpvTqcg4eCayYqIkeJlAJgfog8/mBBS6JgTQPWS0TRJRdWfnAFuxQn8OLudjDGlyuDjvoxVubMEi79djqZgE6jQMEAEpsTB9UTzOyVGQpEiOPVcX2h8pQ0QcMeZu9L9Kyp7jN0Q0TcUQuYVooRUdPNh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrTPi1If; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709203553; x=1740739553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zNCU8bPfdsgAvaLe1ye6Hs5Kt2LyfDsod6rjLc8GSj4=;
  b=RrTPi1Ifwt9PhK/m2HDu4aqXuFOfq/Ag7Td6LF9//uPKWoNW815vHd/f
   gem+suSoYuQY3RgYcVhLqcUsAaaCdLYYPDEWeUb4gACpy56GcMnI/yENh
   GWD+qqQgNihOgzjwVefL+oocYJrr1wcxq6SrhSnL6xz7ESQ6BnR0GLQBG
   NUlX3NolB7JBY7EvWNxUEZIkSgZ8zmiXYBvIbktO5VeHhH0S05Jq9ptEg
   xcB3SBD0o8b1t+jY+ADSFBPAtTQglhS3EEx6qyeaeAfNVPdw0BDcJeAjT
   N2PR9P5fdm2rSIlMwjWa8XsBX9Jl0cf4P//yH383tN/RKUaJRUpYACtS2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21121570"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="21121570"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913978733"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913978733"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:45:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfdv9-00000008e1f-0QR7;
	Thu, 29 Feb 2024 12:45:47 +0200
Date: Thu, 29 Feb 2024 12:45:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, u.kleine-koenig@pengutronix.de,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpio: 74x164: Enable output pins after registers are
 reset
Message-ID: <ZeBgWnt8bleYVXJl@smile.fi.intel.com>
References: <20240229084555.43701-2-arturas.moskvinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229084555.43701-2-arturas.moskvinas@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 10:45:56AM +0200, Arturas Moskvinas wrote:
> Chip outputs are enabled[1] before actual reset is performed[2] which might
> cause pin output value to flip flop if previous pin value was set to 1 in chip.
> Change fixes that behavior by making sure chip is fully reset before all outputs
> are enabled.
> 
> Flip-flop can be noticed when module is removed and inserted again and one of
> the pins was changed to 1 before removal. 100 microsecond flipping is
> noticeable on oscilloscope (100khz SPI bus).
> 
> For a properly reset chip - output is enabled around 100 microseconds (on 100khz
> SPI bus) later during probing process hence should be irrelevant behavioral
> change.

> [1] - https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74x164.c#L130
> [2] - https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74x164.c#L150

Please, convert these to be Link tags, so

at the end it will look like

Fixes:
Link: URL1 [1]
Link: URL2 [2]
Signed-off-by:

-- 
With Best Regards,
Andy Shevchenko



