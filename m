Return-Path: <linux-kernel+bounces-90522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB928870093
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7776E284CD2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBCE3A8C9;
	Mon,  4 Mar 2024 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZUDxhEb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E652539FEE;
	Mon,  4 Mar 2024 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552581; cv=none; b=rDV+UIiYnzJw4hIaBm/RXcezBrsa9vyc04ZvQK7djsIA7vhGYNJwoxJpSbAHBAqj6YsLfH3p7R4yoSZ/5QYLTowPy+/jQIBTpV4DVGqlntVhrn4f6SokT6fof81cvXhDzLlliDZPMXpNItoWd7jpslkAvks+3iZ5vP3076FuKn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552581; c=relaxed/simple;
	bh=0wECyTFNn/czi0BC/9vnk0G4cpXjt7XdbPGnqVO5lDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQN1z886iX9t7lqE4WCBs71FOVlEFPTQW/EVxzfNAoo/jYD7z15q+zMHODMaSyNa3w9ce7TZGaOO36sgpT9v4aoUEucDm/M932ttGs8AkykCjeTcoMGyG0Mlb4DCS0rXCcpTSssxjdQKCFeAZXNPRNyZ9qVVECdEff7uL0/z+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZUDxhEb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709552580; x=1741088580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0wECyTFNn/czi0BC/9vnk0G4cpXjt7XdbPGnqVO5lDo=;
  b=EZUDxhEbVhucUImwTXGpniIeOXpDbtZwIHA5dXWFZa3iZ4aucrl/MWzl
   14cbYEOKPgsUlK6MaCu++/iaV8YXMotNJVFop+zZESJ10+HQYG0DP3uiq
   /ympFcHDuSPTIJ1s9A2lTP2iOGry8n20Tr01BUUsj0SqcoK8w1WNc22IC
   IMv/uZiJHuO824gjrOZODRN/qZLdSSWQ7AIgu1bZUz6hbD/7QLaFnKX7s
   MYBqivF94hl5frwRk5J7FTjWayisx5hSsbX0zb4L9ptnMC4hPHXNbXAPz
   HrkZqUmBEEtce8Ru9gYtlMrOXdH6iruFoz4Ub7WhsD/r1453ddes99ZNw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7811175"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7811175"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:42:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="914103611"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="914103611"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:42:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rh6ib-00000009hhP-1kXc;
	Mon, 04 Mar 2024 13:42:53 +0200
Date: Mon, 4 Mar 2024 13:42:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: pressure: Add scale value for channels
Message-ID: <ZeWzvewAtqKKfnwI@smile.fi.intel.com>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
 <20240303165300.468011-3-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303165300.468011-3-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Mar 03, 2024 at 05:52:58PM +0100, Vasileios Amoiridis wrote:
> Add extra IIO_CHAN_INFO_SCALE in order to be able to have the scales
> for the values in userspace. Can be used for triggered buffers.

..


> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_HUMIDITYRELATIVE:
> +			if (!strcmp(indio_dev->name, "bme280")) {
> +				*val = 1000;
> +				*val2 = 1024;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else {
> +				ret = -EINVAL;
> +			}

No, just make these int arrays part of chip_info, then

		case IIO_HUMIDITYRELATIVE:
			if (chip_info->hrel) {
				*val = chip_info->hrel[0];
				*val2 = chip_info->hrel[1];
				ret = IIO_VAL_FRACTIONAL;
			} else {
				ret = -EINVAL;
			}

> +			break;
> +		case IIO_PRESSURE:
> +			if ((!strcmp(indio_dev->name, "bmp085")) ||
> +			    (!strcmp(indio_dev->name, "bmp180")) ||
> +			    (!strcmp(indio_dev->name, "bmp181"))) {
> +				*val = 1;
> +				*val2 = 1000;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else if ((!strcmp(indio_dev->name, "bmp280")) ||
> +				   (!strcmp(indio_dev->name, "bme280"))) {
> +				*val = 1;
> +				*val2 = 256000;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else if (!strcmp(indio_dev->name, "bmp380")) {
> +				*val = 1;
> +				*val2 = 100000;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else if (!strcmp(indio_dev->name, "bmp580")) {
> +				*val = 1;
> +				*val2 = 64000;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else {
> +				ret = -EINVAL;
> +			}
> +			break;

Ditto.

> +		case IIO_TEMP:
> +			if ((!strcmp(indio_dev->name, "bmp085")) ||
> +			    (!strcmp(indio_dev->name, "bmp180")) ||
> +			    (!strcmp(indio_dev->name, "bmp181"))) {
> +				*val = 100;
> +				*val2 = 1;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else if ((!strcmp(indio_dev->name, "bmp280")) ||
> +				   (!strcmp(indio_dev->name, "bme280"))) {
> +				*val = 10;
> +				*val2 = 1;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else if (!strcmp(indio_dev->name, "bmp380")) {
> +				*val = 10;
> +				*val2 = 1;
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else if (!strcmp(indio_dev->name, "bmp580")) {
> +				*val = 1000;
> +				*val2 = 16;
> +				ret = IIO_VAL_FRACTIONAL_LOG2;
> +			} else {
> +				ret = -EINVAL;
> +			}
> +			break;

Ditto.

> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		break;

-- 
With Best Regards,
Andy Shevchenko



