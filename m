Return-Path: <linux-kernel+bounces-41653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CACB83F5E7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA17C1C22700
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA32820DC4;
	Sun, 28 Jan 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJPkz9WP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774931E89D;
	Sun, 28 Jan 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706452778; cv=none; b=FIwoUlworECDusGtUQPqfhPleMYeHxnLbm0c2afZfKw55pUFvx77nCASFfZcGosMGV0ISbxaVA5OdZ24Up/fXkxJHEVhjNmO6M69v9EoPqs883UAuMm7riqczUywAGaxIZdkleE014HozZ61RF1lhKG08CSvX7MkDiof/R4c9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706452778; c=relaxed/simple;
	bh=MvFLG7+fw1TsvJEiHrVT3XO9svrY/UGXQ8KusEBsHSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiTJJgFgM14Z+x4f1Ob5pOx01cw4VrSOMjWIO3qQzxulGGitNXBKA5BlwXtOiJ0EN8MwLHrrd5wFcWeGao56aOCuK5FQBbXF1DyBzNEvhrBjT3qUZsLIYaX5eWmEo7bOyLca5pSzQmKXtnDKWHY7AtqVQVM81hAKhxYhPBZuHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJPkz9WP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706452776; x=1737988776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MvFLG7+fw1TsvJEiHrVT3XO9svrY/UGXQ8KusEBsHSI=;
  b=nJPkz9WPid0JbQqh92mMkh35fQ8/VPtF1BFFSUjRl8Am24sjVvQ0R433
   l4tyupZbCdR3KPMplpZPtn2XPZXWRcChUHFM3EbZzBDZG4nHe5RGQp1Si
   x00axpv6ZX37VJ14DFAFvxVJGDaVVfRqyQom3171NcNYV/0T9+vPsY/d2
   jx3k98jZMDXFkp3Rj+po4lVwFQXOwahQC4+rVe6cEILBpkzstHEP8wv19
   ZYlLMzl7gLKIL8Wh+8rWFulBcplrbmbwuISDuSH6adkAZBanA5nk81CYc
   JwD+nRfEhI7X2GQOgmJ+l6FWo5mpwcJXTnQHqpvdai7O3VIv4KpvwwRdP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="1712459"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="1712459"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 06:39:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="1118701747"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="1118701747"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 06:39:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rU6Jm-0000000HTrg-3huR;
	Sun, 28 Jan 2024 16:39:30 +0200
Date: Sun, 28 Jan 2024 16:39:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 4/4] backlight: hx8357: Utilise temporary variable for
 struct device
Message-ID: <ZbZnItD-4v6d9qfh@smile.fi.intel.com>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-5-andriy.shevchenko@linux.intel.com>
 <20240124172507.GA16024@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124172507.GA16024@aspen.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 24, 2024 at 05:25:07PM +0000, Daniel Thompson wrote:
> On Sun, Jan 14, 2024 at 05:25:11PM +0200, Andy Shevchenko wrote:

..

> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Thank you for the review, I will address comments and send a new version
at the end of the next week I hope.

-- 
With Best Regards,
Andy Shevchenko



