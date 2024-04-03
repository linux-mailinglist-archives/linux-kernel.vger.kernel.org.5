Return-Path: <linux-kernel+bounces-129436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05BE896AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB2FB2BBB3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC3133981;
	Wed,  3 Apr 2024 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEWnWSyl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7EB6FE00;
	Wed,  3 Apr 2024 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136977; cv=none; b=S2iGwhbcCQZsXfICa3dyrldYCXHaiOh+eTGNZUI8GaR9BbHmVYGxnq2cs2F294TdRMXSuX36KvMOcbqABYUdYK+WqXg1XjinKdwSU2XCve2XkWskB8r5a2gphF9szcG4lrxmtB5oNqR/lLGXF67qhi+QLptBDwlPwNdzKAxnAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136977; c=relaxed/simple;
	bh=J4/4Z/KbRHhQpBPL6z/aGYydGWTMJbsDXjqRAbKjEZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdJ7fCJLveJdxtHAN544bbimVNjPKQ4S2Gg+ZO4BDiw3KsPYTzgyxmACCLiA4A5hptXdOR7mb1+SPrFtdB1FWjm++G8SeApcOR3yr4opbkRfxHKAYHPMBYp9pzCJj/HOagmXs4D2iJUef3gf0znaBfZNfVQMUoq8p2Q1hZmIyAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEWnWSyl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712136976; x=1743672976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J4/4Z/KbRHhQpBPL6z/aGYydGWTMJbsDXjqRAbKjEZM=;
  b=EEWnWSylOKhhopQMk7DNhthF2S/HaZjaBYtnFwpTPZqkea7nJL2jCUwf
   /yN3nrizHaD6qXn49jUG3rPeUuaUVEmxStIBa8ddESXs4ODmfL/BF8jDC
   /8suW9QMQDD4OVTKk9Zya0Hg3fXwdrZamaiUAtGPczK+hEDCwKMdR8NNn
   LGKCAPxgbRoogvwY6IoWnJTCI2SkfhZCUX+fcUcr9QAMCE6X5HT92vd0y
   0MWL397CDmaSJN3pLMzYnl6mjeb/pD3383rK7PgnTUmh7UiYbH72oofzE
   gK5ZUHpO0rCCsbiynj3bftrgYMHYi/7x5EC/0fbC07c11jO9aa/IsDQLr
   w==;
X-CSE-ConnectionGUID: BVAbgaSjRFqYtOUodZ3JLw==
X-CSE-MsgGUID: aHZNuR9XQn+RunVOAjP+Gg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7219125"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7219125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:36:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915176150"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915176150"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:36:13 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrx2R-000000014m4-15PG;
	Wed, 03 Apr 2024 12:36:11 +0300
Date: Wed, 3 Apr 2024 12:36:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 16/34] iio: ad5755: hook up of_device_id lookup to
 platform driver
Message-ID: <Zg0jC0R39CTLsrg0@smile.fi.intel.com>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-17-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-17-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 10:06:34AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When the driver is built-in, 'make W=1' warns about an unused
> ID table:
> 
> drivers/iio/dac/ad5755.c:866:34: error: 'ad5755_of_match' defined but not used [-Werror=unused-const-variable=]
>   866 | static const struct of_device_id ad5755_of_match[] = {
> 
> While the data is duplicated in the spi_device_id, it's common
> to use the actual OF compatible strings in the driver.
> 
> Since there are no in-tree users of plain platform devices, the
> spi_device_id table could actually be dropped entirely with this.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



