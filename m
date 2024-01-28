Return-Path: <linux-kernel+bounces-41661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A100A83F5FA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BA7283D10
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A10F288A7;
	Sun, 28 Jan 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buo9Wmlw"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91C625773;
	Sun, 28 Jan 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706453612; cv=none; b=ganLNE8ZrdiAifWrl2mPMdtyTzJ/Q70bss4m4rXDCXfz1gVKtVRtwZKtCczY+5ZsqkM9y+XGV+nJXnMZdHKyzCM6u2qqJcX6jewvc1VoVkOUEGLy1rGx4j1/G8i91jmXqIUDyYn1tRnExu6/CkIvFf241MrSMfJSEWmC0qQiMg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706453612; c=relaxed/simple;
	bh=FPNPXRGcYW+3LdmTeX/GEGVmsrCrRC4A0cjQ4DkFE/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7eT0MR6/EbXs8KyEz5k8d+xNX3EWebTpjZ/u9PnHx3zXd8nH7m6l47oH8+/CayNqfWztskjSAKoddyBM17tec5NSdbKgZOcWjw1jKNz7XesD4GKhErPcOkxDczD0onLbevTWNk5f4qdJZJBPZYmsd8M5gcHs/iAyDSKyNDxWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buo9Wmlw; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706453610; x=1737989610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FPNPXRGcYW+3LdmTeX/GEGVmsrCrRC4A0cjQ4DkFE/k=;
  b=buo9WmlwrhFOMF6M+nAxJrpiztosiUxl4YVyb9Ffdeh8BtnjvBWoogw2
   krz4F5Z81Zsb/TV/jRFT1y0BJbEB+vlKLERWBklzg8pqgmT/AgrUXYrgl
   39gXPqw9INo+zN0PaIlRso+s40pTxRxzAguGY4M3fuW3PYuAFwC90BXGr
   XO2FmDq98j1Z4c/geHq8kK935KZssE4Vcjv4Yan4gdaBxJCnAG5lJQhvQ
   mtDS/8tgL4zAvKKBPC/bRCs0FqjQTM1A7oPgRdnIf1eEZFBTppL6Kxzfv
   98nNMOH4CGD2KItjBnL7r92A/s1tXEj21lSewyeUFZuHnGrG/Rc2uNG73
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="433942007"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="433942007"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 06:53:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="960671412"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="960671412"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 06:53:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rU6XE-0000000HU1q-2r1s;
	Sun, 28 Jan 2024 16:53:24 +0200
Date: Sun, 28 Jan 2024 16:53:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] pwm: dwc: Add 16 channel support for Intel
 Elkhart Lake
Message-ID: <ZbZqZDvdw-_D3hyb@smile.fi.intel.com>
References: <20240122030238.29437-1-raag.jadav@intel.com>
 <20240122030238.29437-2-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122030238.29437-2-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 22, 2024 at 08:32:36AM +0530, Raag Jadav wrote:
> Intel Elkhart Lake PSE includes two instances of PWM as a single PCI
> function with 8 channels each. Add support for the remaining channels.

..

> +static int dwc_pwm_init(struct device *dev, const struct dwc_pwm_info *info, void __iomem *base)
> +{
> +	/* Default values for single instance devices */
> +	unsigned int nr = 1, size = 0;
> +	int i, ret;
> +
> +	/* Fill up values from driver_data, if any */
> +	if (info) {
> +		nr = info->nr;
> +		size = info->size;
> +	}
> +
> +	for (i = 0; i < nr; i++) {
> +		struct dwc_pwm *dwc;
> +
> +		dwc = dwc_pwm_alloc(dev);
> +		if (!dwc)
> +			return -ENOMEM;
> +
> +		dwc->base = base + (i * size);
> +
> +		ret = devm_pwmchip_add(dev, &dwc->chip);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

Why not doing this slightly differently?

First option: Always provide driver data (info is never NULL).

Second option, have the body of the for-loop be factored to a helper
dwc_pwm_init_one() and here

	if (!info)
		return dwc_pwm_init_one(..., 1, 0);

	for (i = 0; i < info->nr; i++) {
		ret = dwc_pwm_init_one(...);
		if (ret)
			return ret;
	}

-- 
With Best Regards,
Andy Shevchenko



