Return-Path: <linux-kernel+bounces-109953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8777788582B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42135283156
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BAD58229;
	Thu, 21 Mar 2024 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjUcB880"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BDB56B9C;
	Thu, 21 Mar 2024 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020154; cv=none; b=n5BM3NV0HvAOED7rv6WvrM04sB/H1q7el5Qc1/fsxQdjqwIGG6TqhTi7FqvT+nMaoi09Vlhjhz2BPvlQb2IombEfbn2TxMLxiqYXQ79pGQQODVIvtlnrBwg4xOaYHUeprFyTXMQZoaIX5l8hGXU9M3GrO8uO8yq6hkr98hZgZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020154; c=relaxed/simple;
	bh=B5hYVgV8ybe0NDF3WjWOs8927InHswBxtTUnOsK0Th8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5XiQlarvdLxToBD2w3GX2PYVMAay8C/Q9P6I320RkEfweLBMkTKYCu5PekjaqMQag++wswvub7VvzHU/gpZ09XSdFSgByXq3cKHJaTjebaC1vvB3F6Jrp/3TO6/UGfuOE79uSh9rEYIa4d8pZnO6UuAffVpnALRBTG4RECPemE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjUcB880; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711020153; x=1742556153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B5hYVgV8ybe0NDF3WjWOs8927InHswBxtTUnOsK0Th8=;
  b=QjUcB880CM66JXIepPu7tgzU9DGQGmxziQZ+UnSyaYHPB+H2h6MQ3UZV
   23KdZg3eQki6n/HJTD20GcFWbU3zicjApCeluh7pyQ7BZaSnZC13kx2Eq
   NGA+DznE8sJUoBGmmcXRrbL7D8yYyYBLxDFn+YitADSON9NxobvNZHQAD
   Ozs+zsxG3ZCUTVUcW/FX4764zva0Q/cIT7Qr9omABkV3nq8FQvEYM4Ch6
   GSzX9j/FekQkuE5wQPEJoyiL0N5ZuintXdGHRdCxFg+UTwKKWJ0C0IN6c
   asJEzPQUFH8h6BojkeB402OF9Wiq3Tm9lfIhld1t7gtOxI5GDYpfmlEiN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6115754"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6115754"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:22:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="914704304"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="914704304"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:22:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rnGV7-0000000Eqax-42sD;
	Thu, 21 Mar 2024 13:22:25 +0200
Date: Thu, 21 Mar 2024 13:22:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: pressure: Add timestamp and scan_masks for
 BMP280 driver
Message-ID: <ZfwYcSB2B2WtlFgM@smile.fi.intel.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-6-vassilisamir@gmail.com>
 <ZfrDW1ESxnFg__od@smile.fi.intel.com>
 <20240320184516.GB36450@vamoiridPC>
 <ZftJK3cqFNU9-dCG@smile.fi.intel.com>
 <20240320213139.GA52721@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320213139.GA52721@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 20, 2024 at 10:31:39PM +0100, Vasileios Amoiridis wrote:
> On Wed, Mar 20, 2024 at 10:38:03PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 20, 2024 at 07:45:16PM +0100, Vasileios Amoiridis wrote:
> > > On Wed, Mar 20, 2024 at 01:07:07PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Mar 19, 2024 at 01:29:24AM +0100, Vasileios Amoiridis wrote:

..

> > > > > +enum bmp280_scan {
> > > > > +	BMP280_TEMP,
> > > > > +	BMP280_PRESS,
> > > > > +	BME280_HUMID
> > > > 
> > > > The last is not a terminator, please leave trailing comma.
> > > > 
> > > > > +};
> > > 
> > > What do you mean it is not a terminator? In general with the enum
> > > variables I would write:
> > > 
> > > 	enum var { a, b, c };
> > 
> > This example is different to what you used. I.o.w. _this_ example is okay.
> > 
> > > Why in this case there is a comma needed after the BME280_HUMID element?
> > 
> > It's pure style issue that helps to avoid the unneeded churn in the future in
> > case the list is getting expanded. You can easily imagine what I mean.
> > 
> 
> Ok, that definitely makes sense, thank you! In general, should this be applied
> to structs as well?

Yes, to structs and/or arrays initializers when the list has a potential
expanding. We don't have trailing comma when:
1) it's a terminator entry (nothing must be after);
2) it's on the one line (as in your above example).

-- 
With Best Regards,
Andy Shevchenko



