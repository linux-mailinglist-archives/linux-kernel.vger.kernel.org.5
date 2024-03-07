Return-Path: <linux-kernel+bounces-95408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6198874D49
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847E91C22886
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DCC128818;
	Thu,  7 Mar 2024 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWWnLXiV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378ACDDC9;
	Thu,  7 Mar 2024 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810453; cv=none; b=eozbwsjx2xeQIWefuDohl2QNJzWX+ErvJbC821jfppXbMA+PL3DfUXWwgPE/DTY1HeASjCwQ3stu9gJNXdTAPHkmrOuAaZt674ctDT41MHgAoxgsicv8kUV3zLSxELTgpW28lGWVOBN3mRhDx9vPOTSivmkheLKrwAQkowtqz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810453; c=relaxed/simple;
	bh=ApMkrw723LkwYTFRCtKAEXYBM0ar5qJTrIp2KwSQfpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grn+xhpyMAgjA93SNl2vTkmMHGgGKZ59W0+CTveAgIy0PoMVJ9plGfGabFoZF1+XESGu8dHpDWm65O9m9wK12Xyvq4fofyzC2gH+Y//RNfrdlsy1A9Uyz41YLQTccsVoHsKUnIoW2mqqq5YzFJtbhTQFfryWQ5FoDot3m4L90OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWWnLXiV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709810451; x=1741346451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ApMkrw723LkwYTFRCtKAEXYBM0ar5qJTrIp2KwSQfpw=;
  b=SWWnLXiVRceJTo/YNx1/rMvEDJX7kAVRjhGmyGEAZh1MTYdBsc57IxKG
   2+SzSVRVngT+7Kur1bc6yBLDTCMUFZhG0J8zfN5YaBt+MWlA5zp6zeEKS
   cHcPBCoxzGsDM64DMHuKpHEpysQ6/EIZIpinGET7Wd876VYPeY+Ez1CpA
   1arCoHQfT3Z9LVVLxfqFGJJTs7woh0Rop3Quo6IreiZytCuqA3klJGWLz
   /8r/FLszJo6aDfaAVy98uBtcy3lcFWwOCdMdqv5oDPXGzB9u1fS55AKNR
   IWQtInBLNgL0uB84T++kXGlLSKJn0FVRKRhbfPHzcq8gedqaA0SeWjRm/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15881501"
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="15881501"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 03:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="914211314"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="914211314"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 03:20:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riBnr-0000000AXdk-2q8W;
	Thu, 07 Mar 2024 13:20:47 +0200
Date: Thu, 7 Mar 2024 13:20:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: oc-tiny: Remove unused of_gpio.h
Message-ID: <ZemjDwEs8qdix2n0@smile.fi.intel.com>
References: <20240228193732.3605768-1-andriy.shevchenko@linux.intel.com>
 <ZeXd7zrNZSTW3va0@smile.fi.intel.com>
 <9ac09714-25e6-429f-8847-0ee6a34e0220@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ac09714-25e6-429f-8847-0ee6a34e0220@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 04, 2024 at 05:10:22PM +0000, Mark Brown wrote:
> On Mon, Mar 04, 2024 at 04:42:55PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 28, 2024 at 09:37:31PM +0200, Andy Shevchenko wrote:
> > > of_gpio.h is deprecated and subject to remove.
> > > The driver doesn't use it, simply remove the unused header.
> 
> > Hmm... did it fall through cracks or anything should I do?
> 
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so 
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
> 
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.

Right, but it looks like this is quite simple one that simply got unnoticed
or so...

-- 
With Best Regards,
Andy Shevchenko



