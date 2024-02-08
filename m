Return-Path: <linux-kernel+bounces-58468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61DB84E6E7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AF5284940
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E30823D2;
	Thu,  8 Feb 2024 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBhkYavs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6044C125DA;
	Thu,  8 Feb 2024 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413948; cv=none; b=IW+xRnsXDjXlWJYpMD7B7QQ6/r0KsdBK9qksEcs8MM6NHlN4/8c0qz8phgxxWifeSd+L+0RmWcFQHPA+Pz0TWgl+fFvNaH2WsL75aW1HlezRyiVZ1Yo2I7tZtCfCL7Ghq4PEwDTCY7wo2tBKG4f1rrPJ3hEcY4ei4FZJb3UMcuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413948; c=relaxed/simple;
	bh=FGrFBhVYW5+vEBjlfh5W8e9AfIMN0Bx1vppx0iko9fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqza7NkYRI/CUcV5l6jSa8f/NkOhChvg38Tx1NKoYmrt8IYHd5P80Ck7fqI6zfIffol6V4Qaq1Q9f/pQgqcZEh+zGT4B/Cp1qToM7fJBInHHcA4pmMd68o+uycEcIsyGHgnhreEtboTCCKbUMFnQY+Zo9uEgll32HbdOaB9XSF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBhkYavs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707413948; x=1738949948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FGrFBhVYW5+vEBjlfh5W8e9AfIMN0Bx1vppx0iko9fk=;
  b=YBhkYavskLFoIpx2BbwkESmlpzu3wts77UJQnqp/Ff/UUbKWSk73Rq9p
   ixQC5yOtDuR8fThniiac7grnSi4bzfBpvvpLdFCr0bMofR5gW+3JTdp5Y
   TtgO3vqcSUpPJt4Kv8en+wBbb47AnLVXrCuYTG7/pKotbcyrfKV92b5OM
   lKj3a3dFNRI6+JKQ4JmtRurvv50qVQI86xPOD+BAdXn1OxnunBDSQ1rhQ
   CBcSvp0+PpfQc+b6nbXRYdFDuyycsxqYqq7KdY76SHRpIYimu0HSqjivs
   byQm/4iHvVYrKGHjkeyyxEwFsxoYzVh7+3qNn/jKlfs+sSq4+6hNL+5BC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1430471"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1430471"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910439155"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910439155"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:39:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY8MW-00000002wHA-32AP;
	Thu, 08 Feb 2024 19:39:00 +0200
Date: Thu, 8 Feb 2024 19:39:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 19/24] gpio: remove unnecessary checks from
 gpiod_to_chip()
Message-ID: <ZcURtLZoEftBDpsy@smile.fi.intel.com>
References: <20240208095920.8035-1-brgl@bgdev.pl>
 <20240208095920.8035-20-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208095920.8035-20-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 10:59:15AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We don't need to check the gdev pointer in struct gpio_desc - it's
> always assigned and never cleared. It's also pointless to check
> gdev->chip before we actually serialize access to it.

..

>  struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
>  {
> -	if (!desc || !desc->gdev)
> +	if (!desc)

Wondering if it makes sense to align with the below and use IS_ERR_OR_NULL() check.

>  		return NULL;
>  	return desc->gdev->chip;

..

> -	if (!desc || IS_ERR(desc) || !desc->gdev || !desc->gdev->chip)
> +	if (!desc || IS_ERR(desc))

IS_ERR_OR_NULL()

>  		return -EINVAL;
>  
>  	gc = desc->gdev->chip;

-- 
With Best Regards,
Andy Shevchenko



