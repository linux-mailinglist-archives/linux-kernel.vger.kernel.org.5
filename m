Return-Path: <linux-kernel+bounces-102395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBD187B1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA3FFB3115C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E965A7B4;
	Wed, 13 Mar 2024 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdjSVanR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46D5A4D8;
	Wed, 13 Mar 2024 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356597; cv=none; b=VdQNoRw8vq1U4YlqzGUE37QZQLDpUcTd6e7EXMb6R7kIqxUQ6n+Jq8e70ece89UAE3PhABGWcooWJPKk1TGPI8Y4kojpOeL8iO8RgJUsYKyGECnFdnxXQsocC44yuSofknqabkpjZWdMx5HhVA2S4w5wjqZTeRdrnLs1TF6LqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356597; c=relaxed/simple;
	bh=Y3asIHRcfcnUNu8RRFRQdtWj1CUUVV8XA2p1BBBkpdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcF8yDNUhJRGS6emZgGG3iksMAk6lczpO0bjB1Z2cMX9BJIXj4q8IaG16ytsNuAvxyQ5sL96GovPqNqa6nprMVCbk6OlRnandfB6FMASZyA2yCioKUCWv/z2sokLVBvpCr3xGLKlv5CHA4aQpxZzed+gSkrFU8Xgxv24aAPEewA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdjSVanR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710356596; x=1741892596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y3asIHRcfcnUNu8RRFRQdtWj1CUUVV8XA2p1BBBkpdA=;
  b=mdjSVanRt4TwDwd37BqoFcnNJoF8P9ZMxR47wYkwrxWK9xhrukwhMmab
   kkPHeJVE6c8o2s1zc4bEkWANIw2HWtud5WtIX4mbUFEFcsngnn6OdLlRe
   f2epTzKySAR1FUzVDxizUVuOXIEt7A9m4YrMHMIHE2gtphVcN8ekDERjJ
   BOyOHSlClrooAWbdXDk9OYufP8qFTqx2/ygeXQ3tMVnN2pKn62EL9Ic+P
   pHAgr1/OC6550PPhBi3zWN9BieWODCYUwBWuiZljV0GtQjWj4OXjDMZ+F
   AtMF4gtLAESBhzo5eY98eSSpSIieGPFxDiWqLZ2OTEk/4+eGKrCkbw9xO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="15874085"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="15874085"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="914439293"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="914439293"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:03:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkTsb-0000000CIiu-0a3O;
	Wed, 13 Mar 2024 21:03:09 +0200
Date: Wed, 13 Mar 2024 21:03:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, linus.walleij@linaro.org,
	phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: pressure: add SCALE and RAW values for
 channels
Message-ID: <ZfH4bET-HX0e3PO_@smile.fi.intel.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-4-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313174007.1934983-4-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 13, 2024 at 06:40:04PM +0100, Vasileios Amoiridis wrote:
> Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW in order to be
> able to calculate the processed value with standard userspace IIO
> tools. Can be used for triggered buffers as well.

..

> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_HUMIDITYRELATIVE:
> +			*val = data->chip_info->read_humid(data);
> +			ret = IIO_VAL_INT;
> +			break;
> +		case IIO_PRESSURE:
> +			*val = data->chip_info->read_press(data);
> +			ret = IIO_VAL_INT;
> +			break;
> +		case IIO_TEMP:
> +			*val = data->chip_info->read_temp(data);
> +			ret = IIO_VAL_INT;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;

Is it mutex that prevents us from returning here?
If so, perhaps switching to use cleanup.h first?

> +		}
> +		break;


-- 
With Best Regards,
Andy Shevchenko



