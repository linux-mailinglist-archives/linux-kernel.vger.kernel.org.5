Return-Path: <linux-kernel+bounces-76645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA99285FA6D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CEB1F24ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B761C137C31;
	Thu, 22 Feb 2024 13:55:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA7258ADF;
	Thu, 22 Feb 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610105; cv=none; b=TC/VbiFZcZYOCzPUK8sbHvCRmZzKTMSAl8FyG8OOc2tHmnYaRjmFk+WvdWQ6Ojp9heBaYCZovR6BEOjz2l1fiYfNcLvIbk9IoD+hH+ZFCWu3cLEQ2QcL6hn8Y03mkIfzxJDqfKFNjPXcqAp7EZ92lHe/h4WmBinl52WuH9kZryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610105; c=relaxed/simple;
	bh=rpZDVv/1mLgRWOiaQCy4si/knuEmPEovGhuqTdYMBk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U98FLMoQ2MQEO19m/5uRNmtRM1q/id1fJr23PPnFxjFEuIKc3qKiUt/x7KN9BOG1GedVcBEuvdE6FFhs8m9jwimb5yJMHKpXb/NkEf4cUAWcSzKSdrcTve4tduwDFbdO5eDx45dTGH1K2Zxi9k8kC8DTX5WCipCQreHJkgrOnSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13963683"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13963683"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:55:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936852991"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="936852991"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:54:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rd9XJ-00000006dwU-2ROI;
	Thu, 22 Feb 2024 15:54:53 +0200
Date: Thu, 22 Feb 2024 15:54:53 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
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
Subject: Re: [PATCH v14 2/3] iio: adc: ad_sigma_delta: Add optional irq
 selection
Message-ID: <ZddSLfDcFPpkFQ4a@smile.fi.intel.com>
References: <20240222110817.29670-1-mitrutzceclan@gmail.com>
 <20240222110817.29670-2-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222110817.29670-2-mitrutzceclan@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 01:07:42PM +0200, Dumitru Ceclan wrote:
> Add optional irq_num attribute to ad_sigma_delta_info structure for
> selecting the used interrupt line for adc's conversion completion.

ADC's

..

> + * @irq_num: IRQ for reading conversions. If 0, spi->irq will be used

Naming is a bit confusing. Does _num mean the amount of IRQ vectors?
Perhaps irq_line, irq_conv?

..

> +	unsigned long irq_num;

Why is it not simple (signed) int?

..

> +	unsigned int		irq_num;

Ditto.

-- 
With Best Regards,
Andy Shevchenko



