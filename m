Return-Path: <linux-kernel+bounces-67598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B0D856DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034DD1C2414B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0113A248;
	Thu, 15 Feb 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYG/qJMN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55F841A81;
	Thu, 15 Feb 2024 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026029; cv=none; b=Dt0zJzfUUSbUftY8MKTFDAiQKouQVPuJFeKsCkr1/7y4eZJBoNMoW5rnvr0mvmENcc6kDr5HQu6ReAu7+0BOLSVOrHdosyrH+vAMTY7lu4qdRHcZvrkW+kW7pmDjaNZXrlcCC10Bldm2RP/CQ3cr67em8HHuF0aGATq9SxqSuJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026029; c=relaxed/simple;
	bh=qLdn8H0HRBzthy+dj0BE8u7JRCMQcxy04vJ6ZPWUk60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRV/2MyLvwUoILozLs6qhuvd55oj5UR/fWgWUDvs7hh30ctwhVEXxU88zfXSe0Xx/tmvBRBLVD9VfOv+jz1Ik8txYcaTqVYydATTxJG1VrzSUgDaSsgnoyIRrApwl3RwHUVaKs7F1doFf2DpeUDwegKS03NdXnYwK3mZYMTE494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYG/qJMN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708026028; x=1739562028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qLdn8H0HRBzthy+dj0BE8u7JRCMQcxy04vJ6ZPWUk60=;
  b=gYG/qJMND6IZEUhFaTlrqKquKTTJpGsfwj7EA4J64HAyFpUKMeQANiCI
   /FJigisIEkoxAHx3torvX93rNj2+Y0oFeZUwxDFdoaiOYEsFNOwnXr5gh
   vBezQtouLxYOMxp5w/TFKh2mPwMUiUi+l9PdRIOCpa9Eh5IS3Av69JmcE
   fIAwI/KApz9tIVoRljdnk9HW1qLB9m2iP8v8Mj7eVUQsj6TyTx3qPaNFs
   eGfEEmm8Zp51+CMwQWt7kUoR2L+YTwyYTMWxbByMY9tX0mcRg2cBXqxht
   VLopto8VmWRmZJ00oCFPMtNoeOUTqV7TYovm5e1fQohH+F9916ufj4Jp0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="19558170"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="19558170"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:40:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="826457139"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="826457139"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:40:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raham-00000004sOA-2c4p;
	Thu, 15 Feb 2024 21:40:20 +0200
Date: Thu, 15 Feb 2024 21:40:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_bcm7271: Replace custom unit
 definitions
Message-ID: <Zc5opIrKD0UdXqrk@smile.fi.intel.com>
References: <20240215160234.653305-1-andriy.shevchenko@linux.intel.com>
 <7132d989-533f-47ef-803b-6001de3aff33@broadcom.com>
 <Zc5kTdkTqXEE6cA3@smile.fi.intel.com>
 <d4619f25-12d8-4f95-8e5e-e83516e8230a@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4619f25-12d8-4f95-8e5e-e83516e8230a@broadcom.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 11:27:39AM -0800, Florian Fainelli wrote:
> On 2/15/24 11:21, Andy Shevchenko wrote:
> > On Thu, Feb 15, 2024 at 10:35:11AM -0800, Florian Fainelli wrote:
> > > On 2/15/24 08:02, Andy Shevchenko wrote:

..

> > > > -#define KHZ    1000
> > > > -#define MHZ(x) ((x) * KHZ * KHZ)
> > > >    static const u32 brcmstb_rate_table[] = {
> > > > -	MHZ(81),
> > > > -	MHZ(108),
> > > > -	MHZ(64),		/* Actually 64285715 for some chips */
> > > > -	MHZ(48),
> > > > +	81 * HZ_PER_MHZ,
> > > > +	108 * HZ_PER_MHZ,
> > > > +	64 * HZ_PER_MHZ,		/* Actually 64285715 for some chips */
> > > > +	48 * HZ_PER_MHZ,
> > > 
> > > The previous notation was IMHO more readable,
> > 
> > I tend to disagree as we read in plain text "frequency is 64 MHz",
> > the patch follows natural language.
> > 
> > > can we meet in the middle and do:
> > > 
> > > #define MHZ(x)	((x) * HZ_PER_MHZ
> > > 
> > > and avoid touching the tables entirely?
> > 
> > I don't like the intermediate layer which hides the implementation of MHZ().
> > What does it do exactly? You need to look at the internals, with the patch
> > applied you immediately see that these are just constants.
> 
> OK, I suppose today's color is blue for the bike shed.

Sky is blue and sun is shining and I am happy person :-)

> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



