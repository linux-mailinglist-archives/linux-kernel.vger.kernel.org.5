Return-Path: <linux-kernel+bounces-58447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F28884E69B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4152919B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB737BAE3;
	Thu,  8 Feb 2024 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPJW/uYW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39B37EF19;
	Thu,  8 Feb 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413019; cv=none; b=mwrWYdZ2v2ecjXEm2Y5jLdSj16kONQqmqfRHsrx9CXdcVnurTOSJp2yUw63YWT21dOrK5tgSgveutIUZRb48Ah2jnfqqklZVqKC2B66e8KJ4Bb61p9rFZ6co13s6GNUrN8gJ1c41u0ID2QFTlW3YxdeHQAmFmJQvpGzu/FrH9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413019; c=relaxed/simple;
	bh=V+gwtZRfZzD4e0ADinSM7BMhqOp1FjOWYK5UT7X4mJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9xZsTm7YvunHs9hFex17TIE2S5+zFs3V/towfHzGK/pf4CXiVouMz+9BIk9iwvOsvOM3/x8Mg981KEUEHaQYqKicSIKZ4zy7SH3/wqOG1jPDbYW8lB88JR/GTXlQrdfbJVMcJa4VvYHTLlnKnv3Oh7rhXjsjDrMTaTWaMiBAYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPJW/uYW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707413018; x=1738949018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V+gwtZRfZzD4e0ADinSM7BMhqOp1FjOWYK5UT7X4mJ0=;
  b=NPJW/uYWdtd/8jNa75MHWAiVUtzF4hmWsFhLO6V3DHHkyX37qUdpW9zg
   O+OamevUeORgXW1/xthcynaJaio4xo3/Klitssp9mEYz7pWV1BZJF/wLr
   oHunJGsqnB7CNKKDowNgKYEnhs+ZjQPS+YJ+YIR+P9muw4ssJfpNRvgab
   oamfh+AU2vfPHmMhbpn0CmKeg3GF8xhdkABvucS3AcomcjLN+V1eboXpo
   Syfl99Lj48rgoeZkDhP1ReybzTPWWdCDaeTIlJ8lTw2bXb55aNlZpVdfP
   7YQhptwAL4AXnaVU5C33Q3Gx5lr2W4/wh9rOyWPCz2BxvZOi664tz8hqp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="11843627"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="11843627"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:23:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910434285"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910434285"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:23:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY87Y-00000002w6K-3Guk;
	Thu, 08 Feb 2024 19:23:32 +0200
Date: Thu, 8 Feb 2024 19:23:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] DesignWare PWM improvements
Message-ID: <ZcUOFComp54S76jF@smile.fi.intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208070529.28562-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 12:35:24PM +0530, Raag Jadav wrote:
> This series implements 16 channel PWM support for Intel Elkhart Lake
> along with minor cleanups for DesignWare PWM driver.

> Raag Jadav (5):
>   pwm: dwc: drop redundant error check
>   pwm: dwc: Add 16 channel support for Intel Elkhart Lake
>   pwm: dwc: simplify error handling
>   pwm: dwc: access driver_data using dev_get_drvdata()
>   pwm: dwc: use pm_sleep_ptr() macro

For patches except #3
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



