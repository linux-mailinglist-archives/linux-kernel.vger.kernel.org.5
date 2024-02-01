Return-Path: <linux-kernel+bounces-48216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EAD8458AF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24BB6B27B64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E58253377;
	Thu,  1 Feb 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8Sn1mUF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8320B8662D;
	Thu,  1 Feb 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793481; cv=none; b=AnpHFTpgaYsghzKNGbiIYEx+xeABXtEKP9ocHY7kXhPpMlQNuUtRKfS9zJUHWdhDC+IIc7yhkNfs5uwixbQzfGwgJ/fIqbYU8S5Fu1PTR9amDBrQFx4crZnMP+WjEkTCLd0VMxmy5UYsKkAUXVLlyPyHlStJytSTUU1Qy8M6ZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793481; c=relaxed/simple;
	bh=3ZoQUuBpsVZXNjJz/pyS6DRGTxWPkkOr4+FLxmPbU5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8ky0yB7YccBpGBk7emayglK1zEbjTxLxRwEW3dKidAh8dj3hREakkfvDnHTvKmpTrQrptnyei393A4aOZ7NI3dr6vAV47YsNvrQV29sNnbYytM4genCslrz1Jh9puAmI7B58pn98xFnkMGyyVcPF/RuXN4TpRqA2EYnYYmy2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8Sn1mUF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706793479; x=1738329479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ZoQUuBpsVZXNjJz/pyS6DRGTxWPkkOr4+FLxmPbU5Q=;
  b=Y8Sn1mUFEcoeNykKGqI0cVzIRx+QOWKD1pCkV0p3W6LXEPlPSSRNzz3r
   sEDkXEI2SN6fDGIdns84ATJsFn3tfMhkI/+GPNYYhaGK1nay6gCISLkuz
   WIRYOIfd8KNKQLe1z5pkJEEW/pDryxGB0XkYuEtUOanwZxMWuVbXkuGWI
   PnjInxQXuGO5m+ypM7GcDbSCnCdmkLzHuQg0hhq+EXDcFwuVyI2BPT7uZ
   LR+8TzvVRQiVnVdGRRwcDT0FtIvRIAYHSiPplUzbevkhDm2c6ItoIyc4Q
   WiChqF2zA6K+aQdRrRXzAafA2gon+gOY6jc4E0ZK3y8t0oxDAc7xCQ7z3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="25353507"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="25353507"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 05:17:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="879099304"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="879099304"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 05:17:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVWwy-00000000qIA-0xEC;
	Thu, 01 Feb 2024 15:17:52 +0200
Date: Thu, 1 Feb 2024 15:17:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Kalle Valo <kvalo@kernel.org>, Arend van Spriel <aspriel@gmail.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Lee Jones <lee@kernel.org>, Brian Norris <briannorris@chromium.org>,
	Srinivasan Raju <srini.raju@purelifi.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 1/6] wifi: ath9k: Obtain system GPIOS from descriptors
Message-ID: <ZbuZ_55a-qqDqkeN@smile.fi.intel.com>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
 <20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
 <613ae419-9a2c-477e-8b19-8a29d42a3164@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <613ae419-9a2c-477e-8b19-8a29d42a3164@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 01, 2024 at 01:20:16PM +0100, Arnd Bergmann wrote:
> On Wed, Jan 31, 2024, at 23:37, Linus Walleij wrote:


FWIW, some nit-picks below.

..

> -	if (ah->led_pin < 0) {
> +	if (AR_SREV_SOC(ah)) {
> +		ah->led_gpio = gpiod_get(ah->dev, "led", 0);
> +		if (IS_ERR(ah->led_gpio))
> +			ah->led_gpio = NULL;

Slightly better to have something like

		desc = gpiod_get_optional();
		if (!IS_ERR(desc))
			led_gpio = desc;


> +	} else if (ah->led_pin < 0) {

..

> +	if (sc->sc_ah->led_gpio)

Dup check

> +		gpiod_put(sc->sc_ah->led_gpio);

..

>  #include "htc.h"
> +#include <linux/gpio/consumer.h>

First to include linux/* ones?

..

> +		ath9k_hw_set_gpio(priv->ah, priv->ah->led_pin,
> +				  (priv->brightness == LED_OFF));

Unnecessary parentheses.

>  }

..

> +	if (AR_SREV_SOC(priv->ah)) {
> +		priv->ah->led_gpio = gpiod_get(priv->ah->dev, "led", 0);
> +		if (IS_ERR(priv->ah->led_gpio))
> +			priv->ah->led_gpio = NULL;

_optional() ?


> +	} else if (AR_SREV_9287(priv->ah))

..

> +	if (ah->led_gpio)

Dup check.

> +		gpiod_set_value(ah->led_gpio, 1);
>  

..

> +	if (ah->led_gpio)

Ditto.

> +		gpiod_set_value(ah->led_gpio, 0);

-- 
With Best Regards,
Andy Shevchenko



