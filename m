Return-Path: <linux-kernel+bounces-90534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BB88700CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2AE1C21610
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABB83B29A;
	Mon,  4 Mar 2024 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BoH2vG2C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D363A8D8;
	Mon,  4 Mar 2024 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553134; cv=none; b=NS+SbB9+ekuV1vQj3BNaowDjcxbUEbbHVy6OxKH6N3VfMp0iqz28PXjCIHXUmWkW/GbyYbk3zDcyLXgDRhb3n5DsVsk4h+sVSa8hurXRHVmJZKqlKeiqhNYw79TJf90rdMDwbU47ubtcX3N73XKjIWME1a2EHfHkyZSdOmabSjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553134; c=relaxed/simple;
	bh=2hICw3jHmTAeqnoKhRbbNvhCs51NgKtPkklLxtlGNHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0x5rdPzcEWEkDg7UYVEXK3SHRkUA9vbNzcx+tAQ4/yWawo/Ub5fL0Vpmy/gqDteGYCdzQPSDl0NV78nXtb0GdkkvPg2Q9w5iOX8kDmsFh3N9RSsqM0oarSyg0Ka5hX8ghaLm+gZJMBVkP8hok8RDzjYroa4t4tcQyQ+IzGSVTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BoH2vG2C; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709553133; x=1741089133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2hICw3jHmTAeqnoKhRbbNvhCs51NgKtPkklLxtlGNHk=;
  b=BoH2vG2C9p6H/glx1fczNDoe3EcD0vrWMYXK9w3C67mip0ML4Fj4ZClv
   avFv59RwiRLfUPfbMciQJrauxGzlzHEnBqQ5mDSntpOt9izxUyFo7e0m8
   R95Q3tcihvF+O41D/L9CXnvEFNib2DTAS8GdpKpjqpiEq7v+KYJoDnz6k
   LaoIE9VsMzUM2tn33+i/fGl5Vjluh8It2rW7iwWP8LqQC8whS2a5a8aox
   9hXwRsO7fU0jGL0nyZ5+L46txgfsMb1mWJPLqxpEPD3Vzy7biD8KOHL1M
   00YZMf+gBuveDivEM5AbHVZPGe9ScTxU+KUPqFfd8iTdfgatZc4u2G6tn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7811955"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7811955"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:52:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="914103838"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="914103838"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:52:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rh6rW-00000009hom-0EuS;
	Mon, 04 Mar 2024 13:52:06 +0200
Date: Mon, 4 Mar 2024 13:52:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <ZeW15Q2juyQuTw5q@smile.fi.intel.com>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
 <20240303165300.468011-5-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303165300.468011-5-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Mar 03, 2024 at 05:53:00PM +0100, Vasileios Amoiridis wrote:
> Add a buffer struct that will hold the values of the measurements
> and will be pushed to userspace. Modify all read_* functions in order
> to just read and compensate the data without though converting to the
> required IIO measurement units which are used for the oneshot captures.

> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>

Yes, taking into account the comment against patch 1, this will become the part
of iio/* group.

..

> +	/* val might be NULL if we're called by the buffer handler */
> +	if (val) {
> +		*val = comp_press;
> +		/* Compensated pressure is in cPa (centipascals) */
> +		*val2 = 100000;

Here and everywhere else where it makes sense

		*val2 = CENTI * 1000; // (What is 1000 here?)

from units.h?

> +		return IIO_VAL_FRACTIONAL;
> +	}

..

> +	struct {
> +		s32 temperature;
> +		u32 pressure;
> +		u32 humidity;

> +		s64 timestamp;

Shouldn't this be aligned properly?

> +	} iio_buffer;

-- 
With Best Regards,
Andy Shevchenko



