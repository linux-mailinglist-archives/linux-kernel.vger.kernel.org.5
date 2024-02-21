Return-Path: <linux-kernel+bounces-74774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5A385D99F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3335B24FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1217BAE4;
	Wed, 21 Feb 2024 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdKnMnnO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4256A8D6;
	Wed, 21 Feb 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521614; cv=none; b=sxmkVhe03l/8JOXSkQKb2GIbVzZR5bgZM0nxcMwepX38kqsAmkfWkXAfNVtfxN0+pi8jttOw4BktGk5TvKMRtDqojlxUtTCmSMUGt+TPtdx7tieWHAAvJY3yv5hfh7FmgxuCDCR5FDbawHAelfJ16QBl8k2fi60Vdv1+VRG4xlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521614; c=relaxed/simple;
	bh=2wjGF5jbjsu0i3M9Tg69QSKMJU8pypnOd8aBudYMAUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6+LT2xiXRuLBEcx6ppb9HlHw6nhvXd3jOLwM30Ve78s/9EYcbeAiGH8aYM/nyYp66tdv7b02W4R3JkpbnGUwKZUIzbeaXl+SXhOI6S0Hc9vt2WhTTt/6JT74S53LdPfl6bHZ8LovpbyyASbWWn0GMflfivaS3SWpoh/q/aIL2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdKnMnnO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708521612; x=1740057612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2wjGF5jbjsu0i3M9Tg69QSKMJU8pypnOd8aBudYMAUU=;
  b=RdKnMnnOxh5ZB0gJcK49r1grhsaqEVjuO46QP6dMiJAD4LDpShNTqJ9L
   NT4jjRi3amtWGumh8EdgADAF+2rQg0SkWPzQ5Gb2wU9NINb/46bHl9j/C
   NJ7AX8nxHKP7wCWasLlH+thIBMuLbq5xD56zuxVwzHaTKCeAyZqy2K4q7
   rbJU3Tcf5EmgEyzvO+lPCTr3ousIyb+YYTN1Q2pSnK7AxAKzkmolPE/4j
   mdAL2VeEIgLqCpfGCYfagRTVdLJLsGVPk5ZUrAAf30qT8PM3kCBy0XmX/
   SeNFcNKA0fyILnBhPqC97Rr6h3eboBl7ZB8kk3MaS+gRtM8SN4IrEN4FG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6454957"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="6454957"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 05:20:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913302683"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="913302683"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 05:20:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcmW7-00000006MAD-0wqm;
	Wed, 21 Feb 2024 15:20:07 +0200
Date: Wed, 21 Feb 2024 15:20:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers: iio: pressure: Sort headers of BMPxxx SPI
 driver
Message-ID: <ZdX4hgXtFaXTujGZ@smile.fi.intel.com>
References: <20240220224329.53729-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220224329.53729-1-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 20, 2024 at 11:43:28PM +0100, Vasileios Amoiridis wrote:
> Alphabetical sorting and separation of headers for the BMPxxx
> SPI driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



