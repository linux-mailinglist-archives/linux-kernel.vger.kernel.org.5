Return-Path: <linux-kernel+bounces-98652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A67A877D53
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABF51C2125C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14B9208C8;
	Mon, 11 Mar 2024 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bF5k4Zi7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8219617561;
	Mon, 11 Mar 2024 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150729; cv=none; b=X4t25kHsqTbFW6Z70qzkJ7FznUCcIJfQB95mOT37/1XJ/DjEsKamQN2q6XfI9KOZMGYEK6o3FrhF4uyD8FeX6JcWAFuMIglBwK3mY+/dmkURjERTONLgAIXIIs/uHXdbERZsHqoF/QjMci3eLpjw2hjuY0w8EYQs2Xw8lBvrGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150729; c=relaxed/simple;
	bh=kHqGNEG12eLe3S/obPhPqU/Qc/8vK1W84077+sxQovU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTlWQYnur3YpzO8mnQeBbL4dc26mEGAWgguao2pfqbEgVevN4nHVLxcZQQNiOHbRHtYJOlPGNtH0MjoOE9iL+aXkV1OUzlMONTH8m4o3F6AB9l4Kh4osVjsNqSo47ZESBCJZq0jMPL/lpQlNFXob6nno8Q2j5jTYMOLkeZMVLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bF5k4Zi7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710150728; x=1741686728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kHqGNEG12eLe3S/obPhPqU/Qc/8vK1W84077+sxQovU=;
  b=bF5k4Zi7MyLC0sjzcpebHrvt13p7mYKzLvEYv/FxH2lF2VF2Wd+7eARK
   fYdLTisO24exmDrXsSwDlUlXP+XdWUFKffrOpjlpyvrI3akpcIRA+LXII
   FX7J8KLwzwqymNRvFHWmQqwHO2uJ5R9ZilWTD4maAKLwhrkZIi8/fBg93
   8/RJyJ8U5DiHo06kqGyJKEYh/8ylWLv6eLFTGRN2enxUFOe0rnG7isV79
   SjDdIo8JhCCEo91ZROoCHqJzLh5IzaveuKdke8UtOO4Fb0rC/kcdaNsFa
   x0kZW9GcpebXvAtmRkQvxfEFqoJnsu+MkyIic3gI0PDBByB6vV6tFQ0xk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="8619483"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="8619483"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 02:52:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="914354296"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="914354296"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 02:52:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rjcK8-0000000BaI1-2XGg;
	Mon, 11 Mar 2024 11:52:00 +0200
Date: Mon, 11 Mar 2024 11:52:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/5] Support for Avago APDS9306 Ambient Light Sensor
Message-ID: <Ze7UQAD4V3n-MKDJ@smile.fi.intel.com>
References: <20240309105031.10313-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309105031.10313-1-subhajit.ghosh@tweaklogic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 09, 2024 at 09:20:26PM +1030, Subhajit Ghosh wrote:
> Support for Avago APDS9306 Ambient Light Sensor.
> 
> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
> It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
> channel approximates the response of the human-eye providing direct
> read out where the output count is proportional to ambient light levels.
> It is internally temperature compensated and rejects 50Hz and 60Hz flicker
> caused by artificial light sources. Hardware interrupt configuration is
> optional. It is a low power device with 20 bit resolution and has 
> configurable adaptive interrupt mode and interrupt persistence mode.
> The device also features inbuilt hardware gain, multiple integration time
> selection options and sampling frequency selection options.
> 
> This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for 
> Scales, Gains and Integration time implementation.
> 
> Link: https://docs.broadcom.com/doc/AV02-4755EN

..

>  - Removed 'ret' from iio_gts_find_new_gain_by_old_gain_time()
>    as it is not used. The current implementaion of the above
>    function passes all my tests of changing integration times,
>    scales and gains from userspace.

This is weird. I believe we have to fix the API first before adding / dropping
the return value from it. This odd API which makes everybody confused.

-- 
With Best Regards,
Andy Shevchenko



