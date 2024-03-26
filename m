Return-Path: <linux-kernel+bounces-119791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFAF88CD07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A091C654C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E0713CFB7;
	Tue, 26 Mar 2024 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNe1RS37"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596113C9AA;
	Tue, 26 Mar 2024 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480878; cv=none; b=lsPlllmJIwgWqACN35ACkRsHCUYSCQwEGfAEupF3I5OEZg2kipNZZcmdYhHUCNIx9Rbp2NfV9WlqTBc/to9A/KYhdTxPrwG0zsIUQTRxUu360BKqfG0fghE8hKy2zjOuJI3Tkw4wLkwCp1Ukig6zdQTytLCaA/sOO93Dr9MUtjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480878; c=relaxed/simple;
	bh=y8cQuOZ4dlJ8bbEO6d3PWj+z80CIABXFOXhnbN/3Gvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSIKfO7DMkk+o7iMx3ni8N5FdqVV1vlAJ8IuXPvJy9FFttzOPMESs5xLbEWvwapyQ9X1srM3N9JRvQynioMC+1WQ79agqW6WRgjCrNOMsm8QvxEKQ2VuAIMk4u59J6pWREeBbWJ3tjytt2d2XSwDZKOwhcoxQ9iOh/LhXVx5nCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNe1RS37; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711480877; x=1743016877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y8cQuOZ4dlJ8bbEO6d3PWj+z80CIABXFOXhnbN/3Gvo=;
  b=LNe1RS37dxHoijxLAhU1G4XPpedtPvS5QPhXGxJ3SVagV+0KEdzSHFtd
   yUITm3tDShTv11hPMieMxY3LC9dAjBvGsAUZZvtJGDaZ8ux5hp57/1Rxa
   oC6FtgLBFOxudD0EzYGsSSkxCE13XjL0xPCH/tUTWDgPeKdHJtqD0feqr
   cwW2yB9p34GJGdFbp7Peo/avv8NtCSEFHg01imFlKuyGxEFTvBuwf2iIp
   fESnEjeSG+S6wVJaIA/S8t4w4ajOEDTUgjQpQXYj83+dUhuASYJXpboOc
   kqJhjz3PtrvhvHxYvnjfBA43YatMU1AGszVvUV0b5IymLLNtyQB66mHBI
   Q==;
X-CSE-ConnectionGUID: aKBnjGQZTyi6TTE9bB61hQ==
X-CSE-MsgGUID: UypJvpNISN6lLgK7t0h2xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="29031155"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="29031155"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 12:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914888468"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914888468"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 12:21:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpCMB-0000000GQwq-0D3z;
	Tue, 26 Mar 2024 21:21:11 +0200
Date: Tue, 26 Mar 2024 21:21:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
Message-ID: <ZgMgJvlXpkN0gPdN@smile.fi.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-2-andriy.shevchenko@linux.intel.com>
 <14f08a50-edef-4b36-891e-2b4b2283f40c@sirena.org.uk>
 <ZgMSg5Tr97mWgPW4@smile.fi.intel.com>
 <424de3ed-f0ea-4fc1-80f5-3ab1d23cf1e1@sirena.org.uk>
 <ZgMXe4EMbJ44W1tr@smile.fi.intel.com>
 <c3066481-bac6-48fd-8b38-6797975d83c2@sirena.org.uk>
 <ZgMZhdsDc-bzWa6P@smile.fi.intel.com>
 <4241ecb8-07e4-4613-a289-4699c39d0d08@sirena.org.uk>
 <ZgMf5eISwE2P_1tN@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgMf5eISwE2P_1tN@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 09:20:05PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2024 at 07:10:09PM +0000, Mark Brown wrote:
> > On Tue, Mar 26, 2024 at 08:52:53PM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 26, 2024 at 06:49:58PM +0000, Mark Brown wrote:
> > 
> > > > > > > > I think the ACPI dependency there is as much about hiding the device on
> > > > > > > > irrelevant platforms as anything else, might be better replaced with an
> > > > > > > > x86 dependency though.
> > 
> > > Oh, oh, my bad I missed acpi_dev_uid_to_integer() call.
> > > Okay, with that in mind it's functional dependency for the ACPI-based
> > > platforms. Do you want to keep it untouched?
> > 
> > That's not actually what I was thinking of (please read what I wrote
> > above, like I say I was thining about hiding things) but surely if that
> > was a reason to keep the dependency it'd need to be an actual ACPI
> > dependency rather than an ||?
> 
> For my knowledge there is none of the ACPI-based platform where CONFIG_ACPI
> needs to be 'n' while having the real device (as per ACPI ID table) to be on.

to be on --> in a sense of "to be present".

> That's why I answered purely from the compilation point of view.
> 
> Personally I see that dependency more confusing than hinting about anything.

-- 
With Best Regards,
Andy Shevchenko



