Return-Path: <linux-kernel+bounces-56648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B8F84CD2F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B705A28B883
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DC37F7C8;
	Wed,  7 Feb 2024 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G50tUKri"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8393C7E779;
	Wed,  7 Feb 2024 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317288; cv=none; b=F1mJC55lSz87/XCbanjoWnRADpJBr3TVyFfGnE04XfYJBWtLUDtJb1ZcDLDLDBGkSRuZCrfv9CxiOQArc6LlW0epoVDHutRTJGenGYuRBKgLC+lPGJQ0TeOo1mCn9G1k+rr/PTdS8Hx7YvgM983KF2ssKBhBiX+YlZjDPVFQthI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317288; c=relaxed/simple;
	bh=BKNP9vGvcUxiD10sWfb8N0pUD3IrC1mjd7jdcTMxLa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzxobUq3KS5Xu120snk7rtrWtqk6YGVOtADK8ouYV5gH2LAVraQuUc0Fr/be94nqaxaqEylh4A4Id9No6DHmr5SPGh5+DugsGox9LHwvSXb1lHTXqbmDLfMn710wGFICXpxM9SwMOcyDkuNF5P3HwMZgzNnTa4voZnxHiEDsYuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G50tUKri; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707317286; x=1738853286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BKNP9vGvcUxiD10sWfb8N0pUD3IrC1mjd7jdcTMxLa4=;
  b=G50tUKriOwNdRmLd/8jdyVh4QwAKSwosyepf+tt3mGA2SlgmmTBA3NPs
   RP50j7wHk6noVzU6oTj1+fvc1txCvAJttzgNlv9/k00xukVY2JGnpiK8g
   t4b0qToSCnvdGR0hHySIKZXyF+H2Ew8WqwSQtGGFSCQc38TssNg8Vw+Zt
   JlS1eZXvaLJdbOoX8F+wYsHuV4k1g/hZNrmHMz3xl52E/ReZWhYfRzmlu
   yJRuhoc8+oSol9avcvWjz/vhf4n3x9XTi4hmB/m1QpoiQoj2e9aI9aFNN
   jngPH6A7v9f480kemwK6SCNtIh7Z8MZs/xMMsWqXA2CqlNZNpduJNVvje
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="4866615"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="4866615"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 06:48:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="910010162"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="910010162"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 06:48:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXjDU-00000002dFR-1LRq;
	Wed, 07 Feb 2024 16:48:00 +0200
Date: Wed, 7 Feb 2024 16:48:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	akaessens@gmail.com, thomas.preston@codethink.co.uk,
	preid@electromag.com.au, u.kleine-koenig@pengutronix.de,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: mcp23s08: Check only GPIOs which have
 interrupts enabled
Message-ID: <ZcOYIBGfxdviQ1E7@smile.fi.intel.com>
References: <ZcDpDaclAXEa5ETN@smile.fi.intel.com>
 <0dab8d77-ea4e-4cea-99dd-2ffe7c9051d5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dab8d77-ea4e-4cea-99dd-2ffe7c9051d5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 07, 2024 at 12:50:51PM +0200, Arturas Moskvinas wrote:
> On 2/5/24 15:56, Andy Shevchenko wrote:
> > > Do you want that information to be added as part of commit message or
> > > information in the mailing thread will be enough?
> > Up to maintainers. I'm fine with this email. If Linus uses b4 to generate
> > a Link tag to this discussion it will be enough (in my opinion).
> 
> Is there anything left for me to update/change? Or we're waiting for other
> reviewers and/or Linus to chime in?

I believe we are waiting for Linus' decision.

-- 
With Best Regards,
Andy Shevchenko



