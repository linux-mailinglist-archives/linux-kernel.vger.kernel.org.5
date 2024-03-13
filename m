Return-Path: <linux-kernel+bounces-102436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7A987B1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16911C2744C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95F14CDF9;
	Wed, 13 Mar 2024 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YODp69Yv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A3210E9;
	Wed, 13 Mar 2024 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358136; cv=none; b=NkJ/Jkc+9QQtC8MDWaU1oZ7VU4HHhnC+cEZb1TXBwT47kgW+zV/yKsonzz5ySV/XGPDC9Q6Dn0B+g1dAEDWJjqjaTDMP3sw2a7kI2sul7ZxyWQDzxBLKc6qI8L4TvEUyn2ZpfasNxDPTGx4/nlwBp2fGowwAGFaKIghBl5Mo0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358136; c=relaxed/simple;
	bh=jEX7xRWr5bS1ECghF4PJiW3looDCCj225HvMYgHcpM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1N8CgLi9ODBYlz3XEZSj33mOR1pHa4WlyzhEiUC+u5qGm7gbydGvOx66OB82NTSsMhrSl0skStgorPcrmBdHpJs6SUcKnukY7QfGb2dIkpfUb+8o6o0pcZ0gQXpgSX+0VUhyjC8B4elyR8U56n2LAYh3K1ofujg9ifjybwP9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YODp69Yv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710358135; x=1741894135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jEX7xRWr5bS1ECghF4PJiW3looDCCj225HvMYgHcpM4=;
  b=YODp69YvPtwh9Y6RYowYz+P7pMCFNiBLIRflFe+mTW9RvaWBF+mbjJCx
   HHFvOFqn3LNzuRTJJPif5U7C3EySBVjokdInT3dsomTNGXyZcK6KOr7o2
   Dmii6yRptti7LubZMJeapTweQHLVUfnOtiDnxEs7PbggrTZDa3gm3mEin
   2UF1tIhEDbUZXPqNKEHiT70+1ZjsCqt6fUnVJ0jH1+Cn4Pg2hF7vVz2Fe
   D0SiVTQzhcKpqPpMQNMxCX0c2RD4tcKx/gJab+ZLyzlzKrCocNzY8MNZL
   jktWl86XjJ4C40yy9iBOv7BBDS3Jf747QEHw9Ara3Y5Xo7v4JFqhqxC8H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="15876370"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="15876370"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:28:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="914439794"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="914439794"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:28:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkUHQ-0000000CJBn-0szT;
	Wed, 13 Mar 2024 21:28:48 +0200
Date: Wed, 13 Mar 2024 21:28:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, linus.walleij@linaro.org,
	phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: pressure: Simplify read_* functions
Message-ID: <ZfH-b2KWcU_8-Nmh@smile.fi.intel.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-3-vassilisamir@gmail.com>
 <ZfH4IyeFTGFBKT4J@smile.fi.intel.com>
 <20240313192245.GA1938985@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313192245.GA1938985@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 13, 2024 at 08:22:45PM +0100, Vasileios Amoiridis wrote:
> On Wed, Mar 13, 2024 at 09:01:55PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 13, 2024 at 06:40:03PM +0100, Vasileios Amoiridis wrote:

..

> > >  		case IIO_TEMP:
> > > -			ret = data->chip_info->read_temp(data, val, val2);
> > > +			ret = data->chip_info->read_temp(data);
> > > +			*val = data->chip_info->temp_coeffs[0] * ret;
> > > +			*val2 = data->chip_info->temp_coeffs[1];
> > 
> > > +			if (!strcmp(indio_dev->name, "bmp580"))
> > > +				ret = IIO_VAL_FRACTIONAL_LOG2;
> > > +			else
> > > +				ret = IIO_VAL_FRACTIONAL;
> > 
> > I'm wondering if we may replace these strcmp():s by using enum and respective
> > values in chip_info.
> 
> The whole problem starts from the fact that all these BMPxxx_CHIP_ID defines are
> not unique for the respective BMPxxx device. You mean to add a new variable
> that could store some enum values that would be the actual chip_info IDs? Like:
> 
> enum chip_info_ids = {
> 	BMP085,
> 	BMP180,
> 	...
> 	BMP580,
> };
> 
> and later for every chip_info struct to use it like this:
> 
> const struct bmp280_chip_info bmpxxx_chip_info = {
> 	...
> 	.chip_info_id = BIT(BMPxxx),

No BIT(), but yes.

> 	...
> }
> 
> And in the read_raw() function to just use the test_bit() function in the same
> way that is done with the test_bit() and avail_scan_mask to test for the
> enabled channels?

If BIT() is more suitable, than also yes.

-- 
With Best Regards,
Andy Shevchenko



