Return-Path: <linux-kernel+bounces-142961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94CD8A3290
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E977E1C24602
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83F3148301;
	Fri, 12 Apr 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtInHfC3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF41482E2;
	Fri, 12 Apr 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936158; cv=none; b=DZRKXXq+gr2RUPX/i2xvlLCkrOYpyfyz8ZRGr+KNvlwXzIRGGhVzXukAoJJfbSidNT/lgvkJp4Hwb+tNNGm8A8C35dfEcUUg8ug6vS5ifupforwbuC9K7iT/HW5C0Fr6mfcrs7ABhS/5Z4le4lynHmxxZCl2TuoMekBXFNbpClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936158; c=relaxed/simple;
	bh=ri9lUgAOtfo86OqHDKzXa69NZHZUgF3TZoCl1G2ZZWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sG9N7sWe8KKfso1KJCcbTcoglADKY1f8UHY4TDhQw8m4kY0v4x7mafZvkVHrHQxfYfIg0g/JInyR6NFuBo1EmfqegTNh8W+xH3F0iQ/MSthYuXGrCrtj7cmZcFLk9zrIafRrVP7oy1InuNXMHoY09/tLQNH2riP7XW8clLc7C3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtInHfC3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712936157; x=1744472157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ri9lUgAOtfo86OqHDKzXa69NZHZUgF3TZoCl1G2ZZWk=;
  b=YtInHfC3i84a1FKpfs+2Sp7vMC0pB3ymiWADvEoDvambA74Qe9amL1+W
   BqDxRpHnPLtXn73Vr/dTSP9CZfY2rEy4rdWp5QFNpQGbspfaJ+XM4mdPS
   w7CgIt4yIeNQNnDBzxChnNeRQHHTW3l2WLhA+TloBoIqYymNn9FrmZRKV
   H296xBCf3OhmhDOHRwlCmXTms7T8c5qQi35WbnvHI6x6MQs26ssPS/h3A
   +8Wu0w7yWSQ0d2dkiafhEXKZ//HUhCJYtN0k8rZOFdeifURe2naNxHNKb
   d++OAwLhi8XxaYMl+fwnbvv81BZNWI5eHkMqBa/W2SVWDMK9GbDzGRllw
   g==;
X-CSE-ConnectionGUID: PPa9VnITRxSSsqnCRE54tQ==
X-CSE-MsgGUID: jQiSGJzuTWOF+18smw70vw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="12243725"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="12243725"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:35:56 -0700
X-CSE-ConnectionGUID: E5x+YhdQQbWx+08vauJTIg==
X-CSE-MsgGUID: rOGDQoMPSgmibNVcz859/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25700350"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:35:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rvIwR-00000003gq9-3gtK;
	Fri, 12 Apr 2024 18:35:51 +0300
Date: Fri, 12 Apr 2024 18:35:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: dwc: allow suspend/resume for 16 channels
Message-ID: <ZhlU176sS36_JvQU@smile.fi.intel.com>
References: <20240412060812.20412-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412060812.20412-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 11:38:12AM +0530, Raag Jadav wrote:
> With 16 channel pwm support, we're registering two instances of pwm_chip
> with 8 channels each. We need to update PM functions to use both instances
> of pwm_chip during power state transitions.
> 
> Introduce struct dwc_pwm_drvdata and use it as driver_data, which will
> maintain both instances of pwm_chip along with dwc_pwm_info and allow us
> to use them inside suspend/resume handles.

..

> +	data = devm_kzalloc(dev, struct_size(data, chips, info->nr), GFP_KERNEL);
> +	if (!data)
> +		return dev_err_probe(dev, -ENOMEM, "Failed to allocate drvdata\n");

Haven't noticed before, but we do not print messages for -ENOMEM. Just return
the code.

-- 
With Best Regards,
Andy Shevchenko



