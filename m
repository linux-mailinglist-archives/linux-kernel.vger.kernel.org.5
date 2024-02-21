Return-Path: <linux-kernel+bounces-74777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A866285D9C1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96521C2305E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AE07A715;
	Wed, 21 Feb 2024 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0NAnJST"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCDA763F6;
	Wed, 21 Feb 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521711; cv=none; b=UjoqtDqyCiYMXWH3XRdS/MeFvh35hCqVerDfneq9YB6TnpuDAw4MnTUgFROPY+6HyKDeU3vjH/RilOwCt4NVfANy90FqLH3u+/qGy7yx0Y0XeHwc3LdWoKaykSVUYkghFnXnp/eJXNmkJo4SH/LAwzGiv+cXaMYh5eZQ5SWlsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521711; c=relaxed/simple;
	bh=m8OXLkRSII1k4JsXdV2zR3nWembuP6BcMZNr+6VGExk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8VB8U2mvwr5OJD2h97JAYwIXLqH287ArzJNV9PyYNeSaIWIpK5oLQnFCnohDMFg+UrJmZrMXyoBHqCWOAaKMMf7+WAnw+rFbzGn7TlFqn9akoc8mC8ZZCMKTA/vR0ga+RvHiFmUZGtr7+zgboWDKDj+rtT4CR29dusOOtg/yAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0NAnJST; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708521710; x=1740057710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m8OXLkRSII1k4JsXdV2zR3nWembuP6BcMZNr+6VGExk=;
  b=L0NAnJSTFnmUayRgyy2b9JEa5xybac3lw9SGLl88ZWgLvMtYRD0HV59E
   +1ds/I9R/bxGr7dXN0n1FDn05gzWqOmmb+6G2E6slZfHfpr/yX+DmFGlZ
   2Km4FliVbBK+Cjk1LBQwOx6KjxDkboJHy31NSHDMGxw9VjyPt4bnpuvW3
   Rod1vFD9OKMWjjSjJ1ELW+Nki2pWHN24mC5wHte3y+oJYy/fNLyvM0O+Z
   dzfHukelcoTWCzI+LBBx9DtQuCdu5Utjgr8BEMq4fi0n+fTInOdPsi9uu
   ML+rZrDiwPommxaQWJQHLOL5CWtIjGcQI7WZhR/zS6xhQumqXMedNMB4u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6455128"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="6455128"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 05:21:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913302811"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="913302811"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 05:21:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcmXf-00000006MB4-46d9;
	Wed, 21 Feb 2024 15:21:43 +0200
Date: Wed, 21 Feb 2024 15:21:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
Message-ID: <ZdX45xqSlz1oQQ-R@smile.fi.intel.com>
References: <20240220224329.53729-1-vassilisamir@gmail.com>
 <20240220224329.53729-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220224329.53729-2-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 20, 2024 at 11:43:29PM +0100, Vasileios Amoiridis wrote:
> According to the datasheet of BMP38x and BMP390 devices, for an SPI
> read operation the first byte that is returned needs to be dropped,
> and the rest of the bytes are the actual data returned from the
> sensor.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(If you got tags in the previous rounds of review, it's your responsibility
 to carry them, in case code is not _drastically_ changed.)

-- 
With Best Regards,
Andy Shevchenko



