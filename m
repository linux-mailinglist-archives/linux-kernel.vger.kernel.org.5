Return-Path: <linux-kernel+bounces-117239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4184E88A8FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDD43675E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411D112F5AB;
	Mon, 25 Mar 2024 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LT6sUl4F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667C84A3E;
	Mon, 25 Mar 2024 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376467; cv=none; b=nKNFMrUXlJIJ5jT4E0wLjhQtXwL66Cp/5IENxPcSlMnx1HAvKIONVnbzQAGiLfH5WpQiqqLrhFlZdo4YULr6mKk9Ekc4ENISGBMvXq1SZu2zZjkC6mebumWVgfVt2MQ/fAG2VxzhqehbT1lJ3DbkkKGj8ZWOXyGZIuPGzfJRj2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376467; c=relaxed/simple;
	bh=Nbky7w1K9krHxCztmzHbc4cyv0j40xX3Yglo1Am08Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gp6cJ8B8a5y5EhWW8uJLF2yCm6bexRsz5tO7U2nfpTk/pJTXxbxKPatleHxWCHaxrQHtjG7g21LzAmci1XULxgpv+5mbXd7UW/1y3hgejbJv6ylVWzbhOoHUeyIOW4AEkLchJ03N41dJwV7DJC4D5YzL8YRquelPUlLqAmupql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LT6sUl4F; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711376465; x=1742912465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nbky7w1K9krHxCztmzHbc4cyv0j40xX3Yglo1Am08Xo=;
  b=LT6sUl4F1mPdzJv/VKLC0+H9r38x77pPUiO/GqQEF4v0SNGy2RnPGUf1
   LGdVv7yk+YOQn8xNHSQ8OBiduc5LMj2Sw3A7kWQKgCSZhSeV9+pHgV+2u
   lFB5FQqBUb59EsRxlAxaflSKAXQhl5MT/CAgudTysmWKq9oNkheOcI2by
   sudqtv2P9Uwh0yPPnByE/l8YaRRbkXbzxh3pCFr08v/k0LXiiCTf34CuE
   m8+MOOvml22sVvRzMlDypWyf6RH/fL1qGeuM2MNcvsjboRn1kILQd3O7i
   mrOFYQbpD9AWCTj+oyGIOol1XUhaukxKE27lnCHh8ugcq371LhD5uQrF4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17813575"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17813575"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 07:21:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="914844803"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914844803"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 07:21:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rolC7-0000000G0Wp-2ZXA;
	Mon, 25 Mar 2024 16:20:59 +0200
Date: Mon, 25 Mar 2024 16:20:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: rspi: Get rid of unused struct rspi_plat_data
Message-ID: <ZgGISy3Wjz_f1EFM@smile.fi.intel.com>
References: <20240307155045.3796045-1-andriy.shevchenko@linux.intel.com>
 <8c75da02-ff4c-4a31-93ae-7b55d16e1bf8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c75da02-ff4c-4a31-93ae-7b55d16e1bf8@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 02:08:49PM +0000, Mark Brown wrote:
> On Thu, Mar 07, 2024 at 05:50:45PM +0200, Andy Shevchenko wrote:

..

> >  drivers/spi/spi-rspi.c   | 11 +----------
> >  include/linux/spi/rspi.h | 18 ------------------
> 
> This breaks the build:
> 
> /build/stage/linux/drivers/spi/spi-rspi.c:27:10: fatal error: linux/spi/rspi.h: No such file or directory
>    27 | #include <linux/spi/rspi.h>
>       |          ^~~~~~~~~~~~~~~~~~

Indeed... Yet another driver that depends on the custom ARCH_*.
I'll send v2. At least now it compiles on x86_64.

-- 
With Best Regards,
Andy Shevchenko



