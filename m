Return-Path: <linux-kernel+bounces-48060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77ED8456C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1064A1C281E5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFDC15DBC0;
	Thu,  1 Feb 2024 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0YbJhqW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E615DBA4;
	Thu,  1 Feb 2024 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789007; cv=none; b=OTuILp/heI/dLRbZJEl8E85ksHnzHfJLl2ATgZwk8OvpaY5XX+i2Mj5tbqSV7asKbsvgXgAQKswqQJXXzFjOfhVRsVMPtLmqLSQDJB6iPX6EwbsZYpYdk9E2TXE8G6iSx+vCMrZywZRJgetXrYF1TScAIqJtLpe4OWXpzSGG/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789007; c=relaxed/simple;
	bh=2m5DaL/Ch9nYB4JV5SYoG6jFp7mOyve/+2De+UkHY00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5eNbAjZqSKVK7r3j/kAKeWXAbTE7fnpJkkc0T85kOB/EKFGM7BZy5oPVtKmRi0wKSa06beiPyXFdcxcPJ3Q3huv/j+DT5GmEERDwJ/hCqx4bGXwS1tBSnUllYT3guMcUqn1Fw8HcVCZNDXDA+W82WlryAX+u2NRsSOK3ryAd8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0YbJhqW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706789006; x=1738325006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2m5DaL/Ch9nYB4JV5SYoG6jFp7mOyve/+2De+UkHY00=;
  b=I0YbJhqW7o7xl+zj7QWmxBJmx14wI/YUttwLE85QQuPbnF10qGm0c50a
   Cwu3UtM8noiEP4+s4TJio0gXRFr7z09nKwGFcGy9zgXyFtFBGjJCxPQ0W
   Dxku6Rkkc88FOeDa/pFxZBy9PrcEot1EfVvf2HEcMGwotCXQAbmkvdpRW
   2hLw9HTdg/38mB1JRmWXHbPEK2xPRcN/FAUIj5cAsT9rPd/465lzraDy4
   RKapI/amu+TsAsmB+De26N2SinsBIf8w97juHkAiaeUxGc/JJcm6AFIOf
   smKpmtCRhLGIIxmmTTcVLqvVBGksWpJ4egNp2aAr0XniQAzIAVH2U647I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10531559"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10531559"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="738410604"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="738410604"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVVQO-00000000ovk-02ld;
	Thu, 01 Feb 2024 13:40:08 +0200
Date: Thu, 1 Feb 2024 13:40:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Kalle Valo <kvalo@kernel.org>, Arend van Spriel <aspriel@gmail.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Srinivasan Raju <srini.raju@purelifi.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 1/6] wifi: ath9k: Obtain system GPIOS from descriptors
Message-ID: <ZbuDF2-m8oJofpyl@smile.fi.intel.com>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
 <20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 31, 2024 at 11:37:20PM +0100, Linus Walleij wrote:
> The ath9k has an odd use of system-wide GPIOs: if the chip
> does not have internal GPIO capability, it will try to obtain a
> GPIO line from the system GPIO controller:
> 
>   if (BIT(gpio) & ah->caps.gpio_mask)
>         ath9k_hw_gpio_cfg_wmac(...);
>   else if (AR_SREV_SOC(ah))
>         ath9k_hw_gpio_cfg_soc(ah, gpio, out, label);
> 
> Where ath9k_hw_gpio_cfg_soc() will attempt to issue
> gpio_request_one() passing the local GPIO number of the controller
> (0..31) to gpio_request_one().
> 
> This is somewhat peculiar and possibly even dangerous: there is
> nowadays no guarantee of the numbering of these system-wide
> GPIOs, and assuming that GPIO 0..31 as used by ath9k would
> correspond to GPIOs 0..31 on the system as a whole seems a bit
> wild.
> 
> My best guess is that everyone actually using this driver has
> support for the local (custom) GPIO API and the bit in
> h->caps.gpio_mask is always set for any GPIO the driver may
> try to obtain, so this facility to use system-wide GPIOs is
> actually unused and could be deleted.
> 
> Anyway: I cannot know if this is really the case, so implement
> a fallback handling using GPIO descriptors obtained from the
> ah->dev device indexed 0..31. These can for example be passed
> in the device tree, ACPI or through board files. I doubt that
> anyone will use them, but this makes it possible to obtain a
> system-wide GPIO for any of the 0..31 GPIOs potentially
> requested by the driver.

..

> +	/* Obtains a system specific GPIO descriptor from another GPIO controller */
> +	gpiod = devm_gpiod_get_index(ah->dev, NULL, gpio, flags);

> +

Unnecessary blank line, please don't add it.

> +	if (IS_ERR(gpiod)) {
> +		err = PTR_ERR(gpiod);
>  		ath_err(ath9k_hw_common(ah), "request GPIO%d failed:%d\n",
>  			gpio, err);
>  		return;
>  	}

-- 
With Best Regards,
Andy Shevchenko



