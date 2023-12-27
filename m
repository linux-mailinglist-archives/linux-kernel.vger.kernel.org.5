Return-Path: <linux-kernel+bounces-12141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC3281F07B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07BE1C216D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED433286AC;
	Wed, 27 Dec 2023 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGAUFLqX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020691E50B;
	Wed, 27 Dec 2023 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703695068; x=1735231068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C0xIy59+brcN4rsi5+PyliR2R7CN2ScjanmBgdR+p7E=;
  b=RGAUFLqXug9061h8ap9wIpP/oJkQ/GbmlheRuazvXfWc5bkHisjiXpN3
   mhgELp4MgdTND4i9Q5n2vWWoJTn/i1MnY393lro+xaidaAPrewPFPk128
   sd95kbwxkzEz42jeC06s8y/ehjWLjTTc69dw+pvmsdyakIPJgyHYzhetv
   sG/4axC/fGpBHrggVCXvW7Uq28C6r4hO9rmUUYcWj+qWBnM0e57AvDQeX
   OthVnm9F2UblSSiwRNJwStLIH+j5DdocgJL2R+BqWIIPBDCske22yjpds
   CeDea9W1/PY07q4ARrmPslPQ05ESOybdbZ5bd/SKSUeXnpoJZe0dhrf4Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="381434300"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="381434300"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:37:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="812568448"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="812568448"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:37:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIWud-00000009SsX-0lNv;
	Wed, 27 Dec 2023 18:37:43 +0200
Date: Wed, 27 Dec 2023 18:37:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 08/10] iio: pressure: mprls0025pa.c refactor
Message-ID: <ZYxS1o2lSlaJ6dG4@smile.fi.intel.com>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-9-petre.rodan@subdimension.ro>
 <20231226164922.6d7132c1@jic23-huawei>
 <ZYw1wbvYQqqCr5C2@sunspire>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYw1wbvYQqqCr5C2@sunspire>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 27, 2023 at 04:33:37PM +0200, Petre Rodan wrote:
> On Tue, Dec 26, 2023 at 04:49:22PM +0000, Jonathan Cameron wrote:

,,,

> > >  		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
> > > -				IRQF_TRIGGER_RISING, client->name, data);
> > > +				      IRQF_TRIGGER_RISING, dev_name(dev), data);
> > 
> > Even though you'll change it again here, would have been nice to have
> > the alignment fixed in the earlier patch then the code update here.
> 
> I tried this, but due to the fact that the line has to be right-aligned to
> column 80 we will still see a whitespace difference due to the length diff of
> the name-related argument.

You can split in the previous patch accordingly, so data comes to a new line.

...

> > > +#include <linux/iio/iio.h>
> > 
> > Why include this?  Can't see an IIO specific stuff in here.
> 
> tried to remove it and
> 
>   CC [M]  mprls0025pa_i2c.o
> mprls0025pa.h:89:63: error: 'IIO_DMA_MINALIGN' undeclared here (not in a function); did you mean 'ARCH_DMA_MINALIGN'?
>    89 |         u8          buffer[MPR_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);

> I guess it makes more sense to move it to the .h file, where buffer[] is defined.

Yes, C-code and especially headers should follow IWYI principle. The real user
of that definition is _the header_ file, and not C in this case.


-- 
With Best Regards,
Andy Shevchenko



