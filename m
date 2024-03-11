Return-Path: <linux-kernel+bounces-98667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D54EC877D98
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6985F28267A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0122261F;
	Mon, 11 Mar 2024 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRsr7VOw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C79617578;
	Mon, 11 Mar 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151514; cv=none; b=oz+yaA6vD7HnpdsHonBHS/MItyqjUoLpTw8jmqCiP2UIOxR6VO+nLzkt5HDK8A8O9tT/Th7dAYhuTiQ8yAuezfgDez+bOLlRZy8EglzyIDzJztEkiKtHGFjDnRaixkUNJZye7LolhaeHGge/XRO6I+3AGNEgwjmsk6XPWofV12Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151514; c=relaxed/simple;
	bh=9raTGoVduTplUkSs6V7+n3GxTuAcH/u1boii2ha37N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utzyBuy0dwG3P7gTzKdUF7ab7PnEVpNLgZCYKU5Nx/FFCOP4FZGisIru83Rm+d9S5sPWircDpK34bLf1tR4XqhJ69bmbZmgxlAYj6AJ/+m4gTVuRidQinfnXwAv9lSrutxnPHT65LbVlHmonYRIfAawxARloVD7EUVgZIaXiy6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRsr7VOw; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710151513; x=1741687513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9raTGoVduTplUkSs6V7+n3GxTuAcH/u1boii2ha37N8=;
  b=QRsr7VOwYZf3UscFLDdYxcaZRMDaYEOi09qorHoNcriN4/6rpI4QiDQ4
   NY9ExinXiB6Oc+8pm8dzyPnBcLTDdZ+3LEPTMxYWb1CcO8hAReUaMeA//
   EAIHtRJpWQcjWX3pfqTilAIKQ5Bt9YUxy/tjtRRy+TAJ/3uMcu1Sbo7ZZ
   YZbGZh5WPkBg62J8EpyROVK31xRR6ziB6G86YICPzJBsJTlzbCJ/swCvk
   Bs0q/r1qQFGzTvEeHcgWRgeZyr9O397AUrUtrUDJnWaaVWBfHHciDG3Pj
   x5LLCs/LQRaBfndDzn0F49UbmWdv9k6JAV9kWwxu3OgUpi2W++ZWnffbE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4941775"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4941775"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:05:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="914354556"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="914354556"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:05:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rjcWq-0000000BaT1-06VT;
	Mon, 11 Mar 2024 12:05:08 +0200
Date: Mon, 11 Mar 2024 12:05:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: Fixes SPI support for BMP3xx devices
Message-ID: <Ze7XU5JS8FF5FZdg@smile.fi.intel.com>
References: <20240311005432.1752853-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311005432.1752853-1-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 11, 2024 at 01:54:32AM +0100, Vasileios Amoiridis wrote:
> Bosch does not use unique BMPxxx_CHIP_ID for the different versions of
> the device which leads to misidentification of devices if their ID is
> used. Use a new value in the chip_info structure instead of the
> BMPxxx_CHIP_ID, in order to choose the regmap_bus to be used.

..

>  	const struct regmap_config *regmap_config;
> +	int spi_read_extra_byte;

Why is it int and not boolean?
Also, please run `pahole` to see the best place for a new member.

-- 
With Best Regards,
Andy Shevchenko



