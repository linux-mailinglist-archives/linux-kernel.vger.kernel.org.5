Return-Path: <linux-kernel+bounces-81641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1787E8678AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E1128AE5B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84412BF17;
	Mon, 26 Feb 2024 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SM/85HFK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C312B15F;
	Mon, 26 Feb 2024 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958062; cv=none; b=ULhvtgl6IiIBwW4SBHn1Zbh+9/hPKCr7hKphTqfnGye5J9er2Rk4reydaRJD4eRxB1qbwJ39BeFgmr38BrjovUJRCulJVgZFgyzaFVjVOWM73ngSOTh2mnREH3enA7ArBUeH7NACOkMaxvXp5VPSRKCdnDGEwTLvf3QSu7QEbRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958062; c=relaxed/simple;
	bh=WlQKTnhGmfdIRVl371dmiB1JvtIJJJyuIdpi2MmNQlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxKr52ZrWlO7a5IlBR9UHNtSpYStu6wpdUjgMugvJlSda7TuhJ1qBYV0IHd1GKaKAinvyqA/AKKX42m0Ci6NAbVy630uKKwOOEN0wfK25ZyUtTP3BUY/DdP9JQ/EabOFc5pHz9iTX8HTW+D/MJSrqMWBSMO3gru2jvYgp1/hrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SM/85HFK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708958061; x=1740494061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WlQKTnhGmfdIRVl371dmiB1JvtIJJJyuIdpi2MmNQlM=;
  b=SM/85HFKLlouWIn9ygbaW2SKgGWwQ8TCoM1FX+zbEDd4Hryk+QyODVaK
   GnGIpHc0P+i9/GyXmSM9j4MWjf2PJweeryvUbAseSf8m2PYB1UnD8r4V/
   taEIu8OQ5Wx2OLwW4ya2zkImSQM9rJKiDFunKw6mBP4X7KxecCevwTVNP
   dzGSvaZfSVIehi6plKgm5OQeU40bdSN2gnHyx7PTQs1ekThcp5yuN/wgC
   48zZHSayCgnyJ5w2vj6d6S4UF3eMGY8xysdfDmKSvMkjiEsDIFjPJzy9b
   RYDx7wNR6HAGltpgRTtJJ1kT161db0lTKCwFvgeznC+rT/Gdcmp4Q0FZt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14679680"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14679680"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:34:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="913873357"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913873357"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:34:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rec3c-00000007hiC-1aA8;
	Mon, 26 Feb 2024 16:34:16 +0200
Date: Mon, 26 Feb 2024 16:34:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 1/1] leds: expresswire: Don't use "proxy" headers
Message-ID: <ZdyhaP3f2p5_ADbh@smile.fi.intel.com>
References: <20240223203010.881065-1-andriy.shevchenko@linux.intel.com>
 <ZdkGmE2HFxXpIonR@duo.ucw.cz>
 <Zdyf7y-nKy6ihciq@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdyf7y-nKy6ihciq@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 26, 2024 at 04:28:00PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 23, 2024 at 09:56:56PM +0100, Pavel Machek wrote:

..

> > > +struct gpio_desc;
> > 
> > If include tweak means you need to declare struct, is it ian
> > improvement?
> 
> Of course, we increase a build time by dropping the header that's

Should be read: increase --> decrease

> not used for the compilation.

-- 
With Best Regards,
Andy Shevchenko



