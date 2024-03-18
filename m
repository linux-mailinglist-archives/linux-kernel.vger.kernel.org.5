Return-Path: <linux-kernel+bounces-105937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0627A87E6A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10891F22652
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0392D610;
	Mon, 18 Mar 2024 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WactNBc7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF8E2D03D;
	Mon, 18 Mar 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756226; cv=none; b=H8DgBmBjcmGPMZPy0ihmGl5OLkMjkRVtAdu1XjcY36nkHmLZ3feYsaxq1Va7QQexV7IcfWerPh+i5sr9N4Lsco22Qqbr67QpyfpnfNG/aZolKwXDm/hKPQF57dWP63rKjAyiImz518EHv+fviY+yAI8SpqP48I+DENFEqQJ8YPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756226; c=relaxed/simple;
	bh=xDlNMWqUTXTBM8em3VlJSfREj2/BL9qrToesVMEcMoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGjoh0PLhbiUcHTRKp9gQ6kLeKcwx8oZckhwmukXOGVR545fFFXcLzuO+IOMROm3PG+VTru663N7FXJHD+WugMoVYgyfJdCiLcO3Xmrcv2p6Rkdi4TUJ7ojdgH0mGWEoSJ7qo9/4NXukfpwYfKHMuiaZ8MO0zyDsYxh+yDObqp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WactNBc7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710756225; x=1742292225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xDlNMWqUTXTBM8em3VlJSfREj2/BL9qrToesVMEcMoI=;
  b=WactNBc723FWsyDwt6b5yZLza4dAx5hV7XKPcoGw1SbMQp3HGgRHblGX
   EaJEPZVgmoezgpzLS440qpXlvboeS/3V0DbCTwjd22yJ2YdgpF/rBtm7u
   qChIqlqSTUk3jfJ6kuRLhhe2QK1Ly/Hm6iqFnPMvtd54CWmSlnKwEB+fj
   6DEfNA36GZOp7QqyjWN8DGUPJ9MqTe/1ppi2m69OwGgF04ZgCEBRGUnKg
   9n0Vht+f5oBiHNSIJryD23OAtFBUmsZJnLfYK+TY9QeuQwJYxpE9XmfCN
   B5Jd7KBHLy+ORoI0XDeX9SdmUFc5a84mVytqy/Ei8kpR3UWuMl11D/IlV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5685231"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5685231"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="914587235"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="914587235"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:03:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rm9qE-0000000DuN5-1Kpj;
	Mon, 18 Mar 2024 12:03:38 +0200
Date: Mon, 18 Mar 2024 12:03:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_lpc18xx: disable clks on error in probe()
Message-ID: <ZfgReWkDIFnoUiCZ@smile.fi.intel.com>
References: <92646c10-e0b5-4117-a9ac-ce9987d33ce3@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92646c10-e0b5-4117-a9ac-ce9987d33ce3@moroto.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 16, 2024 at 12:30:09PM +0300, Dan Carpenter wrote:
> Goto the clean up path to clean up a couple clocks before returning
> on this error path.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for fixing this!

-- 
With Best Regards,
Andy Shevchenko



