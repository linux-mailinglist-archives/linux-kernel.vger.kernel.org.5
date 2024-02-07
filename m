Return-Path: <linux-kernel+bounces-56418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D20684C9EB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4228282A8F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0C1D526;
	Wed,  7 Feb 2024 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y65Fa4HV"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7C17BCC;
	Wed,  7 Feb 2024 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306524; cv=none; b=Zgb6/IkgWP+Y26Qqwl1R1hhxhtzMhF7Y8Zy0qmWnXmnHJU/VS2Jr6PI7afk7ePD9++hA9HaF0/ID7u/fcS92+KvJorDII7JZozF/tXmRaFiK69orIXoB6ffAYHqkLlpJeXpZLExNPCuuBtm7zOsVtqdm2XQ1jdtXoZeg8UNmKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306524; c=relaxed/simple;
	bh=cEVCU8sgbTnjA3CQHfC28Z+VysLJVqFFi3nqnWq3mdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dtsjf8aViJL6/pVHu+YxKg/l76WEfgPjhNuzkUf2479B+m2C/KFY5/paERJ8iz8EBgwPDIFAPE68a0XGv9LUbTZjTlKVohEUXdXaV4OctpbD+JUKSRugEfBrW7hT7IdMZOmp3eqvMHlKizwLCbVlx1FRixrL1Ehciopa8GPzu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y65Fa4HV; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707306522; x=1738842522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cEVCU8sgbTnjA3CQHfC28Z+VysLJVqFFi3nqnWq3mdc=;
  b=Y65Fa4HVKV8Ag6JiqyT0nUWg6XU6IF+lZN1o/WLy0uPrpio5jsQQZ1X6
   k/szNkEtMjIFKh4uhtE31CClci4Wf+3+vJt2ufnYBB8y/kPThbqLzCTEU
   EokzC+5+DDDGmV8tDjQqZNQdVB5wUmnJ5E/gFlWuWDSOWo9NzaRWA/vTx
   FJqKAxNxVGhEntWfL0sS3EgFDkk1XRKhFi7A9UacjhnO08lObRNg9ilhK
   9kSXxw6dC5XmBW78BN7NozJgyNIMfqW0m/pCn+fyLzOHOmAjmTkAZuYjW
   sTR45b+JyD9TUgPlorh1O1POnomboa+HHvQZMEu474IiN9jxZLmFQR069
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="395388525"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="395388525"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 03:48:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="933750096"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="933750096"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 03:48:38 -0800
Date: Wed, 7 Feb 2024 13:48:35 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] pwm: dwc: Add 16 channel support for Intel
 Elkhart Lake
Message-ID: <ZcNt83zD4H3hsCgc@black.fi.intel.com>
References: <20240122030238.29437-1-raag.jadav@intel.com>
 <20240122030238.29437-2-raag.jadav@intel.com>
 <ZbZqZDvdw-_D3hyb@smile.fi.intel.com>
 <ZbjPv_-S-6CQsaja@black.fi.intel.com>
 <Zbt__WmU74vmLpPR@smile.fi.intel.com>
 <Zbxo2b_TuCoSyhav@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbxo2b_TuCoSyhav@black.fi.intel.com>

On Fri, Feb 02, 2024 at 06:02:46AM +0200, Raag Jadav wrote:
> On Thu, Feb 01, 2024 at 01:26:53PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 30, 2024 at 12:30:23PM +0200, Raag Jadav wrote:
> > > On Sun, Jan 28, 2024 at 04:53:24PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Jan 22, 2024 at 08:32:36AM +0530, Raag Jadav wrote:
> > > > > Intel Elkhart Lake PSE includes two instances of PWM as a single PCI
> > > > > function with 8 channels each. Add support for the remaining channels.
> > 
> > ...
> > 
> > > > First option: Always provide driver data (info is never NULL).
> > > 
> > > Allowing empty driver_data would save us from adding dummy info
> > > for single instance devices in the future.
> > 
> > Which may be too premature "optimisation". Why? Because if we ever have
> > something like pci_dev_get_match_data(), the empty will mean NULL, and
> > we may not get difference between empty and missing one.
> 
> Not sure if I'm able to find such a helper as of now, but fair.
> I can change it in v2 if Jarkko is okay with it.

Hi Jarkko,

If you agree with Andy's comments, please let me know.
Will send out a v2 accordingly.

Raag

