Return-Path: <linux-kernel+bounces-49164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA88466B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E597289794
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E080AE57A;
	Fri,  2 Feb 2024 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjvPAcHA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F9E549;
	Fri,  2 Feb 2024 04:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846569; cv=none; b=ajVtwGfhpTUpDWl5uOr0pT7KnvD00pPY62vQg015Ql6JFVI22Hlm9gfc3j2HeLtQwoGKHEakn9nftv1JW1/ZZZHZPKdRBmIRyfjsOlIZijcINQx2YTW1NQUkNRtquogH5op/1Qg7RGE93RxkcJnh8QVVgbWFgLghgWn4CarFdPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846569; c=relaxed/simple;
	bh=ztSIav3KcBwz0bNVUufr2e/T3sJdFopKr7MY53JdyKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEOxmSwJnt/B807cMpja7ZmZgfMxycZfLEEAuOcMFBf81qkKJeStZ6eL82jVJJftBpOCPunav5t9KqHjqO9VbxRlyabLzQduWrW7Q1cOwqLhoBGPFXTkcfnRAOX0qlroWs0azvGZKJJPRN06FTnVOWJi2qa6ZCROPT1OExM8A3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjvPAcHA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706846567; x=1738382567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ztSIav3KcBwz0bNVUufr2e/T3sJdFopKr7MY53JdyKE=;
  b=jjvPAcHAnWCJULGMkVjmxcv8wgnvpyrHB5x70QDoN6aoy9E56DzvrSeo
   h0sM9RESs5BSExdOENo5d+pwDSsF4HxfVB/DR+WhHU7VpvlfyEV9R/AqC
   8usiYi4NH/YcVZk55Kv5l7/hBJXcxGHsjZ/qJzJ6fFrWkmKMZxN8VwCf/
   8efAY07NwXRoDruKz+8Anb8pHhQifGO+RKlAktjnrBICenNBP8irAGli6
   8riAEH0AFfeGUP69KQt4nbemPFZ67ITU/UHO6+gcFxAprOMOKH+SSW+b0
   bhdsb3d5ejOjQjdtrt0+LMz6R9EtQ96agMevKjvj15L6ci3kBAPCjIxtx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="22570508"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="22570508"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 20:02:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823119684"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="823119684"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 20:02:44 -0800
Date: Fri, 2 Feb 2024 06:02:40 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] pwm: dwc: Add 16 channel support for Intel
 Elkhart Lake
Message-ID: <Zbxo2b_TuCoSyhav@black.fi.intel.com>
References: <20240122030238.29437-1-raag.jadav@intel.com>
 <20240122030238.29437-2-raag.jadav@intel.com>
 <ZbZqZDvdw-_D3hyb@smile.fi.intel.com>
 <ZbjPv_-S-6CQsaja@black.fi.intel.com>
 <Zbt__WmU74vmLpPR@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbt__WmU74vmLpPR@smile.fi.intel.com>

On Thu, Feb 01, 2024 at 01:26:53PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 30, 2024 at 12:30:23PM +0200, Raag Jadav wrote:
> > On Sun, Jan 28, 2024 at 04:53:24PM +0200, Andy Shevchenko wrote:
> > > On Mon, Jan 22, 2024 at 08:32:36AM +0530, Raag Jadav wrote:
> > > > Intel Elkhart Lake PSE includes two instances of PWM as a single PCI
> > > > function with 8 channels each. Add support for the remaining channels.
> 
> ...
> 
> > > First option: Always provide driver data (info is never NULL).
> > 
> > Allowing empty driver_data would save us from adding dummy info
> > for single instance devices in the future.
> 
> Which may be too premature "optimisation". Why? Because if we ever have
> something like pci_dev_get_match_data(), the empty will mean NULL, and
> we may not get difference between empty and missing one.

Not sure if I'm able to find such a helper as of now, but fair.
I can change it in v2 if Jarkko is okay with it.

Raag

