Return-Path: <linux-kernel+bounces-86783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C738786CAB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1D628512C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A77312BE85;
	Thu, 29 Feb 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2VhQ/al"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689D7D3E9;
	Thu, 29 Feb 2024 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214793; cv=none; b=TbkDKkblNA+vHb3wnE847Upk6AE2adwr2mFErjmoZjnGoa4Wb8OgBziIw0Qj5uv4SUUXMzZZHXxlSnwjwhVGqItkk7LFs8zklxgyTHQDAi2KXb6pcZKzxGvbVAED27CuADtZWbBS3cvKHkGK0pxhSjiG9EFdDVE30pJCJvqT+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214793; c=relaxed/simple;
	bh=soFEyKKUiQuYWMqoVH6cYWp/GwAL18MTf6JPCEiXDwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWeXvgWv1SerI7HqwEzqHjJh/8QjstEoWPnhdpxqQ63yEvynQqOgzVYskatMEbV8/XEXSxJPqFSfaTD5X3PN9EVU62baocIq2RSO8udF94pFOk9lkT4RNPr1VQx7xt0wqy1YMAcceUm+IB4NlZS+tnwwr33pNZ8Cz6bS5czKZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2VhQ/al; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709214792; x=1740750792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=soFEyKKUiQuYWMqoVH6cYWp/GwAL18MTf6JPCEiXDwI=;
  b=n2VhQ/alU/f0f1i19lHLauU46xFDGthOUsyjJEi8nRNws8VP0GYbANzC
   bhwYIATTyrvu0/djievbOn3DXWenqQeodnwHjCeGYr72sTP6nx5I+9gDF
   otuhcjN5JW9IauxB6hpDKmmHBy1ahiRFWT6zJA5IHiR0xxHWl/GM2yyk6
   dN/Evvm8DbtdO2gZZdjwI/WXpz2pe2yBAnx0Edc36gDkzO6TYT2mGtAPk
   oBUb4Po50V5ff6BjQg4M8UMkbs0Uh6BkCO6OYlmcPY29H33NXXqBswzMF
   U3vCEtQcbU4EsQ/IjpAxzfeVw6ZsPZ47TG+4BAdRcpjD9YrgSFePKAki/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14835702"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14835702"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 05:53:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913982643"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913982643"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 05:53:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfgqN-00000008gQI-1TA4;
	Thu, 29 Feb 2024 15:53:03 +0200
Date: Thu, 29 Feb 2024 15:53:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v8 04/10] reset: eyeq5: add platform driver
Message-ID: <ZeCMP4pKdoAj3s3C@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-4-c57fbda7664a@bootlin.com>
 <Zd4bbCsY54XEnvJM@smile.fi.intel.com>
 <CZGVIWR4H4DE.3M5H3H99X0QPT@bootlin.com>
 <ZeBo4N204gLO0eUd@smile.fi.intel.com>
 <CZHK1ZCSROM5.X4WYN7SAZJTH@bootlin.com>
 <ZeCLS17PhKPuGvkm@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeCLS17PhKPuGvkm@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 03:48:59PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 29, 2024 at 01:18:08PM +0100, Théo Lebrun wrote:

..

> The downside is that you will need to include property.h for this only thing.
> And I don't see other code that can be converted to fwnode right away here.

I meant here

	device_set_node(..., dev_fwnode(parent));

On the second thought it can survive probably without it in a form

	device_set_node(..., of_fwnode_handle(parent->of_node));

but this does not fully solve the fundamental problem with accessing of_node.

-- 
With Best Regards,
Andy Shevchenko



