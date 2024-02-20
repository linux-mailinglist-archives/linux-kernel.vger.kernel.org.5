Return-Path: <linux-kernel+bounces-73170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077FF85BE96
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9507283827
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740546BB2B;
	Tue, 20 Feb 2024 14:19:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A56A034;
	Tue, 20 Feb 2024 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438778; cv=none; b=sp/0gL33jAgbF37HA7ZSCHbLzks6RCuOqnduX65R3qlatLJB1BrlRM+ISxFqfzhJiC3Y/MsPc/+7e6K7r1ElAl/JpG9kQpApYTvajqSEMxLVCN3kN1SOuiFEiFuz7+jfktwO6UBcGqAzVqFzMqHqcC+CWlHHjsfvU4Hat65s55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438778; c=relaxed/simple;
	bh=nSo3t5Ukzp4UNcpuV7Og3BCAYJnGWRz063c+lUZYmJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhBQ7TwPs0vlUCCAxrHBhFIIDmxp/XDRKR4eMle5jOh/hA0j66+ndMA7GqwRhjlg24p56Qr34t3LGJ/Hkt+Qs8nv/Mf3vZSjToABWi5p3ItWmZMs+Zc8vc38b/S0Guziew7NI4ZMUINLK95kaMs1mmiak2/PhRkQ1tyNTFPGd4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="5498930"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5498930"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:19:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="913083690"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="913083690"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:19:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rcQxx-000000066RO-27dE;
	Tue, 20 Feb 2024 16:19:25 +0200
Date: Tue, 20 Feb 2024 16:19:25 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, linus.walleij@linaro.org,
	brgl@bgdev.pl, linux-gpio@vger.kernel.org,
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
Subject: Re: [PATCH v13 3/3] iio: adc: ad7173: add AD7173 driver
Message-ID: <ZdS07T5jJ_pCzRFK@smile.fi.intel.com>
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
 <20240220094344.17556-3-mitrutzceclan@gmail.com>
 <fc49f36bf1df931f7c67dd195aa74636eb479e64.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc49f36bf1df931f7c67dd195aa74636eb479e64.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 20, 2024 at 01:20:52PM +0100, Nuno Sá wrote:
> On Tue, 2024-02-20 at 11:43 +0200, Dumitru Ceclan wrote:

..

> Another thing that caught my attention

> > +static int ad7173_register_clk_provider(struct iio_dev *indio_dev)
> > +{
> > +	struct ad7173_state *st = iio_priv(indio_dev);
> > +	struct device *dev = indio_dev->dev.parent;
> > +	struct fwnode_handle *fw_node = dev_fwnode(dev);

Since you used this context, I would also like fw_node to be renamed to fwnode
(in case it will still be used).

> > +	struct clk_init_data init = {};
> > +	int ret;
> > +
> > +	if (!fw_node)
> > +		return 0;
> 
> I think that better than the above check (do we really have any case where fw_node is
> NULL?) is to have:
> 
> if (!IS_ENABLED(CONFIG_COMMON_CLK))
> 	return 0;

-- 
With Best Regards,
Andy Shevchenko



