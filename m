Return-Path: <linux-kernel+bounces-102398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8860C87B24B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C2BB314FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B895D749;
	Wed, 13 Mar 2024 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1k1/LSl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782264DA13;
	Wed, 13 Mar 2024 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356694; cv=none; b=QnLmcDvhOkHrStH4Rxb2HMyApd3lUFdoATicegFVz2utWoIq9RlF55ksh7ly1PfJiTpXJxuyandu3PQ2qU/eEyZVFWGlNFcbuemUZ1xiic9rXSwSUkt7ZPVjRyqEFoSDU6KnWE0F1bSHSDFKxya0PYZeMSky2dJiy5InR9GxXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356694; c=relaxed/simple;
	bh=VPdzAc0FsDDvBJDK1XggBVHga4+fDQhGH/tMKavFcXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXJusb9gT5eE2/QFLvZKm56AADPgFLxjxWGUMZJeCWfpHLd60Z+LgfpLX7Lkb1rAnNGik8ls6S3rsELGS1Il5nYO05YOTP787OG8gO1GxTAwT8krPcPRnJE9+b07ZcIuihuxCqYgX/EFwz3+uxaIMPRotRRthvpaaY0PXVsMgHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1k1/LSl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710356693; x=1741892693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VPdzAc0FsDDvBJDK1XggBVHga4+fDQhGH/tMKavFcXE=;
  b=E1k1/LSlkbDfu82haUxQtsGJrV6jgBLbGKw2P7QDI8KzGePKebDRwdw1
   /BIfIC/y7beI1225BRn+sqTmsyK4rbrJXHSen0ae1T2a3mvQYLSzYfMde
   5u00ZNXv7sKMmhjqNWuml9hi+x0SBChbGHkyFeAY7PGlOaR6qRar9O7Ow
   4CXbE8o6cTSxThLKfl0P4SapleKe90TcAWPauX0ecUHdnkDK17K7SXV/y
   OOBbG/CmDd0k18r48mF0ozAboZluUvo03PtJFw22yxW40gTFmp5YvGZFM
   MMop9387MgZRvBSuwutb/7MDiiYNUFrFoeh3kQQxCIEvQsk7LvlA4cKRc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="15874306"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="15874306"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:04:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="914439334"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="914439334"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:04:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkTuA-0000000CIjz-3pD1;
	Wed, 13 Mar 2024 21:04:46 +0200
Date: Wed, 13 Mar 2024 21:04:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, linus.walleij@linaro.org,
	phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: pressure: Simplify and make more clear
 temperature readings
Message-ID: <ZfH4znQ2FK6j5LWK@smile.fi.intel.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-5-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313174007.1934983-5-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 13, 2024 at 06:40:05PM +0100, Vasileios Amoiridis wrote:
> The read_press/read_humid functions need the updated t_fine value

read_press()/read_humid()


> in order to calculate the current pressure/humidity. Temperature
> reads should be removed from the read_press/read_humid functions

read_press()/read_humid()

> and should be placed in the oneshot captures before the pressure
> and humidity reads. This makes the code more intuitive.

..

> +			if (strcmp(indio_dev->name, "bmp580"))
> +				data->chip_info->read_temp(data);
> +

> +			if (strcmp(indio_dev->name, "bmp580"))
> +				data->chip_info->read_temp(data);

Yeah, not a fan of the strcmp().

-- 
With Best Regards,
Andy Shevchenko



