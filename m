Return-Path: <linux-kernel+bounces-73627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1816785C546
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0CD1C21D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E07114A4C3;
	Tue, 20 Feb 2024 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsXFZogO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A537142;
	Tue, 20 Feb 2024 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458983; cv=none; b=W0mesEV9lL67+I9H/qHSpGsYvT703Kv3s/YzDj6HzW49EWprSE1SrEDxi+NqXZJdpszzIIsNhpHXABfSAmv8RxLWwzQ1x10B/YcauJat1XzVg+/y+bYwU59elDKJ6IsxDw6MAlsyvBmeKdhDO/ZSnQZhguXA9N5ZOXC6BCCGN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458983; c=relaxed/simple;
	bh=gty/ttCJpjM5GViKv+40dtWMBwRDV0JamboFHl95rPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tajgzc2DriboSg3cBiNxgVHzWPi1rFiZ5VnZC6Tvh24GoOGRI/4RanuOaHNe3acmzwClAuZHbv2HqtYRnbGwoY1luX39dzGl/miewU3PKcaTIRaIBPCDuwyGSAFYkzyv59zlP6ZqCxBsVCFiHZPBoutrtMvmJ33BTlmNeICXfVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsXFZogO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708458982; x=1739994982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gty/ttCJpjM5GViKv+40dtWMBwRDV0JamboFHl95rPE=;
  b=VsXFZogOJHDWQ6CP24WcWUgvSC2V2CjRzoqaqNW+3WVIhIM6mLarXlHu
   Eib5nCOoBaXrHLwKjst6VpRsAdH5iiJaUhP3tLQFYbLdCWr/1VfdavG2I
   VOBF+2X9PEx7nl9FY5VeuGyN9EorZV67pE4zIPMRKViICooklzl8yxj+h
   mj55Fvxx9aZbAR4jZlRIXkjMwO0w3rfkg05Q0NRTPz9HDEk+M9qoVdZOJ
   F65gzaueuRmGu9xPZmpnmt1isuooaZmKH940u06ntKpm1+jxFe4nZm0Yn
   mNhmJzjUgqTCLrqZAAl/uodXv7cweKoDCIkbg3S4QmAj3nOaCEw2EB1Le
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2728632"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2728632"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 11:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913134696"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="913134696"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 11:56:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcWDw-00000006BPb-0WYl;
	Tue, 20 Feb 2024 21:56:16 +0200
Date: Tue, 20 Feb 2024 21:56:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: iio: pressure: Sort headers of BMPxxx SPI
 driver
Message-ID: <ZdUD3yI7I7uj3Nhp@smile.fi.intel.com>
References: <20240220184125.32602-1-vassilisamir@gmail.com>
 <20240220184125.32602-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220184125.32602-2-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 20, 2024 at 07:41:25PM +0100, Vasileios Amoiridis wrote:
> Alphabetical sorting and separation of headers for the BMPxxx
> SPI driver.

..

> -#include <linux/module.h>
> -#include <linux/spi/spi.h>
> +#include <linux/bits.h>
>  #include <linux/err.h>
> +#include <linux/module.h>
>  #include <linux/regmap.h>

> -#include <linux/bits.h>

That's what I meant. Please do not add it into the wrong place to begin with.

> +#include <linux/spi/spi.h>

-- 
With Best Regards,
Andy Shevchenko



