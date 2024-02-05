Return-Path: <linux-kernel+bounces-52760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14E3849C62
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101941C241FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A00E21370;
	Mon,  5 Feb 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWWPpcv9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A65222EED;
	Mon,  5 Feb 2024 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141397; cv=none; b=SdAPvVMx1WYXP7EIKbZTpD5l+ryhn5j1jPWJPMtXtGA0SA8o9mGEJft+cYN5g8WMcxe9Nalh14FGDSuLxRGBhkoDhxrlGW8Bpmf0xCCx8gRxIEy5PKkH5cDf1htbkVOhyR3iJ7hkTyLS5MAn4NccJDHwHBzx5O3uaippShBjFr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141397; c=relaxed/simple;
	bh=a9AWEeBnJr2boZUHp+YtnhfbRsyRm9DVOa26c/HAV34=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pHhsACzDtTi/c+XU1S2hqUgD7o6RIbOCollTwn0JHPSjd0LTHz5J8CCznBE6ktwXaiKRmaFsubiqR2MDqrBOSROOSlkpBiWav9mcDi6QWegj3/sta3aMOHymSVMr4sXYNNRgmUSqTrCM3+nEGQth35TnJVO/YKADil2+DwtQM7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWWPpcv9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707141395; x=1738677395;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a9AWEeBnJr2boZUHp+YtnhfbRsyRm9DVOa26c/HAV34=;
  b=nWWPpcv9RE+iaSflzp3fDgv9eO6UxQdQ4fsshcPMyNFbZepGGNQGy1OA
   V1UvjDTJv02YGRxVlMGfdeKUo5OfbX26jYuR5RZ2sreFLEW/Y2lAmiGRU
   zttjFGbFbmWQw6ty0NBvh9Akkl9RMYpJ69DBu7Ia83GDTU5iKf6LhO9+P
   vVgvMlEVqJdPNqvMjx71QP81AWEDskiJ4v/o3Vn0YJb7nT38kUAEzVQPe
   kH4OMiExbMMmdObQQuEVXRNqcIamcL0Oveku1B8tn9gkwE1XNB1YxlAdS
   xwUddhYu/tVAYzOGNGY52CRu+5Ry6uH4iq9s21sxIk2b+uJGnGPabHMfE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="432085"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="432085"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:56:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909301200"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909301200"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:56:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rWzSX-000000025xX-2xgV;
	Mon, 05 Feb 2024 15:56:29 +0200
Date: Mon, 5 Feb 2024 15:56:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	akaessens@gmail.com, thomas.preston@codethink.co.uk,
	preid@electromag.com.au, u.kleine-koenig@pengutronix.de,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: mcp23s08: Check only GPIOs which have
 interrupts enabled
Message-ID: <ZcDpDaclAXEa5ETN@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo


On Fri, Feb 02, 2024 at 12:40:23PM +0200, Arturas Moskvinas wrote:
> 
> On 2/1/24 16:30, Andy Shevchenko wrote:
> > On Thu, Feb 01, 2024 at 04:14:07PM +0200, Arturas Moskvinas wrote:
> > > GPINTEN register contains information about GPIOs with enabled
> > > interrupts no need to check other GPIOs for changes.
> > > 
> > > Signed-off-by: Arturas Moskvinas<arturas.moskvinas@gmail.com>
> > > ---
> > You forgot to add a changelog here, but no need to resend, just you can respond
> > to the email since it's not a big issue in this case.
> Ack.
> > > +	if (mcp_read(mcp, MCP_GPINTEN, &gpinten))
> > > +		goto unlock;
> > Do all hw variants have this register available?
> > Esp. I2C part, wouldn't it be problematic (exception with NACK on the bus)?
> According to specification sheets MCP(s0)17 [1] page 19, MCP(s0)18 [2] page
> 19, MCP(s0)08 [3] page 11 - all supported expanders have that register also
> that register needs to be used [4] to mask/unmask interrupts on given GPIO,
> without it - expander won't even fire an interrupt. I tested on MCP23018 I2C
> expander though but module itself is not treating that expander differently
> for interrupt handling purposes.

Thank you for the clarification!

> Do you want that information to be added as part of commit message or
> information in the mailing thread will be enough?

Up to maintainers. I'm fine with this email. If Linus uses b4 to generate
a Link tag to this discussion it will be enough (in my opinion).

> [1] https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP23017-Data-Sheet-DS20001952.pdf
> [2] https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP23018-Data-Sheet-DS20002103.pdf
> [3] https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP23008-MCP23S08-Data-Sheet-DS20001919.pdf
> [4] https://elixir.bootlin.com/linux/v6.7/source/drivers/pinctrl/pinctrl-mcp23s08.c#L473

-- 
With Best Regards,
Andy Shevchenko



