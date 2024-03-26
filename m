Return-Path: <linux-kernel+bounces-119880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FB088CE1E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6B2325BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C7513D2A3;
	Tue, 26 Mar 2024 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZxCJKM/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8435BACB;
	Tue, 26 Mar 2024 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484277; cv=none; b=TYy0FdQTJ8M09FCkD7FAWpQRVd+WO7Yl3lIPcgqW+sAZzSK4CbNRtT0nHV1ILxOSRC4g8jYUyrG+NPDGlqO0zFapoHitTBAT+XRFNNiDELcE3Mq8SV1+B2xw+nfzr57bD2m78c6odBnfdSO/hU0yn0nBBajtYmV67WzeXQaRkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484277; c=relaxed/simple;
	bh=fUHj783vc0K9GP4jaZXuZSKf7EgnYra/4cyV3SFRVFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qShYanVlzzqwWLQY+aNpxdWEln8xtyiuVedCTDpQrehnyqFOLgxIsKkky/5/09LT9ilkptAfz87sRU9UwGP4HBKRlKz4AIJ/IyOVfHrcU0ve63xFP8SpmzV8unMZT1S7WRcZY7eCEzYOe4FRX0DNl92ERkYC3wdlgZfJeHprUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZxCJKM/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711484276; x=1743020276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fUHj783vc0K9GP4jaZXuZSKf7EgnYra/4cyV3SFRVFw=;
  b=nZxCJKM/9T9lK4dqhoq+NREVc6BrE04XyF9VrW+zZxQWgkQlHicp1nng
   jSr53EPrcqoMGEecwnvdfnpksOE7SMqKx9tGWqaFBcLciv7rxOQyrV/jc
   VgT1kNsCWVb+aQog2A0u5GZ+EILyKUIsETac0VHH6poIGqZAzza4aqDL3
   wGVdgyTJ5csT9psKrSp3pS38kB/YWOolieHvO41MD3u0gKfZ7WCmayLfU
   iSrBfXXD7QtcnHr6Ib3IGRDv1LQkexPetsFhic5VnAMb+2Jl6tK1YD4rp
   KiIe0o6+sQkyYbOMP0NKdTVy1BtwFnSbPnUqLPa0SDbaGnOBw9XT2LnED
   Q==;
X-CSE-ConnectionGUID: pp9P6+o4QTKdDYutQPVl/Q==
X-CSE-MsgGUID: I4E3rUncRk2RvAPcRYQzfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6770286"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="6770286"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:17:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914889770"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="914889770"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:17:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpDF1-0000000GRfq-05Jd;
	Tue, 26 Mar 2024 22:17:51 +0200
Date: Tue, 26 Mar 2024 22:17:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
Message-ID: <ZgMtbn3luybjeOrY@smile.fi.intel.com>
References: <ZgMSg5Tr97mWgPW4@smile.fi.intel.com>
 <424de3ed-f0ea-4fc1-80f5-3ab1d23cf1e1@sirena.org.uk>
 <ZgMXe4EMbJ44W1tr@smile.fi.intel.com>
 <c3066481-bac6-48fd-8b38-6797975d83c2@sirena.org.uk>
 <ZgMZhdsDc-bzWa6P@smile.fi.intel.com>
 <4241ecb8-07e4-4613-a289-4699c39d0d08@sirena.org.uk>
 <ZgMf5eISwE2P_1tN@smile.fi.intel.com>
 <a30da48d-f801-4d0a-9db7-9c9bb159ca6b@sirena.org.uk>
 <ZgMqW6TSHYJ2NOPq@smile.fi.intel.com>
 <ccb80185-0862-4d84-a0bf-0cc349a609fe@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccb80185-0862-4d84-a0bf-0cc349a609fe@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 08:12:09PM +0000, Mark Brown wrote:
> On Tue, Mar 26, 2024 at 10:04:43PM +0200, Andy Shevchenko wrote:
> 
> > There is currently a dependency among others PCI || ACPI || COMPILE_TEST
> 
> > From the point of view of the real platforms it means that if there is
> > a PCI compiled we support PCI devices that use this "platform" driver.
> > Similar with ACPI.
> 
> > What you want is to hide this in the menuconfig for the irrelevant platforms
> > which have PCI _or_ ACPI enabled, correct?
> 
> > But if we add x86 dependency to that, it will drop the support for non-x86
> > ACPI-based platforms with this device. I have no clue what are those.
> 
> Given the history I would be surprised to learn of any platforms that
> have used this other than PXA, MMP or x86.  It's possible Intel shipped
> the IP directly exposed on a PCI card of some kind but it'd be pretty
> surprising given the way it tends to get used and the idiom for PCI
> cards, Marvell having done that would be even more surprising.  The x86
> uses I'm aware of are integrated into the chipset rather than something
> meaingfully separate to the SoC.

Okay, do you want to have an experimental (that we might revert in the future
if any regression being reported) patch to narrow this dependencies as I
described above?

I can prepend the v2 with a such.

-- 
With Best Regards,
Andy Shevchenko



