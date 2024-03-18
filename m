Return-Path: <linux-kernel+bounces-105993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCAC87E737
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500AAB21E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60E23FBB7;
	Mon, 18 Mar 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OD5+3XBF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03D2E630;
	Mon, 18 Mar 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757238; cv=none; b=U0AxJ4Lj3uE7wt3RaF83RxMXzWdLw+CAL0JJybYevy7yEv089mrP2exYDQkNb+iqcgK/R6zGpxkvgn2H9KqOn5luV0z9BbSJJ9mVkldT78GGMjeHrNC1YfUwnS0OjhBk8J03vnZc8g79RrOuSi3BO6cZrsv/Aron+ngAuXaDoJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757238; c=relaxed/simple;
	bh=j9hJYP8DK3w/3Tegkw2PNvElGryXR1mvuoyceP9Cxq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7NcbNAcFgMTr+G1jRWbZ3Hgy8ZqpieAr1M0MOChjXf46eCl0fLoV/qZKa7KXifGEEoZBqrd/EULzuMYl2ksbwDtL2Dfi2j24CJCC02JKs4/55XSgIUVXrWUPAKZIQkmqSVqCzhErGo7WXFGaHQ/PljbbRwkBpgYCf2tJ5dTKhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OD5+3XBF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710757237; x=1742293237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j9hJYP8DK3w/3Tegkw2PNvElGryXR1mvuoyceP9Cxq8=;
  b=OD5+3XBFCV1y1Adlh9krWpRlDRwUDYtqRESdQLxOnutKGsJ3xQdvyKIn
   dfco6FGSf80EL7alq/gn/nunrBnIPRAroOQLOSLd/lqVWeJklBkXpH3Qm
   AJQvlZV2rRsAw4H7WFBSurElK6fnBlUqj3lR3/NwyIrAXTwa7miEszc1B
   hHEqFzO49Bwwm/DBeiI5EpNGlWMdnnv/cgym+KKlXF9HO1fNGDqsXHaJO
   XAIRK2o6RkB5dg9YNk2A559SKD2j5cbeOMazZq8Q9yu2MtbGPX7f1W4JB
   XdWL5clJX7AxOYzYW5rvEUHzaCbzDSm96plyg8zWgVWEjqFx4Wvqcz1oP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="17008228"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="17008228"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="914587692"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="914587692"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:20:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmA6Y-0000000Duax-263H;
	Mon, 18 Mar 2024 12:20:30 +0200
Date: Mon, 18 Mar 2024 12:20:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] backlight: mp3309c: fix signedness bug in
 mp3309c_parse_fwnode()
Message-ID: <ZfgVbraKN1-Xtj3v@smile.fi.intel.com>
References: <74347f67-360d-4513-8939-595e3c4764fa@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74347f67-360d-4513-8939-595e3c4764fa@moroto.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 16, 2024 at 12:45:27PM +0300, Dan Carpenter wrote:
> The "num_levels" variable is used to store error codes from
> device_property_count_u32() so it needs to be signed.  This doesn't
> cause an issue at runtime because devm_kcalloc() won't allocate negative
> sizes.  However, it's still worth fixing.

Agree.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



