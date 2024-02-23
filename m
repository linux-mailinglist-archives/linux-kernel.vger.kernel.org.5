Return-Path: <linux-kernel+bounces-78894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE2F861A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F6C1C256C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E5D141987;
	Fri, 23 Feb 2024 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpKtTH1D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455951353EA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710161; cv=none; b=XcfF2CVqkTnBS0VhseqCZtG5/QVQYP2XzlJWhGjD83RQ31c9KVkxnwSkVP6zUdc0SY2AXaZG92viSTLhDwgzPrlizvpu6kK2oGuEsVddZh9YfhlsP+cKNq3oXY5frSgiVTnLtDqpy0fzdr7JhUJWXhr1MdSULWgB5BQi+axUuB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710161; c=relaxed/simple;
	bh=IycnRvyn0DFRkClwY9SGw1un5/Ap5e/m6Ec695D7Cjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDPNqZ66fpPCPfrLyQsNwnp+CXMz2gQutkqW/7Nn2L8jxSMFtPSAtS04jup5lv4sgkztKgd5qaluiwr4NPoMdDZo/iDJdbm7LceeE5Li1g5Z6l3yO3He2g0N1anf4ML83wipykv0Bcuow4bk5bj6T4XYKbjyT57pdvji2lugQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpKtTH1D; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708710160; x=1740246160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IycnRvyn0DFRkClwY9SGw1un5/Ap5e/m6Ec695D7Cjs=;
  b=JpKtTH1DsA15nSb92wxXAzW2ycwAmZd7rRlRwoX92fiB5GRKmimgxkW3
   w/IkQxwKm7BF2gE6Pc5dUXhkoUI4U1KxvQ0686h2s4d59sslxe0wCId/E
   ACrlh1lk7KgaCPa/QzS08YYC/Dx5j9XCVpkep/YY1neSdXdrdT57QHQ4X
   yqnHYm0eEg3bX2UYA0EsVFz5OjMi7tNarQX/6/qtnWQcShzimt4klAy4g
   I2j6QfTDMfCH3/zVaHBceHdSpZBskvFIGshYHxH/SBXxCdbCi1/+O/0n0
   6FgiEKZQ0VI2upmeoXzqKXqe1HFf6e31JSJshZPd8VqeMDCHHO41LkOKT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6853947"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6853947"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 09:42:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913752235"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913752235"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 09:42:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdZZD-00000006xfx-0muc;
	Fri, 23 Feb 2024 19:42:35 +0200
Date: Fri, 23 Feb 2024 19:42:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
Cc: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clkdev: Update clkdev id usage to allow for longer
 names
Message-ID: <ZdjZCrpP52Hfbs6L@smile.fi.intel.com>
References: <20240223163516.796606-1-michael.j.ruhl@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223163516.796606-1-michael.j.ruhl@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 11:35:16AM -0500, Michael J. Ruhl wrote:
> clkdev DEV ID information is limited to an array of 20 bytes
> (MAX_DEV_ID).  It is possible that the ID could be longer than
> that.  If so, the lookup will fail because the "real ID" will
> not match the copied value.
> 
> For instance, generating a device name for the I2C Designware
> module using the PCI ID can result in a name of:
> 
> i2c_designware.39424
> 
> clkdev_create() will store:
> 
> i2c_designware.3942
> 
> The stored name is one off and will not match correctly during probe.
> 
> Increase the size of the ID to allow for a longer name.

> v2: Removed CON_ID update and added example to commit

Usually we put changelog out of the commit messages...

> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> ---

..somewhere here.

Also just noticed that you forgot CCF maintainers to be included.
I'm suggesting to use my script [1] which harvests more or less
adequate list of people and mailing lists to Cc email to.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko



