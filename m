Return-Path: <linux-kernel+bounces-139311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7F68A013F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28353281075
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02C1181CEF;
	Wed, 10 Apr 2024 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWZ3RALe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A6181CE8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780635; cv=none; b=Jijl8I3ymIxJB+nSkXbb0+eUqpkbQPes4wT/aqQw3PRnh8ZrlJbm/GdhQOmYUJzhBptTO/dBC7cdM8khxwgv2tsUP/63EQZ6dST/YA5owkN0aGfV9hc2+Kb+uEQDTvKwGhK9RLmwVVBxANPbAXrkYrsL2GH/ox5v0l/A9ZyUsXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780635; c=relaxed/simple;
	bh=wKAN+1801N1Qbn4Fd48EWlQQ/8yKmqseKjyTtp2yqN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVZMBK/ELnb7rUfvRI8ZsBvB4IltkHCn9dRmdPrSG0VrDeBxqVW4Uy8jm8qtYptMbxkh8KWrJDl5fAiR+Cb/MuBxlU09p4+onVXI3q6/uQq6bBM1krxFy4vjjxRdIUVCYw7R/lx2iGs0DePxiE6pfZXZEeIhAd499Q2iTsXjnFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWZ3RALe; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712780633; x=1744316633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wKAN+1801N1Qbn4Fd48EWlQQ/8yKmqseKjyTtp2yqN0=;
  b=XWZ3RALeSbJgy+xbKp8ob8j0kntWy1vBKPvKV62qyEBRn3qVpZQIPhiJ
   RWPEcrUWdyWnOMjCowTIVaE740yTOUwi6IN8t6LdazOY9OAu1A2B3O3rQ
   oiLX3+3ol8fLUMcmK8NwIUP6alVmG3roJ8zxke6mS3qxzfAvX6xraIrtI
   S5burvDHz2o+9UPY2fZqme7x3OQW5a4pUz4weXSqzw04XjqkwXHsrbiJN
   7IOjKgQN8DqJUz0v0vyzI8Q/FI5laBy9B5TmInlX1CVWVAHIYyNDgTGa5
   n16ippEcA4xiUEXYhc9B5ojv8YZZmEp/2CGN9i+9/xBAOIA61uh0SxMH7
   A==;
X-CSE-ConnectionGUID: 4fV6zArvSdGx9c6w1ZJJuA==
X-CSE-MsgGUID: QofyvwXESbWhdAq6ljXWvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8022148"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8022148"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:23:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915442223"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="915442223"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:23:51 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rueU1-00000003BLA-1hVA;
	Wed, 10 Apr 2024 23:23:49 +0300
Date: Wed, 10 Apr 2024 23:23:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] regmap: spi: Add missing MODULE_DESCRIPTION()
Message-ID: <Zhb1VSXYAwnKbx0I@smile.fi.intel.com>
References: <20240410200031.1656581-1-andriy.shevchenko@linux.intel.com>
 <3602aa7a-15c9-4e77-8aa9-a12f2136530c@sirena.org.uk>
 <Zhbyu-qI97eBxtxU@smile.fi.intel.com>
 <8dd5a474-ec45-4f0d-b1a9-e91e54c990fc@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd5a474-ec45-4f0d-b1a9-e91e54c990fc@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 10, 2024 at 09:16:26PM +0100, Mark Brown wrote:
> On Wed, Apr 10, 2024 at 11:12:43PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 10, 2024 at 09:05:17PM +0100, Mark Brown wrote:
> 
> > > regmap.
> 
> > Hmm...
> 
> > drivers/base/regmap/regmap-i3c.c:59:MODULE_DESCRIPTION("Regmap I3C Module");
> > drivers/base/regmap/regmap-mdio.c:120:MODULE_DESCRIPTION("Regmap MDIO Module");
> > drivers/base/regmap/regmap-sdw-mbq.c:100:MODULE_DESCRIPTION("Regmap SoundWire MBQ Module");
> > drivers/base/regmap/regmap-sdw.c:101:MODULE_DESCRIPTION("Regmap SoundWire Module");
> > drivers/base/regmap/regmap-spi.c:168:MODULE_DESCRIPTION("Regmap SPI Module");
> 
> Feel free to fix the others as well.

OK. Will do in v2.

Btw, any news about PXA2xx cleanup?

-- 
With Best Regards,
Andy Shevchenko



