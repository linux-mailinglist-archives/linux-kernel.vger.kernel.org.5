Return-Path: <linux-kernel+bounces-95978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FA0875593
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A0DB21133
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2752F131731;
	Thu,  7 Mar 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHI5diXz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1614130E58;
	Thu,  7 Mar 2024 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833972; cv=none; b=WYO8t7zO38gG4TW/MnHSruFH1pfvyEZIWOCbYoFXxBKWzoPyJjfFfk+boFQpSq5QC/Q/3vcDwJXjZ4sAH9jk9hksAjQrQulZZeOXlBBnjHErl0qC12fCS1XDYQxYKy+xTMIUQqKV1oTShdPQE+iyElSgG9kZXxBooZZzIAw7N6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833972; c=relaxed/simple;
	bh=EwLOKsBQqfvl2TftRhAv9wcR/kjcGBcVdlhuRsQXiHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liiUrOmKuK76I7rWru5rx4bY3RUikSzz3jqyiuFhQXHv2NSLVzng5C3fgyRVlh7WodplfnfIQ88P1N6YWNKWdWEOedbmqZiOwRSLv5zXynb9AeNkQI7y14jrp1TyjzOWwbThTF7VRQU0+DBIo5FpgAB/ZOurW5KK6l0qSs/+eDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHI5diXz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709833971; x=1741369971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EwLOKsBQqfvl2TftRhAv9wcR/kjcGBcVdlhuRsQXiHI=;
  b=mHI5diXzzBjmXWlMC6oz0epBKTBoCHxitxm1cuE25cg65yr0zX8olNqb
   vbE3Rk6zhe9zqB+hVVpr/5jxCQZmenjHZOsGyJrS7jSw+oqPNMsuczehb
   CGdXwYj/PEIwbIjvSsTPGvligVpWuDtF+pKjnE5hK9ApFCj9arX4gX41S
   Nbdjz4KA9Q3zF+jiOaCsDHEY2DDNvMMYmU6Dv3UBcDirxvirNFrLtN9pI
   H1hoUvOBgO9bhzhfpplNgP4Muz/CQ8fIWPSEEbco68onH+hsMrIgeSDVk
   oZa3ypTd/8ixK0Hm3yixeMLulIUXuO/GbzRob/m0WWOgmH9h+S+kSiur9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15952097"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="15952097"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914220563"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="914220563"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:52:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riHvA-0000000AdCi-3VOk;
	Thu, 07 Mar 2024 19:52:44 +0200
Date: Thu, 7 Mar 2024 19:52:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] spi: pxa2xx: Clean up linux/spi/pxa2xx_spi.h
Message-ID: <Zen-7K_AuVfjuAX8@smile.fi.intel.com>
References: <20240307170441.3884452-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307170441.3884452-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 07:03:14PM +0200, Andy Shevchenko wrote:
> A couple of cleanups against linux/spi/pxa2xx_spi.h.

Besides obvious compilation error I think I can follow Arnd's suggestion to get
rid of the pxa2xx_spi.h altogether. Stay tuned!


-- 
With Best Regards,
Andy Shevchenko



