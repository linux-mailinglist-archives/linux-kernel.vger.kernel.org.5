Return-Path: <linux-kernel+bounces-95926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3760D87550B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E834E284BAA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE121130AF1;
	Thu,  7 Mar 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5vj2t6U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E61130ACC;
	Thu,  7 Mar 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832118; cv=none; b=ck0ML+KeBITHnHKxkFaVh9Aq68rbNAkBPBmjcq1XZy4AWelW2vaVC6dCzgE5zp63gdZOoY4ww1jWTQR4M1d4qbUcnvLsGGnH1JnDw/Q8YrssFK86fy2BoTWq8n4NezV1UHCJPmemKmByf00E0/IggB5qeV6AING5t49yZaE+Hfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832118; c=relaxed/simple;
	bh=YZybhNNI2z9K9HHtsdU1tEnwKmlAkpV4Dy3FViCKkwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7ycX4xOTBalwdvE1hOJPsnKGeZca3d0jUUYzBi4RYc9R/NnBAtJv4rVQSm/fdbu20G+8IeqbxBEzLoD8PUjuYkjVZLIWY20wKSvLLK5RM4LX/IzVVUjOcva+/ZcYicTQcxcWnGxlLdpB7Zl5S4KzLiQiRw0ZGRP8tbYAm8qCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5vj2t6U; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709832116; x=1741368116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YZybhNNI2z9K9HHtsdU1tEnwKmlAkpV4Dy3FViCKkwc=;
  b=S5vj2t6UdOOA3SpNFOaWqxEZYCe5rAx2MYMHZlviYmTgBCahob1RPAs/
   G76LMGFDoBMLycB9MLkNFKKma1owUFjUZm9Rp6XJDygeHLz0889I/3hsz
   eETcC5mKC0T7iqvnh7iu3cE+Dm3OoXc+TtkuBkT7o/1aqx2f13MwhbOTS
   nHFHVUOZ2D7nUcN5DeXclQSSVfcVlzlK2zwIKoJLNLPXbDe/+28SkNF4U
   oI0wi3QF5U4agPIPpakDNGxy0spZXMOj25ixamOD5blDahTSF2nO6HRk8
   xjAMvPxmVIcCjC9u05lH80Es0FT92VhteVAfSh/lp/GO4KMh1CiS7dzU+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4636030"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="4636030"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:21:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914219901"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="914219901"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:21:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riHRG-0000000Acq4-2QKA;
	Thu, 07 Mar 2024 19:21:50 +0200
Date: Thu, 7 Mar 2024 19:21:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] spi: pxa2xx: Kill pxa2xx_set_spi_info()
Message-ID: <Zen3rjXtIJk9dSsO@smile.fi.intel.com>
References: <20240307170441.3884452-1-andriy.shevchenko@linux.intel.com>
 <20240307170441.3884452-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307170441.3884452-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 07:03:15PM +0200, Andy Shevchenko wrote:

..

> +		pd->dev.platform_data = info;

Oops, this won't compile :-)

-- 
With Best Regards,
Andy Shevchenko



