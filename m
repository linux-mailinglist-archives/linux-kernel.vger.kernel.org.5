Return-Path: <linux-kernel+bounces-128515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B21895BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A851C22CB6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8760115B542;
	Tue,  2 Apr 2024 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjKmuVKr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B439133421;
	Tue,  2 Apr 2024 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083416; cv=none; b=mCqFFKAslruBrBzxIK4D6wempGRUuSPhNLlkSf146ESqgapon2Gz5t04LePEYeYi8oP5Rqn3syR8mCZPSPlEsELwWu+PErM6M23ROtYXzvXdKMjcayJAeK0nz7gPt24QC8UF+xmPLmc1HKg9OwU/1J9PI4Yo6pZMGUGMA2jzTGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083416; c=relaxed/simple;
	bh=owPkFS+aHIiODbc1mDCipIfoNGM2SZCNTgceRjbgtrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSfzrmYL2viMC/jhCeSx7CzKwAb8AHmU4vF9glCoSsj4OS1P0HXPQ+nssTOZhYW0LWWXbQBJGpkyZaWdt6CqMcC6Qm4WGqxhRzcoZWLp84QNG1A73RhlYfsgNtb/3G5CXQ0K5rPOWUduvsmSSKEH/zbxv5cave927ZGQjkWuXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjKmuVKr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712083415; x=1743619415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=owPkFS+aHIiODbc1mDCipIfoNGM2SZCNTgceRjbgtrY=;
  b=BjKmuVKrNGeytW7VF7N0/QSbmpnb/spRQ0DaXPlbQQKoZIFQjEZdBKdx
   gB+d7TstebUvUICRs1CcwNEOicwcCbMMSV0U8hyK9UFymWqCMjEqSNW3s
   TPZTM2DN5q2nWDymcdpJZ3WOHPsvpGAIHeimDQ+7kf5tNBbMjjR52xWMI
   6EOzcx6vFrJx4CraBTm7RskorAeOR9iECHQzucl4ENbeJiIK7il/QTgfW
   51g+8+H97wVuzrO2I0YZunB+/oB0tQndHszd30zXqvq5UHeFs3zAFVqlD
   sths/7BZUER1iDqXT7NONrCUIZaWZ2xGI0tni9vPxOJBAEn78+ffr8MZ4
   w==;
X-CSE-ConnectionGUID: 5WkhkMCpQUyCIRLF0welQw==
X-CSE-MsgGUID: fkSW7xnVSkmaUny5jO1HQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7146471"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7146471"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 11:43:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915150053"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="915150053"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 11:43:31 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrj6W-00000000u3U-0fnL;
	Tue, 02 Apr 2024 21:43:28 +0300
Date: Tue, 2 Apr 2024 21:43:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 0/3] gpiolib: Get rid of
 gpio_free_array()/gpio_request_array()
Message-ID: <ZgxRzyQGeSAl4MzX@smile.fi.intel.com>
References: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 03:49:02PM +0200, Andy Shevchenko wrote:
> There are only two users left of the gpio_free_array()/gpio_request_array().
> Convert them to very basic legacy APIs (it requires much less work for
> now) and drop no more used gpio_free_array()/gpio_request_array().

Any comments on this? We really want to get rid of the legacy APIs.

While at here, would be also good to have a comment/tag for
https://lore.kernel.org/r/20240327193138.2385910-7-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



