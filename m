Return-Path: <linux-kernel+bounces-73159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 929F485BE54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C620C1C214A1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CDE6BB38;
	Tue, 20 Feb 2024 14:11:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A95A6A8CE;
	Tue, 20 Feb 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438293; cv=none; b=piJMRtCKSexmSfeUMZq/eSjbceGA3AIlRjL/n9MYOIho0I94+jia+IKV9C0/NBhMRfgqfxnFoWIjr4rcqr3DORQhvKifeXOr/8ylDpivpGJbR3moiId1gpAb0PCPP+4FrcEkhbTNe+nSZsIK/G7HcoQc4y7VQrvEny79/7VQDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438293; c=relaxed/simple;
	bh=0GcoN0t+2Coj9NK+07WItqUPu3W/l0ZctvKLNd6QzVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RU2Bo88XT6sDHIT/BdeZGzjnthQnsUEQlB6T6XxFD0uuUqt00YktFVlF3rAiQB8VbC9kg0MbIoQlDhLOCOl39JLFPaHN2DfBiUXex2Hj/mjB+87+3L1JyI+fiRG6hwgav5IyP69lh6DnMy+bWLVr7pVLjQEi9KQsW426F1zhqnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="6359315"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="6359315"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:11:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="913082505"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="913082505"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:11:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rcQq9-000000066Jp-384v;
	Tue, 20 Feb 2024 16:11:21 +0200
Date: Tue, 20 Feb 2024 16:11:21 +0200
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
Subject: Re: [PATCH v13 2/3] iio: adc: ad_sigma_delta: Add optional irq
 selection
Message-ID: <ZdSzCe2cw8gL3K-W@smile.fi.intel.com>
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
 <20240220094344.17556-2-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220094344.17556-2-mitrutzceclan@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 20, 2024 at 11:43:39AM +0200, Dumitru Ceclan wrote:
> Add optional irq_num attribute to ad_sigma_delta_info structure for
> selecting the used interrupt line for adc's conversion completion.

..

> +	if (!info->irq_num)
> +		sigma_delta->irq_num = spi->irq;
> +	else
> +		sigma_delta->irq_num = info->irq_num;

Why not positive check?

-- 
With Best Regards,
Andy Shevchenko



