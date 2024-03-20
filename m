Return-Path: <linux-kernel+bounces-108818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B9B88106C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01A7EB23965
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC883BB4B;
	Wed, 20 Mar 2024 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UreR5Bqg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64421DFE3;
	Wed, 20 Mar 2024 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932835; cv=none; b=cir1P7yF/V9j2TKDHR58P/sv877tAQ3wh0nWObd5RWVyoOgBVgK+Hp64+9eah/TxGGbPic5QH0NZIUrCRMCMgbt993RYBJEQTiN5qRKx7BB9a4n773CNyjZ3/iOeq0rpxm94FA2tGO1188rvW+BUlS2Dk7B4rfME6I5MZi4xi/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932835; c=relaxed/simple;
	bh=s1PitjeZN8BPl9Z65wuXv90wyhRBBYc9kiquZ8XZNyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcN2esq+4uxsQFlwFxGInlFh7VdPu5kMxyeqfjJcVkcJxoB3fUJcjkjQzjDmmIDes4cq0ru4cDv32Tw4oKfh2aVlnPEB9cTIRm6JQvUE6IesJ8ttjTgvg4waNFythnNo+qlCPlR4XvAt9veBp5MteyRMHWulZA94XjuLbuZbxPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UreR5Bqg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710932834; x=1742468834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s1PitjeZN8BPl9Z65wuXv90wyhRBBYc9kiquZ8XZNyM=;
  b=UreR5BqgcffaBlVeKL99sYRrRJsTjzAW5rVEVvR49Qd5lHwntMgOhaDP
   PeaZO/wKIRlWvBHKucJIuFcMlNHJ9jnJKobS0zFuAGniTkrfsKkZ9Ibiz
   4kWuw+RJ1Boj3qzFgugol16z4qLSGY1qU6u33KtXMCTlfTDt/QCKwwTzV
   UGM7PlEQGiY1Vbo1ATwibFg2wvjbDHLjWPit6x4NNr/mumJi3uuYQq1KR
   yZFPUeHI3o7jy7Yd2sX8/Dtt94oPXLp/flOZgqXy0FW2nmAfEKrP3KgJu
   5yJ6PPlN+Ncw3kZgLswwbbcK85hcJDYaT5G94Zo1C8xPzgNLCet9Up9Rk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17295295"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="17295295"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:07:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="914663038"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="914663038"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:07:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmtml-0000000EY7M-2imR;
	Wed, 20 Mar 2024 13:07:07 +0200
Date: Wed, 20 Mar 2024 13:07:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: pressure: Add timestamp and scan_masks for
 BMP280 driver
Message-ID: <ZfrDW1ESxnFg__od@smile.fi.intel.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-6-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319002925.2121016-6-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 19, 2024 at 01:29:24AM +0100, Vasileios Amoiridis wrote:
> The scan mask for the BME280 supports humidity measurement and
> needs to be distinguished from the rest in order for the timestamp
> to be able to work.

..

> +enum bmp280_scan {
> +	BMP280_TEMP,
> +	BMP280_PRESS,
> +	BME280_HUMID

The last is not a terminator, please leave trailing comma.

> +};

-- 
With Best Regards,
Andy Shevchenko



