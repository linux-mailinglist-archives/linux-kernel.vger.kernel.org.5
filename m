Return-Path: <linux-kernel+bounces-129856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0193897154
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 526D7B2785F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2001487CC;
	Wed,  3 Apr 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qbm2VRLl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8E5146D41;
	Wed,  3 Apr 2024 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151566; cv=none; b=QUiuIIRGu9FjZ2P8fer9+lHJ57I6Y6uVKQjMHcPYDLg57Ueia+3blnThVUMlGKCau5RL6KCdjKC+X2ZGnEE5MGsqV0LOExqBurHHVIsiy9NY+ebWyuv4aBFjCvG8D+LYG5QZCSYlJN9joFuyPThDxHQn/7Whi+owIClT3RVXduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151566; c=relaxed/simple;
	bh=yuwlPgatDVh6zFj152mH2P0uRmArAHNy0sOK7o8mFYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7O7l8L68h3/vM8fm0xup7NQvI9C2aEo0mXdn3mxZ0vRE+pUSwkSg509udsHrYN4FwCycBWmNXmA0ed3rdnkB7viHBLTeIunIqdlsR7URfNwk/6s07unPQbm/8AXrqu1Df2uwAxOOTKuw+f8ABlc27EhClP8jlzEOt5VssezSyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qbm2VRLl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712151564; x=1743687564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yuwlPgatDVh6zFj152mH2P0uRmArAHNy0sOK7o8mFYI=;
  b=Qbm2VRLll47SnTpAuqQTraf+Rhy0cjNn6yWX890ustW4CK19Aa1m5OtF
   Yw6FB4I6XrHD94MCGJqxXPsOjghd1meI1nCSoPuiGF98KIqy0woQEBwSV
   wyB/yIdk6YzUJOKNV4sM4q+rvw5dZFxMBCCuPFhMrEMi2vqa/iI3j3CVW
   E5v+kspOSl6es5qL3yhYxvizq/U+B8IKiaSepTtNoNW73Pc0QxwToaasA
   inlOeB+3ZRd+MB9yq8XeRY7yuNdosEpQ4gR7OpBF57wd9OKcclcnXtE3M
   C/hAL6RnGa/qHrGRDkk79qP2xa7lkYSkrGVdWUKBkZVAPCzvxEzTSYNyD
   A==;
X-CSE-ConnectionGUID: s3r4j05eQXCiL6qFXbrf8Q==
X-CSE-MsgGUID: khJTsiyORn+NFFBvO2e1Vw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7246332"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7246332"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 06:39:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915183772"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915183772"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 06:39:15 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rs0pd-000000018EQ-04zU;
	Wed, 03 Apr 2024 16:39:13 +0300
Date: Wed, 3 Apr 2024 16:39:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: (subset) [PATCH v2 0/9] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
Message-ID: <Zg1cAHEkhIf2vpwJ@smile.fi.intel.com>
References: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
 <171167575036.187521.17547262230962160149.b4-ty@kernel.org>
 <Zg04cWhT_Dl6AUik@smile.fi.intel.com>
 <b7ac20d0-ca45-4e65-92ff-ddf84da6645a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7ac20d0-ca45-4e65-92ff-ddf84da6645a@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 02:29:38PM +0100, Mark Brown wrote:
> On Wed, Apr 03, 2024 at 02:07:29PM +0300, Andy Shevchenko wrote:
> 
> > Do I need to do anything else to get the rest applied?
> 
> All the concerns I have with swnodes just being a more complex and less
> maintainable way of doing things still stand, I'm not clear that this is
> making anything better.

As I explained before it's not less maintainable than device tree sources.
The only difference is that we don't have validation tool for in-kernel
tables. And I don't see why we need that. The data describes the platforms
and in the very same way may come to the driver from elsewhere.
How would you validate that? It the same as we trust firmware (boot loader)
or not. If we don't than how should we do at all?

Can you point out what the exact aspect is most significant from C language
perspective that we miss after conversion? Type checking? Something else?

-- 
With Best Regards,
Andy Shevchenko



