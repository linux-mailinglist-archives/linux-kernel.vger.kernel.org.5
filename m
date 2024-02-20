Return-Path: <linux-kernel+bounces-73169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6889C85BE89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08DBAB21016
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C81B6BB20;
	Tue, 20 Feb 2024 14:18:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628526A8A5;
	Tue, 20 Feb 2024 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438684; cv=none; b=X6N3dtTMt5or1neoN08xB/oSt0jsnakMOi6XUrIvsATkzDr0G8ofcVZBz9u29A3vN0GfOY5KhJajcszi+dQiemEvECGN0YE5eCG9b6LMM2IV/7xNO9Hazgvx6tn/Iv79v6Vrdzu+1N52q11p5l/1G3fmaEYyYbJRmU8hfcVVh3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438684; c=relaxed/simple;
	bh=FKL/oycJDIAMqy+qC3CkH/3qHCngEt7CyLFeD6ai8fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NB6ya8JnLzhbu15DkA/p+Hf0neMakyIFgBfkchVH1QD5rw4uhupxaD0XYmE3abcWuTVhHHFs2OFMYeDaU27ZDxPFZpQuy7kETIa/kA8RuGrwMcup6jofa1gxgmzKM40vIuXcjK6fH7EgMWwWiCEk4FjnQSd62PGpMY50cbDgm5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="5498700"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5498700"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:18:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="913083482"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="913083482"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:17:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rcQwT-000000066Pg-0t6Z;
	Tue, 20 Feb 2024 16:17:53 +0200
Date: Tue, 20 Feb 2024 16:17:52 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>, Arnd Bergmann <arnd@arndb.de>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	David Lechner <dlechner@baylibre.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 2/3] iio: adc: ad_sigma_delta: Add optional irq
 selection
Message-ID: <ZdS0kOKTWHlisuyn@smile.fi.intel.com>
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
 <20240220094344.17556-2-mitrutzceclan@gmail.com>
 <ZdSzCe2cw8gL3K-W@smile.fi.intel.com>
 <001d1e99-5d96-44f3-8695-ad2ecee42128@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001d1e99-5d96-44f3-8695-ad2ecee42128@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 20, 2024 at 04:13:12PM +0200, Ceclan Dumitru wrote:
> On 2/20/24 16:11, Andy Shevchenko wrote:
> > On Tue, Feb 20, 2024 at 11:43:39AM +0200, Dumitru Ceclan wrote:

..

> >> +	if (!info->irq_num)
> >> +		sigma_delta->irq_num = spi->irq;
> >> +	else
> >> +		sigma_delta->irq_num = info->irq_num;
> > 
> > Why not positive check?
> > 
> Considered that selecting spi->irq is usually the default case, so it should
> be the first branch

Let compiler do its job, the negative conditions are harder to read/parse by
human beings.

-- 
With Best Regards,
Andy Shevchenko



